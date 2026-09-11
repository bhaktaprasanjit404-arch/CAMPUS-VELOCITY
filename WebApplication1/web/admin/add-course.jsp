<%-- 
    Document   : add-course
    Created on : 9 Sept 2026, 5:40:38?pm
    Author     : User
--%>

<%
    request.setAttribute("pageTitle", "Add Course");
%>

<%@ page import="java.util.*" %>

<%@ include file="admin-header.jsp" %>

<div class="page-header">

    <div>
        <h2>Create New Course</h2>

        <p>
            Add a new learning program to Capacity Connect.
        </p>
    </div>

</div>


<div class="form-panel">

<form method="post"
      action="${pageContext.request.contextPath}/AdminServlet">

<input type="hidden"
       name="action"
       value="add-course">


<div class="form-grid">


    <div class="form-group">

        <label class="form-label">
            Course Title
        </label>

        <input class="form-control"
               type="text"
               name="title"
               placeholder="e.g. Full Stack Web Development"
               required>

    </div>


    <div class="form-group">

        <label class="form-label">
            Category
        </label>

        <input class="form-control"
               type="text"
               name="category"
               placeholder="e.g. Programming"
               required>

    </div>


    <div class="form-group full">

        <label class="form-label">
            Description
        </label>

        <textarea class="form-control"
                  name="description"
                  placeholder="Describe this course..."
                  required></textarea>

    </div>


    <div class="form-group">

        <label class="form-label">
            Level
        </label>

        <select class="form-control"
                name="level">

            <option value="BEGINNER">
                Beginner
            </option>

            <option value="INTERMEDIATE">
                Intermediate
            </option>

            <option value="ADVANCED">
                Advanced
            </option>

        </select>

    </div>


    <div class="form-group">

        <label class="form-label">
            Duration
        </label>

        <input class="form-control"
               type="text"
               name="duration"
               placeholder="e.g. 8 Weeks">

    </div>


    <div class="form-group">

        <label class="form-label">
            Price
        </label>

        <input class="form-control"
               type="number"
               step="0.01"
               name="price"
               value="0">

    </div>


    <div class="form-group">

        <label class="form-label">
            Thumbnail URL
        </label>

        <input class="form-control"
               type="text"
               name="thumbnail"
               placeholder="https://...">

    </div>


    <div class="form-group">

        <label class="form-label">
            Assign Teacher
        </label>

        <select class="form-control"
                name="teacher_id">

            <option value="">
                No Teacher Assigned
            </option>

            <%
                List<Map<String,Object>> teachers =
                    (List<Map<String,Object>>)
                    request.getAttribute("teachers");

                if (teachers != null) {

                    for (Map<String,Object> t : teachers) {
            %>

                <option value="<%= t.get("id") %>">
                    <%= t.get("name") %>
                </option>

            <%
                    }
                }
            %>

        </select>

    </div>


    <div class="form-group">

        <label class="form-label">
            Status
        </label>

        <select class="form-control"
                name="status">

            <option value="DRAFT">
                Draft
            </option>

            <option value="ACTIVE">
                Active
            </option>

            <option value="INACTIVE">
                Inactive
            </option>

        </select>

    </div>

</div>


<div class="form-actions">

    <a href="${pageContext.request.contextPath}/AdminServlet?action=courses"
       class="secondary-btn">

        Cancel

    </a>

    <button type="submit"
            class="primary-btn">

        <i class="fa-solid fa-check"></i>
        Create Course

    </button>

</div>

</form>

</div>


<%@ include file="admin-footer.jsp" %>