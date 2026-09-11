package com.ficohsa.driven.creditcard.errormanager;


import com.ficohsa.driven.creditcard.errormanager.dto.ErrorRequest;
import com.ficohsa.driven.creditcard.errormanager.dto.ErrorResponse;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import reactor.core.publisher.Mono;

import java.util.Map;

public interface ErrorManagerClient {
    Mono<ErrorResponse> consume(@RequestBody ErrorRequest request, @RequestHeader Map<String, String> correlationId);
}
