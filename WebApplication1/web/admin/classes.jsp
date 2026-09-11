<%-- 
    Document   : classes
    Created on : 9 Sept 2026, 5:44:09?pm
    Author     : User
--%>

<%
    request.setAttribute("pageTitle", "Classes");
%>

<%@ page import="java.util.*" %>

<%@ include file="admin-header.jsp" %>

<div class="page-header">

<div>

<h2>Classes</h2>

<p>
Monitor teaching classes and learner participation.
</p>

</div>

</div>


<div class="admin-panel">

<div class="table-wrapper">

<table class="admin-table">

<thead>

<tr>

<th>Class</th>
<th>Teacher</th>
<th>Level</th>
<th>Students</th>
<th>Status</th>

</tr>

</thead>


<tbody>

<%
List<Map<String,Object>> classes =
    (List<Map<String,Object>>)
    request.getAttribute("classes");

if (classes != null && !classes.isEmpty()) {

    for (Map<String,Object> c : classes) {
%>

<tr>

<td>

<strong>
    <%= c.get("title") %>
</strong>

</td>

<td>
    <%= c.get("teacher_name") != null
        ? c.get("teacher_name") : "Not Assigned" %>
</td>

<td>
    <%= c.get("level") %>
</td>

<td>
    <strong>
        <%= c.get("student_count") %>
    </strong>
</td>

<td>

<span class="status active">
    <%= c.get("status") %>
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

<i class="fa-solid fa-school"></i>

<p>No classes available.</p>

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