(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MasterDataHN/conDatoTarjetas_v2/xsd/conDatoTarjetas_v2_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatoTarjetas_v2";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/MasterDataHN/xq/conDatoTarjetas_v2In/";

declare function xf:conDatoTarjetas_v2In($codigoPais as xs:string,
    $org as xs:string,
    $numeroTarjeta as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:Pais>{ $codigoPais }</ns0:Pais>
            {
            	if($org != '') then (
            		<ns0:Org>{ $org }</ns0:Org>
            	) else ()
            }
            <ns0:NumTarjeta>{ $numeroTarjeta }</ns0:NumTarjeta>
        </ns0:InputParameters>
};

declare variable $codigoPais as xs:string external;
declare variable $org as xs:string external;
declare variable $numeroTarjeta as xs:string external;

xf:conDatoTarjetas_v2In($codigoPais,
    $org,
    $numeroTarjeta)