package com.ficohsa.driven.secretsmanager;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.ficohsa.ports.ICredentialsGateway;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.logging.log4j.util.InternalException;
import org.springframework.stereotype.Service;
import reactor.core.publisher.Mono;
import software.amazon.awssdk.services.secretsmanager.SecretsManagerAsyncClient;
import software.amazon.awssdk.services.secretsmanager.model.GetSecretValueRequest;
import software.amazon.awssdk.services.secretsmanager.model.GetSecretValueResponse;

import java.util.concurrent.CompletableFuture;


@Service
@AllArgsConstructor
@Slf4j
public class SecretsManagerAdapter implements ICredentialsGateway {

    private final SecretsManagerAsyncClient secretsManagerClient;
    private final ObjectMapper objectMapper;

    public <T> Mono<T> getSecretValue(String secretName, Class<T> type) {
        log.info("[ADAPTER] Getting secret manager");
        GetSecretValueRequest request = GetSecretValueRequest.builder()
                .secretId(secretName)
                .build();

        CompletableFuture<GetSecretValueResponse> future = secretsManagerClient.getSecretValue(request);

        return Mono.fromFuture(future)
                .map(GetSecretValueResponse::secretString)
                .map(rawValue -> {
                    if (type.equals(String.class))
                        return type.cast(rawValue);
                    try {
                        return objectMapper.readValue(rawValue, type);
                    } catch (Exception e) {
                        throw new InternalException(e.getMessage(), e);
                    }
                })
                .onErrorResume(throwable -> {
                    log.info("[ADAPTER] Error obtaining secret, error: {}", throwable.getMessage());
                    return Mono.error(new RuntimeException(throwable.getMessage()));
                })
                .doOnSuccess(res -> log.info("[ADAPTER] Retrieve secret manager successfully"));
    }

}

