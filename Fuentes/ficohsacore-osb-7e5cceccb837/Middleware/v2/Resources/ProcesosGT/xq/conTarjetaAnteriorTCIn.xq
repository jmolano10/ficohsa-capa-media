(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/ProcesosGT/conTarjetaAnteriorTC/xsd/conTarjetaAnteriorTC_sp.xsd" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conTarjetaAnteriorTC";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/MasterDataGT/xq/conTarjetaAnteriorTCIn/";

declare function xf:conTarjetaAnteriorTCIn($org as xs:string,
    $numeroTarjeta as xs:string,
    $codigoPais as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:Pais>{ data($codigoPais) }</ns0:Pais>
            {
            	if($org != '')then(
            		<ns0:Org>{ $org }</ns0:Org>
            	)else()
            }
            <ns0:NumCard>{ data($numeroTarjeta) }</ns0:NumCard>
        </ns0:InputParameters>
};

declare variable $org as xs:string external;
declare variable $numeroTarjeta as xs:string external;
declare variable $codigoPais as xs:string external;

xf:conTarjetaAnteriorTCIn($org,
    $numeroTarjeta,
    $codigoPais)