<%-- 
    Document   : login
    Created on : 9 Sept 2026, 5:26:37 pm
    Author     : User
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Login | Capacity Connect</title>

    <!-- Google Font -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&family=Manrope:wght@500;600;700;800&display=swap"
          rel="stylesheet">

    <!-- Font Awesome -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

    <!-- Login CSS -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/login.css">

</head>

<body>

<div class="login-page">

    <!-- Animated Background -->
    <div class="background-shape shape-one"></div>
    <div class="background-shape shape-two"></div>
    <div class="background-shape shape-three"></div>

    <div class="login-wrapper">

        <!-- LEFT SIDE -->
        <div class="login-showcase">

            <div class="showcase-overlay"></div>

            <div class="showcase-content">

                <!-- Logo -->
                <a href="${pageContext.request.contextPath}/index.jsp"
                   class="brand">

                    <div class="brand-icon">
                        <i class="fa-solid fa-layer-group"></i>
                    </div>

                    <div class="brand-text">
                        <span class="brand-name">
                            CAPACITY
                        </span>

                        <span class="brand-subtitle">
                            CONNECT
                        </span>
                    </div>

                </a>

                <!-- Main Content -->
                <div class="showcase-main">

                    <span class="eyebrow">
                        <span class="eyebrow-dot"></span>
                        DIGITAL LEARNING PLATFORM
                    </span>

                    <h1>
                        Learn.
                        <span>Grow.</span>
                        Lead.
                    </h1>

                    <p>
                        Empowering learners, educators and organizations
                        through smarter digital capacity building.
                    </p>

                    <!-- Mini Features -->
                    <div class="showcase-features">

                        <div class="showcase-feature">

                            <div class="feature-icon">
                                <i class="fa-solid fa-graduation-cap"></i>
                            </div>

                            <div>
                                <strong>Learn Smarter</strong>
                                <span>Structured learning experiences</span>
                            </div>

                        </div>


                        <div class="showcase-feature">

                            <div class="feature-icon">
                                <i class="fa-solid fa-chart-line"></i>
                            </div>

                            <div>
                                <strong>Track Progress</strong>
                                <span>Monitor your learning journey</span>
                            </div>

                        </div>


                        <div class="showcase-feature">

                            <div class="feature-icon">
                                <i class="fa-solid fa-certificate"></i>
                            </div>

                            <div>
                                <strong>Build Skills</strong>
                                <span>Develop skills for the future</span>
                            </div>

                        </div>

                    </div>

                </div>


                <!-- Bottom -->
                <div class="showcase-footer">

                    <div class="trusted-users">

                        <div class="avatar avatar-one">A</div>
                        <div class="avatar avatar-two">R</div>
                        <div class="avatar avatar-three">S</div>
                        <div class="avatar avatar-four">M</div>

                    </div>

                    <div class="trusted-text">

                        <div class="stars">
                            ★★★★★
                        </div>

                        <span>
                            Built for modern learning
                        </span>

                    </div>

                </div>

            </div>

        </div>


        <!-- RIGHT SIDE -->
        <div class="login-panel">

            <div class="login-card">

                <!-- Mobile Logo -->
                <div class="mobile-brand">

                    <div class="brand-icon">
                        <i class="fa-solid fa-layer-group"></i>
                    </div>

                    <div class="brand-text">
                        <span class="brand-name">
                            CAPACITY
                        </span>

                        <span class="brand-subtitle">
                            CONNECT
                        </span>
                    </div>

                </div>


                <!-- Heading -->
                <div class="login-heading">

                    <span class="welcome-label">
                        WELCOME BACK
                    </span>

                    <h2>
                        Sign in to your account
                    </h2>

                    <p>
                        Continue your learning journey with Capacity Connect.
                    </p>

                </div>


                <!-- Error Message -->
                <%
                    String error = (String) request.getAttribute("error");

                    if (error != null) {
                %>

                    <div class="message error-message">

                        <i class="fa-solid fa-circle-exclamation"></i>

                        <span>
                            <%= error %>
                        </span>

                    </div>

                <%
                    }
                %>


                <!-- Success Message -->
                <%
                    String registered = request.getParameter("registered");

                    if ("true".equals(registered)) {
                %>

                    <div class="message success-message">

                        <i class="fa-solid fa-circle-check"></i>

                        <span>
                            Registration successful. Please login.
                        </span>

                    </div>

                <%
                    }
                %>


                <!-- Login Form -->
                <form action="${pageContext.request.contextPath}/LoginServlet"
                      method="post"
                      id="loginForm">


                    <!-- Role Selection -->
                    <div class="role-section">

                        <label class="form-label">
                            Sign in as
                        </label>

                        <div class="role-selector">

                            <button type="button"
                                    class="role-option active"
                                    data-role="STUDENT">

                                <i class="fa-solid fa-user-graduate"></i>

                                <span>Student</span>

                            </button>


                            <button type="button"
                                    class="role-option"
                                    data-role="TEACHER">

                                <i class="fa-solid fa-chalkboard-user"></i>

                                <span>Teacher</span>

                            </button>


                            <button type="button"
                                    class="role-option admin-role"
                                    data-role="ADMIN">

                                <i class="fa-solid fa-shield-halved"></i>

                                <span>Admin</span>

                            </button>

                        </div>

                    </div>


                    <!-- Hidden Role -->
                    <input type="hidden"
                           name="role"
                           id="role"
                           value="STUDENT">


                    <!-- Email / Username -->
                    <div class="input-group">

                        <label for="loginIdentifier"
                               class="form-label"
                               id="identifierLabel">

                            Email Address

                        </label>

                        <div class="input-wrapper">

                            <i class="fa-regular fa-envelope input-icon"
                               id="identifierIcon"></i>

                            <input type="email"
                                   name="email"
                                   id="loginIdentifier"
                                   placeholder="Enter your email address"
                                   autocomplete="username"
                                   required>

                        </div>

                    </div>


                    <!-- Password -->
                    <div class="input-group">

                        <div class="password-label-row">

                            <label for="password"
                                   class="form-label">

                                Password

                            </label>

                        </div>


                        <div class="input-wrapper">

                            <i class="fa-solid fa-lock input-icon"></i>

                            <input type="password"
                                   name="password"
                                   id="password"
                                   placeholder="Enter your password"
                                   autocomplete="current-password"
                                   required>

                            <button type="button"
                                    class="password-toggle"
                                    id="passwordToggle"
                                    aria-label="Show password">

                                <i class="fa-regular fa-eye"></i>

                            </button>

                        </div>

                    </div>


                    <!-- Remember + Forgot -->
                    <div class="form-options">

                        <label class="remember-me">

                            <input type="checkbox"
                                   id="remember">

                            <span class="custom-checkbox"></span>

                            <span>
                                Remember me
                            </span>

                        </label>

                        <a href="#"
                           class="forgot-link">

                            Forgot password?

                        </a>

                    </div>


                    <!-- Login Button -->
                    <button type="submit"
                            class="login-button"
                            id="loginButton">

                        <span class="button-text">
                            Sign In
                        </span>

                        <i class="fa-solid fa-arrow-right"></i>

                    </button>

                </form>


                <!-- Registration -->
                <div class="register-area"
                     id="registerArea">

                    <span>
                        Don't have an account?
                    </span>

                    <a href="${pageContext.request.contextPath}/register.jsp">
                        Create an account
                    </a>

                </div>


                <!-- Security -->
                <div class="security-note">

                    <i class="fa-solid fa-shield-halved"></i>

                    <span>
                        Your account and learning data are securely protected.
                    </span>

                </div>

            </div>

        </div>

    </div>

</div>


<script src="${pageContext.request.contextPath}/js/login.js"></script>

</body>
</html>