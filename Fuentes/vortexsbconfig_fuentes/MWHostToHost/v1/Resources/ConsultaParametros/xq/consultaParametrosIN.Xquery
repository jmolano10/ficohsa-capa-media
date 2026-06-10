<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaParametrosRequest" element="ns0:consultaParametrosRequest" location="../../AperturaMasiva/xsd/aperturaMasivaTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/PWS/consultaParametros/xsd/consultaParametros_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/aperturaMasivaTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaParametros";
declare namespace xf = "http://tempuri.org/MWHostToHost/v1/Resources/ActualizaParametros/xq/actualizaParametrosIN/";

declare function xf:consultaParametrosIN($consultaParametrosRequest as element(ns0:consultaParametrosRequest))
    as element(ns1:InputParameters) {
        &lt;ns1:InputParameters>
            &lt;ns1:PV_CODIGOCLIENTE>{ data($consultaParametrosRequest/CUSTOMER_ID) }&lt;/ns1:PV_CODIGOCLIENTE>
        &lt;/ns1:InputParameters>
};

declare variable $consultaParametrosRequest as element(ns0:consultaParametrosRequest) external;

xf:consultaParametrosIN($consultaParametrosRequest)</con:xquery>
    <con:dependency location="../../AperturaMasiva/xsd/aperturaMasivaTypes.xsd">
        <con:schema ref="MWHostToHost/v1/Resources/AperturaMasiva/xsd/aperturaMasivaTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/PWS/consultaParametros/xsd/consultaParametros_sp.xsd">
        <con:schema ref="MWHostToHost/v1/BusinessServices/PWS/consultaParametros/xsd/consultaParametros_sp"/>
    </con:dependency>
</con:xqueryEntry>