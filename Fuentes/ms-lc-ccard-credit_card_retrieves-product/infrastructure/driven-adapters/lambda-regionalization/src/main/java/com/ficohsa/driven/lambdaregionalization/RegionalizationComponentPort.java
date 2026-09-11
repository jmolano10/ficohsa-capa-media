package com.ficohsa.driven.lambdaregionalization;

import reactor.core.publisher.Mono;

/**
 * Interface wrapper for DynamicRegionalizationComponent to enable unit testing on Java 24+.
 */
public interface RegionalizationComponentPort {
    Mono<Void> validateRegionEnabled(String country, String domain, String method, String version, String sourceBank, String destinationBank);
}
