xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-return element="ns0:InputParameters" location="../../../BusinessServices/MasterDataHN/conDetalleComprasCuotas/xsd/conDetalleComprasCuotas_sp.xsd" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/MasterDataHN/xq/conDetalleComprasCuotasHNIn/";
declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDetalleComprasCuotas";

declare function xf:conDetalleComprasCuotasHNIn($pais as xs:string,
    $org as xs:string,
    $numCuenta as xs:string,
    $tipo as xs:string,
    $originalInstall as xs:string)
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            <ns0:Pais>{ $pais }</ns0:Pais>
            <ns0:Org>{ $org }</ns0:Org>
            <ns0:NumCuenta>{ fn-bea:pad-left($numCuenta, 19, '0') }</ns0:NumCuenta>
            <ns0:Tipo>
            { 
            	if($tipo = 'CARD_NUMBER')then(
            		1
            	)else(
            		0
            	)         
            }
            </ns0:Tipo>
            <ns0:OriginalInstall>{ $originalInstall }</ns0:OriginalInstall>
        </ns0:InputParameters>
};

declare variable $pais as xs:string external;
declare variable $org as xs:string external;
declare variable $numCuenta as xs:string external;
declare variable $tipo as xs:string external;
declare variable $originalInstall as xs:string external;

xf:conDetalleComprasCuotasHNIn($pais,
    $org,
    $numCuenta,
    $tipo,
    $originalInstall)