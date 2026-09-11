document.addEventListener("DOMContentLoaded", function () {

    // =====================================================
    // LOGIN ROLE SWITCH
    // =====================================================

    const loginRoleButtons =
        document.querySelectorAll("[data-login-role]");

    const loginRole =
        document.getElementById("loginRole");

    const studentFields =
        document.getElementById("studentLoginFields");

    const teacherFields =
        document.getElementById("teacherLoginFields");

    const adminFields =
        document.getElementById("adminLoginFields");


    if (loginRoleButtons.length > 0) {

        loginRoleButtons.forEach(function (button) {

            button.addEventListener("click", function () {

                loginRoleButtons.forEach(function (btn) {

                    btn.classList.remove("active");

                });

                button.classList.add("active");


                const selectedRole =
                    button.getAttribute("data-login-role");


                loginRole.value = selectedRole;


                if (studentFields) {
                    studentFields.style.display =
                        selectedRole === "STUDENT"
                            ? "block"
                            : "none";
                }


                if (teacherFields) {
                    teacherFields.style.display =
                        selectedRole === "TEACHER"
                            ? "block"
                            : "none";
                }


                if (adminFields) {
                    adminFields.style.display =
                        selectedRole === "ADMIN"
                            ? "block"
                            : "none";
                }

            });

        });

    }


    // =====================================================
    // REGISTER ROLE SWITCH
    // =====================================================

    const registerButtons =
        document.querySelectorAll("[data-register-role]");

    const registerRole =
        document.getElementById("registerRole");

    const teacherRegisterFields =
        document.getElementById("teacherRegisterFields");


    if (registerButtons.length > 0) {

        function updateRegisterFields(role) {

            if (registerRole) {

                registerRole.value = role;
            }


            if (teacherRegisterFields) {

                if (role === "TEACHER") {

                    teacherRegisterFields.style.display =
                        "block";

                } else {

                    teacherRegisterFields.style.display =
                        "none";
                }
            }

        }


        registerButtons.forEach(function (button) {

            button.addEventListener("click", function () {

                registerButtons.forEach(function (btn) {

                    btn.classList.remove("active");

                });

                button.classList.add("active");


                const selectedRole =
                    button.getAttribute("data-register-role");


                updateRegisterFields(selectedRole);

            });

        });


        updateRegisterFields("STUDENT");
    }


    // =====================================================
    // PASSWORD SHOW / HIDE
    // =====================================================

    const passwordButtons =
        document.querySelectorAll(".password-toggle");


    passwordButtons.forEach(function (button) {

        button.addEventListener("click", function () {

            const targetId =
                button.getAttribute("data-target");

            const input =
                document.getElementById(targetId);

            const icon =
                button.querySelector("i");


            if (!input) {
                return;
            }


            if (input.type === "password") {

                input.type = "text";

                icon.classList.remove("fa-eye");

                icon.classList.add("fa-eye-slash");

            } else {

                input.type = "password";

                icon.classList.remove("fa-eye-slash");

                icon.classList.add("fa-eye");
            }

        });

    });


    // =====================================================
    // SUCCESS MESSAGE
    // =====================================================

    const params =
        new URLSearchParams(window.location.search);


    if (params.get("registered") === "true") {

        const formHeader =
            document.querySelector(".form-header");


        if (formHeader) {

            const message =
                document.createElement("div");

            message.className =
                "message success-message";

            message.innerHTML =
                '<i class="fa-solid fa-circle-check"></i>' +
                '<span>Account created successfully. Please sign in.</span>';


            formHeader.insertAdjacentElement(
                "afterend",
                message
            );
        }

    }

});