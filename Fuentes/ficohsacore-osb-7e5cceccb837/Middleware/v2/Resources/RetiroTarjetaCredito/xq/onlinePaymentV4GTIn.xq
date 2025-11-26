xquery version "1.0" encoding "Cp1252";
(:: pragma bea:global-element-parameter parameter="$retiroTarjetaCredito" element="ns0:retiroTarjetaCredito" location="../xsd/retiroTarjetaCreditoTypes.xsd" ::)
(:: pragma bea:global-element-return element="ns1:OnlinePaymentV4Request" location="../../../BusinessServices/VisionPlusGT/onlineTransactions_v4/wsdl/OnlineTransactions_v4.wsdl" ::)

declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RetiroTarjetaCredito/xq/onlinePaymentV4GTIn/";
declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/retiroTarjetaCreditoTypes";
declare namespace ns1 = "http://www.procesa.com/fdcs/ot";

declare function xf:onlinePaymentV4GTIn($retiroTarjetaCredito as element(ns0:retiroTarjetaCredito),
    $org as xs:string,
    $sequenceValue as xs:string,
    $merchantNumber as xs:string)
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
                        (concat($lastYearDigit, $yearDays, $hours, $minutes, $sequenceValue))
                }
            </RRN37>
            <NumberOfInstallments>00</NumberOfInstallments>
            <MCCType>6010</MCCType>
            <RequestType>A</RequestType>
            <CardNumber>{ data($retiroTarjetaCredito/CREDIT_CARD_INFO/VALUE) }</CardNumber>
            <OrgId>{ data($org) }</OrgId>
            <MerchantNumber>{$merchantNumber}</MerchantNumber>
            <CardExpirationDate>{ data($retiroTarjetaCredito/CREDIT_CARD_INFO/EXPIRATION_DATE) }</CardExpirationDate>
            <TotalSalesAmount>{ data($retiroTarjetaCredito/AMOUNT) }</TotalSalesAmount>
            <Track2Length>0000</Track2Length>
            <Track2Data>0000</Track2Data>
            <CardValidationValue>000</CardValidationValue>
        </ns1:OnlinePaymentV4Request>
};

declare variable $retiroTarjetaCredito as element(ns0:retiroTarjetaCredito) external;
declare variable $org as xs:string external;
declare variable $sequenceValue as xs:string external;
declare variable $merchantNumber as xs:string external;

xf:onlinePaymentV4GTIn($retiroTarjetaCredito,
    $org,
    $sequenceValue,
    $merchantNumber)
