/*
 * Este código utiliza la versión 0.1.0 de la implementación de Jon Chambers para el RFC4226.
 * Ver: https://github.com/jchambers/java-otp
 *
 * El uso del código mencionado, por parte del Grupo Financiero Ficohsa, no viola lo acuerdos de licencia bajo
 * los cuales fue publicado.
 *
 * Respecto al funcionamiento de HOTP, favor referirse a: https://tools.ietf.org/html/rfc4226.
 *
 */
package com.ficohsa;

import com.eatthepath.otp.*;
import java.security.NoSuchAlgorithmException;
import java.security.Key;
import java.security.InvalidKeyException;
import java.util.Random;
import javax.crypto.spec.SecretKeySpec;
import static java.lang.StrictMath.abs;

public class OneTimePasswordGeneration {
    public static String GenerateOneTimePassword(int otpSize) throws NoSuchAlgorithmException, InvalidKeyException {
        final int SEED_SIZE = 20;
        final Random randomCounter = new Random();
        final byte[] randomByteSeed = new byte[SEED_SIZE];
        new Random().nextBytes(randomByteSeed);
        final Key key = new SecretKeySpec(randomByteSeed, "RSA");
        final HmacOneTimePasswordGenerator hotp = new HmacOneTimePasswordGenerator(otpSize);

        String generatedPassword = "";

        while (generatedPassword.length() != otpSize) {
            generatedPassword = Integer.toString(hotp.generateOneTimePassword(key, abs(randomCounter.nextLong())));
        }

        return generatedPassword;
    }
}
