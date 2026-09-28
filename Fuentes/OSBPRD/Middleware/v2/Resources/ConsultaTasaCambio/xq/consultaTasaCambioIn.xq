xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$requestHeader" element="ns0:RequestHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$consultaTasaCambio" element="ns2:consultaTasaCambio" location="../../../../Business_Resources/Core/consultaTasaCambio/consultaTasaCambioTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:Consultadetasadecambiolcy" location="../../../../Business_Resources/Core/Resources/XMLSchema_1632682327.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTasaCambio/xq/consultaTasaCambioIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/consultaTasaCambioTypes";
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
 
declare function xf:consultaTasaCambioIn($requestHeader as element(ns0:RequestHeader),
    $consultaTasaCambio as element(ns2:consultaTasaCambio))
    as element(ns1:Consultadetasadecambiolcy) {
        <ns1:Consultadetasadecambiolcy>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
												data($requestHeader/Authentication/UserName)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                								data($requestHeader/Authentication/Password)) }</password>
            </WebRequestCommon>
            <WSLCYEXCHRATEType>
                <enquiryInputCollection>
                	<columnName>CURRENCY.CODE</columnName>
                	<criteriaValue>{ data($consultaTasaCambio/TARGET_CURRENCY) }</criteriaValue>
                	<operand>EQ</operand>
                </enquiryInputCollection>
            </WSLCYEXCHRATEType>
        </ns1:Consultadetasadecambiolcy>
};

declare variable $requestHeader as element(ns0:RequestHeader) external;
declare variable $consultaTasaCambio as element(ns2:consultaTasaCambio) external;

xf:consultaTasaCambioIn($requestHeader,
    $consultaTasaCambio)