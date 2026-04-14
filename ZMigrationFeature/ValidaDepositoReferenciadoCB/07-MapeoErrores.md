# Mapeo de Errores - ValidaDepositoReferenciadoCB

## Tabla de Mapeo de Errores

| Código Error (Core) | Descripción Error (Core) | Código HTTP | Descripción Error |
|-------------------|-------------------------|-------------|------------------|
| **FICBCO0312** | Error en ValidaDepositoReferenciadoCB - Wrapper CB | 500 | Internal Server Error - Error en validación de depósito referenciado CB |
| **FICBCO0311** | Error en ValidaDepositoReferenciado - Servicio Core | 500 | Internal Server Error - Error en validación de depósito referenciado |
| **NO ACCOUNT** | La cuenta es necesaria | 400 | Bad Request - Campo ACCOUNT requerido |
| **NO DOCUMENT TYPE** | El tipo de documento es necesario | 400 | Bad Request - Campo DOCUMENT_INFO.TYPE requerido |
| **NO DOCUMENT VALUE** | El valor del documento es necesario | 400 | Bad Request - Campo DOCUMENT_INFO.VALUE requerido |
| **NO RECORDS** | NO RECORDS FOUND | 404 | Not Found - No se encontraron registros para los criterios especificados |
| **BEA-382505** | Error de validación de esquema XML | 400 | Bad Request - Estructura XML inválida |
| **MW-0008** | SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY | 501 | Not Implemented - Servicio no implementado para esta región |
| **ERROR** | Error en validación de corresponsal bancario | 403 | Forbidden - Corresponsal bancario no autorizado |
| **ERROR** | Error en validación de servicio regional | 403 | Forbidden - Servicio no habilitado para la región |
| **SUCCESS** | Operación exitosa | 200 | OK - Validación exitosa |

## Códigos de Error por Componente

### ValidaDepositoReferenciadoCB Proxy (Wrapper CB)

#### Errores de Validación de Entrada
- **NO ACCOUNT**: Campo ACCOUNT vacío o nulo
- **NO DOCUMENT TYPE**: Campo DOCUMENT_INFO.TYPE vacío o nulo  
- **NO DOCUMENT VALUE**: Campo DOCUMENT_INFO.VALUE vacío o nulo
- **BEA-382505**: Error de validación de esquema XML

#### Errores de Corresponsal Bancario
- **Error de Corresponsal**: Cuando `PV_CODIGO_MENSAJE != 'SUCCESS'` en consultarCorresponsalB_db

#### Código de Servicio
- **FICBCO0312**: Código identificador del servicio ValidaDepositoReferenciadoCB

### ValidaDepositoReferenciado Proxy (Servicio Core)

#### Errores de Validación Regional
- **Error Regional**: Cuando `PV_CODIGO_ERROR != 'SUCCESS'` en ValidaServicioRegional_db

#### Errores de Datos
- **NO RECORDS**: Cuando `PV_CODIGO_RETORNO = '-1'` desde la base de datos

#### Errores de Implementación
- **MW-0008**: Servicio no implementado para regiones diferentes a HN01

#### Código de Servicio
- **FICBCO0311**: Código identificador del servicio ValidaDepositoReferenciado

### Base de Datos (ValidaDepositoReferenciado_db)

#### Parámetros de Error de Salida
- **PV_CODIGO_ERROR**: Código de error del stored procedure
- **PV_CODIGO_RETORNO**: Código de retorno (-1 = sin registros, 0 = exitoso)
- **PV_MENSAJE_ERROR**: Mensaje descriptivo del error

#### Stored Procedure
- **Package**: CBR_K_DEP_REFERENCIADOS
- **Procedure**: CRB_P_VALIDAR_DEPOSITO_REF

## Flujo de Manejo de Errores

### 1. Errores de Validación de Esquema
```
Cliente → ValidaDepositoReferenciadoCB → Error BEA-382505 → mapeoErrorValidate → SOAP Fault
```

### 2. Errores de Campos Obligatorios
```
Cliente → ValidaDepositoReferenciadoCB → Error (NO ACCOUNT/TYPE/VALUE) → MapeoErrores (FICBCO0312) → Response Error
```

### 3. Errores de Corresponsal
```
Cliente → ValidaDepositoReferenciadoCB → consultarCorresponsalB_db → Error → Response Error
```

### 4. Errores de Servicio Regional
```
Cliente → ValidaDepositoReferenciado → ValidaServicioRegional_db → Error → MapeoErrores (FICBCO0311) → Response Error
```

### 5. Errores de Datos
```
Cliente → ValidaDepositoReferenciado → ValidaDepositoReferenciado_db → NO RECORDS → MapeoErrores (FICBCO0311) → Response Error
```

### 6. Errores de Región No Implementada
```
Cliente → ValidaDepositoReferenciado → DefaultBranch → MW-0008 → Response Error
```

## Transformaciones de Error

### mapeoErrorValidate (BEA-382505)
- **Entrada**: `$fault` (contexto de error OSB)
- **Salida**: Header con `successIndicator` y `messages`
- **Uso**: Errores de validación de esquema XML

### MapeoErrores Service
- **Entrada**: 
  - `CODIGO_ERROR`: Código del error
  - `MENSAJE_ERROR`: Mensaje con formato "FICBCO0312$#$mensaje" o "FICBCO0311$#$mensaje"
- **Salida**: Header estructurado con error mapeado
- **Uso**: Mapeo de errores de negocio a códigos estándar

## Estructura de Response de Error

### Header de Error
```xml
<aut:ResponseHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
    <successIndicator>ERROR</successIndicator>
    <messages>Descripción del error</messages>
</aut:ResponseHeader>
```

### Body de Error
```xml
<val:validaDepositoReferenciadoCBResponse xmlns:val="http://www.ficohsa.com.hn/middleware.services/ValidaDepositoReferenciadoCBTypes"/>
```

## Códigos de Transacción

### Tipos de Transacción para Validaciones
- **Tipo 7**: Validación de corresponsal bancario en consultarCorresponsalB_db

### Códigos de Servicio
- **FICBCO0312**: ValidaDepositoReferenciadoCB (Wrapper CB)
- **FICBCO0311**: ValidaDepositoReferenciado (Servicio Core)

## Logging y Monitoreo

### Configuración de Logging
- **Nivel**: Debug habilitado en todos los proxy services
- **SLA Alerting**: Habilitado en nivel normal
- **Pipeline Alerting**: Habilitado en nivel normal

### Información de Debug
- Requests y responses completos
- Transformaciones XQuery
- Errores de base de datos
- Validaciones fallidas

## Recomendaciones para Manejo de Errores

### Para Desarrollo
1. **Validar Esquemas**: Asegurar que los XSD estén actualizados
2. **Probar Validaciones**: Verificar todos los campos obligatorios
3. **Simular Errores**: Probar todos los flujos de error
4. **Logging Detallado**: Mantener logs para troubleshooting

### Para Operación
1. **Monitoreo**: Configurar alertas para errores frecuentes
2. **Dashboards**: Crear métricas de errores por tipo
3. **Documentación**: Mantener catálogo de errores actualizado
4. **Escalamiento**: Definir procedimientos para errores críticos

### Para Migración
1. **Mapeo Regional**: Adaptar códigos de error por región
2. **Base de Datos**: Configurar stored procedures por región
3. **Testing**: Validar manejo de errores en cada región
4. **Rollback**: Preparar procedimientos de reversión