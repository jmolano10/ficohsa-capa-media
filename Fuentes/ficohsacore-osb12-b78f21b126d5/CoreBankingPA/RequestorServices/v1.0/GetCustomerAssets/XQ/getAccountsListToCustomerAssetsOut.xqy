xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns3="http://www.ficohsa.com.hn/middleware.services/consultaClientes";
(:: import schema at "../../../../../MWBanking/Customers/RequestorServices/XSD/getCustomerAssets.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaListaCuentas";
(:: import schema at "../../../../ProviderServices/XSD/GetAccountsList/GetAccountsList_sp.xsd" ::)

declare namespace ns1="http://www.ficohsa.com/midleware.services/getAccountsListToCustomerAssetsOut";
declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $getAccountsListRSP as element() (:: schema-element(ns2:OutputParameters) ::) external;
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

declare function xq:capitalizeFirst($arg as xs:string) as xs:string {
    concat(upper-case(substring($arg,1,1)), substring($arg,2))
};

declare function ns1:getAccountsListToCustomerAssetsOut($uuid as xs:string, $getAccountsListRSP as element() (:: schema-element(ns2:OutputParameters) ::)) as element() (:: schema-element(ns3:getCustomerAssetsResponse) ::) {
    <ns3:getCustomerAssetsResponse>
        <ns3:StatusInfo>
            <com:Status>Success</com:Status>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </ns3:StatusInfo>
        {
            if (fn:string($getAccountsListRSP/ns2:PV_ASSET_TYPE) = "AHO") then (
                let $assetNumber := $getAccountsListRSP/ns2:PV_ASSET_NUMBER/ns2:PV_ASSET_NUMBER_ITEM
                let $assetName := $getAccountsListRSP/ns2:PV_ASSET_NAME/ns2:PV_ASSET_NAME_ITEM
                let $assetCurrency := $getAccountsListRSP/ns2:PV_ASSET_CURRENCY/ns2:PV_ASSET_NUMBER_ITEM
                let $assetTotalBalance := $getAccountsListRSP/ns2:PV_ASSET_TOTAL_BALANCE/ns2:PV_ASSET_NUMBER_ITEM
                let $assetReserveBalance := $getAccountsListRSP/ns2:PV_ASSET_RESERVE_BALANCE/ns2:PV_ASSET_NUMBER_ITEM
                let $assetLockedBalance := $getAccountsListRSP/ns2:PV_ASSET_LOCKED_BALANCE/ns2:PV_ASSET_NUMBER_ITEM
                let $assetVisaFloatingBalance := $getAccountsListRSP/ns2:PV_ASSET_VISA_FLOATING_BALANCE/ns2:PV_ASSET_NUMBER_ITEM
                let $assetAvailableBalance := $getAccountsListRSP/ns2:PV_ASSET_AVAILABLE_BALANCE/ns2:PV_ASSET_NUMBER_ITEM
                let $assetProductType := $getAccountsListRSP/ns2:PV_ASSET_PRODUCT_TYPE/ns2:PV_ASSET_NAME_ITEM
                
                return
                  <ns3:Assets>
                      <ns3:Type>Savings</ns3:Type>
                      <ns3:Status>{ xq:mensajeRespuesta(data($getAccountsListRSP/ns2:PV_ERROR_CODE), $getAccountsListRSP/ns2:PV_ASSET_TYPE[text() = 'AHO']) }</ns3:Status>
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
                                  <ns3:OperationType>{ xq:capitalizeFirst(fn:lower-case(data($assetProductType[$i]))) }</ns3:OperationType>
                              </ns3:AssetDetails>
                      }
                  </ns3:Assets>
            ) else ( if (fn:string($getAccountsListRSP/ns2:PV_ASSET_TYPE) = "CHQ") then (
                let $assetNumber := $getAccountsListRSP/ns2:PV_ASSET_NUMBER/ns2:PV_ASSET_NUMBER_ITEM
                let $assetName := $getAccountsListRSP/ns2:PV_ASSET_NAME/ns2:PV_ASSET_NAME_ITEM
                let $assetCurrency := $getAccountsListRSP/ns2:PV_ASSET_CURRENCY/ns2:PV_ASSET_NUMBER_ITEM
                let $assetTotalBalance := $getAccountsListRSP/ns2:PV_ASSET_TOTAL_BALANCE/ns2:PV_ASSET_NUMBER_ITEM
                let $assetReserveBalance := $getAccountsListRSP/ns2:PV_ASSET_RESERVE_BALANCE/ns2:PV_ASSET_NUMBER_ITEM
                let $assetLockedBalance := $getAccountsListRSP/ns2:PV_ASSET_LOCKED_BALANCE/ns2:PV_ASSET_NUMBER_ITEM
                let $assetVisaFloatingBalance := $getAccountsListRSP/ns2:PV_ASSET_VISA_FLOATING_BALANCE/ns2:PV_ASSET_NUMBER_ITEM
                let $assetAvailableBalance := $getAccountsListRSP/ns2:PV_ASSET_AVAILABLE_BALANCE/ns2:PV_ASSET_NUMBER_ITEM
                let $assetProductType := $getAccountsListRSP/ns2:PV_ASSET_PRODUCT_TYPE/ns2:PV_ASSET_NAME_ITEM
                
                return
                  <ns3:Assets>
                      <ns3:Type>Currents</ns3:Type>
                      <ns3:Status>{ xq:mensajeRespuesta(data($getAccountsListRSP/ns2:PV_ERROR_CODE), $getAccountsListRSP/ns2:PV_ASSET_TYPE[text() = 'CHQ']) }</ns3:Status>
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
                                  <ns3:OperationType>{ xq:capitalizeFirst(fn:lower-case(data($assetProductType[$i]))) }</ns3:OperationType>
                              </ns3:AssetDetails>
                      }
                  </ns3:Assets>
            ) else ( if (fn:string($getAccountsListRSP/ns2:PV_ASSET_TYPE) = "CTA") then (
                  <ns3:Assets>
                      <ns3:Type>Savings</ns3:Type>
                      <ns3:Status>{ xq:mensajeRespuesta(data($getAccountsListRSP/ns2:PV_ERROR_CODE), $getAccountsListRSP/ns2:PV_ASSET_TYPE_OUT/ns2:PV_ASSET_NUMBER_ITEM[text() = 'AHO']) }</ns3:Status>
                      {
                          let $assetTypeOut := $getAccountsListRSP/ns2:PV_ASSET_TYPE_OUT/ns2:PV_ASSET_NUMBER_ITEM
                          let $assetNumber := $getAccountsListRSP/ns2:PV_ASSET_NUMBER/ns2:PV_ASSET_NUMBER_ITEM
                          let $assetName := $getAccountsListRSP/ns2:PV_ASSET_NAME/ns2:PV_ASSET_NAME_ITEM
                          let $assetCurrency := $getAccountsListRSP/ns2:PV_ASSET_CURRENCY/ns2:PV_ASSET_NUMBER_ITEM
                          let $assetTotalBalance := $getAccountsListRSP/ns2:PV_ASSET_TOTAL_BALANCE/ns2:PV_ASSET_NUMBER_ITEM
                          let $assetReserveBalance := $getAccountsListRSP/ns2:PV_ASSET_RESERVE_BALANCE/ns2:PV_ASSET_NUMBER_ITEM
                          let $assetLockedBalance := $getAccountsListRSP/ns2:PV_ASSET_LOCKED_BALANCE/ns2:PV_ASSET_NUMBER_ITEM
                          let $assetVisaFloatingBalance := $getAccountsListRSP/ns2:PV_ASSET_VISA_FLOATING_BALANCE/ns2:PV_ASSET_NUMBER_ITEM
                          let $assetAvailableBalance := $getAccountsListRSP/ns2:PV_ASSET_AVAILABLE_BALANCE/ns2:PV_ASSET_NUMBER_ITEM
                          let $assetProductType := $getAccountsListRSP/ns2:PV_ASSET_PRODUCT_TYPE/ns2:PV_ASSET_NAME_ITEM
                          
                          return
                          for $i in (1 to count($assetNumber))
                              return
                                if(fn:string($assetTypeOut[$i]) = "AHO") then (
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
                                      <ns3:OperationType>{ xq:capitalizeFirst(fn:lower-case(data($assetProductType[$i]))) }</ns3:OperationType>
                                  </ns3:AssetDetails>
                                ) else ( )
                      }
                  </ns3:Assets>
            ) else ( )))
        }
        {
            if (fn:string($getAccountsListRSP/ns2:PV_ASSET_TYPE) = "CTA") then (
                  <ns3:Assets>
                      <ns3:Type>Currents</ns3:Type>
                      <ns3:Status>{ xq:mensajeRespuesta(data($getAccountsListRSP/ns2:PV_ERROR_CODE), $getAccountsListRSP/ns2:PV_ASSET_TYPE_OUT/ns2:PV_ASSET_NUMBER_ITEM[text() = 'CHQ']) }</ns3:Status>
                      {
                          let $assetTypeOut := $getAccountsListRSP/ns2:PV_ASSET_TYPE_OUT/ns2:PV_ASSET_NUMBER_ITEM
                          let $assetNumber := $getAccountsListRSP/ns2:PV_ASSET_NUMBER/ns2:PV_ASSET_NUMBER_ITEM
                          let $assetName := $getAccountsListRSP/ns2:PV_ASSET_NAME/ns2:PV_ASSET_NAME_ITEM
                          let $assetCurrency := $getAccountsListRSP/ns2:PV_ASSET_CURRENCY/ns2:PV_ASSET_NUMBER_ITEM
                          let $assetTotalBalance := $getAccountsListRSP/ns2:PV_ASSET_TOTAL_BALANCE/ns2:PV_ASSET_NUMBER_ITEM
                          let $assetReserveBalance := $getAccountsListRSP/ns2:PV_ASSET_RESERVE_BALANCE/ns2:PV_ASSET_NUMBER_ITEM
                          let $assetLockedBalance := $getAccountsListRSP/ns2:PV_ASSET_LOCKED_BALANCE/ns2:PV_ASSET_NUMBER_ITEM
                          let $assetVisaFloatingBalance := $getAccountsListRSP/ns2:PV_ASSET_VISA_FLOATING_BALANCE/ns2:PV_ASSET_NUMBER_ITEM
                          let $assetAvailableBalance := $getAccountsListRSP/ns2:PV_ASSET_AVAILABLE_BALANCE/ns2:PV_ASSET_NUMBER_ITEM
                          let $assetProductType := $getAccountsListRSP/ns2:PV_ASSET_PRODUCT_TYPE/ns2:PV_ASSET_NAME_ITEM
                          
                          return
                          for $i in (1 to count($assetNumber))
                              return
                                if(fn:string($assetTypeOut[$i]) = "CHQ") then (
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
                                      <ns3:OperationType>{ xq:capitalizeFirst(fn:lower-case(data($assetProductType[$i]))) }</ns3:OperationType>
                                  </ns3:AssetDetails>
                                ) else ( )
                      }
                  </ns3:Assets>
            ) else ( )
        }
    </ns3:getCustomerAssetsResponse>
};

ns1:getAccountsListToCustomerAssetsOut($uuid, $getAccountsListRSP)