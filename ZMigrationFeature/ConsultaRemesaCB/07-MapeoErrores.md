# Mapeo de Errores - ConsultaRemesaCB

## Códigos de Error del Core y Homologación HTTP

### Errores de Validación de Entrada

| Código Error (ConsultaRemesaCB) | Descripción Error (ConsultaRemesaCB) | Código HTTP | Descripción Error HTTP |
|--------------------------------|-------------------------------------|-------------|----------------------|
| BEA-382505 | REQUIRED FIELDS NOT SUPPLIED | 400 | Bad Request - Campos requeridos no proporcionados |
| OSB-000005 | UNRECOGNIZED REMITTANCE STRUCTURE | 400 | Bad Request - Estructura de remesa no reconocida |
| VALIDATION_ERROR | Error de validación de esquema XML | 400 | Bad Request - Datos de entrada inválidos |

### Errores de Autenticación y Autorización

| Código Error (ConsultaRemesaCB) | Descripción Error (ConsultaRemesaCB) | Código HTTP | Descripción Error HTTP |
|--------------------------------|-------------------------------------|-------------|----------------------|
| AUTH_FAILED | Credenciales de autenticación inválidas | 401 | Unauthorized - Credenciales inválidas |
| CORRESPONSAL_NOT_AUTHORIZED | Corresponsal no autorizado para este tipo de transacción | 403 | Forbidden - Corresponsal no autorizado |
| USER_NO_PERMISSIONS | El usuario no tiene permisos para consultar este tipos de claves de remesa | 403 | Forbidden - Usuario sin permisos |
| CRYPTO_DECRYPT_FAILED | Error al descifrar credenciales | 401 | Unauthorized - Error de descifrado |

### Errores de Validación Regional

| Código Error (ConsultaRemesaCB) | Descripción Error (ConsultaRemesaCB) | Código HTTP | Descripción Error HTTP |
|--------------------------------|-------------------------------------|-------------|----------------------|
| REGION_NOT_VALID | Región no válida para el servicio | 400 | Bad Request - Región no soportada |
| SERVICE_NOT_ENABLED | Servicio FICBCO0148 no habilitado para la región | 503 | Service Unavailable - Servicio no disponible |

### Errores de Tipo de Remesadora

| Código Error (ConsultaRemesaCB) | Descripción Error (ConsultaRemesaCB) | Código HTTP | Descripción Error HTTP |
|--------------------------------|-------------------------------------|-------------|----------------------|
| REMITTANCE_TYPE_ERROR | Error obteniendo tipo de remesadora | 500 | Internal Server Error - Error interno |
| INVALID_REMITTANCE_CODE | Codigo de remesa no valido | 400 | Bad Request - Código de remesa inválido |
| REMITTANCE_TYPE_NA | Remesadora no disponible (NA) | 404 | Not Found - Remesadora no encontrada |

### Errores de Consulta de Remesas Locales

| Código Error (ConsultaRemesaCB) | Descripción Error (ConsultaRemesaCB) | Código HTTP | Descripción Error HTTP |
|--------------------------------|-------------------------------------|-------------|----------------------|
| LOCAL_REMITTANCE_ERROR | Error consultando remesa local | 500 | Internal Server Error - Error en consulta local |
| LOCAL_REMITTANCE_NOT_FOUND | Remesa local no encontrada | 404 | Not Found - Remesa no encontrada |
| T24_CONNECTION_ERROR | Error de conexión con T24 | 503 | Service Unavailable - Sistema T24 no disponible |

### Errores de Consulta Ficohsa Remesas

| Código Error (ConsultaRemesaCB) | Descripción Error (ConsultaRemesaCB) | Código HTTP | Descripción Error HTTP |
|--------------------------------|-------------------------------------|-------------|----------------------|
| FICOHSA_REMITTANCE_ERROR | Error consultando Ficohsa Remesas | 500 | Internal Server Error - Error en Ficohsa Remesas |
| FICOHSA_REMITTANCE_NOT_FOUND | Remesa Ficohsa no encontrada | 404 | Not Found - Remesa Ficohsa no encontrada |
| PAYER_ID_MISSING | ID de pagador no configurado para el usuario | 400 | Bad Request - Configuración de usuario incompleta |

### Errores de Enrutador de Convenios (ONLINE)

| Código Error (ConsultaRemesaCB) | Descripción Error (ConsultaRemesaCB) | Código HTTP | Descripción Error HTTP |
|--------------------------------|-------------------------------------|-------------|----------------------|
| -1 | La remesa no pudo ser consultada | 404 | Not Found - Remesa no encontrada en remesadoras |
| 1 | Error en consulta de remesadora | 500 | Internal Server Error - Error en remesadora externa |
| 3 | Remesa no disponible | 404 | Not Found - Remesa no disponible |
| 4 | Error de comunicación con remesadora | 503 | Service Unavailable - Remesadora no disponible |
| 5 | Timeout en consulta de remesadora | 504 | Gateway Timeout - Timeout en remesadora |
| ROUTER_CONNECTION_ERROR | Error de conexión con enrutador | 503 | Service Unavailable - Enrutador no disponible |
| MULTIPLE_REMITTERS_NO_SUCCESS | Ninguna remesadora retornó resultado exitoso | 404 | Not Found - Remesa no encontrada |

### Errores de Evaluación de Listas

| Código Error (ConsultaRemesaCB) | Descripción Error (ConsultaRemesaCB) | Código HTTP | Descripción Error HTTP |
|--------------------------------|-------------------------------------|-------------|----------------------|
| RESTRICTED_LIST_ERROR | Cliente en lista restrictiva | 403 | Forbidden - Cliente restringido |
| LIST_EVALUATION_ERROR | Error evaluando listas de clientes | 500 | Internal Server Error - Error en evaluación |

### Errores Específicos por Tipo de Remesa Local

| Código Error (ConsultaRemesaCB) | Descripción Error (ConsultaRemesaCB) | Código HTTP | Descripción Error HTTP |
|--------------------------------|-------------------------------------|-------------|----------------------|
| DOLEX_ERROR | Error consultando remesas Dolex | 500 | Internal Server Error - Error en Dolex |
| RIA_ERROR | Error consultando remesas RIA | 500 | Internal Server Error - Error en RIA |
| FICOEXP_ERROR | Error consultando Ficohsa Express | 500 | Internal Server Error - Error en Ficohsa Express |
| GROUPEX_ERROR | Error consultando Group Express | 500 | Internal Server Error - Error en Group Express |
| REMTRAS_ERROR | Error consultando Remesas y Transferencias | 500 | Internal Server Error - Error en Remesas y Transferencias |
| TRANSFAST_ERROR | Error consultando TransFast | 500 | Internal Server Error - Error en TransFast |
| SIGUE_ERROR | Error consultando Sigue | 500 | Internal Server Error - Error en Sigue |
| GIROSOL_ERROR | Error consultando Girosol | 500 | Internal Server Error - Error en Girosol |
| UNIDENTIFIED_REMITTANCE | Tipo de remesa no identificado | 400 | Bad Request - Tipo de remesa no reconocido |

### Errores de Base de Datos

| Código Error (ConsultaRemesaCB) | Descripción Error (ConsultaRemesaCB) | Código HTTP | Descripción Error HTTP |
|--------------------------------|-------------------------------------|-------------|----------------------|
| DB_CONNECTION_ERROR | Error de conexión a base de datos | 503 | Service Unavailable - Base de datos no disponible |
| DB_TIMEOUT_ERROR | Timeout en consulta de base de datos | 504 | Gateway Timeout - Timeout en base de datos |
| SP_EXECUTION_ERROR | Error ejecutando stored procedure | 500 | Internal Server Error - Error en procedimiento |
| LIMIT_REGISTRATION_ERROR | Error registrando límite transaccional | 500 | Internal Server Error - Error en registro de límite |

### Errores Específicos del SP OSB_P_REGISTRAR_REMESA

| Código Error (OSB_P_REGISTRAR_REMESA) | Descripción Error (OSB_P_REGISTRAR_REMESA) | Código HTTP | Descripción Error HTTP |
|---------------------------------------|-------------------------------------------|-------------|----------------------|
| INVALID_CLIENT_ID | ID de cliente inválido o nulo | 400 | Bad Request - ID de cliente requerido |
| INVALID_AMOUNT_FORMAT | Formato de monto flotante inválido | 400 | Bad Request - Formato de monto inválido |
| INVALID_EXCHANGE_RATE | Tasa de cambio inválida o fuera de rango | 400 | Bad Request - Tasa de cambio inválida |
| NEGATIVE_AMOUNT | Monto flotante no puede ser negativo | 400 | Bad Request - Monto debe ser positivo |
| ZERO_EXCHANGE_RATE | Tasa de cambio no puede ser cero | 400 | Bad Request - Tasa de cambio inválida |
| CLIENT_UPDATE_FAILED | Error actualizando datos del cliente existente | 500 | Internal Server Error - Error en actualización |
| CLIENT_INSERT_FAILED | Error insertando nuevo cliente | 500 | Internal Server Error - Error en inserción |
| TABLE_LOCK_ERROR | Error de bloqueo en tabla MW_MONTOS_CLIENTES_REMESAS | 503 | Service Unavailable - Recurso bloqueado |
| CONSTRAINT_VIOLATION | Violación de restricción de integridad | 400 | Bad Request - Datos violan restricciones |
| INSUFFICIENT_PRIVILEGES | Privilegios insuficientes para operación | 403 | Forbidden - Sin permisos para operación |
| TABLESPACE_FULL | Espacio de tabla insuficiente | 507 | Insufficient Storage - Espacio insuficiente |
| DEADLOCK_DETECTED | Deadlock detectado en transacción | 409 | Conflict - Conflicto de concurrencia |
| COMMIT_FAILED | Error al confirmar transacción | 500 | Internal Server Error - Error en commit |
| ROLLBACK_FAILED | Error al revertir transacción | 500 | Internal Server Error - Error en rollback |
| ORA-00001 | Violación de restricción única | 409 | Conflict - Registro duplicado |
| ORA-00054 | Recurso ocupado y adquirido con NOWAIT | 503 | Service Unavailable - Recurso ocupado |
| ORA-00060 | Deadlock detectado mientras se esperaba un recurso | 409 | Conflict - Deadlock detectado |
| ORA-00942 | Tabla o vista no existe | 500 | Internal Server Error - Objeto de BD no existe |
| ORA-01400 | No se puede insertar NULL | 400 | Bad Request - Campo requerido es nulo |
| ORA-01722 | Número inválido | 400 | Bad Request - Formato numérico inválido |
| ORA-12899 | Valor demasiado grande para columna | 400 | Bad Request - Valor excede longitud máxima |
| ORA-02291 | Restricción de integridad violada - clave padre no encontrada | 400 | Bad Request - Referencia inválida |
| ORA-02292 | Restricción de integridad violada - registro hijo encontrado | 409 | Conflict - No se puede eliminar registro referenciado |

### Errores de Configuración

| Código Error (ConsultaRemesaCB) | Descripción Error (ConsultaRemesaCB) | Código HTTP | Descripción Error HTTP |
|--------------------------------|-------------------------------------|-------------|----------------------|
| PARAMETER_NOT_FOUND | Parámetro de configuración no encontrado | 500 | Internal Server Error - Configuración incompleta |
| REMIT_SOURCE_NOT_CONFIGURED | REMITSOURCE no configurado para tipo de remesa | 500 | Internal Server Error - Configuración faltante |
| USER_CONFIG_MISSING | Configuración de usuario incompleta | 400 | Bad Request - Usuario no configurado |

## Códigos de Éxito

| Código Éxito (ConsultaRemesaCB) | Descripción Éxito (ConsultaRemesaCB) | Código HTTP | Descripción HTTP |
|--------------------------------|-------------------------------------|-------------|------------------|
| SUCCESS | Consulta exitosa | 200 | OK - Consulta procesada correctamente |
| 0 | Remesa disponible (ONLINE) | 200 | OK - Remesa disponible para pago |
| 2 | Remesa pagada (ONLINE) | 200 | OK - Remesa ya fue pagada |

## Mapeo de Estados de Remesa

| Estado Interno | Estado Expuesto | Descripción |
|---------------|----------------|-------------|
| DISPONIBLE | DISPONIBLE | Remesa disponible para pago |
| PAGADA | PAGADA | Remesa ya fue pagada |
| ERROR | ERROR | Error en consulta de remesa |
| NA | ERROR | Remesadora no disponible |

## Códigos de Error por Servicio Dependiente

### MW_P_OBTENER_TIPO_REMESADORA

| Código SP | Descripción SP | Mapeo ConsultaRemesaCB |
|-----------|---------------|----------------------|
| SUCCESS | Tipo de remesadora obtenido correctamente | Continúa procesamiento |
| ERROR | Error obteniendo tipo de remesadora | REMITTANCE_TYPE_ERROR |
| NO_DATA_FOUND | No se encontró información para la clave | INVALID_REMITTANCE_CODE |

### MW_P_VALIDAR_CORRESPONSAL

| Código SP | Descripción SP | Mapeo ConsultaRemesaCB |
|-----------|---------------|----------------------|
| SUCCESS | Corresponsal autorizado | Continúa procesamiento |
| ERROR | Corresponsal no autorizado | CORRESPONSAL_NOT_AUTHORIZED |
| INVALID_TRANSACTION_TYPE | Tipo de transacción inválido | CORRESPONSAL_NOT_AUTHORIZED |

### OSB_P_REGISTRAR_REMESA

| Código SP | Descripción SP | Mapeo ConsultaRemesaCB |
|-----------|---------------|----------------------|
| SUCCESS | Remesa registrada correctamente | SUCCESS |
| ERROR | Error general en registro de remesa | CLIENT_REGISTRATION_ERROR |
| INVALID_CLIENT_ID | ID de cliente inválido | INVALID_CLIENT_ID |
| INVALID_AMOUNT_FORMAT | Formato de monto inválido | INVALID_AMOUNT_FORMAT |
| INVALID_EXCHANGE_RATE | Tasa de cambio inválida | INVALID_EXCHANGE_RATE |
| CLIENT_UPDATE_FAILED | Error actualizando cliente | CLIENT_UPDATE_FAILED |
| CLIENT_INSERT_FAILED | Error insertando cliente | CLIENT_INSERT_FAILED |
| TABLE_LOCK_ERROR | Error de bloqueo de tabla | TABLE_LOCK_ERROR |
| CONSTRAINT_VIOLATION | Violación de restricción | CONSTRAINT_VIOLATION |
| COMMIT_FAILED | Error en commit de transacción | COMMIT_FAILED |

### CV_K_DATOS_REMESAS$CONSU_X_ID (Remesas Locales)

| Estado SP | Descripción SP | Mapeo ConsultaRemesaCB |
|-----------|---------------|----------------------|
| DISPONIBLE | Remesa disponible | SUCCESS con estado DISPONIBLE |
| PAGADA | Remesa pagada | SUCCESS con estado PAGADA |
| ERROR | Error en consulta | LOCAL_REMITTANCE_ERROR |
| NOT_FOUND | Remesa no encontrada | LOCAL_REMITTANCE_NOT_FOUND |

### CV_K_DATOS_REMESAS_POR_PAGADOR (Ficohsa Remesas)

| Estado SP | Descripción SP | Mapeo ConsultaRemesaCB |
|-----------|---------------|----------------------|
| DISPONIBLE | Remesa disponible | SUCCESS con estado DISPONIBLE |
| PAGADA | Remesa pagada | SUCCESS con estado PAGADA |
| ERROR | Error en consulta | FICOHSA_REMITTANCE_ERROR |
| NOT_FOUND | Remesa no encontrada | FICOHSA_REMITTANCE_NOT_FOUND |

### Enrutador de Convenios (HTTP)

| errorCode | Descripción | Mapeo ConsultaRemesaCB |
|-----------|-------------|----------------------|
| 0 | Remesa disponible | SUCCESS con estado DISPONIBLE |
| 2 | Remesa pagada | SUCCESS con estado PAGADA |
| -1 | Remesa no encontrada | MULTIPLE_REMITTERS_NO_SUCCESS |
| 1 | Error general | Error con mensaje del enrutador |
| 3 | Remesa no disponible | Error con mensaje del enrutador |
| 4 | Error de comunicación | ROUTER_CONNECTION_ERROR |
| 5 | Timeout | Gateway Timeout |

## Manejo de Errores por Pipeline

### Pipeline: Validaciones Generales (ConsultaRemesaCB)

1. **Validación de Esquema**: Retorna SOAP Fault si el XML no es válido
2. **Validación de Corresponsal**: Retorna error específico del SP
3. **Descifrado de Credenciales**: Retorna error de criptografía si falla

### Pipeline: Error Handler (ConsultaRemesaCB)

```xml
<aut:ResponseHeader>
    <successIndicator>ERROR</successIndicator>
    <messages>{concat($fault/ctx:errorCode, ": ", $fault/ctx:reason)}</messages>
</aut:ResponseHeader>
```

### Pipeline: Manejo de Errores (ConsultaRemesas)

1. **Captura de Errores Generales**: Usa MapeoErrores con código FICBCO0148
2. **Mapeo a HTTP**: Convierte errores internos a códigos HTTP estándar
3. **Logging**: Registra errores para auditoría

### Pipeline: Manejo de Errores OSB_P_REGISTRAR_REMESA

```xml
<!-- Validación de parámetros de entrada -->
<con:if>
    <con:condition>$PV_ID_CLIENTE = '' or fn:not($PV_ID_CLIENTE)</con:condition>
    <con:actions>
        <con:assign varName="errorCode">INVALID_CLIENT_ID</con:assign>
        <con:assign varName="errorMessage">ID de cliente es requerido</con:assign>
        <con:reply>ERROR</con:reply>
    </con:actions>
</con:if>

<!-- Validación de formato numérico -->
<con:if>
    <con:condition>fn:not(fn:matches($PV_MONTO_FLOTANTE, '^[0-9]+(\.[0-9]+)?$'))</con:condition>
    <con:actions>
        <con:assign varName="errorCode">INVALID_AMOUNT_FORMAT</con:assign>
        <con:assign varName="errorMessage">Formato de monto flotante inválido</con:assign>
        <con:reply>ERROR</con:reply>
    </con:actions>
</con:if>

<!-- Manejo de errores Oracle específicos -->
<con:catch>
    <con:if>
        <con:condition>fn:contains($fault/ctx:reason, 'ORA-00001')</con:condition>
        <con:actions>
            <con:assign varName="httpCode">409</con:assign>
            <con:assign varName="errorCode">CONSTRAINT_VIOLATION</con:assign>
        </con:actions>
    </con:if>
    <con:if>
        <con:condition>fn:contains($fault/ctx:reason, 'ORA-01722')</con:condition>
        <con:actions>
            <con:assign varName="httpCode">400</con:assign>
            <con:assign varName="errorCode">INVALID_AMOUNT_FORMAT</con:assign>
        </con:actions>
    </con:if>
</con:catch>
```

## Recomendaciones para Migración

### Códigos de Error Estándar HTTP

1. **400 Bad Request**: Para errores de validación de entrada
2. **401 Unauthorized**: Para errores de autenticación
3. **403 Forbidden**: Para errores de autorización
4. **404 Not Found**: Para remesas no encontradas
5. **500 Internal Server Error**: Para errores internos del sistema
6. **503 Service Unavailable**: Para servicios no disponibles
7. **504 Gateway Timeout**: Para timeouts en servicios externos

### Estructura de Error Recomendada

```json
{
  "error": {
    "code": "REMITTANCE_NOT_FOUND",
    "message": "La remesa solicitada no fue encontrada",
    "details": {
      "remittanceId": "REM123456789",
      "searchedIn": ["MONEYGRAM", "UNITELLER", "BTS"],
      "timestamp": "2024-12-01T12:00:00Z"
    }
  }
}
```

### Estructura de Error para OSB_P_REGISTRAR_REMESA

```json
{
  "error": {
    "code": "CLIENT_REGISTRATION_ERROR",
    "message": "Error registrando datos de remesa para el cliente",
    "details": {
      "clientId": "CLI123456789",
      "operation": "UPDATE|INSERT",
      "floatingAmount": "1500.00",
      "exchangeRate": "24.50",
      "oracleError": "ORA-01722: invalid number",
      "timestamp": "2024-12-01T12:00:00Z"
    }
  }
}
```

### Estructura de Respuesta Exitosa OSB_P_REGISTRAR_REMESA

```json
{
  "success": {
    "code": "SUCCESS",
    "message": "Remesa registrada correctamente",
    "details": {
      "clientId": "CLI123456789",
      "operation": "UPDATE|INSERT",
      "floatingAmount": "1500.00",
      "exchangeRate": "24.50",
      "status": "PEN",
      "timestamp": "2024-12-01T12:00:00Z"
    }
  }
}
```

### Logging de Errores

1. **Nivel ERROR**: Para errores que impiden el procesamiento
2. **Nivel WARN**: Para situaciones que no impiden el procesamiento pero requieren atención
3. **Nivel INFO**: Para flujo normal con información relevante
4. **Nivel DEBUG**: Para información detallada de troubleshooting

### Monitoreo y Alertas

1. **Errores de Conectividad**: Alertas inmediatas para errores 503/504
2. **Errores de Autorización**: Monitoreo de patrones de errores 401/403
3. **Errores de Negocio**: Tracking de errores 404 para análisis de tendencias
4. **Errores Internos**: Alertas críticas para errores 500