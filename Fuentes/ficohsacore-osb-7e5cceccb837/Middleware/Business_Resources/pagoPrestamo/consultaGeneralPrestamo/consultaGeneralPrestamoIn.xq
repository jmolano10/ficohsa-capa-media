(:: pragma bea:global-element-parameter parameter="$pagoPrestamo" element="ns0:pagoPrestamo" location="../pagoPrestamoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../consultaGeneralPrestamo/Resources/ConsultaGeneralPrestamo/xsd/ORA_BANK_OSB_CON_GENERAL_PRESTAMO.xsd" ::)

declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_CON_GENERAL_PRESTAMO/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoPrestamoTypes";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/pagoPrestamo/consultaGeneralPrestamo/consultaGeneralPrestamoIn/";

declare function xf:consultaGeneralPrestamoIn($pagoPrestamo as element(ns0:pagoPrestamo))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:LOAN_ID>{ data($pagoPrestamo/LOAN_NUMBER) }</ns1:LOAN_ID>
        </ns1:InputParameters>
};

declare variable $pagoPrestamo as element(ns0:pagoPrestamo) external;

xf:consultaGeneralPrestamoIn($pagoPrestamo)