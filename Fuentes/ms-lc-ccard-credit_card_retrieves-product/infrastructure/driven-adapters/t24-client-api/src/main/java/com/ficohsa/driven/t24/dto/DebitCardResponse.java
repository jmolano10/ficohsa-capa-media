package com.ficohsa.driven.t24.dto;

import java.util.List;

public record DebitCardResponse(
    Meta meta,
    Data data
) {
    public record Meta(
        String serviceName,
        String serviceDomain,
        String timestamp
    ) {}
    
    public record Data(
        Body body
    ) {}
    
    public record Body(
        ConsultaMaestraTarjetaDebitoResponse consultaMaestraTarjetaDebitoResponse
    ) {}
    
    public record ConsultaMaestraTarjetaDebitoResponse(
        Status status,
        WsficodebitcardcustomerType wsficodebitcardcustomerType
    ) {}
    
    public record Status(
        String successIndicator
    ) {}
    
    public record WsficodebitcardcustomerType(
        String zerorecords,
        GWsficodebitcardcustomerDetailType gWsficodebitcardcustomerDetailType
    ) {}
    
    public record GWsficodebitcardcustomerDetailType(
        List<MWsficodebitcardcustomerDetailType> mWsficodebitcardcustomerDetailType
    ) {}
    
    public record MWsficodebitcardcustomerDetailType(
        String customer,
        String cardnumber,
        String nameoncard,
        String currency1,
        String primaryacct,
        String scndryacct,
        String cardstatus,
        String typeofcard,
        String producttype,
        String customerlegalId,
        String issuedate
    ) {}
}
