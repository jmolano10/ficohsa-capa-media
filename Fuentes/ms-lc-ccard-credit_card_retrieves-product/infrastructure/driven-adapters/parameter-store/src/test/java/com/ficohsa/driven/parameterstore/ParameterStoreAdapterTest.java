package com.ficohsa.driven.parameterstore;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.ficohsa.lib.core.exception.InternalServerException;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;
import org.junit.jupiter.api.extension.ExtendWith;
import org.mockito.Mock;
import org.mockito.junit.jupiter.MockitoExtension;
import reactor.test.StepVerifier;
import software.amazon.awssdk.services.ssm.SsmAsyncClient;
import software.amazon.awssdk.services.ssm.model.GetParameterRequest;
import software.amazon.awssdk.services.ssm.model.GetParameterResponse;
import software.amazon.awssdk.services.ssm.model.Parameter;

import java.util.Objects;
import java.util.concurrent.CompletableFuture;

import static org.mockito.ArgumentMatchers.any;
import static org.mockito.Mockito.when;

@ExtendWith(MockitoExtension.class)
class ParameterStoreAdapterTest {

    @Mock
    private SsmAsyncClient ssmAsyncClient;

    @Mock
    private ObjectMapper objectMapper;

    private ParameterStoreAdapter adapter;

    @BeforeEach
    void setUp() {
        adapter = new ParameterStoreAdapter(ssmAsyncClient, objectMapper);
    }

    @Test
    void shouldReturnStringParameterWhenTypeIsString() {
        String parameterName = "test-param";
        String expectedValue = "test-value";

        Parameter parameter = Parameter.builder().value(expectedValue).build();
        GetParameterResponse response = GetParameterResponse.builder().parameter(parameter).build();

        when(ssmAsyncClient.getParameter(any(GetParameterRequest.class)))
                .thenReturn(CompletableFuture.completedFuture(response));

        StepVerifier.create(adapter.getParameter(parameterName, String.class))
                .expectNext(expectedValue)
                .verifyComplete();
    }

    @Test
    void shouldReturnObjectParameterWhenTypeIsNotString() throws Exception {
        String parameterName = "test-param";
        String jsonValue = "{\"name\":\"test\"}";
        TestConfig expectedConfig = new TestConfig("test");

        Parameter parameter = Parameter.builder().value(jsonValue).build();
        GetParameterResponse response = GetParameterResponse.builder().parameter(parameter).build();

        when(ssmAsyncClient.getParameter(any(GetParameterRequest.class)))
                .thenReturn(CompletableFuture.completedFuture(response));
        when(objectMapper.readValue(jsonValue, TestConfig.class)).thenReturn(expectedConfig);

        StepVerifier.create(adapter.getParameter(parameterName, TestConfig.class))
                .expectNext(expectedConfig)
                .verifyComplete();
    }

    @Test
    void shouldReturnDatabaseConnectionString() {
        String parameterName = "db-connection";
        String expectedConnection = "server:port:database";

        Parameter parameter = Parameter.builder().value(expectedConnection).build();
        GetParameterResponse response = GetParameterResponse.builder().parameter(parameter).build();

        when(ssmAsyncClient.getParameter(any(GetParameterRequest.class)))
                .thenReturn(CompletableFuture.completedFuture(response));

        StepVerifier.create(adapter.getDatabaseConnection(parameterName))
                .expectNext(expectedConnection)
                .verifyComplete();
    }

    @Test
    void shouldThrowExceptionWhenSsmClientFails() {
        String parameterName = "test-param";

        when(ssmAsyncClient.getParameter(any(GetParameterRequest.class)))
                .thenReturn(CompletableFuture.failedFuture(new RuntimeException("Parameter not found")));

        StepVerifier.create(adapter.getParameter(parameterName, String.class))
                .expectError(InternalServerException.class)
                .verify();
    }

    @Test
    void shouldThrowExceptionWhenJsonParsingFails() throws Exception {
        String parameterName = "test-param";
        String invalidJson = "invalid-json";

        Parameter parameter = Parameter.builder().value(invalidJson).build();
        GetParameterResponse response = GetParameterResponse.builder().parameter(parameter).build();

        when(ssmAsyncClient.getParameter(any(GetParameterRequest.class)))
                .thenReturn(CompletableFuture.completedFuture(response));
        when(objectMapper.readValue(invalidJson, TestConfig.class))
                .thenThrow(new RuntimeException("JSON parsing error"));

        StepVerifier.create(adapter.getParameter(parameterName, TestConfig.class))
                .expectError(InternalServerException.class)
                .verify();
    }

    private static class TestConfig {
        private final String name;

        public TestConfig(String name) {
            this.name = name;
        }

        @Override
        public boolean equals(Object obj) {
            if (this == obj) return true;
            if (obj == null || getClass() != obj.getClass()) return false;
            TestConfig that = (TestConfig) obj;
            return Objects.equals(name, that.name);
        }

        @Override
        public int hashCode() {
            return name != null ? name.hashCode() : 0;
        }
    }
}
