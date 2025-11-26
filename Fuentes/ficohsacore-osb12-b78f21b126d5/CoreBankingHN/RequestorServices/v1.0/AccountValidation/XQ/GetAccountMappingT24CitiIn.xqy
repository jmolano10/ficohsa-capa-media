xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetAccountMappingT24Citi";
(:: import schema at "../../../../ProviderServices/XSD/GetAccountMappingT24Citi/GetAccountMappingT24Citi_sp.xsd" ::)

declare variable $accountNumber as xs:string external;

declare function local:func($accountNumber as xs:string) as element() (:: schema-element(ns1:InputParameters) ::) {
    <ns1:InputParameters>
        <ns1:NUMERO_CUENTA_P>{fn:data($accountNumber)}</ns1:NUMERO_CUENTA_P>
    </ns1:InputParameters>
};

local:func($accountNumber)