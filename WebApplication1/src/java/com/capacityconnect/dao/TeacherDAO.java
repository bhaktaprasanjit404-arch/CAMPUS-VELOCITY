/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.capacityconnect.dao;

import com.capacityconnect.db.DBConnection;
import com.capacityconnect.model.Teacher;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class TeacherDAO {

    // =====================================================
    // GET TEACHER PROFILE
    // =====================================================

    public Teacher getTeacherByUserId(int userId) {

        Teacher teacher = null;

        /*
         * Actual database table:
         *
         * teacher
         * ----------------
         * id
         * user_id
         * qualification
         * specification
         * phone
         * bio
         *
         * Name and email are NOT stored in teacher table.
         */

        String sql =
                "SELECT id, user_id, qualification, " +
                "specification, phone, bio " +
                "FROM teacher " +
                "WHERE user_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, userId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    teacher = new Teacher();

                    teacher.setId(rs.getInt("id"));

                    teacher.setUserId(
                            rs.getInt("user_id"));

                    teacher.setQualification(
                            rs.getString("qualification"));

                    teacher.setSpecialization(
                            rs.getString("specification"));

                    teacher.setPhone(
                            rs.getString("phone"));

                    teacher.setBio(
                            rs.getString("bio"));
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return teacher;
    }


    // =====================================================
    // GET TEACHER COURSES
    // =====================================================

    public List<String[]> getCourses(int teacherId) {

        List<String[]> courses = new ArrayList<>();

        String sql =
                "SELECT id, title, category, level, duration, status " +
                "FROM courses " +
                "WHERE teacher_id = ? " +
                "ORDER BY created_at DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, teacherId);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    courses.add(new String[]{
                        String.valueOf(rs.getInt("id")),
                        rs.getString("title"),
                        rs.getString("category"),
                        rs.getString("level"),
                        rs.getString("duration"),
                        rs.getString("status")
                    });
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return courses;
    }


    // =====================================================
    // GET STUDENTS OF TEACHER
    // =====================================================

    public List<String[]> getStudents(int teacherId) {

        List<String[]> students = new ArrayList<>();

        String sql =
                "SELECT DISTINCT u.id, u.name, u.email, " +
                "c.title, e.progress, e.status " +
                "FROM enrollments e " +
                "INNER JOIN students s ON e.student_id = s.id " +
                "INNER JOIN users u ON s.user_id = u.id " +
                "INNER JOIN courses c ON e.course_id = c.id " +
                "WHERE c.teacher_id = ? " +
                "ORDER BY u.name";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, teacherId);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    students.add(new String[]{
                        String.valueOf(rs.getInt("id")),
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("title"),
                        String.valueOf(
                                rs.getBigDecimal("progress")),
                        rs.getString("status")
                    });
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return students;
    }


    // =====================================================
    // DASHBOARD COURSE COUNT
    // =====================================================

    public int getCourseCount(int teacherId) {

        String sql =
                "SELECT COUNT(*) " +
                "FROM courses " +
                "WHERE teacher_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, teacherId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    return rs.getInt(1);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }


    // =====================================================
    // DASHBOARD STUDENT COUNT
    // =====================================================

    public int getStudentCount(int teacherId) {

        String sql =
                "SELECT COUNT(DISTINCT e.student_id) " +
                "FROM enrollments e " +
                "INNER JOIN courses c " +
                "ON e.course_id = c.id " +
                "WHERE c.teacher_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, teacherId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    return rs.getInt(1);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }


    // =====================================================
    // ASSIGNMENT COUNT
    // =====================================================

    public int getAssignmentCount(int teacherId) {

        String sql =
                "SELECT COUNT(*) " +
                "FROM assignments a " +
                "INNER JOIN courses c " +
                "ON a.course_id = c.id " +
                "WHERE c.teacher_id = ?";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, teacherId);

            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {
                    return rs.getInt(1);
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return 0;
    }


    // =====================================================
    // ATTENDANCE
    // =====================================================

    public boolean markAttendance(int studentId,
                                  int courseId,
                                  int teacherId,
                                  String date,
                                  String status,
                                  String remarks) {

        String sql =
                "INSERT INTO attendance " +
                "(student_id, course_id, teacher_id, " +
                "attendance_date, status, remarks) " +
                "VALUES (?, ?, ?, ?, ?, ?) " +
                "ON DUPLICATE KEY UPDATE " +
                "status = VALUES(status), " +
                "remarks = VALUES(remarks)";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, studentId);
            ps.setInt(2, courseId);
            ps.setInt(3, teacherId);
            ps.setString(4, date);
            ps.setString(5, status);
            ps.setString(6, remarks);

            return ps.executeUpdate() > 0;

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    // =====================================================
    // STUDENT PROGRESS
    // =====================================================

    public List<String[]> getStudentProgress(int teacherId) {

        List<String[]> progress = new ArrayList<>();

        String sql =
                "SELECT u.name, u.email, c.title, " +
                "e.progress, e.status " +
                "FROM enrollments e " +
                "INNER JOIN students s " +
                "ON e.student_id = s.id " +
                "INNER JOIN users u " +
                "ON s.user_id = u.id " +
                "INNER JOIN courses c " +
                "ON e.course_id = c.id " +
                "WHERE c.teacher_id = ? " +
                "ORDER BY e.progress DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, teacherId);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    progress.add(new String[]{
                        rs.getString("name"),
                        rs.getString("email"),
                        rs.getString("title"),
                        String.valueOf(
                                rs.getBigDecimal("progress")),
                        rs.getString("status")
                    });
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return progress;
    }


    // =====================================================
    // PERFORMANCE / SCORES
    // Uses assignments + submissions
    // =====================================================

    public List<String[]> getPerformance(int teacherId) {

        List<String[]> performance = new ArrayList<>();

        String sql =
                "SELECT u.name, c.title, " +
                "a.title AS assignment, " +
                "s.marks, a.total_marks, s.status " +
                "FROM submissions s " +
                "INNER JOIN assignments a " +
                "ON s.assignment_id = a.id " +
                "INNER JOIN courses c " +
                "ON a.course_id = c.id " +
                "INNER JOIN students st " +
                "ON s.student_id = st.id " +
                "INNER JOIN users u " +
                "ON st.user_id = u.id " +
                "WHERE c.teacher_id = ? " +
                "ORDER BY s.marks DESC";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, teacherId);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    performance.add(new String[]{
                        rs.getString("name"),
                        rs.getString("title"),
                        rs.getString("assignment"),
                        String.valueOf(
                                rs.getBigDecimal("marks")),
                        String.valueOf(
                                rs.getInt("total_marks")),
                        rs.getString("status")
                    });
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return performance;
    }


    // =====================================================
    // RECENT ASSIGNMENTS
    // Used by notifications
    // =====================================================

    public List<String[]> getRecentAssignments(int teacherId) {

        List<String[]> assignments = new ArrayList<>();

        String sql =
                "SELECT a.title, " +
                "c.title AS course, " +
                "a.due_date " +
                "FROM assignments a " +
                "INNER JOIN courses c " +
                "ON a.course_id = c.id " +
                "WHERE c.teacher_id = ? " +
                "ORDER BY a.created_at DESC " +
                "LIMIT 10";

        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, teacherId);

            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    assignments.add(new String[]{
                        rs.getString("title"),
                        rs.getString("course"),
                        String.valueOf(
                                rs.getTimestamp("due_date"))
                    });
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return assignments;
    }
}