<%-- 
    Document   : index
    Created on : 9 Sept 2026, 5:01:25 pm
    Author     : User
--%>

<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Capacity Connect | Digital Learning Portal</title>


    <!-- GOOGLE FONT -->

    <link rel="preconnect"
          href="https://fonts.googleapis.com">

    <link rel="preconnect"
          href="https://fonts.gstatic.com"
          crossorigin>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
          rel="stylesheet">


    <!-- FONT AWESOME -->

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">


    <!-- MAIN CSS -->
    <link rel="stylesheet" href="css/header.css">
    <link rel="stylesheet" href="css/home.css">
    <link rel="stylesheet" href="css/footer.css">
</head>


<body>


<!-- ================= HEADER ================= -->

<%@ include file="includes/header.jsp" %>


<!-- ================= HERO SECTION ================= -->

<section class="hero-section">

    <div class="hero-background">

        <div class="hero-grid"></div>

        <div class="hero-glow hero-glow-one"></div>

        <div class="hero-glow hero-glow-two"></div>

    </div>


    <div class="hero-container">


        <!-- HERO CONTENT -->

        <div class="hero-content">

            <div class="hero-badge">

                <span class="badge-dot"></span>

                DIGITAL CAPACITY BUILDING PLATFORM

            </div>


            <h1 class="hero-title">

                Learn.
                <span>Develop.</span>
                Grow.

            </h1>


            <p class="hero-description">

                A modern digital capacity building and learning
                management portal designed to connect learners,
                teachers and administrators in one powerful
                learning ecosystem.

            </p>


            <!-- HERO BUTTONS -->

            <div class="hero-buttons">

                <a href="courses.jsp"
                   class="btn btn-primary">

                    Explore Courses

                    <i class="fas fa-arrow-right"></i>

                </a>


                <button class="btn btn-secondary"
                        onclick="openVideo()">

                    <span class="play-icon">

                        <i class="fas fa-play"></i>

                    </span>

                    Watch Introduction

                </button>

            </div>


            <!-- HERO TRUST -->

            <div class="hero-trust">

                <div class="trust-users">

                    <div class="user-avatar">
                        <i class="fas fa-user"></i>
                    </div>

                    <div class="user-avatar">
                        <i class="fas fa-user"></i>
                    </div>

                    <div class="user-avatar">
                        <i class="fas fa-user"></i>
                    </div>

                    <div class="user-avatar">
                        <i class="fas fa-user"></i>
                    </div>

                </div>


                <div class="trust-text">

                    <strong>Growing Learning Community</strong>

                    <span>
                        Students • Instructors • Professionals
                    </span>

                </div>

            </div>

        </div>


        <!-- HERO IMAGE -->

        <div class="hero-visual">

            <div class="hero-image-wrapper">

                <img
                    src="images/hero-student.jpg"
                    alt="Student learning on Capacity Connect"
                    class="hero-image"
                >

            </div>


            <!-- FLOATING CARD 1 -->

            <div class="floating-card floating-card-one">

                <div class="floating-icon blue">

                    <i class="fas fa-book-open"></i>

                </div>

                <div>

                    <strong>Active Learning</strong>

                    <span>Continue your journey</span>

                    <div class="progress-bar">

                        <div class="progress-fill"
                             style="width:72%;">
                        </div>

                    </div>

                </div>

                <b>72%</b>

            </div>


            <!-- FLOATING CARD 2 -->

            <div class="floating-card floating-card-two">

                <div class="floating-icon yellow">

                    <i class="fas fa-certificate"></i>

                </div>

                <div>

                    <strong>Certificate Ready</strong>

                    <span>Java Development</span>

                </div>

                <i class="fas fa-check-circle check-icon"></i>

            </div>


            <!-- FLOATING CARD 3 -->

            <div class="floating-card floating-card-three">

                <div class="floating-icon purple">

                    <i class="fas fa-chart-line"></i>

                </div>

                <div>

                    <span>Learning Growth</span>

                    <strong>+28.4%</strong>

                </div>

            </div>

        </div>

    </div>

</section>



<!-- ================= STATS ================= -->

<section class="stats-section">

    <div class="stats-container">


        <div class="stat-item">

            <div class="stat-icon">
                <i class="fas fa-graduation-cap"></i>
            </div>

            <div>

                <h3>500+</h3>

                <p>Learning Resources</p>

            </div>

        </div>


        <div class="stat-item">

            <div class="stat-icon">
                <i class="fas fa-users"></i>
            </div>

            <div>

                <h3>1,200+</h3>

                <p>Active Learners</p>

            </div>

        </div>


        <div class="stat-item">

            <div class="stat-icon">
                <i class="fas fa-chalkboard-teacher"></i>
            </div>

            <div>

                <h3>80+</h3>

                <p>Expert Teachers</p>

            </div>

        </div>


        <div class="stat-item">

            <div class="stat-icon">
                <i class="fas fa-certificate"></i>
            </div>

            <div>

                <h3>250+</h3>

                <p>Certificates Issued</p>

            </div>

        </div>


    </div>

</section>



<!-- ================= FEATURES ================= -->

<section class="features-section">

    <div class="section-container">


        <div class="section-heading">

            <span class="section-label">
                WHY CAPACITY CONNECT
            </span>

            <h2>
                Everything You Need To
                <span>Grow Your Skills</span>
            </h2>

            <p>
                One platform connecting learners, teachers and
                administrators for a smarter learning experience.
            </p>

        </div>


        <div class="features-grid">


            <div class="feature-card">

                <div class="feature-icon blue">
                    <i class="fas fa-laptop-code"></i>
                </div>

                <h3>Digital Learning</h3>

                <p>
                    Access structured courses, videos,
                    learning materials and assessments
                    from anywhere.
                </p>

                <a href="courses.jsp">
                    Explore Learning
                    <i class="fas fa-arrow-right"></i>
                </a>

            </div>



            <div class="feature-card">

                <div class="feature-icon purple">
                    <i class="fas fa-chalkboard-teacher"></i>
                </div>

                <h3>Teacher Connect</h3>

                <p>
                    Teachers can manage classes, students,
                    learning materials and monitor student
                    performance.
                </p>

                <a href="login.jsp">
                    Teacher Portal
                    <i class="fas fa-arrow-right"></i>
                </a>

            </div>



            <div class="feature-card">

                <div class="feature-icon yellow">
                    <i class="fas fa-chart-pie"></i>
                </div>

                <h3>Smart Progress</h3>

                <p>
                    Track learning progress, course completion,
                    assessments and overall skill development.
                </p>

                <a href="login.jsp">
                    Track Progress
                    <i class="fas fa-arrow-right"></i>
                </a>

            </div>



            <div class="feature-card">

                <div class="feature-icon green">
                    <i class="fas fa-users"></i>
                </div>

                <h3>Connected Community</h3>

                <p>
                    Create a collaborative environment where
                    learners and teachers can share knowledge.
                </p>

                <a href="about.jsp">
                    Learn More
                    <i class="fas fa-arrow-right"></i>
                </a>

            </div>


        </div>

    </div>

</section>



<!-- ================= COURSES ================= -->

<section class="courses-section">

    <div class="section-container">


        <div class="section-heading-row">

            <div>

                <span class="section-label">
                    POPULAR COURSES
                </span>

                <h2>
                    Start Learning
                    <span>Today</span>
                </h2>

            </div>


            <a href="courses.jsp"
               class="view-all-btn">

                View All Courses

                <i class="fas fa-arrow-right"></i>

            </a>

        </div>



        <div class="course-grid">


            <!-- COURSE 1 -->

            <div class="course-card">

                <div class="course-image">

                    <div class="course-category">
                        PROGRAMMING
                    </div>

                    <i class="fab fa-java course-big-icon"></i>

                </div>


                <div class="course-content">

                    <div class="course-rating">

                        <i class="fas fa-star"></i>

                        <span>4.9</span>

                    </div>

                    <h3>
                        Java Programming
                    </h3>

                    <p>
                        Learn Java from fundamentals
                        to advanced programming.
                    </p>


                    <div class="course-meta">

                        <span>
                            <i class="fas fa-play-circle"></i>
                            32 Lessons
                        </span>

                        <span>
                            <i class="fas fa-clock"></i>
                            18 Hours
                        </span>

                    </div>


                    <a href="course-details.jsp"
                       class="course-btn">

                        Start Learning

                        <i class="fas fa-arrow-right"></i>

                    </a>

                </div>

            </div>



            <!-- COURSE 2 -->

            <div class="course-card">

                <div class="course-image web">

                    <div class="course-category">
                        DEVELOPMENT
                    </div>

                    <i class="fas fa-code course-big-icon"></i>

                </div>


                <div class="course-content">

                    <div class="course-rating">

                        <i class="fas fa-star"></i>

                        <span>4.8</span>

                    </div>

                    <h3>
                        Full Stack Web Development
                    </h3>

                    <p>
                        Build modern websites and
                        powerful web applications.
                    </p>


                    <div class="course-meta">

                        <span>
                            <i class="fas fa-play-circle"></i>
                            45 Lessons
                        </span>

                        <span>
                            <i class="fas fa-clock"></i>
                            25 Hours
                        </span>

                    </div>


                    <a href="course-details.jsp"
                       class="course-btn">

                        Start Learning

                        <i class="fas fa-arrow-right"></i>

                    </a>

                </div>

            </div>



            <!-- COURSE 3 -->

            <div class="course-card">

                <div class="course-image data">

                    <div class="course-category">
                        DATA
                    </div>

                    <i class="fas fa-chart-line course-big-icon"></i>

                </div>


                <div class="course-content">

                    <div class="course-rating">

                        <i class="fas fa-star"></i>

                        <span>4.7</span>

                    </div>

                    <h3>
                        Data Analytics
                    </h3>

                    <p>
                        Understand data and transform
                        it into meaningful insights.
                    </p>


                    <div class="course-meta">

                        <span>
                            <i class="fas fa-play-circle"></i>
                            28 Lessons
                        </span>

                        <span>
                            <i class="fas fa-clock"></i>
                            16 Hours
                        </span>

                    </div>


                    <a href="course-details.jsp"
                       class="course-btn">

                        Start Learning

                        <i class="fas fa-arrow-right"></i>

                    </a>

                </div>

            </div>


        </div>

    </div>

</section>



<!-- ================= CTA ================= -->

<section class="cta-section">

    <div class="cta-container">

        <div class="cta-content">

            <span class="section-label">
                BUILD YOUR FUTURE
            </span>

            <h2>
                Your Skills.
                Your Growth.
                Your Future.
            </h2>

            <p>
                Join Capacity Connect and take the next
                step toward building the skills that matter.
            </p>


            <div class="cta-buttons">

                <a href="register.jsp"
                   class="btn btn-primary">

                    Create Free Account

                    <i class="fas fa-arrow-right"></i>

                </a>


                <a href="courses.jsp"
                   class="btn btn-secondary">

                    Explore Courses

                </a>

            </div>

        </div>

    </div>

</section>



<!-- ================= FOOTER ================= -->

<%@ include file="includes/footer.jsp" %>




<!-- ================= JAVASCRIPT ================= -->

<script src="js/home.js"></script>


</body>

</html>