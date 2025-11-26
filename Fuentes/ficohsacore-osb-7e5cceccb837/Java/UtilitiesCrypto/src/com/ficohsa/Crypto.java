package com.ficohsa;


import java.math.BigInteger;
import java.security.*;
import java.security.cert.Certificate;
import javax.crypto.Cipher;
import javax.xml.bind.DatatypeConverter;
import java.io.ByteArrayInputStream;
import java.io.InputStream;
import java.nio.charset.StandardCharsets;

public class Crypto {
    public static byte[] decodeBase64(String base64Param) throws Exception {
        return DatatypeConverter.parseBase64Binary(base64Param);
    }

    public static String encodeBase64(byte[] bytesParam) throws Exception {
        return DatatypeConverter.printBase64Binary(bytesParam);
    }

    private static KeyPair getKeyPair(String keyStoreBase64,
                                      String keyAlias,
                                      String keyStorePassword,
                                      String privateKeyPassword) throws Exception {

        InputStream keyStoreInputStream = new ByteArrayInputStream(decodeBase64(keyStoreBase64));
        KeyStore keyStore = KeyStore.getInstance("JKS");
        keyStore.load(keyStoreInputStream, keyStorePassword.toCharArray());

        Key privateKey = (PrivateKey)keyStore.getKey(keyAlias, privateKeyPassword.toCharArray());
        Certificate certificate = keyStore.getCertificate(keyAlias);
        PublicKey publicKey = certificate.getPublicKey();

        KeyPair keyPair = new KeyPair(publicKey, (PrivateKey) privateKey);

        return keyPair;
    }

    public static String encrypt(String keyStoreBase64,
                                 String keyAlias,
                                 String keyStorePassword,
                                 String privateKeyPassword,
                                 String decryptedValue) throws Exception {

        KeyPair keyPair = getKeyPair(keyStoreBase64, keyAlias, keyStorePassword, privateKeyPassword);

        Cipher cipher;
        cipher = Cipher.getInstance("RSA");
        cipher.init(Cipher.ENCRYPT_MODE, keyPair.getPublic());

        byte[] encryptedValue = cipher.doFinal(decryptedValue.getBytes(StandardCharsets.UTF_8));

        String encryptedBase64Value = encodeBase64(encryptedValue);

        // return new String(encryptedValue, StandardCharsets.UTF_8);
        return encryptedBase64Value;
    }

    public static String decrypt(String keyStoreBase64,
                                 String keyAlias,
                                 String keyStorePassword,
                                 String privateKeyPassword,
                                 String encryptedValue) throws Exception {

        KeyPair keyPair = getKeyPair(keyStoreBase64, keyAlias, keyStorePassword, privateKeyPassword);

        Cipher cipher;
        cipher = Cipher.getInstance("RSA");
        cipher.init(Cipher.DECRYPT_MODE, keyPair.getPrivate());

        byte[] decodedEncryptedValue = decodeBase64(encryptedValue);

        byte[] decryptedValue = cipher.doFinal(decodedEncryptedValue);

        return new String(decryptedValue, StandardCharsets.UTF_8);
    }

    public static String getHash(String input, String algorithm) throws Exception {
        MessageDigest messageDigest = MessageDigest.getInstance(algorithm);
        byte[] inputDigest = messageDigest.digest(input.getBytes());

        // Convierte el byte[] resultante en su representación signum into its signum representation.
        // Ver: https://en.wikipedia.org/wiki/Sign_function
        BigInteger inputDigestBigInteger = new BigInteger(1, inputDigest);
        String inputHash = inputDigestBigInteger.toString(16);

        while (inputHash.length() < 32) {
            inputHash = "0" + inputHash;
        }

        return inputHash;
    }
}
