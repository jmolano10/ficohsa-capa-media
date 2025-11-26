(:: pragma bea:global-element-parameter parameter="$convertISO8583ToXMLResponse" element="ns1:convertISO8583ToXMLResponse" location="../../../BusinessServices/Switch/iso8583ConverterMultiple/wsdl/iso8583ConverterMultiple.wsdl" ::)
(:: pragma bea:global-element-return element="ns0:procesaMensajeGenericoSwitchFacadeRequest" location="../xsd/procesaMensajeGenericoSwitchFacadeTypes.xsd" ::)

declare namespace ns0 = "http://www.ficohsa.com.hn/middleware.services/procesaMensajeGenericoSwitchFacadeTypes";
declare namespace ns1 = "http://www.ficohsa.com.hn/schema/iso8583ConverterMultipleTypes";
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ProcesaMensajeGenericoSwitch/xq/procesaMensajeGenericoSwitchFacadeIn_new/";

declare function xf:procesaMensajeGenericoSwitchFacadeIn_new($convertISO8583ToXMLResponse as element(ns1:convertISO8583ToXMLResponse))
    as element(ns0:procesaMensajeGenericoSwitchFacadeRequest) {
        <ns0:procesaMensajeGenericoSwitchFacadeRequest>
            <ISO8583>
                <ISO8583_XML_CONTENT>

                {
                let $convertISO8583ToXMLBody := $convertISO8583ToXMLResponse/iso8583/iso8583Item[1]/bodyMessageDetails/item
                let $convertISO8583ToXMLHead := $convertISO8583ToXMLResponse/iso8583/iso8583Item[1]/headerMessageDetails/item
                 return
                 (
                                                 
                     if($convertISO8583ToXMLHead/key = 'MESSAGE_TYPE_INDICATOR')then  
                     (<MTI>{ data($convertISO8583ToXMLHead/value) }</MTI>)else
                     (),
                          

                    for $convertISO8583ToXMLRes in $convertISO8583ToXMLBody
                    return( 
                          
                    if($convertISO8583ToXMLRes/key = 'PRIMARY_ACCOUNT_NUMBER')then
                    (<PrimaryAccountNumber_002>{ data($convertISO8583ToXMLRes/value) }</PrimaryAccountNumber_002>)else
                    (),
                 
                    if($convertISO8583ToXMLRes/key = 'PROCESSING_CODE')then
                    (<ProcessingCode_003>{ data($convertISO8583ToXMLRes/value) }</ProcessingCode_003>)else
                    (),
                    
                    if($convertISO8583ToXMLRes/key = 'TRANSACTION_AMOUNT')then
                    (<AmountTransaction_004>{ data($convertISO8583ToXMLRes/value) }</AmountTransaction_004>)else
                    (),
                                        
                    if($convertISO8583ToXMLRes/key = 'SETTLEMENT_AMOUNT')then
                    (<AmountSettlement_005>{ data($convertISO8583ToXMLRes/value) }</AmountSettlement_005>)else
                    (),           
                    
                    if($convertISO8583ToXMLRes/key = 'CARDHOLDER_BILLING_AMOUNT')then
                    (<AmountCardholderBilling_006>{ data($convertISO8583ToXMLRes/value) }</AmountCardholderBilling_006>)else
                    (),                    
                                                 
                    if($convertISO8583ToXMLRes/key = 'TRANSMISSION_DATETIME')then
                    (<TransmissionDateTime_007>{ data($convertISO8583ToXMLRes/value) }</TransmissionDateTime_007>)else
                    (),                                                 
                                                 
                    if($convertISO8583ToXMLRes/key = 'CARDHOLDER_BILLING_FEE_AMOUNT')then
                    (<AmountCardholderBillingFee_008>{ data($convertISO8583ToXMLRes/value) }</AmountCardholderBillingFee_008>)else
                    (),                                                 
                                
                    if($convertISO8583ToXMLRes/key = 'SETTLEMENT_CONVERSION_RATE')then
                    (<ConversionRateSettlement_009>{ data($convertISO8583ToXMLRes/value) }</ConversionRateSettlement_009>)else
                    (),                                
                                
                    if($convertISO8583ToXMLRes/key = 'CARDHOLDER_BILLING_CONVERSION_RATE')then
                    (<ConversionRateCardholderBilling_010>{ data($convertISO8583ToXMLRes/value) }</ConversionRateCardholderBilling_010>)else
                    (),                                
                                
                    if($convertISO8583ToXMLRes/key = 'SYSTEMS_TRACE_AUDIT_NUMBER')then
                    (<SystemTraceAuditNumber_011>{ data($convertISO8583ToXMLRes/value) }</SystemTraceAuditNumber_011>)else
                    (),                    
                                
                    if($convertISO8583ToXMLRes/key = 'LOCAL_TRANSACTION_TIME')then
                    (<TimeLocalTransaction_012>{ data($convertISO8583ToXMLRes/value) }</TimeLocalTransaction_012>)else
                    (),                                
                                
                    if($convertISO8583ToXMLRes/key = 'LOCAL_TRANSACTION_DATE')then
                    (<DateLocalTransaction_013>{ data($convertISO8583ToXMLRes/value) }</DateLocalTransaction_013>)else
                    (),                                
                                
                    if($convertISO8583ToXMLRes/key = 'EXPIRATION_DATE')then
                    (<DateExpiration_014>{ data($convertISO8583ToXMLRes/value) }</DateExpiration_014>)else
                    (),                                
                                
                    if($convertISO8583ToXMLRes/key = 'SETTLEMENT_DATE')then
                    (<DateSettlement_015>{ data($convertISO8583ToXMLRes/value) }</DateSettlement_015>)else
                    (),                                
                                
                    if($convertISO8583ToXMLRes/key = 'CONVERSION_DATE')then
                    (<DateConversion_016>{ data($convertISO8583ToXMLRes/value) }</DateConversion_016>)else
                    (),                                
                                
                    if($convertISO8583ToXMLRes/key = 'CAPTURE_DATE')then
                    (<DateCapture_017>{ data($convertISO8583ToXMLRes/value) }</DateCapture_017>)else
                    (),                                
                                
                    if($convertISO8583ToXMLRes/key = 'MERCHANT_TYPE')then
                    (<MerchantType_018>{ data($convertISO8583ToXMLRes/value) }</MerchantType_018>)else
                    (),                                
                                
                    if($convertISO8583ToXMLRes/key = 'ACQUIRING_INSTITUTION_COUNTRY_CODE')then
                    (<AcquiringInstitutionCountryCode_019>{ data($convertISO8583ToXMLRes/value) }</AcquiringInstitutionCountryCode_019>)else
                    (),                  
                    
                     if($convertISO8583ToXMLRes/key = 'PAN_EXTENDED_COUNTRY_CODE')then
                    (<PANExtendedCountryCode_020>{ data($convertISO8583ToXMLRes/value) }</PANExtendedCountryCode_020>)else
                    (),                                 
                                
                    if($convertISO8583ToXMLRes/key = 'FORWARDING_INSTITUTION_COUNTRY_CODE')then
                    (<ForwardingInstitutionCountryCode_021>{ data($convertISO8583ToXMLRes/value) }</ForwardingInstitutionCountryCode_021>)else
                    (),                                
                                
                    if($convertISO8583ToXMLRes/key = 'POINT_OF_SERVICE_ENTRY_MODE')then
                    (<PointOfServiceEntryMode_022>{ data($convertISO8583ToXMLRes/value) }</PointOfServiceEntryMode_022>)else
                    (),                                
                                
                    if($convertISO8583ToXMLRes/key = 'APPLICATION_PAN_NUMBER')then
                    (<ApplicationPANSequenceNumber_023>{ data($convertISO8583ToXMLRes/value) }</ApplicationPANSequenceNumber_023>)else
                    (),                                
                                
                    if($convertISO8583ToXMLRes/key = 'FUNCTION_CODE_NII')then
                    (<FunctionCode_024>{ data($convertISO8583ToXMLRes/value) }</FunctionCode_024>)else
                    (),                                
                                
                    if($convertISO8583ToXMLRes/key = 'POINT_OF_SERVICE_CONDITION_CODE')then
                    (<PointOfServiceConditionCode_025>{ data($convertISO8583ToXMLRes/value) }</PointOfServiceConditionCode_025>)else
                    (),                                
                                
                    if($convertISO8583ToXMLRes/key = 'POINT_OF_SERVICE_CAPTURE_CODE')then
                    (<PointOfServiceCaptureCode_026>{ data($convertISO8583ToXMLRes/value) }</PointOfServiceCaptureCode_026>)else
                    (),                                
                                
                    if($convertISO8583ToXMLRes/key = 'AUTHORIZING_IDENTIFICATION_RESPONSE_LENGTH')then
                    (<AuthorizingIdentificationResponseLength_027>{ data($convertISO8583ToXMLRes/value) }</AuthorizingIdentificationResponseLength_027>)else
                    (),                                
                                
                    if($convertISO8583ToXMLRes/key = 'AMOUNT_TRANSACTION_FEE')then
                    (<AmountTransactionFee_028>{ data($convertISO8583ToXMLRes/value) }</AmountTransactionFee_028>)else
                    (),                                
                                
                     if($convertISO8583ToXMLRes/key = 'AMOUNT_SETTLEMENT_FEE')then
                    (<AmountSettlementFee_029>{ data($convertISO8583ToXMLRes/value) }</AmountSettlementFee_029>)else
                    (),                               
                                
                    if($convertISO8583ToXMLRes/key = 'AMOUNT_TRANSACTION_PROCESSING_FEE')then
                    (<AmountTransactionProcessingFee_030>{ data($convertISO8583ToXMLRes/value) }</AmountTransactionProcessingFee_030>)else
                    (),                              
                                
                     if($convertISO8583ToXMLRes/key = 'AMOUNT_SETTLEMENT_PROCESSING_FEE')then
                    (<AmountSettlementProcessingFee_031>{ data($convertISO8583ToXMLRes/value) }</AmountSettlementProcessingFee_031>)else
                    (),                               
                                
                    if($convertISO8583ToXMLRes/key = 'ACQUIRING_INSTITUTION_IDENTIFICATION_CODE')then
                    (<AcquiringInstitutionIdentificationCode_032>{ data($convertISO8583ToXMLRes/value) }</AcquiringInstitutionIdentificationCode_032>)else
                    (),                                
                                
                    if($convertISO8583ToXMLRes/key = 'FORWARDING_INSTITUTION_IDENTIFICATION_CODE')then
                    (<ForwardingInstitutionIdentificationCode_033>{ data($convertISO8583ToXMLRes/value) }</ForwardingInstitutionIdentificationCode_033>)else
                    (),                                                 
                         
                    if($convertISO8583ToXMLRes/key = 'PRIMARY_ACCOUNT_NUMBER_EXTENDED')then
                    (<PrimaryAccountNumberExtended_034>{ data($convertISO8583ToXMLRes/value) }</PrimaryAccountNumberExtended_034>)else
                    (),                         
                         
                     if($convertISO8583ToXMLRes/key = 'TRACK_2_DATA')then
                    (<Track2Data_035>{ data($convertISO8583ToXMLRes/value) }</Track2Data_035>)else
                    (),                        
                         
                    if($convertISO8583ToXMLRes/key = 'TRACK_3_DATA')then
                    (<Track3Data_036>{ data($convertISO8583ToXMLRes/value) }</Track3Data_036>)else
                    (),                         
                         
                     if($convertISO8583ToXMLRes/key = 'RETRIEVAL_REFERENCE_NUMBER')then
                    (<RetrievalReferenceNumber_037>{ data($convertISO8583ToXMLRes/value) }</RetrievalReferenceNumber_037>)else
                    (),                        
                         
                     if($convertISO8583ToXMLRes/key = 'AUTHORIZATION_IDENTIFICATION_RESPONSE')then
                    (<AuthorizationIdentificationResponse_038>{ data($convertISO8583ToXMLRes/value) }</AuthorizationIdentificationResponse_038>)else
                    (),                        
                         
                    if($convertISO8583ToXMLRes/key = 'RESPONSE_CODE')then
                    (<ResponseCode_039>{ data($convertISO8583ToXMLRes/value) }</ResponseCode_039>)else
                    (),                         
                         
                    if($convertISO8583ToXMLRes/key = 'SERVICE_RESTRICTION_CODE')then
                    (<ServiceRestrictionCode_040>{ data($convertISO8583ToXMLRes/value) }</ServiceRestrictionCode_040>)else
                    (),                         
                         
                    if($convertISO8583ToXMLRes/key = 'CARD_ACCEPTOR_TERMINAL_IDENTIFICATION')then
                    (<CardAcceptorTerminalIdentification_041>{ data($convertISO8583ToXMLRes/value) }</CardAcceptorTerminalIdentification_041>)else
                    (),                         
                         
                    if($convertISO8583ToXMLRes/key = 'CARD_ACCEPTOR_IDENTIFICATION_CODE')then
                    (<CardAcceptorIdentificationCode_042>{ data($convertISO8583ToXMLRes/value) }</CardAcceptorIdentificationCode_042>)else
                    (),                         
                         
                    if($convertISO8583ToXMLRes/key = 'CARD_ACCEPTOR_NAME_LOCATION')then
                    (<CardAcceptorNameLocation_043>{ data($convertISO8583ToXMLRes/value) }</CardAcceptorNameLocation_043>)else
                    (),                         
                         
                     if($convertISO8583ToXMLRes/key = 'ADDITIONAL_RESPONSE_DATA')then
                    (<AdditionalResponseData_044>{ data($convertISO8583ToXMLRes/value) }</AdditionalResponseData_044>)else
                    (),                        
                         
                    if($convertISO8583ToXMLRes/key = 'TRACK_1_DATA')then
                    (<Track1Data_045>{ data($convertISO8583ToXMLRes/value) }</Track1Data_045>)else
                    (),           
                         
                     if($convertISO8583ToXMLRes/key = 'ADDITIONAL_DATA_ISO')then
                    (<AdditionalDataISO_046>{ data($convertISO8583ToXMLRes/value) }</AdditionalDataISO_046>)else
                    (),                        
                         
                    if($convertISO8583ToXMLRes/key = 'ADDITIONAL_DATA_NATIONAL')then
                    (<AdditionalDataNational_047>{ data($convertISO8583ToXMLRes/value) }</AdditionalDataNational_047>)else
                    (),                         
                         
                    if($convertISO8583ToXMLRes/key = 'ADDITIONAL_DATA_PRIVATE')then
                    (<AdditionalDataPrivate_048>{ data($convertISO8583ToXMLRes/value) }</AdditionalDataPrivate_048>)else
                    (),                         
                         
                    if($convertISO8583ToXMLRes/key = 'TRANSACTION_CURRENCY_CODE')then
                    (<CurrencyCodeTransaction_049>{ data($convertISO8583ToXMLRes/value) }</CurrencyCodeTransaction_049>)else
                    (),                         
                         
                     if($convertISO8583ToXMLRes/key = 'CURRENCY_CODE_SETTLEMENT')then
                    (<CurrencyCodeSettlement_050>{ data($convertISO8583ToXMLRes/value) }</CurrencyCodeSettlement_050>)else
                    (),                        
                         
                     if($convertISO8583ToXMLRes/key = 'CURRENCY_CODE_CARDHOLDER_BILLING')then
                    (<CurrencyCodeCardholderBilling_051>{ data($convertISO8583ToXMLRes/value) }</CurrencyCodeCardholderBilling_051>)else
                    (),                        
                         
                    if($convertISO8583ToXMLRes/key = 'PERSONAL_IDENTIFICATION_NUMBER_DATA')then
                    (<PersonalIdentificationNumberData_052>{ data($convertISO8583ToXMLRes/value) }</PersonalIdentificationNumberData_052>)else
                    (),                         
                         
                    if($convertISO8583ToXMLRes/key = 'SECURITY_RELATED_CONTROL_INFORMATION')then
                    (<SecurityRelatedControlInformation_053>{ data($convertISO8583ToXMLRes/value) }</SecurityRelatedControlInformation_053>)else
                    (),                         
                         
                     if($convertISO8583ToXMLRes/key = 'ADDITIONAL_AMOUNTS')then
                    (<AdditionalAmounts_054>{ data($convertISO8583ToXMLRes/value) }</AdditionalAmounts_054>)else
                    (),                        
                         
                    if($convertISO8583ToXMLRes/key = 'RESERVED_ISO_1')then
                    (<ReservedISO_055>{ data($convertISO8583ToXMLRes/value) }</ReservedISO_055>)else
                    (),                         
                         
                    if($convertISO8583ToXMLRes/key = 'RESERVED_ISO_2')then
                    (<ReservedISO_056>{ data($convertISO8583ToXMLRes/value) }</ReservedISO_056>)else
                    (),                         
                         
                     if($convertISO8583ToXMLRes/key = 'RESERVED_NATIONAL_1')then
                    (<ReservedNational_057>{ data($convertISO8583ToXMLRes/value) }</ReservedNational_057>)else
                    (),                        
                         
                     if($convertISO8583ToXMLRes/key = 'RESERVED_NATIONAL_2')then
                    (<ReservedNational_058>{ data($convertISO8583ToXMLRes/value) }</ReservedNational_058>)else
                    (),                        
                         
                     if($convertISO8583ToXMLRes/key = 'RESERVED_FOR_NATIONAL_USE_1')then
                    (<ReservedNational_059>{ data($convertISO8583ToXMLRes/value) }</ReservedNational_059>)else
                    (),                        
                         
                    if($convertISO8583ToXMLRes/key = 'ADVICE_REASON_CODE')then
                    (<ReservedNational_060>{ data($convertISO8583ToXMLRes/value) }</ReservedNational_060>)else
                    (),                         
                         
                    if($convertISO8583ToXMLRes/key = 'RESERVED_PRIVATE_1')then
                    (<ReservedPrivate_061>{ data($convertISO8583ToXMLRes/value) }</ReservedPrivate_061>)else
                    (),                         
                         
                    if($convertISO8583ToXMLRes/key = 'RESERVED_PRIVATE_2')then
                    (<ReservedPrivate_062>{ data($convertISO8583ToXMLRes/value) }</ReservedPrivate_062>)else
                    (),                         
                         
                    if($convertISO8583ToXMLRes/key = 'RESERVED_PRIVATE_3')then
                    (<ReservedPrivate_063>{ data($convertISO8583ToXMLRes/value) }</ReservedPrivate_063>)else
                    (),                         
                         
                    if($convertISO8583ToXMLRes/key = 'MESSAGE_AUTHENTICATION_CODE')then
                    (<MessageAuthenticationCode_064>{ data($convertISO8583ToXMLRes/value) }</MessageAuthenticationCode_064>)else
                    (),                         
                         
                    if($convertISO8583ToXMLRes/key = 'BIT_MAP_TERTIARY')then
                    (<BitmapExtended_065>{ data($convertISO8583ToXMLRes/value) }</BitmapExtended_065>)else
                    (),                         
                         
                    if($convertISO8583ToXMLRes/key = 'SETTLEMENT_CODE')then
                    (<SettlementCode_066>{ data($convertISO8583ToXMLRes/value) }</SettlementCode_066>)else
                    (),                         
                         
                     if($convertISO8583ToXMLRes/key = 'EXTENDED_PAYMENT_CODE')then
                    (<ExtendedPaymentCode_067>{ data($convertISO8583ToXMLRes/value) }</ExtendedPaymentCode_067>)else
                    (),                        
                         
                    if($convertISO8583ToXMLRes/key = 'RECEIVING_INSTITUTION_COUNTRY_CODE')then
                    (<ReceivingInstitutionCountryCode_068>{ data($convertISO8583ToXMLRes/value) }</ReceivingInstitutionCountryCode_068>)else
                    (),                         
                         
                     if($convertISO8583ToXMLRes/key = 'SETTLEMENT_INSTITUTION_COUNTY_CODE')then
                    (<SettlementInstitutionCountryCode_069>{ data($convertISO8583ToXMLRes/value) }</SettlementInstitutionCountryCode_069>)else
                    (),                        
                         
                     if($convertISO8583ToXMLRes/key = 'NETWORK_MANAGEMENT_INFORMATION_CODE')then
                    (<NetworkManagementInformationCode_070>{ data($convertISO8583ToXMLRes/value) }</NetworkManagementInformationCode_070>)else
                    (),                        
                         
                     if($convertISO8583ToXMLRes/key = 'MESSAGE_NUMBER')then
                    (<MessageNumber_071>{ data($convertISO8583ToXMLRes/value) }</MessageNumber_071>)else
                    (),                        
                         
                    if($convertISO8583ToXMLRes/key = 'DATA_RECORD')then
                    (<MessageNumberLast_072>{ data($convertISO8583ToXMLRes/value) }</MessageNumberLast_072>)else
                    (),                         
                         
                    if($convertISO8583ToXMLRes/key = 'DATE_ACTION')then
                    (<DateAction_073>{ data($convertISO8583ToXMLRes/value) }</DateAction_073>)else
                    (),                         
                         
                     if($convertISO8583ToXMLRes/key = 'CREDITS_NUMBER')then
                    (<CreditsNumber_074>{ data($convertISO8583ToXMLRes/value) }</CreditsNumber_074>)else
                    (),                        
                         
                    if($convertISO8583ToXMLRes/key = 'CREDITS_REVERSAL_NUMBER')then
                    (<CreditsReversalNumber_075>{ data($convertISO8583ToXMLRes/value) }</CreditsReversalNumber_075>)else
                    (),                         
                         
                     if($convertISO8583ToXMLRes/key = 'DEBITS_NUMBER')then
                    (<DebitsNumber_076>{ data($convertISO8583ToXMLRes/value) }</DebitsNumber_076>)else
                    (),                        
                         
                    if($convertISO8583ToXMLRes/key = 'DEBITS_REVERSAL_NUMBER')then
                    (<DebitsReversalNumber_077>{ data($convertISO8583ToXMLRes/value) }</DebitsReversalNumber_077>)else
                    (),                         
                         
                    if($convertISO8583ToXMLRes/key = 'TRANSFER_NUMBER')then
                    (<TransferNumber_078>{ data($convertISO8583ToXMLRes/value) }</TransferNumber_078>)else
                    (),                         
                         
                    if($convertISO8583ToXMLRes/key = 'TRANSFER_REVERSAL_NUMBER')then
                    (<TransferReversalNumber_079>{ data($convertISO8583ToXMLRes/value) }</TransferReversalNumber_079>)else
                    (),                         
                         
                     if($convertISO8583ToXMLRes/key = 'INQUIRIES_NUMBER')then
                    (<InquiriesNumber_080>{ data($convertISO8583ToXMLRes/value) }</InquiriesNumber_080>)else
                    (),                        
                         
                    if($convertISO8583ToXMLRes/key = 'AUTHORIZATIONS_NUMBER')then
                    (<AuthorizationsNumber_081>{ data($convertISO8583ToXMLRes/value) }</AuthorizationsNumber_081>)else
                    (),                         
                         
                     if($convertISO8583ToXMLRes/key = 'CREDITS_PROCESSING_FEE_AMOUNT')then
                    (<CreditsProcessingFeeAmount_082>{ data($convertISO8583ToXMLRes/value) }</CreditsProcessingFeeAmount_082>)else
                    (),                        
                         
                     if($convertISO8583ToXMLRes/key = 'CREDITS_TRANSACTION_FEE_AMOUNT')then
                    (<CreditsTransactionFeeAmount_083>{ data($convertISO8583ToXMLRes/value) }</CreditsTransactionFeeAmount_083>)else
                    (),                        
                         
                     if($convertISO8583ToXMLRes/key = 'DEBITS_PROCESSING_FEE_AMOUNT')then
                    (<DebitsProcessingFeeAmount_084>{ data($convertISO8583ToXMLRes/value) }</DebitsProcessingFeeAmount_084>)else
                    (),                        
                         
                      if($convertISO8583ToXMLRes/key = 'DEBITS_TRANSACTION_FEE_AMOUNT')then
                    (<DebitsTransactionFeeAmount_085>{ data($convertISO8583ToXMLRes/value) }</DebitsTransactionFeeAmount_085>)else
                    (),                       
                         
                     if($convertISO8583ToXMLRes/key = 'CREDITS_AMOUNT')then
                    (<CreditsAmount_086>{ data($convertISO8583ToXMLRes/value) }</CreditsAmount_086>)else
                    (),                        
                         
                    if($convertISO8583ToXMLRes/key = 'CREDITS_REVERSAL_AMOUNT')then
                    (<CreditsReversalAmount_087>{ data($convertISO8583ToXMLRes/value) }</CreditsReversalAmount_087>)else
                    (),                         
                         
                    if($convertISO8583ToXMLRes/key = 'DEBITS_AMOUNT')then
                    (<DebitsAmount_088>{ data($convertISO8583ToXMLRes/value) }</DebitsAmount_088>)else
                    (),                         
                         
                    if($convertISO8583ToXMLRes/key = 'DEBITS_REVERSAL_AMOUNT')then
                    (<DebitsReversalAmount_089>{ data($convertISO8583ToXMLRes/value) }</DebitsReversalAmount_089>)else
                    (),                         
                         
                    if($convertISO8583ToXMLRes/key = 'ORIGINAL_DATA_ELEMENTS')then
                    (<OriginalDataElements_090>{ data($convertISO8583ToXMLRes/value) }</OriginalDataElements_090>)else
                    (),                         
                         
                     if($convertISO8583ToXMLRes/key = 'FILE_UPDATE_CODE')then
                    (<FileUpdateCode_091>{ data($convertISO8583ToXMLRes/value) }</FileUpdateCode_091>)else
                    (),                        
                         
                     if($convertISO8583ToXMLRes/key = 'FILE_SECURITY_CODE')then
                    (<FileSecurityCode_092>{ data($convertISO8583ToXMLRes/value) }</FileSecurityCode_092>)else
                    (),                        
                         
                    if($convertISO8583ToXMLRes/key = 'RESPONSE_INDICATOR')then
                    (<ResponseIndicator_093>{ data($convertISO8583ToXMLRes/value) }</ResponseIndicator_093>)else
                    (),                         
                          
                     if($convertISO8583ToXMLRes/key = 'SERVICE_INDICATOR')then
                    (<ServiceIndicator_094>{ data($convertISO8583ToXMLRes/value) }</ServiceIndicator_094>)else
                    (),                         

                     if($convertISO8583ToXMLRes/key = 'REPLACEMENT_AMOUNTS')then
                    (<ReplacementAmounts_095>{ data($convertISO8583ToXMLRes/value) }</ReplacementAmounts_095>)else
                    (),                         
                          
                    if($convertISO8583ToXMLRes/key = 'MESSAGE_SECURITY_CODE')then
                    (<MessageSecurityCode_096>{ data($convertISO8583ToXMLRes/value) }</MessageSecurityCode_096>)else
                    (),                          
                          
                     if($convertISO8583ToXMLRes/key = 'AMOUNT_NET_SETTLEMENT')then
                    (<AmountNetSettlement_097>{ data($convertISO8583ToXMLRes/value) }</AmountNetSettlement_097>)else
                    (),                         
                          
                     if($convertISO8583ToXMLRes/key = 'PAYEE')then
                    (<Payee_098>{ data($convertISO8583ToXMLRes/value) }</Payee_098>)else
                    (),                         
                          
                    if($convertISO8583ToXMLRes/key = 'SETTLEMENT_INSTITUTION_IDENTIFICATION_CODE')then
                    (<SettlementInstitutionIdentificationCode_099>{ data($convertISO8583ToXMLRes/value) }</SettlementInstitutionIdentificationCode_099>)else
                    (),                          
                          
                     if($convertISO8583ToXMLRes/key = 'RECEIVING_INSTITUTION_IDENTIFICATION_CODE')then
                    (<ReceivingInstitutionIdentificationCode_100>{ data($convertISO8583ToXMLRes/value) }</ReceivingInstitutionIdentificationCode_100>)else
                    (),                         
                          
                     if($convertISO8583ToXMLRes/key = 'FILE_NAME')then
                    (<FileName_101>{ data($convertISO8583ToXMLRes/value) }</FileName_101>)else
                    (),                         
                          
                      if($convertISO8583ToXMLRes/key = 'ACCOUNT_IDENTIFICATION_1')then
                    (<AccountIdentification1_102>{ data($convertISO8583ToXMLRes/value) }</AccountIdentification1_102>)else
                    (),                        
                          
                      if($convertISO8583ToXMLRes/key = 'ACCOUNT_IDENTIFICATION_2')then
                    (<AccountIdentification2_103>{ data($convertISO8583ToXMLRes/value) }</AccountIdentification2_103>)else
                    (),                        
                          
                     if($convertISO8583ToXMLRes/key = 'TRANSACTION_DESCRIPTION')then
                    (<TransactionDescription_104>{ data($convertISO8583ToXMLRes/value) }</TransactionDescription_104>)else
                    (),                         
                          
                     if($convertISO8583ToXMLRes/key = 'RESERVED_FOR_ISO_USE_1')then
                    (<ReservedForISOUse_105>{ data($convertISO8583ToXMLRes/value) }</ReservedForISOUse_105>)else
                    (),                         
                          
                      if($convertISO8583ToXMLRes/key = 'RESERVED_FOR_ISO_USE_2')then
                    (<ReservedForISOUse_106>{ data($convertISO8583ToXMLRes/value) }</ReservedForISOUse_106>)else
                    (),                        
                          
                     if($convertISO8583ToXMLRes/key = 'RESERVED_FOR_ISO_USE_3')then
                    (<ReservedForISOUse_107>{ data($convertISO8583ToXMLRes/value) }</ReservedForISOUse_107>)else
                    (),                         
                          
                      if($convertISO8583ToXMLRes/key = 'RESERVED_FOR_ISO_USE_4')then
                    (<ReservedForISOUse_108>{ data($convertISO8583ToXMLRes/value) }</ReservedForISOUse_108>)else
                    (),                        
                          
                      if($convertISO8583ToXMLRes/key = 'RESERVED_FOR_ISO_USE_5')then
                    (<ReservedForISOUse_109>{ data($convertISO8583ToXMLRes/value) }</ReservedForISOUse_109>)else
                    (),                        
                          
                    if($convertISO8583ToXMLRes/key = 'RESERVED_FOR_ISO_USE_6')then
                    (<ReservedForISOUse_110>{ data($convertISO8583ToXMLRes/value) }</ReservedForISOUse_110>)else
                    (),                          
                          
                    if($convertISO8583ToXMLRes/key = 'RESERVED_FOR_ISO_USE_7')then
                    (<ReservedForISOUse_111>{ data($convertISO8583ToXMLRes/value) }</ReservedForISOUse_111>)else
                    (),                          
                          
                    if($convertISO8583ToXMLRes/key = 'RESERVED_FOR_NATIONAL_USE_2')then
                    (<ReservedForNationalUse_112>{ data($convertISO8583ToXMLRes/value) }</ReservedForNationalUse_112>)else
                    (),                          
                          
                     if($convertISO8583ToXMLRes/key = 'AUTHORIZING_AGENT_INSTITUTION_ID_CODE')then
                    (<ReservedForNationalUse_113>{ data($convertISO8583ToXMLRes/value) }</ReservedForNationalUse_113>)else
                    (),                         
                          
                      if($convertISO8583ToXMLRes/key = 'RESERVED_FOR_NATIONAL_USE_3')then
                    (<ReservedForNationalUse_114>{ data($convertISO8583ToXMLRes/value) }</ReservedForNationalUse_114>)else
                    (),                        
                          
                    if($convertISO8583ToXMLRes/key = 'RESERVED_FOR_NATIONAL_USE_4')then
                    (<ReservedForNationalUse_115>{ data($convertISO8583ToXMLRes/value) }</ReservedForNationalUse_115>)else
                    (),                          
                          
                    if($convertISO8583ToXMLRes/key = 'RESERVED_FOR_NATIONAL_USE_5')then
                    (<ReservedForNationalUse_116>{ data($convertISO8583ToXMLRes/value) }</ReservedForNationalUse_116>)else
                    (),                          
                          
                    if($convertISO8583ToXMLRes/key = 'RESERVED_FOR_NATIONAL_USE_6')then
                    (<ReservedForNationalUse_117>{ data($convertISO8583ToXMLRes/value) }</ReservedForNationalUse_117>)else
                    (),                          
                          
                     if($convertISO8583ToXMLRes/key = 'RESERVED_FOR_NATIONAL_USE_7')then
                    (<ReservedForNationalUse_118>{ data($convertISO8583ToXMLRes/value) }</ReservedForNationalUse_118>)else
                    (),                         
                          
                    if($convertISO8583ToXMLRes/key = 'RESERVED_FOR_NATIONAL_USE_8')then
                    (<ReservedForNationalUse_119>{ data($convertISO8583ToXMLRes/value) }</ReservedForNationalUse_119>)else
                    (),                          
                          
                    if($convertISO8583ToXMLRes/key = 'RESERVED_FOR_PRIVATE_USE_1')then
                    (<ReservedForPrivateUse_120>{ data($convertISO8583ToXMLRes/value) }</ReservedForPrivateUse_120>)else
                    (),                          
                          
                    if($convertISO8583ToXMLRes/key = 'RESERVED_FOR_PRIVATE_USE_2')then
                    (<ReservedForPrivateUse_121>{ data($convertISO8583ToXMLRes/value) }</ReservedForPrivateUse_121>)else
                    (),                          
                          
                     if($convertISO8583ToXMLRes/key = 'RESERVED_FOR_PRIVATE_USE_3')then
                    (<ReservedForPrivateUse_122>{ data($convertISO8583ToXMLRes/value) }</ReservedForPrivateUse_122>)else
                    (),                         
                     
                    if($convertISO8583ToXMLRes/key = 'RESERVED_FOR_PRIVATE_USE_4')then
                    (<ReservedForPrivateUse_123>{ data($convertISO8583ToXMLRes/value) }</ReservedForPrivateUse_123>)else
                    (),                     
                     
                     if($convertISO8583ToXMLRes/key = 'INFO_TEXT')then
                    (<ReservedForPrivateUse_124>{ data($convertISO8583ToXMLRes/value) }</ReservedForPrivateUse_124>)else
                    (),                    
                     
                    if($convertISO8583ToXMLRes/key = 'NETWORK_MANAGEMENT_INFORMATION')then
                    (<ReservedForPrivateUse_125>{ data($convertISO8583ToXMLRes/value) }</ReservedForPrivateUse_125>)else
                    (),                     
                     
                    if($convertISO8583ToXMLRes/key = 'ISSUER_TRACE_ID')then
                    (<ReservedForPrivateUse_126>{ data($convertISO8583ToXMLRes/value) }</ReservedForPrivateUse_126>)else
                    (),                     
                     
                     if($convertISO8583ToXMLRes/key = 'RESERVED_FOR_PRIVATE_USE_5')then
                    (<ReservedForPrivateUse_127>{ data($convertISO8583ToXMLRes/value) }</ReservedForPrivateUse_127>)else
                    (),                    
                     
                     if($convertISO8583ToXMLRes/key = 'MESSAGE_AUTHENTICATION_CODE')then
                    (<MessageAuthenticationCode_128>{ data($convertISO8583ToXMLRes/value) }</MessageAuthenticationCode_128>)else
                    ()  
                    
                       )
                       
                      )
                    
                     }
                </ISO8583_XML_CONTENT>
            </ISO8583>
        </ns0:procesaMensajeGenericoSwitchFacadeRequest>
};

declare variable $convertISO8583ToXMLResponse as element(ns1:convertISO8583ToXMLResponse) external;

xf:procesaMensajeGenericoSwitchFacadeIn_new($convertISO8583ToXMLResponse)