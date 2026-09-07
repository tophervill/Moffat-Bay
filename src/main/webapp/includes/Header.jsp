<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<header class="site-header">

    <nav class="navbar">

        <a class="brand"
           href="${pageContext.request.contextPath}/index.jsp">
            Moffat Bay Marina
        </a>


        <div class="nav-links">

            <a class="nav-link"
               href="${pageContext.request.contextPath}/index.jsp">
                Home
            </a>

            <a class="nav-link"
               href="#">
                Attractions
            </a>

            <a class="nav-link"
               href="#">
                About Us
            </a>

            <a class="nav-link"
               href="#">
                Contact Us
            </a>

        </div>


        <div class="nav-actions">

            <a class="nav-pill"
               href="${pageContext.request.contextPath}/reservationLookup.jsp">
                Check Reservation
            </a>

            <a class="nav-pill"
               href="${pageContext.request.contextPath}/register.jsp">
                Account
            </a>

        </div>

    </nav>

</header>