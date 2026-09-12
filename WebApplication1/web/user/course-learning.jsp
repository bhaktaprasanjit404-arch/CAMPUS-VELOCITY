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

    List<Map<String, Object>> enrolledCourses = (List<Map<String, Object>>) request.getAttribute("enrolledCourses");
    if (enrolledCourses == null) {
        enrolledCourses = studentDAO.getEnrolledCourses(studentId);
    }

    // Determine selected course
    int selectedCourseId = -1;
    String courseParam = request.getParameter("courseId");
    if (courseParam != null && !courseParam.trim().isEmpty()) {
        try {
            selectedCourseId = Integer.parseInt(courseParam.trim());
        } catch (NumberFormatException ignored) {}
    } else if (request.getAttribute("selectedCourseId") != null) {
        selectedCourseId = (Integer) request.getAttribute("selectedCourseId");
    }

    if (selectedCourseId <= 0 && enrolledCourses != null && !enrolledCourses.isEmpty()) {
        selectedCourseId = (Integer) enrolledCourses.get(0).get("courseId");
    }

    // Find selected course data
    Map<String, Object> currentCourse = null;
    if (enrolledCourses != null) {
        for (Map<String, Object> c : enrolledCourses) {
            if ((Integer) c.get("courseId") == selectedCourseId) {
                currentCourse = c;
                break;
            }
        }
        if (currentCourse == null && !enrolledCourses.isEmpty()) {
            currentCourse = enrolledCourses.get(0);
            selectedCourseId = (Integer) currentCourse.get("courseId");
        }
    }

    List<Map<String, Object>> courseVideos = (List<Map<String, Object>>) request.getAttribute("courseVideos");
    if (courseVideos == null && selectedCourseId > 0) {
        courseVideos = studentDAO.getVideosForCourse(selectedCourseId);
    }

    List<Map<String, Object>> courseResources = (List<Map<String, Object>>) request.getAttribute("courseResources");
    if (courseResources == null && selectedCourseId > 0) {
        courseResources = studentDAO.getResourcesForCourse(selectedCourseId);
    }

    double currentProgress = currentCourse != null && currentCourse.get("progress") != null 
            ? (Double) currentCourse.get("progress") : 0.0;

    request.setAttribute("activePage", "learning");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Course Learning | Capacity Connect</title>

    <!-- Google Fonts Inter -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">

    <!-- Font Awesome 6.5.2 -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

    <!-- User Standard CSS -->
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/user.css">

    <style>
        .learning-layout-grid {
            display: grid;
            grid-template-columns: 2.2fr 1fr;
            gap: 28px;
        }
        .video-viewport-card {
            background: #ffffff;
            border: 1px solid var(--border);
            border-radius: 20px;
            overflow: hidden;
            box-shadow: 0 6px 20px rgba(30, 40, 70, 0.03);
            margin-bottom: 24px;
        }
        .video-screen-container {
            width: 100%;
            height: 480px;
            background: #000000;
            position: relative;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .video-screen-container iframe, .video-screen-container video {
            width: 100%;
            height: 100%;
            border: none;
        }
        .video-placeholder-box {
            text-align: center;
            color: #ffffff;
            padding: 24px;
        }
        .video-placeholder-box i {
            font-size: 54px;
            color: #4b5563;
            margin-bottom: 14px;
        }
        .video-details-box {
            padding: 24px 28px;
        }
        .video-title-bar {
            display: flex;
            justify-content: space-between;
            align-items: flex-start;
            gap: 16px;
            margin-bottom: 14px;
        }
        .video-title-bar h2 {
            font-size: 20px;
            font-weight: 800;
            color: var(--dark);
        }
        .course-selector-bar {
            background: #ffffff;
            border: 1px solid var(--border);
            border-radius: 16px;
            padding: 16px 24px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-bottom: 24px;
            flex-wrap: wrap;
            gap: 14px;
        }
        .course-dropdown-select {
            padding: 10px 18px;
            border-radius: 12px;
            border: 1px solid var(--border);
            background: #f8fafc;
            color: var(--dark);
            font-size: 13.5px;
            font-weight: 600;
            font-family: inherit;
            outline: none;
            cursor: pointer;
            min-width: 280px;
        }
        .playlist-sidebar-card {
            background: #ffffff;
            border: 1px solid var(--border);
            border-radius: 20px;
            overflow: hidden;
            display: flex;
            flex-direction: column;
            margin-bottom: 24px;
        }
        .playlist-header {
            padding: 20px 24px;
            border-bottom: 1px solid var(--border);
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        .playlist-header h3 {
            font-size: 16px;
            font-weight: 800;
            color: var(--dark);
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .playlist-items {
            max-height: 480px;
            overflow-y: auto;
            display: flex;
            flex-direction: column;
        }
        .playlist-item {
            display: flex;
            align-items: center;
            gap: 14px;
            padding: 14px 20px;
            border-bottom: 1px solid var(--border);
            cursor: pointer;
            transition: .2s;
            text-decoration: none;
            color: var(--text);
        }
        .playlist-item:hover {
            background: #f8faff;
        }
        .playlist-item.active {
            background: #edf1ff;
            border-left: 4px solid var(--primary);
        }
        .playlist-item-icon {
            width: 34px;
            height: 34px;
            border-radius: 10px;
            background: #edf1ff;
            color: var(--primary);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 13px;
            flex-shrink: 0;
        }
        .playlist-item.active .playlist-item-icon {
            background: var(--primary);
            color: #ffffff;
        }
        .playlist-item-title {
            font-size: 13.5px;
            font-weight: 600;
            color: var(--dark);
            line-height: 1.3;
        }
        .resource-chip-list {
            display: flex;
            flex-direction: column;
            gap: 10px;
            margin-top: 14px;
        }
        .resource-chip {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 12px 16px;
            border-radius: 14px;
            background: #f8faff;
            border: 1px solid var(--border);
            text-decoration: none;
            color: var(--text);
            transition: .2s;
        }
        .resource-chip:hover {
            background: #edf1ff;
            border-color: #c7d2fe;
        }
        .progress-update-box {
            background: #ffffff;
            border: 1px solid var(--border);
            border-radius: 20px;
            padding: 24px;
        }
        @media (max-width: 1024px) {
            .learning-layout-grid {
                grid-template-columns: 1fr;
            }
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
                <span class="topbar-label">VIRTUAL CLASSROOM</span>
                <h1>Interactive Course Learning</h1>
            </div>
            <div class="user-profile-mini">
                <div class="mini-avatar"><%= student.getName() != null ? student.getName().substring(0, 1).toUpperCase() : "S" %></div>
                <div>
                    <strong style="display: block; font-size: 13px; color: var(--dark);"><%= student.getName() %></strong>
                    <span style="font-size: 11px; color: var(--muted);">Student ID: #<%= student.getId() %></span>
                </div>
            </div>
        </header>

        <% if (enrolledCourses == null || enrolledCourses.isEmpty()) { %>
            <div class="empty-state">
                <i class="fa-solid fa-chalkboard-user"></i>
                <h3>No Registered Courses</h3>
                <p>You need to be enrolled in a course to attend digital lectures and access course study modules.</p>
                <a href="${pageContext.request.contextPath}/courses.jsp" class="btn-user-primary" style="margin-top: 18px;">
                    <i class="fa-solid fa-compass"></i> Browse Courses Catalog
                </a>
            </div>
        <% } else { %>

            <!-- Course Switcher Bar -->
            <div class="course-selector-bar">
                <div style="display: flex; align-items: center; gap: 12px;">
                    <span style="font-size: 13px; font-weight: 700; color: var(--muted);">SELECT COURSE:</span>
                    <select class="course-dropdown-select" onchange="window.location.href='${pageContext.request.contextPath}/user/course-learning.jsp?courseId=' + this.value">
                        <% for (Map<String, Object> c : enrolledCourses) { 
                            int cid = (Integer) c.get("courseId");
                            String ctitle = (String) c.get("title");
                        %>
                            <option value="<%= cid %>" <%= cid == selectedCourseId ? "selected" : "" %>><%= ctitle %></option>
                        <% } %>
                    </select>
                </div>

                <%
                    String progBadgeClass = currentProgress >= 100 ? "completed" : "warning";
                    String progBadgeText = currentProgress >= 100 ? "COMPLETED" : "PROGRESS: " + Math.round(currentProgress) + "%";
                %>
                <div style="display: flex; align-items: center; gap: 14px;">
                    <span class="card-badge <%= progBadgeClass %>" style="margin-bottom: 0;">
                        <%= progBadgeText %>
                    </span>
                    <a href="${pageContext.request.contextPath}/user/my-resources.jsp?courseId=<%= selectedCourseId %>" class="btn-user-secondary" style="padding: 8px 14px; font-size: 12px;">
                        <i class="fa-solid fa-folder-open"></i> Course Materials
                    </a>
                </div>
            </div>

            <%
                String firstVideoUrl = (courseVideos != null && !courseVideos.isEmpty()) 
                        ? (String) courseVideos.get(0).get("videoUrl") : null;
                String firstVideoTitle = (courseVideos != null && !courseVideos.isEmpty()) 
                        ? (String) courseVideos.get(0).get("title") : "No video lectures available yet";
            %>

            <!-- Learning Grid -->
            <div class="learning-layout-grid">

                <!-- Left Column: Video Viewport & Lesson Info -->
                <div>
                    <div class="video-viewport-card">
                        <div class="video-screen-container" id="videoContainer">
                            <% if (firstVideoUrl != null && !firstVideoUrl.trim().isEmpty()) { 
                                String vUrl = firstVideoUrl.trim();
                                if (vUrl.contains("youtube.com") || vUrl.contains("youtu.be")) {
                                    String embedUrl = vUrl;
                                    if (vUrl.contains("watch?v=")) {
                                        embedUrl = vUrl.replace("watch?v=", "embed/");
                                    } else if (vUrl.contains("youtu.be/")) {
                                        embedUrl = vUrl.replace("youtu.be/", "www.youtube.com/embed/");
                                    }
                            %>
                                <iframe id="activePlayer" src="<%= embedUrl %>" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>
                            <% } else { %>
                                <video id="activePlayer" controls src="<%= vUrl %>"></video>
                            <% } %>
                            <% } else { %>
                                <div class="video-placeholder-box">
                                    <i class="fa-brands fa-youtube"></i>
                                    <h4 style="font-size: 18px; margin-bottom: 6px;">Classroom Stream Ready</h4>
                                    <p style="color: #9ca3af; font-size: 13px;">Select a lecture topic from the syllabus playlist on the right to start watching.</p>
                                </div>
                            <% } %>
                        </div>

                        <div class="video-details-box">
                            <div class="video-title-bar">
                                <div>
                                    <span style="font-size: 11px; font-weight: 800; color: var(--primary); letter-spacing: 1.2px; text-transform: uppercase;">
                                        <%= currentCourse != null ? currentCourse.get("category") : "Lecture" %>
                                    </span>
                                    <h2 id="activeVideoTitle"><%= firstVideoTitle %></h2>
                                </div>
                                <span class="status-pill present">
                                    <i class="fa-solid fa-signal"></i> Active Session
                                </span>
                            </div>

                            <p style="color: var(--muted); font-size: 13.5px; line-height: 1.6; margin-bottom: 18px;">
                                <%= currentCourse != null && currentCourse.get("description") != null 
                                    ? currentCourse.get("description") 
                                    : "Comprehensive educational curriculum curated by departmental faculty." %>
                            </p>

                            <div style="display: flex; gap: 20px; align-items: center; border-top: 1px solid var(--border); padding-top: 16px; flex-wrap: wrap;">
                                <div style="display: flex; align-items: center; gap: 8px; font-size: 13px; color: var(--dark);">
                                    <i class="fa-solid fa-user-tie" style="color: var(--primary);"></i>
                                    <span>Instructor: <strong><%= currentCourse != null ? currentCourse.get("teacherName") : "Staff" %></strong></span>
                                </div>
                                <div style="display: flex; align-items: center; gap: 8px; font-size: 13px; color: var(--dark);">
                                    <i class="fa-regular fa-clock" style="color: var(--primary);"></i>
                                    <span>Duration: <strong><%= currentCourse != null ? currentCourse.get("duration") : "Self-paced" %></strong></span>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Progress Marking Form -->
                    <div class="progress-update-box">
                        <h3 style="font-size: 16px; font-weight: 800; color: var(--dark); margin-bottom: 12px; display: flex; align-items: center; gap: 8px;">
                            <i class="fa-solid fa-list-check" style="color: var(--primary);"></i> Update Lesson Progress
                        </h3>
                        <p style="color: var(--muted); font-size: 13px; margin-bottom: 16px;">
                            Keep your curriculum progress updated. Reaching 100% completion automatically verifies your coursework and awards your certificate.
                        </p>

                        <form action="${pageContext.request.contextPath}/StudentServlet" method="POST" style="display: flex; align-items: center; gap: 14px; flex-wrap: wrap;">
                            <input type="hidden" name="action" value="updateProgress">
                            <input type="hidden" name="courseId" value="<%= selectedCourseId %>">
                            <input type="hidden" name="redirectPage" value="learning">

                            <div style="flex: 1; min-width: 220px;">
                                <div class="progress-labels" style="margin-bottom: 6px;">
                                    <span style="font-size: 12px; font-weight: 600; color: var(--muted);">Set Progress Level</span>
                                    <span id="progressValueDisplay" style="font-size: 13px; font-weight: 800; color: var(--primary);"><%= Math.round(currentProgress) %>&#37;</span>
                                </div>
                                <input type="range" name="progress" id="progressRangeInput" min="0" max="100" value="<%= Math.round(currentProgress) %>" 
                                       style="width: 100%; cursor: pointer;" oninput="document.getElementById('progressValueDisplay').innerText = this.value + '%'">
                            </div>

                            <button type="submit" class="btn-user-primary">
                                <i class="fa-solid fa-floppy-disk"></i> Save Progress
                            </button>

                            <% if (currentProgress < 100.0) { %>
                                <button type="button" class="btn-user-secondary" onclick="document.getElementById('progressRangeInput').value=100; document.getElementById('progressValueDisplay').innerText='100%'; this.form.submit();">
                                    <i class="fa-solid fa-circle-check"></i> Mark Complete (100%)
                                </button>
                            <% } %>
                        </form>
                    </div>
                </div>

                <!-- Right Column: Video Playlist & Course Resources -->
                <div>
                    <!-- Lectures Playlist -->
                    <div class="playlist-sidebar-card">
                        <div class="playlist-header">
                            <h3><i class="fa-solid fa-list-ol" style="color: var(--primary);"></i> Syllabus Lectures</h3>
                            <span class="card-badge" style="margin-bottom: 0;"><%= courseVideos != null ? courseVideos.size() : 0 %> Lessons</span>
                        </div>

                        <div class="playlist-items">
                            <% if (courseVideos == null || courseVideos.isEmpty()) { %>
                                <div style="padding: 24px; text-align: center; color: var(--muted); font-size: 13px;">
                                    No recorded video lessons have been uploaded for this course yet.
                                </div>
                            <% } else { 
                                int idx = 1;
                                for (Map<String, Object> video : courseVideos) {
                                    String vTitle = video.get("title") != null ? String.valueOf(video.get("title")) : "Lecture";
                                    String vUrl = video.get("videoUrl") != null ? String.valueOf(video.get("videoUrl")) : "";
                                    String itemActiveClass = (idx == 1) ? "active" : "";
                                    String safeVTitle = vTitle.replace("\"", "&quot;");
                            %>
                                <div class="playlist-item <%= itemActiveClass %>" 
                                     data-video-url="<%= vUrl %>" 
                                     data-video-title="<%= safeVTitle %>">
                                    <div class="playlist-item-icon">
                                        <%= idx++ %>
                                    </div>
                                    <div style="flex: 1;">
                                        <div class="playlist-item-title"><%= vTitle %></div>
                                        <div style="font-size: 11px; color: var(--muted); margin-top: 2px;">
                                             <i class="fa-solid fa-circle-play" style="font-size: 10px;"></i> Video Lesson
                                        </div>
                                    </div>
                                </div>
                            <% } } %>
                        </div>
                    </div>

                    <!-- Associated Resources -->
                    <div class="table-card">
                        <div class="table-card-header">
                            <h3><i class="fa-solid fa-file-pdf" style="color: var(--primary);"></i> Lesson Notes & Files</h3>
                        </div>
                        <div style="padding: 16px 20px;">
                            <% if (courseResources == null || courseResources.isEmpty()) { %>
                                <p style="font-size: 13px; color: var(--muted); text-align: center; padding: 12px 0;">
                                    No documents attached to this module.
                                </p>
                            <% } else { %>
                                <div class="resource-chip-list">
                                    <% for (Map<String, Object> res : courseResources) { 
                                        String rTitle = (String) res.get("title");
                                        String rType = (String) res.get("resourceType");
                                        String rUrl = (String) res.get("resourceUrl");
                                        String safeRUrl = (rUrl != null && !rUrl.trim().isEmpty()) ? rUrl : "#";
                                    %>
                                        <a href="<%= safeRUrl %>" target="_blank" class="resource-chip">
                                            <div style="display: flex; align-items: center; gap: 10px;">
                                                <i class="fa-solid fa-file-lines" style="color: var(--primary);"></i>
                                                <strong style="font-size: 12.5px; color: var(--dark);"><%= rTitle %></strong>
                                            </div>
                                            <span class="status-pill pending" style="font-size: 10px; padding: 2px 8px;"><%= rType != null ? rType : "DOC" %></span>
                                        </a>
                                    <% } %>
                                </div>
                            <% } %>
                        </div>
                    </div>
                </div>

            </div>

        <% } %>

    </main>
</div>

<!-- Video Playlist Switcher Script -->
<script>
    function changeVideo(url, title, el) {
        document.querySelectorAll('.playlist-item').forEach(item => item.classList.remove('active'));
        if (el) el.classList.add('active');

        document.getElementById('activeVideoTitle').innerText = title;

        const container = document.getElementById('videoContainer');
        if (!url || url.trim() === '') {
            container.innerHTML = '<div class="video-placeholder-box"><i class="fa-solid fa-video-slash"></i><h4 style="font-size: 18px; margin-bottom: 6px;">No Stream Available</h4><p style="color: #9ca3af; font-size: 13px;">The selected lecture has no video media attached.</p></div>';
            return;
        }

        if (url.includes('youtube.com') || url.includes('youtu.be')) {
            let embedUrl = url;
            if (url.includes('watch?v=')) {
                embedUrl = url.replace('watch?v=', 'embed/');
            } else if (url.includes('youtu.be/')) {
                embedUrl = url.replace('youtu.be/', 'www.youtube.com/embed/');
            }
            container.innerHTML = '<iframe id="activePlayer" src="' + embedUrl + '" allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" allowfullscreen></iframe>';
        } else {
            container.innerHTML = '<video id="activePlayer" controls autoplay src="' + url + '"></video>';
        }
    }

    document.addEventListener('DOMContentLoaded', function() {
        document.querySelectorAll('.playlist-item').forEach(function(item) {
            item.addEventListener('click', function() {
                var url = this.getAttribute('data-video-url') || '';
                var title = this.getAttribute('data-video-title') || 'Lecture';
                changeVideo(url, title, this);
            });
        });
    });
</script>

</body>
</html>
