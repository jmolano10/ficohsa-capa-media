package com.ficohsa.driven.cobis.dto.request;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;
import java.util.Map;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CobisRequest {
    // Para operaciones legacy
    private String operation;
    private boolean flagcache;
    private List<CobisPayloadItem> payload;
    
    // Para stored procedures
    private CobisData data;
    
    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class CobisData {
        private String connectionName;
        private String catalogueName;
        private String procedureName;
        private Map<String, String> params;
    }
}
