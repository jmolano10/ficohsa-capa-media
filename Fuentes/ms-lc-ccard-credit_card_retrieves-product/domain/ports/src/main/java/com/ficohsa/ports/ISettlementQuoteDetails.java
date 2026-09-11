package com.ficohsa.ports;

import com.ficohsa.model.settlementquotedetails.SettlementQuoteDetails;
import com.ficohsa.model.settlementquotedetails.SettlementQuoteDetailsModel;
import reactor.core.publisher.Mono;

public interface ISettlementQuoteDetails {
    Mono<SettlementQuoteDetailsModel> retrieveSettlementQuoteDetails(SettlementQuoteDetails request);
}
