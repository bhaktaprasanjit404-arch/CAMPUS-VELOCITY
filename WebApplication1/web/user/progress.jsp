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

    List<Map<String, Object>> attendanceList = (List<Map<String, Object>>) request.getAttribute("attendanceList");
    if (attendanceList == null) {
        attendanceList = studentDAO.getAllStudentAttendance(studentId);
    }

    int totalAttendance = (stats != null && stats.get("totalAttendance") instanceof Number) 
            ? ((Number) stats.get("totalAttendance")).intValue() : 0;
    int presentAttendance = (stats != null && stats.get("presentAttendance") instanceof Number) 
            ? ((Number) stats.get("presentAttendance")).intValue() : 0;
    int absentAttendance = Math.max(0, totalAttendance - presentAttendance);
    double attendanceRate = (stats != null && stats.get("attendanceRate") instanceof Number) 
            ? ((Number) stats.get("attendanceRate")).doubleValue() : 0.0;
    boolean isGoodStanding = attendanceRate >= 75.0 || totalAttendance == 0;

    String standingIconClass = isGoodStanding ? "green" : "orange";
    String standingPillClass = isGoodStanding ? "present" : "warning";
    String standingText = isGoodStanding ? "Good Standing (75%+)" : "Needs Improvement (Below 75%)";
    long roundedAttRate = Math.round(attendanceRate);

    String studentName = (student.getName() != null && !student.getName().trim().isEmpty()) 
            ? student.getName().trim() : "Student";
    String initial = studentName.length() > 0 ? studentName.substring(0, 1).toUpperCase() : "S";

    request.setAttribute("activePage", "progress");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Progress &amp; Attendance | Capacity Connect</title>

    <!-- Google Fonts Inter -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&amp;display=swap" rel="stylesheet">

    <!-- Font Awesome 6.5.2 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

    <!-- User Standard CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/user.css">

    <style>
        .progress-section-title {
            font-size: 18px;
            font-weight: 800;
            color: var(--dark);
            margin-bottom: 16px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        .table-filter-bar {
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 16px;
            padding: 16px 24px;
            border-bottom: 1px solid var(--border);
            flex-wrap: wrap;
        }
        .table-filter-tabs {
            display: flex;
            gap: 6px;
        }
        .table-tab-btn {
            background: #f1f5f9;
            border: none;
            padding: 6px 14px;
            border-radius: 8px;
            font-size: 12.5px;
            font-weight: 700;
            color: var(--muted);
            cursor: pointer;
            transition: .2s;
        }
        .table-tab-btn.active, .table-tab-btn:hover {
            background: #edf1ff;
            color: var(--primary);
        }
        .course-milestones-grid {
            display: grid;
            grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
            gap: 20px;
            margin-bottom: 32px;
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
                <span class="topbar-label">ACADEMIC AUDIT</span>
                <h1>Progress &amp; Attendance Metrics</h1>
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
            <span>PERFORMANCE AUDIT</span>
            <h2>Attendance Records &amp; Course Milestones</h2>
            <p>Monitor your verified attendance history recorded by instructors, ensure minimum qualification attendance requirements (75%+), and track curriculum milestones.</p>
        </div>

        <!-- KPI Stats Grid -->
        <div class="user-stats-grid">
            <div class="user-stat-card">
                <div class="user-stat-icon <%= standingIconClass %>">
                    <i class="fa-solid fa-chart-pie"></i>
                </div>
                <span>ATTENDANCE RATE</span>
                <strong><%= roundedAttRate %>&#37;</strong>
                <small class="status-pill <%= standingPillClass %>" style="display: inline-flex; margin-top: 4px;">
                    <%= standingText %>
                </small>
            </div>

            <div class="user-stat-card">
                <div class="user-stat-icon blue">
                    <i class="fa-solid fa-calendar-check"></i>
                </div>
                <span>SESSIONS RECORDED</span>
                <strong><%= totalAttendance %></strong>
                <small>Total classroom periods</small>
            </div>

            <div class="user-stat-card">
                <div class="user-stat-icon green">
                    <i class="fa-solid fa-user-check"></i>
                </div>
                <span>PRESENT DAYS</span>
                <strong><%= presentAttendance %></strong>
                <small>Attended classroom sessions</small>
            </div>

            <div class="user-stat-card">
                <div class="user-stat-icon purple">
                    <i class="fa-solid fa-user-xmark"></i>
                </div>
                <span>ABSENT DAYS</span>
                <strong><%= absentAttendance %></strong>
                <small>Missed classroom lectures</small>
            </div>
        </div>

        <!-- Section: Course Progress Milestones -->
        <div class="progress-section-title">
            <i class="fa-solid fa-bars-progress" style="color: var(--primary);"></i>
            <span>Course Completion Milestones</span>
        </div>

        <% if (enrolledCourses != null && !enrolledCourses.isEmpty()) { %>
            <div class="course-milestones-grid">
                <% for (Map<String, Object> c : enrolledCourses) { 
                    int cid = (c.get("courseId") instanceof Number) 
                            ? ((Number) c.get("courseId")).intValue() : 0;
                    String title = c.get("title") != null ? String.valueOf(c.get("title")) : "Course";
                    String category = c.get("category") != null ? String.valueOf(c.get("category")) : "Course";
                    String teacherName = c.get("teacherName") != null ? String.valueOf(c.get("teacherName")) : "Faculty Member";
                    double prog = (c.get("progress") instanceof Number) 
                            ? ((Number) c.get("progress")).doubleValue() : 0.0;
                    boolean isCompleted = prog >= 100.0;

                    String statusBadgeClass = isCompleted ? "present" : "pending";
                    String statusBadgeText = isCompleted ? "COMPLETED" : "IN PROGRESS";
                    String progressColor = isCompleted ? "var(--green)" : "var(--primary)";
                    String progressFillClass = isCompleted ? "green" : "";
                    long roundedProg = Math.round(prog);
                    double fillWidth = Math.min(100.0, prog);
                    String widthStyle = "width: " + fillWidth + "%;";
                %>
                <div class="user-card" style="padding: 20px;">
                    <div>
                        <div style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 8px;">
                            <span class="card-badge" style="margin-bottom: 0;"><%= category %></span>
                            <span class="status-pill <%= statusBadgeClass %>" style="font-size: 11px; padding: 2px 8px;">
                                <%= statusBadgeText %>
                            </span>
                        </div>
                        <h4 style="font-size: 15px; font-weight: 800; color: var(--dark); margin: 6px 0 4px;"><%= title %></h4>
                        <div style="font-size: 12px; color: var(--muted); margin-bottom: 14px;">
                            Instructor: <%= teacherName %>
                        </div>
                        <div class="progress-container" style="margin: 8px 0 14px;">
                            <div class="progress-labels">
                                <span style="font-size: 11px; color: var(--muted);">Progress</span>
                                <span style="font-size: 12px; font-weight: 800; color: <%= progressColor %>;"><%= roundedProg %>&#37;</span>
                            </div>
                            <div class="progress-track">
                                <div class="progress-fill <%= progressFillClass %>" style="<%= widthStyle %>"></div>
                            </div>
                        </div>
                    </div>
                    <a href="${pageContext.request.contextPath}/user/course-learning.jsp?courseId=<%= cid %>" class="btn-user-secondary" style="width: 100%; font-size: 12px; padding: 8px 12px;">
                        <i class="fa-solid fa-play"></i> Open Learning Room
                    </a>
                </div>
                <% } %>
            </div>
        <% } %>

        <!-- Section: Verified Attendance Log Table -->
        <div class="table-card">
            <div class="table-card-header">
                <h3><i class="fa-solid fa-clipboard-user" style="color: var(--primary);"></i> Detailed Attendance Records</h3>
                <span class="card-badge" style="margin-bottom: 0;"><%= attendanceList != null ? attendanceList.size() : 0 %> Total Logs</span>
            </div>

            <!-- Table Filter Toolbar -->
            <div class="table-filter-bar">
                <div class="table-filter-tabs">
                    <button type="button" class="table-tab-btn active" onclick="filterAttendance('all', this)">All Records</button>
                    <button type="button" class="table-tab-btn" onclick="filterAttendance('present', this)">Present (<%= presentAttendance %>)</button>
                    <button type="button" class="table-tab-btn" onclick="filterAttendance('absent', this)">Absent (<%= absentAttendance %>)</button>
                </div>

                <div style="display: flex; align-items: center; gap: 8px;">
                    <i class="fa-solid fa-magnifying-glass" style="color: var(--muted); font-size: 13px;"></i>
                    <input type="text" id="attSearchInput" placeholder="Filter by course title..." onkeyup="searchAttendance()" 
                           style="border: 1px solid var(--border); border-radius: 8px; padding: 6px 12px; font-size: 12.5px; outline: none;">
                </div>
            </div>

            <% if (attendanceList == null || attendanceList.isEmpty()) { %>
                <div style="padding: 40px 20px; text-align: center; color: var(--muted);">
                    <i class="fa-solid fa-calendar-xmark" style="font-size: 36px; margin-bottom: 12px; color: #cbd5e1;"></i>
                    <p style="font-size: 14px;">No attendance sessions have been logged by faculty members yet.</p>
                </div>
            <% } else { %>
                <table class="data-table">
                    <thead>
                        <tr>
                            <th>#</th>
                            <th>Session Date</th>
                            <th>Course Name</th>
                            <th>Instructor</th>
                            <th>Attendance Status</th>
                        </tr>
                    </thead>
                    <tbody id="attTableBody">
                        <% 
                            int rowNum = 1;
                            for (Map<String, Object> record : attendanceList) {
                                String date = record.get("attendanceDate") != null ? String.valueOf(record.get("attendanceDate")) : "-";
                                String cTitle = record.get("courseTitle") != null ? String.valueOf(record.get("courseTitle")) : "General Class";
                                String tName = record.get("teacherName") != null ? String.valueOf(record.get("teacherName")) : "Instructor";
                                String status = record.get("status") != null ? String.valueOf(record.get("status")) : "N/A";
                                boolean isPresent = "PRESENT".equalsIgnoreCase(status);
                                String attRowStatus = isPresent ? "present" : "absent";
                                String attPillClass = isPresent ? "present" : "absent";
                                String attIconClass = isPresent ? "fa-circle-check" : "fa-circle-xmark";
                                String safeCTitle = cTitle.replace("\"", "&quot;");
                        %>
                        <tr class="att-row" data-status="<%= attRowStatus %>" data-course="<%= safeCTitle.toLowerCase() %>">
                            <td style="color: var(--muted); font-weight: 600;"><%= rowNum++ %></td>
                            <td>
                                <i class="fa-regular fa-calendar" style="color: var(--primary); margin-right: 6px;"></i>
                                <strong><%= date %></strong>
                            </td>
                            <td>
                                <strong><%= cTitle %></strong>
                            </td>
                            <td style="color: var(--muted);">
                                <%= tName %>
                            </td>
                            <td>
                                <span class="status-pill <%= attPillClass %>">
                                    <i class="fa-solid <%= attIconClass %>"></i>
                                    <%= status.toUpperCase() %>
                                </span>
                            </td>
                        </tr>
                        <% } %>
                    </tbody>
                </table>
            <% } %>
        </div>

    </main>
</div>

<!-- Attendance Filter Script -->
<script>
    function filterAttendance(filter, btn) {
        document.querySelectorAll('.table-tab-btn').forEach(function(b) { b.classList.remove('active'); });
        btn.classList.add('active');

        var rows = document.querySelectorAll('.att-row');
        rows.forEach(function(r) {
            if (filter === 'all' || r.getAttribute('data-status') === filter) {
                r.style.display = '';
            } else {
                r.style.display = 'none';
            }
        });
    }

    function searchAttendance() {
        var query = (document.getElementById('attSearchInput').value || '').toLowerCase().trim();
        var rows = document.querySelectorAll('.att-row');
        rows.forEach(function(r) {
            var course = r.getAttribute('data-course') || '';
            if (course.indexOf(query) !== -1) {
                r.style.display = '';
            } else {
                r.style.display = 'none';
            }
        });
    }
</script>

</body>
</html>