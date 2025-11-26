package co.com.cidenet.iso8583converter;

import java.io.StringReader;
import java.io.StringWriter;
import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.util.HashMap;
import java.util.Map;

import javax.xml.bind.JAXBContext;
import javax.xml.bind.Marshaller;
import javax.xml.bind.Unmarshaller;
import javax.xml.parsers.DocumentBuilder;
import javax.xml.parsers.DocumentBuilderFactory;

import org.apache.xmlbeans.XmlObject;
import org.apache.xmlbeans.XmlOptions;
import org.w3c.dom.Document;
import org.xml.sax.InputSource;

import com.solab.iso8583.IsoMessage;
import com.solab.iso8583.MessageFactory;
import com.solab.iso8583.parse.AlphaParseInfo;
import com.solab.iso8583.parse.AmountParseInfo;
import com.solab.iso8583.parse.BinaryParseInfo;
import com.solab.iso8583.parse.Date10ParseInfo;
import com.solab.iso8583.parse.FieldParseInfo;
import com.solab.iso8583.parse.LllvarParseInfo;
import com.solab.iso8583.parse.LlvarParseInfo;
import com.solab.iso8583.parse.NumericParseInfo;
import com.solab.iso8583.parse.TimeParseInfo;

import co.com.cidenet.iso8583converter.exception.CustomParserException;
import co.com.cidenet.iso8583converter.exception.InvalidValueException;
import co.com.cidenet.iso8583converter.util.ISO8583Request;
import co.com.cidenet.iso8583converter.util.ISO8583Response;
import co.com.cidenet.iso8583converter.util.ISO8583TYPE;
import co.com.cidenet.iso8583converter.util.ISO8583Utils;

public class Iso8583Converter {

	/**
	 * Tamaño del MTI
	 */
	private static final int MTI_LENGTH = 4;
	private static final String SUCCESS_RESULT_CODE = "SUCCESS";
	private static final String ERROR_RESULT_CODE = "ERROR";

	private static Map<Integer, FieldParseInfo> parserFields = new HashMap<Integer, FieldParseInfo>();

	private static MessageFactory<IsoMessage> isoMessageFactory = new MessageFactory<>();

	static {
		loadParserFieldsConfiguration();
	}

	/**
	 * Se utiliza para convertir un string en formato ISO8583 a un XML
	 * 
	 * @param dataIsoMessage
	 * @param headerLength
	 * @return
	 */
	public static final XmlObject convertIso8583ToXml(String dataIsoMessage, int headerLength) {

		ISO8583Response iso8583Response;

		try {
			iso8583Response = getISOMessagefromTrama(dataIsoMessage, headerLength);
		} catch (Exception e) {
			iso8583Response = new ISO8583Response();
			iso8583Response.setResultcode(ERROR_RESULT_CODE);
			iso8583Response.setResultmessage(e.getMessage());
		}

		return convertToXmlResponse(iso8583Response);

	}

	/**
	 * Se utiliza para convertir un objeto XML a string en formato ISO8583
	 * 
	 * @param xml
	 * @param showSizeMessage
	 * @return xmlObject
	 */
	public static final XmlObject convertXmlToIso8583(XmlObject xml, boolean showSizeMessage) {

		ISO8583Response iso8583Response = new ISO8583Response();

		try {

			ISO8583Request iso8583Request = getRequestFromXml(xml);
			ISO8583TYPE iso8583Type = iso8583Request.getIso8583XmlContent();
			String header = (iso8583Request.getIso8583HEADER() != null) ? iso8583Request.getIso8583HEADER() : "";
			String maskedMTI = maskMTI(iso8583Type.getMTI());

			isoMessageFactory.setForceSecondaryBitmap(true);
			IsoMessage isoMessage = isoMessageFactory.newMessage(Integer.decode(maskedMTI));

			isoMessage.setFields(ISO8583Utils.createMapIsoValue(iso8583Type));
			isoMessage.setIsoHeader(header);
			iso8583Response.setResultcode(SUCCESS_RESULT_CODE);

			String data = isoMessage.debugString();

			if (showSizeMessage) {
				// Get data size on 3 Decimal digits
				String sizeData = String.format("%03d",
						new Object[] { Integer.valueOf(isoMessage.debugString().length()) });
				data = sizeData + isoMessage.debugString();
			}

			iso8583Response.setIso8583StringMessage(data);

		} catch (NullPointerException e) {
			iso8583Response.setResultcode(ERROR_RESULT_CODE);
			iso8583Response.setResultmessage("Error al parsear el xml, no se envio el nodo xml: ISO8583_XML_CONTENT ");
		} catch (Exception e) {
			iso8583Response.setResultcode(ERROR_RESULT_CODE);
			iso8583Response.setResultmessage("Error interno al parsear el xml: " + e.getMessage());
		}

		// Concatenate data size to data
		return convertToXmlResponse(iso8583Response);

	}

	/**
	 * 
	 * @param iso8583Response
	 * @return xmlObject
	 */
	private static final XmlObject convertToXmlResponse(ISO8583Response iso8583Response) {

		XmlObject xml;

		try (StringWriter writer = new StringWriter()) {

			JAXBContext jaxbContext = JAXBContext.newInstance(ISO8583Response.class);
			Marshaller jaxbMarshaller = jaxbContext.createMarshaller();
			jaxbMarshaller.setProperty(Marshaller.JAXB_ENCODING, "UTF-8");
			jaxbMarshaller.setProperty(Marshaller.JAXB_FORMATTED_OUTPUT, true);

			jaxbMarshaller.marshal(iso8583Response, writer);

			String xmlMarshall = writer.toString();

			DocumentBuilderFactory factory = DocumentBuilderFactory.newInstance();
			DocumentBuilder builder;
			xml = null;

			builder = factory.newDocumentBuilder();
			Document document = builder.parse(new InputSource(new StringReader(xmlMarshall)));
			XmlOptions opts = new XmlOptions();
			opts.setSavePrettyPrint();
			opts.setSavePrettyPrintIndent(8);

			xml = XmlObject.Factory.parse(document, opts);

		} catch (Exception e) {
			throw new CustomParserException("Error interno al parsear el xml: " + e.getMessage());
		}

		return xml;

	}

	/**
	 * 
	 * @param xml
	 * @return
	 */
	private static final ISO8583Request getRequestFromXml(XmlObject xml) {

		String xmlString = xml.xmlText();
		ISO8583Request iso8583Request = null;

		try {
			JAXBContext jaxbContext = JAXBContext.newInstance(ISO8583Request.class);
			Unmarshaller jaxbUnmarshaller = jaxbContext.createUnmarshaller();

			iso8583Request = (ISO8583Request) jaxbUnmarshaller.unmarshal(new StringReader(xmlString));
		} catch (Exception e) {
			throw new CustomParserException("Error interno al parsear el xml: " + e.getMessage());
		}

		return iso8583Request;

	}

	/**
	 * 
	 * @param dataIsoMessage
	 * @param headerLength
	 * @return
	 * @throws CustomParserException
	 */
	private static final ISO8583Response getISOMessagefromTrama(String dataIsoMessage, int headerLength)
			throws CustomParserException {

		IsoMessage isoMessage;

		int startMTIPosition = headerLength;
		int endMTIPosition = startMTIPosition + MTI_LENGTH;

		String receivedMTI = dataIsoMessage.substring(startMTIPosition, endMTIPosition);
		String maskedMTI = maskMTI(receivedMTI);

		// Set response parser template
		isoMessageFactory.setParseMap(Integer.decode(maskedMTI), parserFields);

		try {
			isoMessage = isoMessageFactory.parseMessage(dataIsoMessage.getBytes(), headerLength, false);
		} catch (ParseException | UnsupportedEncodingException e) {

			throw new CustomParserException("Error al parsear el mensaje: " + e.getMessage());
		}

		ISO8583TYPE iso8583Type = ISO8583Utils.convertfromISO8583(isoMessage);
		ISO8583Response iso8583Response = new ISO8583Response();
		iso8583Response.setResultcode(SUCCESS_RESULT_CODE);
		iso8583Response.setIso8583XmlMessage(iso8583Type);

		return iso8583Response;

	}

	/**
	 * Agrega el sufijo {@code 0x} al MTI
	 * 
	 * @param MTI
	 * @return
	 * @throws InvalidValueException
	 */
	private static String maskMTI(final String MTI) throws InvalidValueException {

		String maskedMTI = null;
		try {
			maskedMTI = "0x" + Integer.parseInt(MTI);
			return maskedMTI;

		} catch (NumberFormatException e) {

			throw new InvalidValueException("El tipo de operación (MTI) no es un número.");
		}

	}

	/**
	 * Se hace el parseo de acuerdo al tipo de bit según la norma ISO8583
	 */
	private static final void loadParserFieldsConfiguration() {

		parserFields.put(2, new LlvarParseInfo());
		parserFields.put(3, new NumericParseInfo(6));
		parserFields.put(4, new AmountParseInfo());
		parserFields.put(5, new AmountParseInfo());
		parserFields.put(6, new AmountParseInfo());
		parserFields.put(7, new Date10ParseInfo());
		parserFields.put(8, new TimeParseInfo());
		parserFields.put(9, new NumericParseInfo(8));
		parserFields.put(10, new NumericParseInfo(8));
		parserFields.put(11, new NumericParseInfo(6));
		parserFields.put(12, new NumericParseInfo(6));
		parserFields.put(13, new NumericParseInfo(4));
		parserFields.put(14, new NumericParseInfo(4));
		parserFields.put(15, new NumericParseInfo(4));
		parserFields.put(16, new NumericParseInfo(4));
		parserFields.put(17, new NumericParseInfo(4));
		parserFields.put(18, new NumericParseInfo(4));
		parserFields.put(19, new NumericParseInfo(3));
		parserFields.put(20, new NumericParseInfo(3));
		parserFields.put(21, new NumericParseInfo(3));
		parserFields.put(22, new NumericParseInfo(3));
		parserFields.put(23, new NumericParseInfo(3));
		parserFields.put(24, new NumericParseInfo(3));
		parserFields.put(25, new NumericParseInfo(2));
		parserFields.put(26, new NumericParseInfo(2));
		parserFields.put(27, new NumericParseInfo(1));
		parserFields.put(28, new NumericParseInfo(8));
		parserFields.put(29, new NumericParseInfo(8));
		parserFields.put(30, new NumericParseInfo(8));
		parserFields.put(31, new NumericParseInfo(8));
		parserFields.put(32, new LlvarParseInfo());
		parserFields.put(33, new LlvarParseInfo());
		parserFields.put(34, new LlvarParseInfo());
		parserFields.put(35, new LlvarParseInfo());
		parserFields.put(36, new LllvarParseInfo());
		parserFields.put(37, new AlphaParseInfo(12));
		parserFields.put(38, new AlphaParseInfo(6));
		parserFields.put(39, new AlphaParseInfo(2));
		parserFields.put(40, new AlphaParseInfo(3));
		parserFields.put(41, new AlphaParseInfo(8));
		parserFields.put(42, new AlphaParseInfo(15));
		parserFields.put(43, new AlphaParseInfo(40));
		parserFields.put(44, new LlvarParseInfo());
		parserFields.put(45, new LlvarParseInfo());
		parserFields.put(46, new LllvarParseInfo());
		parserFields.put(47, new LllvarParseInfo());
		parserFields.put(48, new LllvarParseInfo());
		parserFields.put(49, new AlphaParseInfo(3));
		parserFields.put(50, new AlphaParseInfo(3));
		parserFields.put(51, new AlphaParseInfo(3));
		parserFields.put(52, new BinaryParseInfo(8));
		parserFields.put(53, new NumericParseInfo(18));
		parserFields.put(54, new LllvarParseInfo());
		parserFields.put(55, new LllvarParseInfo());
		parserFields.put(56, new LllvarParseInfo());
		parserFields.put(57, new LllvarParseInfo());
		parserFields.put(58, new LllvarParseInfo());
		parserFields.put(59, new LllvarParseInfo());
		parserFields.put(60, new LllvarParseInfo());
		parserFields.put(61, new LllvarParseInfo());
		parserFields.put(62, new LllvarParseInfo());
		parserFields.put(63, new LllvarParseInfo());
		parserFields.put(64, new BinaryParseInfo(16));
		parserFields.put(65, new BinaryParseInfo(16));
		parserFields.put(66, new NumericParseInfo(1));
		parserFields.put(67, new NumericParseInfo(2));
		parserFields.put(68, new NumericParseInfo(3));
		parserFields.put(69, new NumericParseInfo(3));
		parserFields.put(70, new NumericParseInfo(3));
		parserFields.put(71, new NumericParseInfo(4));
		parserFields.put(72, new LllvarParseInfo());
		parserFields.put(73, new NumericParseInfo(6));
		parserFields.put(74, new NumericParseInfo(10));
		parserFields.put(75, new NumericParseInfo(10));
		parserFields.put(76, new NumericParseInfo(10));
		parserFields.put(77, new NumericParseInfo(10));
		parserFields.put(78, new NumericParseInfo(10));
		parserFields.put(79, new NumericParseInfo(10));
		parserFields.put(80, new NumericParseInfo(10));
		parserFields.put(81, new NumericParseInfo(10));
		parserFields.put(82, new NumericParseInfo(12));
		parserFields.put(83, new NumericParseInfo(12));
		parserFields.put(84, new NumericParseInfo(12));
		parserFields.put(85, new NumericParseInfo(12));
		parserFields.put(86, new NumericParseInfo(15));
		parserFields.put(87, new NumericParseInfo(15));
		parserFields.put(88, new NumericParseInfo(15));
		parserFields.put(89, new NumericParseInfo(15));
		parserFields.put(90, new NumericParseInfo(42));
		parserFields.put(91, new AlphaParseInfo(1));
		parserFields.put(92, new NumericParseInfo(2));
		parserFields.put(93, new NumericParseInfo(5));
		parserFields.put(94, new AlphaParseInfo(7));
		parserFields.put(95, new AlphaParseInfo(42));
		parserFields.put(96, new AlphaParseInfo(8));
		parserFields.put(97, new NumericParseInfo(16));
		parserFields.put(98, new AlphaParseInfo(25));
		parserFields.put(99, new LlvarParseInfo());
		parserFields.put(100, new LlvarParseInfo());
		parserFields.put(101, new AlphaParseInfo(17));
		parserFields.put(102, new LlvarParseInfo());
		parserFields.put(103, new LlvarParseInfo());
		parserFields.put(104, new LllvarParseInfo());
		parserFields.put(105, new LllvarParseInfo());
		parserFields.put(106, new LllvarParseInfo());
		parserFields.put(107, new LllvarParseInfo());
		parserFields.put(108, new LllvarParseInfo());
		parserFields.put(109, new LllvarParseInfo());
		parserFields.put(110, new LllvarParseInfo());
		parserFields.put(111, new LllvarParseInfo());
		parserFields.put(112, new LllvarParseInfo());
		parserFields.put(113, new LlvarParseInfo());
		parserFields.put(114, new LllvarParseInfo());
		parserFields.put(115, new LllvarParseInfo());
		parserFields.put(116, new LllvarParseInfo());
		parserFields.put(117, new LllvarParseInfo());
		parserFields.put(118, new LllvarParseInfo());
		parserFields.put(119, new LllvarParseInfo());
		parserFields.put(120, new LllvarParseInfo());
		parserFields.put(121, new LllvarParseInfo());
		parserFields.put(122, new LllvarParseInfo());
		parserFields.put(123, new LllvarParseInfo());
		parserFields.put(124, new LllvarParseInfo());
		parserFields.put(125, new LlvarParseInfo());
		parserFields.put(126, new LlvarParseInfo());
		parserFields.put(127, new LllvarParseInfo());
		parserFields.put(128, new BinaryParseInfo(16));
	}

}
