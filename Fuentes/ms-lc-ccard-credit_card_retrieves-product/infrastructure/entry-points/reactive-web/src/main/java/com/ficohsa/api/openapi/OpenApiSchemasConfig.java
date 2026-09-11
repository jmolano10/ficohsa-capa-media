package com.ficohsa.api.openapi;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.enums.ParameterIn;
import io.swagger.v3.oas.annotations.media.Content;
import io.swagger.v3.oas.annotations.media.ExampleObject;
import io.swagger.v3.oas.annotations.responses.ApiResponse;
import org.springdoc.core.annotations.RouterOperation;
import org.springdoc.core.annotations.RouterOperations;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.MediaType;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.reactive.function.server.RouterFunction;
import org.springframework.web.reactive.function.server.ServerResponse;

import static org.springframework.web.reactive.function.server.RouterFunctions.route;

@Configuration
public class OpenApiSchemasConfig {

    @Bean
    @RouterOperations({
        @RouterOperation(
            path = "/cards/credit-card-retrieves/v1/{customerIdentification}/retrieve",
            method = RequestMethod.GET,
            produces = MediaType.APPLICATION_JSON_VALUE,
            operation = @Operation(
                operationId = "getCreditCard",
                summary = "Consultar tarjetas de crédito de un cliente",
                description = "Consulta las tarjetas de crédito asociadas a un cliente",
                tags = {"CreditCard"},
                parameters = {
                    @Parameter(name = "customerIdentification", in = ParameterIn.PATH, required = true, description = "Identificador del cliente"),
                    @Parameter(name = "Authorization", in = ParameterIn.HEADER, required = true, description = "Bearer access token"),
                    @Parameter(name = "Source-Bank", in = ParameterIn.HEADER, required = true, description = "Código del banco origen"),
                    @Parameter(name = "Application-Id", in = ParameterIn.HEADER, required = true, description = "Identificador de la aplicación")
                },
                responses = {
                    @ApiResponse(responseCode = "200", description = "Respuesta exitosa",
                        content = @Content(mediaType = MediaType.APPLICATION_JSON_VALUE,
                            examples = @ExampleObject(name = "SUCCESS", value = OpenApiResponseConfig.CREDIT_CARD_RETRIEVE_SUCCESS))),
                    @ApiResponse(responseCode = "400", description = "Bad Request",
                        content = @Content(mediaType = MediaType.APPLICATION_JSON_VALUE,
                            examples = @ExampleObject(name = "BAD_REQUEST", value = OpenApiResponseConfig.BAD_REQUEST))),
                    @ApiResponse(responseCode = "404", description = "Not Found",
                        content = @Content(mediaType = MediaType.APPLICATION_JSON_VALUE,
                            examples = @ExampleObject(name = "NOT_FOUND", value = OpenApiResponseConfig.NOT_FOUND))),
                    @ApiResponse(responseCode = "500", description = "Internal Server Error",
                        content = @Content(mediaType = MediaType.APPLICATION_JSON_VALUE,
                            examples = @ExampleObject(name = "INTERNAL_SERVER_ERROR", value = OpenApiResponseConfig.INTERNAL_SERVER_ERROR)))
                }
            )
        )
    })
    public RouterFunction<ServerResponse> documentedRoutes() {
        return route()
            .GET("/__openapi-doc-only", req -> ServerResponse.notFound().build())
            .build();
    }
}
