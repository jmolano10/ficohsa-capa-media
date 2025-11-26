package co.com.cidenet.iso8583converter.exception;

/**
 * Lanzada para indicar que se obtuvo un valor inválido
 * 
 * @author jzambrano@cidenet.com.co
 *
 */
public class InvalidValueException extends NumberFormatException {

  private static final long serialVersionUID = 5012792055750559020L;
  
  /**
   * Indica cuando se obtine un valor inválido
   * @param message
   */
  public InvalidValueException(String message) {
		super(message);
	}
}
