<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="com.capacityconnect.model.Teacher" %>

<%
    Teacher teacher =
        (Teacher) request.getAttribute("teacher");
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Teacher Profile | Capacity Connect</title>

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
           class="teacher-nav-link active">
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
            ACCOUNT
        </span>

        <h1>My Profile</h1>

    </div>

</header>


<section class="profile-cover">

    <div class="profile-avatar-large">

        <%= teacher.getName().substring(0,1).toUpperCase() %>

    </div>

    <div>

        <span>TEACHER</span>

        <h2>
            <%= teacher.getName() %>
        </h2>

        <p>
            <%= teacher.getSpecialization() != null
                ? teacher.getSpecialization()
                : "Capacity Connect Educator" %>
        </p>

    </div>

</section>


<div class="profile-grid">

    <div class="profile-card">

        <span class="profile-label">
            PERSONAL INFORMATION
        </span>

        <h3>Profile Details</h3>


        <div class="profile-row">

            <i class="fa-solid fa-user"></i>

            <div>

                <small>Full Name</small>

                <strong>
                    <%= teacher.getName() %>
                </strong>

            </div>

        </div>


        <div class="profile-row">

            <i class="fa-solid fa-envelope"></i>

            <div>

                <small>Email Address</small>

                <strong>
                    <%= teacher.getEmail() %>
                </strong>

            </div>

        </div>


        <div class="profile-row">

            <i class="fa-solid fa-phone"></i>

            <div>

                <small>Phone</small>

                <strong>
                    <%= teacher.getPhone() != null
                        ? teacher.getPhone()
                        : "Not provided" %>
                </strong>

            </div>

        </div>

    </div>


    <div class="profile-card">

        <span class="profile-label">
            PROFESSIONAL INFORMATION
        </span>

        <h3>Teaching Details</h3>


        <div class="profile-row">

            <i class="fa-solid fa-graduation-cap"></i>

            <div>

                <small>Qualification</small>

                <strong>
                    <%= teacher.getQualification() != null
                        ? teacher.getQualification()
                        : "Not provided" %>
                </strong>

            </div>

        </div>


        <div class="profile-row">

            <i class="fa-solid fa-code"></i>

            <div>

                <small>Specialization</small>

                <strong>
                    <%= teacher.getSpecialization() != null
                        ? teacher.getSpecialization()
                        : "Not provided" %>
                </strong>

            </div>

        </div>


        <div class="profile-row">

            <i class="fa-solid fa-align-left"></i>

            <div>

                <small>Bio</small>

                <strong>
                    <%= teacher.getBio() != null
                        ? teacher.getBio()
                        : "No bio added." %>
                </strong>

            </div>

        </div>

    </div>

</div>

</main>

</div>

</body>
</html>