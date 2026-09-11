<%-- 
    Document   : teachers
    Created on : 9 Sept 2026, 5:38:52?pm
    Author     : User
--%>

<%
    request.setAttribute("pageTitle", "Teachers");
%>

<%@ page import="java.util.*" %>

<%@ include file="admin-header.jsp" %>

<div class="page-header">

    <div>
        <h2>Teacher Management</h2>
        <p>Manage instructors and their teaching profiles.</p>
    </div>

</div>


<div class="admin-panel">

<div class="table-wrapper">

<table class="admin-table">

<thead>

<tr>
    <th>Teacher</th>
    <th>Email</th>
    <th>Qualification</th>
    <th>Specialization</th>
    <th>Phone</th>
</tr>

</thead>

<tbody>

<%
List<Map<String,Object>> teachers =
    (List<Map<String,Object>>)
    request.getAttribute("teacherList");

if (teachers != null && !teachers.isEmpty()) {

    for (Map<String,Object> t : teachers) {
%>

<tr>

<td>

<div class="table-user">

<div class="table-avatar">
    <i class="fa-solid fa-chalkboard-user"></i>
</div>

<strong>
    <%= t.get("name") %>
</strong>

</div>

</td>

<td><%= t.get("email") %></td>

<td>
    <%= t.get("qualification") != null
        ? t.get("qualification") : "-" %>
</td>

<td>
    <%= t.get("specialization") != null
        ? t.get("specialization") : "-" %>
</td>

<td>
    <%= t.get("phone") != null
        ? t.get("phone") : "-" %>
</td>

</tr>

<%
    }

} else {
%>

<tr>
<td colspan="5">

<div class="empty-state">

<i class="fa-solid fa-chalkboard-user"></i>

<p>No teacher profiles found.</p>

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