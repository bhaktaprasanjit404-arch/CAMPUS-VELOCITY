<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="com.capacityconnect.model.Teacher" %>

<%
    Teacher teacher =
        (Teacher) request.getAttribute("teacher");

    List<String[]> courses =
        (List<String[]>) request.getAttribute("courses");
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Class Details | Capacity Connect</title>

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
           class="teacher-nav-link">
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
            CLASSROOM
        </span>

        <h1>Class Details</h1>

    </div>

</header>


<section class="page-intro">

    <span>YOUR LEARNING PROGRAMS</span>

    <h2>Class Overview</h2>

    <p>
        Select a course to manage and view classroom information.
    </p>

</section>


<div class="class-detail-grid">

<%
    if (courses != null && !courses.isEmpty()) {

        for (String[] c : courses) {
%>

<div class="class-detail-card">

    <div class="class-icon">

        <i class="fa-solid fa-chalkboard"></i>

    </div>

    <span class="course-status">
        <%= c[5] %>
    </span>

    <h3>
        <%= c[1] %>
    </h3>

    <p>
        <%= c[2] %>
    </p>

    <div class="class-meta">

        <span>
            <i class="fa-solid fa-signal"></i>
            <%= c[3] %>
        </span>

        <span>
            <i class="fa-regular fa-clock"></i>
            <%= c[4] %>
        </span>

    </div>

    <a href="${pageContext.request.contextPath}/TeacherServlet?action=students"
       class="teacher-view-btn">

        View Learners
        <i class="fa-solid fa-arrow-right"></i>

    </a>

</div>

<%
        }

    } else {
%>

<div class="empty-state">

    <i class="fa-solid fa-chalkboard"></i>

    <h3>No classes available</h3>

    <p>
        Courses assigned to you will appear here.
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