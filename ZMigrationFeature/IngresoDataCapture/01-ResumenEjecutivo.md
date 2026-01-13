# Resumen Ejecutivo - IngresoDataCapture

## Índice de Documentación

1. [Resumen Ejecutivo](01-ResumenEjecutivo.md)
2. [Comparación entre Regiones](02-ComparativaRegiones.md)
3. [Ejemplos y Mapeos - General](03-EjemplosYMapeos-General.md)
4. [Diagrama de Secuencia - General](04-Secuencia-General.mmd)
5. [Diagrama de Flujo Multiregión](05-FlujoMultiregión.mmd)
6. [Listado de Ficheros](06-ListadoFicheros.md)

## Propósito de la Funcionalidad

La funcionalidad **IngresoDataCapture** es un servicio OSB que permite realizar el ingreso de transacciones de Data Capture en el sistema bancario T24. Este servicio actúa como un proxy SOAP que recibe solicitudes de ingreso de transacciones contables y las procesa a través del sistema T24 Web Services, permitiendo registrar movimientos de débito y crédito con información detallada de cuentas, montos, narrativas y categorías.

## Entradas y Salidas Principales

### Entrada (Request)
- **Protocolo**: SOAP/HTTP
- **Namespace**: `http://www.ficohsa.com.hn/middleware.services/ingresoDataCapturePS/`
- **Elemento**: `ingresoDataCapture`
- **Campos principales**:
  - `BATCH_ID` (requerido): Identificador del lote
  - `DEPARTMENT_CODE` (opcional): Código de departamento
  - `ACCOUNT_NUMBER` (opcional): Número de cuenta
  - `CURRENCY` (requerido): Código de moneda
  - `AMOUNT` (requerido): Monto de la transacción
  - `DEBIT_CREDIT` (requerido): Tipo de transacción ("DEBIT" o "CREDIT")
  - `DESCRIPTION` (requerido): Descripción de la transacción
  - `VALUE_DATE` (opcional): Fecha valor
  - `PROFIT_CENTER` (opcional): Centro de beneficio
  - `PROFIT_LOSS_CATEGORY` (opcional): Categoría de pérdidas y ganancias
  - `PRODUCT_CATEGORY` (opcional): Categoría de producto

### Salida (Response)
- **Protocolo**: SOAP/HTTP
- **Namespace**: `http://www.ficohsa.com.hn/middleware.services/ingresoDataCaptureTypes`
- **Elemento**: `ingresoDataCaptureResponse`
- **Campos**:
  - `RECORD_STATUS`: Estado del registro procesado

## Sistemas/Servicios OSB Involucrados

### Proxy Service
- **Nombre**: `IngresoDataCapture`
- **Ubicación**: `/Middleware/OperationsAndExecution/CustomerDeposits/IngresoDataCapture`
- **Tipo**: SOAP Proxy Service
- **WSDL**: `Middleware/Business_Resources/dataCapture/IngresoDataCapture/ingresoDataCapturePS`
- **Autenticación**: Custom Token Authentication (Username/Password)

### Business Services Dependientes
1. **ObtenerParametrizacion**
   - **Ubicación**: `Middleware/Business_Resources/general/Resources/ObtenerParametrizacion/ObtenerParametrizacion`
   - **Función**: Obtener códigos de transacción para débito y crédito
   - **Operación**: `obtenerParametrizacion`

2. **DataCapture**
   - **Ubicación**: `Middleware/Business_Resources/dataCapture/Resources/DataCapture`
   - **Función**: Servicio principal para procesar transacciones T24
   - **Operación**: `IngresodeDataCapture`
   - **Endpoint**: `http://mwinterbanca:7003/svcDataCapture/services`

### Transformaciones XQuery
- **ingresoDataCaptureValidateRequired.xq**: Validación de campos requeridos
- **ingresoDataCaptureIn.xq**: Transformación del request OSB a formato T24
- **ingresoDataCaptureOut.xq**: Transformación de la respuesta T24 a formato OSB
- **ingresoDataCaptureHeaderOut.xq**: Transformación del header de respuesta

### Servicios de Utilidad
- **obtenerUUID**: Generación de identificadores únicos para transacciones
- **Lookup de credenciales**: Mapeo de usuarios LDAP a credenciales T24

## Riesgos/Limitaciones Conocidas

### Riesgos Identificados
1. **Dependencia de T24**: El servicio depende completamente del sistema T24 Web Services
2. **Autenticación Personalizada**: Utiliza autenticación custom token que puede ser vulnerable
3. **Sin Timeout Configurado**: Timeout configurado en 0 (sin límite) puede causar bloqueos
4. **Validaciones Limitadas**: Solo valida campos requeridos básicos
5. **Región Única**: Implementación centralizada sin diferenciación regional explícita

### Limitaciones Técnicas
1. **Sin Retry Automático**: No tiene configuración de reintentos automáticos (retry-count: 0)
2. **Manejo de Errores Básico**: Manejo de errores simplificado sin categorización detallada
3. **Logging Limitado**: Solo logging básico habilitado a nivel debug
4. **Validación de Moneda**: Lógica hardcodeada para HNL vs otras monedas

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
- **Result Caching**: Habilitado pero no soportado
- **Timeout**: 0 segundos (sin límite)
- **Connection Timeout**: 0 segundos (sin límite)

### Parámetros de Configuración
- **Códigos de Transacción**: 
  - Débito: `T24T099.TXNCODEDR`
  - Crédito: `T24T099.TXNCODECR`
- **Longitud de Narrativa**: Máximo 34 caracteres por línea
- **Moneda Local**: HNL (Lempira Hondureña)

## Arquitectura Regional

La funcionalidad está implementada de manera **centralizada** sin diferenciación regional explícita. Sin embargo, se identifican los siguientes aspectos:

### Configuración Regional Implícita
- **Endpoint T24**: `http://mwinterbanca:7003/svcDataCapture/services`
- **Moneda Base**: HNL (Honduras)
- **Códigos de Transacción**: Configurables por región a través de parametrización
- **Usuarios LDAP**: Mapeo por región a través del directorio `Middleware/Security/`

### Regiones Detectadas
Basado en el análisis del código y estructura:
- **General**: Implementación centralizada que soporta múltiples regiones
- **HN01**: Honduras (región principal identificada por moneda HNL)
- **GT01, PA01, NI01**: Potencialmente soportadas a través de parametrización

## Estado de Implementación

- **Implementación Central**: ✅ Completamente implementada
- **Diferenciación Regional**: ⚠️ A través de parametrización, no por código específico
- **Soporte Multi-región**: ✅ Soportado a través de configuración

## Recomendaciones

1. **Implementar Timeouts**: Configurar timeouts apropiados para evitar bloqueos
2. **Mejorar Autenticación**: Considerar autenticación más robusta que custom token
3. **Configurar Retry**: Habilitar reintentos automáticos para mayor resiliencia
4. **Optimizar Logging**: Implementar logging estructurado y niveles apropiados
5. **Documentar Configuraciones**: Documentar todos los parámetros de configuración