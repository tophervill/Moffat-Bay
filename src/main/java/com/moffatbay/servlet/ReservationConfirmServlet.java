package com.moffatbay.servlet;

import java.io.IOException;
import java.math.BigDecimal;
import java.sql.SQLException;
import java.time.LocalDate;

import com.moffatbay.dao.ReservationDAO;
import com.moffatbay.dao.ReservationDAO.BoatInfo;
import com.moffatbay.dao.ReservationDAO.SlipInfo;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/confirmReservation")
public class ReservationConfirmServlet
        extends HttpServlet {

    private static final long serialVersionUID = 1L;

    private final ReservationDAO reservationDAO =
            new ReservationDAO();


    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);


        /*
         * Customer must still be logged in.
         */
        if (session == null
                || !(session.getAttribute("customerId")
                instanceof Integer)) {

            response.sendRedirect(
                    request.getContextPath()
                    + "/Login_Page.jsp"
            );

            return;
        }


        int customerId =
                (Integer) session.getAttribute(
                        "customerId"
                );


        /*
         * Retrieve the pending reservation
         * created by ReservationServlet.
         */
        Integer pendingBoatId =
                (Integer) session.getAttribute(
                        "pendingBoatId"
                );

        Integer pendingSlipId =
                (Integer) session.getAttribute(
                        "pendingSlipId"
                );

        Integer pendingSlipSize =
                (Integer) session.getAttribute(
                        "pendingSlipSize"
                );

        LocalDate pendingCheckInDate =
                (LocalDate) session.getAttribute(
                        "pendingCheckInDate"
                );

        LocalDate pendingCheckOutDate =
                (LocalDate) session.getAttribute(
                        "pendingCheckOutDate"
                );

        BigDecimal pendingMonthlyCost =
                (BigDecimal) session.getAttribute(
                        "pendingMonthlyCost"
                );


        /*
         * If any required pending reservation information
         * is missing, return to the reservation page.
         */
        if (pendingBoatId == null
                || pendingSlipId == null
                || pendingSlipSize == null
                || pendingCheckInDate == null
                || pendingCheckOutDate == null
                || pendingMonthlyCost == null) {

            clearPendingReservation(session);

            response.sendRedirect(
                    request.getContextPath()
                    + "/reservation"
            );

            return;
        }


        try {

            /*
             * Verify the boat still belongs to
             * the logged-in customer.
             */
            BoatInfo boat =
                    reservationDAO.getBoatForCustomer(
                            customerId
                    );

            if (boat == null
                    || boat.getBoatId()
                    != pendingBoatId) {

                clearPendingReservation(session);

                response.sendRedirect(
                        request.getContextPath()
                        + "/reservation"
                );

                return;
            }


            /*
             * Re-check the slip category immediately
             * before saving the reservation.
             */
            int slipSizeId =
                    reservationDAO.getSlipSizeId(
                            pendingSlipSize
                    );

            if (slipSizeId == -1) {

                throw new SQLException(
                        "The required slip category could not be found."
                );
            }


            SlipInfo availableSlip =
                    reservationDAO.findAvailableSlip(
                            slipSizeId,
                            pendingCheckInDate,
                            pendingCheckOutDate
                    );


            /*
             * The exact slip shown on the summary page
             * must still be available.
             *
             * If availability changed while the customer
             * was reviewing the summary, they must check
             * availability again before confirming.
             */
            if (availableSlip == null
                    || availableSlip.getSlipId()
                    != pendingSlipId) {

                clearPendingReservation(session);

                request.setAttribute(
                        "boat",
                        boat
                );

                request.setAttribute(
                        "reservationError",
                        "Slip availability changed while you were reviewing "
                        + "your reservation. Please select your dates and "
                        + "check availability again."
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
             * Create the confirmed reservation.
             */
            int reservationId =
                    reservationDAO.createReservation(
                            pendingBoatId,
                            pendingSlipId,
                            pendingCheckInDate,
                            pendingCheckOutDate,
                            pendingMonthlyCost
                    );


            /*
             * The pending reservation is no longer needed
             * after it has been successfully saved.
             */
            clearPendingReservation(session);


            /*
             * Keep the new reservation ID available
             * for the confirmation page.
             */
            session.setAttribute(
                    "lastReservationId",
                    reservationId
            );


            /*
             * Redirect to the final confirmation page.
             *
             * We will create this page next.
             */
            response.sendRedirect(
                    request.getContextPath()
                    + "/reservationConfirmation.jsp"
                    + "?reservationId="
                    + reservationId
            );


        } catch (SQLException e) {

            e.printStackTrace();

            request.setAttribute(
                    "confirmationError",
                    "A database error occurred while confirming "
                    + "your reservation. Please try again."
            );

            request.getRequestDispatcher(
                    "/reservationSummary.jsp"
            ).forward(
                    request,
                    response
            );
        }
    }


    /*
     * Removes all temporary reservation information
     * stored during the reservation process.
     */
    private void clearPendingReservation(
            HttpSession session) {

        session.removeAttribute(
                "pendingBoatId"
        );

        session.removeAttribute(
                "pendingBoatName"
        );

        session.removeAttribute(
                "pendingBoatLength"
        );

        session.removeAttribute(
                "pendingSlipId"
        );

        session.removeAttribute(
                "pendingSlipNumber"
        );

        session.removeAttribute(
                "pendingSlipSize"
        );

        session.removeAttribute(
                "pendingCheckInDate"
        );

        session.removeAttribute(
                "pendingCheckOutDate"
        );

        session.removeAttribute(
                "pendingMonthlyCost"
        );
    }
}