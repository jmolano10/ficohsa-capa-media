package com.ficohsa.driven.abanks.dto.request;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Map;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class AbanksRequest {
    private String connectionType;
    private String operationType;
    private String catalogueName;
    private String procedureName;
    private Map<String, String> params;
}
