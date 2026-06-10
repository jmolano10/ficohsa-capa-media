<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaGeneralPrestamo1" element="ns0:consultaGeneralPrestamo" location="../xsd/consultaGeneralPrestamoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABKGT/consultaGeneralPrestamo/xsd/ConsultaGeneralPrestamo_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaGeneralPrestamoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaGeneralPrestamo";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksGT/consultaCertificadoDeposito/consultaGeneralPrestamoIn/";

declare function xf:consultaGeneralPrestamoIn($consultaGeneralPrestamo1 as element(ns0:consultaGeneralPrestamo))
    as element(ns1:InputParameters) {
        &lt;ns1:InputParameters>
            &lt;ns1:LOAN_ID>{ data($consultaGeneralPrestamo1/LOAN_ID) }&lt;/ns1:LOAN_ID>
        &lt;/ns1:InputParameters>
};

declare variable $consultaGeneralPrestamo1 as element(ns0:consultaGeneralPrestamo) external;

xf:consultaGeneralPrestamoIn($consultaGeneralPrestamo1)</con:xquery>
    <con:dependency location="../xsd/consultaGeneralPrestamoTypes.xsd">
        <con:schema ref="Middleware/v2/Resources/ConsultaGeneralPrestamo/xsd/consultaGeneralPrestamoTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/ABKGT/consultaGeneralPrestamo/xsd/ConsultaGeneralPrestamo_sp.xsd">
        <con:schema ref="Middleware/v2/BusinessServices/ABKGT/consultaGeneralPrestamo/xsd/ConsultaGeneralPrestamo_sp"/>
    </con:dependency>
</con:xqueryEntry>