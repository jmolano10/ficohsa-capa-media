xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$pagoRecaudo" element="ns1:pagoRecaudo" location="../../../../Business_Resources/pagoRecaudos/PagoRecaudo/pagoRecaudoTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$conOrgSequenceResponse" element="ns0:OutputParameters" location="../../../BusinessServices/MasterDataPA/conOrgSequence/xsd/osbConOrgSequence_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns2:OnlinePaymentV4Request" location="../../../BusinessServices/VisionPlusPA/onlineTransactions_v4/wsdl/OnlineTransactions_v4.wsdl" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/osbConOrgSequence";
declare namespace ns2 = "http://www.procesa.com/fdcs/ot";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/pagoRecaudoTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/PagoRecaudo/xq/onlinePaymentV4/";

declare function xf:onlinePaymentV4($pagoRecaudo as element(ns1:pagoRecaudo),
    $conOrgSequenceResponse as element(ns0:OutputParameters),
    $requestType as xs:string,
    $merchantNumber as xs:string)
    as element(ns2:OnlinePaymentV4Request) {
        <ns2:OnlinePaymentV4Request>
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
                        (concat($lastYearDigit ,$yearDays, $hours, $minutes, string($conOrgSequenceResponse/ns0:SequenceValue/text())))
                }
			</RRN37>
            <NumberOfInstallments>00</NumberOfInstallments>
            <MCCType>0000</MCCType>
            <RequestType>{ $requestType }</RequestType>
            <CardNumber>{ data($pagoRecaudo/PAYMENT_INFORMATION/CREDIT_CARD_NUMBER) }</CardNumber>
            <OrgId>{ data($conOrgSequenceResponse/ns0:ORG) }</OrgId>
            <MerchantNumber>{ $merchantNumber }</MerchantNumber>
            <CardExpirationDate>{ data($pagoRecaudo/PAYMENT_INFORMATION/EXPIRATION_DATE) }</CardExpirationDate>
            <TotalSalesAmount>{ data($pagoRecaudo/PAYMENT_INFORMATION/PAYMENT_AMOUNT) }</TotalSalesAmount>
            <Track2Length>0000</Track2Length>
            <Track2Data>0000</Track2Data>
            <CardValidationValue>000</CardValidationValue>
        </ns2:OnlinePaymentV4Request>
};

declare variable $pagoRecaudo as element(ns1:pagoRecaudo) external;
declare variable $conOrgSequenceResponse as element(ns0:OutputParameters) external;
declare variable $requestType as xs:string external;
declare variable $merchantNumber as xs:string external;


xf:onlinePaymentV4($pagoRecaudo,
    $conOrgSequenceResponse,
    $requestType,
    $merchantNumber)