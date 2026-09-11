package com.ficohsa.driven.visionplus;

import com.ficohsa.driven.visionplus.config.VisionPlusClientConfig;
import com.ficohsa.driven.visionplus.dto.response.VisionPlusResponse;
import com.ficohsa.driven.visionplus.mapper.VisionPlusMapper;
import com.ficohsa.lib.core.exception.*;
import com.ficohsa.lib.core.utility.AppTool;
import com.ficohsa.model.settlementquotedetails.SettlementQuoteDetails;
import com.ficohsa.model.settlementquotedetails.SettlementQuoteDetailsModel;
import com.ficohsa.ports.ISettlementQuoteDetailsGateway;
import io.github.resilience4j.circuitbreaker.annotation.CircuitBreaker;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import reactor.core.publisher.Mono;

import java.util.Optional;

import static com.ficohsa.driven.visionplus.mapper.VisionPlusMapper.toEntity;

@Slf4j
@RequiredArgsConstructor
public class VisionPlusAdapter implements ISettlementQuoteDetailsGateway {

    private final VisionPlusClientConfig visionPlusWebClient;
    
    private static final String NOT_FOUND_ACCT_CARD = "VPL5SQI11S";
    private static final String NOT_FOUND_PLAN = "VPL5SQI15S";
    private static final String NOT_FOUND_PLAN_RECORD = "VPL5SQI14S";

    @Override
    public String key() {
        return "PA01VP/GT01VP/HN01VP/NI01VP";
    }

    @Override
    @CircuitBreaker(name = "externalApiCircuitBreaker", fallbackMethod = "fallbackRetrieveSettlementQuoteDetails")
    public Mono<SettlementQuoteDetailsModel> retrieveSettlementQuoteDetails(SettlementQuoteDetails request) {
        return AppTool.context()
                .flatMap(context -> visionPlusWebClient.retrievesSettlementQuoteDetails(toEntity(request), context) )
                .switchIfEmpty(Mono.error(new BadGatewayException("VisionPlus returned empty response")))
                .flatMap(this::validateResponse)
                .map(VisionPlusMapper::toModel)
                .doOnSuccess(response -> log.info("[ADAPTER] Successfully retrieved settlement quote details from VisionPlus"))
                .doOnError(error -> log.error("[ADAPTER] Vision plus service error: {}", error.getMessage()));
    }

    @SuppressWarnings("java:S1172")
    private Mono<SettlementQuoteDetailsModel> fallbackRetrieveSettlementQuoteDetails(SettlementQuoteDetails request, Throwable throwable) {
        log.error("[ADAPTER] Circuit breaker activated for VisionPlus. Reason: {}", throwable.getMessage());
        return Mono.error(new ServiceUnavailableException("VisionPlus service is temporarily unavailable. Please try again later."));
    }

    private Mono<VisionPlusResponse> validateResponse(VisionPlusResponse response){
        if (response == null || response.getData() == null || response.getData().getBody() == null ||
                response.getData().getBody().getSettlementQuoteInquiryResponse() == null) {
            log.error("[ADAPTER] VisionPlus response structure is invalid or null");
            return Mono.error(new BadGatewayException("VisionPlus response structure is invalid"));
        }

        var innerResponse = response.getData().getBody().getSettlementQuoteInquiryResponse();

        if (!"P".equalsIgnoreCase(innerResponse.getServiceReturnCode())) {
            String errorCode = "UNKNOWN";
            String errorDesc = "Unknown Error from VisionPlus";
            String serviceReturnCode = innerResponse.getServiceReturnCode();

            if (innerResponse.getReturnCodes() != null &&
                    innerResponse.getReturnCodes().getRc() != null &&
                    !innerResponse.getReturnCodes().getRc().isEmpty()) {

                var firstError = innerResponse.getReturnCodes().getRc().get(0);
                errorCode = Optional.ofNullable(firstError.getCode()).orElse(errorCode);
                errorDesc = Optional.ofNullable(firstError.getDesc()).orElse(errorDesc);
            }

            log.error("[ADAPTER] === VisionPlus Business Error Response Details ===");
            log.error("[ADAPTER] Service Return Code: {}", serviceReturnCode);
            log.error("[ADAPTER] Error Code (from ReturnCodes): {}", errorCode);
            log.error("[ADAPTER] Error Description: {}", errorDesc);
            log.error("[ADAPTER] ==================================================");
            
            if (isNotFoundError(errorCode)) {
                log.error("[ADAPTER] Adapter: Resource not found - Creating BusinessCoreException with NotFoundException");
                log.error("[ADAPTER]   - codigo_error: '{}'", errorCode);
                log.error("[ADAPTER]   - texto_error: '{}'", errorDesc);
                
                return Mono.error(new BusinessCoreException(
                        new NotFoundException(errorDesc),
                        errorCode,
                        errorDesc
                ));
            }
            
            log.error("[ADAPTER] Adapter: Creating BusinessCoreException for error-mapping:");
            log.error("[ADAPTER]   - codigo_error: '{}' (from serviceReturnCode)", serviceReturnCode);
            log.error("[ADAPTER]   - texto_error: '{}'", errorDesc);
            log.error("[ADAPTER]   Note: Using ONLY the first error from ReturnCodes (other errors are ignored)");
            log.error("[ADAPTER]   This will be sent to error-mapping service to find the appropriate error code");

            return Mono.error(new BusinessCoreException(
                    new UnprocessableEntityException(errorDesc),
                    serviceReturnCode,
                    errorDesc
            ));
        }
        return Mono.just(response);
    }
    
    private boolean isNotFoundError(String errorCode) {
        return NOT_FOUND_ACCT_CARD.equals(errorCode) ||
               NOT_FOUND_PLAN.equals(errorCode) ||
               NOT_FOUND_PLAN_RECORD.equals(errorCode);
    }
}

