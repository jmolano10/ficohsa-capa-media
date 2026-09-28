(:: pragma bea:global-element-parameter parameter="$consultaFinanciamiento" element="ns0:consultaFinanciamiento" location="../../FinanciamientoTC/xsd/financiamientoTCTypes.xsd" ::)
(:: pragma bea:global-element-return element="wsExtraFinanciamientoRequest" location="../../../BusinessServices/VASA/extrafinanciamiento/wsdl/wsdlFinanciamientoTC.wsdl" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/financiamientoTCTypes";
declare namespace ns1 = "http://co.com.cidenet/schema/FinanciamientoTC";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaFinanciamientoTC/xq/wsExtraFinanciamientoIn/";

declare function getBit3 ($CREDIT_LINE as xs:string, $RATE_CLASS as  xs:string)  as xs:string {
	(
		if($CREDIT_LINE = 'EXTERNAL') then (
			if($RATE_CLASS = '1') then (
				'010021'		
			) else(
				'010022'		
			)
		) else(
			if($RATE_CLASS = '1') then (
				'010023'	
			) else(
				'010024'		
			)	
		)
	)
		    
 };

declare function xf:wsExtraFinanciamientoIn($consultaFinanciamiento as element(ns0:consultaFinanciamiento),
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
    $bit120 as xs:string,
    $codigoMoneda as xs:string,
    $isoHeader as xs:string,
    $fecha as xs:dateTime )
    as element(ns1:FinanciamientoTCRequest) {
    <ns1:FinanciamientoTCRequest>
    	<ISO8583_HEADER>{ $isoHeader }</ISO8583_HEADER>
        <ISO8583_REQUEST>
       		<MTI>0200</MTI>
            <PrimaryAccountNumber_002>{ fn-bea:pad-left(data($consultaFinanciamiento/CARD_NUMBER), 16, '0') }</PrimaryAccountNumber_002>
            <ProcessingCode_003>{ getBit3($consultaFinanciamiento/CREDIT_LINE , $consultaFinanciamiento/RATE_CLASS) }</ProcessingCode_003>
            <AmountTransaction_004>{ xs:decimal(fn:string($consultaFinanciamiento/REQUEST_AMOUNT/text())) * 100 }</AmountTransaction_004>
			<TransmissionDateTime_007>{ fn-bea:dateTime-to-string-with-format('MMddHHmmss', $fecha ) }</TransmissionDateTime_007>
        	<SystemTraceAuditNumber_011>{ substring($consultaFinanciamiento/INTERFACE_REFERENCE_NO/text(),7) }</SystemTraceAuditNumber_011> (:Secuencia de 6 digitos:)
            <TimeLocalTransaction_012>{ fn-bea:dateTime-to-string-with-format('HHmmss', $fecha ) }</TimeLocalTransaction_012>
            <DateLocalTransaction_013>{ fn-bea:dateTime-to-string-with-format('MMdd', $fecha ) }</DateLocalTransaction_013>
            <DateExpiration_014>{ string($consultaFinanciamiento/EXPIRATION_DATE/text()) }</DateExpiration_014>
            <DateCapture_017>{ fn-bea:dateTime-to-string-with-format('MMdd', $fecha ) }</DateCapture_017>     
            <PointOfServiceEntryMode_022>{ $bit22 }</PointOfServiceEntryMode_022>
            <PointOfServiceConditionCode_025>{ $bit25 }</PointOfServiceConditionCode_025>
            <AcquiringInstitutionIdentificationCode_032>{ fn-bea:pad-left($bit32, 6, '0') }</AcquiringInstitutionIdentificationCode_032>
            <RetrievalReferenceNumber_037>{ string($consultaFinanciamiento/INTERFACE_REFERENCE_NO/text()) } </RetrievalReferenceNumber_037>
            <CardAcceptorTerminalIdentification_041>{ $bit41 }</CardAcceptorTerminalIdentification_041>
            <CardAcceptorIdentificationCode_042>{ $bit42 }</CardAcceptorIdentificationCode_042>
            <CardAcceptorNameLocation_043>{ $bit43 }</CardAcceptorNameLocation_043>
            <AdditionalDataPrivate_048>
	        {
	            let $numPayments  := (fn:string( $consultaFinanciamiento/NUMBER_OF_PAYMENTS/text()))  
	            let $interestRate  := (fn:string(xs:int(xs:decimal( $consultaFinanciamiento/INTEREST_RATE/text())*100)))  
	            return
	                fn:concat(
	                	'021',
	                	'002',
	                	fn-bea:pad-left($numPayments, 3, '0'),
	                	if($interestRate != '') then(
	                		fn-bea:pad-left($interestRate, 5, '0')
	                	)else('*****'),
	                		'S',
	                		fn-bea:pad-right('', 8, ' '), (:Ocho espacios en blanco:)
	                		'M'
	                )
	         }
			</AdditionalDataPrivate_048>
            <CurrencyCodeTransaction_049>{ $codigoMoneda }</CurrencyCodeTransaction_049>
            <ReservedISO_055>
            {
           		for $securityCode  in (fn:string($consultaFinanciamiento/SECURITY_CODE/text()))  
           		return
               		if ($securityCode = '') then
                   		('999')
               		else
                   		fn-bea:pad-right($securityCode, 3, ' ')
            }
            </ReservedISO_055>
            <ReservedNational_060>{ fn-bea:pad-left($bit60, 12, '0')  }</ReservedNational_060>
            <ReservedPrivate_061>{ fn-bea:pad-left($bit61, 13, '0')  }</ReservedPrivate_061>
            <ReservedPrivate_062>{ fn-bea:pad-left($bit62, 6, '0') }</ReservedPrivate_062>
            <ReceivingInstitutionIdentificationCode_100>{ fn-bea:pad-left($bit100, 6, '0') }</ReceivingInstitutionIdentificationCode_100> 
            <ReservedForPrivateUse_120>{ fn-bea:pad-right($bit120, 41, ' ') }</ReservedForPrivateUse_120>          
         </ISO8583_REQUEST>
    </ns1:FinanciamientoTCRequest>
};

declare variable $consultaFinanciamiento as element(ns0:consultaFinanciamiento) external;
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
declare variable $bit120 as xs:string external;
declare variable $codigoMoneda as xs:string external;
declare variable $isoHeader as xs:string external;
declare variable $fecha as xs:dateTime external;

xf:wsExtraFinanciamientoIn($consultaFinanciamiento,
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
    $bit120,
    $codigoMoneda,
    $isoHeader,
    $fecha)