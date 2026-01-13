# Listado de Ficheros - IngresoDataCapture

## Archivos Principales de la Funcionalidad

### Proxy Services
- `Middleware/OperationsAndExecution/CustomerDeposits/IngresoDataCapture.proxy`
  - **Tipo**: OSB Proxy Service
  - **Función**: Punto de entrada SOAP para la funcionalidad IngresoDataCapture
  - **Binding**: SOAP 1.1 con WSDL
  - **URI**: `/Middleware/OperationsAndExecution/CustomerDeposits/IngresoDataCapture`
  - **Autenticación**: Custom Token Authentication

### WSDL y Contratos
- `Middleware/Business_Resources/dataCapture/IngresoDataCapture/ingresoDataCapturePS.wsdl`
  - **Tipo**: WSDL Contract
  - **Función**: Definición del contrato SOAP
  - **Namespace**: `http://www.ficohsa.com.hn/middleware.services/ingresoDataCapturePS/`
  - **Operations**: ingresoDataCapture
  - **Binding**: ingresoDataCapturePSSOAP

### Esquemas XSD
- `Middleware/Business_Resources/dataCapture/IngresoDataCapture/ingresoDataCaptureTypes.xsd`
  - **Tipo**: XML Schema Definition
  - **Función**: Definición de tipos para request y response OSB
  - **Namespace**: `http://www.ficohsa.com.hn/middleware.services/ingresoDataCaptureTypes`
  - **Elements**: ingresoDataCapture, ingresoDataCaptureResponse

### Transformaciones XQuery
- `Middleware/Business_Resources/dataCapture/IngresoDataCapture/ingresoDataCaptureValidateRequired.xq`
  - **Tipo**: XQuery Validation
  - **Función**: Validación de campos requeridos y valores permitidos
  - **Input**: ingresoDataCapture element
  - **Output**: boolean (true/false)

- `Middleware/Business_Resources/dataCapture/IngresoDataCapture/ingresoDataCaptureIn.xq`
  - **Tipo**: XQuery Transformation
  - **Función**: Transformación del request OSB a formato T24
  - **Input**: AutenticacionRequestHeader, ingresoDataCapture, códigos de transacción, UUID
  - **Output**: IngresodeDataCapture (formato T24)

- `Middleware/Business_Resources/dataCapture/IngresoDataCapture/ingresoDataCaptureOut.xq`
  - **Tipo**: XQuery Transformation
  - **Función**: Transformación del response T24 a formato OSB
  - **Input**: IngresodeDataCaptureResponse (T24)
  - **Output**: ingresoDataCaptureResponse (OSB)

- `Middleware/Business_Resources/dataCapture/IngresoDataCapture/ingresoDataCaptureHeaderOut.xq`
  - **Tipo**: XQuery Transformation
  - **Función**: Transformación del header de respuesta T24 a OSB
  - **Input**: IngresodeDataCaptureResponse (T24)
  - **Output**: ResponseHeader (OSB)

## Business Services Dependientes

### Servicio de Parametrización
- `Middleware/Business_Resources/general/Resources/ObtenerParametrizacion/ObtenerParametrizacion.biz`
  - **Tipo**: OSB Business Service (Database)
  - **Función**: Obtener parámetros de configuración desde base de datos
  - **Operations**: obtenerParametrizacion
  - **Database**: ORA_BANK
  - **Schema**: OSB_GET_CONFIG

- `Middleware/Business_Resources/general/Resources/ObtenerParametrizacion/obtenerParametrizacion_db.wsdl`
  - **Tipo**: WSDL para Database Adapter
  - **Función**: Definición de operaciones de base de datos
  - **JCA**: obtenerParametrizacion_db.jca

- `Middleware/Business_Resources/general/Resources/ObtenerParametrizacion/obtenerParametrizacion_db.jca`
  - **Tipo**: JCA Database Adapter
  - **Función**: Configuración de conexión a base de datos
  - **Database**: ORA_BANK
  - **Schema**: OSB_GET_CONFIG

### Servicio T24 DataCapture
- `Middleware/Business_Resources/dataCapture/Resources/DataCapture.biz`
  - **Tipo**: OSB Business Service (SOAP)
  - **Función**: Conexión al servicio T24 Web Services
  - **Endpoint**: `http://mwinterbanca:7003/svcDataCapture/services`
  - **Operations**: IngresodeDataCapture, Autorizaciondedatacapture, Reversiondedatacapture

- `Middleware/Business_Resources/dataCapture/Resources/DataCapture.wsdl`
  - **Tipo**: WSDL para T24 Web Service
  - **Función**: Definición de operaciones T24
  - **Namespace**: `T24WebServicesImpl`
  - **Port**: T24WebServicesImplPort

## Esquemas XSD de T24

### Esquemas de Tipos T24
- `Middleware/Business_Resources/dataCapture/Resources/XMLSchema_-987790958.xsd`
  - **Tipo**: XML Schema Definition
  - **Función**: Definición de tipos para T24 Web Services
  - **Namespace**: `T24WebServicesImpl`
  - **Elements**: IngresodeDataCapture, IngresodeDataCaptureResponse, DATACAPTUREINPUTWSType, DATACAPTUREType

- `Middleware/Business_Resources/dataCapture/Resources/XMLSchema_-694387951.xsd`
  - **Tipo**: XML Schema Definition
  - **Función**: Definición de tipos array para JAX-WS
  - **Namespace**: `http://jaxb.dev.java.net/array`
  - **Elements**: anyTypeArray

### Esquemas de Base de Datos
- `Middleware/Business_Resources/general/Resources/ObtenerParametrizacion/xsd/ORA_BANK_OSB_GET_CONFIG.xsd`
  - **Tipo**: XML Schema Definition
  - **Función**: Definición de tipos para adapter de base de datos
  - **Namespace**: `http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_GET_CONFIG/`
  - **Elements**: obtenerParametrizacion, obtenerParametrizacionResponse

## Transformaciones XQuery de Utilidad

### Transformaciones de Parametrización
- `Middleware/Business_Resources/general/Parametrizacion/obtenerParametrizacionIn.xq`
  - **Tipo**: XQuery Transformation
  - **Función**: Transformación para request de parametrización
  - **Input**: nombreParametros string
  - **Output**: obtenerParametrizacion request

### Transformaciones de UUID
- `Middleware/Business_Resources/general/UUID/obtenerUUID`
  - **Tipo**: XQuery Transformation
  - **Función**: Generación de identificadores únicos
  - **Input**: Ninguno
  - **Output**: UUID string

## Esquemas Comunes

### Esquemas de Headers
- `Middleware/Business_Resources/esquemas_generales/HeaderElements.xsd`
  - **Tipo**: XML Schema Definition
  - **Función**: Definición de headers comunes (AutenticacionRequestHeader, ResponseHeader)
  - **Namespace**: `http://www.ficohsa.com.hn/middleware.services/autType`
  - **Elements**: AutenticacionRequestHeader, ResponseHeader

## Archivos de Configuración y Políticas

### Configuraciones OSB
- Configuraciones de timeout y retry en DataCapture.biz
- Configuraciones de monitoring y logging en IngresoDataCapture.proxy
- Configuraciones de custom token authentication en IngresoDataCapture.proxy
- Configuraciones de throttling y message tracing

### Configuraciones de Base de Datos
- JCA adapter configuration en obtenerParametrizacion_db.jca
- Database connection settings
- Schema mappings para ORA_BANK.OSB_GET_CONFIG

## Servicios Relacionados (Misma Familia)

### Otros Servicios DataCapture
- `Middleware/OperationsAndExecution/CustomerDeposits/AutorizacionDataCapture.proxy`
  - **Función**: Autorización de transacciones DataCapture
  - **Relación**: Mismo dominio de negocio

- `Middleware/OperationsAndExecution/CustomerDeposits/ReversionDataCapture.proxy`
  - **Función**: Reversión de transacciones DataCapture
  - **Relación**: Mismo dominio de negocio

### Transformaciones Relacionadas
- `Middleware/Business_Resources/dataCapture/AutorizacionDataCapture/autorizacionDataCaptureIn.xq`
- `Middleware/Business_Resources/dataCapture/AutorizacionDataCapture/autorizacionDataCaptureOut.xq`
- `Middleware/Business_Resources/dataCapture/AutorizacionDataCapture/autorizacionDataCaptureHeaderOut.xq`
- `Middleware/Business_Resources/dataCapture/AutorizacionDataCapture/autorizacionDataCaptureValidation.xq`

- `Middleware/Business_Resources/dataCapture/ReversionDataCapture/reversionDataCaptureIn.xq`
- `Middleware/Business_Resources/dataCapture/ReversionDataCapture/reversionDataCaptureOut.xq`
- `Middleware/Business_Resources/dataCapture/ReversionDataCapture/reversionDataCaptureHeaderOut.xq`
- `Middleware/Business_Resources/dataCapture/ReversionDataCapture/reversionDataCaptureValidation.xq`

### Esquemas Relacionados
- `Middleware/Business_Resources/dataCapture/AutorizacionDataCapture/autorizacionDataCaptureTypes.xsd`
- `Middleware/Business_Resources/dataCapture/AutorizacionDataCapture/autorizacionDataCapturePS.wsdl`
- `Middleware/Business_Resources/dataCapture/ReversionDataCapture/reversionDataCaptureTypes.xsd`
- `Middleware/Business_Resources/dataCapture/ReversionDataCapture/reversionDataCapturePS.wsdl`

## Tests y Validación

### Tests Relevantes
- **No se encontraron archivos de test específicos** para la funcionalidad IngresoDataCapture
- **Recomendación**: Crear tests unitarios y de integración para validar la funcionalidad

## Archivos de Configuración del Entorno

### Propiedades y Configuración
- **Configuración embebida** en los archivos .biz y .proxy
- **Parámetros de base de datos** configurados via JCA adapters
- **Endpoints** configurados directamente en business services

### Configuraciones de Seguridad
- **LDAP Lookup**: Directorio `Middleware/Security/{USERNAME}`
- **Custom Token Authentication**: Configurado en proxy service
- **Credenciales T24**: Mapeadas via LDAP o fallback a originales

## Resumen de Rutas por Tipo

### Estructura de Directorios
```
Middleware/
├── OperationsAndExecution/CustomerDeposits/
│   ├── IngresoDataCapture.proxy
│   ├── AutorizacionDataCapture.proxy
│   └── ReversionDataCapture.proxy
├── Business_Resources/
│   ├── dataCapture/
│   │   ├── IngresoDataCapture/
│   │   │   ├── ingresoDataCapturePS.wsdl
│   │   │   ├── ingresoDataCaptureTypes.xsd
│   │   │   ├── ingresoDataCaptureValidateRequired.xq
│   │   │   ├── ingresoDataCaptureIn.xq
│   │   │   ├── ingresoDataCaptureOut.xq
│   │   │   └── ingresoDataCaptureHeaderOut.xq
│   │   ├── AutorizacionDataCapture/
│   │   ├── ReversionDataCapture/
│   │   └── Resources/
│   │       ├── DataCapture.biz
│   │       ├── DataCapture.wsdl
│   │       ├── XMLSchema_-987790958.xsd
│   │       └── XMLSchema_-694387951.xsd
│   ├── general/
│   │   ├── Resources/ObtenerParametrizacion/
│   │   │   ├── ObtenerParametrizacion.biz
│   │   │   ├── obtenerParametrizacion_db.wsdl
│   │   │   ├── obtenerParametrizacion_db.jca
│   │   │   └── xsd/ORA_BANK_OSB_GET_CONFIG.xsd
│   │   ├── Parametrizacion/
│   │   │   └── obtenerParametrizacionIn.xq
│   │   └── UUID/
│   │       └── obtenerUUID
│   └── esquemas_generales/
│       └── HeaderElements.xsd
```

## Total de Archivos Identificados

### Por Categoría
- **Archivos principales**: 5 (proxy, wsdl, xsd, transformaciones)
- **Business Services**: 2 (ObtenerParametrizacion, DataCapture)
- **Esquemas XSD**: 4 (tipos OSB, tipos T24, tipos DB, headers)
- **Transformaciones XQuery**: 6 (validación, mapeos, utilidades)
- **Archivos de configuración**: 2 (JCA adapter, configuraciones)
- **Servicios relacionados**: 6 (AutorizacionDataCapture, ReversionDataCapture)

**Total**: 25 archivos directamente relacionados con la funcionalidad IngresoDataCapture

### Archivos Críticos para Migración
1. **IngresoDataCapture.proxy** - Proxy service principal
2. **ingresoDataCaptureIn.xq** - Transformación principal de request
3. **DataCapture.biz** - Business service T24
4. **ObtenerParametrizacion.biz** - Servicio de configuración
5. **ingresoDataCaptureTypes.xsd** - Esquema de tipos OSB
6. **XMLSchema_-987790958.xsd** - Esquema de tipos T24

### Dependencias Externas
- **Base de datos**: ORA_BANK.OSB_GET_CONFIG
- **T24 Web Service**: http://mwinterbanca:7003/svcDataCapture/services
- **LDAP Directory**: Middleware/Security/{USERNAME}
- **UUID Generator**: Servicio de generación de identificadores únicos