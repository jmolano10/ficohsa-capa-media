package com.ficohsa.driven.creditcard.cachecomponent.mapper;

import com.ficohsa.driven.creditcard.cachecomponent.dto.request.CacheComponentRequest;
import com.ficohsa.driven.creditcard.cachecomponent.dto.response.CacheSettlementQuoteDetailsResponse;
import com.ficohsa.model.settlementquotedetails.SettlementQuoteDetailsModel;
import lombok.experimental.UtilityClass;

@UtilityClass
public class CacheComponentMapper {

    public static SettlementQuoteDetailsModel toModel(CacheSettlementQuoteDetailsResponse response) {
        return SettlementQuoteDetailsModel.builder()
                .settlementQuoteInquiry(buildSettlementQuoteInquiry(response))
                .build();
    }

    public static SettlementQuoteDetailsModel.SettlementQuoteInquiry buildSettlementQuoteInquiry(CacheSettlementQuoteDetailsResponse response) {
        return SettlementQuoteDetailsModel.SettlementQuoteInquiry.builder()
                .organizationReference(response.getValue().getOrg())
                .alternateOrganization(response.getValue().getForeignOrg())
                .organizationLogo(response.getValue().getLogo())
                .accountNumber(response.getValue().getAccountNumber())
                .creditCardId(response.getValue().getCardNumber())
                .accountSettlementDate(response.getValue().getAccountPayoffDate())
                .accountSettlementAmount(response.getValue().getAccountPayoffAmount())
                .planData(buildPlanData(response))
                .build();
    }

    public static SettlementQuoteDetailsModel.PlanData buildPlanData(CacheSettlementQuoteDetailsResponse response) {
        return SettlementQuoteDetailsModel.PlanData.builder()
                .productReference(response.getValue().getPlanData().getPlanRef())
                .productType(response.getValue().getPlanData().getPlanType())
                .productDescription(response.getValue().getPlanData().getPlanDescription())
                .quoteType(response.getValue().getPlanData().getQuoteType())
                .settlementDate(response.getValue().getPlanData().getPayoffDate())
                .planSettlementAmount(response.getValue().getPlanData().getPlanPayoffAmount())
                .repaymentType(response.getValue().getPlanData().getPaymentType())
                .repaymentMethod(response.getValue().getPlanData().getMethodPayment())
                .newTerm(response.getValue().getPlanData().getNewTerm())
                .newPaymentAmount(response.getValue().getPlanData().getNewPaymentAmount())
                .build();
    }

    @SuppressWarnings("java:S1172")
    public static CacheComponentRequest toEntity(SettlementQuoteDetailsModel model){
        return CacheComponentRequest.builder().build();
    }
}
