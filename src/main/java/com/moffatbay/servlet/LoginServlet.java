package com.moffatbay.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Locale;

import com.moffatbay.util.DBUtil;
import com.moffatbay.util.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String email =
                request.getParameter("email");

        String password =
                request.getParameter("password");

        if (email == null
                || email.isBlank()
                || password == null
                || password.isBlank()) {

            showError(
                    request,
                    response,
                    "Please enter both your email address and password."
            );

            return;
        }

        email = email
                .trim()
                .toLowerCase(Locale.ROOT);

        String sql =
                "SELECT customer_id, "
                + "first_name, "
                + "last_name, "
                + "email, "
                + "password_hash "
                + "FROM Customer "
                + "WHERE email = ?";

        try (
                Connection connection =
                        DBUtil.getConnection();

                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setString(1, email);

            try (ResultSet result =
                    statement.executeQuery()) {

                if (result.next()) {

                    String storedPasswordHash =
                            result.getString(
                                    "password_hash"
                            );

                    boolean passwordMatches =
                            PasswordUtil.verifyPassword(
                                    password,
                                    storedPasswordHash
                            );

                    if (passwordMatches) {

                        HttpSession oldSession =
                                request.getSession(false);

                        if (oldSession != null) {
                            oldSession.invalidate();
                        }

                        HttpSession session =
                                request.getSession(true);

                        session.setAttribute(
                                "customerId",
                                result.getInt("customer_id")
                        );

                        session.setAttribute(
                                "customerEmail",
                                result.getString("email")
                        );

                        session.setAttribute(
                                "customerName",
                                result.getString("first_name")
                                        + " "
                                        + result.getString("last_name")
                        );

                        response.sendRedirect(
                                request.getContextPath()
                                + "/index.jsp"
                        );

                        return;
                    }
                }
            }

            showError(
                    request,
                    response,
                    "Invalid email address or password."
            );

        } catch (SQLException e) {

            e.printStackTrace();

            showError(
                    request,
                    response,
                    "A database error occurred while logging in. Please try again."
            );
        }
    }

    private void showError(
            HttpServletRequest request,
            HttpServletResponse response,
            String message)
            throws ServletException, IOException {

        request.setAttribute(
                "loginError",
                message
        );

        request.getRequestDispatcher(
                "/Login_Page.jsp"
        ).forward(
                request,
                response
        );
    }
}