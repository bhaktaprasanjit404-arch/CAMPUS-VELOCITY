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

    int enrolledCount = (stats != null && stats.get("enrolledCount") instanceof Number) 
            ? ((Number) stats.get("enrolledCount")).intValue() : 0;
    int completedCount = (stats != null && stats.get("completedCount") instanceof Number) 
            ? ((Number) stats.get("completedCount")).intValue() : 0;
    int inProgressCount = (stats != null && stats.get("inProgressCount") instanceof Number) 
            ? ((Number) stats.get("inProgressCount")).intValue() : 0;
    double avgProgress = (stats != null && stats.get("avgProgress") instanceof Number) 
            ? ((Number) stats.get("avgProgress")).doubleValue() : 0.0;
    long roundedAvgProgress = Math.round(avgProgress);

    String studentName = (student.getName() != null && !student.getName().trim().isEmpty()) 
            ? student.getName().trim() : "Student";
    String initial = studentName.length() > 0 ? studentName.substring(0, 1).toUpperCase() : "S";

    request.setAttribute("activePage", "courses");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Courses | Capacity Connect</title>

    <!-- Google Fonts Inter -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&amp;display=swap" rel="stylesheet">

    <!-- Font Awesome 6.5.2 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

    <!-- User Standard CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/user.css">

    <style>
        .filter-toolbar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 16px;
            margin-bottom: 24px;
            flex-wrap: wrap;
        }
        .filter-tabs {
            display: flex;
            gap: 8px;
            background: #ffffff;
            padding: 6px;
            border-radius: 14px;
            border: 1px solid var(--border);
        }
        .filter-btn {
            background: transparent;
            border: none;
            padding: 8px 18px;
            border-radius: 10px;
            font-size: 13px;
            font-weight: 700;
            color: var(--muted);
            cursor: pointer;
            transition: .2s;
        }
        .filter-btn.active, .filter-btn:hover {
            background: #edf1ff;
            color: var(--primary);
        }
        .search-box {
            display: flex;
            align-items: center;
            gap: 10px;
            background: #ffffff;
            border: 1px solid var(--border);
            padding: 8px 16px;
            border-radius: 14px;
            width: 280px;
        }
        .search-box input {
            border: none;
            outline: none;
            font-size: 13px;
            font-family: inherit;
            width: 100%;
            background: transparent;
        }
        .course-thumb-holder {
            width: 100%;
            height: 140px;
            border-radius: 14px;
            background: linear-gradient(135deg, #1e293b, #334155);
            margin-bottom: 16px;
            overflow: hidden;
            display: flex;
            align-items: center;
            justify-content: center;
            position: relative;
        }
        .course-thumb-holder img {
            width: 100%;
            height: 100%;
            object-fit: cover;
        }
        .course-thumb-placeholder {
            font-size: 36px;
            color: rgba(255, 255, 255, 0.4);
        }
        .course-meta-tags {
            display: flex;
            gap: 8px;
            margin-bottom: 12px;
            flex-wrap: wrap;
        }
        .teacher-info {
            display: flex;
            align-items: center;
            gap: 8px;
            font-size: 12.5px;
            color: var(--muted);
            margin-bottom: 14px;
        }
        .teacher-info i {
            color: var(--primary);
        }
        .card-actions {
            display: flex;
            gap: 10px;
            margin-top: 16px;
        }
        .card-actions .btn-user-primary, .card-actions .btn-user-secondary {
            flex: 1;
            padding: 9px 12px;
            font-size: 12.5px;
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
                <span class="topbar-label">ENROLLED CURRICULUM</span>
                <h1>My Registered Courses</h1>
            </div>
            <div class="user-profile-mini">
                <div class="mini-avatar"><%= initial %></div>
                <div>
                    <strong style="display: block; font-size: 13px; color: var(--dark);"><%= studentName %></strong>
                    <span style="font-size: 11px; color: var(--muted);">Student ID: #<%= student.getId() %></span>
                </div>
            </div>
        </header>

        <!-- Intro Banner -->
        <div class="page-intro">
            <span>LEARNING PATHWAY</span>
            <h2>Continue Where You Left Off</h2>
            <p>Access your enrolled subjects, stream classroom lecture series, review curriculum materials, and track your ongoing academic progress.</p>
        </div>

        <!-- KPI Stats Grid -->
        <div class="user-stats-grid">
            <div class="user-stat-card">
                <div class="user-stat-icon blue">
                    <i class="fa-solid fa-book-open-reader"></i>
                </div>
                <span>TOTAL ENROLLED</span>
                <strong><%= enrolledCount %></strong>
                <small>Active subject programs</small>
            </div>

            <div class="user-stat-card">
                <div class="user-stat-icon orange">
                    <i class="fa-solid fa-spinner"></i>
                </div>
                <span>IN PROGRESS</span>
                <strong><%= inProgressCount %></strong>
                <small>Curriculums underway</small>
            </div>

            <div class="user-stat-card">
                <div class="user-stat-icon green">
                    <i class="fa-solid fa-circle-check"></i>
                </div>
                <span>COMPLETED</span>
                <strong><%= completedCount %></strong>
                <small>100% course finished</small>
            </div>

            <div class="user-stat-card">
                <div class="user-stat-icon purple">
                    <i class="fa-solid fa-chart-line"></i>
                </div>
                <span>AVERAGE PROGRESS</span>
                <strong><%= roundedAvgProgress %>&#37;</strong>
                <small>Overall completion rate</small>
            </div>
        </div>

        <!-- Filter & Search Toolbar -->
        <div class="filter-toolbar">
            <div class="filter-tabs">
                <button type="button" class="filter-btn active" onclick="filterCourses('all', this)">
                    All Courses (<%= enrolledCourses != null ? enrolledCourses.size() : 0 %>)
                </button>
                <button type="button" class="filter-btn" onclick="filterCourses('in-progress', this)">
                    In Progress (<%= inProgressCount %>)
                </button>
                <button type="button" class="filter-btn" onclick="filterCourses('completed', this)">
                    Completed (<%= completedCount %>)
                </button>
            </div>

            <div class="search-box">
                <i class="fa-solid fa-magnifying-glass" style="color: var(--muted);"></i>
                <input type="text" id="courseSearchInput" placeholder="Search courses or topics..." onkeyup="searchCourses()">
            </div>
        </div>

        <!-- Course Cards Grid -->
        <% if (enrolledCourses == null || enrolledCourses.isEmpty()) { %>
            <div class="empty-state">
                <i class="fa-solid fa-book-bookmark"></i>
                <h3>No Courses Enrolled Yet</h3>
                <p>You haven't enrolled in any university courses yet. Visit the catalog to discover cutting-edge modules and register.</p>
                <a href="${pageContext.request.contextPath}/courses.jsp" class="btn-user-primary" style="margin-top: 18px;">
                    <i class="fa-solid fa-compass"></i> Explore Course Catalog
                </a>
            </div>
        <% } else { %>
            <div class="user-card-grid" id="courseGrid">
                <% for (Map<String, Object> course : enrolledCourses) { 
                    int courseId = (course.get("courseId") instanceof Number) 
                            ? ((Number) course.get("courseId")).intValue() : 0;
                    String title = course.get("title") != null ? String.valueOf(course.get("title")) : "Course";
                    String category = course.get("category") != null ? String.valueOf(course.get("category")) : "General";
                    String level = course.get("level") != null ? String.valueOf(course.get("level")) : "All Levels";
                    String duration = course.get("duration") != null ? String.valueOf(course.get("duration")) : "Self-paced";
                    String teacherName = course.get("teacherName") != null ? String.valueOf(course.get("teacherName")) : "Faculty Member";
                    String qualification = course.get("qualification") != null ? String.valueOf(course.get("qualification")) : "";
                    String thumbnail = course.get("thumbnail") != null ? String.valueOf(course.get("thumbnail")) : "";
                    
                    double progress = (course.get("progress") instanceof Number) 
                            ? ((Number) course.get("progress")).doubleValue() : 0.0;
                    
                    String enrollStatus = course.get("enrollmentStatus") != null ? String.valueOf(course.get("enrollmentStatus")) : "";
                    boolean isCompleted = progress >= 100.0 || "COMPLETED".equalsIgnoreCase(enrollStatus);
                    String statusCategory = isCompleted ? "completed" : "in-progress";

                    String safeTitle = title.replace("\"", "&quot;");
                    String safeCategory = category.replace("\"", "&quot;");

                    String badgeClass = isCompleted ? "completed" : "warning";
                    String badgeText = isCompleted ? "COMPLETED" : "IN PROGRESS";
                    String progressColor = isCompleted ? "var(--green)" : "var(--primary)";
                    String progressFillClass = isCompleted ? "green" : "";
                    long roundedProgress = Math.round(progress);
                    double fillWidth = Math.min(100.0, progress);
                    String widthStyle = "width: " + fillWidth + "%;";
                %>
                <div class="user-card course-item-card" data-status="<%= statusCategory %>" data-title="<%= safeTitle.toLowerCase() %>" data-category="<%= safeCategory.toLowerCase() %>">
                    <div>
                        <!-- Thumbnail -->
                        <div class="course-thumb-holder">
                            <% if (!thumbnail.trim().isEmpty()) { %>
                                <img src="<%= thumbnail %>" alt="<%= safeTitle %>" class="course-img">
                            <% } else { %>
                                <i class="fa-solid fa-laptop-code course-thumb-placeholder"></i>
                            <% } %>
                        </div>

                        <!-- Meta Badges -->
                        <div class="course-meta-tags">
                            <span class="card-badge"><%= category %></span>
                            <span class="card-badge <%= badgeClass %>">
                                <%= badgeText %>
                            </span>
                        </div>

                        <!-- Title -->
                        <h3><%= title %></h3>

                        <!-- Instructor & Duration -->
                        <div class="teacher-info">
                            <i class="fa-solid fa-chalkboard-user"></i>
                            <span>Instructor: <strong><%= teacherName %></strong> <%= !qualification.isEmpty() ? "(" + qualification + ")" : "" %></span>
                        </div>
                        <div class="teacher-info" style="margin-top: -6px;">
                            <i class="fa-regular fa-clock"></i>
                            <span>Duration: <%= duration %> | <%= level %></span>
                        </div>

                        <!-- Progress Bar -->
                        <div class="progress-container">
                            <div class="progress-labels">
                                <span style="color: var(--muted);">Course Completion</span>
                                <span style="color: <%= progressColor %>;"><%= roundedProgress %>&#37;</span>
                            </div>
                            <div class="progress-track">
                                <div class="progress-fill <%= progressFillClass %>" style="<%= widthStyle %>"></div>
                            </div>
                        </div>
                    </div>

                    <!-- Action Buttons -->
                    <div class="card-actions">
                        <a href="${pageContext.request.contextPath}/user/course-learning.jsp?courseId=<%= courseId %>" class="btn-user-primary">
                            <i class="fa-solid fa-play"></i> Watch Lectures
                        </a>
                        <a href="${pageContext.request.contextPath}/user/my-resources.jsp?courseId=<%= courseId %>" class="btn-user-secondary">
                            <i class="fa-solid fa-file-arrow-down"></i> Notes
                        </a>
                    </div>
                </div>
                <% } %>
            </div>
        <% } %>

    </main>
</div>

<!-- Simple Filter Script -->
<script>
    function filterCourses(filter, btn) {
        document.querySelectorAll('.filter-btn').forEach(function(b) { b.classList.remove('active'); });
        btn.classList.add('active');

        var cards = document.querySelectorAll('.course-item-card');
        cards.forEach(function(card) {
            if (filter === 'all' || card.getAttribute('data-status') === filter) {
                card.style.display = 'flex';
            } else {
                card.style.display = 'none';
            }
        });
    }

    function searchCourses() {
        var query = (document.getElementById('courseSearchInput').value || '').toLowerCase().trim();
        var cards = document.querySelectorAll('.course-item-card');
        cards.forEach(function(card) {
            var title = card.getAttribute('data-title') || '';
            var category = card.getAttribute('data-category') || '';
            if (title.indexOf(query) !== -1 || category.indexOf(query) !== -1) {
                card.style.display = 'flex';
            } else {
                card.style.display = 'none';
            }
        });
    }

    // Image error fallback
    document.addEventListener('DOMContentLoaded', function() {
        document.querySelectorAll('.course-img').forEach(function(img) {
            img.addEventListener('error', function() {
                this.style.display = 'none';
            });
        });
    });
</script>

</body>
</html>