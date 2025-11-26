package test;

import java.io.StringReader;

import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.apache.xmlbeans.XmlObject;
import org.apache.xmlbeans.XmlOptions;
import org.w3c.dom.Document;
import org.xml.sax.InputSource;

import co.com.cidenet.iso8583converter.Iso8583Converter;

public class Test {

	/**
	 * 
	 */
	public static void convertIso8583ToXml() {

		// String trama =
		// "ISO0253000450200F23880010E9180180000000016000000164220106000485137010022000000012000010510161600173110161601050105062590000000000017310000003000000339
		// 254000000000000000000000000047044003 840020 050000P006746009
		// 06259000280000000000 28 ";

		// String trama =
		// "ISO0253000450200F67E8581AAE0A0000000000016000000164214980013821258891006000000500000000000500000022016072600000000118713160726022017120000022102110402048000048000374214980013821258=171210113148475000008051161187130000000118
		// FICORED ZOLI AMERICA #5 HND HN3403400480002803921950833 8000 2899459208 8000
		// 0 ";

		// String trama =
		// "ISO0253000450210F04008200080000200010008100000021210123456789012345600000080000012345678123000000000000000000230200000000000111111111100000000111234532300000000000123456789000000000120430400000000000000000111111111555555555588888";

		// String trama =
		// "ISO0253000400200B02000018081800000000000060000001520000000000001001234561110000000000110000000000110000000
		// 0083174546412313ficohsaatm001049999";

//		String trama = "0200F67E8581AAE1A0000000000016000000164214980018352408011000000016000000000016000000031515215300000000115614152153031520120000031602110402048000048000374214980018352408=201210115115010000008074151156140000000115        FICORED        LEAR - PLANTA LEMPIRA    HND          HN01233333333333434034004800028200003330833  8000          28                            ";
		String trama = "0210F23E44812AE1900000000000000000801620000100000000001510000000000500000925160452141665120507092520120000601102102048000282000010000000000=201222222228268121416652900000141FICORED        CAJERO DIEBOLD PRUEBAS DEHND          HN0128000000001043400000000000000000000";

		XmlObject xml = Iso8583Converter.convertIso8583ToXml(trama, 0);

		System.out.println(xml.xmlText());

	}

	public static void convertXmlToIso8583() {

		// String xmlString
		// ="<iso8583TYPE><MTI>0210</MTI><PrimaryAccountNumber_002>4220106000485137</PrimaryAccountNumber_002><ProcessingCode_003>010022</ProcessingCode_003><AmountTransaction_004>000000000120</AmountTransaction_004><TransmissionDateTime_007>0105101616</TransmissionDateTime_007><SystemTraceAuditNumber_011>001731</SystemTraceAuditNumber_011><TimeLocalTransaction_012>101616</TimeLocalTransaction_012><DateLocalTransaction_013>0105</DateLocalTransaction_013><DateCapture_017>0105</DateCapture_017><AcquiringInstitutionIdentificationCode_032>259000</AcquiringInstitutionIdentificationCode_032><RetrievalReferenceNumber_037>000000001731</RetrievalReferenceNumber_037><AuthorizationIdentificationResponse_038>000000</AuthorizationIdentificationResponse_038><ResponseCode_039>30</ResponseCode_039><CardAcceptorTerminalIdentification_041>00000339</CardAcceptorTerminalIdentification_041><AdditionalResponseData_044>4000000000000000000000000</AdditionalResponseData_044><AdditionalDataPrivate_048>044003</AdditionalDataPrivate_048><CurrencyCodeTransaction_049>840</CurrencyCodeTransaction_049><ReservedNational_060></ReservedNational_060><ReservedPrivate_061>000P006746009</ReservedPrivate_061><ReceivingInstitutionIdentificationCode_100>259000</ReceivingInstitutionIdentificationCode_100><AccountIdentification1_102>0000000000</AccountIdentification1_102><AccountIdentification2_103>
		// </AccountIdentification2_103></iso8583TYPE>";

		// String xmlString =
		// "<ISO8583Request><ISO8583_HEADER>ISO025300045</ISO8583_HEADER><ISO8583_XML_CONTENT><MTI>0210</MTI><PrimaryAccountNumber_002>4214980013821258</PrimaryAccountNumber_002><ProcessingCode_003>891006</ProcessingCode_003><AmountTransaction_004>000000005000</AmountTransaction_004><AmountCardholderBilling_006>000000005000</AmountCardholderBilling_006><TransmissionDateTime_007>0220160726</TransmissionDateTime_007><ConversionRateCardholderBilling_010>00000000</ConversionRateCardholderBilling_010><SystemTraceAuditNumber_011>118713</SystemTraceAuditNumber_011><TimeLocalTransaction_012>160726</TimeLocalTransaction_012><DateLocalTransaction_013>0220</DateLocalTransaction_013><DateExpiration_014>1712</DateExpiration_014><DateSettlement_015>0000</DateSettlement_015><DateCapture_017>0221</DateCapture_017><PointOfServiceEntryMode_022>021</PointOfServiceEntryMode_022><FunctionCode_024>104</FunctionCode_024><PointOfServiceConditionCode_025>02</PointOfServiceConditionCode_025><AcquiringInstitutionIdentificationCode_032>8000</AcquiringInstitutionIdentificationCode_032><ForwardingInstitutionIdentificationCode_033>8000</ForwardingInstitutionIdentificationCode_033><Track2Data_035>4214980013821258=17121011314847500000</Track2Data_035><RetrievalReferenceNumber_037>805116118713</RetrievalReferenceNumber_037><ResponseCode_039>00</ResponseCode_039><CardAcceptorTerminalIdentification_041>00000118</CardAcceptorTerminalIdentification_041><CardAcceptorIdentificationCode_042>FICORED
		// </CardAcceptorIdentificationCode_042><CardAcceptorNameLocation_043>ZOLI
		// AMERICA #5 HND
		// HN</CardAcceptorNameLocation_043><CurrencyCodeTransaction_049>340</CurrencyCodeTransaction_049><CurrencyCodeCardholderBilling_051>340</CurrencyCodeCardholderBilling_051><ReceivingInstitutionIdentificationCode_100>8000</ReceivingInstitutionIdentificationCode_100>
		// <AccountIdentification1_102>03921950833 8000 </AccountIdentification1_102>
		// <AccountIdentification2_103>99459208 8000 0
		// </AccountIdentification2_103></ISO8583_XML_CONTENT></ISO8583Request>";

		// String xmlString =
		// "<ISO8583Request><ISO8583_HEADER>ISO025300045</ISO8583_HEADER><ISO8583_XML_CONTENT><MTI>0210</MTI><PrimaryAccountNumber_002>101234567890</PrimaryAccountNumber_002><ProcessingCode_003>123456</ProcessingCode_003><AmountTransaction_004>000000008000</AmountTransaction_004><ConversionRateCardholderBilling_010>12345678</ConversionRateCardholderBilling_010><ForwardingInstitutionCountryCode_021>123</ForwardingInstitutionCountryCode_021><AuthorizingIdentificationResponseLength_027>0</AuthorizingIdentificationResponseLength_027><CardAcceptorTerminalIdentification_041>0000000000000000</CardAcceptorTerminalIdentification_041><ReservedPrivate_063>02000000000001111111111</ReservedPrivate_063><InquiriesNumber_080>0000000011</InquiriesNumber_080><ResponseIndicator_093>12345</ResponseIndicator_093><ReceivingInstitutionIdentificationCode_100>30000000000012345678900000000012</ReceivingInstitutionIdentificationCode_100><ReservedForPrivateUse_127>0400000000000000000111111111555555555588888</ReservedForPrivateUse_127></ISO8583_XML_CONTENT>
		// </ISO8583Request>";

		// String xmlString = "<ISO8583Request>
		// <ISO8583_HEADER>ISO025300040</ISO8583_HEADER> <ISO8583_XML_CONTENT>
		// <MTI>0200</MTI>
		// <PrimaryAccountNumber_002>4009506000003250</PrimaryAccountNumber_002>
		// <ProcessingCode_003>010021</ProcessingCode_003>
		// <AmountTransaction_004>50</AmountTransaction_004>
		// <TransmissionDateTime_007>0312012915</TransmissionDateTime_007>
		// <SystemTraceAuditNumber_011>000254</SystemTraceAuditNumber_011>
		// <TimeLocalTransaction_012>012915</TimeLocalTransaction_012>
		// <DateLocalTransaction_013>0312</DateLocalTransaction_013>
		// <DateExpiration_014>1909</DateExpiration_014>
		// <DateCapture_017>0312</DateCapture_017>
		// <PointOfServiceEntryMode_022>010</PointOfServiceEntryMode_022>
		// <PointOfServiceConditionCode_025>00</PointOfServiceConditionCode_025>
		// <AcquiringInstitutionIdentificationCode_032>259000</AcquiringInstitutionIdentificationCode_032>
		// <RetrievalReferenceNumber_037>000254</RetrievalReferenceNumber_037>
		// <CardAcceptorTerminalIdentification_041>01240000</CardAcceptorTerminalIdentification_041>
		// <CardAcceptorIdentificationCode_042>CAJAFICO</CardAcceptorIdentificationCode_042>
		// <CardAcceptorNameLocation_043>FICOHSA TEGUCIGALPA
		// HN</CardAcceptorNameLocation_043>
		// <AdditionalDataPrivate_048>021002055*****F20180315M</AdditionalDataPrivate_048>
		// <CurrencyCodeTransaction_049>840</CurrencyCodeTransaction_049>
		// <ReservedISO_055>999</ReservedISO_055>
		// <ReservedNational_060>0730FICO0000</ReservedNational_060>
		// <ReservedPrivate_061>0000PRO50000P</ReservedPrivate_061>
		// <ReservedPrivate_062>746009</ReservedPrivate_062>
		// <ReceivingInstitutionIdentificationCode_100>259000</ReceivingInstitutionIdentificationCode_100>
		// <ReservedForPrivateUse_120>TEGUCIGALPA </ReservedForPrivateUse_120>
		// </ISO8583_XML_CONTENT> </ISO8583Request>";

		// Billtera : String xmlString =
		// "<ISO8583Request><ISO8583_HEADER></ISO8583_HEADER><ISO8583_XML_CONTENT><MTI>0210</MTI><ProcessingCode_003>151000</ProcessingCode_003><AmountTransaction_004>000000000002</AmountTransaction_004><SystemTraceAuditNumber_011>123456</SystemTraceAuditNumber_011><AcquiringInstitutionIdentificationCode_032>10000000000</AcquiringInstitutionIdentificationCode_032><ForwardingInstitutionIdentificationCode_033>00000000002</ForwardingInstitutionIdentificationCode_033><CardAcceptorTerminalIdentification_041>10000000</CardAcceptorTerminalIdentification_041><AdditionalDataPrivate_048>333333333334</AdditionalDataPrivate_048><CurrencyCodeTransaction_049>840</CurrencyCodeTransaction_049></ISO8583_XML_CONTENT></ISO8583Request>";

		// Cupon: String xmlString =
		// "<ISO8583Request><ISO8583_HEADER>ISO025300040</ISO8583_HEADER><ISO8583_XML_CONTENT><MTI>0210</MTI><ProcessingCode_003>152000</ProcessingCode_003><AmountTransaction_004>1</AmountTransaction_004><SystemTraceAuditNumber_011>123456</SystemTraceAuditNumber_011><AcquiringInstitutionIdentificationCode_032>10000000000</AcquiringInstitutionIdentificationCode_032><ForwardingInstitutionIdentificationCode_033>00000000001</ForwardingInstitutionIdentificationCode_033><CardAcceptorTerminalIdentification_041>10000000</CardAcceptorTerminalIdentification_041><AdditionalDataPrivate_048>31745464</AdditionalDataPrivate_048><CurrencyCodeTransaction_049>840</CurrencyCodeTransaction_049><AccountIdentification1_102>ficohsaatm001</AccountIdentification1_102><AccountIdentification2_103>9999</AccountIdentification2_103></ISO8583_XML_CONTENT></ISO8583Request>";

		String xmlString = "<ISO8583Request><ISO8583_HEADER></ISO8583_HEADER><ISO8583_XML_CONTENT><MTI>0210</MTI>        <PrimaryAccountNumber_002>2000010000000000</PrimaryAccountNumber_002>        <ProcessingCode_003>151000</ProcessingCode_003>        <AmountTransaction_004>000000050000</AmountTransaction_004>        <TransmissionDateTime_007>0925154012</TransmissionDateTime_007>        <SystemTraceAuditNumber_011>141665</SystemTraceAuditNumber_011>        <TimeLocalTransaction_012>120507</TimeLocalTransaction_012>        <DateLocalTransaction_013>0925</DateLocalTransaction_013>        <DateExpiration_014>2012</DateExpiration_014>        <DateSettlement_015>0000</DateSettlement_015>        <MerchantType_018>6011</MerchantType_018>        <PointOfServiceEntryMode_022>021</PointOfServiceEntryMode_022>        <PointOfServiceConditionCode_025>02</PointOfServiceConditionCode_025>        <AcquiringInstitutionIdentificationCode_032>8000</AcquiringInstitutionIdentificationCode_032>        <Track2Data_035>2000010000000000=20122222222</Track2Data_035>        <RetrievalReferenceNumber_037>826812141665</RetrievalReferenceNumber_037>        <ResponseCode_039>29</ResponseCode_039>        <CardAcceptorTerminalIdentification_041>00000141</CardAcceptorTerminalIdentification_041>        <CardAcceptorIdentificationCode_042>FICORED        </CardAcceptorIdentificationCode_042>        <CardAcceptorNameLocation_043>CAJERO DIEBOLD PRUEBAS DEHND          HN</CardAcceptorNameLocation_043>        <AdditionalDataPrivate_048>800000000104</AdditionalDataPrivate_048>        <CurrencyCodeTransaction_049>340</CurrencyCodeTransaction_049>        <PersonalIdentificationNumberData_052>0000000000000000</PersonalIdentificationNumberData_052><ReservedForPrivateUse_121/></ISO8583_XML_CONTENT></ISO8583Request>";

		DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
		DocumentBuilder builder;
		XmlObject xml = null;
		try {
			builder = factory.newDocumentBuilder();
			Document document = builder.parse(new InputSource(new StringReader(xmlString)));
			XmlOptions opts = new XmlOptions();
			opts.setSavePrettyPrint();
			opts.setSavePrettyPrintIndent(8);

			xml = XmlObject.Factory.parse(document, opts);

		} catch (Exception e) {
			e.printStackTrace();
		}

		XmlObject xmlResponse = Iso8583Converter.convertXmlToIso8583(xml, false);

		System.out.println(xmlResponse.xmlText());
	}

	public static void main(String[] args) throws Exception {

		convertIso8583ToXml();

		/*
		 * Cuando se transforma de xml a trama en los campos AMOUNT esta multiplicando
		 * por 100, ya que no pueden haber decimales en la trama Cuando se transforma de
		 * trama a xml se deberia dividir por 100 ya que ese valor tiene decimales, pero
		 * la libreria no lo está dividiendo.
		 */
//		 convertXmlToIso8583();

	}

}
