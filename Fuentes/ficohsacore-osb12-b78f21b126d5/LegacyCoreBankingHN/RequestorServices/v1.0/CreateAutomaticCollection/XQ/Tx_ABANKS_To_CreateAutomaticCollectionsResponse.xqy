xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/customerTypes";
(:: import schema at "../../../../../MWBanking/Customers/RequestorServices/XSD/customersTypes.xsd" ::)
declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/CreateAutomaticCollection_BS";
(:: import schema at "../../../../ProviderServices/XSD/CreateAutomaticCollection/CreateAutomaticCollection_BS_sp.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $uuid as xs:string external;
declare variable $abanksResponse as element() (:: schema-element(ns1:OutputParameters) ::) external;

declare function xq:Tx_ABANKS_To_CreateAutomaticCollectionsResponse($abanksResponse as element() (:: schema-element(ns1:OutputParameters) ::), $uuid as xs:string) as element() (:: schema-element(ns2:automaticCollectionsResponse) ::) {
    <ns2:automaticCollectionsResponse>
        <ns2:StatusInfo>
            <com:Status>Success</com:Status>
            <com:TransactionId></com:TransactionId>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{$uuid}</com:GlobalId>
        </ns2:StatusInfo>
        {
            if ($abanksResponse/ns1:PV_DEBTOR_CODE)
            then <ns2:DebtorCode>{fn:data($abanksResponse/ns1:PV_DEBTOR_CODE)}</ns2:DebtorCode>
            else ()
        }
        {
            if ($abanksResponse/ns1:PV_PLAZOS)
            then <ns2:Installments>{fn:data($abanksResponse/ns1:PV_PLAZOS)}</ns2:Installments>
            else ()
        }
        {
            if ($abanksResponse/ns1:PV_VALOR_PLAN)
            then <ns2:CollectionValue>{fn:data($abanksResponse/ns1:PV_VALOR_PLAN)}</ns2:CollectionValue>
            else ()
        }
        {
            if ($abanksResponse/ns1:PV_DIA_PAGO)
            then <ns2:PaymentDate>{fn:data($abanksResponse/ns1:PV_DIA_PAGO)}</ns2:PaymentDate>
            else ()
        }
    </ns2:automaticCollectionsResponse>
};

xq:Tx_ABANKS_To_CreateAutomaticCollectionsResponse($abanksResponse,$uuid)
