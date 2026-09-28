(:: pragma bea:global-element-parameter parameter="$consultaMovimientosRecientesTC1" element="ns1:consultaMovimientosRecientesTC" location="consultaMovimientosRecientesTCTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:ConsultarMovsRecientes" location="../Resources/TarjetaDeCredito.wsdl" ::)

declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaMovimientosRecientesTCTypes";
declare namespace ns0 = "http://tempuri.org/";
declare namespace xf = "http://tempuri.org/Middleware/Business_Resources/tarjetaCredito/ConsultaMovimientosRecientesTC/consultaMovimientosRecientesTCIn/";

declare function xf:consultaMovimientosRecientesTCIn($consultaMovimientosRecientesTC1 as element(ns1:consultaMovimientosRecientesTC))
    as element(ns0:ConsultarMovsRecientes) {
        <ns0:ConsultarMovsRecientes>
            <ns0:noTarjetaCredito>{ data($consultaMovimientosRecientesTC1/CARD_NUMBER) }</ns0:noTarjetaCredito>
        </ns0:ConsultarMovsRecientes>
};

declare variable $consultaMovimientosRecientesTC1 as element(ns1:consultaMovimientosRecientesTC) external;

xf:consultaMovimientosRecientesTCIn($consultaMovimientosRecientesTC1)