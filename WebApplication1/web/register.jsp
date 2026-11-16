<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Create Account | Capacity Connect</title>

    <link rel="stylesheet" href="css/auth.css">

    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"
          rel="stylesheet">

    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">
</head>

<body>

<div class="auth-page">

    <!-- LEFT SIDE -->
    <div class="auth-visual">

        <div class="visual-overlay"></div>

        <div class="visual-content">

            <div class="brand-small">
                <span class="brand-dot"></span>
                CAPACITY CONNECT
            </div>

            <h1>
                Build your
                <span>next level.</span>
            </h1>

            <p>
                Learn skills. Share knowledge.
                Build your future with Capacity Connect.
            </p>

            <div class="visual-bottom">
                <span>● DIGITAL CAPACITY BUILDING</span>
            </div>

        </div>

    </div>


    <!-- RIGHT SIDE -->
    <div class="auth-panel">

        <div class="auth-box">

            <div class="auth-top">

                <span class="eyebrow">
                    GET STARTED
                </span>

                <h2>Create account.</h2>

                <p>
                    Choose how you want to join Capacity Connect.
                </p>

            </div>


            <!-- ROLE SELECTOR -->
            <div class="role-selector">

                <button type="button"
                        class="role-btn active"
                        data-role="STUDENT"
                        id="studentRoleBtn">

                    <i class="fa-solid fa-user-graduate"></i>

                    <span>User</span>

                </button>


                <button type="button"
                        class="role-btn"
                        data-role="TEACHER"
                        id="teacherRoleBtn">

                    <i class="fa-solid fa-chalkboard-user"></i>

                    <span>Teacher</span>

                </button>

            </div>


            <!-- ================= USER FORM ================= -->

            <form action="RegisterServlet"
                  method="post"
                  id="studentForm"
                  class="register-form active-form">

                <input type="hidden"
                       name="role"
                       value="STUDENT">


                <div class="form-heading">

                    <div>
                        <h3>Create your learner account</h3>
                        <p>Join courses, resources and learning programs.</p>
                    </div>

                </div>


                <div class="input-group">

                    <label for="studentName">
                        Full Name
                    </label>

                    <div class="input-wrapper">

                        <i class="fa-regular fa-user"></i>

                        <input type="text"
                               id="studentName"
                               name="name"
                               placeholder="Enter your full name"
                               required>

                    </div>

                </div>


                <div class="input-group">

                    <label for="studentEmail">
                        Email Address
                    </label>

                    <div class="input-wrapper">

                        <i class="fa-regular fa-envelope"></i>

                        <input type="email"
                               id="studentEmail"
                               name="email"
                               placeholder="Enter your email"
                               required>

                    </div>

                </div>


                <div class="input-group">

                    <label for="studentPassword">
                        Password
                    </label>

                    <div class="input-wrapper">

                        <i class="fa-solid fa-lock"></i>

                        <input type="password"
                               id="studentPassword"
                               name="password"
                               placeholder="Create a password"
                               required>

                        <button type="button"
                                class="password-toggle"
                                data-target="studentPassword">

                            <i class="fa-regular fa-eye"></i>

                        </button>

                    </div>

                </div>


                <button type="submit" class="create-btn">

                    <span>Create User Account</span>

                    <i class="fa-solid fa-arrow-right"></i>

                </button>

            </form>


            <!-- ================= TEACHER FORM ================= -->

            <form action="RegisterServlet"
                  method="post"
                  id="teacherForm"
                  class="register-form">

                <input type="hidden"
                       name="role"
                       value="TEACHER">


                <div class="form-heading">

                    <div>
                        <h3>Create your teacher account</h3>
                        <p>Share your expertise with learners.</p>
                    </div>

                </div>


                <div class="two-column">

                    <div class="input-group">

                        <label for="teacherName">
                            Full Name
                        </label>

                        <div class="input-wrapper">

                            <i class="fa-regular fa-user"></i>

                            <input type="text"
                                   id="teacherName"
                                   name="name"
                                   placeholder="Teacher name"
                                   required>

                        </div>

                    </div>


                    <div class="input-group">

                        <label for="teacherPhone">
                            Phone Number
                        </label>

                        <div class="input-wrapper">

                            <i class="fa-solid fa-phone"></i>

                            <input type="tel"
                                   id="teacherPhone"
                                   name="phone"
                                   placeholder="Phone number"
                                   required>

                        </div>

                    </div>

                </div>


                <div class="input-group">

                    <label for="teacherEmail">
                        Email Address
                    </label>

                    <div class="input-wrapper">

                        <i class="fa-regular fa-envelope"></i>

                        <input type="email"
                               id="teacherEmail"
                               name="email"
                               placeholder="Teacher email"
                               required>

                    </div>

                </div>


                <div class="two-column">

                    <div class="input-group">

                        <label for="qualification">
                            Qualification
                        </label>

                        <div class="input-wrapper">

                            <i class="fa-solid fa-graduation-cap"></i>

                            <input type="text"
                                   id="qualification"
                                   name="qualification"
                                   placeholder="e.g. M.Tech"
                                   required>

                        </div>

                    </div>


                    <div class="input-group">

                        <label for="specialization">
                            Specialization
                        </label>

                        <div class="input-wrapper">

                            <i class="fa-solid fa-code"></i>

                            <input type="text"
                                   id="specialization"
                                   name="specialization"
                                   placeholder="e.g. Java, AI"
                                   required>

                        </div>

                    </div>

                </div>


                <div class="input-group">

                    <label for="teacherBio">
                        Short Bio
                    </label>

                    <div class="input-wrapper textarea-wrapper">

                        <i class="fa-regular fa-message"></i>

                        <textarea id="teacherBio"
                                  name="bio"
                                  placeholder="Tell learners about your experience..."
                                  rows="3"></textarea>

                    </div>

                </div>


                <div class="input-group">

                    <label for="teacherPassword">
                        Password
                    </label>

                    <div class="input-wrapper">

                        <i class="fa-solid fa-lock"></i>

                        <input type="password"
                               id="teacherPassword"
                               name="password"
                               placeholder="Create a password"
                               required>

                        <button type="button"
                                class="password-toggle"
                                data-target="teacherPassword">

                            <i class="fa-regular fa-eye"></i>

                        </button>

                    </div>

                </div>


                <button type="submit" class="create-btn">

                    <span>Create Teacher Account</span>

                    <i class="fa-solid fa-arrow-right"></i>

                </button>

            </form>


            <!-- ERROR MESSAGE -->

            <% if (request.getAttribute("error") != null) { %>

                <div class="error-message">

                    <i class="fa-solid fa-circle-exclamation"></i>

                    <span>
                        <%= request.getAttribute("error") %>
                    </span>

                </div>

            <% } %>


            <!-- LOGIN -->

            <div class="login-link">

                Already have an account?

                <a href="login.jsp">
                    Sign in
                </a>

            </div>

        </div>

    </div>

</div>


<script>
document.addEventListener("DOMContentLoaded", function () {

    const studentRoleBtn = document.getElementById("studentRoleBtn");
    const teacherRoleBtn = document.getElementById("teacherRoleBtn");

    const studentForm = document.getElementById("studentForm");
    const teacherForm = document.getElementById("teacherForm");


    /* ==============================
       STUDENT / USER BUTTON
    ============================== */

    studentRoleBtn.addEventListener("click", function () {

        // Button active state
        studentRoleBtn.classList.add("active");
        teacherRoleBtn.classList.remove("active");

        // Form switching
        studentForm.classList.add("active-form");
        teacherForm.classList.remove("active-form");

    });


    /* ==============================
       TEACHER BUTTON
    ============================== */

    teacherRoleBtn.addEventListener("click", function () {

        // Button active state
        teacherRoleBtn.classList.add("active");
        studentRoleBtn.classList.remove("active");

        // Form switching
        teacherForm.classList.add("active-form");
        studentForm.classList.remove("active-form");

    });


    /* ==============================
       PASSWORD SHOW / HIDE
    ============================== */

    const passwordButtons = document.querySelectorAll(".password-toggle");

    passwordButtons.forEach(function (button) {

        button.addEventListener("click", function () {

            const targetId = button.getAttribute("data-target");
            const passwordInput = document.getElementById(targetId);

            if (!passwordInput) {
                return;
            }

            const icon = button.querySelector("i");

            if (passwordInput.type === "password") {

                passwordInput.type = "text";

                if (icon) {
                    icon.classList.remove("fa-eye");
                    icon.classList.add("fa-eye-slash");
                }

            } else {

                passwordInput.type = "password";

                if (icon) {
                    icon.classList.remove("fa-eye-slash");
                    icon.classList.add("fa-eye");
                }

            }

        });

    });


    /* ==============================
       TEACHER PHONE VALIDATION
    ============================== */

    const teacherPhone = document.getElementById("teacherPhone");

    if (teacherPhone) {

        teacherPhone.addEventListener("input", function () {

            // Only numbers
            this.value = this.value.replace(/\D/g, "");

            // Maximum 10 digits
            if (this.value.length > 10) {
                this.value = this.value.substring(0, 10);
            }

        });

    }

});
</script>

</body>
</html>