(:: pragma bea:global-element-parameter parameter="$consultaPaises1" element="ns1:consultaPaises" location="../../../../Business_Resources/direcciones/consultaPaises/consultaPaisesTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$RequestHeader1" element="ns2:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadepaises" location="../../../../Business_Resources/direcciones/Resources/XMLSchema_1123420404.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaPaisesTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaPaises/xq/consultaPaisesEmptyIn/";

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

declare function xf:consultaPaisesEmptyIn($consultaPaises1 as element(ns1:consultaPaises),
    $RequestHeader1 as element(ns2:RequestHeader))
    as element(ns0:Consultadepaises) {
        <ns0:Consultadepaises>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($RequestHeader1/Authentication/UserName)), 
												data($RequestHeader1/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($RequestHeader1/Authentication/UserName)),
                								data($RequestHeader1/Authentication/Password)) }</password>
            </WebRequestCommon>
        </ns0:Consultadepaises>
};

declare variable $consultaPaises1 as element(ns1:consultaPaises) external;
declare variable $RequestHeader1 as element(ns2:RequestHeader) external;

xf:consultaPaisesEmptyIn($consultaPaises1,
    $RequestHeader1)