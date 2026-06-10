<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaComisionMasivos1" element="ns0:ConsultaComisionMasivos" location="../xsd/consultaComisionMasivosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/PMSV/consultaComisionMasivos/xsd/ConsultaComisionMasivos_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaComisionMasivosTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaComisionMasivos";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaComisionMasivos/xq/consultaComisionMasivosIn/";

declare function xf:consultaComisionMasivosIn($consultaComisionMasivos1 as element(ns0:ConsultaComisionMasivos))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:PV_CUSTOMER_ID>{ data($consultaComisionMasivos1/CUSTOMER_ID) }</ns1:PV_CUSTOMER_ID>
            <ns1:PV_BATCH_ID>{ data($consultaComisionMasivos1/BATCH_ID) }</ns1:PV_BATCH_ID>
            <ns1:PV_CREATION_DATE>{ data($consultaComisionMasivos1/CREATION_DATE) }</ns1:PV_CREATION_DATE>
        </ns1:InputParameters>
};

declare variable $consultaComisionMasivos1 as element(ns0:ConsultaComisionMasivos) external;

xf:consultaComisionMasivosIn($consultaComisionMasivos1)]]></con:xquery>
    <con:dependency location="../xsd/consultaComisionMasivosTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaComisionMasivos/xsd/consultaComisionMasivosTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/PMSV/consultaComisionMasivos/xsd/ConsultaComisionMasivos_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/PMSV/consultaComisionMasivos/xsd/ConsultaComisionMasivos_sp"/>
    </con:dependency>
</con:xqueryEntry>