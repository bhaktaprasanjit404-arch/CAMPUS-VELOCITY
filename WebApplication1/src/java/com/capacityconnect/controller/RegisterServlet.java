package com.capacityconnect.controller;

import com.capacityconnect.dao.UserDAO;
import com.capacityconnect.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;

@WebServlet("/RegisterServlet")
public class RegisterServlet extends HttpServlet {

    private UserDAO userDAO;


    @Override
    public void init() {

        userDAO = new UserDAO();
    }


    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {


        String role =
                request.getParameter("role");

        String name =
                request.getParameter("name");

        String email =
                request.getParameter("email");

        String password =
                request.getParameter("password");


        // =================================================
        // STUDENT REGISTRATION
        // =================================================

        if ("STUDENT".equalsIgnoreCase(role)) {

            User user = new User();

            user.setName(name.trim());
            user.setEmail(email.trim());
            user.setPassword(password);
            user.setRole("STUDENT");


            boolean success =
                    userDAO.registerStudent(user);


            if (success) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/login.jsp?registered=true"
                );

            } else {

                request.setAttribute(
                        "error",
                        "Student registration failed. Email may already exist."
                );

                request.getRequestDispatcher(
                        "register.jsp"
                ).forward(request, response);
            }

            return;
        }


        // =================================================
        // TEACHER REGISTRATION
        // =================================================

        if ("TEACHER".equalsIgnoreCase(role)) {

            String qualification =
                    request.getParameter("qualification");

            String specialization =
                    request.getParameter("specialization");

            String phone =
                    request.getParameter("phone");

            String bio =
                    request.getParameter("bio");


            User user = new User();

            user.setName(name.trim());
            user.setEmail(email.trim());
            user.setPassword(password);
            user.setRole("TEACHER");


            boolean success =
                    userDAO.registerTeacher(
                            user,
                            qualification,
                            specialization,
                            phone,
                            bio
                    );


            if (success) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/login.jsp?registered=true"
                );

            } else {

                request.setAttribute(
                        "error",
                        "Teacher registration failed. Email may already exist."
                );

                request.getRequestDispatcher(
                        "register.jsp"
                ).forward(request, response);
            }

            return;
        }


        // =================================================
        // INVALID ROLE
        // =================================================

        request.setAttribute(
                "error",
                "Invalid account type."
        );

        request.getRequestDispatcher(
                "register.jsp"
        ).forward(request, response);
    }
}