package com.ficohsa.usecase;

import com.ficohsa.lib.core.exception.UnprocessableEntityException;
import com.ficohsa.model.debitcarddetails.DebitCardDetails;
import com.ficohsa.model.debitcarddetails.DebitCardInquiry;
import com.ficohsa.ports.IDebitCardDetails;
import com.ficohsa.ports.IDebitCardDetailsGateway;
import com.ficohsa.ports.IRegionalizationGateway;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import reactor.core.publisher.Mono;

import java.util.Map;

@Slf4j
@Component
@RequiredArgsConstructor
public class DebitCardDetailsUseCase implements IDebitCardDetails {

    private final Map<String, IDebitCardDetailsGateway> debitCardDetailsStrategies;
    private final IRegionalizationGateway regionalizationGateway;

    @Override
    public Mono<DebitCardDetails> getDebitCardDetails(String customerIdentification, String accountStatusTypeValues, String accountNumber, String sourceBank) {
        return regionalizationGateway.validateRegion("debit-card-details", sourceBank, sourceBank)
                .then(Mono.defer(() -> {
                    IDebitCardDetailsGateway strategy = debitCardDetailsStrategies.get(sourceBank.trim());
                    if (strategy == null) {
                        return Mono.error(new UnprocessableEntityException("NOT_IMPLEMENTED"));
                    }
                    return strategy.retrieveDebitCardDetails(customerIdentification, accountStatusTypeValues, accountNumber)
                            .contextWrite(context -> context.put("Source-Bank", sourceBank));
                }))
                .map(debitCardDetails -> filterDebitCardDetails(debitCardDetails, accountStatusTypeValues, accountNumber));
    }

    private DebitCardDetails filterDebitCardDetails(DebitCardDetails debitCardDetails, String accountStatusTypeValues, String accountNumber) {
        if (debitCardDetails == null || debitCardDetails.getDebitCardInquiry() == null) {
            return debitCardDetails;
        }

        var filteredCards = debitCardDetails.getDebitCardInquiry().stream()
                .filter(card -> matchesStatus(card.getCardStatus(), accountStatusTypeValues))
                .filter(card -> matchesAccountNumber(card.getAssociationReference(), accountNumber))
                .map(this::formatIssueDate)
                .toList();

        var filteredDetails = new DebitCardDetails();
        filteredDetails.setCustomerInquiry(debitCardDetails.getCustomerInquiry());
        filteredDetails.setDebitCardInquiry(filteredCards);
        return filteredDetails;
    }

    private boolean matchesStatus(String cardStatus, String accountStatusTypeValues) {
        if (accountStatusTypeValues == null || accountStatusTypeValues.equalsIgnoreCase("ALL")) {
            return true;
        }
        return accountStatusTypeValues.equalsIgnoreCase(cardStatus);
    }

    private boolean matchesAccountNumber(String associationReference, String accountNumber) {
        if (accountNumber == null) {
            return true;
        }
        return accountNumber.equals(associationReference);
    }

    private DebitCardInquiry formatIssueDate(DebitCardInquiry card) {
        if (card.getIssueDate() != null && card.getIssueDate().length() == 8) {
            String date = card.getIssueDate();
            String formattedDate = date.substring(0, 4) + "-" + date.substring(4, 6) + "-" + date.substring(6, 8);
            card.setIssueDate(formattedDate);
        }
        return card;
    }
}
