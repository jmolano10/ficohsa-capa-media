(:: pragma bea:global-element-parameter parameter="$ws_gestionesResponse" element="ns0:ws_gestionesResponse" location="../../../BusinessServices/SALESFORCE/creaGestionGenerica/wsdl/creaGestionGenerica.wsdl" ::)
(:: pragma bea:global-element-return element="ns1:gestionesGenericasCRMResponse" location="../xsd/gestionesGenericasCRMTypes.xsd" ::)

declare namespace ns0 = "http://soap.sforce.com/schemas/class/ws_gestiones";
declare namespace ns2 = "http://soap.sforce.com/schemas/class/ws_gestiones_types";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/gestionesGenericasCRMTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/GestionesGenericasCRM/xq/gestionesGenericasCRMHNOut/";

declare function xf:gestionesGenericasCRMHNOut($ws_gestionesResponse as element(ns0:ws_gestionesResponse))
    as element(ns1:gestionesGenericasCRMResponse) {
        <ns1:gestionesGenericasCRMResponse>
            {
                for $recordName in $ws_gestionesResponse/ns0:result/ns2:recordName
                return
                    <REFERENCE_ID>{ data($recordName) }</REFERENCE_ID>
            }
        </ns1:gestionesGenericasCRMResponse>
};

declare variable $ws_gestionesResponse as element(ns0:ws_gestionesResponse) external;

xf:gestionesGenericasCRMHNOut($ws_gestionesResponse)