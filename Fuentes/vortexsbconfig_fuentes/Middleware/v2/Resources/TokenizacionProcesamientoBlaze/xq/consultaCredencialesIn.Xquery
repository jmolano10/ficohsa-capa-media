<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaCredencialesDM_db"; 
(:: import schema at "../../../BusinessServices/MDW/consultaCredencialesDM/xsd/consultaCredencialesDM_db_sp.xsd" ::)

declare variable $pais as xs:string external;

declare function local:consultaCredencialesIn($pais as xs:string) as element() (:: schema-element(ns1:InputParameters) ::) {
    <ns1:InputParameters>
        <ns1:PV_CODIGOPAIS>{fn:data($pais)}</ns1:PV_CODIGOPAIS>
        <ns1:PV_OPERATION>APIBLAZE</ns1:PV_OPERATION>
    </ns1:InputParameters>
};

local:consultaCredencialesIn($pais)]]></con:xquery>
    <con:dependencies>
        <con:importSchema location="../../../BusinessServices/MDW/consultaCredencialesDM/xsd/consultaCredencialesDM_db_sp.xsd">
            <con:schema ref="Middleware/v2/BusinessServices/MDW/consultaCredencialesDM/xsd/consultaCredencialesDM_db_sp"/>
        </con:importSchema>
    </con:dependencies>
</con:xqueryEntry>