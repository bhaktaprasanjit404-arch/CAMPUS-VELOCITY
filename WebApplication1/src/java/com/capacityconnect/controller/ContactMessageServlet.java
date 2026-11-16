/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.capacityconnect.controller;

import com.capacityconnect.dao.ContactMessageDAO;
import com.capacityconnect.model.ContactMessage;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/ContactMessageServlet")
public class ContactMessageServlet extends HttpServlet {

    private ContactMessageDAO contactMessageDAO;

    @Override
    public void init() {

        contactMessageDAO = new ContactMessageDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String name =
                request.getParameter("name");

        String email =
                request.getParameter("email");

        String subject =
                request.getParameter("subject");

        String message =
                request.getParameter("message");


        // Basic validation

        if (name == null || name.trim().isEmpty()
                || email == null || email.trim().isEmpty()
                || subject == null || subject.trim().isEmpty()
                || message == null || message.trim().isEmpty()) {

            response.sendRedirect("about.jsp?error=1#contact");

            return;
        }


        ContactMessage contactMessage =
                new ContactMessage(
                        name.trim(),
                        email.trim(),
                        subject.trim(),
                        message.trim()
                );


        boolean saved =
                contactMessageDAO.saveMessage(contactMessage);


        if (saved) {

            response.sendRedirect(
                    "about.jsp?success=1#contact"
            );

        } else {

            response.sendRedirect(
                    "about.jsp?error=1#contact"
            );
        }
    }
}