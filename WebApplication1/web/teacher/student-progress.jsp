<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="com.capacityconnect.model.Teacher" %>

<%
    Teacher teacher =
        (Teacher) request.getAttribute("teacher");

    List<String[]> progress =
        (List<String[]>) request.getAttribute("progress");
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Student Progress | Capacity Connect</title>

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
           class="teacher-nav-link active">
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
        <span class="topbar-label">ANALYTICS</span>
        <h1>Student Progress</h1>
    </div>

    <div class="mini-avatar">
        <%= teacher.getName().substring(0,1).toUpperCase() %>
    </div>

</header>


<section class="page-intro">

    <span>LEARNING ANALYTICS</span>

    <h2>Track Student Progress</h2>

    <p>
        Understand how learners are progressing through your courses.
    </p>

</section>


<div class="table-card">

    <div class="table-header">

        <div>
            <h3>Progress Overview</h3>
            <p>Real-time enrollment progress</p>
        </div>

        <div class="table-icon">
            <i class="fa-solid fa-chart-line"></i>
        </div>

    </div>


    <div class="table-responsive">

        <table class="teacher-table">

            <thead>

            <tr>

                <th>Student</th>
                <th>Email</th>
                <th>Course</th>
                <th>Progress</th>
                <th>Status</th>

            </tr>

            </thead>

            <tbody>

            <%
                if (progress != null && !progress.isEmpty()) {

                    for (String[] p : progress) {
            %>

            <tr>

                <td>
                    <strong><%= p[0] %></strong>
                </td>

                <td><%= p[1] %></td>

                <td><%= p[2] %></td>

                <td>

                    <div class="progress-wrapper">

                        <div class="progress-bar-small">

                            <span style="width:<%= p[3] %>%"></span>

                        </div>

                        <small><%= p[3] %>%</small>

                    </div>

                </td>

                <td>
                    <span class="status-badge">
                        <%= p[4] %>
                    </span>
                </td>

            </tr>

            <%
                    }

                } else {
            %>

            <tr>

                <td colspan="5"
                    class="empty-table">

                    No progress data available.

                </td>

            </tr>

            <%
                }
            %>

            </tbody>

        </table>

    </div>

</div>

</main>

</div>

</body>
</html>