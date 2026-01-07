# Resumen Ejecutivo - AutorizacionDataCapture

## Índice de Documentación

1. [Resumen Ejecutivo](01-ResumenEjecutivo.md)
2. [Comparación entre Regiones](02-ComparativaRegiones.md)
3. [Ejemplos y Mapeos - General](03-EjemplosYMapeos-General.md)
4. [Diagrama de Secuencia - General](04-Secuencia-General.mmd)
5. [Diagrama de Flujo Multiregión](05-FlujoMultiregión.mmd)
6. [Listado de Ficheros](06-ListadoFicheros.md)

## Propósito de la Funcionalidad

La funcionalidad **AutorizacionDataCapture** es un servicio OSB que permite autorizar transacciones de Data Capture previamente ingresadas en el sistema bancario T24. Este servicio actúa como un proxy SOAP que recibe solicitudes de autorización de transacciones contables y las procesa a través del sistema T24 Web Services, permitiendo completar el flujo de aprobación de movimientos de débito y crédito que requieren autorización adicional.

## Entradas y Salidas Principales

### Entrada (Request)
- **Protocolo**: SOAP/HTTP
- **Namespace**: `http://www.ficohsa.com.hn/middleware.services/autorizacionDataCapturePS/`
- **Elemento**: `autorizacionDataCapture`
- **Campos principales**:
  - `DATA_CAPTURE_ID` (requerido): Identificador de la transacción DataCapture a autorizar

### Salida (Response)
- **Protocolo**: SOAP/HTTP
- **Namespace**: `http://www.ficohsa.com.hn/middleware.services/autorizacionDataCaptureTypes`
- **Elemento**: `autorizacionDataCaptureResponse`
- **Campos**:
  - `TRANSACTION_DATE`: Fecha de la transacción autorizada

## Sistemas/Servicios OSB Involucrados

### Proxy Service
- **Nombre**: `AutorizacionDataCapture`
- **Ubicación**: `/Middleware/OperationsAndExecution/CustomerDeposits/AutorizacionDataCapture`
- **Tipo**: SOAP Proxy Service
- **WSDL**: `Middleware/Business_Resources/dataCapture/AutorizacionDataCapture/autorizacionDataCapturePS`
- **Autenticación**: Custom Token Authentication (Username/Password)

### Business Service Dependiente
- **DataCapture**
  - **Ubicación**: `Middleware/Business_Resources/dataCapture/Resources/DataCapture`
  - **Función**: Servicio principal para procesar autorizaciones T24
  - **Operación**: `Autorizaciondedatacapture`
  - **Endpoint**: `http://mwinterbanca:7003/svcDataCapture/services`

### Transformaciones XQuery
- **autorizacionDataCaptureValidation.xq**: Validación de campos requeridos
- **autorizacionDataCaptureIn.xq**: Transformación del request OSB a formato T24
- **autorizacionDataCaptureOut.xq**: Transformación de la respuesta T24 a formato OSB
- **autorizacionDataCaptureHeaderOut.xq**: Transformación del header de respuesta

### Servicios de Utilidad
- **Lookup de credenciales**: Mapeo de usuarios LDAP a credenciales T24

## Riesgos/Limitaciones Conocidas

### Riesgos Identificados
1. **Dependencia de T24**: El servicio depende completamente del sistema T24 Web Services
2. **Autenticación Personalizada**: Utiliza autenticación custom token que puede ser vulnerable
3. **Sin Timeout Configurado**: No se especifican timeouts explícitos
4. **Validación Mínima**: Solo valida que DATA_CAPTURE_ID no esté vacío
5. **Región Única**: Implementación centralizada sin diferenciación regional explícita

### Limitaciones Técnicas
1. **Funcionalidad Limitada**: Solo autoriza transacciones existentes, no las crea
2. **Manejo de Errores Básico**: Manejo de errores simplificado sin categorización detallada
3. **Logging Limitado**: Solo logging básico habilitado a nivel debug
4. **Sin Retry Automático**: No tiene configuración de reintentos automáticos

## Métricas o SLAs

### Configuración de Monitoreo
- **Monitoring**: Habilitado con intervalo de agregación de 10 segundos
- **Pipeline Monitoring**: Nivel Pipeline
- **Logging**: Habilitado a nivel debug
- **SLA Alerting**: Habilitado con nivel normal
- **Pipeline Alerting**: Habilitado con nivel normal

### Configuración de Rendimiento
- **Throttling**: Deshabilitado
- **Message Tracing**: Deshabilitado
- **Result Caching**: No especificado
- **Timeout**: No configurado explícitamente
- **Connection Timeout**: No configurado explícitamente

### Parámetros de Configuración
- **Campo Requerido**: DATA_CAPTURE_ID (identificador de transacción)
- **Operación T24**: Autorizaciondedatacapture
- **Tipo de Respuesta**: TRANSACTION_DATE (fecha de autorización)

## Arquitectura Regional

La funcionalidad está implementada de manera **centralizada** sin diferenciación regional explícita, similar a IngresoDataCapture:

### Configuración Regional Implícita
- **Endpoint T24**: `http://mwinterbanca:7003/svcDataCapture/services`
- **Usuarios LDAP**: Mapeo por región a través del directorio `Middleware/Security/`
- **Operación Centralizada**: Una sola operación que soporta múltiples regiones

### Regiones Detectadas
Basado en el análisis del código y estructura:
- **General**: Implementación centralizada que soporta múltiples regiones
- **HN01, GT01, PA01, NI01**: Potencialmente soportadas a través de la misma implementación

## Estado de Implementación

- **Implementación Central**: ✅ Completamente implementada
- **Diferenciación Regional**: ⚠️ No requiere diferenciación específica por región
- **Soporte Multi-región**: ✅ Soportado a través de implementación única

## Reglas de Negocio Principales

### Validaciones de Entrada
1. **Campo Requerido**: DATA_CAPTURE_ID no puede estar vacío
2. **Mensaje de Error**: "REQUIRED FILEDS NOT SUPPLIED" (nota: typo en el código original)

### Lógica de Procesamiento
1. **Mapeo Simple**: DATA_CAPTURE_ID → transactionId en T24
2. **Credenciales**: Lookup LDAP con fallback a credenciales originales
3. **Respuesta**: Extracción de VALUEDATE como TRANSACTION_DATE

### Manejo de Credenciales
1. **Lookup LDAP**: Intento de obtener credenciales desde directorio LDAP
2. **Fallback**: Uso de credenciales originales si lookup falla
3. **Seguridad**: Credenciales almacenadas en `Middleware/Security/{USERNAME}`

## Flujo de Procesamiento

### Flujo Principal
1. **Validación**: Verificar que DATA_CAPTURE_ID no esté vacío
2. **Transformación**: Mapear request OSB a formato T24
3. **Invocación**: Llamar a T24 Web Service para autorizar
4. **Respuesta**: Transformar respuesta T24 a formato OSB

### Flujo de Error
1. **Error de Validación**: Retornar error con mensaje específico
2. **Error de Sistema**: Capturar fault y retornar error con código y razón
3. **Respuesta Vacía**: Retornar response vacío en caso de error

## Relación con Otras Funcionalidades

### Funcionalidades Relacionadas
- **IngresoDataCapture**: Crea las transacciones que luego autoriza este servicio
- **ReversionDataCapture**: Permite revertir transacciones autorizadas
- **Flujo Completo**: Ingreso → Autorización → (Opcional) Reversión

### Dependencias Compartidas
- **DataCapture Business Service**: Servicio T24 compartido
- **LDAP Security**: Mismo mecanismo de autenticación
- **Esquemas T24**: Mismos tipos de datos y estructuras

## Recomendaciones

### Mejoras de Funcionalidad
1. **Validaciones Adicionales**: Implementar validaciones más robustas del DATA_CAPTURE_ID
2. **Información de Respuesta**: Incluir más información en la respuesta (estado, detalles)
3. **Manejo de Estados**: Validar que la transacción esté en estado autorizable

### Mejoras de Seguridad
1. **Timeouts**: Configurar timeouts apropiados para evitar bloqueos
2. **Validación de Autorización**: Verificar permisos del usuario para autorizar
3. **Auditoría**: Implementar logging detallado de autorizaciones

### Mejoras de Rendimiento
1. **Configurar Retry**: Habilitar reintentos automáticos para mayor resiliencia
2. **Message Tracing**: Habilitar para troubleshooting en ambientes de desarrollo
3. **Caching**: Considerar caching de respuestas si es apropiado

### Mejoras de Mantenibilidad
1. **Corregir Typo**: Corregir "REQUIRED FILEDS NOT SUPPLIED" → "REQUIRED FIELDS NOT SUPPLIED"
2. **Documentar Flujo**: Documentar el flujo completo de DataCapture
3. **Tests Automatizados**: Implementar tests unitarios y de integración
4. **Monitoreo de Negocio**: Implementar métricas específicas de autorizaciones