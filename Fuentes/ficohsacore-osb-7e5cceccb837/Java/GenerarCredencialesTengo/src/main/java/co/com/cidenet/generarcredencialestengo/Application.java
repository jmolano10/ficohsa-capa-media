package co.com.cidenet.generarcredencialestengo;

/**
 * 
 * @author aavendano@cidenet.com.co
 *
 */
public class Application {

	/**
	 * Retorna un hash SHA1 a partir de un texto
	 * 
	 * @param txt
	 * @param hashType
	 * @return sessionId en string
	 */
	public static String getHash(String txt, String hashType) {
		try {

			java.security.MessageDigest md = java.security.MessageDigest.getInstance(hashType);
			byte[] array = md.digest(txt.getBytes());
			StringBuffer sb = new StringBuffer();

			for (int i = 0; i < array.length; ++i) {
				sb.append(Integer.toHexString((array[i] & 0xFF) | 0x100).substring(1, 3));
			}

			return sb.toString();
		} catch (java.security.NoSuchAlgorithmException e) {
			return "";
		}
	}

	/**
	 * Retorna pin tipo string para realizar login en los servicios de TENGO
	 * 
	 * @param usuario
	 * @param contrasena
	 * @param sessionId
	 * @return pin
	 */
	public static String sha1(String usuario, String contrasena, String sessionId) {
		String hash = Application.getHash(usuario.toLowerCase() + contrasena, "SHA1").toLowerCase();
		return Application.getHash((sessionId + hash), "SHA1").toUpperCase();
	}

}