(:: pragma bea:global-element-parameter parameter="$procesaFinanciamiento" element="ns0:procesaFinanciamiento" location="../../FinanciamientoTC/xsd/financiamientoTCTypes.xsd" ::)
(:: pragma bea:global-element-return element="wsExtraFinanciamientoRequest" location="../../../BusinessServices/VASA/extrafinanciamiento/wsdl/wsdlFinanciamientoTC.wsdl" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/financiamientoTCTypes";
declare namespace ns1 = "http://co.com.cidenet/schema/FinanciamientoTC";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaFinanciamiento/xq/wsExtraFinanciamientoIn/";

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
    $BIT22 as xs:string,
    $BIT25 as xs:string,
    $BIT32 as xs:string,
    $BIT41 as xs:string,
    $BIT42 as xs:string,
    $BIT43 as xs:string,
    $BIT60 as xs:string,
    $BIT61 as xs:string,
    $BIT62 as xs:string,
    $BIT100 as xs:string,
    $BIT120 as xs:string,
    $currency as xs:string,
    $fecha as xs:dateTime,
    $isoHeader as xs:string,
    $procesaFinanciamiento as element(ns0:procesaFinanciamiento))
    as element(ns1:FinanciamientoTCRequest) {
	    <ns1:FinanciamientoTCRequest>
	    	<ISO8583_HEADER>{ $isoHeader }</ISO8583_HEADER>
	        <ISO8583_REQUEST>
	            <MTI>0200</MTI>
	            <PrimaryAccountNumber_002>{ fn-bea:pad-left(data($procesaFinanciamiento/CARD_NUMBER), 16, '0') }</PrimaryAccountNumber_002>
	            <ProcessingCode_003>{getBit3(string($procesaFinanciamiento/CREDIT_LINE/text()),(string($procesaFinanciamiento/RATE_CLASS/text())))}</ProcessingCode_003>
	            <AmountTransaction_004>{ xs:decimal(data($procesaFinanciamiento/REQUEST_AMOUNT)) * 100 }</AmountTransaction_004>
	            <TransmissionDateTime_007>{(fn-bea:dateTime-to-string-with-format('MMddHHmmss', $fecha)) }</TransmissionDateTime_007>
            	<SystemTraceAuditNumber_011>{ substring($procesaFinanciamiento/INTERFACE_REFERENCE_NO/text(), 7) }</SystemTraceAuditNumber_011> (:Secuencia:)
            	<TimeLocalTransaction_012>{ fn-bea:dateTime-to-string-with-format('HHmmss', $fecha)}</TimeLocalTransaction_012>
            	<DateLocalTransaction_013>{(fn-bea:dateTime-to-string-with-format('MMdd', $fecha))}</DateLocalTransaction_013>
            	<DateExpiration_014>{ data($procesaFinanciamiento/EXPIRATION_DATE) }</DateExpiration_014>
           		<DateCapture_017>{(fn-bea:dateTime-to-string-with-format('MMdd', $fecha))}</DateCapture_017>          
	            <PointOfServiceEntryMode_022>{ $BIT22 }</PointOfServiceEntryMode_022>
	            <PointOfServiceConditionCode_025>{ $BIT25 }</PointOfServiceConditionCode_025>
	            <AcquiringInstitutionIdentificationCode_032>{ fn-bea:pad-left($BIT32, 6, '0') }</AcquiringInstitutionIdentificationCode_032>
	            <RetrievalReferenceNumber_037>{ string($procesaFinanciamiento/INTERFACE_REFERENCE_NO/text()) }</RetrievalReferenceNumber_037>
	            <CardAcceptorTerminalIdentification_041>{ $BIT41 }</CardAcceptorTerminalIdentification_041>
	            <CardAcceptorIdentificationCode_042>{ $BIT42 }</CardAcceptorIdentificationCode_042>
	            <CardAcceptorNameLocation_043>{ $BIT43 }</CardAcceptorNameLocation_043>
	            <AdditionalDataPrivate_048>
	            {
	            	let $tipo := fn:string($procesaFinanciamiento/PROCESSING_TYPE/text())
	            	let $fecha := fn:string($procesaFinanciamiento/CONFIRMATION_DATE/text())
	            	let $interesRate := xs:int(xs:double(fn:string($procesaFinanciamiento/INTEREST_RATE/text())) * 100)
	                return
		            	fn:concat(
		                	'021',
		                    '002',
		                    fn-bea:pad-left(fn:string($procesaFinanciamiento/NUMBER_OF_PAYMENTS/text()), 3, '0'),
		                    (
			                    if(fn:string($procesaFinanciamiento/INTEREST_RATE/text()) != '') then (
			                    	fn-bea:pad-left(string($interesRate), 5, '0')
			                    )else (
			                    	'*****'
			                    )
		                    ),		                    
	                    	if($tipo = 'IMMEDIATE') then(
	                    		'E'
	                    	) else (
	                    		'F'
	                    	),
	                    	if($tipo = 'DEFERRED') then(
		                    	$fecha (:Dede ser mayor a la fecha actual:)
		                    ) else (
		                    	fn-bea:pad-right('', 8, ' ') (:Ocho espacios en blanco:)
		                    ),
		                    'M'
		            	)
	            }
				</AdditionalDataPrivate_048>
	            <CurrencyCodeTransaction_049>{ $currency }</CurrencyCodeTransaction_049>
	            <ReservedISO_055>
				{
	           		for $securityCode  in (fn:string($procesaFinanciamiento/SECURITY_CODE/text()))  
	           		return
	               		if ($securityCode = '') then
	                   		('999')
	               		else
	                   	fn-bea:pad-right($securityCode, 3, ' ')
	            }
	            </ReservedISO_055>
	            <ReservedNational_060>{ fn-bea:pad-left($BIT60, 12, '0') }</ReservedNational_060>
	            <ReservedPrivate_061>{ fn-bea:pad-left($BIT61, 13, '0') }</ReservedPrivate_061>
	            <ReservedPrivate_062>{ fn-bea:pad-left($BIT62, 6, '0') }</ReservedPrivate_062>
	            <ReceivingInstitutionIdentificationCode_100>{ fn-bea:pad-left($BIT100, 6, '0') }</ReceivingInstitutionIdentificationCode_100>
	           	<ReservedForPrivateUse_120>{ fn-bea:pad-right($BIT120, 41, ' ') }</ReservedForPrivateUse_120>
	        </ISO8583_REQUEST>
	    </ns1:FinanciamientoTCRequest>
};

declare variable $BIT22 as xs:string external;
declare variable $BIT25 as xs:string external;
declare variable $BIT32 as xs:string external;
declare variable $BIT41 as xs:string external;
declare variable $BIT42 as xs:string external;
declare variable $BIT43 as xs:string external;
declare variable $BIT60 as xs:string external;
declare variable $BIT61 as xs:string external;
declare variable $BIT62 as xs:string external;
declare variable $BIT100 as xs:string external;
declare variable $BIT120 as xs:string external;
declare variable $currency as xs:string external;
declare variable $fecha as xs:dateTime external;
declare variable $isoHeader as xs:string external;
declare variable $procesaFinanciamiento as element(ns0:procesaFinanciamiento) external;

xf:wsExtraFinanciamientoIn(
	$BIT22,
    $BIT25,
    $BIT32,
    $BIT41,
    $BIT42,
    $BIT43,
    $BIT60,
    $BIT61,
    $BIT62,
    $BIT100,
    $BIT120,
    $currency,
    $fecha,
    $isoHeader,
    $procesaFinanciamiento)