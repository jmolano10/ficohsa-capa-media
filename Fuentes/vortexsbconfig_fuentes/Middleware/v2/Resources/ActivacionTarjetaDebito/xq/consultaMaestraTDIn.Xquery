<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns1:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$activacionTarjetaDebito" element="ns0:activacionTarjetaDebito" location="../xsd/activacionTarjetaDebitoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns2:ConsultaMaestraTarjetaDebito" location="../../../../Business_Resources/tarjetasDebito/Resources/XMLSchema_-155258746.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/activacionTarjetaDebitoTypes";
declare namespace ns2 = "T24WebServicesImpl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActivacionTarjetaDebito/xq/consultaMaestraTDIn/";

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

declare function xf:consultaMaestraTDIn($requestHeader as element(ns1:RequestHeader),
    $activacionTarjetaDebito as element(ns0:activacionTarjetaDebito))
    as element(ns2:ConsultaMaestraTarjetaDebito) {
        <ns2:ConsultaMaestraTarjetaDebito>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                								data($requestHeader/Authentication/Password)) }</password>
            </WebRequestCommon>
            <WSFICODEBITCARDCUSTOMERType>
                <enquiryInputCollection>
                	<columnName>@ID</columnName>
                    <criteriaValue>{ concat("...", data($activacionTarjetaDebito/DEBIT_CARD_NUMBER)) }</criteriaValue>
                    <operand>LK</operand>
                </enquiryInputCollection>
            </WSFICODEBITCARDCUSTOMERType>
        </ns2:ConsultaMaestraTarjetaDebito>
};

declare variable $requestHeader as element(ns1:RequestHeader) external;
declare variable $activacionTarjetaDebito as element(ns0:activacionTarjetaDebito) external;

xf:consultaMaestraTDIn($requestHeader,
    $activacionTarjetaDebito)]]></con:xquery>
    <con:dependency location="../../esquemas_generales/HeaderElements.xsd">
        <con:schema ref="Middleware/v2/Resources/esquemas_generales/HeaderElements"/>
    </con:dependency>
    <con:dependency location="../xsd/activacionTarjetaDebitoTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ActivacionTarjetaDebito/xsd/activacionTarjetaDebitoTypes"/>
    </con:dependency>
    <con:dependency location="../../../../Business_Resources/tarjetasDebito/Resources/XMLSchema_-155258746.xsd">
        <con:schema ref="Middleware/Business_Resources/tarjetasDebito/Resources/XMLSchema_-155258746"/>
    </con:dependency>
</con:xqueryEntry>