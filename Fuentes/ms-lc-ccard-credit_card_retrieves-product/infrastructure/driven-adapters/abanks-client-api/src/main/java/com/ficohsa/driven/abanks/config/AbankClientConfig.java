package com.ficohsa.driven.abanks.config;

import com.ficohsa.driven.abanks.dto.request.AbanksRequest;
import com.ficohsa.driven.abanks.dto.response.AbanksResponse;
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
@EnableConfigurationProperties(AbankPropsConfig.class)
@RequiredArgsConstructor
public class AbankClientConfig {

    private final WebClientComponent webClient;

    @Value("${ficohsa.external-apis.ms-abanks-wrapper.base-url}")
    private String baseUrl;

    @Value("${ficohsa.external-apis.ms-abanks-wrapper.path-GT01}")
    private String pathGT01;

    @Value("${ficohsa.external-apis.ms-abanks-wrapper.path-PA01}")
    private String pathPA01;

    @LogExternalCall(provider = "AbanksWrapper")
    public Mono<AbanksResponse> getBankProducts(AbanksRequest request, AppContext context) {
        String selectedPath = "PA01".equals(context.sourceBank()) ? pathPA01 : pathGT01;
        return webClient.post(baseUrl + selectedPath, HeadersBuilder.fromContext(context), request, new ParameterizedTypeReference<>() {});
    }
}
