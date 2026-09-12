<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!DOCTYPE html>

<html>

<head>

	<!-- 
	CSD460 - Group C
	Moffat Bay Marina Project
	-->

	<meta charset="UTF-8">

	<meta name="viewport" content="width=device-width, initial-scale=1.0">

	<title>Moffat Bay Marina</title>

	<!--  Meta Tags -->

	<meta name="description"
		  content="Moffat Bay Marina - Your gateway to coastal adventures. Reserve your boat slip online and explore the beauty of Joviedsa Island.">

	<meta name="author" content="CSD460-340A | Group C">

	<meta name="keywords"
		  content="Moffat Bay Marina, Boat Slip Reservation, Joviedsa Island, Coastal Adventures, Marina Services">

	<!--  Fonts -->

	<link rel="preconnect" href="https://fonts.googleapis.com">

	<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>

	<link href="https://fonts.googleapis.com/css2?family=Inika:wght@400;700&family=Mulish:ital,wght@0,200..1000;1,200..1000&display=swap"
		  rel="stylesheet">

	<script src="https://kit.fontawesome.com/d9a1097e3c.js" crossorigin="anonymous"></script>

	<!--  Stylesheets -->

	<link rel="stylesheet" href="css/landingpage.css">

</head>

<body>

<%@ include file="includes/header.jsp" %>

<main>

	<!-- Hero Section -->

	<div class="hero">

		<div class="hero-left">

			<div class="hero-left-wrapper">

				<p id="welcoming-text">Welcome to</p>

				<h1>Moffat Bay Marina</h1>

				<p id="short-text">
					Whether you are staying for a weekend getaway or a full season,
					reserve your boat slip online with ease and prepare for your next
					coastal adventure.
				</p>

				<div class="check-availability-form">

					<form action="${pageContext.request.contextPath}/reservation"
						  method="GET">

						<div class="form-row">

							<input
								type="submit"
								value="Login to Reserve an Available Slip">

						</div>

					</form>

				</div>

			</div>

		</div>

		<div class="hero-right"></div>

	</div>


	<!-- Pricing Section -->

	<div class="pricing">

		<h2>Check Out Our Pricing</h2>

		<div class="pricing-cards">

			<div class="card">

				<h3>Small Slip</h3>

				<p class="size-text">
					Boats up to 26 ft.
				</p>

				<ul class="card-list-desc">

					<li>
						$10.50 per boat foot
					</li>

					<li>
						$10 service fee (Electrical)
					</li>

					<li>
						Estimated Costs:
						<span>
							Up to $283.00 at 26 Feet
						</span>
					</li>

				</ul>

			</div>


			<div class="card">

				<h3>Medium Slip</h3>

				<p class="size-text">
					Boats over 26 ft. and up to 40 ft.
				</p>

				<ul class="card-list-desc">

					<li>
						$10.50 per boat foot
					</li>

					<li>
						$10 service fee (Electrical)
					</li>

					<li>
						Estimated Costs:
						<span>
							Up to $430.00 at 40 Feet
						</span>
					</li>

				</ul>

			</div>


			<div class="card">

				<h3>Large Slip</h3>

				<p class="size-text">
					Boats over 40 ft. and up to 50 ft.
				</p>

				<ul class="card-list-desc">

					<li>
						$10.50 per boat foot
					</li>

					<li>
						$10 service fee (Electrical)
					</li>

					<li>
						Estimated Costs:
						<span>
							Up to $535.00 at 50 Feet
						</span>
					</li>

				</ul>

			</div>

		</div>

	</div>


	<div class="reviews">

		<h2>See What Our Customers Say</h2>

		<div class="review-row">

			<div class="review-card">

				<div class="review-rating">

					<i class="fa-solid fa-star fa-lg" style="color: #1A7073;"></i>

					<i class="fa-solid fa-star fa-lg" style="color: #1A7073;"></i>

					<i class="fa-solid fa-star fa-lg" style="color: #1A7073;"></i>

					<i class="fa-solid fa-star fa-lg" style="color: #1A7073;"></i>

					<i class="fa-solid fa-star fa-lg" style="color: #1A7073;"></i>

				</div>

				<blockquote class="review-message">

					"Moffat Bay Marina is simply the finest marina I've docked at along the coast. The staff anticipated every need before I could ask."

				</blockquote>

				<p class="review-author">
					- James Corleone
				</p>

				<p class="review-date">
					August 23, 2026
				</p>

			</div>


			<div class="review-card">

				<div class="review-rating">

					<i class="fa-solid fa-star fa-lg" style="color: #1A7073;"></i>

					<i class="fa-solid fa-star fa-lg" style="color: #1A7073;"></i>

					<i class="fa-solid fa-star fa-lg" style="color: #1A7073;"></i>

					<i class="fa-solid fa-star fa-lg" style="color: #1A7073;"></i>

					<i class="fa-solid fa-star fa-lg" style="color: #1A7073;"></i>

				</div>

				<blockquote class="review-message">

					"Great marina with excellent amenities. The online reservation system made it easy to secure a slip for my boat."

				</blockquote>

				<p class="review-author">
					- Sarah Johnson
				</p>

				<p class="review-date">
					September 7, 2026
				</p>

			</div>

		</div>

	</div>

</main>


<footer>

	<div class="footer-wrapper">

		<div class="column" id="footer-text">

			<div class="footer-text">

				<h4>Moffat Bay Marina</h4>

				<p>
					Serving the Marina of Joviedsa Island located
					in the State of Washington.
				</p>

			</div>

		</div>


		<div class="column" id="navigate">

			<a href="#">
				Attractions
			</a>

			<a href="#">
				Reservations
			</a>

			<a href="#">
				Wait List
			</a>

		</div>


		<div class="column" id="info">

			<a href="#">
				About Us
			</a>

			<a href="#">
				Contact Us
			</a>

			<a href="#">
				Account
			</a>

		</div>


		<div class="column" id="contact">

			<a href="mailto:MoffatBayMarina@email.com">
				MoffatBayMarina@email.com
			</a>

			<a href="tel:15555555555">
				+1 (555) 555 - 5555
			</a>

			<a href="https://wa.gov/" target="_blank">
				Joviesda Island, Washington
			</a>

		</div>

	</div>

	<hr>

	<p>&copy; 2026 - Moffat Bay Marina></p>

</footer>

</body>

</html>