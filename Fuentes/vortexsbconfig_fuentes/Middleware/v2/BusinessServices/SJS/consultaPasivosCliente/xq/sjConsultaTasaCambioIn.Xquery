<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$sjConsultaPasivosClienteRequest1" element="ns1:sjConsultaPasivosClienteRequest" location="../xsd/sjConsultaPasivosCliente.xsd" ::)
(:: pragma bea:global-element-return element="ns0:Consultadetasadecambiolcy" location="../../../../../Business_Resources/Core/Resources/XMLSchema_1632682327.xsd" ::)

declare namespace con = "http://www.bea.com/wli/sb/services/security/config";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/sjConsultaPasivosCliente";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaPasivosCliente/xq/sjConsultaTasaCambioIn/";

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

declare function xf:sjConsultaTasaCambioIn($sjConsultaPasivosClienteRequest1 as element(ns1:sjConsultaPasivosClienteRequest),
    $sourceCurrency as xs:string,
    $targetCurrency as xs:string)
    as element(ns0:Consultadetasadecambiolcy) {
        <ns0:Consultadetasadecambiolcy>
            <WebRequestCommon>
                <userName>{ fn-bea:fail-over( getUsername(data($sjConsultaPasivosClienteRequest1/ns1:USERNAME)), 
												data($sjConsultaPasivosClienteRequest1/ns1:USERNAME)) }</userName>
                <password>{ fn-bea:fail-over( getPassword(data($sjConsultaPasivosClienteRequest1/ns1:USERNAME)), 
												data($sjConsultaPasivosClienteRequest1/ns1:PASSWORD)) }</password>
            </WebRequestCommon>
            <WSLCYEXCHRATEType>
                <enquiryInputCollection>
                    <columnName>@ID</columnName>
                    <criteriaValue>{ $targetCurrency }</criteriaValue>
                    <operand>EQ</operand>
                </enquiryInputCollection>
            </WSLCYEXCHRATEType>
        </ns0:Consultadetasadecambiolcy>
};

declare variable $sjConsultaPasivosClienteRequest1 as element(ns1:sjConsultaPasivosClienteRequest) external;
declare variable $sourceCurrency as xs:string external;
declare variable $targetCurrency as xs:string external;

xf:sjConsultaTasaCambioIn($sjConsultaPasivosClienteRequest1,
    $sourceCurrency,
    $targetCurrency)]]></con:xquery>
    <con:dependency location="../xsd/sjConsultaPasivosCliente.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/SJS/consultaPasivosCliente/xsd/sjConsultaPasivosCliente"/>
    </con:dependency>
    <con:dependency location="../../../../../Business_Resources/Core/Resources/XMLSchema_1632682327.xsd">
        <con:schema ref="Middleware/Business_Resources/Core/Resources/XMLSchema_1632682327"/>
    </con:dependency>
</con:xqueryEntry>