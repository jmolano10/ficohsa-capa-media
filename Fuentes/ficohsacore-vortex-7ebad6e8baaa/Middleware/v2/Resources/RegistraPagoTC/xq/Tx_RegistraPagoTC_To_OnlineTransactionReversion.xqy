xquery version "2004-draft";
(:: pragma bea:global-element-parameter parameter="$outputParameters1" element="ns0:OutputParameters" location="../../../../Business_Resources/general/Resources/ObtenerParametrizacion/xsd/ORA_BANK_OSB_GET_CONFIG.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$registraPagoTCRequest1" element="ns1:registraPagoTCRequest" location="../xsd/RegistraPagoTC.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$outputParameters2" element="ns2:OutputParameters" location="../../../BusinessServices/MasterDataHN/conOrgSequence/xsd/osbConOrgSequence_sp.xsd" ::)
(:: pragma bea:global-element-return element="ns3:OnlinePaymentV4Request" location="../../../BusinessServices/VisionPlusHN/onlineTransactions_v4/wsdl/OnlineTransactions_v4.wsdl" ::)

declare namespace ns0 = "http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_GET_CONFIG/";
declare namespace ns2 = "http://xmlns.oracle.com/pcbpel/adapter/db/sp/osbConOrgSequence";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/registraPagoTCxsd";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/RegistraPagoTC/xq/Tx_RegistraPagoTC_To_osbConOrgSequence_db/";
declare namespace ns3 = "http://www.procesa.com/fdcs/ot";

declare function xf:Tx_RegistraPagoTC_To_osbConOrgSequence_db($outputParameters1 as element(ns0:OutputParameters),
    $registraPagoTCRequest1 as element(ns1:registraPagoTCRequest),
     $ORG as xs:string,
     $SEQ as xs:string,
     $merchantDefault as xs:string,
     $merchant as xs:string)
    as element(ns3:OnlinePaymentV4Request) {
        <ns3:OnlinePaymentV4Request>
            <POSUserData>{ data($outputParameters1/ns0:CONFIGURACIONES/ns0:CONFIGURACIONES_ITEM[ns0:NAME='FICBCO0067.HN01.POSUSERDATA']/ns0:VALUE) }</POSUserData>
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
                        (concat($lastYearDigit ,$yearDays, $hours, $minutes,$SEQ ))
                }            
	
			</RRN37>
            <NumberOfInstallments>{ data($outputParameters1/ns0:CONFIGURACIONES/ns0:CONFIGURACIONES_ITEM[ns0:NAME='FICBCO0067.HN01.NUMBEROFINSTALLMENTS']/ns0:VALUE) }</NumberOfInstallments>
            <MCCType>{ data($outputParameters1/ns0:CONFIGURACIONES/ns0:CONFIGURACIONES_ITEM[ns0:NAME='FICBCO0067.HN01.MCCTYPE']/ns0:VALUE) }</MCCType>
            <RequestType>{ data($outputParameters1/ns0:CONFIGURACIONES/ns0:CONFIGURACIONES_ITEM[ns0:NAME='FICBCO0067.HN01.REVERSE']/ns0:VALUE) }</RequestType>
            <CardNumber>{ data($registraPagoTCRequest1/CREDIT_CARD) }</CardNumber>
            <OrgId>{$ORG}</OrgId>
            {
            if (fn:data($outputParameters1/ns0:CONFIGURACIONES/ns0:CONFIGURACIONES_ITEM[ns0:NAME=$merchant]/ns0:VALUE)!='')
            then
            <MerchantNumber>{ data($outputParameters1/ns0:CONFIGURACIONES/ns0:CONFIGURACIONES_ITEM[ns0:NAME=$merchant]/ns0:VALUE) }</MerchantNumber>
            else
            <MerchantNumber>{ data($outputParameters1/ns0:CONFIGURACIONES/ns0:CONFIGURACIONES_ITEM[ns0:NAME=$merchantDefault]/ns0:VALUE) }</MerchantNumber>            
            }
            <CardExpirationDate>{ data($registraPagoTCRequest1/EXPIRATION_DATE) }</CardExpirationDate>
            <TotalSalesAmount>{ data($registraPagoTCRequest1/PAYMENT_AMOUNT) }</TotalSalesAmount>
            <Track2Length>{ data($outputParameters1/ns0:CONFIGURACIONES/ns0:CONFIGURACIONES_ITEM[ns0:NAME='FICBCO0067.HN01.TRACK2LENGTH']/ns0:VALUE) }</Track2Length>
            <Track2Data>{ data($outputParameters1/ns0:CONFIGURACIONES/ns0:CONFIGURACIONES_ITEM[ns0:NAME='FICBCO0067.HN01.TRACK2DATA']/ns0:VALUE) }</Track2Data>
            <CardValidationValue>{ data($outputParameters1/ns0:CONFIGURACIONES/ns0:CONFIGURACIONES_ITEM[ns0:NAME='FICBCO0067.HN01.CARDVALIDATIONVALUE']/ns0:VALUE) }</CardValidationValue>
        </ns3:OnlinePaymentV4Request>
};

declare variable $outputParameters1 as element(ns0:OutputParameters) external;
declare variable $registraPagoTCRequest1 as element(ns1:registraPagoTCRequest) external;
declare variable $SEQ as xs:string external;
declare variable $ORG as xs:string external;
declare variable $merchantDefault as xs:string external;
declare variable $merchant as xs:string external;

xf:Tx_RegistraPagoTC_To_osbConOrgSequence_db($outputParameters1,
    $registraPagoTCRequest1,$ORG,$SEQ,$merchantDefault,$merchant)