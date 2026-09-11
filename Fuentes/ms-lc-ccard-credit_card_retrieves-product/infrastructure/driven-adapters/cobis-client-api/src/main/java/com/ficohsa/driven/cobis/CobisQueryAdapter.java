package com.ficohsa.driven.cobis;

import com.ficohsa.driven.cobis.config.CobisClientConfig;
import com.ficohsa.driven.cobis.dto.request.CobisPayloadItem;
import com.ficohsa.driven.cobis.dto.request.CobisRequest;
import com.ficohsa.driven.cobis.dto.request.CobisSpRequest;
import com.ficohsa.driven.cobis.mapper.CobisMapper;
import com.ficohsa.lib.core.exception.NotFoundException;
import com.ficohsa.lib.core.utility.AppTool;
import com.ficohsa.model.debitbasicinformation.DebitBasicInformation;
import com.ficohsa.model.debitcarddetails.DebitCardDetails;
import com.ficohsa.ports.IDebitBasicInformationGateway;
import com.ficohsa.ports.IDebitCardDetailsGateway;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;
import reactor.core.publisher.Mono;

import java.util.List;
import java.util.Map;

import static com.ficohsa.driven.cobis.consts.CobisConsts.*;

@Slf4j
@Component
@RequiredArgsConstructor
public class CobisQueryAdapter implements IDebitBasicInformationGateway, IDebitCardDetailsGateway {
    private final CobisClientConfig cobisWebClient;
    private final CobisMapper cobisMapper;

    @Override
    public String key() {
        return "NI01";
    }

    @Override
    public Mono<DebitBasicInformation> retrieveDebitBasicInformation(String debitCardId) {
        return Mono.deferContextual(contextView -> {
            log.info("[ADAPTER] Calling CobisClientConfig to retrieve debit card info for ID: {}", debitCardId);
            
            CobisRequest requestBody = CobisRequest.builder()
                    .operation(OPERATION_CONSULTA_TARJETA_DEBITO)
                    .flagcache(false)
                    .payload(List.of(
                        CobisPayloadItem.builder()
                            .type("contextoTransaccional")
                            .codCanalOriginador(1)
                            .build(),
                        CobisPayloadItem.builder()
                            .type("tarjetaDebito")
                            .value(debitCardId)
                            .build()
                    ))
                    .build();

            return AppTool.context()
                    .flatMap(context -> cobisWebClient.executeOperation(requestBody, context, OPERATION_CONSULTA_TARJETA_DEBITO))
                    .<DebitBasicInformation>handle((cobisResponse, sink) -> {
                        log.info("[ADAPTER] CobisClientConfig response: {}", cobisResponse);

                        var contextoRespuesta = cobisResponse.getData().getBody()
                                .getOpConsultaTarjetaDebitoRespuesta().getContextoRespuesta();
                        
                        if (!"0".equals(contextoRespuesta.getCodTipoRespuesta())) {
                            log.error("[ADAPTER] CobisClientConfig business error");
                            sink.error(new NotFoundException("NOT_FOUND"));
                            return;
                        }

                        sink.next(cobisMapper.mapToDebitBasicInformation(cobisResponse));
                    });
        });
    }

    @Override
    public Mono<DebitCardDetails> retrieveDebitCardDetails(String customerIdentification, String accountStatusTypeValues, String accountNumber) {
        return Mono.deferContextual(contextView -> {
            log.info("[ADAPTER] Calling COBIS SP to retrieve debit card details for customer: {}", customerIdentification);

            var requestData = CobisSpRequest.CobisSpData.builder()
                    .connectionName(SP_CONNECTION_NAME)
                    .catalogueName(SP_CATALOGUE_NAME)
                    .procedureName(SP_PROCEDURE_NAME)
                    .params(Map.of(
                            "i_CUSTOMER_ID", customerIdentification,
                            "i_CARD_STATUS", accountStatusTypeValues
                    ))
                    .build();

            var request = CobisSpRequest.builder()
                    .data(requestData)
                    .build();

            return AppTool.context()
                    .flatMap(context -> cobisWebClient.executeSpOperation(request, context))
                    .map( cobisResponse -> cobisMapper.mapToDebitCardDetails(cobisResponse, request))
                    .doOnError(e -> log.error("[ADAPTER] Error calling COBIS SP for customer: {}", customerIdentification, e));
        });
    }
}



