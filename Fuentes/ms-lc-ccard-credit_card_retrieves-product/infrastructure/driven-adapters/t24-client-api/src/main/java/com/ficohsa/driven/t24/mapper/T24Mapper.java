package com.ficohsa.driven.t24.mapper;

import com.ficohsa.driven.t24.dto.DebitCardResponse;
import com.ficohsa.driven.t24.dto.response.T24Response;
import com.ficohsa.lib.core.exception.NotFoundException;
import com.ficohsa.model.debitbasicinformation.DebitAccounts;
import com.ficohsa.model.debitbasicinformation.DebitBasicInformation;
import com.ficohsa.model.debitbasicinformation.LinkedAccounts;
import com.ficohsa.model.debitcarddetails.CustomerInquiry;
import com.ficohsa.model.debitcarddetails.DebitCardDetails;
import com.ficohsa.model.debitcarddetails.DebitCardInquiry;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class T24Mapper {

    public DebitBasicInformation mapToDebitBasicInformation(T24Response response) {
        if (response.getData() == null || response.getData().getBody() == null ||
                response.getData().getBody().getConsultaMaestraTarjetaDebitoResponse() == null) {
            return null;
        }

        var consultaResponse = response.getData().getBody().getConsultaMaestraTarjetaDebitoResponse();
        var customerType = consultaResponse.getWsficodebitcardcustomerType();

        // Check if customerType is null
        if (customerType == null) {
            return null;
        }

        // Check if there are zero records
        if (customerType.getZerorecords() != null) {
            throw new NotFoundException("TARGET_NOT_FOUND");
        }

        // Check if we have customer detail data
        if (customerType.getGWsficodebitcardcustomerDetailType() == null ||
                customerType.getGWsficodebitcardcustomerDetailType().getMWsficodebitcardcustomerDetailType() == null) {
            return null;
        }

        var cardDetail = customerType.getGWsficodebitcardcustomerDetailType().getMWsficodebitcardcustomerDetailType();

        String mappedStatus = mapCardStatus(cardDetail.getCardstatus());

        List<DebitAccounts> primaryAccounts = parseAccounts(cardDetail.getPrimaryacct(), cardDetail.getCurrency1(), "\"");
        List<DebitAccounts> secondaryAccounts = parseAccounts(cardDetail.getScndryacct(), cardDetail.getCurrency1(), "!!");
        
        var linkedAccounts = new LinkedAccounts(primaryAccounts, secondaryAccounts);

        return new DebitBasicInformation(
                cardDetail.getCustomer(),
                cardDetail.getNameoncard(),
                cardDetail.getTypeofcard(),
                mappedStatus,
                linkedAccounts
        );
    }

    private String mapCardStatus(String t24Status) {
        return switch (t24Status) {
            case "90" -> "ACTIVE";
            case "93" -> "CANCELED";
            default -> "OTHERS";
        };
    }

    private List<DebitAccounts> parseAccounts(String accountData, String currency, String delimiter) {
        List<DebitAccounts> accounts = new ArrayList<>();
        
        if (accountData == null || accountData.trim().isEmpty()) {
            return accounts;
        }

        String[] parts = accountData.split(delimiter);
        for (String part : parts) {
            if (!part.trim().isEmpty()) {
                accounts.add(new DebitAccounts(part.trim(), currency));
            }
        }
        
        return accounts;
    }

    public DebitCardDetails mapToDebitCardDetails(DebitCardResponse response) {
        if (response.data() == null || response.data().body() == null ||
            response.data().body().consultaMaestraTarjetaDebitoResponse() == null) {
            return null;
        }

        var debitResponse = response.data().body().consultaMaestraTarjetaDebitoResponse();
        var customerType = debitResponse.wsficodebitcardcustomerType();

        // Check if there are zero records
        if (customerType.zerorecords() != null) {
            throw new NotFoundException("TARGET_NOT_FOUND");
        }        
        
        var cards = customerType
                .gWsficodebitcardcustomerDetailType()
                .mWsficodebitcardcustomerDetailType();

        if (cards == null || cards.isEmpty()) {
            return null;
        }

        var firstCard = cards.get(0);
        var customerInquiry = new CustomerInquiry();
        customerInquiry.setCustomerIdentification(firstCard.customer());
        
        var debitCardInquiries = cards.stream()
                .map(this::mapToDebitCardInquiry)
                .toList();

        var debitCardDetails = new DebitCardDetails();
        debitCardDetails.setCustomerInquiry(customerInquiry);
        debitCardDetails.setDebitCardInquiry(debitCardInquiries);
        return debitCardDetails;
    }

    private DebitCardInquiry mapToDebitCardInquiry(DebitCardResponse.MWsficodebitcardcustomerDetailType card) {
        var inquiry = new DebitCardInquiry();
        inquiry.setCreditCardId(card.cardnumber());
        inquiry.setCardHolderReference(card.nameoncard());
        inquiry.setProductType(card.typeofcard());
        inquiry.setCardType(card.producttype());
        inquiry.setIssueDate(card.issuedate());
        inquiry.setProductName(getProductName(card.cardnumber()));
        inquiry.setAccountCurrency(card.currency1());
        inquiry.setAssociationReference(card.primaryacct());
        inquiry.setCardStatus(mapCardStatusForDetails(card.cardstatus()));
        return inquiry;
    }

    private String mapCardStatusForDetails(String t24Status) {
        return switch (t24Status) {
            case "90" -> "ISSUED";
            case "91" -> "RETURNED";
            case "92" -> "SCRAP";
            case "93" -> "CANCEL";
            case "94" -> "ACTIVE";
            case "95" -> "DESTROYED";
            case "96" -> "BLOCKED";
            default -> "ALL";
        };
    }

    private String getProductName(String cardNumber) {
        if (cardNumber == null || cardNumber.isEmpty()) return "OTRA";
        return switch (cardNumber.charAt(0)) {
            case '4' -> "VISA";
            case '5' -> "MASTER CARD";
            case '3' -> "AMERICAN EXPRESS";
            default -> "OTRA";
        };
    }
}
