# Comparación entre Regiones - IngresoDataCapture

## Tabla de Comparación Regional

| Aspecto | General (Centralizada) | HN01 (Honduras) | GT01 (Guatemala) | PA01 (Panamá) | NI01 (Nicaragua) |
|---------|------------------------|-----------------|------------------|---------------|------------------|
| **Endpoint OSB** | `/Middleware/OperationsAndExecution/CustomerDeposits/IngresoDataCapture` | Mismo endpoint | Mismo endpoint | Mismo endpoint | Mismo endpoint |
| **Nombre de Base de Datos** | ORA_BANK (via parametrización) | ORA_BANK | ORA_BANK | ORA_BANK | ORA_BANK |
| **Esquemas** | OSB_GET_CONFIG | OSB_GET_CONFIG | OSB_GET_CONFIG | OSB_GET_CONFIG | OSB_GET_CONFIG |
| **Store Procedure** | No aplica (Web Service T24) | No aplica | No aplica | No aplica | No aplica |
| **Nombre de Conexión a Base de datos u OSB** | DataCapture (T24 Web Service) | DataCapture | DataCapture | DataCapture | DataCapture |
| **Transformaciones clave** | ingresoDataCaptureIn.xq, ingresoDataCaptureOut.xq, ingresoDataCaptureHeaderOut.xq | Mismas transformaciones | Mismas transformaciones | Mismas transformaciones | Mismas transformaciones |
| **Campos diferenciadores** | CURRENCY, códigos de transacción por parametrización | HNL como moneda local | Moneda extranjera | Moneda extranjera | Moneda extranjera |
| **Errores/Excepciones** | Manejo estándar con pipeline de error | Mismo manejo | Mismo manejo | Mismo manejo | Mismo manejo |
| **Timeouts/Retrys** | 0 timeout, 0 retry | Mismo | Mismo | Mismo | Mismo |
| **Dependencias internas** | ObtenerParametrizacion, DataCapture, obtenerUUID | Mismas dependencias | Mismas dependencias | Mismas dependencias | Mismas dependencias |
| **Endpoint T24** | http://mwinterbanca:7003/svcDataCapture/services | Mismo endpoint | Mismo endpoint | Mismo endpoint | Mismo endpoint |
| **Autenticación** | Custom Token + LDAP Lookup | Mismo método | Mismo método | Mismo método | Mismo método |
| **Operación T24** | IngresodeDataCapture | Misma operación | Misma operación | Misma operación | Misma operación |
| **Namespace WSDL** | http://www.ficohsa.com.hn/middleware.services/ingresoDataCapturePS/ | Mismo namespace | Mismo namespace | Mismo namespace | Mismo namespace |
| **Binding SOAP** | ingresoDataCapturePSSOAP | Mismo binding | Mismo binding | Mismo binding | Mismo binding |
| **Códigos de Transacción** | T24T099.TXNCODEDR/CR (parametrizables) | Configurables por región | Configurables por región | Configurables por región | Configurables por región |

## Sección por Región

### General (Implementación Centralizada)

#### Endpoints y Configuración
- **Proxy Service**: `IngresoDataCapture.proxy`
- **URI Endpoint**: `/Middleware/OperationsAndExecution/CustomerDeposits/IngresoDataCapture`
- **WSDL**: `ingresoDataCapturePS.wsdl`
- **Binding**: `ingresoDataCapturePSSOAP`

#### Mapeos y Transformaciones
- **Request Validation**: `ingresoDataCaptureValidateRequired.xq` valida campos requeridos
- **Request Mapping**: `ingresoDataCaptureIn.xq` transforma OSB request a formato T24
- **Response Header Mapping**: `ingresoDataCaptureHeaderOut.xq` mapea status y headers
- **Response Body Mapping**: `ingresoDataCaptureOut.xq` extrae RECORD_STATUS

#### Validaciones y Políticas OSB
- **Custom Token Authentication**: Username/Password desde header
- **Schema Validation**: Validación automática de esquema SOAP
- **Business Validation**: Validación de campos requeridos y valores permitidos
- **DEBIT_CREDIT Validation**: Solo acepta "DEBIT" o "CREDIT"

#### Handlers y Configuración
- **Error Handler**: Pipeline de error personalizado con manejo de faults
- **Security**: Custom token authentication con lookup LDAP
- **Monitoring**: Habilitado con agregación cada 10 segundos
- **Logging**: Debug level habilitado
- **Throttling**: Deshabilitado

#### Business Services Internos
1. **ObtenerParametrizacion**
   - **Endpoint**: Base de datos via JCA adapter
   - **Función**: Obtener códigos de transacción configurables
   - **Parámetros**: `T24T099.TXNCODEDR||T24T099.TXNCODECR`

2. **DataCapture**
   - **Endpoint**: `http://mwinterbanca:7003/svcDataCapture/services`
   - **Tipo**: T24 Web Service
   - **Operación**: `IngresodeDataCapture`
   - **Timeout**: 0 (sin límite)

#### Logging y Auditoría
- **Request Logging**: Logging básico a nivel debug
- **Response Logging**: Logging de respuestas exitosas y errores
- **Error Logging**: Pipeline de error con detalles de fault
- **Monitoring**: SLA alerting y pipeline alerting habilitados

### HN01 (Honduras) - Configuración Específica

#### Diferencias Identificadas
- **Moneda Local**: HNL tratada como moneda local (AMOUNTLCY)
- **Códigos de Transacción**: Configurados específicamente para Honduras
- **LDAP Security**: Directorio `Middleware/Security/` con usuarios hondureños
- **Endpoint T24**: Apunta al servidor T24 de Honduras

#### Reglas de Negocio Específicas
- **Manejo de HNL**: `if (data($ingresoDataCapture/CURRENCY) = "HNL")` → AMOUNTLCY
- **Otras Monedas**: Cualquier moneda != HNL → CURRENCY + AMOUNTFCY
- **Narrativa**: División automática en líneas de 34 caracteres

### GT01 (Guatemala) - Configuración Implícita

#### Estado de Implementación
- **Implementación**: A través de configuración centralizada
- **Diferencias**: Códigos de transacción específicos via parametrización
- **Moneda**: Tratada como moneda extranjera (no HNL)
- **Endpoint**: Mismo endpoint T24 centralizado

#### Configuración Esperada
- **Códigos de Transacción**: Configurables via `T24T099.TXNCODEDR/CR`
- **Moneda Local**: Probablemente GTQ
- **LDAP Users**: Usuarios guatemaltecos en directorio de seguridad

### PA01 (Panamá) - Configuración Implícita

#### Estado de Implementación
- **Implementación**: A través de configuración centralizada
- **Diferencias**: Códigos de transacción específicos via parametrización
- **Moneda**: Tratada como moneda extranjera (no HNL)
- **Endpoint**: Mismo endpoint T24 centralizado

#### Configuración Esperada
- **Códigos de Transacción**: Configurables via `T24T099.TXNCODEDR/CR`
- **Moneda Local**: Probablemente PAB o USD
- **LDAP Users**: Usuarios panameños en directorio de seguridad

### NI01 (Nicaragua) - Configuración Implícita

#### Estado de Implementación
- **Implementación**: A través de configuración centralizada
- **Diferencias**: Códigos de transacción específicos via parametrización
- **Moneda**: Tratada como moneda extranjera (no HNL)
- **Endpoint**: Mismo endpoint T24 centralizado

#### Configuración Esperada
- **Códigos de Transacción**: Configurables via `T24T099.TXNCODEDR/CR`
- **Moneda Local**: Probablemente NIO
- **LDAP Users**: Usuarios nicaragüenses en directorio de seguridad

## Diferencias Identificadas

### Diferencias Principales
1. **Arquitectura Centralizada**: Una sola implementación que soporta múltiples regiones
2. **Diferenciación por Configuración**: Las diferencias regionales se manejan via parametrización
3. **Moneda Base**: HNL hardcodeada como moneda local, otras como extranjeras
4. **Códigos de Transacción**: Configurables por región via base de datos

### Diferencias Técnicas por Región
- **HN01**: Moneda HNL tratada especialmente como moneda local
- **GT01, PA01, NI01**: Todas las monedas no-HNL tratadas como extranjeras
- **Parametrización**: Códigos de transacción específicos por región

### Diferencias en Configuración
- **Endpoint Único**: Todas las regiones usan el mismo endpoint T24
- **Autenticación Centralizada**: Mismo mecanismo con usuarios específicos por región
- **Transformaciones Comunes**: Mismas transformaciones XQuery para todas las regiones

## Análisis de Impacto

### Impacto de Migración
1. **Implementación Única**: Migrar una sola implementación que soporta todas las regiones
2. **Configuración Regional**: Migrar configuraciones específicas por región
3. **Base de Datos**: Migrar parámetros de configuración regional

### Consideraciones de Diseño
1. **Mantenibilidad**: Arquitectura centralizada facilita mantenimiento
2. **Escalabilidad**: Fácil agregar nuevas regiones via configuración
3. **Flexibilidad**: Códigos de transacción configurables por región

## Recomendaciones

### Para Implementación Centralizada
1. Mantener arquitectura centralizada durante la migración
2. Validar configuraciones específicas por región
3. Documentar parámetros de configuración regional

### Para Diferenciación Regional
1. Considerar si se necesita lógica específica por región
2. Evaluar si el manejo de monedas debe ser más flexible
3. Implementar validaciones específicas por región si es necesario

### Para Configuración
1. Documentar todos los parámetros configurables por región
2. Implementar tests para validar configuraciones regionales
3. Crear herramientas de administración para configuraciones regionales