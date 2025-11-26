xquery version "1.0" encoding "utf-8";

(:: OracleAnnotationVersion "1.0" ::)

declare namespace ns2="http://www.ficohsa.com.hn/middleware.services/PaymentRecordCreditCard";
(:: import schema at "../../../../../../MWBanking/CreditCards/RequestorServices/XSD/paymentRecordCreditCardTypes.xsd" ::)
declare namespace ns4="http://www.procesa.com/fdcs/ot";
(:: import schema at "../../../../../ProviderServices/WSDL/visionPlus/onlineTransactionsV4.wsdl" ::)
declare namespace ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/GetParameter";
(:: import schema at "../../../../../ProviderServices/XSD/GetParameter/GetParameter_sp.xsd" ::)
declare namespace ns3="http://xmlns.oracle.com/pcbpel/adapter/db/sp/OsbConOrgSequence";
(:: import schema at "../../../../../ProviderServices/XSD/OsbConOrgSequence/OsbConOrgSequence_sp.xsd" ::)

declare variable $GetParameterResponse as element() (:: schema-element(ns1:OutputParameters) ::) external;
declare variable $PaymentRecordCreditCardRequest as element() (:: schema-element(ns2:PaymentRecordCreditCardRequest) ::) external;
declare variable $OsbConOrgSequenceResponse as element() (:: schema-element(ns3:OutputParameters) ::) external;
declare variable $merchant as xs:string external;
declare variable $merchantDefault as xs:string external;

declare function local:func($GetParameterResponse as element() (:: schema-element(ns1:OutputParameters) ::), 
                            $PaymentRecordCreditCardRequest as element() (:: schema-element(ns2:PaymentRecordCreditCardRequest) ::), 
                            $OsbConOrgSequenceResponse as element() (:: schema-element(ns3:OutputParameters) ::),
                            $merchant as xs:string,
                            $merchantDefault as xs:string) 
                            as element() (:: schema-element(ns4:OnlinePaymentV4Request) ::) {
    <ns4:OnlinePaymentV4Request>
        <POSUserData>{fn:data($GetParameterResponse/ns1:CONFIGURACIONES/ns1:CONFIGURACIONES_ITEM[ns1:NAME='FICBCO0067.HN01.POSUSERDATA']/ns1:VALUE)}</POSUserData>
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
                        (concat($lastYearDigit ,$yearDays, $hours, $minutes, string($OsbConOrgSequenceResponse/ns3:SequenceValue/text())))
        }
        </RRN37>
        <NumberOfInstallments>{fn:data($GetParameterResponse/ns1:CONFIGURACIONES/ns1:CONFIGURACIONES_ITEM[ns1:NAME='FICBCO0067.HN01.NUMBEROFINSTALLMENTS']/ns1:VALUE)}</NumberOfInstallments>
        {
            if (fn:data($GetParameterResponse/ns1:CONFIGURACIONES/ns1:CONFIGURACIONES_ITEM[ns1:NAME='FICBCO0067.HN01.MCCTYPE']/ns1:VALUE)!='')
            then <MCCType>{fn:data($GetParameterResponse/ns1:CONFIGURACIONES/ns1:CONFIGURACIONES_ITEM[ns1:NAME='FICBCO0067.HN01.MCCTYPE']/ns1:VALUE)}</MCCType>
            else (<MCCType>{fn:data($GetParameterResponse/ns1:CONFIGURACIONES/ns1:CONFIGURACIONES_ITEM[ns1:NAME='FICBCO0067.HN01.MCCTYPE.WITHDRAWAL']/ns1:VALUE)}</MCCType>)
        }
        <RequestType>{fn:data($GetParameterResponse/ns1:CONFIGURACIONES/ns1:CONFIGURACIONES_ITEM[ns1:NAME='FICBCO0067.HN01.AUTHORIZATION']/ns1:VALUE)}</RequestType>
        <CardNumber>{fn:data($PaymentRecordCreditCardRequest/ns2:CreditCard)}</CardNumber>
        <OrgId>{fn:data($OsbConOrgSequenceResponse/ns3:ORG)}</OrgId>
        {
            if(fn:data($GetParameterResponse/ns1:CONFIGURACIONES/ns1:CONFIGURACIONES_ITEM[ns1:NAME=$merchant]/ns1:VALUE)!='')
            then <MerchantNumber>{fn:data($GetParameterResponse/ns1:CONFIGURACIONES/ns1:CONFIGURACIONES_ITEM[ns1:NAME=$merchant]/ns1:VALUE)}</MerchantNumber>
            else(<MerchantNumber>{fn:data($GetParameterResponse/ns1:CONFIGURACIONES/ns1:CONFIGURACIONES_ITEM[ns1:NAME=$merchantDefault]/ns1:VALUE)}</MerchantNumber>)
        }
        <CardExpirationDate>{fn:data($PaymentRecordCreditCardRequest/ns2:ExpirationDate)}</CardExpirationDate>
        <TotalSalesAmount>{fn:data($PaymentRecordCreditCardRequest/ns2:PaymentAmount)}</TotalSalesAmount>
        <Track2Length>{fn:data($GetParameterResponse/ns1:CONFIGURACIONES/ns1:CONFIGURACIONES_ITEM[ns1:NAME='FICBCO0067.HN01.TRACK2LENGTH']/ns1:VALUE)}</Track2Length>
        <Track2Data>{fn:data($GetParameterResponse/ns1:CONFIGURACIONES/ns1:CONFIGURACIONES_ITEM[ns1:NAME='FICBCO0067.HN01.TRACK2DATA']/ns1:VALUE)}</Track2Data>
        <CardValidationValue>{fn:data($GetParameterResponse/ns1:CONFIGURACIONES/ns1:CONFIGURACIONES_ITEM[ns1:NAME='FICBCO0067.HN01.CARDVALIDATIONVALUE']/ns1:VALUE)}</CardValidationValue>
    </ns4:OnlinePaymentV4Request>
};

local:func($GetParameterResponse, $PaymentRecordCreditCardRequest, $OsbConOrgSequenceResponse, $merchant, $merchantDefault)