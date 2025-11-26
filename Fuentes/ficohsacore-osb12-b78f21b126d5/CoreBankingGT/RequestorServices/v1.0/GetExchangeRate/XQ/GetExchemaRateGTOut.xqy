xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/getExchangeRateTypes";
(:: import schema at "../../../../../MWBanking/ConsumerService/XSD/getExchangeRateTypes.xsd" ::)
declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetExchangeRate";
(:: import schema at "../../../../ProviderServices/XSD/GetExchangeRate/GetExchangeRateGT_BS_sp.xsd" ::)
declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $GetExchangeRateOut as element() (:: schema-element(ns1:OutputParameters) ::) external;
declare variable $uuid as xs:string external;

declare function local:func($GetExchangeRateOut as element() (:: schema-element(ns1:OutputParameters) ::),
                            $uuid as xs:string) as element() (:: schema-element(ns2:getExchangeRateResponse) ::) {
    <ns2:getExchangeRateResponse>
      <ns2:StatusInfo>
            <com:Status>Success</com:Status>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{$uuid}</com:GlobalId>
        </ns2:StatusInfo>
        <ns2:getExchangeRateResponseType>
            <ns2:getExchangeRateRecordType>
                {
                    if ($GetExchangeRateOut/ns1:BUY_RATE)
                    then <ns2:BuyRate>{fn:data($GetExchangeRateOut/ns1:BUY_RATE)}</ns2:BuyRate>
                    else ()
                }
                {
                    if ($GetExchangeRateOut/ns1:SELL_RATE)
                    then <ns2:SellRate>{fn:data($GetExchangeRateOut/ns1:SELL_RATE)}</ns2:SellRate>
                    else ()
                }
            </ns2:getExchangeRateRecordType>
        </ns2:getExchangeRateResponseType>
    </ns2:getExchangeRateResponse>
};

local:func($GetExchangeRateOut, $uuid)