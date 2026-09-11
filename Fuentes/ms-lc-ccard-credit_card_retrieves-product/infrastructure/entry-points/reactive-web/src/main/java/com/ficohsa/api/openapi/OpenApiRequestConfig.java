package com.ficohsa.api.openapi;

public final class OpenApiRequestConfig {

    public static final String CREDIT_CARD_RETRIEVE_REQUEST = """
    {
      "data": {
        "customerIdentification": "0801199012345"
      }
    }
    """;

    public static final String SETTLEMENT_QUOTE_DETAILS_REQUEST = """
    {
      "data": {
        "accountNumber": "4000123456789012",
        "planSequenceNumber": "001"
      }
    }
    """;

    private OpenApiRequestConfig() {
    }
}
