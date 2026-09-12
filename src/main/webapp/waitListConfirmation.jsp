<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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


    Integer lastWaitListId =
            (Integer) session.getAttribute(
                    "lastWaitListId"
            );

    String lastWaitListBoatName =
            (String) session.getAttribute(
                    "lastWaitListBoatName"
            );

    Double lastWaitListBoatLength =
            (Double) session.getAttribute(
                    "lastWaitListBoatLength"
            );

    Integer lastWaitListSlipSize =
            (Integer) session.getAttribute(
                    "lastWaitListSlipSize"
            );

    LocalDate lastWaitListCheckInDate =
            (LocalDate) session.getAttribute(
                    "lastWaitListCheckInDate"
            );


    boolean waitListReady =
            lastWaitListId != null
            && lastWaitListBoatName != null
            && lastWaitListBoatLength != null
            && lastWaitListSlipSize != null
            && lastWaitListCheckInDate != null;
%>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        Wait List Confirmation | Moffat Bay Marina
    </title>

    <meta name="description"
          content="Moffat Bay Marina wait list confirmation.">

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

    <!-- Wait List Confirmation styles -->
    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/waitlist_confirmation.css">

</head>

<body>

<%@ include file="includes/header.jsp" %>


<main class="waitlist-confirmation-page">

    <section class="waitlist-confirmation-card">


        <% if (waitListReady) { %>


            <div class="waitlist-confirmation-heading">

                <p class="waitlist-confirmation-eyebrow">
                    Moffat Bay Marina
                </p>

                <h1>
                    Wait List Confirmed
                </h1>

                <p class="waitlist-confirmation-description">
                    Your boat has been added to the wait list
                    for the required slip category.
                </p>

            </div>


            <div class="waitlist-number">

                <span class="waitlist-number-label">
                    Wait List Number
                </span>

                <span class="waitlist-number-value">
                    #<%= lastWaitListId %>
                </span>

            </div>


            <div class="waitlist-confirmation-section">

                <h2>
                    Boat Information
                </h2>

                <div class="waitlist-confirmation-grid">

                    <div class="waitlist-confirmation-item">

                        <span class="waitlist-confirmation-label">
                            Boat Name
                        </span>

                        <span class="waitlist-confirmation-value">
                            <%= lastWaitListBoatName %>
                        </span>

                    </div>


                    <div class="waitlist-confirmation-item">

                        <span class="waitlist-confirmation-label">
                            Boat Length
                        </span>

                        <span class="waitlist-confirmation-value">
                            <%= lastWaitListBoatLength %> ft.
                        </span>

                    </div>

                </div>

            </div>


            <div class="waitlist-confirmation-section">

                <h2>
                    Wait List Information
                </h2>

                <div class="waitlist-confirmation-grid">

                    <div class="waitlist-confirmation-item">

                        <span class="waitlist-confirmation-label">
                            Required Slip Size
                        </span>

                        <span class="waitlist-confirmation-value">
                            <%= lastWaitListSlipSize %>-foot slip
                        </span>

                    </div>


                    <div class="waitlist-confirmation-item">

                        <span class="waitlist-confirmation-label">
                            Requested Check-In
                        </span>

                        <span class="waitlist-confirmation-value">
                            <%= lastWaitListCheckInDate %>
                        </span>

                    </div>

                </div>

            </div>


            <div class="waitlist-message">

                <strong>
                    You are now on the wait list.
                </strong>

                <p>
                    Your wait-list request will remain active
                    until it is updated or removed.
                </p>

            </div>


            <div class="waitlist-confirmation-actions">

                <a
                    class="waitlist-confirmation-button"
                    href="${pageContext.request.contextPath}/index.jsp">

                    Return to Home

                </a>

            </div>


        <% } else { %>


            <div class="waitlist-confirmation-error">

                <strong>
                    Wait List Information Unavailable
                </strong>

                <p>
                    We could not find a recent wait-list request.
                    Please return to the reservation page.
                </p>

                <a
                    class="waitlist-confirmation-button"
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