<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoT241" element="ns0:procesaMensajeGenericoT24" location="../xsd/procesaMensajeGenericoT24Types.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/TSP/consultaBatchTSP/xsd/consultaBatchTSP_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaBatchTSP";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoT24Types";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoT24/xq/consultaBatchTSPIN/";

declare function xf:consultaBatchTSPIN($procesaMensajeGenericoT241 as element(ns0:procesaMensajeGenericoT24))
    as element(ns1:InputParameters) {
        &lt;ns1:InputParameters>
      		&lt;ns1:PV_REF_TT_FT>{ fn:string($procesaMensajeGenericoT241/MESSAGE/text()) }&lt;/ns1:PV_REF_TT_FT>
        &lt;/ns1:InputParameters>
};

declare variable $procesaMensajeGenericoT241 as element(ns0:procesaMensajeGenericoT24) external;

xf:consultaBatchTSPIN($procesaMensajeGenericoT241)</con:xquery>
    <con:dependency location="../xsd/procesaMensajeGenericoT24Types.xsd">
        <con:schema ref="Middleware/v2/Resources/ProcesaMensajeGenericoT24/xsd/procesaMensajeGenericoT24Types"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/TSP/consultaBatchTSP/xsd/consultaBatchTSP_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/TSP/consultaBatchTSP/xsd/consultaBatchTSP_sp"/>
    </con:dependency>
</con:xqueryEntry>