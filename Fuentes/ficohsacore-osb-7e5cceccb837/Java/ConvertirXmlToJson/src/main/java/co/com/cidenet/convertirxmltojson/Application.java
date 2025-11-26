package co.com.cidenet.convertirxmltojson;

import org.json.JSONObject;
import org.json.XML;

public class Application {

	/**
	 * @author aavendano@cidenet.com.co
	 * @param xmlString
	 * @param indentFactor
	 * @return
	 */
	public static String xmlToJSON(String xmlString, int indentFactor) {
		try {
			JSONObject xmlJSONObj = XML.toJSONObject(xmlString);
			String string = xmlJSONObj.toString(indentFactor);
			return string;
		} catch (Exception e) {
			return "";
		}
	}

}