package com.ficohsa.model;

public record CashInformation(
        String extraCashBalance,
        String extraCashInstllment,
        String extraCashInterest,
        String extraCashFee,
        String intraCashBalance,
        String intraCashInstallment,
        String intraCashInterest,
        String intraCashFee
) {
}
