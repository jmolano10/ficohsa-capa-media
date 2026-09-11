package com.ficohsa.ports;

import reactor.core.publisher.Mono;

public interface IParameterStoreGateway {
    <T> Mono<T> getParameter(String parameterName, Class<T> type);
    Mono<String> getDatabaseConnection(String parameterName);
}

