package com.ficohsa.api.openapi;

public final class OpenApiResponseConfig {

    public static final String CREDIT_CARD_RETRIEVE_SUCCESS = """
    {
      "meta": { "bian": { "businessArea": "OperationsAndExecution", "businessDomain": "Cards", "serviceDomain": "CreditCard" } },
      "data": { "creditCards": [] }
    }
    """;

    public static final String BAD_REQUEST = """
    {
      "type": "https://api.ficohsa.com/errors/bad-request",
      "title": "Bad Request",
      "status": 400,
      "detail": "Los parámetros o formato son inválidos",
      "instance": "/cards/credit-card-retrieves/v1",
      "correlationId": "4f7b-abc123",
      "timestamp": "2025-08-14T20:15:00Z"
    }
    """;

    public static final String UNAUTHORIZED = """
    {
      "type": "https://api.ficohsa.com/errors/unauthorized",
      "title": "Unauthorized",
      "status": 401,
      "detail": "Cliente no autenticado o credenciales inválidas",
      "instance": "/cards/credit-card-retrieves/v1",
      "correlationId": "4f7b-abc123",
      "timestamp": "2025-08-14T20:15:00Z"
    }
    """;

    public static final String NOT_FOUND = """
    {
      "type": "https://api.ficohsa.com/errors/not-found",
      "title": "Not Found",
      "status": 404,
      "detail": "Recurso solicitado no existe",
      "instance": "/cards/credit-card-retrieves/v1",
      "correlationId": "4f7b-abc123",
      "timestamp": "2025-08-14T20:15:00Z"
    }
    """;

    public static final String INTERNAL_SERVER_ERROR = """
    {
      "type": "https://api.ficohsa.com/errors/internal-server-error",
      "title": "Internal Server Error",
      "status": 500,
      "detail": "Error inesperado en el servicio",
      "instance": "/cards/credit-card-retrieves/v1",
      "correlationId": "4f7b-abc123",
      "timestamp": "2025-08-14T20:15:00Z"
    }
    """;

    public static final String BAD_GATEWAY = """
    {
      "type": "https://api.ficohsa.com/errors/bad-gateway",
      "title": "Bad Gateway",
      "status": 502,
      "detail": "Falla de un servicio intermedio/gateway",
      "instance": "/cards/credit-card-retrieves/v1",
      "correlationId": "4f7b-abc123",
      "timestamp": "2025-08-14T20:15:00Z"
    }
    """;

    private OpenApiResponseConfig() {
    }
}
