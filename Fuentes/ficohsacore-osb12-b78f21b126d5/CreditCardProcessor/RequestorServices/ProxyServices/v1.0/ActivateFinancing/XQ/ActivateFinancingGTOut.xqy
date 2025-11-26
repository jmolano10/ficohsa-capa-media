xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/activateFinancingTypes";
(:: import schema at "../../../../../../MWBanking/CreditCards/RequestorServices/XSD/activateFinancingTypes.xsd" ::)
declare namespace ns1="http://www.procesa.com/fdcs";
(:: import schema at "../../../../../ProviderServices/XSD/visionPlus/XMLSchema_769155616.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $visionResponse as element() (:: schema-element(ns1:MonetaryActionCodeL8V2Response) ::) external;
declare variable $uuid as xs:string external;

declare function xq:ActivateFinancingGTOut($visionResponse as element() (:: schema-element(ns1:MonetaryActionCodeL8V2Response) ::), 
                                           $uuid as xs:string) 
                                           as element() (:: schema-element(ns2:activateFinancingResponse) ::) {
    <ns2:activateFinancingResponse>
        <StatusInfo>
            <com:Status>Success</com:Status>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </StatusInfo>
    </ns2:activateFinancingResponse>
};

xq:ActivateFinancingGTOut($visionResponse, $uuid)