package com.lms.studentlms.dao;

import com.lms.studentlms.model.Admin;
import com.lms.studentlms.util.FileUtils;
import org.mindrot.jbcrypt.BCrypt;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

public class AdminDao extends BaseDao<Admin> {
    private static final String FILE_PATH = "C:\\Users\\USER\\OneDrive - Sri Lanka Institute of Information Technology\\Desktop\\New folder\\projectlms\\src\\main\\resources\\data\\admins.txt";

    public AdminDao() {
        super(FILE_PATH);
    }

    public boolean validateAdmin(String email, String password) {
        try {
            List<String> lines = FileUtils.readLinesFromFile(FILE_PATH);

            for (String line : lines) {
                String[] parts = line.split(",");
                if (parts.length > 3) {
                    String storedEmail = parts[2]; // Email is at index 2
                    String storedHash = parts[3]; // Password is at index 3

                    if (email.equals(storedEmail)) {
                        return BCrypt.checkpw(password, storedHash);
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return false;
    }

    public Optional<Admin> getAdminByEmail(String email) {
        try {
            List<String> lines = FileUtils.readLinesFromFile(FILE_PATH);

            for (String line : lines) {
                String[] parts = line.split(",");
                if (parts.length > 3) {
                    String storedEmail = parts[2]; // Email is at index 2

                    if (email.equals(storedEmail)) {
                        Admin admin = mapEntityFromLine(line);
                        return Optional.ofNullable(admin);
                    }
                }
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        return Optional.empty();
    }

    public boolean saveAdmin(Admin admin) {
        try {
            // Hash the password if it's not already hashed
            if (!admin.getPassword().startsWith("$2a$")) {
                String hashedPassword = BCrypt.hashpw(admin.getPassword(), BCrypt.gensalt());
                admin.setPassword(hashedPassword);
            }

            List<String> lines = new ArrayList<>();
            lines.add(mapEntityToLine(admin));

            FileUtils.writeLinesToFile(FILE_PATH, lines, true); // append mode
            return true;
        } catch (IOException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Admin> getAllAdmins() {
        return findAll();
    }

    public boolean updateAdmin(Admin admin) {
        try {
            List<Admin> admins = getAllAdmins();
            List<Admin> updatedAdmins = new ArrayList<>();
            boolean updated = false;

            for (Admin existingAdmin : admins) {
                if (existingAdmin.getEmail().equals(admin.getEmail())) {
                    // Update password only if it's changed
                    if (!admin.getPassword().startsWith("$2a$")) {
                        String hashedPassword = BCrypt.hashpw(admin.getPassword(), BCrypt.gensalt());
                        admin.setPassword(hashedPassword);
                    }
                    updatedAdmins.add(admin);
                    updated = true;
                } else {
                    updatedAdmins.add(existingAdmin);
                }
            }

            if (updated) {
                return saveAllOverwrite(updatedAdmins);
            }

            return false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public boolean deleteAdmin(String email) {
        try {
            List<Admin> admins = getAllAdmins();
            List<Admin> updatedAdmins = new ArrayList<>();
            boolean deleted = false;

            for (Admin admin : admins) {
                if (!admin.getEmail().equals(email)) {
                    updatedAdmins.add(admin);
                } else {
                    deleted = true;
                }
            }

            if (deleted) {
                return saveAllOverwrite(updatedAdmins);
            }

            return false;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    @Override
    protected Admin mapEntityFromLine(String line) {
        String[] parts = line.split(",");
        if (parts.length >= 4) {
            Admin admin = new Admin();
            admin.setFullName(parts[0]);
            admin.setUsername(parts[1]);
            admin.setEmail(parts[2]);
            admin.setPassword(parts[3]);

            if (parts.length > 4) {
                admin.setRole(parts[4]);
            } else {
                admin.setRole("ADMIN");
            }

            return admin;
        }
        return null;
    }

    @Override
    protected String mapEntityToLine(Admin admin) {
        return admin.getFullName() + "," +
                admin.getUsername() + "," +
                admin.getEmail() + "," +
                admin.getPassword() + "," +
                admin.getRole();
    }
}

