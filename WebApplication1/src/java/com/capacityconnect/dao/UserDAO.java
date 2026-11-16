package com.capacityconnect.dao;

import com.capacityconnect.db.DBConnection;
import com.capacityconnect.model.User;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Statement;

public class UserDAO {


    // =========================================================
    // STUDENT / USER REGISTRATION
    //
    // Data is stored only in users table.
    // =========================================================

    public boolean registerStudent(
            String name,
            String email,
            String password) {

        String sql =
                "INSERT INTO users " +
                "(name, email, password, role) " +
                "VALUES (?, ?, ?, 'STUDENT')";

        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {

            ps.setString(1, name);
            ps.setString(2, email);
            ps.setString(3, password);

            int result = ps.executeUpdate();

            return result > 0;

        } catch (Exception e) {

            e.printStackTrace();

            return false;
        }
    }


    // =========================================================
    // TEACHER REGISTRATION
    //
    // STEP 1:
    // Insert teacher login information into users table.
    //
    // STEP 2:
    // Get generated users.id.
    //
    // STEP 3:
    // Insert teacher information into teachers table.
    //
    // Both operations use one transaction.
    // =========================================================

    public boolean registerTeacher(
            String name,
            String email,
            String password,
            String qualification,
            String specialization,
            String phone,
            String bio) {


        Connection con = null;


        String userSQL =
                "INSERT INTO users " +
                "(name, email, password, role) " +
                "VALUES (?, ?, ?, 'TEACHER')";


        String teacherSQL =
                "INSERT INTO teachers " +
                "(name, user_id, qualification, specialization, phone, bio) " +
                "VALUES (?, ?, ?, ?, ?, ?)";


        try {

            con = DBConnection.getConnection();

            // Start transaction
            con.setAutoCommit(false);


            // =================================================
            // STEP 1 - INSERT INTO USERS
            // =================================================

            PreparedStatement userPS =
                    con.prepareStatement(
                            userSQL,
                            Statement.RETURN_GENERATED_KEYS
                    );


            userPS.setString(1, name);
            userPS.setString(2, email);
            userPS.setString(3, password);


            int userResult =
                    userPS.executeUpdate();


            if (userResult == 0) {

                con.rollback();

                userPS.close();

                return false;
            }


            // =================================================
            // STEP 2 - GET GENERATED USER ID
            // =================================================

            int userId = 0;

            ResultSet keys =
                    userPS.getGeneratedKeys();


            if (keys.next()) {

                userId = keys.getInt(1);

            } else {

                keys.close();
                userPS.close();

                con.rollback();

                return false;
            }


            keys.close();
            userPS.close();


            // =================================================
            // STEP 3 - INSERT INTO TEACHERS
            // =================================================

            PreparedStatement teacherPS =
                    con.prepareStatement(teacherSQL);


            teacherPS.setString(1, name);
            teacherPS.setInt(2, userId);
            teacherPS.setString(3, qualification);
            teacherPS.setString(4, specialization);
            teacherPS.setString(5, phone);
            teacherPS.setString(6, bio);


            int teacherResult =
                    teacherPS.executeUpdate();


            if (teacherResult == 0) {

                teacherPS.close();

                con.rollback();

                return false;
            }


            teacherPS.close();


            // =================================================
            // EVERYTHING SUCCESSFUL
            // =================================================

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

            } catch (Exception e) {

                e.printStackTrace();
            }
        }
    }


    // =========================================================
    // USER / STUDENT LOGIN
    //
    // Login JSP sends:
    //
    // userName
    // userEmail
    //
    // Database:
    //
    // users.name
    // users.email
    //
    // Role must be STUDENT.
    // =========================================================

    public User loginUser(
            String name,
            String email) {


        String sql =
                "SELECT id, name, email, password, role " +
                "FROM users " +
                "WHERE name = ? " +
                "AND email = ? " +
                "AND role = 'STUDENT'";


        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {


            ps.setString(1, name);
            ps.setString(2, email);


            ResultSet rs =
                    ps.executeQuery();


            if (rs.next()) {


                User user =
                        new User();


                user.setId(
                        rs.getInt("id")
                );


                user.setName(
                        rs.getString("name")
                );


                user.setEmail(
                        rs.getString("email")
                );


                user.setPassword(
                        rs.getString("password")
                );


                user.setRole(
                        rs.getString("role")
                );


                rs.close();


                return user;
            }


            rs.close();


        } catch (Exception e) {

            e.printStackTrace();
        }


        return null;
    }


    // =========================================================
    // TEACHER LOGIN
    //
    // Login JSP sends:
    //
    // teacherName
    // teacherPhone
    //
    // teachers table:
    //
    // teachers.name
    // teachers.phone
    //
    // users table:
    //
    // users.id
    // users.name
    // users.email
    // users.password
    // users.role
    //
    // JOIN:
    //
    // teachers.user_id = users.id
    // =========================================================

    public User loginTeacher(
            String name,
            String phone) {


        String sql =
                "SELECT u.id, u.name, u.email, " +
                "u.password, u.role " +
                "FROM users u " +
                "INNER JOIN teachers t " +
                "ON u.id = t.user_id " +
                "WHERE t.name = ? " +
                "AND t.phone = ? " +
                "AND u.role = 'TEACHER'";


        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {


            ps.setString(1, name);
            ps.setString(2, phone);


            ResultSet rs =
                    ps.executeQuery();


            if (rs.next()) {


                User teacher =
                        new User();


                teacher.setId(
                        rs.getInt("id")
                );


                teacher.setName(
                        rs.getString("name")
                );


                teacher.setEmail(
                        rs.getString("email")
                );


                teacher.setPassword(
                        rs.getString("password")
                );


                teacher.setRole(
                        rs.getString("role")
                );


                rs.close();


                return teacher;
            }


            rs.close();


        } catch (Exception e) {

            e.printStackTrace();
        }


        return null;
    }


    // =========================================================
    // ADMIN LOGIN
    //
    // Admin is NOT stored in users table.
    //
    // Admin table:
    //
    // username
    // password
    // =========================================================

    public boolean loginAdmin(
            String username,
            String password) {


        String sql =
                "SELECT username " +
                "FROM admin " +
                "WHERE username = ? " +
                "AND password = ?";


        try (
                Connection con = DBConnection.getConnection();
                PreparedStatement ps = con.prepareStatement(sql)
        ) {


            ps.setString(1, username);
            ps.setString(2, password);


            ResultSet rs =
                    ps.executeQuery();


            boolean valid =
                    rs.next();


            rs.close();


            return valid;


        } catch (Exception e) {

            e.printStackTrace();

            return false;
        }
    }
}