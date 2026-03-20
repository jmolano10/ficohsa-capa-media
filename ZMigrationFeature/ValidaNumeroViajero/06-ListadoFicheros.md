# Listado de Ficheros - ValidaNumeroViajero

## Proxy Services

### Servicio Principal
- `Middleware/v2/ProxyServices/ValidaNumeroViajero.proxy`
  - **Descripción**: Proxy service principal que expone la funcionalidad
  - **Endpoint**: `/Middleware/CreditCard/Customer/ValidaNumeroViajero`
  - **Protocolo**: SOAP/HTTPS
  - **Puerto**: 8004

## Business Services

### Conexión a Base de Datos
- `Middleware/v2/BusinessServices/ValidaNumeroViajero/biz/validaNumeroViajero_db.biz`
  - **Descripción**: Business service para conexión a Salesforce DB
  - **Conexión**: `jca://eis/DB/ConnectionInterfazSFC`
  - **Tipo**: Database JCA Adapter

## Pipelines

### Pipelines Integrados en Proxy
Los pipelines están definidos dentro del archivo proxy:
- **ValidaNumeroViajero_request**: Pipeline de entrada
  - Stage: ValidacionXSD
  - Stage: FlujoEntrada
- **ValidaNumeroViajero_response**: Pipeline de respuesta
  - Stage: FlujoSalida
- **_onErrorHandler**: Pipeline de manejo de errores
  - Stage: ManejoError

## XQuery/XSLT

### Transformaciones de Entrada
- `Middleware/v2/Resources/ValidaNumeroViajero/xq/ValidaNumeroViajeroIn.xq`
  - **Descripción**: Transformación OSB request → DB input
  - **Función**: Mapea Type/FlyerNumber a PV_TYPE/PV_NUMERO_VIAJERO

### Transformaciones de Salida
- `Middleware/v2/Resources/ValidaNumeroViajero/xq/ValidaNumeroViajeroOut.xq`
  - **Descripción**: Transformación DB output → OSB response
  - **Función**: Mapea PV_RESULT a Result

## Java Callouts

**No encontrados**: Esta funcionalidad no utiliza Java Callouts.

## POJOs

**No encontrados**: Esta funcionalidad no utiliza POJOs personalizados.

## Configuración

### JCA Adapters
- `Middleware/v2/BusinessServices/ValidaNumeroViajero/jca/validaNumeroViajero_db.jca`
  - **Descripción**: Configuración del adaptador JCA para base de datos
  - **Connection Factory**: `eis/DB/ConnectionInterfazSFC`
  - **Schema**: SALESFORCE
  - **Stored Procedure**: SFC_VALIDAR_NUMERO_VIAJERO

## Properties

**No encontrados**: Esta funcionalidad no utiliza archivos de propiedades específicos.

## Esquemas y Contratos

### WSDL - Proxy Service
- `Middleware/v2/Resources/ValidaNumeroViajero/wsdl/validaNumeroViajeroPS.wsdl`
  - **Descripción**: Contrato WSDL del proxy service
  - **Namespace**: `http://www.ficohsa.com.hn/middleware.services/validaNumeroViajeroPS/`
  - **Operation**: ValidaNumeroViajero

### WSDL - Business Service
- `Middleware/v2/BusinessServices/ValidaNumeroViajero/wsdl/validaNumeroViajero.wsdl`
  - **Descripción**: Contrato WSDL abstracto para DB adapter
- `Middleware/v2/BusinessServices/ValidaNumeroViajero/wsdl/validaNumeroViajero_db.wsdl`
  - **Descripción**: Contrato WSDL concreto para DB adapter

### XSD - Tipos de Datos
- `Middleware/v2/Resources/ValidaNumeroViajero/xsd/validaNumeroViajeroTypes.xsd`
  - **Descripción**: Definición de tipos para request/response del proxy
  - **Elementos**: validaNumeroViajero, validaNumeroViajeroResponse
- `Middleware/v2/BusinessServices/ValidaNumeroViajero/xsd/validaNumeroViajero_sp.xsd`
  - **Descripción**: Definición de tipos para stored procedure
  - **Elementos**: InputParameters, OutputParameters

### Esquemas Generales
- `Middleware/v2/esquemas_generales/HeaderElements.xsd`
  - **Descripción**: Esquemas para headers de autenticación
  - **Namespace**: `http://www.ficohsa.com.hn/middleware.services/autType`

## Políticas

### Políticas de Seguridad
**Integradas en proxy**: Custom token authentication configurada directamente en el proxy service.

### Políticas de Timeout
**No encontradas**: Se utilizan configuraciones por defecto de OSB.

## Handlers

### Error Handlers
**Integrados en proxy**: Error handler definido dentro del proxy service como pipeline de error.

## Tests

### Tests Unitarios
**No encontrados**: No se encontraron tests específicos para esta funcionalidad.

### Tests de Integración
**No encontrados**: No se encontraron tests de integración específicos.

## Archivos JAR Relevantes

### Producción
- `JAR/TPTCR-773/PRD/ValidaNumeroViajero.jar`
  - **Descripción**: JAR de producción (posiblemente contiene clases auxiliares)

### QA
- `JAR/TPTCR-773/QA/ValidaNumeroViajero.jar`
  - **Descripción**: JAR de QA (posiblemente contiene clases auxiliares)

## Estructura de Directorios

```
Middleware/v2/
├── ProxyServices/
│   └── ValidaNumeroViajero.proxy
├── BusinessServices/
│   └── ValidaNumeroViajero/
│       ├── biz/
│       │   └── validaNumeroViajero_db.biz
│       ├── jca/
│       │   └── validaNumeroViajero_db.jca
│       ├── wsdl/
│       │   ├── validaNumeroViajero.wsdl
│       │   └── validaNumeroViajero_db.wsdl
│       └── xsd/
│           └── validaNumeroViajero_sp.xsd
└── Resources/
    └── ValidaNumeroViajero/
        ├── wsdl/
        │   └── validaNumeroViajeroPS.wsdl
        ├── xq/
        │   ├── ValidaNumeroViajeroIn.xq
        │   └── ValidaNumeroViajeroOut.xq
        └── xsd/
            └── validaNumeroViajeroTypes.xsd
```

## Dependencias Externas

### Base de Datos
- **Salesforce Database**: Esquema SALESFORCE
- **Stored Procedure**: SFC_VALIDAR_NUMERO_VIAJERO
- **Connection Pool**: ConnectionInterfazSFC

### Infraestructura OSB
- **OSB Server**: Para ejecución de servicios
- **JCA Database Adapter**: Para conectividad a BD
- **HTTPS Connector**: Para exposición segura del servicio

## Archivos de Configuración de Entorno

**No encontrados específicos**: La funcionalidad utiliza configuraciones estándar de OSB y conexiones definidas a nivel de servidor.

## Resumen de Archivos por Categoría

| Categoría | Cantidad | Archivos |
|-----------|----------|----------|
| **Proxy Services** | 1 | ValidaNumeroViajero.proxy |
| **Business Services** | 1 | validaNumeroViajero_db.biz |
| **WSDL** | 3 | validaNumeroViajeroPS.wsdl, validaNumeroViajero.wsdl, validaNumeroViajero_db.wsdl |
| **XSD** | 2 | validaNumeroViajeroTypes.xsd, validaNumeroViajero_sp.xsd |
| **XQuery** | 2 | ValidaNumeroViajeroIn.xq, ValidaNumeroViajeroOut.xq |
| **JCA** | 1 | validaNumeroViajero_db.jca |
| **JAR** | 2 | ValidaNumeroViajero.jar (PRD/QA) |
| **Total** | 12 | - |

## Observaciones

1. **Funcionalidad compacta**: Pocos archivos, bien organizados
2. **Sin regionalización**: Todos los archivos son únicos y transversales
3. **Estándar OSB**: Sigue patrones estándar de Oracle Service Bus
4. **Sin dependencias complejas**: Solo requiere conectividad a Salesforce DB
5. **Mantenimiento simple**: Estructura clara y directa