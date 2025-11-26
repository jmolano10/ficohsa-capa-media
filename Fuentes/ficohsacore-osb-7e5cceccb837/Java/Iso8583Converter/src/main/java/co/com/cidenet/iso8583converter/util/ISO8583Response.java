//
// Este archivo ha sido generado por la arquitectura JavaTM para la implantación de la referencia de enlace (JAXB) XML v2.2.7 
// Visite <a href="http://java.sun.com/xml/jaxb">http://java.sun.com/xml/jaxb</a> 
// Todas las modificaciones realizadas en este archivo se perderán si se vuelve a compilar el esquema de origen. 
// Generado el: 2018.03.07 a las 10:36:04 AM COT 
//

package co.com.cidenet.iso8583converter.util;

import javax.xml.bind.annotation.XmlAccessType;
import javax.xml.bind.annotation.XmlAccessorType;
import javax.xml.bind.annotation.XmlElement;
import javax.xml.bind.annotation.XmlRootElement;
import javax.xml.bind.annotation.XmlType;

/**
 * <p>
 * Clase Java para anonymous complex type.
 * 
 * <p>
 * El siguiente fragmento de esquema especifica el contenido que se espera que
 * haya en esta clase.
 * 
 * <pre>
 * &lt;complexType>
 *   &lt;complexContent>
 *     &lt;restriction base="{http://www.w3.org/2001/XMLSchema}anyType">
 *       &lt;sequence>
 *         &lt;element name="RESULT_CODE" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="RESULT_MESSAGE" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="ISO8583_RESPONSE" type="{http://co.com.cidenet/schema/FinanciamientoTC}ISO8583_TYPE" minOccurs="0"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "", propOrder = { "resultcode", "resultmessage", "iso8583StringMessage", "iso8583XmlMessage" })
@XmlRootElement(name = "ISO8583Response")
public class ISO8583Response {

	@XmlElement(name = "RESULT_CODE")
	protected String resultcode;
	@XmlElement(name = "RESULT_MESSAGE")
	protected String resultmessage;
	@XmlElement(name = "ISO8583_STRING_MESSAGE")
	protected String iso8583StringMessage;
	@XmlElement(name = "ISO8583_XML_MESSAGE")
	protected ISO8583TYPE iso8583XmlMessage;

	/**
	 * @return the resultcode
	 */
	public String getResultcode() {
		return resultcode;
	}

	/**
	 * @param resultcode
	 *            the resultcode to set
	 */
	public void setResultcode(String resultcode) {
		this.resultcode = resultcode;
	}

	/**
	 * @return the resultmessage
	 */
	public String getResultmessage() {
		return resultmessage;
	}

	/**
	 * @param resultmessage
	 *            the resultmessage to set
	 */
	public void setResultmessage(String resultmessage) {
		this.resultmessage = resultmessage;
	}

	/**
	 * @return the iso8583StringMessage
	 */
	public String getIso8583StringMessage() {
		return iso8583StringMessage;
	}

	/**
	 * @param iso8583StringMessage
	 *            the iso8583StringMessage to set
	 */
	public void setIso8583StringMessage(String iso8583StringMessage) {
		this.iso8583StringMessage = iso8583StringMessage;
	}

	/**
	 * @return the iso8583XmlMessage
	 */
	public ISO8583TYPE getIso8583XmlMessage() {
		return iso8583XmlMessage;
	}

	/**
	 * @param iso8583XmlMessage
	 *            the iso8583XmlMessage to set
	 */
	public void setIso8583XmlMessage(ISO8583TYPE iso8583XmlMessage) {
		this.iso8583XmlMessage = iso8583XmlMessage;
	}

}
