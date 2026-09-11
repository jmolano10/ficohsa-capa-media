package com.ficohsa.api.mappers;

import com.ficohsa.api.dto.settlementquotedetails.request.SettlementQuoteDetailsRequestDto;
import com.ficohsa.api.dto.settlementquotedetails.response.SettlementQuoteDetailsResponseDto;
import com.ficohsa.model.settlementquotedetails.SettlementQuoteDetails;
import com.ficohsa.model.settlementquotedetails.SettlementQuoteDetailsModel;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface SettlementQuoteDetailMapper {

    SettlementQuoteDetails toDomain(SettlementQuoteDetailsRequestDto.RequestData request);

    @Mapping(source = "settlementQuoteInquiry.organizationReference", target = "organizationReference")
    @Mapping(source = "settlementQuoteInquiry.alternateOrganization", target = "alternateOrganization")
    @Mapping(source = "settlementQuoteInquiry.organizationLogo", target = "organizationLogo")
    @Mapping(source = "settlementQuoteInquiry.accountNumber", target = "accountNumber")
    @Mapping(source = "settlementQuoteInquiry.creditCardId", target = "creditCardId")
    @Mapping(source = "settlementQuoteInquiry.accountSettlementDate", target = "accountSettlementDate")
    @Mapping(source = "settlementQuoteInquiry.accountSettlementAmount", target = "accountSettlementAmount")
    @Mapping(source = "settlementQuoteInquiry.planData", target = "planData")
    SettlementQuoteDetailsResponseDto toResponse(SettlementQuoteDetailsModel domain);

    SettlementQuoteDetailsResponseDto.PlanData toPlanData(SettlementQuoteDetailsModel.PlanData planData);
}
