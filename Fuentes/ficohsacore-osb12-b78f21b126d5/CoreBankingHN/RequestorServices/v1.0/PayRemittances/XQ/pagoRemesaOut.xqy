xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="T24WebServicesImpl";
(:: import schema at "../../../../ProviderServices/XSD/PayRemittances/XMLSchema_-1855765488.xsd" ::)
declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/payRemittancesTypes";
(:: import schema at "../../../../../MWBanking/Remittances/RequestorServices/XSD/payRemittancesTypes.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $pagoderemesaFTResponse1 as element() (:: schema-element(ns1:PagoderemesaFTResponse) ::) external;
declare variable $uuid as xs:string external;

declare function xq:pagoRemesaOut($pagoderemesaFTResponse1 as element() (:: schema-element(ns1:PagoderemesaFTResponse) ::), 
                                  $uuid as xs:string) 
                                  as element() (:: schema-element(ns2:pagoRemesasResponse) ::) {
    <ns2:pagoRemesasResponse>
        <ns2:StatusInfo>
                    {
                for $successIndicator in $pagoderemesaFTResponse1/Status/successIndicator
                return
            <com:Status>{ data($successIndicator) }</com:Status>
            }
            {
                for $transactionId in $pagoderemesaFTResponse1/Status/transactionId
                return            
            <com:TransactionId>{ data($transactionId) }</com:TransactionId>
            }
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{$uuid}</com:GlobalId>
        </ns2:StatusInfo>
    </ns2:pagoRemesasResponse>
};

xq:pagoRemesaOut($pagoderemesaFTResponse1, $uuid)
