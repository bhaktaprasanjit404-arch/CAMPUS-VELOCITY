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

    List<Map<String, Object>> resources = (List<Map<String, Object>>) request.getAttribute("resources");
    if (resources == null) {
        resources = studentDAO.getAllStudentResources(studentId);
    }

    // Optional course filter
    String filterCourseId = request.getParameter("courseId");
    int filterId = -1;
    if (filterCourseId != null && !filterCourseId.trim().isEmpty()) {
        try {
            filterId = Integer.parseInt(filterCourseId.trim());
        } catch (NumberFormatException ignored) {}
    }

    // Counts by type
    int totalResources = resources != null ? resources.size() : 0;
    int docCount = 0;
    int codeCount = 0;
    int otherCount = 0;

    if (resources != null) {
        for (Map<String, Object> r : resources) {
            String type = (String) r.get("resourceType");
            if (type != null) {
                type = type.toUpperCase();
                if (type.contains("PDF") || type.contains("DOC") || type.contains("PPT") || type.contains("NOTE")) {
                    docCount++;
                } else if (type.contains("CODE") || type.contains("ZIP") || type.contains("GIT")) {
                    codeCount++;
                } else {
                    otherCount++;
                }
            } else {
                docCount++;
            }
        }
    }

    request.setAttribute("activePage", "resources");
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Study Materials | Capacity Connect</title>

    <!-- Google Fonts Inter -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@300;400;500;600;700;800;900&display=swap" rel="stylesheet">

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
        .resource-card {
            background: #ffffff;
            border: 1px solid var(--border);
            border-radius: 20px;
            padding: 24px;
            display: flex;
            flex-direction: column;
            justify-content: space-between;
            transition: .3s;
        }
        .resource-card:hover {
            transform: translateY(-4px);
            box-shadow: 0 14px 35px rgba(30, 40, 70, 0.07);
        }
        .resource-icon-box {
            width: 50px;
            height: 50px;
            border-radius: 14px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 22px;
            margin-bottom: 16px;
        }
        .resource-icon-box.doc { background: #fee2e2; color: #dc2626; }
        .resource-icon-box.code { background: #e0e7ff; color: #4338ca; }
        .resource-icon-box.link { background: #e0f2fe; color: #0284c7; }
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
                <span class="topbar-label">DIGITAL REPOSITORY</span>
                <h1>Course Study Materials</h1>
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
            <span>LEARNING ASSETS</span>
            <h2>Curated Documents & Reference Materials</h2>
            <p>Access lecture notes, lab manuals, code templates, slides, and academic resources provided by your professors for all enrolled courses.</p>
        </div>

        <!-- KPI Stats Grid -->
        <div class="user-stats-grid">
            <div class="user-stat-card">
                <div class="user-stat-icon blue">
                    <i class="fa-solid fa-folder-open"></i>
                </div>
                <span>ALL MATERIALS</span>
                <strong><%= totalResources %></strong>
                <small>Available learning files</small>
            </div>

            <div class="user-stat-card">
                <div class="user-stat-icon orange">
                    <i class="fa-solid fa-file-pdf"></i>
                </div>
                <span>DOCS & SLIDES</span>
                <strong><%= docCount %></strong>
                <small>PDFs, handouts & notes</small>
            </div>

            <div class="user-stat-card">
                <div class="user-stat-icon purple">
                    <i class="fa-solid fa-code"></i>
                </div>
                <span>CODE REPOSITORIES</span>
                <strong><%= codeCount %></strong>
                <small>Source files & scripts</small>
            </div>

            <div class="user-stat-card">
                <div class="user-stat-icon green">
                    <i class="fa-solid fa-link"></i>
                </div>
                <span>LINKS & MEDIA</span>
                <strong><%= otherCount %></strong>
                <small>Web references & guides</small>
            </div>
        </div>

        <!-- Filter & Search Toolbar -->
        <div class="filter-toolbar">
            <div class="filter-tabs">
                <button type="button" class="filter-btn active" onclick="filterResources('all', this)">All Materials (<%= totalResources %>)</button>
                <button type="button" class="filter-btn" onclick="filterResources('doc', this)">Documents (<%= docCount %>)</button>
                <button type="button" class="filter-btn" onclick="filterResources('code', this)">Code (<%= codeCount %>)</button>
            </div>

            <div class="search-box">
                <i class="fa-solid fa-magnifying-glass" style="color: var(--muted);"></i>
                <input type="text" id="resourceSearchInput" placeholder="Search files or subjects..." onkeyup="searchResources()">
            </div>
        </div>

        <!-- Resource Cards Grid -->
        <% if (resources == null || resources.isEmpty()) { %>
            <div class="empty-state">
                <i class="fa-solid fa-folder-open"></i>
                <h3>No Study Materials Uploaded Yet</h3>
                <p>Instructors have not uploaded supplementary notes or documents for your enrolled subjects yet.</p>
                <a href="${pageContext.request.contextPath}/user/my-courses.jsp" class="btn-user-primary" style="margin-top: 18px;">
                    <i class="fa-solid fa-book-bookmark"></i> View My Courses
                </a>
            </div>
        <% } else { %>
            <div class="user-card-grid" id="resourceGrid">
                <% for (Map<String, Object> res : resources) { 
                    int courseId = res.get("courseId") != null ? (Integer) res.get("courseId") : 0;
                    String title = (String) res.get("title");
                    String rType = (String) res.get("resourceType");
                    String rUrl = (String) res.get("resourceUrl");
                    String cTitle = (String) res.get("courseTitle");
                    String category = (String) res.get("category");

                    String typeUpper = rType != null ? rType.toUpperCase() : "DOC";
                    String catClass = "doc";
                    String iconClass = "fa-file-pdf";

                    if (typeUpper.contains("CODE") || typeUpper.contains("ZIP") || typeUpper.contains("JAVA") || typeUpper.contains("PY")) {
                        catClass = "code";
                        iconClass = "fa-file-code";
                    } else if (typeUpper.contains("LINK") || typeUpper.contains("WEB") || typeUpper.contains("URL")) {
                        catClass = "link";
                        iconClass = "fa-link";
                    }

                    String safeTitle = title != null ? title.replace("\"", "&quot;") : "Resource";
                    String safeCourse = cTitle != null ? cTitle.replace("\"", "&quot;").toLowerCase() : "";
                    String safeUrl = (rUrl != null && !rUrl.trim().isEmpty()) ? rUrl : "#";
                %>
                <div class="resource-card res-item-card" data-category="<%= catClass %>" data-title="<%= safeTitle.toLowerCase() %>" data-course="<%= safeCourse %>">
                    <div>
                        <div style="display: flex; justify-content: space-between; align-items: flex-start; margin-bottom: 12px;">
                            <div class="resource-icon-box <%= catClass %>">
                                <i class="fa-solid <%= iconClass %>"></i>
                            </div>
                            <span class="card-badge" style="margin-bottom: 0;"><%= typeUpper %></span>
                        </div>

                        <span style="font-size: 11px; font-weight: 800; color: var(--primary); letter-spacing: 1.2px; text-transform: uppercase;">
                            <%= cTitle != null ? cTitle : "General Subject" %>
                        </span>

                        <h3 style="font-size: 16px; font-weight: 800; color: var(--dark); margin: 6px 0 10px;">
                            <%= title %>
                        </h3>

                        <p style="color: var(--muted); font-size: 13px; line-height: 1.5; margin-bottom: 18px;">
                            Supplementary academic material and reference notes prepared by the instructor.
                        </p>
                    </div>

                    <div>
                        <div style="border-top: 1px solid var(--border); padding-top: 16px; display: flex; justify-content: space-between; align-items: center;">
                            <span style="font-size: 12px; color: var(--muted);">
                                <i class="fa-regular fa-folder" style="color: var(--primary); margin-right: 4px;"></i>
                                <%= category != null ? category : "Academic" %>
                            </span>

                            <a href="<%= safeUrl %>" target="_blank" class="btn-user-primary" style="padding: 8px 16px; font-size: 12.5px;">
                                <i class="fa-solid fa-download"></i> Access File
                            </a>
                        </div>
                    </div>
                </div>
                <% } %>
            </div>
        <% } %>

    </main>
</div>

<!-- Resource Filter Script -->
<script>
    function filterResources(cat, btn) {
        document.querySelectorAll('.filter-btn').forEach(b => b.classList.remove('active'));
        btn.classList.add('active');

        const cards = document.querySelectorAll('.res-item-card');
        cards.forEach(card => {
            if (cat === 'all' || card.getAttribute('data-category') === cat) {
                card.style.display = 'flex';
            } else {
                card.style.display = 'none';
            }
        });
    }

    function searchResources() {
        const query = document.getElementById('resourceSearchInput').value.toLowerCase().trim();
        const cards = document.querySelectorAll('.res-item-card');
        cards.forEach(card => {
            const title = card.getAttribute('data-title') || '';
            const course = card.getAttribute('data-course') || '';
            if (title.includes(query) || course.includes(query)) {
                card.style.display = 'flex';
            } else {
                card.style.display = 'none';
            }
        });
    }
</script>

</body>
</html>
