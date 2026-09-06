package com.moffatbay.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBUtil {

    private static final String URL =
            "jdbc:mysql://localhost:3306/moffat_bay";

    private static final String USER =
            "moffat_app";

    private static final String PASSWORD =
            "MoffatBay2026!";

    private DBUtil() {
    }

    public static Connection getConnection()
            throws SQLException {

        return DriverManager.getConnection(
                URL,
                USER,
                PASSWORD
        );
    }
}