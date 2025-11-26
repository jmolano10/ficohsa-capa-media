(:: pragma bea:global-element-parameter parameter="$creaciondeclienteprospectoResponse1" element="ns0:NewProspectResponse" location="../../../BusinessServices/T24/CreaProspecto/xsd/XMLSchema_435747315.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreaProspectoHN/xq/CreaProspectoHnOut/";

declare function xf:CreaProspectoHnOut($creaciondeclienteprospectoResponse1 as element(ns0:NewProspectResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $successIndicator in $creaciondeclienteprospectoResponse1/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            <messages>
            {
                for $messages in $creaciondeclienteprospectoResponse1/Status/messages
                let $messagesStr := ""
                return 
                     concat($messagesStr, $messages) 
            }
            </messages>
        </ns1:ResponseHeader>
};

declare variable $creaciondeclienteprospectoResponse1 as element(ns0:NewProspectResponse) external;

xf:CreaProspectoHnOut($creaciondeclienteprospectoResponse1)