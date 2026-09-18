<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        About Us | Moffat Bay Marina
    </title>

    <meta name="description"
          content="Learn about Moffat Bay Marina, our slip options, pricing, contact information, and marina services on Joviedsa Island.">

    <meta name="author"
          content="CSD460-340A | Group C">

    <meta name="keywords"
          content="Moffat Bay Marina, Joviedsa Island, boat slips, marina pricing, marina contact">


    <!-- Shared Fonts -->

    <link rel="preconnect"
          href="https://fonts.googleapis.com">

    <link rel="preconnect"
          href="https://fonts.gstatic.com"
          crossorigin>

    <link href="https://fonts.googleapis.com/css2?family=Inika:wght@400;700&family=Mulish:wght@400;500;600;700&display=swap"
          rel="stylesheet">


    <!-- Shared Site Styles -->

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/styles.css">


    <!-- About Us Page Styles -->

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/about_Us.css">

</head>


<body>


    <%@ include file="includes/header.jsp" %>


    <main class="aboutUs-page">


        <!-- =====================================================
             ABOUT MOFFAT BAY MARINA
             ===================================================== -->

        <section class="about-section">

            <div class="about-content">

                <p class="about-eyebrow">
                    MOFFAT BAY MARINA
                </p>

                <h1>
                    The Moffat Bay Marina Experience
                </h1>

                <p class="about-intro">

                    Moffat Bay Marina is a recreational marina created
                    by the hard-working employees of the San Juan Islands
                    First Nations Development Committee.

                    Our goal is to provide boating enthusiasts with a fun,
                    affordable, and safe long-term marina option on
                    Joviedsa Island.

                </p>

            </div>

        </section>


        <!-- =====================================================
             SLIP INFORMATION
             ===================================================== -->

        <section class="about-section about-section-light">

            <div class="about-content">

                <h2>
                    Slip Reservation Pricing
                </h2>

                <p class="section-description">

                    Monthly slip pricing is based on the actual length
                    of your registered boat.

                    The current rate is
                    <strong>$10.50 per foot</strong>
                    plus a
                    <strong>$10 electrical service fee</strong>.

                </p>


                <div class="pricing-grid">


                    <div class="about-card">

                        <h3>
                            26-Foot Slip
                        </h3>

                        <p class="pricing-value">
                            Up to $283/month
                        </p>

                        <p>
                            For registered boats measuring
                            up to 26 feet.
                        </p>

                    </div>


                    <div class="about-card">

                        <h3>
                            40-Foot Slip
                        </h3>

                        <p class="pricing-value">
                            Up to $430/month
                        </p>

                        <p>
                            For registered boats measuring
                            more than 26 feet and up to 40 feet.
                        </p>

                    </div>


                    <div class="about-card">

                        <h3>
                            50-Foot Slip
                        </h3>

                        <p class="pricing-value">
                            Up to $535/month
                        </p>

                        <p>
                            For registered boats measuring
                            more than 40 feet and up to 50 feet.
                        </p>

                    </div>


                </div>


                <p class="pricing-note">

                    Your exact monthly cost is calculated using your
                    registered boat length rather than the maximum
                    length of the assigned slip.

                </p>

            </div>

        </section>


        <!-- =====================================================
             CONTACT INFORMATION
             ===================================================== -->

        <section class="about-section">

            <div class="about-content">

                <h2>
                    Contact Moffat Bay Marina
                </h2>

                <p class="section-description">

                    For questions or concerns, contact our marina team
                    using the information below.

                </p>


                <div class="contact-grid">


                    <div class="about-card contact-card">

                        <span class="contact-label">
                            Harbormaster VHF Hail
                        </span>

                        <span class="contact-value">
                            Channel 68
                        </span>

                    </div>


                    <div class="about-card contact-card">

                        <span class="contact-label">
                            Office Phone
                        </span>

                        <span class="contact-value">
                            (444) 348-4800
                        </span>

                    </div>


                    <div class="about-card contact-card">

                        <span class="contact-label">
                            Customer Support Email
                        </span>

                        <a class="contact-value"
                           href="mailto:MoffatBayMarina@email.com">

                            MoffatBayMarina@email.com

                        </a>

                    </div>


                    <div class="about-card contact-card">

                        <span class="contact-label">
                            Hours of Operation
                        </span>

                        <span class="contact-value">

                            Monday-Friday: 8 AM - 8 PM<br>
                            Saturday: 8 AM - 10 PM<br>
                            Sunday: Closed

                        </span>

                    </div>


                </div>

            </div>

        </section>


        <!-- =====================================================
             MARINA IMAGE
             ===================================================== -->

        <section class="about-image-section">

            <img
                class="about-image"
                src="${pageContext.request.contextPath}/Images/aboutUs.jpg"
                alt="Moffat Bay Marina">

        </section>


    </main>


    <%@ include file="includes/footer.jsp" %>


</body>

</html>