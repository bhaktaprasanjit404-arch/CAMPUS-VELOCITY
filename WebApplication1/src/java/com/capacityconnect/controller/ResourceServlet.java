/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package com.capacityconnect.controller;

import com.capacityconnect.dao.ResourceDAO;
import com.capacityconnect.model.Resource;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.net.URI;
import java.sql.SQLException;
import java.util.Collections;
import java.util.List;

@WebServlet(name = "ResourceServlet", urlPatterns = {"/ResourceServlet"})
public class ResourceServlet extends HttpServlet {

    private ResourceDAO resourceDAO;

    @Override
    public void init() throws ServletException {
        resourceDAO = new ResourceDAO();
    }

    @Override
    protected void doGet(HttpServletRequest request,
                         HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        String action = request.getParameter("action");

        if ("open".equalsIgnoreCase(action)) {
            openResource(request, response);
            return;
        }

        listResources(request, response);
    }

    private void listResources(HttpServletRequest request,
                               HttpServletResponse response)
            throws ServletException, IOException {

        String search = request.getParameter("search");
        String category = request.getParameter("category");
        String type = request.getParameter("type");

        try {
            List<Resource> resources =
                    resourceDAO.getResources(search, category, type);

            List<String> categories = resourceDAO.getCategories();

            int totalResources = resourceDAO.getResourceCount();

            request.setAttribute("resources", resources);
            request.setAttribute("categories", categories);
            request.setAttribute("totalResources", totalResources);

            request.setAttribute("searchTerm",
                    search == null ? "" : search);

            request.setAttribute("selectedCategory",
                    category == null ? "All" : category);

            request.setAttribute("selectedType",
                    type == null ? "All" : type);

            request.getRequestDispatcher("/resources.jsp")
                   .forward(request, response);

        } catch (SQLException e) {

            getServletContext().log(
                    "Unable to load learning resources.", e);

            request.setAttribute(
                    "resourceError",
                    "Resources could not be loaded. Please try again."
            );

            request.setAttribute("resources",
                    Collections.emptyList());

            request.setAttribute("categories",
                    Collections.emptyList());

            request.setAttribute("totalResources", 0);

            request.setAttribute("searchTerm",
                    search == null ? "" : search);

            request.setAttribute("selectedCategory",
                    category == null ? "All" : category);

            request.setAttribute("selectedType",
                    type == null ? "All" : type);

            request.getRequestDispatcher("/resources.jsp")
                   .forward(request, response);
        }
    }

    private void openResource(HttpServletRequest request,
                              HttpServletResponse response)
            throws ServletException, IOException {

        String idValue = request.getParameter("id");

        if (idValue == null || !idValue.matches("\\d+")) {
            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid resource ID."
            );
            return;
        }

        try {
            int id = Integer.parseInt(idValue);

            Resource resource = resourceDAO.getResourceById(id);

            if (resource == null) {
                response.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "Resource not found."
                );
                return;
            }

            String fileUrl = resource.getFileUrl();

            if (fileUrl == null || fileUrl.trim().isEmpty()) {
                response.sendError(
                        HttpServletResponse.SC_NOT_FOUND,
                        "This resource has no available file."
                );
                return;
            }

            fileUrl = fileUrl.trim();

            /*
             * Allow local application paths and HTTP/HTTPS links.
             * Reject other protocols such as javascript: and file:.
             */
            if (fileUrl.startsWith("/")
                    && !fileUrl.startsWith("//")
                    && !fileUrl.startsWith("/\\")) {

                response.sendRedirect(
                        request.getContextPath() + fileUrl
                );
                return;
            }

            URI uri;

            try {
                uri = URI.create(fileUrl);
            } catch (IllegalArgumentException ex) {
                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Invalid resource URL."
                );
                return;
            }

            String scheme = uri.getScheme();

            if (scheme == null
                    || !(scheme.equalsIgnoreCase("https")
                    || scheme.equalsIgnoreCase("http"))
                    || uri.getHost() == null) {

                response.sendError(
                        HttpServletResponse.SC_BAD_REQUEST,
                        "Only valid HTTP or HTTPS resource links are allowed."
                );
                return;
            }

            response.sendRedirect(uri.toASCIIString());

        } catch (NumberFormatException e) {

            response.sendError(
                    HttpServletResponse.SC_BAD_REQUEST,
                    "Invalid resource ID."
            );

        } catch (SQLException e) {

            getServletContext().log(
                    "Unable to open learning resource.", e);

            response.sendError(
                    HttpServletResponse.SC_INTERNAL_SERVER_ERROR,
                    "Unable to open this resource right now."
            );
        }
    }

    @Override
    protected void doPost(HttpServletRequest request,
                          HttpServletResponse response)
            throws ServletException, IOException {

        doGet(request, response);
    }
}