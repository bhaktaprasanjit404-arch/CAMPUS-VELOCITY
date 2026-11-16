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


    // =========================================================
    // INIT
    // =========================================================

    @Override
    public void init() {

        userDAO = new UserDAO();

    }


    // =========================================================
    // POST
    // =========================================================

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {


        // Get selected role
        String role =
                request.getParameter("role");


        // =====================================================
        // NO ROLE SELECTED
        // =====================================================

        if (role == null || role.trim().isEmpty()) {

            request.setAttribute(
                    "error",
                    "Please select an account type."
            );


            request.getRequestDispatcher(
                    "login.jsp"
            ).forward(request, response);


            return;
        }


        // =====================================================
        // USER / STUDENT LOGIN
        // =====================================================

        if (role.equals("USER")) {


            String name =
                    request.getParameter(
                            "userName"
                    );


            String email =
                    request.getParameter(
                            "userEmail"
                    );


            // Basic validation
            if (name == null ||
                    name.trim().isEmpty() ||
                    email == null ||
                    email.trim().isEmpty()) {


                request.setAttribute(
                        "error",
                        "Please enter your name and email."
                );


                request.getRequestDispatcher(
                        "login.jsp"
                ).forward(request, response);


                return;
            }


            // Login from database
            User user =
                    userDAO.loginUser(
                            name.trim(),
                            email.trim()
                    );


            // =================================================
            // LOGIN SUCCESS
            // =================================================

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
                        "STUDENT"
                );


                // Student dashboard
                response.sendRedirect(
                        "user/dashboard.jsp"
                );


                return;
            }


            // =================================================
            // LOGIN FAILED
            // =================================================

            request.setAttribute(
                    "error",
                    "Invalid user name or email."
            );


            request.getRequestDispatcher(
                    "login.jsp"
            ).forward(request, response);


            return;
        }


        // =====================================================
        // TEACHER LOGIN
        // =====================================================

        if (role.equals("TEACHER")) {


            String name =
                    request.getParameter(
                            "teacherName"
                    );


            String phone =
                    request.getParameter(
                            "teacherPhone"
                    );


            // Basic validation
            if (name == null ||
                    name.trim().isEmpty() ||
                    phone == null ||
                    phone.trim().isEmpty()) {


                request.setAttribute(
                        "error",
                        "Please enter teacher name and phone number."
                );


                request.getRequestDispatcher(
                        "login.jsp"
                ).forward(request, response);


                return;
            }


            // Login from database
            User teacher =
                    userDAO.loginTeacher(
                            name.trim(),
                            phone.trim()
                    );


            // =================================================
            // TEACHER LOGIN SUCCESS
            // =================================================

            if (teacher != null) {


                HttpSession session =
                        request.getSession();


                session.setAttribute(
                        "userId",
                        teacher.getId()
                );


                session.setAttribute(
                        "userName",
                        teacher.getName()
                );


                session.setAttribute(
                        "email",
                        teacher.getEmail()
                );


                session.setAttribute(
                        "role",
                        "TEACHER"
                );


                // Important:
                // TeacherServlet loads the teacher object
                // and then opens teacher dashboard.

                response.sendRedirect(
                        "TeacherServlet?action=dashboard"
                );


                return;
            }


            // =================================================
            // TEACHER LOGIN FAILED
            // =================================================

            request.setAttribute(
                    "error",
                    "Invalid teacher name or phone number."
            );


            request.getRequestDispatcher(
                    "login.jsp"
            ).forward(request, response);


            return;
        }


        // =====================================================
        // ADMIN LOGIN
        // =====================================================

        if (role.equals("ADMIN")) {


            String username =
                    request.getParameter(
                            "adminUsername"
                    );


            String password =
                    request.getParameter(
                            "adminPassword"
                    );


            // Basic validation
            if (username == null ||
                    username.trim().isEmpty() ||
                    password == null ||
                    password.trim().isEmpty()) {


                request.setAttribute(
                        "error",
                        "Please enter administrator username and password."
                );


                request.getRequestDispatcher(
                        "login.jsp"
                ).forward(request, response);


                return;
            }


            // Check admin table
            boolean valid =
                    userDAO.loginAdmin(
                            username.trim(),
                            password
                    );


            // =================================================
            // ADMIN LOGIN SUCCESS
            // =================================================

            if (valid) {


                HttpSession session =
                        request.getSession();


                session.setAttribute(
                        "adminUsername",
                        username
                );


                session.setAttribute(
                        "role",
                        "ADMIN"
                );


                response.sendRedirect(
                        "admin/dashboard.jsp"
                );


                return;
            }


            // =================================================
            // ADMIN LOGIN FAILED
            // =================================================

            request.setAttribute(
                    "error",
                    "Invalid administrator credentials."
            );


            request.getRequestDispatcher(
                    "login.jsp"
            ).forward(request, response);


            return;
        }


        // =====================================================
        // INVALID ROLE
        // =====================================================

        request.setAttribute(
                "error",
                "Invalid account type selected."
        );


        request.getRequestDispatcher(
                "login.jsp"
        ).forward(request, response);
    }
}