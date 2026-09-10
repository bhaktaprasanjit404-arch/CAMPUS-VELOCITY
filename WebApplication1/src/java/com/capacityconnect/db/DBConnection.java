/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.capacityconnect.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String URL =
            "jdbc:mysql://localhost:3306/capacity_connect";

    private static final String USER =
            "root";

    private static final String PASSWORD =
            "YOUR_MYSQL_PASSWORD";


    public static Connection getConnection() {

        Connection connection = null;

        try {

            // Load MySQL JDBC Driver
            Class.forName("com.mysql.cj.jdbc.Driver");

            // Create database connection
            connection = DriverManager.getConnection(
                        "jdbc:mysql://localhost:3306/foodcentre",
                        "root",
                        "Prasan@1234"
                );

            System.out.println(
                    "Database connected successfully!"
            );

        } catch (ClassNotFoundException e) {

            System.out.println(
                    "MySQL JDBC Driver not found!"
            );

            e.printStackTrace();

        } catch (SQLException e) {

            System.out.println(
                    "Database connection failed!"
            );

            e.printStackTrace();
        }

        return connection;
    }
}