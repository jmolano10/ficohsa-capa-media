package com.ficohsa.driven.cobis.dto.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CobisDataDto {
    private BodyDto body;

    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class BodyDto {
        @JsonProperty("opConsultaTarjetaDebitoRespuesta")
        private OpConsultaTarjetaDebitoRespuestaDto opConsultaTarjetaDebitoRespuesta;
    }

    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class OpConsultaTarjetaDebitoRespuestaDto {
        private ContextoRespuestaDto contextoRespuesta;
        private TarjetaDto tarjeta;
        private CuentaPrincipalDto cuentaPrincipal;
        private CuentaSecundariaDto cuentaSecundaria;
    }

    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class ContextoRespuestaDto {
        private String codTipoRespuesta;
        private String valDescripcionRespuesta;
    }

    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class TarjetaDto {
        private String idCliente;
        private String nombreTarjeta;
        private String categoriaTarjeta;
        private String estadoTarjeta;
    }

    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class CuentaPrincipalDto {
        private String numCuenta;
        private String moneda;
    }

    @Data
    @Builder
    @NoArgsConstructor
    @AllArgsConstructor
    public static class CuentaSecundariaDto {
        private String numCuenta;
        private String moneda;
    }
}
