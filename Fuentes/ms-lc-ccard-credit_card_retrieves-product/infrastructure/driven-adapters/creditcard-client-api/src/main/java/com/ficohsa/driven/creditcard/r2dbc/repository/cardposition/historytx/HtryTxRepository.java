package com.ficohsa.driven.creditcard.r2dbc.repository.cardposition.historytx;

import com.ficohsa.driven.creditcard.r2dbc.dto.cardposition.HtryTxDto;
import reactor.core.publisher.Mono;

public interface HtryTxRepository {
    Mono<HtryTxDto> rtvHtryTx(String cardNumber, String rgIso03, String group);
}
