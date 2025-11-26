xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/getInterestRateTypes";
(:: import schema at "../../../../../../MWBanking/CreditCards/RequestorServices/XSD/getInterestRateTypes.xsd" ::)
declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetInterestRate";
(:: import schema at "../../../../../ProviderServices/XSD/GetInterestRate/GetInterestRate_sp.xsd" ::)

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $uuid as xs:string external;
declare variable $GetInterestRateBS as element() (:: schema-element(ns1:OutputParameters) ::) external;

declare function local:func($uuid as xs:string, $GetInterestRateBS as element() (:: schema-element(ns1:OutputParameters) ::)) as element() (:: schema-element(ns2:getInterestRateResponse) ::) {
    <ns2:getInterestRateResponse>
        <ns2:StatusInfo>
            <com:Status>Success</com:Status>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </ns2:StatusInfo>
        {
            for $Row in $GetInterestRateBS/ns1:RowSet/ns1:Row
            return 
            <ns2:RatesInfo>
                <ns2:Org>{fn:data($Row/ns1:Column[@name='Org'])}</ns2:Org>
                <ns2:Logo>{fn:data($Row/ns1:Column[@name='Logo'])}</ns2:Logo>
                <ns2:Pct>{fn:data($Row/ns1:Column[@name='PCT'])}</ns2:Pct>
                <ns2:InterestRate>{fn:data($Row/ns1:Column[@name='TasaInteres'])}</ns2:InterestRate>
                <ns2:UpdateDateInterestRate>{substring-before(fn:data($Row/ns1:Column[@name='Fecha']), ".")}</ns2:UpdateDateInterestRate>
            </ns2:RatesInfo>
        }
    </ns2:getInterestRateResponse>
};

local:func($uuid, $GetInterestRateBS)