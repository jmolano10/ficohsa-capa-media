xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$pagoRecaudo" element="ns0:pagoRecaudo" location="../../../../Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaDetalleContratoRecaudos" location="../../ConsultaDetalleContratoRecaudos/xsd/consultaDetalleContratoRecaudosTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRecaudo/xq/pagoRecaudoConsultaContratoIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleContratoRecaudosTypes";

declare function xf:pagoRecaudoConsultaContratoIn($pagoRecaudo as element(ns0:pagoRecaudo))
    as element(ns1:consultaDetalleContratoRecaudos) {
        <ns1:consultaDetalleContratoRecaudos>
            <CONTRACT_ID>{ data($pagoRecaudo/CONTRACT_ID) }</CONTRACT_ID>
        </ns1:consultaDetalleContratoRecaudos>
};

declare variable $pagoRecaudo as element(ns0:pagoRecaudo) external;

xf:pagoRecaudoConsultaContratoIn($pagoRecaudo)