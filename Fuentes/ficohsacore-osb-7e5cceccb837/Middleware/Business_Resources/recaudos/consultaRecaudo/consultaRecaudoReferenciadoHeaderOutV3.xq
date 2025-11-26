(::pragma bea:global-element-parameter parameter="$pagoderecaudoreferenciadodbcta_ValidateResponseIN" element="ns0:Pagoderecaudoreferenciadodbcta_ValidateResponse" location="../../pagoRecaudos/Resources/XMLSchema_-258408779.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../esquemas_generales/HeaderElements.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/recaudos/consultaRecaudo/consultaRecaudoReferenciadoHeaderOut2/";

declare function xf:consultaRecaudoReferenciadoHeaderOut($pagoderecaudoreferenciadodbcta_ValidateResponseIN as element(ns0:pagoderecaudoreferenciadodbcta_ValidateResponseIN))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $successIndicator in $pagoderecaudoreferenciadodbcta_ValidateResponseIN/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $pagoderecaudoreferenciadodbcta_ValidateResponseIN/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $pagoderecaudoreferenciadodbcta_ValidateResponseIN as element(ns0:pagoderecaudoreferenciadodbcta_ValidateResponseIN) external;

xf:consultaRecaudoReferenciadoHeaderOut($pagoderecaudoreferenciadodbcta_ValidateResponseIN)