xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/CoreBS/XMLSchema_1628019553.xsd" ::)
declare namespace ns2="http://www.ficohsa.com.hn/getExchangeRateTypes";
(:: import schema at "../../../../../MWBanking/ConsumerService/XSD/getExchangeRateTypes.xsd" ::)

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $CoreBSReponse as element() (:: schema-element(ns1:ConsultadetasadecambiofcyResponse) ::) external;
declare variable $uuid as xs:string external;
declare variable $source as xs:string external;
declare variable $target as xs:string external;

declare function local:func($CoreBSReponse as element() (:: schema-element(ns1:ConsultadetasadecambiofcyResponse) ::), 
                            $uuid as xs:string, 
                            $source as xs:string, 
                            $target as xs:string) 
                            as element() (:: schema-element(ns2:getExchangeRateResponse) ::) {
    <ns2:getExchangeRateResponse>
        <ns2:StatusInfo>
            <com:Status>Success</com:Status>    
            {
                if ($CoreBSReponse/Status/transactionId)
                then <com:TransactionId>{fn:data($CoreBSReponse/Status/transactionId)}</com:TransactionId>
                else ()
            }
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{$uuid}</com:GlobalId>
        </ns2:StatusInfo>
        <ns2:getExchangeRateResponseType>
            <ns2:getExchangeRateRecordType>
            {
                if($source = "USD" and $target = "USD")then(
                  <ns2:BuyRate>1</ns2:BuyRate>,
                  <ns2:SellRate>1</ns2:SellRate>
                )else if($source = "USD" )then(
                  let $targets := fn:tokenize($CoreBSReponse/WSFCYEXCHRATEType[1]/gWSFCYEXCHRATEDetailType/mWSFCYEXCHRATEDetailType[1]/CURRENCY, "\|\|")
                  let $buys := fn:tokenize($CoreBSReponse/WSFCYEXCHRATEType[1]/gWSFCYEXCHRATEDetailType/mWSFCYEXCHRATEDetailType[1]/USDBUYRATE, "\|\|")
                  let $sells := fn:tokenize($CoreBSReponse/WSFCYEXCHRATEType[1]/gWSFCYEXCHRATEDetailType/mWSFCYEXCHRATEDetailType[1]/USDSALERATE, "\|\|")
                    for $item at $i in $targets
                    return
                      if ($item = $target) then (
		        <ns2:BuyRate>{ $buys[$i] }</ns2:BuyRate>,
                        <ns2:SellRate>{ $sells[$i] }</ns2:SellRate>					
                      ) else ()
                )else if($target = "USD")then(
                  let $sources := fn:tokenize($CoreBSReponse/WSFCYEXCHRATEType[1]/gWSFCYEXCHRATEDetailType/mWSFCYEXCHRATEDetailType[1]/CURRENCY, "\|\|")
                  let $buys := fn:tokenize($CoreBSReponse/WSFCYEXCHRATEType[1]/gWSFCYEXCHRATEDetailType/mWSFCYEXCHRATEDetailType[1]/USDBUYRATE, "\|\|")
                  let $sells := fn:tokenize($CoreBSReponse/WSFCYEXCHRATEType[1]/gWSFCYEXCHRATEDetailType/mWSFCYEXCHRATEDetailType[1]/USDSALERATE, "\|\|")
                    for $item at $i in $sources
                    return
                      if ($item = $source) then (
                        <ns2:BuyRate>{ fn-bea:fail-over(round-half-to-even(1 div number($buys[$i]), 4), 0) }</ns2:BuyRate>,
                        <ns2:SellRate>{ fn-bea:fail-over(round-half-to-even(1 div number($sells[$i]), 4), 0) }</ns2:SellRate>
                      ) else ()
                )else()
            }
            </ns2:getExchangeRateRecordType>
        </ns2:getExchangeRateResponseType>
    </ns2:getExchangeRateResponse>
};

local:func($CoreBSReponse, $uuid, $source, $target)