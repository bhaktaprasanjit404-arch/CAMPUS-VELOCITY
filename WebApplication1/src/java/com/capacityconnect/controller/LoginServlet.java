/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.capacityconnect.controller;

import com.capacityconnect.dao.UserDAO;
import com.capacityconnect.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {

    private UserDAO userDAO;

    @Override
    public void init() {
        userDAO = new UserDAO();
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        String role = request.getParameter("role");
        String password = request.getParameter("password");


        /* =========================================
           ADMIN LOGIN
           FIXED CREDENTIALS
        ========================================= */

        if ("ADMIN".equalsIgnoreCase(role)) {

            String username =
                    request.getParameter("username");

            /*
             * Fixed Admin credentials.
             *
             * Username: admin
             * Password: admin1234
             */

            if ("admin".equals(username)
                    && "admin1234".equals(password)) {

                HttpSession session =
                        request.getSession();

                session.setAttribute(
                        "userId",
                        0
                );

                session.setAttribute(
                        "userName",
                        "Administrator"
                );

                session.setAttribute(
                        "username",
                        "admin"
                );

                session.setAttribute(
                        "role",
                        "ADMIN"
                );

                response.sendRedirect(
                        request.getContextPath()
                        + "/admin/admin-dashboard.jsp"
                );

                return;

            } else {

                request.setAttribute(
                        "error",
                        "Invalid admin username or password."
                );

                request.getRequestDispatcher(
                        "login.jsp"
                ).forward(request, response);

                return;
            }
        }


        /* =========================================
           TEACHER / STUDENT LOGIN
        ========================================= */

        String email =
                request.getParameter("email");

        if (email == null ||
            email.trim().isEmpty() ||
            password == null ||
            password.trim().isEmpty()) {

            request.setAttribute(
                    "error",
                    "Please enter your email and password."
            );

            request.getRequestDispatcher(
                    "login.jsp"
            ).forward(request, response);

            return;
        }


        User user =
                userDAO.login(
                        email,
                        password,
                        role
                );


        /* =========================================
           SUCCESS
        ========================================= */

        if (user != null) {

            HttpSession session =
                    request.getSession();

            session.setAttribute(
                    "userId",
                    user.getId()
            );

            session.setAttribute(
                    "userName",
                    user.getName()
            );

            session.setAttribute(
                    "email",
                    user.getEmail()
            );

            session.setAttribute(
                    "role",
                    user.getRole()
            );


            /* Teacher */

            if ("TEACHER".equalsIgnoreCase(role)) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/teacher/teacher-dashboard.jsp"
                );

            }

            /* Student */

            else if ("STUDENT".equalsIgnoreCase(role)) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/student/student-dashboard.jsp"
                );

            }

            /* Unknown role */

            else {

                session.invalidate();

                request.setAttribute(
                        "error",
                        "Invalid user role."
                );

                request.getRequestDispatcher(
                        "login.jsp"
                ).forward(request, response);
            }

        }


        /* =========================================
           LOGIN FAILED
        ========================================= */

        else {

            request.setAttribute(
                    "error",
                    "Invalid email, password or role."
            );

            request.getRequestDispatcher(
                    "login.jsp"
            ).forward(request, response);
        }
    }
}