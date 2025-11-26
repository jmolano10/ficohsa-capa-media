(:: pragma bea:global-element-parameter parameter="$pagoderecaudoreferenciadoefec_ValidateResponse" element="ns0:Pagoderecaudoreferenciadoefec_ValidateResponse" location="../../xsds/PagoRecaudos/XMLSchema_-258408779.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../xsds/General/Autenticacion.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaRecaudo/consultaRecaudoReferenciadoHeaderOut/";

declare function xf:consultaRecaudoReferenciadoHeaderOut($pagoderecaudoreferenciadoefec_ValidateResponse as element(ns0:Pagoderecaudoreferenciadoefec_ValidateResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $successIndicator in $pagoderecaudoreferenciadoefec_ValidateResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $pagoderecaudoreferenciadoefec_ValidateResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $pagoderecaudoreferenciadoefec_ValidateResponse as element(ns0:Pagoderecaudoreferenciadoefec_ValidateResponse) external;

xf:consultaRecaudoReferenciadoHeaderOut($pagoderecaudoreferenciadoefec_ValidateResponse)