package com.ficohsa.model.settlementquotedetails;

import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class RegionModel {

    private List<RegionConfig> regions;

    @Data
    @Builder
    public static class RegionConfig {

        private String region;
        private Boolean enabled;
    }

}
