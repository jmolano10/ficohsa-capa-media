package co.com.cidenet.calcularcuota;



import org.apache.xmlbeans.XmlObject;

import co.com.cidenet.model.Cuota;

public class Application {

	static XmlObject newObject;
	
	/**
	 * @author aavendano@cidnet.com.co
	 * Metodo que se encarga de calcular la cuota mensual y las tasas dependiendo de los datos ingresados
	 * @param plazo
	 * @param monto
	 * @param tasaAnual
	 * @param tasaSeguro
	 * @param tasaDesembolso
         * @param banderaSumaSeguro
	 * @return
	 */
	public static XmlObject calcularCuotaFinanciamientoTC(int plazo, double monto, double tasaAnual, double tasaSeguro,
			double tasaDesembolso, String banderaSumaSeguro) {

		try {
			
			Cuota cuotacalculada = new Cuota(plazo, monto, tasaAnual, tasaSeguro, tasaDesembolso,banderaSumaSeguro);			
			
			/**
			 * Se dispara una excepcion dependiendo de los valores retornados por el constructor de la clase
			 */
			String value = String.valueOf(cuotacalculada.getCuotaMensual()).toUpperCase();
			if("INFINITY".equals(value) || "NAN".equals(value)) {
				 throw new RuntimeException("Error en los datos ingresados");
			}			
			
			/**
			 * Se arma el xml de salida en formato String
			 */
			String xmlString = String.format(
				"<CuotaCalculada>\n" + 
						"<CodigoMensaje>" + "SUCCESS" +"</CodigoMensaje>\n" + 
						"<CuotaMensual>" + cuotacalculada.getCuotaMensual() +"</CuotaMensual>\n" + 
						"<ValorSeguro>" + cuotacalculada.getValorSeguro() +"</ValorSeguro>\n" + 
						"<ValorDesembolso>" + cuotacalculada.getValorDesembolso() +"</ValorDesembolso>\n" + 
						"<TasaAnual>" + cuotacalculada.getTasaAnual() +"</TasaAnual>\n" + 
						"<TasaMensual>" + cuotacalculada.getTasaMensual() +"</TasaMensual>\n" + 
					"</CuotaCalculada>\n");
		
			XmlObject object = XmlObject.Factory.parse(xmlString);

			return object;
		} catch (Exception e) {
			
			String xmlString = String.format(
				"<CuotaCalculada>\n" + 
					"<CodigoMensaje>" + "ERROR" +"</CodigoMensaje>\n" + 
					"<DescripcionMensaje>" + e.getMessage() +"</DescripcionMensaje>\n" + 
				"</CuotaCalculada>\n");

				try {
					
					XmlObject object = XmlObject.Factory.parse(xmlString);					
					return object;
					
				} catch(Exception ex) {
					return null;
				}				
		}

	}
	
	


}