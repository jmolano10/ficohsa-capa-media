xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns1="http://www.ficohsa.com.hn/middleware.services/calculateFinancingTypes";
(:: import schema at "../../../../../../MWBanking/CreditCards/RequestorServices/XSD/calculateFinancingTypes.xsd" ::)
declare namespace com = "http://www.ficohsa.com.hn/middleware.services/commonTypes";

declare variable $calculatedFee as element()* external;
declare variable $totalAmount as xs:string external;
declare variable $numberOfPayments as xs:string external;
declare variable $uuid as xs:string external;

declare function local:func($calculatedFee as element()*, 
                            $totalAmount as xs:string,
                            $numberOfPayments as xs:string,
                            $uuid as xs:string) 
                            as element() (:: schema-element(ns1:calculateFinancingResponse) ::) {
    <ns1:calculateFinancingResponse>
    <ns1:StatusInfo>
            <com:Status>Success</com:Status>
            <com:ValueDate>{fn:substring(fn:string(fn:current-dateTime()),0,11)}</com:ValueDate>
            <com:DateTime>{fn:substring(fn:string(fn:current-dateTime()),0,20)}</com:DateTime>
            <com:GlobalId>{fn:data($uuid)}</com:GlobalId>
        </ns1:StatusInfo>
        <ExactMatch>YES</ExactMatch>
            <TotalAmount>{ data($totalAmount) }</TotalAmount>
            <MonthlyPayment>{ fn:round-half-to-even(data($calculatedFee/CuotaMensual),2) }</MonthlyPayment>
            <NumberOfPayments>{ data($numberOfPayments) }</NumberOfPayments>
            <YearlyIntRate>{ fn:round-half-to-even(data($calculatedFee/TasaAnual),2) }</YearlyIntRate>
            <MonthlyIntRate>{ fn:round-half-to-even(data($calculatedFee/TasaMensual),2) }</MonthlyIntRate>
            <Charges>
                <Charge>
                    <Name>DISBURSEMENT</Name>
                    <Value>{ fn:round-half-to-even(data($calculatedFee/ValorDesembolso),2) }</Value>
                </Charge>
                <Charge>
                    <Name>INSURANCE</Name>
                    <Value>{fn:round-half-to-even( data($calculatedFee/ValorSeguro), 2) }</Value>
                </Charge>
            </Charges>
    </ns1:calculateFinancingResponse>
};

local:func($calculatedFee, $totalAmount, $numberOfPayments, $uuid)