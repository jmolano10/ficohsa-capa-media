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
 *         &lt;element name="ISO8583_HEADER" type="{http://www.w3.org/2001/XMLSchema}string" minOccurs="0"/>
 *         &lt;element name="ISO8583_REQUEST" type="{http://co.com.cidenet/schema/FinanciamientoTC}ISO8583_TYPE"/>
 *       &lt;/sequence>
 *     &lt;/restriction>
 *   &lt;/complexContent>
 * &lt;/complexType>
 * </pre>
 * 
 * 
 */
@XmlAccessorType(XmlAccessType.FIELD)
@XmlType(name = "", propOrder = { "iso8583HEADER", "iso8583XmlContent" })
@XmlRootElement(name = "ISO8583Request")
public class ISO8583Request {

	@XmlElement(name = "ISO8583_HEADER")
	protected String iso8583HEADER;
	@XmlElement(name = "ISO8583_XML_CONTENT", required = true)
	protected ISO8583TYPE iso8583XmlContent;

	/**
	 * @return the iso8583HEADER
	 */
	public String getIso8583HEADER() {
		return iso8583HEADER;
	}

	/**
	 * @param iso8583header
	 *            the iso8583HEADER to set
	 */
	public void setIso8583HEADER(String iso8583header) {
		iso8583HEADER = iso8583header;
	}

	/**
	 * @return the iso8583XmlContent
	 */
	public ISO8583TYPE getIso8583XmlContent() {
		return iso8583XmlContent;
	}

	/**
	 * @param iso8583XmlContent
	 *            the iso8583XmlContent to set
	 */
	public void setIso8583XmlContent(ISO8583TYPE iso8583XmlContent) {
		this.iso8583XmlContent = iso8583XmlContent;
	}

}
