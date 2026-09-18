<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        Contact Us | Moffat Bay Marina
    </title>

    <meta name="description"
          content="Contact Moffat Bay Marina for questions about reservations, marina services, and boating on Joviedsa Island.">

    <meta name="author"
          content="CSD460-340A | Group C">


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


    <!-- Contact Us Page Styles -->

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/contact_us.css">

</head>


<body>


    <%@ include file="includes/header.jsp" %>


    <main class="contact-page">


        <!-- =====================================================
             CONTACT INTRODUCTION
             ===================================================== -->

        <section class="contact-hero">

            <div class="contact-container">

                <p class="contact-eyebrow">
                    MOFFAT BAY MARINA
                </p>

                <h1>
                    Contact Us
                </h1>

                <p class="contact-intro">

                    Have a question about Moffat Bay Marina,
                    your reservation, or our marina services?

                    Our team is available to help.

                </p>

            </div>

        </section>


        <!-- =====================================================
             CONTACT INFORMATION
             ===================================================== -->

        <section class="contact-section">

            <div class="contact-container">

                <h2>
                    Get in Touch
                </h2>

                <p class="section-description">

                    Use the contact information below to reach
                    the Moffat Bay Marina team.

                </p>


                <div class="contact-grid">


                    <!-- EMAIL -->

                    <div class="contact-card">

                        <p class="contact-card-label">
                            Customer Support Email
                        </p>

                        <h3>
                            Email Us
                        </h3>

                        <a href="mailto:MoffatBayMarina@email.com"
                           class="contact-link">

                            MoffatBayMarina@email.com

                        </a>

                    </div>


                    <!-- PHONE -->

                    <div class="contact-card">

                        <p class="contact-card-label">
                            Marina Phone
                        </p>

                        <h3>
                            Call Us
                        </h3>

                        <a href="tel:15555555555"
                           class="contact-link">

                            +1 (555) 555-5555

                        </a>

                    </div>


                    <!-- VHF -->

                    <div class="contact-card">

                        <p class="contact-card-label">
                            Harbormaster
                        </p>

                        <h3>
                            VHF Radio
                        </h3>

                        <p class="contact-card-value">
                            Channel 68
                        </p>

                    </div>


                    <!-- LOCATION -->

                    <div class="contact-card">

                        <p class="contact-card-label">
                            Location
                        </p>

                        <h3>
                            Joviedsa Island
                        </h3>

                        <p class="contact-card-value">
                            Washington State
                        </p>

                    </div>


                </div>

            </div>

        </section>


        <!-- =====================================================
             HOURS
             ===================================================== -->

        <section class="contact-hours-section">

            <div class="contact-container">

                <div class="contact-hours-card">

                    <div class="hours-content">

                        <p class="contact-card-label">
                            MARINA OFFICE
                        </p>

                        <h2>
                            Hours of Operation
                        </h2>

                        <div class="hours-row">

                            <span>
                                Monday - Friday
                            </span>

                            <strong>
                                8:00 AM - 8:00 PM
                            </strong>

                        </div>

                        <div class="hours-row">

                            <span>
                                Saturday
                            </span>

                            <strong>
                                8:00 AM - 10:00 PM
                            </strong>

                        </div>

                        <div class="hours-row">

                            <span>
                                Sunday
                            </span>

                            <strong>
                                Closed
                            </strong>

                        </div>

                    </div>


                    <div class="contact-action">

                        <h3>
                            Need Assistance?
                        </h3>

                        <p>

                            Send our customer service team an email
                            and we will respond as soon as possible.

                        </p>

                        <a class="primary-button contact-button"
                           href="mailto:MoffatBayMarina@email.com">

                            Email Moffat Bay Marina

                        </a>

                    </div>

                </div>

            </div>

        </section>


    </main>


    <%@ include file="includes/footer.jsp" %>


</body>

</html>