package com.capacityconnect.controller;

import com.capacityconnect.dao.UserDAO;
import com.capacityconnect.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

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


        // =================================================
        // STUDENT LOGIN
        // =================================================

        if ("STUDENT".equalsIgnoreCase(role)) {

            try {

                int studentId =
                        Integer.parseInt(
                                request.getParameter("studentId")
                        );

                String studentName =
                        request.getParameter("studentName");

                String password =
                        request.getParameter("studentPassword");


                User user =
                        userDAO.loginStudent(
                                studentId,
                                studentName,
                                password
                        );


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


                    response.sendRedirect(
                            request.getContextPath()
                            + "/student/student-dashboard.jsp"
                    );

                } else {

                    request.setAttribute(
                            "error",
                            "Invalid Student ID, name or password."
                    );

                    request.getRequestDispatcher(
                            "login.jsp"
                    ).forward(request, response);
                }


            } catch (NumberFormatException e) {

                request.setAttribute(
                        "error",
                        "Please enter a valid Student ID."
                );

                request.getRequestDispatcher(
                        "login.jsp"
                ).forward(request, response);
            }

            return;
        }


        // =================================================
// TEACHER LOGIN
// =================================================

if ("TEACHER".equalsIgnoreCase(role)) {

    try {

        int teacherId =
                Integer.parseInt(
                        request.getParameter("teacherId")
                );

        int userId =
                Integer.parseInt(
                        request.getParameter("userId")
                );

        String password =
                request.getParameter("teacherPassword");


        User user =
                userDAO.loginTeacher(
                        teacherId,
                        userId,
                        password
                );


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
                    "TEACHER"
            );

            session.setAttribute(
                    "teacherId",
                    teacherId
            );


            // IMPORTANT:
            // Do NOT open dashboard.jsp directly.
            // TeacherServlet must load the Teacher object.

            response.sendRedirect(
                    request.getContextPath()
                    + "/TeacherServlet?action=dashboard"
            );


        } else {

            request.setAttribute(
                    "error",
                    "Invalid Teacher ID, User ID or password."
            );

            request.getRequestDispatcher(
                    "login.jsp"
            ).forward(request, response);
        }


    } catch (NumberFormatException e) {

        request.setAttribute(
                "error",
                "Teacher ID and User ID must be numbers."
        );

        request.getRequestDispatcher(
                "login.jsp"
        ).forward(request, response);
    }

    return;
}

        // =================================================
        // ADMIN LOGIN
        // =================================================

        if ("ADMIN".equalsIgnoreCase(role)) {

            String username =
                    request.getParameter("adminUsername");

            String password =
                    request.getParameter("adminPassword");


            boolean success =
                    userDAO.loginAdmin(
                            username,
                            password
                    );


            if (success) {

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
                        request.getContextPath()
                        + "/admin/dashboard.jsp"
                );


            } else {

                request.setAttribute(
                        "error",
                        "Invalid admin username or password."
                );

                request.getRequestDispatcher(
                        "login.jsp"
                ).forward(request, response);
            }

            return;
        }


        // =================================================
        // INVALID ROLE
        // =================================================

        request.setAttribute(
                "error",
                "Please select an account type."
        );

        request.getRequestDispatcher(
                "login.jsp"
        ).forward(request, response);
    }
}