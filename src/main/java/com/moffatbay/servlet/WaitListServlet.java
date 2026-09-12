package com.moffatbay.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeParseException;

import com.moffatbay.dao.ReservationDAO;
import com.moffatbay.dao.ReservationDAO.BoatInfo;
import com.moffatbay.util.PricingUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

@WebServlet("/waitlist")
public class WaitListServlet
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
         * Customer must be logged in.
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


        String checkInDateValue =
                request.getParameter(
                        "checkInDate"
                );


        /*
         * Validate the requested check-in date.
         */
        if (checkInDateValue == null
                || checkInDateValue.isBlank()) {

            returnToReservation(
                    request,
                    response,
                    customerId,
                    "The requested check-in date is missing."
            );

            return;
        }


        try {

            LocalDate requestedCheckInDate =
                    LocalDate.parse(
                            checkInDateValue
                    );


            if (requestedCheckInDate
                    .isBefore(LocalDate.now())) {

                returnToReservation(
                        request,
                        response,
                        customerId,
                        "The requested check-in date cannot be in the past."
                );

                return;
            }


            /*
             * Reload the customer's actual boat from
             * the database instead of trusting the
             * hidden boatId submitted by the browser.
             */
            BoatInfo boat =
                    reservationDAO.getBoatForCustomer(
                            customerId
                    );


            if (boat == null) {

                returnToReservation(
                        request,
                        response,
                        customerId,
                        "Boat information could not be found for your account."
                );

                return;
            }


            /*
             * Determine the correct slip category from
             * the customer's saved boat length.
             *
             * We intentionally do not trust the hidden
             * slipSizeId sent from the page.
             */
            int requiredSlipSize =
                    PricingUtil.getRequiredSlipSize(
                            boat.getBoatLength()
                    );


            int slipSizeId =
                    reservationDAO.getSlipSizeId(
                            requiredSlipSize
                    );


            if (slipSizeId == -1) {

                throw new SQLException(
                        "The required slip category could not be found."
                );
            }


            /*
             * ReservationDAO prevents duplicate active
             * wait-list entries for the same boat and
             * slip category.
             */
            int waitListId =
                    reservationDAO.addToWaitList(
                            boat.getBoatId(),
                            slipSizeId,
                            requestedCheckInDate
                    );


            /*
             * Save the information needed for the
             * wait-list confirmation page.
             */
            session.setAttribute(
                    "lastWaitListId",
                    waitListId
            );

            session.setAttribute(
                    "lastWaitListBoatName",
                    boat.getBoatName()
            );

            session.setAttribute(
                    "lastWaitListBoatLength",
                    boat.getBoatLength()
            );

            session.setAttribute(
                    "lastWaitListSlipSize",
                    requiredSlipSize
            );

            session.setAttribute(
                    "lastWaitListCheckInDate",
                    requestedCheckInDate
            );


            /*
             * We will create this page next.
             */
            response.sendRedirect(
                    request.getContextPath()
                    + "/waitListConfirmation.jsp"
            );


        } catch (DateTimeParseException e) {

            returnToReservation(
                    request,
                    response,
                    customerId,
                    "The requested check-in date is invalid."
            );


        } catch (IllegalArgumentException e) {

            returnToReservation(
                    request,
                    response,
                    customerId,
                    e.getMessage()
            );


        } catch (SQLException e) {

            e.printStackTrace();

            returnToReservation(
                    request,
                    response,
                    customerId,
                    "A database error occurred while joining the wait list. "
                    + "Please try again."
            );
        }
    }


    /*
     * Reloads the customer's boat before returning to
     * reservation.jsp so the page can still display
     * the boat information correctly.
     */
    private void returnToReservation(
            HttpServletRequest request,
            HttpServletResponse response,
            int customerId,
            String errorMessage)
            throws ServletException, IOException {

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


        request.setAttribute(
                "reservationError",
                errorMessage
        );


        request.getRequestDispatcher(
                "/reservation.jsp"
        ).forward(
                request,
                response
        );
    }
}