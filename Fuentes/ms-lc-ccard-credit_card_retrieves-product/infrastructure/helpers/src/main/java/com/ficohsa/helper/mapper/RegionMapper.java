package com.ficohsa.helper.mapper;

import com.ficohsa.model.settlementquotedetails.RegionModel;
import com.ficohsa.model.settlementquotedetails.SettlementQuoteLambdaModel;
import lombok.experimental.UtilityClass;

import java.util.ArrayList;
import java.util.List;

@UtilityClass
public class RegionMapper {

    public static RegionModel toRegionModel(SettlementQuoteLambdaModel lambdaModel){

        return RegionModel.builder()
                .regions(lambdaModel.getValue().getMethods().getSettlementQuoteDetails().getRegions().stream()
                        .map(RegionMapper::toRegionConfig).toList())
                .build();
    }

    private static RegionModel.RegionConfig toRegionConfig(SettlementQuoteLambdaModel.RegionConfig region){

        return RegionModel.RegionConfig.builder()
                .region(region.getRegion())
                .enabled(region.getEnabled())
                .build();
    }

    public static List<Object> toCacheKey(SettlementQuoteLambdaModel lambdaModel){

        SettlementQuoteLambdaModel.CacheConfig cache = lambdaModel.getValue().getMethods().getSettlementQuoteDetails().getCache();

        List<Object> cacheConfig = new ArrayList<>();

        for (String field : cache.getCacheKeyFields()) {
            cacheConfig.add(field);
        }

        return cacheConfig;
    }
}
