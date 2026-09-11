package com.ficohsa.driven.visionplus.mapper;

import com.ficohsa.driven.visionplus.dto.request.VisionPlusRequest;
import com.ficohsa.driven.visionplus.dto.response.VisionPlusResponse;
import com.ficohsa.model.settlementquotedetails.SettlementQuoteDetails;
import com.ficohsa.model.settlementquotedetails.SettlementQuoteDetailsModel;
import lombok.experimental.UtilityClass;


@UtilityClass
public class VisionPlusMapper {

    public static VisionPlusRequest toEntity(SettlementQuoteDetails request) {
        var innerRequestBuilder = VisionPlusRequest.SettlementQuoteInquiryRequest.builder()
                .organization(request.getOrganizationReference())
                .account(request.getAccountNumber())
                .plan(request.getFinancingPlanReference())
                .planSequence(request.getPaymentSequenceNumber())
                .serviceFunctionCode("N")
                .serviceStartSequenceNumber("01")
                .payoffByDate(request.getCancellationDate())
                .settlementQuoteType("P");

        if (request.getRepaymentAmount() != null) {
            innerRequestBuilder.partialSettlementAmount(String.format("%.2f", request.getRepaymentAmount()));
        }

        if (request.getPaymentType() != null) {
            innerRequestBuilder.psType(String.valueOf(request.getPaymentType()));
        }

        var cacheKeyFields = VisionPlusRequest.CacheKeyFields.builder()
                .org(request.getOrganizationReference())
                .accountNumber(request.getAccountNumber())
                .planNumber(request.getFinancingPlanReference())
                .seccuenceNumber(request.getPaymentSequenceNumber())
                .cancellationDate(request.getCancellationDate())
                .build();

        var visionPlusData = VisionPlusRequest.VisionPlusData.builder()
                .request(innerRequestBuilder.build())
                .build();

        return VisionPlusRequest.builder()
                .data(visionPlusData)
                .cacheKeyFields(cacheKeyFields)
                .build();
    }

    public static SettlementQuoteDetailsModel toModel(VisionPlusResponse response) {
        return SettlementQuoteDetailsModel.builder()
                .settlementQuoteInquiry(createSettlementQuoteInquiry(response))
                .build();
    }

    private static SettlementQuoteDetailsModel.SettlementQuoteInquiry createSettlementQuoteInquiry(VisionPlusResponse response) {
        if (response == null || response.getData() == null || response.getData().getBody() == null ||
                response.getData().getBody().getSettlementQuoteInquiryResponse() == null) {
            return SettlementQuoteDetailsModel.SettlementQuoteInquiry.builder().build();
        }

        var innerResponse = response.getData().getBody().getSettlementQuoteInquiryResponse();

        return SettlementQuoteDetailsModel.SettlementQuoteInquiry.builder()
                .organizationReference(innerResponse.getOrg())
                .alternateOrganization(innerResponse.getForeignOrg())
                .organizationLogo(innerResponse.getLogo())
                .accountNumber(innerResponse.getAccountNumber())
                .creditCardId(innerResponse.getCardNumber())
                .accountSettlementDate(innerResponse.getAccountPayoffDate())
                .accountSettlementAmount(innerResponse.getAccountPayoffAmount())
                .planData(createPlanData(innerResponse))
                .build();
    }

    private static SettlementQuoteDetailsModel.PlanData createPlanData(VisionPlusResponse.SettlementQuoteInquiryResponse innerResponse) {
        if (innerResponse.getPlanData() == null ||
                innerResponse.getPlanData().getArxqioPlanEntry() == null ||
                innerResponse.getPlanData().getArxqioPlanEntry().isEmpty()) {
            return null;
        }

        var planEntry = innerResponse.getPlanData().getArxqioPlanEntry().get(0);

        return SettlementQuoteDetailsModel.PlanData.builder()
                .productReference(planEntry.getPlanRef())
                .productType(planEntry.getPlanType())
                .productDescription(planEntry.getPlanDescription())
                .quoteType(planEntry.getQuoteType())
                .settlementDate(planEntry.getPayoffDate1())
                .planSettlementAmount(planEntry.getPlanPayoffAmount1())
                .repaymentType(planEntry.getPartialSetlType())
                .repaymentMethod(planEntry.getPsQuoteType())
                .newTerm(planEntry.getPsNewTerm())
                .newPaymentAmount(planEntry.getPsNewFixedPmtAmt())
                .build();
    }
}
