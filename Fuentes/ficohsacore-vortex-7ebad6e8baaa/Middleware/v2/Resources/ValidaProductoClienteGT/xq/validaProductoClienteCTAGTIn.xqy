xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$validaProductoCliente" element="ns0:validaProductoCliente" location="../../ValidaProductoCliente/xsd/validaProductoClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../BusinessServices/ABKGT/consultaDetallesCuenta/xsd/consultaDetallesCuenta_sp.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/validaProductoClienteTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultaDetallesCuenta";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaProductoClienteGT/xq/validaProductoClienteCTAGTIn/";

declare function xf:validaProductoClienteCTAGTIn($validaProductoCliente as element(ns0:validaProductoCliente))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:ACCOUNT_NUMBER>{ data($validaProductoCliente/PRODUCT_NUMBER) }</ns1:ACCOUNT_NUMBER>
        </ns1:InputParameters>
};

declare variable $validaProductoCliente as element(ns0:validaProductoCliente) external;

xf:validaProductoClienteCTAGTIn($validaProductoCliente)