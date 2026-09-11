package com.ficohsa.helper;

import com.ficohsa.helper.mapper.RegionMapper;

import com.ficohsa.model.settlementquotedetails.RegionModel;
import com.ficohsa.model.settlementquotedetails.SettlementQuoteLambdaModel;
import org.junit.jupiter.api.Test;

import java.util.List;

import static org.junit.jupiter.api.Assertions.*;

class RegionMapperTest {

    @Test
    void testToRegionModel() {
        SettlementQuoteLambdaModel.RegionConfig regionConfig = SettlementQuoteLambdaModel.RegionConfig.builder()
                .region("HN")
                .enabled(true)
                .build();

        SettlementQuoteLambdaModel.MethodConfig methodConfig = SettlementQuoteLambdaModel.MethodConfig.builder()
                .regions(List.of(regionConfig))
                .cache(SettlementQuoteLambdaModel.CacheConfig.builder().build())
                .build();

        SettlementQuoteLambdaModel.MethodsConfig methodsConfig = SettlementQuoteLambdaModel.MethodsConfig.builder()
                .settlementQuoteDetails(methodConfig)
                .build();

        SettlementQuoteLambdaModel.ValueConfig valueConfig = SettlementQuoteLambdaModel.ValueConfig.builder()
                .methods(methodsConfig)
                .build();

        SettlementQuoteLambdaModel lambdaModel = SettlementQuoteLambdaModel.builder()
                .value(valueConfig)
                .build();

        RegionModel result = RegionMapper.toRegionModel(lambdaModel);

        assertNotNull(result);
        assertEquals(1, result.getRegions().size());
        assertEquals("HN", result.getRegions().get(0).getRegion());
        assertTrue(result.getRegions().get(0).getEnabled());
    }

    @Test
    void testToCacheKey() {
        SettlementQuoteLambdaModel.CacheConfig cacheConfig = SettlementQuoteLambdaModel.CacheConfig.builder()
                .enabled(true)
                .ttlSeconds(300)
                .cacheKeyFields(List.of("field1"))
                .build();

        SettlementQuoteLambdaModel.MethodConfig methodConfig = SettlementQuoteLambdaModel.MethodConfig.builder()
                .cache(cacheConfig)
                .regions(List.of())
                .build();

        SettlementQuoteLambdaModel.MethodsConfig methodsConfig = SettlementQuoteLambdaModel.MethodsConfig.builder()
                .settlementQuoteDetails(methodConfig)
                .build();

        SettlementQuoteLambdaModel.ValueConfig valueConfig = SettlementQuoteLambdaModel.ValueConfig.builder()
                .methods(methodsConfig)
                .build();

        SettlementQuoteLambdaModel lambdaModel = SettlementQuoteLambdaModel.builder()
                .value(valueConfig)
                .build();

        List<Object> result = RegionMapper.toCacheKey(lambdaModel);

        assertNotNull(result);
        assertFalse(result.isEmpty());
        assertEquals(1, result.size());
        assertEquals("field1", result.get(0));
    }
}
