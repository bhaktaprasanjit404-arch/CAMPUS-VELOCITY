/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.capacityconnect.controller;

import com.capacityconnect.dao.TeacherDAO;
import com.capacityconnect.model.Teacher;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/TeacherServlet")
public class TeacherServlet extends HttpServlet {

    private TeacherDAO teacherDAO;

    @Override
    public void init() {
        teacherDAO = new TeacherDAO();
    }


    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // =================================================
        // TEACHER LOGIN CHECK
        // =================================================

        if (session == null ||
            session.getAttribute("userId") == null ||
            !"TEACHER".equals(session.getAttribute("role"))) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp");

            return;
        }

        int userId =
                (Integer) session.getAttribute("userId");

        // =================================================
        // GET TEACHER
        // =================================================

        Teacher teacher =
                teacherDAO.getTeacherByUserId(userId);

        if (teacher == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp");

            return;
        }

        // Actual teacher ID from teacher table
        int teacherId = teacher.getId();

        String action = request.getParameter("action");

        if (action == null || action.isEmpty()) {
            action = "dashboard";
        }


        // =================================================
        // DASHBOARD
        // =================================================

        if ("dashboard".equals(action)) {

            request.setAttribute(
                    "teacher",
                    teacher);

            request.setAttribute(
                    "courseCount",
                    teacherDAO.getCourseCount(teacherId));

            request.setAttribute(
                    "studentCount",
                    teacherDAO.getStudentCount(teacherId));

            request.setAttribute(
                    "assignmentCount",
                    teacherDAO.getAssignmentCount(teacherId));

            request.getRequestDispatcher(
                    "/teacher/dashboard.jsp")
                    .forward(request, response);
        }


        // =================================================
        // MY COURSES
        // =================================================

        else if ("courses".equals(action)) {

            request.setAttribute(
                    "teacher",
                    teacher);

            request.setAttribute(
                    "courses",
                    teacherDAO.getCourses(teacherId));

            request.getRequestDispatcher(
                    "/teacher/my-courses.jsp")
                    .forward(request, response);
        }


        // =================================================
        // STUDENTS
        // =================================================

        else if ("students".equals(action)) {

            request.setAttribute(
                    "teacher",
                    teacher);

            request.setAttribute(
                    "students",
                    teacherDAO.getStudents(teacherId));

            request.getRequestDispatcher(
                    "/teacher/students.jsp")
                    .forward(request, response);
        }


        // =================================================
        // ATTENDANCE
        // =================================================

        else if ("attendance".equals(action)) {

            request.setAttribute(
                    "teacher",
                    teacher);

            request.setAttribute(
                    "courses",
                    teacherDAO.getCourses(teacherId));

            request.setAttribute(
                    "students",
                    teacherDAO.getStudents(teacherId));

            request.getRequestDispatcher(
                    "/teacher/attendance.jsp")
                    .forward(request, response);
        }


        // =================================================
        // STUDENT PROGRESS
        // =================================================

        else if ("progress".equals(action)) {

            request.setAttribute(
                    "teacher",
                    teacher);

            request.setAttribute(
                    "progress",
                    teacherDAO.getStudentProgress(teacherId));

            request.getRequestDispatcher(
                    "/teacher/student-progress.jsp")
                    .forward(request, response);
        }


        // =================================================
        // PERFORMANCE
        // =================================================

        else if ("performance".equals(action)) {

            request.setAttribute(
                    "teacher",
                    teacher);

            request.setAttribute(
                    "performance",
                    teacherDAO.getPerformance(teacherId));

            request.getRequestDispatcher(
                    "/teacher/performance.jsp")
                    .forward(request, response);
        }


        // =================================================
        // PROFILE
        // =================================================

        else if ("profile".equals(action)) {

            request.setAttribute(
                    "teacher",
                    teacher);

            request.getRequestDispatcher(
                    "/teacher/profile.jsp")
                    .forward(request, response);
        }


        // =================================================
        // NOTIFICATIONS
        // =================================================

        else if ("notifications".equals(action)) {

            request.setAttribute(
                    "teacher",
                    teacher);

            request.setAttribute(
                    "assignments",
                    teacherDAO.getRecentAssignments(teacherId));

            request.getRequestDispatcher(
                    "/teacher/notifications.jsp")
                    .forward(request, response);
        }


        // =================================================
        // CLASS DETAILS
        // =================================================

        else if ("class-details".equals(action)) {

            request.setAttribute(
                    "teacher",
                    teacher);

            request.setAttribute(
                    "courses",
                    teacherDAO.getCourses(teacherId));

            request.getRequestDispatcher(
                    "/teacher/class-details.jsp")
                    .forward(request, response);
        }
    }


    // =====================================================
    // POST
    // =====================================================

    @Override
    protected void doPost(HttpServletRequest request,
                           HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // =================================================
        // TEACHER LOGIN CHECK
        // =================================================

        if (session == null ||
            session.getAttribute("userId") == null ||
            !"TEACHER".equals(session.getAttribute("role"))) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp");

            return;
        }

        int userId =
                (Integer) session.getAttribute("userId");

        Teacher teacher =
                teacherDAO.getTeacherByUserId(userId);

        if (teacher == null) {

            response.sendRedirect(
                    request.getContextPath() + "/login.jsp");

            return;
        }


        String action =
                request.getParameter("action");


        // =================================================
        // MARK ATTENDANCE
        // =================================================

        if ("markAttendance".equals(action)) {

            int studentId =
                    Integer.parseInt(
                            request.getParameter("studentId"));

            int courseId =
                    Integer.parseInt(
                            request.getParameter("courseId"));

            String date =
                    request.getParameter("date");

            String status =
                    request.getParameter("status");

            String remarks =
                    request.getParameter("remarks");


            boolean success =
                    teacherDAO.markAttendance(
                            studentId,
                            courseId,
                            teacher.getId(),
                            date,
                            status,
                            remarks
                    );


            if (success) {

                response.sendRedirect(
                        request.getContextPath()
                        + "/TeacherServlet?action=attendance&success=true"
                );

            } else {

                response.sendRedirect(
                        request.getContextPath()
                        + "/TeacherServlet?action=attendance&error=true"
                );
            }
        }
    }
}