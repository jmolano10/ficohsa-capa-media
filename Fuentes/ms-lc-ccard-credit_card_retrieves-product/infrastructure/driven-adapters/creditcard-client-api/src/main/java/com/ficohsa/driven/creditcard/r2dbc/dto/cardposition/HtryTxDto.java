package com.ficohsa.driven.creditcard.r2dbc.dto.cardposition;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import java.util.List;

@Getter
@Setter
@AllArgsConstructor
@NoArgsConstructor
public class HtryTxDto {
    private Integer codigoError;
    private String mensajeError;
    private List<TransaccionRow> rowSet;

    @Getter
    @Setter
    @AllArgsConstructor
    @NoArgsConstructor
    public static class TransaccionRow {
        private String numtarjeta;
        private String nombreTarjetahabiente;
        private String fecefectiva;
        private String descripcion;
        private String monto;
        private String codMoneda;
        private String tipoMovimiento;
        private String montoOriginal;
        private String monedaOriginal;
    }
}
