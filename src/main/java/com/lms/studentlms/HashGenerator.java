package com.lms.studentlms;

import org.mindrot.jbcrypt.BCrypt;

public class HashGenerator {
    public static void main(String[] args) {
        String password = "vishva123"; // Replace with your desired password
        String hash = BCrypt.hashpw(password, BCrypt.gensalt(10));
        System.out.println(hash);
    }
}
