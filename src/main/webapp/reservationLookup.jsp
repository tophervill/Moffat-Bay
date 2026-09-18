<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.util.List" %>
<%@ page import="com.moffatbay.dao.ReservationDAO.ReservationInfo" %>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        Check Reservation | Moffat Bay Marina
    </title>

    <meta name="description"
          content="View and manage your existing Moffat Bay Marina reservations.">

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


    <!-- Reservation Lookup Page Styles -->

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/reservation_lookup.css">

</head>


<body>


    <%@ include file="includes/header.jsp" %>


    <%
        Integer loggedInCustomerId =
                (Integer) session.getAttribute("customerId");

        String lookupError =
                (String) request.getAttribute("lookupError");

        ReservationInfo selectedReservation =
                (ReservationInfo) request.getAttribute("reservation");

        List<ReservationInfo> reservations =
                (List<ReservationInfo>) request.getAttribute("reservations");
    %>


    <main class="reservation-lookup-page">


        <!-- =====================================================
             HERO
             ===================================================== -->

        <section class="lookup-hero">

            <div class="lookup-container">

                <p class="lookup-eyebrow">
                    MOFFAT BAY MARINA
                </p>

                <h1>
                    Check Reservation
                </h1>

                <p class="lookup-intro">

                    View your existing marina reservations,
                    inspect reservation details, or search manually
                    using a reservation number.

                </p>

            </div>

        </section>


        <!-- =====================================================
             PAGE CONTENT
             ===================================================== -->

        <section class="lookup-section">

            <div class="lookup-container">


                <%-- =================================================
                     NOT LOGGED IN
                     ================================================= --%>

                <% if (loggedInCustomerId == null) { %>


                    <div class="lookup-card lookup-login-card">

                        <p class="lookup-card-label">
                            ACCOUNT REQUIRED
                        </p>

                        <h2>
                            Log In Required
                        </h2>

                        <p class="lookup-description">

                            You must be logged in before viewing
                            reservation information.

                            This helps protect your account and
                            reservation details.

                        </p>


                        <a class="lookup-button"
                           href="${pageContext.request.contextPath}/Login_Page.jsp">

                            Log In

                        </a>

                    </div>


                <% } else { %>


                    <!-- =================================================
                         CUSTOMER RESERVATIONS
                         ================================================= -->

                    <div class="reservation-list-section">


                        <div class="reservation-list-heading">

                            <p class="lookup-card-label">
                                YOUR RESERVATIONS
                            </p>

                            <h2>
                                Your Marina Reservations
                            </h2>

                            <p class="lookup-description">

                                Select a reservation below to view
                                its complete details.

                            </p>

                        </div>


                        <% if (reservations != null
                                && !reservations.isEmpty()) { %>


                            <div class="reservation-card-grid">


                                <% for (ReservationInfo reservation
                                        : reservations) { %>


                                    <article class="reservation-card">


                                        <div class="reservation-card-top">


                                            <div>

                                                <p class="reservation-number-label">
                                                    Reservation
                                                </p>

                                                <h3>
                                                    #<%= reservation.getReservationId() %>
                                                </h3>

                                            </div>


                                            <div class="reservation-card-status">

                                                <%= reservation.getStatus() %>

                                            </div>


                                        </div>


                                        <div class="reservation-card-info">


                                            <div class="reservation-card-row">

                                                <span>
                                                    Boat
                                                </span>

                                                <strong>
                                                    <%= reservation.getBoatName() %>
                                                </strong>

                                            </div>


                                            <div class="reservation-card-row">

                                                <span>
                                                    Slip
                                                </span>

                                                <strong>
                                                    <%= reservation.getSlipNumber() %>
                                                </strong>

                                            </div>


                                            <div class="reservation-card-row">

                                                <span>
                                                    Check-In
                                                </span>

                                                <strong>
                                                    <%= reservation.getCheckInDate() %>
                                                </strong>

                                            </div>


                                            <div class="reservation-card-row">

                                                <span>
                                                    Check-Out
                                                </span>

                                                <strong>
                                                    <%= reservation.getCheckOutDate() %>
                                                </strong>

                                            </div>


                                            <div class="reservation-card-row">

                                                <span>
                                                    Monthly Cost
                                                </span>

                                                <strong>

                                                    $<%= String.format(
                                                            "%.2f",
                                                            reservation
                                                                .getMonthlyCost()
                                                                .doubleValue()
                                                    ) %>

                                                </strong>

                                            </div>


                                        </div>


                                        <a
                                            class="lookup-button reservation-view-button"
                                            href="${pageContext.request.contextPath}/reservationLookup?reservationId=<%= reservation.getReservationId() %>">

                                            View Details

                                        </a>


                                    </article>


                                <% } %>


                            </div>


                        <% } else { %>


                            <div class="lookup-card no-reservations-card">

                                <h3>
                                    No Reservations Found
                                </h3>

                                <p>

                                    There are currently no reservations
                                    associated with your account.

                                </p>

                                <a
                                    class="lookup-button"
                                    href="${pageContext.request.contextPath}/reservation">

                                    Make a Reservation

                                </a>

                            </div>


                        <% } %>


                    </div>


                    <!-- =================================================
                         SELECTED RESERVATION DETAILS
                         ================================================= -->

                    <% if (selectedReservation != null) { %>


                        <div class="lookup-result">


                            <div class="lookup-result-header">


                                <div>

                                    <p class="lookup-card-label">
                                        RESERVATION DETAILS
                                    </p>

                                    <h2>
                                        Reservation
                                        #<%= selectedReservation.getReservationId() %>
                                    </h2>

                                </div>


                                <div class="lookup-status">

                                    <span>
                                        Status
                                    </span>

                                    <strong>
                                        <%= selectedReservation.getStatus() %>
                                    </strong>

                                </div>


                            </div>


                            <div class="lookup-details-grid">


                                <div class="lookup-detail">

                                    <span class="lookup-detail-label">
                                        Customer Email
                                    </span>

                                    <strong>
                                        <%= selectedReservation.getCustomerEmail() %>
                                    </strong>

                                </div>


                                <div class="lookup-detail">

                                    <span class="lookup-detail-label">
                                        Boat Name
                                    </span>

                                    <strong>
                                        <%= selectedReservation.getBoatName() %>
                                    </strong>

                                </div>


                                <div class="lookup-detail">

                                    <span class="lookup-detail-label">
                                        Boat Length
                                    </span>

                                    <strong>

                                        <%= String.format(
                                                "%.1f",
                                                selectedReservation.getBoatLength()
                                        ) %> ft

                                    </strong>

                                </div>


                                <div class="lookup-detail">

                                    <span class="lookup-detail-label">
                                        Slip Number
                                    </span>

                                    <strong>
                                        <%= selectedReservation.getSlipNumber() %>
                                    </strong>

                                </div>


                                <div class="lookup-detail">

                                    <span class="lookup-detail-label">
                                        Slip Size
                                    </span>

                                    <strong>
                                        <%= selectedReservation.getSlipSizeFeet() %> ft
                                    </strong>

                                </div>


                                <div class="lookup-detail">

                                    <span class="lookup-detail-label">
                                        Check-In Date
                                    </span>

                                    <strong>
                                        <%= selectedReservation.getCheckInDate() %>
                                    </strong>

                                </div>


                                <div class="lookup-detail">

                                    <span class="lookup-detail-label">
                                        Check-Out Date
                                    </span>

                                    <strong>
                                        <%= selectedReservation.getCheckOutDate() %>
                                    </strong>

                                </div>


                                <div class="lookup-detail">

                                    <span class="lookup-detail-label">
                                        Reservation Status
                                    </span>

                                    <strong>
                                        <%= selectedReservation.getStatus() %>
                                    </strong>

                                </div>


                            </div>


                            <div class="lookup-price-box">

                                <span>
                                    Monthly Reservation Cost
                                </span>

                                <strong>

                                    $<%= String.format(
                                            "%.2f",
                                            selectedReservation
                                                .getMonthlyCost()
                                                .doubleValue()
                                    ) %>

                                </strong>

                            </div>


                        </div>


                    <% } %>


                    <!-- =================================================
                         MANUAL LOOKUP
                         ================================================= -->

                    <div class="manual-lookup-section">


                        <div class="lookup-card">


                            <p class="lookup-card-label">
                                MANUAL LOOKUP
                            </p>

                            <h2>
                                Not Seeing Your Reservation?
                            </h2>

                            <p class="lookup-description">

                                If you have a reservation number
                                that is not shown above, enter it below.

                            </p>


                            <% if (lookupError != null) { %>

                                <div class="lookup-error">

                                    <%= lookupError %>

                                </div>

                            <% } %>


                            <form
                                class="lookup-form"
                                action="${pageContext.request.contextPath}/reservationLookup"
                                method="POST">


                                <div class="lookup-field">


                                    <label for="reservationId">

                                        Reservation Number

                                    </label>


                                    <input
                                        class="lookup-input"
                                        type="number"
                                        id="reservationId"
                                        name="reservationId"
                                        min="1"
                                        step="1"
                                        required
                                        placeholder="Enter reservation number">


                                    <small>

                                        Enter the reservation confirmation
                                        number you received when booking.

                                    </small>


                                </div>


                                <button
                                    type="submit"
                                    class="lookup-button">

                                    Look Up Reservation

                                </button>


                            </form>


                        </div>


                    </div>


                <% } %>


            </div>

        </section>


    </main>


    <%@ include file="includes/footer.jsp" %>


</body>

</html>