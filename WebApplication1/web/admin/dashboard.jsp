<%-- 
    Document   : dashboard
    Created on : 9 Sept 2026, 5:38:05?pm
    Author     : User
--%>

<%
    request.setAttribute("pageTitle", "Dashboard");
%>

<%@ include file="admin-header.jsp" %>

<div class="page-header">

    <div>
        <h2>Good to see you, Admin ?</h2>

        <p>
            Here's what's happening across Capacity Connect today.
        </p>
    </div>

    <a href="${pageContext.request.contextPath}/AdminServlet?action=reports"
       class="secondary-btn">

        <i class="fa-solid fa-chart-line"></i>
        View Reports

    </a>

</div>


<div class="stats-grid">


    <div class="stat-card">

        <div class="stat-top">

            <div>
                <div class="stat-label">TOTAL USERS</div>
                <div class="stat-number">
                    <%= request.getAttribute("totalUsers") != null
                        ? request.getAttribute("totalUsers") : 0 %>
                </div>
            </div>

            <div class="stat-icon">
                <i class="fa-solid fa-users"></i>
            </div>

        </div>

        <div class="stat-growth">
            <i class="fa-solid fa-arrow-up"></i>
            Registered accounts
        </div>

    </div>


    <div class="stat-card purple">

        <div class="stat-top">

            <div>
                <div class="stat-label">TEACHERS</div>
                <div class="stat-number">
                    <%= request.getAttribute("totalTeachers") != null
                        ? request.getAttribute("totalTeachers") : 0 %>
                </div>
            </div>

            <div class="stat-icon">
                <i class="fa-solid fa-chalkboard-user"></i>
            </div>

        </div>

        <div class="stat-growth">
            Active teaching community
        </div>

    </div>


    <div class="stat-card green">

        <div class="stat-top">

            <div>
                <div class="stat-label">STUDENTS</div>
                <div class="stat-number">
                    <%= request.getAttribute("totalStudents") != null
                        ? request.getAttribute("totalStudents") : 0 %>
                </div>
            </div>

            <div class="stat-icon">
                <i class="fa-solid fa-user-graduate"></i>
            </div>

        </div>

        <div class="stat-growth">
            Learners on platform
        </div>

    </div>


    <div class="stat-card orange">

        <div class="stat-top">

            <div>
                <div class="stat-label">COURSES</div>
                <div class="stat-number">
                    <%= request.getAttribute("totalCourses") != null
                        ? request.getAttribute("totalCourses") : 0 %>
                </div>
            </div>

            <div class="stat-icon">
                <i class="fa-solid fa-book-open"></i>
            </div>

        </div>

        <div class="stat-growth">
            Learning programs
        </div>

    </div>

</div>


<div class="dashboard-grid">


    <!-- QUICK ACTIONS -->

    <div class="admin-panel">

        <div class="panel-heading">

            <h3>Quick Actions</h3>

        </div>

        <div class="panel-body">

            <div class="quick-grid">


                <a href="${pageContext.request.contextPath}/AdminServlet?action=add-course"
                   class="quick-action">

                    <i class="fa-solid fa-plus"></i>

                    <strong>Add Course</strong>

                    <span>
                        Create a new learning program
                    </span>

                </a>


                <a href="${pageContext.request.contextPath}/AdminServlet?action=add-resource"
                   class="quick-action">

                    <i class="fa-solid fa-file-circle-plus"></i>

                    <strong>Add Resource</strong>

                    <span>
                        Upload learning material
                    </span>

                </a>


                <a href="${pageContext.request.contextPath}/AdminServlet?action=events"
                   class="quick-action">

                    <i class="fa-solid fa-calendar-plus"></i>

                    <strong>Manage Events</strong>

                    <span>
                        Create platform events
                    </span>

                </a>


                <a href="${pageContext.request.contextPath}/AdminServlet?action=users"
                   class="quick-action">

                    <i class="fa-solid fa-users-gear"></i>

                    <strong>Manage Users</strong>

                    <span>
                        Review platform accounts
                    </span>

                </a>

            </div>

        </div>

    </div>


    <!-- ENROLLMENTS -->

    <div class="admin-panel">

        <div class="panel-heading">

            <h3>Platform Overview</h3>

            <a href="${pageContext.request.contextPath}/AdminServlet?action=enrollments">
                View
            </a>

        </div>

        <div class="panel-body">

            <div class="report-value">

                <%= request.getAttribute("totalEnrollments") != null
                    ? request.getAttribute("totalEnrollments") : 0 %>

            </div>

            <p class="report-description">

                Total course enrollments recorded across
                the Capacity Connect learning platform.

            </p>

        </div>

    </div>

</div>


<%@ include file="admin-footer.jsp" %>