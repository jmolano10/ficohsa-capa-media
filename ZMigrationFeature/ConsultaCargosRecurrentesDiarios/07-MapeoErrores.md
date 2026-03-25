# Mapeo de Errores - ConsultaCargosRecurrentesDiarios

## Códigos de Error del Core y Homologación HTTP

| Código Error (Core) | Descripción Error (Core) | Código HTTP | Descripción Error HTTP |
|-------------------|-------------------------|-------------|----------------------|
| **SUCCESS** | Operación exitosa | 200 | OK |
| **FICBCO0276** | Error específico del servicio ConsultaCargosRecurrentesDiarios | 500 | Internal Server Error |

## Códigos de Error de VisaNet

### Códigos de Consulta (strQueryCode)

| Código VisaNet | Descripción VisaNet | Mapeo OSB | Código HTTP | Descripción HTTP |
|---------------|-------------------|-----------|-------------|------------------|
| **000** | Consulta exitosa | Success | 200 | OK |
| **001** | Error de autenticación | VisaNet-001 | 401 | Unauthorized |
| **002** | Parámetros inválidos | VisaNet-002 | 400 | Bad Request |
| **003** | Tarjeta no encontrada | VisaNet-003 | 404 | Not Found |
| **004** | Error de conexión | VisaNet-004 | 503 | Service Unavailable |
| **005** | Timeout en consulta | VisaNet-005 | 504 | Gateway Timeout |
| **999** | Error interno VisaNet | VisaNet-999 | 500 | Internal Server Error |

### Códigos de Transacción (strTransactionResponseCode)

| Código VisaNet | Descripción VisaNet | Mapeo OSB | Estado Final |
|---------------|-------------------|-----------|-------------|
| **00** | Transacción aprobada | Aplicado | Exitoso |
| **01** | Referir al emisor | Rechazado | Fallido |
| **02** | Referir al emisor, llamada especial | Rechazado | Fallido |
| **03** | Comercio inválido | Rechazado | Fallido |
| **04** | Retener tarjeta | Rechazado | Fallido |
| **05** | No autorizar | Rechazado | Fallido |
| **06** | Error general | Rechazado | Fallido |
| **07** | Retener tarjeta, condiciones especiales | Rechazado | Fallido |
| **08** | Aprobar después de identificación | Rechazado | Fallido |
| **09** | Solicitud en proceso | Rechazado | Fallido |
| **10** | Monto parcial aprobado | Rechazado | Fallido |
| **11** | Aprobado (VIP) | Rechazado | Fallido |
| **12** | Transacción inválida | Rechazado | Fallido |
| **13** | Monto inválido | Rechazado | Fallido |
| **14** | Número de tarjeta inválido | Rechazado | Fallido |
| **15** | Emisor no existe | Rechazado | Fallido |
| **19** | Re-ingresar transacción | Rechazado | Fallido |
| **20** | Respuesta errónea | Rechazado | Fallido |
| **21** | No se tomó acción | Rechazado | Fallido |
| **22** | Sospecha de mal funcionamiento | Rechazado | Fallido |
| **25** | No se puede localizar registro | Rechazado | Fallido |
| **28** | Archivo temporalmente no disponible | Rechazado | Fallido |
| **30** | Error de formato | Rechazado | Fallido |
| **41** | Tarjeta perdida | Rechazado | Fallido |
| **43** | Tarjeta robada | Rechazado | Fallido |
| **51** | Fondos insuficientes | Rechazado | Fallido |
| **52** | Cuenta no existe | Rechazado | Fallido |
| **53** | Cuenta cerrada | Rechazado | Fallido |
| **54** | Tarjeta expirada | Rechazado | Fallido |
| **55** | PIN incorrecto | Rechazado | Fallido |
| **56** | Tarjeta no está en archivo | Rechazado | Fallido |
| **57** | Transacción no permitida para portador | Rechazado | Fallido |
| **58** | Transacción no permitida en terminal | Rechazado | Fallido |
| **59** | Sospecha de fraude | Rechazado | Fallido |
| **61** | Excede límite de retiro | Rechazado | Fallido |
| **62** | Tarjeta restringida | Rechazado | Fallido |
| **63** | Violación de seguridad | Rechazado | Fallido |
| **65** | Excede límite de frecuencia | Rechazado | Fallido |
| **68** | Respuesta recibida muy tarde | Rechazado | Fallido |
| **75** | Excede límite de intentos de PIN | Rechazado | Fallido |
| **76** | Clave ya bloqueada | Rechazado | Fallido |
| **77** | Datos inconsistentes | Rechazado | Fallido |
| **78** | Cuenta bloqueada | Rechazado | Fallido |
| **80** | Fecha inválida | Rechazado | Fallido |
| **81** | Error de encriptación | Rechazado | Fallido |
| **82** | CVV incorrecto | Rechazado | Fallido |
| **83** | No se puede verificar PIN | Rechazado | Fallido |
| **84** | Archivo de autorizaciones inválido | Rechazado | Fallido |
| **85** | Razón no especificada | Rechazado | Fallido |
| **86** | No se puede verificar PIN | Rechazado | Fallido |
| **87** | Compra negada | Rechazado | Fallido |
| **88** | Criptograma incorrecto | Rechazado | Fallido |
| **89** | Terminal inválido | Rechazado | Fallido |
| **90** | Corte de día en proceso | Rechazado | Fallido |
| **91** | Emisor no disponible | Rechazado | Fallido |
| **92** | Destino no disponible | Rechazado | Fallido |
| **93** | No se puede completar | Rechazado | Fallido |
| **94** | Transacción duplicada | Rechazado | Fallido |
| **95** | Error de reconciliación | Rechazado | Fallido |
| **96** | Error del sistema | Rechazado | Fallido |

## Errores de Configuración OSB

### Errores de Parámetros

| Código Error | Descripción Error | Código HTTP | Descripción HTTP |
|-------------|------------------|-------------|------------------|
| **CONFIG_ERROR** | Error al obtener parámetros de configuración | 500 | Internal Server Error |
| **MISSING_PARAM** | Parámetro de configuración faltante | 500 | Internal Server Error |
| **INVALID_REGION** | Región no válida o no configurada | 400 | Bad Request |

### Errores de Validación

| Código Error | Descripción Error | Código HTTP | Descripción HTTP |
|-------------|------------------|-------------|------------------|
| **VALIDATION_ERROR** | Error de validación XSD | 400 | Bad Request |
| **INVALID_CARD_NUMBER** | Número de tarjeta inválido (longitud) | 400 | Bad Request |
| **MISSING_HEADER** | Header de autenticación faltante | 401 | Unauthorized |
| **INVALID_CREDENTIALS** | Credenciales de autenticación inválidas | 401 | Unauthorized |

### Errores de Enrutamiento

| Código Error | Descripción Error | Código HTTP | Descripción HTTP |
|-------------|------------------|-------------|------------------|
| **ROUTING_ERROR** | Error en enrutamiento dinámico | 500 | Internal Server Error |
| **SERVICE_NOT_FOUND** | Servicio regional no encontrado | 404 | Not Found |
| **REGION_NOT_CONFIGURED** | Región no configurada en BD | 500 | Internal Server Error |

## Errores de Conectividad

### Errores de VisaNet

| Código Error | Descripción Error | Código HTTP | Descripción HTTP |
|-------------|------------------|-------------|------------------|
| **CONNECTION_TIMEOUT** | Timeout de conexión a VisaNet | 504 | Gateway Timeout |
| **CONNECTION_REFUSED** | Conexión rechazada por VisaNet | 503 | Service Unavailable |
| **SSL_ERROR** | Error de certificado SSL | 503 | Service Unavailable |
| **NETWORK_ERROR** | Error de red general | 503 | Service Unavailable |

### Errores de Base de Datos

| Código Error | Descripción Error | Código HTTP | Descripción HTTP |
|-------------|------------------|-------------|------------------|
| **DB_CONNECTION_ERROR** | Error de conexión a BD | 503 | Service Unavailable |
| **DB_TIMEOUT** | Timeout en consulta a BD | 504 | Gateway Timeout |
| **DB_QUERY_ERROR** | Error en consulta SQL | 500 | Internal Server Error |

## Mapeo de Errores por Región

### Honduras (HN01)

| Error Específico | Descripción | Mapeo Final |
|-----------------|-------------|-------------|
| **VISANET_HN_UNAVAILABLE** | VisaNet Honduras no disponible | VisaNet-004 |
| **HN_CONFIG_ERROR** | Error configuración parámetros HN01 | CONFIG_ERROR |
| **HN_AUTH_ERROR** | Error autenticación VisaNet HN | VisaNet-001 |

### Nicaragua (NI01)

| Error Específico | Descripción | Mapeo Final |
|-----------------|-------------|-------------|
| **VISANET_NI_UNAVAILABLE** | VisaNet Nicaragua no disponible | VisaNet-004 |
| **NI_CONFIG_ERROR** | Error configuración parámetros NI01 | CONFIG_ERROR |
| **NI_AUTH_ERROR** | Error autenticación VisaNet NI | VisaNet-001 |
| **NI_SOAP12_ERROR** | Error específico SOAP 1.2 | VALIDATION_ERROR |

## Lógica de Mapeo de Errores

### Función getStatusDescripcion (XQuery)

```xquery
declare function getStatusDescripcion($valor as xs:string) as xs:string {
    if($valor = "00") then "Aplicado"
    else if ( $valor != "00" ) then "Rechazado"
    else("")
};
```

### Mapeo de Header de Respuesta (XQuery)

```xquery
if($strQueryCode = '000') then (
    <successIndicator>{'Success'}</successIndicator>
)
else (
    <successIndicator>{fn:concat("VisaNet-", $strQueryCode)}</successIndicator>
)
```

### Manejo de Errores en Pipeline

```xml
<con1:assign varName="errorCode">
    <con1:expr>
        <con:xqueryText>fn:string($fault/ctx:errorCode/text())</con:xqueryText>
    </con1:expr>
</con1:assign>
<con1:assign varName="errorMessage">
    <con1:expr>
        <con:xqueryText>fn:string($fault/ctx:reason/text())</con:xqueryText>
    </con1:expr>
</con1:assign>
```

## Configuración de Mapeo de Errores

### Servicio MapeoErrores

- **Proxy**: `Middleware/v2/ProxyServices/MapeoErrores`
- **Operación**: `mapeoErrores`
- **Parámetros**:
  - `CODIGO_ERROR`: Código de error original
  - `MENSAJE_ERROR`: Mensaje con formato `FICBCO0276$#$[mensaje]`

### Transformaciones de Mapeo

- **Input**: `Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageIn`
- **Output**: `Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageOut`

## Consideraciones para Migración

### 1. Códigos de Error Personalizados
- Mantener la lógica de prefijo "VisaNet-" para errores de VisaNet
- Preservar el mapeo binario "00" → "Aplicado", otros → "Rechazado"

### 2. Manejo Regional
- Cada región puede tener códigos de error específicos
- Mantener la separación de configuraciones por región

### 3. Logging y Monitoreo
- Todos los errores se registran con nivel debug
- SLA alerting habilitado para errores críticos

### 4. Timeout y Retry
- No hay configuración de retry (retry-count: 0)
- Timeouts en 0 (sin límite configurado)
- Considerar configurar timeouts apropiados en migración