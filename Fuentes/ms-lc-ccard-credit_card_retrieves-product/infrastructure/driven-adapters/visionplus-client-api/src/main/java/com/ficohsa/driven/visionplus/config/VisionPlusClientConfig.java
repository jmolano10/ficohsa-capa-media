package com.ficohsa.driven.visionplus.config;

import com.ficohsa.driven.visionplus.dto.request.VisionPlusRequest;
import com.ficohsa.driven.visionplus.dto.response.VisionPlusResponse;
import com.ficohsa.helper.HeadersBuilder;
import com.ficohsa.lib.core.dto.AppContext;
import com.ficohsa.lib.core.exception.BadRequestException;
import com.ficohsa.lib.core.exception.UnprocessableEntityException;
import com.ficohsa.lib.logging.clients.annotation.LogExternalCall;
import com.ficohsa.lib.web.component.WebClientComponent;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.context.properties.EnableConfigurationProperties;
import org.springframework.context.annotation.Configuration;
import org.springframework.core.ParameterizedTypeReference;
import reactor.core.publisher.Mono;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

@Slf4j
@Configuration
@EnableConfigurationProperties(VisionPlusCacheManagerPropsConfig.class)
@RequiredArgsConstructor
public class VisionPlusClientConfig {

    private static final String GT_PREFIX = "GT";

    private final WebClientComponent webClient;
    private final VisionPlusCacheManagerPropsConfig config;

    @LogExternalCall(provider = "VisionPlusCacheManager")
    public Mono<VisionPlusResponse> retrievesSettlementQuoteDetails(VisionPlusRequest request, AppContext context) {
        return validateMandatoryHeaders(context)
                .flatMap(this::validateDestinationBank)
                .flatMap(validatedContext -> processRequest(request, validatedContext));
    }

    private Mono<AppContext> validateMandatoryHeaders(AppContext context) {
        List<String> missingHeaders = new ArrayList<>();

        if (context.applicationId() == null || context.applicationId().isBlank()) {
            missingHeaders.add("Application-Id");
        }
        if (context.applicationUser() == null || context.applicationUser().isBlank()) {
            missingHeaders.add("Application-User");
        }
        if (context.authorization() == null || context.authorization().isBlank()) {
            missingHeaders.add("Authorization");
        }
        if (context.correlationId() == null) {
            missingHeaders.add("Correlation-Id");
        }
        if (context.sourceBank() == null || context.sourceBank().isBlank()) {
            missingHeaders.add("Source-Bank");
        }

        if (!missingHeaders.isEmpty()) {
            String errorMessage = String.format(
                "Missing mandatory headers required by VisionPlus: %s",
                String.join(", ", missingHeaders)
            );
            log.error("[ADAPTER] Integration Bad Request - {}", errorMessage);
            return Mono.error(new BadRequestException(errorMessage));
        }

        return Mono.just(context);
    }

    private Mono<AppContext> validateDestinationBank(AppContext context) {
        String destBank = context.destinationBank();
        String srcBank = context.sourceBank();

        if (destBank == null || destBank.isBlank()) {
            return Mono.just(context);
        }

        if (!destBank.equalsIgnoreCase(srcBank)) {
            String errorMessage = String.format(
                "Destination-Bank '%s' must match Source-Bank '%s'",
                destBank, srcBank
            );
            log.error("[ADAPTER] Business validation failed - {}", errorMessage);
            return Mono.error(new UnprocessableEntityException(errorMessage));
        }

        return Mono.just(context);
    }

    private Mono<VisionPlusResponse> processRequest(VisionPlusRequest request, AppContext context) {
        String sourceBank = context.sourceBank();
        boolean isGuatemala = isGuatemala(sourceBank);

        if (isGuatemala && request.getData() != null && request.getData().getRequest() != null) {
            request.getData().getRequest().setPartialSettlementAmount(null);
            request.getData().getRequest().setPsType(null);
        }

        String operation = isGuatemala
            ? config.getSettlementQuoteInquiryL8v1Operation()
            : config.getSettlementQuoteInquiryL8v2Operation();

        String paramName = isGuatemala
            ? config.getSettlementQuoteInquiryL8v1ParamName()
            : config.getSettlementQuoteInquiryL8v2ParamName();

        String uri = isGuatemala
            ? config.getSettlementQuoteInquiryL8v1Endpoint()
            : config.getSettlementQuoteInquiryL8v2Endpoint();

        if (request.getData() != null) {
            request.getData().setOperation(operation);
        }

        request.setParamName(paramName);
        request.setTtl(config.getCacheTtl());

        Map<String, String> headers = buildHeaders(context, operation);

        return webClient.post(uri, headers, request, new ParameterizedTypeReference<>() {});
    }

    private boolean isGuatemala(String sourceBank) {
        return sourceBank != null && sourceBank.toUpperCase().startsWith(GT_PREFIX);
    }

    private Map<String, String> buildHeaders(AppContext context, String operation) {
        Map<String, String> headers = HeadersBuilder.fromContext(context);
        // Override Caller-Service with config value specific to VisionPlus
        headers.put("Caller-Service", config.getSettlementQuoteInquiryCallerService());
        headers.put("operation", operation);

        if (context.applicationUser() != null) {
            headers.put("Application-User", context.applicationUser());
        }

        // Destination-Bank: fallback to sourceBank if null/blank
        String destBank = context.destinationBank();
        if (destBank == null || destBank.isBlank()) {
            destBank = context.sourceBank();
        }
        if (destBank != null) {
            headers.put("Destination-Bank", destBank);
        }
        return headers;
    }
}
