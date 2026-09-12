<%-- 
    Document   : reports
    Created on : 9 Sept 2026, 5:44:58?pm
    Author     : User
--%>

<%
    request.setAttribute("pageTitle", "Reports");
%>

<%@ include file="admin-header.jsp" %>


<div class="page-header">

<div>

<h2>Platform Reports</h2>

<p>
Overview of Capacity Connect performance and activity.
</p>

</div>

</div>


<div class="report-grid">


<div class="report-card">

<h3>Total Users</h3>

<div class="report-value">

<%= request.getAttribute("totalUsers") != null
    ? request.getAttribute("totalUsers") : 0 %>

</div>

<p class="report-description">

Total registered accounts across the platform.

</p>

</div>


<div class="report-card">

<h3>Total Enrollments</h3>

<div class="report-value">

<%= request.getAttribute("totalEnrollments") != null
    ? request.getAttribute("totalEnrollments") : 0 %>

</div>

<p class="report-description">

Total student-course enrollments.

</p>

</div>


<div class="report-card">

<h3>Active Courses</h3>

<div class="report-value">

<%= request.getAttribute("activeCourses") != null
    ? request.getAttribute("activeCourses") : 0 %>

</div>

<p class="report-description">

Currently active learning programs.

</p>

</div>


</div>


<div class="admin-panel"
     style="margin-top:20px;">

<div class="panel-heading">

<h3>Course Performance</h3>

</div>


<div class="table-wrapper">

<table class="admin-table">

<thead>

<tr>

<th>Course</th>
<th>Students</th>
<th>Average Progress</th>

</tr>

</thead>


<tbody>

<%
java.util.List<java.util.Map<String,Object>> reportCourses =
    (java.util.List<java.util.Map<String,Object>>)
    request.getAttribute("courseReports");

if (reportCourses != null && !reportCourses.isEmpty()) {

    for (java.util.Map<String,Object> r : reportCourses) {
%>

<tr>

<td>
    <strong>
        <%= r.get("title") %>
    </strong>
</td>

<td>
    <%= r.get("student_count") %>
</td>

<td>
    <%= r.get("avg_progress") != null
        ? r.get("avg_progress") : 0 %>&#37;
</td>

</tr>

<%
    }

} else {
%>

<tr>

<td colspan="3">

<div class="empty-state">

<i class="fa-solid fa-chart-line"></i>

<p>No report data available.</p>

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