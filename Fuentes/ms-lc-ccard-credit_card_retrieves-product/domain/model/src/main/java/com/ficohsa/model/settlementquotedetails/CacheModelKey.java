package com.ficohsa.model.settlementquotedetails;

import lombok.Builder;
import lombok.Data;
import java.util.List;

@Data
@Builder
public class CacheModelKey {

    private CacheConfig cache;

    @Data
    @Builder
    public static class CacheConfig {

        private Boolean enabled;
        private Integer ttlSeconds;
        private List<String> cacheKeyFields;
    }
}
