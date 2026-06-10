<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaRecaudo" element="ns0:consultaRecaudo" location="../../ConsultaRecaudo/xsd/consultaRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/TercerosNI/consultaConvenio/xsd/ConsultaConvenio_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaRecaudoNI";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaRecaudoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRecaudoNI/xq/ArmarConsultaRecaudoNIIn/";

declare function xf:ArmarConsultaRecaudoNIIn($consultaRecaudo as element(ns0:consultaRecaudo))
    as element(ns1:InputParameters) {
        &lt;ns1:InputParameters>
            &lt;ns1:PV_IDCONVENIO>{ data($consultaRecaudo/CONTRACT_ID) }&lt;/ns1:PV_IDCONVENIO>
        &lt;/ns1:InputParameters>
};

declare variable $consultaRecaudo as element(ns0:consultaRecaudo) external;
declare variable $username as xs:string external;
declare variable $session as xs:string external;

xf:ArmarConsultaRecaudoNIIn($consultaRecaudo)</con:xquery>
    <con:dependency location="../../ConsultaRecaudo/xsd/consultaRecaudoTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaRecaudo/xsd/consultaRecaudoTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/TercerosNI/consultaConvenio/xsd/ConsultaConvenio_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/TercerosNI/consultaConvenio/xsd/ConsultaConvenio_sp"/>
    </con:dependency>
</con:xqueryEntry>