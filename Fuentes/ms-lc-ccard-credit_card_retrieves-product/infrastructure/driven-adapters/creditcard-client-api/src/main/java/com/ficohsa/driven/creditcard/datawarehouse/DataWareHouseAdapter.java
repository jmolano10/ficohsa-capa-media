package com.ficohsa.driven.creditcard.datawarehouse;

import com.ficohsa.driven.creditcard.datawarehouse.client.ExternalDataWareHouseClient;
import com.ficohsa.driven.creditcard.datawarehouse.dto.request.DataWareHouseRequest;
import com.ficohsa.driven.creditcard.datawarehouse.dto.response.DataWareHouseResponse;
import com.ficohsa.driven.creditcard.datawarehouse.mapper.IDataWareHouseMapper;
import com.ficohsa.lib.core.exception.InternalServerException;
import com.ficohsa.model.CreditCardsDetails;
import com.ficohsa.ports.ICreditCardsDetailsGateway;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import org.springframework.web.server.ResponseStatusException;
import reactor.core.publisher.Mono;

import java.util.Map;

@Slf4j
@Component
@RequiredArgsConstructor
public class DataWareHouseAdapter implements ICreditCardsDetailsGateway {

    private static final String CATALOGUE_NAME = "dbo";
    private static final String PROCEDURE_NAME = "p_consulta_ONBASE_V2";
    private static final String IDENTITY = "IDENTIDAD";

    private final ExternalDataWareHouseClient externalDataWareHouseClient;
    private final IDataWareHouseMapper dataWareHouseMapper;

    @Override
    public Mono<CreditCardsDetails> getCreditCard(String customerIdentification) {
        log.info("[ADAPTER] Retrieving credit cards for customer: {}", customerIdentification);
        
        return Mono.fromCallable(() -> {
            DataWareHouseRequest request = new DataWareHouseRequest(
                CATALOGUE_NAME,
                PROCEDURE_NAME,
                Map.of(IDENTITY, customerIdentification)
            );
            
            DataWareHouseResponse response = externalDataWareHouseClient.getCreditCards(request);
            
            log.info("[ADAPTER] Successfully retrieved credit cards for customer: {}", customerIdentification);
            return dataWareHouseMapper.mapToCreditCardsDetails(response);
        })
        .onErrorMap(e -> !(e instanceof ResponseStatusException), e -> {
            log.error("[ADAPTER] Unexpected error retrieving credit cards for customer {}", customerIdentification, e);
            return new InternalServerException(String.valueOf(org.springframework.http.HttpStatus.INTERNAL_SERVER_ERROR));
        })
        .doOnError(ResponseStatusException.class, e -> 
            log.error("[ADAPTER] Error retrieving credit cards for customer {}: {}", customerIdentification, e.getReason())
        );
    }
}

