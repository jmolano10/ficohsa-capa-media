xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns0="http://alcance.local/wsinfotarjetas/";
(:: import schema at "../Resources/WSInfoTarjetas.asmx.wsdl" ::)

declare function local:consultaEstadoCuentaTCHistoricoIn($mes as xs:string ,$anio as xs:string, $numeroTarjeta as xs:string)
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

local:consultaEstadoCuentaTCHistoricoIn($mes, $anio, $numeroTarjeta)