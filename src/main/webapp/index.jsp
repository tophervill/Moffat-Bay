<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
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
	<link rel="stylesheet" href="styles.css">
</head>
<body>
<header>
	<!--  Navigation Bar -->
	<nav class="navbar">
		<div class="nav-start">Moffat Bay Marina</div>
		<div class="nav-middle mobile-hidden">
			<a href="#" class="active">Home</a>
			<a href="#">Attractions</a>
			<a href="#">About Us</a>
			<a href="#">Contact Us</a>
		</div>
		<div class="nav-end mobile-hidden">
			<a href="#">Check Reservation</a>
			<a href="#">Account</a>
		</div>
	</nav>
</header>
<main>
	<!-- Hero Section -->
	<div class="hero">
		<div class="hero-left">
			<p id="welcoming-text">Welcome to</p>
			<h1>Moffat Bay Marina</h1>
			<p id="short-text">Whether you are staying for a weekend getaway or a full season, reserve your boat slip
				online with ease and prepare for your next coastal adventure.</p>
			<div class="check-availability-form">
				<h4>Check Availability</h4>
				<form>
					<div class="form-row">
						<div class="form-group">
							<label for="arrivalDate">Arrival Date:</label>
							<input type="date" id="arrivalDate" name="arrivalDate" required>
						</div>
						<div class="form-group">
							<label for="departureDate">Departure Date:</label>
							<input type="date" id="departureDate" name="departureDate" required>
						</div>
						<div class="form-group">
							<label for="vesselLength">Vessel Length:</label>
							<input type="number" id="vesselLength" name="vesselLength" step="0.1" required>
						</div>
					</div>
					<div class="form-row">
						<input type="submit" value="Search Available Slips">
					</div>
				</form>
			</div>
		</div>
		<div class="hero-right"></div>
	</div>

	<!-- Pricing Section -->
	<div class="pricing">
		<h2>Check Out Our Pricing</h2>
		<div class="pricing-cards">
			<div class="card">
				<h3>Small Ship</h3>
				<p class="size-text">Up to 26ft.</p>
				<ul class="card-list-desc">
					<li>$10 per foot</li>
					<li>$10 service fee (Electrical)</li>
					<li>Estimated Costs: <span>Up to $270 at 26 Feet</span></li>
				</ul>
			</div>
			<div class="card">
				<h3>Medium Ship</h3>
				<p class="size-text">Up to 40ft.</p>
				<ul class="card-list-desc">
					<li>$10 per foot</li>
					<li>$10 service fee (Electrical)</li>
					<li>Estimated Costs: <span>Up to $410 at 40 Feet</span></li>
				</ul>
			</div>
			<div class="card">
				<h3>Small Ship</h3>
				<p class="size-text">Up to 50ft.</p>
				<ul class="card-list-desc">
					<li>$10 per foot</li>
					<li>$10 service fee (Electrical)</li>
					<li>Estimated Costs: <span>Up to $510 at 50 Feet</span></li>
				</ul>
			</div>
		</div>
	</div>

	<div class="reviews">
		<h2>See What Our Customers Say</h2>
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
			<p class="review-author">- James Corleone</p>
			<p class="review-date">August 23, 2026</p>
		</div>
	</div>
</main>
<footer>
	<div class="footer-wrapper">
		<div class="footer-text">
			<h4>Moffat Bay Marina</h4>
			<p>Serving the Marina of Joviedsa Island located in the State of Washington.</p>
		</div>
		<div class="footer-nav">
			<ul>
				<li><a href="#">Attractions</a></li>
				<li><a href="#">Reservations</a></li>
				<li><a href="#">Wait List</a></li>
				<li><a href="#">About Us</a></li>
				<li><a href="#">Contact Us</a></li>
				<li><a href="#">Account</a></li>
			</ul>
		</div>
	</div>
	<hr>
	<p>&copy; 2026 - Moffat Bay Marina <br/><span id="team">Created By: Group C - CSD460</span></p>
</footer>
</body>
</html>