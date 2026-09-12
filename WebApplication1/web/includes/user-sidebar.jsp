<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.capacityconnect.model.Student" %>
<%
    String activePage = (String) request.getAttribute("activePage");
    if (activePage == null) {
        activePage = "";
    }

    String userName = (String) session.getAttribute("userName");
    if (userName == null || userName.trim().isEmpty()) {
        userName = "Student Portal";
    }
    String userEmail = (String) session.getAttribute("email");
    if (userEmail == null) {
        userEmail = "student@capacityconnect.edu";
    }
    String initial = userName.substring(0, 1).toUpperCase();

    String actDashboard = "dashboard".equals(activePage) ? "active" : "";
    String actCourses = "courses".equals(activePage) ? "active" : "";
    String actLearning = "learning".equals(activePage) ? "active" : "";
    String actProgress = "progress".equals(activePage) ? "active" : "";
    String actResources = "resources".equals(activePage) ? "active" : "";
    String actCertificates = "certificates".equals(activePage) ? "active" : "";
    String actAi = "ai-assessment".equals(activePage) ? "active" : "";
    String actNotifications = "notifications".equals(activePage) ? "active" : "";
    String actProfile = "profile".equals(activePage) ? "active" : "";
%>

<aside class="user-sidebar" id="userSidebar">
    <!-- Brand -->
    <div class="user-brand">
        <div class="user-brand-icon">
            <i class="fa-solid fa-graduation-cap"></i>
        </div>
        <div class="user-brand-text">
            <strong>CAPACITY</strong>
            <span>CONNECT</span>
        </div>
    </div>

    <div class="nav-section-label">STUDENT PORTAL</div>

    <!-- Navigation Links -->
    <nav class="user-nav">
        <a href="${pageContext.request.contextPath}/user/s-dashboard.jsp"
           class="user-nav-link <%= actDashboard %>">
            <i class="fa-solid fa-chart-pie"></i>
            Dashboard
        </a>

        <a href="${pageContext.request.contextPath}/user/my-courses.jsp"
           class="user-nav-link <%= actCourses %>">
            <i class="fa-solid fa-book-bookmark"></i>
            My Courses
        </a>

        <a href="${pageContext.request.contextPath}/user/course-learning.jsp"
           class="user-nav-link <%= actLearning %>">
            <i class="fa-solid fa-chalkboard-user"></i>
            Course Learning
        </a>

        <a href="${pageContext.request.contextPath}/user/progress.jsp"
           class="user-nav-link <%= actProgress %>">
            <i class="fa-solid fa-chart-line"></i>
            Progress &amp; Attendance
        </a>

        <a href="${pageContext.request.contextPath}/user/my-resources.jsp"
           class="user-nav-link <%= actResources %>">
            <i class="fa-solid fa-folder-open"></i>
            Study Materials
        </a>

        <a href="${pageContext.request.contextPath}/user/certificates.jsp"
           class="user-nav-link <%= actCertificates %>">
            <i class="fa-solid fa-award"></i>
            Certificates
        </a>

        <a href="${pageContext.request.contextPath}/user/s-dashboard.jsp#ai-assessment"
           class="user-nav-link <%= actAi %>">
            <i class="fa-solid fa-wand-magic-sparkles" style="color: #a78bfa;"></i>
            AI Assessment
            <span class="nav-badge" style="background: linear-gradient(135deg, #7c3aed, #ec4899); font-size: 10px;">AI</span>
        </a>

        <a href="${pageContext.request.contextPath}/user/notifications.jsp"
           class="user-nav-link <%= actNotifications %>">
            <i class="fa-regular fa-bell"></i>
            Notifications
        </a>

        <a href="${pageContext.request.contextPath}/user/profile.jsp"
           class="user-nav-link <%= actProfile %>">
            <i class="fa-solid fa-circle-user"></i>
            My Profile
        </a>

        <div class="nav-section-label" style="margin-top: 10px;">EXPLORE</div>

        <a href="${pageContext.request.contextPath}/courses.jsp" class="user-nav-link">
            <i class="fa-solid fa-compass"></i>
            Course Catalog
        </a>

        <a href="${pageContext.request.contextPath}/resources.jsp" class="user-nav-link">
            <i class="fa-solid fa-book"></i>
            Public Resources
        </a>
    </nav>

    <!-- Bottom User Profile Card -->
    <div class="sidebar-user-card">
        <div class="sidebar-avatar">
            <%= initial %>
        </div>
        <div class="sidebar-user-info">
            <strong><%= userName %></strong>
            <span><%= userEmail %></span>
        </div>
        <a href="${pageContext.request.contextPath}/LogoutServlet" class="btn-logout-icon" title="Sign Out">
            <i class="fa-solid fa-arrow-right-from-bracket"></i>
        </a>
    </div>
</aside>
