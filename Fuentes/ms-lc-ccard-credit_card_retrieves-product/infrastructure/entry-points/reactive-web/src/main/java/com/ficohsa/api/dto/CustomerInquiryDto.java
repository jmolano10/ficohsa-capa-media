package com.ficohsa.api.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Builder;

@Builder
@Schema(description = "Información de la consulta del cliente")
public record CustomerInquiryDto(
    @Schema(description = "Identificador del cliente", example = "0801199012345")
    String customerIdentification
) {}
