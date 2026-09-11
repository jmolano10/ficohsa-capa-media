package com.ficohsa.model;

import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class RegionStatusModel {

    private RegionStatusRetrieve regionStatusRetrieve;

    @Data
    @Builder
    public static class RegionStatusRetrieve {
        private List<RegionState> regionStates;
    }

    @Data
    @Builder
    public static class RegionState {
        private String region;
        private Boolean enabled;
    }

}
