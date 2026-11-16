<%-- 
    Document   : resources
    Created on : 9 Sept 2026, 5:25:15 pm
    Author     : User
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="com.capacityconnect.model.Resource"%>

<%!
    private String escapeHtml(String value) {
        if (value == null) {
            return "";
        }

        return value
            .replace("&", "&amp;")
            .replace("<", "&lt;")
            .replace(">", "&gt;")
            .replace("\"", "&quot;")
            .replace("'", "&#39;");
    }

    private String iconForType(String type) {
        if (type == null) {
            return "fa-file-lines";
        }

        switch (type.toLowerCase()) {
            case "pdf":
                return "fa-file-pdf";
            case "video":
                return "fa-circle-play";
            case "document":
                return "fa-file-word";
            case "guide":
                return "fa-book-open";
            case "presentation":
                return "fa-file-powerpoint";
            case "link":
                return "fa-link";
            default:
                return "fa-file-lines";
        }
    }

    private String colorForCategory(String category) {
        if (category == null) {
            return "mint";
        }

        switch (category.toLowerCase()) {
            case "programming":
                return "rose";
            case "web development":
                return "mint";
            case "data science":
                return "blue";
            case "design":
                return "peach";
            case "cyber security":
                return "dark";
            default:
                return "mint";
        }
    }
%>

<%
    Object resourceAttribute = request.getAttribute("resources");

    /*
     * Direct access to resources.jsp redirects through the servlet
     * so the page receives database results and filter options.
     */
    if (resourceAttribute == null) {
        response.sendRedirect("ResourceServlet");
        return;
    }

    List<Resource> resources =
        (List<Resource>) resourceAttribute;

    List<String> categories =
        (List<String>) request.getAttribute("categories");

    if (categories == null) {
        categories = new ArrayList<>();
    }

    String searchTerm =
        (String) request.getAttribute("searchTerm");

    String selectedCategory =
        (String) request.getAttribute("selectedCategory");

    String selectedType =
        (String) request.getAttribute("selectedType");

    if (searchTerm == null) {
        searchTerm = "";
    }

    if (selectedCategory == null) {
        selectedCategory = "All";
    }

    if (selectedType == null) {
        selectedType = "All";
    }

    Integer totalValue =
        (Integer) request.getAttribute("totalResources");

    int totalResources =
        totalValue == null ? resources.size() : totalValue;
%>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <meta name="description"
          content="Discover learning resources, study guides, videos and practical knowledge with Capacity Connect.">

    <title>Learning Resources | Capacity Connect</title>

    <link rel="stylesheet" href="css/header.css">
    <link rel="stylesheet" href="css/resources.css">
    <link rel="stylesheet" href="css/footer.css">

    <link rel="preconnect" href="https://fonts.googleapis.com">

    <link rel="preconnect"
          href="https://fonts.gstatic.com" crossorigin>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
          rel="stylesheet">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
</head>

<body class="resources-page">

    <jsp:include page="includes/header.jsp" />

    <main>

        <!-- HERO -->
        <section class="resources-hero">

            <div class="resources-hero-glow"></div>

            <div class="resources-container resources-hero-layout">

                <div class="resources-hero-copy">

                    <div class="resources-eyebrow">
                        <span class="resources-eyebrow-dot"></span>
                        YOUR KNOWLEDGE HUB
                    </div>

                    <h1>
                        Knowledge that moves you
                        <span>forward.</span>
                    </h1>

                    <p>
                        Explore carefully organised learning materials,
                        practical guides and resources that help you
                        build skills and turn ambition into achievement.
                    </p>

                    <div class="resources-hero-actions">

                        <a href="#resource-library"
                           class="resources-primary-btn">
                            Explore Resources
                            <i class="fa-solid fa-arrow-right"></i>
                        </a>

                        <div class="resources-trust-note">
                            <span class="resources-trust-icon">
                                <i class="fa-solid fa-book-open"></i>
                            </span>

                            <span>
                                <strong>Learn at your pace</strong>
                                <small>Your next skill starts here</small>
                            </span>
                        </div>

                    </div>

                    <div class="resources-hero-metrics">

                        <div>
                            <strong><%= totalResources %>+</strong>
                            <span>Resources</span>
                        </div>

                        <div class="resources-metric-divider"></div>

                        <div>
                            <strong>Anytime</strong>
                            <span>Learn at your pace</span>
                        </div>

                        <div class="resources-metric-divider"></div>

                        <div>
                            <strong>One hub</strong>
                            <span>Many possibilities</span>
                        </div>

                    </div>

                </div>

                <div class="resources-hero-art">

                    <div class="resources-art-orbit resources-orbit-one"></div>
                    <div class="resources-art-orbit resources-orbit-two"></div>

                    <div class="resources-art-card resources-art-main">

                        <div class="resources-art-top">
                            <div class="resources-art-brand">
                                <span class="resources-art-logo">
                                    <i class="fa-solid fa-layer-group"></i>
                                </span>

                                <span>
                                    <strong>CAPACITY</strong>
                                    <small>CONNECT</small>
                                </span>
                            </div>

                            <span class="resources-art-live">
                                <span></span> LEARNING HUB
                            </span>
                        </div>

                        <div class="resources-art-heading">
                            <span>YOUR NEXT CHAPTER</span>
                            <h2>Learn something<br>that changes everything.</h2>
                        </div>

                        <div class="resources-art-books">

                            <div class="resources-book resources-book-one">
                                <span>
                                    <i class="fa-solid fa-code"></i>
                                </span>

                                <div>
                                    <strong>Programming</strong>
                                    <small>Build your foundation</small>
                                </div>

                                <i class="fa-solid fa-arrow-up-right-from-square"></i>
                            </div>

                            <div class="resources-book resources-book-two">
                                <span>
                                    <i class="fa-solid fa-chart-line"></i>
                                </span>

                                <div>
                                    <strong>Data & Analytics</strong>
                                    <small>Discover new insights</small>
                                </div>

                                <i class="fa-solid fa-arrow-up-right-from-square"></i>
                            </div>

                            <div class="resources-book resources-book-three">
                                <span>
                                    <i class="fa-solid fa-pen-ruler"></i>
                                </span>

                                <div>
                                    <strong>Creative Design</strong>
                                    <small>Bring ideas to life</small>
                                </div>

                                <i class="fa-solid fa-arrow-up-right-from-square"></i>
                            </div>

                        </div>

                        <div class="resources-art-footer">
                            <span>
                                <i class="fa-solid fa-circle-check"></i>
                                Knowledge for your journey
                            </span>

                            <i class="fa-solid fa-arrow-right"></i>
                        </div>

                    </div>

                    <div class="resources-floating-card resources-float-top">
                        <span class="resources-floating-icon">
                            <i class="fa-solid fa-graduation-cap"></i>
                        </span>

                        <span>
                            <strong>Keep learning</strong>
                            <small>Keep growing</small>
                        </span>
                    </div>

                    <div class="resources-floating-card resources-float-bottom">
                        <span class="resources-floating-icon resources-floating-green">
                            <i class="fa-solid fa-bolt"></i>
                        </span>

                        <span>
                            <strong>Skills for tomorrow</strong>
                            <small>One resource at a time</small>
                        </span>
                    </div>

                </div>

            </div>

            <div class="resources-hero-bottom-shape"></div>

        </section>


        <!-- INTRODUCTION -->
        <section class="resources-intro"
                 id="resource-library">

            <div class="resources-container">

                <div class="resources-section-heading">

                    <div>
                        <span class="resources-section-kicker">
                            THE RESOURCE LIBRARY
                        </span>

                        <h2>
                            Find your next
                            <span>breakthrough.</span>
                        </h2>

                        <p>
                            The right resource can change the way you learn.
                            Find the knowledge you need for your next step.
                        </p>
                    </div>

                    <div class="resources-library-badge">
                        <i class="fa-solid fa-sparkles"></i>
                        Curiosity starts here
                    </div>

                </div>


                <!-- SEARCH AND FILTERS -->
                <form action="ResourceServlet"
                      method="get"
                      class="resources-filter-panel"
                      id="resourceFilterForm">

                    <div class="resources-search-box">

                        <i class="fa-solid fa-magnifying-glass"></i>

                        <input type="search"
                               name="search"
                               id="resourceSearch"
                               value="<%= escapeHtml(searchTerm) %>"
                               placeholder="Search guides, skills, topics..."
                               aria-label="Search resources">

                        <button type="submit"
                                class="resources-search-submit">
                            Search
                        </button>

                    </div>

                    <div class="resources-filter-row">

                        <div class="resources-filter-label">
                            <i class="fa-solid fa-sliders"></i>
                            Filter by
                        </div>

                        <div class="resources-select-wrap">

                            <i class="fa-solid fa-layer-group"></i>

                            <select name="category"
                                    id="resourceCategory"
                                    aria-label="Filter by category">

                                <option value="All"
                                    <%= "All".equalsIgnoreCase(selectedCategory)
                                        ? "selected" : "" %>>
                                    All Categories
                                </option>

                                <% for (String category : categories) { %>

                                    <option
                                        value="<%= escapeHtml(category) %>"
                                        <%= category.equalsIgnoreCase(selectedCategory)
                                            ? "selected" : "" %>>

                                        <%= escapeHtml(category) %>

                                    </option>

                                <% } %>

                            </select>

                        </div>

                        <div class="resources-select-wrap">

                            <i class="fa-regular fa-file-lines"></i>

                            <select name="type"
                                    id="resourceType"
                                    aria-label="Filter by resource type">

                                <option value="All"
                                    <%= "All".equalsIgnoreCase(selectedType)
                                        ? "selected" : "" %>>
                                    All Types
                                </option>

                                <option value="PDF"
                                    <%= "PDF".equalsIgnoreCase(selectedType)
                                        ? "selected" : "" %>>
                                    PDF
                                </option>

                                <option value="Video"
                                    <%= "Video".equalsIgnoreCase(selectedType)
                                        ? "selected" : "" %>>
                                    Video
                                </option>

                                <option value="Document"
                                    <%= "Document".equalsIgnoreCase(selectedType)
                                        ? "selected" : "" %>>
                                    Document
                                </option>

                                <option value="Guide"
                                    <%= "Guide".equalsIgnoreCase(selectedType)
                                        ? "selected" : "" %>>
                                    Guide
                                </option>

                                <option value="Presentation"
                                    <%= "Presentation".equalsIgnoreCase(selectedType)
                                        ? "selected" : "" %>>
                                    Presentation
                                </option>

                                <option value="Link"
                                    <%= "Link".equalsIgnoreCase(selectedType)
                                        ? "selected" : "" %>>
                                    Link
                                </option>

                            </select>

                        </div>

                        <button type="submit"
                                class="resources-filter-apply">
                            Apply Filters
                        </button>

                        <a href="ResourceServlet"
                           class="resources-filter-reset">
                            Reset
                        </a>

                    </div>

                </form>


                <!-- RESULT SUMMARY -->
                <div class="resources-results-heading">

                    <div>
                        <span class="resources-results-label">
                            EXPLORE & DISCOVER
                        </span>

                        <h3>Featured resources</h3>
                    </div>

                    <div class="resources-results-count">
                        <span><%= resources.size() %></span>
                        resource<%= resources.size() == 1 ? "" : "s" %>
                        found
                    </div>

                </div>


                <!-- RESOURCE GRID -->
                <% if (!resources.isEmpty()) { %>

                    <div class="resources-grid">

                        <% for (Resource resource : resources) {

                            String cardColor =
                                colorForCategory(resource.getCategory());

                            String typeIcon =
                                iconForType(resource.getResourceType());

                            String thumbnail =
                                resource.getThumbnailUrl();

                            boolean hasThumbnail =
                                thumbnail != null
                                && !thumbnail.trim().isEmpty();

                        %>

                            <article class="resource-card">

                                <div class="resource-card-visual <%= cardColor %>">

                                    <% if (hasThumbnail) { %>

                                        <img
                                            class="resource-thumbnail"
                                            src="<%= escapeHtml(thumbnail) %>"
                                            alt="<%= escapeHtml(resource.getTitle()) %>"
                                            loading="lazy">

                                    <% } else { %>

                                        <div class="resource-visual-pattern"></div>

                                        <div class="resource-file-icon">
                                            <i class="fa-solid <%= typeIcon %>"></i>
                                        </div>

                                        <span class="resource-visual-label">
                                            CAPACITY CONNECT
                                        </span>

                                        <span class="resource-visual-decoration">
                                            <i class="fa-solid fa-layer-group"></i>
                                        </span>

                                    <% } %>

                                    <span class="resource-type-badge">
                                        <i class="fa-solid <%= typeIcon %>"></i>
                                        <%= escapeHtml(resource.getResourceType()) %>
                                    </span>

                                </div>


                                <div class="resource-card-content">

                                    <div class="resource-card-meta">

                                        <span class="resource-category">
                                            <span></span>
                                            <%= escapeHtml(resource.getCategory()) %>
                                        </span>

                                        <span class="resource-id">
                                            RESOURCE #<%= resource.getId() %>
                                        </span>

                                    </div>

                                    <h4>
                                        <%= escapeHtml(resource.getTitle()) %>
                                    </h4>

                                    <p class="resource-description">
                                        <%= escapeHtml(resource.getDescription()) %>
                                    </p>

                                    <div class="resource-card-divider"></div>

                                    <div class="resource-card-footer">

                                        <span class="resource-access-label">
                                            <i class="fa-solid fa-book-open"></i>
                                            Learning material
                                        </span>

                                        <a
                                            class="resource-open-btn"
                                            href="ResourceServlet?action=open&amp;id=<%= resource.getId() %>"
                                            target="_blank"
                                            rel="noopener noreferrer"
                                            aria-label="Open <%= escapeHtml(resource.getTitle()) %>">

                                            <span>Explore</span>

                                            <i class="fa-solid fa-arrow-up-right-from-square"></i>

                                        </a>

                                    </div>

                                </div>

                            </article>

                        <% } %>

                    </div>

                <% } else { %>

                    <div class="resources-empty-state">

                        <div class="resources-empty-icon">
                            <i class="fa-solid fa-magnifying-glass"></i>
                        </div>

                        <span class="resources-section-kicker">
                            NOTHING FOUND JUST YET
                        </span>

                        <h3>Your next resource is waiting.</h3>

                        <p>
                            We couldn't find a match for these filters.
                            Try a different keyword or explore all resources.
                        </p>

                        <a href="ResourceServlet"
                           class="resources-primary-btn">
                            View All Resources
                            <i class="fa-solid fa-arrow-right"></i>
                        </a>

                    </div>

                <% } %>

            </div>

        </section>


        <!-- LEARNING CTA -->
        <section class="resources-cta-section">

            <div class="resources-container">

                <div class="resources-cta">

                    <div class="resources-cta-decoration resources-cta-decoration-one"></div>
                    <div class="resources-cta-decoration resources-cta-decoration-two"></div>

                    <div class="resources-cta-icon">
                        <i class="fa-solid fa-lightbulb"></i>
                    </div>

                    <div class="resources-cta-copy">

                        <span>YOUR LEARNING JOURNEY</span>

                        <h2>
                            Every expert started
                            <em>with curiosity.</em>
                        </h2>

                        <p>
                            Explore something new today. Build a stronger
                            foundation for whatever comes next.
                        </p>

                    </div>

                    <a href="courses.jsp"
                       class="resources-cta-btn">
                        Explore Courses
                        <i class="fa-solid fa-arrow-right"></i>
                    </a>

                </div>

            </div>

        </section>

    </main>

    <jsp:include page="includes/footer.jsp" />

</body>
</html>