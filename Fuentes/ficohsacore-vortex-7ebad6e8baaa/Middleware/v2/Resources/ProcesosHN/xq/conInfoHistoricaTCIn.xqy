xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ProcesosHN/conInfoHistoricaTC/xsd/conInfoHistoricaTC_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conInfoHistoricaTC";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/MasterDataHN/xq/conInfoHistoricaTCIn/";

declare function xf:conInfoHistoricaTCIn($codigoPais as xs:string,
    $numeroTarjeta as xs:string,
    $org as xs:string,
    $mes as xs:string,
    $anio as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:Pais>{ data($codigoPais) }</ns0:Pais>
            {
            	if($org != '')then(
            		<ns0:Org>{ data($org) }</ns0:Org>
            	)else()
            }
            <ns0:NumCard>{ data($numeroTarjeta) }</ns0:NumCard>
            {
            	if($mes != '')then(
            		<ns0:Mes>{ data($mes) }</ns0:Mes>
            	)else()
            }
            {
            	if($anio != '')then(
            		<ns0:Anio>{ data($anio) }</ns0:Anio>
            	)else()
            }
        </ns0:InputParameters>
};

declare variable $codigoPais as xs:string external;
declare variable $numeroTarjeta as xs:string external;
declare variable $org as xs:string external;
declare variable $mes as xs:string external;
declare variable $anio as xs:string external;

xf:conInfoHistoricaTCIn($codigoPais,
    $numeroTarjeta,
    $org,
    $mes,
    $anio)