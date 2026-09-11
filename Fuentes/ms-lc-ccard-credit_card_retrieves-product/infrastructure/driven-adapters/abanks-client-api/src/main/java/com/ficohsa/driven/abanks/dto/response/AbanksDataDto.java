package com.ficohsa.driven.abanks.dto.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class AbanksDataDto {
    
    @JsonProperty("PV_CODIGO_CLIENTE")
    private String codigoCliente;
    
    @JsonProperty("PV_NOMBRE_TARJETA")
    private String nombreTarjeta;
    
    @JsonProperty("PV_CODIGO_MONEDA")
    private String codigoMoneda;
    
    @JsonProperty("PV_TIPO_TARJETA")
    private String tipoTarjeta;
    
    @JsonProperty("PV_ESTATUS_TARJETA")
    private String estatusTarjeta;
    
    @JsonProperty("PV_CUENTA")
    private String cuenta;
    
    @JsonProperty("PV_CANTIDAD_CUENTAS")
    private String cantidadCuentas;
    
    @JsonProperty("PV_ORDEN_CUENTAS")
    private String ordenCuentas;
    
    @JsonProperty("PV_CODIGO_ERROR")
    private String codigoError;
    
    @JsonProperty("PV_CODIGO_RETORNO")
    private String codigoRetorno;
    
    @JsonProperty("PV_MENSAJE_ERROR")
    private String mensajeError;
}
