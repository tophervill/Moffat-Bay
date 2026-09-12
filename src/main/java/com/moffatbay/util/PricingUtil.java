package com.moffatbay.util;

import java.math.BigDecimal;
import java.math.RoundingMode;

public final class PricingUtil {

    public static final BigDecimal RATE_PER_FOOT =
            new BigDecimal("10.50");

    public static final BigDecimal ELECTRICAL_FEE =
            new BigDecimal("10.00");

    private PricingUtil() {
    }

    public static BigDecimal calculateMonthlyCost(double boatLength) {

        if (boatLength <= 0 || boatLength > 50) {
            throw new IllegalArgumentException(
                    "Boat length must be greater than 0 and no more than 50 feet."
            );
        }

        BigDecimal length =
                BigDecimal.valueOf(boatLength);

        return length
                .multiply(RATE_PER_FOOT)
                .add(ELECTRICAL_FEE)
                .setScale(2, RoundingMode.HALF_UP);
    }

    public static int getRequiredSlipSize(double boatLength) {

        if (boatLength <= 0 || boatLength > 50) {
            throw new IllegalArgumentException(
                    "Boat length must be greater than 0 and no more than 50 feet."
            );
        }

        if (boatLength <= 26) {
            return 26;
        }

        if (boatLength <= 40) {
            return 40;
        }

        return 50;
    }
}