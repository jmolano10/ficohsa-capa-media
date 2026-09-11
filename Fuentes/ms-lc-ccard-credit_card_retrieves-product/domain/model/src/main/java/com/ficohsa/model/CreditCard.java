package com.ficohsa.model;

public record CreditCard(
        AccountIdentification accountIdentification,
        AccountRestrictionStatus accountRestrictionStatus,
        String cardAffinityGroup,
        CreditCardProductName creditCardProductName,
        Integer cardSettlementModel,
        String cardOpeningDate,
        String cardCancelationDate,
        String lastExtraDate,
        Integer creditCardDelinquency,
        LimitAmount limitAmount,
        Double currentCardBalance,
        Double accountClosingBalance,
        Double extraBalance,
        Double intraBalance,
        Double activeAdditionalInstallments,
        String blockCodeOne,
        String blockCodeTwo,
        String logo,
        String availableCash,
        String blockCodeOneDate,
        String blockCodeTwoDate,
        String bin,
        String additionalApprovalDate,
        String intraApprovalDate,
        String pilApprovalDate,
        String previousLimit,
        String authorizationBalance
) {
}
