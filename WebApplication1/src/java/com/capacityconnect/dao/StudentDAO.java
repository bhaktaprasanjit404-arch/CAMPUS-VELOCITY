package com.capacityconnect.dao;

import com.capacityconnect.db.DBConnection;
import com.capacityconnect.model.Student;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * Data Access Object for Student operations.
 * Strictly aligned with capacity_connect database schema (database.sql).
 */
public class StudentDAO {

    // =====================================================
    // GET STUDENT PROFILE BY USER ID
    // =====================================================
    public Student getStudentById(int studentId) {
        Student student = null;
        String sql = "SELECT id, name, email, password, role FROM users WHERE id = ? AND role = 'STUDENT'";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, studentId);

            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    student = new Student();
                    student.setId(rs.getInt("id"));
                    student.setName(rs.getString("name"));
                    student.setEmail(rs.getString("email"));
                    student.setPassword(rs.getString("password"));
                    student.setRole(rs.getString("role"));
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return student;
    }

    // =====================================================
    // GET DASHBOARD SUMMARY STATS
    // =====================================================
    public Map<String, Object> getDashboardStats(int studentId) {
        Map<String, Object> stats = new HashMap<>();

        int enrolledCount = 0;
        int completedCount = 0;
        double avgProgress = 0.0;
        int totalAssignments = 0;
        int submittedAssignments = 0;
        int pendingAssignments = 0;
        int totalAttendance = 0;
        int presentAttendance = 0;
        double attendanceRate = 0.0;
        int certificateCount = 0;

        try (Connection con = DBConnection.getConnection()) {

            // 1. Enrolled courses, completed count, and avg progress
            String enrollSql = "SELECT COUNT(*) AS total_enrolled, "
                    + "SUM(CASE WHEN progress >= 100.00 OR status = 'COMPLETED' THEN 1 ELSE 0 END) AS total_completed, "
                    + "AVG(progress) AS avg_progress "
                    + "FROM enrollments WHERE student_id = ?";
            try (PreparedStatement ps = con.prepareStatement(enrollSql)) {
                ps.setInt(1, studentId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        enrolledCount = rs.getInt("total_enrolled");
                        completedCount = rs.getInt("total_completed");
                        avgProgress = rs.getDouble("avg_progress");
                    }
                }
            }

            // 2. Total assignments from enrolled courses
            String assignSql = "SELECT COUNT(a.id) AS total_assign "
                    + "FROM assignments a "
                    + "INNER JOIN enrollments e ON a.course_id = e.course_id "
                    + "WHERE e.student_id = ?";
            try (PreparedStatement ps = con.prepareStatement(assignSql)) {
                ps.setInt(1, studentId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        totalAssignments = rs.getInt("total_assign");
                    }
                }
            }

            // 3. Submitted assignments
            String subSql = "SELECT COUNT(DISTINCT assignment_id) AS total_submitted "
                    + "FROM submissions WHERE student_id = ?";
            try (PreparedStatement ps = con.prepareStatement(subSql)) {
                ps.setInt(1, studentId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        submittedAssignments = rs.getInt("total_submitted");
                    }
                }
            }
            pendingAssignments = Math.max(0, totalAssignments - submittedAssignments);

            // 4. Attendance rate
            String attSql = "SELECT COUNT(*) AS total_records, "
                    + "SUM(CASE WHEN UPPER(status) = 'PRESENT' THEN 1 ELSE 0 END) AS present_records "
                    + "FROM attendance WHERE student_id = ?";
            try (PreparedStatement ps = con.prepareStatement(attSql)) {
                ps.setInt(1, studentId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        totalAttendance = rs.getInt("total_records");
                        presentAttendance = rs.getInt("present_records");
                        if (totalAttendance > 0) {
                            attendanceRate = ((double) presentAttendance / totalAttendance) * 100.0;
                        }
                    }
                }
            }

            // 5. Certificates count
            String certSql = "SELECT COUNT(*) AS total_certs FROM certificates WHERE student_id = ?";
            try (PreparedStatement ps = con.prepareStatement(certSql)) {
                ps.setInt(1, studentId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        certificateCount = rs.getInt("total_certs");
                    }
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        stats.put("enrolledCount", enrolledCount);
        stats.put("completedCount", completedCount);
        stats.put("inProgressCount", Math.max(0, enrolledCount - completedCount));
        stats.put("avgProgress", Math.round(avgProgress * 10.0) / 10.0);
        stats.put("totalAssignments", totalAssignments);
        stats.put("submittedAssignments", submittedAssignments);
        stats.put("pendingAssignments", pendingAssignments);
        stats.put("totalAttendance", totalAttendance);
        stats.put("presentAttendance", presentAttendance);
        stats.put("attendanceRate", Math.round(attendanceRate * 10.0) / 10.0);
        stats.put("certificateCount", certificateCount);

        return stats;
    }

    // =====================================================
    // GET ENROLLED COURSES WITH INSTRUCTOR & PROGRESS
    // =====================================================
    public List<Map<String, Object>> getEnrolledCourses(int studentId) {
        List<Map<String, Object>> list = new ArrayList<>();

        String sql = "SELECT e.id AS enrollment_id, e.progress, e.status AS enrollment_status, "
                + "c.id AS course_id, c.title, c.category, c.description, c.level, c.duration, "
                + "c.price, c.thumbnail, c.status AS course_status, "
                + "COALESCE(t.name, 'Staff Instructor') AS teacher_name, "
                + "t.qualification, t.specialization "
                + "FROM enrollments e "
                + "INNER JOIN courses c ON e.course_id = c.id "
                + "LEFT JOIN teachers t ON c.teacher_id = t.id "
                + "WHERE e.student_id = ? "
                + "ORDER BY e.id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, studentId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("enrollmentId", rs.getInt("enrollment_id"));
                    map.put("progress", rs.getDouble("progress"));
                    map.put("enrollmentStatus", rs.getString("enrollment_status"));
                    map.put("courseId", rs.getInt("course_id"));
                    map.put("title", rs.getString("title"));
                    map.put("category", rs.getString("category") != null ? rs.getString("category") : "General");
                    map.put("description", rs.getString("description"));
                    map.put("level", rs.getString("level") != null ? rs.getString("level") : "All Levels");
                    map.put("duration", rs.getString("duration") != null ? rs.getString("duration") : "Self-paced");
                    map.put("price", rs.getBigDecimal("price"));
                    map.put("thumbnail", rs.getString("thumbnail"));
                    map.put("courseStatus", rs.getString("course_status"));
                    map.put("teacherName", rs.getString("teacher_name"));
                    map.put("qualification", rs.getString("qualification"));
                    map.put("specialization", rs.getString("specialization"));
                    list.add(map);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // =====================================================
    // GET ASSIGNMENTS & SUBMISSION STATUS
    // =====================================================
    public List<Map<String, Object>> getStudentAssignments(int studentId) {
        List<Map<String, Object>> list = new ArrayList<>();

        String sql = "SELECT a.id AS assignment_id, a.title AS assignment_title, a.description, "
                + "a.due_date, a.total_marks, "
                + "c.id AS course_id, c.title AS course_title, "
                + "s.id AS submission_id, s.submission_file, s.submitted_at, s.marks, s.feedback "
                + "FROM assignments a "
                + "INNER JOIN courses c ON a.course_id = c.id "
                + "INNER JOIN enrollments e ON e.course_id = c.id AND e.student_id = ? "
                + "LEFT JOIN submissions s ON s.assignment_id = a.id AND s.student_id = ? "
                + "ORDER BY a.due_date ASC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, studentId);
            ps.setInt(2, studentId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("assignmentId", rs.getInt("assignment_id"));
                    map.put("title", rs.getString("assignment_title"));
                    map.put("description", rs.getString("description"));
                    Timestamp dueTimestamp = rs.getTimestamp("due_date");
                    map.put("dueDate", dueTimestamp != null ? dueTimestamp.toString() : "N/A");
                    map.put("totalMarks", rs.getInt("total_marks"));
                    map.put("courseId", rs.getInt("course_id"));
                    map.put("courseTitle", rs.getString("course_title"));

                    int subId = rs.getInt("submission_id");
                    boolean isSubmitted = (subId > 0 && !rs.wasNull());
                    map.put("isSubmitted", isSubmitted);
                    map.put("submissionId", subId);
                    map.put("submissionFile", rs.getString("submission_file"));
                    Timestamp subTimestamp = rs.getTimestamp("submitted_at");
                    map.put("submittedAt", subTimestamp != null ? subTimestamp.toString() : null);

                    int marks = rs.getInt("marks");
                    boolean hasMarks = !rs.wasNull();
                    map.put("marks", hasMarks ? marks : null);
                    map.put("feedback", rs.getString("feedback"));

                    // Determine clean computed status
                    String statusText;
                    if (isSubmitted && hasMarks) {
                        statusText = "GRADED";
                    } else if (isSubmitted) {
                        statusText = "SUBMITTED";
                    } else if (dueTimestamp != null && dueTimestamp.getTime() < System.currentTimeMillis()) {
                        statusText = "OVERDUE";
                    } else {
                        statusText = "PENDING";
                    }
                    map.put("status", statusText);

                    list.add(map);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // =====================================================
    // GET ATTENDANCE HISTORY
    // =====================================================
    public List<Map<String, Object>> getStudentAttendance(int studentId) {
        List<Map<String, Object>> list = new ArrayList<>();

        String sql = "SELECT att.id, att.attendance_date, att.status, "
                + "c.title AS course_title, "
                + "COALESCE(t.name, 'Instructor') AS teacher_name "
                + "FROM attendance att "
                + "INNER JOIN courses c ON att.course_id = c.id "
                + "LEFT JOIN teachers t ON att.teacher_id = t.id "
                + "WHERE att.student_id = ? "
                + "ORDER BY att.attendance_date DESC LIMIT 15";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, studentId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("id", rs.getInt("id"));
                    map.put("attendanceDate", rs.getDate("attendance_date").toString());
                    map.put("status", rs.getString("status"));
                    map.put("courseTitle", rs.getString("course_title"));
                    map.put("teacherName", rs.getString("teacher_name"));
                    list.add(map);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // =====================================================
    // GET CERTIFICATES
    // =====================================================
    public List<Map<String, Object>> getStudentCertificates(int studentId) {
        List<Map<String, Object>> list = new ArrayList<>();

        String sql = "SELECT cert.id, cert.certificate_number, cert.issue_date, "
                + "c.id AS course_id, c.title AS course_title, c.category "
                + "FROM certificates cert "
                + "INNER JOIN courses c ON cert.course_id = c.id "
                + "WHERE cert.student_id = ? "
                + "ORDER BY cert.issue_date DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, studentId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("id", rs.getInt("id"));
                    map.put("certificateNumber", rs.getString("certificate_number"));
                    map.put("issueDate", rs.getDate("issue_date").toString());
                    map.put("courseId", rs.getInt("course_id"));
                    map.put("courseTitle", rs.getString("course_title"));
                    map.put("category", rs.getString("category"));
                    list.add(map);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // =====================================================
    // GET RECENT RESOURCES & MATERIALS
    // =====================================================
    public List<Map<String, Object>> getRecentResources(int studentId) {
        List<Map<String, Object>> list = new ArrayList<>();

        String sql = "SELECT r.id, r.title, r.resource_type, r.resource_url, "
                + "c.title AS course_title "
                + "FROM resources r "
                + "INNER JOIN courses c ON r.course_id = c.id "
                + "INNER JOIN enrollments e ON e.course_id = c.id AND e.student_id = ? "
                + "ORDER BY r.id DESC LIMIT 8";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, studentId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("id", rs.getInt("id"));
                    map.put("title", rs.getString("title"));
                    map.put("resourceType", rs.getString("resource_type") != null ? rs.getString("resource_type") : "DOC");
                    map.put("resourceUrl", rs.getString("resource_url"));
                    map.put("courseTitle", rs.getString("course_title"));
                    list.add(map);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // =====================================================
    // GET COURSE VIDEOS
    // =====================================================
    public List<Map<String, Object>> getCourseVideos(int studentId) {
        List<Map<String, Object>> list = new ArrayList<>();

        String sql = "SELECT v.id, v.title, v.video_url, c.title AS course_title "
                + "FROM course_videos v "
                + "INNER JOIN courses c ON v.course_id = c.id "
                + "INNER JOIN enrollments e ON e.course_id = c.id AND e.student_id = ? "
                + "ORDER BY v.id DESC LIMIT 6";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, studentId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("id", rs.getInt("id"));
                    map.put("title", rs.getString("title"));
                    map.put("videoUrl", rs.getString("video_url"));
                    map.put("courseTitle", rs.getString("course_title"));
                    list.add(map);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // =====================================================
    // SUBMIT ASSIGNMENT
    // =====================================================
    public boolean submitAssignment(int assignmentId, int studentId, String submissionFile) {
        String checkSql = "SELECT id FROM submissions WHERE assignment_id = ? AND student_id = ?";
        String insertSql = "INSERT INTO submissions (assignment_id, student_id, submission_file, submitted_at) VALUES (?, ?, ?, NOW())";
        String updateSql = "UPDATE submissions SET submission_file = ?, submitted_at = NOW() WHERE id = ?";

        try (Connection con = DBConnection.getConnection()) {

            int existingSubId = -1;
            try (PreparedStatement ps = con.prepareStatement(checkSql)) {
                ps.setInt(1, assignmentId);
                ps.setInt(2, studentId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        existingSubId = rs.getInt("id");
                    }
                }
            }

            if (existingSubId > 0) {
                try (PreparedStatement ps = con.prepareStatement(updateSql)) {
                    ps.setString(1, submissionFile);
                    ps.setInt(2, existingSubId);
                    return ps.executeUpdate() > 0;
                }
            } else {
                try (PreparedStatement ps = con.prepareStatement(insertSql)) {
                    ps.setInt(1, assignmentId);
                    ps.setInt(2, studentId);
                    ps.setString(3, submissionFile);
                    return ps.executeUpdate() > 0;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // =====================================================
    // UPDATE ENROLLMENT PROGRESS
    // =====================================================
    public boolean updateProgress(int studentId, int courseId, double progress) {
        String sql = "UPDATE enrollments SET progress = ?, "
                + "status = CASE WHEN ? >= 100.0 THEN 'COMPLETED' ELSE 'ENROLLED' END "
                + "WHERE student_id = ? AND course_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setDouble(1, progress);
            ps.setDouble(2, progress);
            ps.setInt(3, studentId);
            ps.setInt(4, courseId);

            boolean updated = ps.executeUpdate() > 0;

            // Auto-issue certificate if 100% completed and not yet issued
            if (updated && progress >= 100.0) {
                issueCertificateIfNotExists(con, studentId, courseId);
            }

            return updated;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    private void issueCertificateIfNotExists(Connection con, int studentId, int courseId) {
        String checkSql = "SELECT id FROM certificates WHERE student_id = ? AND course_id = ?";
        String insertSql = "INSERT INTO certificates (student_id, course_id, certificate_number, issue_date) VALUES (?, ?, ?, CURDATE())";

        try {
            boolean exists = false;
            try (PreparedStatement ps = con.prepareStatement(checkSql)) {
                ps.setInt(1, studentId);
                ps.setInt(2, courseId);
                try (ResultSet rs = ps.executeQuery()) {
                    if (rs.next()) {
                        exists = true;
                    }
                }
            }

            if (!exists) {
                String certNumber = "CC-" + (1000 + courseId) + "-" + (10000 + studentId) + "-" + (System.currentTimeMillis() % 10000);
                try (PreparedStatement ps = con.prepareStatement(insertSql)) {
                    ps.setInt(1, studentId);
                    ps.setInt(2, courseId);
                    ps.setString(3, certNumber);
                    ps.executeUpdate();
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // =====================================================
    // GET ALL ATTENDANCE HISTORY
    // =====================================================
    public List<Map<String, Object>> getAllStudentAttendance(int studentId) {
        List<Map<String, Object>> list = new ArrayList<>();

        String sql = "SELECT att.id, att.attendance_date, att.status, "
                + "c.id AS course_id, c.title AS course_title, "
                + "COALESCE(t.name, 'Instructor') AS teacher_name "
                + "FROM attendance att "
                + "INNER JOIN courses c ON att.course_id = c.id "
                + "LEFT JOIN teachers t ON att.teacher_id = t.id "
                + "WHERE att.student_id = ? "
                + "ORDER BY att.attendance_date DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, studentId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("id", rs.getInt("id"));
                    map.put("courseId", rs.getInt("course_id"));
                    map.put("attendanceDate", rs.getDate("attendance_date").toString());
                    map.put("status", rs.getString("status"));
                    map.put("courseTitle", rs.getString("course_title"));
                    map.put("teacherName", rs.getString("teacher_name"));
                    list.add(map);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // =====================================================
    // GET ALL ENROLLED RESOURCES
    // =====================================================
    public List<Map<String, Object>> getAllStudentResources(int studentId) {
        List<Map<String, Object>> list = new ArrayList<>();

        String sql = "SELECT r.id, r.title, r.resource_type, r.resource_url, "
                + "c.id AS course_id, c.title AS course_title, c.category "
                + "FROM resources r "
                + "INNER JOIN courses c ON r.course_id = c.id "
                + "INNER JOIN enrollments e ON e.course_id = c.id AND e.student_id = ? "
                + "ORDER BY r.id DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, studentId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("id", rs.getInt("id"));
                    map.put("courseId", rs.getInt("course_id"));
                    map.put("title", rs.getString("title"));
                    map.put("resourceType", rs.getString("resource_type") != null ? rs.getString("resource_type") : "DOC");
                    map.put("resourceUrl", rs.getString("resource_url"));
                    map.put("courseTitle", rs.getString("course_title"));
                    map.put("category", rs.getString("category"));
                    list.add(map);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // =====================================================
    // GET VIDEOS FOR A SPECIFIC COURSE
    // =====================================================
    public List<Map<String, Object>> getVideosForCourse(int courseId) {
        List<Map<String, Object>> list = new ArrayList<>();

        String sql = "SELECT id, course_id, title, video_url FROM course_videos WHERE course_id = ? ORDER BY id ASC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, courseId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("id", rs.getInt("id"));
                    map.put("courseId", rs.getInt("course_id"));
                    map.put("title", rs.getString("title"));
                    map.put("videoUrl", rs.getString("video_url"));
                    list.add(map);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // =====================================================
    // GET RESOURCES FOR A SPECIFIC COURSE
    // =====================================================
    public List<Map<String, Object>> getResourcesForCourse(int courseId) {
        List<Map<String, Object>> list = new ArrayList<>();

        String sql = "SELECT id, course_id, title, resource_type, resource_url FROM resources WHERE course_id = ? ORDER BY id ASC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, courseId);

            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> map = new HashMap<>();
                    map.put("id", rs.getInt("id"));
                    map.put("courseId", rs.getInt("course_id"));
                    map.put("title", rs.getString("title"));
                    map.put("resourceType", rs.getString("resource_type") != null ? rs.getString("resource_type") : "DOC");
                    map.put("resourceUrl", rs.getString("resource_url"));
                    list.add(map);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // =====================================================
    // UPDATE STUDENT PROFILE
    // =====================================================
    public boolean updateStudentProfile(int studentId, String name, String password) {
        boolean updatePass = (password != null && !password.trim().isEmpty());
        String sql = updatePass
                ? "UPDATE users SET name = ?, password = ? WHERE id = ? AND role = 'STUDENT'"
                : "UPDATE users SET name = ? WHERE id = ? AND role = 'STUDENT'";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            if (updatePass) {
                ps.setString(1, name.trim());
                ps.setString(2, password.trim());
                ps.setInt(3, studentId);
            } else {
                ps.setString(1, name.trim());
                ps.setInt(2, studentId);
            }

            return ps.executeUpdate() > 0;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    // =====================================================
    // GET STUDENT NOTIFICATIONS & ACADEMIC ALERTS
    // =====================================================
    public List<Map<String, Object>> getStudentNotifications(int studentId) {
        List<Map<String, Object>> list = new ArrayList<>();

        String subSql = "SELECT s.id, s.submitted_at, s.marks, s.feedback, a.title AS assignment_title, "
                + "c.title AS course_title, a.total_marks "
                + "FROM submissions s "
                + "INNER JOIN assignments a ON s.assignment_id = a.id "
                + "INNER JOIN courses c ON a.course_id = c.id "
                + "WHERE s.student_id = ? AND s.marks IS NOT NULL "
                + "ORDER BY s.submitted_at DESC LIMIT 8";

        String upSql = "SELECT a.id, a.title AS assignment_title, a.due_date, a.total_marks, "
                + "c.title AS course_title "
                + "FROM assignments a "
                + "INNER JOIN courses c ON a.course_id = c.id "
                + "INNER JOIN enrollments e ON e.course_id = c.id AND e.student_id = ? "
                + "LEFT JOIN submissions s ON s.assignment_id = a.id AND s.student_id = ? "
                + "WHERE s.id IS NULL AND a.due_date >= NOW() "
                + "ORDER BY a.due_date ASC LIMIT 8";

        String certSql = "SELECT cert.id, cert.certificate_number, cert.issue_date, c.title AS course_title "
                + "FROM certificates cert "
                + "INNER JOIN courses c ON cert.course_id = c.id "
                + "WHERE cert.student_id = ? "
                + "ORDER BY cert.issue_date DESC LIMIT 8";

        try (Connection con = DBConnection.getConnection()) {
            // 1. Graded submissions
            try (PreparedStatement ps = con.prepareStatement(subSql)) {
                ps.setInt(1, studentId);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        Map<String, Object> map = new HashMap<>();
                        map.put("type", "GRADE");
                        map.put("title", "Assignment Graded: " + rs.getString("assignment_title"));
                        String feedback = rs.getString("feedback");
                        map.put("message", "You received " + rs.getInt("marks") + "/" + rs.getInt("total_marks") + " in " + rs.getString("course_title") + (feedback != null && !feedback.trim().isEmpty() ? " | Feedback: \"" + feedback + "\"" : ""));
                        map.put("date", rs.getTimestamp("submitted_at") != null ? rs.getTimestamp("submitted_at").toString() : "Recent");
                        map.put("icon", "fa-check-double");
                        map.put("badgeClass", "completed");
                        list.add(map);
                    }
                }
            }

            // 2. Upcoming assignments
            try (PreparedStatement ps = con.prepareStatement(upSql)) {
                ps.setInt(1, studentId);
                ps.setInt(2, studentId);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        Map<String, Object> map = new HashMap<>();
                        map.put("type", "DEADLINE");
                        map.put("title", "Upcoming Assignment: " + rs.getString("assignment_title"));
                        map.put("message", "Submission deadline for " + rs.getString("course_title") + " is " + rs.getTimestamp("due_date") + ".");
                        map.put("date", rs.getTimestamp("due_date") != null ? rs.getTimestamp("due_date").toString() : "Upcoming");
                        map.put("icon", "fa-clock");
                        map.put("badgeClass", "warning");
                        list.add(map);
                    }
                }
            }

            // 3. Certificates issued
            try (PreparedStatement ps = con.prepareStatement(certSql)) {
                ps.setInt(1, studentId);
                try (ResultSet rs = ps.executeQuery()) {
                    while (rs.next()) {
                        Map<String, Object> map = new HashMap<>();
                        map.put("type", "CERTIFICATE");
                        map.put("title", "Certificate Issued: " + rs.getString("course_title"));
                        map.put("message", "Certificate of Completion #" + rs.getString("certificate_number") + " has been verified and awarded.");
                        map.put("date", rs.getDate("issue_date") != null ? rs.getDate("issue_date").toString() : "Recent");
                        map.put("icon", "fa-award");
                        map.put("badgeClass", "completed");
                        list.add(map);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }
}
