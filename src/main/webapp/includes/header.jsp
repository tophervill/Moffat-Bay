<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<header class="site-header">

    <nav class="navbar">


        <!-- =====================================================
             LOGO
             ===================================================== -->

        <a class="brand"
           href="${pageContext.request.contextPath}/index.jsp">

            <img
                class="header-logo"
                src="${pageContext.request.contextPath}/Images/moffatBayLogo.png"
                alt="Moffat Bay Marina">

        </a>


        <!-- =====================================================
             MAIN NAVIGATION
             ===================================================== -->

        <div class="nav-links">


            <a
                class="nav-link ${pageContext.request.servletPath == '/index.jsp' ? 'active' : ''}"
                href="${pageContext.request.contextPath}/index.jsp">

                Home

            </a>


            <a
                class="nav-link ${pageContext.request.servletPath == '/attractions.jsp' ? 'active' : ''}"
                href="${pageContext.request.contextPath}/attractions.jsp">

                Attractions

            </a>


            <a
                class="nav-link ${pageContext.request.servletPath == '/about_Us.jsp' ? 'active' : ''}"
                href="${pageContext.request.contextPath}/about_Us.jsp">

                About Us

            </a>


            <a
                class="nav-link ${pageContext.request.servletPath == '/reservationLookup' || pageContext.request.servletPath == '/reservationLookup.jsp' ? 'active' : ''}"
                href="${pageContext.request.contextPath}/reservationLookup">

                Check Reservation

            </a>


        </div>


        <!-- =====================================================
             ACCOUNT / LOGIN
             ===================================================== -->

        <div class="nav-actions">


            <%
                String loggedInCustomerName =
                        (String) session.getAttribute("customerName");

                if (loggedInCustomerName != null) {
            %>


                <span class="nav-status">

                    Welcome, <%= loggedInCustomerName %>

                </span>


                <a
                    class="nav-link"
                    href="${pageContext.request.contextPath}/logout">

                    Logout

                </a>


            <% } else { %>


                <a
                    class="nav-link ${pageContext.request.servletPath == '/Login_Page.jsp' ? 'active' : ''}"
                    href="${pageContext.request.contextPath}/Login_Page.jsp">

                    Log In

                </a>


            <% } %>


        </div>


    </nav>

</header>