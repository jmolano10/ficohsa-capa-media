xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/DBConTransaccioneshistoricasBS";
(:: import schema at "../Schemas/DBConTransaccioneshistoricasBS_sp.xsd" ::)



declare function local:conTransaccionesHistorica($codigoPais as xs:string,
    $tipoRegistro as xs:string,
    $numeroTarjeta as xs:string,
    $mes as xs:string,
    $anio as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:Pais>{ data($codigoPais) }</ns0:Pais>
            <ns0:NumCuenta>{ data($numeroTarjeta) }</ns0:NumCuenta>
            <ns0:Tipo>{ data($tipoRegistro) }</ns0:Tipo>
            {
            	if($mes != '')then(
            		<ns0:Mes> { data($mes) } </ns0:Mes>
            	)else()
            }
            {
            	if($anio != '')then(
            		<ns0:Anio> { data($anio) } </ns0:Anio>
            	)else()
            }
        </ns0:InputParameters>
};

declare variable $codigoPais as xs:string external;
declare variable $tipoRegistro as xs:string external;
declare variable $numeroTarjeta as xs:string external;
declare variable $mes as xs:string external;
declare variable $anio as xs:string external;

local:conTransaccionesHistorica($codigoPais,
    $tipoRegistro,
    $numeroTarjeta,
    $mes,
    $anio)