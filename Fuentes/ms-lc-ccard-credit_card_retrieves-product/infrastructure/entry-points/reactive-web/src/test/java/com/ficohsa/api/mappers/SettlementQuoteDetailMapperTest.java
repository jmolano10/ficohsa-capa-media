package com.ficohsa.api.mappers;

import com.ficohsa.api.dto.settlementquotedetails.request.SettlementQuoteDetailsRequestDto;
import com.ficohsa.api.dto.settlementquotedetails.response.SettlementQuoteDetailsResponseDto;
import com.ficohsa.model.settlementquotedetails.SettlementQuoteDetails;
import com.ficohsa.model.settlementquotedetails.SettlementQuoteDetailsModel;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.mapstruct.factory.Mappers;

import static org.junit.jupiter.api.Assertions.*;

class SettlementQuoteDetailMapperTest {

    private SettlementQuoteDetailMapper mapper;

    @BeforeEach
    void setUp() {
        mapper = Mappers.getMapper(SettlementQuoteDetailMapper.class);
    }

    @Test
    void toDomain_MapsAllFields() {
        SettlementQuoteDetailsRequestDto.RequestData requestData = SettlementQuoteDetailsRequestDto.RequestData.builder()
                .accountNumber("123456")
                .organizationReference("ORG001")
                .financingPlanReference("PLAN001")
                .paymentSequenceNumber("1")
                .cancellationDate("2024-12-31")
                .repaymentAmount(1000.0)
                .paymentType(1)
                .build();

        SettlementQuoteDetails result = mapper.toDomain(requestData);

        assertNotNull(result);
        assertEquals("123456", result.getAccountNumber());
        assertEquals("ORG001", result.getOrganizationReference());
        assertEquals("PLAN001", result.getFinancingPlanReference());
        assertEquals("1", result.getPaymentSequenceNumber());
        assertEquals("2024-12-31", result.getCancellationDate());
        assertEquals(1000.0, result.getRepaymentAmount());
        assertEquals(1, result.getPaymentType());
    }

    @Test
    void toResponse_MapsAllFields() {
        SettlementQuoteDetailsModel.PlanData planData = SettlementQuoteDetailsModel.PlanData.builder()
                .productReference("PROD001")
                .productType("TYPE1")
                .productDescription("Description")
                .quoteType("QUOTE1")
                .settlementDate("2024-12-31")
                .planSettlementAmount("5000.00")
                .repaymentType("MONTHLY")
                .repaymentMethod("AUTO")
                .newTerm("12")
                .newPaymentAmount("500.00")
                .build();

        SettlementQuoteDetailsModel.SettlementQuoteInquiry inquiry = SettlementQuoteDetailsModel.SettlementQuoteInquiry.builder()
                .organizationReference("ORG001")
                .alternateOrganization("ALT001")
                .organizationLogo("logo.png")
                .accountNumber("123456")
                .creditCardId("CARD001")
                .accountSettlementDate("2024-12-31")
                .accountSettlementAmount("10000.00")
                .planData(planData)
                .build();

        SettlementQuoteDetailsModel domain = SettlementQuoteDetailsModel.builder()
                .settlementQuoteInquiry(inquiry)
                .build();

        SettlementQuoteDetailsResponseDto result = mapper.toResponse(domain);

        assertNotNull(result);
        assertEquals("ORG001", result.organizationReference());
        assertEquals("123456", result.accountNumber());

        assertNotNull(result.planData());
        assertEquals("PROD001", result.planData().productReference());
        assertEquals("500.00", result.planData().newPaymentAmount());
    }

    @Test
    void toResponse_WithNullPlanData_HandledGracefully() {
        SettlementQuoteDetailsModel.SettlementQuoteInquiry inquiry = SettlementQuoteDetailsModel.SettlementQuoteInquiry.builder()
                .organizationReference("ORG001")
                .accountNumber("123456")
                .planData(null)
                .build();

        SettlementQuoteDetailsModel domain = SettlementQuoteDetailsModel.builder()
                .settlementQuoteInquiry(inquiry)
                .build();

        SettlementQuoteDetailsResponseDto result = mapper.toResponse(domain);
        assertNotNull(result);
        assertNull(result.planData());
    }
}
