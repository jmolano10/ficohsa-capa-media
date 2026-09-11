package com.ficohsa.model;

public record CreditCardTransactions(
        String periodDate,
        String periodBalance,
        String overdueAmount,
        String payments,
        String merchantSalesTransactions,
        String cashAdvance,
        String limit,
        String otherTransactions,
        String interestCharge,
        String totalFees,
        String otherDebits,
        String cycleDueDate,
        String totalCycleBalance
) {
}
