package com.ficohsa.api.dto;

import io.swagger.v3.oas.annotations.media.Schema;
import lombok.Builder;

@Builder
@Schema(description = "Información de tarjeta de débito")
public record DebitCardInquiryDto(
    @Schema(description = "Número de la tarjeta de crédito a consultar", example = "4000123456789012")
    String creditCardId,
    @Schema(description = "Nombre del tarjetahabiente", example = "JUAN PEREZ")
    String cardHolderReference,
    @Schema(description = "Categoría de la tarjeta", example = "DEBITO")
    String productType,
    @Schema(description = "Tipo de tarjeta", example = "PRIMARY", allowableValues = {"PRIMARY", "SUPPLEMENTARY"})
    String cardType,
    @Schema(description = "Fecha de emisión de la tarjeta", example = "2023-01-15")
    String issueDate,
    @Schema(description = "Marca de la tarjeta (Visa, MasterCard, etc.)", example = "VISA")
    String productName,
    @Schema(description = "Moneda de la tarjeta", example = "USD")
    String accountCurrency,
    @Schema(description = "Número de cuenta asociada a la tarjeta", example = "1234567890")
    String associationReference,
    @Schema(description = "Estado de la tarjeta débito", example = "ACTIVE",
            allowableValues = {"ISSUED", "RETURNED", "SCRAP", "CANCEL", "ACTIVE", "DESTROYED", "BLOCKED"})
    String cardStatus
) {}
