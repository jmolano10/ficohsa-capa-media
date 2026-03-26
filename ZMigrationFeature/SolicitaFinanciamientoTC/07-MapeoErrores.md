# Mapeo de Errores - SolicitaFinanciamientoTC

## Tabla de Mapeo de Errores

| Código Error (Core) | Descripción Error (Core) | Código HTTP | Descripción Error HTTP |
|-------------------|-------------------------|-------------|----------------------|
| **MW-0008** | SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY | 501 | Not Implemented |
| **SUCCESS** | Operación exitosa | 200 | OK |
| **ERROR** | Error general en el procesamiento | 500 | Internal Server Error |
| **INVALID_SESSION_ID** | Sesión de Salesforce inválida o expirada | 401 | Unauthorized |
| **VALIDATION_ERROR** | Error de validación XSD o de datos | 400 | Bad Request |
| **REGION_NOT_VALID** | Región no válida para el servicio | 403 | Forbidden |
| **NO_OFFERS_AVAILABLE** | No hay ofertas disponibles para el cliente | 404 | Not Found |
| **INVALID_CONDITIONS** | Condiciones crediticias no válidas | 422 | Unprocessable Entity |
| **PARAMETER_ERROR** | Error en obtención de parámetros | 500 | Internal Server Error |
| **DATABASE_ERROR** | Error de conexión o consulta a base de datos | 503 | Service Unavailable |
| **SALESFORCE_ERROR** | Error general de Salesforce | 502 | Bad Gateway |
| **TIMEOUT_ERROR** | Timeout en servicios externos | 504 | Gateway Timeout |
| **PENDING** | Solicitud en proceso | 202 | Accepted |
| **APPROVED** | Solicitud aprobada | 200 | OK |
| **REJECTED** | Solicitud rechazada | 422 | Unprocessable Entity |

## Errores Específicos por Componente

### Errores de Validación XSD
| Código Error | Descripción | Origen |
|-------------|-------------|---------|
| **VALIDATION_ERROR** | Campo obligatorio faltante: CUSTOMER_ID | XSD Validation |
| **VALIDATION_ERROR** | Campo obligatorio faltante: TOTAL_AMOUNT | XSD Validation |
| **VALIDATION_ERROR** | Campo obligatorio faltante: CURRENCY | XSD Validation |
| **VALIDATION_ERROR** | Campo obligatorio faltante: NUMBER_OF_PAYMENTS | XSD Validation |
| **VALIDATION_ERROR** | Campo obligatorio faltante: DISBURSEMENT_INFO | XSD Validation |
| **VALIDATION_ERROR** | Campo obligatorio faltante: EMAIL_ADDRESS | XSD Validation |
| **VALIDATION_ERROR** | Formato inválido en EXPIRATION_DATE | XSD Validation |
| **VALIDATION_ERROR** | Valor inválido en CREDIT_LINE (debe ser INTERNAL/EXTERNAL) | XSD Validation |
| **VALIDATION_ERROR** | Valor inválido en DISBURSEMENT_INFO/TYPE | XSD Validation |

### Errores de Validación Regional
| Código Error | Descripción | Origen |
|-------------|-------------|---------|
| **REGION_NOT_VALID** | Servicio FICBCO0269 no disponible para región {REGION} | ValidaServicioRegional |
| **MW-0008** | SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY | Default Pipeline |

### Errores de Parametrización
| Código Error | Descripción | Origen |
|-------------|-------------|---------|
| **PARAMETER_ERROR** | No se encontró parámetro FICBCO0269.DISBURSERATE | ObtenerParametrizacion |
| **PARAMETER_ERROR** | No se encontró parámetro FICBCO0269.PRODUCTQUANTIFY | ObtenerParametrizacion |
| **PARAMETER_ERROR** | No se encontró parámetro FICBCO0269.DISBURSEMENTYPE.{TYPE} | ObtenerParametrizacion (HN01) |
| **PARAMETER_ERROR** | No se encontró parámetro FICBCO0269.DISBURSERATE.GT01 | ObtenerParametrizacion (GT01) |
| **PARAMETER_ERROR** | No se encontró parámetro FICBCO0269.PRODUCTQUANTIFY.GT01 | ObtenerParametrizacion (GT01) |

### Errores de Base de Datos
| Código Error | Descripción | Origen |
|-------------|-------------|---------|
| **DATABASE_ERROR** | Error de conexión a base de datos VASA | consultaOferta_db (HN01) |
| **DATABASE_ERROR** | Error de conexión a base de datos BLAZEGT | consultaOferta_db (GT01) |
| **NO_OFFERS_AVAILABLE** | No hay ofertas disponibles para el cliente | consultaOferta SP |
| **DATABASE_ERROR** | Error ejecutando stored procedure consultaOferta | consultaOferta SP |
| **INVALID_CONDITIONS** | Cliente no tiene línea de crédito disponible | consultaOferta SP |
| **INVALID_CONDITIONS** | Monto solicitado excede límite disponible | consultaOferta SP |

### Errores de Validación de Condiciones
| Código Error | Descripción | Origen |
|-------------|-------------|---------|
| **INVALID_CONDITIONS** | No hay ofertas para el plazo solicitado | validaCondicionesCredito.xq |
| **INVALID_CONDITIONS** | No hay ofertas para la moneda solicitada | validaCondicionesCredito.xq |
| **INVALID_CONDITIONS** | Monto solicitado excede ofertas disponibles | validaCondicionesCredito.xq |
| **INVALID_CONDITIONS** | No se encontró tasa de interés aplicable | Cálculo de tasa |

### Errores de Salesforce
| Código Error | Descripción | Origen |
|-------------|-------------|---------|
| **INVALID_SESSION_ID** | Sesión de Salesforce inválida o expirada | Salesforce Service |
| **SALESFORCE_ERROR** | Error de autenticación en Salesforce | LoginSalesforce |
| **SALESFORCE_ERROR** | Error creando gestión extra en Salesforce | CrearExtra Operation |
| **SALESFORCE_ERROR** | Usuario no tiene permisos en Salesforce | Salesforce Service |
| **SALESFORCE_ERROR** | Servicio Salesforce no disponible | Salesforce Service |
| **TIMEOUT_ERROR** | Timeout conectando a Salesforce | Salesforce Service |

### Errores Específicos de IngresaGestionExtra (Salesforce)
| Código Error (Salesforce) | Descripción Error (Salesforce) | Código HTTP | Descripción Error HTTP |
|--------------------------|--------------------------------|-------------|----------------------|
| **SUCCESS** | Gestión extra creada exitosamente | 200 | OK |
| **INVALID_CLIENT** | Cliente no existe o está inactivo | 404 | Not Found |
| **INVALID_CARD** | Número de tarjeta inválido o no pertenece al cliente | 422 | Unprocessable Entity |
| **INSUFFICIENT_CREDIT_LINE** | Línea de crédito insuficiente para el monto solicitado | 422 | Unprocessable Entity |
| **INVALID_TERM** | Plazo solicitado no está disponible | 422 | Unprocessable Entity |
| **INVALID_CURRENCY** | Moneda no soportada para la región | 422 | Unprocessable Entity |
| **INVALID_AMOUNT** | Monto fuera de los límites permitidos | 422 | Unprocessable Entity |
| **INVALID_DISBURSEMENT_TYPE** | Tipo de desembolso no válido | 422 | Unprocessable Entity |
| **INVALID_ACCOUNT** | Cuenta de crédito no válida o inactiva | 422 | Unprocessable Entity |
| **INVALID_EMAIL** | Formato de email inválido | 400 | Bad Request |
| **DUPLICATE_REQUEST** | Solicitud duplicada para el mismo cliente | 409 | Conflict |
| **CLIENT_BLOCKED** | Cliente bloqueado para nuevos financiamientos | 403 | Forbidden |
| **SYSTEM_ERROR** | Error interno del sistema Salesforce | 500 | Internal Server Error |
| **VALIDATION_ERROR** | Error de validación de reglas de negocio | 422 | Unprocessable Entity |
| **WORKFLOW_ERROR** | Error en el flujo de aprobación | 500 | Internal Server Error |
| **INTEGRATION_ERROR** | Error de integración con sistemas externos | 502 | Bad Gateway |
| **TIMEOUT_ERROR** | Timeout procesando la solicitud | 504 | Gateway Timeout |
| **RATE_LIMIT_EXCEEDED** | Límite de solicitudes excedido | 429 | Too Many Requests |
| **MAINTENANCE_MODE** | Sistema en mantenimiento | 503 | Service Unavailable |
| **INVALID_REGION** | Región no válida para el tipo de producto | 422 | Unprocessable Entity |
| **PRODUCT_NOT_AVAILABLE** | Producto no disponible para el cliente | 422 | Unprocessable Entity |
| **CREDIT_EVALUATION_FAILED** | Evaluación crediticia fallida | 422 | Unprocessable Entity |
| **INVALID_INTEREST_RATE** | Tasa de interés fuera de rango | 422 | Unprocessable Entity |
| **INVALID_COMMISSION** | Comisión de desembolso inválida | 422 | Unprocessable Entity |
| **ADDRESS_REQUIRED** | Dirección requerida para tipo de desembolso | 400 | Bad Request |
| **ACCOUNT_REQUIRED** | Cuenta requerida para tipo de desembolso | 400 | Bad Request |

### Estados de Respuesta Salesforce
| Estado Salesforce | Estado OSB | Descripción |
|------------------|-----------|-------------|
| **EN PROCESO** | PENDING | Solicitud recibida y en proceso |
| **INGRESADA** | PENDING | Solicitud ingresada al sistema |
| **APROBADO** | APPROVED | Solicitud aprobada |
| **RECHAZADO** | REJECTED | Solicitud rechazada |
| **CANCELADO** | REJECTED | Solicitud cancelada |
| **ERROR** | REJECTED | Error procesando solicitud |
| **PENDIENTE_DOCUMENTOS** | PENDING | Pendiente de documentación |
| **EVALUACION_CREDITO** | PENDING | En evaluación crediticia |
| **APROBADO_CONDICIONAL** | PENDING | Aprobado con condiciones |
| **VENCIDO** | REJECTED | Solicitud vencida |
| **RETIRADO** | REJECTED | Cliente retiró la solicitud |

## Mapeo de Errores HTTP por Categoría

### Errores de Cliente (4xx)
- **400 Bad Request**: Errores de validación XSD, datos faltantes o inválidos
- **401 Unauthorized**: Sesión Salesforce inválida, credenciales incorrectas
- **403 Forbidden**: Región no válida, servicio no autorizado
- **404 Not Found**: No hay ofertas disponibles, cliente no encontrado
- **422 Unprocessable Entity**: Condiciones crediticias no válidas, solicitud rechazada

### Errores de Servidor (5xx)
- **500 Internal Server Error**: Errores generales, errores de parametrización
- **501 Not Implemented**: Servicio no implementado para la región
- **502 Bad Gateway**: Errores de Salesforce, servicios externos
- **503 Service Unavailable**: Base de datos no disponible, servicios externos no disponibles
- **504 Gateway Timeout**: Timeout en servicios externos

### Respuestas Exitosas (2xx)
- **200 OK**: Operación exitosa, solicitud aprobada
- **202 Accepted**: Solicitud en proceso, pendiente de aprobación

## Manejo de Errores por Pipeline

### Pipeline ValidacionesGenerales_request
```xml
<!-- Validación XSD -->
<validate schema="solicitudFinanciamientoTCTypes">
  <!-- Error: VALIDATION_ERROR → 400 Bad Request -->
</validate>

<!-- Validación Regional -->
<wsCallout service="ValidaServicioRegional">
  <!-- Error: REGION_NOT_VALID → 403 Forbidden -->
</wsCallout>
```

### Pipeline SolicitaFinanciamientoTC_request (HN01)
```xml
<!-- Parametrización -->
<wsCallout service="ObtenerParametrizacion">
  <!-- Error: PARAMETER_ERROR → 500 Internal Server Error -->
</wsCallout>

<!-- Consulta Ofertas -->
<wsCallout service="consultaOferta_db">
  <!-- Error: NO_OFFERS_AVAILABLE → 404 Not Found -->
  <!-- Error: DATABASE_ERROR → 503 Service Unavailable -->
</wsCallout>

<!-- Validación Condiciones -->
<assign varName="validationMessage">
  <!-- Error: INVALID_CONDITIONS → 422 Unprocessable Entity -->
</assign>

<!-- Login Salesforce -->
<wsCallout service="LoginSalesforce">
  <!-- Error: SALESFORCE_ERROR → 502 Bad Gateway -->
</wsCallout>

<!-- Crear Gestión Extra -->
<wsCallout service="SalesforceHNIngresaGestionExtra">
  <!-- Error: INVALID_SESSION_ID → 401 Unauthorized (con retry) -->
  <!-- Error: SALESFORCE_ERROR → 502 Bad Gateway -->
</wsCallout>
```

### Error Handlers
```xml
<!-- Error Handler HN01 -->
<pipeline name="_onErrorHandler-7908611298617121392--4ebd19fc.164898eb0db.-76ad">
  <stage name="errorHandlerIngresoGestionExtrafinanciamiento">
    <!-- Manejo específico de INVALID_SESSION_ID -->
    <ifThenElse>
      <case condition="$errorCode='ws:INVALID_SESSION_ID'">
        <!-- Retry automático con nuevo login -->
      </case>
    </ifThenElse>
  </stage>
</pipeline>

<!-- Error Handler General -->
<pipeline name="_onErrorHandler-299465145049024412--217aff33.16481a1ebbc.-7d9e">
  <stage name="ManejoError">
    <!-- Mapeo general de errores -->
    <wsCallout service="MapeoErrores"/>
  </stage>
</pipeline>
```

## Configuración de Mapeo de Errores

### Servicio MapeoErrores
- **Proxy**: `Middleware/v2/ProxyServices/MapeoErrores`
- **Operación**: mapeoErrores
- **Input**: Código error + mensaje
- **Output**: Error mapeado con código HTTP

### Transformaciones de Error
- **Input**: `Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageIn.xq`
- **Output**: `Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageOut.xq`

### Formato de Error Estándar
```xml
<aut:ResponseHeader>
  <successIndicator>ERROR</successIndicator>
  <messages>{mensaje_error_detallado}</messages>
  <errorCode>{codigo_error}</errorCode>
  <httpStatusCode>{codigo_http}</httpStatusCode>
</aut:ResponseHeader>
```

## Ejemplos de Respuestas de Error de IngresaGestionExtra

### Respuesta de Error - Cliente Inválido
```xml
<ns2:CrearExtraResponse xmlns:ns2="http://soap.sforce.com/schemas/class/WS_IngresaGestionExtra">
   <ns2:result>
      <ns2:CodigoError>INVALID_CLIENT</ns2:CodigoError>
      <ns2:MensajeError>Cliente con ID 0801199012345 no existe o está inactivo</ns2:MensajeError>
      <ns2:IdGestion></ns2:IdGestion>
   </ns2:result>
</ns2:CrearExtraResponse>
```

### Respuesta de Error - Línea de Crédito Insuficiente
```xml
<ns2:CrearExtraResponse xmlns:ns2="http://soap.sforce.com/schemas/class/WS_IngresaGestionExtra">
   <ns2:result>
      <ns2:CodigoError>INSUFFICIENT_CREDIT_LINE</ns2:CodigoError>
      <ns2:MensajeError>Línea de crédito insuficiente. Disponible: 30000.00, Solicitado: 50000.00</ns2:MensajeError>
      <ns2:IdGestion></ns2:IdGestion>
   </ns2:result>
</ns2:CrearExtraResponse>
```

### Respuesta de Error - Tarjeta Inválida
```xml
<ns2:CrearExtraResponse xmlns:ns2="http://soap.sforce.com/schemas/class/WS_IngresaGestionExtra">
   <ns2:result>
      <ns2:CodigoError>INVALID_CARD</ns2:CodigoError>
      <ns2:MensajeError>Tarjeta 4111111111111111 no pertenece al cliente o está inactiva</ns2:MensajeError>
      <ns2:IdGestion></ns2:IdGestion>
   </ns2:result>
</ns2:CrearExtraResponse>
```

### Respuesta de Error - Sistema en Mantenimiento
```xml
<ns2:CrearExtraResponse xmlns:ns2="http://soap.sforce.com/schemas/class/WS_IngresaGestionExtra">
   <ns2:result>
      <ns2:CodigoError>MAINTENANCE_MODE</ns2:CodigoError>
      <ns2:MensajeError>Sistema en mantenimiento programado. Intente más tarde</ns2:MensajeError>
      <ns2:IdGestion></ns2:IdGestion>
   </ns2:result>
</ns2:CrearExtraResponse>
```

## Mapeo de Errores IngresaGestionExtra por Región

### Errores Específicos HN01 (Honduras)
| Código Error | Descripción | Causa Común |
|-------------|-------------|-------------|
| **INVALID_CLIENT** | Cliente no existe en base HN | ID de cliente incorrecto o cliente no migrado |
| **INSUFFICIENT_CREDIT_LINE** | Línea insuficiente HNL | Límites en Lempiras |
| **INVALID_CURRENCY** | Moneda no HNL | Solo acepta Lempiras en Honduras |
| **INVALID_DISBURSEMENT_TYPE** | Tipo desembolso no válido HN | Tipos específicos para Honduras |
| **PRODUCT_NOT_AVAILABLE** | EXTRAFINANCIAMIENTO no disponible | Producto específico HN |

### Errores Específicos GT01 (Guatemala)
| Código Error | Descripción | Causa Común |
|-------------|-------------|-------------|
| **INVALID_CLIENT** | Cliente no existe en base GT | ID de cliente incorrecto o cliente no migrado |
| **INSUFFICIENT_CREDIT_LINE** | Línea insuficiente GTQ | Límites en Quetzales |
| **INVALID_CURRENCY** | Moneda no GTQ | Solo acepta Quetzales en Guatemala |
| **INVALID_DISBURSEMENT_TYPE** | Tipo desembolso no válido GT | Tipos específicos para Guatemala |
| **PRODUCT_NOT_AVAILABLE** | FINANCIAMIENTO_TC no disponible | Producto específico GT |

## Transformación de Errores en XQuery

### Función de Mapeo de Errores (Propuesta)
```xquery
declare function mapSalesforceError($codigoError as xs:string, $mensajeError as xs:string) 
as element() {
    let $httpCode := 
        if ($codigoError = "SUCCESS") then "200"
        else if ($codigoError = ("INVALID_CLIENT", "INVALID_CARD")) then "404"
        else if ($codigoError = "INVALID_EMAIL") then "400"
        else if ($codigoError = "CLIENT_BLOCKED") then "403"
        else if ($codigoError = "DUPLICATE_REQUEST") then "409"
        else if ($codigoError = "RATE_LIMIT_EXCEEDED") then "429"
        else if ($codigoError = ("INSUFFICIENT_CREDIT_LINE", "INVALID_TERM", "INVALID_CURRENCY", 
                                "INVALID_AMOUNT", "INVALID_DISBURSEMENT_TYPE", "INVALID_ACCOUNT",
                                "VALIDATION_ERROR", "INVALID_REGION", "PRODUCT_NOT_AVAILABLE",
                                "CREDIT_EVALUATION_FAILED", "INVALID_INTEREST_RATE", "INVALID_COMMISSION")) then "422"
        else if ($codigoError = ("SYSTEM_ERROR", "WORKFLOW_ERROR")) then "500"
        else if ($codigoError = "INTEGRATION_ERROR") then "502"
        else if ($codigoError = "MAINTENANCE_MODE") then "503"
        else if ($codigoError = "TIMEOUT_ERROR") then "504"
        else "500"
    
    let $osbStatus := 
        if ($codigoError = "SUCCESS") then "Success"
        else "ERROR"
    
    return
        <errorMapping>
            <salesforceCode>{$codigoError}</salesforceCode>
            <salesforceMessage>{$mensajeError}</salesforceMessage>
            <httpCode>{$httpCode}</httpCode>
            <osbStatus>{$osbStatus}</osbStatus>
        </errorMapping>
};
```

### Implementación en Pipeline
```xml
<!-- En el responseTransform del wsCallout a Salesforce -->
<con2:assign varName="errorCode">
  <con1:id>_ActionId_ErrorMapping</con1:id>
  <con2:expr>
    <con1:xqueryText>fn:string($RSPCrearExtra/pre:result/pre:CodigoError/text())</con1:xqueryText>
  </con2:expr>
</con2:assign>

<con2:assign varName="validationMessage">
  <con1:id>_ActionId_ErrorMessage</con1:id>
  <con2:expr>
    <con1:xqueryText>
      let $errorCodigo := fn:upper-case($errorCode)
      let $errorMessage := fn:string($RSPCrearExtra/pre:result/pre:MensajeError/text())
      return
        if($errorCodigo = 'SUCCESS') then ('')
        else (
          if($errorMessage != '') then ($errorMessage)
          else ($errorCode)
        )
    </con1:xqueryText>
  </con2:expr>
</con2:assign>
```

## Recomendaciones para Migración

### Consolidación de Errores
1. **Unificar códigos**: Usar códigos estándar HTTP
2. **Centralizar mapeo**: Un solo servicio de mapeo de errores
3. **Logging estructurado**: Incluir códigos de error en logs
4. **Monitoreo**: Alertas por tipo de error
5. **Mapeo Salesforce**: Crear función específica para errores de IngresaGestionExtra

### Mejoras Propuestas
1. **Códigos específicos**: Crear códigos más granulares por tipo de error
2. **Mensajes localizados**: Soporte multi-idioma para mensajes
3. **Retry policies**: Configurar reintentos automáticos
4. **Circuit breaker**: Implementar para servicios externos
5. **Error enrichment**: Agregar contexto adicional a errores de Salesforce

### Validación de Errores
1. **Tests de error**: Crear casos de prueba para cada tipo de error
2. **Documentación**: Mantener catálogo actualizado de errores
3. **Monitoreo**: Dashboard de errores por región y tipo
4. **Simulación**: Crear mocks de Salesforce para testing de errores

### Manejo Específico de IngresaGestionExtra
1. **Validación previa**: Validar datos antes de enviar a Salesforce
2. **Retry inteligente**: Solo reintentar errores transitorios
3. **Fallback**: Implementar mecanismo de respaldo
4. **Alertas**: Notificaciones para errores críticos de negocio