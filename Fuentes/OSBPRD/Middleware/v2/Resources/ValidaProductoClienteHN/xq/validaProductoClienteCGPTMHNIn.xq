(:: pragma bea:global-element-parameter parameter="$validaProductoCliente" element="ns0:validaProductoCliente" location="../../ValidaProductoCliente/xsd/validaProductoClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:InputParameters" location="../../../../Business_Resources/consultaGeneralPrestamo/Resources/ConsultaGeneralPrestamo/xsd/ORA_BANK_OSB_CON_GENERAL_PRESTAMO.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/validaProductoClienteTypes";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_CON_GENERAL_PRESTAMO/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaProductoClienteHN/xq/validaProductoClienteCGPTMHNIn/";

declare function xf:validaProductoClienteCGPTMHNIn($validaProductoCliente as element(ns0:validaProductoCliente))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:LOAN_ID>{ data($validaProductoCliente/PRODUCT_NUMBER) }</ns1:LOAN_ID>
        </ns1:InputParameters>
};

declare variable $validaProductoCliente as element(ns0:validaProductoCliente) external;

xf:validaProductoClienteCGPTMHNIn($validaProductoCliente)