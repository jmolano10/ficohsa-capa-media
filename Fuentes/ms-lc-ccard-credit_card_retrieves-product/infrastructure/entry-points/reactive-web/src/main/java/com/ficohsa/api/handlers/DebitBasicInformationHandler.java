package com.ficohsa.api.handlers;

import com.ficohsa.lib.core.exception.BadRequestException;
import com.ficohsa.lib.core.exception.UnprocessableEntityException;
import com.ficohsa.lib.core.utility.AppTool;
import com.ficohsa.model.debitbasicinformation.DebitBasicInformation;
import com.ficohsa.model.exception.enums.RegionErrorCode;
import com.ficohsa.ports.IDebitBasicInformation;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.reactive.function.server.ServerRequest;
import reactor.core.publisher.Mono;

import java.util.Set;

@Slf4j
@Component
@RequiredArgsConstructor
public class DebitBasicInformationHandler {

    private static final Set<String> VALID_REGIONS = Set.of("HN01", "GT01", "SV01", "NI01", "CR01", "PA01");

    private final IDebitBasicInformation debitBasicInformation;

    public Mono<DebitBasicInformation> handle(ServerRequest request) {
        String creditCardId = request.pathVariables().get("creditCardId");
        if (creditCardId != null && creditCardId.length() < 12) {
            return Mono.error(new BadRequestException("creditCardId is required"));
        }
        return AppTool.context()
                .flatMap(context -> validateRegion(context.sourceBank())
                        .then(debitBasicInformation.debitBasicInformationRetrieve(creditCardId, context.sourceBank())));
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
