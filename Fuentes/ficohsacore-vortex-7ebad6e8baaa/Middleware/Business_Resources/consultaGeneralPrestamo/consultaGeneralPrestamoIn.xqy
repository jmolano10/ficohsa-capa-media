xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaGeneralPrestamo1" element="ns0:consultaGeneralPrestamo" location="consultaGeneralPrestamoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="Resources/ConsultaGeneralPrestamo/xsd/ORA_BANK_OSB_CON_GENERAL_PRESTAMO.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_CON_GENERAL_PRESTAMO/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaGeneralPrestamoTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/consultaGeneralPrestamo/consultaGeneralPrestamoIn/";

declare function xf:consultaGeneralPrestamoIn($consultaGeneralPrestamo1 as element(ns0:consultaGeneralPrestamo))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:LOAN_ID>{ data($consultaGeneralPrestamo1/LOAN_ID) }</ns1:LOAN_ID>
        </ns1:InputParameters>
};

declare variable $consultaGeneralPrestamo1 as element(ns0:consultaGeneralPrestamo) external;

xf:consultaGeneralPrestamoIn($consultaGeneralPrestamo1)