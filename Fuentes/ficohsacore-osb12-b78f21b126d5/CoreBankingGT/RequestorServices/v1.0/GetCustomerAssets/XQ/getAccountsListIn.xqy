xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetAccountsList_BS";
(:: import schema at "../../../../ProviderServices/XSD/GetAccountsList/GetAccountsList_sp.xsd" ::)

declare namespace ns2="http://www.ficohsa.com/midleware.services/getAccountsListIn";
declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare variable $customerId as xs:string external;
declare variable $assetType as xs:string external;

(: Función encargada de traducir el Asset Type:)
declare function xq:getUsername ($asset as xs:string)  as xs:string { 
	if ($asset = 'Savings') then
              'AHO'
        else if ($asset = 'Currents') then
              'CHQ'
        else if ($asset = 'Accounts') then
              'CTA'
        else 
              'ALL'
 };

declare function ns2:getAccountsListIn($customerId as xs:string, 
                                       $assetType as xs:string) 
                                       as element() (:: schema-element(ns1:InputParameters) ::) {
    <ns1:InputParameters>
        <ns1:PV_CUSTOMER_ID>{fn:data($customerId)}</ns1:PV_CUSTOMER_ID>
        <ns1:PV_ASSET_TYPE>{xq:getUsername(fn:data($assetType))}</ns1:PV_ASSET_TYPE>
    </ns1:InputParameters>
};

ns2:getAccountsListIn($customerId, $assetType)