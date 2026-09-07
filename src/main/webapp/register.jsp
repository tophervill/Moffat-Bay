<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>

<html lang="en">

<head>

    <meta charset="UTF-8">

    <meta name="viewport"
          content="width=device-width, initial-scale=1.0">

    <title>
        Register | Moffat Bay Marina
    </title>


    <meta name="description"
          content="Create a Moffat Bay Marina account and register your boat.">

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


    <main class="registration-page">


        <!-- =================================================
             REGISTRATION INFORMATION
             ================================================= -->

        <section class="registration-intro">


            <p class="registration-eyebrow">
                JOIN MOFFAT BAY MARINA
            </p>


            <h1>
                Create Your Account
            </h1>


            <p>
                Create a free account to reserve a long-term boat
                slip and manage your reservation at Moffat Bay Marina.
            </p>


            <div class="registration-info">

                <h2>
                    Why create an account?
                </h2>


                <ul>

                    <li>
                        Reserve an available marina slip
                    </li>

                    <li>
                        Look up your existing reservation
                    </li>

                    <li>
                        Join a wait list when your required
                        slip size is unavailable
                    </li>

                    <li>
                        Access your account using your email address
                    </li>

                </ul>

            </div>


            <div class="slip-reminder">

                <strong>
                    Long-term slip sizes:
                </strong>

                <span>
                    26 ft
                </span>

                <span>
                    40 ft
                </span>

                <span>
                    50 ft
                </span>

            </div>


        </section>



        <!-- =================================================
             REGISTRATION FORM
             ================================================= -->

        <section class="registration-form-wrapper">


            <div class="registration-card">


                <h2>
                    Account Registration
                </h2>


                <p class="card-description">
                    Enter your customer and boat information below.
                </p>



                <!-- =========================================
                     REGISTRATION ERROR
                     ========================================= -->

                <%
                    String registrationErrorTitle =
                            (String) request.getAttribute(
                                    "registrationErrorTitle"
                            );

                    String registrationError =
                            (String) request.getAttribute(
                                    "registrationError"
                            );
                %>


                <% if (registrationError != null) { %>


                    <div class="registration-error">


                        <div class="registration-error-icon">
                            !
                        </div>


                        <div class="registration-error-content">


                            <div class="registration-error-title">

                                <%= registrationErrorTitle %>

                            </div>


                            <div class="registration-error-message">

                                <%= registrationError %>

                            </div>


                        </div>


                    </div>


                <% } %>



                <!-- =========================================
                     REGISTRATION FORM
                     ========================================= -->

                <form
                    action="${pageContext.request.contextPath}/register"
                    method="post"
                    class="registration-form">


                    <!-- EMAIL -->

                    <div class="form-group full-width">

                        <label for="email">
                            Email Address
                        </label>

                        <input
                            type="email"
                            id="email"
                            name="email"
                            maxlength="100"
                            placeholder="name@example.com"
                            required>

                        <small>
                            Your email address will be your username.
                        </small>

                    </div>


                    <!-- FIRST NAME -->

                    <div class="form-group">

                        <label for="firstName">
                            First Name
                        </label>

                        <input
                            type="text"
                            id="firstName"
                            name="firstName"
                            maxlength="50"
                            required>

                    </div>


                    <!-- LAST NAME -->

                    <div class="form-group">

                        <label for="lastName">
                            Last Name
                        </label>

                        <input
                            type="text"
                            id="lastName"
                            name="lastName"
                            maxlength="50"
                            required>

                    </div>


                    <!-- TELEPHONE -->

                    <div class="form-group full-width">

                        <label for="telephone">
                            Telephone
                        </label>

                        <input
                            type="tel"
                            id="telephone"
                            name="telephone"
                            maxlength="20"
                            placeholder="555-555-5555"
                            required>

                    </div>


                    <!-- BOAT NAME -->

                    <div class="form-group">

                        <label for="boatName">
                            Boat Name
                        </label>

                        <input
                            type="text"
                            id="boatName"
                            name="boatName"
                            maxlength="100"
                            required>

                    </div>


                    <!-- BOAT LENGTH -->

                    <div class="form-group">

                        <label for="boatLength">
                            Boat Length (ft)
                        </label>

                        <input
                            type="number"
                            id="boatLength"
                            name="boatLength"
                            min="1"
                            step="0.01"
                            placeholder="Example: 34"
                            required>

                    </div>


                    <!-- PASSWORD -->

                    <div class="form-group full-width">

                        <label for="password">
                            Password
                        </label>

                        <input
                            type="password"
                            id="password"
                            name="password"
                            minlength="8"
                            pattern="(?=.*[a-z])(?=.*[A-Z]).{8,}"
                            title="Password must be at least 8 characters and contain at least one uppercase and one lowercase letter."
                            required>

                        <small>
                            Minimum 8 characters with at least one
                            uppercase and one lowercase letter.
                        </small>

                    </div>


                    <!-- CONFIRM PASSWORD -->

                    <div class="form-group full-width">

                        <label for="confirmPassword">
                            Confirm Password
                        </label>

                        <input
                            type="password"
                            id="confirmPassword"
                            name="confirmPassword"
                            minlength="8"
                            required>

                    </div>


                    <!-- CREATE ACCOUNT BUTTON -->

                    <div class="full-width">

                        <button
                            type="submit"
                            class="primary-button registration-submit-button">

                            Create Account

                        </button>

                    </div>


                </form>



                <!-- =========================================
                     LOGIN LINK
                     ========================================= -->

                <div class="login-link">

                    Already have an account?

                    <a href="Login_Page.jsp">
                        Log In
                    </a>

                </div>


            </div>


        </section>


    </main>


    <%@ include file="includes/footer.jsp" %>


</body>

</html>