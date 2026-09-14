package com.moffatbay.dao;

import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.time.LocalDate;

import com.moffatbay.util.DBUtil;

public class ReservationDAO {

    /*
     * Simple object used to return the logged-in customer's boat information.
     */
    public static class BoatInfo {

        private final int boatId;
        private final String boatName;
        private final double boatLength;

        public BoatInfo(
                int boatId,
                String boatName,
                double boatLength) {

            this.boatId = boatId;
            this.boatName = boatName;
            this.boatLength = boatLength;
        }

        public int getBoatId() {
            return boatId;
        }

        public String getBoatName() {
            return boatName;
        }

        public double getBoatLength() {
            return boatLength;
        }
    }


    /*
     * Simple object used to return an available slip.
     */
    public static class SlipInfo {

        private final int slipId;
        private final String slipNumber;
        private final int slipSizeId;
        private final int slipSizeFeet;

        public SlipInfo(
                int slipId,
                String slipNumber,
                int slipSizeId,
                int slipSizeFeet) {

            this.slipId = slipId;
            this.slipNumber = slipNumber;
            this.slipSizeId = slipSizeId;
            this.slipSizeFeet = slipSizeFeet;
        }

        public int getSlipId() {
            return slipId;
        }

        public String getSlipNumber() {
            return slipNumber;
        }

        public int getSlipSizeId() {
            return slipSizeId;
        }

        public int getSlipSizeFeet() {
            return slipSizeFeet;
        }
    }


    /*
     * Used when displaying a saved reservation.
     */
    public static class ReservationInfo {

        private final int reservationId;
        private final int customerId;
        private final String customerEmail;

        private final int boatId;
        private final String boatName;
        private final double boatLength;

        private final int slipId;
        private final String slipNumber;
        private final int slipSizeFeet;

        private final LocalDate checkInDate;
        private final LocalDate checkOutDate;

        private final BigDecimal monthlyCost;
        private final String status;

        public ReservationInfo(
                int reservationId,
                int customerId,
                String customerEmail,
                int boatId,
                String boatName,
                double boatLength,
                int slipId,
                String slipNumber,
                int slipSizeFeet,
                LocalDate checkInDate,
                LocalDate checkOutDate,
                BigDecimal monthlyCost,
                String status) {

            this.reservationId = reservationId;
            this.customerId = customerId;
            this.customerEmail = customerEmail;

            this.boatId = boatId;
            this.boatName = boatName;
            this.boatLength = boatLength;

            this.slipId = slipId;
            this.slipNumber = slipNumber;
            this.slipSizeFeet = slipSizeFeet;

            this.checkInDate = checkInDate;
            this.checkOutDate = checkOutDate;

            this.monthlyCost = monthlyCost;
            this.status = status;
        }

        public int getReservationId() {
            return reservationId;
        }

        public int getCustomerId() {
            return customerId;
        }

        public String getCustomerEmail() {
            return customerEmail;
        }

        public int getBoatId() {
            return boatId;
        }

        public String getBoatName() {
            return boatName;
        }

        public double getBoatLength() {
            return boatLength;
        }

        public int getSlipId() {
            return slipId;
        }

        public String getSlipNumber() {
            return slipNumber;
        }

        public int getSlipSizeFeet() {
            return slipSizeFeet;
        }

        public LocalDate getCheckInDate() {
            return checkInDate;
        }

        public LocalDate getCheckOutDate() {
            return checkOutDate;
        }

        public BigDecimal getMonthlyCost() {
            return monthlyCost;
        }

        public String getStatus() {
            return status;
        }
    }


    /*
     * Finds the boat belonging to the logged-in customer.
     *
     * Registration currently creates one boat for each customer,
     * so the first boat belonging to the customer is returned.
     */
    public BoatInfo getBoatForCustomer(int customerId)
            throws SQLException {

        String sql =
                "SELECT boat_id, boat_name, boat_length "
                + "FROM Boat "
                + "WHERE customer_id = ? "
                + "ORDER BY boat_id "
                + "LIMIT 1";

        try (
                Connection connection =
                        DBUtil.getConnection();

                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setInt(1, customerId);

            try (ResultSet result =
                    statement.executeQuery()) {

                if (result.next()) {

                    return new BoatInfo(
                            result.getInt("boat_id"),
                            result.getString("boat_name"),
                            result.getDouble("boat_length")
                    );
                }
            }
        }

        return null;
    }


    /*
     * Converts the required slip size in feet
     * into the corresponding SlipSize table ID.
     *
     * Current database:
     *
     * 26 ft = slip_size_id 1
     * 40 ft = slip_size_id 2
     * 50 ft = slip_size_id 3
     *
     * We query the database instead of hard-coding those IDs.
     */
    public int getSlipSizeId(int requiredSlipSize)
            throws SQLException {

        String sql =
                "SELECT slip_size_id "
                + "FROM SlipSize "
                + "WHERE size_ft = ?";

        try (
                Connection connection =
                        DBUtil.getConnection();

                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setInt(
                    1,
                    requiredSlipSize
            );

            try (ResultSet result =
                    statement.executeQuery()) {

                if (result.next()) {

                    return result.getInt(
                            "slip_size_id"
                    );
                }
            }
        }

        return -1;
    }


    /*
     * Finds one active slip in the EXACT required category
     * that does not already have an overlapping confirmed
     * reservation.
     *
     * Example:
     * A 34-foot boat requires a 40-foot slip.
     * This method will not silently assign a 50-foot slip.
     */
    public SlipInfo findAvailableSlip(
            int slipSizeId,
            LocalDate checkInDate,
            LocalDate checkOutDate)
            throws SQLException {

        String sql =
                "SELECT "
                + "s.slip_id, "
                + "s.slip_number, "
                + "s.slip_size_id, "
                + "ss.size_ft "
                + "FROM Slip s "
                + "JOIN SlipSize ss "
                + "ON s.slip_size_id = ss.slip_size_id "
                + "WHERE s.slip_size_id = ? "
                + "AND s.is_active = 1 "
                + "AND NOT EXISTS ("
                + "    SELECT 1 "
                + "    FROM Reservation r "
                + "    WHERE r.slip_id = s.slip_id "
                + "    AND r.status = 'confirmed' "
                + "    AND r.check_in_date < ? "
                + "    AND r.check_out_date > ?"
                + ") "
                + "ORDER BY s.slip_id "
                + "LIMIT 1";

        try (
                Connection connection =
                        DBUtil.getConnection();

                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setInt(
                    1,
                    slipSizeId
            );

            statement.setDate(
                    2,
                    Date.valueOf(checkOutDate)
            );

            statement.setDate(
                    3,
                    Date.valueOf(checkInDate)
            );

            try (ResultSet result =
                    statement.executeQuery()) {

                if (result.next()) {

                    return new SlipInfo(
                            result.getInt("slip_id"),
                            result.getString("slip_number"),
                            result.getInt("slip_size_id"),
                            result.getInt("size_ft")
                    );
                }
            }
        }

        return null;
    }


    /*
     * Creates the reservation only after the customer
     * confirms it on the Reservation Summary page.
     *
     * Returns the newly generated reservation ID.
     */
    public int createReservation(
            int boatId,
            int slipId,
            LocalDate checkInDate,
            LocalDate checkOutDate,
            BigDecimal monthlyCost)
            throws SQLException {

        String sql =
                "INSERT INTO Reservation "
                + "(boat_id, "
                + "slip_id, "
                + "check_in_date, "
                + "check_out_date, "
                + "monthly_cost, "
                + "status) "
                + "VALUES (?, ?, ?, ?, ?, 'confirmed')";

        try (
                Connection connection =
                        DBUtil.getConnection();

                PreparedStatement statement =
                        connection.prepareStatement(
                                sql,
                                Statement.RETURN_GENERATED_KEYS
                        )
        ) {

            statement.setInt(
                    1,
                    boatId
            );

            statement.setInt(
                    2,
                    slipId
            );

            statement.setDate(
                    3,
                    Date.valueOf(checkInDate)
            );

            statement.setDate(
                    4,
                    Date.valueOf(checkOutDate)
            );

            statement.setBigDecimal(
                    5,
                    monthlyCost
            );

            int rowsInserted =
                    statement.executeUpdate();

            if (rowsInserted == 0) {

                throw new SQLException(
                        "Reservation could not be created."
                );
            }

            try (ResultSet generatedKeys =
                    statement.getGeneratedKeys()) {

                if (generatedKeys.next()) {

                    return generatedKeys.getInt(1);
                }
            }
        }

        throw new SQLException(
                "Reservation was created, but no reservation ID was returned."
        );
    }


    /*
     * Adds the customer's boat to the wait list.
     *
     * The WaitList table automatically supplies:
     *
     * status = waiting
     * created_at = current timestamp
     */
    public int addToWaitList(
            int boatId,
            int slipSizeId,
            LocalDate requestedCheckInDate)
            throws SQLException {

        Integer existingWaitListId =
                findExistingWaitListEntry(
                        boatId,
                        slipSizeId
                );

        if (existingWaitListId != null) {

            return existingWaitListId;
        }

        String sql =
                "INSERT INTO WaitList "
                + "(boat_id, "
                + "slip_size_id, "
                + "requested_check_in_date) "
                + "VALUES (?, ?, ?)";

        try (
                Connection connection =
                        DBUtil.getConnection();

                PreparedStatement statement =
                        connection.prepareStatement(
                                sql,
                                Statement.RETURN_GENERATED_KEYS
                        )
        ) {

            statement.setInt(
                    1,
                    boatId
            );

            statement.setInt(
                    2,
                    slipSizeId
            );

            statement.setDate(
                    3,
                    Date.valueOf(
                            requestedCheckInDate
                    )
            );

            int rowsInserted =
                    statement.executeUpdate();

            if (rowsInserted == 0) {

                throw new SQLException(
                        "Wait list entry could not be created."
                );
            }

            try (ResultSet generatedKeys =
                    statement.getGeneratedKeys()) {

                if (generatedKeys.next()) {

                    return generatedKeys.getInt(1);
                }
            }
        }

        throw new SQLException(
                "Wait list entry was created, but no ID was returned."
        );
    }


    /*
     * Prevents the same boat from being added repeatedly
     * to the same active wait list category.
     */
    private Integer findExistingWaitListEntry(
            int boatId,
            int slipSizeId)
            throws SQLException {

        String sql =
                "SELECT waitlist_id "
                + "FROM WaitList "
                + "WHERE boat_id = ? "
                + "AND slip_size_id = ? "
                + "AND status = 'waiting' "
                + "ORDER BY waitlist_id "
                + "LIMIT 1";

        try (
                Connection connection =
                        DBUtil.getConnection();

                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setInt(
                    1,
                    boatId
            );

            statement.setInt(
                    2,
                    slipSizeId
            );

            try (ResultSet result =
                    statement.executeQuery()) {

                if (result.next()) {

                    return result.getInt(
                            "waitlist_id"
                    );
                }
            }
        }

        return null;
    }


    /*
     * Retrieves a reservation belonging to a specific customer.
     *
     * The customer ID check prevents one logged-in customer
     * from viewing another customer's reservation simply by
     * changing the reservation ID.
     */
    public ReservationInfo getReservation(
            int reservationId,
            int customerId)
            throws SQLException {

        String sql =
                "SELECT "
                + "r.reservation_id, "
                + "c.customer_id, "
                + "c.email, "
                + "b.boat_id, "
                + "b.boat_name, "
                + "b.boat_length, "
                + "s.slip_id, "
                + "s.slip_number, "
                + "ss.size_ft, "
                + "r.check_in_date, "
                + "r.check_out_date, "
                + "r.monthly_cost, "
                + "r.status "
                + "FROM Reservation r "
                + "JOIN Boat b "
                + "ON r.boat_id = b.boat_id "
                + "JOIN Customer c "
                + "ON b.customer_id = c.customer_id "
                + "JOIN Slip s "
                + "ON r.slip_id = s.slip_id "
                + "JOIN SlipSize ss "
                + "ON s.slip_size_id = ss.slip_size_id "
                + "WHERE r.reservation_id = ? "
                + "AND c.customer_id = ?";

        try (
                Connection connection =
                        DBUtil.getConnection();

                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setInt(
                    1,
                    reservationId
            );

            statement.setInt(
                    2,
                    customerId
            );

            try (ResultSet result =
                    statement.executeQuery()) {

                if (result.next()) {

                    return new ReservationInfo(
                            result.getInt(
                                    "reservation_id"
                            ),

                            result.getInt(
                                    "customer_id"
                            ),

                            result.getString(
                                    "email"
                            ),

                            result.getInt(
                                    "boat_id"
                            ),

                            result.getString(
                                    "boat_name"
                            ),

                            result.getDouble(
                                    "boat_length"
                            ),

                            result.getInt(
                                    "slip_id"
                            ),

                            result.getString(
                                    "slip_number"
                            ),

                            result.getInt(
                                    "size_ft"
                            ),

                            result.getDate(
                                    "check_in_date"
                            ).toLocalDate(),

                            result.getDate(
                                    "check_out_date"
                            ).toLocalDate(),

                            result.getBigDecimal(
                                    "monthly_cost"
                            ),

                            result.getString(
                                    "status"
                            )
                    );
                }
            }
        }

        return null;
    }


    /*
     * Cancels a reservation belonging to the logged-in customer.
     *
     * We retain the reservation record and change its status
     * rather than permanently deleting historical data.
     */
    public boolean cancelReservation(
            int reservationId,
            int customerId)
            throws SQLException {

        String sql =
                "UPDATE Reservation r "
                + "JOIN Boat b "
                + "ON r.boat_id = b.boat_id "
                + "SET r.status = 'cancelled' "
                + "WHERE r.reservation_id = ? "
                + "AND b.customer_id = ? "
                + "AND r.status = 'confirmed'";

        try (
                Connection connection =
                        DBUtil.getConnection();

                PreparedStatement statement =
                        connection.prepareStatement(sql)
        ) {

            statement.setInt(
                    1,
                    reservationId
            );

            statement.setInt(
                    2,
                    customerId
            );

            return statement.executeUpdate() > 0;
        }
    }
}