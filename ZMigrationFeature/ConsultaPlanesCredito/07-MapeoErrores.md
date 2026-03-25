# Mapeo de Errores - ConsultaPlanesCredito

## Tabla de Mapeo de Errores

| Código Error (ConsultaPlanesCredito) | Descripción Error (ConsultaPlanesCredito) | Código HTTP | Descripción Error |
|-------------------------------------|-------------------------------------------|-------------|-------------------|
| SUCCESS | Consulta exitosa de planes de crédito | 200 | OK |
| ERROR | Error general en la consulta | 500 | Internal Server Error |
| VALIDATION_ERROR | Error de validación de esquema XML | 400 | Bad Request |
| INVALID_ACCOUNT | Número de cuenta inválido o no encontrado | 404 | Not Found |
| INVALID_REGION | Región no válida o no soportada | 400 | Bad Request |
| DATABASE_ERROR | Error de conexión o consulta a base de datos | 503 | Service Unavailable |
| TIMEOUT_ERROR | Timeout en la consulta a base de datos | 504 | Gateway Timeout |
| AUTHENTICATION_ERROR | Error de autenticación | 401 | Unauthorized |
| AUTHORIZATION_ERROR | Error de autorización | 403 | Forbidden |
| SERVICE_UNAVAILABLE | Servicio no disponible | 503 | Service Unavailable |
| INVALID_REQUEST_FORMAT | Formato de request inválido | 400 | Bad Request |
| MISSING_REQUIRED_FIELD | Campo obligatorio faltante | 400 | Bad Request |
| INVALID_ORG | Código de organización inválido | 400 | Bad Request |
| NO_PLANS_FOUND | No se encontraron planes para la cuenta | 404 | Not Found |
| REGIONAL_ROUTING_ERROR | Error en enrutamiento regional | 500 | Internal Server Error |

## Errores Específicos por Región

### Guatemala (GT01)
| Código Error Interno | Descripción | Mapeo OSB | Código HTTP |
|---------------------|-------------|-----------|-------------|
| -1 | Consulta exitosa | SUCCESS | 200 |
| 1001 | Cuenta no encontrada en GT | INVALID_ACCOUNT | 404 |
| 1002 | Error de conexión BD GT | DATABASE_ERROR | 503 |
| 1003 | Parámetros inválidos GT | INVALID_REQUEST_FORMAT | 400 |
| 1004 | Sin planes activos GT | NO_PLANS_FOUND | 404 |

### Honduras (HN01)
| Código Error Interno | Descripción | Mapeo OSB | Código HTTP |
|---------------------|-------------|-----------|-------------|
| -1 | Consulta exitosa | SUCCESS | 200 |
| 2001 | Cuenta no encontrada en HN | INVALID_ACCOUNT | 404 |
| 2002 | Error de conexión BD HN | DATABASE_ERROR | 503 |
| 2003 | Parámetros inválidos HN | INVALID_REQUEST_FORMAT | 400 |
| 2004 | Sin planes activos HN | NO_PLANS_FOUND | 404 |
| 2005 | Error específico HN | {$errorCode} | 500 |

### Nicaragua (NI01)
| Código Error Interno | Descripción | Mapeo OSB | Código HTTP |
|---------------------|-------------|-----------|-------------|
| -1 | Consulta exitosa | SUCCESS | 200 |
| 3001 | Cuenta no encontrada en NI | INVALID_ACCOUNT | 404 |
| 3002 | Error de conexión BD NI | DATABASE_ERROR | 503 |
| 3003 | Parámetros inválidos NI | INVALID_REQUEST_FORMAT | 400 |
| 3004 | Sin planes activos NI | NO_PLANS_FOUND | 404 |
| 3005 | Error esquema OSB NI | DATABASE_ERROR | 503 |

### Panamá (PA01)
| Código Error Interno | Descripción | Mapeo OSB | Código HTTP |
|---------------------|-------------|-----------|-------------|
| -1 | Consulta exitosa | SUCCESS | 200 |
| 4001 | Cuenta no encontrada en PA | INVALID_ACCOUNT | 404 |
| 4002 | Error de conexión BD PA | DATABASE_ERROR | 503 |
| 4003 | Parámetros inválidos PA | INVALID_REQUEST_FORMAT | 400 |
| 4004 | Sin planes activos PA | NO_PLANS_FOUND | 404 |

## Errores de Validación XSD

| Error XSD | Descripción | Código OSB | Código HTTP |
|-----------|-------------|------------|-------------|
| cvc-minLength-valid | Campo no cumple longitud mínima | VALIDATION_ERROR | 400 |
| cvc-maxLength-valid | Campo excede longitud máxima | VALIDATION_ERROR | 400 |
| cvc-pattern-valid | Campo no cumple patrón requerido | VALIDATION_ERROR | 400 |
| cvc-type.3.1.3 | Valor no válido para el tipo | VALIDATION_ERROR | 400 |
| cvc-complex-type.2.4.a | Elemento requerido faltante | MISSING_REQUIRED_FIELD | 400 |
| cvc-elt.1.a | Elemento no declarado | INVALID_REQUEST_FORMAT | 400 |

## Errores de Enrutamiento Regional

| Error Enrutamiento | Descripción | Código OSB | Código HTTP |
|-------------------|-------------|------------|-------------|
| REGION_NOT_FOUND | Región no encontrada en consultaRutaRegional | INVALID_REGION | 400 |
| SERVICE_NOT_AVAILABLE | Servicio regional no disponible | SERVICE_UNAVAILABLE | 503 |
| ROUTING_TIMEOUT | Timeout en enrutamiento | TIMEOUT_ERROR | 504 |
| INVALID_SERVICE_ID | ID de servicio inválido (FICBCO0321) | INVALID_REQUEST_FORMAT | 400 |
| VERSION_NOT_SUPPORTED | Versión no soportada | INVALID_REQUEST_FORMAT | 400 |

## Errores de Base de Datos

| Error BD | Descripción | Código OSB | Código HTTP |
|----------|-------------|------------|-------------|
| ORA-00942 | Tabla o vista no existe | DATABASE_ERROR | 503 |
| ORA-01017 | Usuario/contraseña inválida | AUTHENTICATION_ERROR | 401 |
| ORA-12154 | TNS: no se pudo resolver el identificador de conexión | DATABASE_ERROR | 503 |
| ORA-12541 | TNS: no hay listener | DATABASE_ERROR | 503 |
| ORA-00904 | Identificador inválido | DATABASE_ERROR | 503 |
| ORA-01403 | No se encontraron datos | NO_PLANS_FOUND | 404 |
| ORA-00001 | Restricción única violada | DATABASE_ERROR | 500 |
| ORA-01400 | No se puede insertar NULL | DATABASE_ERROR | 500 |

## Errores de Conexión JCA

| Error JCA | Descripción | Código OSB | Código HTTP |
|-----------|-------------|------------|-------------|
| JCA-11001 | Error de conexión al adaptador | DATABASE_ERROR | 503 |
| JCA-11002 | Timeout de conexión | TIMEOUT_ERROR | 504 |
| JCA-11003 | Pool de conexiones agotado | SERVICE_UNAVAILABLE | 503 |
| JCA-11004 | Configuración de adaptador inválida | DATABASE_ERROR | 503 |
| JCA-11005 | Error en stored procedure | DATABASE_ERROR | 500 |

## Errores de Transformación XQuery

| Error XQuery | Descripción | Código OSB | Código HTTP |
|--------------|-------------|------------|-------------|
| XPTY0004 | Tipo de secuencia incorrecto | ERROR | 500 |
| XPDY0002 | Expresión dinámica no válida | ERROR | 500 |
| FORG0001 | Conversión de tipo inválida | ERROR | 500 |
| FONS0004 | Namespace no declarado | ERROR | 500 |
| XQST0022 | Namespace duplicado | ERROR | 500 |

## Errores de Autenticación y Autorización

| Error Auth | Descripción | Código OSB | Código HTTP |
|------------|-------------|------------|-------------|
| AUTH_001 | Usuario no encontrado | AUTHENTICATION_ERROR | 401 |
| AUTH_002 | Contraseña incorrecta | AUTHENTICATION_ERROR | 401 |
| AUTH_003 | Usuario bloqueado | AUTHENTICATION_ERROR | 401 |
| AUTH_004 | Sesión expirada | AUTHENTICATION_ERROR | 401 |
| AUTH_005 | Sin permisos para la operación | AUTHORIZATION_ERROR | 403 |
| AUTH_006 | Sin permisos para la región | AUTHORIZATION_ERROR | 403 |

## Configuración de Mapeo de Errores

### Servicio MapeoErrores
- **Proxy**: `Middleware/v2/ProxyServices/MapeoErrores.proxy`
- **Operación**: `mapeoErrores`
- **Transformación Input**: `Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageIn.xq`
- **Transformación Output**: `Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageOut.xq`

### Formato de Error Estándar
```xml
<aut:ResponseHeader>
  <successIndicator>ERROR</successIndicator>
  <messages>FICBCO0321$#$[Mensaje de error específico]</messages>
</aut:ResponseHeader>
```

### Formato de Error HN01 (Específico)
```xml
<aut:ResponseHeader>
  <successIndicator>{$errorCode}</successIndicator>
  <messages>[Mensaje de error específico]</messages>
</aut:ResponseHeader>
```

## Consideraciones para Migración

### 1. Homologación de Códigos
- Unificar códigos de error entre regiones
- Establecer mapeo consistente a códigos HTTP
- Implementar catálogo centralizado de errores

### 2. Manejo de Errores Regional
- Estandarizar el formato de error response
- HN01 tiene comportamiento diferente (successIndicator = $errorCode)
- Considerar mantener o unificar este comportamiento

### 3. Logging y Monitoreo
- Implementar logging estructurado de errores
- Agregar métricas de errores por región
- Configurar alertas para errores críticos

### 4. Timeouts y Reintentos
- Configurar timeouts apropiados por región
- Implementar estrategia de reintentos
- Manejar circuit breakers para fallos de BD

### 5. Validaciones
- Mejorar validaciones de entrada
- Implementar validaciones de negocio específicas
- Agregar validaciones de formato de cuenta por región