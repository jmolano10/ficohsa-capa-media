<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaPasivosClienteRequest1" element="ns1:consultaPasivosClienteRequest" location="../../../../../../Business_Resources/consultasCliente/Resources/consultaClientesTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultarTarjetasCredito" location="../../../transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl" ::)

declare namespace ns0 = "http://alcance.local/wsinfotarjetas/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksGT/consultaPasivosCliente/sjConsultaTarjetaCredito/consultaTarjetaCreditoClienteIn/";

declare function xf:consultaTarjetaCreditoClienteIn($consultaPasivosClienteRequest1 as element(ns1:consultaPasivosClienteRequest))
    as element(ns0:ConsultarTarjetasCredito) {
        &lt;ns0:ConsultarTarjetasCredito>
            &lt;ns0:noIdentidadCliente>{ data($consultaPasivosClienteRequest1/CUSTOMER_ID) }&lt;/ns0:noIdentidadCliente>
        &lt;/ns0:ConsultarTarjetasCredito>
};

declare variable $consultaPasivosClienteRequest1 as element(ns1:consultaPasivosClienteRequest) external;

xf:consultaTarjetaCreditoClienteIn($consultaPasivosClienteRequest1)</con:xquery>
    <con:dependency location="../../../../../../Business_Resources/consultasCliente/Resources/consultaClientesTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/consultasCliente/Resources/consultaClientesTypes"/>
    </con:dependency>
    <con:dependency location="../../../transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl">
        <con:wsdl ref="Middleware/v2/BusinessServices/ABKGT/transaccionesAlcance/wsdl/wsinfotarjetas.asmx"/>
    </con:dependency>
</con:xqueryEntry>