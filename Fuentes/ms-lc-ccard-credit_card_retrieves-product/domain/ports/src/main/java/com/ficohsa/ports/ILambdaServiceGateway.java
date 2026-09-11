package com.ficohsa.ports;

import reactor.core.publisher.Mono;

public interface ILambdaServiceGateway {
    <T> Mono<T> invokeLambda(Class<T> targetType);
}

