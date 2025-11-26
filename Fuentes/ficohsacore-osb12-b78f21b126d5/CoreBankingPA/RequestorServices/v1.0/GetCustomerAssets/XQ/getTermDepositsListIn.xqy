xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaListaDepositosCliente";
(:: import schema at "../../../../ProviderServices/XSD/GetTermDepositsList/GetTermDepositsList_sp.xsd" ::)

declare namespace ns1="http://www.ficohsa.com/midleware.services/getTermDepositsListIn";

declare variable $customerId as xs:string external;
declare variable $assetType as xs:string external;

declare function ns1:getTermDepositsListIn($customerId as xs:string, 
                                           $assetType as xs:string) 
                                           as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        <ns2:CUSTOMER_ID>{fn:data($customerId)}</ns2:CUSTOMER_ID>
        <ns2:ASSET_TYPE>DEP</ns2:ASSET_TYPE>
    </ns2:InputParameters>
};

ns1:getTermDepositsListIn($customerId, $assetType)