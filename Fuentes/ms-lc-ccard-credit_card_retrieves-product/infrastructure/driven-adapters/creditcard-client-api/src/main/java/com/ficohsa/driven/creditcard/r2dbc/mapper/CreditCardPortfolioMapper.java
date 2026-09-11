package com.ficohsa.driven.creditcard.r2dbc.mapper;

import com.ficohsa.driven.creditcard.r2dbc.dto.CreditCardRowDto;
import com.ficohsa.helper.RegionMappingService;
import com.ficohsa.model.associatedcards.CreditCardDetail;
import com.ficohsa.model.associatedcards.CreditCardPortfolio;
import org.mapstruct.*;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;

@Mapper(componentModel = "spring", injectionStrategy = InjectionStrategy.CONSTRUCTOR)
public abstract class CreditCardPortfolioMapper {

    protected RegionMappingService regionMappingService;

    @Autowired
    public void setRegionMappingService(RegionMappingService regionMappingService) {
        this.regionMappingService = regionMappingService;
    }

    @Mapping(target = "additionalInformation.fieldInformation.nameField", source = "nameField")
    @Mapping(target = "additionalInformation.fieldInformation.valueField", source = "valueField")
    public abstract CreditCardDetail toDomain(CreditCardRowDto row);

    @AfterMapping
    protected void setCardProductName(@MappingTarget CreditCardDetail target, CreditCardRowDto source) {
        target.setCardProductName(regionMappingService.getCardBrand(source.getCreditCardId()));
    }

    protected void mapWithRegion(@MappingTarget CreditCardDetail target, CreditCardRowDto source, String region) {
        target.setCardProductName(regionMappingService.getCardBrand(source.getCreditCardId()));
        target.setCardEffectiveDate(regionMappingService.formatCardEffectiveDate(region, source.getCardEffectiveDate()));
    }

    public CreditCardDetail toDomainWithRegion(CreditCardRowDto row, String region) {
        CreditCardDetail detail = toDomain(row);
        mapWithRegion(detail, row, region);
        return detail;
    }

    public CreditCardPortfolio toDomainPortfolio(List<CreditCardRowDto> rows) {
        CreditCardPortfolio portfolio = new CreditCardPortfolio();
        portfolio.setCreditCardDetails(rows.stream().map(this::toDomain).toList());
        return portfolio;
    }

    public CreditCardPortfolio toDomainPortfolioWithRegion(List<CreditCardRowDto> rows, String region) {
        CreditCardPortfolio portfolio = new CreditCardPortfolio();
        portfolio.setCreditCardDetails(rows.stream().map(row -> toDomainWithRegion(row, region)).toList());
        return portfolio;
    }
}
