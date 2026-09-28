(:: pragma bea:global-element-return element="ns1:OnlinePaymentV4Request" location="../../../BusinessServices/VisionPlus/onlineTransactions_v4/wsdl/OnlineTransactions_v4.wsdl" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/kvpType";
declare namespace ns2 = "http://www.ficohsa.com.hn/middleware.services/RegistrarTransaccionTCTypes";
declare namespace ns1 = "http://www.procesa.com/fdcs/ot";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RegistrarTransaccionTC/xq/onlineTransactionsV4In/";

declare function xf:onlineTransactionsV4In($installments as xs:string,
    $MCCType as xs:string,
    $requestType as xs:string,
    $cardNumber as xs:string,
    $org as xs:string,
    $MerchantNumber as xs:string,
    $fechaVencimientoTarjeta as xs:string,
    $transactionAmount as xs:string,
    $numeroSecuencia as xs:string,
    $authorizationCode as xs:string)
    as element(ns1:OnlinePaymentV4Request) {
        <ns1:OnlinePaymentV4Request>
            <POSUserData>ATX</POSUserData>
            <RRN37>
                {
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
                        (concat($lastYearDigit ,$yearDays, $hours, $minutes, string($numeroSecuencia)))
                }
</RRN37>
            <NumberOfInstallments>{ data($installments) }</NumberOfInstallments>
            <MCCType>{ $MCCType }</MCCType>
            <RequestType>{ $requestType }</RequestType>
            <CardNumber>{ $cardNumber }</CardNumber>
            <OrgId>{ data($org) }</OrgId>
            <MerchantNumber>{ data($MerchantNumber) }</MerchantNumber>
            <CardExpirationDate>{ data($fechaVencimientoTarjeta) }</CardExpirationDate>
            <TotalSalesAmount>{ data($transactionAmount) }</TotalSalesAmount>
            <Track2Length>0000</Track2Length>
            <Track2Data>0000</Track2Data>
            <CardValidationValue>000</CardValidationValue>
            <AuthorizationCode>{ $authorizationCode }</AuthorizationCode>
        </ns1:OnlinePaymentV4Request>
};

declare variable $installments as xs:string external;
declare variable $MCCType as xs:string external;
declare variable $requestType as xs:string external;
declare variable $cardNumber as xs:string external;
declare variable $org as xs:string external;
declare variable $MerchantNumber as xs:string external;
declare variable $fechaVencimientoTarjeta as xs:string external;
declare variable $transactionAmount as xs:string external;
declare variable $numeroSecuencia as xs:string external;
declare variable $authorizationCode as xs:string external;

xf:onlineTransactionsV4In($installments,
    $MCCType,
    $requestType,
    $cardNumber,
    $org,
    $MerchantNumber,
    $fechaVencimientoTarjeta,
    $transactionAmount,
    $numeroSecuencia,
    $authorizationCode)