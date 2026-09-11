package com.ficohsa.api.handlers;

import com.ficohsa.lib.core.exception.BadRequestException;
import com.ficohsa.lib.core.exception.UnprocessableEntityException;
import com.ficohsa.lib.core.utility.AppTool;
import com.ficohsa.model.cardposition.CreditCardStatement;
import com.ficohsa.model.exception.enums.RegionErrorCode;
import com.ficohsa.ports.ICardPosition;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.reactive.function.server.ServerRequest;
import reactor.core.publisher.Mono;

import java.util.Set;

@Slf4j
@Component
@RequiredArgsConstructor
public class CardPositionHandler {

    private static final Set<String> VALID_REGIONS = Set.of("HN01", "GT01", "SV01", "NI01", "CR01", "PA01");

    private final ICardPosition cardPosition;

    public Mono<CreditCardStatement> handle(ServerRequest request) {
        String creditCardId = request.pathVariable("creditCardId");
        String month = request.queryParams().getFirst("month");
        String year = request.queryParams().getFirst("year");

        try {
            if (month != null) {
                Integer.parseInt(month);
            }
            if (year != null) {
                Integer.parseInt(year);
            }
        } catch (NumberFormatException ex) {
            return Mono.error(new BadRequestException("The month and year fields must be numeric"));
        }

        return AppTool.context()
                .flatMap(ctx -> validateRegion(ctx.sourceBank())
                        .then(cardPosition.rtvCardPosition(creditCardId, ctx.sourceBank(), ctx.destinationBank())));
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
