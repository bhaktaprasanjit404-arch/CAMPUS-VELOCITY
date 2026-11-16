package com.capacityconnect.controller;

import com.capacityconnect.dao.CourseDAO;
import com.capacityconnect.model.Course;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

import java.io.IOException;
import java.util.List;

@WebServlet("/CourseServlet")
public class CourseServlet extends HttpServlet {

    private CourseDAO courseDAO;


    @Override
    public void init() {

        courseDAO = new CourseDAO();
    }


    @Override
    protected void doGet(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {


        String action = request.getParameter("action");


        if (action == null || action.isEmpty()) {

            action = "list";
        }


        switch (action) {

            case "list":

                listCourses(request, response);

                break;


            case "details":

                courseDetails(request, response);

                break;


            case "search":

                searchCourses(request, response);

                break;


            default:

                listCourses(request, response);

                break;
        }
    }


    /* =====================================================
       COURSE LIST
       ===================================================== */

    private void listCourses(HttpServletRequest request,
                             HttpServletResponse response)
            throws ServletException, IOException {


        List<Course> courses =
                courseDAO.getAllCourses();


        request.setAttribute("courses", courses);


        request.getRequestDispatcher("courses.jsp")
                .forward(request, response);
    }


    /* =====================================================
       COURSE DETAILS
       ===================================================== */

    private void courseDetails(HttpServletRequest request,
                               HttpServletResponse response)
            throws ServletException, IOException {


        String id = request.getParameter("id");


        if (id == null || id.isEmpty()) {

            response.sendRedirect("CourseServlet?action=list");

            return;
        }


        try {

            int courseId = Integer.parseInt(id);


            Course course =
                    courseDAO.getCourseById(courseId);


            if (course == null) {

                response.sendRedirect("CourseServlet?action=list");

                return;
            }


            request.setAttribute("course", course);


            request.getRequestDispatcher("course-details.jsp")
                    .forward(request, response);


        } catch (NumberFormatException e) {

            response.sendRedirect("CourseServlet?action=list");
        }
    }


    /* =====================================================
       SEARCH
       ===================================================== */

    private void searchCourses(HttpServletRequest request,
                               HttpServletResponse response)
            throws ServletException, IOException {


        String keyword =
                request.getParameter("keyword");


        if (keyword == null) {

            keyword = "";
        }


        List<Course> courses =
                courseDAO.searchCourses(keyword);


        request.setAttribute("courses", courses);

        request.setAttribute("searchKeyword", keyword);


        request.getRequestDispatcher("courses.jsp")
                .forward(request, response);
    }


    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        doGet(request, response);
    }
}