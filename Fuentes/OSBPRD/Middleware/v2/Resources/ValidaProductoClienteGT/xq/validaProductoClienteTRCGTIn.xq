(:: pragma bea:global-element-parameter parameter="$validaProductoCliente" element="ns0:validaProductoCliente" location="../../ValidaProductoCliente/xsd/validaProductoClienteTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:ConsultarTarjetasCredito_v2" location="../../../BusinessServices/ABKGT/transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/validaProductoClienteTypes";
declare namespace ns1 = "http://alcance.local/wsinfotarjetas/";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ValidaProductoClienteGT/xq/validaProductoClienteTRCGTIn/";

declare function xf:validaProductoClienteTRCGTIn($validaProductoCliente as element(ns0:validaProductoCliente))
    as element(ns1:ConsultarTarjetasCredito_v2) {
        <ns1:ConsultarTarjetasCredito_v2>
            <ns1:Tipo>1</ns1:Tipo>
            <ns1:Parametro>{ data($validaProductoCliente/CUSTOMER_ID) }</ns1:Parametro>
            <ns1:Saldos>None</ns1:Saldos>
        </ns1:ConsultarTarjetasCredito_v2>
};

declare variable $validaProductoCliente as element(ns0:validaProductoCliente) external;

xf:validaProductoClienteTRCGTIn($validaProductoCliente)