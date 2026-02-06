xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$bloqueoTarjetasDebito" element="ns2:bloqueoTarjetasDebito" location="../../../../Business_Resources/tarjetasDebito/bloqueoTarjetasDebito/bloqueoTarjetasDebitoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ConsultaMaestraTarjetaDebito" location="../../../../Business_Resources/tarjetasDebito/Resources/XMLSchema_-155258746.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/BloqueoTarjetasDebito/xq/consultaMaestraTDIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/bloqueoTarjetasDebitoTypes";
declare namespace ns1 = "T24WebServicesImpl";

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
 
declare function xf:consultaMaestraTDIn($requestHeader as element(ns0:RequestHeader),
    $bloqueoTarjetasDebito as element(ns2:bloqueoTarjetasDebito))
    as element(ns1:ConsultaMaestraTarjetaDebito) {
        <ns1:ConsultaMaestraTarjetaDebito>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                								data($requestHeader/Authentication/Password)) }</password>
            </WebRequestCommon>
            <WSFICODEBITCARDCUSTOMERType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    <criteriaValue>{ concat("...", $bloqueoTarjetasDebito/DEBIT_CARD_NUMBER) }</criteriaValue>
                    <operand>LK</operand>
                </enquiryInputCollection>
            </WSFICODEBITCARDCUSTOMERType>
        </ns1:ConsultaMaestraTarjetaDebito>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $bloqueoTarjetasDebito as element(ns2:bloqueoTarjetasDebito) external;

xf:consultaMaestraTDIn($requestHeader,
    $bloqueoTarjetasDebito)