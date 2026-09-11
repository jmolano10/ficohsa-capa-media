package com.ficohsa.api.dto;

import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Builder;

@Builder
@Schema(description = "Parámetros para consulta de detalles de tarjetas de débito")
public record DebitCardDetailsPathParamsDto(
    @Parameter(description = "Identificador único del cliente", required = true, example = "0801199012345")
    @Schema(description = "Identificador único del cliente")
    String customerIdentification
) {}
