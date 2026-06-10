<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns1:OutputParameters" location="../../../BusinessServices/ValidaNumeroViajero/xsd/validaNumeroViajero_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:validaNumeroViajeroResponse" location="../xsd/validaNumeroViajeroTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/validaNumeroViajeroTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/validaNumeroViajero";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaNumeroViajero/xq/ValidaNumeroViajeroOut/";

declare function xf:ValidaNumeroViajeroOut($outputParameters1 as element(ns1:OutputParameters))
    as element(ns0:validaNumeroViajeroResponse) {
        &lt;ns0:validaNumeroViajeroResponse>
            {
                for $PV_RESULT in $outputParameters1/PV_RESULT
                return
                    &lt;Result>{ data($PV_RESULT) }&lt;/Result>
            }
        &lt;/ns0:validaNumeroViajeroResponse>
};

declare variable $outputParameters1 as element(ns1:OutputParameters) external;

xf:ValidaNumeroViajeroOut($outputParameters1)</con:xquery>
    <con:dependency location="../../../BusinessServices/ValidaNumeroViajero/xsd/validaNumeroViajero_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ValidaNumeroViajero/xsd/validaNumeroViajero_sp"/>
    </con:dependency>
    <con:dependency location="../xsd/validaNumeroViajeroTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ValidaNumeroViajero/xsd/validaNumeroViajeroTypes"/>
    </con:dependency>
</con:xqueryEntry>