package com.ficohsa.model.settlementquotedetails;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class SettlementQuoteDetails {
    private String accountNumber;
    private String organizationReference;
    private String financingPlanReference;
    private String paymentSequenceNumber;
    private String cancellationDate;
    private Double repaymentAmount;
    private Integer paymentType;
    private String region;
    private String callService;
}
