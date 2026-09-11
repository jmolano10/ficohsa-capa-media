package com.ficohsa.driven.creditcard.datawarehouse.dto.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

@Data
public class CardAccountDto {

    @JsonProperty("NUMEROCUENTA")
    private String account;

    @JsonProperty("ESTADO")
    private String status;

    @JsonProperty("GRUPOAFINIDAD")
    private String affinityGroup;

    private String product;

    @JsonProperty("MODELOLIQUIDACION")
    private String clearingModel;

    @JsonProperty("FECHAAPERTURA")
    private String openingDate;

    @JsonProperty("FECHACANCELACION")
    private String cancelationDate;

    @JsonProperty("FECHAULTIMOEXTRA")
    private String lastExtraDate;

    @JsonProperty("MORAACTUAL")
    private String currentDue;

    @JsonProperty("LIMITEACTUAL")
    private String currentLimit;

    @JsonProperty("SALDOACTUAL")
    private String currentBalance;

    @JsonProperty("SALDOCORTE")
    private String closingBalance;

    @JsonProperty("SALDOEXTRA")
    private String extraBalance;

    @JsonProperty("SALDOINTRA")
    private String intraBalance;

    @JsonProperty("CUOTASEXTRAVIGENTES")
    private String activeExtraInstallments;

    @JsonProperty("CODBLOQUE1")
    private String lockcode1;

    @JsonProperty("CODBLOQUE2")
    private String lockcode2;

    @JsonProperty("LOGO")
    private String logo;

    @JsonProperty("DISPONIBLE")
    private String availableCash;

    @JsonProperty("FECBLOQUE1")
    private String lockDate1;

    @JsonProperty("FECBLOQUE2")
    private String lockDate2;

    private String bin;

    private String extraApprovalDate;

    private String intraApprovalDate;

    @JsonProperty("FECHA_APROBACION_INTRA")
    private String pilApprovalDate;

    @JsonProperty("LIMITE_PREVIO")
    private String priorLimit;

    @JsonProperty("SALDO_AUTORIZACION")
    private String authBalance;

    @JsonProperty("PRODUCT_TRANSACTIONS")
    private ProductTransactions productTransactions;

    @JsonProperty("PRODUCTO")
    public void setProductFromPRODUCTO(String productoValue) {
        this.product = productoValue;
        this.bin = productoValue;
    }

    @JsonProperty("FECHA_APROBACION_EXTRA")
    public void setExtraApprovalDate(String value) {
        this.extraApprovalDate = value;
        this.intraApprovalDate = value;
    }
}
