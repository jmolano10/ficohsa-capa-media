<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery><![CDATA[xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaAgenciasBanco" element="ns0:consultaAgenciasBanco" location="../../../../Business_Resources/Core/consultaAgenciasBanco/consultaAgenciasBancoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABKGT/consultaAgenciasBanco/xsd/consultaAgenciasBanco_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaAgenciasBancoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaAgenciasBanco";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaAgenciasBanco/xq/consultaAgenciasBancoGTIn/";

declare function xf:consultaAgenciasBancoGTIn($consultaAgenciasBanco as element(ns0:consultaAgenciasBanco))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            {
                for $SERVICE_CODE in $consultaAgenciasBanco/SERVICE_CODE
                return
                    <ns1:SERVICE_CODE>{ data($SERVICE_CODE) }</ns1:SERVICE_CODE>
            }
            {
                for $BRANCH_CODE in $consultaAgenciasBanco/BRANCH_CODE
                return
                    <ns1:BRANCH_CODE>{ data($BRANCH_CODE) }</ns1:BRANCH_CODE>
            }
        </ns1:InputParameters>
};

declare variable $consultaAgenciasBanco as element(ns0:consultaAgenciasBanco) external;

xf:consultaAgenciasBancoGTIn($consultaAgenciasBanco)]]></con:xquery>
    <con:dependency location="../../../../Business_Resources/Core/consultaAgenciasBanco/consultaAgenciasBancoTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/Core/consultaAgenciasBanco/consultaAgenciasBancoTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/ABKGT/consultaAgenciasBanco/xsd/consultaAgenciasBanco_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABKGT/consultaAgenciasBanco/xsd/consultaAgenciasBanco_sp"/>
    </con:dependency>
</con:xqueryEntry>