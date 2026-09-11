package com.ficohsa.driven.creditcard.errormanager.config;

import com.ficohsa.driven.creditcard.errormanager.dto.ErrorRequest;
import com.ficohsa.driven.creditcard.errormanager.dto.ErrorResponse;
import com.ficohsa.lib.logging.clients.annotation.LogExternalCall;
import com.ficohsa.lib.web.component.WebClientComponent;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.ParameterizedTypeReference;
import reactor.core.publisher.Mono;

import java.util.Map;

@Slf4j
@Configuration
@EnableConfigurationProperties
@RequiredArgsConstructor
public class ErrorManagerClientConfig {

    private final WebClientComponent webClient;

    @Value("${ficohsa.external-apis.ms-error.base-url}")
    private String baseUrl;

    @Value("${ficohsa.external-apis.ms-error.path}")
    private String path;

    @LogExternalCall(provider = "ErrorManager")
    public Mono<ErrorResponse> consume(Map<String, String> headers, ErrorRequest request) {
        return webClient.post(baseUrl + path, headers, request, new ParameterizedTypeReference<>() {});
    }
}
