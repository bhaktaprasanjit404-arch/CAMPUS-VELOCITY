<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="jakarta.servlet.http.HttpSession" %>
<%@ page import="java.util.List" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.capacityconnect.model.Student" %>
<%@ page import="com.capacityconnect.dao.StudentDAO" %>

<%
    // Authentication check
    HttpSession userSession = request.getSession(false);
    if (userSession == null || userSession.getAttribute("userId") == null 
            || !"STUDENT".equalsIgnoreCase((String) userSession.getAttribute("role"))) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    int studentId = (Integer) userSession.getAttribute("userId");
    StudentDAO studentDAO = new StudentDAO();

    Student student = (Student) request.getAttribute("student");
    if (student == null) {
        student = studentDAO.getStudentById(studentId);
        if (student == null) {
            student = new Student();
            student.setId(studentId);
            student.setName((String) userSession.getAttribute("userName"));
            student.setEmail((String) userSession.getAttribute("email"));
            student.setRole("STUDENT");
        }
    }

    Map<String, Object> stats = (Map<String, Object>) request.getAttribute("stats");
    if (stats == null) {
        stats = studentDAO.getDashboardStats(studentId);
    }

    List<Map<String, Object>> enrolledCourses = (List<Map<String, Object>>) request.getAttribute("enrolledCourses");
    if (enrolledCourses == null) {
        enrolledCourses = studentDAO.getEnrolledCourses(studentId);
    }

    int enrolledCount = stats.get("enrolledCount") != null ? (Integer) stats.get("enrolledCount") : 0;
    int completedCount = stats.get("completedCount") != null ? (Integer) stats.get("completedCount") : 0;
    int certCount = stats.get("certificateCount") != null ? (Integer) stats.get("certificateCount") : 0;
    double attRate = stats.get("attendanceRate") != null ? (Double) stats.get("attendanceRate") : 0.0;

    String studentName = student.getName() != null ? student.getName() : "Student";
    String studentEmail = student.getEmail() != null ? student.getEmail() : "student@capacityconnect.edu";
    String initial = studentName.substring(0, 1).toUpperCase();

    String statusMsg = request.getParameter("status");

    request.setAttribute("activePage", "profile");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile | Capacity Connect</title>

    <!-- Google Fonts Inter -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">

    <!-- Font Awesome 6.5.2 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

    <!-- User Standard CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/user.css">

    <style>
        .form-group {
            margin-bottom: 16px;
        }
        .form-label {
            display: block;
            font-size: 12px;
            font-weight: 700;
            color: var(--muted);
            margin-bottom: 6px;
            text-transform: uppercase;
        }
        .form-control {
            width: 100%;
            padding: 10px 14px;
            border-radius: 12px;
            border: 1px solid var(--border);
            font-family: inherit;
            font-size: 13.5px;
            color: var(--dark);
            background: #f8fafc;
            outline: none;
            transition: .2s;
        }
        .form-control:focus {
            border-color: var(--primary);
            background: #ffffff;
            box-shadow: 0 0 0 3px rgba(49, 87, 232, 0.12);
        }
        .alert-banner {
            background: #e7f8f0;
            border: 1px solid #a7f3d0;
            color: #065f46;
            padding: 14px 20px;
            border-radius: 14px;
            margin-bottom: 24px;
            display: flex;
            align-items: center;
            gap: 12px;
            font-size: 13.5px;
            font-weight: 600;
        }
        .mini-course-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 14px 0;
            border-bottom: 1px solid var(--border);
        }
        .mini-course-row:last-child {
            border-bottom: none;
        }
    </style>
</head>
<body>

<div class="user-layout">

    <!-- Reusable Sidebar -->
    <jsp:include page="/includes/user-sidebar.jsp" />

    <!-- Main Content -->
    <main class="user-main">

        <!-- Topbar -->
        <header class="user-topbar">
            <div>
                <span class="topbar-label">ACCOUNT & SETTINGS</span>
                <h1>Student Profile</h1>
            </div>
            <div class="user-profile-mini">
                <div class="mini-avatar"><%= initial %></div>
                <div>
                    <strong style="display: block; font-size: 13px; color: var(--dark);"><%= studentName %></strong>
                    <span style="font-size: 11px; color: var(--muted);">Student ID: #<%= student.getId() %></span>
                </div>
            </div>
        </header>

        <% if ("profileUpdated".equalsIgnoreCase(statusMsg)) { %>
            <div class="alert-banner">
                <i class="fa-solid fa-circle-check" style="font-size: 18px;"></i>
                <span>Your profile credentials have been successfully updated in the system database.</span>
            </div>
        <% } %>

        <!-- Profile Cover Header -->
        <div class="profile-cover">
            <div class="profile-avatar-large">
                <%= initial %>
            </div>
            <div>
                <span>STUDENT PORTAL IDENTIFIER</span>
                <h2><%= studentName %></h2>
                <p>
                    <i class="fa-regular fa-envelope" style="margin-right: 6px;"></i> <%= studentEmail %> &nbsp;|&nbsp;
                    <i class="fa-solid fa-id-badge" style="margin-right: 6px;"></i> Student UID #<%= student.getId() %> &nbsp;|&nbsp;
                    <i class="fa-solid fa-graduation-cap" style="margin-right: 6px;"></i> Status: Active
                </p>
            </div>
        </div>

        <!-- Academic Summary KPI Cards -->
        <div class="user-stats-grid">
            <div class="user-stat-card">
                <div class="user-stat-icon blue">
                    <i class="fa-solid fa-book-bookmark"></i>
                </div>
                <span>ENROLLED SUBJECTS</span>
                <strong><%= enrolledCount %></strong>
                <small>Active program modules</small>
            </div>

            <div class="user-stat-card">
                <div class="user-stat-icon green">
                    <i class="fa-solid fa-chart-line"></i>
                </div>
                <span>ATTENDANCE RECORD</span>
                <strong><%= Math.round(attRate) %>&#37;</strong>
                <small>Session presence score</small>
            </div>

            <div class="user-stat-card">
                <div class="user-stat-icon orange">
                    <i class="fa-solid fa-circle-check"></i>
                </div>
                <span>COURSES COMPLETED</span>
                <strong><%= completedCount %></strong>
                <small>Syllabus finished</small>
            </div>

            <div class="user-stat-card">
                <div class="user-stat-icon purple">
                    <i class="fa-solid fa-award"></i>
                </div>
                <span>VERIFIED CERTS</span>
                <strong><%= certCount %></strong>
                <small>Accredited diplomas</small>
            </div>
        </div>

        <!-- Two-Column Profile Grid -->
        <div class="profile-grid">

            <!-- Left Card: Personal Details & Edit Form -->
            <div class="profile-card">
                <span class="profile-label">ACCOUNT INFORMATION</span>
                <h3>Personal & Login Details</h3>

                <div class="info-row">
                    <span>Full Legal Name</span>
                    <strong><%= studentName %></strong>
                </div>
                <div class="info-row">
                    <span>Email Address</span>
                    <strong><%= studentEmail %></strong>
                </div>
                <div class="info-row">
                    <span>System Role</span>
                    <strong class="status-pill present" style="font-size: 11px; padding: 2px 10px;">STUDENT</strong>
                </div>
                <div class="info-row">
                    <span>Unique Student ID</span>
                    <strong style="font-family: monospace;">#<%= student.getId() %></strong>
                </div>

                <div style="margin-top: 28px; padding-top: 20px; border-top: 1px solid var(--border);">
                    <span class="profile-label">SETTINGS</span>
                    <h4 style="font-size: 15px; font-weight: 800; color: var(--dark); margin-bottom: 14px;">Update Profile Information</h4>

                    <form action="${pageContext.request.contextPath}/StudentServlet" method="POST">
                        <input type="hidden" name="action" value="updateProfile">

                        <div class="form-group">
                            <label class="form-label" for="profileName">Display / Full Name</label>
                            <input type="text" class="form-control" id="profileName" name="name" value="<%= studentName %>" required>
                        </div>

                        <div class="form-group">
                            <label class="form-label" for="profilePassword">New Password (leave blank to keep unchanged)</label>
                            <input type="password" class="form-control" id="profilePassword" name="password" placeholder="Enter new password if updating">
                        </div>

                        <button type="submit" class="btn-user-primary" style="margin-top: 6px;">
                            <i class="fa-solid fa-floppy-disk"></i> Save Profile Changes
                        </button>
                    </form>
                </div>
            </div>

            <!-- Right Card: Enrolled Programs & Academic Standing -->
            <div class="profile-card">
                <span class="profile-label">ACADEMIC STANDING</span>
                <h3>Registered Courses Standing</h3>

                <% if (enrolledCourses == null || enrolledCourses.isEmpty()) { %>
                    <div style="padding: 24px 0; text-align: center; color: var(--muted); font-size: 13.5px;">
                        No courses registered yet.
                    </div>
                <% } else { %>
                    <div>
                        <% for (Map<String, Object> course : enrolledCourses) { 
                            int cid = (Integer) course.get("courseId");
                            String cTitle = (String) course.get("title");
                            String category = (String) course.get("category");
                            double prog = course.get("progress") != null ? (Double) course.get("progress") : 0.0;
                            boolean isComp = prog >= 100.0;
                            String compBadgeClass = isComp ? "present" : "pending";
                            String compBadgeText = isComp ? "COMPLETED" : Math.round(prog) + "%";
                        %>
                        <div class="mini-course-row">
                            <div style="flex: 1; padding-right: 14px;">
                                <div style="display: flex; align-items: center; gap: 8px; margin-bottom: 4px;">
                                    <strong style="font-size: 13.5px; color: var(--dark);"><%= cTitle %></strong>
                                    <span class="status-pill <%= compBadgeClass %>" style="font-size: 10px; padding: 2px 6px;">
                                        <%= compBadgeText %>
                                    </span>
                                </div>
                                <div style="font-size: 11.5px; color: var(--muted);"><%= category != null ? category : "Course" %></div>
                            </div>
                            <a href="${pageContext.request.contextPath}/user/course-learning.jsp?courseId=<%= cid %>" class="btn-user-secondary" style="padding: 6px 12px; font-size: 12px;">
                                <i class="fa-solid fa-arrow-right"></i>
                            </a>
                        </div>
                        <% } %>
                    </div>
                <% } %>

                <div style="margin-top: 24px; padding-top: 20px; border-top: 1px solid var(--border); background: #f8fafc; padding: 16px; border-radius: 14px;">
                    <div style="display: flex; align-items: center; gap: 12px;">
                        <i class="fa-solid fa-shield-halved" style="font-size: 24px; color: var(--primary);"></i>
                        <div>
                            <strong style="font-size: 13px; color: var(--dark); display: block;">Institutional Verification</strong>
                            <span style="font-size: 11.5px; color: var(--muted);">Student records are stored securely in Capacity Connect database.</span>
                        </div>
                    </div>
                </div>
            </div>

        </div>

    </main>
</div>

</body>
</html>
