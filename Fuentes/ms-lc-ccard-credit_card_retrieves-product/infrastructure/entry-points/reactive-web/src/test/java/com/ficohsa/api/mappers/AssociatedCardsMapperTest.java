package com.ficohsa.api.mappers;

import com.ficohsa.api.dto.CreditCardRetrieveRequestDto;
import com.ficohsa.api.dto.CustomerFilterDto;
import com.ficohsa.api.dto.associatedcards.AssociatedCardsRequestDataDto;
import com.ficohsa.model.associatedcards.CreditCardRetrieve;
import org.junit.jupiter.api.Test;
import org.mapstruct.factory.Mappers;

import static org.junit.jupiter.api.Assertions.assertEquals;
import static org.junit.jupiter.api.Assertions.assertNotNull;

class AssociatedCardsMapperTest {

    private final AssociatedCardsMapper mapper = Mappers.getMapper(AssociatedCardsMapper.class);

    @Test
    void toDomain_WithCustomerId_SetsTypeCode1() {
        var request = AssociatedCardsRequestDataDto.builder()
                .creditCardRetrieveRequest(CreditCardRetrieveRequestDto.builder()
                        .customerFilter(CustomerFilterDto.builder()
                                .customerIdentificationType("CUSTOMER_ID")
                                .build())
                        .build())
                .build();

        CreditCardRetrieve result = mapper.toDomain(request);

        assertNotNull(result);
        assertNotNull(result.getCustomerFilter());
        assertEquals(1, result.getCustomerFilter().getCustomerIdentificationTypeCode());
    }

    @Test
    void toDomain_WithLegalId_SetsTypeCode2() {
        var request = AssociatedCardsRequestDataDto.builder()
                .creditCardRetrieveRequest(CreditCardRetrieveRequestDto.builder()
                        .customerFilter(CustomerFilterDto.builder()
                                .customerIdentificationType("LEGAL_ID")
                                .build())
                        .build())
                .build();

        CreditCardRetrieve result = mapper.toDomain(request);

        assertNotNull(result);
        assertNotNull(result.getCustomerFilter());
        assertEquals(2, result.getCustomerFilter().getCustomerIdentificationTypeCode());
    }

    @Test
    void toDomain_WithOtherType_DoesNotSetTypeCode() {
        var request = AssociatedCardsRequestDataDto.builder()
                .creditCardRetrieveRequest(CreditCardRetrieveRequestDto.builder()
                        .customerFilter(CustomerFilterDto.builder()
                                .customerIdentificationType("OTHER")
                                .build())
                        .build())
                .build();

        CreditCardRetrieve result = mapper.toDomain(request);

        assertNotNull(result);
        assertNotNull(result.getCustomerFilter());
    }

    @Test
    void toDomain_WithNullCustomerFilter_HandlesGracefully() {
        var request = AssociatedCardsRequestDataDto.builder()
                .creditCardRetrieveRequest(CreditCardRetrieveRequestDto.builder().build())
                .build();

        CreditCardRetrieve result = mapper.toDomain(request);

        assertNotNull(result);
    }
}
