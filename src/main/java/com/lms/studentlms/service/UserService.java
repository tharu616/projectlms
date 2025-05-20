package com.lms.studentlms.service;

import com.lms.studentlms.dao.UserDao;
import com.lms.studentlms.model.User;

import java.util.Date;
import java.util.List;

public class UserService {

    private UserDao userDao;

    public UserService() {
        this.userDao = new UserDao();
    }

    public boolean registerUser(User user) {
        // Validate user data
        if (user.getEmail() == null || user.getEmail().isEmpty() ||
                user.getPassword() == null || user.getPassword().isEmpty() ||
                user.getFullName() == null || user.getFullName().isEmpty()) {
            return false;
        }

        // Check if user already exists
        User existingUser = userDao.getUserByEmail(user.getEmail());
        if (existingUser != null) {
            return false;
        }

        // Save the user
        return userDao.saveUser(user);
    }

    public User authenticateUser(String email, String password) {
        // Validate credentials
        if (email == null || email.isEmpty() || password == null || password.isEmpty()) {
            return null;
        }

        // Check if credentials are valid
        boolean isValid = userDao.validateUser(email, password);
        if (!isValid) {
            return null;
        }

        // Return user details
        return userDao.getUserByEmail(email);
    }

    public User getUserByEmail(String email) {
        if (email == null || email.isEmpty()) {
            return null;
        }
        return userDao.getUserByEmail(email);
    }

    public List<User> getAllUsers() {
        return userDao.readAllUsers();
    }

    public boolean updateUser(User user) {
        if (user == null || user.getEmail() == null || user.getEmail().isEmpty()) {
            return false;
        }

        // Check if user exists
        User existingUser = userDao.getUserByEmail(user.getEmail());
        if (existingUser == null) {
            return false;
        }

        return userDao.updateUser(user);
    }

    public boolean deleteUser(String email) {
        if (email == null || email.isEmpty()) {
            return false;
        }
        return userDao.deleteUser(email);
    }

    public List<User> getUsersByRegistrationDate(Date startDate, Date endDate) {
        if (startDate == null || endDate == null) {
            return List.of();
        }
        return userDao.getUsersByRegistrationDate(startDate, endDate);
    }

    public int getTotalUserCount() {
        return userDao.getTotalUserCount();
    }
}
