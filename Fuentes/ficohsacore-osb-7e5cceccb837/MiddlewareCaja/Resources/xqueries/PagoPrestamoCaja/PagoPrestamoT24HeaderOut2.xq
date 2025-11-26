(:: pragma bea:global-element-parameter parameter="$pagoaprestamoAAResponse1" element="ns0:PagoaprestamoAAResponse" location="../../xsds/ConsultaGeneralPrestamo/consultaPrestamoT24/XMLSchema_448646516.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ResponseHeader" location="../../xsds/General/Autenticacion.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/autType";
declare namespace ns0 = "T24WebServicesImpl";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoPrestamoCaja/PagoPrestamoT24HeaderOut2/";

declare function xf:PagoPrestamoT24HeaderOut2($pagoaprestamoAAResponse1 as element(ns0:PagoaprestamoAAResponse))
    as element(ns1:ResponseHeader) {
        <ns1:ResponseHeader>
            {
                for $successIndicator in $pagoaprestamoAAResponse1/Status/successIndicator
                return
                    <successIndicator>{ data($successIndicator) }</successIndicator>
            }
            {
                for $messages in $pagoaprestamoAAResponse1/Status/messages
                return
                    <messages>{ data($messages) }</messages>
            }
        </ns1:ResponseHeader>
};

declare variable $pagoaprestamoAAResponse1 as element(ns0:PagoaprestamoAAResponse) external;

xf:PagoPrestamoT24HeaderOut2($pagoaprestamoAAResponse1)