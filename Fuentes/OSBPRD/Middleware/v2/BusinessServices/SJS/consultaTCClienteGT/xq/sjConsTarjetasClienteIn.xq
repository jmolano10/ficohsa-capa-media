(:: pragma bea:global-element-return element="ns0:ConsultarTarjetasCredito" location="../../../ABKGT/transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl" ::)

declare namespace ns0 = "http://alcance.local/wsinfotarjetas/";
declare namespace xf = "http://tempuri.org/Middleware/v2/BusinessServices/SJS/consultaTCClienteGT/xq/sjConsTarjetasIn/";

declare function xf:sjConsTarjetasIn($customerId as xs:string)
    as element(ns0:ConsultarTarjetasCredito) {
        <ns0:ConsultarTarjetasCredito>
            <ns0:noIdentidadCliente>{ $customerId }</ns0:noIdentidadCliente>
            <ns0:nombreCliente></ns0:nombreCliente>
        </ns0:ConsultarTarjetasCredito>
};

declare variable $customerId as xs:string external;

xf:sjConsTarjetasIn($customerId)