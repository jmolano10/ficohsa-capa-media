xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MasterData/conTransaccionesHistoricas/xsd/conTransaccionesHistoricas_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conTransaccionesHistoricas";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/MasterData/xq/conTransaccionesHistoricasIn/";

declare function xf:conTransaccionesHistoricasIn($codigoPais as xs:string,
    $org as xs:string,
    $cardNumber as xs:string,
    $tipo as xs:string,
    $month as xs:string,
    $year as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:Pais>{$codigoPais}</ns0:Pais>
            <ns0:Org>{$org}</ns0:Org>
            <ns0:NumCuenta>{ fn-bea:pad-left($cardNumber, 19, '0') }</ns0:NumCuenta>
            <ns0:Tipo>{ data($tipo) }</ns0:Tipo>
            {
            	if($month != '') then
            	(
            		<ns0:Mes>{ data($month) }</ns0:Mes>
            	) else ()            
            }
            {
            	if($year != '') then
            	(
            		<ns0:Anio>{ data($year) }</ns0:Anio>
            	) else ()            
            }            
        </ns0:InputParameters>
};

declare variable $codigoPais as xs:string external;
declare variable $org as xs:string external;
declare variable $cardNumber as xs:string external;
declare variable $tipo as xs:string external;
declare variable $month as xs:string external;
declare variable $year as xs:string external;

xf:conTransaccionesHistoricasIn($codigoPais,
    $org,
    $cardNumber,
    $tipo,
    $month,
    $year)