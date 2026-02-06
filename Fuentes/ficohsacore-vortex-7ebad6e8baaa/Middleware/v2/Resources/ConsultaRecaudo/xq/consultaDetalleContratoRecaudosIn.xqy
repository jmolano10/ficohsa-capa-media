xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaRecaudo1" element="ns0:consultaRecaudo" location="../../../../Business_Resources/recaudos/consultaRecaudo/consultaRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaDetalleContratoRecaudos" location="../../ConsultaDetalleContratoRecaudos/xsd/consultaDetalleContratoRecaudosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleContratoRecaudosTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/recaudos/consultaRecaudo/consultaDetalleContratoRecaudosIn/";

declare function xf:consultaDetalleContratoRecaudosIn($consultaRecaudo1 as element(ns0:consultaRecaudo))
    as element(ns1:consultaDetalleContratoRecaudos) {
        <ns1:consultaDetalleContratoRecaudos>
            <CONTRACT_ID>{ data($consultaRecaudo1/CONTRACT_ID) }</CONTRACT_ID>
        </ns1:consultaDetalleContratoRecaudos>
};

declare variable $consultaRecaudo1 as element(ns0:consultaRecaudo) external;

xf:consultaDetalleContratoRecaudosIn($consultaRecaudo1)