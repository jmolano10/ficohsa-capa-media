xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/availableFinancingDetailTypes";
(:: import schema at "../../../../../../MWBanking/CreditCards/RequestorServices/XSD/availableFinancingDetailTypes.xsd" ::)
declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/ConsultOffer_BS";
(:: import schema at "../../../../../ProviderServices/XSD/ConsultOffer/ConsultOffer_BS_sp.xsd" ::)

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $ConsulOfferOut as element() (:: schema-element(ns1:OutputParameters) ::) external;
declare variable $uuid as xs:string external;
declare variable $legalId as xs:string external;
declare variable $creditLine as xs:string external;

declare function local:func($ConsulOfferOut as element() (:: schema-element(ns1:OutputParameters) ::), 
                            $uuid as xs:string,
                            $legalId as xs:string,
                            $creditLine as xs:string) 
                            as element() (:: schema-element(ns2:availableFinancingDetailResponse) ::) {
    <ns2:availableFinancingDetailResponse>
        <ns2:StatusInfo>
            <com:Status>Success</com:Status>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </ns2:StatusInfo>
        <ns2:LegalId>{fn:data($legalId)}</ns2:LegalId>
        <ns2:CreditLine>{fn:data($creditLine)}</ns2:CreditLine>
        {
            for $Row in $ConsulOfferOut/ns1:RowSet/ns1:Row
            return 
            <ns2:Details>
                <ns2:RateType>{fn:data($Row/ns1:Column[@name='Pv_TipoTasa'])}</ns2:RateType>
                <ns2:Rate>{fn:data($Row/ns1:Column[@name='Pn_Tasa'])}</ns2:Rate>
                <ns2:Currency>{fn:data($Row/ns1:Column[@name='Pv_Moneda'])}</ns2:Currency>
                <ns2:Term>{fn:data($Row/ns1:Column[@name='Pn_Plazo'])}</ns2:Term>
                <ns2:Amount>{fn:data($Row/ns1:Column[@name='Pn_Monto'])}</ns2:Amount>
            </ns2:Details>
        }
    </ns2:availableFinancingDetailResponse>
};

local:func($ConsulOfferOut, $uuid, $legalId, $creditLine)