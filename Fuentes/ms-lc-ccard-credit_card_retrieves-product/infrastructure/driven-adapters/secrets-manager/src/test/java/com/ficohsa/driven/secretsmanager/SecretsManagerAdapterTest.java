package com.ficohsa.driven.secretsmanager;

import com.fasterxml.jackson.databind.ObjectMapper;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import reactor.test.StepVerifier;
import software.amazon.awssdk.services.secretsmanager.SecretsManagerAsyncClient;
import software.amazon.awssdk.services.secretsmanager.model.GetSecretValueRequest;
import software.amazon.awssdk.services.secretsmanager.model.GetSecretValueResponse;

import java.util.concurrent.CompletableFuture;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class SecretsManagerAdapterTest {

    @Mock private SecretsManagerAsyncClient secretsManagerClient;
    private SecretsManagerAdapter adapter;

    @BeforeEach
    void setUp() {
        adapter = new SecretsManagerAdapter(secretsManagerClient, new ObjectMapper());
    }

    @Test
    void getSecretValue_string_success() {
        var response = GetSecretValueResponse.builder().secretString("secret-value").build();
        when(secretsManagerClient.getSecretValue(any(GetSecretValueRequest.class)))
                .thenReturn(CompletableFuture.completedFuture(response));

        StepVerifier.create(adapter.getSecretValue("test-secret", String.class))
                .expectNext("secret-value")
                .verifyComplete();
    }

    @Test
    void getSecretValue_json_success() {
        var response = GetSecretValueResponse.builder().secretString("{\"key\":\"val\"}").build();
        when(secretsManagerClient.getSecretValue(any(GetSecretValueRequest.class)))
                .thenReturn(CompletableFuture.completedFuture(response));

        StepVerifier.create(adapter.getSecretValue("test-secret", java.util.Map.class))
                .expectNextCount(1)
                .verifyComplete();
    }

    @Test
    void getSecretValue_error_propagates() {
        when(secretsManagerClient.getSecretValue(any(GetSecretValueRequest.class)))
                .thenReturn(CompletableFuture.failedFuture(new RuntimeException("AWS error")));

        StepVerifier.create(adapter.getSecretValue("test-secret", String.class))
                .expectError(RuntimeException.class)
                .verify();
    }
}
