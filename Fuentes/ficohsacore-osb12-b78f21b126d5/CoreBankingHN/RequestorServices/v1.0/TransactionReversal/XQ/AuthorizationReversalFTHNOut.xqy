xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/PayRemittances/XMLSchema_-193201527.xsd" ::)
declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/transactionReversalTypes";
(:: import schema at "../../../../../MWBanking/Transfers/RequestorServices/XSD/transactionReversalTypes.xsd" ::)

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $uuid as xs:string external;
declare variable $authorizationReversalResponse as element() (:: schema-element(ns1:AutorizacionreversionFTResponse) ::) external;

declare function local:func($uuid as xs:string, $authorizationReversalResponse as element() (:: schema-element(ns1:AutorizacionreversionFTResponse) ::)) as element() (:: schema-element(ns2:transactionReversalResponse) ::) {
    <ns2:transactionReversalResponse>
        <ns2:StatusInfo>
            {
                if ($authorizationReversalResponse/Status/successIndicator)
                then <com:Status>{fn:data($authorizationReversalResponse/Status/successIndicator)}</com:Status>
                else ()
            }
            {
                if ($authorizationReversalResponse/Status/transactionId)
                then <com:TransactionId>{fn:data($authorizationReversalResponse/Status/transactionId)}</com:TransactionId>
                else ()
            }
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{$uuid}</com:GlobalId>
        </ns2:StatusInfo>
    </ns2:transactionReversalResponse>
};

local:func($uuid, $authorizationReversalResponse)
