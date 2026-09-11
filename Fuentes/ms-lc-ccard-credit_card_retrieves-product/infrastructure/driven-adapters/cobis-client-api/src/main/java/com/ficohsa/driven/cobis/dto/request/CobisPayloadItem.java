package com.ficohsa.driven.cobis.dto.request;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CobisPayloadItem {
    private String type;
    private Object value;
    private Integer codCanalOriginador;
}
