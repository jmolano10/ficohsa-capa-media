xquery version "2004-draft" encoding "Cp1252";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MasterDataHN/conDatoTarjeta/xsd/conDatoTarjeta_sp.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/MasterDataHN/conDatoTarjetaIn/";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoTarjeta";

declare function xf:conDatoTarjetaIn($cardNumber as xs:string,
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

xf:conDatoTarjetaIn($cardNumber,
    $org,
    $codigoPais)