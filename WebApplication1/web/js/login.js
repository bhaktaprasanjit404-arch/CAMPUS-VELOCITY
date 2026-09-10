/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */
/* =========================================
   CAPACITY CONNECT LOGIN JAVASCRIPT
========================================= */

document.addEventListener("DOMContentLoaded", function () {

    const roleButtons =
        document.querySelectorAll(".role-option");

    const roleInput =
        document.getElementById("role");

    const identifierInput =
        document.getElementById("loginIdentifier");

    const identifierLabel =
        document.getElementById("identifierLabel");

    const identifierIcon =
        document.getElementById("identifierIcon");

    const passwordInput =
        document.getElementById("password");

    const passwordToggle =
        document.getElementById("passwordToggle");

    const loginForm =
        document.getElementById("loginForm");

    const loginButton =
        document.getElementById("loginButton");

    const loginCard =
        document.querySelector(".login-card");

    const registerArea =
        document.getElementById("registerArea");


    /* =========================================
       ROLE SELECTION
    ========================================= */

    roleButtons.forEach(function (button) {

        button.addEventListener("click", function () {

            const selectedRole =
                this.getAttribute("data-role");

            /* Remove active */
            roleButtons.forEach(function (item) {
                item.classList.remove("active");
            });

            /* Add active */
            this.classList.add("active");

            /* Update hidden role */
            roleInput.value = selectedRole;


            /* =================================
               ADMIN
            ================================= */

            if (selectedRole === "ADMIN") {

                identifierLabel.textContent =
                    "Admin Username";

                identifierInput.type =
                    "text";

                identifierInput.name =
                    "username";

                identifierInput.placeholder =
                    "Enter admin username";

                identifierInput.value = "";

                identifierIcon.className =
                    "fa-solid fa-user-shield input-icon";

                loginCard.classList.add(
                    "admin-mode"
                );

                registerArea.style.display =
                    "none";

            }


            /* =================================
               TEACHER
            ================================= */

            else if (selectedRole === "TEACHER") {

                identifierLabel.textContent =
                    "Email Address";

                identifierInput.type =
                    "email";

                identifierInput.name =
                    "email";

                identifierInput.placeholder =
                    "Enter your email address";

                identifierInput.value = "";

                identifierIcon.className =
                    "fa-regular fa-envelope input-icon";

                loginCard.classList.remove(
                    "admin-mode"
                );

                registerArea.style.display =
                    "block";

            }


            /* =================================
               STUDENT
            ================================= */

            else {

                identifierLabel.textContent =
                    "Email Address";

                identifierInput.type =
                    "email";

                identifierInput.name =
                    "email";

                identifierInput.placeholder =
                    "Enter your email address";

                identifierInput.value = "";

                identifierIcon.className =
                    "fa-regular fa-envelope input-icon";

                loginCard.classList.remove(
                    "admin-mode"
                );

                registerArea.style.display =
                    "block";

            }

            /* Focus input */

            setTimeout(function () {

                identifierInput.focus();

            }, 100);

        });

    });


    /* =========================================
       PASSWORD SHOW / HIDE
    ========================================= */

    passwordToggle.addEventListener(
        "click",
        function () {

            const icon =
                this.querySelector("i");

            if (passwordInput.type === "password") {

                passwordInput.type =
                    "text";

                icon.className =
                    "fa-regular fa-eye-slash";

                this.setAttribute(
                    "aria-label",
                    "Hide password"
                );

            } else {

                passwordInput.type =
                    "password";

                icon.className =
                    "fa-regular fa-eye";

                this.setAttribute(
                    "aria-label",
                    "Show password"
                );
            }

        }
    );


    /* =========================================
       FORM SUBMIT
    ========================================= */

    loginForm.addEventListener(
        "submit",
        function () {

            loginButton.classList.add(
                "loading"
            );

        }
    );


    /* =========================================
       INPUT ANIMATION
    ========================================= */

    const inputs =
        document.querySelectorAll(
            ".input-wrapper input"
        );

    inputs.forEach(function (input) {

        input.addEventListener(
            "focus",
            function () {

                this.parentElement.classList.add(
                    "focused"
                );

            }
        );

        input.addEventListener(
            "blur",
            function () {

                this.parentElement.classList.remove(
                    "focused"
                );

            }
        );

    });


});

