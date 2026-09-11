package com.ficohsa.driven.creditcard.datawarehouse.mapper;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.ficohsa.driven.creditcard.datawarehouse.dto.response.*;
import com.ficohsa.driven.creditcard.datawarehouse.utility.XmlToJsonConverterService;
import com.ficohsa.lib.core.exception.InternalServerException;
import com.ficohsa.model.*;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.json.JSONObject;
import org.springframework.stereotype.Component;

import java.util.Collections;
import java.util.List;
import java.util.Optional;

@Slf4j
@Component
@RequiredArgsConstructor
public class DataWareHouseMapper implements IDataWareHouseMapper {

    private final XmlToJsonConverterService xmlToJsonConverterService;
    private final ObjectMapper objectMapper;

    @Override
    public CreditCardsDetails mapToCreditCardsDetails(DataWareHouseResponse response) {
        if (response == null || response.getData() == null || 
            response.getData().getResultSet() == null || 
            response.getData().getResultSet().isEmpty()) {
            return new CreditCardsDetails(Collections.emptyList(), null, null, null, null, null, null);
        }

        String xmlString = response.getData().getResultSet().getFirst().getCliente();
        if (xmlString == null || xmlString.trim().isEmpty()) {
            return new CreditCardsDetails(Collections.emptyList(), null, null, null, null, null, null);
        }

        try {
            JSONObject jsonObject = xmlToJsonConverterService.convertXmlToJson(xmlString);
            String jsonString = jsonObject.toString();
            
            // Log para debug
            log.info("[ADAPTER] XML input: {}", xmlString);
            log.info("[ADAPTER] JSON converted: {}", jsonString);

            RootDto result = objectMapper.readValue(jsonString, RootDto.class);
            log.info("[ADAPTER] Mapped client: {}", result);
            CardAccountDto cardAccountDto = result.getClient().getCreditCardDto().getCardAccountDto();
            
            CreditCard creditCard = mapToCreditCard(cardAccountDto);
            CreditCardTransactions transactions = mapToCreditCardTransactions(cardAccountDto);
            CashInformation cashInfo = mapToCashInformation(cardAccountDto);
            
            return new CreditCardsDetails(
                List.of(creditCard),
                transactions,
                cashInfo,
                getExtraFee(cardAccountDto),
                getIntraFee(cardAccountDto),
                cardAccountDto.getExtraBalance(),
                cardAccountDto.getIntraBalance()
            );
        } catch (JsonProcessingException e) {
            throw new InternalServerException("Error mapping JSON to Customer: " + e.getMessage());
        }
    }

    private CreditCard mapToCreditCard(CardAccountDto cardAccountDto) {
        return new CreditCard(
            new AccountIdentification(cardAccountDto.getAccount()),
            new AccountRestrictionStatus(cardAccountDto.getStatus()),
            cardAccountDto.getAffinityGroup(),
            new CreditCardProductName(cardAccountDto.getProduct()),
            parseInteger(cardAccountDto.getClearingModel()),
            cardAccountDto.getOpeningDate(),
            cardAccountDto.getCancelationDate(),
            cardAccountDto.getLastExtraDate(),
            parseInteger(cardAccountDto.getCurrentDue()),
            new LimitAmount(parseDouble(cardAccountDto.getCurrentLimit())),
            parseDouble(cardAccountDto.getCurrentBalance()),
            parseDouble(cardAccountDto.getClosingBalance()),
            parseDouble(cardAccountDto.getExtraBalance()),
            parseDouble(cardAccountDto.getIntraBalance()),
            parseDouble(cardAccountDto.getActiveExtraInstallments()),
            cardAccountDto.getLockcode1(),
            cardAccountDto.getLockcode2(),
            cardAccountDto.getLogo(),
            cardAccountDto.getAvailableCash(),
            cardAccountDto.getLockDate1(),
            cardAccountDto.getLockDate2(),
            cardAccountDto.getBin(),
            cardAccountDto.getExtraApprovalDate(),
            cardAccountDto.getIntraApprovalDate(),
            cardAccountDto.getPilApprovalDate(),
            cardAccountDto.getPriorLimit(),
            cardAccountDto.getAuthBalance()
        );
    }

    private CreditCardTransactions mapToCreditCardTransactions(CardAccountDto cardAccountDto) {
        Transaction transaction = getFirstTransaction(cardAccountDto);
        if (transaction == null) {
            return new CreditCardTransactions(null, null, null, null, null, null, null, null, null, null, null, null, null);
        }

        return new CreditCardTransactions(
            transaction.getPeriodDate(),
            transaction.getPeriodBalance(),
            transaction.getAmountDue(),
            transaction.getPayments(),
            transaction.getMerchSales(),
            transaction.getCashWithdrawal(),
            transaction.getLimit(),
            transaction.getOtherTransactions(),
            transaction.getInterest(),
            transaction.getTotalFees(),
            transaction.getOtherDebits(),
            transaction.getCycleDue(),
            transaction.getCycleTotalBalance()
        );
    }

    private CashInformation mapToCashInformation(CardAccountDto cardAccountDto) {
        Transaction transaction = getFirstTransaction(cardAccountDto);
        if (transaction == null) {
            return new CashInformation(null, null, null, null, null, null, null, null);
        }

        ExtraCashInfo extraCash = transaction.getExtraCashInfo();
        IntraCashInfo intraCash = transaction.getIntraCashInfo();

        return new CashInformation(
            extraCash != null ? extraCash.getBalance() : null,
            extraCash != null ? extraCash.getInstallment() : null,
            extraCash != null ? extraCash.getInterest() : null,
            extraCash != null ? extraCash.getFee() : null,
            intraCash != null ? intraCash.getBalance() : null,
            intraCash != null ? intraCash.getInstallment() : null,
            intraCash != null ? intraCash.getInterest() : null,
            intraCash != null ? intraCash.getFee() : null
        );
    }

    private String getExtraFee(CardAccountDto cardAccountDto) {
        Transaction transaction = getFirstTransaction(cardAccountDto);
        return transaction != null ? transaction.getExtraFee() : null;
    }

    private String getIntraFee(CardAccountDto cardAccountDto) {
        Transaction transaction = getFirstTransaction(cardAccountDto);
        return transaction != null ? transaction.getIntraFee() : null;
    }

    private Transaction getFirstTransaction(CardAccountDto cardAccountDto) {
        return Optional.ofNullable(cardAccountDto.getProductTransactions())
            .map(ProductTransactions::getTransaction)
            .filter(transactions -> !transactions.isEmpty())
            .map(transactions -> transactions.get(0))
            .orElse(null);
    }

    private Double parseDouble(String value) {
        if (value == null || value.trim().isEmpty()) {
            return null;
        }
        try {
            return Double.parseDouble(value);
        } catch (NumberFormatException e) {
            return null;
        }
    }

    private Integer parseInteger(String value) {
        if (value == null || value.trim().isEmpty()) {
            return null;
        }
        try {
            return Integer.parseInt(value);
        } catch (NumberFormatException e) {
            return null;
        }
    }
}
