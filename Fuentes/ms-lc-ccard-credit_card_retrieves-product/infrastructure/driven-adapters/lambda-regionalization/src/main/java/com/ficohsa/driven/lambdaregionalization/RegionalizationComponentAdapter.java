package com.ficohsa.driven.lambdaregionalization;

import com.ficohsa.lib.regionalization.adapter.DynamicRegionalizationComponent;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Component;
import reactor.core.publisher.Mono;

@Component
@RequiredArgsConstructor
public class RegionalizationComponentAdapter implements RegionalizationComponentPort {
    private final DynamicRegionalizationComponent delegate;

    @Override
    public Mono<Void> validateRegionEnabled(String country, String domain, String method, String version, String sourceBank, String destinationBank) {
        return delegate.validateRegionEnabled(country, domain, method, version, sourceBank, destinationBank);
    }
}
