<%-- 
    Document   : header
    Created on : 9 Sept 2026, 5:46:13 pm
    Author     : User
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<!-- ================= HEADER ================= -->

<header class="main-header" id="mainHeader">

    <div class="header-container">

        <!-- LOGO -->
        <a href="index.jsp" class="logo">

            <div class="logo-icon">
                <i class="fas fa-graduation-cap"></i>
            </div>

            <div class="logo-text">
                <span class="logo-title">CAPACITY</span>
                <span class="logo-subtitle">CONNECT</span>
            </div>

        </a>


        <!-- MOBILE MENU BUTTON -->
        <button class="mobile-menu-btn" id="mobileMenuBtn">
            <i class="fas fa-bars"></i>
        </button>


        <!-- NAVIGATION -->
        <nav class="main-nav" id="mainNav">

            <a href="index.jsp" class="nav-link active">
                Home
            </a>

            <a href="about.jsp" class="nav-link">
                About
            </a>

            <a href="courses.jsp" class="nav-link">
                Courses
            </a>

            <a href="resources.jsp" class="nav-link">
                Resources
            </a>

            <a href="events.jsp" class="nav-link">
                Events
            </a>

            <a href="news.jsp" class="nav-link">
                News & Updates
            </a>

            <a href="contact.jsp" class="nav-link">
                Contact
            </a>

        </nav>


        <!-- HEADER ACTIONS -->
        <div class="header-actions">

            <!-- SEARCH -->
            <button class="search-btn" id="searchBtn">
                <i class="fas fa-search"></i>
            </button>


            <!-- LOGIN -->
            <a href="${pageContext.request.contextPath}/login.jsp" class="login-btn">
                <i class="fas fa-user"></i>
                Login
            </a>


            <!-- REGISTER -->
            <a href="${pageContext.request.contextPath}/register.jsp" class="signup-btn">
                Get Started
                <i class="fas fa-arrow-right"></i>
            </a>

        </div>

    </div>

</header>


<!-- ================= SEARCH OVERLAY ================= -->

<div class="search-overlay" id="searchOverlay">

    <div class="search-container">

        <button class="close-search" id="closeSearch">
            <i class="fas fa-times"></i>
        </button>

        <div class="search-content">

            <span class="search-label">
                SEARCH CAPACITY CONNECT
            </span>

            <h2>
                What are you looking for?
            </h2>

            <div class="search-box">

                <i class="fas fa-search"></i>

                <input
                    type="text"
                    id="globalSearch"
                    placeholder="Search courses, resources, events..."
                >

                <button id="searchSubmit">
                    Search
                </button>

            </div>

        </div>

    </div>

</div>