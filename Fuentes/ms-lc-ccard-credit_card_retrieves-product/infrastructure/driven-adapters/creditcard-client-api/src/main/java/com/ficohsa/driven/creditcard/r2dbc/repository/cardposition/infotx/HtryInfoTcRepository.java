package com.ficohsa.driven.creditcard.r2dbc.repository.cardposition.infotx;

import com.ficohsa.driven.creditcard.r2dbc.dto.cardposition.HtryInfoTcDto;
import reactor.core.publisher.Mono;

public interface HtryInfoTcRepository {
    Mono<HtryInfoTcDto> rtvHtryInfoTc(String cardNumber, String rgIso03);
}
