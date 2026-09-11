<%-- 
    Document   : users
    Created on : 9 Sept 2026, 5:38:29?pm
    Author     : User
--%>

<%
    request.setAttribute("pageTitle", "Users");
%>

<%@ page import="java.util.*" %>

<%@ include file="admin-header.jsp" %>

<div class="page-header">

    <div>
        <h2>User Management</h2>
        <p>View registered students, teachers and administrators.</p>
    </div>

</div>


<div class="admin-panel">

<div class="table-wrapper">

<table class="admin-table">

<thead>

<tr>
    <th>User</th>
    <th>Email</th>
    <th>Role</th>
    <th>Created</th>
</tr>

</thead>

<tbody>

<%
List<Map<String,Object>> users =
    (List<Map<String,Object>>)
    request.getAttribute("users");

if (users != null && !users.isEmpty()) {

    for (Map<String,Object> u : users) {
%>

<tr>

<td>

<div class="table-user">

    <div class="table-avatar">
        <%= u.get("name").toString().substring(0,1).toUpperCase() %>
    </div>

    <strong>
        <%= u.get("name") %>
    </strong>

</div>

</td>

<td>
    <%= u.get("email") %>
</td>

<td>

<span class="status active">
    <%= u.get("role") %>
</span>

</td>

<td>
    <%= u.get("created_at") %>
</td>

</tr>

<%
    }

} else {
%>

<tr>
<td colspan="4">

<div class="empty-state">

<i class="fa-solid fa-users"></i>

<p>No users found.</p>

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