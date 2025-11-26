(:: pragma bea:global-element-parameter parameter="$consultadedetrecaudomigracionResponse" element="ns0:ConsultadedetrecaudomigracionResponse" location="../../xsds/Recaudos/XMLSchema_-1599652964.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../xsds/General/Autenticacion.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaRecaudoMigracion/ConsultaRecaudoMigracionHeaderOut/";

declare function xf:ConsultaRecaudoMigracionHeaderOut($consultadedetrecaudomigracionResponse as element(ns0:ConsultadedetrecaudomigracionResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $successIndicator in $consultadedetrecaudomigracionResponse/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $consultadedetrecaudomigracionResponse/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $consultadedetrecaudomigracionResponse as element(ns0:ConsultadedetrecaudomigracionResponse) external;

xf:ConsultaRecaudoMigracionHeaderOut($consultadedetrecaudomigracionResponse)