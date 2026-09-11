package com.capacityconnect.controller;

import com.capacityconnect.db.DBConnection;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.sql.*;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@WebServlet("/AdminServlet")
public class AdminServlet extends HttpServlet {


    /* =========================================
       ADMIN SECURITY CHECK
    ========================================= */

    private boolean isAdmin(HttpServletRequest request) {

        HttpSession session =
                request.getSession(false);

        if (session == null) {
            return false;
        }

        return "ADMIN".equals(
                String.valueOf(
                        session.getAttribute("role")
                )
        );
    }


    /* =========================================
       GET
    ========================================= */

    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {


        if (!isAdmin(request)) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/login.jsp"
            );

            return;
        }


        String action =
                request.getParameter("action");


        if (action == null) {
            action = "dashboard";
        }


        try {

            switch (action) {

                case "dashboard":
                    dashboard(request, response);
                    break;

                case "users":
                    users(request, response);
                    break;

                case "teachers":
                    teachers(request, response);
                    break;

                case "courses":
                    courses(request, response);
                    break;

                case "add-course":
                    showAddCourse(request, response);
                    break;

                case "edit-course":
                    showEditCourse(request, response);
                    break;

                case "delete-course":
                    deleteCourse(request, response);
                    break;

                case "resources":
                    resources(request, response);
                    break;

                case "add-resource":
                    showAddResource(request, response);
                    break;

                case "delete-resource":
                    deleteResource(request, response);
                    break;

                case "classes":
                    classes(request, response);
                    break;

                case "enrollments":
                    enrollment(request, response);
                    break;

                case "events":
                    events(request, response);
                    break;

                case "delete-event":
                    deleteEvent(request, response);
                    break;

                case "reports":
                    reports(request, response);
                    break;

                case "settings":
                    request.getRequestDispatcher(
                            "/admin/settings.jsp"
                    ).forward(request, response);
                    break;

                default:
                    dashboard(request, response);
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Admin panel error."
            );
        }
    }


    /* =========================================
       POST
    ========================================= */

    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {


        if (!isAdmin(request)) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/login.jsp"
            );

            return;
        }


        String action =
                request.getParameter("action");


        try {

            if ("add-course".equals(action)) {

                addCourse(request, response);

            }

            else if ("edit-course".equals(action)) {

                updateCourse(request, response);

            }

            else if ("add-resource".equals(action)) {

                addResource(request, response);

            }

            else if ("add-event".equals(action)) {

                addEvent(request, response);

            }

            else {

                response.sendRedirect(
                        request.getContextPath()
                        + "/AdminServlet?action=dashboard"
                );
            }

        } catch (Exception e) {

            e.printStackTrace();

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to process admin request."
            );
        }
    }


    /* =========================================
       DASHBOARD
    ========================================= */

    private void dashboard(
            HttpServletRequest request,
            HttpServletResponse response)
            throws Exception {


        try (Connection con =
                     DBConnection.getConnection()) {


            request.setAttribute(
                    "totalUsers",
                    getCount(con, "SELECT COUNT(*) FROM users")
            );


            request.setAttribute(
                    "totalTeachers",
                    getCount(con,
                            "SELECT COUNT(*) FROM teachers")
            );


            request.setAttribute(
                    "totalStudents",
                    getCount(con,
                            "SELECT COUNT(*) FROM students")
            );


            request.setAttribute(
                    "totalCourses",
                    getCount(con,
                            "SELECT COUNT(*) FROM courses")
            );


            request.setAttribute(
                    "totalEnrollments",
                    getCount(con,
                            "SELECT COUNT(*) FROM enrollments")
            );
        }


        request.getRequestDispatcher(
                "/admin/dashboard.jsp"
        ).forward(request, response);
    }


    /* =========================================
       USERS
    ========================================= */

    private void users(
            HttpServletRequest request,
            HttpServletResponse response)
            throws Exception {


        List<Map<String,Object>> list =
                new ArrayList<>();


        String sql =
                "SELECT id, name, email, role, created_at " +
                "FROM users ORDER BY id DESC";


        try (Connection con =
                     DBConnection.getConnection();
             PreparedStatement ps =
                     con.prepareStatement(sql);
             ResultSet rs =
                     ps.executeQuery()) {


            while (rs.next()) {

                Map<String,Object> map =
                        new HashMap<>();

                map.put("id", rs.getInt("id"));
                map.put("name", rs.getString("name"));
                map.put("email", rs.getString("email"));
                map.put("role", rs.getString("role"));
                map.put("created_at",
                        rs.getTimestamp("created_at"));

                list.add(map);
            }
        }


        request.setAttribute("users", list);


        request.getRequestDispatcher(
                "/admin/users.jsp"
        ).forward(request, response);
    }


    /* =========================================
       TEACHERS
    ========================================= */

    private void teachers(
            HttpServletRequest request,
            HttpServletResponse response)
            throws Exception {


        List<Map<String,Object>> list =
                new ArrayList<>();


        String sql =
                "SELECT t.id, u.name, u.email, " +
                "t.qualification, t.specialization, t.phone " +
                "FROM teachers t " +
                "INNER JOIN users u ON t.user_id = u.id " +
                "ORDER BY t.id DESC";


        try (Connection con =
                     DBConnection.getConnection();
             PreparedStatement ps =
                     con.prepareStatement(sql);
             ResultSet rs =
                     ps.executeQuery()) {


            while (rs.next()) {

                Map<String,Object> map =
                        new HashMap<>();

                map.put("id", rs.getInt("id"));
                map.put("name", rs.getString("name"));
                map.put("email", rs.getString("email"));
                map.put("qualification",
                        rs.getString("qualification"));
                map.put("specialization",
                        rs.getString("specialization"));
                map.put("phone",
                        rs.getString("phone"));

                list.add(map);
            }
        }


        request.setAttribute(
                "teacherList",
                list
        );


        request.getRequestDispatcher(
                "/admin/teachers.jsp"
        ).forward(request, response);
    }


    /* =========================================
       COURSES
    ========================================= */

    private void courses(
            HttpServletRequest request,
            HttpServletResponse response)
            throws Exception {


        List<Map<String,Object>> list =
                getCourses();


        request.setAttribute(
                "courses",
                list
        );


        request.getRequestDispatcher(
                "/admin/courses.jsp"
        ).forward(request, response);
    }


    private List<Map<String,Object>> getCourses()
            throws Exception {


        List<Map<String,Object>> list =
                new ArrayList<>();


        String sql =
                "SELECT c.*, " +
                "u.name AS teacher_name " +
                "FROM courses c " +
                "LEFT JOIN teachers t " +
                "ON c.teacher_id = t.id " +
                "LEFT JOIN users u " +
                "ON t.user_id = u.id " +
                "ORDER BY c.id DESC";


        try (Connection con =
                     DBConnection.getConnection();
             PreparedStatement ps =
                     con.prepareStatement(sql);
             ResultSet rs =
                     ps.executeQuery()) {


            while (rs.next()) {
            Map<String,Object> map =
                        new HashMap<>();

                map.put("id", rs.getInt("id"));
                map.put("title", rs.getString("title"));
                map.put("category",
                        rs.getString("category"));
                map.put("description",
                        rs.getString("description"));
                map.put("level",
                        rs.getString("level"));
                map.put("duration",
                        rs.getString("duration"));
                map.put("price",
                        rs.getBigDecimal("price"));
                map.put("thumbnail",
                        rs.getString("thumbnail"));
                map.put("teacher_name",
                        rs.getString("teacher_name"));
                map.put("status",
                        rs.getString("status"));

                list.add(map);
            }
        }


        return list;
    }


    /* =========================================
       SHOW ADD COURSE
    ========================================= */

    private void showAddCourse(
            HttpServletRequest request,
            HttpServletResponse response)
            throws Exception {


        request.setAttribute(
                "teachers",
                getTeacherOptions()
        );


        request.getRequestDispatcher(
                "/admin/add-course.jsp"
        ).forward(request, response);
    }


    /* =========================================
       TEACHER OPTIONS
    ========================================= */

    private List<Map<String,Object>> getTeacherOptions()
            throws Exception {


        List<Map<String,Object>> list =
                new ArrayList<>();


        String sql =
                "SELECT t.id, u.name " +
                "FROM teachers t " +
                "INNER JOIN users u " +
                "ON t.user_id = u.id " +
                "ORDER BY u.name";


        try (Connection con =
                     DBConnection.getConnection();
             PreparedStatement ps =
                     con.prepareStatement(sql);
             ResultSet rs =
                     ps.executeQuery()) {


            while (rs.next()) {

                Map<String,Object> map =
                        new HashMap<>();

                map.put("id", rs.getInt("id"));

                map.put("name",
                        rs.getString("name"));

                list.add(map);
            }
        }


        return list;
    }


    /* =========================================
       ADD COURSE
    ========================================= */

    private void addCourse(
            HttpServletRequest request,
            HttpServletResponse response)
            throws Exception {


        String sql =
                "INSERT INTO courses " +
                "(title, category, description, level, " +
                "duration, price, thumbnail, teacher_id, status) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";


        try (Connection con =
                     DBConnection.getConnection();
             PreparedStatement ps =
                     con.prepareStatement(sql)) {


            ps.setString(
                    1,
                    request.getParameter("title")
            );

            ps.setString(
                    2,
                    request.getParameter("category")
            );

            ps.setString(
                    3,
                    request.getParameter("description")
            );

            ps.setString(
                    4,
                    request.getParameter("level")
            );

            ps.setString(
                    5,
                    request.getParameter("duration")
            );


            String price =
                    request.getParameter("price");


            ps.setBigDecimal(
                    6,
                    new java.math.BigDecimal(
                            price == null ||
                            price.isEmpty()
                            ? "0"
                            : price
                    )
            );


            ps.setString(
                    7,
                    request.getParameter("thumbnail")
            );


            String teacherId =
                    request.getParameter("teacher_id");


            if (teacherId == null ||
                teacherId.isEmpty()) {

                ps.setNull(
                        8,
                        Types.INTEGER
                );

            } else {

                ps.setInt(
                        8,
                        Integer.parseInt(teacherId)
                );
            }


            ps.setString(
                    9,
                    request.getParameter("status")
            );


            ps.executeUpdate();
        }


        response.sendRedirect(
                request.getContextPath()
                + "/AdminServlet?action=courses"
        );
    }


    /* =========================================
       SHOW EDIT COURSE
    ========================================= */

    private void showEditCourse(
            HttpServletRequest request,
            HttpServletResponse response)
            throws Exception {


        int id =
                Integer.parseInt(
                        request.getParameter("id")
                );


        Map<String,Object> course =
                getCourse(id);


        request.setAttribute(
                "course",
                course
        );


        request.getRequestDispatcher(
                "/admin/edit-course.jsp"
        ).forward(request, response);
    }


    private Map<String,Object> getCourse(int id)
            throws Exception {


        Map<String,Object> map =
                new HashMap<>();


        String sql =
                "SELECT * FROM courses WHERE id = ?";


        try (Connection con =
                     DBConnection.getConnection();
             PreparedStatement ps =
                     con.prepareStatement(sql)) {


            ps.setInt(1, id);


            try (ResultSet rs =
                         ps.executeQuery()) {


                if (rs.next()) {

                    map.put("id",
                            rs.getInt("id"));

                    map.put("title",
                            rs.getString("title"));

                    map.put("category",
                            rs.getString("category"));

                    map.put("description",
                            rs.getString("description"));

                    map.put("level",
                            rs.getString("level"));

                    map.put("duration",
                            rs.getString("duration"));

                    map.put("price",
                            rs.getBigDecimal("price"));

                    map.put("thumbnail",
                            rs.getString("thumbnail"));

                    map.put("status",
                            rs.getString("status"));
                }
            }
        }


        return map;
    }


    /* =========================================
       UPDATE COURSE
    ========================================= */

    private void updateCourse(
            HttpServletRequest request,
            HttpServletResponse response)
            throws Exception {


        String sql =
                "UPDATE courses SET " +
                "title=?, category=?, description=?, " +
                "level=?, duration=?, price=?, " +
                "thumbnail=?, status=? " +
                "WHERE id=?";


        try (Connection con =
                     DBConnection.getConnection();
             PreparedStatement ps =
                     con.prepareStatement(sql)) {


            ps.setString(
                    1,
                    request.getParameter("title")
            );

            ps.setString(
                    2,
                    request.getParameter("category")
            );

            ps.setString(
                    3,
                    request.getParameter("description")
            );

            ps.setString(
                    4,
                    request.getParameter("level")
            );

            ps.setString(
                    5,
                    request.getParameter("duration")
            );


            String price =
                    request.getParameter("price");


            ps.setBigDecimal(
                    6,
                    new java.math.BigDecimal(
                            price == null ||
                            price.isEmpty()
                            ? "0"
                            : price
                    )
            );


            ps.setString(
                    7,
                    request.getParameter("thumbnail")
            );

            ps.setString(
                    8,
                    request.getParameter("status")
            );

            ps.setInt(
                    9,
                    Integer.parseInt(
                            request.getParameter("id")
                    )
            );


            ps.executeUpdate();
        }


        response.sendRedirect(
                request.getContextPath()
                + "/AdminServlet?action=courses"
        );
    }


    /* =========================================
       DELETE COURSE
    ========================================= */

    private void deleteCourse(
            HttpServletRequest request,
            HttpServletResponse response)
            throws Exception {


        int id =
                Integer.parseInt(
                        request.getParameter("id")
                );


        String sql =
                "DELETE FROM courses WHERE id = ?";


        try (Connection con =
                     DBConnection.getConnection();
             PreparedStatement ps =
                     con.prepareStatement(sql)) {


            ps.setInt(1, id);

            ps.executeUpdate();
        }


        response.sendRedirect(
                request.getContextPath()
                + "/AdminServlet?action=courses"
        );
    }


    /* =========================================
       RESOURCES
    ========================================= */

    private void resources(
            HttpServletRequest request,
            HttpServletResponse response)
            throws Exception {


        List<Map<String,Object>> list =
                new ArrayList<>();


        String sql =
                "SELECT r.*, " +
                "c.title AS course_title, " +
                "u.name AS uploaded_name " +
                "FROM resources r " +
                "LEFT JOIN courses c " +
                "ON r.course_id = c.id " +
                "LEFT JOIN users u " +
                "ON r.uploaded_by = u.id " +
                "ORDER BY r.id DESC";


        try (Connection con =
                     DBConnection.getConnection();
             PreparedStatement ps =
                     con.prepareStatement(sql);
             ResultSet rs =
                     ps.executeQuery()) {


            while (rs.next()) {

                Map<String,Object> map =
                        new HashMap<>();

                map.put("id",
                        rs.getInt("id"));

                map.put("title",
                        rs.getString("title"));

                map.put("course_title",
                        rs.getString("course_title"));

                map.put("resource_type",
                        rs.getString("resource_type"));

                map.put("uploaded_name",
                        rs.getString("uploaded_name"));

                list.add(map);
            }
        }


        request.setAttribute(
                "resources",
                list
        );


        request.getRequestDispatcher(
                "/admin/resources.jsp"
        ).forward(request, response);
    }


    /* =========================================
       SHOW ADD RESOURCE
    ========================================= */

    private void showAddResource(
            HttpServletRequest request,
            HttpServletResponse response)
            throws Exception {


        request.setAttribute(
                "courses",
                getCourses()
        );


        request.getRequestDispatcher(
                "/admin/add-resource.jsp"
        ).forward(request, response);
    }


    /* =========================================
       ADD RESOURCE
    ========================================= */

    private void addResource(
            HttpServletRequest request,
            HttpServletResponse response)
            throws Exception {


        String sql =
                "INSERT INTO resources " +
                "(course_id, title, description, " +
                "resource_type, resource_url, uploaded_by) " +
                "VALUES (?, ?, ?, ?, ?, ?)";


        HttpSession session =
                request.getSession(false);


        Object userId =
                session.getAttribute("userId");


        try (Connection con =
                     DBConnection.getConnection();
             PreparedStatement ps =
                     con.prepareStatement(sql)) {


            String courseId =
                    request.getParameter("course_id");


            if (courseId == null ||
                courseId.isEmpty()) {

                ps.setNull(
                        1,
                        Types.INTEGER
                );

            } else {

                ps.setInt(
                        1,
                        Integer.parseInt(courseId)
                );
            }


            ps.setString(
                    2,
                    request.getParameter("title")
            );

            ps.setString(
                    3,
                    request.getParameter("description")
            );

            ps.setString(
                    4,
                    request.getParameter("resource_type")
            );

            ps.setString(
                    5,
                    request.getParameter("resource_url")
            );


            if (userId == null) {

                ps.setNull(
                        6,
                        Types.INTEGER
                );

            } else {

                ps.setInt(
                        6,
                        Integer.parseInt(
                                userId.toString()
                        )
                );
            }


            ps.executeUpdate();
        }


        response.sendRedirect(
                request.getContextPath()
                + "/AdminServlet?action=resources"
        );
    }


    /* =========================================
       DELETE RESOURCE
    ========================================= */

    private void deleteResource(
            HttpServletRequest request,
            HttpServletResponse response)
            throws Exception {


        int id =
                Integer.parseInt(
                        request.getParameter("id")
                );


        try (Connection con =
                     DBConnection.getConnection();
             PreparedStatement ps =
                     con.prepareStatement(
                             "DELETE FROM resources WHERE id=?"
                     )) {


            ps.setInt(1, id);

            ps.executeUpdate();
        }


        response.sendRedirect(
                request.getContextPath()
                + "/AdminServlet?action=resources"
        );
    }


    /* =========================================
       CLASSES
    ========================================= */

    private void classes(
            HttpServletRequest request,
            HttpServletResponse response)
            throws Exception {


        List<Map<String,Object>> list =
                new ArrayList<>();


        String sql =
                "SELECT c.id, c.title, c.level, c.status, " +
                "u.name AS teacher_name, " +
                "COUNT(e.id) AS student_count " +
                "FROM courses c " +
                "LEFT JOIN teachers t " +
                "ON c.teacher_id = t.id " +
                "LEFT JOIN users u " +
                "ON t.user_id = u.id " +
                "LEFT JOIN enrollments e " +
                "ON c.id = e.course_id " +
                "GROUP BY c.id, c.title, c.level, " +
                "c.status, u.name " +
                "ORDER BY c.id DESC";


        try (Connection con =
                     DBConnection.getConnection();
             PreparedStatement ps =
                     con.prepareStatement(sql);
             ResultSet rs =
                     ps.executeQuery()) {


            while (rs.next()) {

                Map<String,Object> map =
                        new HashMap<>();

                map.put("id",
                        rs.getInt("id"));

                map.put("title",
                        rs.getString("title"));

                map.put("level",
                        rs.getString("level"));

                map.put("status",
                        rs.getString("status"));

                map.put("teacher_name",
                        rs.getString("teacher_name"));

                map.put("student_count",
                        rs.getInt("student_count"));

                list.add(map);
            }
        }


        request.setAttribute(
                "classes",
                list
        );


        request.getRequestDispatcher(
                "/admin/classes.jsp"
        ).forward(request, response);
    }


    /* =========================================
       ENROLLMENTS
    ========================================= */

    private void enrollment(
            HttpServletRequest request,
            HttpServletResponse response)
            throws Exception {


        List<Map<String,Object>> list =
                new ArrayList<>();


        String sql =
                "SELECT e.*, " +
                "u.name AS student_name, " +
                "c.title AS course_title " +
                "FROM enrollments e " +
                "INNER JOIN students s " +
                "ON e.student_id = s.id " +
                "INNER JOIN users u " +
                "ON s.user_id = u.id " +
                "INNER JOIN courses c " +
                "ON e.course_id = c.id " +
                "ORDER BY e.id DESC";


        try (Connection con =
                     DBConnection.getConnection();
             PreparedStatement ps =
                     con.prepareStatement(sql);
             ResultSet rs =
                     ps.executeQuery()) {


            while (rs.next()) {

                Map<String,Object> map =
                        new HashMap<>();

                map.put(
                        "student_name",
                        rs.getString("student_name")
                );

                map.put(
                        "course_title",
                        rs.getString("course_title")
                );

                map.put(
                        "enrollment_date",
                        rs.getTimestamp("enrollment_date")
                );

                map.put(
                        "progress",
                        rs.getBigDecimal("progress")
                );

                map.put(
                        "status",
                        rs.getString("status")
                );

                list.add(map);
            }
        }


        request.setAttribute(
                "enrollments",
                list
        );


        request.getRequestDispatcher(
                "/admin/enrollments.jsp"
        ).forward(request, response);
    }


    /* =========================================
       EVENTS
    ========================================= */

    private void events(
            HttpServletRequest request,
            HttpServletResponse response)
            throws Exception {


        List<Map<String,Object>> list =
                new ArrayList<>();


        String sql =
                "SELECT id, title, description, " +
                "event_date, event_time, location " +
                "FROM events " +
                "ORDER BY event_date DESC";


        try (Connection con =
                     DBConnection.getConnection();
             PreparedStatement ps =
                     con.prepareStatement(sql);
             ResultSet rs =
                     ps.executeQuery()) {


            while (rs.next()) {

                Map<String,Object> map =
                        new HashMap<>();

                map.put("id",
                        rs.getInt("id"));

                map.put("title",
                        rs.getString("title"));

                map.put("description",
                        rs.getString("description"));

                map.put("event_date",
                        rs.getDate("event_date"));

                map.put("event_time",
                        rs.getTime("event_time"));

                map.put("location",
                        rs.getString("location"));

                list.add(map);
            }
        }


        request.setAttribute(
                "events",
                list
        );


        request.getRequestDispatcher(
                "/admin/events.jsp"
        ).forward(request, response);
    }


    /* =========================================
       ADD EVENT
    ========================================= */

    private void addEvent(
            HttpServletRequest request,
            HttpServletResponse response)
            throws Exception {


        String sql =
                "INSERT INTO events " +
                "(title, description, event_date, " +
                "event_time, location, created_by) " +
                "VALUES (?, ?, ?, ?, ?, ?)";


        HttpSession session =
                request.getSession(false);


        Object userId =
                session.getAttribute("userId");


        try (Connection con =
                     DBConnection.getConnection();
             PreparedStatement ps =
                     con.prepareStatement(sql)) {


            ps.setString(
                    1,
                    request.getParameter("title")
            );

            ps.setString(
                    2,
                    request.getParameter("description")
            );

            ps.setDate(
                    3,
                    Date.valueOf(
                            request.getParameter("event_date")
                    )
            );


            String eventTime =
                    request.getParameter("event_time");


            if (eventTime == null ||
                eventTime.isEmpty()) {

                ps.setNull(
                        4,
                        Types.TIME
                );

            } else {

                ps.setTime(
                        4,
                        Time.valueOf(
                                eventTime + ":00"
                        )
                );
            }


            ps.setString(
                    5,
                    request.getParameter("location")
            );


            if (userId == null) {

                ps.setNull(
                        6,
                        Types.INTEGER
                );

            } else {

                ps.setInt(
                        6,
                        Integer.parseInt(
                                userId.toString()
                        )
                );
            }


            ps.executeUpdate();
        }


        response.sendRedirect(
                request.getContextPath()
                + "/AdminServlet?action=events"
        );
    }


    /* =========================================
       DELETE EVENT
    ========================================= */

    private void deleteEvent(
            HttpServletRequest request,
            HttpServletResponse response)
            throws Exception {


        int id =
                Integer.parseInt(
                        request.getParameter("id")
                );


        try (Connection con =
                     DBConnection.getConnection();
             PreparedStatement ps =
                     con.prepareStatement(
                             "DELETE FROM events WHERE id=?"
                     )) {


            ps.setInt(1, id);

            ps.executeUpdate();
        }


        response.sendRedirect(
                request.getContextPath()
                + "/AdminServlet?action=events"
        );
    }


    /* =========================================
       REPORTS
    ========================================= */

    private void reports(
            HttpServletRequest request,
            HttpServletResponse response)
            throws Exception {


        try (Connection con =
                     DBConnection.getConnection()) {


            request.setAttribute(
                    "totalUsers",
                    getCount(
                            con,
                            "SELECT COUNT(*) FROM users"
                    )
            );


            request.setAttribute(
                    "totalEnrollments",
                    getCount(
                            con,
                            "SELECT COUNT(*) FROM enrollments"
                    )
            );


            request.setAttribute(
                    "activeCourses",
                    getCount(
                            con,
                            "SELECT COUNT(*) FROM courses " +
                            "WHERE status='ACTIVE'"
                    )
            );


            request.setAttribute(
                    "courseReports",
                    getCourseReports(con)
            );
        }


        request.getRequestDispatcher(
                "/admin/reports.jsp"
        ).forward(request, response);
    }


    private List<Map<String,Object>>
    getCourseReports(Connection con)
            throws Exception {


        List<Map<String,Object>> list =
                new ArrayList<>();


        String sql =
                "SELECT c.title, " +
                "COUNT(e.id) AS student_count, " +
                "AVG(e.progress) AS avg_progress " +
                "FROM courses c " +
                "LEFT JOIN enrollments e " +
                "ON c.id = e.course_id " +
                "GROUP BY c.id, c.title " +
                "ORDER BY student_count DESC";


        try (PreparedStatement ps =
                     con.prepareStatement(sql);
             ResultSet rs =
                     ps.executeQuery()) {


            while (rs.next()) {

                Map<String,Object> map =
                        new HashMap<>();

                map.put(
                        "title",
                        rs.getString("title")
                );

                map.put(
                        "student_count",
                        rs.getInt("student_count")
                );

                map.put(
                        "avg_progress",
                        rs.getBigDecimal("avg_progress")
                );

                list.add(map);
            }
        }


        return list;
    }


    /* =========================================
       COUNT HELPER
    ========================================= */

    private int getCount(
            Connection con,
            String sql)
            throws SQLException {


        try (PreparedStatement ps =
                     con.prepareStatement(sql);
             ResultSet rs =
                     ps.executeQuery()) {


            if (rs.next()) {

                return rs.getInt(1);
            }
        }


        return 0;
    }

}   
            