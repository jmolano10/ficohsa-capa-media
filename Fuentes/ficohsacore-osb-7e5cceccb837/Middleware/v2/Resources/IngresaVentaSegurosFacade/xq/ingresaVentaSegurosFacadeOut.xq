(:: pragma bea:global-element-parameter parameter="$procesaMensajeGenericoSwitchFacadeRequest" element="ns0:procesaMensajeGenericoSwitchFacadeRequest" location="../../ProcesaMensajeGenericoSwitch/xsd/procesaMensajeGenericoSwitchFacadeTypes.xsd" ::)
(:: pragma bea:global-element-parameter parameter="$ingresaVentaSegurosResponse" element="ns1:ingresaVentaSegurosResponse" location="../../IngresaVentaSeguros/xsd/ingresaVentaSegurosTypes.xsd" ::)
(:: pragma bea:local-element-return type="ns0:procesaMensajeGenericoSwitchFacadeResponse/ISO8583" location="../../ProcesaMensajeGenericoSwitch/xsd/procesaMensajeGenericoSwitchFacadeTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoSwitchFacadeTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/middleware.services/ingresaVentaSegurosTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/IngresaVentaSeguroFacade/xq/ingresaVentaSegurosFacadeOut/";

declare function local:mtiChange($MTI as xs:string) 
	as xs:string{
		if ($MTI = '0200') 
			then ('0210') 
		elseif ($MTI='0220') 
			then ('0230') 
		elseif($MTI='0420') 
			then ('0430') 
		else('')
};

declare function xf:ingresaVentaSegurosFacadeOut($procesaMensajeGenericoSwitchFacadeRequest as element(ns0:procesaMensajeGenericoSwitchFacadeRequest),
    $ingresaVentaSegurosResponse as element(ns1:ingresaVentaSegurosResponse),
    $successIndicator as xs:string,
    $description as xs:string,
    $amount as xs:string,
    $currency as xs:string,
    $message as xs:string)
    as element() {
        <ISO8583>
            <ISO8583_HEADER>{ $procesaMensajeGenericoSwitchFacadeRequest/ISO8583/ISO8583_HEADER/@* , $procesaMensajeGenericoSwitchFacadeRequest/ISO8583/ISO8583_HEADER/node() }</ISO8583_HEADER>
            {
                let $ISO8583_XML_CONTENT := $procesaMensajeGenericoSwitchFacadeRequest/ISO8583/ISO8583_XML_CONTENT
                return
                    <ISO8583_XML_CONTENT>
                        {
                            for $MTI in $ISO8583_XML_CONTENT/MTI
                            return
                                <MTI>{ local:mtiChange(fn:string($MTI/text())) }</MTI>
                        }
                        {
                            for $PrimaryAccountNumber_002 in $ISO8583_XML_CONTENT/PrimaryAccountNumber_002
                            return
                                <PrimaryAccountNumber_002>{ data($PrimaryAccountNumber_002) }</PrimaryAccountNumber_002>
                        }
                        {
                            for $ProcessingCode_003 in $ISO8583_XML_CONTENT/ProcessingCode_003
                            return
                                <ProcessingCode_003>{ data($ProcessingCode_003) }</ProcessingCode_003>
                        }
                        {
                            for $AmountTransaction_004 in $ISO8583_XML_CONTENT/AmountTransaction_004
                            return
                                <AmountTransaction_004>{ xs:decimal(data($AmountTransaction_004)) div 100 }</AmountTransaction_004>
                        }
                        {
                            for $AmountSettlement_005 in $ISO8583_XML_CONTENT/AmountSettlement_005
                            return
                                <AmountSettlement_005>{ xs:decimal(data($AmountSettlement_005)) div 100 }</AmountSettlement_005>
                        }
                        {
                            for $AmountCardholderBilling_006 in $ISO8583_XML_CONTENT/AmountCardholderBilling_006
                            return
                                <AmountCardholderBilling_006>{ xs:decimal(data($AmountCardholderBilling_006)) div 100 }</AmountCardholderBilling_006>
                        }
                        <TransmissionDateTime_007>{ fn-bea:dateTime-to-string-with-format('MMddHHmmss', adjust-dateTime-to-timezone(current-dateTime(), ())) }</TransmissionDateTime_007>
                        {
                            for $AmountCardholderBillingFee_008 in $ISO8583_XML_CONTENT/AmountCardholderBillingFee_008
                            return
                                <AmountCardholderBillingFee_008>{ data($AmountCardholderBillingFee_008) }</AmountCardholderBillingFee_008>
                        }
                        {
                            for $ConversionRateSettlement_009 in $ISO8583_XML_CONTENT/ConversionRateSettlement_009
                            return
                                <ConversionRateSettlement_009>{ data($ConversionRateSettlement_009) }</ConversionRateSettlement_009>
                        }
                        {
                            for $ConversionRateCardholderBilling_010 in $ISO8583_XML_CONTENT/ConversionRateCardholderBilling_010
                            return
                                <ConversionRateCardholderBilling_010>{ data($ConversionRateCardholderBilling_010) }</ConversionRateCardholderBilling_010>
                        }
                        {
                            for $SystemTraceAuditNumber_011 in $ISO8583_XML_CONTENT/SystemTraceAuditNumber_011
                            return
                                <SystemTraceAuditNumber_011>{ data($SystemTraceAuditNumber_011) }</SystemTraceAuditNumber_011>
                        }
                        {
                            for $TimeLocalTransaction_012 in $ISO8583_XML_CONTENT/TimeLocalTransaction_012
                            return
                                <TimeLocalTransaction_012>{ data($TimeLocalTransaction_012) }</TimeLocalTransaction_012>
                        }
                        {
                            for $DateLocalTransaction_013 in $ISO8583_XML_CONTENT/DateLocalTransaction_013
                            return
                                <DateLocalTransaction_013>{ data($DateLocalTransaction_013) }</DateLocalTransaction_013>
                        }
                        {
                            for $DateExpiration_014 in $ISO8583_XML_CONTENT/DateExpiration_014
                            return
                                <DateExpiration_014>{ data($DateExpiration_014) }</DateExpiration_014>
                        }
                        {
                            for $DateSettlement_015 in $ISO8583_XML_CONTENT/DateSettlement_015
                            return
                                <DateSettlement_015>{ data($DateSettlement_015) }</DateSettlement_015>
                        }
                        {
                            for $DateConversion_016 in $ISO8583_XML_CONTENT/DateConversion_016
                            return
                                <DateConversion_016>{ data($DateConversion_016) }</DateConversion_016>
                        }
                        {
                            for $DateCapture_017 in $ISO8583_XML_CONTENT/DateCapture_017
                            return
                                <DateCapture_017>{ data($DateCapture_017) }</DateCapture_017>
                        }
                        {
                            for $MerchantType_018 in $ISO8583_XML_CONTENT/MerchantType_018
                            return
                                <MerchantType_018>{ data($MerchantType_018) }</MerchantType_018>
                        }
                        {
                            for $AcquiringInstitutionCountryCode_019 in $ISO8583_XML_CONTENT/AcquiringInstitutionCountryCode_019
                            return
                                <AcquiringInstitutionCountryCode_019>{ data($AcquiringInstitutionCountryCode_019) }</AcquiringInstitutionCountryCode_019>
                        }
                        {
                            for $PANExtendedCountryCode_020 in $ISO8583_XML_CONTENT/PANExtendedCountryCode_020
                            return
                                <PANExtendedCountryCode_020>{ data($PANExtendedCountryCode_020) }</PANExtendedCountryCode_020>
                        }
                        {
                            for $ForwardingInstitutionCountryCode_021 in $ISO8583_XML_CONTENT/ForwardingInstitutionCountryCode_021
                            return
                                <ForwardingInstitutionCountryCode_021>{ data($ForwardingInstitutionCountryCode_021) }</ForwardingInstitutionCountryCode_021>
                        }
                        {
                            for $PointOfServiceEntryMode_022 in $ISO8583_XML_CONTENT/PointOfServiceEntryMode_022
                            return
                                <PointOfServiceEntryMode_022>{ data($PointOfServiceEntryMode_022) }</PointOfServiceEntryMode_022>
                        }
                        {
                            for $ApplicationPANSequenceNumber_023 in $ISO8583_XML_CONTENT/ApplicationPANSequenceNumber_023
                            return
                                <ApplicationPANSequenceNumber_023>{ data($ApplicationPANSequenceNumber_023) }</ApplicationPANSequenceNumber_023>
                        }
                        {
                            for $FunctionCode_024 in $ISO8583_XML_CONTENT/FunctionCode_024
                            return
                                <FunctionCode_024>{ data($FunctionCode_024) }</FunctionCode_024>
                        }
                        {
                            for $PointOfServiceConditionCode_025 in $ISO8583_XML_CONTENT/PointOfServiceConditionCode_025
                            return
                                <PointOfServiceConditionCode_025>{ data($PointOfServiceConditionCode_025) }</PointOfServiceConditionCode_025>
                        }
                        {
                            for $PointOfServiceCaptureCode_026 in $ISO8583_XML_CONTENT/PointOfServiceCaptureCode_026
                            return
                                <PointOfServiceCaptureCode_026>{ data($PointOfServiceCaptureCode_026) }</PointOfServiceCaptureCode_026>
                        }
                        {
                            for $AuthorizingIdentificationResponseLength_027 in $ISO8583_XML_CONTENT/AuthorizingIdentificationResponseLength_027
                            return
                                <AuthorizingIdentificationResponseLength_027>{ data($AuthorizingIdentificationResponseLength_027) }</AuthorizingIdentificationResponseLength_027>
                        }
                        {
                            for $AmountTransactionFee_028 in $ISO8583_XML_CONTENT/AmountTransactionFee_028
                            return
                                <AmountTransactionFee_028>{ data($AmountTransactionFee_028) }</AmountTransactionFee_028>
                        }
                        {
                            for $AmountSettlementFee_029 in $ISO8583_XML_CONTENT/AmountSettlementFee_029
                            return
                                <AmountSettlementFee_029>{ data($AmountSettlementFee_029) }</AmountSettlementFee_029>
                        }
                        {
                            for $AmountTransactionProcessingFee_030 in $ISO8583_XML_CONTENT/AmountTransactionProcessingFee_030
                            return
                                <AmountTransactionProcessingFee_030>{ data($AmountTransactionProcessingFee_030) }</AmountTransactionProcessingFee_030>
                        }
                        {
                            for $AmountSettlementProcessingFee_031 in $ISO8583_XML_CONTENT/AmountSettlementProcessingFee_031
                            return
                                <AmountSettlementProcessingFee_031>{ data($AmountSettlementProcessingFee_031) }</AmountSettlementProcessingFee_031>
                        }
                        {
                            for $AcquiringInstitutionIdentificationCode_032 in $ISO8583_XML_CONTENT/AcquiringInstitutionIdentificationCode_032
                            return
                                <AcquiringInstitutionIdentificationCode_032>{ data($AcquiringInstitutionIdentificationCode_032) }</AcquiringInstitutionIdentificationCode_032>
                        }
                        {
                            for $ForwardingInstitutionIdentificationCode_033 in $ISO8583_XML_CONTENT/ForwardingInstitutionIdentificationCode_033
                            return
                                <ForwardingInstitutionIdentificationCode_033>{ data($ForwardingInstitutionIdentificationCode_033) }</ForwardingInstitutionIdentificationCode_033>
                        }
                        {
                            for $PrimaryAccountNumberExtended_034 in $ISO8583_XML_CONTENT/PrimaryAccountNumberExtended_034
                            return
                                <PrimaryAccountNumberExtended_034>{ data($PrimaryAccountNumberExtended_034) }</PrimaryAccountNumberExtended_034>
                        }
                        {
                            for $Track2Data_035 in $ISO8583_XML_CONTENT/Track2Data_035
                            return
                                <Track2Data_035>{ data($Track2Data_035) }</Track2Data_035>
                        }
                        {
                            for $Track3Data_036 in $ISO8583_XML_CONTENT/Track3Data_036
                            return
                                <Track3Data_036>{ data($Track3Data_036) }</Track3Data_036>
                        }
                        {
                            for $RetrievalReferenceNumber_037 in $ISO8583_XML_CONTENT/RetrievalReferenceNumber_037
                            return
                                <RetrievalReferenceNumber_037>{ data($RetrievalReferenceNumber_037) }</RetrievalReferenceNumber_037>
                        }
                        {
                            for $AuthorizationIdentificationResponse_038 in $ISO8583_XML_CONTENT/AuthorizationIdentificationResponse_038
                            return
                                <AuthorizationIdentificationResponse_038>{ data($AuthorizationIdentificationResponse_038) }</AuthorizationIdentificationResponse_038>
                        }
                        <ResponseCode_039>
                        	{
                            	if(upper-case($successIndicator) = 'SUCCESS') then(
                                	'00'
                            	) else if(upper-case($successIndicator) = 'ERROR') then(
                                	'80'
                            	) else(
                                	$successIndicator
                            	)
                       		}
                        </ResponseCode_039>
                        {
                            for $ServiceRestrictionCode_040 in $ISO8583_XML_CONTENT/ServiceRestrictionCode_040
                            return
                                <ServiceRestrictionCode_040>{ data($ServiceRestrictionCode_040) }</ServiceRestrictionCode_040>
                        }
                        {
                            for $CardAcceptorTerminalIdentification_041 in $ISO8583_XML_CONTENT/CardAcceptorTerminalIdentification_041
                            return
                                <CardAcceptorTerminalIdentification_041>{ data($CardAcceptorTerminalIdentification_041) }</CardAcceptorTerminalIdentification_041>
                        }
                        {
                            for $CardAcceptorIdentificationCode_042 in $ISO8583_XML_CONTENT/CardAcceptorIdentificationCode_042
                            return
                                <CardAcceptorIdentificationCode_042>{ data($CardAcceptorIdentificationCode_042) }</CardAcceptorIdentificationCode_042>
                        }
                        {
                            for $CardAcceptorNameLocation_043 in $ISO8583_XML_CONTENT/CardAcceptorNameLocation_043
                            return
                                <CardAcceptorNameLocation_043>{ data($CardAcceptorNameLocation_043) }</CardAcceptorNameLocation_043>
                        }
                        {
                            for $AdditionalResponseData_044 in $ISO8583_XML_CONTENT/AdditionalResponseData_044
                            return
                                <AdditionalResponseData_044>{ data($AdditionalResponseData_044) }</AdditionalResponseData_044>
                        }
                        {
                            for $Track1Data_045 in $ISO8583_XML_CONTENT/Track1Data_045
                            return
                                <Track1Data_045>{ data($Track1Data_045) }</Track1Data_045>
                        }
                        {
                            for $AdditionalDataISO_046 in $ISO8583_XML_CONTENT/AdditionalDataISO_046
                            return
                                <AdditionalDataISO_046>{ data($AdditionalDataISO_046) }</AdditionalDataISO_046>
                        }
                        {
                            for $AdditionalDataNational_047 in $ISO8583_XML_CONTENT/AdditionalDataNational_047
                            return
                                <AdditionalDataNational_047>{ data($AdditionalDataNational_047) }</AdditionalDataNational_047>
                        }
                        {
                            for $AdditionalDataPrivate_048 in $ISO8583_XML_CONTENT/AdditionalDataPrivate_048
                            return
                                <AdditionalDataPrivate_048>{ data($AdditionalDataPrivate_048) }</AdditionalDataPrivate_048>
                        }
                        {
                            for $CurrencyCodeTransaction_049 in $ISO8583_XML_CONTENT/CurrencyCodeTransaction_049
                            return
                                <CurrencyCodeTransaction_049>{ data($CurrencyCodeTransaction_049) }</CurrencyCodeTransaction_049>
                        }
                        {
                            for $CurrencyCodeSettlement_050 in $ISO8583_XML_CONTENT/CurrencyCodeSettlement_050
                            return
                                <CurrencyCodeSettlement_050>{ data($CurrencyCodeSettlement_050) }</CurrencyCodeSettlement_050>
                        }
                        {
                            for $CurrencyCodeCardholderBilling_051 in $ISO8583_XML_CONTENT/CurrencyCodeCardholderBilling_051
                            return
                                <CurrencyCodeCardholderBilling_051>{ data($CurrencyCodeCardholderBilling_051) }</CurrencyCodeCardholderBilling_051>
                        }
                        {
                            for $PersonalIdentificationNumberData_052 in $ISO8583_XML_CONTENT/PersonalIdentificationNumberData_052
                            return
                                <PersonalIdentificationNumberData_052>{ data($PersonalIdentificationNumberData_052) }</PersonalIdentificationNumberData_052>
                        }
                        {
                            for $SecurityRelatedControlInformation_053 in $ISO8583_XML_CONTENT/SecurityRelatedControlInformation_053
                            return
                                <SecurityRelatedControlInformation_053>{ data($SecurityRelatedControlInformation_053) }</SecurityRelatedControlInformation_053>
                        }
                        {
                            for $AdditionalAmounts_054 in $ISO8583_XML_CONTENT/AdditionalAmounts_054
                            return
                                <AdditionalAmounts_054>{ data($AdditionalAmounts_054) }</AdditionalAmounts_054>
                        }
                        {
                            for $ReservedISO_055 in $ISO8583_XML_CONTENT/ReservedISO_055
                            return
                                <ReservedISO_055>{ data($ReservedISO_055) }</ReservedISO_055>
                        }
                        {
                            for $ReservedISO_056 in $ISO8583_XML_CONTENT/ReservedISO_056
                            return
                                <ReservedISO_056>{ data($ReservedISO_056) }</ReservedISO_056>
                        }
                        {
                            for $ReservedNational_057 in $ISO8583_XML_CONTENT/ReservedNational_057
                            return
                                <ReservedNational_057>{ data($ReservedNational_057) }</ReservedNational_057>
                        }
                        {
                            for $ReservedNational_058 in $ISO8583_XML_CONTENT/ReservedNational_058
                            return
                                <ReservedNational_058>{ data($ReservedNational_058) }</ReservedNational_058>
                        }
                        {
                            for $ReservedNational_059 in $ISO8583_XML_CONTENT/ReservedNational_059
                            return
                                <ReservedNational_059>{ data($ReservedNational_059) }</ReservedNational_059>
                        }
                        {
                            for $ReservedNational_060 in $ISO8583_XML_CONTENT/ReservedNational_060
                            return
                                <ReservedNational_060>{ data($ReservedNational_060) }</ReservedNational_060>
                        }
                        {
                            for $ReservedPrivate_061 in $ISO8583_XML_CONTENT/ReservedPrivate_061
                            return
                                <ReservedPrivate_061>{ data($ReservedPrivate_061) }</ReservedPrivate_061>
                        }
                        {
                            for $ReservedPrivate_062 in $ISO8583_XML_CONTENT/ReservedPrivate_062
                            return
                                <ReservedPrivate_062>{ data($ReservedPrivate_062) }</ReservedPrivate_062>
                        }
                        {
                            for $ReservedPrivate_063 in $ISO8583_XML_CONTENT/ReservedPrivate_063
                            return
                                <ReservedPrivate_063>{ data($ReservedPrivate_063) }</ReservedPrivate_063>
                        }
                        {
                            for $MessageAuthenticationCode_064 in $ISO8583_XML_CONTENT/MessageAuthenticationCode_064
                            return
                                <MessageAuthenticationCode_064>{ data($MessageAuthenticationCode_064) }</MessageAuthenticationCode_064>
                        }
                        {
                            for $BitmapExtended_065 in $ISO8583_XML_CONTENT/BitmapExtended_065
                            return
                                <BitmapExtended_065>{ data($BitmapExtended_065) }</BitmapExtended_065>
                        }
                        {
                            for $SettlementCode_066 in $ISO8583_XML_CONTENT/SettlementCode_066
                            return
                                <SettlementCode_066>{ data($SettlementCode_066) }</SettlementCode_066>
                        }
                        {
                            for $ExtendedPaymentCode_067 in $ISO8583_XML_CONTENT/ExtendedPaymentCode_067
                            return
                                <ExtendedPaymentCode_067>{ data($ExtendedPaymentCode_067) }</ExtendedPaymentCode_067>
                        }
                        {
                            for $ReceivingInstitutionCountryCode_068 in $ISO8583_XML_CONTENT/ReceivingInstitutionCountryCode_068
                            return
                                <ReceivingInstitutionCountryCode_068>{ data($ReceivingInstitutionCountryCode_068) }</ReceivingInstitutionCountryCode_068>
                        }
                        {
                            for $SettlementInstitutionCountryCode_069 in $ISO8583_XML_CONTENT/SettlementInstitutionCountryCode_069
                            return
                                <SettlementInstitutionCountryCode_069>{ data($SettlementInstitutionCountryCode_069) }</SettlementInstitutionCountryCode_069>
                        }
                        {
                            for $NetworkManagementInformationCode_070 in $ISO8583_XML_CONTENT/NetworkManagementInformationCode_070
                            return
                                <NetworkManagementInformationCode_070>{ data($NetworkManagementInformationCode_070) }</NetworkManagementInformationCode_070>
                        }
                        {
                            for $MessageNumber_071 in $ISO8583_XML_CONTENT/MessageNumber_071
                            return
                                <MessageNumber_071>{ data($MessageNumber_071) }</MessageNumber_071>
                        }
                        {
                            for $MessageNumberLast_072 in $ISO8583_XML_CONTENT/MessageNumberLast_072
                            return
                                <MessageNumberLast_072>{ data($MessageNumberLast_072) }</MessageNumberLast_072>
                        }
                        {
                            for $DateAction_073 in $ISO8583_XML_CONTENT/DateAction_073
                            return
                                <DateAction_073>{ data($DateAction_073) }</DateAction_073>
                        }
                        {
                            for $CreditsNumber_074 in $ISO8583_XML_CONTENT/CreditsNumber_074
                            return
                                <CreditsNumber_074>{ data($CreditsNumber_074) }</CreditsNumber_074>
                        }
                        {
                            for $CreditsReversalNumber_075 in $ISO8583_XML_CONTENT/CreditsReversalNumber_075
                            return
                                <CreditsReversalNumber_075>{ data($CreditsReversalNumber_075) }</CreditsReversalNumber_075>
                        }
                        {
                            for $DebitsNumber_076 in $ISO8583_XML_CONTENT/DebitsNumber_076
                            return
                                <DebitsNumber_076>{ data($DebitsNumber_076) }</DebitsNumber_076>
                        }
                        {
                            for $DebitsReversalNumber_077 in $ISO8583_XML_CONTENT/DebitsReversalNumber_077
                            return
                                <DebitsReversalNumber_077>{ data($DebitsReversalNumber_077) }</DebitsReversalNumber_077>
                        }
                        {
                            for $TransferNumber_078 in $ISO8583_XML_CONTENT/TransferNumber_078
                            return
                                <TransferNumber_078>{ data($TransferNumber_078) }</TransferNumber_078>
                        }
                        {
                            for $TransferReversalNumber_079 in $ISO8583_XML_CONTENT/TransferReversalNumber_079
                            return
                                <TransferReversalNumber_079>{ data($TransferReversalNumber_079) }</TransferReversalNumber_079>
                        }
                        {
                            for $InquiriesNumber_080 in $ISO8583_XML_CONTENT/InquiriesNumber_080
                            return
                                <InquiriesNumber_080>{ data($InquiriesNumber_080) }</InquiriesNumber_080>
                        }
                        {
                            for $AuthorizationsNumber_081 in $ISO8583_XML_CONTENT/AuthorizationsNumber_081
                            return
                                <AuthorizationsNumber_081>{ data($AuthorizationsNumber_081) }</AuthorizationsNumber_081>
                        }
                        {
                            for $CreditsProcessingFeeAmount_082 in $ISO8583_XML_CONTENT/CreditsProcessingFeeAmount_082
                            return
                                <CreditsProcessingFeeAmount_082>{ data($CreditsProcessingFeeAmount_082) }</CreditsProcessingFeeAmount_082>
                        }
                        {
                            for $CreditsTransactionFeeAmount_083 in $ISO8583_XML_CONTENT/CreditsTransactionFeeAmount_083
                            return
                                <CreditsTransactionFeeAmount_083>{ data($CreditsTransactionFeeAmount_083) }</CreditsTransactionFeeAmount_083>
                        }
                        {
                            for $DebitsProcessingFeeAmount_084 in $ISO8583_XML_CONTENT/DebitsProcessingFeeAmount_084
                            return
                                <DebitsProcessingFeeAmount_084>{ data($DebitsProcessingFeeAmount_084) }</DebitsProcessingFeeAmount_084>
                        }
                        {
                            for $DebitsTransactionFeeAmount_085 in $ISO8583_XML_CONTENT/DebitsTransactionFeeAmount_085
                            return
                                <DebitsTransactionFeeAmount_085>{ data($DebitsTransactionFeeAmount_085) }</DebitsTransactionFeeAmount_085>
                        }
                        {
                            for $CreditsAmount_086 in $ISO8583_XML_CONTENT/CreditsAmount_086
                            return
                                <CreditsAmount_086>{ data($CreditsAmount_086) }</CreditsAmount_086>
                        }
                        {
                            for $CreditsReversalAmount_087 in $ISO8583_XML_CONTENT/CreditsReversalAmount_087
                            return
                                <CreditsReversalAmount_087>{ data($CreditsReversalAmount_087) }</CreditsReversalAmount_087>
                        }
                        {
                            for $DebitsAmount_088 in $ISO8583_XML_CONTENT/DebitsAmount_088
                            return
                                <DebitsAmount_088>{ data($DebitsAmount_088) }</DebitsAmount_088>
                        }
                        {
                            for $DebitsReversalAmount_089 in $ISO8583_XML_CONTENT/DebitsReversalAmount_089
                            return
                                <DebitsReversalAmount_089>{ data($DebitsReversalAmount_089) }</DebitsReversalAmount_089>
                        }
                        {
                            for $OriginalDataElements_090 in $ISO8583_XML_CONTENT/OriginalDataElements_090
                            return
                                <OriginalDataElements_090>{ data($OriginalDataElements_090) }</OriginalDataElements_090>
                        }
                        {
                            for $FileUpdateCode_091 in $ISO8583_XML_CONTENT/FileUpdateCode_091
                            return
                                <FileUpdateCode_091>{ data($FileUpdateCode_091) }</FileUpdateCode_091>
                        }
                        {
                            for $FileSecurityCode_092 in $ISO8583_XML_CONTENT/FileSecurityCode_092
                            return
                                <FileSecurityCode_092>{ data($FileSecurityCode_092) }</FileSecurityCode_092>
                        }
                        {
                            for $ResponseIndicator_093 in $ISO8583_XML_CONTENT/ResponseIndicator_093
                            return
                                <ResponseIndicator_093>{ data($ResponseIndicator_093) }</ResponseIndicator_093>
                        }
                        {
                            for $ServiceIndicator_094 in $ISO8583_XML_CONTENT/ServiceIndicator_094
                            return
                                <ServiceIndicator_094>{ data($ServiceIndicator_094) }</ServiceIndicator_094>
                        }
                        {
                            for $ReplacementAmounts_095 in $ISO8583_XML_CONTENT/ReplacementAmounts_095
                            return
                                <ReplacementAmounts_095>{ data($ReplacementAmounts_095) }</ReplacementAmounts_095>
                        }
                        {
                            for $MessageSecurityCode_096 in $ISO8583_XML_CONTENT/MessageSecurityCode_096
                            return
                                <MessageSecurityCode_096>{ data($MessageSecurityCode_096) }</MessageSecurityCode_096>
                        }
                        {
                            for $AmountNetSettlement_097 in $ISO8583_XML_CONTENT/AmountNetSettlement_097
                            return
                                <AmountNetSettlement_097>{ data($AmountNetSettlement_097) }</AmountNetSettlement_097>
                        }
                        {
                            for $Payee_098 in $ISO8583_XML_CONTENT/Payee_098
                            return
                                <Payee_098>{ data($Payee_098) }</Payee_098>
                        }
                        {
                            for $SettlementInstitutionIdentificationCode_099 in $ISO8583_XML_CONTENT/SettlementInstitutionIdentificationCode_099
                            return
                                <SettlementInstitutionIdentificationCode_099>{ data($SettlementInstitutionIdentificationCode_099) }</SettlementInstitutionIdentificationCode_099>
                        }
                        {
                            for $ReceivingInstitutionIdentificationCode_100 in $ISO8583_XML_CONTENT/ReceivingInstitutionIdentificationCode_100
                            return
                                <ReceivingInstitutionIdentificationCode_100>{ data($ReceivingInstitutionIdentificationCode_100) }</ReceivingInstitutionIdentificationCode_100>
                        }
                        {
                            for $FileName_101 in $ISO8583_XML_CONTENT/FileName_101
                            return
                                <FileName_101>{ data($FileName_101) }</FileName_101>
                        }
                        {
                            for $AccountIdentification1_102 in $ISO8583_XML_CONTENT/AccountIdentification1_102
                            return
                                <AccountIdentification1_102>{ data($AccountIdentification1_102) }</AccountIdentification1_102>
                        }
                        {
                            for $AccountIdentification2_103 in $ISO8583_XML_CONTENT/AccountIdentification2_103
                            return
                                <AccountIdentification2_103>{ data($AccountIdentification2_103) }</AccountIdentification2_103>
                        }
                        {
                            for $TransactionDescription_104 in $ISO8583_XML_CONTENT/TransactionDescription_104
                            return
                                <TransactionDescription_104>{ data($TransactionDescription_104) }</TransactionDescription_104>
                        }
                        {
                            for $ReservedForISOUse_105 in $ISO8583_XML_CONTENT/ReservedForISOUse_105
                            return
                                <ReservedForISOUse_105>{ data($ReservedForISOUse_105) }</ReservedForISOUse_105>
                        }
                        {
                            for $ReservedForISOUse_106 in $ISO8583_XML_CONTENT/ReservedForISOUse_106
                            return
                                <ReservedForISOUse_106>{ data($ReservedForISOUse_106) }</ReservedForISOUse_106>
                        }
                        {
                            for $ReservedForISOUse_107 in $ISO8583_XML_CONTENT/ReservedForISOUse_107
                            return
                                <ReservedForISOUse_107>{ data($ReservedForISOUse_107) }</ReservedForISOUse_107>
                        }
                        {
                            for $ReservedForISOUse_108 in $ISO8583_XML_CONTENT/ReservedForISOUse_108
                            return
                                <ReservedForISOUse_108>{ data($ReservedForISOUse_108) }</ReservedForISOUse_108>
                        }
                        {
                            for $ReservedForISOUse_109 in $ISO8583_XML_CONTENT/ReservedForISOUse_109
                            return
                                <ReservedForISOUse_109>{ data($ReservedForISOUse_109) }</ReservedForISOUse_109>
                        }
                        {
                            for $ReservedForISOUse_110 in $ISO8583_XML_CONTENT/ReservedForISOUse_110
                            return
                                <ReservedForISOUse_110>{ data($ReservedForISOUse_110) }</ReservedForISOUse_110>
                        }
                        {
                            for $ReservedForISOUse_111 in $ISO8583_XML_CONTENT/ReservedForISOUse_111
                            return
                                <ReservedForISOUse_111>{ data($ReservedForISOUse_111) }</ReservedForISOUse_111>
                        }
                        {
                            for $ReservedForNationalUse_112 in $ISO8583_XML_CONTENT/ReservedForNationalUse_112
                            return
                                <ReservedForNationalUse_112>{ data($ReservedForNationalUse_112) }</ReservedForNationalUse_112>
                        }
                        {
                            for $ReservedForNationalUse_113 in $ISO8583_XML_CONTENT/ReservedForNationalUse_113
                            return
                                <ReservedForNationalUse_113>{ data($ReservedForNationalUse_113) }</ReservedForNationalUse_113>
                        }
                        {
                            for $ReservedForNationalUse_114 in $ISO8583_XML_CONTENT/ReservedForNationalUse_114
                            return
                                <ReservedForNationalUse_114>{ data($ReservedForNationalUse_114) }</ReservedForNationalUse_114>
                        }
                        {
                            for $ReservedForNationalUse_115 in $ISO8583_XML_CONTENT/ReservedForNationalUse_115
                            return
                                <ReservedForNationalUse_115>{ data($ReservedForNationalUse_115) }</ReservedForNationalUse_115>
                        }
                        {
                            for $ReservedForNationalUse_116 in $ISO8583_XML_CONTENT/ReservedForNationalUse_116
                            return
                                <ReservedForNationalUse_116>{ data($ReservedForNationalUse_116) }</ReservedForNationalUse_116>
                        }
                        {
                            for $ReservedForNationalUse_117 in $ISO8583_XML_CONTENT/ReservedForNationalUse_117
                            return
                                <ReservedForNationalUse_117>{ data($ReservedForNationalUse_117) }</ReservedForNationalUse_117>
                        }
                        {
                            for $ReservedForNationalUse_118 in $ISO8583_XML_CONTENT/ReservedForNationalUse_118
                            return
                                <ReservedForNationalUse_118>{ data($ReservedForNationalUse_118) }</ReservedForNationalUse_118>
                        }
                        {
                            for $ReservedForNationalUse_119 in $ISO8583_XML_CONTENT/ReservedForNationalUse_119
                            return
                                <ReservedForNationalUse_119>{ data($ReservedForNationalUse_119) }</ReservedForNationalUse_119>
                        }
                        {
                            for $ReservedForPrivateUse_120 in $ISO8583_XML_CONTENT/ReservedForPrivateUse_120
                            return
                                <ReservedForPrivateUse_120>{ data($ReservedForPrivateUse_120) }</ReservedForPrivateUse_120>
                        }
                        {
     						if(upper-case($successIndicator) = 'SUCCESS') then(
     							<ReservedForPrivateUse_121>
        							{ 
            							fn:concat(
                    						'TRANSACCION      : ', $description, ';', 
                    						'POLIZA/CERT.     : ', $ingresaVentaSegurosResponse/INSURANCE_POLICY_CODE/text(), '/', $ingresaVentaSegurosResponse/CERTIFICATE_NUMBER/text(), ';',
                    						'COBRO DE SEGURO  : ', $currency, ' ', $amount, ';',
                    						'NUM. DE CONTACTO : ', '****', fn:substring(fn:tokenize($ISO8583_XML_CONTENT/AdditionalDataPrivate_048/text(),"\|\|")[2],fn:string-length(fn:tokenize($ISO8583_XML_CONTENT/AdditionalDataPrivate_048/text(),"\|\|")[2])-3), ';',
                    						' ;',
                    						$message,';'
                						) 
            						}
     							</ReservedForPrivateUse_121>
     						) else(
          						<ReservedForPrivateUse_121></ReservedForPrivateUse_121>
     						)
						}
                        {
                            for $ReservedForPrivateUse_122 in $ISO8583_XML_CONTENT/ReservedForPrivateUse_122
                            return
                                <ReservedForPrivateUse_122>{ data($ReservedForPrivateUse_122) }</ReservedForPrivateUse_122>
                        }
                        {
                            for $ReservedForPrivateUse_123 in $ISO8583_XML_CONTENT/ReservedForPrivateUse_123
                            return
                                <ReservedForPrivateUse_123>{ data($ReservedForPrivateUse_123) }</ReservedForPrivateUse_123>
                        }
                        {
                            for $ReservedForPrivateUse_124 in $ISO8583_XML_CONTENT/ReservedForPrivateUse_124
                            return
                                <ReservedForPrivateUse_124>{ data($ReservedForPrivateUse_124) }</ReservedForPrivateUse_124>
                        }
                        {
                            for $ReservedForPrivateUse_125 in $ISO8583_XML_CONTENT/ReservedForPrivateUse_125
                            return
                                <ReservedForPrivateUse_125>{ data($ReservedForPrivateUse_125) }</ReservedForPrivateUse_125>
                        }
                        {
                            for $ReservedForPrivateUse_126 in $ISO8583_XML_CONTENT/ReservedForPrivateUse_126
                            return
                                <ReservedForPrivateUse_126>{ data($ReservedForPrivateUse_126) }</ReservedForPrivateUse_126>
                        }
                        {
                            for $ReservedForPrivateUse_127 in $ISO8583_XML_CONTENT/ReservedForPrivateUse_127
                            return
                                <ReservedForPrivateUse_127>{ data($ReservedForPrivateUse_127) }</ReservedForPrivateUse_127>
                        }
                        {
                            for $MessageAuthenticationCode_128 in $ISO8583_XML_CONTENT/MessageAuthenticationCode_128
                            return
                                <MessageAuthenticationCode_128>{ data($MessageAuthenticationCode_128) }</MessageAuthenticationCode_128>
                        }
                    </ISO8583_XML_CONTENT>
            }
        </ISO8583>
};

declare variable $procesaMensajeGenericoSwitchFacadeRequest as element(ns0:procesaMensajeGenericoSwitchFacadeRequest) external;
declare variable $ingresaVentaSegurosResponse as element(ns1:ingresaVentaSegurosResponse) external;
declare variable $successIndicator as xs:string external;
declare variable $description as xs:string external;
declare variable $amount as xs:string external;
declare variable $currency as xs:string external;
declare variable $message as xs:string external;

xf:ingresaVentaSegurosFacadeOut($procesaMensajeGenericoSwitchFacadeRequest,
    $ingresaVentaSegurosResponse,
    $successIndicator,
    $description,
    $amount,
    $currency,
    $message)