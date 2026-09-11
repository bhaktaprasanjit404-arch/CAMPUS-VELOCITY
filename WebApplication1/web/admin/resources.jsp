<%-- 
    Document   : resources
    Created on : 9 Sept 2026, 5:41:43?pm
    Author     : User
--%>

<%
    request.setAttribute("pageTitle", "Resources");
%>

<%@ page import="java.util.*" %>

<%@ include file="admin-header.jsp" %>

<div class="page-header">

    <div>
        <h2>Learning Resources</h2>
        <p>Manage PDFs, documents, links and learning materials.</p>
    </div>

    <a href="${pageContext.request.contextPath}/AdminServlet?action=add-resource"
       class="primary-btn">

        <i class="fa-solid fa-plus"></i>
        Add Resource

    </a>

</div>


<div class="admin-panel">

<div class="table-wrapper">

<table class="admin-table">

<thead>

<tr>
    <th>Resource</th>
    <th>Course</th>
    <th>Type</th>
    <th>Uploaded By</th>
    <th>Action</th>
</tr>

</thead>

<tbody>

<%
List<Map<String,Object>> resources =
    (List<Map<String,Object>>)
    request.getAttribute("resources");

if (resources != null && !resources.isEmpty()) {

    for (Map<String,Object> r : resources) {
%>

<tr>

<td>
    <strong><%= r.get("title") %></strong>
</td>

<td>
    <%= r.get("course_title") != null
        ? r.get("course_title") : "General" %>
</td>

<td>
    <span class="status completed">
        <%= r.get("resource_type") %>
    </span>
</td>

<td>
    <%= r.get("uploaded_name") != null
        ? r.get("uploaded_name") : "-" %>
</td>

<td>

<a class="table-action delete"
   href="${pageContext.request.contextPath}/AdminServlet?action=delete-resource&id=<%= r.get("id") %>"
   onclick="return confirm('Delete this resource?');">

    <i class="fa-solid fa-trash"></i>

</a>

</td>

</tr>

<%
    }

} else {
%>

<tr>
<td colspan="5">

<div class="empty-state">

<i class="fa-solid fa-folder-open"></i>

<p>No resources found.</p>

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
