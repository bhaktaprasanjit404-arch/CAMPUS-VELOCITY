package com.capacityconnect.controller;

import com.capacityconnect.dao.UserDAO;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

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


        request.setCharacterEncoding("UTF-8");


        String role =
                request.getParameter("role");


        String name =
                request.getParameter("name");

        String email =
                request.getParameter("email");

        String password =
                request.getParameter("password");


        /* =====================================================
           BASIC VALIDATION
        ===================================================== */

        if (role == null ||
            name == null ||
            email == null ||
            password == null ||
            name.trim().isEmpty() ||
            email.trim().isEmpty() ||
            password.trim().isEmpty()) {

            request.setAttribute(
                    "error",
                    "Please fill all required fields."
            );

            request.getRequestDispatcher(
                    "register.jsp"
            ).forward(request, response);

            return;
        }


        try {


            /* =================================================
               STUDENT / USER REGISTRATION
            ================================================= */

            if ("STUDENT".equalsIgnoreCase(role)) {


                boolean success =
                        userDAO.registerStudent(
                                name.trim(),
                                email.trim(),
                                password
                        );


                if (success) {

                    response.sendRedirect(
                            "login.jsp?registered=student"
                    );

                } else {

                    request.setAttribute(
                            "error",
                            "Registration failed. Email may already exist."
                    );

                    request.getRequestDispatcher(
                            "register.jsp"
                    ).forward(request, response);
                }


                return;
            }


            /* =================================================
               TEACHER REGISTRATION
            ================================================= */

            if ("TEACHER".equalsIgnoreCase(role)) {


                String qualification =
                        request.getParameter(
                                "qualification"
                        );


                String specialization =
                        request.getParameter(
                                "specialization"
                        );


                String phone =
                        request.getParameter(
                                "phone"
                        );


                String bio =
                        request.getParameter(
                                "bio"
                        );


                if (qualification == null ||
                    specialization == null ||
                    phone == null ||
                    qualification.trim().isEmpty() ||
                    specialization.trim().isEmpty() ||
                    phone.trim().isEmpty()) {


                    request.setAttribute(
                            "error",
                            "Please fill all teacher details."
                    );


                    request.getRequestDispatcher(
                            "register.jsp"
                    ).forward(request, response);

                    return;
                }


                boolean success =
                        userDAO.registerTeacher(
                                name.trim(),
                                email.trim(),
                                password,
                                qualification.trim(),
                                specialization.trim(),
                                phone.trim(),
                                bio
                        );


                if (success) {

                    response.sendRedirect(
                            "login.jsp?registered=teacher"
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


            /* =================================================
               INVALID ROLE
            ================================================= */

            request.setAttribute(
                    "error",
                    "Invalid registration type."
            );

            request.getRequestDispatcher(
                    "register.jsp"
            ).forward(request, response);


        } catch (Exception e) {

            e.printStackTrace();


            request.setAttribute(
                    "error",
                    "Something went wrong: "
                    + e.getMessage()
            );


            request.getRequestDispatcher(
                    "register.jsp"
            ).forward(request, response);
        }
    }


    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws IOException {

        response.sendRedirect("register.jsp");
    }
}