<%@ page contentType="text/html;charset=UTF-8" %>
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

    List<Map<String, Object>> notifications = (List<Map<String, Object>>) request.getAttribute("notifications");
    if (notifications == null) {
        notifications = studentDAO.getStudentNotifications(studentId);
    }

    int totalNotifications = notifications != null ? notifications.size() : 0;
    int gradeCount = 0;
    int deadlineCount = 0;
    int certCount = 0;

    if (notifications != null) {
        for (Map<String, Object> n : notifications) {
            String type = (String) n.get("type");
            if ("GRADE".equalsIgnoreCase(type)) gradeCount++;
            else if ("DEADLINE".equalsIgnoreCase(type)) deadlineCount++;
            else if ("CERTIFICATE".equalsIgnoreCase(type)) certCount++;
        }
    }

    request.setAttribute("activePage", "notifications");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Notifications | Capacity Connect</title>

    <!-- Google Fonts Inter -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">

    <!-- Font Awesome 6.5.2 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

    <!-- User Standard CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/user.css">

    <style>
        .notif-feed-card {
            background: #ffffff;
            border: 1px solid var(--border);
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 4px 15px rgba(30, 40, 70, 0.02);
        }
        .notif-filter-bar {
            padding: 16px 24px;
            border-bottom: 1px solid var(--border);
            display: flex;
            justify-content: space-between;
            align-items: center;
            gap: 16px;
            flex-wrap: wrap;
        }
        .notif-tabs {
            display: flex;
            gap: 8px;
        }
        .notif-tab-btn {
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
        .notif-tab-btn.active, .notif-tab-btn:hover {
            background: #edf1ff;
            color: var(--primary);
        }
        .notif-item {
            display: flex;
            gap: 18px;
            padding: 20px 24px;
            border-bottom: 1px solid var(--border);
            transition: .2s;
            align-items: flex-start;
        }
        .notif-item:last-child {
            border-bottom: none;
        }
        .notif-item:hover {
            background: #fcfdff;
        }
        .notif-icon-circle {
            width: 44px;
            height: 44px;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 18px;
            flex-shrink: 0;
        }
        .notif-icon-circle.grade { background: #e7f8f0; color: #16a34a; }
        .notif-icon-circle.deadline { background: #fff5df; color: #f59e0b; }
        .notif-icon-circle.cert { background: #f1eaff; color: #7c3aed; }
        .notif-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 4px;
            flex-wrap: wrap;
            gap: 8px;
        }
        .notif-header h4 {
            font-size: 15px;
            font-weight: 800;
            color: var(--dark);
        }
        .notif-date {
            font-size: 12px;
            color: var(--muted);
        }
        .notif-body {
            font-size: 13.5px;
            color: var(--text);
            line-height: 1.5;
            margin-bottom: 8px;
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
                <span class="topbar-label">ACTIVITY HUB</span>
                <h1>Academic Notifications & Alerts</h1>
            </div>
            <div class="user-profile-mini">
                <div class="mini-avatar"><%= student.getName() != null ? student.getName().substring(0, 1).toUpperCase() : "S" %></div>
                <div>
                    <strong style="display: block; font-size: 13px; color: var(--dark);"><%= student.getName() %></strong>
                    <span style="font-size: 11px; color: var(--muted);">Student ID: #<%= student.getId() %></span>
                </div>
            </div>
        </header>

        <!-- Intro Banner -->
        <div class="page-intro">
            <span>REAL-TIME UPDATES</span>
            <h2>Stay Synced with Faculty Evaluations</h2>
            <p>Review the latest grading outcomes, instructor feedback, upcoming project deadlines, and verified academic credentials awarded to your student profile.</p>
        </div>

        <!-- KPI Stats Grid -->
        <div class="user-stats-grid">
            <div class="user-stat-card">
                <div class="user-stat-icon blue">
                    <i class="fa-regular fa-bell"></i>
                </div>
                <span>TOTAL ALERTS</span>
                <strong><%= totalNotifications %></strong>
                <small>Recent messages & notices</small>
            </div>

            <div class="user-stat-card">
                <div class="user-stat-icon green">
                    <i class="fa-solid fa-check-double"></i>
                </div>
                <span>GRADED TASKS</span>
                <strong><%= gradeCount %></strong>
                <small>Instructor reviews</small>
            </div>

            <div class="user-stat-card">
                <div class="user-stat-icon orange">
                    <i class="fa-solid fa-clock"></i>
                </div>
                <span>DUE DEADLINES</span>
                <strong><%= deadlineCount %></strong>
                <small>Pending submissions</small>
            </div>

            <div class="user-stat-card">
                <div class="user-stat-icon purple">
                    <i class="fa-solid fa-award"></i>
                </div>
                <span>CREDENTIALS</span>
                <strong><%= certCount %></strong>
                <small>Certificates awarded</small>
            </div>
        </div>

        <!-- Notification Feed Card -->
        <div class="notif-feed-card">
            <div class="notif-filter-bar">
                <div class="notif-tabs">
                    <button type="button" class="notif-tab-btn active" onclick="filterNotifs('all', this)">All Updates (<%= totalNotifications %>)</button>
                    <button type="button" class="notif-tab-btn" onclick="filterNotifs('grade', this)">Grades (<%= gradeCount %>)</button>
                    <button type="button" class="notif-tab-btn" onclick="filterNotifs('deadline', this)">Deadlines (<%= deadlineCount %>)</button>
                    <button type="button" class="notif-tab-btn" onclick="filterNotifs('cert', this)">Certificates (<%= certCount %>)</button>
                </div>

                <div style="font-size: 12px; color: var(--muted);">
                    <i class="fa-solid fa-circle" style="color: var(--green); font-size: 8px; margin-right: 4px;"></i> Live Feed Connected
                </div>
            </div>

            <% if (notifications == null || notifications.isEmpty()) { %>
                <div class="empty-state" style="border: none; border-radius: 0;">
                    <i class="fa-regular fa-bell-slash"></i>
                    <h3>No Notifications Right Now</h3>
                    <p>You're completely up to date! As assignments are graded and deadlines approach, notices will appear here.</p>
                </div>
            <% } else { %>
                <div id="notifList">
                    <% for (Map<String, Object> notif : notifications) { 
                        String type = (String) notif.get("type");
                        String title = (String) notif.get("title");
                        String message = (String) notif.get("message");
                        String date = (String) notif.get("date");
                        String icon = (String) notif.get("icon");
                        if (icon == null) icon = "fa-bell";

                        String typeClass = "grade";
                        if ("DEADLINE".equalsIgnoreCase(type)) typeClass = "deadline";
                        else if ("CERTIFICATE".equalsIgnoreCase(type)) typeClass = "cert";
                    %>
                    <div class="notif-item" data-type="<%= typeClass %>">
                        <div class="notif-icon-circle <%= typeClass %>">
                            <i class="fa-solid <%= icon %>"></i>
                        </div>
                        <div style="flex: 1;">
                            <div class="notif-header">
                                <h4><%= title %></h4>
                                <span class="notif-date"><%= date %></span>
                            </div>
                            <div class="notif-body">
                                <%= message %>
                            </div>
                            <div>
                                <% if ("DEADLINE".equalsIgnoreCase(type)) { %>
                                    <a href="${pageContext.request.contextPath}/user/s-dashboard.jsp#assignments" class="btn-user-primary" style="padding: 4px 12px; font-size: 11px;">
                                        <i class="fa-solid fa-upload"></i> Submit Now
                                    </a>
                                <% } else if ("CERTIFICATE".equalsIgnoreCase(type)) { %>
                                    <a href="${pageContext.request.contextPath}/user/certificates.jsp" class="btn-user-secondary" style="padding: 4px 12px; font-size: 11px;">
                                        <i class="fa-solid fa-award"></i> View Certificate
                                    </a>
                                <% } %>
                            </div>
                        </div>
                    </div>
                    <% } %>
                </div>
            <% } %>
        </div>

    </main>
</div>

<!-- Notification Filter Script -->
<script>
    function filterNotifs(type, btn) {
        document.querySelectorAll('.notif-tab-btn').forEach(b => b.classList.remove('active'));
        btn.classList.add('active');

        const items = document.querySelectorAll('.notif-item');
        items.forEach(item => {
            if (type === 'all' || item.getAttribute('data-type') === type) {
                item.style.display = 'flex';
            } else {
                item.style.display = 'none';
            }
        });
    }
</script>

</body>
</html>
