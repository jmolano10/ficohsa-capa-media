package com.ficohsa.driven.cobis.mapper;

import com.ficohsa.driven.cobis.dto.request.CobisSpRequest;
import com.ficohsa.driven.cobis.dto.response.CobisDataDto;
import com.ficohsa.driven.cobis.dto.response.CobisResponse;
import com.ficohsa.driven.cobis.dto.response.CobisSpResponse;
import com.ficohsa.model.debitbasicinformation.DebitAccounts;
import com.ficohsa.model.debitbasicinformation.DebitBasicInformation;
import com.ficohsa.model.debitbasicinformation.LinkedAccounts;
import com.ficohsa.model.debitcarddetails.CustomerInquiry;
import com.ficohsa.model.debitcarddetails.DebitCardDetails;
import com.ficohsa.model.debitcarddetails.DebitCardInquiry;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

import java.util.ArrayList;
import java.util.List;

@Slf4j
@Component
public class CobisMapper {

    public DebitBasicInformation mapToDebitBasicInformation(CobisResponse response) {
        var opRespuesta = response.getData().getBody().getOpConsultaTarjetaDebitoRespuesta();
        var tarjeta = opRespuesta.getTarjeta();

        List<DebitAccounts> primaryAccounts = parseMultipleAccounts(
            opRespuesta.getCuentaPrincipal());
        List<DebitAccounts> secondaryAccounts = parseMultipleAccounts(
            opRespuesta.getCuentaSecundaria());

        var linkedAccounts = new LinkedAccounts(primaryAccounts, secondaryAccounts);

        return new DebitBasicInformation(
            tarjeta.getIdCliente(),
            tarjeta.getNombreTarjeta(),
            tarjeta.getCategoriaTarjeta(),
            tarjeta.getEstadoTarjeta(),
            linkedAccounts
        );
    }


    public DebitCardDetails mapToDebitCardDetails(CobisSpResponse response, CobisSpRequest request) {
        log.info("[ADAPTER] Mapping COBIS SP response: {}", response);
        if (response.getData() == null || response.getData().getResultSet1() == null || response.getData().getResultSet1().isEmpty()) {
            throw new com.ficohsa.lib.core.exception.NotFoundException("No debit card details found");
        }

        var cards = response.getData().getResultSet1();

        var customerInquiry = new CustomerInquiry();
        customerInquiry.setCustomerIdentification(request.getData().getParams().get("i_CUSTOMER_ID"));

        var debitCardInquiries = cards.stream()
                .map(this::mapToDebitCardInquiry)
                .toList();

        var debitCardDetails = new DebitCardDetails();
        debitCardDetails.setCustomerInquiry(customerInquiry);
        debitCardDetails.setDebitCardInquiry(debitCardInquiries);
        return debitCardDetails;
    }

    private DebitCardInquiry mapToDebitCardInquiry(CobisSpResponse.CobisSpCardData card) {
        var inquiry = new DebitCardInquiry();
        inquiry.setCreditCardId(card.getCardNumber());
        inquiry.setCardHolderReference(card.getCardHolderName());
        inquiry.setProductType("DEBITO");
        inquiry.setCardType(card.getCardCategory());
        inquiry.setIssueDate(card.getIssueDate());
        inquiry.setProductName(card.getCardBrand());
        inquiry.setAccountCurrency(card.getCardCurrency());
        inquiry.setAssociationReference(card.getCardAccountNumber());
        inquiry.setCardStatus(card.getCardStatus());
        return inquiry;
    }

    private List<DebitAccounts> parseMultipleAccounts(CobisDataDto.CuentaPrincipalDto cuenta) {
        List<DebitAccounts> accounts = new ArrayList<>();

        if (cuenta == null || cuenta.getNumCuenta() == null || cuenta.getNumCuenta().isEmpty()) {
            return accounts;
        }

        // Check if account numbers are separated by common delimiters
        String[] accountNumbers = cuenta.getNumCuenta().split("[;,|]");

        for (String accountNumber : accountNumbers) {
            if (!accountNumber.trim().isEmpty()) {
                accounts.add(new DebitAccounts(accountNumber.trim(), cuenta.getMoneda()));
            }
        }

        return accounts;
    }

    private List<DebitAccounts> parseMultipleAccounts(CobisDataDto.CuentaSecundariaDto cuenta) {
        List<DebitAccounts> accounts = new ArrayList<>();

        if (cuenta == null || cuenta.getNumCuenta() == null || cuenta.getNumCuenta().isEmpty()) {
            return accounts;
        }

        // Check if account numbers are separated by common delimiters
        String[] accountNumbers = cuenta.getNumCuenta().split("[;,|]");

        for (String accountNumber : accountNumbers) {
            if (!accountNumber.trim().isEmpty()) {
                accounts.add(new DebitAccounts(accountNumber.trim(), cuenta.getMoneda()));
            }
        }

        return accounts;
    }
}
