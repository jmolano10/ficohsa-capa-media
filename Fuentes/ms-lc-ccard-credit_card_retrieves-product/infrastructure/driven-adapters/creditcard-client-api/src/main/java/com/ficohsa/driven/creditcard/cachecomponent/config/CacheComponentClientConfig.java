package com.ficohsa.driven.creditcard.cachecomponent.config;

import com.ficohsa.driven.creditcard.cachecomponent.dto.request.CacheComponentRequest;
import com.ficohsa.driven.creditcard.cachecomponent.dto.response.CacheSettlementQuoteDetailsResponse;
import com.ficohsa.helper.HeadersBuilder;
import com.ficohsa.lib.core.dto.AppContext;
import com.ficohsa.lib.logging.clients.annotation.LogExternalCall;
import com.ficohsa.lib.web.component.WebClientComponent;
import lombok.RequiredArgsConstructor;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.ParameterizedTypeReference;
import reactor.core.publisher.Mono;

@Configuration
@EnableConfigurationProperties
@RequiredArgsConstructor
public class CacheComponentClientConfig {

    private final WebClientComponent webClient;

    @Value("${ficohsa.external-apis.ms-ccp-wrapper.base-url}")
    private String baseUrl;

    @Value("${ficohsa.external-apis.ms-ccp-wrapper.set-ccp-path}")
    private String setCcpPath;

    @Value("${ficohsa.external-apis.ms-ccp-wrapper.get-ccp-path}")
    private String getCcpPath;

    @LogExternalCall(provider = "CacheComponent")
    public Mono<CacheSettlementQuoteDetailsResponse> setCache(CacheComponentRequest request, AppContext context) {
        return webClient.post(baseUrl + setCcpPath, HeadersBuilder.fromContext(context), request, new ParameterizedTypeReference<>() {});
    }

    @LogExternalCall(provider = "CacheComponent")
    public Mono<CacheSettlementQuoteDetailsResponse> getCache(String key, AppContext context) {
        return webClient.get(baseUrl + getCcpPath + "/" + key, HeadersBuilder.fromContext(context), new ParameterizedTypeReference<>() {});
    }
}
