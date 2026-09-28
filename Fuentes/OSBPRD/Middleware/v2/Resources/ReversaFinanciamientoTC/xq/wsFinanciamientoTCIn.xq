(:: pragma bea:global-element-parameter parameter="$reversaFinanciamiento" element="ns0:reversaFinanciamiento" location="../../FinanciamientoTC/xsd/financiamientoTCTypes.xsd" ::)
(:: pragma bea:global-element-return element="wsExtraFinanciamientoRequest" location="../../../BusinessServices/VASA/extrafinanciamiento/wsdl/wsdlFinanciamientoTC.wsdl" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/financiamientoTCTypes";
declare namespace ns1 = "http://co.com.cidenet/schema/FinanciamientoTC";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ReversaFinanciamientoTC/xq/wsExtraFinanciamientoIn/";

declare function getBit3 ($CreditLine as xs:string,$RateClass as xs:string)as xs:string { 
  		if($CreditLine = 'EXTERNAL' and $RateClass = '1') then (
        	'010021'
           )
        else 
       	if($CreditLine = 'EXTERNAL' and $RateClass = '2') then (
        	'010022'
           )
        else 
        if($CreditLine = 'INTERNAL' and $RateClass = '1') then (
        	'010023'
           )
        else 
        if($CreditLine = 'INTERNAL' and $RateClass = '2') then (
        	'010024'
           )
        else 
        (
         ''
        )
 };

declare function xf:wsExtraFinanciamientoIn(
	$bit22 as xs:string,
    $bit25 as xs:string,
    $bit32 as xs:string,
    $bit41 as xs:string,
    $bit42 as xs:string,
    $bit43 as xs:string,
    $bit60 as xs:string,
    $bit61 as xs:string,
    $bit62 as xs:string,
    $bit100 as xs:string,
    $codMoneda as xs:string,
    $secOperacionOriginal as xs:string,
    $fecha as xs:dateTime,
    $fechaOriginal as xs:dateTime,
    $isoHeader as xs:string,
    $reversaFinanciamiento as element(ns0:reversaFinanciamiento))
    as element(ns1:FinanciamientoTCRequest) {
    <ns1:FinanciamientoTCRequest>
    	<ISO8583_HEADER>{ $isoHeader }</ISO8583_HEADER>
        <ISO8583_REQUEST>
            <MTI>0420</MTI>
            <PrimaryAccountNumber_002>{ fn-bea:pad-left(fn:string($reversaFinanciamiento/CARD_NUMBER/text()), 16, '0') }</PrimaryAccountNumber_002>
            <ProcessingCode_003>{getBit3(string(data($reversaFinanciamiento/CREDIT_LINE/text())),(string(data($reversaFinanciamiento/RATE_CLASS/text()))))}</ProcessingCode_003>
            <AmountTransaction_004>{ xs:decimal(string($reversaFinanciamiento/REQUEST_AMOUNT/text())) * 100  }</AmountTransaction_004>     
            <TransmissionDateTime_007>{ fn-bea:dateTime-to-string-with-format('MMddHHmmss', $fecha ) }</TransmissionDateTime_007>
            <SystemTraceAuditNumber_011>{ substring($reversaFinanciamiento/INTERFACE_REFERENCE_NO/text(), 7) }</SystemTraceAuditNumber_011> (:Secuencia de 6 digitos:)
            <TimeLocalTransaction_012>{ fn-bea:dateTime-to-string-with-format('HHmmss', $fecha ) }</TimeLocalTransaction_012>
            <DateLocalTransaction_013>{ fn-bea:dateTime-to-string-with-format('MMdd', $fecha ) }</DateLocalTransaction_013>
            <DateExpiration_014>{ string($reversaFinanciamiento/EXPIRATION_DATE/text())}</DateExpiration_014>
            <DateCapture_017>{ fn-bea:dateTime-to-string-with-format('MMdd', $fecha ) }</DateCapture_017>           
            <PointOfServiceEntryMode_022>{ $bit22 }</PointOfServiceEntryMode_022>
            <PointOfServiceConditionCode_025>{ $bit25 }</PointOfServiceConditionCode_025>
            <AcquiringInstitutionIdentificationCode_032>{ fn-bea:pad-left($bit32, 6, '0') }</AcquiringInstitutionIdentificationCode_032>
            <RetrievalReferenceNumber_037>{ string($reversaFinanciamiento/INTERFACE_REFERENCE_NO/text()) }</RetrievalReferenceNumber_037>
            <ResponseCode_039>00</ResponseCode_039>            
            <CardAcceptorTerminalIdentification_041>{ $bit41 }</CardAcceptorTerminalIdentification_041>
            <CardAcceptorIdentificationCode_042>{ $bit42 }</CardAcceptorIdentificationCode_042>
            <CardAcceptorNameLocation_043>{ $bit43 }</CardAcceptorNameLocation_043>
            <AdditionalDataPrivate_048>
            {
                let $numPayments  := fn:string($reversaFinanciamiento/NUMBER_OF_PAYMENTS/text()) 
                let $fecha  := xs:dateTime($reversaFinanciamiento/CONFIRMATION_DATE/text())
                let $operacion  := fn:string($reversaFinanciamiento/OPERATION_TYPE/text()) 
                let $interestRate  := fn:string(
                        xs:int(xs:decimal($reversaFinanciamiento/INTEREST_RATE/text())*100))  
                return
                    fn:concat(
                        '021',
                        '002',
                        fn-bea:pad-left($numPayments, 3, '0'),
                        if($interestRate != '') then(
                            fn-bea:pad-left($interestRate, 5, '0')
                        )else('*****'),
                        $operacion,
                        if($operacion = 'F') then(
                            fn-bea:dateTime-to-string-with-format('yyyyMMdd',$fecha)
                        ) else (
                            fn-bea:pad-left('', 8, ' ')
                        ),
                        'M'
                    )
            }
            </AdditionalDataPrivate_048>
            <CurrencyCodeTransaction_049>{ $codMoneda }</CurrencyCodeTransaction_049>
            <ReservedNational_060>{ fn-bea:pad-left($bit60, 12, '0') }</ReservedNational_060>
            <ReservedPrivate_061>{ fn-bea:pad-left($bit61, 13, '0') }</ReservedPrivate_061>
            <ReservedPrivate_062>{ fn-bea:pad-left($bit62, 6, '0') }</ReservedPrivate_062>
            <OriginalDataElements_090>
            {
            	fn:concat(
                    '0200', (:Tipo de Transacción Original:)
                    $secOperacionOriginal,
                    fn-bea:dateTime-to-string-with-format('MMdd', $fechaOriginal ),
                    fn-bea:dateTime-to-string-with-format('HHmmss', adjust-dateTime-to-timezone($fechaOriginal,()) ),
                    '00', (: Filler :)
                    fn-bea:dateTime-to-string-with-format('MMdd', $fechaOriginal ),
                    substring($secOperacionOriginal, 7),
                    '0000' (: Filler :)
                 )
            }
            </OriginalDataElements_090> 
            <ReplacementAmounts_095>{ fn-bea:pad-right('', 42, '0') }</ReplacementAmounts_095>                       
            <ReceivingInstitutionIdentificationCode_100>{ fn-bea:pad-left($bit100, 6, '0') }</ReceivingInstitutionIdentificationCode_100>
            <AccountIdentification1_102>{ fn-bea:pad-right('', 28, '0') }</AccountIdentification1_102>
            <AccountIdentification2_103>{ fn-bea:pad-right('', 28, '0') }</AccountIdentification2_103>     
        </ISO8583_REQUEST>
    </ns1:FinanciamientoTCRequest>
};

declare variable $bit22 as xs:string external;
declare variable $bit25 as xs:string external;
declare variable $bit32 as xs:string external;
declare variable $bit41 as xs:string external;
declare variable $bit42 as xs:string external;
declare variable $bit43 as xs:string external;
declare variable $bit60 as xs:string external;
declare variable $bit61 as xs:string external;
declare variable $bit62 as xs:string external;
declare variable $bit100 as xs:string external;
declare variable $codMoneda as xs:string external;
declare variable $secOperacionOriginal as xs:string external;
declare variable $fecha as xs:dateTime external;
declare variable $fechaOriginal as xs:dateTime external;
declare variable $isoHeader as xs:string external;
declare variable $reversaFinanciamiento as element(ns0:reversaFinanciamiento) external;

xf:wsExtraFinanciamientoIn(
	$bit22,
    $bit25,
    $bit32,
    $bit41,
    $bit42,
    $bit43,
    $bit60,
    $bit61,
    $bit62,
    $bit100,
    $codMoneda,
    $secOperacionOriginal,
    $fecha,
    $fechaOriginal,
    $isoHeader,
    $reversaFinanciamiento)