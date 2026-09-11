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
@ConfigurationProperties(prefix = "ficohsa.regionalization.debit-basic-information")
public class DebitBasicInformationProperties {
    private String country;
    private String domain;
    private String method;
}
