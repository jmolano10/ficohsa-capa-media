xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetCustomerRisk_BS";
(:: import schema at "../../../../../ProviderServices/XSD/GetCustomerRisk/v1.0/GetCustomerRisk_BS_sp.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare variable $legalId as xs:string external;

declare function xq:Tx_GetConsolidatedCustomerRisk_To_consulta_ONBASE_V2($legalId as xs:string) as element() (:: schema-element(ns1:InputParameters) ::) {
    <ns1:InputParameters>
        <ns1:IDENTIDAD>{fn:data($legalId)}</ns1:IDENTIDAD>
    </ns1:InputParameters>
};

xq:Tx_GetConsolidatedCustomerRisk_To_consulta_ONBASE_V2($legalId)
