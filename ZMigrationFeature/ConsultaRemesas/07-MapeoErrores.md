# Mapeo de Errores - ConsultaRemesas

## Códigos de Error del Core y Homologación HTTP

### Errores de Validación

| Código Error (Core) | Descripción Error (Core) | Código HTTP | Descripción Error |
|-------------------|------------------------|-------------|------------------|
| `BEA-382505` | REQUIRED FIELDS NOT SUPPLIED | 400 | Bad Request - Campos requeridos faltantes |
| `OSB-000005` | UNRECOGNIZED REMITTANCE STRUCTURE | 400 | Bad Request - Estructura de remesa no reconocida |
| `FICBCO0148-001` | Validación XSD fallida | 400 | Bad Request - Formato de mensaje inválido |
| `FICBCO0148-002` | Tipo de consulta inválido | 400 | Bad Request - Parámetros de consulta inválidos |

### Errores de Autorización y Permisos

| Código Error (Core) | Descripción Error (Core) | Código HTTP | Descripción Error |
|-------------------|------------------------|-------------|------------------|
| `FICBCO0148-003` | Usuario no tiene permisos para consultar este tipo de remesa | 403 | Forbidden - Sin permisos para el tipo de remesa |
| `FICBCO0148-004` | Código de remesa no válido | 403 | Forbidden - Código de remesa no autorizado |
| `FICBCO0148-005` | Cliente en lista restrictiva | 403 | Forbidden - Cliente restringido |
| `FICBCO0148-006` | Región no válida para el servicio | 403 | Forbidden - Servicio no disponible en la región |

### Errores de Datos No Encontrados

| Código Error (Core) | Descripción Error (Core) | Código HTTP | Descripción Error |
|-------------------|------------------------|-------------|------------------|
| `FICBCO0148-100` | Remesa no encontrada | 404 | Not Found - Remesa no existe |
| `FICBCO0148-101` | Tipo de remesadora no encontrado | 404 | Not Found - Tipo de remesadora no configurado |
| `FICBCO0148-102` | La remesa no pudo ser consultada | 404 | Not Found - Remesa no disponible |
| `FICBCO0148-103` | Sin respuestas válidas de remesadoras online | 404 | Not Found - No hay datos disponibles |

### Errores de Estado de Remesa

| Código Error (Core) | Descripción Error (Core) | Código HTTP | Descripción Error |
|-------------------|------------------------|-------------|------------------|
| `FICBCO0148-200` | Remesa ya pagada | 409 | Conflict - Remesa en estado no consultable |
| `FICBCO0148-201` | Remesa cancelada | 409 | Conflict - Remesa cancelada |
| `FICBCO0148-202` | Remesa vencida | 409 | Conflict - Remesa expirada |
| `FICBCO0148-203` | Remesa en proceso | 409 | Conflict - Remesa no disponible temporalmente |

### Errores de Sistemas Backend

| Código Error (Core) | Descripción Error (Core) | Código HTTP | Descripción Error |
|-------------------|------------------------|-------------|------------------|
| `FICBCO0148-500` | Error en consulta T24 | 502 | Bad Gateway - Error en sistema core |
| `FICBCO0148-501` | Error en consulta FLink | 502 | Bad Gateway - Error en base de datos auxiliar |
| `FICBCO0148-502` | Error en consulta SJS | 502 | Bad Gateway - Error en servicio de remesadoras |
| `FICBCO0148-503` | Error en validación regional | 502 | Bad Gateway - Error en servicio de validación |
| `FICBCO0148-504` | Error en evaluación de listas | 502 | Bad Gateway - Error en servicio de listas |

### Errores de Timeout y Conectividad

| Código Error (Core) | Descripción Error (Core) | Código HTTP | Descripción Error |
|-------------------|------------------------|-------------|------------------|
| `FICBCO0148-600` | Timeout en consulta T24 | 504 | Gateway Timeout - Sistema core no responde |
| `FICBCO0148-601` | Timeout en consulta remesadoras online | 504 | Gateway Timeout - Remesadoras no responden |
| `FICBCO0148-602` | Error de conectividad con base de datos | 503 | Service Unavailable - Base de datos no disponible |
| `FICBCO0148-603` | Servicio temporalmente no disponible | 503 | Service Unavailable - Servicio en mantenimiento |

### Errores de Configuración

| Código Error (Core) | Descripción Error (Core) | Código HTTP | Descripción Error |
|-------------------|------------------------|-------------|------------------|
| `FICBCO0148-700` | Configuración de remesadora no encontrada | 500 | Internal Server Error - Error de configuración |
| `FICBCO0148-701` | Parámetros de usuario no configurados | 500 | Internal Server Error - Configuración de usuario faltante |
| `FICBCO0148-702` | Error en transformación de datos | 500 | Internal Server Error - Error de procesamiento |
| `FICBCO0148-703` | Error en mapeo de campos | 500 | Internal Server Error - Error de transformación |

## Errores Específicos por Tipo de Remesadora

### REMESALOCAL (T24 y FLink)

| Código Error (Core) | Descripción Error (Core) | Código HTTP | Descripción Error |
|-------------------|------------------------|-------------|------------------|
| `T24-001` | Error de conexión T24 | 502 | Bad Gateway - T24 no disponible |
| `T24-002` | Remesa no encontrada en T24 | 404 | Not Found - Remesa no existe en core |
| `T24-003` | Error en stored procedure T24 | 500 | Internal Server Error - Error en T24 |
| `FLINK-001` | Error de conexión FLink | 502 | Bad Gateway - FLink no disponible |
| `FLINK-002` | Remesa no encontrada en FLink | 404 | Not Found - Remesa no existe en tablas |
| `FLINK-003` | Error en stored procedure FLink | 500 | Internal Server Error - Error en FLink |

### FICOREMESA

| Código Error (Core) | Descripción Error (Core) | Código HTTP | Descripción Error |
|-------------------|------------------------|-------------|------------------|
| `FREM-001` | Error en consulta Ficohsa Remesas | 502 | Bad Gateway - Ficohsa Remesas no disponible |
| `FREM-002` | Remesa Ficohsa no encontrada | 404 | Not Found - Remesa no existe en Ficohsa |
| `FREM-003` | Estado de remesa Ficohsa inválido | 409 | Conflict - Remesa no disponible |

### ONLINE (SJS - Múltiples Remesadoras)

| Código Error (Core) | Descripción Error (Core) | Código HTTP | Descripción Error |
|-------------------|------------------------|-------------|------------------|
| `SJS-001` | Error en servicio SJS | 502 | Bad Gateway - SJS no disponible |
| `SJS-002` | Sin remesadoras configuradas | 500 | Internal Server Error - Configuración faltante |
| `SJS-003` | Todas las remesadoras fallaron | 502 | Bad Gateway - Remesadoras no disponibles |
| `MGM-001` | Error Moneygram | 502 | Bad Gateway - Moneygram no disponible |
| `WU-001` | Error Western Union | 502 | Bad Gateway - Western Union no disponible |
| `UNI-001` | Error Uniteller | 502 | Bad Gateway - Uniteller no disponible |

## Códigos de Error de Remesadoras Online

### Moneygram

| Código Error (Remesadora) | Descripción Error (Remesadora) | Código HTTP | Descripción Error |
|---------------------------|-------------------------------|-------------|------------------|
| `0` | Consulta exitosa | 200 | OK - Remesa encontrada |
| `1` | Remesa no encontrada | 404 | Not Found - Remesa no existe |
| `2` | Remesa ya pagada | 409 | Conflict - Remesa ya procesada |
| `3` | Remesa cancelada | 409 | Conflict - Remesa cancelada |
| `4` | Error de sistema | 502 | Bad Gateway - Error interno Moneygram |
| `-1` | Error de conectividad | 504 | Gateway Timeout - Moneygram no responde |

### Western Union

| Código Error (Remesadora) | Descripción Error (Remesadora) | Código HTTP | Descripción Error |
|---------------------------|-------------------------------|-------------|------------------|
| `0` | Consulta exitosa | 200 | OK - Remesa encontrada |
| `100` | Remesa no encontrada | 404 | Not Found - Remesa no existe |
| `200` | Remesa ya pagada | 409 | Conflict - Remesa ya procesada |
| `300` | Remesa expirada | 409 | Conflict - Remesa vencida |
| `500` | Error de sistema | 502 | Bad Gateway - Error interno Western Union |
| `-1` | Error de conectividad | 504 | Gateway Timeout - Western Union no responde |

### Uniteller

| Código Error (Remesadora) | Descripción Error (Remesadora) | Código HTTP | Descripción Error |
|---------------------------|-------------------------------|-------------|------------------|
| `SUCCESS` | Consulta exitosa | 200 | OK - Remesa encontrada |
| `NOT_FOUND` | Remesa no encontrada | 404 | Not Found - Remesa no existe |
| `ALREADY_PAID` | Remesa ya pagada | 409 | Conflict - Remesa ya procesada |
| `CANCELLED` | Remesa cancelada | 409 | Conflict - Remesa cancelada |
| `SYSTEM_ERROR` | Error de sistema | 502 | Bad Gateway - Error interno Uniteller |
| `TIMEOUT` | Error de conectividad | 504 | Gateway Timeout - Uniteller no responde |

## Mapeo de Errores de Validación Regional

| Código Error (ValidaServicioRegional) | Descripción Error | Código HTTP | Descripción Error |
|---------------------------------------|------------------|-------------|------------------|
| `SUCCESS` | Validación exitosa | 200 | OK - Región válida |
| `INVALID_REGION` | Región no válida | 403 | Forbidden - Región no autorizada |
| `SERVICE_NOT_AVAILABLE` | Servicio no disponible en región | 503 | Service Unavailable - Servicio no habilitado |
| `CONFIGURATION_ERROR` | Error de configuración regional | 500 | Internal Server Error - Configuración faltante |

## Mapeo de Errores de Evaluación de Listas

| Código Error (EvaluaListasCliente) | Descripción Error | Código HTTP | Descripción Error |
|------------------------------------|------------------|-------------|------------------|
| `SUCCESS` | Cliente válido | 200 | OK - Cliente autorizado |
| `CLIENT_RESTRICTED` | Cliente en lista restrictiva | 403 | Forbidden - Cliente restringido |
| `OFAC_MATCH` | Cliente en lista OFAC | 403 | Forbidden - Cliente en lista OFAC |
| `PEP_MATCH` | Cliente es PEP | 403 | Forbidden - Persona políticamente expuesta |
| `VALIDATION_ERROR` | Error en validación | 500 | Internal Server Error - Error de validación |

## Estructura de Response de Error

### Formato de Error Estándar
```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType"
                  xmlns:cons="http://www.ficohsa.com.hn/middleware.services/consultaRemesasTypes">
   <soapenv:Header>
      <aut:ResponseHeader>
         <successIndicator>ERROR</successIndicator>
         <messages>Descripción del error específico</messages>
      </aut:ResponseHeader>
   </soapenv:Header>
   <soapenv:Body>
      <cons:consultaRemesasResponse/>
   </soapenv:Body>
</soapenv:Envelope>
```

### SOAP Fault para Errores Críticos
```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
   <soapenv:Body>
      <soapenv:Fault>
         <faultcode>FICBCO0148</faultcode>
         <faultstring>Error en ConsultaRemesas</faultstring>
         <detail>
            <errorCode>FICBCO0148-XXX</errorCode>
            <errorMessage>Descripción detallada del error</errorMessage>
         </detail>
      </soapenv:Fault>
   </soapenv:Body>
</soapenv:Envelope>
```

## Configuración de Mapeo de Errores

### Archivo de Configuración
- **Servicio**: `MapeoErrores.proxy`
- **Transformación Entrada**: `mapeoErroresUsageIn.xq`
- **Transformación Salida**: `mapeoErroresUsageOut.xq`
- **Patrón de Código**: `FICBCO0148$#$[MENSAJE_ERROR]`

### Parámetros de Mapeo
- **CODIGO_ERROR**: Código interno del error
- **MENSAJE_ERROR**: Mensaje descriptivo del error
- **SUCCESS_INDICATOR**: Indicador de éxito/error

## Recomendaciones para Manejo de Errores

### 1. Logging y Auditoría
- Registrar todos los errores con timestamp y contexto
- Incluir información de usuario y región
- Mantener trazabilidad de errores por tipo de remesadora

### 2. Retry y Resilience
- Implementar retry para errores de conectividad (5xx)
- Circuit breaker para servicios externos
- Fallback a fuentes alternativas cuando sea posible

### 3. Monitoreo y Alertas
- Alertas automáticas para errores críticos (5xx)
- Dashboard de errores por tipo y frecuencia
- SLA de tiempo de respuesta por tipo de error

### 4. Documentación para Usuarios
- Códigos de error claros y descriptivos
- Acciones recomendadas para cada tipo de error
- Información de contacto para soporte técnico