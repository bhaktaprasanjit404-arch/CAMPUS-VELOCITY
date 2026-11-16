<%-- 
    Document   : courses
    Created on : 9 Sept 2026, 5:24:23 pm
    Author     : User
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Courses | Capacity Connect</title>

    <!-- Google Font -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
          rel="stylesheet">

    <!-- Font Awesome -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

    <!-- Existing Header -->
    <jsp:include page="includes/header.jsp"/>

    <!-- Course CSS -->
    <link rel="stylesheet" href="css/courses.css">
    <link rel="stylesheet" href="css/header.css">
    <link rel="stylesheet" href="css/footer.css">

</head>

<body>

<main class="course-page">

    <!-- =========================================
         HERO SECTION
    ========================================== -->

    <section class="course-hero">

        <div class="course-hero-overlay"></div>

        <div class="course-hero-content">

            <span class="hero-badge">
                <i class="fa-solid fa-graduation-cap"></i>
                Learn. Grow. Succeed.
            </span>

            <h1>
                Upgrade Your Skills.
                <span>Build Your Future.</span>
            </h1>

            <p>
                Learn practical skills from carefully designed courses,
                expert instructors and industry-focused learning paths.
            </p>

            <!-- Search -->

            <div class="course-search">

                <i class="fa-solid fa-magnifying-glass"></i>

                <input type="text"
                       id="courseSearch"
                       placeholder="What do you want to learn?">

                <button type="button">
                    Search
                </button>

            </div>

            <div class="hero-mini-stats">

                <div>
                    <strong>50+</strong>
                    <span>Courses</span>
                </div>

                <div>
                    <strong>10K+</strong>
                    <span>Learners</span>
                </div>

                <div>
                    <strong>25+</strong>
                    <span>Experts</span>
                </div>

            </div>

        </div>

    </section>


    <!-- =========================================
         CATEGORY SECTION
    ========================================== -->

    <section class="category-section">

        <div class="section-heading">

            <div>
                <span class="small-label">EXPLORE</span>

                <h2>
                    Find Your Learning Path
                </h2>

                <p>
                    Choose a category and start building skills that matter.
                </p>
            </div>

            <a href="#" class="view-all">
                View all
                <i class="fa-solid fa-arrow-right"></i>
            </a>

        </div>


        <div class="category-list">

            <button class="category-pill active">
                <i class="fa-solid fa-layer-group"></i>
                All Courses
            </button>

            <button class="category-pill">
                <i class="fa-solid fa-code"></i>
                Programming
            </button>

            <button class="category-pill">
                <i class="fa-solid fa-database"></i>
                Database
            </button>

            <button class="category-pill">
                <i class="fa-solid fa-brain"></i>
                AI & ML
            </button>

            <button class="category-pill">
                <i class="fa-solid fa-chart-line"></i>
                Business
            </button>

            <button class="category-pill">
                <i class="fa-solid fa-palette"></i>
                Design
            </button>

        </div>

    </section>


    <!-- =========================================
         FEATURED COURSE
    ========================================== -->

    <section class="featured-section">

        <div class="featured-card">

            <div class="featured-image">

                <img src="images/full-stack.jpg"
                     alt="Featured Course">

                <span class="featured-tag">
                    <i class="fa-solid fa-fire"></i>
                    Featured
                </span>

            </div>


            <div class="featured-content">

                <span class="course-type">
                    FULL STACK DEVELOPMENT
                </span>

                <h2>
                    Become a Modern Web Developer
                </h2>

                <p>
                    Master frontend, backend, databases and real-world
                    application development through practical projects.
                </p>


                <div class="featured-info">

                    <span>
                        <i class="fa-regular fa-clock"></i>
                        42 Hours
                    </span>

                    <span>
                        <i class="fa-solid fa-signal"></i>
                        Intermediate
                    </span>

                    <span>
                        <i class="fa-solid fa-video"></i>
                        86 Lessons
                    </span>

                </div>


                <div class="featured-bottom">

                    <div class="instructor">

                        <div class="instructor-avatar">
                            <i class="fa-solid fa-user"></i>
                        </div>

                        <div>
                            <strong>Expert Instructor</strong>
                            <span>Industry Professional</span>
                        </div>

                    </div>


                    <a href="#" class="featured-button">
                        Start Learning
                        <i class="fa-solid fa-arrow-right"></i>
                    </a>

                </div>

            </div>

        </div>

    </section>


    <!-- =========================================
         COURSE GRID
    ========================================== -->

    <section class="courses-section">

        <div class="section-heading">

            <div>

                <span class="small-label">
                    LEARN SOMETHING NEW
                </span>

                <h2>
                    Popular Courses
                </h2>

                <p>
                    Skills designed to help you learn, build and grow.
                </p>

            </div>

            <a href="#" class="view-all">
                Explore all
                <i class="fa-solid fa-arrow-right"></i>
            </a>

        </div>


        <div class="course-grid">


            <!-- COURSE 1 -->

            <article class="course-card">

                <div class="course-image">

                    <img src="images/web.jpg"
                         alt="Java Programming">

                    <span class="course-badge">
                        Bestseller
                    </span>

                    <button class="wishlist">
                        <i class="fa-regular fa-heart"></i>
                    </button>

                </div>


                <div class="course-card-content">

                    <span class="course-category">
                        PROGRAMMING
                    </span>

                    <h3>
                        Advanced Java & Web Development
                    </h3>

                    <p>
                        Learn Java, JSP, Servlets and database connectivity
                        by building real projects.
                    </p>


                    <div class="rating">

                        <strong>4.9</strong>

                        <span class="stars">
                            ★★★★★
                        </span>

                        <span>
                            (2.4k)
                        </span>

                    </div>


                    <div class="course-meta">

                        <span>
                            <i class="fa-regular fa-clock"></i>
                            36h
                        </span>

                        <span>
                            <i class="fa-solid fa-book-open"></i>
                            72 lessons
                        </span>

                        <span>
                            <i class="fa-solid fa-signal"></i>
                            Advanced
                        </span>

                    </div>


                    <div class="course-footer">

                        <strong class="price">
                            Free
                        </strong>

                        <a href="#" class="learn-btn">
                            Learn
                            <i class="fa-solid fa-arrow-right"></i>
                        </a>

                    </div>

                </div>

            </article>


            <!-- COURSE 2 -->

            <article class="course-card">

                <div class="course-image">

                    <img src="images/python.jpg"
                         alt="Python Course">

                    <button class="wishlist">
                        <i class="fa-regular fa-heart"></i>
                    </button>

                </div>


                <div class="course-card-content">

                    <span class="course-category">
                        PROGRAMMING
                    </span>

                    <h3>
                        Python Programming From Zero
                    </h3>

                    <p>
                        Build a strong Python foundation and create
                        practical applications.
                    </p>


                    <div class="rating">

                        <strong>4.8</strong>

                        <span class="stars">
                            ★★★★★
                        </span>

                        <span>
                            (1.8k)
                        </span>

                    </div>


                    <div class="course-meta">

                        <span>
                            <i class="fa-regular fa-clock"></i>
                            28h
                        </span>

                        <span>
                            <i class="fa-solid fa-book-open"></i>
                            58 lessons
                        </span>

                        <span>
                            <i class="fa-solid fa-signal"></i>
                            Beginner
                        </span>

                    </div>


                    <div class="course-footer">

                        <strong class="price">
                            Free
                        </strong>

                        <a href="#" class="learn-btn">
                            Learn
                            <i class="fa-solid fa-arrow-right"></i>
                        </a>

                    </div>

                </div>

            </article>


            <!-- COURSE 3 -->

            <article class="course-card">

                <div class="course-image">

                    <img src="images/database.jpg"
                         alt="Database Course">

                    <span class="course-badge new">
                        New
                    </span>

                    <button class="wishlist">
                        <i class="fa-regular fa-heart"></i>
                    </button>

                </div>


                <div class="course-card-content">

                    <span class="course-category">
                        DATABASE
                    </span>

                    <h3>
                        Master MySQL & Database Design
                    </h3>

                    <p>
                        Learn SQL, database design, queries and
                        real-world database management.
                    </p>


                    <div class="rating">

                        <strong>4.9</strong>

                        <span class="stars">
                            ★★★★★
                        </span>

                        <span>
                            (960)
                        </span>

                    </div>


                    <div class="course-meta">

                        <span>
                            <i class="fa-regular fa-clock"></i>
                            20h
                        </span>

                        <span>
                            <i class="fa-solid fa-book-open"></i>
                            41 lessons
                        </span>

                        <span>
                            <i class="fa-solid fa-signal"></i>
                            Intermediate
                        </span>

                    </div>


                    <div class="course-footer">

                        <strong class="price">
                            Free
                        </strong>

                        <a href="#" class="learn-btn">
                            Learn
                            <i class="fa-solid fa-arrow-right"></i>
                        </a>

                    </div>

                </div>

            </article>


            <!-- COURSE 4 -->

            <article class="course-card">

                <div class="course-image">

                    <img src="images/ai.jpg"
                         alt="Artificial Intelligence">

                    <button class="wishlist">
                        <i class="fa-regular fa-heart"></i>
                    </button>

                </div>


                <div class="course-card-content">

                    <span class="course-category">
                        AI & MACHINE LEARNING
                    </span>

                    <h3>
                        Introduction to Artificial Intelligence
                    </h3>

                    <p>
                        Understand AI fundamentals and explore
                        practical machine learning concepts.
                    </p>


                    <div class="rating">

                        <strong>4.7</strong>

                        <span class="stars">
                            ★★★★★
                        </span>

                        <span>
                            (1.2k)
                        </span>

                    </div>


                    <div class="course-meta">

                        <span>
                            <i class="fa-regular fa-clock"></i>
                            24h
                        </span>

                        <span>
                            <i class="fa-solid fa-book-open"></i>
                            46 lessons
                        </span>

                        <span>
                            <i class="fa-solid fa-signal"></i>
                            Beginner
                        </span>

                    </div>


                    <div class="course-footer">

                        <strong class="price">
                            Free
                        </strong>

                        <a href="#" class="learn-btn">
                            Learn
                            <i class="fa-solid fa-arrow-right"></i>
                        </a>

                    </div>

                </div>

            </article>

        </div>

    </section>


    <!-- =========================================
         WHY LEARN SECTION
    ========================================== -->

    <section class="learning-section">

        <div class="learning-heading">

            <span class="small-label">
                WHY CAPACITY CONNECT?
            </span>

            <h2>
                Learning that actually moves you forward.
            </h2>

            <p>
                Everything you need to turn knowledge into practical skills.
            </p>

        </div>


        <div class="learning-grid">

            <div class="learning-box">

                <div class="learning-icon">
                    <i class="fa-solid fa-laptop-code"></i>
                </div>

                <h3>
                    Learn by Doing
                </h3>

                <p>
                    Practice through projects, assignments and
                    real-world challenges.
                </p>

            </div>


            <div class="learning-box">

                <div class="learning-icon">
                    <i class="fa-solid fa-user-tie"></i>
                </div>

                <h3>
                    Expert Guidance
                </h3>

                <p>
                    Learn from structured content created by
                    experienced instructors.
                </p>

            </div>


            <div class="learning-box">

                <div class="learning-icon">
                    <i class="fa-solid fa-certificate"></i>
                </div>

                <h3>
                    Build Your Portfolio
                </h3>

                <p>
                    Complete projects that demonstrate your skills
                    and knowledge.
                </p>

            </div>


            <div class="learning-box">

                <div class="learning-icon">
                    <i class="fa-solid fa-chart-line"></i>
                </div>

                <h3>
                    Track Progress
                </h3>

                <p>
                    Monitor your learning journey and keep improving
                    every day.
                </p>

            </div>

        </div>

    </section>


    <!-- =========================================
         CTA
    ========================================== -->

    <section class="course-cta">

        <div class="cta-content">

            <span>
                YOUR NEXT SKILL STARTS HERE
            </span>

            <h2>
                Ready to level up?
            </h2>

            <p>
                Start learning today and take one step closer
                to your career goals.
            </p>

            <a href="#" class="cta-button">
                Explore Courses
                <i class="fa-solid fa-arrow-right"></i>
            </a>

        </div>

    </section>

</main>


<!-- Existing Footer -->
<jsp:include page="includes/footer.jsp"/>


<!-- Course JS -->
<script src="js/course.js"></script>
<script src="js/header.js"></script>
</body>
</html>