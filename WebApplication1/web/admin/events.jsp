<%-- 
    Document   : events
    Created on : 9 Sept 2026, 5:43:50?pm
    Author     : User
--%>

<%
    request.setAttribute("pageTitle", "Events");
%>

<%@ page import="java.util.*" %>

<%@ include file="admin-header.jsp" %>

<div class="page-header">

<div>

<h2>Events</h2>

<p>
Manage workshops, seminars and platform events.
</p>

</div>

</div>


<div class="form-panel"
     style="margin-bottom:20px;">

<form method="post"
      action="${pageContext.request.contextPath}/AdminServlet">

<input type="hidden"
       name="action"
       value="add-event">


<div class="form-grid">


<div class="form-group">

<label class="form-label">
    Event Title
</label>

<input class="form-control"
       name="title"
       required
       placeholder="e.g. Career Development Workshop">

</div>


<div class="form-group">

<label class="form-label">
    Date
</label>

<input class="form-control"
       type="date"
       name="event_date"
       required>

</div>


<div class="form-group">

<label class="form-label">
    Time
</label>

<input class="form-control"
       type="time"
       name="event_time">

</div>


<div class="form-group">

<label class="form-label">
    Location
</label>

<input class="form-control"
       name="location"
       placeholder="Online / Campus">

</div>


<div class="form-group full">

<label class="form-label">
    Description
</label>

<textarea class="form-control"
          name="description"></textarea>

</div>


</div>


<div class="form-actions">

<button class="primary-btn"
        type="submit">

<i class="fa-solid fa-calendar-plus"></i>

Create Event

</button>

</div>

</form>

</div>


<div class="admin-panel">

<div class="panel-heading">

<h3>Upcoming & Previous Events</h3>

</div>


<div class="table-wrapper">

<table class="admin-table">

<thead>

<tr>
<th>Event</th>
<th>Date</th>
<th>Time</th>
<th>Location</th>
<th>Action</th>
</tr>

</thead>


<tbody>

<%
List<Map<String,Object>> events =
    (List<Map<String,Object>>)
    request.getAttribute("events");

if (events != null && !events.isEmpty()) {

    for (Map<String,Object> e : events) {
%>

<tr>

<td>
    <strong><%= e.get("title") %></strong>
</td>

<td>
    <%= e.get("event_date") %>
</td>

<td>
    <%= e.get("event_time") != null
        ? e.get("event_time") : "-" %>
</td>

<td>
    <%= e.get("location") != null
        ? e.get("location") : "-" %>
</td>

<td>

<a class="table-action delete"
   href="${pageContext.request.contextPath}/AdminServlet?action=delete-event&id=<%= e.get("id") %>"
   onclick="return confirm('Delete this event?');">

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

<i class="fa-solid fa-calendar-days"></i>

<p>No events found.</p>

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
