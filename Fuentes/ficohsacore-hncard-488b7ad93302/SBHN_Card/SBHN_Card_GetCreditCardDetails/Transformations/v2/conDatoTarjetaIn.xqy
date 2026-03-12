xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoTarjeta";
(:: import schema at "../../Schemas/v2/conDatoTarjeta_sp.xsd" ::)


declare function local:conDatoTarjetaIn($cardNumber as xs:string,
    $org as xs:string,
    $codigoPais as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:Pais>{ $codigoPais }</ns0:Pais>
            {
           	 	if($org != "") then (
            		<ns0:Org>{ $org }</ns0:Org>
            	)else()
            }
            <ns0:NumTarjeta>{ $cardNumber }</ns0:NumTarjeta>
        </ns0:InputParameters>
};

declare variable $cardNumber as xs:string external;
declare variable $org as xs:string external;
declare variable $codigoPais as xs:string external;

local:conDatoTarjetaIn($cardNumber,
    $org,
    $codigoPais)