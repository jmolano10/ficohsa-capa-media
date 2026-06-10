<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/PWS/consultaDatoCreditScore/xsd/consultaDatoCreditScore_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns0:consultaDatoAplicacionResponse" location="../xsd/consultaDatoAplicacionTypes.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaDatoCreditScore";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDatoAplicacionTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaDatoAplicacion/xq/consultaDatoAplicacionHNOut/";

declare function xf:consultaDatoAplicacionHNOut($outputParameters as element(ns1:OutputParameters))
    as element(ns0:consultaDatoAplicacionResponse) {
        &lt;ns0:consultaDatoAplicacionResponse>
            {
                for $P_DATA_VALUE in $outputParameters/ns1:P_DATA_VALUE
                return
                    &lt;ns0:DATA_VALUE>{ data($P_DATA_VALUE) }&lt;/ns0:DATA_VALUE>
            }
        &lt;/ns0:consultaDatoAplicacionResponse>
};

declare variable $outputParameters as element(ns1:OutputParameters) external;

xf:consultaDatoAplicacionHNOut($outputParameters)</con:xquery>
    <con:dependency location="../../../BusinessServices/PWS/consultaDatoCreditScore/xsd/consultaDatoCreditScore_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/PWS/consultaDatoCreditScore/xsd/consultaDatoCreditScore_sp"/>
    </con:dependency>
    <con:dependency location="../xsd/consultaDatoAplicacionTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaDatoAplicacion/xsd/consultaDatoAplicacionTypes"/>
    </con:dependency>
</con:xqueryEntry>