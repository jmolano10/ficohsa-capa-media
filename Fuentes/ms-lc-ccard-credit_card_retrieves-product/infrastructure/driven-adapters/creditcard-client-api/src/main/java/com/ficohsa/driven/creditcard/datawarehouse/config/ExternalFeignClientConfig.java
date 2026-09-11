package com.ficohsa.driven.creditcard.datawarehouse.config;

import com.ficohsa.driven.creditcard.datawarehouse.decoder.ExternalErrorDecoder;
import feign.Logger;
import feign.Request;
import feign.codec.ErrorDecoder;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
@EnableConfigurationProperties(ExternalServicePropsConfig.class)
public class ExternalFeignClientConfig {

    @Bean
    Logger.Level feignLoggerLevel() { return Logger.Level.BASIC; }

    @Bean Request.Options feignOptions(ExternalServicePropsConfig props) {
        return new Request.Options(
            props.getConnectTimeoutMs(), 
            java.util.concurrent.TimeUnit.MILLISECONDS,
            props.getReadTimeoutMs(), 
            java.util.concurrent.TimeUnit.MILLISECONDS,
            true
        );
    }

    @Bean
    ErrorDecoder errorDecoder() { return new ExternalErrorDecoder(); }
}
