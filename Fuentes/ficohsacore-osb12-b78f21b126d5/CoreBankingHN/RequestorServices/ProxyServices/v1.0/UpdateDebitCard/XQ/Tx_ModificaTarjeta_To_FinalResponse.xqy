xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="T24WebServicesImpl";
(:: import schema at "../../../../../ProviderServices/XSD/GetCustomerDebitCards/XMLSchema_-155258746.xsd" ::)
declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/debitCardsTypes";
(:: import schema at "../../../../../../MWBanking/DebitCards/RequestorServices/XSD/debitCardsTypes.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $modificaTarjetaDebitoResponse as element() (:: schema-element(ns1:ModificacionTarjetaDebitoResponse) ::) external;
declare variable $uuid as xs:string external;

declare function xq:Tx_ModificaTarjeta_To_FinalResponse($modificaTarjetaDebitoResponse as element() (:: schema-element(ns1:ModificacionTarjetaDebitoResponse) ::), 
                                                        $uuid as xs:string) 
                                                        as element() (:: schema-element(ns2:updateDebitCardResponse) ::) {
    <ns2:updateDebitCardResponse>
                <ns2:StatusInfo>
                <com:Status>Success</com:Status>
                <com:TransactionId></com:TransactionId>
                <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
                <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime> 
                <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
            </ns2:StatusInfo>
    </ns2:updateDebitCardResponse>
};

xq:Tx_ModificaTarjeta_To_FinalResponse($modificaTarjetaDebitoResponse, $uuid)
