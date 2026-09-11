package com.ficohsa.ports;

import reactor.core.publisher.Mono;

public interface IRegionalizationGateway {
    Mono<Void> validateRegion(String method, String sourceBank, String destinationBank);
}
