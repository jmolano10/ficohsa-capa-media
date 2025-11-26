xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetAccountDetails_BS";
(:: import schema at "../../../../ProviderServices/XSD/GetAccountDetails/GetAccountDetails_BS_sp.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare variable $accountNumber as xs:string external;

declare function xq:Tx_GetAccountDetail_To_Abanks($accountNumber as xs:string) as element() (:: schema-element(ns1:InputParameters) ::) {
    <ns1:InputParameters>
        <ns1:ACCOUNT_NUMBER>{fn:data($accountNumber)}</ns1:ACCOUNT_NUMBER>
    </ns1:InputParameters>
};

xq:Tx_GetAccountDetail_To_Abanks($accountNumber)
