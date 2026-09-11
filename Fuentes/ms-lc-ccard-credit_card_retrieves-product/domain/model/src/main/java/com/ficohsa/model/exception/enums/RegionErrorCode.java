package com.ficohsa.model.exception.enums;

public enum RegionErrorCode {
    REGION_NOT_AVAILABLE("MW-0008", "Región no habilitada para este servicio"),
    REGION_NOT_IMPLEMENT("MW-0009", "Región no implementada para este servicio"),
    REGION_FORMAT_INVALID("MW-0010", "La solicitud contiene datos inválidos o incompletos");

    private final String code;
    private final String message;

    RegionErrorCode(String code, String message) {
        this.code = code;
        this.message = message;
    }

    public String getCode() {
        return code;
    }

    public String getMessage() {
        return message;
    }
}
