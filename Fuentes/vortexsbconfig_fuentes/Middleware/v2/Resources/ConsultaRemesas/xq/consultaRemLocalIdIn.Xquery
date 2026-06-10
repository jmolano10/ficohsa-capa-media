<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaRemesas1" element="ns1:consultaRemesas" location="../xsd/consultaRemesasTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ConsultarRemLocalId/xsd/consultarRemLocalId_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaRemesasTypes";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarRemLocalId";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaRemesas/xq/consultaRemLocalIdIn/";

declare function xf:consultaRemLocalIdIn($consultaRemesas1 as element(ns1:consultaRemesas))
    as element(ns0:InputParameters) {
        &lt;ns0:InputParameters>
            {
                for $REMITTANCE_ID in $consultaRemesas1/REMITTANCE_ID
                return
                    &lt;ns0:PV_REMESA>{ data($REMITTANCE_ID) }&lt;/ns0:PV_REMESA>
            }
        &lt;/ns0:InputParameters>
};

declare variable $consultaRemesas1 as element(ns1:consultaRemesas) external;

xf:consultaRemLocalIdIn($consultaRemesas1)</con:xquery>
    <con:dependency location="../xsd/consultaRemesasTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaRemesas/xsd/consultaRemesasTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/ConsultarRemLocalId/xsd/consultarRemLocalId_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ConsultarRemLocalId/xsd/consultarRemLocalId_sp"/>
    </con:dependency>
</con:xqueryEntry>