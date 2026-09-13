<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Moffat Bay Marina</title>

    <meta name="description"
          content="Moffat Bay Marina - Your gateway to coastal adventures.
          Reserve your boat slip online and explore the beauty of Joviedsa Island.">

    <meta name="author"
          content="CSD460-340 | Group C">

    <meta name="keywords"
          content="Moffat Bay Marina, Boat Slip Reservation, Joviedsa Island, Coastal Adventures">

    <link rel="preconnect"
          href="https://fonts.googleapis.com">

    <link rel="preconnect"
          href="https://fonts.gstatic.com"
          crossorigin>

    <link href="https://fonts.googleapis.com/css2?family=Inika:wght@400;700&display=swap"
          rel="stylesheet">

    <!-- Shared site styles for consistent header/footer -->

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/styles.css">

    <!-- About Us page-specific styles -->

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/about_Us.css">

</head>


<!-- About Us Page -->

<body>

<%@ include file="includes/header.jsp" %>


<main class="aboutUs-page">

    <div class="company-info">

        <h1>

            The Moffat Bay Marina Experience – Inexpensive Boating for All

        </h1>

        <h2>

            The Moffat Bay Marina is a recreational boatyard created by the hard-working employees of the
            San Juan Islands First Nations Development Committee, to provide those who love boating with a
            fun, affordable, and most importantly a safe option for any occasion with multiple boat size options available
            from those fitting a small group of friends to the whole family.

        </h2>

        <br>

        <h2>

            For any questions or concerns please contact our customer service team today.

        </h2>

        <h2>

            Email:

            <a href="mailto:MoffatBayMarina@email.com">

                MoffatBayMarina@email.com

            </a>

        </h2>

        <h2>

            Marina Harbormaster: VHF Channel 68

        </h2>

        <br>

        <br>


        <div style="width: 100%; margin: 0 auto;">

            <img
                src="${pageContext.request.contextPath}/Images/aboutUs.jpg"
                width="1400"
                alt="Description" />

        </div>

    </div>

</main>


<%@ include file="includes/footer.jsp" %>


</body>

</html>