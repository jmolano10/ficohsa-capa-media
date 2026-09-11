package com.ficohsa.driven.abanks.dto.response;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Collections;
import java.util.List;
import java.util.Map;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class AbanksResponse {
    private Map<String, List<AbanksDataDto>> data;

    public List<AbanksDataDto> getResultSet() {
        if (data == null) {
            return Collections.emptyList();
        }
        List<AbanksDataDto> result = data.get("#result-set-1");
        return result != null ? result : Collections.emptyList();
    }
}
