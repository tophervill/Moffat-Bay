<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.moffatbay.dao.ReservationDAO" %>
<%@ page import="com.moffatbay.dao.ReservationDAO.ReservationInfo" %>

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


    Integer lastReservationId =
            (Integer) session.getAttribute(
                    "lastReservationId"
            );

    ReservationInfo reservation = null;
    String confirmationError = null;


    if (lastReservationId != null) {

        try {

            ReservationDAO reservationDAO =
                    new ReservationDAO();

            reservation =
                    reservationDAO.getReservation(
                            lastReservationId,
                            loggedInCustomerId
                    );

        } catch (Exception e) {

            e.printStackTrace();

            confirmationError =
                    "Your reservation was created, but the "
                    + "confirmation details could not be loaded.";
        }

    } else {

        confirmationError =
                "No recently confirmed reservation was found.";
    }
%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        Reservation Confirmed | Moffat Bay Marina
    </title>

    <meta name="description"
          content="Moffat Bay Marina reservation confirmation.">

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

    <!-- Reservation Confirmation styles -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/reservation_confirmation.css">

</head>

<body>

<%@ include file="includes/header.jsp" %>


<main class="confirmation-page">

    <section class="confirmation-card">


        <% if (reservation != null) { %>


            <div class="confirmation-heading">

                <p class="confirmation-eyebrow">
                    Moffat Bay Marina
                </p>

                <h1>
                    Reservation Confirmed
                </h1>

                <p class="confirmation-description">
                    Your slip reservation has been successfully confirmed.
                    Please keep your reservation number for your records.
                </p>

            </div>


            <div class="confirmation-number">

                <span class="confirmation-number-label">
                    Reservation Number
                </span>

                <span class="confirmation-number-value">
                    #<%= reservation.getReservationId() %>
                </span>

            </div>


            <div class="confirmation-section">

                <h2>
                    Boat Information
                </h2>

                <div class="confirmation-grid">

                    <div class="confirmation-item">

                        <span class="confirmation-label">
                            Boat Name
                        </span>

                        <span class="confirmation-value">
                            <%= reservation.getBoatName() %>
                        </span>

                    </div>


                    <div class="confirmation-item">

                        <span class="confirmation-label">
                            Boat Length
                        </span>

                        <span class="confirmation-value">
                            <%= reservation.getBoatLength() %> ft.
                        </span>

                    </div>

                </div>

            </div>


            <div class="confirmation-section">

                <h2>
                    Slip Information
                </h2>

                <div class="confirmation-grid">

                    <div class="confirmation-item">

                        <span class="confirmation-label">
                            Slip Number
                        </span>

                        <span class="confirmation-value">
                            <%= reservation.getSlipNumber() %>
                        </span>

                    </div>


                    <div class="confirmation-item">

                        <span class="confirmation-label">
                            Slip Size
                        </span>

                        <span class="confirmation-value">
                            <%= reservation.getSlipSizeFeet() %>-foot slip
                        </span>

                    </div>

                </div>

            </div>


            <div class="confirmation-section">

                <h2>
                    Reservation Dates
                </h2>

                <div class="confirmation-grid">

                    <div class="confirmation-item">

                        <span class="confirmation-label">
                            Check-In Date
                        </span>

                        <span class="confirmation-value">
                            <%= reservation.getCheckInDate() %>
                        </span>

                    </div>


                    <div class="confirmation-item">

                        <span class="confirmation-label">
                            Check-Out Date
                        </span>

                        <span class="confirmation-value">
                            <%= reservation.getCheckOutDate() %>
                        </span>

                    </div>

                </div>

            </div>


            <div class="confirmation-cost">

                <span class="confirmation-cost-label">
                    Monthly Cost
                </span>

                <span class="confirmation-cost-value">
                    $<%= reservation.getMonthlyCost() %>
                </span>

            </div>


            <div class="confirmation-actions">

                <a
                    class="confirmation-button"
                    href="${pageContext.request.contextPath}/index.jsp">

                    Return to Home

                </a>

            </div>


        <% } else { %>


            <div class="confirmation-error">

                <strong>
                    Confirmation Details Unavailable
                </strong>

                <p>
                    <%= confirmationError %>
                </p>

                <a
                    class="confirmation-button"
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