xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader1" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$bloqueaAnticipoCuenta1" element="ns1:bloqueaAnticipoCuenta" location="../../BloqueoAnticipoCTA/xsd/bloqueaAnticipoCuentaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Bloqueodeanticiposenctaahorros" location="../../../BusinessServices/T24/AnticiposCliente/xsd/XMLSchema_-361259320.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/bloqueaAnticipoCuentaTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/BloqueoAnticipoCTAHN/xq/BloqueoHnIN/";

(: Función encargada de realizar el mapeo de usuario:)
declare function getUsername ($LDAPUsername as xs:string)  as xs:string { 
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:username/text()
 };

(: Función encargada de realizar el mapeo de contraseña:)
declare function getPassword ($LDAPUsername as xs:string)  as xs:string {      
	let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
  		return
		    $data/con:password/text()
 };

declare function xf:BloqueoHnIN($requestHeader1 as element(ns2:RequestHeader),
    $bloqueaAnticipoCuenta1 as element(ns1:bloqueaAnticipoCuenta))
    as element(ns0:Bloqueodeanticiposenctaahorros) {
        <ns0:Bloqueodeanticiposenctaahorros>
            <WebRequestCommon>
				 <userName>{ fn-bea:fail-over( getUsername(data($requestHeader1/Authentication/UserName)), 
												data($requestHeader1/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader1/Authentication/UserName)),
                								data($requestHeader1/Authentication/Password)) }</password>
            </WebRequestCommon>
            <OfsFunction>
                <noOfAuth>0</noOfAuth>
            </OfsFunction>
            <FICOCAEMPLOYEESETUPSTATUSWSType id = "{ data($bloqueaAnticipoCuenta1/PRODUCT_NUMBER) }"/>
        </ns0:Bloqueodeanticiposenctaahorros>
};

declare variable $requestHeader1 as element(ns2:RequestHeader) external;
declare variable $bloqueaAnticipoCuenta1 as element(ns1:bloqueaAnticipoCuenta) external;

xf:BloqueoHnIN($requestHeader1,
    $bloqueaAnticipoCuenta1)