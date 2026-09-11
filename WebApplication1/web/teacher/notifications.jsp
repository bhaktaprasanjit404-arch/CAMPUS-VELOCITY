<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="com.capacityconnect.model.Teacher" %>

<%
    Teacher teacher =
        (Teacher) request.getAttribute("teacher");

    List<String[]> assignments =
        (List<String[]>) request.getAttribute("assignments");
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Notifications | Capacity Connect</title>

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/teacher.css">

</head>

<body>

<div class="teacher-layout">

<aside class="teacher-sidebar">

    <div class="teacher-brand">

        <div class="teacher-brand-icon">
            <i class="fa-solid fa-layer-group"></i>
        </div>

        <div>
            <strong>CAPACITY</strong>
            <span>CONNECT</span>
        </div>

    </div>

    <nav class="teacher-nav">

        <a href="${pageContext.request.contextPath}/TeacherServlet?action=dashboard"
           class="teacher-nav-link">
            <i class="fa-solid fa-grid-2"></i> Dashboard
        </a>

        <a href="${pageContext.request.contextPath}/TeacherServlet?action=courses"
           class="teacher-nav-link">
            <i class="fa-solid fa-book-open"></i> My Courses
        </a>

        <a href="${pageContext.request.contextPath}/TeacherServlet?action=students"
           class="teacher-nav-link">
            <i class="fa-solid fa-users"></i> Students
        </a>

        <a href="${pageContext.request.contextPath}/TeacherServlet?action=attendance"
           class="teacher-nav-link">
            <i class="fa-solid fa-calendar-check"></i> Attendance
        </a>

        <a href="${pageContext.request.contextPath}/TeacherServlet?action=progress"
           class="teacher-nav-link">
            <i class="fa-solid fa-chart-line"></i> Student Progress
        </a>

        <a href="${pageContext.request.contextPath}/TeacherServlet?action=performance"
           class="teacher-nav-link">
            <i class="fa-solid fa-ranking-star"></i> Performance
        </a>

        <a href="${pageContext.request.contextPath}/TeacherServlet?action=notifications"
           class="teacher-nav-link active">
            <i class="fa-solid fa-bell"></i> Notifications
        </a>

        <a href="${pageContext.request.contextPath}/TeacherServlet?action=profile"
           class="teacher-nav-link">
            <i class="fa-solid fa-user-circle"></i> Profile
        </a>

    </nav>

    <div class="sidebar-bottom">

        <a href="${pageContext.request.contextPath}/LogoutServlet"
           class="logout-link">
            <i class="fa-solid fa-right-from-bracket"></i>
            Logout
        </a>

    </div>

</aside>


<main class="teacher-main">

<header class="teacher-topbar">

    <div>

        <span class="topbar-label">
            TEACHER PORTAL
        </span>

        <h1>Notifications</h1>

    </div>

    <div class="mini-avatar">
        <%= teacher.getName().substring(0,1).toUpperCase() %>
    </div>

</header>


<section class="page-intro">

    <span>UPDATES & ACTIVITY</span>

    <h2>Recent Activity</h2>

    <p>
        Stay updated with your latest learning activities.
    </p>

</section>


<div class="notification-list">

<%
    if (assignments != null &&
        !assignments.isEmpty()) {

        for (String[] a : assignments) {
%>

<div class="notification-card">

    <div class="notification-icon">

        <i class="fa-solid fa-file-circle-plus"></i>

    </div>

    <div class="notification-content">

        <span>ASSIGNMENT</span>

        <h3>
            <%= a[0] %>
        </h3>

        <p>
            Course: <strong><%= a[1] %></strong>
        </p>

        <small>
            Due: <%= a[2] %>
        </small>

    </div>

</div>

<%
        }

    } else {
%>

<div class="empty-state">

    <i class="fa-solid fa-bell-slash"></i>

    <h3>No new notifications</h3>

    <p>
        You are all caught up.
    </p>

</div>

<%
    }
%>

</div>

</main>

</div>

</body>
</html>