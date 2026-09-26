<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.moffatbay.dao.ReservationDAO" %>

<%
    ReservationDAO reservationDAO = new ReservationDAO();

    int smallWaitlist = 0;
    int mediumWaitlist = 0;
    int largeWaitlist = 0;

    try {
        smallWaitlist = reservationDAO.getWaitListCount(1);
        mediumWaitlist = reservationDAO.getWaitListCount(2);
        largeWaitlist = reservationDAO.getWaitListCount(3);
    } catch (Exception e) {
        e.printStackTrace();
    }
%>

<!DOCTYPE html>
<html lang="en">
<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>Waitlist Lookup | Moffat Bay Marina</title>

    <meta name="description"
          content="View the current waitlist for Moffat Bay Marina slips.">

    <meta name="author"
          content="CSD460-340 | Group C">

    <link rel="preconnect"
          href="https://fonts.googleapis.com">
          
    <link rel="preconnect"
          href="https://fonts.gstatic.com"
          crossorigin>

    <link href="https://fonts.googleapis.com/css2?family=Inika:wght@400;700&family=Mulish:wght@400;500;600;700&display=swap"
          rel="stylesheet">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/styles.css">

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/waiting_list.css">

</head>

<body>

    <%@ include file="includes/header.jsp" %>

    <main class="waitlist-page">
        <section class="waitlist-hero">
            <div class="waitlist-container">
                <p class="waitlist-eyebrow">MOFFAT BAY MARINA</p>
                <h1>Waitlist Lookup</h1>
                <p class="waitlist-intro">
                    View the current number of customers waiting
                    for each available slip size.
                </p>
            </div>
        </section>

        <section class="waitlist-section">
            <div class="waitlist-container">
                <div class="waitlist-grid">
                
                	<!-- Small Slip -->
                    <article class="waitlist-card">
                        <p class="waitlist-label">SMALL SLIPS</p>
                        <h2>26 ft</h2>
                        <div class="waitlist-count">
                        	<%= smallWaitlist %>
                        </div>
                        <p class="waitlist-status">
                            <%= smallWaitlist == 1
                                    ? "Customer waiting"
                                    : "Customers Waiting" %>
                        </p>
                    </article>

                    <!-- Medium Slip -->
                    <article class="waitlist-card">
                        <p class="waitlist-label">MEDIUM SLIPS</p>
                        <h2>40 ft</h2>
                        <div class="waitlist-count">
                            <%= mediumWaitlist %>
                        </div>
                        <p class="waitlist-status">
                            <%= mediumWaitlist == 1
                                    ? "Customer Waiting"
                                    : "Customers Waiting" %>
                        </p>
                    </article>

                    <!-- Large Slip -->
                    <article class="waitlist-card">
                        <p class="waitlist-label">LARGE SLIPS</p>
                        <h2>50 ft</h2>
                        <div class="waitlist-count">
                            <%= largeWaitlist %>
                        </div>
                        <p class="waitlist-status">
                            <%= largeWaitlist == 1
                                    ? "Customer Waiting"
                                    : "Customers Waiting" %>
                        </p>
                    </article>
                </div>
                
                <div class="waitlist-content">
                	<p>Wait-list totals are displayed without customer information to protect customer privacy</p>
                </div>
            </div>
        </section>
    </main>

    <%@ include file="includes/footer.jsp" %>

</body>
</html>