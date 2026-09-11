package com.ficohsa.driven.t24;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.ficohsa.driven.t24.config.T24ClientConfig;
import com.ficohsa.driven.t24.dto.DebitCardResponse;
import com.ficohsa.driven.t24.dto.request.T24Request;
import com.ficohsa.driven.t24.dto.response.T24Response;
import com.ficohsa.driven.t24.mapper.T24Mapper;
import com.ficohsa.lib.core.dto.AppContext;
import com.ficohsa.lib.core.dto.ErrorModel;
import com.ficohsa.lib.core.exception.BadGatewayException;
import com.ficohsa.lib.core.exception.BusinessException;
import com.ficohsa.lib.core.exception.InternalServerException;
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

import static com.ficohsa.driven.t24.consts.T24Consts.*;

@Slf4j
@Component
@RequiredArgsConstructor
public class T24QueryAdapter implements IDebitBasicInformationGateway, IDebitCardDetailsGateway {
    private final T24ClientConfig t24WebClient;
    private final T24Mapper t24Mapper;
    private final ObjectMapper objectMapper;

    @Override
    public String key() {
        return "HN01";
    }

    @Override
    public Mono<DebitBasicInformation> retrieveDebitBasicInformation(String debitCardId) {
        return Mono.deferContextual(contextView -> {
            log.info("[ADAPTER] Calling T24ClientConfig to retrieve debit card info for ID");
            String debitCartIdT24 = "...".concat(debitCardId);

            T24Request.EnquiryInputCollection enquiry = T24Request.EnquiryInputCollection.builder()
                    .columnName(COLUMN_NAME_ID)
                    .criteriaValue(debitCartIdT24)
                    .operand(OPERAND_LK)
                    .build();

            T24Request.Payload payload = T24Request.Payload.builder()
                    .type(TYPE_WSFICO_DEBIT_CARD_CUSTOMER)
                    .enquiryInputCollection(List.of(enquiry))
                    .build();

            T24Request requestBody = T24Request.builder()
                    .operation(OPERATION_CONSULTA_MAESTRA_TARJETA_DEBITO)
                    .resource(null)
                    .payload(payload)
                    .build();

            return AppTool.context()
                    .map(context -> withCallerService(context, "credit_card_retrieves-product-debit_basic_information"))
                    .flatMap(context -> t24WebClient.executeOperation(requestBody, context, OPERATION_CONSULTA_MAESTRA_TARJETA_DEBITO))
                    .<DebitBasicInformation>handle((response, sink) -> {
                        log.info("[ADAPTER] T24ClientConfig response: {}", response);

                        T24Response debitBasicInformation = objectMapper.convertValue(response, T24Response.class);

                        if (debitBasicInformation.getData() == null || debitBasicInformation.getData().getBody() == null) {
                            log.error("[ADAPTER] ADAPTER DebitBasicInformation BUSINESS ERROR: Response body is null");
                            sink.error(new InternalServerException("T24 response body is null"));
                            return;
                        }

                        if (debitBasicInformation.getData().getBody().getConsultaMaestraTarjetaDebitoResponse() != null
                                && debitBasicInformation.getData().getBody().getConsultaMaestraTarjetaDebitoResponse().getWsficodebitcardcustomerType() != null
                                && debitBasicInformation.getData().getBody().getConsultaMaestraTarjetaDebitoResponse().getWsficodebitcardcustomerType().getZerorecords() != null) {
                            log.error("[ADAPTER] ADAPTER DebitBasicInformation ZERO RECORD:");
                            sink.error(new NotFoundException("NOT_FOUND"));
                            return;
                        }

                        if (debitBasicInformation.getData().getBody().getConsultaMaestraTarjetaDebitoResponse() != null
                                && !"Success".equalsIgnoreCase(debitBasicInformation.getData().getBody().getConsultaMaestraTarjetaDebitoResponse().getStatus().getSuccessIndicator())) {
                            log.error("[ADAPTER] ADAPTER DebitBasicInformation BUSINESS ERROR:");
                            var code = debitBasicInformation.getData().getBody().getConsultaMaestraTarjetaDebitoResponse().getStatus().getSuccessIndicator();
                            String message = debitBasicInformation.getData().getBody().getConsultaMaestraTarjetaDebitoResponse().getStatus().getMessages();
                            log.error("[ADAPTER] T24ClientConfig business error: code: {}, message: {}", code, message);
                            sink.error(new BusinessException(
                                    new BadGatewayException(message),
                                    new ErrorModel.Upstream(
                                            "T24ClientConfig business error",
                                            code,
                                            message)

                            ));
                            return;
                        }

                        sink.next(t24Mapper.mapToDebitBasicInformation(debitBasicInformation));
                    });
        });
    }

    @Override
    public Mono<DebitCardDetails> retrieveDebitCardDetails(String customerIdentification, String accountStatusTypeValues, String accountNumber) {
        return Mono.deferContextual(contextView -> {
            log.info("[ADAPTER] Calling T24ClientConfig to retrieve debit card details for customer: {}", customerIdentification);

            T24Request.EnquiryInputCollection enquiry = T24Request.EnquiryInputCollection.builder()
                    .columnName(COLUMN_NAME_CUSTOMER)
                    .criteriaValue(customerIdentification)
                    .operand(OPERAND_EQ)
                    .build();

            T24Request.Payload payload = T24Request.Payload.builder()
                    .type(TYPE_WSFICO_DEBIT_CARD_CUSTOMER)
                    .enquiryInputCollection(List.of(enquiry))
                    .build();

            T24Request requestBody = T24Request.builder()
                    .operation(OPERATION_CONSULTA_MAESTRA_TARJETA_DEBITO)
                    .resource(null)
                    .payload(payload)
                    .build();

            return AppTool.context()
                    .map(context -> withCallerService(context, "credit_card_retrieves-product-debit_card_details"))
                    .flatMap(context -> t24WebClient.executeOperation(requestBody, context, OPERATION_CONSULTA_MAESTRA_TARJETA_DEBITO))
                    .<DebitCardDetails>handle((response, sink) -> {
                        log.info("[ADAPTER] T24ClientConfig debit card details response: {}", response);

                        DebitCardResponse debitCardResponse = objectMapper.convertValue(response, DebitCardResponse.class);

                        if (debitCardResponse.data() == null || debitCardResponse.data().body() == null) {
                            log.error("[ADAPTER] T24ClientConfig business error: Response body is null");
                            sink.error(new NotFoundException("No debit card details found"));
                            return;
                        }

                        sink.next(t24Mapper.mapToDebitCardDetails(debitCardResponse));
                    })
                    .doOnError(e -> log.error("[ADAPTER] Error calling T24ClientConfig for customer: {}", customerIdentification, e));
        });
    }

    private AppContext withCallerService(AppContext ctx, String callerService) {
        return new AppContext(ctx.acceptLanguage(), ctx.applicationId(), ctx.applicationUser(),
                ctx.authorization(), callerService, ctx.channel(), ctx.correlationId(),
                ctx.sourceBank(), ctx.destinationBank(), ctx.transactionDate(), ctx.url());
    }
}


