package com.ficohsa.driven.creditcard.r2dbc.dto.cardposition;

import lombok.*;

import java.util.List;

@Getter
@Setter
@Builder
@AllArgsConstructor
@NoArgsConstructor
public class HtryInfoTcDto {
    private Integer codigoError;
    private String mensajeError;
    private List<InfoHistoricaRow> rowSet;

    @Getter
    @Setter
    @AllArgsConstructor
    @NoArgsConstructor
    public static class InfoHistoricaRow {
        private String accountName;
        private String numtarjeta;
        private String accountNbr;
        private String fecproxecta;
        private String fechamaximapago;
        private String codMoneda;
        private String crlim;
        private String puntosAcumulados;
        private String totbalini;
        private String pagominimo;
        private String actualdue;
        private String saldoAlCorte;
    }
}
