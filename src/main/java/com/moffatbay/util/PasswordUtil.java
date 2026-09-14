package com.moffatbay.util;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.security.spec.InvalidKeySpecException;
import java.util.Base64;

import javax.crypto.SecretKeyFactory;
import javax.crypto.spec.PBEKeySpec;

public class PasswordUtil {

    private static final int ITERATIONS = 65536;
    private static final int KEY_LENGTH = 256;

    private PasswordUtil() {
    }

    public static String hashPassword(String password) {

        try {

            byte[] salt = new byte[16];

            SecureRandom random = new SecureRandom();
            random.nextBytes(salt);

            PBEKeySpec spec = new PBEKeySpec(
                    password.toCharArray(),
                    salt,
                    ITERATIONS,
                    KEY_LENGTH
            );

            SecretKeyFactory factory =
                    SecretKeyFactory.getInstance(
                            "PBKDF2WithHmacSHA256"
                    );

            byte[] hash =
                    factory.generateSecret(spec).getEncoded();

            spec.clearPassword();

            String encodedSalt =
                    Base64.getEncoder().encodeToString(salt);

            String encodedHash =
                    Base64.getEncoder().encodeToString(hash);

            return ITERATIONS
                    + ":"
                    + encodedSalt
                    + ":"
                    + encodedHash;

        } catch (
                NoSuchAlgorithmException
                | InvalidKeySpecException e) {

            throw new RuntimeException(
                    "Unable to hash password.",
                    e
            );
        }
    }

    public static boolean verifyPassword(
            String password,
            String storedPasswordHash) {

        if (password == null
                || storedPasswordHash == null
                || storedPasswordHash.isBlank()) {

            return false;
        }

        try {

            String[] parts =
                    storedPasswordHash.split(":", 3);

            if (parts.length != 3) {
                return false;
            }

            int iterations =
                    Integer.parseInt(parts[0]);

            byte[] salt =
                    Base64.getDecoder().decode(parts[1]);

            byte[] expectedHash =
                    Base64.getDecoder().decode(parts[2]);

            PBEKeySpec spec = new PBEKeySpec(
                    password.toCharArray(),
                    salt,
                    iterations,
                    expectedHash.length * 8
            );

            SecretKeyFactory factory =
                    SecretKeyFactory.getInstance(
                            "PBKDF2WithHmacSHA256"
                    );

            byte[] actualHash =
                    factory.generateSecret(spec).getEncoded();

            spec.clearPassword();

            return MessageDigest.isEqual(
                    expectedHash,
                    actualHash
            );

        } catch (
                IllegalArgumentException
                | NoSuchAlgorithmException
                | InvalidKeySpecException e) {

            return false;
        }
    }
}