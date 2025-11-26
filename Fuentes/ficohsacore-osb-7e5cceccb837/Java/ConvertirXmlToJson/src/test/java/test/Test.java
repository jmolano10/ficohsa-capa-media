package test;

import org.json.JSONException;

import co.com.cidenet.convertirxmltojson.Application;

public class Test {

	public static void main(String[] args) {
		
		Application ap = new Application();
		
		String xmlEntrada = "<CONTENIDO xmlns:soapenv=\"http://schemas.xmlsoap.org/soap/envelope/\" xmlns:reg=\"http://www.ficohsa.com.hn/middleware.services/registrarBitacoraFinanciamientoTCTypes\" xmlns:sol=\"http://www.ficohsa.com.hn/middleware.services/SolicitudFinanciamientoTCTypes\" xmlns:aut=\"http://www.ficohsa.com.hn/middleware.services/autType\"><soapenv:Body><sol:calculaFinanciamientoTCResponse><EXACT_MATCH>YES</EXACT_MATCH><TOTAL_AMOUNT>10.5</TOTAL_AMOUNT><MONTHLY_PAYMENT>1.3053180201307006</MONTHLY_PAYMENT><NUMBER_OF_PAYMENTS>10</NUMBER_OF_PAYMENTS><YEARLY_INT_RATE>0.5</YEARLY_INT_RATE><MONTHLY_INT_RATE>0.041666666666666664</MONTHLY_INT_RATE><CHARGES><CHARGE><NAME>DISBURSEMENT</NAME><VALUE>1.05</VALUE></CHARGE><CHARGE><NAME>INSURANCE</NAME><VALUE>1.05</VALUE></CHARGE></CHARGES></sol:calculaFinanciamientoTCResponse></soapenv:Body></CONTENIDO>";

		System.out.println(ap.xmlToJSON(xmlEntrada, 4));	        	
	}

}
