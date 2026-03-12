xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.procesa.com/fdcs/ot";
(:: import schema at "../Resources/OnlineTransactions_v4.wsdl" ::)
declare namespace ns1="https://www.ficohsa.com/regional/card";
(:: import schema at "../Schemas/RollbackPurchaseTypes.xsd" ::)

declare variable $Rollback as element() (:: schema-element(ns1:getStatusTicket) ::) external;
declare variable $sequence as xs:string external;
declare variable $org as xs:string external;
declare variable $requestType as xs:string external;
declare variable $creditCard as xs:string external;
declare variable $merchant as xs:string external;
declare variable $expiration as xs:string external;
declare variable $payment as xs:string external;

declare function local:funcRollbackPurchaseToOnlinePayment($Rollback as element() (:: schema-element(ns1:getStatusTicket) ::),
                                                    $sequence as xs:string,    
                                                  $org as xs:string,
                                                  $requestType as xs:string,
                                                  $creditCard as xs:string,
                                                  $merchant as xs:string,
                                                  $expiration as xs:string,
                                                  $payment as xs:string) as element() (:: schema-element(ns2:OnlinePaymentV4Request) ::) {
    <ns2:OnlinePaymentV4Request>
        <POSUserData>ATX</POSUserData>
        <RRN37>{    
    let $currentDate  := (current-date())  
    let $currentTime  := (current-time())  
    let $yearFormat  := ("YY")  
    let $lastYearDigitIndex  := (2)  
    let $yearDaysFormat  := ("D")  
    let $yearDaysSize  := (3)  
    let $yearDaysPad  := ('0')  
    let $hoursSize  := (2)  
    let $hoursPad  := ('0')  
    let $minutesSize  := (2)  
    let $minutesPad  := ('0')  
    let $lastYearDigit  := (substring(fn-bea:date-to-string-with-format($yearFormat, $currentDate), $lastYearDigitIndex))  
    let $yearDays  := (fn-bea:pad-left(fn-bea:date-to-string-with-format($yearDaysFormat, $currentDate), $yearDaysSize, $yearDaysPad))  
    let $hours  := (fn-bea:pad-left(xs:string(hours-from-time($currentTime)), $hoursSize, $hoursPad))  
    let $minutes  := (fn-bea:pad-left(xs:string(minutes-from-time($currentTime)), $minutesSize, $minutesPad))  
    return
        (concat($lastYearDigit ,$yearDays, $hours, $minutes, $sequence))
}</RRN37>
        <NumberOfInstallments>00</NumberOfInstallments>
        <MCCType>6010</MCCType>
        <RequestType>{fn:data($requestType)}</RequestType>
        <CardNumber>{fn:data($creditCard)}</CardNumber>
        <OrgId>{fn:data($org)}</OrgId>
        <MerchantNumber>{fn:data($merchant)}</MerchantNumber>
        <CardExpirationDate>{fn:data($expiration)}</CardExpirationDate>
        <TotalSalesAmount>{fn:data($payment)}</TotalSalesAmount>
        <Track2Length>0000</Track2Length>
        <Track2Data>0000</Track2Data>
        <CardValidationValue>000</CardValidationValue>
    </ns2:OnlinePaymentV4Request>
};

local:funcRollbackPurchaseToOnlinePayment($Rollback,$sequence,$org,$requestType,$creditCard,$merchant,$expiration,$payment)