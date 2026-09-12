package com.capacityconnect.db;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;

public class DBConnection {

    private static String url = "jdbc:mysql://localhost:3306/capacity_connect?useSSL=false&allowPublicKeyRetrieval=true&serverTimezone=UTC";
    private static String user = "root";
    private static String pass = "Prasan@1234";

    static {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
        } catch (ClassNotFoundException e) {
            System.err.println("MySQL JDBC Driver not found: " + e.getMessage());
            e.printStackTrace();
        }

        try (InputStream in = DBConnection.class.getClassLoader().getResourceAsStream("db.properties")) {
            if (in != null) {
                Properties props = new Properties();
                props.load(in);
                if (props.containsKey("db.url")) url = props.getProperty("db.url");
                if (props.containsKey("db.user")) user = props.getProperty("db.user");
                if (props.containsKey("db.password")) pass = props.getProperty("db.password");
            }
        } catch (Exception ignored) {
        }

        String envUrl = System.getenv("DB_URL");
        if (envUrl != null && !envUrl.isEmpty()) url = envUrl;
        String envUser = System.getenv("DB_USER");
        if (envUser != null && !envUser.isEmpty()) user = envUser;
        String envPass = System.getenv("DB_PASSWORD");
        if (envPass != null) pass = envPass;
    }

    public static Connection getConnection() {
        Connection con = null;
        try {
            con = DriverManager.getConnection(url, user, pass);
        } catch (Exception e) {
            System.err.println("Database Connection Failed: " + e.getMessage());
            e.printStackTrace();
        }
        return con;
    }
}
