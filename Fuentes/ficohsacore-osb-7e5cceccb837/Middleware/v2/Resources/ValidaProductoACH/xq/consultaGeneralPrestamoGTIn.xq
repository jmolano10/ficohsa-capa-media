(:: pragma bea:global-element-parameter parameter="$validaProductoACH1" element="ns0:validaProductoACH" location="../xsd/validaProductoACHTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABKGT/consultaGeneralPrestamo/xsd/ConsultaGeneralPrestamo_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/validaProductoACHTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaGeneralPrestamo";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaProductoACH/xq/consultaGeneralPrestamoGTIn/";

declare function xf:consultaGeneralPrestamoGTIn($validaProductoACH1 as element(ns0:validaProductoACH))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:LOAN_ID>{ data($validaProductoACH1/PRODUCT_NUMBER) }</ns1:LOAN_ID>
        </ns1:InputParameters>
};

declare variable $validaProductoACH1 as element(ns0:validaProductoACH) external;

xf:consultaGeneralPrestamoGTIn($validaProductoACH1)