xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetCustomerAssetsNI_BS";
(:: import schema at "../../../../ProviderServices/XSD/GetCustomerAssets/GetCustomerAssetsNI_BS_sp.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare variable $customerId as xs:integer external;
declare variable $userId as xs:string external;
declare variable $assetType as xs:string external;

declare function xq:Tx-GetCustomerAssets_To_Cobis($customerId as xs:integer, 
                                                  $userId as xs:string,
                                                  $assetType as xs:string) 
                                                  as element() (:: schema-element(ns1:InputParameters) ::) {
    <ns1:InputParameters>
        <ns1:i_CUSTOMER_ID>{fn:data($customerId)}</ns1:i_CUSTOMER_ID>
         {
         if (fn:data($assetType) = 'Savings') 
         then <ns1:i_ASSET_TYPE>AHO</ns1:i_ASSET_TYPE>
         else (if (fn:data($assetType) = 'Currents') 
         then <ns1:i_ASSET_TYPE>CHQ</ns1:i_ASSET_TYPE>
         else (if (fn:data($assetType) = 'TermDeposits') 
         then <ns1:i_ASSET_TYPE>DEP</ns1:i_ASSET_TYPE>
         else (if (fn:data($assetType) = 'PensionFunds') 
         then <ns1:i_ASSET_TYPE>DEP</ns1:i_ASSET_TYPE>
         else <ns1:i_ASSET_TYPE>ALL</ns1:i_ASSET_TYPE> )))

}
               <ns1:i_userId>{fn:data($userId)}</ns1:i_userId>
    </ns1:InputParameters>
};

xq:Tx-GetCustomerAssets_To_Cobis($customerId, $userId, $assetType)