package com.ficohsa.driven.creditcard.r2dbc.config;

import org.springframework.boot.actuate.autoconfigure.r2dbc.ConnectionFactoryHealthContributorAutoConfiguration;
import org.springframework.boot.autoconfigure.EnableAutoConfiguration;
import org.springframework.boot.autoconfigure.r2dbc.R2dbcAutoConfiguration;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Configuration;

@Configuration
@EnableConfigurationProperties(DatabasePropsConfig.class)
@EnableAutoConfiguration(exclude = {
    R2dbcAutoConfiguration.class,
    ConnectionFactoryHealthContributorAutoConfiguration.class
})
public class R2dbcClientConfig {

}
