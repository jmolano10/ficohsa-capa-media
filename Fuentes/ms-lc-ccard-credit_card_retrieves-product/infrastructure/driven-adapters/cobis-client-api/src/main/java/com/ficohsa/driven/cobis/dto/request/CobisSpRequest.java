package com.ficohsa.driven.cobis.dto.request;

import lombok.Builder;
import lombok.Data;

import java.util.Map;

@Data
@Builder
public class CobisSpRequest {
    private CobisSpData data;

    @Data
    @Builder
    public static class CobisSpData {
        private String connectionName;
        private String catalogueName;
        private String procedureName;
        private Map<String, String> params;
    }
}
