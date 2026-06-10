<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaFinancierasACH1" element="ns1:consultaFinancierasACH" location="../../../../Business_Resources/Core/consultaFinancierasACH/consultaFinancierasACHTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKPA/consultaFinancierasACH/xsd/consultaFinancierasACH_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaFinancierasACH";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaFinancierasACHTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksPA/consultaFinancierasACH/xq/consultaFinancierasACHIn/";

declare function xf:consultaFinancierasACHIn($consultaFinancierasACH1 as element(ns1:consultaFinancierasACH))
    as element(ns0:InputParameters) {
        &lt;ns0:InputParameters>
            {
                for $DESTINATION_CODE in $consultaFinancierasACH1/DESTINATION_CODE
                return
                    &lt;ns0:DESTINATION_CODE>{ data($DESTINATION_CODE) }&lt;/ns0:DESTINATION_CODE>
            }
        &lt;/ns0:InputParameters>
};

declare variable $consultaFinancierasACH1 as element(ns1:consultaFinancierasACH) external;

xf:consultaFinancierasACHIn($consultaFinancierasACH1)</con:xquery>
    <con:dependency location="../../../../Business_Resources/Core/consultaFinancierasACH/consultaFinancierasACHTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/Core/consultaFinancierasACH/consultaFinancierasACHTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/ABKPA/consultaFinancierasACH/xsd/consultaFinancierasACH_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABKPA/consultaFinancierasACH/xsd/consultaFinancierasACH_sp"/>
    </con:dependency>
</con:xqueryEntry>