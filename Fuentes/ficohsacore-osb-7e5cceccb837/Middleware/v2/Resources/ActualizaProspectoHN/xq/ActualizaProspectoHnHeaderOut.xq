(:: pragma bea:global-element-parameter parameter="$UpdateProspectResponse1" element="ns0:UpdateProspectResponse" location="../../../BusinessServices/T24/ActualizaProspecto/xsd/svcUpdateProspect_1.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreaProspectoHN/xq/CreaProspectoHnOut/";

declare function xf:CreaProspectoHnOut($UpdateProspectResponse1 as element(ns0:UpdateProspectResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $successIndicator in $UpdateProspectResponse1/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            <messages>
            {
                for $messages in $UpdateProspectResponse1/Status/messages
                let $messagesStr := ""
                return 
                     concat($messagesStr, $messages) 
            }
            </messages>
        </ns1:ResponseHeader>
};

declare variable $UpdateProspectResponse1 as element(ns0:UpdateProspectResponse) external;

xf:CreaProspectoHnOut($UpdateProspectResponse1)