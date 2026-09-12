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

    <link rel="stylesheet"
          href="${pageContext.request.contextPath}/css/login_page.css">

</head>


<!-----------------------------------------------------
-----LOGIN FORM----->

<body>

<%@ include file="includes/header.jsp" %>

<main class="login-page">

    <section class="login-form-wrapper">

        <div class="login-card">

            <h1>Account Log In</h1>

            <form action="${pageContext.request.contextPath}/login"
                  method="POST"
                  class="login-form">

                <p class="card-description">
                    Enter your email and password below to access your account
                </p>


                <%-- Login error returned by LoginServlet --%>

                <%
                    String loginError =
                            (String) request.getAttribute("loginError");

                    if (loginError != null) {
                %>

                <div class="login-error">

                    <strong>Login Failed</strong>

                    <p>
                        <%= loginError %>
                    </p>

                </div>

                <%
                    }
                %>


                <div class="form-group full-width">

                    <label for="email">

                        <h3>Username</h3>

                    </label>

                    <input
                        type="email"
                        id="email"
                        name="email"
                        maxlength="255"
                        placeholder="username@email.com"
                        required>

                </div>


                <div class="form-group full-width">

                    <label for="password">

                        <h3>Password</h3>

                    </label>

                    <input
                        type="password"
                        id="password"
                        name="password"
                        minlength="8"
                        maxlength="100"
                        title="Password must be at least 8 characters and contain at least one uppercase and one lowercase letter."
                        placeholder="Password"
                        required>

                </div>


                <div class="full-width">

                    <button type="submit"
                            class="sign-button login-submit-button">

                        Sign In

                    </button>

                </div>


                <div class="signup-link">

                    Don't have an account yet? <br><br>

                    <a href="register.jsp">
                        Register your free account here.
                    </a>

                </div>

            </form>

        </div>

    </section>

</main>

<%@ include file="includes/footer.jsp" %>

</body>

</html>