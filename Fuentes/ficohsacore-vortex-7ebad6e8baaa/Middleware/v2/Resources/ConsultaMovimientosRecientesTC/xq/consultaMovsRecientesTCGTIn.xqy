xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$consultaMovimientosRecientesTC1" element="ns1:consultaMovimientosRecientesTC" location="../../../../Business_Resources/tarjetaCredito/ConsultaMovimientosRecientesTC/consultaMovimientosRecientesTCTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:MovimientosRecientes" location="../../../BusinessServices/ABKGT/transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl" ::)

declare namespace ns0 = "http://alcance.local/wsinfotarjetas/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaMovimientosRecientesTCTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksGT/consultarMovimientosRecientesTC/xq/consultarMovimientosRecientesTCIn/";

declare function xf:consultarMovimientosRecientesTCIn($consultaMovimientosRecientesTC1 as element(ns1:consultaMovimientosRecientesTC))
    as element(ns0:MovimientosRecientes) {
        <ns0:MovimientosRecientes>
            <ns0:noTarjetaCredito>{ data($consultaMovimientosRecientesTC1/CARD_NUMBER) }</ns0:noTarjetaCredito>
        </ns0:MovimientosRecientes>
};

declare variable $consultaMovimientosRecientesTC1 as element(ns1:consultaMovimientosRecientesTC) external;

xf:consultarMovimientosRecientesTCIn($consultaMovimientosRecientesTC1)