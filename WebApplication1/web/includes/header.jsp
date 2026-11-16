<%--  
    Document   : header 
    Created on : 9 Sept 2026, 5:46:13 pm 
    Author     : User 
--%> 
 
<!-- ===================================================== 
     CAPACITY CONNECT ? PREMIUM HEADER 
     ===================================================== --> 
 
<header class="main-header"> 
 
    <div class="header-container"> 
 
        <!-- LOGO --> 
        <a href="index.jsp" class="logo"> 
 
            <span class="logo-icon"> 
                <i class="fa-solid fa-layer-group"></i> 
            </span> 
 
            <span class="logo-text"> 
                <span class="logo-main">CAPACITY</span> 
                <span class="logo-sub">CONNECT</span> 
            </span> 
 
        </a> 
 
 
        <!-- DESKTOP NAVIGATION --> 
        <nav class="main-nav" id="mainNav"> 
 
            <a href="index.jsp" class="nav-link"> 
                Home 
            </a> 
 
            <a href="courses.jsp" class="nav-link"> 
                Courses 
            </a> 
 
            <a href="about.jsp" class="nav-link"> 
                About 
            </a> 
 
            <a href="ResourceServlet" class="nav-link">
                Resources
            </a>
 
            <a href="events.jsp" class="nav-link"> 
                Events 
            </a> 
 
            <a href="contact.jsp" class="nav-link"> 
                Contact 
            </a> 
 
        </nav> 
 
 
        <!-- RIGHT SIDE --> 
        <div class="header-actions"> 
 
            <!-- SEARCH --> 
            <button class="header-icon-btn" 
                    id="searchBtn" 
                    aria-label="Search"> 
 
                <i class="fa-solid fa-magnifying-glass"></i> 
 
            </button> 
 
 
            <!-- LOGIN --> 
            <!-- Existing class name kept exactly same --> 
            <a href="login.jsp" 
               class="header-login" 
               data-auth-open="login"> 
 
                <i class="fa-regular fa-user"></i> 
 
                <span>Login</span> 
 
            </a> 
 
 
            <!-- JOIN BUTTON --> 
            <!-- Existing class name kept exactly same --> 
            <a href="register.jsp" 
               class="header-join" 
               data-auth-open="register"> 
 
                <span>Join Now</span> 
 
                <i class="fa-solid fa-arrow-right"></i> 
 
            </a> 
 
 
            <!-- MOBILE MENU --> 
            <button class="mobile-menu-btn" 
                    id="mobileMenuBtn" 
                    aria-label="Open Menu"> 
 
                <span></span> 
                <span></span> 
                <span></span> 
 
            </button> 
 
        </div> 
 
    </div> 
 
 
    <!-- SEARCH OVERLAY --> 
    <div class="header-search" id="headerSearch"> 
 
        <div class="search-inner"> 
 
            <i class="fa-solid fa-magnifying-glass"></i> 
 
            <input 
                type="text" 
                id="headerSearchInput" 
                placeholder="Search courses, skills, resources..." 
                autocomplete="off" 
            /> 
 
            <button id="closeSearch" aria-label="Close Search"> 
                <i class="fa-solid fa-xmark"></i> 
            </button> 
 
        </div> 
 
    </div> 
 
</header>


<!-- =====================================================
     AUTH MODAL
     
     This loads the transparent Login/Register popup.
     
     Existing header classes are NOT changed.
     ===================================================== -->

<%@ include file="auth-modal.jsp" %>

<link rel="stylesheet" href="<%= request.getContextPath() %>/css/auth-modal.css">
<script src="<%= request.getContextPath() %>/js/auth-modal.js"></script>