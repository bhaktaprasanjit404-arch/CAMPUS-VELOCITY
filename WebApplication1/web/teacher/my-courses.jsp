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

    <title>My Courses | Capacity Connect</title>

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
           class="teacher-nav-link active">
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
            <span class="topbar-label">TEACHER PORTAL</span>
            <h1>My Courses</h1>
        </div>

        <div class="mini-avatar">
            <%= teacher.getName().substring(0,1).toUpperCase() %>
        </div>

    </header>


    <section class="page-intro">

        <span>LEARNING PROGRAMS</span>

        <h2>Your Courses</h2>

        <p>
            Manage and monitor the courses assigned to you.
        </p>

    </section>


    <div class="course-teacher-grid">

        <%
            if (courses != null && !courses.isEmpty()) {

                for (String[] c : courses) {
        %>

        <div class="teacher-course-card">

            <div class="teacher-course-icon">
                <i class="fa-solid fa-book-open"></i>
            </div>

            <div class="course-status">
                <%= c[5] %>
            </div>

            <h3><%= c[1] %></h3>

            <p>
                <%= c[2] %> • <%= c[3] %>
            </p>

            <div class="course-detail-row">

                <span>
                    <i class="fa-regular fa-clock"></i>
                    <%= c[4] %>
                </span>

            </div>

            <a href="${pageContext.request.contextPath}/TeacherServlet?action=class-details&courseId=<%= c[0] %>"
               class="teacher-view-btn">

                View Class
                <i class="fa-solid fa-arrow-right"></i>

            </a>

        </div>

        <%
                }

            } else {
        %>

        <div class="empty-state">

            <i class="fa-solid fa-book-open"></i>

            <h3>No courses assigned yet</h3>

            <p>
                Your assigned courses will appear here.
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