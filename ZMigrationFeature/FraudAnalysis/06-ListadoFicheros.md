# Listado de Ficheros - FraudAnalysis

## Proxy Services

### Proxy Service Principal
- `Fuentes/ficohsacore-osb12-b78f21b126d5/MasterVU/Middleware/v2/ProxyServices/OperationsAndExecution/FraudAnalysis_PS.proxy`
  - **Tipo**: SOAP Proxy Service
  - **Endpoint**: `/Middleware/OperationsAndExecution/PartyAuthentication/FraudAnalysis`
  - **Binding**: SOAP 1.1
  - **Seguridad**: Custom Token Authentication (Username/Password)
  - **Pipeline**: FraudAnalysis_PP

### Pipeline Principal
- `Fuentes/ficohsacore-osb12-b78f21b126d5/MasterVU/Middleware/v2/ProxyServices/OperationsAndExecution/FraudAnalysis_PP.pipeline`
  - **Tipo**: Pipeline
  - **Stages Request**: ValidacionXSD, CommonParams, BitacoraRequest, ValidacionServicioRegional, GetAPIToken, Tx_To_VU
  - **Stages Response**: MapeoError, BitacoraResponse
  - **Error Handler**: ManejoError, BitacoraResponseError
  - **Route Node**: RouteToFraudAnalysis

### Proxy Services Dependientes
- `Fuentes/ficohsacore-osb12-b78f21b126d5/MasterVU/Middleware/v2/ProxyServices/MapeoErrores.proxy`
  - **Operación**: mapeoErrores
  - **Propósito**: Mapear códigos de error técnicos a mensajes de negocio

- `Fuentes/ficohsacore-osb12-b78f21b126d5/MasterVU/Middleware/v2/ProxyServices/MapeoErrores.pipeline`
  - **Pipeline**: Lógica de mapeo de errores

---

## Business Services

### Business Service Principal
- `Fuentes/ficohsacore-osb12-b78f21b126d5/MasterVU/Middleware/v2/BusinessServices/FraudAnalysis/biz/FraudAnalysis_BS.bix`
  - **Tipo**: REST Business Service
  - **Endpoint**: https://10.242.25.20:8080/FraudAnalysis/service
  - **Operación**: analyze
  - **Protocolo**: REST/HTTP
  - **Binding**: REST

### Business Services de Base de Datos

#### ValidaServicioRegional
- `Fuentes/ficohsacore-osb12-b78f21b126d5/MasterVU/Middleware/v2/BusinessServices/ValidaServicioRegional/biz/ValidaServicioRegional_db.bix`
  - **Tipo**: DB Adapter
  - **Operación**: ValidaServicioRegional
  - **Stored Procedure**: MW_P_VALIDA_SERVICIO_REGIONAL

- `Fuentes/ficohsacore-osb12-b78f21b126d5/MasterVU/Middleware/v2/BusinessServices/ValidaServicioRegional/jca/ValidaServicioRegional_db.jca`
  - **Conexión**: eis/DB/ConnectionMiddleware
  - **Adapter**: Database Adapter

#### GetAPIAuth
- `Fuentes/ficohsacore-osb12-b78f21b126d5/MasterVU/Middleware/v2/BusinessServices/DeviceManagement/biz/GetAPIAuth_BS.bix`
  - **Tipo**: DB Adapter
  - **Operación**: GetAPIAuth_BS
  - **Stored Procedure**: MW_P_OBTENER_APIREST_AUT
  - **Schema**: MIDDLEWARE2

- `Fuentes/ficohsacore-osb12-b78f21b126d5/MasterVU/Middleware/v2/Resources/DeviceManagement/jca/GetAPIAuth_BS_db.jca`
  - **Conexión**: eis/DB/ConnectionMiddleware
  - **Adapter**: Database Adapter

#### RegistrarBitacoraOSB
- `Fuentes/ficohsacore-osb12-b78f21b126d5/MasterVU/Middleware/v2/BusinessServices/OSB/RegistrarBitacoraOSB_v2/biz/RegistrarBitacoraOSB_v2.bix`
  - **Operación**: registrarBitacoraOSB
  - **Propósito**: Registrar bitácora de requests y responses

---

## Recursos XQuery (Transformaciones)

### Transformaciones Específicas de FraudAnalysis
- `Fuentes/ficohsacore-osb12-b78f21b126d5/MasterVU/Middleware/v2/Resources/FraudAnalysis/xq/FraudAnalysis_To_VU.xqy`
  - **Propósito**: Transformar request OSB a formato VU Security
  - **Mapeos**: channel → idChannel, optionalParams → name/value

- `Fuentes/ficohsacore-osb12-b78f21b126d5/MasterVU/Middleware/v2/Resources/FraudAnalysis/xq/Vu_To_FraudAnalysis_Response.xqy`
  - **Propósito**: Transformar response VU Security a formato OSB
  - **Mapeos**: result → ACTION, score → SCORERISK

### Transformaciones Generales
- `Fuentes/ficohsacore-osb12-b78f21b126d5/MasterVU/Middleware/v2/Resources/Generales/xq/validaServicioRegionalIn.xqy`
  - **Propósito**: Construir request para validación regional

- `Fuentes/ficohsacore-osb12-b78f21b126d5/MasterVU/Middleware/v2/Resources/Generales/xq/aplicarValoresPorDefectoRegion.xqy`
  - **Propósito**: Aplicar valores por defecto a regiones (HN01 default)

- `Fuentes/ficohsacore-osb12-b78f21b126d5/MasterVU/Middleware/v2/Resources/Generales/xq/registrarBitacoraOSBIn.xqy`
  - **Propósito**: Construir requests para registro de bitácora

- `Fuentes/ficohsacore-osb12-b78f21b126d5/MasterVU/Middleware/v2/Resources/DeviceManagement/xq/DeviceManagement_To_API_Token_Request.xqy`
  - **Propósito**: Construir request para obtener API Key

- `Fuentes/ficohsacore-osb12-b78f21b126d5/MasterVU/Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageIn.xqy`
  - **Propósito**: Construir request para mapeo de errores

- `Fuentes/ficohsacore-osb12-b78f21b126d5/MasterVU/Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageOut.xqy`
  - **Propósito**: Procesar response de mapeo de errores

- `Fuentes/ficohsacore-osb12-b78f21b126d5/MasterVU/Middleware/Business_Resources/general/UUID/obtenerUUID.xqy`
  - **Propósito**: Generar UUIDs para bitácora

---

## Esquemas XSD

### Esquemas Específicos de FraudAnalysis
- `Fuentes/ficohsacore-osb12-b78f21b126d5/MasterVU/Middleware/v2/Resources/FraudAnalysis/xsd/FraudAnalysisTypes.xsd`
  - **Elementos**: FraudAnalysisRequest, FraudAnalysisRequestVU, FraudAnalysisResponse, fraudAnalysisResponseVU
  - **Tipos**: channel (enumeration)

### Esquemas Generales
- `Fuentes/ficohsacore-osb12-b78f21b126d5/MasterVU/Middleware/v2/Resources/Esquemas_Generales/HeaderElements.xsd`
  - **Elementos**: RequestHeader, ResponseHeader
  - **Tipos**: Authentication, Region

### Esquemas de Stored Procedures
- `Fuentes/ficohsacore-osb12-b78f21b126d5/MasterVU/Middleware/v2/BusinessServices/ValidaServicioRegional/xsd/ValidaServicioRegional_sp.xsd`
  - **Elementos**: InputParameters, OutputParameters para ValidaServicioRegional

- `Fuentes/ficohsacore-osb12-b78f21b126d5/MasterVU/Middleware/v2/Resources/DeviceManagement/xsd/GetAPIAuth_BS_sp.xsd`
  - **Elementos**: InputParameters, OutputParameters para GetAPIAuth_BS

---

## WSDL

### WSDL de Proxy Services
- `Fuentes/ficohsacore-osb12-b78f21b126d5/MasterVU/Middleware/v2/Resources/FraudAnalysis/wsdl/FraudAnalysis_PS.wsdl`
  - **PortType**: fraudAnalysis_ptt
  - **Operation**: fraudAnalysis
  - **Binding**: fraudAnalysis_bind (SOAP)

### WSDL de Business Services
- `Fuentes/ficohsacore-osb12-b78f21b126d5/MasterVU/Middleware/v2/Resources/FraudAnalysis/wsdl/FraudAnalysis_BS.wsdl`
  - **PortType**: FraudAnalysis_BS_ptt
  - **Operation**: analyze
  - **Binding**: REST

- `Fuentes/ficohsacore-osb12-b78f21b126d5/MasterVU/Middleware/v2/BusinessServices/ValidaServicioRegional/wsdl/ValidaServicioRegional.wsdl`
  - **PortType**: ValidaServicioRegional_ptt
  - **Operation**: ValidaServicioRegional

- `Fuentes/ficohsacore-osb12-b78f21b126d5/MasterVU/Middleware/v2/BusinessServices/ValidaServicioRegional/wsdl/ValidaServicioRegional_db.wsdl`
  - **Binding**: SOAP over JCA

- `Fuentes/ficohsacore-osb12-b78f21b126d5/MasterVU/Middleware/v2/Resources/DeviceManagement/wsdl/GetAPIAuth_BS.wsdl`
  - **PortType**: GetAPIAuth_BS_ptt
  - **Operation**: GetAPIAuth_BS

- `Fuentes/ficohsacore-osb12-b78f21b126d5/MasterVU/Middleware/v2/Resources/DeviceManagement/wsdl/GetAPIAuth_BS-concrete.wsdl`
  - **Binding**: SOAP over JCA

---

## WADL (REST)

- `Fuentes/ficohsacore-osb12-b78f21b126d5/MasterVU/Middleware/v2/Resources/FraudAnalysis/wadl/FraudAnalysis_BS.wadl`
  - **Descripción**: REST API definition para VU Security

---

## Archivos JCA (Adaptadores)

- `Fuentes/ficohsacore-osb12-b78f21b126d5/MasterVU/Middleware/v2/BusinessServices/ValidaServicioRegional/jca/ValidaServicioRegional_db.jca`
  - **Adapter**: Database Adapter
  - **Connection**: eis/DB/ConnectionMiddleware
  - **Procedure**: MW_P_VALIDA_SERVICIO_REGIONAL

- `Fuentes/ficohsacore-osb12-b78f21b126d5/MasterVU/Middleware/v2/Resources/DeviceManagement/jca/GetAPIAuth_BS_db.jca`
  - **Adapter**: Database Adapter
  - **Connection**: eis/DB/ConnectionMiddleware
  - **Schema**: MIDDLEWARE2
  - **Procedure**: MW_P_OBTENER_APIREST_AUT

---

## Resumen por Tipo de Archivo

### Archivos de Configuración OSB
- **Proxy Services (.proxy)**: 2 archivos
- **Pipelines (.pipeline)**: 2 archivos
- **Business Services (.bix)**: 4 archivos

### Archivos de Transformación
- **XQuery (.xqy)**: 9 archivos

### Archivos de Contrato
- **XSD (.xsd)**: 4 archivos
- **WSDL (.wsdl)**: 6 archivos
- **WADL (.wadl)**: 1 archivo

### Archivos de Adaptador
- **JCA (.jca)**: 2 archivos

### Total de Archivos
**30 archivos** directamente involucrados en la funcionalidad FraudAnalysis

---

## Dependencias Externas (No Incluidas en el Listado)

### Base de Datos
- **Stored Procedures**:
  - `MW_P_VALIDA_SERVICIO_REGIONAL`
  - `MW_P_OBTENER_APIREST_AUT`
  - Stored procedures de RegistrarBitacoraOSB_v2 (no especificados)
  - Stored procedures de MapeoErrores (no especificados)

### Servicios Externos
- **VU Security REST API**: https://10.242.25.20:8080/FraudAnalysis/service

### Conexiones JNDI
- **eis/DB/ConnectionMiddleware**: Conexión a base de datos Oracle

---

## Archivos de Soporte (Referenciados pero no listados)

Los siguientes archivos son referenciados por los servicios dependientes pero no son específicos de FraudAnalysis:

- Archivos de RegistrarBitacoraOSB_v2 (proxy, pipeline, business service, xquery, xsd, wsdl)
- Archivos de MapeoErrores completos (business service, xquery adicionales, xsd, wsdl)
- Archivos de configuración de seguridad y políticas OSB
- Archivos de configuración de conexiones a base de datos

---

## Notas Importantes

1. **Todos los archivos son multiregionales**: No existen archivos específicos por región (HN01, GT01, PA01, NI01)
2. **Ruta base**: Todos los archivos están bajo `Fuentes/ficohsacore-osb12-b78f21b126d5/MasterVU/Middleware/`
3. **Versionado**: Los archivos están en la carpeta `v2`, indicando una versión 2 del middleware
4. **Convención de nombres**: Los archivos siguen la convención `<Funcionalidad>_<Tipo>.<extension>`

---

**Fecha de Análisis**: 2024  
**Versión del Documento**: 1.0  
**Total de Archivos Analizados**: 30
