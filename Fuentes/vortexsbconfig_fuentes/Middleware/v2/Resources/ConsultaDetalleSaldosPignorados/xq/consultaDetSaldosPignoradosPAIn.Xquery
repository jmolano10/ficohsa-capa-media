<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaDetalleSaldosPignorados1" element="ns1:consultaDetalleSaldosPignorados" location="../xsd/consultaDetalleSaldosPignoradosTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ABKPA/consultaDetalleSaldosPignorados/xsd/consultaDetalleSaldosPignorados_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaDetalleSaldosPignorados";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaDetalleSaldosPignoradosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksPA/consultaDetalleSaldosPignorados/xq/consultaDetalleSaldosPignoradosIn/";

declare function xf:consultaDetalleSaldosPignoradosIn($consultaDetalleSaldosPignorados1 as element(ns1:consultaDetalleSaldosPignorados))
    as element(ns0:InputParameters) {
        &lt;ns0:InputParameters>
            &lt;ns0:ACCOUNT_NUMBER>{ data($consultaDetalleSaldosPignorados1/ACCOUNT_NUMBER) }&lt;/ns0:ACCOUNT_NUMBER>
        &lt;/ns0:InputParameters>
};

declare variable $consultaDetalleSaldosPignorados1 as element(ns1:consultaDetalleSaldosPignorados) external;

xf:consultaDetalleSaldosPignoradosIn($consultaDetalleSaldosPignorados1)</con:xquery>
    <con:dependency location="../xsd/consultaDetalleSaldosPignoradosTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaDetalleSaldosPignorados/xsd/consultaDetalleSaldosPignoradosTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/ABKPA/consultaDetalleSaldosPignorados/xsd/consultaDetalleSaldosPignorados_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABKPA/consultaDetalleSaldosPignorados/xsd/consultaDetalleSaldosPignorados_sp"/>
    </con:dependency>
</con:xqueryEntry>