<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$pagoRecaudo" element="ns0:pagoRecaudo" location="../../../../Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaDetalleContratoRecaudos" location="../../ConsultaDetalleContratoRecaudos/xsd/consultaDetalleContratoRecaudosTypes.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRecaudo/xq/pagoRecaudoConsultaContratoIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleContratoRecaudosTypes";

declare function xf:pagoRecaudoConsultaContratoIn($pagoRecaudo as element(ns0:pagoRecaudo))
    as element(ns1:consultaDetalleContratoRecaudos) {
        &lt;ns1:consultaDetalleContratoRecaudos>
            &lt;CONTRACT_ID>{ data($pagoRecaudo/CONTRACT_ID) }&lt;/CONTRACT_ID>
        &lt;/ns1:consultaDetalleContratoRecaudos>
};

declare variable $pagoRecaudo as element(ns0:pagoRecaudo) external;

xf:pagoRecaudoConsultaContratoIn($pagoRecaudo)</con:xquery>
    <con:dependency location="../../../../Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoTypes"/>
    </con:dependency>
    <con:dependency location="../../ConsultaDetalleContratoRecaudos/xsd/consultaDetalleContratoRecaudosTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaDetalleContratoRecaudos/xsd/consultaDetalleContratoRecaudosTypes"/>
    </con:dependency>
</con:xqueryEntry>