<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        Registration Successful | Moffat Bay Marina
    </title>

    <meta name="description"
          content="Your Moffat Bay Marina account has been created successfully.">

    <meta name="author"
          content="CSD460-340A | Group C">


    <!-- Shared Fonts -->

    <link rel="preconnect"
          href="https://fonts.googleapis.com">

    <link rel="preconnect"
          href="https://fonts.gstatic.com"
          crossorigin>

    <link href="https://fonts.googleapis.com/css2?family=Inika:wght@400;700&family=Mulish:ital,wght@0,200..1000;1,200..1000&display=swap"
          rel="stylesheet">


    <!-- Shared Stylesheet -->

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/styles.css">

</head>


<body>


    <%@ include file="includes/header.jsp" %>


    <main class="confirmation-page">


        <section class="confirmation-card">


            <div class="confirmation-icon">
                ✓
            </div>


            <p class="confirmation-eyebrow">
                ACCOUNT CREATED
            </p>


            <h1>
                Registration Successful!
            </h1>


            <p class="confirmation-message">

                Your Moffat Bay Marina account has been
                created successfully.

            </p>


            <p class="confirmation-details">

                You can now log in using the email address
                and password you provided during registration.

            </p>


            <div class="confirmation-divider"></div>


            <div class="confirmation-actions">

                <a class="primary-button confirmation-login-button"
                   href="${pageContext.request.contextPath}/Login_Page.jsp">

                    Go to Login

                </a>

            </div>


            <p class="confirmation-note">

                Thank you for choosing Moffat Bay Marina.

            </p>


        </section>


    </main>


    <%@ include file="includes/footer.jsp" %>


</body>

</html>