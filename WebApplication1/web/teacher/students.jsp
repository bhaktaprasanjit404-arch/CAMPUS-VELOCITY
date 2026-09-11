<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="com.capacityconnect.model.Teacher" %>

<%
    Teacher teacher =
        (Teacher) request.getAttribute("teacher");

    List<String[]> students =
        (List<String[]>) request.getAttribute("students");
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Students | Capacity Connect</title>

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
           class="teacher-nav-link active">
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
            <h1>My Students</h1>
        </div>

        <div class="mini-avatar">
            <%= teacher.getName().substring(0,1).toUpperCase() %>
        </div>

    </header>


    <section class="page-intro">

        <span>LEARNER COMMUNITY</span>

        <h2>Students</h2>

        <p>
            Monitor learners enrolled in your courses.
        </p>

    </section>


    <div class="table-card">

        <div class="table-header">

            <div>
                <h3>Enrolled Students</h3>
                <p>Students connected to your courses</p>
            </div>

            <div class="table-icon">
                <i class="fa-solid fa-users"></i>
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
                    if (students != null && !students.isEmpty()) {

                        for (String[] s : students) {
                %>

                <tr>

                    <td>

                        <div class="student-name">

                            <div class="student-avatar">
                                <%= s[1].substring(0,1).toUpperCase() %>
                            </div>

                            <strong><%= s[1] %></strong>

                        </div>

                    </td>

                    <td><%= s[2] %></td>

                    <td><%= s[3] %></td>

                    <td>

                        <div class="progress-wrapper">

                            <div class="progress-bar-small">

                                <span style="width:<%= s[4] %>%"></span>

                            </div>

                            <small><%= s[4] %>%</small>

                        </div>

                    </td>

                    <td>

                        <span class="status-badge">
                            <%= s[5] %>
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

                        No students found.

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