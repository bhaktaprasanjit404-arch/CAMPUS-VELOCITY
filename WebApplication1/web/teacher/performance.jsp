<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="com.capacityconnect.model.Teacher" %>

<%
    Teacher teacher =
        (Teacher) request.getAttribute("teacher");

    if (teacher == null) {
        response.sendRedirect(request.getContextPath() + "/TeacherServlet?action=performance");
        return;
    }

    List<String[]> performance =
        (List<String[]>) request.getAttribute("performance");
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Performance | Capacity Connect</title>

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
            <i class="fa-solid fa-grid-2"></i>
            Dashboard
        </a>

        <a href="${pageContext.request.contextPath}/TeacherServlet?action=courses"
           class="teacher-nav-link">
            <i class="fa-solid fa-book-open"></i>
            My Courses
        </a>

        <a href="${pageContext.request.contextPath}/TeacherServlet?action=students"
           class="teacher-nav-link">
            <i class="fa-solid fa-users"></i>
            Students
        </a>

        <a href="${pageContext.request.contextPath}/TeacherServlet?action=attendance"
           class="teacher-nav-link">
            <i class="fa-solid fa-calendar-check"></i>
            Attendance
        </a>

        <a href="${pageContext.request.contextPath}/TeacherServlet?action=progress"
           class="teacher-nav-link">
            <i class="fa-solid fa-chart-line"></i>
            Student Progress
        </a>

        <a href="${pageContext.request.contextPath}/TeacherServlet?action=performance"
           class="teacher-nav-link active">
            <i class="fa-solid fa-ranking-star"></i>
            Performance
        </a>

        <a href="${pageContext.request.contextPath}/TeacherServlet?action=notifications"
           class="teacher-nav-link">
            <i class="fa-solid fa-bell"></i>
            Notifications
        </a>

        <a href="${pageContext.request.contextPath}/TeacherServlet?action=profile"
           class="teacher-nav-link">
            <i class="fa-solid fa-user-circle"></i>
            Profile
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
            PERFORMANCE CENTER
        </span>

        <h1>Student Performance</h1>

    </div>

    <div class="mini-avatar">
        <%= (teacher != null && teacher.getName() != null && !teacher.getName().isEmpty()) ? teacher.getName().substring(0,1).toUpperCase() : "T" %>
    </div>

</header>


<section class="performance-hero">

    <div>

        <span>SMART ANALYTICS</span>

        <h2>
            Measure learning.
            <span>Improve outcomes.</span>
        </h2>

        <p>
            Review assignment scores and understand how
            your students are performing.
        </p>

    </div>

    <div class="performance-icon">

        <i class="fa-solid fa-ranking-star"></i>

    </div>

</section>


<div class="table-card">

    <div class="table-header">

        <div>

            <h3>Scoreboard</h3>

            <p>
                Assignment performance of your students
            </p>

        </div>

        <div class="table-icon">

            <i class="fa-solid fa-trophy"></i>

        </div>

    </div>


    <div class="table-responsive">

        <table class="teacher-table">

            <thead>

            <tr>

                <th>Student</th>
                <th>Course</th>
                <th>Assignment</th>
                <th>Score</th>
                <th>Result</th>

            </tr>

            </thead>


            <tbody>

            <%
                if (performance != null &&
                    !performance.isEmpty()) {

                    for (String[] p : performance) {

                        double marks =
                            Double.parseDouble(p[3]);

                        double total =
                            Double.parseDouble(p[4]);

                        double percentage =
                            total > 0
                            ? (marks / total) * 100
                            : 0;
            %>

            <tr>

                <td>

                    <div class="student-name">

                        <div class="student-avatar">
                            <%= p[0].substring(0,1).toUpperCase() %>
                        </div>

                        <strong>
                            <%= p[0] %>
                        </strong>

                    </div>

                </td>


                <td>
                    <%= p[1] %>
                </td>


                <td>
                    <%= p[2] %>
                </td>


                <td>

                    <strong class="score-number">

                        <%= p[3] %>
                        /
                        <%= p[4] %>

                    </strong>

                    <small class="score-percent">

                        <%= String.format("%.1f", percentage) %>&#37;

                    </small>

                </td>


                <td>

                    <%
                        if (percentage >= 80) {
                    %>

                    <span class="performance-badge excellent">
                        Excellent
                    </span>

                    <%
                        } else if (percentage >= 60) {
                    %>

                    <span class="performance-badge good">
                        Good
                    </span>

                    <%
                        } else if (percentage >= 40) {
                    %>

                    <span class="performance-badge average">
                        Average
                    </span>

                    <%
                        } else {
                    %>

                    <span class="performance-badge needs-work">
                        Needs Work
                    </span>

                    <%
                        }
                    %>

                </td>

            </tr>

            <%
                    }

                } else {
            %>

            <tr>

                <td colspan="5"
                    class="empty-table">

                    <i class="fa-solid fa-chart-column"></i>

                    No performance data available yet.

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