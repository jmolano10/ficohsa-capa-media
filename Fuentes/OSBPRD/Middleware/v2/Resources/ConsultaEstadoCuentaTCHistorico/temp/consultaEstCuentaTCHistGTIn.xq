(:: pragma bea:global-element-parameter parameter="$consultaEstadoCuentaTCHistorico1" element="ns1:consultaEstadoCuentaTCHistorico" location="../../../../Business_Resources/tarjetaCredito/ConsultaEstadoCuentaTCHistorico/consultaEstadoCuentaTCHistoricoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns0:EstadosCuentaHistorico" location="../../../BusinessServices/ABKGT/transaccionesAlcance/wsdl/wsinfotarjetas.asmx.wsdl" ::)

declare namespace ns0 = "http://alcance.local/wsinfotarjetas/";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/consultaEstadoCuentaTCHistoricoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/abanksGT/consultaEstadoCuentaTCHistorico/xq/consultaEstadoCuentaTCHistoricoIn/";

declare function xf:consultaEstadoCuentaTCHistoricoIn($mes as xs:string ,$anio as xs:string, $numeroTarjeta as xs:string)
    as element(ns0:EstadosCuentaHistorico) {
        <ns0:EstadosCuentaHistorico>
            <ns0:noTarjetaCredito>{ data($numeroTarjeta) }</ns0:noTarjetaCredito>
            <ns0:noAnio>{ data($anio) }</ns0:noAnio>
            <ns0:noMes>{ data($mes) }</ns0:noMes>
        </ns0:EstadosCuentaHistorico>
};

declare variable $numeroTarjeta as xs:string external;
declare variable $anio as xs:string external;
declare variable $mes as xs:string external;

xf:consultaEstadoCuentaTCHistoricoIn($mes, $anio, $numeroTarjeta)