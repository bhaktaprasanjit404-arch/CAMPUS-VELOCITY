<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Login | Capacity Connect</title>


    <!-- GOOGLE FONT -->

    <link rel="preconnect"
          href="https://fonts.googleapis.com">

    <link rel="preconnect"
          href="https://fonts.gstatic.com"
          crossorigin>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap"
          rel="stylesheet">


    <!-- FONT AWESOME -->

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">


    <!-- CAPACITY CONNECT LOGIN CSS -->

    <link rel="stylesheet"
          href="css/auth.css">

</head>


<body>


<!-- =========================================================
     MAIN LOGIN SCREEN
     ========================================================= -->

<div class="auth-screen">


    <!-- =====================================================
         BACKGROUND
         ===================================================== -->

    <div class="auth-background"></div>

    <div class="background-overlay"></div>

    <div class="background-grid"></div>



    <!-- =====================================================
         LEFT BRAND / HERO
         ===================================================== -->

    <div class="auth-brand">


        <!-- BRAND TOP -->

        <div class="brand-top">

            <div class="brand-mark">

                <i class="fa-solid fa-layer-group"></i>

            </div>


            <div>

                <div class="brand-name">
                    CAPACITY CONNECT
                </div>

                <div class="brand-subname">
                    DIGITAL LEARNING
                </div>

            </div>

        </div>



        <!-- BRAND CONTENT -->

        <div class="brand-content">


            <div class="brand-tag">

                <span>
                    <i class="fa-solid fa-circle"></i>
                </span>

                DIGITAL CAPACITY BUILDING PLATFORM

            </div>


            <h1>

                Learn.
                <br>

                Grow.

                <br>

                <span>Connect.</span>

            </h1>


            <p>

                Build meaningful skills, share knowledge,
                and unlock new opportunities through
                Capacity Connect.

            </p>


        </div>



        <!-- BRAND BOTTOM -->

        <div class="brand-bottom">

            <span>
                © Capacity Connect
            </span>

            <span>
                Learn • Develop • Grow
            </span>

        </div>


    </div>



    <!-- =====================================================
         RIGHT LOGIN PANEL
         ===================================================== -->

    <div class="auth-panel">


        <div class="auth-panel-inner">


            <!-- MOBILE BRAND -->

            <div class="mobile-brand">

                <span>CAPACITY</span> CONNECT

            </div>



            <!-- =================================================
                 LOGIN HEADING
                 ================================================= -->

            <div class="auth-heading">


                <span class="small-heading">
                    WELCOME BACK
                </span>


                <h2>

                    Sign in.

                </h2>


                <p>

                    Choose your account type to continue.

                </p>


            </div>



            <!-- =================================================
                 ERROR MESSAGE
                 ================================================= -->

            <%

                String error =
                        (String) request.getAttribute("error");

                if (error != null) {

            %>

                <div class="auth-error">

                    <i class="fa-solid fa-circle-exclamation"></i>

                    <span>
                        <%= error %>
                    </span>

                </div>

            <%

                }

            %>



            <!-- =================================================
                 ROLE SELECTOR
                 ================================================= -->

            <div class="auth-role-tabs">


                <!-- USER -->

                <label class="role-tab active">

                    <input type="radio"
                           name="loginRole"
                           value="USER"
                           checked
                           hidden>

                    <i class="fa-solid fa-user-graduate"></i>

                    <span>
                        User
                    </span>

                </label>



                <!-- TEACHER -->

                <label class="role-tab">

                    <input type="radio"
                           name="loginRole"
                           value="TEACHER"
                           hidden>

                    <i class="fa-solid fa-chalkboard-user"></i>

                    <span>
                        Teacher
                    </span>

                </label>



                <!-- ADMIN -->

                <label class="role-tab">

                    <input type="radio"
                           name="loginRole"
                           value="ADMIN"
                           hidden>

                    <i class="fa-solid fa-user-shield"></i>

                    <span>
                        Admin
                    </span>

                </label>


            </div>



            <!-- =================================================
                 USER LOGIN FORM
                 ================================================= -->

            <form action="LoginServlet"
                  method="post"
                  id="studentForm"
                  class="role-form active">


                <!-- IMPORTANT:
                     LoginServlet expects role = USER -->

                <input type="hidden"
                       name="role"
                       value="USER">


                <div class="field">

                    <label>
                        USER NAME
                    </label>


                    <div class="field-box">

                        <i class="fa-solid fa-user"></i>

                        <input type="text"
                               name="userName"
                               placeholder="Enter your full name"
                               autocomplete="name"
                               required>

                    </div>

                </div>



                <div class="field">

                    <label>
                        EMAIL ADDRESS
                    </label>


                    <div class="field-box">

                        <i class="fa-solid fa-envelope"></i>

                        <input type="email"
                               name="userEmail"
                               placeholder="Enter your email address"
                               autocomplete="email"
                               required>

                    </div>

                </div>



                <button type="submit"
                        class="auth-submit">

                    <span>
                        Continue as User
                    </span>

                    <i class="fa-solid fa-arrow-right"></i>

                </button>


            </form>



            <!-- =================================================
                 TEACHER LOGIN FORM
                 ================================================= -->

            <form action="LoginServlet"
                  method="post"
                  id="teacherForm"
                  class="role-form">


                <input type="hidden"
                       name="role"
                       value="TEACHER">


                <div class="field">

                    <label>
                        TEACHER NAME
                    </label>


                    <div class="field-box">

                        <i class="fa-solid fa-chalkboard-user"></i>

                        <input type="text"
                               name="teacherName"
                               placeholder="Enter teacher name"
                               autocomplete="name"
                               required>

                    </div>

                </div>



                <div class="field">

                    <label>
                        PHONE NUMBER
                    </label>


                    <div class="field-box">

                        <i class="fa-solid fa-phone"></i>

                        <input type="tel"
                               id="teacherPhone"
                               name="teacherPhone"
                               placeholder="Enter phone number"
                               maxlength="10"
                               inputmode="numeric"
                               autocomplete="tel"
                               required>

                    </div>

                </div>



                <button type="submit"
                        class="auth-submit teacher-submit">

                    <span>
                        Continue as Teacher
                    </span>

                    <i class="fa-solid fa-arrow-right"></i>

                </button>


            </form>



            <!-- =================================================
                 ADMIN LOGIN FORM
                 ================================================= -->

            <form action="LoginServlet"
                  method="post"
                  id="adminForm"
                  class="role-form">


                <input type="hidden"
                       name="role"
                       value="ADMIN">


                <!-- ADMIN WARNING -->

                <div class="admin-warning">

                    <i class="fa-solid fa-shield-halved"></i>

                    <div>

                        <strong>
                            Administrator Access
                        </strong>

                        <span>
                            Authorized administrator access only.
                        </span>

                    </div>

                </div>



                <!-- ADMIN USERNAME -->

                <div class="field">

                    <label>
                        ADMIN USERNAME
                    </label>


                    <div class="field-box">

                        <i class="fa-solid fa-user-shield"></i>

                        <input type="text"
                               name="adminUsername"
                               placeholder="Enter admin username"
                               autocomplete="username"
                               required>

                    </div>

                </div>



                <!-- ADMIN PASSWORD -->

                <div class="field">

                    <label>
                        ADMIN PASSWORD
                    </label>


                    <div class="field-box">

                        <i class="fa-solid fa-lock"></i>

                        <input type="password"
                               id="adminPassword"
                               name="adminPassword"
                               placeholder="Enter admin password"
                               autocomplete="current-password"
                               required>


                        <button type="button"
                                class="password-toggle"
                                data-target="adminPassword"
                                aria-label="Show password">

                            <i class="fa-regular fa-eye"></i>

                        </button>

                    </div>

                </div>



                <button type="submit"
                        class="auth-submit admin-submit">

                    <span>
                        Enter Admin Portal
                    </span>

                    <i class="fa-solid fa-arrow-right"></i>

                </button>


            </form>



            <!-- =================================================
                 REGISTER LINK
                 ================================================= -->

            <div class="auth-switch">

                <span>
                    Don't have an account?
                </span>

                <a href="register.jsp">
                    Create Account
                </a>

            </div>



            <!-- =================================================
                 SECURITY
                 ================================================= -->

            <div class="security-text">

                <i class="fa-solid fa-lock"></i>

                <span>
                    Secure access • Capacity Connect
                </span>

            </div>


        </div>

    </div>


</div>



<!-- =========================================================
     LOGIN JAVASCRIPT
     ========================================================= -->

<script>

document.addEventListener("DOMContentLoaded", function () {


    const roleTabs =
        document.querySelectorAll(".role-tab");


    const userForm =
        document.getElementById("studentForm");


    const teacherForm =
        document.getElementById("teacherForm");


    const adminForm =
        document.getElementById("adminForm");


    function showForm(role) {


        /* Remove active tab */

        roleTabs.forEach(function(tab) {

            tab.classList.remove("active");

        });


        /* Hide all forms */

        userForm.classList.remove("active");

        teacherForm.classList.remove("active");

        adminForm.classList.remove("active");


        /* Show selected form */

        if (role === "USER") {

            userForm.classList.add("active");

        }


        else if (role === "TEACHER") {

            teacherForm.classList.add("active");

        }


        else if (role === "ADMIN") {

            adminForm.classList.add("active");

        }


        /* Activate selected tab */

        roleTabs.forEach(function(tab) {

            const radio =
                tab.querySelector("input");

            if (radio &&
                radio.value === role) {

                tab.classList.add("active");

                radio.checked = true;

            }

        });

    }


    /* ROLE CLICK */

    roleTabs.forEach(function(tab) {

        tab.addEventListener("click", function() {

            const radio =
                tab.querySelector("input");

            if (radio) {

                showForm(radio.value);

            }

        });

    });



    /* =====================================================
       PASSWORD SHOW / HIDE
       ===================================================== */

    const passwordButtons =
        document.querySelectorAll(".password-toggle");


    passwordButtons.forEach(function(button) {

        button.addEventListener("click", function() {


            const targetId =
                button.getAttribute("data-target");


            const passwordInput =
                document.getElementById(targetId);


            if (!passwordInput) {
                return;
            }


            const icon =
                button.querySelector("i");


            if (passwordInput.type === "password") {

                passwordInput.type = "text";


                if (icon) {

                    icon.classList.remove("fa-eye");

                    icon.classList.add("fa-eye-slash");

                }

                button.setAttribute(
                    "aria-label",
                    "Hide password"
                );

            }

            else {

                passwordInput.type = "password";


                if (icon) {

                    icon.classList.remove("fa-eye-slash");

                    icon.classList.add("fa-eye");

                }

                button.setAttribute(
                    "aria-label",
                    "Show password"
                );

            }

        });

    });



    /* =====================================================
       TEACHER PHONE VALIDATION
       ===================================================== */

    const teacherPhone =
        document.getElementById("teacherPhone");


    if (teacherPhone) {

        teacherPhone.addEventListener(
            "input",
            function() {

                this.value =
                    this.value.replace(/\D/g, "");


                if (this.value.length > 10) {

                    this.value =
                        this.value.substring(0, 10);

                }

            }
        );

    }


});


</script>


</body>

</html>