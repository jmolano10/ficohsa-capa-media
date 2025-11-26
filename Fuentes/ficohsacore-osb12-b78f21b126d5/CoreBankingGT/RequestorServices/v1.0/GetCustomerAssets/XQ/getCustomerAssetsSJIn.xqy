xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaActivosCliente";
(:: import schema at "../XSD/GetCustomerAssetsGT_SJ.xsd" ::)

declare namespace ns2="http://www.ficohsa.com/midleware.services/getCustomerAssetsSJIn";

declare variable $customerId as xs:string external;
declare variable $assetType as xs:string external;
declare variable $uuid as xs:string external;
declare variable $sourceBank as xs:string external;
declare variable $destinationBank as xs:string external;
declare variable $user as xs:string external;

declare function ns2:getCustomerAssetsSJIn($uuid as xs:string, 
                                           $sourceBank as xs:string, 
                                           $destinationBank as xs:string, 
                                           $user as xs:string, 
                                           $customerId as xs:string, 
                                           $assetType as xs:string) 
                                           as element() (:: schema-element(ns1:InputParameters) ::) {
    <ns1:InputParameters>
        <ns1:PV_CUSTOMER_ID>{fn:data($customerId)}</ns1:PV_CUSTOMER_ID>
        <ns1:PV_ASSET_TYPE>ALL</ns1:PV_ASSET_TYPE>
        <ns1:UUID>{fn:data($uuid)}</ns1:UUID>
        <ns1:SOURCE_BANK>{fn:data($sourceBank)}</ns1:SOURCE_BANK>
        <ns1:DESTINATION_BANK>{fn:data($destinationBank)}</ns1:DESTINATION_BANK>
        <ns1:USER>{fn:data($user)}</ns1:USER>
    </ns1:InputParameters>
};

ns2:getCustomerAssetsSJIn($uuid, $sourceBank, $destinationBank, $user, $customerId, $assetType)
