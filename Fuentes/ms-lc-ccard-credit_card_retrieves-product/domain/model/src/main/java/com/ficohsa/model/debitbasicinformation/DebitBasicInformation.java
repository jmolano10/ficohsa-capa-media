package com.ficohsa.model.debitbasicinformation;

public record DebitBasicInformation(
        String customerReference,
        String cardHolderName,
        String cardType,
        String cardStatus,
        LinkedAccounts linkedAccounts
) {
}
