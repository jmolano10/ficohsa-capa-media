xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$validaProductoACH1" element="ns0:validaProductoACH" location="../xsd/validaProductoACHTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABKGT/consultaDetallesCuenta/xsd/consultaDetallesCuenta_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/validaProductoACHTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaDetallesCuenta";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaProductoACH/xq/consultaDetallesCuentaGTIn/";

declare function xf:consultaDetallesCuentaGTIn($validaProductoACH1 as element(ns0:validaProductoACH))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:ACCOUNT_NUMBER>{ data($validaProductoACH1/PRODUCT_NUMBER) }</ns1:ACCOUNT_NUMBER>
        </ns1:InputParameters>
};

declare variable $validaProductoACH1 as element(ns0:validaProductoACH) external;

xf:consultaDetallesCuentaGTIn($validaProductoACH1)