/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package com.capacityconnect.dao;

import com.capacityconnect.db.DBConnection;
import com.capacityconnect.model.Course;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class CourseDAO {


    /* =====================================================
       GET ALL ACTIVE COURSES
       ===================================================== */

    public List<Course> getAllCourses() {

        List<Course> courses = new ArrayList<>();

        String sql =
                "SELECT id, title, category, description, level, " +
                "duration, price, thumbnail, teacher_id, status " +
                "FROM courses " +
                "WHERE status = 'ACTIVE' " +
                "ORDER BY id DESC";


        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery()) {


            while (rs.next()) {

                Course course = new Course();

                course.setId(rs.getInt("id"));
                course.setTitle(rs.getString("title"));
                course.setCategory(rs.getString("category"));
                course.setDescription(rs.getString("description"));
                course.setLevel(rs.getString("level"));
                course.setDuration(rs.getString("duration"));
                course.setPrice(rs.getDouble("price"));
                course.setThumbnail(rs.getString("thumbnail"));
                course.setTeacherId(rs.getInt("teacher_id"));
                course.setStatus(rs.getString("status"));

                courses.add(course);
            }


        } catch (Exception e) {

            e.printStackTrace();
        }


        return courses;
    }


    /* =====================================================
       SEARCH COURSES
       ===================================================== */

    public List<Course> searchCourses(String keyword) {

        List<Course> courses = new ArrayList<>();

        String sql =
                "SELECT id, title, category, description, level, " +
                "duration, price, thumbnail, teacher_id, status " +
                "FROM courses " +
                "WHERE status = 'ACTIVE' " +
                "AND (title LIKE ? OR category LIKE ? OR description LIKE ?) " +
                "ORDER BY id DESC";


        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {


            String search = "%" + keyword + "%";

            ps.setString(1, search);
            ps.setString(2, search);
            ps.setString(3, search);


            try (ResultSet rs = ps.executeQuery()) {

                while (rs.next()) {

                    Course course = new Course();

                    course.setId(rs.getInt("id"));
                    course.setTitle(rs.getString("title"));
                    course.setCategory(rs.getString("category"));
                    course.setDescription(rs.getString("description"));
                    course.setLevel(rs.getString("level"));
                    course.setDuration(rs.getString("duration"));
                    course.setPrice(rs.getDouble("price"));
                    course.setThumbnail(rs.getString("thumbnail"));
                    course.setTeacherId(rs.getInt("teacher_id"));
                    course.setStatus(rs.getString("status"));

                    courses.add(course);
                }
            }


        } catch (Exception e) {

            e.printStackTrace();
        }


        return courses;
    }


    /* =====================================================
       GET COURSE BY ID
       ===================================================== */

    public Course getCourseById(int id) {

        Course course = null;


        String sql =
                "SELECT id, title, category, description, level, " +
                "duration, price, thumbnail, teacher_id, status " +
                "FROM courses " +
                "WHERE id = ?";


        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)) {


            ps.setInt(1, id);


            try (ResultSet rs = ps.executeQuery()) {

                if (rs.next()) {

                    course = new Course();

                    course.setId(rs.getInt("id"));
                    course.setTitle(rs.getString("title"));
                    course.setCategory(rs.getString("category"));
                    course.setDescription(rs.getString("description"));
                    course.setLevel(rs.getString("level"));
                    course.setDuration(rs.getString("duration"));
                    course.setPrice(rs.getDouble("price"));
                    course.setThumbnail(rs.getString("thumbnail"));
                    course.setTeacherId(rs.getInt("teacher_id"));
                    course.setStatus(rs.getString("status"));
                }
            }


        } catch (Exception e) {

            e.printStackTrace();
        }


        return course;
    }
}