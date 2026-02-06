xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$autenticacionRequestHeader1" element="ns2:AutenticacionRequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaCuentasAfiliadasTarjetaDebito" element="ns1:consultaCuentasAfiliadasTarjetaDebito" location="consultaCuentasAfiliadasTarjetaDebitoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultaMaestraTarjetaDebito" location="../Resources/XMLSchema_-155258746.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaCuentasAfiliadasTarjetaDebitoTypes";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/tarjetasDebito/consultaCuentasAfiliadasTarjetaDebito/consultaCuentasAfiliadasTarjetaDebitoIn/";

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

declare function xf:consultaCuentasAfiliadasTarjetaDebitoIn($autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader),
    $consultaCuentasAfiliadasTarjetaDebito as element(ns1:consultaCuentasAfiliadasTarjetaDebito))
    as element(ns0:ConsultaMaestraTarjetaDebito) {
        <ns0:ConsultaMaestraTarjetaDebito>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($autenticacionRequestHeader1/UserName)), 
												data($autenticacionRequestHeader1/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($autenticacionRequestHeader1/UserName)),
                								data($autenticacionRequestHeader1/Password)) }</password>
            </WebRequestCommon>
            <WSFICODEBITCARDCUSTOMERType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    <criteriaValue>{ concat("...", $consultaCuentasAfiliadasTarjetaDebito/DEBIT_CARD_NUMBER) }</criteriaValue>
                    <operand>LK</operand>
                </enquiryInputCollection>
            </WSFICODEBITCARDCUSTOMERType>
        </ns0:ConsultaMaestraTarjetaDebito>
};

declare variable $autenticacionRequestHeader1 as element(ns2:AutenticacionRequestHeader) external;
declare variable $consultaCuentasAfiliadasTarjetaDebito as element(ns1:consultaCuentasAfiliadasTarjetaDebito) external;

xf:consultaCuentasAfiliadasTarjetaDebitoIn($autenticacionRequestHeader1,
    $consultaCuentasAfiliadasTarjetaDebito)