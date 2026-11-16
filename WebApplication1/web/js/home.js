/* =========================================================
   CAPACITY CONNECT
   HOME PAGE JAVASCRIPT
   ========================================================= */


/* =========================================================
   WAIT FOR PAGE TO LOAD
   ========================================================= */

document.addEventListener("DOMContentLoaded", function () {


    /* =====================================================
       HERO SLIDER
       ===================================================== */

    const heroSlides = document.querySelectorAll(".hero-slide");

    const heroDots = document.querySelectorAll(".hero-dot");

    const heroPrev = document.getElementById("heroPrev");

    const heroNext = document.getElementById("heroNext");


    let currentSlide = 0;

    let heroTimer;


    /* =====================================================
       SHOW HERO SLIDE
       ===================================================== */

    function showSlide(index) {

        if (heroSlides.length === 0) {
            return;
        }


        /*
         * Keep index inside the available range
         */

        if (index < 0) {
            index = heroSlides.length - 1;
        }

        if (index >= heroSlides.length) {
            index = 0;
        }


        currentSlide = index;


        /*
         * Remove active class from all slides
         */

        heroSlides.forEach(function (slide) {

            slide.classList.remove("active");

        });


        /*
         * Remove active class from all dots
         */

        heroDots.forEach(function (dot) {

            dot.classList.remove("active");

        });


        /*
         * Activate selected slide
         */

        heroSlides[currentSlide].classList.add("active");


        /*
         * Activate selected dot
         */

        if (heroDots[currentSlide]) {

            heroDots[currentSlide].classList.add("active");

        }

    }


    /* =====================================================
       NEXT HERO SLIDE
       ===================================================== */

    function nextSlide() {

        showSlide(currentSlide + 1);

    }


    /* =====================================================
       PREVIOUS HERO SLIDE
       ===================================================== */

    function previousSlide() {

        showSlide(currentSlide - 1);

    }


    /* =====================================================
       AUTOMATIC HERO SLIDER
       ===================================================== */

    function startHeroSlider() {

        stopHeroSlider();


        heroTimer = setInterval(function () {

            nextSlide();

        }, 5000);

    }


    /* =====================================================
       STOP HERO SLIDER
       ===================================================== */

    function stopHeroSlider() {

        if (heroTimer) {

            clearInterval(heroTimer);

            heroTimer = null;

        }

    }


    /* =====================================================
       HERO NEXT BUTTON
       ===================================================== */

    if (heroNext) {

        heroNext.addEventListener("click", function () {

            nextSlide();

            /*
             * Restart timer after manual click
             */

            startHeroSlider();

        });

    }


    /* =====================================================
       HERO PREVIOUS BUTTON
       ===================================================== */

    if (heroPrev) {

        heroPrev.addEventListener("click", function () {

            previousSlide();

            /*
             * Restart timer after manual click
             */

            startHeroSlider();

        });

    }


    /* =====================================================
       HERO DOTS
       ===================================================== */

    heroDots.forEach(function (dot) {

        dot.addEventListener("click", function () {

            const slideNumber =
                parseInt(
                    dot.getAttribute("data-slide")
                );


            if (!isNaN(slideNumber)) {

                showSlide(slideNumber);

                /*
                 * Restart automatic timer
                 */

                startHeroSlider();

            }

        });

    });


    /* =====================================================
       PAUSE HERO WHEN MOUSE IS OVER HERO
       ===================================================== */

    const heroSection =
        document.querySelector(".hero-section");


    if (heroSection) {

        heroSection.addEventListener("mouseenter", function () {

            stopHeroSlider();

        });


        heroSection.addEventListener("mouseleave", function () {

            startHeroSlider();

        });

    }


    /* =====================================================
       PAUSE WHEN BROWSER TAB IS NOT ACTIVE
       ===================================================== */

    document.addEventListener(
        "visibilitychange",
        function () {

            if (document.hidden) {

                stopHeroSlider();

            } else {

                startHeroSlider();

            }

        }
    );


    /* =====================================================
       START HERO
       ===================================================== */

    if (heroSlides.length > 0) {

        showSlide(0);

        startHeroSlider();

    }



    /* =====================================================
       PROGRAM CAROUSEL
       ===================================================== */

    const programCarousel =
        document.getElementById("programCarousel");


    const programPrev =
        document.getElementById("programPrev");


    const programNext =
        document.getElementById("programNext");


    if (programCarousel) {


        /* =================================================
           GET PROGRAM CARDS
           ================================================= */

        const programCards =
            programCarousel.querySelectorAll(".program-card");


        /* =================================================
           FIND CARD SCROLL WIDTH
           ================================================= */

        function getScrollAmount() {

            if (programCards.length === 0) {

                return 300;

            }


            const card =
                programCards[0];


            const cardWidth =
                card.getBoundingClientRect().width;


            const style =
                window.getComputedStyle(
                    programCarousel
                );


            const gap =
                parseFloat(style.gap) || 18;


            return cardWidth + gap;

        }


        /* =================================================
           UPDATE PROGRAM ARROWS
           ================================================= */

        function updateProgramButtons() {

            if (!programPrev || !programNext) {

                return;

            }


            /*
             * Check if we are at the beginning
             */

            if (
                programCarousel.scrollLeft <= 5
            ) {

                programPrev.style.opacity = "0.35";

                programPrev.style.pointerEvents = "none";

            } else {

                programPrev.style.opacity = "1";

                programPrev.style.pointerEvents = "auto";

            }


            /*
             * Check if we are at the end
             */

            const maxScroll =
                programCarousel.scrollWidth -
                programCarousel.clientWidth;


            if (
                programCarousel.scrollLeft >=
                maxScroll - 5
            ) {

                programNext.style.opacity = "0.35";

                programNext.style.pointerEvents = "none";

            } else {

                programNext.style.opacity = "1";

                programNext.style.pointerEvents = "auto";

            }

        }


        /* =================================================
           SCROLL PROGRAMS TO RIGHT
           ================================================= */

        function scrollProgramsRight() {

            programCarousel.scrollBy({

                left: getScrollAmount(),

                behavior: "smooth"

            });

        }


        /* =================================================
           SCROLL PROGRAMS TO LEFT
           ================================================= */

        function scrollProgramsLeft() {

            programCarousel.scrollBy({

                left: -getScrollAmount(),

                behavior: "smooth"

            });

        }


        /* =================================================
           NEXT PROGRAM BUTTON
           ================================================= */

        if (programNext) {

            programNext.addEventListener(
                "click",
                function () {

                    scrollProgramsRight();

                }
            );

        }


        /* =================================================
           PREVIOUS PROGRAM BUTTON
           ================================================= */

        if (programPrev) {

            programPrev.addEventListener(
                "click",
                function () {

                    scrollProgramsLeft();

                }
            );

        }


        /* =================================================
           UPDATE BUTTONS WHEN SCROLLING
           ================================================= */

        programCarousel.addEventListener(
            "scroll",
            function () {

                updateProgramButtons();

            }
        );


        /* =================================================
           MOUSE WHEEL
           
           Converts vertical mouse wheel movement
           into horizontal program scrolling.
           ================================================= */

        programCarousel.addEventListener(
            "wheel",
            function (event) {

                /*
                 * Only convert when the user is
                 * actually scrolling vertically.
                 */

                if (Math.abs(event.deltaY) >
                    Math.abs(event.deltaX)) {

                    event.preventDefault();


                    programCarousel.scrollLeft +=
                        event.deltaY;

                }

            },
            {
                passive: false
            }
        );


        /* =================================================
           TOUCH SWIPE SUPPORT
           
           Mobile users can swipe the cards left/right.
           ================================================= */

        let touchStartX = 0;

        let touchStartY = 0;


        programCarousel.addEventListener(
            "touchstart",
            function (event) {

                if (
                    event.touches &&
                    event.touches.length > 0
                ) {

                    touchStartX =
                        event.touches[0].clientX;

                    touchStartY =
                        event.touches[0].clientY;

                }

            },
            {
                passive: true
            }
        );


        programCarousel.addEventListener(
            "touchend",
            function (event) {

                if (
                    !event.changedTouches ||
                    event.changedTouches.length === 0
                ) {

                    return;

                }


                const touchEndX =
                    event.changedTouches[0].clientX;


                const touchEndY =
                    event.changedTouches[0].clientY;


                const differenceX =
                    touchStartX - touchEndX;


                const differenceY =
                    touchStartY - touchEndY;


                /*
                 * Make sure it is mainly
                 * a horizontal swipe.
                 */

                if (
                    Math.abs(differenceX) >
                    Math.abs(differenceY)
                ) {


                    /*
                     * Swipe LEFT
                     */

                    if (differenceX > 50) {

                        scrollProgramsRight();

                    }


                    /*
                     * Swipe RIGHT
                     */

                    if (differenceX < -50) {

                        scrollProgramsLeft();

                    }

                }

            },
            {
                passive: true
            }
        );


        /* =================================================
           DRAG WITH MOUSE
           
           Allows desktop users to drag the cards.
           ================================================= */

        let isDragging = false;

        let dragStartX = 0;

        let dragScrollLeft = 0;


        programCarousel.addEventListener(
            "mousedown",
            function (event) {

                isDragging = true;

                programCarousel.classList.add(
                    "dragging"
                );

                dragStartX = event.pageX;

                dragScrollLeft =
                    programCarousel.scrollLeft;

            }
        );


        programCarousel.addEventListener(
            "mouseleave",
            function () {

                isDragging = false;

                programCarousel.classList.remove(
                    "dragging"
                );

            }
        );


        programCarousel.addEventListener(
            "mouseup",
            function () {

                isDragging = false;

                programCarousel.classList.remove(
                    "dragging"
                );

            }
        );


        programCarousel.addEventListener(
            "mousemove",
            function (event) {

                if (!isDragging) {

                    return;

                }


                event.preventDefault();


                const distance =
                    event.pageX - dragStartX;


                programCarousel.scrollLeft =
                    dragScrollLeft - distance;

            }
        );


        /* =================================================
           RESIZE
           
           Recalculate buttons when browser
           width changes.
           ================================================= */

        window.addEventListener(
            "resize",
            function () {

                updateProgramButtons();

            }
        );


        /* =================================================
           INITIAL BUTTON STATE
           ================================================= */

        updateProgramButtons();

    }



    /* =====================================================
       ADD REVEAL ANIMATION TO SECTIONS
       ===================================================== */

    const revealElements =
        document.querySelectorAll(
            ".section-heading, " +
            ".class-card, " +
            ".program-card, " +
            ".why-content, " +
            ".why-image, " +
            ".video-container, " +
            ".cta-container"
        );


    /*
     * IntersectionObserver checks when
     * an element enters the screen.
     */

    if ("IntersectionObserver" in window) {


        const revealObserver =
            new IntersectionObserver(
                function (entries, observer) {

                    entries.forEach(
                        function (entry) {

                            if (entry.isIntersecting) {

                                entry.target.classList.add(
                                    "show-reveal"
                                );


                                observer.unobserve(
                                    entry.target
                                );

                            }

                        }
                    );

                },
                {
                    threshold: 0.12
                }
            );


        revealElements.forEach(
            function (element) {

                element.classList.add(
                    "reveal-element"
                );


                revealObserver.observe(
                    element
                );

            }
        );

    }


    /* =====================================================
       PROGRAM CARD LINK SAFETY
       
       Prevent accidental drag from opening links.
       ===================================================== */

    let wasDragging = false;


    if (programCarousel) {

        programCarousel.addEventListener(
            "mousedown",
            function () {

                wasDragging = false;

            }
        );


        programCarousel.addEventListener(
            "mousemove",
            function () {

                if (isMouseMovingFast()) {

                    wasDragging = true;

                }

            }
        );

    }


    function isMouseMovingFast() {

        return false;

    }


    /* =====================================================
       FINISHED
       ===================================================== */

    console.log(
        "Capacity Connect Home Page loaded successfully."
    );

});