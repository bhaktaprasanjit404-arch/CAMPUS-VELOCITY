<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>
<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Settings | Capacity Connect</title>

    <!-- Font Awesome -->
    <link rel="stylesheet"
          href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.2/css/all.min.css">

    <!-- Settings CSS -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/settings.css">

</head>


<body>

<div class="settings-page">


    <!-- =========================
         TOP HEADER
    ========================== -->

    <div class="settings-top">

        <div class="settings-title">

            <div class="title-icon">

                <i class="fa-solid fa-sliders"></i>

            </div>

            <div>

                <span class="small-title">
                    ADMIN PANEL
                </span>

                <h1>Settings</h1>

                <p>
                    Manage your account and platform preferences.
                </p>

            </div>

        </div>


        <a href="${pageContext.request.contextPath}/admin/dashboard.jsp"
           class="back-dashboard">

            <i class="fa-solid fa-arrow-left"></i>

            Back to Dashboard

        </a>

    </div>



    <!-- =========================
         SETTINGS CONTENT
    ========================== -->

    <div class="settings-container">


        <!-- =========================
             ADMIN PROFILE
        ========================== -->

        <section class="settings-card profile-card">

            <div class="card-header">

                <div class="card-icon blue">

                    <i class="fa-solid fa-user-shield"></i>

                </div>

                <div>

                    <h2>Admin Profile</h2>

                    <p>
                        Your administrator account information.
                    </p>

                </div>

            </div>


            <div class="profile-content">


                <div class="profile-avatar">

                    <i class="fa-solid fa-user-tie"></i>

                </div>


                <div class="profile-info">

                    <span class="profile-label">
                        ADMINISTRATOR
                    </span>

                    <h3>Administrator</h3>

                    <div class="profile-status">

                        <span class="status-dot"></span>

                        Active Administrator

                    </div>

                </div>


                <div class="username-box">

                    <span>
                        Username
                    </span>

                    <strong>
                        admin
                    </strong>

                </div>

            </div>

        </section>



        <!-- =========================
             CHANGE PASSWORD
        ========================== -->

        <section class="settings-card">

            <div class="card-header">

                <div class="card-icon purple">

                    <i class="fa-solid fa-lock"></i>

                </div>

                <div>

                    <h2>Change Password</h2>

                    <p>
                        Update your administrator password.
                    </p>

                </div>

            </div>


            <form action="${pageContext.request.contextPath}/AdminServlet"
                  method="post"
                  class="settings-form">

                <input type="hidden"
                       name="action"
                       value="change-password">


                <div class="form-row">


                    <div class="input-group">

                        <label>
                            Current Password
                        </label>

                        <div class="input-box">

                            <i class="fa-solid fa-key"></i>

                            <input type="password"
                                   name="currentPassword"
                                   id="currentPassword"
                                   placeholder="Enter current password"
                                   required>

                            <button type="button"
                                    class="password-toggle"
                                    onclick="togglePassword('currentPassword', this)">

                                <i class="fa-solid fa-eye"></i>

                            </button>

                        </div>

                    </div>


                    <div class="input-group">

                        <label>
                            New Password
                        </label>

                        <div class="input-box">

                            <i class="fa-solid fa-shield-halved"></i>

                            <input type="password"
                                   name="newPassword"
                                   id="newPassword"
                                   placeholder="Enter new password"
                                   required>

                            <button type="button"
                                    class="password-toggle"
                                    onclick="togglePassword('newPassword', this)">

                                <i class="fa-solid fa-eye"></i>

                            </button>

                        </div>

                    </div>


                </div>


                <div class="input-group">

                    <label>
                        Confirm New Password
                    </label>

                    <div class="input-box">

                        <i class="fa-solid fa-check-double"></i>

                        <input type="password"
                               name="confirmPassword"
                               id="confirmPassword"
                               placeholder="Confirm new password"
                               required>

                        <button type="button"
                                class="password-toggle"
                                onclick="togglePassword('confirmPassword', this)">

                            <i class="fa-solid fa-eye"></i>

                        </button>

                    </div>

                </div>


                <div class="password-note">

                    <i class="fa-solid fa-circle-info"></i>

                    <span>
                        Use a strong password containing letters,
                        numbers and special characters.
                    </span>

                </div>


                <button type="submit"
                        class="primary-button">

                    <i class="fa-solid fa-key"></i>

                    Update Password

                </button>

            </form>

        </section>



        <!-- =========================
             PLATFORM SETTINGS
        ========================== -->

        <section class="settings-card">

            <div class="card-header">

                <div class="card-icon orange">

                    <i class="fa-solid fa-gear"></i>

                </div>

                <div>

                    <h2>Platform Settings</h2>

                    <p>
                        Configure basic Capacity Connect preferences.
                    </p>

                </div>

            </div>


            <form action="${pageContext.request.contextPath}/AdminServlet"
                  method="post"
                  class="platform-form">

                <input type="hidden"
                       name="action"
                       value="platform-settings">


                <!-- Notifications -->

                <div class="setting-option">

                    <div class="option-icon">

                        <i class="fa-solid fa-bell"></i>

                    </div>

                    <div class="option-content">

                        <h3>Email Notifications</h3>

                        <p>
                            Receive notifications about new registrations
                            and platform activity.
                        </p>

                    </div>

                    <label class="switch">

                        <input type="checkbox"
                               name="emailNotifications"
                               checked>

                        <span class="slider"></span>

                    </label>

                </div>


                <!-- Registration -->

                <div class="setting-option">

                    <div class="option-icon">

                        <i class="fa-solid fa-user-plus"></i>

                    </div>

                    <div class="option-content">

                        <h3>Student Registration</h3>

                        <p>
                            Allow new students to create accounts.
                        </p>

                    </div>

                    <label class="switch">

                        <input type="checkbox"
                               name="studentRegistration"
                               checked>

                        <span class="slider"></span>

                    </label>

                </div>


                <!-- Teacher Registration -->

                <div class="setting-option">

                    <div class="option-icon">

                        <i class="fa-solid fa-chalkboard-user"></i>

                    </div>

                    <div class="option-content">

                        <h3>Teacher Registration</h3>

                        <p>
                            Allow teachers to register on the platform.
                        </p>

                    </div>

                    <label class="switch">

                        <input type="checkbox"
                               name="teacherRegistration"
                               checked>

                        <span class="slider"></span>

                    </label>

                </div>


                <!-- Platform Status -->

                <div class="setting-option">

                    <div class="option-icon green">

                        <i class="fa-solid fa-circle-check"></i>

                    </div>

                    <div class="option-content">

                        <h3>Platform Status</h3>

                        <p>
                            Keep Capacity Connect available to users.
                        </p>

                    </div>

                    <label class="switch">

                        <input type="checkbox"
                               name="platformActive"
                               checked>

                        <span class="slider"></span>

                    </label>

                </div>


                <button type="submit"
                        class="primary-button settings-save">

                    <i class="fa-solid fa-floppy-disk"></i>

                    Save Platform Settings

                </button>

            </form>

        </section>



        <!-- =========================
             LOGOUT
        ========================== -->

        <section class="logout-card">

            <div class="logout-icon">

                <i class="fa-solid fa-right-from-bracket"></i>

            </div>


            <div class="logout-content">

                <h2>Sign out of Admin Panel</h2>

                <p>
                    You will be securely logged out of your
                    administrator session.
                </p>

            </div>


            <a href="${pageContext.request.contextPath}/LogoutServlet"
               class="logout-button"
               onclick="return confirm('Are you sure you want to logout?');">

                <i class="fa-solid fa-power-off"></i>

                Logout

            </a>

        </section>


    </div>

</div>



<!-- =========================
     JAVASCRIPT
========================== -->

<script>

function togglePassword(id, button) {

    const input = document.getElementById(id);

    const icon = button.querySelector("i");

    if (input.type === "password") {

        input.type = "text";

        icon.classList.remove("fa-eye");

        icon.classList.add("fa-eye-slash");

    } else {

        input.type = "password";

        icon.classList.remove("fa-eye-slash");

        icon.classList.add("fa-eye");

    }

}

</script>


</body>

</html>