xquery version "2004-draft";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MasterDataGT/conDatoTarjetas_v2/xsd/conDatoTarjetas_v2_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoTarjetas_v2";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/MasterDataGT/xq/conDatoTarjetaIn_v2/";

declare function xf:conDatoTarjetaIn_v2($cardNumber as xs:string,
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

xf:conDatoTarjetaIn_v2($cardNumber,
    $org,
    $codigoPais)