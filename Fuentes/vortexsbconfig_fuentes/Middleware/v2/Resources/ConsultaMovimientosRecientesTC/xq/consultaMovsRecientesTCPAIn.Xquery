<?xml version="1.0" encoding="UTF-8"?>
<con:xqueryEntry xmlns:con="http://www.bea.com/wli/sb/resources/config">
    <con:xquery>xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaMovimientosRecientesTC1" element="ns1:consultaMovimientosRecientesTC" location="../../../../Business_Resources/tarjetaCredito/ConsultaMovimientosRecientesTC/consultaMovimientosRecientesTCTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:MovimientosRecientes" location="../../../BusinessServices/ABKPA/transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl" ::)

declare namespace ns0 = "http://alcance.local/wsinfotarjetas/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaMovimientosRecientesTCTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksPA/consultarMovimientosRecientesTC/xq/consultarMovimientosRecientesTCIn/";

declare function xf:consultarMovimientosRecientesTCIn($consultaMovimientosRecientesTC1 as element(ns1:consultaMovimientosRecientesTC))
    as element(ns0:MovimientosRecientes) {
        &lt;ns0:MovimientosRecientes>
            &lt;ns0:noTarjetaCredito>{ data($consultaMovimientosRecientesTC1/CARD_NUMBER) }&lt;/ns0:noTarjetaCredito>
        &lt;/ns0:MovimientosRecientes>
};

declare variable $consultaMovimientosRecientesTC1 as element(ns1:consultaMovimientosRecientesTC) external;

xf:consultarMovimientosRecientesTCIn($consultaMovimientosRecientesTC1)</con:xquery>
    <con:dependency location="../../../../Business_Resources/tarjetaCredito/ConsultaMovimientosRecientesTC/consultaMovimientosRecientesTCTypes.xsd">
        <con:schema ref="Middleware/Business_Resources/tarjetaCredito/ConsultaMovimientosRecientesTC/consultaMovimientosRecientesTCTypes"/>
    </con:dependency>
    <con:dependency location="../../../BusinessServices/ABKPA/transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl">
        <con:wsdl ref="Middleware/v2/BusinessServices/ABKPA/transaccionesAlcance/wsdl/wsinfotarjetas.asmx"/>
    </con:dependency>
</con:xqueryEntry>