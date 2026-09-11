package com.ficohsa.api.handlers;

import com.ficohsa.api.dto.associatedcards.AssociatedCardsRequestDataDto;
import com.ficohsa.api.dto.associatedcards.AssociatedCardsResponseDto;
import com.ficohsa.api.mappers.AssociatedCardsMapper;
import com.ficohsa.api.mappers.CreditCardPortfolioResponseMapper;
import com.ficohsa.lib.core.exception.BadRequestException;
import com.ficohsa.lib.core.exception.UnprocessableEntityException;
import com.ficohsa.lib.core.utility.AppTool;
import com.ficohsa.model.exception.enums.RegionErrorCode;
import com.ficohsa.ports.IAssociatedCards;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import reactor.core.publisher.Mono;

import java.util.Set;

@Slf4j
@Component
@RequiredArgsConstructor
public class AssociatedActiveCardsHandler {

    private static final Set<String> VALID_REGIONS = Set.of("HN01", "GT01", "SV01", "NI01", "CR01", "PA01");

    private final IAssociatedCards associatedCards;
    private final AssociatedCardsMapper associatedCardsMapper;
    private final CreditCardPortfolioResponseMapper responseMapper;

    public Mono<AssociatedCardsResponseDto> handle(AssociatedCardsRequestDataDto request) {
        return Mono.just(associatedCardsMapper.toDomain(request))
                .flatMap(creditCardRetrieve -> AppTool.context().map(appContext -> {
                    creditCardRetrieve.setRegion(appContext.sourceBank());
                    return creditCardRetrieve;
                }))
                .flatMap(creditCardRetrieve -> validateRegion(creditCardRetrieve.getRegion())
                        .then(Mono.just(creditCardRetrieve)))
                .flatMap(associatedCards::execute)
                .map(responseMapper::toResponse);
    }

    private Mono<Void> validateRegion(String region) {
        if (region == null || region.trim().isEmpty()) {
            return Mono.error(new BadRequestException(RegionErrorCode.REGION_FORMAT_INVALID.getMessage()));
        }
        if (!VALID_REGIONS.contains(region)) {
            return Mono.error(new UnprocessableEntityException(RegionErrorCode.REGION_NOT_AVAILABLE.getMessage()));
        }
        return Mono.empty();
    }
}
