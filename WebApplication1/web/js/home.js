/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/ClientSide/javascript.js to edit this template
 */
document.addEventListener("DOMContentLoaded", function () {

    /* ==========================
       MOBILE MENU
    ========================== */

    const mobileMenuBtn = document.getElementById("mobileMenuBtn");
    const mainNav = document.getElementById("mainNav");

    if (mobileMenuBtn && mainNav) {

        mobileMenuBtn.addEventListener("click", function () {
            mainNav.classList.toggle("mobile-open");

            const icon = mobileMenuBtn.querySelector("i");

            if (mainNav.classList.contains("mobile-open")) {
                icon.classList.remove("fa-bars");
                icon.classList.add("fa-times");
            } else {
                icon.classList.remove("fa-times");
                icon.classList.add("fa-bars");
            }
        });
    }


    /* ==========================
       SEARCH OVERLAY
    ========================== */

    const searchBtn = document.getElementById("searchBtn");
    const searchOverlay = document.getElementById("searchOverlay");
    const closeSearch = document.getElementById("closeSearch");
    const globalSearch = document.getElementById("globalSearch");
    const searchSubmit = document.getElementById("searchSubmit");

    if (searchBtn && searchOverlay) {

        searchBtn.addEventListener("click", function () {
            searchOverlay.classList.add("show");

            if (globalSearch) {
                setTimeout(function () {
                    globalSearch.focus();
                }, 100);
            }
        });
    }

    if (closeSearch && searchOverlay) {
        closeSearch.addEventListener("click", function () {
            searchOverlay.classList.remove("show");
        });
    }

    if (searchOverlay) {
        searchOverlay.addEventListener("click", function (event) {

            if (event.target === searchOverlay) {
                searchOverlay.classList.remove("show");
            }

        });
    }


    /* ==========================
       SEARCH
    ========================== */

    if (searchSubmit && globalSearch) {

        searchSubmit.addEventListener("click", function () {

            const query = globalSearch.value.trim();

            if (query !== "") {
                window.location.href =
                    "courses.jsp?search=" + encodeURIComponent(query);
            }

        });

        globalSearch.addEventListener("keydown", function (event) {

            if (event.key === "Enter") {
                searchSubmit.click();
            }

        });
    }


    /* ==========================
       FOOTER YEAR
    ========================== */

    const currentYear = document.getElementById("currentYear");

    if (currentYear) {
        currentYear.textContent = new Date().getFullYear();
    }


    /* ==========================
       CLOSE MOBILE MENU
    ========================== */

    document.querySelectorAll(".nav-link").forEach(function (link) {

        link.addEventListener("click", function () {

            if (mainNav) {
                mainNav.classList.remove("mobile-open");
            }

        });

    });

});