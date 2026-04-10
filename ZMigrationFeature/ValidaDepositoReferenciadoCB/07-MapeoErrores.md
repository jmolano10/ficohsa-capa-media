# Mapeo de Errores - ValidaDepositoReferenciadoCB

## Tabla de Mapeo de Errores

| Código Error (Core) | Descripción Error (Core) | Código HTTP | Descripción Error |
|-------------------|-------------------------|-------------|-------------------|
| **NO ACCOUNT** | La cuenta es necesaria | 400 | Bad Request - Campo obligatorio faltante |
| **NO DOCUMENT TYPE** | El tipo de documento es necesario | 400 | Bad Request - Campo obligatorio faltante |
| **NO DOCUMENT VALUE** | El valor del documento es necesario | 400 | Bad Request - Campo obligatorio faltante |
| **NO RECORDS** | NO RECORDS FOUND | 404 | Not Found - No se encontraron registros |
| **MW-0008** | SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY | 501 | Not Implemented - Servicio no implementado |
| **BEA-382505** | Schema validation error | 400 | Bad Request - Error de validación de esquema |
| **FICBCO0312** | Error en servicio CB ValidaDepositoReferenciadoCB | 500 | Internal Server Error - Error interno del servicio CB |
| **FICBCO0311** | Error en servicio core ValidaDepositoReferenciado | 500 | Internal Server Error - Error interno del servicio core |
| **ERROR** | Error genérico de validación regional | 500 | Internal Server Error - Error de validación regional |
| **SUCCESS** | Operación exitosa | 200 | OK - Operación completada exitosamente |

## Detalles de Errores por Categoría

### 1. Errores de Validación de Entrada (400 - Bad Request)

#### NO ACCOUNT
- **Origen**: ValidaDepositoReferenciadoCB.proxy - Pipeline "Validaciones Generales_request"
- **Condición**: `fn:string($body/val:validaDepositoReferenciadoCBRequest/ACCOUNT/text()) = ""`
- **Ubicación en código**: Stage "ValidateMessage"
- **Acción**: Error inmediato con código "NO ACCOUNT"
- **Mensaje**: "La cuenta es necesaria"

#### NO DOCUMENT TYPE
- **Origen**: ValidaDepositoReferenciadoCB.proxy - Pipeline "Validaciones Generales_request"
- **Condición**: `fn:string($body/val:validaDepositoReferenciadoCBRequest/DOCUMENT_INFO/TYPE/text()) = ""`
- **Ubicación en código**: Stage "ValidateMessage"
- **Acción**: Error inmediato con código "NO DOCUMENT TYPE"
- **Mensaje**: "El tipo de documento es necesario"

#### NO DOCUMENT VALUE
- **Origen**: ValidaDepositoReferenciadoCB.proxy - Pipeline "Validaciones Generales_request"
- **Condición**: `fn:string($body/val:validaDepositoReferenciadoCBRequest/DOCUMENT_INFO/VALUE/text()) = ""`
- **Ubicación en código**: Stage "ValidateMessage"
- **Acción**: Error inmediato con código "NO DOCUMENT VALUE"
- **Mensaje**: "El valor del documento es necesario"

#### BEA-382505 (Schema Validation Error)
- **Origen**: OSB Framework - Validación automática de esquema
- **Condición**: Request no cumple con el esquema XSD definido
- **Manejo**: Transformación con `mapeoErrorValidate.xq`
- **Ubicación**: Error handler de ambos proxies
- **Acción**: Mapeo automático a formato de error estándar

### 2. Errores de Negocio (404 - Not Found)

#### NO RECORDS
- **Origen**: ValidaDepositoReferenciado.proxy - Pipeline "HN01_request"
- **Condición**: `$codigoValidaDeposito = "-1"`
- **Fuente**: Stored procedure CRB_P_VALIDAR_DEPOSITO_REF retorna PV_CODIGO_RETORNO = "-1"
- **Ubicación en código**: Stage "FlujoEntrada" después de wsCallout a ValidaDepositoReferenciado_db
- **Acción**: Error inmediato con código "NO RECORDS"
- **Mensaje**: "NO RECORDS FOUND"

### 3. Errores de Implementación (501 - Not Implemented)

#### MW-0008
- **Origen**: ValidaDepositoReferenciado.proxy - Pipeline "DefaultBranchPP_response"
- **Condición**: Región diferente a HN01
- **Ubicación en código**: Branch por defecto en regionalización
- **Acción**: Error inmediato con código "MW-0008"
- **Mensaje**: "SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY"

### 4. Errores Internos del Sistema (500 - Internal Server Error)

#### FICBCO0312 (Servicio CB)
- **Origen**: ValidaDepositoReferenciadoCB.proxy - Error handlers
- **Condición**: Errores no manejados específicamente en el servicio CB
- **Formato de mensaje**: `fn:concat("FICBCO0312", "$#$", $errorMessage)`
- **Procesamiento**: Llamada a servicio MapeoErrores
- **Transformación**: mapeoErroresUsageIn.xq / mapeoErroresUsageOut.xq

#### FICBCO0311 (Servicio Core)
- **Origen**: ValidaDepositoReferenciado.proxy - Error handlers
- **Condición**: Errores no manejados específicamente en el servicio core
- **Formato de mensaje**: `fn:concat("FICBCO0311", "$#$", $errorMessage)`
- **Procesamiento**: Llamada a servicio MapeoErrores
- **Transformación**: mapeoErroresUsageIn.xq / mapeoErroresUsageOut.xq

#### ERROR (Validación Regional)
- **Origen**: ValidaDepositoReferenciado.proxy - Stage "ValidateRegionService"
- **Condición**: `fn:string($RSPValidaServicioRegional/vsr:PV_CODIGO_ERROR/text()) != 'SUCCESS'`
- **Fuente**: Stored procedure ValidaServicioRegional
- **Acción**: Response con successIndicator="ERROR"
- **Mensaje**: Contenido de PV_MENSAJE_ERROR del stored procedure

### 5. Errores de Corresponsal Bancario (500 - Internal Server Error)

#### Error de Corresponsal
- **Origen**: ValidaDepositoReferenciadoCB.proxy - Stage "ValidarCorresponsal"
- **Condición**: `fn:string($RSPConsultaCorresponsal/con:PV_CODIGO_MENSAJE/text()) != 'SUCCESS'`
- **Fuente**: Stored procedure consultarCorresponsalB
- **Acción**: Response con successIndicator="Error"
- **Mensaje**: Contenido de PV_MENSAJE_ERROR del stored procedure

## Flujo de Manejo de Errores

### 1. Errores de Validación (BEA-382505)
```
Error de Esquema → mapeoErrorValidate.xq → Response Header con Error → Cliente
```

### 2. Errores de Aplicación (Otros códigos)
```
Error → MapeoErrores Service → mapeoErroresUsageIn.xq → 
Stored Procedure de Mapeo → mapeoErroresUsageOut.xq → Response Header con Error → Cliente
```

### 3. Errores de Negocio Específicos
```
Validación de Negocio → Error Inmediato → Response con successIndicator != SUCCESS → Cliente
```

## Estructura de Response de Error

### Header de Error Estándar
```xml
<aut:ResponseHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
    <successIndicator>ERROR</successIndicator>
    <messages>Mensaje de error específico</messages>
</aut:ResponseHeader>
```

### Body de Error (Vacío)
```xml
<val:validaDepositoReferenciadoCBResponse xmlns:val="http://www.ficohsa.com.hn/middleware.services/ValidaDepositoReferenciadoCBTypes"/>
```

## Configuración de Retry y Timeout

### Configuración de Retry
- **Retry Count**: 0 (sin reintentos automáticos)
- **Retry Interval**: 30 segundos
- **Retry Application Errors**: true

### Implicaciones
- Los errores de aplicación no se reintentan automáticamente
- Los errores de conectividad podrían reintentar según configuración de conexión
- Timeout por defecto del contenedor OSB (no configurado específicamente)

## Códigos de Servicio para Mapeo

### Identificadores de Servicio
- **FICBCO0312**: Identificador para errores del servicio CB ValidaDepositoReferenciadoCB
- **FICBCO0311**: Identificador para errores del servicio core ValidaDepositoReferenciado
- **Transacción 7**: Tipo de transacción para validación de corresponsal bancario

### Formato de Mensaje de Error
```
CODIGO_SERVICIO$#$MENSAJE_ERROR
```

Ejemplo:
```
FICBCO0312$#$La cuenta es necesaria
```

## Recomendaciones para Manejo de Errores

### 1. Logging y Monitoreo
- Todos los servicios tienen logging habilitado en nivel DEBUG
- SLA alerting configurado en nivel NORMAL
- Considerar implementar métricas específicas por tipo de error

### 2. Mejoras Sugeridas
- Implementar códigos de error más granulares
- Agregar información de contexto en mensajes de error
- Considerar implementar retry logic para errores transitorios
- Documentar mapeo completo de errores de stored procedures

### 3. Consistencia Regional
- Mantener códigos de error consistentes entre regiones
- Implementar mapeo de errores específico por región si es necesario
- Considerar localización de mensajes de error