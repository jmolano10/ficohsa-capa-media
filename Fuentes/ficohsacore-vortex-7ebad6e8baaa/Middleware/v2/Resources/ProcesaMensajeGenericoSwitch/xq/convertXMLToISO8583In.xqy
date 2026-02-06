xquery version "2004-draft";
(:: pragma  parameter="$anyType" type="anyType" ::)
(:: pragma bea:global-element-return element="ns0:convertXMLToISO8583Request" location="../../../BusinessServices/Switch/iso8583ConverterMultiple/wsdl/iso8583ConverterMultiple.wsdl" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/schema/iso8583ConverterMultipleTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoSwitch/xq/convertXMLToISO8583In/";

declare function xf:convertXMLToISO8583In($anyType as element(*))
    as element(ns0:convertXMLToISO8583Request) {
        <ns0:convertXMLToISO8583Request>
            <iso8583>
                <iso8583Item>
                    <headerMessageDetails>
                    {
                    if($anyType/ISO8583_XML_CONTENT/MTI)then(
                        <item>
                            <key>MESSAGE_TYPE_INDICATOR</key>
                            <value>{ data($anyType/ISO8583_XML_CONTENT/MTI)  }</value>
                        </item>
                        )else()
                        }
                    </headerMessageDetails>
                    <bodyMessageDetails>
                     {
                         let $request := $anyType/ISO8583_XML_CONTENT
                         return
                         (
                           if($request/PrimaryAccountNumber_002)then(
                         <item>
                             <key>PRIMARY_ACCOUNT_NUMBER</key>
                             <value>{ data($request/PrimaryAccountNumber_002) }</value>
                         </item>
                         )else(),
                         
                          if($request/ProcessingCode_003)then(
                         <item>
                             <key>PROCESSING_CODE</key>
                             <value>{ data($request/ProcessingCode_003) }</value>
                         </item>
                         )else(),
                         
                          if($request/AmountTransaction_004)then(
                         <item>
                             <key>TRANSACTION_AMOUNT</key>
                             <value>{ data($request/AmountTransaction_004) }</value>
                         </item>
                         )else(),                         
                         
                          if($request/AmountSettlement_005)then(
                         <item>
                             <key>SETTLEMENT_AMOUNT</key>
                             <value>{ data($request/AmountSettlement_005) }</value>
                         </item>
                         )else(),                         
                         
                          if($request/AmountCardholderBilling_006)then(
                         <item>
                             <key>CARDHOLDER_BILLING_AMOUNT</key>
                             <value>{ data($request/AmountCardholderBilling_006) }</value>
                         </item>
                         )else(),                         
                         
                          if($request/TransmissionDateTime_007)then(
                         <item>
                             <key>TRANSMISSION_DATETIME</key>
                             <value>{ data($request/TransmissionDateTime_007) }</value>
                         </item>
                         )else(),                         
                         
                          if($request/AmountCardholderBillingFee_008)then(
                         <item>
                             <key>CARDHOLDER_BILLING_FEE_AMOUNT</key>
                             <value>{ data($request/AmountCardholderBillingFee_008) }</value>
                         </item>
                         )else(),                         
                         
                          if($request/ConversionRateSettlement_009)then(
                         <item>
                             <key>SETTLEMENT_CONVERSION_RATE</key>
                             <value>{ data($request/ConversionRateSettlement_009) }</value>
                         </item>
                         )else(),                         
                         
                          if($request/ConversionRateCardholderBilling_010)then(
                         <item>
                             <key>CARDHOLDER_BILLING_CONVERSION_RATE</key>
                             <value>{ data($request/ConversionRateCardholderBilling_010) }</value>
                         </item>
                         )else(),                         
                         
                           if($request/SystemTraceAuditNumber_011)then(
                         <item>
                             <key>SYSTEMS_TRACE_AUDIT_NUMBER</key>
                             <value>{ data($request/SystemTraceAuditNumber_011) }</value>
                         </item>
                         )else(),                        
                         
                          if($request/TimeLocalTransaction_012)then(
                         <item>
                             <key>LOCAL_TRANSACTION_TIME</key>
                             <value>{ data($request/TimeLocalTransaction_012) }</value>
                         </item>
                         )else(),                         
                         
                            if($request/DateLocalTransaction_013)then(
                         <item>
                             <key>LOCAL_TRANSACTION_DATE</key>
                             <value>{ data($request/DateLocalTransaction_013) }</value>
                         </item>
                         )else(),                       
                         
                          if($request/DateExpiration_014)then(
                         <item>
                             <key>EXPIRATION_DATE</key>
                             <value>{ data($request/DateExpiration_014) }</value>
                         </item>
                         )else(),                         
                         
                          if($request/DateSettlement_015)then(
                         <item>
                             <key>SETTLEMENT_DATE</key>
                             <value>{ data($request/DateSettlement_015) }</value>
                         </item>
                         )else(),                         
                         
                            if($request/DateConversion_016)then(
                         <item>
                             <key>CONVERSION_DATE</key>
                             <value>{ data($request/DateConversion_016) }</value>
                         </item>
                         )else(),                       
                         
                            if($request/DateCapture_017)then(
                         <item>
                             <key>CAPTURE_DATE</key>
                             <value>{ data($request/DateCapture_017) }</value>
                         </item>
                         )else(),                       
                         
                            if($request/MerchantType_018)then(
                         <item>
                             <key>MERCHANT_TYPE</key>
                             <value>{ data($request/MerchantType_018) }</value>
                         </item>
                         )else(),                       
                         
                          if($request/AcquiringInstitutionCountryCode_019)then(
                         <item>
                             <key>ACQUIRING_INSTITUTION_COUNTRY_CODE</key>
                             <value>{ data($request/AcquiringInstitutionCountryCode_019) }</value>
                         </item>
                         )else(),                         
                         
                           if($request/PANExtendedCountryCode_020)then(
                         <item>
                             <key>PAN_EXTENDED_COUNTRY_CODE</key>
                             <value>{ data($request/PANExtendedCountryCode_020) }</value>
                         </item>
                         )else(),                        
                         
                          if($request/ForwardingInstitutionCountryCode_021)then(
                         <item>
                             <key>FORWARDING_INSTITUTION_COUNTRY_CODE</key>
                             <value>{ data($request/ForwardingInstitutionCountryCode_021) }</value>
                         </item>
                         )else(),                         
                         
                           if($request/PointOfServiceEntryMode_022)then(
                         <item>
                             <key>POINT_OF_SERVICE_ENTRY_MODE</key>
                             <value>{ data($request/PointOfServiceEntryMode_022) }</value>
                         </item>
                         )else(),                       
                         
                          if($request/ApplicationPANSequenceNumber_023)then(
                         <item>
                             <key>APPLICATION_PAN_NUMBER</key>
                             <value>{ data($request/ApplicationPANSequenceNumber_023) }</value>
                         </item>
                         )else(),                         
                         
                           if($request/FunctionCode_024)then(
                         <item>
                             <key>FUNCTION_CODE_NII</key>
                             <value>{ data($request/FunctionCode_024) }</value>
                         </item>
                         )else(),                        
                         
                            if($request/PointOfServiceConditionCode_025)then(
                         <item>
                             <key>POINT_OF_SERVICE_CONDITION_CODE</key>
                             <value>{ data($request/PointOfServiceConditionCode_025) }</value>
                         </item>
                         )else(),                       
                         
                          if($request/PointOfServiceCaptureCode_026)then(
                         <item>
                             <key>POINT_OF_SERVICE_CAPTURE_CODE</key>
                             <value>{ data($request/PointOfServiceCaptureCode_026) }</value>
                         </item>
                         )else(),                         
                         
                          if($request/AuthorizingIdentificationResponseLength_027)then(
                         <item>
                             <key>AUTHORIZING_IDENTIFICATION_RESPONSE_LENGTH</key>
                             <value>{ data($request/AuthorizingIdentificationResponseLength_027) }</value>
                         </item>
                         )else(),                         
                         
                           if($request/AmountTransactionFee_028)then(
                         <item>
                             <key>AMOUNT_TRANSACTION_FEE</key>
                             <value>{ data($request/AmountTransactionFee_028) }</value>
                         </item>
                         )else(),                        
                         
                           if($request/AmountSettlementFee_029)then(
                         <item>
                             <key>AMOUNT_SETTLEMENT_FEE</key>
                             <value>{ data($request/AmountSettlementFee_029) }</value>
                         </item>
                         )else(),                        
                         
                           if($request/AmountTransactionProcessingFee_030)then(
                         <item>
                             <key>AMOUNT_TRANSACTION_PROCESSING_FEE</key>
                             <value>{ data($request/AmountTransactionProcessingFee_030) }</value>
                         </item>
                         )else(),                        
                         
                           if($request/AmountSettlementProcessingFee_031)then(
                         <item>
                             <key>AMOUNT_SETTLEMENT_PROCESSING_FEE</key>
                             <value>{ data($request/AmountSettlementProcessingFee_031) }</value>
                         </item>
                         )else(),                        
                         
                          if($request/AcquiringInstitutionIdentificationCode_032)then(
                         <item>
                             <key>ACQUIRING_INSTITUTION_IDENTIFICATION_CODE</key>
                             <value>{ data($request/AcquiringInstitutionIdentificationCode_032) }</value>
                         </item>
                         )else(),                         
                         
                           if($request/ForwardingInstitutionIdentificationCode_033)then(
                         <item>
                             <key>FORWARDING_INSTITUTION_IDENTIFICATION_CODE</key>
                             <value>{ data($request/ForwardingInstitutionIdentificationCode_033) }</value>
                         </item>
                         )else(),                        
                         
                          if($request/PrimaryAccountNumberExtended_034)then(
                         <item>
                             <key>PRIMARY_ACCOUNT_NUMBER_EXTENDED</key>
                             <value>{ data($request/PrimaryAccountNumberExtended_034) }</value>
                         </item>
                         )else(),                         
                         
                           if($request/Track2Data_035)then(
                         <item>
                             <key>TRACK_2_DATA</key>
                             <value>{ data($request/Track2Data_035) }</value>
                         </item>
                         )else(),                        
                         
                            if($request/Track3Data_036)then(
                         <item>
                             <key>TRACK_3_DATA</key>
                             <value>{ data($request/Track3Data_036) }</value>
                         </item>
                         )else(),                       
                         
                          if($request/RetrievalReferenceNumber_037)then(
                         <item>
                             <key>RETRIEVAL_REFERENCE_NUMBER</key>
                             <value>{ data($request/RetrievalReferenceNumber_037) }</value>
                         </item>
                         )else(),                         
                         
                          if($request/AuthorizationIdentificationResponse_038)then(
                         <item>
                             <key>AUTHORIZATION_IDENTIFICATION_RESPONSE</key>
                             <value>{ data($request/AuthorizationIdentificationResponse_038) }</value>
                         </item>
                         )else(),                         
                         
                          if($request/ResponseCode_039)then(
                         <item>
                             <key>RESPONSE_CODE</key>
                             <value>{ data($request/ResponseCode_039) }</value>
                         </item>
                         )else(),                         
                         
                          if($request/ServiceRestrictionCode_040)then(
                         <item>
                             <key>SERVICE_RESTRICTION_CODE</key>
                             <value>{ data($request/ServiceRestrictionCode_040) }</value>
                         </item>
                         )else(),                         
                         
                           if($request/CardAcceptorTerminalIdentification_041)then(
                         <item>
                             <key>CARD_ACCEPTOR_TERMINAL_IDENTIFICATION</key>
                             <value>{ data($request/CardAcceptorTerminalIdentification_041) }</value>
                         </item>
                         )else(),                        
                         
                           if($request/CardAcceptorIdentificationCode_042)then(
                         <item>
                             <key>CARD_ACCEPTOR_IDENTIFICATION_CODE</key>
                             <value>{ data($request/CardAcceptorIdentificationCode_042) }</value>
                         </item>
                         )else(),                       
                         
                          if($request/CardAcceptorNameLocation_043)then(
                         <item>
                             <key>CARD_ACCEPTOR_NAME_LOCATION</key>
                             <value>{ data($request/CardAcceptorNameLocation_043) }</value>
                         </item>
                         )else(),                         
                         
                          if($request/AdditionalResponseData_044)then(
                         <item>
                             <key>ADDITIONAL_RESPONSE_DATA</key>
                             <value>{ data($request/AdditionalResponseData_044) }</value>
                         </item>
                         )else(),                                                
                         
                           if($request/Track1Data_045)then(
                         <item>
                             <key>TRACK_1_DATA</key>
                             <value>{ data($request/Track1Data_045) }</value>
                         </item>
                         )else(),                        
                         
                           if($request/AdditionalDataISO_046)then(
                         <item>
                             <key>ADDITIONAL_DATA_ISO</key>
                             <value>{ data($request/AdditionalDataISO_046) }</value>
                         </item>
                         )else(),                        
                         
                           if($request/AdditionalDataNational_047)then(
                         <item>
                             <key>ADDITIONAL_DATA_NATIONAL</key>
                             <value>{ data($request/AdditionalDataNational_047) }</value>
                         </item>
                         )else(),                        
                         
                          if($request/AdditionalDataPrivate_048)then(
                         <item>
                             <key>ADDITIONAL_DATA_PRIVATE</key>
                             <value>{ data($request/AdditionalDataPrivate_048) }</value>
                         </item>
                         )else(),                         
                         
                           if($request/CurrencyCodeTransaction_049)then(
                         <item>
                             <key>TRANSACTION_CURRENCY_CODE</key>
                             <value>{ data($request/CurrencyCodeTransaction_049) }</value>
                         </item>
                         )else(),                        
                         
                            if($request/CurrencyCodeSettlement_050)then(
                         <item>
                             <key>CURRENCY_CODE_SETTLEMENT</key>
                             <value>{ data($request/CurrencyCodeSettlement_050) }</value>
                         </item>
                         )else(),                       
                         
                           if($request/CurrencyCodeCardholderBilling_051)then(
                         <item>
                             <key>CURRENCY_CODE_CARDHOLDER_BILLING</key>
                             <value>{ data($request/CurrencyCodeCardholderBilling_051) }</value>
                         </item>
                         )else(),                        
                         
                           if($request/PersonalIdentificationNumberData_052)then(
                         <item>
                             <key>PERSONAL_IDENTIFICATION_NUMBER_DATA</key>
                             <value>{ data($request/PersonalIdentificationNumberData_052) }</value>
                         </item>
                         )else(),                       
                         
                          if($request/SecurityRelatedControlInformation_053)then(
                         <item>
                             <key>SECURITY_RELATED_CONTROL_INFORMATION</key>
                             <value>{ data($request/SecurityRelatedControlInformation_053) }</value>
                         </item>
                         )else(),                         
                         
                           if($request/AdditionalAmounts_054)then(
                         <item>
                             <key>ADDITIONAL_AMOUNTS</key>
                             <value>{ data($request/AdditionalAmounts_054) }</value>
                         </item>
                         )else(),                        
                         
                          if($request/ReservedISO_055)then(
                         <item>
                             <key>RESERVED_ISO_1</key>
                             <value>{ data($request/ReservedISO_055) }</value>
                         </item>
                         )else(),                         
                         
                           if($request/ReservedISO_056)then(
                         <item>
                             <key>RESERVED_ISO_2</key>
                             <value>{ data($request/ReservedISO_056) }</value>
                         </item>
                         )else(),                        
                         
                          if($request/ReservedNational_057)then(
                         <item>
                             <key>RESERVED_NATIONAL_1</key>
                             <value>{ data($request/ReservedNational_057) }</value>
                         </item>
                         )else(),                         
                         
                          if($request/ReservedNational_058)then(
                         <item>
                             <key>RESERVED_NATIONAL_2</key>
                             <value>{ data($request/ReservedNational_058) }</value>
                         </item>
                         )else(),                         
                         
                          if($request/ReservedNational_059)then(
                         <item>
                             <key>RESERVED_FOR_NATIONAL_USE_1</key>
                             <value>{ data($request/ReservedNational_059) }</value>
                         </item>
                         )else(),                         
                         
                          if($request/ReservedNational_060)then(
                         <item>
                             <key>ADVICE_REASON_CODE</key>
                             <value>{ data($request/ReservedNational_060) }</value>
                         </item>
                         )else(),                        
                         
                          if($request/ReservedPrivate_061)then(
                         <item>
                             <key>RESERVED_PRIVATE_1</key>
                             <value>{ data($request/ReservedPrivate_061) }</value>
                         </item>
                         )else(),                         
                         
                          if($request/ReservedPrivate_062)then(
                         <item>
                             <key>RESERVED_PRIVATE_2</key>
                             <value>{ data($request/ReservedPrivate_062) }</value>
                         </item>
                         )else(),                         
                         
                          if($request/ReservedPrivate_063)then(
                         <item>
                             <key>RESERVED_PRIVATE_3</key>
                             <value>{ data($request/ReservedPrivate_063) }</value>
                         </item>
                         )else(),                        
                         
                           if($request/MessageAuthenticationCode_064)then(
                         <item>
                             <key>MESSAGE_AUTHENTICATION_CODE</key>
                             <value>{ data($request/MessageAuthenticationCode_064) }</value>
                         </item>
                         )else(),                        
                         
                          if($request/BitmapExtended_065)then(
                         <item>
                             <key>BIT_MAP_TERTIARY</key>
                             <value>{ data($request/BitmapExtended_065) }</value>
                         </item>
                         )else(),                         
                                                  
                          if($request/SettlementCode_066)then(
                         <item>
                             <key>SETTLEMENT_CODE</key>
                             <value>{ data($request/SettlementCode_066) }</value>
                         </item>
                         )else(),                         
                         
                          if($request/ExtendedPaymentCode_067)then(
                         <item>
                             <key>EXTENDED_PAYMENT_CODE</key>
                             <value>{ data($request/ExtendedPaymentCode_067) }</value>
                         </item>
                         )else(),                         
                         
                          if($request/ReceivingInstitutionCountryCode_068)then(
                         <item>
                             <key>RECEIVING_INSTITUTION_COUNTRY_CODE</key>
                             <value>{ data($request/ReceivingInstitutionCountryCode_068) }</value>
                         </item>
                         )else(),                         
                         
                          if($request/SettlementInstitutionCountryCode_069)then(
                         <item>
                             <key>SETTLEMENT_INSTITUTION_COUNTY_CODE</key>
                             <value>{ data($request/SettlementInstitutionCountryCode_069) }</value>
                         </item>
                         )else(),                         
                         
                          if($request/NetworkManagementInformationCode_070)then(
                         <item>
                             <key>NETWORK_MANAGEMENT_INFORMATION_CODE</key>
                             <value>{ data($request/NetworkManagementInformationCode_070) }</value>
                         </item>
                         )else(),                         
                         
                          if($request/MessageNumber_071)then(
                         <item>
                             <key>MESSAGE_NUMBER</key>
                             <value>{ data($request/MessageNumber_071) }</value>
                         </item>
                         )else(),                         
                         
                          if($request/MessageNumberLast_072)then(
                         <item>
                             <key>DATA_RECORD</key>
                             <value>{ data($request/MessageNumberLast_072) }</value>
                         </item>
                         )else(),                         
                         
                          if($request/DateAction_073)then(
                         <item>
                             <key>DATE_ACTION</key>
                             <value>{ data($request/DateAction_073) }</value>
                         </item>
                         )else(),                         
                         
                          if($request/CreditsNumber_074)then(
                         <item>
                             <key>CREDITS_NUMBER</key>
                             <value>{ data($request/CreditsNumber_074) }</value>
                         </item>
                         )else(),                         
                         
                          if($request/CreditsReversalNumber_075)then(
                         <item>
                             <key>CREDITS_REVERSAL_NUMBER</key>
                             <value>{ data($request/CreditsReversalNumber_075) }</value>
                         </item>
                         )else(),                        
                         
                          if($request/DebitsNumber_076)then(
                         <item>
                             <key>DEBITS_NUMBER</key>
                             <value>{ data($request/DebitsNumber_076) }</value>
                         </item>
                         )else(),                         
                         
                          if($request/DebitsReversalNumber_077)then(
                         <item>
                             <key>DEBITS_REVERSAL_NUMBER</key>
                             <value>{ data($request/DebitsReversalNumber_077) }</value>
                         </item>
                         )else(),                         
                         
                          if($request/TransferNumber_078)then(
                         <item>
                             <key>TRANSFER_NUMBER</key>
                             <value>{ data($request/TransferNumber_078) }</value>
                         </item>
                         )else(),                         
                         
                          if($request/TransferReversalNumber_079)then(
                         <item>
                             <key>TRANSFER_REVERSAL_NUMBER</key>
                             <value>{ data($request/TransferReversalNumber_079) }</value>
                         </item>
                         )else(),                         
                         
                          if($request/InquiriesNumber_080)then(
                         <item>
                             <key>INQUIRIES_NUMBER</key>
                             <value>{ data($request/InquiriesNumber_080) }</value>
                         </item>
                         )else(),                         
                         
                           if($request/AuthorizationsNumber_081)then(
                         <item>
                             <key>AUTHORIZATIONS_NUMBER</key>
                             <value>{ data($request/AuthorizationsNumber_081) }</value>
                         </item>
                         )else(),                        
                         
                          if($request/CreditsProcessingFeeAmount_082)then(
                         <item>
                             <key>CREDITS_PROCESSING_FEE_AMOUNT</key>
                             <value>{ data($request/CreditsProcessingFeeAmount_082) }</value>
                         </item>
                         )else(),                         
                         
                          if($request/CreditsTransactionFeeAmount_083)then(
                         <item>
                             <key>CREDITS_TRANSACTION_FEE_AMOUNT</key>
                             <value>{ data($request/CreditsTransactionFeeAmount_083) }</value>
                         </item>
                         )else(),                         
                         
                          if($request/DebitsProcessingFeeAmount_084)then(
                         <item>
                             <key>DEBITS_PROCESSING_FEE_AMOUNT</key>
                             <value>{ data($request/DebitsProcessingFeeAmount_084) }</value>
                         </item>
                         )else(),                         
                         
                          if($request/DebitsTransactionFeeAmount_085)then(
                         <item>
                             <key>DEBITS_TRANSACTION_FEE_AMOUNT</key>
                             <value>{ data($request/DebitsTransactionFeeAmount_085) }</value>
                         </item>
                         )else(),                         
                         
                          if($request/CreditsAmount_086)then(
                         <item>
                             <key>CREDITS_AMOUNT</key>
                             <value>{ data($request/CreditsAmount_086) }</value>
                         </item>
                         )else(),                         
                         
                          if($request/CreditsReversalAmount_087)then(
                         <item>
                             <key>CREDITS_REVERSAL_AMOUNT</key>
                             <value>{ data($request/CreditsReversalAmount_087) }</value>
                         </item>
                         )else(),                       
                         
                          if($request/DebitsAmount_088)then(
                         <item>
                             <key>DEBITS_AMOUNT</key>
                             <value>{ data($request/DebitsAmount_088) }</value>
                         </item>
                         )else(),                         
                         
                          if($request/DebitsReversalAmount_089)then(
                         <item>
                             <key>DEBITS_REVERSAL_AMOUNT</key>
                             <value>{ data($request/DebitsReversalAmount_089) }</value>
                         </item>
                         )else(),                         
                         
                           if($request/OriginalDataElements_090)then(
                         <item>
                             <key>ORIGINAL_DATA_ELEMENTS</key>
                             <value>{ data($request/OriginalDataElements_090) }</value>
                         </item>
                         )else(),                        
                         
                          if($request/FileUpdateCode_091)then(
                         <item>
                             <key>FILE_UPDATE_CODE</key>
                             <value>{ data($request/FileUpdateCode_091) }</value>
                         </item>
                         )else(),                         
                         
                          if($request/FileSecurityCode_092)then(
                         <item>
                             <key>FILE_SECURITY_CODE</key>
                             <value>{ data($request/FileSecurityCode_092) }</value>
                         </item>
                         )else(),                       
                         
                          if($request/ResponseIndicator_093)then(
                         <item>
                             <key>RESPONSE_INDICATOR</key>
                             <value>{ data($request/ResponseIndicator_093) }</value>
                         </item>
                         )else(),                         
                         
                          if($request/ServiceIndicator_094)then(
                         <item>
                             <key>SERVICE_INDICATOR</key>
                             <value>{ data($request/ServiceIndicator_094) }</value>
                         </item>
                         )else(),                         
                         
                          if($request/ReplacementAmounts_095)then(
                         <item>
                             <key>REPLACEMENT_AMOUNTS</key>
                             <value>{ data($request/ReplacementAmounts_095) }</value>
                         </item>
                         )else(),                         
                         
                          if($request/MessageSecurityCode_096)then(
                         <item>
                             <key>MESSAGE_SECURITY_CODE</key>
                             <value>{ data($request/MessageSecurityCode_096) }</value>
                         </item>
                         )else(),                         
                         
                          if($request/AmountNetSettlement_097)then(
                         <item>
                             <key>AMOUNT_NET_SETTLEMENT</key>
                             <value>{ data($request/AmountNetSettlement_097) }</value>
                         </item>
                         )else(),                         
                         
                          if($request/Payee_098)then(
                         <item>
                             <key>PAYEE</key>
                             <value>{ data($request/Payee_098) }</value>
                         </item>
                         )else(),                         
                         
                          if($request/SettlementInstitutionIdentificationCode_099)then(
                         <item>
                             <key>SETTLEMENT_INSTITUTION_IDENTIFICATION_CODE</key>
                             <value>{ data($request/SettlementInstitutionIdentificationCode_099) }</value>
                         </item>
                         )else(),                         
                         
                          if($request/ReceivingInstitutionIdentificationCode_100)then(
                         <item>
                             <key>RECEIVING_INSTITUTION_IDENTIFICATION_CODE</key>
                             <value>{ data($request/ReceivingInstitutionIdentificationCode_100) }</value>
                         </item>
                         )else(),                         
                         
                          if($request/FileName_101)then(
                         <item>
                             <key>FILE_NAME</key>
                             <value>{ data($request/FileName_101) }</value>
                         </item>
                         )else(),                         
                         
                          if($request/AccountIdentification1_102)then(
                         <item>
                             <key>ACCOUNT_IDENTIFICATION_1</key>
                             <value>{ data($request/AccountIdentification1_102) }</value>
                         </item>
                         )else(),                         
                         
                          if($request/AccountIdentification2_103)then(
                         <item>
                             <key>ACCOUNT_IDENTIFICATION_2</key>
                             <value>{ data($request/AccountIdentification2_103) }</value>
                         </item>
                         )else(),                         
                         
                           if($request/TransactionDescription_104)then(
                         <item>
                             <key>TRANSACTION_DESCRIPTION</key>
                             <value>{ data($request/TransactionDescription_104) }</value>
                         </item>
                         )else(),                        
                         
                          if($request/ReservedForISOUse_105)then(
                         <item>
                             <key>RESERVED_FOR_ISO_USE_1</key>
                             <value>{ data($request/ReservedForISOUse_105) }</value>
                         </item>
                         )else(),                         
                         
                          if($request/ReservedForISOUse_106)then(
                         <item>
                             <key>RESERVED_FOR_ISO_USE_2</key>
                             <value>{ data($request/ReservedForISOUse_106) }</value>
                         </item>
                         )else(),                        
                         
                          if($request/ReservedForISOUse_107)then(
                         <item>
                             <key>RESERVED_FOR_ISO_USE_3</key>
                             <value>{ data($request/ReservedForISOUse_107) }</value>
                         </item>
                         )else(),                        
                         
                          if($request/ReservedForISOUse_108)then(
                         <item>
                             <key>RESERVED_FOR_ISO_USE_4</key>
                             <value>{ data($request/ReservedForISOUse_108) }</value>
                         </item>
                         )else(),                         
                         
                          if($request/ReservedForISOUse_109)then(
                         <item>
                             <key>RESERVED_FOR_ISO_USE_5</key>
                             <value>{ data($request/ReservedForISOUse_109) }</value>
                         </item>
                         )else(),                     
                         
                          if($request/ReservedForISOUse_110)then(
                         <item>
                             <key>RESERVED_FOR_ISO_USE_6</key>
                             <value>{ data($request/ReservedForISOUse_110) }</value>
                         </item>
                         )else(),                         
                         
                          if($request/ReservedForISOUse_111)then(
                         <item>
                             <key>RESERVED_FOR_ISO_USE_7</key>
                             <value>{ data($request/ReservedForISOUse_111) }</value>
                         </item>
                         )else(),                        
                         
                          if($request/ReservedForNationalUse_112)then(
                         <item>
                             <key>RESERVED_FOR_NATIONAL_USE_2</key>
                             <value>{ data($request/ReservedForNationalUse_112) }</value>
                         </item>
                         )else(),                         
                         
                          if($request/ReservedForNationalUse_113)then(
                         <item>
                             <key>AUTHORIZING_AGENT_INSTITUTION_ID_CODE</key>
                             <value>{ data($request/ReservedForNationalUse_113) }</value>
                         </item>
                         )else(),                        
                         
                          if($request/ReservedForNationalUse_114)then(
                         <item>
                             <key>RESERVED_FOR_NATIONAL_USE_3</key>
                             <value>{ data($request/ReservedForNationalUse_114) }</value>
                         </item>
                         )else(),                         
                         
                           if($request/ReservedForNationalUse_115)then(
                         <item>
                             <key>RESERVED_FOR_NATIONAL_USE_4</key>
                             <value>{ data($request/ReservedForNationalUse_115) }</value>
                         </item>
                         )else(),                        
                         
                          if($request/ReservedForNationalUse_116)then(
                         <item>
                             <key>RESERVED_FOR_NATIONAL_USE_5</key>
                             <value>{ data($request/ReservedForNationalUse_116) }</value>
                         </item>
                         )else(),                         
                         
                          if($request/ReservedForNationalUse_117)then(
                         <item>
                             <key>RESERVED_FOR_NATIONAL_USE_6</key>
                             <value>{ data($request/ReservedForNationalUse_117) }</value>
                         </item>
                         )else(),                     
                         
                          if($request/ReservedForNationalUse_118)then(
                         <item>
                             <key>RESERVED_FOR_NATIONAL_USE_7</key>
                             <value>{ data($request/ReservedForNationalUse_118) }</value>
                         </item>
                         )else(),
                         
                           if($request/ReservedForNationalUse_119)then(
                         <item>
                             <key>RESERVED_FOR_NATIONAL_USE_8</key>
                             <value>{ data($request/ReservedForNationalUse_119) }</value>
                         </item>
                         )else(),                        
                         
                          if($request/ReservedForPrivateUse_120)then(
                         <item>
                             <key>RESERVED_FOR_PRIVATE_USE_1</key>
                             <value>{ data($request/ReservedForPrivateUse_120) }</value>
                         </item>
                         )else(),                         
                         
                          if($request/ReservedForPrivateUse_121)then(
                         <item>
                             <key>RESERVED_FOR_PRIVATE_USE_2</key>
                             <value>{ data($request/ReservedForPrivateUse_121) }</value>
                         </item>
                         )else(),                         
                         
                          if($request/ReservedForPrivateUse_122)then(
                         <item>
                             <key>RESERVED_FOR_PRIVATE_USE_3</key>
                             <value>{ data($request/ReservedForPrivateUse_122) }</value>
                         </item>
                         )else(),                        
                         
                          if($request/ReservedForPrivateUse_123)then(
                         <item>
                             <key>RESERVED_FOR_PRIVATE_USE_4</key>
                             <value>{ data($request/ReservedForPrivateUse_123) }</value>
                         </item>
                         )else(),                         
                         
                          if($request/ReservedForPrivateUse_124)then(
                         <item>
                             <key>INFO_TEXT</key>
                             <value>{ data($request/ReservedForPrivateUse_124) }</value>
                         </item>
                         )else(),                        
                         
                          if($request/ReservedForPrivateUse_125)then(
                         <item>
                             <key>NETWORK_MANAGEMENT_INFORMATION</key>
                             <value>{ data($request/ReservedForPrivateUse_125) }</value>
                         </item>
                         )else(),                         
                         
                          if($request/ReservedForPrivateUse_126)then(
                         <item>
                             <key>ISSUER_TRACE_ID</key>
                             <value>{ data($request/ReservedForPrivateUse_126) }</value>
                         </item>
                         )else(),                        
                         
                          if($request/ReservedForPrivateUse_127)then(
                         <item>
                             <key>RESERVED_FOR_PRIVATE_USE_5</key>
                             <value>{ data($request/ReservedForPrivateUse_127) }</value>
                         </item>
                         )else(),                         
                         
                          if($request/MessageAuthenticationCode_128)then(
                         <item>
                             <key>MESSAGE_AUTHENTICATION_CODE</key>
                             <value>{ data($request/MessageAuthenticationCode_128) }</value>
                         </item>
                         )else()                                                                       
                                                                           
                         )
                      }
                    </bodyMessageDetails>
                </iso8583Item>
            </iso8583>
        </ns0:convertXMLToISO8583Request>
};

declare variable $anyType as element(*) external;

xf:convertXMLToISO8583In($anyType)