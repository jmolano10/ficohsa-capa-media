xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$creacionClienteNaturalResponse1" element="ns1:CreacionClienteNaturalResponse" location="../../../BusinessServices/T24/creacionCliente/xsd/XMLSchema_1413221226.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns1 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/CreacionClienteBanco/xq/creacionClienteNaturalHeaderOut/";

declare function xf:creacionClienteNaturalHeaderOut($creacionClienteNaturalResponse1 as element(ns1:CreacionClienteNaturalResponse))
    as element(ns0:ResponseHeader) {
        <ns0:ResponseHeader>
            {
                if (fn:string($creacionClienteNaturalResponse1/Status/successIndicator/text()) = "Success") then (
                    <transactionId>{ fn:string($creacionClienteNaturalResponse1/Status/transactionId/text()) }</transactionId>
                ) else ()
            }
            {
                for $successIndicator in $creacionClienteNaturalResponse1/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $creacionClienteNaturalResponse1/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
        </ns0:ResponseHeader>
};

declare variable $creacionClienteNaturalResponse1 as element(ns1:CreacionClienteNaturalResponse) external;

xf:creacionClienteNaturalHeaderOut($creacionClienteNaturalResponse1)