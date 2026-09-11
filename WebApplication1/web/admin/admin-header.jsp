<%-- 
    Document   : admin-header
    Created on : 10 Sept 2026, 10:33:14 pm
    Author     : User
--%>

<%@ page contentType="text/html;charset=UTF-8" %>

<%
    String pageTitle = (String) request.getAttribute("pageTitle");

    if (pageTitle == null) {
        pageTitle = "Dashboard";
    }
%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title><%= pageTitle %> | Capacity Connect Admin</title>

    <link rel="preconnect"
          href="https://fonts.googleapis.com">

    <link rel="preconnect"
          href="https://fonts.gstatic.com"
          crossorigin>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Manrope:wght@600;700;800&display=swap"
          rel="stylesheet">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/admin.css">

</head>

<body>

<div class="admin-layout">


    <!-- MOBILE OVERLAY -->

    <div class="sidebar-overlay"
         id="sidebarOverlay"></div>


    <!-- SIDEBAR -->

    <aside class="admin-sidebar"
           id="adminSidebar">


        <!-- LOGO -->

        <a href="${pageContext.request.contextPath}/AdminServlet?action=dashboard"
           class="admin-logo">

            <div class="admin-logo-icon">
                <i class="fa-solid fa-layer-group"></i>
            </div>

            <div class="admin-logo-text">

                <strong>CAPACITY</strong>

                <span>CONNECT</span>

            </div>

        </a>


        <!-- ADMIN PROFILE -->

        <div class="admin-profile">

            <div class="admin-avatar">
                <i class="fa-solid fa-user-shield"></i>
            </div>

            <div class="admin-profile-text">

                <strong>Administrator</strong>

                <span>
                    System Admin
                </span>

            </div>

            <span class="online-dot"></span>

        </div>


        <!-- NAVIGATION -->

        <div class="nav-label">
            MAIN MENU
        </div>


        <nav class="admin-nav">


            <a href="${pageContext.request.contextPath}/AdminServlet?action=dashboard"
               class="admin-nav-link">

                <i class="fa-solid fa-grid-2"></i>

                <span>Dashboard</span>

            </a>


            <a href="${pageContext.request.contextPath}/AdminServlet?action=users"
               class="admin-nav-link">

                <i class="fa-solid fa-users"></i>

                <span>Users</span>

            </a>


            <a href="${pageContext.request.contextPath}/AdminServlet?action=teachers"
               class="admin-nav-link">

                <i class="fa-solid fa-chalkboard-user"></i>

                <span>Teachers</span>

            </a>


            <a href="${pageContext.request.contextPath}/AdminServlet?action=courses"
               class="admin-nav-link">

                <i class="fa-solid fa-book-open"></i>

                <span>Courses</span>

            </a>


            <a href="${pageContext.request.contextPath}/AdminServlet?action=classes"
               class="admin-nav-link">

                <i class="fa-solid fa-school"></i>

                <span>Classes</span>

            </a>


            <a href="${pageContext.request.contextPath}/AdminServlet?action=enrollments"
               class="admin-nav-link">

                <i class="fa-solid fa-user-plus"></i>

                <span>Enrollments</span>

            </a>


            <div class="nav-label nav-space">
                CONTENT
            </div>


            <a href="${pageContext.request.contextPath}/AdminServlet?action=resources"
               class="admin-nav-link">

                <i class="fa-solid fa-folder-open"></i>

                <span>Resources</span>

            </a>


            <a href="${pageContext.request.contextPath}/AdminServlet?action=events"
               class="admin-nav-link">

                <i class="fa-solid fa-calendar-days"></i>

                <span>Events</span>

            </a>


            <a href="${pageContext.request.contextPath}/AdminServlet?action=reports"
               class="admin-nav-link">

                <i class="fa-solid fa-chart-line"></i>

                <span>Reports</span>

            </a>


            <div class="nav-label nav-space">
                SYSTEM
            </div>


            <a href="${pageContext.request.contextPath}/AdminServlet?action=settings"
               class="admin-nav-link">

                <i class="fa-solid fa-gear"></i>

                <span>Settings</span>

            </a>

        </nav>


        <!-- SIDEBAR BOTTOM -->

        <div class="sidebar-bottom">

            <a href="${pageContext.request.contextPath}/index.jsp"
               class="sidebar-home">

                <i class="fa-solid fa-arrow-up-right-from-square"></i>

                <span>View Website</span>

            </a>


            <a href="${pageContext.request.contextPath}/LogoutServlet"
               class="sidebar-logout">

                <i class="fa-solid fa-right-from-bracket"></i>

                <span>Logout</span>

            </a>

        </div>

    </aside>


    <!-- MAIN -->

    <div class="admin-main">


        <!-- TOPBAR -->

        <header class="admin-topbar">

            <button class="mobile-menu"
                    id="mobileMenu">

                <i class="fa-solid fa-bars"></i>

            </button>


            <div class="topbar-heading">

                <span>
                    ADMINISTRATION
                </span>

                <h1>
                    <%= pageTitle %>
                </h1>

            </div>


            <div class="topbar-actions">

                <button class="top-icon">

                    <i class="fa-regular fa-bell"></i>

                    <span class="notification-dot"></span>

                </button>


                <div class="topbar-user">

                    <div class="topbar-avatar">
                        A
                    </div>

                    <div>

                        <strong>Admin</strong>

                        <span>Administrator</span>

                    </div>

                </div>

            </div>

        </header>


        <!-- PAGE CONTENT -->

        <main class="admin-content">