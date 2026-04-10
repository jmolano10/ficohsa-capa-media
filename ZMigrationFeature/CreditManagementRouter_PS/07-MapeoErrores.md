# Mapeo de Errores - CreditManagementRouter_PS

## Códigos de Error del Core y Homologación HTTP

| Código Error (CreditManagement Core) | Descripción Error (CreditManagement Core) | Código HTTP | Descripción Error HTTP |
|--------------------------------------|-------------------------------------------|-------------|----------------------|
| MW-0001 | INVALID REQUEST FORMAT | 400 | Bad Request |
| MW-0002 | MISSING REQUIRED PARAMETERS | 400 | Bad Request |
| MW-0003 | INVALID REGION REQUEST | 400 | Bad Request |
| MW-0004 | SERVICE NOT AVAILABLE | 503 | Service Unavailable |
| MW-0005 | TIMEOUT ERROR | 408 | Request Timeout |
| MW-0006 | AUTHENTICATION FAILED | 401 | Unauthorized |
| MW-0007 | AUTHORIZATION FAILED | 403 | Forbidden |
| MW-0008 | RESOURCE NOT FOUND | 404 | Not Found |
| MW-0009 | INTERNAL SERVER ERROR | 500 | Internal Server Error |
| MW-0010 | DATABASE CONNECTION ERROR | 500 | Internal Server Error |
| MW-0011 | TRANSFORMATION ERROR | 500 | Internal Server Error |
| MW-0012 | EXTERNAL SERVICE ERROR | 502 | Bad Gateway |
| MW-0013 | INVALID CUSTOMER DATA | 400 | Bad Request |
| MW-0014 | CUSTOMER NOT FOUND | 404 | Not Found |
| MW-0015 | INSUFFICIENT CREDIT SCORE | 422 | Unprocessable Entity |
| MW-0016 | CREDIT LIMIT EXCEEDED | 422 | Unprocessable Entity |
| MW-0017 | INVALID PRODUCT TYPE | 400 | Bad Request |
| MW-0018 | REGION NOT SUPPORTED | 501 | Not Implemented |
| MW-0019 | CURRENCY NOT SUPPORTED | 400 | Bad Request |
| MW-0020 | INVALID DATE FORMAT | 400 | Bad Request |

## Errores Específicos por Región

### Honduras (HN01)

| Código Error (HN Core) | Descripción Error (HN Core) | Código HTTP | Descripción Error HTTP |
|------------------------|----------------------------|-------------|----------------------|
| HN-0001 | CEDULA HONDUREÑA INVALIDA | 400 | Bad Request |
| HN-0002 | RTN INVALIDO | 400 | Bad Request |
| HN-0003 | CLIENTE NO EXISTE EN HONDURAS | 404 | Not Found |
| HN-0004 | SERVICIO DATAWAREHOUSE HN NO DISPONIBLE | 503 | Service Unavailable |
| HN-0005 | ERROR CONSULTA ONBASE HN | 500 | Internal Server Error |
| HN-0006 | BLAZE ADVISOR HN NO DISPONIBLE | 503 | Service Unavailable |
| HN-0007 | REGLAS DE CREDITO HN NO APLICABLES | 422 | Unprocessable Entity |
| HN-0008 | LIMITE CREDITO HN EXCEDIDO | 422 | Unprocessable Entity |
| HN-0009 | SCORE INSUFICIENTE HN | 422 | Unprocessable Entity |
| HN-0010 | MONEDA LEMPIRA REQUERIDA | 400 | Bad Request |

### Guatemala (GT01)

| Código Error (GT Core) | Descripción Error (GT Core) | Código HTTP | Descripción Error HTTP |
|------------------------|----------------------------|-------------|----------------------|
| GT-0001 | DPI GUATEMALTECO INVALIDO | 400 | Bad Request |
| GT-0002 | NIT GUATEMALA INVALIDO | 400 | Bad Request |
| GT-0003 | CLIENTE NO EXISTE EN GUATEMALA | 404 | Not Found |
| GT-0004 | SERVICIO DATAWAREHOUSE GT NO DISPONIBLE | 503 | Service Unavailable |
| GT-0005 | ERROR CONSULTA ONBASE GT | 500 | Internal Server Error |
| GT-0006 | BLAZE ADVISOR GT NO DISPONIBLE | 503 | Service Unavailable |
| GT-0007 | REGLAS DE CREDITO GT NO APLICABLES | 422 | Unprocessable Entity |
| GT-0008 | LIMITE CREDITO GT EXCEDIDO | 422 | Unprocessable Entity |
| GT-0009 | SCORE INSUFICIENTE GT | 422 | Unprocessable Entity |
| GT-0010 | MONEDA QUETZAL REQUERIDA | 400 | Bad Request |
| GT-0011 | FACTOR CAMBIO GT INVALIDO | 400 | Bad Request |
| GT-0012 | CONVERSION MONEDA GT ERROR | 500 | Internal Server Error |

## Errores de DataWareHouse

### Errores Comunes DataWareHouse

| Código Error (DataWareHouse) | Descripción Error (DataWareHouse) | Código HTTP | Descripción Error HTTP |
|------------------------------|-----------------------------------|-------------|----------------------|
| DW-0001 | CONNECTION_TIMEOUT | 408 | Request Timeout |
| DW-0002 | SQL_EXECUTION_ERROR | 500 | Internal Server Error |
| DW-0003 | STORED_PROCEDURE_NOT_FOUND | 500 | Internal Server Error |
| DW-0004 | INVALID_PARAMETERS | 400 | Bad Request |
| DW-0005 | NO_DATA_FOUND | 404 | Not Found |
| DW-0006 | MULTIPLE_RECORDS_FOUND | 409 | Conflict |
| DW-0007 | DATABASE_UNAVAILABLE | 503 | Service Unavailable |
| DW-0008 | TRANSACTION_ROLLBACK | 500 | Internal Server Error |
| DW-0009 | PERMISSION_DENIED | 403 | Forbidden |
| DW-0010 | INVALID_SCHEMA | 500 | Internal Server Error |

### Errores Específicos consulta_ONBASE_V2

| Código Error (ONBASE) | Descripción Error (ONBASE) | Código HTTP | Descripción Error HTTP |
|-----------------------|----------------------------|-------------|----------------------|
| ONBASE-0001 | CUSTOMER_NOT_IN_ONBASE | 404 | Not Found |
| ONBASE-0002 | ONBASE_SERVICE_DOWN | 503 | Service Unavailable |
| ONBASE-0003 | INVALID_CUSTOMER_ID | 400 | Bad Request |
| ONBASE-0004 | ONBASE_TIMEOUT | 408 | Request Timeout |
| ONBASE-0005 | ONBASE_DATA_CORRUPTION | 500 | Internal Server Error |
| ONBASE-0006 | ONBASE_AUTHENTICATION_FAILED | 401 | Unauthorized |
| ONBASE-0007 | ONBASE_QUERY_ERROR | 500 | Internal Server Error |
| ONBASE-0008 | ONBASE_RESULT_TOO_LARGE | 413 | Payload Too Large |

## Errores de RulesManagement (BLAZE)

### Errores BLAZE Advisor

| Código Error (BLAZE) | Descripción Error (BLAZE) | Código HTTP | Descripción Error HTTP |
|----------------------|---------------------------|-------------|----------------------|
| BLAZE-0001 | RULES_ENGINE_UNAVAILABLE | 503 | Service Unavailable |
| BLAZE-0002 | INVALID_RULE_PARAMETERS | 400 | Bad Request |
| BLAZE-0003 | RULE_EXECUTION_FAILED | 500 | Internal Server Error |
| BLAZE-0004 | NO_APPLICABLE_RULES | 422 | Unprocessable Entity |
| BLAZE-0005 | RULE_TIMEOUT | 408 | Request Timeout |
| BLAZE-0006 | INVALID_CUSTOMER_PROFILE | 400 | Bad Request |
| BLAZE-0007 | CREDIT_RULES_NOT_LOADED | 500 | Internal Server Error |
| BLAZE-0008 | RULE_VERSION_MISMATCH | 409 | Conflict |
| BLAZE-0009 | INSUFFICIENT_DATA_FOR_RULES | 400 | Bad Request |
| BLAZE-0010 | RULE_RESULT_INVALID | 500 | Internal Server Error |

## Errores de Sistema OSB

### Errores OSB Framework

| Código Error (OSB) | Descripción Error (OSB) | Código HTTP | Descripción Error HTTP |
|--------------------|-------------------------|-------------|----------------------|
| OSB-0001 | PROXY_SERVICE_UNAVAILABLE | 503 | Service Unavailable |
| OSB-0002 | PIPELINE_EXECUTION_ERROR | 500 | Internal Server Error |
| OSB-0003 | TRANSFORMATION_FAILED | 500 | Internal Server Error |
| OSB-0004 | ROUTING_ERROR | 502 | Bad Gateway |
| OSB-0005 | MESSAGE_FLOW_ERROR | 500 | Internal Server Error |
| OSB-0006 | INVALID_MESSAGE_FORMAT | 400 | Bad Request |
| OSB-0007 | SECURITY_POLICY_VIOLATION | 403 | Forbidden |
| OSB-0008 | TRANSPORT_ERROR | 502 | Bad Gateway |
| OSB-0009 | ENDPOINT_NOT_FOUND | 404 | Not Found |
| OSB-0010 | MESSAGE_SIZE_EXCEEDED | 413 | Payload Too Large |

## Mapeo de Errores en Transformaciones XQuery

### Función de Mapeo Principal
```xquery
declare function local:mapErrorToHTTP($errorCode as xs:string) as xs:integer {
  switch($errorCode)
    case "MW-0001" case "MW-0002" case "MW-0003" case "MW-0013" case "MW-0017" case "MW-0019" case "MW-0020" return 400
    case "MW-0006" return 401
    case "MW-0007" return 403
    case "MW-0008" case "MW-0014" return 404
    case "MW-0005" return 408
    case "MW-0015" case "MW-0016" return 422
    case "MW-0009" case "MW-0010" case "MW-0011" return 500
    case "MW-0018" return 501
    case "MW-0012" return 502
    case "MW-0004" return 503
    default return 500
};
```

### Transformación de Mensajes de Error
```xquery
declare function local:transformErrorMessage($errorCode as xs:string, $region as xs:string) as xs:string {
  let $baseMessage := 
    switch($errorCode)
      case "MW-0003" return "Región no válida o no activa"
      case "MW-0004" return "Servicio no disponible temporalmente"
      case "MW-0014" return "Cliente no encontrado"
      default return "Error interno del sistema"
  
  return concat($baseMessage, " (", $region, ")")
};
```

## Configuración de Error Handling

### Pipeline Error Handler
- **Handler ID**: error-N3f5776ff.N1b0c9075.0.18061bcda9a.N7d02
- **Stages**:
  1. GetErrors - Captura código y descripción del error
  2. TxErrorMessage - Transforma error usando GetErrorMessages_BS
  3. LogErrorRequest - Registra error en SetLogInfoService_BS
  4. Response - Envía respuesta final con código HTTP mapeado

### Logging de Errores
- **Service**: SetLogInfoService_BS
- **Parámetros**:
  - codigoAplicacion: 1
  - codigoServicio: Variable según operación
  - codigoError: Código del error capturado
  - estado: 'Error'
  - bancoOrigen: SourceBank
  - bancoDestino: DestinationBank
  - uuid: Identificador único de transacción

## Consideraciones para Migración

### Validaciones Requeridas
1. **Verificar mapeo de códigos HTTP** en el sistema destino
2. **Configurar GetErrorMessages_BS** con todos los códigos de error
3. **Validar SetLogInfoService_BS** para logging de errores
4. **Probar error handling** para cada región
5. **Verificar transformaciones XQuery** de error

### Códigos Críticos para Testing
- **MW-0003**: Validación regional (más común)
- **MW-0004**: Servicio no disponible
- **MW-0014**: Cliente no encontrado
- **DW-0007**: Base de datos no disponible
- **BLAZE-0001**: Motor de reglas no disponible

### Monitoreo de Errores
- **Alertas críticas**: MW-0004, DW-0007, BLAZE-0001
- **Métricas de error**: Porcentaje de errores por región
- **Dashboard**: Errores por código y región en tiempo real