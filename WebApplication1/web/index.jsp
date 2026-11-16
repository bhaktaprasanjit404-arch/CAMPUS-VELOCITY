<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Capacity Connect | Digital Learning Portal</title>

    <!-- Google Font -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">

    <!-- Font Awesome -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

    <!-- CSS -->
    <link rel="stylesheet" href="css/header.css">
    <link rel="stylesheet" href="css/home.css">
    <link rel="stylesheet" href="css/footer.css">
</head>

<body>

    <!-- HEADER -->
    <jsp:include page="includes/header.jsp"/>


    <!-- ================= HERO SECTION ================= -->

    <section class="hero-section">

        <div class="hero-container">

            <!-- Slide 1 -->
            <div class="hero-slide active"
                 style="background-image: url('images/hero-student.jpg');">

                <div class="hero-content">

                    <span class="hero-tag">
                        <i class="fa-solid fa-graduation-cap"></i>
                        LEARN • GROW • SUCCEED
                    </span>

                    <h1 class="hero-title">
                        Build Your Skills.
                        <br>
                        Build Your Future.
                    </h1>

                    <p>
                        Learn from expert teachers and explore
                        practical courses designed for your career.
                    </p>

                    <div class="hero-buttons">

                        <a href="courses.jsp" class="primary-btn">
                            Explore Courses
                            <i class="fa-solid fa-arrow-right"></i>
                        </a>

                        <a href="about.jsp" class="secondary-btn">
                            Learn More
                        </a>

                    </div>

                </div>

            </div>


            <!-- Slide 2 -->
            <div class="hero-slide"
                 style="background-image: url('images/banner-python.jpg');">

                <div class="hero-content">

                    <span class="hero-tag">
                        <i class="fa-brands fa-python"></i>
                        PYTHON PROGRAMMING
                    </span>

                    <h1 class="hero-title">
                        Master Python.
                        <br>
                        Create Amazing Things.
                    </h1>

                    <p>
                        Start your programming journey with
                        practical Python learning.
                    </p>

                    <div class="hero-buttons">

                        <a href="courses.jsp" class="primary-btn">
                            Start Learning
                            <i class="fa-solid fa-arrow-right"></i>
                        </a>

                    </div>

                </div>

            </div>


            <!-- Slide 3 -->
            <div class="hero-slide"
                 style="background-image: url('images/banner-java.jpg');">

                <div class="hero-content">

                    <span class="hero-tag">
                        <i class="fa-brands fa-java"></i>
                        ADVANCED JAVA
                    </span>

                    <h1 class="hero-title">
                        Become a
                        <br>
                        Java Developer.
                    </h1>

                    <p>
                        Learn Java, JSP, Servlets and database
                        development through practical projects.
                    </p>

                    <div class="hero-buttons">

                        <a href="courses.jsp" class="primary-btn">
                            Explore Java
                            <i class="fa-solid fa-arrow-right"></i>
                        </a>

                    </div>

                </div>

            </div>


            <!-- Slide 4 -->
            <div class="hero-slide"
                 style="background-image: url('images/banner-agriculture.jpg');">

                <div class="hero-content">

                    <span class="hero-tag">
                        <i class="fa-solid fa-seedling"></i>
                        SMART AGRICULTURE
                    </span>

                    <h1 class="hero-title">
                        Technology Meets
                        <br>
                        Agriculture.
                    </h1>

                    <p>
                        Discover modern technologies transforming
                        farming and agriculture.
                    </p>

                    <div class="hero-buttons">

                        <a href="courses.jsp" class="primary-btn">
                            Discover More
                            <i class="fa-solid fa-arrow-right"></i>
                        </a>

                    </div>

                </div>

            </div>


            <!-- Slide 5 -->
            <div class="hero-slide"
                 style="background-image: url('images/banner-ai.jpg');">

                <div class="hero-content">

                    <span class="hero-tag">
                        <i class="fa-solid fa-brain"></i>
                        ARTIFICIAL INTELLIGENCE
                    </span>

                    <h1 class="hero-title">
                        Explore the World
                        <br>
                        of AI.
                    </h1>

                    <p>
                        Understand Artificial Intelligence and
                        build the skills of tomorrow.
                    </p>

                    <div class="hero-buttons">

                        <a href="courses.jsp" class="primary-btn">
                            Explore AI
                            <i class="fa-solid fa-arrow-right"></i>
                        </a>

                    </div>

                </div>

            </div>


            <!-- Slide 6 -->
            <div class="hero-slide"
                 style="background-image: url('images/banner-career.jpg');">

                <div class="hero-content">

                    <span class="hero-tag">
                        <i class="fa-solid fa-briefcase"></i>
                        CAREER DEVELOPMENT
                    </span>

                    <h1 class="hero-title">
                        Learn Today.
                        <br>
                        Lead Tomorrow.
                    </h1>

                    <p>
                        Develop the technical and professional
                        skills needed for your career.
                    </p>

                    <div class="hero-buttons">

                        <a href="courses.jsp" class="primary-btn">
                            Build Your Career
                            <i class="fa-solid fa-arrow-right"></i>
                        </a>

                    </div>

                </div>

            </div>


            <!-- HERO ARROWS -->

            <button class="hero-arrow hero-prev" id="heroPrev">
                <i class="fa-solid fa-chevron-left"></i>
            </button>

            <button class="hero-arrow hero-next" id="heroNext">
                <i class="fa-solid fa-chevron-right"></i>
            </button>


            <!-- HERO DOTS -->

            <div class="hero-dots">

                <span class="hero-dot active" data-slide="0"></span>
                <span class="hero-dot" data-slide="1"></span>
                <span class="hero-dot" data-slide="2"></span>
                <span class="hero-dot" data-slide="3"></span>
                <span class="hero-dot" data-slide="4"></span>
                <span class="hero-dot" data-slide="5"></span>

            </div>

        </div>

    </section>



    <!-- ================= STATS SECTION ================= -->

    <section class="stats-section">

        <div class="stats-container">

            <div class="stat-box">
                <i class="fa-solid fa-book-open"></i>
                <h2>50+</h2>
                <p>Learning Programs</p>
            </div>

            <div class="stat-box">
                <i class="fa-solid fa-users"></i>
                <h2>5K+</h2>
                <p>Active Learners</p>
            </div>

            <div class="stat-box">
                <i class="fa-solid fa-user-tie"></i>
                <h2>100+</h2>
                <p>Expert Teachers</p>
            </div>

            <div class="stat-box">
                <i class="fa-solid fa-layer-group"></i>
                <h2>25+</h2>
                <p>Skill Categories</p>
            </div>

        </div>

    </section>



    <!-- ================= VIDEO SECTION ================= -->

    <section class="video-section" id="learning-video">

        <div class="section-heading">

            <span>LEARNING EXPERIENCE</span>

            <h2>
                Learn. Practice.
                <strong>Grow.</strong>
            </h2>

            <p>
                Experience practical and engaging learning
                designed to help you build real-world skills.
            </p>

        </div>


        <div class="video-container">

            <div class="main-video">

                <video controls poster="images/video-poster.jpg">

                    <source src="videos/learning.mp4"
                            type="video/mp4">

                    Your browser does not support the video tag.

                </video>

            </div>


            <div class="video-info">

                <span class="video-label">
                    <i class="fa-solid fa-play"></i>
                    WATCH & LEARN
                </span>

                <h2>
                    Your Learning Journey
                    Starts Here
                </h2>

                <p>
                    Learn from structured courses, practical
                    examples and experienced teachers.
                </p>


                <div class="video-features">

                    <div>
                        <i class="fa-solid fa-circle-check"></i>
                        Practical Learning
                    </div>

                    <div>
                        <i class="fa-solid fa-circle-check"></i>
                        Expert Guidance
                    </div>

                    <div>
                        <i class="fa-solid fa-circle-check"></i>
                        Career Focused
                    </div>

                </div>


                <a href="courses.jsp" class="primary-btn">
                    Explore Programs
                    <i class="fa-solid fa-arrow-right"></i>
                </a>

            </div>

        </div>

    </section>



    <!-- ================= LEARNING CLASSES ================= -->

    <section class="classes-section">

        <div class="section-heading">

            <span>POPULAR LEARNING CLASSES</span>

            <h2>
                Explore Your
                <strong>Interests</strong>
            </h2>

            <p>
                Choose a subject and start developing
                valuable skills.
            </p>

        </div>


        <div class="classes-grid">


            <!-- Advanced Java -->

            <div class="class-card">

                <div class="class-icon">
                    <i class="fa-brands fa-java"></i>
                </div>

                <h3>Advanced Java</h3>

                <p>
                    JSP, Servlets, JDBC and enterprise
                    application development.
                </p>

                <a href="course-details.jsp">
                    Explore Class
                    <i class="fa-solid fa-arrow-right"></i>
                </a>

            </div>


            <!-- Python -->

            <div class="class-card">

                <div class="class-icon">
                    <i class="fa-brands fa-python"></i>
                </div>

                <h3>Python Programming</h3>

                <p>
                    Learn Python programming from basics
                    to advanced concepts.
                </p>

                <a href="course-details.jsp">
                    Explore Class
                    <i class="fa-solid fa-arrow-right"></i>
                </a>

            </div>


            <!-- Web Development -->

            <div class="class-card">

                <div class="class-icon">
                    <i class="fa-solid fa-code"></i>
                </div>

                <h3>Web Development</h3>

                <p>
                    Build modern websites using HTML,
                    CSS and JavaScript.
                </p>

                <a href="course-details.jsp">
                    Explore Class
                    <i class="fa-solid fa-arrow-right"></i>
                </a>

            </div>


            <!-- AI -->

            <div class="class-card">

                <div class="class-icon">
                    <i class="fa-solid fa-brain"></i>
                </div>

                <h3>Artificial Intelligence</h3>

                <p>
                    Understand AI concepts and
                    intelligent technologies.
                </p>

                <a href="course-details.jsp">
                    Explore Class
                    <i class="fa-solid fa-arrow-right"></i>
                </a>

            </div>


            <!-- Cyber Security -->

            <div class="class-card">

                <div class="class-icon">
                    <i class="fa-solid fa-shield-halved"></i>
                </div>

                <h3>Cyber Security</h3>

                <p>
                    Learn security fundamentals,
                    networking and protection.
                </p>

                <a href="course-details.jsp">
                    Explore Class
                    <i class="fa-solid fa-arrow-right"></i>
                </a>

            </div>


            <!-- Agriculture -->

            <div class="class-card">

                <div class="class-icon">
                    <i class="fa-solid fa-seedling"></i>
                </div>

                <h3>Smart Agriculture</h3>

                <p>
                    Explore technology-driven
                    modern agriculture.
                </p>

                <a href="course-details.jsp">
                    Explore Class
                    <i class="fa-solid fa-arrow-right"></i>
                </a>

            </div>


            <!-- Data Science -->

            <div class="class-card">

                <div class="class-icon">
                    <i class="fa-solid fa-chart-line"></i>
                </div>

                <h3>Data Science</h3>

                <p>
                    Learn data analysis, visualization
                    and data-driven decision making.
                </p>

                <a href="course-details.jsp">
                    Explore Class
                    <i class="fa-solid fa-arrow-right"></i>
                </a>

            </div>


            <!-- Cloud -->

            <div class="class-card">

                <div class="class-icon">
                    <i class="fa-solid fa-cloud"></i>
                </div>

                <h3>Cloud Computing</h3>

                <p>
                    Understand cloud technologies
                    and modern infrastructure.
                </p>

                <a href="course-details.jsp">
                    Explore Class
                    <i class="fa-solid fa-arrow-right"></i>
                </a>

            </div>


            <!-- Database -->

            <div class="class-card">

                <div class="class-icon">
                    <i class="fa-solid fa-database"></i>
                </div>

                <h3>Database Management</h3>

                <p>
                    Learn SQL, MySQL and database
                    management concepts.
                </p>

                <a href="course-details.jsp">
                    Explore Class
                    <i class="fa-solid fa-arrow-right"></i>
                </a>

            </div>


            <!-- Career -->

            <div class="class-card">

                <div class="class-icon">
                    <i class="fa-solid fa-briefcase"></i>
                </div>

                <h3>Career Development</h3>

                <p>
                    Improve your professional skills
                    and prepare for your career.
                </p>

                <a href="course-details.jsp">
                    Explore Class
                    <i class="fa-solid fa-arrow-right"></i>
                </a>

            </div>

        </div>

    </section>



    <!-- ================= PROGRAMS SECTION ================= -->

    <section class="programs-section">

        <div class="section-heading">

            <span>FEATURED PROGRAMS</span>

            <h2>
                Explore Our
                <strong>Learning Programs</strong>
            </h2>

            <p>
                Discover practical courses created to
                develop your technical and professional skills.
            </p>

        </div>


        <div class="program-carousel-wrapper">

            <button class="program-arrow program-prev"
                    id="programPrev">

                <i class="fa-solid fa-chevron-left"></i>

            </button>


            <div class="program-carousel"
                 id="programCarousel">


                <!-- 1 -->

                <div class="program-card">

                    <div class="program-image">

                        <img src="images/course-java.jpg"
                             alt="Advanced Java">

                        <span>TECHNOLOGY</span>

                    </div>

                    <div class="program-content">

                        <h3>Advanced Java Development</h3>

                        <p>
                            JSP, Servlets, JDBC and enterprise
                            application development.
                        </p>

                        <a href="course-details.jsp">
                            View Course
                            <i class="fa-solid fa-arrow-right"></i>
                        </a>

                    </div>

                </div>


                <!-- 2 -->

                <div class="program-card">

                    <div class="program-image">

                        <img src="images/course-python.jpg"
                             alt="Python Programming">

                        <span>PROGRAMMING</span>

                    </div>

                    <div class="program-content">

                        <h3>Python Programming</h3>

                        <p>
                            Build strong Python programming
                            skills through practical learning.
                        </p>

                        <a href="course-details.jsp">
                            View Course
                            <i class="fa-solid fa-arrow-right"></i>
                        </a>

                    </div>

                </div>


                <!-- 3 -->

                <div class="program-card">

                    <div class="program-image">

                        <img src="images/course-web.jpg"
                             alt="Web Development">

                        <span>DEVELOPMENT</span>

                    </div>

                    <div class="program-content">

                        <h3>Modern Web Development</h3>

                        <p>
                            Create responsive and modern
                            websites using web technologies.
                        </p>

                        <a href="course-details.jsp">
                            View Course
                            <i class="fa-solid fa-arrow-right"></i>
                        </a>

                    </div>

                </div>


                <!-- 4 -->

                <div class="program-card">

                    <div class="program-image">

                        <img src="images/course-ai.jpg"
                             alt="Artificial Intelligence">

                        <span>AI</span>

                    </div>

                    <div class="program-content">

                        <h3>Artificial Intelligence</h3>

                        <p>
                            Explore machine intelligence,
                            AI concepts and applications.
                        </p>

                        <a href="course-details.jsp">
                            View Course
                            <i class="fa-solid fa-arrow-right"></i>
                        </a>

                    </div>

                </div>


                <!-- 5 -->

                <div class="program-card">

                    <div class="program-image">

                        <img src="images/course-cyber.jpg"
                             alt="Cyber Security">

                        <span>SECURITY</span>

                    </div>

                    <div class="program-content">

                        <h3>Cyber Security Fundamentals</h3>

                        <p>
                            Learn security fundamentals,
                            threats and protection techniques.
                        </p>

                        <a href="course-details.jsp">
                            View Course
                            <i class="fa-solid fa-arrow-right"></i>
                        </a>

                    </div>

                </div>


                <!-- 6 -->

                <div class="program-card">

                    <div class="program-image">

                        <img src="images/course-data.jpg"
                             alt="Data Science">

                        <span>DATA</span>

                    </div>

                    <div class="program-content">

                        <h3>Data Science Essentials</h3>

                        <p>
                            Learn data analysis and
                            visualization techniques.
                        </p>

                        <a href="course-details.jsp">
                            View Course
                            <i class="fa-solid fa-arrow-right"></i>
                        </a>

                    </div>

                </div>


                <!-- 7 -->

                <div class="program-card">

                    <div class="program-image">

                        <img src="images/course-agriculture.jpg"
                             alt="Smart Agriculture">

                        <span>AGRICULTURE</span>

                    </div>

                    <div class="program-content">

                        <h3>Smart Agriculture</h3>

                        <p>
                            Discover technology-powered
                            modern agriculture.
                        </p>

                        <a href="course-details.jsp">
                            View Course
                            <i class="fa-solid fa-arrow-right"></i>
                        </a>

                    </div>

                </div>


                <!-- 8 -->

                <div class="program-card">

                    <div class="program-image">

                        <img src="images/course-cloud.jpg"
                             alt="Cloud Computing">

                        <span>CLOUD</span>

                    </div>

                    <div class="program-content">

                        <h3>Cloud Computing</h3>

                        <p>
                            Understand cloud platforms,
                            infrastructure and services.
                        </p>

                        <a href="course-details.jsp">
                            View Course
                            <i class="fa-solid fa-arrow-right"></i>
                        </a>

                    </div>

                </div>


                <!-- 9 -->

                <div class="program-card">

                    <div class="program-image">

                        <img src="images/course-database.jpg"
                             alt="Database Management">

                        <span>DATABASE</span>

                    </div>

                    <div class="program-content">

                        <h3>MySQL Database</h3>

                        <p>
                            Learn SQL queries, database design
                            and MySQL.
                        </p>

                        <a href="course-details.jsp">
                            View Course
                            <i class="fa-solid fa-arrow-right"></i>
                        </a>

                    </div>

                </div>


                <!-- 10 -->

                <div class="program-card">

                    <div class="program-image">

                        <img src="images/course-career.jpg"
                             alt="Career Development">

                        <span>CAREER</span>

                    </div>

                    <div class="program-content">

                        <h3>Career Development</h3>

                        <p>
                            Develop communication,
                            interview and career skills.
                        </p>

                        <a href="course-details.jsp">
                            View Course
                            <i class="fa-solid fa-arrow-right"></i>
                        </a>

                    </div>

                </div>


                <!-- 11 -->

                <div class="program-card">

                    <div class="program-image">

                        <img src="images/course-django.jpg"
                             alt="Django Development">

                        <span>PYTHON</span>

                    </div>

                    <div class="program-content">

                        <h3>Django Web Development</h3>

                        <p>
                            Build dynamic web applications
                            using Python and Django.
                        </p>

                        <a href="course-details.jsp">
                            View Course
                            <i class="fa-solid fa-arrow-right"></i>
                        </a>

                    </div>

                </div>


                <!-- 12 -->

                <div class="program-card">

                    <div class="program-image">

                        <img src="images/course-networking.jpg"
                             alt="Computer Networking">

                        <span>NETWORKING</span>

                    </div>

                    <div class="program-content">

                        <h3>Computer Networking</h3>

                        <p>
                            Learn networking fundamentals,
                            protocols and architectures.
                        </p>

                        <a href="course-details.jsp">
                            View Course
                            <i class="fa-solid fa-arrow-right"></i>
                        </a>

                    </div>

                </div>

            </div>


            <button class="program-arrow program-next"
                    id="programNext">

                <i class="fa-solid fa-chevron-right"></i>

            </button>

        </div>

    </section>



    <!-- ================= WHY CAPACITY CONNECT ================= -->

    <section class="why-section">

        <div class="why-container">

            <div class="why-image">

                <img src="images/learning-team.jpg"
                     alt="Learning Team">

                <div class="floating-card">

                    <i class="fa-solid fa-award"></i>

                    <div>

                        <strong>Learn With Confidence</strong>

                        <span>
                            Practical & Career Focused
                        </span>

                    </div>

                </div>

            </div>


            <div class="why-content">

                <span>WHY CAPACITY CONNECT?</span>

                <h2>
                    Learning Designed
                    <strong>For Your Future</strong>
                </h2>

                <p>
                    Capacity Connect brings learners,
                    teachers and practical learning together
                    in one digital platform.
                </p>


                <div class="why-points">

                    <div>

                        <i class="fa-solid fa-circle-check"></i>

                        <div>

                            <h3>Expert Teachers</h3>

                            <p>
                                Learn from experienced
                                teachers and professionals.
                            </p>

                        </div>

                    </div>


                    <div>

                        <i class="fa-solid fa-circle-check"></i>

                        <div>

                            <h3>Practical Learning</h3>

                            <p>
                                Develop skills through
                                projects and real examples.
                            </p>

                        </div>

                    </div>


                    <div>

                        <i class="fa-solid fa-circle-check"></i>

                        <div>

                            <h3>Career Focused</h3>

                            <p>
                                Build knowledge that can
                                support your career goals.
                            </p>

                        </div>

                    </div>

                </div>

            </div>

        </div>

    </section>



    <!-- ================= CTA SECTION ================= -->

    <section class="cta-section">

        <div class="cta-container">

            <div>

                <span>
                    START YOUR JOURNEY
                </span>

                <h2>
                    Ready to Build
                    Your Future?
                </h2>

                <p>
                    Join Capacity Connect and start
                    learning valuable skills today.
                </p>

            </div>


            <div class="cta-buttons">

                <a href="register.jsp" class="primary-btn">

                    Create Free Account

                    <i class="fa-solid fa-arrow-right"></i>

                </a>

                <a href="courses.jsp" class="secondary-btn">

                    Explore Courses

                </a>

            </div>

        </div>

    </section>



    <!-- ================= FOOTER ================= -->

    <jsp:include page="includes/footer.jsp"/>


    <!-- JAVASCRIPT -->

    <script src="js/home.js"></script>
    <script src="js/header.js"></script>

</body>
</html>