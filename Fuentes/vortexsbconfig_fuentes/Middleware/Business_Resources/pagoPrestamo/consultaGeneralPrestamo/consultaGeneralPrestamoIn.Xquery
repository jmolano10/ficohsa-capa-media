<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagoPrestamo" element="ns0:pagoPrestamo" location="../pagoPrestamoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../consultaGeneralPrestamo/Resources/ConsultaGeneralPrestamo/xsd/ORA_BANK_OSB_CON_GENERAL_PRESTAMO.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_CON_GENERAL_PRESTAMO/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoPrestamoTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/pagoPrestamo/consultaGeneralPrestamo/consultaGeneralPrestamoIn/";

declare function xf:consultaGeneralPrestamoIn($pagoPrestamo as element(ns0:pagoPrestamo))
    as element(ns1:InputParameters) {
        &lt;ns1:InputParameters>
            &lt;ns1:LOAN_ID>{ data($pagoPrestamo/LOAN_NUMBER) }&lt;/ns1:LOAN_ID>
        &lt;/ns1:InputParameters>
};

declare variable $pagoPrestamo as element(ns0:pagoPrestamo) external;

xf:consultaGeneralPrestamoIn($pagoPrestamo)</con:xquery>
    <con:dependency location="../pagoPrestamoTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/pagoPrestamo/pagoPrestamoTypes"/>
    </con:dependency>
    <con:dependency location="../../consultaGeneralPrestamo/Resources/ConsultaGeneralPrestamo/xsd/ORA_BANK_OSB_CON_GENERAL_PRESTAMO.xsd">
        <con:schema ref="Middleware/Business_Resources/consultaGeneralPrestamo/Resources/ConsultaGeneralPrestamo/xsd/ORA_BANK_OSB_CON_GENERAL_PRESTAMO"/>
    </con:dependency>
</con:xqueryEntry>