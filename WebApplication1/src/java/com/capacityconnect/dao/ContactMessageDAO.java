/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.capacityconnect.dao;

import com.capacityconnect.db.DBConnection;
import com.capacityconnect.model.ContactMessage;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class ContactMessageDAO {

    public boolean saveMessage(ContactMessage contactMessage) {

        String sql =
            "INSERT INTO contact_messages " +
            "(name, email, subject, message) " +
            "VALUES (?, ?, ?, ?)";

        try (
            Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setString(1, contactMessage.getName());
            ps.setString(2, contactMessage.getEmail());
            ps.setString(3, contactMessage.getSubject());
            ps.setString(4, contactMessage.getMessage());

            int rows = ps.executeUpdate();

            return rows > 0;

        } catch (Exception e) {

            e.printStackTrace();

            return false;
        }
    }
}