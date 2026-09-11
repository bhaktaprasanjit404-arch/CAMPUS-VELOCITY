<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Create Account | Capacity Connect</title>

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

    <link rel="stylesheet"
          href="css/auth.css">

</head>

<body>

<div class="auth-page register-page">

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

                    <i class="fa-solid fa-rocket"></i>

                    START YOUR JOURNEY

                </span>


                <h1>

                    Build your
                    <span>future.</span>

                </h1>


                <p>

                    Join Capacity Connect and unlock
                    a smarter digital learning experience.

                </p>


                <div class="register-benefits">

                    <div>

                        <i class="fa-solid fa-circle-check"></i>

                        Access learning resources

                    </div>


                    <div>

                        <i class="fa-solid fa-circle-check"></i>

                        Learn from expert teachers

                    </div>


                    <div>

                        <i class="fa-solid fa-circle-check"></i>

                        Track your progress

                    </div>


                    <div>

                        <i class="fa-solid fa-circle-check"></i>

                        Earn certificates

                    </div>

                </div>

            </div>

        </div>


        <!-- FORM -->

        <div class="auth-form-area register-form-area">

            <div class="form-header">

                <span class="welcome">
                    GET STARTED
                </span>

                <h2>Create your account</h2>

                <p>
                    Choose your account type and fill in your details.
                </p>

            </div>


            <% if (request.getAttribute("error") != null) { %>

                <div class="message error-message">

                    <i class="fa-solid fa-circle-exclamation"></i>

                    <span>
                        <%= request.getAttribute("error") %>
                    </span>

                </div>

            <% } %>


            <!-- ACCOUNT TYPE -->

            <div class="role-selector">

                <button type="button"
                        class="role-card active"
                        data-register-role="STUDENT">

                    <i class="fa-solid fa-user-graduate"></i>

                    <span>Student</span>

                </button>


                <button type="button"
                        class="role-card"
                        data-register-role="TEACHER">

                    <i class="fa-solid fa-chalkboard-user"></i>

                    <span>Teacher</span>

                </button>

            </div>


            <form action="${pageContext.request.contextPath}/RegisterServlet"
                  method="post"
                  id="registerForm">


                <input type="hidden"
                       name="role"
                       id="registerRole"
                       value="STUDENT">


                <!-- COMMON USERS TABLE DATA -->

                <div class="input-group">

                    <label>Full Name</label>

                    <div class="input-box">

                        <i class="fa-solid fa-user"></i>

                        <input type="text"
                               name="name"
                               placeholder="Enter your full name"
                               required>

                    </div>

                </div>


                <div class="input-group">

                    <label>Email Address</label>

                    <div class="input-box">

                        <i class="fa-solid fa-envelope"></i>

                        <input type="email"
                               name="email"
                               placeholder="Enter your email"
                               required>

                    </div>

                </div>


                <div class="input-group">

                    <label>Password</label>

                    <div class="input-box">

                        <i class="fa-solid fa-lock"></i>

                        <input type="password"
                               name="password"
                               id="registerPassword"
                               placeholder="Create a password"
                               required>

                        <button type="button"
                                class="password-toggle"
                                data-target="registerPassword">

                            <i class="fa-solid fa-eye"></i>

                        </button>

                    </div>

                </div>


                <!-- TEACHER TABLE DATA -->

                <div id="teacherRegisterFields"
                     class="teacher-register-fields">


                    <div class="input-group">

                        <label>Qualification</label>

                        <div class="input-box">

                            <i class="fa-solid fa-graduation-cap"></i>

                            <input type="text"
                                   name="qualification"
                                   placeholder="e.g. MCA, M.Tech">

                        </div>

                    </div>


                    <div class="input-group">

                        <label>Specialization</label>

                        <div class="input-box">

                            <i class="fa-solid fa-code"></i>

                            <input type="text"
                                   name="specialization"
                                   placeholder="e.g. Java, AI, Web Development">

                        </div>

                    </div>


                    <div class="input-group">

                        <label>Phone</label>

                        <div class="input-box">

                            <i class="fa-solid fa-phone"></i>

                            <input type="text"
                                   name="phone"
                                   placeholder="Enter phone number">

                        </div>

                    </div>


                    <div class="input-group">

                        <label>Bio</label>

                        <div class="input-box textarea-box">

                            <i class="fa-solid fa-align-left"></i>

                            <textarea name="bio"
                                      placeholder="Tell students about yourself"></textarea>

                        </div>

                    </div>

                </div>


                <div class="terms">

                    <input type="checkbox"
                           id="terms"
                           required>

                    <label for="terms">
                        I agree to the platform terms and conditions.
                    </label>

                </div>


                <button type="submit"
                        class="login-button">

                    <span>Create Account</span>

                    <i class="fa-solid fa-arrow-right"></i>

                </button>

            </form>


            <div class="form-footer">

                <p>

                    Already have an account?

                    <a href="${pageContext.request.contextPath}/login.jsp">
                        Sign in
                    </a>

                </p>

            </div>

        </div>

    </div>

</div>


<script src="js/auth.js"></script>

</body>

</html>