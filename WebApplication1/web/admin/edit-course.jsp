<%-- 
    Document   : edit-course
    Created on : 9 Sept 2026, 5:41:05?pm
    Author     : User
--%>

<%
    request.setAttribute("pageTitle", "Edit Course");
%>

<%@ page import="java.util.*" %>

<%@ include file="admin-header.jsp" %>

<%
    Map<String,Object> course =
        (Map<String,Object>) request.getAttribute("course");
%>

<div class="page-header">

    <div>
        <h2>Edit Course</h2>
        <p>Update course information and settings.</p>
    </div>

</div>


<div class="form-panel">

<form method="post"
      action="${pageContext.request.contextPath}/AdminServlet">

<input type="hidden"
       name="action"
       value="edit-course">

<input type="hidden"
       name="id"
       value="<%= course.get("id") %>">


<div class="form-grid">


    <div class="form-group">

        <label class="form-label">
            Course Title
        </label>

        <input class="form-control"
               type="text"
               name="title"
               value="<%= course.get("title") %>"
               required>

    </div>


    <div class="form-group">

        <label class="form-label">
            Category
        </label>

        <input class="form-control"
               type="text"
               name="category"
               value="<%= course.get("category") %>"
               required>

    </div>


    <div class="form-group full">

        <label class="form-label">
            Description
        </label>

        <textarea class="form-control"
                  name="description"
                  required><%= course.get("description") != null
                  ? course.get("description") : "" %></textarea>

    </div>


    <div class="form-group">

        <label class="form-label">
            Level
        </label>

        <select class="form-control"
                name="level">

            <option value="BEGINNER"
                <%= "BEGINNER".equals(course.get("level"))
                    ? "selected" : "" %>>
                Beginner
            </option>

            <option value="INTERMEDIATE"
                <%= "INTERMEDIATE".equals(course.get("level"))
                    ? "selected" : "" %>>
                Intermediate
            </option>

            <option value="ADVANCED"
                <%= "ADVANCED".equals(course.get("level"))
                    ? "selected" : "" %>>
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
               value="<%= course.get("duration") != null
                   ? course.get("duration") : "" %>">

    </div>


    <div class="form-group">

        <label class="form-label">
            Price
        </label>

        <input class="form-control"
               type="number"
               step="0.01"
               name="price"
               value="<%= course.get("price") %>">

    </div>


    <div class="form-group">

        <label class="form-label">
            Thumbnail URL
        </label>

        <input class="form-control"
               type="text"
               name="thumbnail"
               value="<%= course.get("thumbnail") != null
                   ? course.get("thumbnail") : "" %>">

    </div>


    <div class="form-group">

        <label class="form-label">
            Status
        </label>

        <select class="form-control"
                name="status">

            <option value="ACTIVE"
                <%= "ACTIVE".equals(course.get("status"))
                    ? "selected" : "" %>>
                Active
            </option>

            <option value="INACTIVE"
                <%= "INACTIVE".equals(course.get("status"))
                    ? "selected" : "" %>>
                Inactive
            </option>

            <option value="DRAFT"
                <%= "DRAFT".equals(course.get("status"))
                    ? "selected" : "" %>>
                Draft
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

        <i class="fa-solid fa-floppy-disk"></i>
        Save Changes

    </button>

</div>

</form>

</div>


<%@ include file="admin-footer.jsp" %>