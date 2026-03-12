xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)


declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoTarjetas_v2";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/consultaDatosTarjetaCreditoTypes";

declare function local:conDatosTarjetaIn_v2($consultaDatosTarjetaCredito as xs:string,
    $codigoPais as xs:string)
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <ns1:Pais>{ $codigoPais }</ns1:Pais> 
            <ns1:NumTarjeta>{$consultaDatosTarjetaCredito}</ns1:NumTarjeta>
        </ns1:InputParameters>
};

declare variable $consultaDatosTarjetaCredito as xs:string external;
declare variable $codigoPais as xs:string external;

local:conDatosTarjetaIn_v2($consultaDatosTarjetaCredito,
    $codigoPais)