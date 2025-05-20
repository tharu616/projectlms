package com.lms.studentlms.util;

import org.mindrot.jbcrypt.BCrypt;

import java.security.SecureRandom;

/**
 * Utility class for password operations including hashing, validation, and generation.
 */
public class PasswordUtils {

    private static final int BCRYPT_ROUNDS = 12;
    private static final SecureRandom RANDOM = new SecureRandom();
    private static final String CHAR_LOWER = "abcdefghijklmnopqrstuvwxyz";
    private static final String CHAR_UPPER = CHAR_LOWER.toUpperCase();
    private static final String NUMBER = "0123456789";
    private static final String SPECIAL = "!@#$%^&*()_-+=<>?";
    private static final String ALL_CHARS = CHAR_LOWER + CHAR_UPPER + NUMBER + SPECIAL;

    /**
     * Hashes a password using BCrypt.
     *
     * @param plainTextPassword The password to hash
     * @return The hashed password
     */
    public static String hashPassword(String plainTextPassword) {
        return BCrypt.hashpw(plainTextPassword, BCrypt.gensalt(BCRYPT_ROUNDS));
    }

    /**
     * Checks if a plain text password matches a hashed password.
     *
     * @param plainTextPassword The plain text password to check
     * @param hashedPassword The hashed password to check against
     * @return true if the passwords match, false otherwise
     */
    public static boolean checkPassword(String plainTextPassword, String hashedPassword) {
        return BCrypt.checkpw(plainTextPassword, hashedPassword);
    }

    /**
     * Generates a random password of the specified length.
     *
     * @param length The length of the password to generate
     * @return The generated password
     */
    public static String generateRandomPassword(int length) {
        if (length < 8) {
            length = 8; // Minimum recommended password length
        }

        StringBuilder password = new StringBuilder(length);

        // Ensure at least one of each character type
        password.append(CHAR_LOWER.charAt(RANDOM.nextInt(CHAR_LOWER.length())));
        password.append(CHAR_UPPER.charAt(RANDOM.nextInt(CHAR_UPPER.length())));
        password.append(NUMBER.charAt(RANDOM.nextInt(NUMBER.length())));
        password.append(SPECIAL.charAt(RANDOM.nextInt(SPECIAL.length())));

        // Fill the rest with random characters
        for (int i = 4; i < length; i++) {
            password.append(ALL_CHARS.charAt(RANDOM.nextInt(ALL_CHARS.length())));
        }

        // Shuffle the password
        char[] passwordArray = password.toString().toCharArray();
        for (int i = 0; i < passwordArray.length; i++) {
            int randomIndex = RANDOM.nextInt(passwordArray.length);
            char temp = passwordArray[i];
            passwordArray[i] = passwordArray[randomIndex];
            passwordArray[randomIndex] = temp;
        }

        return new String(passwordArray);
    }

    /**
     * Checks if a password meets the minimum requirements.
     *
     * @param password The password to check
     * @return true if the password meets the requirements, false otherwise
     */
    public static boolean isPasswordStrong(String password) {
        if (password == null || password.length() < 8) {
            return false;
        }

        boolean hasLower = false;
        boolean hasUpper = false;
        boolean hasDigit = false;
        boolean hasSpecial = false;

        for (char c : password.toCharArray()) {
            if (Character.isLowerCase(c)) {
                hasLower = true;
            } else if (Character.isUpperCase(c)) {
                hasUpper = true;
            } else if (Character.isDigit(c)) {
                hasDigit = true;
            } else if (!Character.isLetterOrDigit(c)) {
                hasSpecial = true;
            }
        }

        return hasLower && hasUpper && hasDigit && hasSpecial;
    }
}
