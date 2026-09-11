<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Login | Capacity Connect</title>

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

    <link rel="stylesheet"
          href="css/auth.css">

</head>

<body>

<div class="auth-page">

    <div class="background-shape shape-one"></div>
    <div class="background-shape shape-two"></div>
    <div class="background-shape shape-three"></div>

    <div class="auth-container">

        <!-- LEFT SIDE -->

        <div class="auth-showcase">

            <div class="brand">

                <div class="brand-icon">
                    <i class="fa-solid fa-layer-group"></i>
                </div>

                <div>
                    <h2>CAPACITY</h2>
                    <span>CONNECT</span>
                </div>

            </div>

            <div class="showcase-content">

                <span class="mini-label">
                    <i class="fa-solid fa-bolt"></i>
                    WELCOME BACK
                </span>

                <h1>
                    Learn.
                    <span>Grow.</span>
                    Connect.
                </h1>

                <p>
                    Sign in to continue your learning journey
                    with Capacity Connect.
                </p>

                <div class="login-highlights">

                    <div>
                        <i class="fa-solid fa-circle-check"></i>
                        Smart learning experience
                    </div>

                    <div>
                        <i class="fa-solid fa-circle-check"></i>
                        Expert-led courses
                    </div>

                    <div>
                        <i class="fa-solid fa-circle-check"></i>
                        Track your progress
                    </div>

                </div>

            </div>

        </div>


        <!-- RIGHT SIDE -->

        <div class="auth-form-area">

            <div class="form-header">

                <span class="welcome">
                    SIGN IN
                </span>

                <h2>Welcome back</h2>

                <p>
                    Choose your account type to continue.
                </p>

            </div>


            <!-- ERROR -->

            <% if (request.getAttribute("error") != null) { %>

                <div class="message error-message">

                    <i class="fa-solid fa-circle-exclamation"></i>

                    <span>
                        <%= request.getAttribute("error") %>
                    </span>

                </div>

            <% } %>


            <!-- ROLE SELECTOR -->

            <div class="role-selector login-role-selector">

                <button type="button"
                        class="role-card active"
                        data-login-role="STUDENT">

                    <i class="fa-solid fa-user-graduate"></i>

                    <span>Student</span>

                </button>


                <button type="button"
                        class="role-card"
                        data-login-role="TEACHER">

                    <i class="fa-solid fa-chalkboard-user"></i>

                    <span>Teacher</span>

                </button>


                <button type="button"
                        class="role-card"
                        data-login-role="ADMIN">

                    <i class="fa-solid fa-shield-halved"></i>

                    <span>Admin</span>

                </button>

            </div>


            <form action="${pageContext.request.contextPath}/LoginServlet"
                  method="post"
                  id="loginForm">


                <input type="hidden"
                       name="role"
                       id="loginRole"
                       value="STUDENT">


                <!-- STUDENT LOGIN -->

                <div id="studentLoginFields"
                     class="login-fields">

                    <div class="input-group">

                        <label>Student ID</label>

                        <div class="input-box">

                            <i class="fa-solid fa-id-card"></i>

                            <input type="number"
                                   name="studentId"
                                   id="studentId"
                                   placeholder="Enter student ID">

                        </div>

                    </div>


                    <div class="input-group">

                        <label>Student Name</label>

                        <div class="input-box">

                            <i class="fa-solid fa-user"></i>

                            <input type="text"
                                   name="studentName"
                                   id="studentName"
                                   placeholder="Enter your name">

                        </div>

                    </div>


                    <div class="input-group">

                        <label>Password</label>

                        <div class="input-box">

                            <i class="fa-solid fa-lock"></i>

                            <input type="password"
                                   name="studentPassword"
                                   id="studentPassword"
                                   placeholder="Enter password">

                            <button type="button"
                                    class="password-toggle"
                                    data-target="studentPassword">

                                <i class="fa-solid fa-eye"></i>

                            </button>

                        </div>

                    </div>

                </div>


                <!-- TEACHER LOGIN -->

                <div id="teacherLoginFields"
                     class="login-fields"
                     style="display:none;">

                    <div class="input-group">

                        <label>Teacher ID</label>

                        <div class="input-box">

                            <i class="fa-solid fa-id-badge"></i>

                            <input type="number"
                                   name="teacherId"
                                   id="teacherId"
                                   placeholder="Enter teacher ID">

                        </div>

                    </div>


                    <div class="input-group">

                        <label>User ID</label>

                        <div class="input-box">

                            <i class="fa-solid fa-user-tag"></i>

                            <input type="number"
                                   name="userId"
                                   id="userId"
                                   placeholder="Enter user ID">

                        </div>

                    </div>


                    <div class="input-group">

                        <label>Password</label>

                        <div class="input-box">

                            <i class="fa-solid fa-lock"></i>

                            <input type="password"
                                   name="teacherPassword"
                                   id="teacherPassword"
                                   placeholder="Enter password">

                            <button type="button"
                                    class="password-toggle"
                                    data-target="teacherPassword">

                                <i class="fa-solid fa-eye"></i>

                            </button>

                        </div>

                    </div>

                </div>


                <!-- ADMIN LOGIN -->

                <div id="adminLoginFields"
                     class="login-fields"
                     style="display:none;">

                    <div class="admin-login-badge">

                        <i class="fa-solid fa-shield-halved"></i>

                        <div>
                            <strong>Administrator Access</strong>
                            <span>Authorized personnel only</span>
                        </div>

                    </div>


                    <div class="input-group">

                        <label>Username</label>

                        <div class="input-box">

                            <i class="fa-solid fa-user-shield"></i>

                            <input type="text"
                                   name="adminUsername"
                                   id="adminUsername"
                                   placeholder="Enter admin username">

                        </div>

                    </div>


                    <div class="input-group">

                        <label>Password</label>

                        <div class="input-box">

                            <i class="fa-solid fa-key"></i>

                            <input type="password"
                                   name="adminPassword"
                                   id="adminPassword"
                                   placeholder="Enter admin password">

                            <button type="button"
                                    class="password-toggle"
                                    data-target="adminPassword">

                                <i class="fa-solid fa-eye"></i>

                            </button>

                        </div>

                    </div>

                </div>


                <button type="submit"
                        class="login-button">

                    <span>Sign In</span>

                    <i class="fa-solid fa-arrow-right"></i>

                </button>

            </form>


            <div class="form-footer">

                <p>
                    Don't have an account?

                    <a href="${pageContext.request.contextPath}/register.jsp">
                        Create account
                    </a>
                </p>

            </div>

        </div>

    </div>

</div>


<script src="js/auth.js"></script>

</body>

</html>