<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="com.capacityconnect.model.Teacher" %>

<%
    Teacher teacher =
        (Teacher) request.getAttribute("teacher");

    if (teacher == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    int courseCount =
        request.getAttribute("courseCount") != null
        ? (Integer) request.getAttribute("courseCount") : 0;

    int studentCount =
        request.getAttribute("studentCount") != null
        ? (Integer) request.getAttribute("studentCount") : 0;

    int assignmentCount =
        request.getAttribute("assignmentCount") != null
        ? (Integer) request.getAttribute("assignmentCount") : 0;
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Teacher Dashboard | Capacity Connect</title>

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
               class="teacher-nav-link active">

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
               class="teacher-nav-link">

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
                    TEACHER PORTAL
                </span>

                <h1>Welcome back, Teacher #<%= teacher.getId() %> 👋</h1>

            </div>

            <a href="${pageContext.request.contextPath}/TeacherServlet?action=profile"
               class="teacher-profile-mini">

                <div class="mini-avatar">
                    <%= teacher.getId() %>
                </div>

                <div>
                    <strong>Teacher #<%= teacher.getId() %></strong>
                    <span>Teacher</span>
                </div>

            </a>

        </header>


        <section class="teacher-hero">

            <div>

                <span class="hero-small">
                    TEACHER OVERVIEW
                </span>

                <h2>
                    Inspire. Teach. <span>Transform.</span>
                </h2>

                <p>
                    Manage your courses, students and learning
                    performance from one powerful workspace.
                </p>

            </div>

            <div class="hero-symbol">

                <i class="fa-solid fa-chalkboard-user"></i>

            </div>

        </section>


        <section class="teacher-stats">

            <div class="teacher-stat-card">

                <div class="teacher-stat-icon blue">
                    <i class="fa-solid fa-book-open"></i>
                </div>

                <span>MY COURSES</span>

                <strong><%= courseCount %></strong>

                <small>Active learning programs</small>

            </div>


            <div class="teacher-stat-card">

                <div class="teacher-stat-icon purple">
                    <i class="fa-solid fa-user-graduate"></i>
                </div>

                <span>STUDENTS</span>

                <strong><%= studentCount %></strong>

                <small>Learners connected</small>

            </div>


            <div class="teacher-stat-card">

                <div class="teacher-stat-icon orange">
                    <i class="fa-solid fa-file-lines"></i>
                </div>

                <span>ASSIGNMENTS</span>

                <strong><%= assignmentCount %></strong>

                <small>Learning activities</small>

            </div>


            <div class="teacher-stat-card">

                <div class="teacher-stat-icon green">
                    <i class="fa-solid fa-chart-simple"></i>
                </div>

                <span>PERFORMANCE</span>

                <strong>LIVE</strong>

                <small>Student analytics available</small>

            </div>

        </section>


        <section class="teacher-section">

            <div class="section-title">

                <div>
                    <span>WORKSPACE</span>
                    <h2>Quick Actions</h2>
                </div>

            </div>


            <div class="teacher-action-grid">

                <a href="${pageContext.request.contextPath}/TeacherServlet?action=courses"
                   class="teacher-action-card">

                    <i class="fa-solid fa-book-open"></i>

                    <h3>My Courses</h3>

                    <p>
                        View and manage your learning programs.
                    </p>

                    <b>Open →</b>

                </a>


                <a href="${pageContext.request.contextPath}/TeacherServlet?action=students"
                   class="teacher-action-card">

                    <i class="fa-solid fa-users"></i>

                    <h3>Students</h3>

                    <p>
                        View students enrolled in your courses.
                    </p>

                    <b>View Students →</b>

                </a>


                <a href="${pageContext.request.contextPath}/TeacherServlet?action=attendance"
                   class="teacher-action-card">

                    <i class="fa-solid fa-calendar-check"></i>

                    <h3>Attendance</h3>

                    <p>
                        Record and manage student attendance.
                    </p>

                    <b>Manage →</b>

                </a>


                <a href="${pageContext.request.contextPath}/TeacherServlet?action=performance"
                   class="teacher-action-card">

                    <i class="fa-solid fa-ranking-star"></i>

                    <h3>Performance</h3>

                    <p>
                        Analyse student scores and results.
                    </p>

                    <b>Analyse →</b>

                </a>

            </div>

        </section>

    </main>

</div>

</body>
</html>