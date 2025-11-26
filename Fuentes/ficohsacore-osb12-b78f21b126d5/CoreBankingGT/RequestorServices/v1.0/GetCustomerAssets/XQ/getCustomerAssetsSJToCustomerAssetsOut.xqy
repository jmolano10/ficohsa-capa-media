xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/consultaClientes";
(:: import schema at "../../../../../MWBanking/Customers/RequestorServices/XSD/getCustomerAssets.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaActivosCliente";
(:: import schema at "../XSD/GetCustomerAssetsGT_SJ.xsd" ::)

declare namespace ns3="http://www.ficohsa.com/midleware.services/getCustomerAssetsSJToCustomerAssetsOut";
declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $getCustomerAssetsSJRSP as element() (:: schema-element(ns2:OutputParameters) ::) external;
declare variable $uuid as xs:string external;

declare function xq:mensajeRespuesta($successIndicator as xs:string, $registros as item()*) as xs:string {
	if (upper-case($successIndicator) = 'SUCCESS' and count($registros) > 0) then (
		'Success'
    ) else if ((upper-case($successIndicator) = 'SUCCESS' and count($registros) = 0) or upper-case($successIndicator) = 'NO RECORDS' ) then (
    	'No Records'
    ) else (
    	'Error'
    )
};

declare function ns3:getCustomerAssetsSJToCustomerAssetsOut($uuid as xs:string, $getCustomerAssetsSJRSP as element() (:: schema-element(ns2:OutputParameters) ::)) as element() (:: schema-element(ns1:getCustomerAssetsResponse) ::) {
    <ns1:getCustomerAssetsResponse>
        <ns1:StatusInfo>
            <com:Status>Success</com:Status>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </ns1:StatusInfo>
        <ns1:Assets>
            <ns1:Type>Savings</ns1:Type>
            <ns1:Status>{ xq:mensajeRespuesta(data($getCustomerAssetsSJRSP/ns2:OutputParametersCuentas/ns2:PV_ERROR_CODE), $getCustomerAssetsSJRSP/ns2:OutputParametersCuentas/ns2:PV_ASSET_TYPE_OUT/ns2:PV_ASSET_NUMBER_ITEM[text() = 'AHO'])  }</ns1:Status>
            {
                let $assetTypeOut := $getCustomerAssetsSJRSP/ns2:OutputParametersCuentas/ns2:PV_ASSET_TYPE_OUT/ns2:PV_ASSET_NUMBER_ITEM
            	let $assetNumber := $getCustomerAssetsSJRSP/ns2:OutputParametersCuentas/ns2:PV_ASSET_NUMBER/ns2:PV_ASSET_NUMBER_ITEM
                let $assetName := $getCustomerAssetsSJRSP/ns2:OutputParametersCuentas/ns2:PV_ASSET_NAME/ns2:PV_ASSET_NAME_ITEM
                let $assetCurrency := $getCustomerAssetsSJRSP/ns2:OutputParametersCuentas/ns2:PV_ASSET_CURRENCY/ns2:PV_ASSET_NUMBER_ITEM
                let $assetTotalBalance := $getCustomerAssetsSJRSP/ns2:OutputParametersCuentas/ns2:PV_ASSET_TOTAL_BALANCE/ns2:PV_ASSET_NUMBER_ITEM
                let $assetReserveBalance := $getCustomerAssetsSJRSP/ns2:OutputParametersCuentas/ns2:PV_ASSET_RESERVE_BALANCE/ns2:PV_ASSET_NUMBER_ITEM
                let $assetLockedBalance := $getCustomerAssetsSJRSP/ns2:OutputParametersCuentas/ns2:PV_ASSET_LOCKED_BALANCE/ns2:PV_ASSET_NUMBER_ITEM
                let $assetVisaFloatingBalance := $getCustomerAssetsSJRSP/ns2:OutputParametersCuentas/ns2:PV_ASSET_VISA_FLOATING_BALANCE/ns2:PV_ASSET_NUMBER_ITEM
                let $assetAvailableBalance := $getCustomerAssetsSJRSP/ns2:OutputParametersCuentas/ns2:PV_ASSET_AVAILABLE_BALANCE/ns2:PV_ASSET_NUMBER_ITEM
                let $assetProductType := $getCustomerAssetsSJRSP/ns2:OutputParametersCuentas/ns2:PV_ASSET_PRODUCT_TYPE/ns2:PV_ASSET_NUMBER_ITEM
                let $assetStatus := $getCustomerAssetsSJRSP/ns2:OutputParametersCuentas/ns2:PV_ASSET_STATUS/ns2:PV_ASSET_NAME_ITEM
                let $assetBlock := $getCustomerAssetsSJRSP/ns2:OutputParametersCuentas/ns2:PV_ASSET_BLOCK/ns2:PV_ASSET_NAME_ITEM
                let $assetOpeningDate := $getCustomerAssetsSJRSP/ns2:OutputParametersCuentas/ns2:PD_ASSET_OPENING_DATE/ns2:ASSET_OPENING_DATE_ITEM
                
                for $i in (1 to count($assetNumber))
                return
                    if (fn:string($assetTypeOut[$i]) = "AHO") then (
                        <ns1:AssetDetails>
                            <ns1:AssetNumber>{ data($assetNumber[$i]) }</ns1:AssetNumber>
                            <ns1:AssetName>{ data($assetName[$i]) }</ns1:AssetName>
                            <ns1:Currency>{ data($assetCurrency[$i]) }</ns1:Currency>
                            <ns1:TotalBalance>{ data($assetTotalBalance[$i]) }</ns1:TotalBalance>
                            <ns1:ReserveBalance>{ data($assetReserveBalance[$i]) }</ns1:ReserveBalance>
                            <ns1:LockedBalance>{ data($assetLockedBalance[$i]) }</ns1:LockedBalance>
                            <ns1:FloatingBalance>{ data($assetVisaFloatingBalance[$i]) }</ns1:FloatingBalance>
                            <ns1:AvailableBalance>{ data($assetAvailableBalance[$i]) }</ns1:AvailableBalance>
                            <ns1:SourceBank>GT01</ns1:SourceBank>
                            <ns1:OperationType>{ data($assetProductType[$i]) }</ns1:OperationType>
                            <ns1:Status>{if (data($assetStatus[$i]) = "INACTIVE") then (data($assetBlock[$i])) else (data($assetStatus[$i]))}</ns1:Status>
                            <ns1:OpeningDate>{ data($assetOpeningDate[$i]) }</ns1:OpeningDate>
                        </ns1:AssetDetails>
                    ) else ()
            }
        </ns1:Assets>
        <ns1:Assets>
            <ns1:Type>Currents</ns1:Type>
            <ns1:Status>{ xq:mensajeRespuesta(data($getCustomerAssetsSJRSP/ns2:OutputParametersCuentas/ns2:PV_ERROR_CODE), $getCustomerAssetsSJRSP/ns2:OutputParametersCuentas/ns2:PV_ASSET_TYPE_OUT/ns2:PV_ASSET_NUMBER_ITEM[text() = 'CHQ'])  }</ns1:Status>
            {
                let $assetTypeOut := $getCustomerAssetsSJRSP/ns2:OutputParametersCuentas/ns2:PV_ASSET_TYPE_OUT/ns2:PV_ASSET_NUMBER_ITEM
            	let $assetNumber := $getCustomerAssetsSJRSP/ns2:OutputParametersCuentas/ns2:PV_ASSET_NUMBER/ns2:PV_ASSET_NUMBER_ITEM
                let $assetName := $getCustomerAssetsSJRSP/ns2:OutputParametersCuentas/ns2:PV_ASSET_NAME/ns2:PV_ASSET_NAME_ITEM
                let $assetCurrency := $getCustomerAssetsSJRSP/ns2:OutputParametersCuentas/ns2:PV_ASSET_CURRENCY/ns2:PV_ASSET_NUMBER_ITEM
                let $assetTotalBalance := $getCustomerAssetsSJRSP/ns2:OutputParametersCuentas/ns2:PV_ASSET_TOTAL_BALANCE/ns2:PV_ASSET_NUMBER_ITEM
                let $assetReserveBalance := $getCustomerAssetsSJRSP/ns2:OutputParametersCuentas/ns2:PV_ASSET_RESERVE_BALANCE/ns2:PV_ASSET_NUMBER_ITEM
                let $assetLockedBalance := $getCustomerAssetsSJRSP/ns2:OutputParametersCuentas/ns2:PV_ASSET_LOCKED_BALANCE/ns2:PV_ASSET_NUMBER_ITEM
                let $assetVisaFloatingBalance := $getCustomerAssetsSJRSP/ns2:OutputParametersCuentas/ns2:PV_ASSET_VISA_FLOATING_BALANCE/ns2:PV_ASSET_NUMBER_ITEM
                let $assetAvailableBalance := $getCustomerAssetsSJRSP/ns2:OutputParametersCuentas/ns2:PV_ASSET_AVAILABLE_BALANCE/ns2:PV_ASSET_NUMBER_ITEM
                let $assetProductType := $getCustomerAssetsSJRSP/ns2:OutputParametersCuentas/ns2:PV_ASSET_PRODUCT_TYPE/ns2:PV_ASSET_NUMBER_ITEM
                let $assetStatus := $getCustomerAssetsSJRSP/ns2:OutputParametersCuentas/ns2:PV_ASSET_STATUS/ns2:PV_ASSET_NAME_ITEM
                let $assetOpeningDate := $getCustomerAssetsSJRSP/ns2:OutputParametersCuentas/ns2:PD_ASSET_OPENING_DATE/ns2:ASSET_OPENING_DATE_ITEM
                
                for $i in (1 to count($assetNumber))
                return
                    if (fn:string($assetTypeOut[$i]) = "CHQ") then (
                        <ns1:AssetDetails>
                            <ns1:AssetNumber>{ data($assetNumber[$i]) }</ns1:AssetNumber>
                            <ns1:AssetName>{ data($assetName[$i]) }</ns1:AssetName>
                            <ns1:Currency>{ data($assetCurrency[$i]) }</ns1:Currency>
                            <ns1:TotalBalance>{ data($assetTotalBalance[$i]) }</ns1:TotalBalance>
                            <ns1:ReserveBalance>{ data($assetReserveBalance[$i]) }</ns1:ReserveBalance>
                            <ns1:LockedBalance>{ data($assetLockedBalance[$i]) }</ns1:LockedBalance>
                            <ns1:FloatingBalance>{ data($assetVisaFloatingBalance[$i]) }</ns1:FloatingBalance>
                            <ns1:AvailableBalance>{ data($assetAvailableBalance[$i]) }</ns1:AvailableBalance>
                            <ns1:SourceBank>GT01</ns1:SourceBank>
                            <ns1:OperationType>{ data($assetProductType[$i]) }</ns1:OperationType>
                            <ns1:Status>{ data($assetStatus[$i])}</ns1:Status>
                            <ns1:OpeningDate>{ data($assetOpeningDate[$i]) }</ns1:OpeningDate>
                        </ns1:AssetDetails>
                    ) else ()
            }
        </ns1:Assets>
        <ns1:Assets>
            <ns1:Type>TermDeposits</ns1:Type>
            <ns1:Status>{ xq:mensajeRespuesta(data($getCustomerAssetsSJRSP/ns2:OutputParametersDepositos/ns2:PV_ERROR_CODE), $getCustomerAssetsSJRSP/ns2:OutputParametersDepositos/ns2:PV_ASSET_NUMBER/ns2:PV_ASSET_NUMBER_ITEM)  }</ns1:Status>
            {
                let $assetTypeOut := $getCustomerAssetsSJRSP/ns2:OutputParametersDepositos/ns2:PV_ASSET_TYPE_OUT/ns2:PV_ASSET_NUMBER_ITEM
            	let $assetNumber := $getCustomerAssetsSJRSP/ns2:OutputParametersDepositos/ns2:PV_ASSET_NUMBER/ns2:PV_ASSET_NUMBER_ITEM
                let $assetName := $getCustomerAssetsSJRSP/ns2:OutputParametersDepositos/ns2:PV_ASSET_NAME/ns2:PV_ASSET_NAME_ITEM
                let $assetCurrency := $getCustomerAssetsSJRSP/ns2:OutputParametersDepositos/ns2:PV_ASSET_CURRENCY/ns2:PV_ASSET_NUMBER_ITEM
                let $assetTotalBalance := $getCustomerAssetsSJRSP/ns2:OutputParametersDepositos/ns2:PV_ASSET_TOTAL_BALANCE/ns2:PV_ASSET_NUMBER_ITEM
                let $assetReserveBalance := $getCustomerAssetsSJRSP/ns2:OutputParametersDepositos/ns2:PV_ASSET_RESERVE_BALANCE/ns2:PV_ASSET_NUMBER_ITEM
                let $assetLockedBalance := $getCustomerAssetsSJRSP/ns2:OutputParametersDepositos/ns2:PV_ASSET_LOCKED_BALANCE/ns2:PV_ASSET_NUMBER_ITEM
                let $assetVisaFloatingBalance := $getCustomerAssetsSJRSP/ns2:OutputParametersDepositos/ns2:PV_ASSET_VISA_FLOATING_BALANCE/ns2:PV_ASSET_NUMBER_ITEM
                let $assetAvailableBalance := $getCustomerAssetsSJRSP/ns2:OutputParametersDepositos/ns2:PV_ASSET_AVAILABLE_BALANCE/ns2:PV_ASSET_NUMBER_ITEM
                let $assetOpeningDate := $getCustomerAssetsSJRSP/ns2:OutputParametersDepositos/ns2:PD_ASSET_OPENING_DATE/ns2:ASSET_OPENING_DATE_ITEM
                
                for $i in (1 to count($assetNumber))
                return
                    <ns1:AssetDetails>
                        <ns1:AssetNumber>{ data($assetNumber[$i]) }</ns1:AssetNumber>
                        <ns1:AssetName>{ data($assetName[$i]) }</ns1:AssetName>
                        <ns1:Currency>{ data($assetCurrency[$i]) }</ns1:Currency>
                        <ns1:TotalBalance>{ data($assetTotalBalance[$i]) }</ns1:TotalBalance>
                        <ns1:ReserveBalance>{ data($assetReserveBalance[$i]) }</ns1:ReserveBalance>
                        <ns1:LockedBalance>{ data($assetLockedBalance[$i]) }</ns1:LockedBalance>
                        <ns1:FloatingBalance>{ data($assetVisaFloatingBalance[$i]) }</ns1:FloatingBalance>
                        <ns1:AvailableBalance>{ data($assetAvailableBalance[$i]) }</ns1:AvailableBalance>
                        <ns1:SourceBank>GT01</ns1:SourceBank>
                        <ns1:Status>ACTIVE</ns1:Status>
                        <ns1:OpeningDate>{ data($assetOpeningDate[$i]) }</ns1:OpeningDate>
                    </ns1:AssetDetails>
            }
        </ns1:Assets>
    </ns1:getCustomerAssetsResponse>
};

ns3:getCustomerAssetsSJToCustomerAssetsOut($uuid, $getCustomerAssetsSJRSP)