xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/CoreBS/XMLSchema_1628019553.xsd" ::)
declare namespace ns2="http://www.ficohsa.com.hn/getExchangeRateTypes";
(:: import schema at "../../../../../MWBanking/ConsumerService/XSD/getExchangeRateTypes.xsd" ::)

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $CoreBSResponse as element() (:: schema-element(ns1:ConsultadetasadecambiolcyResponse) ::) external;
declare variable $uuid as xs:string external;

declare function local:func($CoreBSResponse as element() (:: schema-element(ns1:ConsultadetasadecambiolcyResponse) ::), 
                            $uuid as xs:string) 
                            as element() (:: schema-element(ns2:getExchangeRateResponse) ::) {
    <ns2:getExchangeRateResponse>
        <ns2:StatusInfo>
            <com:Status>Success</com:Status>
            {
                if ($CoreBSResponse/Status/transactionId)
                then <com:TransactionId>{fn:data($CoreBSResponse/Status/transactionId)}</com:TransactionId>
                else ()
            }
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{$uuid}</com:GlobalId>
        </ns2:StatusInfo>
        <ns2:getExchangeRateResponseType>
            <ns2:getExchangeRateRecordType>
                {
                    if ($CoreBSResponse/WSLCYEXCHRATEType[1]/gWSLCYEXCHRATEDetailType/mWSLCYEXCHRATEDetailType[1]/BUYRATE)
                    then <ns2:BuyRate>{fn:data($CoreBSResponse/WSLCYEXCHRATEType[1]/gWSLCYEXCHRATEDetailType/mWSLCYEXCHRATEDetailType[1]/BUYRATE)}</ns2:BuyRate>
                    else ()
                }
                {
                    if ($CoreBSResponse/WSLCYEXCHRATEType[1]/gWSLCYEXCHRATEDetailType/mWSLCYEXCHRATEDetailType[1]/SELLRATE)
                    then <ns2:SellRate>{fn:data($CoreBSResponse/WSLCYEXCHRATEType[1]/gWSLCYEXCHRATEDetailType/mWSLCYEXCHRATEDetailType[1]/SELLRATE)}</ns2:SellRate>
                    else ()
                }
            </ns2:getExchangeRateRecordType>
        </ns2:getExchangeRateResponseType>
    </ns2:getExchangeRateResponse>
};

local:func($CoreBSResponse, $uuid)