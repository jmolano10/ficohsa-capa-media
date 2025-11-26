xquery version "1.0" encoding "utf-8";
  
  (:: OracleAnnotationVersion "1.0" ::)
  
  declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/consultaClientes";
  (:: import schema at "../../../../../MWBanking/Customers/RequestorServices/XSD/getCustomerAssets.xsd" ::)
  declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetCustomerAssetsNI_BS";
  (:: import schema at "../../../../ProviderServices/XSD/GetCustomerAssets/GetCustomerAssetsNI_BS_sp.xsd" ::)
  
  declare namespace xq="http://www.w3.org/2005/xquery-local-functions";
  
  declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";
  
  declare variable $outputParameters as element() (:: schema-element(ns1:OutputParameters) ::) external;
  declare variable $uuid as xs:string external;
  
  declare function local:createAssetsWithDetails($Type as xs:string, $Rows as element()*) as element(ns2:Assets) {
      <ns2:Assets>
        <ns2:Type>{ $Type }</ns2:Type>
        <ns2:Status>Success</ns2:Status>
        {
          for $Row in $Rows
          return
              <ns2:AssetDetails>
                    <ns2:AssetNumber>{fn:data($Row/ns1:Column[@name='ASSET_NUMBER'])}</ns2:AssetNumber>
                    <ns2:AssetName>{fn:data($Row/ns1:Column[@name='ASSET_NAME'])}</ns2:AssetName>
                    <ns2:Currency>{fn:data($Row/ns1:Column[@name='ASSET_CURRENCY'])}</ns2:Currency>
                    <ns2:TotalBalance>{ fn-bea:format-number((xs:decimal(fn:data($Row/ns1:Column[@name='ASSET_TOTAL_BALANCE']))),'0.00') }</ns2:TotalBalance>
                    <ns2:ReserveBalance>{ fn-bea:format-number((xs:decimal(fn:data($Row/ns1:Column[@name='ASSET_RESERVE_BALANCE']))),'0.00') }</ns2:ReserveBalance>
                    <ns2:LockedBalance>{ fn-bea:format-number((xs:decimal(fn:data($Row/ns1:Column[@name='ASSET_LOCKED_BALANCE']))),'0.00') }</ns2:LockedBalance>
                    <ns2:FloatingBalance>{ fn-bea:format-number((xs:decimal(fn:data($Row/ns1:Column[@name='ASSET_VISA_FLOATING_BALANCE']))),'0.00') }</ns2:FloatingBalance>
                    <ns2:AvailableBalance>{ fn-bea:format-number((xs:decimal(fn:data($Row/ns1:Column[@name='ASSET_AVAILABLE_BALANCE']))),'0.00') }</ns2:AvailableBalance>
                    <ns2:SourceBank>NI01</ns2:SourceBank>
                    {
                        if ($Type = "Savings") then
                        <ns2:Status>ACTIVE</ns2:Status>
                        else ()                        
                    }
              </ns2:AssetDetails>
          }
      </ns2:Assets>
};
  
  declare function xq:Tx_Cobis_To_GetCustomerAssets($outputParameters as element() (:: schema-element(ns1:OutputParameters) ::), 
                                                    $uuid as xs:string) 
                                                    as element() (:: schema-element(ns2:getCustomerAssetsResponse) ::) {
      <ns2:getCustomerAssetsResponse>
          <ns2:StatusInfo>
              <com:Status>Success</com:Status>
              <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
              <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
              <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
          </ns2:StatusInfo>
          {
              let $Rows := $outputParameters/ns1:RowSet/ns1:Row[ns1:Column[@name = 'ASSET_TYPE'] != 'PFI' and ns1:Column[@name = 'ASSET_TYPE'] != 'CTE' and ns1:Column[@name = 'ASSET_TYPE'] != 'AHO']
              return
              if (fn:count($Rows) > 0) then local:createAssetsWithDetails("NA", $Rows)
              else ()
          }
          {
              let $Rows := $outputParameters/ns1:RowSet/ns1:Row[ns1:Column[@name = 'ASSET_TYPE'] = 'PFI']
              return 
              if (fn:count($Rows) > 0) then local:createAssetsWithDetails("TermDeposits", $Rows)
              else ()
          }
          {
              let $Rows := $outputParameters/ns1:RowSet/ns1:Row[ns1:Column[@name = 'ASSET_TYPE'] = 'CTE']
              return 
              if (fn:count($Rows) > 0) then local:createAssetsWithDetails("Currents", $Rows)
              else ()
          }
          {
              let $Rows := $outputParameters/ns1:RowSet/ns1:Row[ns1:Column[@name = 'ASSET_TYPE'] = 'AHO']
              return 
              if (fn:count($Rows) > 0) then local:createAssetsWithDetails("Savings", $Rows)
              else ()
          }
      </ns2:getCustomerAssetsResponse>
  };
  
  xq:Tx_Cobis_To_GetCustomerAssets($outputParameters, $uuid)