<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaRecaudo1" element="ns0:consultaRecaudo" location="../../../../Business_Resources/recaudos/consultaRecaudo/consultaRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaDetalleContratoRecaudos" location="../../ConsultaDetalleContratoRecaudos/xsd/consultaDetalleContratoRecaudosTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleContratoRecaudosTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/recaudos/consultaRecaudo/consultaDetalleContratoRecaudosIn/";

declare function xf:consultaDetalleContratoRecaudosIn($consultaRecaudo1 as element(ns0:consultaRecaudo))
    as element(ns1:consultaDetalleContratoRecaudos) {
        &lt;ns1:consultaDetalleContratoRecaudos>
            &lt;CONTRACT_ID>{ data($consultaRecaudo1/CONTRACT_ID) }&lt;/CONTRACT_ID>
        &lt;/ns1:consultaDetalleContratoRecaudos>
};

declare variable $consultaRecaudo1 as element(ns0:consultaRecaudo) external;

xf:consultaDetalleContratoRecaudosIn($consultaRecaudo1)</con:xquery>
    <con:dependency location="../../../../Business_Resources/recaudos/consultaRecaudo/consultaRecaudoTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/recaudos/consultaRecaudo/consultaRecaudoTypes"/>
    </con:dependency>
    <con:dependency location="../../ConsultaDetalleContratoRecaudos/xsd/consultaDetalleContratoRecaudosTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaDetalleContratoRecaudos/xsd/consultaDetalleContratoRecaudosTypes"/>
    </con:dependency>
</con:xqueryEntry>