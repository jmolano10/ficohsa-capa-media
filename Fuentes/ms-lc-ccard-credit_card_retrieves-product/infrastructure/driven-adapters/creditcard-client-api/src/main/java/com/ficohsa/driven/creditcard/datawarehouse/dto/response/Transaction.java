package com.ficohsa.driven.creditcard.datawarehouse.dto.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import lombok.Data;

@Data
public class Transaction {

    @JsonProperty("FECHACORTE")
    private String periodDate;

    @JsonProperty("SALDOCORTE")
    private String periodBalance;

    @JsonProperty("PAGOMINIMO")
    private String amountDue;

    @JsonProperty("PAGOS")
    private String payments;

    @JsonProperty("CONSUMOS")
    private String merchSales;

    @JsonProperty("RETIROS")
    private String cashWithdrawal;

    @JsonProperty("LIMITE")
    private String limit;

    @JsonProperty("OTRASTRANSACCIONES")
    private String otherTransactions;

    @JsonProperty("INTERESES")
    private String interest;

    @JsonProperty("TOTALCARGOS")
    private String totalFees;

    @JsonProperty("OTROSDEBITOS")
    private String otherDebits;

    private String cycleDue;

    @JsonProperty("SALDOTOTAL")
    private String cycleTotalBalance;

    @JsonProperty("EXTRA_CASH_INFO")
    private ExtraCashInfo extraCashInfo;

    @JsonProperty("INTRA_CASH_INFO")
    private IntraCashInfo intraCashInfo;

    private String extraFee;

    @JsonProperty("CUOTAEXTRA")
    private String intraFee;

    @JsonProperty("SALDOEXTRA")
    private String extraBalance;

    @JsonProperty("SALDOINTRA")
    private String intraBalance;

    @JsonProperty("MORA")
    public void setMora(String value) {
        this.cycleDue = value;
        this.extraFee = value;
    }

}
