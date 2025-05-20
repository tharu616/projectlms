package com.lms.studentlms.util;

import java.util.regex.Pattern;

/**
 * Utility class for input validation throughout the application.
 */
public class ValidationUtils {

    // Regular expressions for validation
    private static final Pattern EMAIL_PATTERN =
            Pattern.compile("^[A-Za-z0-9+_.-]+@[A-Za-z0-9.-]+$");

    private static final Pattern PHONE_PATTERN =
            Pattern.compile("^\\+?[0-9]{10,15}$");

    private static final Pattern NIC_PATTERN =
            Pattern.compile("^[0-9]{9}[vVxX]$|^[0-9]{12}$");

    private static final Pattern NAME_PATTERN =
            Pattern.compile("^[A-Za-z\\s.'-]+$");

    private static final Pattern POSTAL_CODE_PATTERN =
            Pattern.compile("^[0-9]{5}$");

    /**
     * Validates an email address.
     *
     * @param email The email address to validate
     * @return true if the email is valid, false otherwise
     */
    public static boolean isValidEmail(String email) {
        if (email == null || email.trim().isEmpty()) {
            return false;
        }
        return EMAIL_PATTERN.matcher(email).matches();
    }

    /**
     * Validates a phone number.
     *
     * @param phone The phone number to validate
     * @return true if the phone number is valid, false otherwise
     */
    public static boolean isValidPhone(String phone) {
        if (phone == null || phone.trim().isEmpty()) {
            return false;
        }
        return PHONE_PATTERN.matcher(phone).matches();
    }

    /**
     * Validates a National Identity Card (NIC) number.
     *
     * @param nic The NIC number to validate
     * @return true if the NIC is valid, false otherwise
     */
    public static boolean isValidNIC(String nic) {
        if (nic == null || nic.trim().isEmpty()) {
            return false;
        }
        return NIC_PATTERN.matcher(nic).matches();
    }

    /**
     * Validates a name (allows letters, spaces, and some special characters).
     *
     * @param name The name to validate
     * @return true if the name is valid, false otherwise
     */
    public static boolean isValidName(String name) {
        if (name == null || name.trim().isEmpty()) {
            return false;
        }
        return NAME_PATTERN.matcher(name).matches();
    }

    /**
     * Validates a postal code.
     *
     * @param postalCode The postal code to validate
     * @return true if the postal code is valid, false otherwise
     */
    public static boolean isValidPostalCode(String postalCode) {
        if (postalCode == null || postalCode.trim().isEmpty()) {
            return false;
        }
        return POSTAL_CODE_PATTERN.matcher(postalCode).matches();
    }

    /**
     * Checks if a string is null or empty.
     *
     * @param str The string to check
     * @return true if the string is null or empty, false otherwise
     */
    public static boolean isNullOrEmpty(String str) {
        return str == null || str.trim().isEmpty();
    }

    /**
     * Sanitizes a string by removing potentially dangerous characters.
     *
     * @param input The string to sanitize
     * @return The sanitized string
     */
    public static String sanitize(String input) {
        if (input == null) {
            return "";
        }

        // Remove potentially dangerous characters
        return input.replaceAll("[<>\"'&]", "");
    }

    /**
     * Validates a date string in the format yyyy-MM-dd.
     *
     * @param dateStr The date string to validate
     * @return true if the date is valid, false otherwise
     */
    public static boolean isValidDate(String dateStr) {
        if (dateStr == null || dateStr.trim().isEmpty()) {
            return false;
        }

        try {
            java.time.LocalDate.parse(dateStr);
            return true;
        } catch (Exception e) {
            return false;
        }
    }
}
