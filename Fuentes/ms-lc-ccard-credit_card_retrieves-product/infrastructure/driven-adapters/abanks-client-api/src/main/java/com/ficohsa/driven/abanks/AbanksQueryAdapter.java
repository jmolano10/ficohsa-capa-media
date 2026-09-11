package com.ficohsa.driven.abanks;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.ficohsa.driven.abanks.config.AbankClientConfig;
import com.ficohsa.driven.abanks.dto.request.AbanksRequest;
import com.ficohsa.driven.abanks.dto.response.AbanksDataDto;
import com.ficohsa.driven.abanks.dto.response.DebitCardDetailsDataDto;
import com.ficohsa.driven.abanks.dto.response.DebitCardDetailsResponse;
import com.ficohsa.driven.abanks.mapper.AbanksMapper;
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

import static com.ficohsa.driven.abanks.consts.AbanksConsts.*;

@Slf4j
@Component
@RequiredArgsConstructor
public class AbanksQueryAdapter implements IDebitBasicInformationGateway, IDebitCardDetailsGateway {
    private final AbankClientConfig abankWebClient;
    private final AbanksMapper abanksMapper;
    private final ObjectMapper objectMapper;
    private static final String SYSTEM = "ABANKS";

    @Override
    public String key() {
        return "GT01";
    }

    @Override
    public Mono<DebitBasicInformation> retrieveDebitBasicInformation(String debitCardId) {
        return Mono.deferContextual(contextView -> {
            log.info("[ADAPTER] Calling AbankClientConfig to retrieve debit cards");
            Map<String, String> params = Map.of("PV_NUMERO_TARJETA", debitCardId);
            String region = contextView.getOrDefault("Source-Bank", "");

            String parameterName = region.equals(GT01) ? PROXYABANKSGT : PROXYABANKSPA;

            AbanksRequest requestBody = AbanksRequest.builder()
                    .connectionType("jdbc")
                    .operationType("query")
                    .catalogueName(parameterName)
                    .procedureName("OSB_MG_CONSULTA_TARJETA_DEBITO")
                    .params(params)
                    .build();

            return AppTool.context()
                    .flatMap(context -> abankWebClient.getBankProducts(requestBody, context))
                    .<DebitBasicInformation>handle((abanksResponse, sink) -> {
                        List<AbanksDataDto> resultSet = abanksResponse.getResultSet();

                        if (resultSet == null || resultSet.isEmpty()) {
                            log.error("[ADAPTER] AbankClientConfig business error: #result-set-1 is null or empty");
                            sink.error(new NotFoundException("NOT_FOUND"));
                            return;
                        }
                        AbanksDataDto data = resultSet.get(0);

                        if (data.getMensajeError() != null
                                && data.getCodigoError() != null) {
                            log.error("[ADAPTER] AbankClientConfig business error: Starting CoreBusinessException adapter");
                            var code = data.getCodigoError();
                            String message = data.getMensajeError();
                            log.error("[ADAPTER] AbankClientConfig business error: code: {}, message: {}", code, message);
                            sink.error(new NotFoundException("NOT_FOUND"));
                            return;
                        }

                        sink.next(abanksMapper.mapToDebitBasicInformation(abanksResponse));
                    });
        });
    }


    @Override
    public Mono<DebitCardDetails> retrieveDebitCardDetails(String customerIdentification, String accountStatusTypeValues, String accountNumber) {
        return Mono.deferContextual(contextView -> {
            log.info("[ADAPTER] Calling AbankClientConfig to retrieve debit card details for customer: {}", customerIdentification);
            Map<String, String> params = Map.of("customer_id", customerIdentification, "card_status", accountStatusTypeValues);
            String region = contextView.getOrDefault("Source-Bank", "");

            String parameterName = region.equals(GT01) ? PROXYABANKSGT : PROXYABANKSPA;
            log.info("[ADAPTER] parameterName Request: {}", parameterName);

            AbanksRequest requestBody = AbanksRequest.builder()
                    .connectionType("jdbc")
                    .operationType("query")
                    .catalogueName(parameterName)
                    .procedureName("OSB_P_CON_TD_X_CLIENTE")
                    .params(params)
                    .build();

            return AppTool.context()
                    .flatMap(context -> abankWebClient.getBankProducts(requestBody, context))
                    .<DebitCardDetails>handle((abanksResponse, sink) -> {
                        log.info("[ADAPTER] AbankClientConfig debit card details response: {}", abanksResponse);

                        if (abanksResponse.getData() == null) {
                            log.error("[ADAPTER] AbankClientConfig business error: Response body is null");
                            sink.error(new NotFoundException("No debit card details found"));
                        }

                        DebitCardDetailsResponse debitCardDetailsResponse = new DebitCardDetailsResponse();
                        debitCardDetailsResponse.setData(objectMapper.convertValue(abanksResponse.getData(), DebitCardDetailsDataDto.class));

                        sink.next(abanksMapper.mapToDebitCardDetails(debitCardDetailsResponse));
                    })
                    .doOnError(e -> log.error("[ADAPTER] Error calling AbankClientConfig for customer: {}", customerIdentification, e));
        });
    }

}


