# Mapeo de Errores - ConsultaGestionesMonetarias

## Códigos de Error del Core y Homologación HTTP

### Errores de Validación XSD

| Código Error (Core) | Descripción Error (Core) | Código HTTP | Descripción Error |
|-------------------|-------------------------|-------------|------------------|
| `FICBCO0287$#$Schema validation failed` | Error en validación de esquema XSD | 400 | Bad Request - Estructura de datos inválida |
| `FICBCO0287$#$Missing required field NUMUSU` | Campo obligatorio NUMUSU faltante | 400 | Bad Request - Campo requerido faltante |
| `FICBCO0287$#$Missing required field DETALLE_GESTION` | Campo obligatorio DETALLE_GESTION faltante | 400 | Bad Request - Campo requerido faltante |
| `FICBCO0287$#$Missing required field PAIS` | Campo obligatorio PAIS faltante | 400 | Bad Request - Campo requerido faltante |
| `FICBCO0287$#$Invalid data type for NUMUSU` | Tipo de dato inválido para NUMUSU | 400 | Bad Request - Tipo de dato incorrecto |

### Errores de Validación Regional

| Código Error (Core) | Descripción Error (Core) | Código HTTP | Descripción Error |
|-------------------|-------------------------|-------------|------------------|
| `FICBCO0287$#$Invalid region` | Región no válida para el servicio | 403 | Forbidden - Región no autorizada |
| `FICBCO0287$#$Service not available for region` | Servicio no disponible para la región | 403 | Forbidden - Servicio no disponible |
| `FICBCO0287$#$Region validation failed` | Falla en validación regional | 403 | Forbidden - Validación regional fallida |
| `FICBCO0287$#$User not authorized for region` | Usuario no autorizado para la región | 401 | Unauthorized - Usuario no autorizado |

### Errores de Autenticación

| Código Error (Core) | Descripción Error (Core) | Código HTTP | Descripción Error |
|-------------------|-------------------------|-------------|------------------|
| `FICBCO0287$#$Authentication failed` | Falla en autenticación | 401 | Unauthorized - Credenciales inválidas |
| `FICBCO0287$#$Missing authentication header` | Header de autenticación faltante | 401 | Unauthorized - Autenticación requerida |
| `FICBCO0287$#$Invalid username or password` | Usuario o contraseña inválidos | 401 | Unauthorized - Credenciales incorrectas |
| `FICBCO0287$#$Token expired` | Token de autenticación expirado | 401 | Unauthorized - Token expirado |

### Errores de Base de Datos

| Código Error (Core) | Descripción Error (Core) | Código HTTP | Descripción Error |
|-------------------|-------------------------|-------------|------------------|
| `FICBCO0287$#$Database connection failed` | Falla en conexión a base de datos | 503 | Service Unavailable - Base de datos no disponible |
| `FICBCO0287$#$Stored procedure execution failed` | Falla en ejecución de stored procedure | 500 | Internal Server Error - Error en procesamiento |
| `FICBCO0287$#$Database timeout` | Timeout en base de datos | 504 | Gateway Timeout - Tiempo de espera agotado |
| `FICBCO0287$#$Invalid database parameters` | Parámetros de base de datos inválidos | 400 | Bad Request - Parámetros incorrectos |
| `FICBCO0287$#$No data found` | No se encontraron datos | 404 | Not Found - Datos no encontrados |

### Errores del Stored Procedure `SFC_P_CON_GESTIONES_MONETARIAS`

Estos son los códigos devueltos directamente por el SP a través del parámetro `Pv_CodigoMensaje`:

| `Pv_CodigoMensaje` | `Pv_DescripcionMensaje` | Condición en el SP | Código HTTP | Descripción HTTP |
|-------------------|------------------------|-------------------|-------------|-----------------|
| `SUCCESS` | *(vacío — se retorna `Pt_Campos_Resultado` con datos)* | `Ln_Cantidad > 0`: se encontraron registros en `SFC_GESTIONES_MONETARIAS` para el `NUMUSU`, `PAIS` y `DETALLE` dados | 200 | OK - Consulta exitosa con registros |
| `NO RECORDS` | `No se encontró ningún dato con los parámetros ingresados` | `Ln_Cantidad = 0`: el cursor `C_REGISTRO` no retornó filas — usuario inexistente, país incorrecto o detalle sin coincidencia | 404 | Not Found - Sin registros para los parámetros dados |
| `ERROR` | `Error al consultar la información. : <SQLERRM>` | Bloque `WHEN OTHERS`: cualquier excepción Oracle no controlada (p.ej. error de acceso a tabla, tipo de dato incorrecto, falla de conexión interna) | 500 | Internal Server Error - Error inesperado en base de datos |

> **Nota sobre `ERROR`:** el mensaje incluye el detalle de `SQLERRM`, por lo que puede contener errores Oracle como `ORA-00942` (tabla no existe), `ORA-01403` (no data found explícito), `ORA-04068` (paquete invalidado), entre otros. El código HTTP 500 aplica en todos estos casos.

### Otros Errores del Stored Procedure (genéricos OSB)

| Código Error (Core) | Descripción Error (Core) | Código HTTP | Descripción Error |
|-------------------|-------------------------|-------------|------------------|
| `FICBCO0287$#$INVALID_USER` | Usuario no válido en el sistema | 404 | Not Found - Usuario no encontrado |
| `FICBCO0287$#$INVALID_COUNTRY` | País no válido | 400 | Bad Request - País incorrecto |
| `FICBCO0287$#$INVALID_DETAIL` | Detalle de gestión no válido | 400 | Bad Request - Detalle incorrecto |
| `FICBCO0287$#$NO_RECORDS_FOUND` | No se encontraron registros | 404 | Not Found - Sin registros |
| `FICBCO0287$#$BUSINESS_ERROR` | Error de negocio en stored procedure | 422 | Unprocessable Entity - Error de negocio |

### Errores de Transformación

| Código Error (Core) | Descripción Error (Core) | Código HTTP | Descripción Error |
|-------------------|-------------------------|-------------|------------------|
| `FICBCO0287$#$XQuery transformation failed` | Falla en transformación XQuery | 500 | Internal Server Error - Error de transformación |
| `FICBCO0287$#$Invalid XML structure` | Estructura XML inválida | 400 | Bad Request - XML malformado |
| `FICBCO0287$#$Namespace error` | Error en namespace XML | 400 | Bad Request - Namespace incorrecto |
| `FICBCO0287$#$Data mapping error` | Error en mapeo de datos | 500 | Internal Server Error - Error de mapeo |

### Errores de Enrutamiento

| Código Error (Core) | Descripción Error (Core) | Código HTTP | Descripción Error |
|-------------------|-------------------------|-------------|------------------|
| `FICBCO0287$#$SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY` | Servicio no implementado para país/empresa | 501 | Not Implemented - Servicio no implementado |
| `FICBCO0287$#$Invalid routing configuration` | Configuración de enrutamiento inválida | 500 | Internal Server Error - Error de configuración |
| `FICBCO0287$#$Pipeline not found` | Pipeline no encontrado | 500 | Internal Server Error - Pipeline faltante |

### Errores de Sistema OSB

| Código Error (Core) | Descripción Error (Core) | Código HTTP | Descripción Error |
|-------------------|-------------------------|-------------|------------------|
| `FICBCO0287$#$OSB-382000` | Error general de OSB | 500 | Internal Server Error - Error interno OSB |
| `FICBCO0287$#$OSB-382001` | Error de proxy service | 500 | Internal Server Error - Error de proxy |
| `FICBCO0287$#$OSB-382002` | Error de business service | 503 | Service Unavailable - Servicio no disponible |
| `FICBCO0287$#$OSB-382003` | Error de pipeline | 500 | Internal Server Error - Error de pipeline |

### Errores de Conectividad

| Código Error (Core) | Descripción Error (Core) | Código HTTP | Descripción Error |
|-------------------|-------------------------|-------------|------------------|
| `FICBCO0287$#$Connection timeout` | Timeout de conexión | 504 | Gateway Timeout - Tiempo de conexión agotado |
| `FICBCO0287$#$Network error` | Error de red | 503 | Service Unavailable - Error de conectividad |
| `FICBCO0287$#$JCA adapter error` | Error en adaptador JCA | 503 | Service Unavailable - Adaptador no disponible |
| `FICBCO0287$#$Connection pool exhausted` | Pool de conexiones agotado | 503 | Service Unavailable - Recursos agotados |

## Códigos de Éxito

| `Pv_CodigoMensaje` / Código (Core) | Descripción | Código HTTP | Descripción HTTP |
|-----------------------------------|-------------|-------------|-----------------|
| `SUCCESS` | El SP retornó al menos un registro en `Pt_Campos_Resultado` | 200 | OK - Consulta exitosa con registros |
| `FICBCO0287$#$SUCCESS` | Consulta de gestiones monetarias exitosa (código OSB mapeado) | 200 | OK - Consulta exitosa |

## Configuración del Mapeo de Errores

### Servicio de Mapeo
- **Proxy Service**: `Middleware/v2/ProxyServices/MapeoErrores`
- **Operación**: `mapeoErrores`
- **Código de Servicio**: `FICBCO0287`

### Transformaciones de Mapeo
- **Entrada**: `Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageIn`
- **Salida**: `Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageOut`

### Parámetros de Mapeo
```xml
<con2:param name="CODIGO_ERROR">
    <con2:path>fn:concat("FICBCO0287", "$#$", $errorMessage)</con2:path>
</con2:param>
<con2:param name="MENSAJE_ERROR">
    <con2:path>$errorCode</con2:path>
</con2:param>
```

## Manejo de Errores por Pipeline

### Error Handler Principal
- **Pipeline**: `_onErrorHandler-4368734614033876815-6f74fcfe.163ff6a96e7.-7fa6`
- **Función**: Capturar y procesar todos los errores no manejados
- **Acciones**:
  1. Extraer código y mensaje de error
  2. Llamar al servicio de mapeo de errores
  3. Construir response de error
  4. Retornar SOAP fault

### Variables de Error
```xml
<con3:assign varName="errorCode">
    <con3:expr>
        <con2:xqueryText>fn:string($fault/ctx:errorCode/text())</con2:xqueryText>
    </con3:expr>
</con3:assign>
<con3:assign varName="errorMessage">
    <con3:expr>
        <con2:xqueryText>fn:string($fault/ctx:reason/text())</con2:xqueryText>
    </con3:expr>
</con3:assign>
```

## Estructura de Response de Error

### Header de Error
```xml
<aut:ResponseHeader>
    <successIndicator>ERROR</successIndicator>
    <messages>{mensaje de error mapeado}</messages>
</aut:ResponseHeader>
```

### Body de Error
```xml
<con:consultaGestionesMonetariasResponse/>
```

## Logging de Errores

### Configuración de Logging
- **Nivel**: Debug
- **Habilitado**: true
- **Ubicación**: Logs del servidor OSB

### Información Registrada
- Código de error original
- Mensaje de error original
- Código de error mapeado
- Mensaje de error mapeado
- Timestamp del error
- Usuario que generó el error
- Región desde donde se originó el error

## Monitoreo y Alertas

### SLA Alerting
- **Habilitado**: true
- **Nivel**: Normal
- **Métricas**: Tiempo de respuesta, tasa de errores

### Pipeline Alerting
- **Habilitado**: true
- **Nivel**: Normal
- **Cobertura**: Todos los pipelines de la funcionalidad

## Recomendaciones para Manejo de Errores

### Para el Cliente
1. **Validar estructura**: Verificar que el XML cumpla con el esquema antes del envío
2. **Manejar timeouts**: Implementar reintentos con backoff exponencial
3. **Verificar autenticación**: Asegurar credenciales válidas
4. **Validar región**: Confirmar que la región esté soportada

### Para el Sistema
1. **Monitoreo proactivo**: Alertas en tiempo real para errores críticos
2. **Logs detallados**: Registrar contexto completo de errores
3. **Métricas de salud**: Dashboard con indicadores de disponibilidad
4. **Documentación actualizada**: Mantener catálogo de errores actualizado