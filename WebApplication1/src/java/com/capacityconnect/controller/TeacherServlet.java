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

    // ==========================================
    // GET
    // ==========================================
    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // Check login
        if (session == null || session.getAttribute("userId") == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Check role
        String role = (String) session.getAttribute("role");
        if (role == null || !role.equals("TEACHER")) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        // Get user ID
        int userId;
        try {
            userId = (Integer) session.getAttribute("userId");
        } catch (Exception e) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        Teacher teacher = teacherDAO.getTeacherByUserId(userId);
        if (teacher == null) {
            request.setAttribute("error", "Teacher profile not found.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        String action = request.getParameter("action");
        if (action == null || action.isEmpty()) {
            action = "dashboard";
        }

        switch (action) {
            case "dashboard":
                request.setAttribute("teacher", teacher);
                request.setAttribute("courseCount", teacherDAO.getCourseCount(teacher.getId()));
                request.setAttribute("studentCount", teacherDAO.getStudentCount(teacher.getId()));
                request.setAttribute("assignmentCount", teacherDAO.getAssignmentCount(teacher.getId()));
                request.getRequestDispatcher("/teacher/dashboard.jsp").forward(request, response);
                break;

            case "courses":
                request.setAttribute("teacher", teacher);
                request.setAttribute("courses", teacherDAO.getCourses(teacher.getId()));
                request.getRequestDispatcher("/teacher/my-courses.jsp").forward(request, response);
                break;

            case "students":
                request.setAttribute("teacher", teacher);
                request.setAttribute("students", teacherDAO.getStudents(teacher.getId()));
                request.getRequestDispatcher("/teacher/students.jsp").forward(request, response);
                break;

            case "attendance":
                request.setAttribute("teacher", teacher);
                request.setAttribute("courses", teacherDAO.getCourses(teacher.getId()));
                request.setAttribute("students", teacherDAO.getStudents(teacher.getId()));
                request.getRequestDispatcher("/teacher/attendance.jsp").forward(request, response);
                break;

            case "progress":
                request.setAttribute("teacher", teacher);
                request.setAttribute("progress", teacherDAO.getStudentProgress(teacher.getId()));
                request.getRequestDispatcher("/teacher/student-progress.jsp").forward(request, response);
                break;

            case "performance":
                request.setAttribute("teacher", teacher);
                request.setAttribute("performance", teacherDAO.getPerformance(teacher.getId()));
                request.getRequestDispatcher("/teacher/performance.jsp").forward(request, response);
                break;

            case "notifications":
                request.setAttribute("teacher", teacher);
                request.setAttribute("assignments", teacherDAO.getRecentAssignments(teacher.getId()));
                request.getRequestDispatcher("/teacher/notifications.jsp").forward(request, response);
                break;

            case "class-details":
                request.setAttribute("teacher", teacher);
                request.setAttribute("courses", teacherDAO.getCourses(teacher.getId()));
                request.getRequestDispatcher("/teacher/class-details.jsp").forward(request, response);
                break;

            case "profile":
                request.setAttribute("teacher", teacher);
                request.getRequestDispatcher("/teacher/profile.jsp").forward(request, response);
                break;

            default:
                response.sendRedirect(request.getContextPath() + "/TeacherServlet?action=dashboard");
                break;
        }
    }

    // ==========================================
    // POST
    // ==========================================
    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        if (session == null || session.getAttribute("userId") == null ||
            !"TEACHER".equals(session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        int userId = (Integer) session.getAttribute("userId");
        Teacher teacher = teacherDAO.getTeacherByUserId(userId);

        if (teacher == null) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        String action = request.getParameter("action");

        if ("markAttendance".equals(action)) {
            try {
                int studentId = Integer.parseInt(request.getParameter("studentId"));
                int courseId = Integer.parseInt(request.getParameter("courseId"));
                String date = request.getParameter("date");
                String status = request.getParameter("status");
                String remarks = request.getParameter("remarks");

                boolean success = teacherDAO.markAttendance(
                        studentId,
                        courseId,
                        teacher.getId(),
                        date,
                        status,
                        remarks
                );

                if (success) {
                    response.sendRedirect(request.getContextPath() + "/TeacherServlet?action=attendance&success=true");
                } else {
                    response.sendRedirect(request.getContextPath() + "/TeacherServlet?action=attendance&error=true");
                }
            } catch (Exception e) {
                e.printStackTrace();
                response.sendRedirect(request.getContextPath() + "/TeacherServlet?action=attendance&error=true");
            }
        } else {
            doGet(request, response);
        }
    }
}