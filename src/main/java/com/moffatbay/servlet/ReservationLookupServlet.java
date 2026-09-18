package com.moffatbay.servlet;

import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

import com.moffatbay.dao.ReservationDAO;
import com.moffatbay.dao.ReservationDAO.ReservationInfo;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;


@WebServlet("/reservationLookup")
public class ReservationLookupServlet
        extends HttpServlet {

    private static final long serialVersionUID = 1L;


    private final ReservationDAO reservationDAO =
            new ReservationDAO();


    /*
     * Opens the Check Reservation page.
     *
     * If the customer is logged in, all reservations
     * belonging to that customer are loaded automatically.
     *
     * A reservationId parameter can also be supplied
     * to display the full details for one reservation.
     */
    @Override
    protected void doGet(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session =
                request.getSession(false);


        /*
         * If the customer is not logged in, simply display
         * the page. The JSP will show the login-required message.
         */
        if (session == null
                || !(session.getAttribute("customerId")
                instanceof Integer)) {

            request.getRequestDispatcher(
                    "/reservationLookup.jsp"
            ).forward(
                    request,
                    response
            );

            return;
        }


        int customerId =
                (Integer) session.getAttribute(
                        "customerId"
                );


        try {

            /*
             * Load every reservation belonging to
             * the logged-in customer.
             */
            List<ReservationInfo> reservations =
                    reservationDAO.getReservationsForCustomer(
                            customerId
                    );

            request.setAttribute(
                    "reservations",
                    reservations
            );


            /*
             * If the user selected a reservation from the list,
             * load that reservation's full details.
             */
            String reservationIdText =
                    request.getParameter(
                            "reservationId"
                    );


            if (reservationIdText != null
                    && !reservationIdText.isBlank()) {

                try {

                    int reservationId =
                            Integer.parseInt(
                                    reservationIdText.trim()
                            );


                    if (reservationId > 0) {

                        ReservationInfo reservation =
                                reservationDAO.getReservation(
                                        reservationId,
                                        customerId
                                );


                        if (reservation != null) {

                            request.setAttribute(
                                    "reservation",
                                    reservation
                            );

                        } else {

                            request.setAttribute(
                                    "lookupError",
                                    "That reservation could not be found "
                                    + "for your account."
                            );
                        }
                    }


                } catch (NumberFormatException e) {

                    request.setAttribute(
                            "lookupError",
                            "Invalid reservation number."
                    );
                }
            }


            request.getRequestDispatcher(
                    "/reservationLookup.jsp"
            ).forward(
                    request,
                    response
            );


        } catch (SQLException e) {

            e.printStackTrace();

            request.setAttribute(
                    "lookupError",
                    "A database error occurred while loading "
                    + "your reservations. Please try again."
            );

            request.getRequestDispatcher(
                    "/reservationLookup.jsp"
            ).forward(
                    request,
                    response
            );
        }
    }


    /*
     * Manual reservation lookup.
     *
     * This is used by the fallback form at the bottom
     * of the page when the customer does not see the
     * reservation they are looking for.
     */
    @Override
    protected void doPost(
            HttpServletRequest request,
            HttpServletResponse response)
            throws ServletException, IOException {

        request.setCharacterEncoding("UTF-8");


        HttpSession session =
                request.getSession(false);


        if (session == null
                || !(session.getAttribute("customerId")
                instanceof Integer)) {

            request.setAttribute(
                    "lookupError",
                    "Please log in before checking a reservation."
            );

            request.getRequestDispatcher(
                    "/reservationLookup.jsp"
            ).forward(
                    request,
                    response
            );

            return;
        }


        int customerId =
                (Integer) session.getAttribute(
                        "customerId"
                );


        try {

            /*
             * Always reload the customer's reservations
             * so the page still displays the list after
             * a manual lookup.
             */
            List<ReservationInfo> reservations =
                    reservationDAO.getReservationsForCustomer(
                            customerId
                    );

            request.setAttribute(
                    "reservations",
                    reservations
            );


            String reservationIdText =
                    request.getParameter(
                            "reservationId"
                    );


            /*
             * Make sure a reservation number was entered.
             */
            if (reservationIdText == null
                    || reservationIdText.isBlank()) {

                request.setAttribute(
                        "lookupError",
                        "Please enter a reservation number."
                );

                request.getRequestDispatcher(
                        "/reservationLookup.jsp"
                ).forward(
                        request,
                        response
                );

                return;
            }


            try {

                int reservationId =
                        Integer.parseInt(
                                reservationIdText.trim()
                        );


                if (reservationId <= 0) {

                    request.setAttribute(
                            "lookupError",
                            "Please enter a valid reservation number."
                    );

                    request.getRequestDispatcher(
                            "/reservationLookup.jsp"
                    ).forward(
                            request,
                            response
                    );

                    return;
                }


                /*
                 * The DAO checks both the reservation ID
                 * and customer ID, preventing customers
                 * from accessing another customer's reservation.
                 */
                ReservationInfo reservation =
                        reservationDAO.getReservation(
                                reservationId,
                                customerId
                        );


                if (reservation == null) {

                    request.setAttribute(
                            "lookupError",
                            "No reservation was found with that number "
                            + "for your account."
                    );

                } else {

                    request.setAttribute(
                            "reservation",
                            reservation
                    );
                }


                request.getRequestDispatcher(
                        "/reservationLookup.jsp"
                ).forward(
                        request,
                        response
                );


            } catch (NumberFormatException e) {

                request.setAttribute(
                        "lookupError",
                        "Reservation numbers must contain numbers only."
                );

                request.getRequestDispatcher(
                        "/reservationLookup.jsp"
                ).forward(
                        request,
                        response
                );
            }


        } catch (SQLException e) {

            e.printStackTrace();

            request.setAttribute(
                    "lookupError",
                    "A database error occurred while looking up "
                    + "your reservation. Please try again."
            );

            request.getRequestDispatcher(
                    "/reservationLookup.jsp"
            ).forward(
                    request,
                    response
            );
        }
    }
}