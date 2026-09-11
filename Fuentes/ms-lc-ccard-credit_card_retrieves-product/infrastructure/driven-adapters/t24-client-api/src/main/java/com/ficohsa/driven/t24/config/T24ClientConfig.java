package com.ficohsa.driven.t24.config;

import com.ficohsa.driven.t24.dto.request.T24Request;
import com.ficohsa.helper.HeadersBuilder;
import com.ficohsa.lib.core.dto.AppContext;
import com.ficohsa.lib.logging.clients.annotation.LogExternalCall;
import com.ficohsa.lib.web.component.WebClientComponent;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.ParameterizedTypeReference;
import reactor.core.publisher.Mono;

@Slf4j
@Configuration
@EnableConfigurationProperties(T24PropsConfig.class)
@RequiredArgsConstructor
public class T24ClientConfig {

    private final WebClientComponent webClient;
    private final T24PropsConfig t24Properties;

    @LogExternalCall(provider = "T24Wrapper")
    public Mono<Object> executeOperation(T24Request request, AppContext context, String operation) {
        String url = t24Properties.getBaseUrl() + t24Properties.getPath() + "/" + operation;
        return webClient.post(url, HeadersBuilder.fromContext(context), request, new ParameterizedTypeReference<>() {});
    }
}
