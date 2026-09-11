<%-- 
    Document   : add-resource
    Created on : 9 Sept 2026, 5:43:33?pm
    Author     : User
--%>

<%
    request.setAttribute("pageTitle", "Add Resource");
%>

<%@ page import="java.util.*" %>

<%@ include file="admin-header.jsp" %>

<div class="page-header">

    <div>
        <h2>Add Learning Resource</h2>

        <p>
            Add a document, PDF or external learning link.
        </p>
    </div>

</div>


<div class="form-panel">

<form method="post"
      action="${pageContext.request.contextPath}/AdminServlet">


<input type="hidden"
       name="action"
       value="add-resource">


<div class="form-grid">


<div class="form-group">

<label class="form-label">
    Resource Title
</label>

<input class="form-control"
       type="text"
       name="title"
       placeholder="e.g. Java Programming Notes"
       required>

</div>


<div class="form-group">

<label class="form-label">
    Resource Type
</label>

<select class="form-control"
        name="resource_type">

<option value="PDF">PDF</option>

<option value="DOCUMENT">
    Document
</option>

<option value="LINK">
    Link
</option>

<option value="OTHER">
    Other
</option>

</select>

</div>


<div class="form-group">

<label class="form-label">
    Course
</label>

<select class="form-control"
        name="course_id">

<option value="">
    General Resource
</option>

<%
List<Map<String,Object>> courseList =
    (List<Map<String,Object>>)
    request.getAttribute("courses");

if (courseList != null) {

    for (Map<String,Object> c : courseList) {
%>

<option value="<%= c.get("id") %>">
    <%= c.get("title") %>
</option>

<%
    }
}
%>

</select>

</div>


<div class="form-group">

<label class="form-label">
    Resource URL
</label>

<input class="form-control"
       type="text"
       name="resource_url"
       placeholder="https://..."
       required>

</div>


<div class="form-group full">

<label class="form-label">
    Description
</label>

<textarea class="form-control"
          name="description"
          placeholder="Describe this resource..."></textarea>

</div>


</div>


<div class="form-actions">

<a href="${pageContext.request.contextPath}/AdminServlet?action=resources"
   class="secondary-btn">

    Cancel

</a>

<button class="primary-btn"
        type="submit">

    <i class="fa-solid fa-cloud-arrow-up"></i>

    Add Resource

</button>

</div>


</form>

</div>


<%@ include file="admin-footer.jsp" %>