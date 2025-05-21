package com.lms.studentlms.dao;

import com.lms.studentlms.model.User;
import com.lms.studentlms.util.FileUtils;
import org.mindrot.jbcrypt.BCrypt;

import java.io.*;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.util.*;
import java.util.stream.Collectors;

public class UserDao extends BaseDao<User> {
    private static final String FILE_PATH = "C:\\Users\\USER\\OneDrive - Sri Lanka Institute of Information Technology\\Desktop\\New folder\\projectlms\\src\\main\\resources\\data\\users.txt";

    public UserDao() {
        super(FILE_PATH);
    }

    public boolean saveUser(User user) {
        try {
            // Generate register number if not already set
            if (user.getRegisterNumber() == null || user.getRegisterNumber().isEmpty()) {
                user.setRegisterNumber(generateRegisterNumber());
            }

            // Set timestamp if not already set
            if (user.getTimestamp() == 0) {
                user.setTimestamp(System.currentTimeMillis());
            }

            // Hash the password if it's not already hashed
            if (!user.getPassword().startsWith("$2a$")) {
                String hashedPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt());
                user.setPassword(hashedPassword);
            }

            List<String> lines = new ArrayList<>();
            lines.add(formatUserToLine(user));

            FileUtils.writeLinesToFile(FILE_PATH, lines, true); // append mode
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean updateUser(User user) {
        try {
            List<String> allLines = FileUtils.readLinesFromFile(FILE_PATH);
            List<String> updatedLines = new ArrayList<>();
            boolean updated = false;

            for (String line : allLines) {
                String[] parts = line.split(",");
                if (parts.length > 2 && parts[2].equals(user.getEmail())) {
                    // This is the user to update
                    updatedLines.add(formatUserToLine(user));
                    updated = true;
                } else {
                    updatedLines.add(line);
                }
            }

            if (updated) {
                FileUtils.writeLinesToFile(FILE_PATH, updatedLines, false); // overwrite mode
                return true;
            }

            return false;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteUser(String email) {
        try {
            List<String> allLines = FileUtils.readLinesFromFile(FILE_PATH);
            List<String> updatedLines = allLines.stream()
                    .filter(line -> {
                        String[] parts = line.split(",");
                        return parts.length <= 2 || !parts[2].equals(email);
                    })
                    .collect(Collectors.toList());

            if (updatedLines.size() < allLines.size()) {
                FileUtils.writeLinesToFile(FILE_PATH, updatedLines, false); // overwrite mode
                return true;
            }

            return false;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean validateUser(String inputEmail, String inputPassword) {
        try {
            List<String> lines = FileUtils.readLinesFromFile(FILE_PATH);

            for (String line : lines) {
                String[] parts = line.split(",");
                if (parts.length > 3) {
                    String storedEmail = parts[2]; // Email is at index 2
                    String storedHash = parts[3]; // Password is at index 3

                    if (inputEmail.equals(storedEmail)) {
                        return BCrypt.checkpw(inputPassword, storedHash);
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return false;
    }

    public List<User> readAllUsers() {
        try {
            List<String> lines = FileUtils.readLinesFromFile(FILE_PATH);
            List<User> users = new ArrayList<>();

            for (String line : lines) {
                try {
                    String[] parts = line.split(",");
                    if (parts.length >= 17) {
                        User user = mapUserFromParts(parts);
                        users.add(user);
                    }
                } catch (Exception e) {
                    // Skip invalid lines
                    e.printStackTrace();
                }
            }

            return users;
        } catch (IOException e) {
            e.printStackTrace();
            return new ArrayList<>();
        }
    }

    public User getUserByEmail(String email) {
        try {
            List<String> lines = FileUtils.readLinesFromFile(FILE_PATH);

            for (String line : lines) {
                String[] parts = line.split(",");
                if (parts.length >= 17) {
                    String storedEmail = parts[2]; // Email is at index 2
                    if (email.equals(storedEmail)) {
                        return mapUserFromParts(parts);
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return null; // User not found
    }

    public int getTotalUserCount() {
        try {
            List<String> lines = FileUtils.readLinesFromFile(FILE_PATH);
            return (int) lines.stream()
                    .filter(line -> !line.trim().isEmpty())
                    .count();
        } catch (IOException e) {
            e.printStackTrace();
            return 0;
        }
    }

    public List<User> getUsersByRegistrationDate(Date startDate, Date endDate) {
        List<User> allUsers = readAllUsers();
        long startTime = startDate.getTime();
        long endTime = endDate.getTime();

        return allUsers.stream()
                .filter(user -> {
                    long timestamp = user.getTimestamp();
                    return timestamp >= startTime && timestamp <= endTime;
                })
                .collect(Collectors.toList());
    }

    private String generateRegisterNumber() {
        String prefix = "STU";
        int nextNumber = 1001;

        try {
            // Read the last line to get the latest register number
            String lastLine = readLastLine();
            if (lastLine != null && !lastLine.isEmpty()) {
                String[] parts = lastLine.split(",");
                // Check if the register number is available (index 17)
                if (parts.length > 17) {
                    String lastRegNum = parts[17];
                    if (lastRegNum != null && lastRegNum.startsWith(prefix)) {
                        try {
                            // Extract number part and increment
                            int num = Integer.parseInt(lastRegNum.substring(prefix.length()));
                            nextNumber = num + 1;
                        } catch (NumberFormatException e) {
                            // Use default if format is incorrect
                        }
                    }
                }
            }
        } catch (Exception e) {
            // Use default in case of error
        }

        // Return the new register number
        return prefix + nextNumber;
    }

    private String readLastLine() {
        try {
            File file = new File(FILE_PATH);
            if (!file.exists() || file.length() == 0) {
                return null;
            }

            List<String> allLines = Files.readAllLines(Paths.get(FILE_PATH));
            if (allLines.isEmpty()) {
                return null;
            }

            return allLines.get(allLines.size() - 1);
        } catch (IOException e) {
            return null;
        }
    }

    private User mapUserFromParts(String[] parts) {
        User user = new User(
                parts[0], // fullName
                parts[1], // nic
                parts[2], // email
                parts[3], // password (hashed)
                parts[4], // dateOfBirth
                parts[5], // gender
                parts[6], // mobileNumber
                parts[7], // whatsAppNumber
                parts[8], // permanentAddress
                parts[9], // districtOrProvince
                parts[10], // postalCode
                parts[11], // indexNumber
                parts[12], // yearOfCompletion
                Arrays.asList(parts[13].split("\\|")), // certificates
                parts[14], // parentFullName
                parts[15], // parentContactNumber
                parts[16] // parentEmail
        );

        // Set register number if available
        if (parts.length > 17) {
            user.setRegisterNumber(parts[17]);
        }

        // Set timestamp if available
        if (parts.length > 18) {
            try {
                user.setTimestamp(Long.parseLong(parts[18]));
            } catch (NumberFormatException e) {
                user.setTimestamp(System.currentTimeMillis());
            }
        } else {
            user.setTimestamp(System.currentTimeMillis());
        }

        return user;
    }

    private String formatUserToLine(User user) {
        return user.getFullName() + "," +
                user.getNic() + "," +
                user.getEmail() + "," +
                user.getPassword() + "," +
                user.getDateOfBirth() + "," +
                user.getGender() + "," +
                user.getMobileNumber() + "," +
                user.getWhatsAppNumber() + "," +
                user.getPermanentAddress() + "," +
                user.getDistrictOrProvince() + "," +
                user.getPostalCode() + "," +
                user.getIndexNumber() + "," +
                user.getYearOfCompletion() + "," +
                String.join("|", user.getCertificates()) + "," +
                user.getParentFullName() + "," +
                user.getParentContactNumber() + "," +
                user.getParentEmail() + "," +
                user.getRegisterNumber() + "," +
                user.getTimestamp();
    }

    @Override
    protected User mapEntityFromLine(String line) {
        String[] parts = line.split(",");
        if (parts.length >= 17) {
            return mapUserFromParts(parts);
        }
        return null;
    }

    @Override
    protected String mapEntityToLine(User user) {
        return formatUserToLine(user);
    }
}
