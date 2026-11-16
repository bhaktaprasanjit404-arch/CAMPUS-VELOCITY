/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/ClientSide/javascript.js to edit this template
 */


document.addEventListener("DOMContentLoaded", function () {

    /* ==========================================
       COURSE SEARCH
    ========================================== */

    const searchInput = document.getElementById("courseSearch");
    const courseCards = document.querySelectorAll(".course-card");

    if (searchInput) {

        searchInput.addEventListener("input", function () {

            const searchValue = this.value.toLowerCase().trim();

            courseCards.forEach(function (card) {

                const text = card.innerText.toLowerCase();

                if (text.includes(searchValue)) {
                    card.style.display = "";
                } else {
                    card.style.display = "none";
                }

            });

        });

    }


    /* ==========================================
       CATEGORY BUTTONS
    ========================================== */

    const categoryButtons =
        document.querySelectorAll(".category-pill");

    categoryButtons.forEach(function (button) {

        button.addEventListener("click", function () {

            categoryButtons.forEach(function (item) {
                item.classList.remove("active");
            });

            this.classList.add("active");

        });

    });


    /* ==========================================
       WISHLIST
    ========================================== */

    const wishlistButtons =
        document.querySelectorAll(".wishlist");

    wishlistButtons.forEach(function (button) {

        button.addEventListener("click", function () {

            const icon = this.querySelector("i");

            if (icon.classList.contains("fa-regular")) {

                icon.classList.remove("fa-regular");
                icon.classList.add("fa-solid");

            } else {

                icon.classList.remove("fa-solid");
                icon.classList.add("fa-regular");

            }

        });

    });

});