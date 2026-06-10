<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/CNV/enrutadorConveniosDB/xsd/EnviarTransaccion_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/EnviarTransaccion";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/EnrutadorConvenios/xq/EnviarTransaccionIn/";

declare function xf:EnviarTransaccionIn($requestData1 as xs:string)
    as element(ns0:InputParameters) {
        &lt;ns0:InputParameters>
            &lt;ns0:PX_XMLIN>{ $requestData1 }&lt;/ns0:PX_XMLIN>
        &lt;/ns0:InputParameters>
};

declare variable $requestData1 as xs:string external;

xf:EnviarTransaccionIn($requestData1)</con:xquery>
    <con:dependency location="../../../BusinessServices/CNV/enrutadorConveniosDB/xsd/EnviarTransaccion_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/CNV/enrutadorConveniosDB/xsd/EnviarTransaccion_sp"/>
    </con:dependency>
</con:xqueryEntry>