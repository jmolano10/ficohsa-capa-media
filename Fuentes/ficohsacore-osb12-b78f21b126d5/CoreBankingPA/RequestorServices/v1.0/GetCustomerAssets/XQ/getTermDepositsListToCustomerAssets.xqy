xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns3="http://www.ficohsa.com.hn/middleware.services/consultaClientes";
(:: import schema at "../../../../../MWBanking/Customers/RequestorServices/XSD/getCustomerAssets.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaListaDepositosCliente";
(:: import schema at "../../../../ProviderServices/XSD/GetTermDepositsList/GetTermDepositsList_sp.xsd" ::)

declare namespace ns1="http://www.ficohsa.com/midleware.services/getTermDepositsListToCustomerAssets";
declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $getTermDepositsListRSP as element() (:: schema-element(ns2:OutputParameters) ::) external;
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

declare function ns1:getTermDepositsListToCustomerAssets($uuid as xs:string, $getTermDepositsListRSP as element() (:: schema-element(ns2:OutputParameters) ::)) as element() (:: schema-element(ns3:getCustomerAssetsResponse) ::) {
    <ns3:getCustomerAssetsResponse>
        <ns3:StatusInfo>
            <com:Status>Success</com:Status>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </ns3:StatusInfo>
        {
            let $assetType := $getTermDepositsListRSP/ns2:ASSET_TYPE
            let $assetNumber := $getTermDepositsListRSP/ns2:ASSET_NUMBER/ns2:ASSET_NUMBER_ITEM
            let $assetName := $getTermDepositsListRSP/ns2:ASSET_NAME/ns2:ASSET_NAME_ITEM
            let $assetCurrency := $getTermDepositsListRSP/ns2:ASSET_CURRENCY/ns2:ASSET_NUMBER_ITEM
            let $assetTotalBalance := $getTermDepositsListRSP/ns2:ASSET_TOTAL_BALANCE/ns2:ASSET_NUMBER_ITEM
            let $assetReserveBalance := $getTermDepositsListRSP/ns2:ASSET_RESERVE_BALANCE/ns2:ASSET_NUMBER_ITEM
            let $assetLockedBalance := $getTermDepositsListRSP/ns2:ASSET_LOCKED_BALANCE/ns2:ASSET_NUMBER_ITEM
            let $assetVisaFloatingBalance := $getTermDepositsListRSP/ns2:ASSET_VISA_FLOATING_BALANCE/ns2:ASSET_NUMBER_ITEM
            let $assetAvailableBalance := $getTermDepositsListRSP/ns2:ASSET_AVAILABLE_BALANCE/ns2:ASSET_NUMBER_ITEM
            return 
                <ns3:Assets>
                    <ns3:Type>TermDeposits</ns3:Type>
                    <ns3:Status>{ xq:mensajeRespuesta(data($getTermDepositsListRSP/ns2:ERROR_CODE), $getTermDepositsListRSP/ns2:ASSET_TYPE[text() = 'DEP']) }</ns3:Status>
                    {    
                        for $i in (1 to count($assetNumber))
                        return
                            <ns3:AssetDetails>
                                <ns3:AssetNumber>{ data($assetNumber[$i]) }</ns3:AssetNumber>
                                <ns3:AssetName>{ data($assetName[$i]) }</ns3:AssetName>
                                <ns3:Currency>{ data($assetCurrency[$i]) }</ns3:Currency>
                                <ns3:TotalBalance>{ data($assetTotalBalance[$i]) }</ns3:TotalBalance>
                                <ns3:ReserveBalance>{ data($assetReserveBalance[$i]) }</ns3:ReserveBalance>
                                <ns3:LockedBalance>{ data($assetLockedBalance[$i]) }</ns3:LockedBalance>
                                <ns3:FloatingBalance>{ data($assetVisaFloatingBalance[$i]) }</ns3:FloatingBalance>
                                <ns3:AvailableBalance>{ data($assetAvailableBalance[$i]) }</ns3:AvailableBalance>
                                <ns3:SourceBank>PA01</ns3:SourceBank>
                            </ns3:AssetDetails>
                    }
                </ns3:Assets>
       } 
    </ns3:getCustomerAssetsResponse>
};

ns1:getTermDepositsListToCustomerAssets($uuid, $getTermDepositsListRSP)