package com.capacityconnect.dao;

import com.capacityconnect.db.DBConnection;
import com.capacityconnect.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class UserDAO {


    // =====================================================
    // STUDENT LOGIN
    // TABLE: users
    //
    // id
    // name
    // email
    // password
    // role
    // =====================================================

    public User loginStudent(int id,
                             String name,
                             String password) {

        User user = null;

        String sql =
                "SELECT id, name, email, password, role " +
                "FROM users " +
                "WHERE id = ? " +
                "AND name = ? " +
                "AND password = ? " +
                "AND role = 'STUDENT'";


        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, id);
            ps.setString(2, name);
            ps.setString(3, password);


            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    user = new User();

                    user.setId(rs.getInt("id"));
                    user.setName(rs.getString("name"));
                    user.setEmail(rs.getString("email"));
                    user.setPassword(rs.getString("password"));
                    user.setRole(rs.getString("role"));
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return user;
    }


    // =====================================================
    // TEACHER LOGIN
    //
    // teachers:
    // id
    // user_id
    //
    // users:
    // id
    // password
    // role
    // =====================================================

    public User loginTeacher(int teacherId,
                             int userId,
                             String password) {

        User user = null;

        String sql =
                "SELECT u.id, u.name, u.email, " +
                "u.password, u.role " +
                "FROM teachers t " +
                "INNER JOIN users u " +
                "ON t.user_id = u.id " +
                "WHERE t.id = ? " +
                "AND t.user_id = ? " +
                "AND u.password = ? " +
                "AND u.role = 'TEACHER'";


        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setInt(1, teacherId);
            ps.setInt(2, userId);
            ps.setString(3, password);


            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    user = new User();

                    user.setId(rs.getInt("id"));
                    user.setName(rs.getString("name"));
                    user.setEmail(rs.getString("email"));
                    user.setPassword(rs.getString("password"));
                    user.setRole(rs.getString("role"));
                }
            }

        } catch (Exception e) {

            e.printStackTrace();
        }

        return user;
    }


    // =====================================================
    // ADMIN LOGIN
    //
    // TABLE: admin
    //
    // username
    // password
    // =====================================================

    public boolean loginAdmin(String username,
                              String password) {

        String sql =
                "SELECT username " +
                "FROM admin " +
                "WHERE username = ? " +
                "AND password = ?";


        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, username);
            ps.setString(2, password);


            try (ResultSet rs = ps.executeQuery()) {

                return rs.next();
            }

        } catch (Exception e) {

            e.printStackTrace();

            return false;
        }
    }


    // =====================================================
    // STUDENT REGISTRATION
    //
    // Students are stored in USERS table.
    //
    // users:
    // name
    // email
    // password
    // role = STUDENT
    // =====================================================

    public boolean registerStudent(User user) {

        String sql =
                "INSERT INTO users " +
                "(name, email, password, role) " +
                "VALUES (?, ?, ?, 'STUDENT')";


        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, user.getName());
            ps.setString(2, user.getEmail());
            ps.setString(3, user.getPassword());

            return ps.executeUpdate() > 0;

        } catch (Exception e) {

            e.printStackTrace();

            return false;
        }
    }


    // =====================================================
    // TEACHER REGISTRATION
    //
    // STEP 1 → users
    // STEP 2 → get generated users.id
    // STEP 3 → teachers using user_id
    // =====================================================

    public boolean registerTeacher(
            User user,
            String qualification,
            String specialization,
            String phone,
            String bio) {

        Connection con = null;


        try {

            con = DBConnection.getConnection();

            con.setAutoCommit(false);


            // ---------------------------------------------
            // STEP 1: INSERT INTO USERS
            // ---------------------------------------------

            String userSql =
                    "INSERT INTO users " +
                    "(name, email, password, role) " +
                    "VALUES (?, ?, ?, 'TEACHER')";


            int userId;


            try (PreparedStatement ps =
                         con.prepareStatement(
                                 userSql,
                                 java.sql.Statement.RETURN_GENERATED_KEYS)) {


                ps.setString(1, user.getName());
                ps.setString(2, user.getEmail());
                ps.setString(3, user.getPassword());

                ps.executeUpdate();


                try (ResultSet rs = ps.getGeneratedKeys()) {

                    if (!rs.next()) {

                        con.rollback();

                        return false;
                    }

                    userId = rs.getInt(1);
                }
            }


            // ---------------------------------------------
            // STEP 2: INSERT INTO TEACHERS
            // ---------------------------------------------

            String teacherSql =
                    "INSERT INTO teachers " +
                    "(user_id, qualification, specialization, phone, bio) " +
                    "VALUES (?, ?, ?, ?, ?)";


            try (PreparedStatement ps =
                         con.prepareStatement(teacherSql)) {

                ps.setInt(1, userId);
                ps.setString(2, qualification);
                ps.setString(3, specialization);
                ps.setString(4, phone);
                ps.setString(5, bio);

                ps.executeUpdate();
            }


            // ---------------------------------------------
            // STEP 3: COMMIT
            // ---------------------------------------------

            con.commit();

            return true;


        } catch (Exception e) {

            e.printStackTrace();


            try {

                if (con != null) {
                    con.rollback();
                }

            } catch (Exception rollbackError) {

                rollbackError.printStackTrace();
            }

            return false;


        } finally {

            try {

                if (con != null) {

                    con.setAutoCommit(true);
                    con.close();

                }

            } catch (Exception closeError) {

                closeError.printStackTrace();
            }
        }
    }
}