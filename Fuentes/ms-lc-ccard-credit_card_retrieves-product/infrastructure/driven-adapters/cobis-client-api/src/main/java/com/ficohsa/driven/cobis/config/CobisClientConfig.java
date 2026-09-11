package com.ficohsa.driven.cobis.config;

import com.ficohsa.driven.cobis.dto.request.CobisRequest;
import com.ficohsa.driven.cobis.dto.request.CobisSpRequest;
import com.ficohsa.driven.cobis.dto.response.CobisResponse;
import com.ficohsa.driven.cobis.dto.response.CobisSpResponse;
import com.ficohsa.helper.HeadersBuilder;
import com.ficohsa.lib.core.dto.AppContext;
import com.ficohsa.lib.logging.clients.annotation.LogExternalCall;
import com.ficohsa.lib.web.component.WebClientComponent;
import lombok.RequiredArgsConstructor;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.ParameterizedTypeReference;
import reactor.core.publisher.Mono;

@Configuration
@EnableConfigurationProperties(CobisPropsConfig.class)
@RequiredArgsConstructor
public class CobisClientConfig {

    private final WebClientComponent webClient;
    private final CobisPropsConfig cobisProperties;

    @LogExternalCall(provider = "CobisWrapper")
    public Mono<CobisResponse> executeOperation(CobisRequest request, AppContext context, String operation) {
        String url = cobisProperties.getBaseUrl() + cobisProperties.getPath() + "/" + operation;
        return webClient.post(url, HeadersBuilder.fromContext(context), request, new ParameterizedTypeReference<>() {});
    }

    @LogExternalCall(provider = "CobisWrapper")
    public Mono<CobisSpResponse> executeSpOperation(CobisSpRequest request, AppContext context) {
        String url = cobisProperties.getSpBaseUrl() + cobisProperties.getSpPath();
        return webClient.post(url, HeadersBuilder.fromContext(context), request, new ParameterizedTypeReference<>() {});
    }
}
