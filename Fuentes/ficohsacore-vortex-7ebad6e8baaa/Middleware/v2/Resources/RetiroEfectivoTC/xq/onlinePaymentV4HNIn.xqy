xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$retiroEfectivoTC" element="ns0:retiroEfectivoTC" location="../xsd/retiroEfectivoTCTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters" element="ns1:OutputParameters" location="../../../BusinessServices/MasterDataHN/conDatosTarjetaVp/xsd/conDatosTarjetaVp_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns2:OnlinePaymentV4Request" location="../../../BusinessServices/VisionPlusHN/onlineTransactions_v4/wsdl/OnlineTransactions_v4.wsdl" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/retiroEfectivoTCTypes";
declare namespace ns2 = "http://www.procesa.com/fdcs/ot";
declare namespace ns1 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatosTarjetaVp";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RetiroEfectivoTC/xq/onlinePaymentV4HNIn/";

declare function xf:onlinePaymentV4HNIn($retiroEfectivoTC as element(ns0:retiroEfectivoTC),
    $outputParameters as element(ns1:OutputParameters),
    $requestType as xs:string,
    $merchantNumber as xs:string)
    as element(ns2:OnlinePaymentV4Request) {
        let $creditCard := data($retiroEfectivoTC/CREDIT_CARD)
        return
        <ns2:OnlinePaymentV4Request>
        
            <POSUserData>ATX</POSUserData>
            {
             let $referenceNumber := xs:string($retiroEfectivoTC/REFERENCE_NUMBER/text())
             let $conDatosTarjetaVPResponse := string($outputParameters/ns1:SequenceValue/text())
             return
                <RRN37>
                {
             		if ($referenceNumber != "")then (
                		$referenceNumber
                	)else(
                		let $currentDate        := current-date()
                		let $currentTime        := current-time()
                		let $yearFormat         := "YY"
                		let $lastYearDigitIndex := 2
                		let $yearDaysFormat     := "D"
                		let $yearDaysSize       := 3
                		let $yearDaysPad        := '0'
                		let $hoursSize          := 2
                		let $hoursPad           := '0'
                		let $minutesSize        := 2
                		let $minutesPad         := '0'
                		let $lastYearDigit      := substring(fn-bea:date-to-string-with-format($yearFormat, $currentDate), $lastYearDigitIndex)
                		let $yearDays           := fn-bea:pad-left(fn-bea:date-to-string-with-format($yearDaysFormat, $currentDate), $yearDaysSize, $yearDaysPad)
						let $hours              := fn-bea:pad-left(xs:string(hours-from-time($currentTime)), $hoursSize, $hoursPad)
                		let $minutes            := fn-bea:pad-left(xs:string(minutes-from-time($currentTime)), $minutesSize, $minutesPad)
                		return
                			concat($lastYearDigit ,$yearDays, $hours, $minutes, $conDatosTarjetaVPResponse)
             		)
                  }
             </RRN37>
            } 
            <NumberOfInstallments>00</NumberOfInstallments>
            <MCCType>6010</MCCType>
            <RequestType>{ $requestType }</RequestType>
            <CardNumber>{ fn-bea:pad-left($creditCard, 19, '0') }</CardNumber>
            <OrgId>{ data($outputParameters/ns1:ORG) }</OrgId>
            <MerchantNumber>{ $merchantNumber }</MerchantNumber>
            <CardExpirationDate>{ data($outputParameters/ns1:CardExpirationDate) }</CardExpirationDate>
            <TotalSalesAmount>{ data($retiroEfectivoTC/AMOUNT) }</TotalSalesAmount>
            <Track2Length>0000</Track2Length>
            <Track2Data>0000</Track2Data>
            <CardValidationValue>000</CardValidationValue>
        </ns2:OnlinePaymentV4Request>
};

declare variable $retiroEfectivoTC as element(ns0:retiroEfectivoTC) external;
declare variable $outputParameters as element(ns1:OutputParameters) external;
declare variable $requestType as xs:string external;
declare variable $merchantNumber as xs:string external;

xf:onlinePaymentV4HNIn($retiroEfectivoTC,
    $outputParameters,
    $requestType,
    $merchantNumber)