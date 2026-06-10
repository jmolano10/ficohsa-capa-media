<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaGeneralPrestamo1" element="ns0:consultaGeneralPrestamo" location="consultaGeneralPrestamoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="Resources/ConsultaGeneralPrestamo/xsd/ORA_BANK_OSB_CON_GENERAL_PRESTAMO.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_CON_GENERAL_PRESTAMO/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaGeneralPrestamoTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaGeneralPrestamo/consultaGeneralPrestamoIn/";

declare function xf:consultaGeneralPrestamoIn($consultaGeneralPrestamo1 as element(ns0:consultaGeneralPrestamo))
    as element(ns1:InputParameters) {
        &lt;ns1:InputParameters>
            &lt;ns1:LOAN_ID>{ data($consultaGeneralPrestamo1/LOAN_ID) }&lt;/ns1:LOAN_ID>
        &lt;/ns1:InputParameters>
};

declare variable $consultaGeneralPrestamo1 as element(ns0:consultaGeneralPrestamo) external;

xf:consultaGeneralPrestamoIn($consultaGeneralPrestamo1)</con:xquery>
    <con:dependency location="consultaGeneralPrestamoTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/consultaGeneralPrestamo/consultaGeneralPrestamoTypes"/>
    </con:dependency>
    <con:dependency location="Resources/ConsultaGeneralPrestamo/xsd/ORA_BANK_OSB_CON_GENERAL_PRESTAMO.xsd">
        <con:schema ref="Middleware/Business_Resources/consultaGeneralPrestamo/Resources/ConsultaGeneralPrestamo/xsd/ORA_BANK_OSB_CON_GENERAL_PRESTAMO"/>
    </con:dependency>
</con:xqueryEntry>