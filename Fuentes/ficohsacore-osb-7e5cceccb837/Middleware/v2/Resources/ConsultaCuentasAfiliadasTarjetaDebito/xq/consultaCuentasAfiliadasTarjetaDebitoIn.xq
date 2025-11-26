xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaCuentasAfiliadasTarjetaDebito" element="ns2:consultaCuentasAfiliadasTarjetaDebito" location="../../../../Business_Resources/tarjetasDebito/consultaCuentasAfiliadasTarjetaDebito/consultaCuentasAfiliadasTarjetaDebitoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ConsultaMaestraTarjetaDebito" location="../../../../Business_Resources/tarjetasDebito/Resources/XMLSchema_-155258746.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaCuentasAfiliadasTarjetaDebito/xq/consultaCuentasAfiliadasTarjetaDebitoIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaCuentasAfiliadasTarjetaDebitoTypes";
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
 
declare function xf:consultaCuentasAfiliadasTarjetaDebitoIn($requestHeader as element(ns0:RequestHeader),
    $consultaCuentasAfiliadasTarjetaDebito as element(ns2:consultaCuentasAfiliadasTarjetaDebito))
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
                    <criteriaValue>{ concat("...", $consultaCuentasAfiliadasTarjetaDebito/DEBIT_CARD_NUMBER) }</criteriaValue>
                    <operand>LK</operand>
                </enquiryInputCollection>
            </WSFICODEBITCARDCUSTOMERType>
        </ns1:ConsultaMaestraTarjetaDebito>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $consultaCuentasAfiliadasTarjetaDebito as element(ns2:consultaCuentasAfiliadasTarjetaDebito) external;

xf:consultaCuentasAfiliadasTarjetaDebitoIn($requestHeader,
    $consultaCuentasAfiliadasTarjetaDebito)