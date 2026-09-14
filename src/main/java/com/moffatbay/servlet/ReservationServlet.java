package com.moffatbay.servlet;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;

import com.moffatbay.dao.ReservationDAO;
import com.moffatbay.dao.ReservationDAO.BoatInfo;
import com.moffatbay.dao.ReservationDAO.SlipInfo;
import com.moffatbay.util.PricingUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/reservation")
public class ReservationServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final ReservationDAO reservationDAO =
            new ReservationDAO();


    /*
     * Displays the reservation page.
     *
     * A customer must be logged in before making a reservation.
     */
    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);

        Integer customerId =
                getLoggedInCustomerId(session);

        if (customerId == null) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/Login_Page.jsp"
            );

            return;
        }

        try {

            BoatInfo boat =
                    reservationDAO.getBoatForCustomer(
                            customerId
                    );

            if (boat == null) {

                request.setAttribute(
                        "reservationError",
                        "No boat is associated with your account."
                );

            } else {

                request.setAttribute(
                        "boat",
                        boat
                );
            }

            request.getRequestDispatcher(
                    "/reservation.jsp"
            ).forward(
                    request,
                    response
            );

        } catch (SQLException e) {

            e.printStackTrace();

            request.setAttribute(
                    "reservationError",
                    "A database error occurred while loading your reservation information."
            );

            request.getRequestDispatcher(
                    "/reservation.jsp"
            ).forward(
                    request,
                    response
            );
        }
    }


    /*
     * Processes the reservation form and prepares
     * the reservation summary.
     *
     * No reservation is inserted into MySQL at this stage.
     * The customer must confirm it on the summary page first.
     */
    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");

        HttpSession session =
                request.getSession(false);

        Integer customerId =
                getLoggedInCustomerId(session);

        if (customerId == null) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/Login_Page.jsp"
            );

            return;
        }

        String checkInValue =
                request.getParameter("checkInDate");

        String checkOutValue =
                request.getParameter("checkOutDate");

        if (isBlank(checkInValue)
                || isBlank(checkOutValue)) {

            returnToReservationPage(
                    request,
                    response,
                    customerId,
                    "Please enter both a check-in date and a check-out date."
            );

            return;
        }

        LocalDate checkInDate;
        LocalDate checkOutDate;

        try {

            checkInDate =
                    LocalDate.parse(checkInValue);

            checkOutDate =
                    LocalDate.parse(checkOutValue);

        } catch (DateTimeParseException e) {

            returnToReservationPage(
                    request,
                    response,
                    customerId,
                    "Please enter valid reservation dates."
            );

            return;
        }


        /*
         * The departure date must come after the arrival date.
         */
        if (!checkOutDate.isAfter(checkInDate)) {

            returnToReservationPage(
                    request,
                    response,
                    customerId,
                    "The check-out date must be after the check-in date."
            );

            return;
        }


        /*
         * Prevent a new reservation from starting in the past.
         */
        if (checkInDate.isBefore(LocalDate.now())) {

            returnToReservationPage(
                    request,
                    response,
                    customerId,
                    "The check-in date cannot be in the past."
            );

            return;
        }


        try {

            BoatInfo boat =
                    reservationDAO.getBoatForCustomer(
                            customerId
                    );

            if (boat == null) {

                returnToReservationPage(
                        request,
                        response,
                        customerId,
                        "No boat is associated with your account."
                );

                return;
            }


            /*
             * Determine the exact required slip category.
             *
             * Examples:
             * 20 ft -> 26 ft slip
             * 34 ft -> 40 ft slip
             * 45 ft -> 50 ft slip
             */
            int requiredSlipSize =
                    PricingUtil.getRequiredSlipSize(
                            boat.getBoatLength()
                    );


            /*
             * Convert 26 / 40 / 50 feet into the
             * corresponding SlipSize table ID.
             */
            int slipSizeId =
                    reservationDAO.getSlipSizeId(
                            requiredSlipSize
                    );

            if (slipSizeId < 1) {

                returnToReservationPage(
                        request,
                        response,
                        customerId,
                        "The required slip size could not be found."
                );

                return;
            }


            /*
             * Check only the exact required slip category.
             */
            SlipInfo availableSlip =
                    reservationDAO.findAvailableSlip(
                            slipSizeId,
                            checkInDate,
                            checkOutDate
                    );


            /*
             * No available slip:
             * return to reservation page and allow the user
             * to choose whether to join the wait list.
             */
            if (availableSlip == null) {

                request.setAttribute(
                        "boat",
                        boat
                );

                request.setAttribute(
                        "noAvailability",
                        true
                );

                request.setAttribute(
                        "requiredSlipSize",
                        requiredSlipSize
                );

                request.setAttribute(
                        "slipSizeId",
                        slipSizeId
                );

                request.setAttribute(
                        "checkInDate",
                        checkInDate
                );

                request.setAttribute(
                        "checkOutDate",
                        checkOutDate
                );

                request.setAttribute(
                        "reservationError",
                        "No "
                        + requiredSlipSize
                        + "-foot slips are available for the selected dates."
                );

                request.getRequestDispatcher(
                        "/reservation.jsp"
                ).forward(
                        request,
                        response
                );

                return;
            }


            /*
             * Calculate the monthly cost using the new
             * client-approved pricing:
             *
             * $10.50 per actual boat foot
             * + $10 electrical service fee.
             */
            BigDecimal monthlyCost =
                    PricingUtil.calculateMonthlyCost(
                            boat.getBoatLength()
                    );


            /*
             * Store the pending reservation in the session.
             *
             * Nothing has been inserted into Reservation yet.
             * These values will be used on the summary page
             * when the customer confirms the reservation.
             */
            session.setAttribute(
                    "pendingBoatId",
                    boat.getBoatId()
            );

            session.setAttribute(
                    "pendingBoatName",
                    boat.getBoatName()
            );

            session.setAttribute(
                    "pendingBoatLength",
                    boat.getBoatLength()
            );

            session.setAttribute(
                    "pendingSlipId",
                    availableSlip.getSlipId()
            );

            session.setAttribute(
                    "pendingSlipNumber",
                    availableSlip.getSlipNumber()
            );

            session.setAttribute(
                    "pendingSlipSize",
                    availableSlip.getSlipSizeFeet()
            );

            session.setAttribute(
                    "pendingCheckInDate",
                    checkInDate
            );

            session.setAttribute(
                    "pendingCheckOutDate",
                    checkOutDate
            );

            session.setAttribute(
                    "pendingMonthlyCost",
                    monthlyCost
            );


            /*
             * Display the summary page.
             */
            request.getRequestDispatcher(
                    "/reservationSummary.jsp"
            ).forward(
                    request,
                    response
            );

        } catch (IllegalArgumentException e) {

            returnToReservationPage(
                    request,
                    response,
                    customerId,
                    e.getMessage()
            );

        } catch (SQLException e) {

            e.printStackTrace();

            returnToReservationPage(
                    request,
                    response,
                    customerId,
                    "A database error occurred while checking slip availability."
            );
        }
    }


    /*
     * Returns the customer to the reservation form
     * while preserving their boat information and
     * showing an error message.
     */
    private void returnToReservationPage(
            HttpServletRequest request,
            HttpServletResponse response,
            int customerId,
            String message)
            throws ServletException, IOException {

        request.setAttribute(
                "reservationError",
                message
        );

        try {

            BoatInfo boat =
                    reservationDAO.getBoatForCustomer(
                            customerId
                    );

            request.setAttribute(
                    "boat",
                    boat
            );

        } catch (SQLException e) {

            e.printStackTrace();
        }

        request.getRequestDispatcher(
                "/reservation.jsp"
        ).forward(
                request,
                response
        );
    }


    /*
     * Retrieves the customerId created by LoginServlet.
     */
    private Integer getLoggedInCustomerId(
            HttpSession session) {

        if (session == null) {
            return null;
        }

        Object customerId =
                session.getAttribute(
                        "customerId"
                );

        if (customerId instanceof Integer) {
            return (Integer) customerId;
        }

        return null;
    }


    private boolean isBlank(String value) {

        return value == null
                || value.isBlank();
    }
}