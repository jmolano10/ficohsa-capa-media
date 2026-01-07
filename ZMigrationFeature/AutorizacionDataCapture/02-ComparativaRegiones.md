# Comparación entre Regiones - AutorizacionDataCapture

## Tabla de Comparación Regional

| Aspecto | General (Centralizada) | HN01 (Honduras) | GT01 (Guatemala) | PA01 (Panamá) | NI01 (Nicaragua) |
|---------|------------------------|-----------------|------------------|---------------|------------------|
| **Endpoint OSB** | `/Middleware/OperationsAndExecution/CustomerDeposits/AutorizacionDataCapture` | Mismo endpoint | Mismo endpoint | Mismo endpoint | Mismo endpoint |
| **Nombre de Base de Datos** | No aplica (Web Service T24) | No aplica | No aplica | No aplica | No aplica |
| **Esquemas** | No aplica (Web Service T24) | No aplica | No aplica | No aplica | No aplica |
| **Store Procedure** | No aplica (Web Service T24) | No aplica | No aplica | No aplica | No aplica |
| **Nombre de Conexión a Base de datos u OSB** | DataCapture (T24 Web Service) | DataCapture | DataCapture | DataCapture | DataCapture |
| **Transformaciones clave** | autorizacionDataCaptureIn.xq, autorizacionDataCaptureOut.xq, autorizacionDataCaptureHeaderOut.xq | Mismas transformaciones | Mismas transformaciones | Mismas transformaciones | Mismas transformaciones |
| **Campos diferenciadores** | DATA_CAPTURE_ID (único campo de entrada) | Mismo campo | Mismo campo | Mismo campo | Mismo campo |
| **Errores/Excepciones** | Manejo estándar con pipeline de error | Mismo manejo | Mismo manejo | Mismo manejo | Mismo manejo |
| **Timeouts/Retrys** | No configurado explícitamente | Mismo | Mismo | Mismo | Mismo |
| **Dependencias internas** | DataCapture T24 Web Service | Misma dependencia | Misma dependencia | Misma dependencia | Misma dependencia |
| **Endpoint T24** | http://mwinterbanca:7003/svcDataCapture/services | Mismo endpoint | Mismo endpoint | Mismo endpoint | Mismo endpoint |
| **Autenticación** | Custom Token + LDAP Lookup | Mismo método | Mismo método | Mismo método | Mismo método |
| **Operación T24** | Autorizaciondedatacapture | Misma operación | Misma operación | Misma operación | Misma operación |
| **Namespace WSDL** | http://www.ficohsa.com.hn/middleware.services/autorizacionDataCapturePS/ | Mismo namespace | Mismo namespace | Mismo namespace | Mismo namespace |
| **Binding SOAP** | autorizacionDataCapturePSSOAP | Mismo binding | Mismo binding | Mismo binding | Mismo binding |
| **Validación** | DATA_CAPTURE_ID no vacío | Misma validación | Misma validación | Misma validación | Misma validación |

## Sección por Región

### General (Implementación Centralizada)

#### Endpoints y Configuración
- **Proxy Service**: `AutorizacionDataCapture.proxy`
- **URI Endpoint**: `/Middleware/OperationsAndExecution/CustomerDeposits/AutorizacionDataCapture`
- **WSDL**: `autorizacionDataCapturePS.wsdl`
- **Binding**: `autorizacionDataCapturePSSOAP`

#### Mapeos y Transformaciones
- **Request Validation**: `autorizacionDataCaptureValidation.xq` valida DATA_CAPTURE_ID
- **Request Mapping**: `autorizacionDataCaptureIn.xq` transforma OSB request a formato T24
- **Response Header Mapping**: `autorizacionDataCaptureHeaderOut.xq` mapea status y headers
- **Response Body Mapping**: `autorizacionDataCaptureOut.xq` extrae TRANSACTION_DATE

#### Validaciones y Políticas OSB
- **Custom Token Authentication**: Username/Password desde header
- **Schema Validation**: Validación automática de esquema SOAP
- **Business Validation**: Validación de DATA_CAPTURE_ID no vacío
- **Error Message**: "REQUIRED FILEDS NOT SUPPLIED" (typo en código original)

#### Handlers y Configuración
- **Error Handler**: Pipeline de error personalizado con manejo de faults
- **Security**: Custom token authentication con lookup LDAP
- **Monitoring**: Habilitado con agregación cada 10 segundos
- **Logging**: Debug level habilitado
- **Throttling**: Deshabilitado

#### Business Service Interno
- **DataCapture**
  - **Endpoint**: `http://mwinterbanca:7003/svcDataCapture/services`
  - **Tipo**: T24 Web Service
  - **Operación**: `Autorizaciondedatacapture`
  - **Timeout**: No configurado explícitamente

#### Logging y Auditoría
- **Request Logging**: Logging básico a nivel debug
- **Response Logging**: Logging de respuestas exitosas y errores
- **Error Logging**: Pipeline de error con detalles de fault
- **Monitoring**: SLA alerting y pipeline alerting habilitados

### HN01 (Honduras) - Configuración Específica

#### Diferencias Identificadas
- **Sin Diferencias Específicas**: La funcionalidad es agnóstica a la región
- **LDAP Security**: Directorio `Middleware/Security/` con usuarios hondureños
- **Endpoint T24**: Apunta al servidor T24 centralizado

#### Reglas de Negocio Específicas
- **Autorización Simple**: Solo requiere DATA_CAPTURE_ID para autorizar
- **Respuesta Uniforme**: TRANSACTION_DATE extraído de VALUEDATE de T24
- **Sin Lógica Regional**: No hay diferenciación por región en el procesamiento

### GT01 (Guatemala) - Configuración Implícita

#### Estado de Implementación
- **Implementación**: A través de configuración centralizada
- **Sin Diferencias**: Misma lógica que otras regiones
- **Endpoint**: Mismo endpoint T24 centralizado

#### Configuración Esperada
- **LDAP Users**: Usuarios guatemaltecos en directorio de seguridad
- **Autorización**: Misma lógica de autorización que otras regiones

### PA01 (Panamá) - Configuración Implícita

#### Estado de Implementación
- **Implementación**: A través de configuración centralizada
- **Sin Diferencias**: Misma lógica que otras regiones
- **Endpoint**: Mismo endpoint T24 centralizado

#### Configuración Esperada
- **LDAP Users**: Usuarios panameños en directorio de seguridad
- **Autorización**: Misma lógica de autorización que otras regiones

### NI01 (Nicaragua) - Configuración Implícita

#### Estado de Implementación
- **Implementación**: A través de configuración centralizada
- **Sin Diferencias**: Misma lógica que otras regiones
- **Endpoint**: Mismo endpoint T24 centralizado

#### Configuración Esperada
- **LDAP Users**: Usuarios nicaragüenses en directorio de seguridad
- **Autorización**: Misma lógica de autorización que otras regiones

## Diferencias Identificadas

### Diferencias Principales
1. **Sin Diferencias Regionales**: La funcionalidad es completamente uniforme entre regiones
2. **Arquitectura Centralizada**: Una sola implementación que soporta todas las regiones
3. **Lógica Agnóstica**: No hay lógica específica por región o moneda
4. **Autorización Universal**: El proceso de autorización es idéntico para todas las regiones

### Diferencias Técnicas por Región
- **Ninguna**: Todas las regiones usan exactamente la misma implementación
- **LDAP Users**: Solo diferencia en usuarios específicos por región en directorio LDAP
- **Endpoint Único**: Todas las regiones usan el mismo endpoint T24

### Diferencias en Configuración
- **Endpoint Único**: Todas las regiones usan el mismo endpoint T24
- **Autenticación Centralizada**: Mismo mecanismo con usuarios específicos por región
- **Transformaciones Comunes**: Mismas transformaciones XQuery para todas las regiones

## Análisis de Impacto

### Impacto de Migración
1. **Implementación Única**: Migrar una sola implementación que soporta todas las regiones
2. **Sin Configuración Regional**: No hay configuraciones específicas por región que migrar
3. **Dependencia Única**: Solo migrar la dependencia al servicio T24

### Consideraciones de Diseño
1. **Simplicidad**: Arquitectura muy simple y uniforme
2. **Mantenibilidad**: Fácil mantenimiento al tener una sola implementación
3. **Escalabilidad**: Fácil agregar nuevas regiones sin cambios de código

## Recomendaciones

### Para Implementación Centralizada
1. Mantener arquitectura centralizada durante la migración
2. Validar que el endpoint T24 sea accesible desde todas las regiones
3. Verificar configuraciones LDAP por región

### Para Diferenciación Regional
1. **No Requerida**: La funcionalidad no requiere diferenciación regional
2. **Validar Permisos**: Considerar si se necesitan validaciones de permisos por región
3. **Auditoría Regional**: Considerar logging específico por región si es necesario

### Para Configuración
1. **Corregir Typo**: Corregir "REQUIRED FILEDS NOT SUPPLIED" en el código
2. **Documentar Uniformidad**: Documentar que la funcionalidad es uniforme entre regiones
3. **Validar Conectividad**: Asegurar que todas las regiones puedan acceder al servicio T24

### Para Mejoras Futuras
1. **Validaciones Adicionales**: Considerar validaciones específicas por región si es necesario
2. **Métricas por Región**: Implementar métricas de autorización por región
3. **Configuración Flexible**: Preparar para futuras diferenciaciones regionales si son necesarias

## Conclusiones

La funcionalidad **AutorizacionDataCapture** presenta una arquitectura completamente centralizada y uniforme entre regiones:

### Fortalezas
- **Simplicidad**: Implementación muy simple y directa
- **Uniformidad**: Comportamiento consistente entre regiones
- **Mantenibilidad**: Fácil de mantener y actualizar

### Consideraciones
- **Flexibilidad Limitada**: Poca flexibilidad para diferenciaciones futuras
- **Validaciones Básicas**: Solo validación mínima de entrada
- **Dependencia Única**: Dependencia completa del servicio T24

### Recomendaciones de Migración
1. **Migración Directa**: Migrar como una sola unidad funcional
2. **Validar Conectividad**: Asegurar acceso T24 desde todas las regiones
3. **Mantener Simplicidad**: No agregar complejidad innecesaria durante la migración