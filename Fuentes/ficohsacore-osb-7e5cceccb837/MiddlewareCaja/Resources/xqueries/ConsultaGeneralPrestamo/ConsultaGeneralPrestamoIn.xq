(:: pragma bea:global-element-parameter parameter="$consultaGeneralPrestamo" element="ns0:consultaGeneralPrestamo" location="../../xsds/ConsultaGeneralPrestamo/ConsultaGeneralPrestamo.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../xsds/ConsultaGeneralPrestamo/consultaGeneralPrestamoAbanks/ORA_BANK_OSB_CON_GENERAL_PRESTAMO.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_CON_GENERAL_PRESTAMO/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaGeneralPrestamoTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/ConsultaGeneralPrestamo/ConsultaGeneralPrestamoIn/";

declare function xf:ConsultaGeneralPrestamoIn($consultaGeneralPrestamo as element(ns0:consultaGeneralPrestamo))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:LOAN_ID>{ data($consultaGeneralPrestamo/LOAN_ID) }</ns1:LOAN_ID>
        </ns1:InputParameters>
};

declare variable $consultaGeneralPrestamo as element(ns0:consultaGeneralPrestamo) external;

xf:ConsultaGeneralPrestamoIn($consultaGeneralPrestamo)