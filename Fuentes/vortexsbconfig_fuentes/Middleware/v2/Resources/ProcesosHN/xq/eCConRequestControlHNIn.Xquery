<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/eCConRequestControl";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/gestionesEstadoCuentaTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesosHN/xq/eCConRequestControlHNIn/";

declare function xf:eCConRequestControlHNIn($batch_id as xs:string,
    $codigoPais as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:i_lote>{ $batch_id }</ns0:i_lote>
            <ns0:i_pais>{ $codigoPais }</ns0:i_pais>
        </ns0:InputParameters>
};

declare variable $batch_id as xs:string external;
declare variable $codigoPais as xs:string external;

xf:eCConRequestControlHNIn($batch_id,
    $codigoPais)]]></con:xquery>
</con:xqueryEntry>