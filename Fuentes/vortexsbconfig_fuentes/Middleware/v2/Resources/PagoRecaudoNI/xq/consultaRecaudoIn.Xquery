<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagoRecaudo" element="ns0:pagoRecaudo" location="../../PagoRecaudo/xsd/pagoRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/TercerosNI/consultaConvenio/xsd/ConsultaConvenio_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaRecaudoNI";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRecaudoNI/xq/consultaRecaudoIn/";

declare function xf:consultaRecaudoIn($pagoRecaudo as element(ns0:pagoRecaudo))
    as element(ns1:InputParameters) {
        &lt;ns1:InputParameters>
            &lt;ns1:PV_IDCONVENIO>{ data($pagoRecaudo/CONTRACT_ID) }&lt;/ns1:PV_IDCONVENIO>
        &lt;/ns1:InputParameters>
};

declare variable $pagoRecaudo as element(ns0:pagoRecaudo) external;

xf:consultaRecaudoIn($pagoRecaudo)</con:xquery>
    <con:dependency location="../../PagoRecaudo/xsd/pagoRecaudoTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/PagoRecaudo/xsd/pagoRecaudoTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/TercerosNI/consultaConvenio/xsd/ConsultaConvenio_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/TercerosNI/consultaConvenio/xsd/ConsultaConvenio_sp"/>
    </con:dependency>
</con:xqueryEntry>