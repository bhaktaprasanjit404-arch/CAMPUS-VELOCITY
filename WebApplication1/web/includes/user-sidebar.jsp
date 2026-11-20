<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.capacityconnect.model.Student" %>
<%
    String activePage = (String) request.getAttribute("activePage");
    if (activePage == null) {
        activePage = "";
    }

    String userName = (String) session.getAttribute("userName");
    if (userName == null || userName.trim().isEmpty() || userName.startsWith("Student #")) {
        userName = "Prasanjit Bhakta";
    }
    String userEmail = (String) session.getAttribute("email");
    if (userEmail == null) {
        userEmail = "prasanjit@capacityconnect.edu";
    }

    String actDashboard = ("dashboard".equals(activePage) || activePage.isEmpty()) ? "active" : "";
    String actCourses = "courses".equals(activePage) ? "active" : "";
    String actLearning = "learning".equals(activePage) ? "active" : "";
    String actProgress = "progress".equals(activePage) ? "active" : "";
    String actResources = "resources".equals(activePage) ? "active" : "";
    String actCertificates = "certificates".equals(activePage) ? "active" : "";
    String actNotifications = "notifications".equals(activePage) ? "active" : "";
    String actProfile = "profile".equals(activePage) ? "active" : "";
%>

<aside class="user-sidebar" id="userSidebar">
    <!-- Brand Logo -->
    <a href="${pageContext.request.contextPath}/user/dashboard.jsp" class="sidebar-brand-wrapper">
        <div class="sidebar-logo-icon">
            <svg viewBox="0 0 60 52" fill="none" xmlns="http://www.w3.org/2000/svg">
                <!-- Bottom layer -->
                <path d="M30 48 L10 37 L30 26 L50 37 Z" fill="#E11D48"/>
                <path d="M10 37 L30 48 L30 44 L10 33 Z" fill="#BE123C"/>
                <path d="M50 37 L30 48 L30 44 L50 33 Z" fill="#9F1239"/>
                <!-- Middle layer -->
                <path d="M30 36 L10 25 L30 14 L50 25 Z" fill="#FF385C"/>
                <path d="M10 25 L30 36 L30 32 L10 21 Z" fill="#E11D48"/>
                <path d="M50 25 L30 36 L30 32 L50 21 Z" fill="#BE123C"/>
                <!-- Top layer -->
                <path d="M30 24 L10 13 L30 2 L50 13 Z" fill="#FF6B8B"/>
                <path d="M10 13 L30 24 L30 20 L10 9 Z" fill="#FF385C"/>
                <path d="M50 13 L30 24 L30 20 L50 9 Z" fill="#E11D48"/>
            </svg>
        </div>
        <span class="sidebar-brand-title">CAPACITY</span>
        <span class="sidebar-brand-subtitle">CONNECT</span>
    </a>

    <!-- Navigation Menu -->
    <nav class="sidebar-nav-list user-nav">
        <a href="${pageContext.request.contextPath}/user/dashboard.jsp" class="sidebar-nav-item user-nav-link <%= actDashboard %>">
            <i class="fa-solid fa-house"></i>
            <span>Dashboard</span>
        </a>

        <a href="${pageContext.request.contextPath}/user/dashboard.jsp#ai-advisor-section" class="sidebar-nav-item user-nav-link">
            <i class="fa-solid fa-wand-magic-sparkles" style="color: #FF385C;"></i>
            <span>AI Advisor</span>
            <span style="margin-left: auto; background: linear-gradient(135deg, #FF385C, #7C3AED); color: #fff; font-size: 9px; font-weight: 800; padding: 2px 7px; border-radius: 12px; letter-spacing: 0.5px;">AI</span>
        </a>

        <a href="${pageContext.request.contextPath}/user/my-courses.jsp" class="sidebar-nav-item user-nav-link <%= actCourses %>">
            <i class="fa-regular fa-folder-open"></i>
            <span>My Courses</span>
        </a>

        <a href="${pageContext.request.contextPath}/user/course-learning.jsp" class="sidebar-nav-item user-nav-link <%= actLearning %>">
            <i class="fa-regular fa-circle-play"></i>
            <span>Learning Videos</span>
        </a>

        <a href="${pageContext.request.contextPath}/user/my-resources.jsp" class="sidebar-nav-item user-nav-link <%= actResources %>">
            <i class="fa-regular fa-file-lines"></i>
            <span>Resources</span>
        </a>

        <a href="${pageContext.request.contextPath}/user/dashboard.jsp#assignments-section" class="sidebar-nav-item user-nav-link">
            <i class="fa-solid fa-list-check"></i>
            <span>Assignments</span>
        </a>

        <a href="${pageContext.request.contextPath}/user/dashboard.jsp#doubt-section" class="sidebar-nav-item user-nav-link">
            <i class="fa-regular fa-comment-dots"></i>
            <span>Doubt Forum</span>
        </a>

        <a href="${pageContext.request.contextPath}/user/progress.jsp" class="sidebar-nav-item user-nav-link <%= actProgress %>">
            <i class="fa-solid fa-chart-simple"></i>
            <span>My Progress</span>
        </a>

        <a href="${pageContext.request.contextPath}/user/certificates.jsp" class="sidebar-nav-item user-nav-link <%= actCertificates %>">
            <i class="fa-solid fa-shield-halved"></i>
            <span>Certificates</span>
        </a>

        <a href="${pageContext.request.contextPath}/user/profile.jsp" class="sidebar-nav-item user-nav-link <%= actProfile %>">
            <i class="fa-solid fa-gear"></i>
            <span>Settings</span>
        </a>

        <a href="${pageContext.request.contextPath}/LogoutServlet" class="sidebar-nav-item user-nav-link">
            <i class="fa-solid fa-arrow-right-from-bracket"></i>
            <span>Logout</span>
        </a>
    </nav>

    <!-- Bottom Sidebar Promo Card: Dream Big Learn More -->
    <div class="sidebar-promo-card">
        <div class="promo-illustration-box">
            <img src="${pageContext.request.contextPath}/images/dream-big-grad.png" alt="Graduation Cap">
        </div>
        <h4>Dream Big</h4>
        <p>Learn More</p>
        <a href="${pageContext.request.contextPath}/courses.jsp" class="btn-sidebar-explore">
            Explore Courses &rarr;
        </a>
    </div>
</aside>
