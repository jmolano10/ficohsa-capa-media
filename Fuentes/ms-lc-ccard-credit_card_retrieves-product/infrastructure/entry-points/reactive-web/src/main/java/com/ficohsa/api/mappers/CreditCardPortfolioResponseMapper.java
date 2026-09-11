package com.ficohsa.api.mappers;

import com.ficohsa.api.dto.associatedcards.AssociatedCardsResponseDto;
import com.ficohsa.api.dto.associatedcards.CreditCardPortfolioResponseDto;
import com.ficohsa.model.associatedcards.CreditCardPortfolio;
import org.mapstruct.Mapper;
import org.mapstruct.Mapping;

@Mapper(componentModel = "spring")
public interface CreditCardPortfolioResponseMapper {

    @Mapping(source = ".", target = "creditCardPortfolio")
    AssociatedCardsResponseDto toResponse(CreditCardPortfolio portfolio);

    CreditCardPortfolioResponseDto toPortfolioResponse(CreditCardPortfolio portfolio);
}
