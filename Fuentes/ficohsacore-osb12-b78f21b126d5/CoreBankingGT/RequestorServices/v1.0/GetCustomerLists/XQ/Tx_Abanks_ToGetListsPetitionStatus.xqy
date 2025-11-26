xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/customerLists";
(:: import schema at "../../../../../MWBanking/Customers/RequestorServices/XSD/customersLists.xsd" ::)
declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetListsPetitionStatus";
(:: import schema at "../../../../ProviderServices/XSD/GetCustomerLists/GetListsPetitionStatus_sp.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $abanksResponse as element() (:: schema-element(ns1:OutputParameters) ::) external;
declare variable $uuid as xs:string external;

declare function xq:Tx_Abanks_ToGetListsPetitionStatu($abanksResponse as element() (:: schema-element(ns1:OutputParameters) ::), 
                                                      $uuid as xs:string) 
                                                      as element() (:: schema-element(ns2:getListsPetitionStatusResponse) ::) {
    <ns2:getListsPetitionStatusResponse>
        <ns2:StatusInfo>
            <com:Status>SUCCESS</com:Status>
            <com:TransactionId></com:TransactionId>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </ns2:StatusInfo>
        {
            if ($abanksResponse/ns1:PV_RET_VAL)
            then <ns2:petitionStatus>{fn:data($abanksResponse/ns1:PV_RET_VAL)}</ns2:petitionStatus>
            else ()
        }
        {
            if ($abanksResponse/ns1:PN_NUMERO_SECUENCIA)
            then <ns2:sequenceNumber>{fn:data($abanksResponse/ns1:PN_NUMERO_SECUENCIA)}</ns2:sequenceNumber>
            else ()
        }
        {
            if ($abanksResponse/ns1:PV_RETURN_CODE)
            then <ns2:returnCode>{fn:data($abanksResponse/ns1:PV_RETURN_CODE)}</ns2:returnCode>
            else ()
        }
        {
            if ($abanksResponse/ns1:PV_RETURN_MESSAGE)
            then <ns2:returnMessage>{fn:data($abanksResponse/ns1:PV_RETURN_MESSAGE)}</ns2:returnMessage>
            else ()
        }
    </ns2:getListsPetitionStatusResponse>
};

xq:Tx_Abanks_ToGetListsPetitionStatu($abanksResponse, $uuid)