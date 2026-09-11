<%-- 
    Document   : courses
    Created on : 9 Sept 2026, 5:39:35?pm
    Author     : User
--%>

<%
    request.setAttribute("pageTitle", "Courses");
%>

<%@ page import="java.util.*" %>

<%@ include file="admin-header.jsp" %>

<div class="page-header">

    <div>
        <h2>Course Management</h2>
        <p>Create, edit and manage learning programs.</p>
    </div>

    <a href="${pageContext.request.contextPath}/AdminServlet?action=add-course"
       class="primary-btn">

        <i class="fa-solid fa-plus"></i>
        Add Course

    </a>

</div>


<div class="admin-panel">

    <div class="panel-heading">

        <h3>All Courses</h3>

    </div>

    <div class="table-wrapper">

        <table class="admin-table">

            <thead>

                <tr>
                    <th>Course</th>
                    <th>Category</th>
                    <th>Level</th>
                    <th>Teacher</th>
                    <th>Price</th>
                    <th>Status</th>
                    <th>Action</th>
                </tr>

            </thead>

            <tbody>

            <%
                List<Map<String,Object>> courses =
                    (List<Map<String,Object>>)
                    request.getAttribute("courses");

                if (courses != null && !courses.isEmpty()) {

                    for (Map<String,Object> c : courses) {
            %>

                <tr>

                    <td>
                        <strong>
                            <%= c.get("title") %>
                        </strong>
                    </td>

                    <td>
                        <%= c.get("category") %>
                    </td>

                    <td>
                        <%= c.get("level") %>
                    </td>

                    <td>
                        <%= c.get("teacher_name") != null
                            ? c.get("teacher_name") : "Not Assigned" %>
                    </td>

                    <td>
                        ?<%= c.get("price") %>
                    </td>

                    <td>

                        <span class="status <%= 
                            "ACTIVE".equals(c.get("status"))
                            ? "active" : "draft"
                        %>">

                            <%= c.get("status") %>

                        </span>

                    </td>

                    <td>

                        <div class="action-buttons">

                            <a class="table-action"
                               href="${pageContext.request.contextPath}/AdminServlet?action=edit-course&id=<%= c.get("id") %>">

                                <i class="fa-solid fa-pen"></i>

                            </a>

                            <a class="table-action delete"
                               href="${pageContext.request.contextPath}/AdminServlet?action=delete-course&id=<%= c.get("id") %>"
                               onclick="return confirm('Delete this course?');">

                                <i class="fa-solid fa-trash"></i>

                            </a>

                        </div>

                    </td>

                </tr>

            <%
                    }

                } else {
            %>

                <tr>
                    <td colspan="7">
                        <div class="empty-state">
                            <i class="fa-solid fa-book-open"></i>
                            <p>No courses available yet.</p>
                        </div>
                    </td>
                </tr>

            <%
                }
            %>

            </tbody>

        </table>

    </div>

</div>

<%@ include file="admin-footer.jsp" %>