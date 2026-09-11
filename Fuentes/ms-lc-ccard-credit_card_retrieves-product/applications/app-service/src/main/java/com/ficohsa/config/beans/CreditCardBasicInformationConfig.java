package com.ficohsa.config.beans;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.ficohsa.driven.abanks.AbanksQueryAdapter;
import com.ficohsa.driven.abanks.config.AbankClientConfig;
import com.ficohsa.driven.abanks.mapper.AbanksMapper;
import com.ficohsa.driven.cobis.CobisQueryAdapter;
import com.ficohsa.driven.cobis.config.CobisClientConfig;
import com.ficohsa.driven.cobis.mapper.CobisMapper;
import com.ficohsa.driven.t24.T24QueryAdapter;
import com.ficohsa.driven.t24.config.T24ClientConfig;
import com.ficohsa.driven.t24.mapper.T24Mapper;
import com.ficohsa.driven.visionplus.VisionPlusAdapter;
import com.ficohsa.driven.visionplus.config.VisionPlusClientConfig;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;

@Configuration
@SuppressWarnings("java:S6830") // Bean names match region codes used as strategy keys
public class CreditCardBasicInformationConfig {

    @Bean(name = "GT01")
    public AbanksQueryAdapter gt01Adapter(AbankClientConfig abankWebClient, AbanksMapper abanksMapper, ObjectMapper objectMapper) {
        return new AbanksQueryAdapter(abankWebClient, abanksMapper, objectMapper);
    }

    @Bean(name = "PA01")
    public AbanksQueryAdapter pa01Adapter(AbankClientConfig abankWebClient, AbanksMapper abanksMapper, ObjectMapper objectMapper) {
        return new AbanksQueryAdapter(abankWebClient, abanksMapper, objectMapper);
    }

    @Bean(name = "NI01")
    public CobisQueryAdapter ni01Adapter(CobisClientConfig cobisWebClient, CobisMapper cobisMapper) {
        return new CobisQueryAdapter(cobisWebClient, cobisMapper);
    }

    @Bean(name = "HN01")
    public T24QueryAdapter hn01Adapter(T24ClientConfig t24WebClient, T24Mapper t24Mapper, ObjectMapper objectMapper) {
        return new T24QueryAdapter(t24WebClient, t24Mapper, objectMapper);
    }

    @Bean(name = "HN01VP")
    public VisionPlusAdapter hn01VpAdapter(VisionPlusClientConfig visionPlusWebClient) {
        return new VisionPlusAdapter(visionPlusWebClient);
    }

    @Bean(name = "GT01VP")
    public VisionPlusAdapter gt01VpAdapter(VisionPlusClientConfig visionPlusWebClient) {
        return new VisionPlusAdapter(visionPlusWebClient);
    }

    @Bean(name = "PA01VP")
    public VisionPlusAdapter pa01VpAdapter(VisionPlusClientConfig visionPlusWebClient) {
        return new VisionPlusAdapter(visionPlusWebClient);
    }

    @Bean(name = "NI01VP")
    public VisionPlusAdapter ni01VpAdapter(VisionPlusClientConfig visionPlusWebClient) {
        return new VisionPlusAdapter(visionPlusWebClient);
    }
}
