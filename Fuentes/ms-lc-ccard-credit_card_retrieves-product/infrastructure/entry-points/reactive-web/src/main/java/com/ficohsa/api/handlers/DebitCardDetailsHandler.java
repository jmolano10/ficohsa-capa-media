package com.ficohsa.api.handlers;

import com.ficohsa.api.dto.DebitCardDetailsDto;
import com.ficohsa.api.mappers.DebitCardDetailsMapper;
import com.ficohsa.lib.core.exception.BadRequestException;
import com.ficohsa.lib.core.exception.UnprocessableEntityException;
import com.ficohsa.lib.core.utility.AppTool;
import com.ficohsa.model.exception.enums.RegionErrorCode;
import com.ficohsa.ports.IDebitCardDetails;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.reactive.function.server.ServerRequest;
import reactor.core.publisher.Mono;

import java.util.Set;

@Slf4j
@Component
@RequiredArgsConstructor
public class DebitCardDetailsHandler {

    private static final Set<String> VALID_REGIONS = Set.of("HN01", "GT01", "SV01", "NI01", "CR01", "PA01");
    private static final Set<String> VALID_STATUS = Set.of("ISSUED", "RETURNED", "SCRAP", "CANCEL", "ACTIVE", "DESTROYED", "BLOCKED", "ALL");

    private final IDebitCardDetails debitCardDetails;
    private final DebitCardDetailsMapper debitCardDetailsMapper;

    public Mono<DebitCardDetailsDto> handle(ServerRequest serverRequest) {
        return AppTool.context()
                .flatMap(ctx -> {
                    String sourceBank = ctx.sourceBank();
                    return validateRegion(sourceBank)
                            .then(Mono.defer(() -> {
                                String accountStatusTypeValues = serverRequest.queryParams().getFirst("accountstatustypevalues");
                                String accountNumber = serverRequest.queryParams().getFirst("accountNumber");

                                if (accountStatusTypeValues == null || accountStatusTypeValues.trim().isEmpty()) {
                                    return Mono.error(new BadRequestException("accountstatustypevalues is required"));
                                }

                                if (!VALID_STATUS.contains(accountStatusTypeValues)) {
                                    return Mono.error(new BadRequestException("Invalid accountstatustypevalues. Must be one of: ISSUED, RETURNED, SCRAP, CANCEL, ACTIVE, DESTROYED, BLOCKED, ALL"));
                                }

                                return debitCardDetails.getDebitCardDetails(
                                        serverRequest.pathVariable("customerIdentification"),
                                        accountStatusTypeValues,
                                        accountNumber, sourceBank
                                ).map(debitCardDetailsMapper::toDto);
                            }));
                });
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
