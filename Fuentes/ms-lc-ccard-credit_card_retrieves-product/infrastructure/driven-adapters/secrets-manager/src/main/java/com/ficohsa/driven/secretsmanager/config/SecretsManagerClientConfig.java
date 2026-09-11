package com.ficohsa.driven.secretsmanager.config;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.Profile;
import software.amazon.awssdk.auth.credentials.DefaultCredentialsProvider;
import software.amazon.awssdk.auth.credentials.ProfileCredentialsProvider;
import software.amazon.awssdk.regions.Region;
import software.amazon.awssdk.regions.providers.DefaultAwsRegionProviderChain;
import software.amazon.awssdk.services.secretsmanager.SecretsManagerAsyncClient;

import java.net.URI;

@Configuration
@EnableConfigurationProperties
public class SecretsManagerClientConfig {
    @Bean
    @Profile({"local"})
    public SecretsManagerAsyncClient amazonSecretsManager(@Value("${aws.secrets-manager.endpoint}") String endpoint,
                                                          @Value("${aws.region}") String region) {
        return SecretsManagerAsyncClient.builder()
                .credentialsProvider(ProfileCredentialsProvider.create("default"))
                .region(Region.of(region))
                .endpointOverride(URI.create(endpoint))
                .build();
    }

    @Bean
    @Profile({"dev", "stg", "uat", "prd", "pdn"})
    public SecretsManagerAsyncClient amazonSecretsManagerAsync(@Value("${aws.region}") String region) {
        return SecretsManagerAsyncClient.builder()
                .credentialsProvider(DefaultCredentialsProvider.builder().build())
                .region(DefaultAwsRegionProviderChain.builder().build().getRegion())
                .build();
    }
}
