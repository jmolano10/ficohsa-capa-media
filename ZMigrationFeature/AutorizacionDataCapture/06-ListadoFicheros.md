# Listado de Ficheros - AutorizacionDataCapture

## Archivos Principales de la Funcionalidad

### Proxy Services
- `Middleware/OperationsAndExecution/CustomerDeposits/AutorizacionDataCapture.proxy`
  - **Tipo**: OSB Proxy Service
  - **Función**: Punto de entrada SOAP para la funcionalidad AutorizacionDataCapture
  - **Binding**: SOAP 1.1 con WSDL
  - **URI**: `/Middleware/OperationsAndExecution/CustomerDeposits/AutorizacionDataCapture`
  - **Autenticación**: Custom Token Authentication

### WSDL y Contratos
- `Middleware/Business_Resources/dataCapture/AutorizacionDataCapture/autorizacionDataCapturePS.wsdl`
  - **Tipo**: WSDL Contract
  - **Función**: Definición del contrato SOAP
  - **Namespace**: `http://www.ficohsa.com.hn/middleware.services/autorizacionDataCapturePS/`
  - **Operations**: autorizacionDataCapture
  - **Binding**: autorizacionDataCapturePSSOAP

### Esquemas XSD
- `Middleware/Business_Resources/dataCapture/AutorizacionDataCapture/autorizacionDataCaptureTypes.xsd`
  - **Tipo**: XML Schema Definition
  - **Función**: Definición de tipos para request y response OSB
  - **Namespace**: `http://www.ficohsa.com.hn/middleware.services/autorizacionDataCaptureTypes`
  - **Elements**: autorizacionDataCapture, autorizacionDataCaptureResponse

### Transformaciones XQuery
- `Middleware/Business_Resources/dataCapture/AutorizacionDataCapture/autorizacionDataCaptureValidation.xq`
  - **Tipo**: XQuery Validation
  - **Función**: Validación de campo requerido DATA_CAPTURE_ID
  - **Input**: autorizacionDataCapture element
  - **Output**: string (mensaje de error o vacío)

- `Middleware/Business_Resources/dataCapture/AutorizacionDataCapture/autorizacionDataCaptureIn.xq`
  - **Tipo**: XQuery Transformation
  - **Función**: Transformación del request OSB a formato T24
  - **Input**: AutenticacionRequestHeader, autorizacionDataCapture
  - **Output**: Autorizaciondedatacapture (formato T24)

- `Middleware/Business_Resources/dataCapture/AutorizacionDataCapture/autorizacionDataCaptureOut.xq`
  - **Tipo**: XQuery Transformation
  - **Función**: Transformación del response T24 a formato OSB
  - **Input**: AutorizaciondedatacaptureResponse (T24)
  - **Output**: autorizacionDataCaptureResponse (OSB)

- `Middleware/Business_Resources/dataCapture/AutorizacionDataCapture/autorizacionDataCaptureHeaderOut.xq`
  - **Tipo**: XQuery Transformation
  - **Función**: Transformación del header de respuesta T24 a OSB
  - **Input**: AutorizaciondedatacaptureResponse (T24)
  - **Output**: ResponseHeader (OSB)

## Business Services Dependientes

### Servicio T24 DataCapture (Compartido)
- `Middleware/Business_Resources/dataCapture/Resources/DataCapture.biz`
  - **Tipo**: OSB Business Service (SOAP)
  - **Función**: Conexión al servicio T24 Web Services
  - **Endpoint**: `http://mwinterbanca:7003/svcDataCapture/services`
  - **Operations**: IngresodeDataCapture, **Autorizaciondedatacapture**, Reversiondedatacapture
  - **Relación**: Servicio compartido con IngresoDataCapture y ReversionDataCapture

- `Middleware/Business_Resources/dataCapture/Resources/DataCapture.wsdl`
  - **Tipo**: WSDL para T24 Web Service
  - **Función**: Definición de operaciones T24
  - **Namespace**: `T24WebServicesImpl`
  - **Port**: T24WebServicesImplPort

## Esquemas XSD de T24 (Compartidos)

### Esquemas de Tipos T24
- `Middleware/Business_Resources/dataCapture/Resources/XMLSchema_-987790958.xsd`
  - **Tipo**: XML Schema Definition
  - **Función**: Definición de tipos para T24 Web Services
  - **Namespace**: `T24WebServicesImpl`
  - **Elements**: Autorizaciondedatacapture, AutorizaciondedatacaptureResponse, DATACAPTUREINPUTWSType, DATACAPTUREType
  - **Relación**: Compartido con IngresoDataCapture y ReversionDataCapture

- `Middleware/Business_Resources/dataCapture/Resources/XMLSchema_-694387951.xsd`
  - **Tipo**: XML Schema Definition
  - **Función**: Definición de tipos array para JAX-WS
  - **Namespace**: `http://jaxb.dev.java.net/array`
  - **Elements**: anyTypeArray
  - **Relación**: Compartido con otras funcionalidades DataCapture

## Esquemas Comunes (Compartidos)

### Esquemas de Headers
- `Middleware/Business_Resources/esquemas_generales/HeaderElements.xsd`
  - **Tipo**: XML Schema Definition
  - **Función**: Definición de headers comunes (AutenticacionRequestHeader, ResponseHeader)
  - **Namespace**: `http://www.ficohsa.com.hn/middleware.services/autType`
  - **Elements**: AutenticacionRequestHeader, ResponseHeader
  - **Relación**: Compartido con todas las funcionalidades OSB

## Archivos de Configuración y Políticas

### Configuraciones OSB
- Configuraciones de timeout y retry en DataCapture.biz (compartidas)
- Configuraciones de monitoring y logging en AutorizacionDataCapture.proxy
- Configuraciones de custom token authentication en AutorizacionDataCapture.proxy
- Configuraciones de throttling y message tracing

### Configuraciones de Seguridad
- **LDAP Lookup**: Directorio `Middleware/Security/{USERNAME}`
- **Custom Token Authentication**: Configurado en proxy service
- **Credenciales T24**: Mapeadas via LDAP o fallback a originales

## Servicios Relacionados (Misma Familia)

### Otros Servicios DataCapture
- `Middleware/OperationsAndExecution/CustomerDeposits/IngresoDataCapture.proxy`
  - **Función**: Ingreso de transacciones DataCapture
  - **Relación**: Crea las transacciones que autoriza AutorizacionDataCapture

- `Middleware/OperationsAndExecution/CustomerDeposits/ReversionDataCapture.proxy`
  - **Función**: Reversión de transacciones DataCapture
  - **Relación**: Revierte transacciones autorizadas por AutorizacionDataCapture

### Transformaciones Relacionadas
- `Middleware/Business_Resources/dataCapture/IngresoDataCapture/ingresoDataCaptureValidateRequired.xq`
- `Middleware/Business_Resources/dataCapture/IngresoDataCapture/ingresoDataCaptureIn.xq`
- `Middleware/Business_Resources/dataCapture/IngresoDataCapture/ingresoDataCaptureOut.xq`
- `Middleware/Business_Resources/dataCapture/IngresoDataCapture/ingresoDataCaptureHeaderOut.xq`

- `Middleware/Business_Resources/dataCapture/ReversionDataCapture/reversionDataCaptureIn.xq`
- `Middleware/Business_Resources/dataCapture/ReversionDataCapture/reversionDataCaptureOut.xq`
- `Middleware/Business_Resources/dataCapture/ReversionDataCapture/reversionDataCaptureHeaderOut.xq`
- `Middleware/Business_Resources/dataCapture/ReversionDataCapture/reversionDataCaptureValidation.xq`

### Esquemas Relacionados
- `Middleware/Business_Resources/dataCapture/IngresoDataCapture/ingresoDataCaptureTypes.xsd`
- `Middleware/Business_Resources/dataCapture/IngresoDataCapture/ingresoDataCapturePS.wsdl`
- `Middleware/Business_Resources/dataCapture/ReversionDataCapture/reversionDataCaptureTypes.xsd`
- `Middleware/Business_Resources/dataCapture/ReversionDataCapture/reversionDataCapturePS.wsdl`

## Tests y Validación

### Tests Relevantes
- **No se encontraron archivos de test específicos** para la funcionalidad AutorizacionDataCapture
- **Recomendación**: Crear tests unitarios y de integración para validar la funcionalidad
- **Tests de Integración**: Validar flujo completo Ingreso → Autorización → Reversión

## Archivos de Configuración del Entorno

### Propiedades y Configuración
- **Configuración embebida** en los archivos .biz y .proxy
- **Endpoints** configurados directamente en business services
- **Sin archivos .properties específicos** encontrados

### Configuraciones de Seguridad
- **LDAP Lookup**: Directorio `Middleware/Security/{USERNAME}`
- **Custom Token Authentication**: Configurado en proxy service
- **Credenciales T24**: Mapeadas via LDAP o fallback a originales

## Resumen de Rutas por Tipo

### Estructura de Directorios
```
Middleware/
├── OperationsAndExecution/CustomerDeposits/
│   ├── AutorizacionDataCapture.proxy
│   ├── IngresoDataCapture.proxy
│   └── ReversionDataCapture.proxy
├── Business_Resources/
│   ├── dataCapture/
│   │   ├── AutorizacionDataCapture/
│   │   │   ├── autorizacionDataCapturePS.wsdl
│   │   │   ├── autorizacionDataCaptureTypes.xsd
│   │   │   ├── autorizacionDataCaptureValidation.xq
│   │   │   ├── autorizacionDataCaptureIn.xq
│   │   │   ├── autorizacionDataCaptureOut.xq
│   │   │   └── autorizacionDataCaptureHeaderOut.xq
│   │   ├── IngresoDataCapture/
│   │   ├── ReversionDataCapture/
│   │   └── Resources/
│   │       ├── DataCapture.biz
│   │       ├── DataCapture.wsdl
│   │       ├── XMLSchema_-987790958.xsd
│   │       └── XMLSchema_-694387951.xsd
│   └── esquemas_generales/
│       └── HeaderElements.xsd
```

## Total de Archivos Identificados

### Por Categoría
- **Archivos principales**: 5 (proxy, wsdl, xsd, transformaciones)
- **Business Services**: 1 (DataCapture - compartido)
- **Esquemas XSD**: 3 (tipos OSB, tipos T24 compartidos, headers compartidos)
- **Transformaciones XQuery**: 4 (validación, mapeos)
- **Archivos de configuración**: 1 (configuraciones embebidas)
- **Servicios relacionados**: 2 (IngresoDataCapture, ReversionDataCapture)

**Total**: 16 archivos directamente relacionados con la funcionalidad AutorizacionDataCapture

### Archivos Críticos para Migración
1. **AutorizacionDataCapture.proxy** - Proxy service principal
2. **autorizacionDataCaptureIn.xq** - Transformación principal de request
3. **autorizacionDataCaptureValidation.xq** - Validación de entrada
4. **DataCapture.biz** - Business service T24 (compartido)
5. **autorizacionDataCaptureTypes.xsd** - Esquema de tipos OSB
6. **XMLSchema_-987790958.xsd** - Esquema de tipos T24 (compartido)

### Dependencias Externas
- **T24 Web Service**: http://mwinterbanca:7003/svcDataCapture/services
- **LDAP Directory**: Middleware/Security/{USERNAME}

### Archivos Compartidos
- **DataCapture.biz**: Compartido con IngresoDataCapture y ReversionDataCapture
- **DataCapture.wsdl**: Compartido con otras funcionalidades DataCapture
- **XMLSchema_-987790958.xsd**: Compartido con otras funcionalidades DataCapture
- **XMLSchema_-694387951.xsd**: Compartido con otras funcionalidades DataCapture
- **HeaderElements.xsd**: Compartido con todas las funcionalidades OSB

### Características Únicas
- **Funcionalidad Simple**: Solo requiere DATA_CAPTURE_ID como entrada
- **Respuesta Mínima**: Solo retorna TRANSACTION_DATE
- **Sin Configuración Regional**: Implementación completamente uniforme
- **Validación Básica**: Solo valida campo requerido
- **Dependencia Única**: Solo depende del servicio T24

### Consideraciones de Migración
1. **Migración Conjunta**: Considerar migrar junto con IngresoDataCapture y ReversionDataCapture
2. **Servicios Compartidos**: Migrar DataCapture.biz una sola vez para todas las funcionalidades
3. **Esquemas Compartidos**: Migrar esquemas T24 una sola vez
4. **Flujo Completo**: Validar flujo completo de DataCapture (Ingreso → Autorización → Reversión)
5. **Corrección de Typo**: Corregir "REQUIRED FILEDS NOT SUPPLIED" durante la migración