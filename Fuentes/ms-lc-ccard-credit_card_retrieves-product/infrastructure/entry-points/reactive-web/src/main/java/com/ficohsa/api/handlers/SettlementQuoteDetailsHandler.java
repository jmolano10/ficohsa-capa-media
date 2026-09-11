package com.ficohsa.api.handlers;

import com.ficohsa.api.dto.settlementquotedetails.request.SettlementQuoteDetailsRequestDto;
import com.ficohsa.api.dto.settlementquotedetails.response.SettlementQuoteDetailsResponseDto;
import com.ficohsa.api.mappers.SettlementQuoteDetailMapper;
import com.ficohsa.lib.core.exception.BadRequestException;
import com.ficohsa.lib.core.utility.AppTool;
import com.ficohsa.model.settlementquotedetails.SettlementQuoteDetails;
import com.ficohsa.model.settlementquotedetails.SettlementQuoteDetailsModel;
import com.ficohsa.ports.ISettlementQuoteDetails;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.validation.BeanPropertyBindingResult;
import org.springframework.validation.Validator;
import reactor.core.publisher.Mono;

import java.util.stream.Collectors;

@Slf4j
@Component
@RequiredArgsConstructor
public class SettlementQuoteDetailsHandler {

    private final ISettlementQuoteDetails settlementQuoteDetails;
    private final Validator validator;
    private final SettlementQuoteDetailMapper settlementQuoteDetailMapper;

    public Mono<SettlementQuoteDetailsResponseDto> retrieveSettlementQuoteDetails(SettlementQuoteDetailsRequestDto request) {
        return Mono.just(request)
                .doOnNext(req -> log.info("[HANDLER] Processing Settlement Quote Details request for account: {}",
                    req.data() != null ? req.data().accountNumber() : "unknown"))
                .flatMap(this::validateRequest)
                .map(SettlementQuoteDetailsRequestDto::data)
                .map(settlementQuoteDetailMapper::toDomain)
                .flatMap(this::enrichWithContextAndExecute)
                .map(settlementQuoteDetailMapper::toResponse);
    }

    private Mono<SettlementQuoteDetailsRequestDto> validateRequest(SettlementQuoteDetailsRequestDto req) {
        var errors = new BeanPropertyBindingResult(req, "settlementQuoteDetailsRequest");
        validator.validate(req, errors);

        if (errors.hasErrors()) {
            String message = errors.getFieldErrors().stream()
                    .map(field -> field.getField() + ": " + field.getDefaultMessage())
                    .collect(Collectors.joining(", "));
            log.error("[HANDLER] Validation failed for request: {}", message);
            return Mono.error(new BadRequestException(message));
        }
        return Mono.just(req);
    }

    private Mono<SettlementQuoteDetailsModel> enrichWithContextAndExecute(SettlementQuoteDetails domainRequest) {
        return AppTool.context()
                .map(appContext -> {
                    domainRequest.setRegion(appContext.sourceBank());
                    domainRequest.setCallService(appContext.callerService());
                    return domainRequest;
                })
                .flatMap(settlementQuoteDetails::retrieveSettlementQuoteDetails);
    }
}
