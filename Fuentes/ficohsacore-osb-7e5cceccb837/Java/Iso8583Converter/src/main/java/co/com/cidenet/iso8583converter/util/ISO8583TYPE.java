package co.com.cidenet.iso8583converter.util;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlType;

/**
 * <p>
 * Clase Java para ISO8583_TYPE complex type.
 * 
 * <p>
 * El siguiente fragmento de esquema especifica el contenido que se espera que
 * haya en esta clase.
 * 
 * <pre>
 * &lt;complexType name="ISO8583_TYPE">
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="MTI" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="PrimaryAccountNumber_002" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="ProcessingCode_003" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="AmountTransaction_004" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="AmountSettlement_005" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="AmountCardholderBilling_006" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="TransmissionDateTime_007" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="AmountCardholderBillingFee_008" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="ConversionRateSettlement_009" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="ConversionRateCardholderBilling_010" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="SystemTraceAuditNumber_011" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="TimeLocalTransaction_012" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="DateLocalTransaction_013" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="DateExpiration_014" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="DateSettlement_015" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="DateConversion_016" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="DateCapture_017" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="MerchantType_018" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="AcquiringInstitutionCountryCode_019" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="PANExtendedCountryCode_020" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="ForwardingInstitutionCountryCode_021" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="PointOfServiceEntryMode_022" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="ApplicationPANSequenceNumber_023" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="FunctionCode_024" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="PointOfServiceConditionCode_025" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="PointOfServiceCaptureCode_026" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="AuthorizingIdentificationResponseLength_027" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="AmountTransactionFee_028" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="AmountSettlementFee_029" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="AmountTransactionProcessingFee_030" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="AmountSettlementProcessingFee_031" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="AcquiringInstitutionIdentificationCode_032" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="ForwardingInstitutionIdentificationCode_033" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="PrimaryAccountNumberExtended_034" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="Track2Data_035" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="Track3Data_036" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="RetrievalReferenceNumber_037" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="AuthorizationIdentificationResponse_038" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="ResponseCode_039" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="ServiceRestrictionCode_040" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="CardAcceptorTerminalIdentification_041" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="CardAcceptorIdentificationCode_042" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="CardAcceptorNameLocation_043" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="AdditionalResponseData_044" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="Track1Data_045" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="AdditionalDataISO_046" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="AdditionalDataNational_047" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="AdditionalDataPrivate_048" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="CurrencyCodeTransaction_049" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="CurrencyCodeSettlement_050" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="CurrencyCodeCardholderBilling_051" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="PersonalIdentificationNumberData_052" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="SecurityRelatedControlInformation_053" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="AdditionalAmounts_054" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="ReservedISO_055" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="ReservedISO_056" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="ReservedNational_057" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="ReservedNational_058" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="ReservedNational_059" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="ReservedNational_060" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="ReservedPrivate_061" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="ReservedPrivate_062" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="ReservedPrivate_063" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="MessageAuthenticationCode_064" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="BitmapExtended_065" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="SettlementCode_066" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="ExtendedPaymentCode_067" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="ReceivingInstitutionCountryCode_068" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="SettlementInstitutionCountryCode_069" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="NetworkManagementInformationCode_070" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="MessageNumber_071" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="MessageNumberLast_072" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="DateAction_073" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="CreditsNumber_074" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="CreditsReversalNumber_075" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="DebitsNumber_076" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="DebitsReversalNumber_077" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="TransferNumber_078" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="TransferReversalNumber_079" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="InquiriesNumber_080" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="AuthorizationsNumber_081" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="CreditsProcessingFeeAmount_082" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="CreditsTransactionFeeAmount_083" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="DebitsProcessingFeeAmount_084" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="DebitsTransactionFeeAmount_085" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="CreditsAmount_086" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="CreditsReversalAmount_087" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="DebitsAmount_088" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="DebitsReversalAmount_089" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="OriginalDataElements_090" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="FileUpdateCode_091" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="FileSecurityCode_092" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="ResponseIndicator_093" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="ServiceIndicator_094" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="ReplacementAmounts_095" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="MessageSecurityCode_096" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="AmountNetSettlement_097" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="Payee_098" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="SettlementInstitutionIdentificationCode_099" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="ReceivingInstitutionIdentificationCode_100" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="FileName_101" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="AccountIdentification1_102" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="AccountIdentification2_103" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="TransactionDescription_104" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="ReservedForISOUse_105" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="ReservedForISOUse_106" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="ReservedForISOUse_107" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="ReservedForISOUse_108" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="ReservedForISOUse_109" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="ReservedForISOUse_110" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="ReservedForISOUse_111" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="ReservedForNationalUse_112" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="ReservedForNationalUse_113" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="ReservedForNationalUse_114" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="ReservedForNationalUse_115" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="ReservedForNationalUse_116" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="ReservedForNationalUse_117" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="ReservedForNationalUse_118" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="ReservedForNationalUse_119" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="ReservedForPrivateUse_120" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="ReservedForPrivateUse_121" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="ReservedForPrivateUse_122" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="ReservedForPrivateUse_123" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="ReservedForPrivateUse_124" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="ReservedForPrivateUse_125" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="ReservedForPrivateUse_126" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="ReservedForPrivateUse_127" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="MessageAuthenticationCode_128" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "ISO8583_TYPE", propOrder = { "mti", "primaryAccountNumber002", "processingCode003",
		"amountTransaction004", "amountSettlement005", "amountCardholderBilling006", "transmissionDateTime007",
		"amountCardholderBillingFee008", "conversionRateSettlement009", "conversionRateCardholderBilling010",
		"systemTraceAuditNumber011", "timeLocalTransaction012", "dateLocalTransaction013", "dateExpiration014",
		"dateSettlement015", "dateConversion016", "dateCapture017", "merchantType018",
		"acquiringInstitutionCountryCode019", "panExtendedCountryCode020", "forwardingInstitutionCountryCode021",
		"pointOfServiceEntryMode022", "applicationPANSequenceNumber023", "functionCode024",
		"pointOfServiceConditionCode025", "pointOfServiceCaptureCode026", "authorizingIdentificationResponseLength027",
		"amountTransactionFee028", "amountSettlementFee029", "amountTransactionProcessingFee030",
		"amountSettlementProcessingFee031", "acquiringInstitutionIdentificationCode032",
		"forwardingInstitutionIdentificationCode033", "primaryAccountNumberExtended034", "track2Data035",
		"track3Data036", "retrievalReferenceNumber037", "authorizationIdentificationResponse038", "responseCode039",
		"serviceRestrictionCode040", "cardAcceptorTerminalIdentification041", "cardAcceptorIdentificationCode042",
		"cardAcceptorNameLocation043", "additionalResponseData044", "track1Data045", "additionalDataISO046",
		"additionalDataNational047", "additionalDataPrivate048", "currencyCodeTransaction049",
		"currencyCodeSettlement050", "currencyCodeCardholderBilling051", "personalIdentificationNumberData052",
		"securityRelatedControlInformation053", "additionalAmounts054", "reservedISO055", "reservedISO056",
		"reservedNational057", "reservedNational058", "reservedNational059", "reservedNational060",
		"reservedPrivate061", "reservedPrivate062", "reservedPrivate063", "messageAuthenticationCode064",
		"bitmapExtended065", "settlementCode066", "extendedPaymentCode067", "receivingInstitutionCountryCode068",
		"settlementInstitutionCountryCode069", "networkManagementInformationCode070", "messageNumber071",
		"messageNumberLast072", "dateAction073", "creditsNumber074", "creditsReversalNumber075", "debitsNumber076",
		"debitsReversalNumber077", "transferNumber078", "transferReversalNumber079", "inquiriesNumber080",
		"authorizationsNumber081", "creditsProcessingFeeAmount082", "creditsTransactionFeeAmount083",
		"debitsProcessingFeeAmount084", "debitsTransactionFeeAmount085", "creditsAmount086", "creditsReversalAmount087",
		"debitsAmount088", "debitsReversalAmount089", "originalDataElements090", "fileUpdateCode091",
		"fileSecurityCode092", "responseIndicator093", "serviceIndicator094", "replacementAmounts095",
		"messageSecurityCode096", "amountNetSettlement097", "payee098", "settlementInstitutionIdentificationCode099",
		"receivingInstitutionIdentificationCode100", "fileName101", "accountIdentification1102",
		"accountIdentification2103", "transactionDescription104", "reservedForISOUse105", "reservedForISOUse106",
		"reservedForISOUse107", "reservedForISOUse108", "reservedForISOUse109", "reservedForISOUse110",
		"reservedForISOUse111", "reservedForNationalUse112", "reservedForNationalUse113", "reservedForNationalUse114",
		"reservedForNationalUse115", "reservedForNationalUse116", "reservedForNationalUse117",
		"reservedForNationalUse118", "reservedForNationalUse119", "reservedForPrivateUse120",
		"reservedForPrivateUse121", "reservedForPrivateUse122", "reservedForPrivateUse123", "reservedForPrivateUse124",
		"reservedForPrivateUse125", "reservedForPrivateUse126", "reservedForPrivateUse127",
		"messageAuthenticationCode128" })
public class ISO8583TYPE {

	@XmlElement(name = "MTI")
	protected String mti;
	@XmlElement(name = "PrimaryAccountNumber_002")
	protected String primaryAccountNumber002;
	@XmlElement(name = "ProcessingCode_003")
	protected String processingCode003;
	@XmlElement(name = "AmountTransaction_004")
	protected String amountTransaction004;
	@XmlElement(name = "AmountSettlement_005")
	protected String amountSettlement005;
	@XmlElement(name = "AmountCardholderBilling_006")
	protected String amountCardholderBilling006;
	@XmlElement(name = "TransmissionDateTime_007")
	protected String transmissionDateTime007;
	@XmlElement(name = "AmountCardholderBillingFee_008")
	protected String amountCardholderBillingFee008;
	@XmlElement(name = "ConversionRateSettlement_009")
	protected String conversionRateSettlement009;
	@XmlElement(name = "ConversionRateCardholderBilling_010")
	protected String conversionRateCardholderBilling010;
	@XmlElement(name = "SystemTraceAuditNumber_011")
	protected String systemTraceAuditNumber011;
	@XmlElement(name = "TimeLocalTransaction_012")
	protected String timeLocalTransaction012;
	@XmlElement(name = "DateLocalTransaction_013")
	protected String dateLocalTransaction013;
	@XmlElement(name = "DateExpiration_014")
	protected String dateExpiration014;
	@XmlElement(name = "DateSettlement_015")
	protected String dateSettlement015;
	@XmlElement(name = "DateConversion_016")
	protected String dateConversion016;
	@XmlElement(name = "DateCapture_017")
	protected String dateCapture017;
	@XmlElement(name = "MerchantType_018")
	protected String merchantType018;
	@XmlElement(name = "AcquiringInstitutionCountryCode_019")
	protected String acquiringInstitutionCountryCode019;
	@XmlElement(name = "PANExtendedCountryCode_020")
	protected String panExtendedCountryCode020;
	@XmlElement(name = "ForwardingInstitutionCountryCode_021")
	protected String forwardingInstitutionCountryCode021;
	@XmlElement(name = "PointOfServiceEntryMode_022")
	protected String pointOfServiceEntryMode022;
	@XmlElement(name = "ApplicationPANSequenceNumber_023")
	protected String applicationPANSequenceNumber023;
	@XmlElement(name = "FunctionCode_024")
	protected String functionCode024;
	@XmlElement(name = "PointOfServiceConditionCode_025")
	protected String pointOfServiceConditionCode025;
	@XmlElement(name = "PointOfServiceCaptureCode_026")
	protected String pointOfServiceCaptureCode026;
	@XmlElement(name = "AuthorizingIdentificationResponseLength_027")
	protected String authorizingIdentificationResponseLength027;
	@XmlElement(name = "AmountTransactionFee_028")
	protected String amountTransactionFee028;
	@XmlElement(name = "AmountSettlementFee_029")
	protected String amountSettlementFee029;
	@XmlElement(name = "AmountTransactionProcessingFee_030")
	protected String amountTransactionProcessingFee030;
	@XmlElement(name = "AmountSettlementProcessingFee_031")
	protected String amountSettlementProcessingFee031;
	@XmlElement(name = "AcquiringInstitutionIdentificationCode_032")
	protected String acquiringInstitutionIdentificationCode032;
	@XmlElement(name = "ForwardingInstitutionIdentificationCode_033")
	protected String forwardingInstitutionIdentificationCode033;
	@XmlElement(name = "PrimaryAccountNumberExtended_034")
	protected String primaryAccountNumberExtended034;
	@XmlElement(name = "Track2Data_035")
	protected String track2Data035;
	@XmlElement(name = "Track3Data_036")
	protected String track3Data036;
	@XmlElement(name = "RetrievalReferenceNumber_037")
	protected String retrievalReferenceNumber037;
	@XmlElement(name = "AuthorizationIdentificationResponse_038")
	protected String authorizationIdentificationResponse038;
	@XmlElement(name = "ResponseCode_039")
	protected String responseCode039;
	@XmlElement(name = "ServiceRestrictionCode_040")
	protected String serviceRestrictionCode040;
	@XmlElement(name = "CardAcceptorTerminalIdentification_041")
	protected String cardAcceptorTerminalIdentification041;
	@XmlElement(name = "CardAcceptorIdentificationCode_042")
	protected String cardAcceptorIdentificationCode042;
	@XmlElement(name = "CardAcceptorNameLocation_043")
	protected String cardAcceptorNameLocation043;
	@XmlElement(name = "AdditionalResponseData_044")
	protected String additionalResponseData044;
	@XmlElement(name = "Track1Data_045")
	protected String track1Data045;
	@XmlElement(name = "AdditionalDataISO_046")
	protected String additionalDataISO046;
	@XmlElement(name = "AdditionalDataNational_047")
	protected String additionalDataNational047;
	@XmlElement(name = "AdditionalDataPrivate_048")
	protected String additionalDataPrivate048;
	@XmlElement(name = "CurrencyCodeTransaction_049")
	protected String currencyCodeTransaction049;
	@XmlElement(name = "CurrencyCodeSettlement_050")
	protected String currencyCodeSettlement050;
	@XmlElement(name = "CurrencyCodeCardholderBilling_051")
	protected String currencyCodeCardholderBilling051;
	@XmlElement(name = "PersonalIdentificationNumberData_052")
	protected String personalIdentificationNumberData052;
	@XmlElement(name = "SecurityRelatedControlInformation_053")
	protected String securityRelatedControlInformation053;
	@XmlElement(name = "AdditionalAmounts_054")
	protected String additionalAmounts054;
	@XmlElement(name = "ReservedISO_055")
	protected String reservedISO055;
	@XmlElement(name = "ReservedISO_056")
	protected String reservedISO056;
	@XmlElement(name = "ReservedNational_057")
	protected String reservedNational057;
	@XmlElement(name = "ReservedNational_058")
	protected String reservedNational058;
	@XmlElement(name = "ReservedNational_059")
	protected String reservedNational059;
	@XmlElement(name = "ReservedNational_060")
	protected String reservedNational060;
	@XmlElement(name = "ReservedPrivate_061")
	protected String reservedPrivate061;
	@XmlElement(name = "ReservedPrivate_062")
	protected String reservedPrivate062;
	@XmlElement(name = "ReservedPrivate_063")
	protected String reservedPrivate063;
	@XmlElement(name = "MessageAuthenticationCode_064")
	protected String messageAuthenticationCode064;
	@XmlElement(name = "BitmapExtended_065")
	protected String bitmapExtended065;
	@XmlElement(name = "SettlementCode_066")
	protected String settlementCode066;
	@XmlElement(name = "ExtendedPaymentCode_067")
	protected String extendedPaymentCode067;
	@XmlElement(name = "ReceivingInstitutionCountryCode_068")
	protected String receivingInstitutionCountryCode068;
	@XmlElement(name = "SettlementInstitutionCountryCode_069")
	protected String settlementInstitutionCountryCode069;
	@XmlElement(name = "NetworkManagementInformationCode_070")
	protected String networkManagementInformationCode070;
	@XmlElement(name = "MessageNumber_071")
	protected String messageNumber071;
	@XmlElement(name = "MessageNumberLast_072")
	protected String messageNumberLast072;
	@XmlElement(name = "DateAction_073")
	protected String dateAction073;
	@XmlElement(name = "CreditsNumber_074")
	protected String creditsNumber074;
	@XmlElement(name = "CreditsReversalNumber_075")
	protected String creditsReversalNumber075;
	@XmlElement(name = "DebitsNumber_076")
	protected String debitsNumber076;
	@XmlElement(name = "DebitsReversalNumber_077")
	protected String debitsReversalNumber077;
	@XmlElement(name = "TransferNumber_078")
	protected String transferNumber078;
	@XmlElement(name = "TransferReversalNumber_079")
	protected String transferReversalNumber079;
	@XmlElement(name = "InquiriesNumber_080")
	protected String inquiriesNumber080;
	@XmlElement(name = "AuthorizationsNumber_081")
	protected String authorizationsNumber081;
	@XmlElement(name = "CreditsProcessingFeeAmount_082")
	protected String creditsProcessingFeeAmount082;
	@XmlElement(name = "CreditsTransactionFeeAmount_083")
	protected String creditsTransactionFeeAmount083;
	@XmlElement(name = "DebitsProcessingFeeAmount_084")
	protected String debitsProcessingFeeAmount084;
	@XmlElement(name = "DebitsTransactionFeeAmount_085")
	protected String debitsTransactionFeeAmount085;
	@XmlElement(name = "CreditsAmount_086")
	protected String creditsAmount086;
	@XmlElement(name = "CreditsReversalAmount_087")
	protected String creditsReversalAmount087;
	@XmlElement(name = "DebitsAmount_088")
	protected String debitsAmount088;
	@XmlElement(name = "DebitsReversalAmount_089")
	protected String debitsReversalAmount089;
	@XmlElement(name = "OriginalDataElements_090")
	protected String originalDataElements090;
	@XmlElement(name = "FileUpdateCode_091")
	protected String fileUpdateCode091;
	@XmlElement(name = "FileSecurityCode_092")
	protected String fileSecurityCode092;
	@XmlElement(name = "ResponseIndicator_093")
	protected String responseIndicator093;
	@XmlElement(name = "ServiceIndicator_094")
	protected String serviceIndicator094;
	@XmlElement(name = "ReplacementAmounts_095")
	protected String replacementAmounts095;
	@XmlElement(name = "MessageSecurityCode_096")
	protected String messageSecurityCode096;
	@XmlElement(name = "AmountNetSettlement_097")
	protected String amountNetSettlement097;
	@XmlElement(name = "Payee_098")
	protected String payee098;
	@XmlElement(name = "SettlementInstitutionIdentificationCode_099")
	protected String settlementInstitutionIdentificationCode099;
	@XmlElement(name = "ReceivingInstitutionIdentificationCode_100")
	protected String receivingInstitutionIdentificationCode100;
	@XmlElement(name = "FileName_101")
	protected String fileName101;
	@XmlElement(name = "AccountIdentification1_102")
	protected String accountIdentification1102;
	@XmlElement(name = "AccountIdentification2_103")
	protected String accountIdentification2103;
	@XmlElement(name = "TransactionDescription_104")
	protected String transactionDescription104;
	@XmlElement(name = "ReservedForISOUse_105")
	protected String reservedForISOUse105;
	@XmlElement(name = "ReservedForISOUse_106")
	protected String reservedForISOUse106;
	@XmlElement(name = "ReservedForISOUse_107")
	protected String reservedForISOUse107;
	@XmlElement(name = "ReservedForISOUse_108")
	protected String reservedForISOUse108;
	@XmlElement(name = "ReservedForISOUse_109")
	protected String reservedForISOUse109;
	@XmlElement(name = "ReservedForISOUse_110")
	protected String reservedForISOUse110;
	@XmlElement(name = "ReservedForISOUse_111")
	protected String reservedForISOUse111;
	@XmlElement(name = "ReservedForNationalUse_112")
	protected String reservedForNationalUse112;
	@XmlElement(name = "ReservedForNationalUse_113")
	protected String reservedForNationalUse113;
	@XmlElement(name = "ReservedForNationalUse_114")
	protected String reservedForNationalUse114;
	@XmlElement(name = "ReservedForNationalUse_115")
	protected String reservedForNationalUse115;
	@XmlElement(name = "ReservedForNationalUse_116")
	protected String reservedForNationalUse116;
	@XmlElement(name = "ReservedForNationalUse_117")
	protected String reservedForNationalUse117;
	@XmlElement(name = "ReservedForNationalUse_118")
	protected String reservedForNationalUse118;
	@XmlElement(name = "ReservedForNationalUse_119")
	protected String reservedForNationalUse119;
	@XmlElement(name = "ReservedForPrivateUse_120")
	protected String reservedForPrivateUse120;
	@XmlElement(name = "ReservedForPrivateUse_121")
	protected String reservedForPrivateUse121;
	@XmlElement(name = "ReservedForPrivateUse_122")
	protected String reservedForPrivateUse122;
	@XmlElement(name = "ReservedForPrivateUse_123")
	protected String reservedForPrivateUse123;
	@XmlElement(name = "ReservedForPrivateUse_124")
	protected String reservedForPrivateUse124;
	@XmlElement(name = "ReservedForPrivateUse_125")
	protected String reservedForPrivateUse125;
	@XmlElement(name = "ReservedForPrivateUse_126")
	protected String reservedForPrivateUse126;
	@XmlElement(name = "ReservedForPrivateUse_127")
	protected String reservedForPrivateUse127;
	@XmlElement(name = "MessageAuthenticationCode_128")
	protected String messageAuthenticationCode128;

	/**
	 * Obtiene el valor de la propiedad mti.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getMTI() {
		return mti;
	}

	/**
	 * Define el valor de la propiedad mti.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setMTI(String value) {
		this.mti = value;
	}

	/**
	 * Obtiene el valor de la propiedad primaryAccountNumber002.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getPrimaryAccountNumber002() {
		return primaryAccountNumber002;
	}

	/**
	 * Define el valor de la propiedad primaryAccountNumber002.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setPrimaryAccountNumber002(String value) {
		this.primaryAccountNumber002 = value;
	}

	/**
	 * Obtiene el valor de la propiedad processingCode003.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getProcessingCode003() {
		return processingCode003;
	}

	/**
	 * Define el valor de la propiedad processingCode003.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setProcessingCode003(String value) {
		this.processingCode003 = value;
	}

	/**
	 * Obtiene el valor de la propiedad amountTransaction004.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getAmountTransaction004() {
		return amountTransaction004;
	}

	/**
	 * Define el valor de la propiedad amountTransaction004.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setAmountTransaction004(String value) {
		this.amountTransaction004 = value;
	}

	/**
	 * Obtiene el valor de la propiedad amountSettlement005.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getAmountSettlement005() {
		return amountSettlement005;
	}

	/**
	 * Define el valor de la propiedad amountSettlement005.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setAmountSettlement005(String value) {
		this.amountSettlement005 = value;
	}

	/**
	 * Obtiene el valor de la propiedad amountCardholderBilling006.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getAmountCardholderBilling006() {
		return amountCardholderBilling006;
	}

	/**
	 * Define el valor de la propiedad amountCardholderBilling006.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setAmountCardholderBilling006(String value) {
		this.amountCardholderBilling006 = value;
	}

	/**
	 * Obtiene el valor de la propiedad transmissionDateTime007.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getTransmissionDateTime007() {
		return transmissionDateTime007;
	}

	/**
	 * Define el valor de la propiedad transmissionDateTime007.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setTransmissionDateTime007(String value) {
		this.transmissionDateTime007 = value;
	}

	/**
	 * Obtiene el valor de la propiedad amountCardholderBillingFee008.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getAmountCardholderBillingFee008() {
		return amountCardholderBillingFee008;
	}

	/**
	 * Define el valor de la propiedad amountCardholderBillingFee008.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setAmountCardholderBillingFee008(String value) {
		this.amountCardholderBillingFee008 = value;
	}

	/**
	 * Obtiene el valor de la propiedad conversionRateSettlement009.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getConversionRateSettlement009() {
		return conversionRateSettlement009;
	}

	/**
	 * Define el valor de la propiedad conversionRateSettlement009.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setConversionRateSettlement009(String value) {
		this.conversionRateSettlement009 = value;
	}

	/**
	 * Obtiene el valor de la propiedad conversionRateCardholderBilling010.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getConversionRateCardholderBilling010() {
		return conversionRateCardholderBilling010;
	}

	/**
	 * Define el valor de la propiedad conversionRateCardholderBilling010.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setConversionRateCardholderBilling010(String value) {
		this.conversionRateCardholderBilling010 = value;
	}

	/**
	 * Obtiene el valor de la propiedad systemTraceAuditNumber011.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getSystemTraceAuditNumber011() {
		return systemTraceAuditNumber011;
	}

	/**
	 * Define el valor de la propiedad systemTraceAuditNumber011.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setSystemTraceAuditNumber011(String value) {
		this.systemTraceAuditNumber011 = value;
	}

	/**
	 * Obtiene el valor de la propiedad timeLocalTransaction012.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getTimeLocalTransaction012() {
		return timeLocalTransaction012;
	}

	/**
	 * Define el valor de la propiedad timeLocalTransaction012.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setTimeLocalTransaction012(String value) {
		this.timeLocalTransaction012 = value;
	}

	/**
	 * Obtiene el valor de la propiedad dateLocalTransaction013.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getDateLocalTransaction013() {
		return dateLocalTransaction013;
	}

	/**
	 * Define el valor de la propiedad dateLocalTransaction013.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setDateLocalTransaction013(String value) {
		this.dateLocalTransaction013 = value;
	}

	/**
	 * Obtiene el valor de la propiedad dateExpiration014.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getDateExpiration014() {
		return dateExpiration014;
	}

	/**
	 * Define el valor de la propiedad dateExpiration014.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setDateExpiration014(String value) {
		this.dateExpiration014 = value;
	}

	/**
	 * Obtiene el valor de la propiedad dateSettlement015.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getDateSettlement015() {
		return dateSettlement015;
	}

	/**
	 * Define el valor de la propiedad dateSettlement015.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setDateSettlement015(String value) {
		this.dateSettlement015 = value;
	}

	/**
	 * Obtiene el valor de la propiedad dateConversion016.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getDateConversion016() {
		return dateConversion016;
	}

	/**
	 * Define el valor de la propiedad dateConversion016.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setDateConversion016(String value) {
		this.dateConversion016 = value;
	}

	/**
	 * Obtiene el valor de la propiedad dateCapture017.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getDateCapture017() {
		return dateCapture017;
	}

	/**
	 * Define el valor de la propiedad dateCapture017.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setDateCapture017(String value) {
		this.dateCapture017 = value;
	}

	/**
	 * Obtiene el valor de la propiedad merchantType018.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getMerchantType018() {
		return merchantType018;
	}

	/**
	 * Define el valor de la propiedad merchantType018.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setMerchantType018(String value) {
		this.merchantType018 = value;
	}

	/**
	 * Obtiene el valor de la propiedad acquiringInstitutionCountryCode019.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getAcquiringInstitutionCountryCode019() {
		return acquiringInstitutionCountryCode019;
	}

	/**
	 * Define el valor de la propiedad acquiringInstitutionCountryCode019.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setAcquiringInstitutionCountryCode019(String value) {
		this.acquiringInstitutionCountryCode019 = value;
	}

	/**
	 * Obtiene el valor de la propiedad panExtendedCountryCode020.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getPANExtendedCountryCode020() {
		return panExtendedCountryCode020;
	}

	/**
	 * Define el valor de la propiedad panExtendedCountryCode020.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setPANExtendedCountryCode020(String value) {
		this.panExtendedCountryCode020 = value;
	}

	/**
	 * Obtiene el valor de la propiedad forwardingInstitutionCountryCode021.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getForwardingInstitutionCountryCode021() {
		return forwardingInstitutionCountryCode021;
	}

	/**
	 * Define el valor de la propiedad forwardingInstitutionCountryCode021.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setForwardingInstitutionCountryCode021(String value) {
		this.forwardingInstitutionCountryCode021 = value;
	}

	/**
	 * Obtiene el valor de la propiedad pointOfServiceEntryMode022.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getPointOfServiceEntryMode022() {
		return pointOfServiceEntryMode022;
	}

	/**
	 * Define el valor de la propiedad pointOfServiceEntryMode022.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setPointOfServiceEntryMode022(String value) {
		this.pointOfServiceEntryMode022 = value;
	}

	/**
	 * Obtiene el valor de la propiedad applicationPANSequenceNumber023.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getApplicationPANSequenceNumber023() {
		return applicationPANSequenceNumber023;
	}

	/**
	 * Define el valor de la propiedad applicationPANSequenceNumber023.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setApplicationPANSequenceNumber023(String value) {
		this.applicationPANSequenceNumber023 = value;
	}

	/**
	 * Obtiene el valor de la propiedad functionCode024.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getFunctionCode024() {
		return functionCode024;
	}

	/**
	 * Define el valor de la propiedad functionCode024.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setFunctionCode024(String value) {
		this.functionCode024 = value;
	}

	/**
	 * Obtiene el valor de la propiedad pointOfServiceConditionCode025.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getPointOfServiceConditionCode025() {
		return pointOfServiceConditionCode025;
	}

	/**
	 * Define el valor de la propiedad pointOfServiceConditionCode025.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setPointOfServiceConditionCode025(String value) {
		this.pointOfServiceConditionCode025 = value;
	}

	/**
	 * Obtiene el valor de la propiedad pointOfServiceCaptureCode026.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getPointOfServiceCaptureCode026() {
		return pointOfServiceCaptureCode026;
	}

	/**
	 * Define el valor de la propiedad pointOfServiceCaptureCode026.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setPointOfServiceCaptureCode026(String value) {
		this.pointOfServiceCaptureCode026 = value;
	}

	/**
	 * Obtiene el valor de la propiedad authorizingIdentificationResponseLength027.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getAuthorizingIdentificationResponseLength027() {
		return authorizingIdentificationResponseLength027;
	}

	/**
	 * Define el valor de la propiedad authorizingIdentificationResponseLength027.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setAuthorizingIdentificationResponseLength027(String value) {
		this.authorizingIdentificationResponseLength027 = value;
	}

	/**
	 * Obtiene el valor de la propiedad amountTransactionFee028.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getAmountTransactionFee028() {
		return amountTransactionFee028;
	}

	/**
	 * Define el valor de la propiedad amountTransactionFee028.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setAmountTransactionFee028(String value) {
		this.amountTransactionFee028 = value;
	}

	/**
	 * Obtiene el valor de la propiedad amountSettlementFee029.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getAmountSettlementFee029() {
		return amountSettlementFee029;
	}

	/**
	 * Define el valor de la propiedad amountSettlementFee029.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setAmountSettlementFee029(String value) {
		this.amountSettlementFee029 = value;
	}

	/**
	 * Obtiene el valor de la propiedad amountTransactionProcessingFee030.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getAmountTransactionProcessingFee030() {
		return amountTransactionProcessingFee030;
	}

	/**
	 * Define el valor de la propiedad amountTransactionProcessingFee030.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setAmountTransactionProcessingFee030(String value) {
		this.amountTransactionProcessingFee030 = value;
	}

	/**
	 * Obtiene el valor de la propiedad amountSettlementProcessingFee031.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getAmountSettlementProcessingFee031() {
		return amountSettlementProcessingFee031;
	}

	/**
	 * Define el valor de la propiedad amountSettlementProcessingFee031.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setAmountSettlementProcessingFee031(String value) {
		this.amountSettlementProcessingFee031 = value;
	}

	/**
	 * Obtiene el valor de la propiedad acquiringInstitutionIdentificationCode032.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getAcquiringInstitutionIdentificationCode032() {
		return acquiringInstitutionIdentificationCode032;
	}

	/**
	 * Define el valor de la propiedad acquiringInstitutionIdentificationCode032.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setAcquiringInstitutionIdentificationCode032(String value) {
		this.acquiringInstitutionIdentificationCode032 = value;
	}

	/**
	 * Obtiene el valor de la propiedad forwardingInstitutionIdentificationCode033.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getForwardingInstitutionIdentificationCode033() {
		return forwardingInstitutionIdentificationCode033;
	}

	/**
	 * Define el valor de la propiedad forwardingInstitutionIdentificationCode033.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setForwardingInstitutionIdentificationCode033(String value) {
		this.forwardingInstitutionIdentificationCode033 = value;
	}

	/**
	 * Obtiene el valor de la propiedad primaryAccountNumberExtended034.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getPrimaryAccountNumberExtended034() {
		return primaryAccountNumberExtended034;
	}

	/**
	 * Define el valor de la propiedad primaryAccountNumberExtended034.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setPrimaryAccountNumberExtended034(String value) {
		this.primaryAccountNumberExtended034 = value;
	}

	/**
	 * Obtiene el valor de la propiedad track2Data035.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getTrack2Data035() {
		return track2Data035;
	}

	/**
	 * Define el valor de la propiedad track2Data035.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setTrack2Data035(String value) {
		this.track2Data035 = value;
	}

	/**
	 * Obtiene el valor de la propiedad track3Data036.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getTrack3Data036() {
		return track3Data036;
	}

	/**
	 * Define el valor de la propiedad track3Data036.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setTrack3Data036(String value) {
		this.track3Data036 = value;
	}

	/**
	 * Obtiene el valor de la propiedad retrievalReferenceNumber037.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getRetrievalReferenceNumber037() {
		return retrievalReferenceNumber037;
	}

	/**
	 * Define el valor de la propiedad retrievalReferenceNumber037.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setRetrievalReferenceNumber037(String value) {
		this.retrievalReferenceNumber037 = value;
	}

	/**
	 * Obtiene el valor de la propiedad authorizationIdentificationResponse038.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getAuthorizationIdentificationResponse038() {
		return authorizationIdentificationResponse038;
	}

	/**
	 * Define el valor de la propiedad authorizationIdentificationResponse038.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setAuthorizationIdentificationResponse038(String value) {
		this.authorizationIdentificationResponse038 = value;
	}

	/**
	 * Obtiene el valor de la propiedad responseCode039.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getResponseCode039() {
		return responseCode039;
	}

	/**
	 * Define el valor de la propiedad responseCode039.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setResponseCode039(String value) {
		this.responseCode039 = value;
	}

	/**
	 * Obtiene el valor de la propiedad serviceRestrictionCode040.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getServiceRestrictionCode040() {
		return serviceRestrictionCode040;
	}

	/**
	 * Define el valor de la propiedad serviceRestrictionCode040.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setServiceRestrictionCode040(String value) {
		this.serviceRestrictionCode040 = value;
	}

	/**
	 * Obtiene el valor de la propiedad cardAcceptorTerminalIdentification041.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getCardAcceptorTerminalIdentification041() {
		return cardAcceptorTerminalIdentification041;
	}

	/**
	 * Define el valor de la propiedad cardAcceptorTerminalIdentification041.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setCardAcceptorTerminalIdentification041(String value) {
		this.cardAcceptorTerminalIdentification041 = value;
	}

	/**
	 * Obtiene el valor de la propiedad cardAcceptorIdentificationCode042.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getCardAcceptorIdentificationCode042() {
		return cardAcceptorIdentificationCode042;
	}

	/**
	 * Define el valor de la propiedad cardAcceptorIdentificationCode042.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setCardAcceptorIdentificationCode042(String value) {
		this.cardAcceptorIdentificationCode042 = value;
	}

	/**
	 * Obtiene el valor de la propiedad cardAcceptorNameLocation043.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getCardAcceptorNameLocation043() {
		return cardAcceptorNameLocation043;
	}

	/**
	 * Define el valor de la propiedad cardAcceptorNameLocation043.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setCardAcceptorNameLocation043(String value) {
		this.cardAcceptorNameLocation043 = value;
	}

	/**
	 * Obtiene el valor de la propiedad additionalResponseData044.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getAdditionalResponseData044() {
		return additionalResponseData044;
	}

	/**
	 * Define el valor de la propiedad additionalResponseData044.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setAdditionalResponseData044(String value) {
		this.additionalResponseData044 = value;
	}

	/**
	 * Obtiene el valor de la propiedad track1Data045.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getTrack1Data045() {
		return track1Data045;
	}

	/**
	 * Define el valor de la propiedad track1Data045.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setTrack1Data045(String value) {
		this.track1Data045 = value;
	}

	/**
	 * Obtiene el valor de la propiedad additionalDataISO046.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getAdditionalDataISO046() {
		return additionalDataISO046;
	}

	/**
	 * Define el valor de la propiedad additionalDataISO046.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setAdditionalDataISO046(String value) {
		this.additionalDataISO046 = value;
	}

	/**
	 * Obtiene el valor de la propiedad additionalDataNational047.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getAdditionalDataNational047() {
		return additionalDataNational047;
	}

	/**
	 * Define el valor de la propiedad additionalDataNational047.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setAdditionalDataNational047(String value) {
		this.additionalDataNational047 = value;
	}

	/**
	 * Obtiene el valor de la propiedad additionalDataPrivate048.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getAdditionalDataPrivate048() {
		return additionalDataPrivate048;
	}

	/**
	 * Define el valor de la propiedad additionalDataPrivate048.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setAdditionalDataPrivate048(String value) {
		this.additionalDataPrivate048 = value;
	}

	/**
	 * Obtiene el valor de la propiedad currencyCodeTransaction049.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getCurrencyCodeTransaction049() {
		return currencyCodeTransaction049;
	}

	/**
	 * Define el valor de la propiedad currencyCodeTransaction049.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setCurrencyCodeTransaction049(String value) {
		this.currencyCodeTransaction049 = value;
	}

	/**
	 * Obtiene el valor de la propiedad currencyCodeSettlement050.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getCurrencyCodeSettlement050() {
		return currencyCodeSettlement050;
	}

	/**
	 * Define el valor de la propiedad currencyCodeSettlement050.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setCurrencyCodeSettlement050(String value) {
		this.currencyCodeSettlement050 = value;
	}

	/**
	 * Obtiene el valor de la propiedad currencyCodeCardholderBilling051.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getCurrencyCodeCardholderBilling051() {
		return currencyCodeCardholderBilling051;
	}

	/**
	 * Define el valor de la propiedad currencyCodeCardholderBilling051.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setCurrencyCodeCardholderBilling051(String value) {
		this.currencyCodeCardholderBilling051 = value;
	}

	/**
	 * Obtiene el valor de la propiedad personalIdentificationNumberData052.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getPersonalIdentificationNumberData052() {
		return personalIdentificationNumberData052;
	}

	/**
	 * Define el valor de la propiedad personalIdentificationNumberData052.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setPersonalIdentificationNumberData052(String value) {
		this.personalIdentificationNumberData052 = value;
	}

	/**
	 * Obtiene el valor de la propiedad securityRelatedControlInformation053.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getSecurityRelatedControlInformation053() {
		return securityRelatedControlInformation053;
	}

	/**
	 * Define el valor de la propiedad securityRelatedControlInformation053.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setSecurityRelatedControlInformation053(String value) {
		this.securityRelatedControlInformation053 = value;
	}

	/**
	 * Obtiene el valor de la propiedad additionalAmounts054.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getAdditionalAmounts054() {
		return additionalAmounts054;
	}

	/**
	 * Define el valor de la propiedad additionalAmounts054.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setAdditionalAmounts054(String value) {
		this.additionalAmounts054 = value;
	}

	/**
	 * Obtiene el valor de la propiedad reservedISO055.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getReservedISO055() {
		return reservedISO055;
	}

	/**
	 * Define el valor de la propiedad reservedISO055.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setReservedISO055(String value) {
		this.reservedISO055 = value;
	}

	/**
	 * Obtiene el valor de la propiedad reservedISO056.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getReservedISO056() {
		return reservedISO056;
	}

	/**
	 * Define el valor de la propiedad reservedISO056.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setReservedISO056(String value) {
		this.reservedISO056 = value;
	}

	/**
	 * Obtiene el valor de la propiedad reservedNational057.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getReservedNational057() {
		return reservedNational057;
	}

	/**
	 * Define el valor de la propiedad reservedNational057.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setReservedNational057(String value) {
		this.reservedNational057 = value;
	}

	/**
	 * Obtiene el valor de la propiedad reservedNational058.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getReservedNational058() {
		return reservedNational058;
	}

	/**
	 * Define el valor de la propiedad reservedNational058.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setReservedNational058(String value) {
		this.reservedNational058 = value;
	}

	/**
	 * Obtiene el valor de la propiedad reservedNational059.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getReservedNational059() {
		return reservedNational059;
	}

	/**
	 * Define el valor de la propiedad reservedNational059.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setReservedNational059(String value) {
		this.reservedNational059 = value;
	}

	/**
	 * Obtiene el valor de la propiedad reservedNational060.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getReservedNational060() {
		return reservedNational060;
	}

	/**
	 * Define el valor de la propiedad reservedNational060.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setReservedNational060(String value) {
		this.reservedNational060 = value;
	}

	/**
	 * Obtiene el valor de la propiedad reservedPrivate061.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getReservedPrivate061() {
		return reservedPrivate061;
	}

	/**
	 * Define el valor de la propiedad reservedPrivate061.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setReservedPrivate061(String value) {
		this.reservedPrivate061 = value;
	}

	/**
	 * Obtiene el valor de la propiedad reservedPrivate062.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getReservedPrivate062() {
		return reservedPrivate062;
	}

	/**
	 * Define el valor de la propiedad reservedPrivate062.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setReservedPrivate062(String value) {
		this.reservedPrivate062 = value;
	}

	/**
	 * Obtiene el valor de la propiedad reservedPrivate063.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getReservedPrivate063() {
		return reservedPrivate063;
	}

	/**
	 * Define el valor de la propiedad reservedPrivate063.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setReservedPrivate063(String value) {
		this.reservedPrivate063 = value;
	}

	/**
	 * Obtiene el valor de la propiedad messageAuthenticationCode064.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getMessageAuthenticationCode064() {
		return messageAuthenticationCode064;
	}

	/**
	 * Define el valor de la propiedad messageAuthenticationCode064.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setMessageAuthenticationCode064(String value) {
		this.messageAuthenticationCode064 = value;
	}

	/**
	 * Obtiene el valor de la propiedad bitmapExtended065.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getBitmapExtended065() {
		return bitmapExtended065;
	}

	/**
	 * Define el valor de la propiedad bitmapExtended065.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setBitmapExtended065(String value) {
		this.bitmapExtended065 = value;
	}

	/**
	 * Obtiene el valor de la propiedad settlementCode066.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getSettlementCode066() {
		return settlementCode066;
	}

	/**
	 * Define el valor de la propiedad settlementCode066.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setSettlementCode066(String value) {
		this.settlementCode066 = value;
	}

	/**
	 * Obtiene el valor de la propiedad extendedPaymentCode067.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getExtendedPaymentCode067() {
		return extendedPaymentCode067;
	}

	/**
	 * Define el valor de la propiedad extendedPaymentCode067.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setExtendedPaymentCode067(String value) {
		this.extendedPaymentCode067 = value;
	}

	/**
	 * Obtiene el valor de la propiedad receivingInstitutionCountryCode068.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getReceivingInstitutionCountryCode068() {
		return receivingInstitutionCountryCode068;
	}

	/**
	 * Define el valor de la propiedad receivingInstitutionCountryCode068.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setReceivingInstitutionCountryCode068(String value) {
		this.receivingInstitutionCountryCode068 = value;
	}

	/**
	 * Obtiene el valor de la propiedad settlementInstitutionCountryCode069.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getSettlementInstitutionCountryCode069() {
		return settlementInstitutionCountryCode069;
	}

	/**
	 * Define el valor de la propiedad settlementInstitutionCountryCode069.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setSettlementInstitutionCountryCode069(String value) {
		this.settlementInstitutionCountryCode069 = value;
	}

	/**
	 * Obtiene el valor de la propiedad networkManagementInformationCode070.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getNetworkManagementInformationCode070() {
		return networkManagementInformationCode070;
	}

	/**
	 * Define el valor de la propiedad networkManagementInformationCode070.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setNetworkManagementInformationCode070(String value) {
		this.networkManagementInformationCode070 = value;
	}

	/**
	 * Obtiene el valor de la propiedad messageNumber071.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getMessageNumber071() {
		return messageNumber071;
	}

	/**
	 * Define el valor de la propiedad messageNumber071.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setMessageNumber071(String value) {
		this.messageNumber071 = value;
	}

	/**
	 * Obtiene el valor de la propiedad messageNumberLast072.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getMessageNumberLast072() {
		return messageNumberLast072;
	}

	/**
	 * Define el valor de la propiedad messageNumberLast072.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setMessageNumberLast072(String value) {
		this.messageNumberLast072 = value;
	}

	/**
	 * Obtiene el valor de la propiedad dateAction073.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getDateAction073() {
		return dateAction073;
	}

	/**
	 * Define el valor de la propiedad dateAction073.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setDateAction073(String value) {
		this.dateAction073 = value;
	}

	/**
	 * Obtiene el valor de la propiedad creditsNumber074.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getCreditsNumber074() {
		return creditsNumber074;
	}

	/**
	 * Define el valor de la propiedad creditsNumber074.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setCreditsNumber074(String value) {
		this.creditsNumber074 = value;
	}

	/**
	 * Obtiene el valor de la propiedad creditsReversalNumber075.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getCreditsReversalNumber075() {
		return creditsReversalNumber075;
	}

	/**
	 * Define el valor de la propiedad creditsReversalNumber075.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setCreditsReversalNumber075(String value) {
		this.creditsReversalNumber075 = value;
	}

	/**
	 * Obtiene el valor de la propiedad debitsNumber076.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getDebitsNumber076() {
		return debitsNumber076;
	}

	/**
	 * Define el valor de la propiedad debitsNumber076.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setDebitsNumber076(String value) {
		this.debitsNumber076 = value;
	}

	/**
	 * Obtiene el valor de la propiedad debitsReversalNumber077.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getDebitsReversalNumber077() {
		return debitsReversalNumber077;
	}

	/**
	 * Define el valor de la propiedad debitsReversalNumber077.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setDebitsReversalNumber077(String value) {
		this.debitsReversalNumber077 = value;
	}

	/**
	 * Obtiene el valor de la propiedad transferNumber078.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getTransferNumber078() {
		return transferNumber078;
	}

	/**
	 * Define el valor de la propiedad transferNumber078.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setTransferNumber078(String value) {
		this.transferNumber078 = value;
	}

	/**
	 * Obtiene el valor de la propiedad transferReversalNumber079.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getTransferReversalNumber079() {
		return transferReversalNumber079;
	}

	/**
	 * Define el valor de la propiedad transferReversalNumber079.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setTransferReversalNumber079(String value) {
		this.transferReversalNumber079 = value;
	}

	/**
	 * Obtiene el valor de la propiedad inquiriesNumber080.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getInquiriesNumber080() {
		return inquiriesNumber080;
	}

	/**
	 * Define el valor de la propiedad inquiriesNumber080.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setInquiriesNumber080(String value) {
		this.inquiriesNumber080 = value;
	}

	/**
	 * Obtiene el valor de la propiedad authorizationsNumber081.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getAuthorizationsNumber081() {
		return authorizationsNumber081;
	}

	/**
	 * Define el valor de la propiedad authorizationsNumber081.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setAuthorizationsNumber081(String value) {
		this.authorizationsNumber081 = value;
	}

	/**
	 * Obtiene el valor de la propiedad creditsProcessingFeeAmount082.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getCreditsProcessingFeeAmount082() {
		return creditsProcessingFeeAmount082;
	}

	/**
	 * Define el valor de la propiedad creditsProcessingFeeAmount082.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setCreditsProcessingFeeAmount082(String value) {
		this.creditsProcessingFeeAmount082 = value;
	}

	/**
	 * Obtiene el valor de la propiedad creditsTransactionFeeAmount083.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getCreditsTransactionFeeAmount083() {
		return creditsTransactionFeeAmount083;
	}

	/**
	 * Define el valor de la propiedad creditsTransactionFeeAmount083.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setCreditsTransactionFeeAmount083(String value) {
		this.creditsTransactionFeeAmount083 = value;
	}

	/**
	 * Obtiene el valor de la propiedad debitsProcessingFeeAmount084.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getDebitsProcessingFeeAmount084() {
		return debitsProcessingFeeAmount084;
	}

	/**
	 * Define el valor de la propiedad debitsProcessingFeeAmount084.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setDebitsProcessingFeeAmount084(String value) {
		this.debitsProcessingFeeAmount084 = value;
	}

	/**
	 * Obtiene el valor de la propiedad debitsTransactionFeeAmount085.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getDebitsTransactionFeeAmount085() {
		return debitsTransactionFeeAmount085;
	}

	/**
	 * Define el valor de la propiedad debitsTransactionFeeAmount085.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setDebitsTransactionFeeAmount085(String value) {
		this.debitsTransactionFeeAmount085 = value;
	}

	/**
	 * Obtiene el valor de la propiedad creditsAmount086.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getCreditsAmount086() {
		return creditsAmount086;
	}

	/**
	 * Define el valor de la propiedad creditsAmount086.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setCreditsAmount086(String value) {
		this.creditsAmount086 = value;
	}

	/**
	 * Obtiene el valor de la propiedad creditsReversalAmount087.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getCreditsReversalAmount087() {
		return creditsReversalAmount087;
	}

	/**
	 * Define el valor de la propiedad creditsReversalAmount087.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setCreditsReversalAmount087(String value) {
		this.creditsReversalAmount087 = value;
	}

	/**
	 * Obtiene el valor de la propiedad debitsAmount088.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getDebitsAmount088() {
		return debitsAmount088;
	}

	/**
	 * Define el valor de la propiedad debitsAmount088.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setDebitsAmount088(String value) {
		this.debitsAmount088 = value;
	}

	/**
	 * Obtiene el valor de la propiedad debitsReversalAmount089.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getDebitsReversalAmount089() {
		return debitsReversalAmount089;
	}

	/**
	 * Define el valor de la propiedad debitsReversalAmount089.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setDebitsReversalAmount089(String value) {
		this.debitsReversalAmount089 = value;
	}

	/**
	 * Obtiene el valor de la propiedad originalDataElements090.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getOriginalDataElements090() {
		return originalDataElements090;
	}

	/**
	 * Define el valor de la propiedad originalDataElements090.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setOriginalDataElements090(String value) {
		this.originalDataElements090 = value;
	}

	/**
	 * Obtiene el valor de la propiedad fileUpdateCode091.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getFileUpdateCode091() {
		return fileUpdateCode091;
	}

	/**
	 * Define el valor de la propiedad fileUpdateCode091.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setFileUpdateCode091(String value) {
		this.fileUpdateCode091 = value;
	}

	/**
	 * Obtiene el valor de la propiedad fileSecurityCode092.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getFileSecurityCode092() {
		return fileSecurityCode092;
	}

	/**
	 * Define el valor de la propiedad fileSecurityCode092.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setFileSecurityCode092(String value) {
		this.fileSecurityCode092 = value;
	}

	/**
	 * Obtiene el valor de la propiedad responseIndicator093.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getResponseIndicator093() {
		return responseIndicator093;
	}

	/**
	 * Define el valor de la propiedad responseIndicator093.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setResponseIndicator093(String value) {
		this.responseIndicator093 = value;
	}

	/**
	 * Obtiene el valor de la propiedad serviceIndicator094.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getServiceIndicator094() {
		return serviceIndicator094;
	}

	/**
	 * Define el valor de la propiedad serviceIndicator094.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setServiceIndicator094(String value) {
		this.serviceIndicator094 = value;
	}

	/**
	 * Obtiene el valor de la propiedad replacementAmounts095.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getReplacementAmounts095() {
		return replacementAmounts095;
	}

	/**
	 * Define el valor de la propiedad replacementAmounts095.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setReplacementAmounts095(String value) {
		this.replacementAmounts095 = value;
	}

	/**
	 * Obtiene el valor de la propiedad messageSecurityCode096.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getMessageSecurityCode096() {
		return messageSecurityCode096;
	}

	/**
	 * Define el valor de la propiedad messageSecurityCode096.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setMessageSecurityCode096(String value) {
		this.messageSecurityCode096 = value;
	}

	/**
	 * Obtiene el valor de la propiedad amountNetSettlement097.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getAmountNetSettlement097() {
		return amountNetSettlement097;
	}

	/**
	 * Define el valor de la propiedad amountNetSettlement097.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setAmountNetSettlement097(String value) {
		this.amountNetSettlement097 = value;
	}

	/**
	 * Obtiene el valor de la propiedad payee098.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getPayee098() {
		return payee098;
	}

	/**
	 * Define el valor de la propiedad payee098.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setPayee098(String value) {
		this.payee098 = value;
	}

	/**
	 * Obtiene el valor de la propiedad settlementInstitutionIdentificationCode099.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getSettlementInstitutionIdentificationCode099() {
		return settlementInstitutionIdentificationCode099;
	}

	/**
	 * Define el valor de la propiedad settlementInstitutionIdentificationCode099.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setSettlementInstitutionIdentificationCode099(String value) {
		this.settlementInstitutionIdentificationCode099 = value;
	}

	/**
	 * Obtiene el valor de la propiedad receivingInstitutionIdentificationCode100.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getReceivingInstitutionIdentificationCode100() {
		return receivingInstitutionIdentificationCode100;
	}

	/**
	 * Define el valor de la propiedad receivingInstitutionIdentificationCode100.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setReceivingInstitutionIdentificationCode100(String value) {
		this.receivingInstitutionIdentificationCode100 = value;
	}

	/**
	 * Obtiene el valor de la propiedad fileName101.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getFileName101() {
		return fileName101;
	}

	/**
	 * Define el valor de la propiedad fileName101.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setFileName101(String value) {
		this.fileName101 = value;
	}

	/**
	 * Obtiene el valor de la propiedad accountIdentification1102.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getAccountIdentification1102() {
		return accountIdentification1102;
	}

	/**
	 * Define el valor de la propiedad accountIdentification1102.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setAccountIdentification1102(String value) {
		this.accountIdentification1102 = value;
	}

	/**
	 * Obtiene el valor de la propiedad accountIdentification2103.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getAccountIdentification2103() {
		return accountIdentification2103;
	}

	/**
	 * Define el valor de la propiedad accountIdentification2103.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setAccountIdentification2103(String value) {
		this.accountIdentification2103 = value;
	}

	/**
	 * Obtiene el valor de la propiedad transactionDescription104.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getTransactionDescription104() {
		return transactionDescription104;
	}

	/**
	 * Define el valor de la propiedad transactionDescription104.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setTransactionDescription104(String value) {
		this.transactionDescription104 = value;
	}

	/**
	 * Obtiene el valor de la propiedad reservedForISOUse105.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getReservedForISOUse105() {
		return reservedForISOUse105;
	}

	/**
	 * Define el valor de la propiedad reservedForISOUse105.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setReservedForISOUse105(String value) {
		this.reservedForISOUse105 = value;
	}

	/**
	 * Obtiene el valor de la propiedad reservedForISOUse106.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getReservedForISOUse106() {
		return reservedForISOUse106;
	}

	/**
	 * Define el valor de la propiedad reservedForISOUse106.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setReservedForISOUse106(String value) {
		this.reservedForISOUse106 = value;
	}

	/**
	 * Obtiene el valor de la propiedad reservedForISOUse107.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getReservedForISOUse107() {
		return reservedForISOUse107;
	}

	/**
	 * Define el valor de la propiedad reservedForISOUse107.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setReservedForISOUse107(String value) {
		this.reservedForISOUse107 = value;
	}

	/**
	 * Obtiene el valor de la propiedad reservedForISOUse108.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getReservedForISOUse108() {
		return reservedForISOUse108;
	}

	/**
	 * Define el valor de la propiedad reservedForISOUse108.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setReservedForISOUse108(String value) {
		this.reservedForISOUse108 = value;
	}

	/**
	 * Obtiene el valor de la propiedad reservedForISOUse109.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getReservedForISOUse109() {
		return reservedForISOUse109;
	}

	/**
	 * Define el valor de la propiedad reservedForISOUse109.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setReservedForISOUse109(String value) {
		this.reservedForISOUse109 = value;
	}

	/**
	 * Obtiene el valor de la propiedad reservedForISOUse110.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getReservedForISOUse110() {
		return reservedForISOUse110;
	}

	/**
	 * Define el valor de la propiedad reservedForISOUse110.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setReservedForISOUse110(String value) {
		this.reservedForISOUse110 = value;
	}

	/**
	 * Obtiene el valor de la propiedad reservedForISOUse111.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getReservedForISOUse111() {
		return reservedForISOUse111;
	}

	/**
	 * Define el valor de la propiedad reservedForISOUse111.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setReservedForISOUse111(String value) {
		this.reservedForISOUse111 = value;
	}

	/**
	 * Obtiene el valor de la propiedad reservedForNationalUse112.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getReservedForNationalUse112() {
		return reservedForNationalUse112;
	}

	/**
	 * Define el valor de la propiedad reservedForNationalUse112.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setReservedForNationalUse112(String value) {
		this.reservedForNationalUse112 = value;
	}

	/**
	 * Obtiene el valor de la propiedad reservedForNationalUse113.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getReservedForNationalUse113() {
		return reservedForNationalUse113;
	}

	/**
	 * Define el valor de la propiedad reservedForNationalUse113.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setReservedForNationalUse113(String value) {
		this.reservedForNationalUse113 = value;
	}

	/**
	 * Obtiene el valor de la propiedad reservedForNationalUse114.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getReservedForNationalUse114() {
		return reservedForNationalUse114;
	}

	/**
	 * Define el valor de la propiedad reservedForNationalUse114.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setReservedForNationalUse114(String value) {
		this.reservedForNationalUse114 = value;
	}

	/**
	 * Obtiene el valor de la propiedad reservedForNationalUse115.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getReservedForNationalUse115() {
		return reservedForNationalUse115;
	}

	/**
	 * Define el valor de la propiedad reservedForNationalUse115.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setReservedForNationalUse115(String value) {
		this.reservedForNationalUse115 = value;
	}

	/**
	 * Obtiene el valor de la propiedad reservedForNationalUse116.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getReservedForNationalUse116() {
		return reservedForNationalUse116;
	}

	/**
	 * Define el valor de la propiedad reservedForNationalUse116.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setReservedForNationalUse116(String value) {
		this.reservedForNationalUse116 = value;
	}

	/**
	 * Obtiene el valor de la propiedad reservedForNationalUse117.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getReservedForNationalUse117() {
		return reservedForNationalUse117;
	}

	/**
	 * Define el valor de la propiedad reservedForNationalUse117.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setReservedForNationalUse117(String value) {
		this.reservedForNationalUse117 = value;
	}

	/**
	 * Obtiene el valor de la propiedad reservedForNationalUse118.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getReservedForNationalUse118() {
		return reservedForNationalUse118;
	}

	/**
	 * Define el valor de la propiedad reservedForNationalUse118.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setReservedForNationalUse118(String value) {
		this.reservedForNationalUse118 = value;
	}

	/**
	 * Obtiene el valor de la propiedad reservedForNationalUse119.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getReservedForNationalUse119() {
		return reservedForNationalUse119;
	}

	/**
	 * Define el valor de la propiedad reservedForNationalUse119.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setReservedForNationalUse119(String value) {
		this.reservedForNationalUse119 = value;
	}

	/**
	 * Obtiene el valor de la propiedad reservedForPrivateUse120.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getReservedForPrivateUse120() {
		return reservedForPrivateUse120;
	}

	/**
	 * Define el valor de la propiedad reservedForPrivateUse120.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setReservedForPrivateUse120(String value) {
		this.reservedForPrivateUse120 = value;
	}

	/**
	 * Obtiene el valor de la propiedad reservedForPrivateUse121.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getReservedForPrivateUse121() {
		return reservedForPrivateUse121;
	}

	/**
	 * Define el valor de la propiedad reservedForPrivateUse121.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setReservedForPrivateUse121(String value) {
		this.reservedForPrivateUse121 = value;
	}

	/**
	 * Obtiene el valor de la propiedad reservedForPrivateUse122.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getReservedForPrivateUse122() {
		return reservedForPrivateUse122;
	}

	/**
	 * Define el valor de la propiedad reservedForPrivateUse122.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setReservedForPrivateUse122(String value) {
		this.reservedForPrivateUse122 = value;
	}

	/**
	 * Obtiene el valor de la propiedad reservedForPrivateUse123.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getReservedForPrivateUse123() {
		return reservedForPrivateUse123;
	}

	/**
	 * Define el valor de la propiedad reservedForPrivateUse123.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setReservedForPrivateUse123(String value) {
		this.reservedForPrivateUse123 = value;
	}

	/**
	 * Obtiene el valor de la propiedad reservedForPrivateUse124.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getReservedForPrivateUse124() {
		return reservedForPrivateUse124;
	}

	/**
	 * Define el valor de la propiedad reservedForPrivateUse124.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setReservedForPrivateUse124(String value) {
		this.reservedForPrivateUse124 = value;
	}

	/**
	 * Obtiene el valor de la propiedad reservedForPrivateUse125.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getReservedForPrivateUse125() {
		return reservedForPrivateUse125;
	}

	/**
	 * Define el valor de la propiedad reservedForPrivateUse125.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setReservedForPrivateUse125(String value) {
		this.reservedForPrivateUse125 = value;
	}

	/**
	 * Obtiene el valor de la propiedad reservedForPrivateUse126.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getReservedForPrivateUse126() {
		return reservedForPrivateUse126;
	}

	/**
	 * Define el valor de la propiedad reservedForPrivateUse126.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setReservedForPrivateUse126(String value) {
		this.reservedForPrivateUse126 = value;
	}

	/**
	 * Obtiene el valor de la propiedad reservedForPrivateUse127.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getReservedForPrivateUse127() {
		return reservedForPrivateUse127;
	}

	/**
	 * Define el valor de la propiedad reservedForPrivateUse127.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setReservedForPrivateUse127(String value) {
		this.reservedForPrivateUse127 = value;
	}

	/**
	 * Obtiene el valor de la propiedad messageAuthenticationCode128.
	 * 
	 * @return possible object is {@link String }
	 * 
	 */
	public String getMessageAuthenticationCode128() {
		return messageAuthenticationCode128;
	}

	/**
	 * Define el valor de la propiedad messageAuthenticationCode128.
	 * 
	 * @param value
	 *            allowed object is {@link String }
	 * 
	 */
	public void setMessageAuthenticationCode128(String value) {
		this.messageAuthenticationCode128 = value;
	}

}
