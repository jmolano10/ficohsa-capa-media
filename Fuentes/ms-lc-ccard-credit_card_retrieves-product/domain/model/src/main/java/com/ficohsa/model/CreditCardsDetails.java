package com.ficohsa.model;

import java.util.List;

public record CreditCardsDetails(
        List<CreditCard> creditCards,
        CreditCardTransactions creditCardTransactions,
        CashInformation cashInformation,
        String extraFee,
        String intraFee,
        String extraBalance,
        String intraBalance
) {
}
