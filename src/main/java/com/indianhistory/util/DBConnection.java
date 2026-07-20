package com.indianhistory.util;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * Provides a JDBC connection to MySQL.
 *
 * Credentials are read from environment variables so that no secrets
 * are hardcoded in source. Docker Compose injects these via the
 * 'environment' block in docker-compose.yml.
 *
 * Fallbacks are provided for local development without Docker.
 */
public class DBConnection {

    private static final String DB_URL = getEnv(
            "DB_URL",
            "jdbc:mysql://localhost:3306/indian_history_db" +
            "?useSSL=false&serverTimezone=UTC&characterEncoding=UTF-8&allowPublicKeyRetrieval=true"
    );

    private static final String DB_USER     = getEnv("DB_USER",     "root");
    private static final String DB_PASSWORD = getEnv("DB_PASSWORD", "root");

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("MySQL JDBC Driver not found.", e);
        }
    }

    /** Returns a fresh JDBC connection. Caller is responsible for closing it. */
    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
    }

    /** Read env var, fall back to defaultValue if not set. */
    private static String getEnv(String name, String defaultValue) {
        String value = System.getenv(name);
        return (value != null && !value.isBlank()) ? value : defaultValue;
    }
}
