xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/payRemittancesTypes";
(:: import schema at "../../../../../MWBanking/Remittances/RequestorServices/XSD/payRemittancesTypes.xsd" ::)
declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/PagoFicoRemesasBS";
(:: import schema at "../../../../ProviderServices/XSD/PayRemittances/PagoFicoRemesasBS_sp.xsd" ::)

declare namespace xq="http://www.w3.org/2005/xquery-local-functions";

declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $outputParameters1 as element() (:: schema-element(ns1:OutputParameters) ::) external;
declare variable $uuid as xs:string external;

declare function xq:pagoFRemOut($outputParameters1 as element() (:: schema-element(ns1:OutputParameters) ::),$uuid as xs:string) as element() (:: schema-element(ns2:pagoRemesasResponse) ::) {
    <ns2:pagoRemesasResponse>
        <ns2:StatusInfo>
            <com:Status></com:Status>
            {
            if (fn:string($outputParameters1/ns1:PERR_COD/text()) != "0") then 
            <com:TransactionId></com:TransactionId>
            else
            <com:TransactionId>{substring-after(fn:string($outputParameters1/ns1:PERR_MSJ),'#')}</com:TransactionId>
            }
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{$uuid}</com:GlobalId>
        </ns2:StatusInfo>
    </ns2:pagoRemesasResponse>
};

xq:pagoFRemOut($outputParameters1,$uuid)
