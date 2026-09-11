package com.ficohsa.ports;

import reactor.core.publisher.Mono;

public interface ICredentialsGateway {
    <T> Mono<T> getSecretValue(String secretName, Class<T> type);
}

