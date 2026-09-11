<%@ page contentType="text/html;charset=UTF-8" %>

<%@ page import="java.util.List" %>
<%@ page import="com.capacityconnect.model.Teacher" %>

<%
    Teacher teacher =
        (Teacher) request.getAttribute("teacher");

    List<String[]> courses =
        (List<String[]>) request.getAttribute("courses");

    List<String[]> students =
        (List<String[]>) request.getAttribute("students");
%>

<!DOCTYPE html>
<html>

<head>

    <meta charset="UTF-8">

    <title>Attendance | Capacity Connect</title>

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
           class="teacher-nav-link active">
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
        <h1>Attendance</h1>
    </div>

    <div class="mini-avatar">
        <%= teacher.getName().substring(0,1).toUpperCase() %>
    </div>

</header>


<section class="page-intro">

    <span>CLASSROOM MANAGEMENT</span>

    <h2>Mark Attendance</h2>

    <p>
        Keep your learner attendance records accurate and updated.
    </p>

</section>


<%
    if ("true".equals(request.getParameter("success"))) {
%>

<div class="success-message">
    <i class="fa-solid fa-circle-check"></i>
    Attendance saved successfully.
</div>

<%
    }

    if ("true".equals(request.getParameter("error"))) {
%>

<div class="error-message">
    <i class="fa-solid fa-circle-exclamation"></i>
    Unable to save attendance.
</div>

<%
    }
%>


<div class="attendance-card">

    <div class="attendance-icon">

        <i class="fa-solid fa-calendar-check"></i>

    </div>

    <h2>Record Student Attendance</h2>

    <p>
        Select the course, student and attendance status.
    </p>


    <form method="post"
          action="${pageContext.request.contextPath}/TeacherServlet">

        <input type="hidden"
               name="action"
               value="markAttendance">


        <div class="form-grid">

            <div class="teacher-input">

                <label>Course</label>

                <select name="courseId" required>

                    <option value="">
                        Select course
                    </option>

                    <%
                        if (courses != null) {

                            for (String[] c : courses) {
                    %>

                    <option value="<%= c[0] %>">
                        <%= c[1] %>
                    </option>

                    <%
                            }
                        }
                    %>

                </select>

            </div>


            <div class="teacher-input">

                <label>Student</label>

                <select name="studentId" required>

                    <option value="">
                        Select student
                    </option>

                    <%
                        if (students != null) {

                            for (String[] s : students) {
                    %>

                    <option value="<%= s[0] %>">
                        <%= s[1] %>
                    </option>

                    <%
                            }
                        }
                    %>

                </select>

            </div>


            <div class="teacher-input">

                <label>Date</label>

                <input type="date"
                       name="date"
                       required>

            </div>


            <div class="teacher-input">

                <label>Status</label>

                <select name="status" required>

                    <option value="PRESENT">
                        Present
                    </option>

                    <option value="ABSENT">
                        Absent
                    </option>

                    <option value="LATE">
                        Late
                    </option>

                </select>

            </div>

        </div>


        <div class="teacher-input">

            <label>Remarks</label>

            <textarea name="remarks"
                      placeholder="Optional remarks..."></textarea>

        </div>


        <button type="submit"
                class="teacher-primary-btn">

            <i class="fa-solid fa-check"></i>

            Save Attendance

        </button>

    </form>

</div>

</main>

</div>

</body>
</html>