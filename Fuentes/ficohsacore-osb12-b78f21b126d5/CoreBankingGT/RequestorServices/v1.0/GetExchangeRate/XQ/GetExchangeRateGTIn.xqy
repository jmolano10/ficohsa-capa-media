xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/getExchangeRateTypes";
(:: import schema at "../../../../../MWBanking/ConsumerService/XSD/getExchangeRateTypes.xsd" ::)
declare namespace ns2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetExchangeRate";
(:: import schema at "../../../../ProviderServices/XSD/GetExchangeRate/GetExchangeRateGT_BS_sp.xsd" ::)

declare variable $GetExchangeRateRequest as element() (:: schema-element(ns1:getExchangeRateRequest) ::) external;
declare variable $usuarioCanal as xs:string external;

declare function local:func($GetExchangeRateRequest as element() (:: schema-element(ns1:getExchangeRateRequest) ::),
         $usuarioCanal as xs:string) as element() (:: schema-element(ns2:InputParameters) ::) {
    <ns2:InputParameters>
        <ns2:FROM_CURRENCY>{fn:data($GetExchangeRateRequest/ns1:SourceCurrency)}</ns2:FROM_CURRENCY>
        <ns2:TO_CURRENCY>{fn:data($GetExchangeRateRequest/ns1:TargetCurrency)}</ns2:TO_CURRENCY>
        <ns2:EXCHANGE_TYPE></ns2:EXCHANGE_TYPE>
        <ns2:EXCHANGE_DATE></ns2:EXCHANGE_DATE>
        <ns2:USER_NAME>{fn:data($usuarioCanal)}</ns2:USER_NAME>
    </ns2:InputParameters>
};

local:func($GetExchangeRateRequest, $usuarioCanal)