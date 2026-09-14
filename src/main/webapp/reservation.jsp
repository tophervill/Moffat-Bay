<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.moffatbay.dao.ReservationDAO.BoatInfo" %>
<%@ page import="com.moffatbay.util.PricingUtil" %>
<%@ page import="java.time.LocalDate" %>

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

    BoatInfo boat =
            (BoatInfo) request.getAttribute("boat");

    String reservationError =
            (String) request.getAttribute(
                    "reservationError"
            );

    Boolean noAvailability =
            (Boolean) request.getAttribute(
                    "noAvailability"
            );

    Integer requiredSlipSize =
            (Integer) request.getAttribute(
                    "requiredSlipSize"
            );

    Integer slipSizeId =
            (Integer) request.getAttribute(
                    "slipSizeId"
            );

    LocalDate selectedCheckIn =
            (LocalDate) request.getAttribute(
                    "checkInDate"
            );

    LocalDate selectedCheckOut =
            (LocalDate) request.getAttribute(
                    "checkOutDate"
            );

    Integer calculatedSlipSize = null;

    if (boat != null) {

        calculatedSlipSize =
                PricingUtil.getRequiredSlipSize(
                        boat.getBoatLength()
                );
    }
%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Slip Reservation | Moffat Bay Marina</title>

    <meta name="description"
          content="Reserve a long-term boat slip at Moffat Bay Marina.">

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

    <!-- Reservation page styles -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/reservation.css">

</head>

<body>

<%@ include file="includes/header.jsp" %>


<main class="reservation-page">

    <section class="reservation-card">

        <div class="reservation-heading">

            <p class="reservation-eyebrow">
                Moffat Bay Marina
            </p>

            <h1>
                Reserve a Slip
            </h1>

            <p class="reservation-description">
                Select your reservation dates below.
                Your registered boat information will be used
                to determine the correct slip size and monthly rate.
                Moffat Bay Marina offers long-term slips
                in 26-foot, 40-foot, and 50-foot sizes.
            </p>

        </div>


        <% if (reservationError != null) { %>

            <div class="reservation-message error-message">

                <strong>
                    Reservation Notice
                </strong>

                <p>
                    <%= reservationError %>
                </p>

            </div>

        <% } %>


        <% if (boat != null) { %>

            <div class="boat-information">

                <h2>
                    Your Boat
                </h2>

                <div class="boat-information-grid">

                    <div class="boat-information-item">

                        <span class="information-label">
                            Boat Name
                        </span>

                        <span class="information-value">
                            <%= boat.getBoatName() %>
                        </span>

                    </div>


                    <div class="boat-information-item">

                        <span class="information-label">
                            Boat Length
                        </span>

                        <span class="information-value">
                            <%= boat.getBoatLength() %> ft.
                        </span>

                    </div>

                </div>

            </div>


            <% if (Boolean.TRUE.equals(noAvailability)) { %>

                <div class="waitlist-card">

                    <h2>
                        No Slip Currently Available
                    </h2>

                    <p>
                        There are no
                        <strong><%= requiredSlipSize %>-foot slips</strong>
                        available for your selected dates.
                    </p>

                    <p>
                        Would you like to join the wait list
                        for this slip category?
                    </p>


                    <div class="waitlist-date-summary">

                        <div>

                            <span class="information-label">
                                Requested Check-In
                            </span>

                            <span class="information-value">
                                <%= selectedCheckIn %>
                            </span>

                        </div>


                        <div>

                            <span class="information-label">
                                Requested Check-Out
                            </span>

                            <span class="information-value">
                                <%= selectedCheckOut %>
                            </span>

                        </div>

                    </div>


                    <form
                        action="${pageContext.request.contextPath}/waitlist"
                        method="POST">

                        <input
                            type="hidden"
                            name="boatId"
                            value="<%= boat.getBoatId() %>">

                        <input
                            type="hidden"
                            name="slipSizeId"
                            value="<%= slipSizeId %>">

                        <input
                            type="hidden"
                            name="checkInDate"
                            value="<%= selectedCheckIn %>">

                        <div class="reservation-actions">

                            <button
                                type="submit"
                                class="reservation-button primary-button">

                                Join Wait List

                            </button>


                            <a
                                class="reservation-button secondary-button"
                                href="${pageContext.request.contextPath}/reservation">

                                Try Different Dates

                            </a>

                        </div>

                    </form>

                </div>


            <% } else { %>

                <form
                    action="${pageContext.request.contextPath}/reservation"
                    method="POST"
                    class="reservation-form">


                    <div class="reservation-form-grid">

                        <div class="reservation-form-group">

                            <label for="checkInDate">
                                Check-In Date
                            </label>

                            <input
                                type="date"
                                id="checkInDate"
                                name="checkInDate"
                                min="<%= LocalDate.now() %>"
                                required>

                        </div>


                        <div class="reservation-form-group">

                            <label for="checkOutDate">
                                Check-Out Date
                            </label>

                            <input
                                type="date"
                                id="checkOutDate"
                                name="checkOutDate"
                                min="<%= LocalDate.now().plusDays(1) %>"
                                required>

                        </div>

                    </div>


                    <div class="reservation-actions reservation-check-actions">

                        <div class="slip-requirement">

                            Based on your saved boat length of
                            <strong><%= boat.getBoatLength() %> ft.</strong>,
                            your boat requires a
                            <strong><%= calculatedSlipSize %>-foot slip.</strong>

                        </div>


                        <button
                            type="submit"
                            class="reservation-button primary-button">

                            Check Slip Availability

                        </button>

                    </div>

                </form>

            <% } %>


        <% } else { %>

            <div class="reservation-message error-message">

                <strong>
                    Boat Information Unavailable
                </strong>

                <p>
                    We could not find boat information
                    associated with your account.
                </p>

            </div>

        <% } %>

    </section>

</main>


<%@ include file="includes/footer.jsp" %>

</body>

</html>