package co.com.cidenet.iso8583converter.exception;

/**
 * Lanzada para indicar que ocurrió un error al intentar procesar el mensaje de
 * repuesta
 * 
 * @author cmontoya@cidenet.com.co
 *
 */
public class CustomParserException extends RuntimeException {

	/**
	* 
	*/
	private static final long serialVersionUID = 4583749647466728564L;

	public CustomParserException(String message) {
		super(message);
	}

}
