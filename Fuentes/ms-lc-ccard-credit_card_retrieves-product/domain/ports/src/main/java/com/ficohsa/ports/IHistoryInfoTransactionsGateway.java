package com.ficohsa.ports;

import com.ficohsa.model.cardposition.HistoryInfoResponse;
import reactor.core.publisher.Mono;

public interface IHistoryInfoTransactionsGateway {
    Mono<HistoryInfoResponse> rtvHistoryInfoTc(String cardNumber, String rgIso03);
}

