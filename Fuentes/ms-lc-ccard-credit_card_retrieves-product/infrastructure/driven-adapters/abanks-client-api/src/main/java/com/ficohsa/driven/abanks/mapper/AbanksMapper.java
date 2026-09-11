package com.ficohsa.driven.abanks.mapper;

import com.ficohsa.driven.abanks.dto.response.AbanksDataDto;
import com.ficohsa.driven.abanks.dto.response.AbanksResponse;
import com.ficohsa.driven.abanks.dto.response.DebitCardDetailsDataDto;
import com.ficohsa.driven.abanks.dto.response.DebitCardDetailsResponse;
import com.ficohsa.model.debitbasicinformation.DebitAccounts;
import com.ficohsa.model.debitbasicinformation.DebitBasicInformation;
import com.ficohsa.model.debitbasicinformation.LinkedAccounts;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Component
public class AbanksMapper {

    public DebitBasicInformation mapToDebitBasicInformation(AbanksResponse response) {
        if (response == null || response.getResultSet().isEmpty()) {
            return null;
        }

        AbanksDataDto data = response.getResultSet().get(0);

        if (!"SUCCESS".equals(data.getCodigoError()) || !"0".equals(data.getCodigoRetorno())) {
            return null;
        }

        var accounts = splitSafe(data.getCuenta());
        var currencies = splitSafe(data.getCodigoMoneda());
        var orders = splitSafe(data.getOrdenCuentas());

        LinkedAccounts linkedAccounts = buildLinkedAccounts(accounts, currencies, orders);

        return new DebitBasicInformation(
            data.getCodigoCliente(),
            data.getNombreTarjeta(),
            data.getTipoTarjeta(),
            data.getEstatusTarjeta(),
            linkedAccounts
        );
    }

    private LinkedAccounts buildLinkedAccounts(String[] accounts, String[] currencies, String[] orders) {
        List<DebitAccounts> primaryAccounts = new ArrayList<>();
        List<DebitAccounts> secondaryAccounts = new ArrayList<>();

        for (int i = 0; i < accounts.length; i++) {
            if (accounts[i].trim().isEmpty()) {
                continue;
            }
            String currency = i < currencies.length ? currencies[i] : null;
            DebitAccounts account = new DebitAccounts(accounts[i], currency);
            boolean isPrimary = isPrimaryAccount(orders, i);

            if (isPrimary) {
                primaryAccounts.add(account);
            } else {
                secondaryAccounts.add(account);
            }
        }

        return new LinkedAccounts(primaryAccounts, secondaryAccounts);
    }

    private boolean isPrimaryAccount(String[] orders, int index) {
        if (index >= orders.length) {
            return index % 2 == 0;
        }
        return "P".equalsIgnoreCase(orders[index]) ||
               "PRIMARY".equalsIgnoreCase(orders[index]) ||
               "1".equals(orders[index]);
    }

    private String[] splitSafe(String value) {
        return value != null ? value.split(";") : new String[0];
    }

    public com.ficohsa.model.debitcarddetails.DebitCardDetails mapToDebitCardDetails(DebitCardDetailsResponse response) {
        if (response == null || response.getData() == null) {
            return null;
        }

        DebitCardDetailsDataDto data = response.getData();

        if (!"00000".equals(data.getErrorCode())) {
            return null;
        }

        var debitCardDetails = new com.ficohsa.model.debitcarddetails.DebitCardDetails();

        var customerInquiry = new com.ficohsa.model.debitcarddetails.CustomerInquiry();
        customerInquiry.setCustomerIdentification(data.getCustomerId());
        debitCardDetails.setCustomerInquiry(customerInquiry);

        debitCardDetails.setDebitCardInquiry(buildDebitCardInquiries(data));

        return debitCardDetails;
    }

    private java.util.List<com.ficohsa.model.debitcarddetails.DebitCardInquiry> buildDebitCardInquiries(DebitCardDetailsDataDto data) {
        java.util.List<com.ficohsa.model.debitcarddetails.DebitCardInquiry> debitCardInquiries = new java.util.ArrayList<>();

        if (data.getCardNumber() == null) {
            return debitCardInquiries;
        }

        for (int i = 0; i < data.getCardNumber().size(); i++) {
            debitCardInquiries.add(buildSingleInquiry(data, i));
        }

        return debitCardInquiries;
    }

    private com.ficohsa.model.debitcarddetails.DebitCardInquiry buildSingleInquiry(DebitCardDetailsDataDto data, int i) {
        var inquiry = new com.ficohsa.model.debitcarddetails.DebitCardInquiry();
        inquiry.setCreditCardId(data.getCardNumber().get(i));
        inquiry.setCardHolderReference(getListValue(data.getCardHolderName(), i));
        inquiry.setProductType(getListValue(data.getCardType(), i));
        inquiry.setCardType(getListValue(data.getCardCategory(), i));
        inquiry.setIssueDate(getListValue(data.getCardIssueDate(), i));
        inquiry.setCardStatus(data.getCardStatus());
        return inquiry;
    }

    private String getListValue(java.util.List<String> list, int index) {
        if (list != null && index < list.size()) {
            return list.get(index);
        }
        return null;
    }
}
