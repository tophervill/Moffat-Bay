# Moffat Bay Marina

Moffat Bay Webpage - CSD-460 Capstone in Software Development

## About the Project

**Moffat Bay Marina** is a web-based project designed to streamline operations for a newly constructed resort and marina commissioned by the **San Juan Islands First Nations Development Committee** on **Joviedsa Island, Washington State**. 

This system completely replaces manual logging by automating reservation tracking, securing user data, and managing long-term slip allocations. It features a comprehensive client-facing portal that ensures boat owners are assigned perfectly sized docking spaces based on their vessel specifications.

## Team

All team members contributed equally to the research, system architecture, and implementation phases of this capstone project—including the Technical Design Document (TDD), Entity-Relationship Diagram (ERD), UI prototypes, and full-stack software development.

| Team | Role |
| -------- | ------- |
| **Christopher Villarreal** [(tophervill)](https://github.com/tophervill) | Team Leader / Developer|
| **Mirach Erkol** [(Mikey5007)](https://github.com/Mikey5007)| Developer |
| **Colton Stone** [(isa99sv)](https://github.com/isa99sv)| Developer |
| **Christine Mazhata** | Instructor |

## Tech Stack

| Layer | Technology Used |
| :--- | :--- |
| **Front-End** | HTML5, CSS3, JavaScript, JavaServer Pages (JSP) |
| **Back-End** | Java 21 (Servlets, Session Management) |
| **Database** | SQL (MySQL) |
| **Local Server Environment** | Apache Tomcat v11.0 |

## Core Features

### Secure User Authentication
* **Input Validation:** Enforces strict regex patterns validating standard email formats (`user@domain.com`) as the primary account username.
* **Credential Security:** Restricts password creation to a minimum of 8 characters containing at least one uppercase and one lowercase letter. Passwords are securely hashed using industry-standard cryptography before database insertion.
* **Session Management:** Confirmed active users are safely bound to the application's session state, restricting reservation modifications strictly to account owners.

### Slip Allocation & Dynamic Pricing Engine
* **Smart Categorization:** Automatically maps vessels into one of three rigid long-term slip sizes (**26ft, 40ft, or 50ft**). The system rounds up to prevent undersized docking (e.g., a 34ft boat is perfectly allocated to a 40ft slip).
* **Automated Billing:** Programmatically applies the marina's long-term billing model on the Summary Page: `Monthly Cost = ($10 * Boat Length) + $10 Electric Utility Fee`.

### Waitlist Automation & Slip Controls
* **Over-booking Prevention:** Queries active MySQL reservation records in real-time against the finite capacity limits established by the physical Marina Map.
* **Automated Waitlists:** If a required slip size category is entirely booked out, the program interrupts the booking, alerts the customer, and prompts an option to join a structured waitlist. 

### Reservation & Waitlist Lookups
* **Self-Service Portals:** Empowers logged-in clients to immediately fetch active booking summaries using either their unique **Reservation ID** or registered email address.
* **Privacy-First Public Counters:** Features a public Waitlist Look Up page displaying real-time aggregate volume metrics (total count of vessels waiting per slip tier) without exposing sensitive consumer names.

### Interactive Information Hub
* **Static Content Modules:** Provides clean, informative *About Us* and *Contact Us* pages outlining operational guidelines, pricing matrices, and essential emergency communication lines—including the active **VHF radio channel number** for the Marina Harbormaster.
