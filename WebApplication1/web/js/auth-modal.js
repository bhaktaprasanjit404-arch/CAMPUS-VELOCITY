/* =========================================================
   CAPACITY CONNECT
   AUTH MODAL - LOGIN / REGISTER
========================================================= */

document.addEventListener("DOMContentLoaded", function () {

    const modal = document.getElementById("ccAuthModal");
    const closeBtn = document.getElementById("ccAuthClose");

    const loginView = document.getElementById("ccLoginView");
    const registerView = document.getElementById("ccRegisterView");

    const openRegister = document.getElementById("ccOpenRegister");
    const openLogin = document.getElementById("ccOpenLogin");

    if (!modal) {
        return;
    }


    /* =====================================================
       OPEN MODAL
    ===================================================== */

    function openAuthModal(type) {

        modal.classList.add("active");
        document.body.classList.add("cc-modal-open");

        if (type === "register") {
            showRegister();
        } else {
            showLogin();
        }
    }


    /* =====================================================
       CLOSE MODAL
    ===================================================== */

    function closeAuthModal() {

        modal.classList.remove("active");
        document.body.classList.remove("cc-modal-open");

    }


    /* =====================================================
       SHOW LOGIN
    ===================================================== */

    function showLogin() {

        loginView.style.display = "block";
        registerView.style.display = "none";

        resetRegisterForms();

    }


    /* =====================================================
       SHOW REGISTER
    ===================================================== */

    function showRegister() {

        loginView.style.display = "none";
        registerView.style.display = "block";

        resetLoginForms();

    }


    /* =====================================================
       RESET LOGIN FORMS
    ===================================================== */

    function resetLoginForms() {

        const studentForm =
            document.getElementById("modalStudentForm");

        const teacherForm =
            document.getElementById("modalTeacherForm");

        const adminForm =
            document.getElementById("modalAdminForm");

        if (studentForm) {
            studentForm.reset();
            studentForm.classList.add("active");
        }

        if (teacherForm) {
            teacherForm.reset();
            teacherForm.classList.remove("active");
        }

        if (adminForm) {
            adminForm.reset();
            adminForm.classList.remove("active");
        }

        const tabs =
            document.querySelectorAll(
                ".cc-auth-role-tabs .role-tab"
            );

        tabs.forEach(function (tab, index) {

            if (index === 0) {
                tab.classList.add("active");
            } else {
                tab.classList.remove("active");
            }

        });

    }


    /* =====================================================
       RESET REGISTER FORMS
    ===================================================== */

    function resetRegisterForms() {

        const studentForm =
            document.getElementById("ccRegisterStudentForm");

        const teacherForm =
            document.getElementById("ccRegisterTeacherForm");

        if (studentForm) {
            studentForm.reset();
            studentForm.classList.add("active");
        }

        if (teacherForm) {
            teacherForm.reset();
            teacherForm.classList.remove("active");
        }

        const studentRole =
            document.getElementById("ccStudentRole");

        const teacherRole =
            document.getElementById("ccTeacherRole");

        if (studentRole) {
            studentRole.classList.add("active");
        }

        if (teacherRole) {
            teacherRole.classList.remove("active");
        }

    }


    /* =====================================================
       HEADER LOGIN / REGISTER BUTTONS
    ===================================================== */

    document.addEventListener("click", function (event) {

        const authButton =
            event.target.closest("[data-auth-open]");

        if (!authButton) {
            return;
        }

        event.preventDefault();

        const type =
            authButton.getAttribute("data-auth-open");

        openAuthModal(type);

    });


    /* =====================================================
       CLOSE BUTTON
    ===================================================== */

    if (closeBtn) {

        closeBtn.addEventListener("click", function () {

            closeAuthModal();

        });

    }


    /* =====================================================
       CLICK OUTSIDE MODAL
    ===================================================== */

    modal.addEventListener("click", function (event) {

        if (event.target === modal) {

            closeAuthModal();

        }

    });


    /* =====================================================
       ESC KEY
    ===================================================== */

    document.addEventListener("keydown", function (event) {

        if (event.key === "Escape") {

            if (modal.classList.contains("active")) {

                closeAuthModal();

            }

        }

    });


    /* =====================================================
       LOGIN → REGISTER
    ===================================================== */

    if (openRegister) {

        openRegister.addEventListener("click", function (event) {

            event.preventDefault();

            showRegister();

        });

    }


    /* =====================================================
       REGISTER → LOGIN
    ===================================================== */

    if (openLogin) {

        openLogin.addEventListener("click", function (event) {

            event.preventDefault();

            showLogin();

        });

    }


    /* =====================================================
       LOGIN ROLE SWITCH
    ===================================================== */

    const loginRoleTabs =
        document.querySelectorAll(
            ".cc-auth-role-tabs .role-tab"
        );

    loginRoleTabs.forEach(function (tab) {

        tab.addEventListener("click", function () {

            loginRoleTabs.forEach(function (item) {

                item.classList.remove("active");

            });

            tab.classList.add("active");

            const radio =
                tab.querySelector("input[type='radio']");

            if (radio) {
                radio.checked = true;
            }

            const role = radio
                ? radio.value
                : "USER";


            const studentForm =
                document.getElementById("modalStudentForm");

            const teacherForm =
                document.getElementById("modalTeacherForm");

            const adminForm =
                document.getElementById("modalAdminForm");


            if (studentForm) {
                studentForm.classList.remove("active");
            }

            if (teacherForm) {
                teacherForm.classList.remove("active");
            }

            if (adminForm) {
                adminForm.classList.remove("active");
            }


            if (role === "USER") {

                if (studentForm) {
                    studentForm.classList.add("active");
                }

            }


            if (role === "TEACHER") {

                if (teacherForm) {
                    teacherForm.classList.add("active");
                }

            }


            if (role === "ADMIN") {

                if (adminForm) {
                    adminForm.classList.add("active");
                }

            }

        });

    });


    /* =====================================================
       REGISTER ROLE SWITCH
    ===================================================== */

    const studentRole =
        document.getElementById("ccStudentRole");

    const teacherRole =
        document.getElementById("ccTeacherRole");

    const studentRegisterForm =
        document.getElementById("ccRegisterStudentForm");

    const teacherRegisterForm =
        document.getElementById("ccRegisterTeacherForm");


    if (studentRole) {

        studentRole.addEventListener("click", function () {

            studentRole.classList.add("active");

            if (teacherRole) {
                teacherRole.classList.remove("active");
            }

            if (studentRegisterForm) {
                studentRegisterForm.classList.add("active");
            }

            if (teacherRegisterForm) {
                teacherRegisterForm.classList.remove("active");
            }

        });

    }


    if (teacherRole) {

        teacherRole.addEventListener("click", function () {

            teacherRole.classList.add("active");

            if (studentRole) {
                studentRole.classList.remove("active");
            }

            if (teacherRegisterForm) {
                teacherRegisterForm.classList.add("active");
            }

            if (studentRegisterForm) {
                studentRegisterForm.classList.remove("active");
            }

        });

    }


    /* =====================================================
       PASSWORD SHOW / HIDE
    ===================================================== */

    document.addEventListener("click", function (event) {

        const button =
            event.target.closest(".cc-password-toggle");

        if (!button) {
            return;
        }

        event.preventDefault();

        const targetId =
            button.getAttribute("data-target");

        const input =
            document.getElementById(targetId);

        if (!input) {
            return;
        }

        const icon =
            button.querySelector("i");


        if (input.type === "password") {

            input.type = "text";

            if (icon) {

                icon.classList.remove(
                    "fa-eye"
                );

                icon.classList.add(
                    "fa-eye-slash"
                );

            }

        } else {

            input.type = "password";

            if (icon) {

                icon.classList.remove(
                    "fa-eye-slash"
                );

                icon.classList.add(
                    "fa-eye"
                );

            }

        }

    });


    /* =====================================================
       PHONE NUMBER VALIDATION
    ===================================================== */

    const phoneInputs =
        document.querySelectorAll(
            "#modalTeacherPhone, #modalRegisterTeacherPhone"
        );


    phoneInputs.forEach(function (input) {

        input.addEventListener("input", function () {

            this.value =
                this.value.replace(/\D/g, "");

            if (this.value.length > 10) {

                this.value =
                    this.value.substring(0, 10);

            }

        });

    });


    /* =====================================================
       FORM SUBMIT LOADING EFFECT
    ===================================================== */

    const authForms =
        document.querySelectorAll(
            ".cc-auth-form, .cc-register-form"
        );


    authForms.forEach(function (form) {

        form.addEventListener("submit", function () {

            const button =
                form.querySelector(".cc-auth-submit");

            if (!button) {
                return;
            }

            const span =
                button.querySelector("span");

            if (span) {

                span.dataset.originalText =
                    span.textContent;

                span.textContent =
                    "Please wait...";

            }

            button.classList.add("loading");

            button.disabled = true;

        });

    });


    /* =====================================================
       AUTO OPEN MODAL FROM URL
       
       Example:
       login.jsp?auth=login
       login.jsp?auth=register
    ===================================================== */

    const urlParams =
        new URLSearchParams(window.location.search);

    const authParam =
        urlParams.get("auth");


    if (authParam === "login") {

        openAuthModal("login");

    }

    if (authParam === "register") {

        openAuthModal("register");

    }


});