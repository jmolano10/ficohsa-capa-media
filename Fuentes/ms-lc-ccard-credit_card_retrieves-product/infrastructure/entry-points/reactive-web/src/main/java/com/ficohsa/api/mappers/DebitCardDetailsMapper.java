package com.ficohsa.api.mappers;

import com.ficohsa.api.dto.CustomerInquiryDto;
import com.ficohsa.api.dto.DebitCardDetailsDto;
import com.ficohsa.api.dto.DebitCardInquiryDto;
import com.ficohsa.model.debitcarddetails.CustomerInquiry;
import com.ficohsa.model.debitcarddetails.DebitCardDetails;
import com.ficohsa.model.debitcarddetails.DebitCardInquiry;
import org.mapstruct.Mapper;

@Mapper(componentModel = "spring")
public interface DebitCardDetailsMapper {

    DebitCardDetailsDto toDto(DebitCardDetails domain);

    CustomerInquiryDto toDto(CustomerInquiry domain);

    DebitCardInquiryDto toDto(DebitCardInquiry domain);
}
