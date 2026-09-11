package com.ficohsa.driven.parameterstore;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.ficohsa.lib.core.exception.InternalServerException;
import com.ficohsa.ports.IParameterStoreGateway;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import reactor.core.publisher.Mono;
import software.amazon.awssdk.services.ssm.SsmAsyncClient;
import software.amazon.awssdk.services.ssm.model.GetParameterRequest;

@Slf4j
@Component
public class ParameterStoreAdapter implements IParameterStoreGateway {
    private final SsmAsyncClient ssmAsyncClient;
    private final ObjectMapper objectMapper;

    public ParameterStoreAdapter(SsmAsyncClient ssmAsyncClient, ObjectMapper objectMapper) {
        this.ssmAsyncClient = ssmAsyncClient;
        this.objectMapper = objectMapper;
    }

    public <T> Mono<T> getParameter(String parameterName, Class<T> type) {
        GetParameterRequest getParameterRequest = GetParameterRequest.builder()
                .name(parameterName)
                .build();
        return Mono.fromFuture(ssmAsyncClient.getParameter(getParameterRequest))
                .map(response -> {
                    String rawValue = response.parameter().value();
                    if (type.equals(String.class))
                        return type.cast(rawValue);
                    try {
                        return objectMapper.readValue(rawValue, type);
                    } catch (Exception e) {
                        throw new InternalServerException("Error deserializing parameter: " + parameterName);
                    }
                })
                .onErrorResume(throwable -> {
                    log.info("[ADAPTER] Error getting parameter store, error: {}", throwable.getMessage());
                    return Mono.error(new InternalServerException("Error retrieving parameter: " + parameterName));
                })
                .doOnSubscribe(subscription -> log.info("[ADAPTER] Getting parameter store, parameterName: {}", parameterName))
                .doOnSuccess(res -> log.info("[ADAPTER] Retrieve parameter store successfully"));
    }

    public Mono<String> getDatabaseConnection(String parameterName) {
        return getParameter(parameterName, String.class);
    }
}
