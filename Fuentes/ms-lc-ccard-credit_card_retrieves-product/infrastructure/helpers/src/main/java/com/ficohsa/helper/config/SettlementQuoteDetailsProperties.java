package com.ficohsa.helper.config;

import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import org.springframework.boot.context.properties.ConfigurationProperties;
import org.springframework.stereotype.Component;

@Getter
@Setter
@NoArgsConstructor
@Component
@ConfigurationProperties(prefix = "ficohsa.regionalization.settlement-quote-details")
public class SettlementQuoteDetailsProperties {
    private String country;
    private String domain;
    private String method;
}
