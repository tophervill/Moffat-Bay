<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        Attractions | Moffat Bay Marina
    </title>

    <meta name="description"
          content="Explore popular attractions around Moffat Bay Marina, including Moffat Bay Pier, The Lost Mariner Wreck, and Moonlight Sandbar.">

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


    <!-- Shared Header / Footer Styles -->

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/styles.css">


    <!-- Attractions Page Styles -->

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/attractions.css">

</head>


<body>


    <%@ include file="includes/header.jsp" %>


    <main class="attractions-page">


        <!-- =====================================================
             HERO
             ===================================================== -->

        <section class="attractions-hero">

            <div class="attractions-container">

                <p class="attractions-eyebrow">
                    EXPLORE JOVIEDSA ISLAND
                </p>

                <h1>
                    Adventure Starts at Moffat Bay
                </h1>

                <p class="attractions-intro">

                    A stay at Moffat Bay Marina is about more than
                    finding the perfect place for your boat.

                    From unforgettable sunsets and underwater adventures
                    to one of the area's favorite boating destinations,
                    there is always something waiting just beyond the marina.

                </p>

            </div>

        </section>


        <!-- =====================================================
             ATTRACTION CARDS
             ===================================================== -->

        <section class="attractions-section">

            <div class="attractions-container">


                <div class="section-heading">

                    <p class="attractions-eyebrow">
                        LOCAL FAVORITES
                    </p>

                    <h2>
                        Discover Moffat Bay
                    </h2>

                    <p>

                        Make the most of your time on Joviedsa Island
                        with some of the most popular destinations
                        around Moffat Bay.

                    </p>

                </div>


                <div class="attractions-grid">


                    <!-- =================================================
                         MOFFAT BAY PIER
                         ================================================= -->

                    <article class="attraction-card">


                        <div class="attraction-image-wrapper">

                            <img
                                class="attraction-image"
                                src="${pageContext.request.contextPath}/Images/Moffat%20Bay%20Pier%20Image.png"
                                alt="Moffat Bay Pier at sunset">

                            <span class="attraction-category">
                                Waterfront
                            </span>

                        </div>


                        <div class="attraction-card-content">


                            <h3>
                                Moffat Bay Pier
                            </h3>


                            <p class="attraction-tagline">
                                Where every island adventure begins.
                            </p>


                            <p class="attraction-summary">

                                Take in sweeping bay views, unforgettable
                                sunsets, and the relaxed atmosphere of
                                Joviedsa Island from Moffat Bay Pier.

                                Just minutes from the marina, the pier is
                                a favorite gathering place for boaters,
                                families, and visitors looking to enjoy
                                the waterfront.

                            </p>


                            <div class="attraction-highlights">

                                <span>Sunset Views</span>

                                <span>Fishing</span>

                                <span>Boat Watching</span>

                                <span>Photography</span>

                            </div>


                            <p class="attraction-extra">

                                Whether you're taking photos at sunset,
                                watching boats move through the bay, or
                                simply enjoying the ocean breeze, Moffat
                                Bay Pier is the perfect place to slow down
                                and experience island life.

                            </p>


                        </div>


                    </article>


                    <!-- =================================================
                         LOST MARINER WRECK
                         ================================================= -->

                    <article class="attraction-card">


                        <div class="attraction-image-wrapper">

                            <img
                                class="attraction-image"
                                src="${pageContext.request.contextPath}/Images/Moffat%20Bay%20Shipwreck%20Image.png"
                                alt="Divers exploring the Lost Mariner shipwreck">

                            <span class="attraction-category">
                                Adventure
                            </span>

                        </div>


                        <div class="attraction-card-content">


                            <h3>
                                The Lost Mariner Wreck
                            </h3>


                            <p class="attraction-tagline">
                                Dive beneath the bay and discover island history.
                            </p>


                            <p class="attraction-summary">

                                Adventure below the surface at The Lost Mariner
                                Wreck, one of Moffat Bay's most exciting scuba
                                diving destinations.

                                The historic wreck has become an artificial reef
                                filled with marine life, coral growth, and
                                incredible underwater scenery.

                            </p>


                            <div class="attraction-highlights">

                                <span>Scuba Diving</span>

                                <span>Marine Wildlife</span>

                                <span>Guided Dives</span>

                                <span>Underwater Photography</span>

                            </div>


                            <p class="attraction-extra">

                                Experienced divers can explore the exterior
                                of the vessel while schools of fish move
                                throughout the wreck.

                                Local dive excursions make this a memorable
                                stop for visitors looking for an adventure
                                beneath the water.

                            </p>


                        </div>


                    </article>


                    <!-- =================================================
                         MOONLIGHT SANDBAR
                         ================================================= -->

                    <article class="attraction-card">


                        <div class="attraction-image-wrapper">

                            <img
                                class="attraction-image"
                                src="${pageContext.request.contextPath}/Images/Moffat%20Bay%20Sandbar%20Image.png"
                                alt="Boats gathered at Moonlight Sandbar at night">

                            <span class="attraction-category">
                                Nightlife
                            </span>

                        </div>


                        <div class="attraction-card-content">


                            <h3>
                                Moonlight Sandbar
                            </h3>


                            <p class="attraction-tagline">
                                Drop anchor. Turn up the lights. Stay awhile.
                            </p>


                            <p class="attraction-summary">

                                When the sun goes down, Moonlight Sandbar
                                becomes one of the liveliest boating
                                destinations around Moffat Bay.

                                Boats gather in the shallow water, colorful
                                underwater lights illuminate the bay, and
                                visitors step off their boats to socialize
                                beneath the stars.

                            </p>


                            <div class="attraction-highlights">

                                <span>Boat Meetups</span>

                                <span>Night Swimming</span>

                                <span>Music</span>

                                <span>Sunset Gatherings</span>

                            </div>


                            <p class="attraction-extra">

                                On popular summer evenings, Moonlight Sandbar
                                comes alive with music, glowing boats, floating
                                games, and groups of friends enjoying the water.

                                It is the perfect destination for boaters
                                looking to add a little nightlife to their
                                Moffat Bay getaway.

                            </p>


                        </div>


                    </article>


                </div>

            </div>

        </section>


        <!-- =====================================================
             RESERVATION CALL TO ACTION
             ===================================================== -->

        <section class="attractions-cta">

            <div class="attractions-container">


                <div class="attractions-cta-card">


                    <div class="cta-content">

                        <p class="attractions-eyebrow">
                            YOUR MOFFAT BAY ADVENTURE
                        </p>

                        <h2>
                            Stay Close to the Action
                        </h2>

                        <p>

                            Make Moffat Bay Marina your home base while
                            exploring everything Joviedsa Island has to offer.

                            Reserve your marina slip and start planning
                            your next waterfront adventure.

                        </p>

                    </div>


                    <div class="cta-action">

                        <a
                            class="attractions-button"
                            href="${pageContext.request.contextPath}/reservation">

                            Reserve a Slip

                        </a>

                    </div>


                </div>


            </div>

        </section>


    </main>


    <%@ include file="includes/footer.jsp" %>


</body>

</html>