xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$consultaTiposPrestamos" element="ns0:consultaTiposPrestamos" location="../../CatalogosInfoPrestamo/xsd/catalogosInfoPrestamoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/CatalogosInfoPrestamo/consultaTiposPrestamos/xsd/consultaTiposPrestamos_sp.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaTiposPrestamos/xq/consultaTiposPrestamosHNIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/catalogosInfoPrestamoTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaTiposPrestamos";

declare function xf:consultaTiposPrestamosHNIn($consultaTiposPrestamos as element(ns0:consultaTiposPrestamos))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:P_LOAN_TYPE_CODE>{ data($consultaTiposPrestamos/LOAN_TYPE_CODE) }</ns1:P_LOAN_TYPE_CODE>
        </ns1:InputParameters>
};

declare variable $consultaTiposPrestamos as element(ns0:consultaTiposPrestamos) external;

xf:consultaTiposPrestamosHNIn($consultaTiposPrestamos)