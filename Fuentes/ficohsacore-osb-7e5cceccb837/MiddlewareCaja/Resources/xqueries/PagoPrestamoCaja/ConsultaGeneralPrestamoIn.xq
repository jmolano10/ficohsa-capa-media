(:: pragma bea:global-element-parameter parameter="$pagoPrestamo" element="ns0:pagoPrestamo" location="../../xsds/PagoPrestamoCaja/PagoPrestamoCaja.xsd" ::)
(:: pragma bea:global-element-return element="ns1:consultaGeneralPrestamo" location="../../xsds/ConsultaGeneralPrestamo/ConsultaGeneralPrestamo.xsd" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaGeneralPrestamoTypes";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/pagoPrestamoTypes";
declare namespace xf = "http://tempuri.org/MiddlewareCaja/Resources/xqueries/PagoPrestamoCaja/ConsultaGeneralPrestamoIn/";

declare function xf:ConsultaGeneralPrestamoIn($pagoPrestamo as element(ns0:pagoPrestamo))
    as element(ns1:consultaGeneralPrestamo) {
        <ns1:consultaGeneralPrestamo>
            <LOAN_ID>{ data($pagoPrestamo/LOAN_NUMBER) }</LOAN_ID>
        </ns1:consultaGeneralPrestamo>
};

declare variable $pagoPrestamo as element(ns0:pagoPrestamo) external;

xf:ConsultaGeneralPrestamoIn($pagoPrestamo)