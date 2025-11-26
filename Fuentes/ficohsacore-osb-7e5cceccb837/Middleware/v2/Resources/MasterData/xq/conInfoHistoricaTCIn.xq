(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MasterData/conInfoHistoricaTC/xsd/conInfoHistoricaTC_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conInfoHistoricaTC";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/MasterData/xq/conInfoHistoricaTCIn/";

declare function xf:conInfoHistoricaTCIn($codigoPais as xs:string,
    $month as xs:string,
    $year as xs:string,
    $cardNumber as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:Pais>{ $codigoPais }</ns0:Pais>
            <ns0:NumCard>{ fn-bea:pad-left($cardNumber, 19, '0') }</ns0:NumCard>
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
declare variable $month as xs:string external;
declare variable $year as xs:string external;
declare variable $cardNumber as xs:string external;

xf:conInfoHistoricaTCIn($codigoPais,
    $month,
    $year,
    $cardNumber)