xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaPasivosClienteRequest1" element="ns1:consultaPasivosClienteRequest" location="../../../../../../Business_Resources/consultasCliente/Resources/consultaClientesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultarTarjetasCredito" location="../../../transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl" ::)

declare namespace ns0 = "http://alcance.local/wsinfotarjetas/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksPA/consultaPasivosCliente/sjConsultaTarjetaCredito/consultaTarjetaCreditoClienteIn/";

declare function xf:consultaTarjetaCreditoClienteIn($consultaPasivosClienteRequest1 as element(ns1:consultaPasivosClienteRequest))
    as element(ns0:ConsultarTarjetasCredito) {
        <ns0:ConsultarTarjetasCredito>
            <ns0:noIdentidadCliente>{ data($consultaPasivosClienteRequest1/CUSTOMER_ID) }</ns0:noIdentidadCliente>
        </ns0:ConsultarTarjetasCredito>
};

declare variable $consultaPasivosClienteRequest1 as element(ns1:consultaPasivosClienteRequest) external;

xf:consultaTarjetaCreditoClienteIn($consultaPasivosClienteRequest1)