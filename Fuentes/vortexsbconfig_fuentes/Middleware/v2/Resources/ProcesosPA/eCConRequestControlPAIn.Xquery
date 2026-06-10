<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../BusinessServices/ProcesosPA/eCConRequestControl/xsd/eCConRequestControl_sp.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/eCConRequestControl";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/gestionesEstadoCuentaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesosPA/xq/eCConRequestControlPAIn/";

declare function xf:eCConRequestControlPAIn($batch_id as xs:string,
    $codigoPais as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:i_lote>{ data($batch_id) }</ns1:i_lote>
            <ns1:i_pais>{ data($codigoPais) }</ns1:i_pais>
        </ns1:InputParameters>
};

declare variable $batch_id as xs:string external;
declare variable $codigoPais as xs:string external;

xf:eCConRequestControlPAIn($batch_id,
    $codigoPais)]]></con:xquery>
    <con:dependency location="../../BusinessServices/ProcesosPA/eCConRequestControl/xsd/eCConRequestControl_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ProcesosPA/eCConRequestControl/xsd/eCConRequestControl_sp"/>
    </con:dependency>
</con:xqueryEntry>