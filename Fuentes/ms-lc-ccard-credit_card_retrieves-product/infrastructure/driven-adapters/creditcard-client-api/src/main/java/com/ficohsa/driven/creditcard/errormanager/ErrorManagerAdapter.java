package com.ficohsa.driven.creditcard.errormanager;

import com.ficohsa.driven.creditcard.errormanager.config.ErrorManagerClientConfig;
import com.ficohsa.driven.creditcard.errormanager.dto.ErrorRequest;
import com.ficohsa.driven.creditcard.errormanager.dto.ErrorResponse;
import com.ficohsa.lib.core.exception.InternalServerException;
import com.ficohsa.lib.core.utility.AppTool;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import reactor.core.publisher.Mono;

import java.util.Map;


@Slf4j
@Component
@RequiredArgsConstructor
public class ErrorManagerAdapter implements ErrorManagerClient {
    private final ErrorManagerClientConfig errorManagerWebClient;

    @Override
    public Mono<ErrorResponse> consume(ErrorRequest request, Map<String, String> headers) {
        return AppTool.context()
                .flatMap(context -> errorManagerWebClient.consume(headers, request))
                .switchIfEmpty(Mono.error(new InternalServerException("Error manager returned empty response")))
                .doOnSuccess(response -> log.info("[ADAPTER] Successfully retrieved loan advances from T24"))
                .doOnError(error -> log.error("[ADAPTER] Error manager service error: {}", error.getMessage()));
    }

}
