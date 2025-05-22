package com.lms.studentlms.controller.auth;

import com.lms.studentlms.dao.UserDao;

import com.lms.studentlms.model.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private UserDao userDao;
//polymorphism
    @Override
    public void init() throws ServletException {
        userDao = new UserDao();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Check if user is already logged in
        HttpSession session = request.getSession(false);
        if (session != null && session.getAttribute("userEmail") != null) {
            // User is already logged in, redirect to dashboard
            response.sendRedirect(request.getContextPath() + "/user/dashboard");
            return;
        }

        // Show registration form
        request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get form data
        String fullName = request.getParameter("fullName");
        String nic = request.getParameter("nic");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String dateOfBirth = request.getParameter("dateOfBirth");
        String gender = request.getParameter("gender");
        String mobileNumber = request.getParameter("mobileNumber");
        String whatsAppNumber = request.getParameter("whatsAppNumber");
        String permanentAddress = request.getParameter("permanentAddress");
        String districtOrProvince = request.getParameter("districtOrProvince");
        String postalCode = request.getParameter("postalCode");
        String indexNumber = request.getParameter("indexNumber");
        String yearOfCompletion = request.getParameter("yearOfCompletion");
        String parentFullName = request.getParameter("parentFullName");
        String parentContactNumber = request.getParameter("parentContactNumber");
        String parentEmail = request.getParameter("parentEmail");

        // Validate input
        List<String> errors = validateInput(fullName, nic, email, password, confirmPassword,
                dateOfBirth, mobileNumber);

        if (!errors.isEmpty()) {
            request.setAttribute("errors", errors);
            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
            return;
        }

        // Check if email already exists
        User existingUser = userDao.getUserByEmail(email);
        if (existingUser != null) {
            errors.add("Email already registered. Please use a different email.");
            request.setAttribute("errors", errors);
            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
            return;
        }

        // Create new user
        User user = new User(
                fullName,
                nic,
                email,
                password,
                dateOfBirth,
                gender,
                mobileNumber,
                whatsAppNumber,
                permanentAddress,
                districtOrProvince,
                postalCode,
                indexNumber,
                yearOfCompletion,
                new ArrayList<>(), // Empty certificates list
                parentFullName,
                parentContactNumber,
                parentEmail
        );

        boolean registered = userDao.saveUser(user);

        if (registered) {
            // Create session for the new user
            HttpSession session = request.getSession();
            session.setAttribute("userEmail", email);
            session.setAttribute("userName", fullName);
            session.setAttribute("userRegisterNumber", user.getRegisterNumber());

            // Redirect to dashboard
            response.sendRedirect(request.getContextPath() + "/user/dashboard");
        } else {
            errors.add("Registration failed. Please try again later.");
            request.setAttribute("errors", errors);
            request.getRequestDispatcher("/WEB-INF/views/auth/register.jsp").forward(request, response);
        }
    }

    private List<String> validateInput(String fullName, String nic, String email,
                                       String password, String confirmPassword, String dateOfBirth, String mobileNumber) {
        List<String> errors = new ArrayList<>();

        if (fullName == null || fullName.trim().isEmpty()) {
            errors.add("Full name is required");
        }

        if (nic == null || nic.trim().isEmpty()) {
            errors.add("NIC is required");
        }

        if (email == null || email.trim().isEmpty()) {
            errors.add("Email is required");
        } else if (!email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            errors.add("Invalid email format");
        }

        if (password == null || password.trim().isEmpty()) {
            errors.add("Password is required");
        } else if (password.length() < 6) {
            errors.add("Password must be at least 6 characters long");
        }

        if (!password.equals(confirmPassword)) {
            errors.add("Passwords do not match");
        }

        if (dateOfBirth == null || dateOfBirth.trim().isEmpty()) {
            errors.add("Date of birth is required");
        }

        if (mobileNumber == null || mobileNumber.trim().isEmpty()) {
            errors.add("Mobile number is required");
        }

        return errors;
    }
}
