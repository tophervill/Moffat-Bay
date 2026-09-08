<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<header class="site-header">

    <nav class="navbar">

        <a class="brand" href="${pageContext.request.contextPath}/index.jsp">
            Moffat Bay Marina
        </a>


        <div class="nav-links">

            <a class="nav-link ${pageContext.request.servletPath == '/index.jsp' ? 'active' : ''}"
               href="${pageContext.request.contextPath}/index.jsp">
                Home
            </a>

            <a class="nav-link ${pageContext.request.servletPath == '/attractions.jsp' ? 'active' : ''}"
               href="${pageContext.request.contextPath}/attractions.jsp">
                Attractions
            </a>

            <a class="nav-link ${pageContext.request.servletPath == '/about.jsp' ? 'active' : ''}"
               href="${pageContext.request.contextPath}/about.jsp">
                About Us
            </a>

            <a class="nav-link ${pageContext.request.servletPath == '/contact.jsp' ? 'active' : ''}"
               href="${pageContext.request.contextPath}/contact.jsp">
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
