package com.moffatbay.util;

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
}