<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.capacityconnect.model.Student" %>
<%@ page import="com.capacityconnect.dao.StudentDAO" %>
<%@ page import="java.util.*" %>

<%
    // Session validation
    HttpSession userSession = request.getSession(false);
    if (userSession == null || userSession.getAttribute("userId") == null 
            || !"STUDENT".equalsIgnoreCase((String) userSession.getAttribute("role"))) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }

    int studentId = (Integer) userSession.getAttribute("userId");
    Student student = (Student) request.getAttribute("student");
    StudentDAO studentDAO = new StudentDAO();

    if (student == null) {
        student = studentDAO.getStudentById(studentId);
    }
    if (student == null) {
        student = new Student();
        student.setId(studentId);
        student.setName((String) userSession.getAttribute("userName"));
        student.setEmail((String) userSession.getAttribute("email"));
    }

    @SuppressWarnings("unchecked")
    Map<String, Object> stats = (Map<String, Object>) request.getAttribute("stats");
    if (stats == null) {
        stats = studentDAO.getDashboardStats(studentId);
    }

    @SuppressWarnings("unchecked")
    List<Map<String, Object>> enrolledCourses = (List<Map<String, Object>>) request.getAttribute("enrolledCourses");
    if (enrolledCourses == null) {
        enrolledCourses = studentDAO.getEnrolledCourses(studentId);
    }

    @SuppressWarnings("unchecked")
    List<Map<String, Object>> assignments = (List<Map<String, Object>>) request.getAttribute("assignments");
    if (assignments == null) {
        assignments = studentDAO.getStudentAssignments(studentId);
    }

    @SuppressWarnings("unchecked")
    List<Map<String, Object>> attendanceList = (List<Map<String, Object>>) request.getAttribute("attendanceList");
    if (attendanceList == null) {
        attendanceList = studentDAO.getStudentAttendance(studentId);
    }

    @SuppressWarnings("unchecked")
    List<Map<String, Object>> certificates = (List<Map<String, Object>>) request.getAttribute("certificates");
    if (certificates == null) {
        certificates = studentDAO.getStudentCertificates(studentId);
    }

    @SuppressWarnings("unchecked")
    List<Map<String, Object>> resources = (List<Map<String, Object>>) request.getAttribute("resources");
    if (resources == null) {
        resources = studentDAO.getRecentResources(8);
    }

    // Extract KPI Metrics
    int enrolledCount = stats.containsKey("enrolledCount") ? (Integer) stats.get("enrolledCount") : enrolledCourses.size();
    int completedCount = stats.containsKey("completedCount") ? (Integer) stats.get("completedCount") : 0;
    double avgProgress = stats.containsKey("avgProgress") ? ((Number) stats.get("avgProgress")).doubleValue() : 0.0;
    int totalAssignments = stats.containsKey("totalAssignments") ? (Integer) stats.get("totalAssignments") : assignments.size();
    int submittedAssignments = stats.containsKey("submittedAssignments") ? (Integer) stats.get("submittedAssignments") : 0;
    int pendingAssignments = stats.containsKey("pendingAssignments") ? (Integer) stats.get("pendingAssignments") : 0;
    double attendanceRate = stats.containsKey("attendanceRate") ? ((Number) stats.get("attendanceRate")).doubleValue() : 0.0;
    int totalAttendance = stats.containsKey("totalAttendance") ? (Integer) stats.get("totalAttendance") : attendanceList.size();
    int presentAttendance = stats.containsKey("presentAttendance") ? (Integer) stats.get("presentAttendance") : 0;
    int certificateCount = stats.containsKey("certificateCount") ? (Integer) stats.get("certificateCount") : certificates.size();

    String successMsg = request.getParameter("success");
    String errorMsg = request.getParameter("error");

    String studentName = student.getName() != null && !student.getName().trim().isEmpty() 
            ? student.getName() : (String) userSession.getAttribute("userName");
    if (studentName == null || studentName.trim().isEmpty()) {
        studentName = "Student #" + student.getId();
    }

    String studentEmail = student.getEmail() != null ? student.getEmail() : (String) userSession.getAttribute("email");
    if (studentEmail == null) studentEmail = "student@capacityconnect.edu";

    String userInitial = studentName.substring(0, 1).toUpperCase();
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Student Dashboard | Capacity Connect</title>
    
    <!-- Google Fonts Inter -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">
    
    <!-- Font Awesome 6.5.2 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
    
    <!-- Student Dashboard CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/s-dashboard.css">
</head>
<body>

<div class="sidebar-backdrop" id="sidebarBackdrop"></div>

<div class="student-layout">

    <!-- =====================================================
         SIDEBAR NAVIGATION
         ===================================================== -->
    <aside class="student-sidebar" id="studentSidebar">

        <!-- Brand -->
        <div class="student-brand">
            <div class="student-brand-icon">
                <i class="fa-solid fa-graduation-cap"></i>
            </div>
            <div class="student-brand-text">
                <strong>CAPACITY</strong>
                <span>CONNECT</span>
            </div>
        </div>

        <div class="student-nav-group-label">MAIN PORTAL</div>

        <!-- Navigation Links -->
        <nav class="student-nav">
            <a href="${pageContext.request.contextPath}/user/s-dashboard.jsp" class="student-nav-link active" data-nav="overview">
                <i class="fa-solid fa-chart-pie"></i>
                Dashboard
            </a>

            <a href="${pageContext.request.contextPath}/user/my-courses.jsp" class="student-nav-link" data-nav="courses">
                <i class="fa-solid fa-book-bookmark"></i>
                My Courses
                <% if (enrolledCount > 0) { %>
                    <span class="student-nav-badge"><%= enrolledCount %></span>
                <% } %>
            </a>

            <a href="${pageContext.request.contextPath}/user/course-learning.jsp" class="student-nav-link" data-nav="learning">
                <i class="fa-solid fa-chalkboard-user"></i>
                Course Learning
            </a>

            <a href="#assignments" class="student-nav-link" data-nav="assignments">
                <i class="fa-solid fa-file-pen"></i>
                Assignments
                <% if (pendingAssignments > 0) { %>
                    <span class="student-nav-badge" style="background: rgba(245, 158, 11, 0.3); color: #fde68a;"><%= pendingAssignments %></span>
                <% } %>
            </a>

            <a href="${pageContext.request.contextPath}/user/progress.jsp" class="student-nav-link" data-nav="progress">
                <i class="fa-solid fa-chart-line"></i>
                Progress & Attendance
                <span class="student-nav-badge"><%= Math.round(attendanceRate) %>%</span>
            </a>

            <a href="${pageContext.request.contextPath}/user/my-resources.jsp" class="student-nav-link" data-nav="resources">
                <i class="fa-solid fa-folder-open"></i>
                Study Materials
            </a>

            <a href="${pageContext.request.contextPath}/user/certificates.jsp" class="student-nav-link" data-nav="certificates">
                <i class="fa-solid fa-award"></i>
                Certificates
                <% if (certificateCount > 0) { %>
                    <span class="student-nav-badge" style="background: rgba(16, 185, 129, 0.3); color: #a7f3d0;"><%= certificateCount %></span>
                <% } %>
            </a>

            <a href="#ai-assessment" class="student-nav-link" data-nav="ai-assessment">
                <i class="fa-solid fa-wand-magic-sparkles" style="color: #c084fc;"></i>
                AI Assessment
                <span class="student-nav-badge" style="background: linear-gradient(135deg, #7c3aed, #ec4899); color: #ffffff; font-size: 10px;">AI NEW</span>
            </a>

            <a href="${pageContext.request.contextPath}/user/notifications.jsp" class="student-nav-link" data-nav="notifications">
                <i class="fa-regular fa-bell"></i>
                Notifications
            </a>

            <a href="${pageContext.request.contextPath}/user/profile.jsp" class="student-nav-link" data-nav="profile">
                <i class="fa-solid fa-circle-user"></i>
                My Profile
            </a>

            <div class="student-nav-group-label" style="margin-top: 14px;">EXPLORE</div>

            <a href="${pageContext.request.contextPath}/courses.jsp" class="student-nav-link">
                <i class="fa-solid fa-compass"></i>
                Course Catalog
            </a>

            <a href="${pageContext.request.contextPath}/resources.jsp" class="student-nav-link">
                <i class="fa-solid fa-book"></i>
                Public Resources
            </a>

            <a href="${pageContext.request.contextPath}/index.jsp" class="student-nav-link">
                <i class="fa-solid fa-house"></i>
                Main Website
            </a>
        </nav>

        <!-- Sidebar Footer / Student Profile -->
        <div class="sidebar-footer">
            <a href="${pageContext.request.contextPath}/user/profile.jsp" class="sidebar-user-card" style="text-decoration: none; cursor: pointer;" title="View Profile">
                <div class="user-avatar-badge">
                    <%= userInitial %>
                </div>
                <div class="user-info-text">
                    <strong><%= studentName %></strong>
                    <span><%= studentEmail %></span>
                </div>
            </a>

            <a href="${pageContext.request.contextPath}/LogoutServlet" class="btn-sidebar-logout" title="Sign Out">
                <i class="fa-solid fa-arrow-right-from-bracket"></i>
                <span>Sign Out</span>
            </a>
        </div>
    </aside>

    <!-- =====================================================
         MAIN CONTENT WORKSPACE
         ===================================================== -->
    <main class="student-main">

        <!-- TOPBAR -->
        <header class="student-topbar">
            <div class="topbar-left">
                <button type="button" class="mobile-menu-btn" id="mobileMenuBtn" aria-label="Toggle Navigation">
                    <i class="fa-solid fa-bars-staggered"></i>
                </button>
                <div class="topbar-title-block">
                    <h1>Student Workspace</h1>
                    <span class="topbar-subtitle">Academic Year 2026 &bull; Spring Semester</span>
                </div>
            </div>

            <div class="topbar-right">
                <!-- Search Box -->
                <div class="topbar-search-box">
                    <i class="fa-solid fa-magnifying-glass"></i>
                    <input type="text" id="courseSearchInput" placeholder="Quick search enrolled courses..." autocomplete="off">
                </div>

                <!-- Explore Action -->
                <a href="#ai-assessment" class="btn-topbar-action" style="background: linear-gradient(135deg, rgba(124, 58, 237, 0.15), rgba(236, 72, 153, 0.15)); border-color: rgba(124, 58, 237, 0.4); color: #7c3aed;">
                    <i class="fa-solid fa-wand-magic-sparkles"></i>
                    <span>Launch AI Diagnostic</span>
                </a>

                <!-- Notification Bell -->
                <div class="topbar-icon-button" id="notifBellBtn" title="Student Notifications">
                    <i class="fa-regular fa-bell"></i>
                    <% if (pendingAssignments > 0) { %>
                        <span class="notification-dot"></span>
                    <% } %>
                </div>

                <!-- Profile Quick Card -->
                <a href="${pageContext.request.contextPath}/user/profile.jsp" class="topbar-user-badge" style="text-decoration: none;">
                    <div class="user-avatar-small"><%= userInitial %></div>
                    <div class="user-badge-text">
                        <strong><%= studentName %></strong>
                        <span>Matriculated Student</span>
                    </div>
                </a>
            </div>
        </header>

        <!-- CONTENT AREA -->
        <div class="student-content-area">

            <!-- ALERTS -->
            <% if (successMsg != null) { %>
                <div class="alert-banner success" style="margin-bottom: 24px; padding: 14px 18px; border-radius: var(--radius-md); background: var(--success-light); border: 1px solid var(--success-border); color: var(--success); display: flex; align-items: center; gap: 12px; font-weight: 600;">
                    <i class="fa-solid fa-circle-check"></i>
                    <span><%= successMsg %></span>
                </div>
            <% } %>

            <% if (errorMsg != null) { %>
                <div class="alert-banner danger" style="margin-bottom: 24px; padding: 14px 18px; border-radius: var(--radius-md); background: var(--danger-light); border: 1px solid var(--danger-border); color: var(--danger); display: flex; align-items: center; gap: 12px; font-weight: 600;">
                    <i class="fa-solid fa-circle-exclamation"></i>
                    <span><%= errorMsg %></span>
                </div>
            <% } %>

            <!-- =====================================================
                 HERO GREETING BANNER
                 ===================================================== -->
            <section class="student-hero">
                <div class="student-hero-content">
                    <div class="student-hero-tag">
                        <i class="fa-solid fa-bolt-lightning"></i>
                        <span>Welcome Back, <%= studentName.split(" ")[0] %></span>
                    </div>

                    <h2>Engineered for <span>Excellence</span> & Continuous Mastery.</h2>

                    <p>
                        You have <strong><%= pendingAssignments %> assignment<%= pendingAssignments == 1 ? "" : "s" %></strong> due this week and your overall course attendance stands at 
                        <strong style="color: <%= attendanceRate >= 75.0 ? "var(--success)" : "var(--warning)" %>;"><%= Math.round(attendanceRate) %>%</strong>. 
                        Dive into your active courses or test your skills using Capacity AI.
                    </p>

                    <div class="hero-actions-row">
                        <a href="#courses" class="btn-hero-primary">
                            <i class="fa-solid fa-play"></i> Resume Active Learning
                        </a>
                        <a href="#ai-assessment" class="btn-hero-secondary">
                            <i class="fa-solid fa-wand-magic-sparkles"></i> Try AI Assessment
                        </a>
                        <a href="#assignments" class="btn-hero-secondary">
                            <i class="fa-solid fa-clipboard-check"></i> View Deadlines
                        </a>
                    </div>
                </div>

                <div class="student-hero-graphic">
                    <div class="hero-stat-bubble">
                        <i class="fa-solid fa-shield-halved"></i>
                        <div>
                            <strong>Honors Track</strong>
                            <span>Grade A+ Average</span>
                        </div>
                    </div>
                </div>
            </section>

            <!-- =====================================================
                 KPI STATS OVERVIEW (4 KEY CARDS)
                 ===================================================== -->
            <section class="stats-overview-grid">
                <!-- Stat 1: Enrolled Courses -->
                <div class="stat-card blue">
                    <div class="stat-card-header">
                        <div class="stat-icon-badge blue">
                            <i class="fa-solid fa-book-open"></i>
                        </div>
                        <span class="stat-trend positive">
                            <i class="fa-solid fa-circle-check"></i> <%= enrolledCount %> Active
                        </span>
                    </div>
                    <span class="stat-label">Enrolled Modules</span>
                    <strong class="stat-value"><%= enrolledCount %> Courses</strong>
                    <div class="stat-meta">
                        <span><%= completedCount %> completed &bull; <%= enrolledCount - completedCount %> in progress</span>
                    </div>
                    <div class="stat-progress-bar">
                        <div class="stat-progress-fill blue" style="width: <%= enrolledCount > 0 ? (completedCount * 100 / enrolledCount) : 0 %>%;"></div>
                    </div>
                </div>

                <!-- Stat 2: Progress -->
                <div class="stat-card green">
                    <div class="stat-card-header">
                        <div class="stat-icon-badge green">
                            <i class="fa-solid fa-bars-progress"></i>
                        </div>
                        <span class="stat-trend positive">
                            <%= Math.round(avgProgress) %>% Completed
                        </span>
                    </div>
                    <span class="stat-label">Curriculum Progress</span>
                    <strong class="stat-value"><%= Math.round(avgProgress) %>% Avg</strong>
                    <div class="stat-meta">
                        <span>Cumulative cross-course syllabus progress</span>
                    </div>
                    <div class="stat-progress-bar">
                        <div class="stat-progress-fill green" style="width: <%= Math.min(100.0, avgProgress) %>%;"></div>
                    </div>
                </div>

                <!-- Stat 3: Assignments -->
                <div class="stat-card amber">
                    <div class="stat-card-header">
                        <div class="stat-icon-badge amber">
                            <i class="fa-solid fa-file-signature"></i>
                        </div>
                        <% if (pendingAssignments > 0) { %>
                            <span class="stat-trend warning">
                                <i class="fa-solid fa-clock"></i> <%= pendingAssignments %> Due
                            </span>
                        <% } else { %>
                            <span class="stat-trend positive">
                                <i class="fa-solid fa-check"></i> All Clear
                            </span>
                        <% } %>
                    </div>
                    <span class="stat-label">Assignments & Tasks</span>
                    <strong class="stat-value"><%= pendingAssignments %> <span style="font-size: 14px; font-weight: 500; color: var(--text-muted);">pending</span></strong>
                    <div class="stat-meta">
                        <span><%= submittedAssignments %> submitted of <%= totalAssignments %> total</span>
                    </div>
                    <div class="stat-progress-bar">
                        <div class="stat-progress-fill amber" style="width: <%= totalAssignments > 0 ? (submittedAssignments * 100 / totalAssignments) : 0 %>%;"></div>
                    </div>
                </div>

                <!-- Stat 4: Attendance -->
                <div class="stat-card purple">
                    <div class="stat-card-header">
                        <div class="stat-icon-badge purple">
                            <i class="fa-solid fa-user-check"></i>
                        </div>
                        <span class="stat-trend <%= attendanceRate >= 75.0 ? "positive" : "warning" %>">
                            <%= Math.round(attendanceRate) %>%
                        </span>
                    </div>
                    <span class="stat-label">Academic Attendance</span>
                    <strong class="stat-value"><%= Math.round(attendanceRate) %>%</strong>
                    <div class="stat-meta">
                        <span><%= presentAttendance %> present out of <%= totalAttendance %> recorded</span>
                    </div>
                    <div class="stat-progress-bar">
                        <div class="stat-progress-fill purple" style="width: <%= Math.min(100.0, attendanceRate) %>%;"></div>
                    </div>
                </div>
            </section>

            <!-- DASHBOARD SECTION TABS -->
            <div class="dashboard-tabs-bar">
                <div class="tabs-nav">
                    <a href="#courses" class="tab-btn active"><i class="fa-solid fa-book-open"></i> My Courses (<%= enrolledCount %>)</a>
                    <a href="#assignments" class="tab-btn"><i class="fa-solid fa-pen-ruler"></i> Assignments (<%= totalAssignments %>)</a>
                    <a href="#attendance" class="tab-btn"><i class="fa-solid fa-calendar-check"></i> Attendance</a>
                    <a href="#ai-assessment" class="tab-btn" style="color: #7c3aed; font-weight: 700;"><i class="fa-solid fa-wand-magic-sparkles"></i> AI Assessment</a>
                    <a href="#resources" class="tab-btn"><i class="fa-solid fa-folder-open"></i> Resources (<%= resources.size() %>)</a>
                    <a href="#certificates" class="tab-btn"><i class="fa-solid fa-award"></i> Certificates (<%= certificateCount %>)</a>
                </div>
            </div>

            <!-- =====================================================
                 MY ENROLLED COURSES SECTION
                 ===================================================== -->
            <section class="content-section" id="courses">
                <div class="section-header">
                    <div class="section-title-group">
                        <h2><i class="fa-solid fa-graduation-cap"></i> Enrolled Courses</h2>
                        <p>Track your lecture video playlists, study notes, and syllabus milestones.</p>
                    </div>
                    <a href="${pageContext.request.contextPath}/user/my-courses.jsp" class="btn-stat-action">
                        View Detailed Catalog <i class="fa-solid fa-arrow-right"></i>
                    </a>
                </div>

                <% if (enrolledCourses.isEmpty()) { %>
                    <div class="empty-state-card">
                        <div class="empty-state-icon">
                            <i class="fa-solid fa-book-open"></i>
                        </div>
                        <h3>You haven't enrolled in any courses yet</h3>
                        <p>Discover courses crafted by university faculty to build in-demand software engineering, AI, and design skills.</p>
                        <a href="${pageContext.request.contextPath}/courses.jsp" class="btn-hero-primary" style="margin-top: 10px;">
                            <i class="fa-solid fa-compass"></i> Explore Course Catalog
                        </a>
                    </div>
                <% } else { %>
                    <div class="courses-grid" id="enrolledCoursesGrid">
                        <% for (Map<String, Object> c : enrolledCourses) { 
                            int courseId = (Integer) c.get("courseId");
                            String cTitle = (String) c.get("courseTitle");
                            String cDesc = (String) c.get("courseDescription");
                            int cProgress = (Integer) c.get("progress");
                            String status = (String) c.get("status");
                            String thumb = (String) c.get("thumbnail");
                            String teacherName = (String) c.get("teacherName");

                            if (thumb == null || thumb.trim().isEmpty()) {
                                thumb = "https://images.unsplash.com/photo-1517694712202-14dd9538aa97?w=600&auto=format&fit=crop&q=80";
                            }
                        %>
                            <div class="course-card" data-course-title="<%= cTitle.toLowerCase() %>">
                                <div class="course-thumbnail-box">
                                    <img src="<%= thumb %>" alt="<%= cTitle %>" loading="lazy">
                                    <span class="course-category-pill">Academic</span>
                                    <span class="course-status-badge <%= status != null ? status.toLowerCase() : "in-progress" %>">
                                        <% if ("COMPLETED".equalsIgnoreCase(status)) { %>
                                            <i class="fa-solid fa-circle-check"></i> Completed
                                        <% } else { %>
                                            <i class="fa-solid fa-spinner fa-spin"></i> In Progress
                                        <% } %>
                                    </span>
                                </div>

                                <div class="course-body">
                                    <div class="course-meta-top">
                                        <span><i class="fa-solid fa-layer-group"></i> University Level</span>
                                        <span><i class="fa-regular fa-clock"></i> Full Semester</span>
                                    </div>

                                    <h3><%= cTitle %></h3>
                                    <p><%= cDesc != null && !cDesc.isEmpty() ? cDesc : "Comprehensive course curriculum covering theoretical principles, practical labs, and real-world system architecture." %></p>

                                    <div class="course-instructor">
                                        <div class="instructor-avatar">
                                            <%= teacherName != null && !teacherName.isEmpty() ? teacherName.substring(0, 1).toUpperCase() : "T" %>
                                        </div>
                                        <span><%= teacherName != null ? teacherName : "Faculty Instructor" %></span>
                                    </div>

                                    <div class="course-progress-block">
                                        <div class="progress-info-row">
                                            <span>Curriculum Progress</span>
                                            <strong><%= cProgress %>%</strong>
                                        </div>
                                        <div class="progress-track">
                                            <div class="progress-fill" style="width: <%= cProgress %>%;"></div>
                                        </div>
                                    </div>

                                    <div class="course-actions">
                                        <a href="${pageContext.request.contextPath}/user/course-learning.jsp" class="btn-course-primary">
                                            <i class="fa-solid fa-play"></i> Continue Learning
                                        </a>
                                        <button type="button" class="btn-course-secondary" title="Update Syllabus Progress" onclick="openProgressModal(<%= courseId %>, '<%= cTitle.replace("'", "\\'") %>', <%= cProgress %>)">
                                            <i class="fa-solid fa-sliders"></i>
                                        </button>
                                    </div>
                                </div>
                            </div>
                        <% } %>
                    </div>
                <% } %>
            </section>

            <!-- =====================================================
                 SPLIT SECTION: ASSIGNMENTS & ATTENDANCE
                 ===================================================== -->
            <div class="split-grid">

                <!-- LEFT: ASSIGNMENTS -->
                <section class="panel-card" id="assignments">
                    <div class="panel-card-header">
                        <h3>
                            <i class="fa-solid fa-clipboard-list"></i>
                            Assignments & Tasks (<%= totalAssignments %>)
                        </h3>
                        <span class="stat-trend <%= pendingAssignments > 0 ? "warning" : "positive" %>">
                            <%= pendingAssignments %> Pending
                        </span>
                    </div>

                    <div class="panel-card-body">
                        <% if (assignments.isEmpty()) { %>
                            <div class="empty-state-card" style="padding: 24px;">
                                <div class="empty-state-icon" style="width: 48px; height: 48px; font-size: 20px;">
                                    <i class="fa-solid fa-clipboard-check"></i>
                                </div>
                                <h4 style="font-size: 14px;">No assignments assigned yet</h4>
                                <p style="font-size: 12px; margin-bottom: 0;">Once your course instructors publish assignments, they will appear here with deadlines.</p>
                            </div>
                        <% } else { %>
                            <% for (Map<String, Object> a : assignments) { 
                                int aId = (Integer) a.get("assignmentId");
                                String aTitle = (String) a.get("title");
                                String cTitle = (String) a.get("courseTitle");
                                String dueDate = (String) a.get("dueDate");
                                String status = (String) a.get("status");
                                boolean isSub = (Boolean) a.get("isSubmitted");
                                Integer marks = (Integer) a.get("marks");
                                int totalMarks = (Integer) a.get("totalMarks");
                            %>
                                <div class="assignment-item">
                                    <div class="assignment-left">
                                        <div class="assignment-icon <%= status.toLowerCase() %>">
                                            <% if ("GRADED".equals(status)) { %>
                                                <i class="fa-solid fa-check-double"></i>
                                            <% } else if ("SUBMITTED".equals(status)) { %>
                                                <i class="fa-solid fa-clock"></i>
                                            <% } else if ("OVERDUE".equals(status)) { %>
                                                <i class="fa-solid fa-triangle-exclamation"></i>
                                            <% } else { %>
                                                <i class="fa-solid fa-file-arrow-up"></i>
                                            <% } %>
                                        </div>
                                        <div class="assignment-info">
                                            <strong><%= aTitle %></strong>
                                            <div class="assignment-subtext">
                                                <span><i class="fa-solid fa-book-open" style="font-size: 11px;"></i> <%= cTitle %></span>
                                                <span>&bull;</span>
                                                <span><i class="fa-regular fa-clock" style="font-size: 11px;"></i> Due: <%= dueDate.length() > 10 ? dueDate.substring(0, 10) : dueDate %></span>
                                            </div>
                                        </div>
                                    </div>

                                    <div class="assignment-right">
                                        <% if ("GRADED".equals(status)) { %>
                                            <div style="text-align: right;">
                                                <span class="status-pill graded"><i class="fa-solid fa-circle-check"></i> Graded</span>
                                                <div style="font-size: 11.5px; font-weight: 700; color: var(--success); margin-top: 4px;">
                                                    Score: <%= marks %> / <%= totalMarks %>
                                                </div>
                                            </div>
                                        <% } else if ("SUBMITTED".equals(status)) { %>
                                            <div style="text-align: right;">
                                                <span class="status-pill submitted"><i class="fa-solid fa-paper-plane"></i> Submitted</span>
                                                <div style="font-size: 11px; color: var(--text-muted); margin-top: 4px;">Awaiting Review</div>
                                            </div>
                                            <button type="button" class="btn-submit-action" onclick="openSubmitModal(<%= aId %>, '<%= aTitle.replace("'", "\\'") %>', '<%= cTitle.replace("'", "\\'") %>')">
                                                Resubmit
                                            </button>
                                        <% } else if ("OVERDUE".equals(status)) { %>
                                            <span class="status-pill overdue"><i class="fa-solid fa-circle-exclamation"></i> Overdue</span>
                                            <button type="button" class="btn-submit-action" style="background: var(--danger-light); color: var(--danger); border-color: var(--danger-border);" onclick="openSubmitModal(<%= aId %>, '<%= aTitle.replace("'", "\\'") %>', '<%= cTitle.replace("'", "\\'") %>')">
                                                Turn In Late
                                            </button>
                                        <% } else { %>
                                            <span class="status-pill pending"><i class="fa-solid fa-hourglass-half"></i> Pending</span>
                                            <button type="button" class="btn-submit-action" onclick="openSubmitModal(<%= aId %>, '<%= aTitle.replace("'", "\\'") %>', '<%= cTitle.replace("'", "\\'") %>')">
                                                <i class="fa-solid fa-upload"></i> Submit
                                            </button>
                                        <% } %>
                                    </div>
                                </div>
                            <% } %>
                        <% } %>
                    </div>
                </section>

                <!-- RIGHT: ATTENDANCE SUMMARY -->
                <section class="panel-card" id="attendance">
                    <div class="panel-card-header">
                        <h3>
                            <i class="fa-solid fa-calendar-check"></i>
                            Attendance Health
                        </h3>
                        <span class="stat-trend <%= attendanceRate >= 75.0 ? "positive" : "warning" %>">
                            <%= attendanceRate >= 75.0 ? "Compliant (>75%)" : "At Risk (<75%)" %>
                        </span>
                    </div>

                    <div class="panel-card-body">
                        <div class="attendance-summary-box">
                            <div class="attendance-meter-circle" style="--att-percent: <%= attendanceRate %>;">
                                <span class="attendance-meter-number"><%= Math.round(attendanceRate) %>%</span>
                            </div>

                            <div class="attendance-breakdown-text">
                                <strong><%= attendanceRate >= 75.0 ? "Good Academic Standing" : "Attendance Warning" %></strong>
                                <p>
                                    You have attended <strong><%= presentAttendance %> of <%= totalAttendance %></strong> scheduled lecture sessions. 
                                    <%= attendanceRate >= 75.0 ? "You meet the required threshold for semester examinations." : "You are currently below the required 75% attendance threshold." %>
                                </p>
                            </div>
                        </div>

                        <% if (!attendanceList.isEmpty()) { %>
                            <div style="margin-top: 18px; border-top: 1px solid var(--card-border); padding-top: 16px;">
                                <h4 style="font-size: 12.5px; font-weight: 700; color: var(--text-heading); text-transform: uppercase; letter-spacing: 0.5px; margin-bottom: 10px;">Recent Recorded Sessions</h4>
                                <table class="custom-data-table" style="width: 100%; font-size: 12px;">
                                    <tbody>
                                        <% int lim = Math.min(3, attendanceList.size());
                                           for (int i = 0; i < lim; i++) {
                                               Map<String, Object> att = attendanceList.get(i);
                                               String aDate = (String) att.get("date");
                                               String aCourse = (String) att.get("courseTitle");
                                               String aStatus = (String) att.get("status");
                                        %>
                                            <tr>
                                                <td style="padding: 6px 0; color: var(--text-muted);"><%= aDate %></td>
                                                <td style="padding: 6px 0; font-weight: 600;"><%= aCourse != null ? aCourse : "General Lecture" %></td>
                                                <td style="padding: 6px 0; text-align: right;">
                                                    <span class="status-badge <%= "PRESENT".equalsIgnoreCase(aStatus) ? "present" : "absent" %>" style="font-size: 10px; padding: 2px 8px;">
                                                        <%= aStatus %>
                                                    </span>
                                                </td>
                                            </tr>
                                        <% } %>
                                    </tbody>
                                </table>
                            </div>
                        <% } %>
                    </div>
                </section>
            </div>

            <!-- =====================================================
                 AI ASSESSMENT & SKILL EVALUATION SECTION
                 ===================================================== -->
            <section class="content-section ai-section" id="ai-assessment">
                <!-- AI Banner -->
                <div class="ai-banner-card">
                    <div class="ai-banner-content">
                        <div class="ai-pill-tag">
                            <i class="fa-solid fa-wand-magic-sparkles"></i> POWERED BY CAPACITY AI
                        </div>
                        <h2>Smart AI <span>Knowledge Diagnostic</span> & Code Review</h2>
                        <p>
                            Assess your real-time comprehension across curriculum topics, diagnose knowledge gaps,
                            and obtain instant automated feedback on your assignment code before final submission.
                        </p>
                        <div class="ai-modes-switcher">
                            <button type="button" class="btn-ai-mode active" id="btnModeQuiz" onclick="switchAiMode('quiz')">
                                <i class="fa-solid fa-brain"></i> Interactive AI Quiz
                            </button>
                            <button type="button" class="btn-ai-mode" id="btnModeCode" onclick="switchAiMode('code')">
                                <i class="fa-solid fa-code"></i> AI Code Evaluator
                            </button>
                        </div>
                    </div>

                    <div class="ai-banner-graphic">
                        <i class="fa-solid fa-microchip"></i>
                    </div>
                </div>

                <!-- AI QUIZ CONTAINER -->
                <div class="ai-quiz-box" id="aiQuizBox">
                    <div class="ai-quiz-header">
                        <div class="quiz-meta-info">
                            <span class="quiz-subject-badge" id="quizSubjectDisplay">Subject Assessment</span>
                            <div class="quiz-timer-badge">
                                <i class="fa-regular fa-clock"></i> AI Mode Active
                            </div>
                        </div>

                        <div>
                            <select id="aiSubjectSelect" class="quiz-subject-select">
                                <option value="java">Java Enterprise & Architecture</option>
                                <option value="ai">Artificial Intelligence & ML</option>
                                <option value="web">Web Design & CSS Architecture</option>
                                <option value="sql">Database Schema & SQL Mastery</option>
                            </select>
                        </div>
                    </div>

                    <div class="quiz-progress-track">
                        <div class="quiz-progress-fill" id="quizProgressFill" style="width: 0%;"></div>
                    </div>

                    <div class="quiz-question-card">
                        <span class="quiz-question-number" id="quizQuestionNum">Question 1 of 3</span>
                        <h3 class="quiz-question-text" id="quizQuestionText">Loading AI Question...</h3>
                        <pre class="quiz-code-snippet" id="quizCodeSnippet" style="display: none;"></pre>
                        <div class="quiz-options-list" id="quizOptionsList">
                            <!-- Options generated dynamically by ai-assessment.js -->
                        </div>
                    </div>

                    <div class="ai-explanation-box" id="aiExplanationBox">
                        <strong><i class="fa-solid fa-wand-magic-sparkles"></i> AI Pedagogical Analysis:</strong>
                        <p id="aiExplanationContent"></p>
                    </div>

                    <div class="quiz-controls-row">
                        <span style="font-size: 12px; color: var(--text-muted);">Select an option and click submit to receive instant AI evaluation.</span>
                        <button type="button" class="btn-ai-submit" id="btnQuizSubmit" onclick="handleQuizAction()" disabled>
                            <i class="fa-solid fa-check"></i> Submit Answer
                        </button>
                    </div>
                </div>

                <!-- AI DIAGNOSTIC REPORT CARD -->
                <div class="ai-report-card" id="aiReportCard">
                    <div class="ai-report-score-donut" id="aiReportDonut" style="--ai-score: 85;">
                        <span class="ai-report-score-val" id="aiReportScoreVal">85%</span>
                    </div>
                    <div class="ai-proficiency-tag" id="aiProficiencyTag">Proficient Learner</div>
                    <h3 style="font-size: 18px; font-weight: 800; color: var(--text-heading); margin-bottom: 8px;">AI Knowledge Assessment Complete</h3>
                    <p class="ai-feedback-summary" id="aiFeedbackSummary">
                        Great performance! Your score reflects strong grasp of core fundamentals.
                    </p>

                    <div class="ai-recommendations-list">
                        <div class="ai-recommendation-item">
                            <i class="fa-solid fa-circle-check"></i>
                            <div>
                                <strong>Strength: High Architecture Comprehension</strong>
                                <p style="color: var(--text-muted); margin-top: 2px;">Demonstrated strong mastery in request lifecycles and separation of concerns.</p>
                            </div>
                        </div>
                        <div class="ai-recommendation-item">
                            <i class="fa-solid fa-lightbulb"></i>
                            <div>
                                <strong>Suggested Focus: Database Constraints & Locking</strong>
                                <p style="color: var(--text-muted); margin-top: 2px;">Review ACID transaction guarantees and connection pool scaling strategies.</p>
                            </div>
                        </div>
                    </div>

                    <button type="button" class="btn-stat-action" style="margin: 0 auto; justify-content: center; padding: 10px 24px;" onclick="retakeAiQuiz()">
                        <i class="fa-solid fa-rotate-left"></i> Retake Assessment / Switch Topic
                    </button>
                </div>

                <!-- AI CODE EVALUATOR CONTAINER -->
                <div class="ai-code-evaluator" id="aiCodeEvaluator">
                    <div class="code-input-panel">
                        <div style="display: flex; align-items: center; justify-content: space-between;">
                            <div>
                                <h4 style="font-size: 15px; font-weight: 700; color: var(--text-heading);">Assignment Code Inspector</h4>
                                <p style="font-size: 12px; color: var(--text-muted);">Paste your assignment code to receive instant automated AI grading & vulnerability scans.</p>
                            </div>
                            <select id="aiCodeLanguage" style="padding: 6px 12px; border-radius: 6px; border: 1px solid var(--card-border); font-size: 12px; background: #ffffff;">
                                <option value="java">Java EE Servlet</option>
                                <option value="sql">SQL / JDBC</option>
                                <option value="js">JavaScript / Node</option>
                            </select>
                        </div>

                        <textarea class="code-textarea" id="aiCodeInput" placeholder="// Paste your assignment code here to evaluate...
public class UserDAO {
    public User login(String email, String password) {
        String sql = &quot;SELECT * FROM users WHERE email = ? AND password = ?&quot;;
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, email);
            ps.setString(2, password);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new User(rs.getInt(&quot;id&quot;), rs.getString(&quot;name&quot;));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }
}"></textarea>

                        <button type="button" class="btn-stat-action" id="btnEvaluateCode" style="justify-content: center; padding: 12px; background: var(--primary-gradient); color: #ffffff;" onclick="evaluateCodeWithAi()">
                            <i class="fa-solid fa-wand-magic-sparkles"></i> Analyze with AI
                        </button>
                    </div>

                    <div class="code-eval-results" id="codeEvalResults">
                        <div style="text-align: center; padding: 48px 16px; color: var(--text-muted);">
                            <i class="fa-solid fa-code" style="font-size: 32px; color: var(--primary); margin-bottom: 12px; display: block;"></i>
                            <strong>No Code Analyzed Yet</strong>
                            <p style="font-size: 12px; margin-top: 4px;">Paste your code on the left and click 'Analyze with AI' to trigger the pedagogical inspection engine.</p>
                        </div>
                    </div>
                </div>
            </section>

            <!-- =====================================================
                 STUDY MATERIALS & RESOURCES PREVIEW
                 ===================================================== -->
            <section class="content-section" id="resources">
                <div class="section-header">
                    <div class="section-title-group">
                        <h2><i class="fa-solid fa-folder-open"></i> Study Materials & Resources</h2>
                        <p>Curated lecture notes, reference PDFs, and source code repositories.</p>
                    </div>
                    <a href="${pageContext.request.contextPath}/user/my-resources.jsp" class="btn-stat-action">
                        View All Materials <i class="fa-solid fa-arrow-right"></i>
                    </a>
                </div>

                <% if (resources.isEmpty()) { %>
                    <div class="empty-state-card" style="padding: 24px;">
                        <p style="margin-bottom: 0; color: var(--text-muted);">No study materials have been uploaded by instructors yet.</p>
                    </div>
                <% } else { %>
                    <div style="display: grid; grid-template-columns: repeat(auto-fill, minmax(260px, 1fr)); gap: 18px;">
                        <% for (Map<String, Object> r : resources) { 
                            String rTitle = (String) r.get("title");
                            String rPath = (String) r.get("filePath");
                            String rCourse = (String) r.get("courseTitle");
                        %>
                            <div style="background: var(--card-bg); border: 1px solid var(--card-border); border-radius: var(--radius-md); padding: 16px; display: flex; align-items: flex-start; gap: 12px;">
                                <div style="width: 36px; height: 36px; border-radius: 8px; background: #fee2e2; color: #ef4444; display: flex; align-items: center; justify-content: center; font-size: 16px; flex-shrink: 0;">
                                    <i class="fa-solid fa-file-lines"></i>
                                </div>
                                <div style="flex: 1; min-width: 0;">
                                    <strong style="display: block; font-size: 13px; color: var(--text-heading); white-space: nowrap; overflow: hidden; text-overflow: ellipsis;"><%= rTitle %></strong>
                                    <span style="font-size: 11px; color: var(--text-muted); display: block;"><%= rCourse != null ? rCourse : "General Lecture Note" %></span>
                                    <a href="${pageContext.request.contextPath}/<%= rPath != null ? rPath : "#" %>" download style="display: inline-flex; align-items: center; gap: 4px; font-size: 11px; font-weight: 700; color: var(--primary); margin-top: 6px;">
                                        <i class="fa-solid fa-download"></i> Download
                                    </a>
                                </div>
                            </div>
                        <% } %>
                    </div>
                <% } %>
            </section>

            <!-- =====================================================
                 ACADEMIC CERTIFICATES
                 ===================================================== -->
            <section class="content-section" id="certificates">
                <div class="section-header">
                    <div class="section-title-group">
                        <h2><i class="fa-solid fa-award"></i> Earned Certifications</h2>
                        <p>Verified credentials and academic achievement records.</p>
                    </div>
                    <a href="${pageContext.request.contextPath}/user/certificates.jsp" class="btn-stat-action">
                        View Honors <i class="fa-solid fa-arrow-right"></i>
                    </a>
                </div>

                <% if (certificates.isEmpty()) { %>
                    <div class="empty-state-card" style="padding: 24px;">
                        <p style="margin-bottom: 0; color: var(--text-muted);">
                            Complete 100% of your course syllabus and assignments to earn verified Capacity Connect certificates.
                        </p>
                    </div>
                <% } else { %>
                    <div style="display: grid; grid-template-columns: repeat(auto-fill, minmax(300px, 1fr)); gap: 18px;">
                        <% for (Map<String, Object> cert : certificates) { 
                            int certId = (Integer) cert.get("certificateId");
                            String cCourse = (String) cert.get("courseTitle");
                            String issueDate = (String) cert.get("issueDate");
                            String certIdFormatted = "CC-CERT-00" + certId;
                        %>
                            <div style="background: var(--card-bg); border: 1px solid var(--card-border); border-radius: var(--radius-md); padding: 18px; display: flex; align-items: center; justify-content: space-between;">
                                <div style="display: flex; align-items: center; gap: 12px;">
                                    <div style="width: 42px; height: 42px; border-radius: 50%; background: #fef3c7; color: #d97706; display: flex; align-items: center; justify-content: center; font-size: 18px;">
                                        <i class="fa-solid fa-award"></i>
                                    </div>
                                    <div>
                                        <strong style="font-size: 13.5px; color: var(--text-heading); display: block;"><%= cCourse %></strong>
                                        <span style="font-size: 11px; color: var(--text-muted); font-family: monospace;"><%= certIdFormatted %></span>
                                    </div>
                                </div>
                                <button type="button" class="btn-stat-action" style="padding: 6px 12px; font-size: 11px;" onclick="openCertModal('<%= certIdFormatted %>', '<%= cCourse.replace("'", "\\'") %>', '<%= studentName.replace("'", "\\'") %>', '<%= issueDate != null && issueDate.length() > 10 ? issueDate.substring(0, 10) : issueDate %>')">
                                    <i class="fa-solid fa-eye"></i> View
                                </button>
                            </div>
                        <% } %>
                    </div>
                <% } %>
            </section>

        </div>
    </main>

</div>

<!-- =====================================================
     MODAL 1: SUBMIT ASSIGNMENT
     ===================================================== -->
<div class="modal-overlay" id="submitModalOverlay">
    <div class="modal-dialog">
        <div class="modal-header">
            <h3><i class="fa-solid fa-cloud-arrow-up"></i> Turn In Assignment Work</h3>
            <button type="button" class="btn-modal-close" onclick="closeSubmitModal()">&times;</button>
        </div>

        <form method="post" action="${pageContext.request.contextPath}/StudentServlet">
            <input type="hidden" name="action" value="submitAssignment">
            <input type="hidden" name="assignmentId" id="modalAssignmentId">

            <div class="modal-body">
                <div class="form-group">
                    <label class="form-label">Assignment Name</label>
                    <input type="text" class="form-control" id="modalAssignmentTitle" readonly>
                </div>

                <div class="form-group">
                    <label class="form-label">Repository URL / Cloud Submission Link *</label>
                    <input type="text" name="submissionFile" class="form-control" placeholder="e.g. https://github.com/my-repo/assignment-solution" required>
                    <span style="font-size: 11.5px; color: var(--text-dim); margin-top: 4px; display: block;">
                        Provide a link to your Git repository, Google Drive, or deployed application.
                    </span>
                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn-modal-cancel" onclick="closeSubmitModal()">Cancel</button>
                <button type="submit" class="btn-modal-submit">Submit Assignment</button>
            </div>
        </form>
    </div>
</div>

<!-- =====================================================
     MODAL 2: UPDATE SYLLABUS PROGRESS
     ===================================================== -->
<div class="modal-overlay" id="progressModalOverlay">
    <div class="modal-dialog">
        <div class="modal-header">
            <h3><i class="fa-solid fa-sliders"></i> Update Course Progress</h3>
            <button type="button" class="btn-modal-close" onclick="closeProgressModal()">&times;</button>
        </div>

        <form method="post" action="${pageContext.request.contextPath}/StudentServlet">
            <input type="hidden" name="action" value="updateProgress">
            <input type="hidden" name="courseId" id="modalCourseId">

            <div class="modal-body">
                <div class="form-group">
                    <label class="form-label">Course Title</label>
                    <input type="text" class="form-control" id="modalCourseTitle" readonly>
                </div>

                <div class="form-group">
                    <label class="form-label">Syllabus Completion Percentage: <strong id="progressDisplayVal">50</strong>%</label>
                    <input type="range" name="progress" id="progressRange" min="0" max="100" step="5" class="form-control" style="cursor: pointer;" oninput="document.getElementById('progressDisplayVal').innerText = this.value">
                </div>
            </div>

            <div class="modal-footer">
                <button type="button" class="btn-modal-cancel" onclick="closeProgressModal()">Cancel</button>
                <button type="submit" class="btn-modal-submit">Save Progress</button>
            </div>
        </form>
    </div>
</div>

<!-- =====================================================
     MODAL 3: CERTIFICATE PREVIEW
     ===================================================== -->
<div class="modal-overlay" id="certModalOverlay">
    <div class="modal-dialog" style="max-width: 740px;">
        <div class="modal-header">
            <h3><i class="fa-solid fa-award" style="color: #f59e0b;"></i> Capacity Connect Verified Credential</h3>
            <button type="button" class="btn-modal-close" onclick="closeCertModal()">&times;</button>
        </div>

        <div class="modal-body" style="padding: 24px;">
            <div class="certificate-preview-box">
                <div class="cert-gold-seal">
                    <i class="fa-solid fa-award"></i>
                </div>

                <div class="cert-watermark">CAPACITY CONNECT</div>
                <div class="cert-subheading">OFFICIAL CERTIFICATE OF COMPLETION</div>
                <div class="cert-awarded-text">This certifies that</div>
                <div class="cert-recipient-name" id="certModalStudent"><%= studentName %></div>
                <div class="cert-body-text">
                    has successfully fulfilled all academic curriculum requirements, comprehensive laboratory assessments, and university examinations for
                </div>
                <div class="cert-course-name" id="certModalCourse">Software Engineering</div>

                <div class="cert-footer-row">
                    <div class="cert-sign-col">
                        <strong id="certModalId">CC-CERT-0000</strong>
                        <span>Verification ID</span>
                    </div>

                    <div class="cert-sign-col">
                        <strong id="certModalDate">2026-09-12</strong>
                        <span>Issue Date</span>
                    </div>
                </div>
            </div>
        </div>

        <div class="modal-footer">
            <button type="button" class="btn-modal-cancel" onclick="closeCertModal()">Close</button>
            <button type="button" class="btn-modal-submit" onclick="window.print()">
                <i class="fa-solid fa-print"></i> Print Certificate
            </button>
        </div>
    </div>
</div>

<!-- =====================================================
     CLIENT-SIDE INTERACTIVITY SCRIPTS
     ===================================================== -->
<script src="${pageContext.request.contextPath}/js/s-dashboard.js"></script>
<script src="${pageContext.request.contextPath}/js/ai-assessment.js"></script>

</body>
</html>