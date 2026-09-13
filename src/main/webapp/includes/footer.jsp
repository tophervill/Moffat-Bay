<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<footer class="site-footer">

    <div class="footer-wrapper">


        <!-- LOGO / DESCRIPTION -->

        <div class="footer-column footer-brand-column">

            <img
                class="footer-logo"
                src="${pageContext.request.contextPath}/Images/moffatBayLogo.png"
                alt="Moffat Bay Marina">

            <p class="footer-description">
                Serving the Marina of Joviedsa Island located
                in the State of Washington.
            </p>

        </div>


        <!-- NAVIGATION -->

        <div class="footer-column">

            <a href="${pageContext.request.contextPath}/attractions.jsp">
                Attractions
            </a>

            <a href="${pageContext.request.contextPath}/reservation">
                Reservations
            </a>

            <a href="#">
                Wait List
            </a>

        </div>


        <!-- INFORMATION -->

        <div class="footer-column">

            <a href="${pageContext.request.contextPath}/about_Us.jsp">
                About Us
            </a>

            <a href="#">
                Account
            </a>

        </div>


        <!-- CONTACT -->

        <div class="footer-column footer-contact-column">

            <a href="mailto:MoffatBayMarina@email.com">
                MoffatBayMarina@email.com
            </a>

            <a href="tel:15555555555">
                +1 (555) 555-5555
            </a>

            <a href="https://wa.gov/"
               target="_blank"
               rel="noopener noreferrer">
                Joviedsa Island, Washington
            </a>

        </div>


    </div>


    <hr>


    <p class="footer-copyright">
        &copy; 2026 - Moffat Bay Marina
    </p>


</footer>