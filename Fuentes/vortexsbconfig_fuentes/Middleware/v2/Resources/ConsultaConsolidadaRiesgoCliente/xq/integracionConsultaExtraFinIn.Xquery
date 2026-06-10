<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/integracionConsultaExtraFin";
(:: import schema at "../../../BusinessServices/DWConsultaConsolidada/integracionConsultaExtraFin/xsd/integracionConsultaExtraFin_sp.xsd" ::)

declare variable $pais as xs:string external;
declare variable $identidad as xs:string external;

declare function local:func($pais as xs:string, 
                            $identidad as xs:string) 
                            as element() (:: schema-element(ns1:InputParameters) ::) {
    <ns1:InputParameters>
        <ns1:PAIS>{fn:data($pais)}</ns1:PAIS>
        <ns1:IDENTIDAD>{fn:data($identidad)}</ns1:IDENTIDAD>
    </ns1:InputParameters>
};

local:func($pais, $identidad)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../../../BusinessServices/DWConsultaConsolidada/integracionConsultaExtraFin/xsd/integracionConsultaExtraFin_sp.xsd">
            <con:schema ref="Middleware/v2/BusinessServices/DWConsultaConsolidada/integracionConsultaExtraFin/xsd/integracionConsultaExtraFin_sp"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>