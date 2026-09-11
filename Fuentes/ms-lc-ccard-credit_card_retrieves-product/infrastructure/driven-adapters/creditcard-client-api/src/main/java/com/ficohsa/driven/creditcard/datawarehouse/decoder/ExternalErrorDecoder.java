package com.ficohsa.driven.creditcard.datawarehouse.decoder;

import com.ficohsa.lib.core.exception.InternalServerException;
import feign.Response;
import feign.codec.ErrorDecoder;

public class ExternalErrorDecoder implements ErrorDecoder {
    @Override
    public Exception decode(String methodKey, Response response) {
        return new InternalServerException("External service error: " + response.status() + " - " + methodKey);
    }
}
