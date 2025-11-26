xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/CreaProductosCliente/v1.0/XMLSchema_379817454.xsd" ::)
declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/debitCardsTypes";
(:: import schema at "../../../../../MWBanking/DebitCards/RequestorServices/XSD/debitCardsTypes.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $t24Response as element() (:: schema-element(ns1:CreaciondeCuentasparaDigitalResponse) ::) external;
declare variable $uuid as xs:string external;

declare function xq:Tx_T24_To_AssignDebitCardResponse($t24Response as element() (:: schema-element(ns1:CreaciondeCuentasparaDigitalResponse) ::), 
                                                      $uuid as xs:string) 
                                                      as element() (:: schema-element(ns2:assignDebitCardResponse) ::) {
    <ns2:assignDebitCardResponse>
        <ns2:StatusInfo>
            <com:Status>Success</com:Status>
            <com:TransactionId></com:TransactionId>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </ns2:StatusInfo>
                        {
                    for $FIELDS51 in $t24Response/FICOBULKAPPRCLNTType/FIELDS51
                    return
                        let $__nullable := ( data($FIELDS51) )
                        return
                            if (fn:boolean($__nullable))
                            then
                                <ns2:Account>{ $__nullable }</ns2:Account>
                            else
                                ()
                }
    </ns2:assignDebitCardResponse>
};

xq:Tx_T24_To_AssignDebitCardResponse($t24Response, $uuid)