package com.moffatbay.servlet;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import com.moffatbay.util.DBUtil;
import com.moffatbay.util.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");


        // =====================================================
        // GET VALUES FROM REGISTRATION FORM
        // =====================================================

        String email = request.getParameter("email");
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String telephone = request.getParameter("telephone");
        String boatName = request.getParameter("boatName");
        String boatLengthText = request.getParameter("boatLength");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");


        // =====================================================
        // REQUIRED FIELD VALIDATION
        // =====================================================

        if (isBlank(email)
                || isBlank(firstName)
                || isBlank(lastName)
                || isBlank(telephone)
                || isBlank(boatName)
                || isBlank(boatLengthText)
                || isBlank(password)
                || isBlank(confirmPassword)) {

            showError(
                    request,
                    response,
                    "Missing Information",
                    "All registration fields are required."
            );

            return;
        }


        // Remove extra spaces
        email = email.trim();
        firstName = firstName.trim();
        lastName = lastName.trim();
        telephone = telephone.trim();
        boatName = boatName.trim();


        // =====================================================
        // EMAIL VALIDATION
        // =====================================================

        if (!email.matches(
                "^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$")) {

            showError(
                    request,
                    response,
                    "Invalid Email Address",
                    "Please enter a valid email address."
            );

            return;
        }


        // =====================================================
        // PASSWORD VALIDATION
        // =====================================================

        if (password.length() < 8
                || !password.matches(".*[A-Z].*")
                || !password.matches(".*[a-z].*")) {

            showError(
                    request,
                    response,
                    "Invalid Password",
                    "Password must be at least 8 characters and contain "
                    + "at least one uppercase and one lowercase letter."
            );

            return;
        }


        // =====================================================
        // CONFIRM PASSWORD
        // =====================================================

        if (!password.equals(confirmPassword)) {

            showError(
                    request,
                    response,
                    "Passwords Do Not Match",
                    "The passwords entered do not match. "
                    + "Please enter the same password in both fields."
            );

            return;
        }


        // =====================================================
        // BOAT LENGTH VALIDATION
        // =====================================================

        BigDecimal boatLength;

        try {

            boatLength = new BigDecimal(boatLengthText);

            if (boatLength.compareTo(BigDecimal.ZERO) <= 0) {

                showError(
                        request,
                        response,
                        "Invalid Boat Length",
                        "Boat length must be greater than zero."
                );

                return;
            }

        } catch (NumberFormatException e) {

            showError(
                    request,
                    response,
                    "Invalid Boat Length",
                    "Please enter a valid numeric boat length."
            );

            return;
        }


        // =====================================================
        // HASH PASSWORD
        // =====================================================

        String passwordHash =
                PasswordUtil.hashPassword(password);


        Connection connection = null;


        try {

            connection = DBUtil.getConnection();

            /*
             * Customer and Boat are related records.
             * Both inserts must succeed together.
             */
            connection.setAutoCommit(false);


            // =================================================
            // CHECK FOR DUPLICATE EMAIL
            // =================================================

            String checkEmailSQL =
                    "SELECT customer_id "
                    + "FROM Customer "
                    + "WHERE email = ?";


            try (PreparedStatement checkStatement =
                         connection.prepareStatement(checkEmailSQL)) {

                checkStatement.setString(1, email);


                try (ResultSet result =
                             checkStatement.executeQuery()) {

                    if (result.next()) {

                        connection.rollback();

                        showError(
                                request,
                                response,
                                "Email Already Exists",
                                "An account already exists with that email address. "
                                + "Please use a different email address or log in "
                                + "to your existing account."
                        );

                        return;
                    }
                }
            }


            // =================================================
            // INSERT CUSTOMER
            // =================================================

            String customerSQL =
                    "INSERT INTO Customer "
                    + "(email, first_name, last_name, "
                    + "telephone, password_hash) "
                    + "VALUES (?, ?, ?, ?, ?)";


            int customerId;


            try (PreparedStatement customerStatement =
                         connection.prepareStatement(
                                 customerSQL,
                                 Statement.RETURN_GENERATED_KEYS)) {

                customerStatement.setString(
                        1,
                        email
                );

                customerStatement.setString(
                        2,
                        firstName
                );

                customerStatement.setString(
                        3,
                        lastName
                );

                customerStatement.setString(
                        4,
                        telephone
                );

                customerStatement.setString(
                        5,
                        passwordHash
                );


                customerStatement.executeUpdate();


                try (ResultSet generatedKeys =
                             customerStatement.getGeneratedKeys()) {

                    if (!generatedKeys.next()) {

                        throw new SQLException(
                                "Unable to retrieve new customer ID."
                        );
                    }

                    customerId =
                            generatedKeys.getInt(1);
                }
            }


            // =================================================
            // INSERT BOAT
            // =================================================

            String boatSQL =
                    "INSERT INTO Boat "
                    + "(customer_id, boat_name, boat_length) "
                    + "VALUES (?, ?, ?)";


            try (PreparedStatement boatStatement =
                         connection.prepareStatement(boatSQL)) {

                boatStatement.setInt(
                        1,
                        customerId
                );

                boatStatement.setString(
                        2,
                        boatName
                );

                boatStatement.setBigDecimal(
                        3,
                        boatLength
                );


                boatStatement.executeUpdate();
            }


            // =================================================
            // SAVE REGISTRATION
            // =================================================

            connection.commit();


            // =================================================
            // SUCCESS PAGE
            // =================================================

            request.getRequestDispatcher(
                    "/registrationSuccess.jsp"
            ).forward(
                    request,
                    response
            );


        } catch (SQLException e) {

            e.printStackTrace();


            if (connection != null) {

                try {

                    connection.rollback();

                } catch (SQLException rollbackError) {

                    rollbackError.printStackTrace();
                }
            }


            showError(
                    request,
                    response,
                    "Database Error",
                    "A database error occurred. "
                    + "The account could not be created. "
                    + "Please try again."
            );


        } finally {

            if (connection != null) {

                try {

                    connection.setAutoCommit(true);

                    connection.close();

                } catch (SQLException e) {

                    e.printStackTrace();
                }
            }
        }
    }


    // =========================================================
    // CHECK FOR BLANK VALUES
    // =========================================================

    private boolean isBlank(String value) {

        return value == null
                || value.trim().isEmpty();
    }


    // =========================================================
    // RETURN ERROR TO REGISTRATION PAGE
    // =========================================================

    private void showError(
            HttpServletRequest request,
            HttpServletResponse response,
            String title,
            String message)
            throws ServletException, IOException {

        request.setAttribute(
                "registrationErrorTitle",
                title
        );

        request.setAttribute(
                "registrationError",
                message
        );

        request.getRequestDispatcher(
                "/register.jsp"
        ).forward(
                request,
                response
        );
    }
}