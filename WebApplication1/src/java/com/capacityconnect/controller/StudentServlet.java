package com.capacityconnect.controller;

import com.capacityconnect.dao.StudentDAO;
import com.capacityconnect.model.Student;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;
import java.util.Map;

/**
 * Controller servlet for Student interactions and Student Dashboard.
 */
@WebServlet("/StudentServlet")
public class StudentServlet extends HttpServlet {

    private StudentDAO studentDAO;

    @Override
    public void init() {
        studentDAO = new StudentDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        handleRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        handleRequest(request, response);
    }

    private void handleRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);

        // =====================================================
        // AUTHENTICATION & ROLE CHECK
        // =====================================================
        if (session == null || session.getAttribute("userId") == null
                || !"STUDENT".equalsIgnoreCase((String) session.getAttribute("role"))) {
            response.sendRedirect(request.getContextPath() + "/login.jsp");
            return;
        }

        int studentId = (Integer) session.getAttribute("userId");
        String action = request.getParameter("action");
        if (action == null || action.trim().isEmpty()) {
            action = "dashboard";
        }

        switch (action) {
            case "courses":
                showCourses(request, response, studentId);
                break;

            case "learning":
                showLearning(request, response, studentId);
                break;

            case "progress":
                showProgress(request, response, studentId);
                break;

            case "resources":
                showResources(request, response, studentId);
                break;

            case "certificates":
                showCertificates(request, response, studentId);
                break;

            case "notifications":
                showNotifications(request, response, studentId);
                break;

            case "profile":
                showProfile(request, response, studentId);
                break;

            case "updateProfile":
                handleUpdateProfile(request, response, studentId);
                break;

            case "submitAssignment":
                handleSubmitAssignment(request, response, studentId);
                break;

            case "updateProgress":
                handleUpdateProgress(request, response, studentId);
                break;

            case "dashboard":
            default:
                showDashboard(request, response, studentId);
                break;
        }
    }

    // =====================================================
    // SHOW STUDENT DASHBOARD
    // =====================================================
    private void showDashboard(HttpServletRequest request, HttpServletResponse response, int studentId)
            throws ServletException, IOException {

        Student student = getStudentOrFallback(request, studentId);
        Map<String, Object> stats = studentDAO.getDashboardStats(studentId);
        List<Map<String, Object>> enrolledCourses = studentDAO.getEnrolledCourses(studentId);
        List<Map<String, Object>> assignments = studentDAO.getStudentAssignments(studentId);
        List<Map<String, Object>> attendance = studentDAO.getStudentAttendance(studentId);
        List<Map<String, Object>> certificates = studentDAO.getStudentCertificates(studentId);
        List<Map<String, Object>> resources = studentDAO.getRecentResources(studentId);
        List<Map<String, Object>> videos = studentDAO.getCourseVideos(studentId);

        request.setAttribute("student", student);
        request.setAttribute("stats", stats);
        request.setAttribute("enrolledCourses", enrolledCourses);
        request.setAttribute("assignments", assignments);
        request.setAttribute("attendance", attendance);
        request.setAttribute("certificates", certificates);
        request.setAttribute("resources", resources);
        request.setAttribute("videos", videos);

        request.getRequestDispatcher("/user/s-dashboard.jsp").forward(request, response);
    }

    // =====================================================
    // SHOW MY COURSES
    // =====================================================
    private void showCourses(HttpServletRequest request, HttpServletResponse response, int studentId)
            throws ServletException, IOException {

        Student student = getStudentOrFallback(request, studentId);
        Map<String, Object> stats = studentDAO.getDashboardStats(studentId);
        List<Map<String, Object>> enrolledCourses = studentDAO.getEnrolledCourses(studentId);

        request.setAttribute("student", student);
        request.setAttribute("stats", stats);
        request.setAttribute("enrolledCourses", enrolledCourses);

        request.getRequestDispatcher("/user/my-courses.jsp").forward(request, response);
    }

    // =====================================================
    // SHOW COURSE LEARNING (VIRTUAL CLASSROOM)
    // =====================================================
    private void showLearning(HttpServletRequest request, HttpServletResponse response, int studentId)
            throws ServletException, IOException {

        Student student = getStudentOrFallback(request, studentId);
        Map<String, Object> stats = studentDAO.getDashboardStats(studentId);
        List<Map<String, Object>> enrolledCourses = studentDAO.getEnrolledCourses(studentId);

        int selectedCourseId = -1;
        String courseParam = request.getParameter("courseId");
        if (courseParam != null && !courseParam.trim().isEmpty()) {
            try {
                selectedCourseId = Integer.parseInt(courseParam.trim());
            } catch (NumberFormatException ignored) {}
        } else if (!enrolledCourses.isEmpty()) {
            selectedCourseId = (Integer) enrolledCourses.get(0).get("courseId");
        }

        List<Map<String, Object>> courseVideos;
        List<Map<String, Object>> courseResources;
        if (selectedCourseId > 0) {
            courseVideos = studentDAO.getVideosForCourse(selectedCourseId);
            courseResources = studentDAO.getResourcesForCourse(selectedCourseId);
        } else {
            courseVideos = studentDAO.getCourseVideos(studentId);
            courseResources = studentDAO.getRecentResources(studentId);
        }

        request.setAttribute("student", student);
        request.setAttribute("stats", stats);
        request.setAttribute("enrolledCourses", enrolledCourses);
        request.setAttribute("selectedCourseId", selectedCourseId);
        request.setAttribute("courseVideos", courseVideos);
        request.setAttribute("courseResources", courseResources);

        request.getRequestDispatcher("/user/course-learning.jsp").forward(request, response);
    }

    // =====================================================
    // SHOW PROGRESS & ATTENDANCE
    // =====================================================
    private void showProgress(HttpServletRequest request, HttpServletResponse response, int studentId)
            throws ServletException, IOException {

        Student student = getStudentOrFallback(request, studentId);
        Map<String, Object> stats = studentDAO.getDashboardStats(studentId);
        List<Map<String, Object>> enrolledCourses = studentDAO.getEnrolledCourses(studentId);
        List<Map<String, Object>> attendanceList = studentDAO.getAllStudentAttendance(studentId);

        request.setAttribute("student", student);
        request.setAttribute("stats", stats);
        request.setAttribute("enrolledCourses", enrolledCourses);
        request.setAttribute("attendanceList", attendanceList);

        request.getRequestDispatcher("/user/progress.jsp").forward(request, response);
    }

    // =====================================================
    // SHOW STUDY MATERIALS & RESOURCES
    // =====================================================
    private void showResources(HttpServletRequest request, HttpServletResponse response, int studentId)
            throws ServletException, IOException {

        Student student = getStudentOrFallback(request, studentId);
        Map<String, Object> stats = studentDAO.getDashboardStats(studentId);
        List<Map<String, Object>> enrolledCourses = studentDAO.getEnrolledCourses(studentId);
        List<Map<String, Object>> resources = studentDAO.getAllStudentResources(studentId);

        request.setAttribute("student", student);
        request.setAttribute("stats", stats);
        request.setAttribute("enrolledCourses", enrolledCourses);
        request.setAttribute("resources", resources);

        request.getRequestDispatcher("/user/my-resources.jsp").forward(request, response);
    }

    // =====================================================
    // SHOW CERTIFICATES
    // =====================================================
    private void showCertificates(HttpServletRequest request, HttpServletResponse response, int studentId)
            throws ServletException, IOException {

        Student student = getStudentOrFallback(request, studentId);
        Map<String, Object> stats = studentDAO.getDashboardStats(studentId);
        List<Map<String, Object>> enrolledCourses = studentDAO.getEnrolledCourses(studentId);
        List<Map<String, Object>> certificates = studentDAO.getStudentCertificates(studentId);

        request.setAttribute("student", student);
        request.setAttribute("stats", stats);
        request.setAttribute("enrolledCourses", enrolledCourses);
        request.setAttribute("certificates", certificates);

        request.getRequestDispatcher("/user/certificates.jsp").forward(request, response);
    }

    // =====================================================
    // SHOW NOTIFICATIONS
    // =====================================================
    private void showNotifications(HttpServletRequest request, HttpServletResponse response, int studentId)
            throws ServletException, IOException {

        Student student = getStudentOrFallback(request, studentId);
        Map<String, Object> stats = studentDAO.getDashboardStats(studentId);
        List<Map<String, Object>> notifications = studentDAO.getStudentNotifications(studentId);

        request.setAttribute("student", student);
        request.setAttribute("stats", stats);
        request.setAttribute("notifications", notifications);

        request.getRequestDispatcher("/user/notifications.jsp").forward(request, response);
    }

    // =====================================================
    // SHOW STUDENT PROFILE
    // =====================================================
    private void showProfile(HttpServletRequest request, HttpServletResponse response, int studentId)
            throws ServletException, IOException {

        Student student = getStudentOrFallback(request, studentId);
        Map<String, Object> stats = studentDAO.getDashboardStats(studentId);
        List<Map<String, Object>> enrolledCourses = studentDAO.getEnrolledCourses(studentId);

        request.setAttribute("student", student);
        request.setAttribute("stats", stats);
        request.setAttribute("enrolledCourses", enrolledCourses);

        request.getRequestDispatcher("/user/profile.jsp").forward(request, response);
    }

    // =====================================================
    // HANDLE PROFILE UPDATE
    // =====================================================
    private void handleUpdateProfile(HttpServletRequest request, HttpServletResponse response, int studentId)
            throws IOException {
        String name = request.getParameter("name");
        String password = request.getParameter("password");

        if (name != null && !name.trim().isEmpty()) {
            boolean success = studentDAO.updateStudentProfile(studentId, name.trim(), password);
            if (success) {
                HttpSession session = request.getSession(false);
                if (session != null) {
                    session.setAttribute("userName", name.trim());
                }
                response.sendRedirect(request.getContextPath() + "/StudentServlet?action=profile&status=profileUpdated");
                return;
            }
        }
        response.sendRedirect(request.getContextPath() + "/StudentServlet?action=profile&status=updateFailed");
    }

    // =====================================================
    // HELPER: GET STUDENT OR FALLBACK FROM SESSION
    // =====================================================
    private Student getStudentOrFallback(HttpServletRequest request, int studentId) {
        Student student = studentDAO.getStudentById(studentId);
        if (student == null) {
            student = new Student();
            student.setId(studentId);
            HttpSession session = request.getSession(false);
            if (session != null) {
                student.setName((String) session.getAttribute("userName"));
                student.setEmail((String) session.getAttribute("email"));
            }
        }
        return student;
    }

    // =====================================================
    // HANDLE ASSIGNMENT SUBMISSION
    // =====================================================
    private void handleSubmitAssignment(HttpServletRequest request, HttpServletResponse response, int studentId)
            throws IOException {
        try {
            int assignmentId = Integer.parseInt(request.getParameter("assignmentId"));
            String submissionFile = request.getParameter("submissionFile");

            if (submissionFile != null && !submissionFile.trim().isEmpty()) {
                boolean success = studentDAO.submitAssignment(assignmentId, studentId, submissionFile.trim());
                if (success) {
                    response.sendRedirect(request.getContextPath() + "/StudentServlet?action=dashboard&success=submitted#assignments");
                    return;
                }
            }
            response.sendRedirect(request.getContextPath() + "/StudentServlet?action=dashboard&error=failed#assignments");
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/StudentServlet?action=dashboard&error=invalid#assignments");
        }
    }

    // =====================================================
    // HANDLE PROGRESS UPDATE
    // =====================================================
    private void handleUpdateProgress(HttpServletRequest request, HttpServletResponse response, int studentId)
            throws IOException {
        try {
            int courseId = Integer.parseInt(request.getParameter("courseId"));
            double progress = Double.parseDouble(request.getParameter("progress"));
            progress = Math.min(100.0, Math.max(0.0, progress));

            studentDAO.updateProgress(studentId, courseId, progress);

            String redirectPage = request.getParameter("redirectPage");
            if ("learning".equalsIgnoreCase(redirectPage)) {
                response.sendRedirect(request.getContextPath() + "/StudentServlet?action=learning&courseId=" + courseId + "&success=progressUpdated");
            } else if ("courses".equalsIgnoreCase(redirectPage)) {
                response.sendRedirect(request.getContextPath() + "/StudentServlet?action=courses&success=progressUpdated");
            } else {
                response.sendRedirect(request.getContextPath() + "/StudentServlet?action=dashboard&success=progressUpdated#courses");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/StudentServlet?action=dashboard&error=progressError#courses");
        }
    }
}
