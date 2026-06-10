<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$actualizaEstadoRemesaRequest1" element="ns1:actualizaEstadoRemesaRequest" location="../xsd/actualizaEstadoRemesa.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/CNV/actualizaEstadoRemesaLocal/xsd/actualizaEstadoRemesaLocal_sp.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/actualizaEstadoRemesaTypes/v2";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/actualizaEstadoRemesaLocal";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ActualizaEstadoRemesa/xq/aerActualizaEstadoRemLocalIn/";

declare function xf:aerActualizaEstadoRemLocalIn($actualizaEstadoRemesaRequest1 as element(ns1:actualizaEstadoRemesaRequest))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:PV_CLAVE>{ data($actualizaEstadoRemesaRequest1/REMITTANCE_ID) }</ns0:PV_CLAVE>
            <ns0:PN_IDCONVENIO>{ data($actualizaEstadoRemesaRequest1/REMITTER_ID) }</ns0:PN_IDCONVENIO>
            <ns0:PV_NUEVOESTADO>{ data($actualizaEstadoRemesaRequest1/NEW_STATUS) }</ns0:PV_NUEVOESTADO>
            <ns0:PV_AGENCIA/>
        </ns0:InputParameters>
};

declare variable $actualizaEstadoRemesaRequest1 as element(ns1:actualizaEstadoRemesaRequest) external;

xf:aerActualizaEstadoRemLocalIn($actualizaEstadoRemesaRequest1)]]></con:xquery>
    <con:dependency location="../xsd/actualizaEstadoRemesa.xsd">
        <con:schema ref="Middleware/v2/Resources/ActualizaEstadoRemesa/xsd/actualizaEstadoRemesa"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/CNV/actualizaEstadoRemesaLocal/xsd/actualizaEstadoRemesaLocal_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/CNV/actualizaEstadoRemesaLocal/xsd/actualizaEstadoRemesaLocal_sp"/>
    </con:dependency>
</con:xqueryEntry>