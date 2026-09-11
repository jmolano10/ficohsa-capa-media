package com.ficohsa.api.mappers;

import com.ficohsa.api.dto.associatedcards.AssociatedCardsRequestDataDto;
import com.ficohsa.model.associatedcards.CreditCardRetrieve;
import org.mapstruct.AfterMapping;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;
import org.mapstruct.MappingTarget;

@Mapper(componentModel = "spring")
public interface AssociatedCardsMapper {

    @Mapping(source = "creditCardRetrieveRequest.customerFilter", target = "customerFilter")
    @Mapping(source = "creditCardRetrieveRequest.creditCardStatus", target = "creditCardStatus")
    @Mapping(source = "creditCardRetrieveRequest.filterCriterias", target = "filterCriterias")
    CreditCardRetrieve toDomain(AssociatedCardsRequestDataDto request);

    @AfterMapping
    default void setCustomerIdentificationTypeCode(@MappingTarget CreditCardRetrieve target, AssociatedCardsRequestDataDto source) {
        if (target.getCustomerFilter() != null && source.creditCardRetrieveRequest() != null && source.creditCardRetrieveRequest().customerFilter() != null) {
            String identificationType = source.creditCardRetrieveRequest().customerFilter().customerIdentificationType();
            if ("CUSTOMER_ID".equals(identificationType)) {
                target.getCustomerFilter().setCustomerIdentificationTypeCode(1);
            } else if ("LEGAL_ID".equals(identificationType)) {
                target.getCustomerFilter().setCustomerIdentificationTypeCode(2);
            }
        }
    }
}
