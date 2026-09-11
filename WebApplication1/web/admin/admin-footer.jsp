<%-- 
    Document   : admin-footer
    Created on : 10 Sept 2026, 10:33:30?pm
    Author     : User
--%>

</main>

        <footer class="admin-footer">

            <span>
                © 2026 Capacity Connect
            </span>

            <span>
                Admin Control Center
            </span>

        </footer>

    </div>

</div>


<script>

    const mobileMenu =
        document.getElementById("mobileMenu");

    const adminSidebar =
        document.getElementById("adminSidebar");

    const sidebarOverlay =
        document.getElementById("sidebarOverlay");


    if (mobileMenu) {

        mobileMenu.addEventListener(
            "click",
            function () {

                adminSidebar.classList.toggle("open");

                sidebarOverlay.classList.toggle("show");

            }
        );

    }


    if (sidebarOverlay) {

        sidebarOverlay.addEventListener(
            "click",
            function () {

                adminSidebar.classList.remove("open");

                sidebarOverlay.classList.remove("show");

            }
        );

    }


    document.querySelectorAll(
        ".delete-confirm"
    ).forEach(function (button) {

        button.addEventListener(
            "click",
            function (event) {

                if (!confirm(
                    "Are you sure you want to delete this item?"
                )) {

                    event.preventDefault();

                }

            }
        );

    });

</script>

</body>

</html>