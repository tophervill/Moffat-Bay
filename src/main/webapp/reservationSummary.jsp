<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.math.BigDecimal" %>
<%@ page import="java.math.RoundingMode" %>
<%@ page import="java.time.LocalDate" %>
<%@ page import="com.moffatbay.util.PricingUtil" %>

<%
    Integer loggedInCustomerId =
            (Integer) session.getAttribute("customerId");

    if (loggedInCustomerId == null) {

        response.sendRedirect(
                request.getContextPath()
                + "/Login_Page.jsp"
        );

        return;
    }


    Integer pendingBoatId =
            (Integer) session.getAttribute(
                    "pendingBoatId"
            );

    String pendingBoatName =
            (String) session.getAttribute(
                    "pendingBoatName"
            );

    Double pendingBoatLength =
            (Double) session.getAttribute(
                    "pendingBoatLength"
            );

    Integer pendingSlipId =
            (Integer) session.getAttribute(
                    "pendingSlipId"
            );

    String pendingSlipNumber =
            (String) session.getAttribute(
                    "pendingSlipNumber"
            );

    Integer pendingSlipSize =
            (Integer) session.getAttribute(
                    "pendingSlipSize"
            );

    LocalDate pendingCheckInDate =
            (LocalDate) session.getAttribute(
                    "pendingCheckInDate"
            );

    LocalDate pendingCheckOutDate =
            (LocalDate) session.getAttribute(
                    "pendingCheckOutDate"
            );

    BigDecimal pendingMonthlyCost =
            (BigDecimal) session.getAttribute(
                    "pendingMonthlyCost"
            );


    boolean reservationReady =
            pendingBoatId != null
            && pendingBoatName != null
            && pendingBoatLength != null
            && pendingSlipId != null
            && pendingSlipNumber != null
            && pendingSlipSize != null
            && pendingCheckInDate != null
            && pendingCheckOutDate != null
            && pendingMonthlyCost != null;


    BigDecimal pendingBaseSlipCost = null;

    if (pendingBoatLength != null) {

        pendingBaseSlipCost =
                BigDecimal.valueOf(pendingBoatLength)
                        .multiply(PricingUtil.RATE_PER_FOOT)
                        .setScale(
                                2,
                                RoundingMode.HALF_UP
                        );
    }
%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        Reservation Summary | Moffat Bay Marina
    </title>

    <meta name="description"
          content="Review your Moffat Bay Marina slip reservation.">

    <meta name="author"
          content="CSD460-340 | Group C">

    <link rel="preconnect"
          href="https://fonts.googleapis.com">

    <link rel="preconnect"
          href="https://fonts.gstatic.com"
          crossorigin>

    <link href="https://fonts.googleapis.com/css2?family=Inika:wght@400;700&family=Mulish:wght@400;500;600;700&display=swap"
          rel="stylesheet">

    <!-- Shared header/footer styles -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/styles.css">

    <!-- Reservation Summary styles -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/reservation_summary.css">

</head>


<body>

<%@ include file="includes/header.jsp" %>


<main class="summary-page">

    <section class="summary-card">


        <div class="summary-heading">

            <p class="summary-eyebrow">
                Moffat Bay Marina
            </p>

            <h1>
                Reservation Summary
            </h1>

            <p class="summary-description">
                Review your reservation information below
                before confirming your slip.
            </p>

        </div>


        <% if (reservationReady) { %>


            <div class="summary-section">

                <h2>
                    Your Boat
                </h2>

                <div class="summary-grid">

                    <div class="summary-item">

                        <span class="summary-label">
                            Boat Name
                        </span>

                        <span class="summary-value">
                            <%= pendingBoatName %>
                        </span>

                    </div>


                    <div class="summary-item">

                        <span class="summary-label">
                            Boat Length
                        </span>

                        <span class="summary-value">
                            <%= pendingBoatLength %> ft.
                        </span>

                    </div>

                </div>

            </div>


            <div class="summary-section">

                <h2>
                    Slip Information
                </h2>

                <div class="summary-grid">

                    <div class="summary-item">

                        <span class="summary-label">
                            Slip Number
                        </span>

                        <span class="summary-value">
                            <%= pendingSlipNumber %>
                        </span>

                    </div>


                    <div class="summary-item">

                        <span class="summary-label">
                            Slip Size
                        </span>

                        <span class="summary-value">
                            <%= pendingSlipSize %>-foot slip
                        </span>

                    </div>

                </div>

            </div>


            <div class="summary-section">

                <h2>
                    Reservation Dates
                </h2>

                <div class="summary-grid">

                    <div class="summary-item">

                        <span class="summary-label">
                            Check-In Date
                        </span>

                        <span class="summary-value">
                            <%= pendingCheckInDate %>
                        </span>

                    </div>


                    <div class="summary-item">

                        <span class="summary-label">
                            Check-Out Date
                        </span>

                        <span class="summary-value">
                            <%= pendingCheckOutDate %>
                        </span>

                    </div>

                </div>

            </div>


            <div class="summary-price">

                <div>

                    <span class="summary-price-label">
                        Monthly Cost
                    </span>

                    <span class="summary-price-note">
                        <strong>
                            <%= pendingBoatLength %> ft. ×
                            $<%= PricingUtil.RATE_PER_FOOT %> per foot =
                            $<%= pendingBaseSlipCost %>
                        </strong>
                    </span>

                    <span class="summary-price-note">
                        Includes the $10 electrical service fee.
                    </span>

                </div>

                <span class="summary-price-value">
                    $<%= pendingMonthlyCost %>
                </span>

            </div>


            <div class="summary-actions">

                <a
                    class="summary-button secondary-button"
                    href="${pageContext.request.contextPath}/reservation">

                    Back to Reservation

                </a>


                <form
                    action="${pageContext.request.contextPath}/confirmReservation"
                    method="POST">

                    <button
                        type="submit"
                        class="summary-button primary-button">

                        Confirm Reservation

                    </button>

                </form>

            </div>


        <% } else { %>


            <div class="summary-error">

                <strong>
                    Reservation Information Unavailable
                </strong>

                <p>
                    We could not find a pending reservation
                    to review. Please return to the reservation
                    page and select your dates again.
                </p>

                <a
                    class="summary-button primary-button"
                    href="${pageContext.request.contextPath}/reservation">

                    Return to Reservation

                </a>

            </div>


        <% } %>


    </section>

</main>


<%@ include file="includes/footer.jsp" %>

</body>

</html>