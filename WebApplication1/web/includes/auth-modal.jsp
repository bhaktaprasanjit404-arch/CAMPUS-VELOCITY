<!-- =========================================================
     CAPACITY CONNECT AUTH MODAL
========================================================= -->

<div class="cc-auth-modal" id="ccAuthModal">

    <div class="cc-auth-window">

        <!-- CLOSE -->
        <button type="button"
                class="cc-auth-close"
                id="ccAuthClose"
                aria-label="Close">

            <i class="fa-solid fa-xmark"></i>

        </button>


        <!-- =================================================
             LEFT VISUAL
        ================================================== -->

        <div class="cc-auth-visual">

            <div class="cc-auth-visual-inner">

                <div class="cc-auth-logo">

                    <div class="cc-auth-logo-icon">
                        <i class="fa-solid fa-layer-group"></i>
                    </div>

                    <div>
                        <div class="cc-auth-logo-title">
                            CAPACITY CONNECT
                        </div>

                        <div class="cc-auth-logo-subtitle">
                            DIGITAL LEARNING
                        </div>
                    </div>

                </div>


                <div class="cc-auth-visual-content">

                    <div class="cc-auth-eyebrow">

                        <i class="fa-solid fa-circle"></i>

                        DIGITAL CAPACITY BUILDING

                    </div>


                    <h1>
                        Learn.<br>
                        Grow.<br>
                        <span>Connect.</span>
                    </h1>


                    <p>
                        Build meaningful skills, share knowledge
                        and unlock new opportunities with
                        Capacity Connect.
                    </p>

                </div>


                <div class="cc-auth-visual-bottom">

                    <span>SECURE ACCESS</span>

                    <span>LEARN ? DEVELOP ? GROW</span>

                </div>

            </div>

        </div>


        <!-- =================================================
             RIGHT CONTENT
        ================================================== -->

        <div class="cc-auth-content">


            <!-- =================================================
                 LOGIN
            ================================================== -->

            <div id="ccLoginView">

                <div class="cc-auth-heading">

                    <span class="cc-auth-small">
                        WELCOME BACK
                    </span>

                    <h2>
                        Sign in.
                    </h2>

                    <p>
                        Choose your account type to continue.
                    </p>

                </div>


                <!-- ROLE -->

                <div class="cc-auth-role-tabs">

                    <label class="role-tab active">

                        <input type="radio"
                               name="modalLoginRole"
                               value="USER"
                               checked
                               hidden>

                        <i class="fa-solid fa-user-graduate"></i>

                        <span>User</span>

                    </label>


                    <label class="role-tab">

                        <input type="radio"
                               name="modalLoginRole"
                               value="TEACHER"
                               hidden>

                        <i class="fa-solid fa-chalkboard-user"></i>

                        <span>Teacher</span>

                    </label>


                    <label class="role-tab">

                        <input type="radio"
                               name="modalLoginRole"
                               value="ADMIN"
                               hidden>

                        <i class="fa-solid fa-user-shield"></i>

                        <span>Admin</span>

                    </label>

                </div>


                <!-- USER LOGIN -->

                <form action="LoginServlet"
                      method="post"
                      id="modalStudentForm"
                      class="cc-auth-form active">

                    <input type="hidden"
                           name="role"
                           value="USER">


                    <div class="cc-field">

                        <label>
                            USER NAME
                        </label>

                        <div class="cc-field-box">

                            <i class="fa-solid fa-user"></i>

                            <input type="text"
                                   name="userName"
                                   placeholder="Enter your full name"
                                   autocomplete="name"
                                   required>

                        </div>

                    </div>


                    <div class="cc-field">

                        <label>
                            EMAIL ADDRESS
                        </label>

                        <div class="cc-field-box">

                            <i class="fa-solid fa-envelope"></i>

                            <input type="email"
                                   name="userEmail"
                                   placeholder="Enter your email address"
                                   autocomplete="email"
                                   required>

                        </div>

                    </div>


                    <button type="submit"
                            class="cc-auth-submit">

                        <span>
                            Continue as User
                        </span>

                        <i class="fa-solid fa-arrow-right"></i>

                    </button>

                </form>


                <!-- TEACHER LOGIN -->

                <form action="LoginServlet"
                      method="post"
                      id="modalTeacherForm"
                      class="cc-auth-form">

                    <input type="hidden"
                           name="role"
                           value="TEACHER">


                    <div class="cc-field">

                        <label>
                            TEACHER NAME
                        </label>

                        <div class="cc-field-box">

                            <i class="fa-solid fa-chalkboard-user"></i>

                            <input type="text"
                                   name="teacherName"
                                   placeholder="Enter teacher name"
                                   autocomplete="name"
                                   required>

                        </div>

                    </div>


                    <div class="cc-field">

                        <label>
                            PHONE NUMBER
                        </label>

                        <div class="cc-field-box">

                            <i class="fa-solid fa-phone"></i>

                            <input type="tel"
                                   id="modalTeacherPhone"
                                   name="teacherPhone"
                                   placeholder="Enter phone number"
                                   maxlength="10"
                                   inputmode="numeric"
                                   autocomplete="tel"
                                   required>

                        </div>

                    </div>


                    <button type="submit"
                            class="cc-auth-submit">

                        <span>
                            Continue as Teacher
                        </span>

                        <i class="fa-solid fa-arrow-right"></i>

                    </button>

                </form>


                <!-- ADMIN LOGIN -->

                <form action="LoginServlet"
                      method="post"
                      id="modalAdminForm"
                      class="cc-auth-form">

                    <input type="hidden"
                           name="role"
                           value="ADMIN">


                    <div class="cc-admin-warning">

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


                    <div class="cc-field">

                        <label>
                            ADMIN USERNAME
                        </label>

                        <div class="cc-field-box">

                            <i class="fa-solid fa-user-shield"></i>

                            <input type="text"
                                   name="adminUsername"
                                   placeholder="Enter admin username"
                                   autocomplete="username"
                                   required>

                        </div>

                    </div>


                    <div class="cc-field">

                        <label>
                            ADMIN PASSWORD
                        </label>

                        <div class="cc-field-box">

                            <i class="fa-solid fa-lock"></i>

                            <input type="password"
                                   id="modalAdminPassword"
                                   name="adminPassword"
                                   placeholder="Enter admin password"
                                   autocomplete="current-password"
                                   required>


                            <button type="button"
                                    class="cc-password-toggle"
                                    data-target="modalAdminPassword">

                                <i class="fa-regular fa-eye"></i>

                            </button>

                        </div>

                    </div>


                    <button type="submit"
                            class="cc-auth-submit">

                        <span>
                            Enter Admin Portal
                        </span>

                        <i class="fa-solid fa-arrow-right"></i>

                    </button>

                </form>


                <div class="cc-auth-bottom">

                    <span>
                        Don't have an account?
                    </span>

                    <a href="#"
                       id="ccOpenRegister">

                        Create Account

                    </a>

                </div>


                <div class="cc-auth-security">

                    <i class="fa-solid fa-lock"></i>

                    Secure access ? Capacity Connect

                </div>

            </div>


            <!-- =================================================
                 REGISTER
            ================================================== -->

            <div id="ccRegisterView"
                 style="display:none;">

                <div class="cc-auth-heading">

                    <span class="cc-auth-small">
                        GET STARTED
                    </span>

                    <h2>
                        Create account.
                    </h2>

                    <p>
                        Choose how you want to join Capacity Connect.
                    </p>

                </div>


                <!-- REGISTER ROLE -->

                <div class="cc-register-role">

                    <button type="button"
                            id="ccStudentRole"
                            class="active">

                        <i class="fa-solid fa-user-graduate"></i>

                        User

                    </button>


                    <button type="button"
                            id="ccTeacherRole">

                        <i class="fa-solid fa-chalkboard-user"></i>

                        Teacher

                    </button>

                </div>


                <!-- USER REGISTER -->

                <form action="RegisterServlet"
                      method="post"
                      id="ccRegisterStudentForm"
                      class="cc-register-form active">

                    <input type="hidden"
                           name="role"
                           value="STUDENT">


                    <div class="cc-field">

                        <label>
                            FULL NAME
                        </label>

                        <div class="cc-field-box">

                            <i class="fa-regular fa-user"></i>

                            <input type="text"
                                   name="name"
                                   placeholder="Enter your full name"
                                   required>

                        </div>

                    </div>


                    <div class="cc-field">

                        <label>
                            EMAIL ADDRESS
                        </label>

                        <div class="cc-field-box">

                            <i class="fa-regular fa-envelope"></i>

                            <input type="email"
                                   name="email"
                                   placeholder="Enter your email"
                                   required>

                        </div>

                    </div>


                    <div class="cc-field">

                        <label>
                            PASSWORD
                        </label>

                        <div class="cc-field-box">

                            <i class="fa-solid fa-lock"></i>

                            <input type="password"
                                   id="modalStudentPassword"
                                   name="password"
                                   placeholder="Create a password"
                                   required>


                            <button type="button"
                                    class="cc-password-toggle"
                                    data-target="modalStudentPassword">

                                <i class="fa-regular fa-eye"></i>

                            </button>

                        </div>

                    </div>


                    <button type="submit"
                            class="cc-auth-submit">

                        <span>
                            Create User Account
                        </span>

                        <i class="fa-solid fa-arrow-right"></i>

                    </button>

                </form>


                <!-- TEACHER REGISTER -->

                <form action="RegisterServlet"
                      method="post"
                      id="ccRegisterTeacherForm"
                      class="cc-register-form">

                    <input type="hidden"
                           name="role"
                           value="TEACHER">


                    <div class="cc-two-column">

                        <div class="cc-field">

                            <label>
                                FULL NAME
                            </label>

                            <div class="cc-field-box">

                                <i class="fa-regular fa-user"></i>

                                <input type="text"
                                       name="name"
                                       placeholder="Teacher name"
                                       required>

                            </div>

                        </div>


                        <div class="cc-field">

                            <label>
                                PHONE NUMBER
                            </label>

                            <div class="cc-field-box">

                                <i class="fa-solid fa-phone"></i>

                                <input type="tel"
                                       id="modalRegisterTeacherPhone"
                                       name="phone"
                                       placeholder="Phone number"
                                       maxlength="10"
                                       required>

                            </div>

                        </div>

                    </div>


                    <div class="cc-field">

                        <label>
                            EMAIL ADDRESS
                        </label>

                        <div class="cc-field-box">

                            <i class="fa-regular fa-envelope"></i>

                            <input type="email"
                                   name="email"
                                   placeholder="Teacher email"
                                   required>

                        </div>

                    </div>


                    <div class="cc-two-column">

                        <div class="cc-field">

                            <label>
                                QUALIFICATION
                            </label>

                            <div class="cc-field-box">

                                <i class="fa-solid fa-graduation-cap"></i>

                                <input type="text"
                                       name="qualification"
                                       placeholder="e.g. M.Tech"
                                       required>

                            </div>

                        </div>


                        <div class="cc-field">

                            <label>
                                SPECIALIZATION
                            </label>

                            <div class="cc-field-box">

                                <i class="fa-solid fa-code"></i>

                                <input type="text"
                                       name="specialization"
                                       placeholder="e.g. Java, AI"
                                       required>

                            </div>

                        </div>

                    </div>


                    <div class="cc-field">

                        <label>
                            SHORT BIO
                        </label>

                        <div class="cc-field-box">

                            <i class="fa-regular fa-message"></i>

                            <textarea name="bio"
                                      rows="3"
                                      placeholder="Tell learners about your experience..."></textarea>

                        </div>

                    </div>


                    <div class="cc-field">

                        <label>
                            PASSWORD
                        </label>

                        <div class="cc-field-box">

                            <i class="fa-solid fa-lock"></i>

                            <input type="password"
                                   id="modalTeacherPassword"
                                   name="password"
                                   placeholder="Create a password"
                                   required>


                            <button type="button"
                                    class="cc-password-toggle"
                                    data-target="modalTeacherPassword">

                                <i class="fa-regular fa-eye"></i>

                            </button>

                        </div>

                    </div>


                    <button type="submit"
                            class="cc-auth-submit">

                        <span>
                            Create Teacher Account
                        </span>

                        <i class="fa-solid fa-arrow-right"></i>

                    </button>

                </form>


                <div class="cc-auth-bottom">

                    <span>
                        Already have an account?
                    </span>

                    <a href="#"
                       id="ccOpenLogin">

                        Sign in

                    </a>

                </div>


                <div class="cc-auth-security">

                    <i class="fa-solid fa-lock"></i>

                    Secure registration ? Capacity Connect

                </div>

            </div>

        </div>

    </div>

</div>