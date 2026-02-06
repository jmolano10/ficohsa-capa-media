xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../BusinessServices/ProcesosPA/conTransaccionesHistoricas/xsd/conTransaccionesHistoricas_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conTransaccionesHistoricas";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesosPA/xq/conTransaccionesHistoricasIn/";

declare function xf:conTransaccionesHistoricasIn($codigoPais as xs:string,
    $tipo as xs:string,
    $numeroTarjeta as xs:string,
    $mes as xs:string,
    $anio as xs:string,
    $agrupar as xs:int)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:Pais>{ data($codigoPais) }</ns0:Pais>
            <ns0:NumCuenta>{ data($numeroTarjeta) }</ns0:NumCuenta>
            <ns0:Tipo>{ data($tipo) }</ns0:Tipo>
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
            <ns0:Agrupar>{ data($agrupar) }</ns0:Agrupar>
        </ns0:InputParameters>
};

declare variable $codigoPais as xs:string external;
declare variable $tipo as xs:string external;
declare variable $numeroTarjeta as xs:string external;
declare variable $mes as xs:string external;
declare variable $anio as xs:string external;
declare variable $agrupar as xs:int external;

xf:conTransaccionesHistoricasIn($codigoPais,
    $tipo,
    $numeroTarjeta,
    $mes,
    $anio,
    $agrupar)