<%-- 
    Document   : enrollments
    Created on : 9 Sept 2026, 5:44:40?pm
    Author     : User
--%>

<%
    request.setAttribute("pageTitle", "Enrollments");
%>

<%@ page import="java.util.*" %>

<%@ include file="admin-header.jsp" %>

<div class="page-header">

<div>

<h2>Enrollment Management</h2>

<p>
Track students enrolled in learning programs.
</p>

</div>

</div>


<div class="admin-panel">

<div class="table-wrapper">

<table class="admin-table">

<thead>

<tr>

<th>Student</th>
<th>Course</th>
<th>Enrollment Date</th>
<th>Progress</th>
<th>Status</th>

</tr>

</thead>


<tbody>

<%
List<Map<String,Object>> enrollments =
    (List<Map<String,Object>>)
    request.getAttribute("enrollments");

if (enrollments != null && !enrollments.isEmpty()) {

    for (Map<String,Object> e : enrollments) {
%>

<tr>

<td>
    <strong>
        <%= e.get("student_name") %>
    </strong>
</td>

<td>
    <%= e.get("course_title") %>
</td>

<td>
    <%= e.get("enrollment_date") %>
</td>

<td>
    <%= e.get("progress") %>%
</td>

<td>

<span class="status <%= 
    "COMPLETED".equals(e.get("status"))
    ? "completed" : "active"
%>">

    <%= e.get("status") %>

</span>

</td>

</tr>

<%
    }

} else {
%>

<tr>

<td colspan="5">

<div class="empty-state">

<i class="fa-solid fa-user-plus"></i>

<p>No enrollments found.</p>

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