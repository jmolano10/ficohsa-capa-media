package com.ficohsa.api.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Builder;
import java.util.List;

@Builder
@Schema(description = "Detalles de tarjetas de débito del cliente")
public record DebitCardDetailsDto(
    @Schema(description = "Información de la consulta del cliente")
    CustomerInquiryDto customerInquiry,
    @Schema(description = "Lista de tarjetas de débito del cliente")
    List<DebitCardInquiryDto> debitCardInquiry
) {}
