/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */
document.addEventListener("DOMContentLoaded", function () {

    /* =====================================================
       MOBILE MENU
       ===================================================== */

    const mobileMenuBtn =
        document.getElementById("mobileMenuBtn");

    const mainNav =
        document.getElementById("mainNav");


    if (mobileMenuBtn && mainNav) {

        mobileMenuBtn.addEventListener("click", function () {

            mobileMenuBtn.classList.toggle("active");

            mainNav.classList.toggle("mobile-open");

        });


        const navLinks =
            mainNav.querySelectorAll(".nav-link");


        navLinks.forEach(function (link) {

            link.addEventListener("click", function () {

                mobileMenuBtn.classList.remove("active");

                mainNav.classList.remove("mobile-open");

            });

        });

    }


    /* =====================================================
       SEARCH
       ===================================================== */

    const searchBtn =
        document.getElementById("searchBtn");

    const headerSearch =
        document.getElementById("headerSearch");

    const closeSearch =
        document.getElementById("closeSearch");

    const searchInput =
        document.getElementById("headerSearchInput");


    if (searchBtn && headerSearch) {

        searchBtn.addEventListener("click", function () {

            headerSearch.classList.add("show");

            setTimeout(function () {

                if (searchInput) {
                    searchInput.focus();
                }

            }, 200);

        });

    }


    if (closeSearch) {

        closeSearch.addEventListener("click", function () {

            headerSearch.classList.remove("show");

        });

    }


    /* Close search with ESC */

    document.addEventListener("keydown", function (event) {

        if (event.key === "Escape") {

            if (headerSearch) {
                headerSearch.classList.remove("show");
            }

            if (mainNav) {
                mainNav.classList.remove("mobile-open");
            }

            if (mobileMenuBtn) {
                mobileMenuBtn.classList.remove("active");
            }

        }

    });


    /* =====================================================
       HEADER SCROLL EFFECT
       ===================================================== */

    const header =
        document.querySelector(".main-header");


    window.addEventListener("scroll", function () {

        if (!header) return;


        if (window.scrollY > 30) {

            header.style.boxShadow =
                "0 12px 35px rgba(0, 0, 0, 0.32)";

        } else {

            header.style.boxShadow = "none";

        }

    });

});

