<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$ws_gestionesResponse" element="ns0:ws_gestionesResponse" location="../../../BusinessServices/SALESFORCE/creaGestionGenerica/wsdl/creaGestionGenerica.wsdl" ::)
(:: pragma bea:global-element-return element="ns1:gestionesGenericasCRMResponse" location="../xsd/gestionesGenericasCRMTypes.xsd" ::)

declare namespace ns0 = "http://soap.sforce.com/schemas/class/ws_gestiones";
declare namespace ns2 = "http://soap.sforce.com/schemas/class/ws_gestiones_types";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/gestionesGenericasCRMTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GestionesGenericasCRM/xq/gestionesGenericasCRMHNOut/";

declare function xf:gestionesGenericasCRMHNOut($ws_gestionesResponse as element(ns0:ws_gestionesResponse))
    as element(ns1:gestionesGenericasCRMResponse) {
        &lt;ns1:gestionesGenericasCRMResponse>
            {
                for $recordName in $ws_gestionesResponse/ns0:result/ns2:recordName
                return
                    &lt;REFERENCE_ID>{ data($recordName) }&lt;/REFERENCE_ID>
            }
        &lt;/ns1:gestionesGenericasCRMResponse>
};

declare variable $ws_gestionesResponse as element(ns0:ws_gestionesResponse) external;

xf:gestionesGenericasCRMHNOut($ws_gestionesResponse)</con:xquery>
    <con:dependency location="../../../BusinessServices/SALESFORCE/creaGestionGenerica/wsdl/creaGestionGenerica.wsdl">
        <con:wsdl ref="Middleware/v2/BusinessServices/SALESFORCE/creaGestionGenerica/wsdl/creaGestionGenerica"/>
    </con:dependency>
    <con:dependency location="../xsd/gestionesGenericasCRMTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/GestionesGenericasCRM/xsd/gestionesGenericasCRMTypes"/>
    </con:dependency>
</con:xqueryEntry>