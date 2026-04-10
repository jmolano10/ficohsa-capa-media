# Listado de Ficheros - ValidaDepositoReferenciadoCB

## Proxies OSB

### Servicio Principal CB
- `Middleware/v2/ProxyServices/ValidaDepositoReferenciadoCB.proxy`
  - **Descripción**: Servicio principal CB wrapper para validación de depósitos referenciados
  - **Tipo**: Proxy Service SOAP
  - **Endpoint**: `/Middleware/OperationsAndExecution/CalculationServices/ValidaDepositoReferenciadoCB`

### Router de Operaciones
- `Middleware/v2/ProxyServices/DepositosReferenciados.proxy`
  - **Descripción**: Router que maneja múltiples operaciones de depósitos referenciados
  - **Tipo**: Proxy Service SOAP
  - **Endpoint**: `/Middleware/OperationsAndExecution/Payments/DepositosReferenciados`

### Servicio Core
- `Middleware/v2/ProxyServices/ValidaDepositoReferenciado.proxy`
  - **Descripción**: Servicio core con lógica de negocio regionalizada
  - **Tipo**: Proxy Service local
  - **Regionalización**: HN01 implementado, otras regiones con error por defecto

## Business Services

### Conexión a Base de Datos Principal
- `Middleware/v2/BusinessServices/ABK/validaDepositoReferenciado/biz/ValidaDepositoReferenciado_db.biz`
  - **Descripción**: Business service para conexión a Oracle DB
  - **Conexión**: jca://eis/DB/ConnectionProxyAbanksHN
  - **Package**: CBR_K_DEP_REFERENCIADOS
  - **Stored Procedure**: CRB_P_VALIDAR_DEPOSITO_REF

### Validaciones de Negocio
- `Middleware/v2/BusinessServices/MDW/consultarCorresponsalB/biz/consultarCorresponsalB_db.biz`
  - **Descripción**: Validación de corresponsal bancario
  - **Stored Procedure**: consultarCorresponsalB

- `Middleware/v2/BusinessServices/ValidaServicioRegional/biz/ValidaServicioRegional_db.biz`
  - **Descripción**: Validación de servicio por región
  - **Stored Procedure**: ValidaServicioRegional

### Mapeo de Errores
- `Middleware/v2/ProxyServices/MapeoErrores.proxy`
  - **Descripción**: Servicio para mapeo y transformación de errores
  - **Operación**: mapeoErrores

## Pipelines y Flujos

### ValidaDepositoReferenciadoCB.proxy
- **Pipeline Request**: `ValidaDepositoReferenciado_request`
  - Stage: `FlujoEntrada`
- **Pipeline Response**: `ValidaDepositoReferenciado_response`
  - Stage: `FlujoSalida`
- **Pipeline Request**: `Validaciones Generales_request`
  - Stage: `ValidateMessage`
  - Stage: `ValidarCorresponsal`
- **Pipeline Response**: `Validaciones Generales_response`
  - Stage: `MapeoError`
- **Error Handler**: `_onErrorHandler-5933896112660964401--91722ad.1696d5f7d18.-7f03`
  - Stage: `ManejoError`

### ValidaDepositoReferenciado.proxy
- **Pipeline Request**: `HN01_request`
  - Stage: `FlujoEntrada`
- **Pipeline Response**: `HN01_response`
  - Stage: `FlujoSalida`
- **Pipeline Request**: `DefaultBranchPP_request`
  - Stage: `FlujoEntrada`
- **Pipeline Response**: `DefaultBranchPP_response`
  - Stage: `FlujoSalida`
- **Pipeline Request**: `Validaciones Generales_request`
  - Stage: `ValidateMessage`
  - Stage: `ValidateRegionService`
- **Pipeline Response**: `Validaciones Generales_response`
  - Stage: `MapeoError`

## XQuery/XSLT

### Transformaciones de Entrada
- `Middleware/v2/BusinessServices/ABK/validaDepositoReferenciado/xq/validaDepositoReferenciadoIN.xq`
  - **Descripción**: Transformación de entrada para mapear datos a stored procedure
  - **Función**: Mapeo de tipo de documento (DEBTOR_CODE → 1, otros → 2)

### Transformaciones de Salida
- `Middleware/v2/Resources/ValidaDepositoReferenciado/xq/validaDepositoReferenciadoOUT.xq`
  - **Descripción**: Transformación de salida del servicio core
  - **Función**: Correlación de arrays de deudores por índice

- `Middleware/v2/Resources/ValidaDepositoReferenciadoCB/xq/validaDepositoReferenciadoCBOUT.xq`
  - **Descripción**: Transformación de salida del servicio CB
  - **Función**: Mapeo de formato interno a formato CB

### Transformaciones Genéricas
- `Middleware/v2/Resources/Genericos/consultarCorresponsalBIn.xq`
  - **Descripción**: Transformación para consulta de corresponsal bancario

- `Middleware/v2/Resources/Generales/xq/validaServicioRegionalIn.xq`
  - **Descripción**: Transformación para validación de servicio regional

- `Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageIn.xq`
  - **Descripción**: Transformación de entrada para mapeo de errores

- `Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageOut.xq`
  - **Descripción**: Transformación de salida para mapeo de errores

- `Middleware/v2/Resources/Genericos/mapeoErrorValidate.xq`
  - **Descripción**: Mapeo de errores de validación de esquema

## WSDL

### Contratos de Servicio
- `Middleware/v2/Resources/ValidaDepositoReferenciadoCB/wsdl/validaDepositoReferenciadoCBPS.wsdl`
  - **Descripción**: Contrato WSDL del servicio CB
  - **Namespace**: `http://www.ficohsa.com.hn/middleware.services/ValidaDepositoReferenciadoCBTypes`

- `Middleware/v2/Resources/ValidaDepositoReferenciado/wsdl/validaDepositoReferenciadoPS.wsdl`
  - **Descripción**: Contrato WSDL del servicio core
  - **Namespace**: `http://www.ficohsa.com.hn/middleware.services/depositosReferenciadosTypes`

- `Middleware/v2/Resources/DepositosReferenciados/wsdl/depositosReferenciadosPS.wsdl`
  - **Descripción**: Contrato WSDL del router de operaciones

### Contratos de Base de Datos
- `Middleware/v2/BusinessServices/ABK/validaDepositoReferenciado/wsdl/validaDepositoReferenciado_db.wsdl`
  - **Descripción**: Contrato WSDL para stored procedure principal

- `Middleware/v2/BusinessServices/ABK/validaDepositoReferenciado/wsdl/validaDepositoReferenciado.wsdl`
  - **Descripción**: Contrato WSDL genérico del business service

## XSD (Esquemas)

### Esquemas de Datos CB
- `Middleware/v2/Resources/ValidaDepositoReferenciadoCB/xsd/validaDepositoReferenciadoCBTypes.xsd`
  - **Descripción**: Esquema de tipos para el servicio CB
  - **Elementos**: validaDepositoReferenciadoCBRequest, validaDepositoReferenciadoCBResponse

### Esquemas de Datos Internos
- `Middleware/v2/Resources/ValidaDepositoReferenciado/xsd/validaDepositoReferenciadoTypes.xsd`
  - **Descripción**: Esquema de tipos para el servicio core

- `Middleware/v2/Resources/DepositosReferenciados/xsd/depositosReferenciadosTypes.xsd`
  - **Descripción**: Esquema de tipos para el router

### Esquemas de Base de Datos
- `Middleware/v2/BusinessServices/ABK/validaDepositoReferenciado/xsd/validaDepositoReferenciado_sp.xsd`
  - **Descripción**: Esquema para parámetros del stored procedure
  - **Elementos**: InputParameters, OutputParameters
  - **Tipos**: TVARCHAR100 para arrays

## JCA (Adaptadores)

### Configuración de Base de Datos
- `Middleware/v2/BusinessServices/ABK/validaDepositoReferenciado/jca/validaDepositoReferenciado_db.jca`
  - **Descripción**: Configuración del adaptador de base de datos
  - **Conexión**: ConnectionProxyAbanksHN
  - **Tipo**: Database Adapter

## Configuración y Propiedades

### Esquemas Generales
- `Middleware/v2/Resources/esquemas_generales/HeaderElementsCB.xsd`
  - **Descripción**: Esquema para elementos de header CB
  - **Namespace**: `http://www.ficohsa.com.hn/middleware.services/autType`

## JAR Files (Deployments)

### Versiones de Producción
- `JAR/2019.8.2.0/MDA-7402/PRD/MDA-7402_ValidacionDepositoReferenciadoCB.jar`
- `JAR/2019.8.2.0/MDA-7402/PRD/MDA-7402_ValidacionDepositoReferenciado.jar`
- `JAR/2019.8.2.0/MDA-7402/PRD/MDA-7402_Update_Deposito_RefereciadoCB.jar`

### Versiones de QA
- `JAR/2019.8.2.0/MDA-7402/QA/MDA-7402_ValidacionDepositoReferenciadoCB.jar`
- `JAR/2019.8.2.0/MDA-7402/QA/MDA-7402_ValidacionDepositoReferenciado.jar`
- `JAR/2019.8.2.0/MDA-7402/QA/MDA-7402_Update_Deposito_RefereciadoCB.jar`

## Tests Relevantes

**No encontrado**: No se identificaron archivos de test específicos para esta funcionalidad en la estructura analizada.

## Resumen de Archivos por Categoría

| Categoría | Cantidad | Descripción |
|-----------|----------|-------------|
| **Proxy Services** | 3 | Servicios OSB principales |
| **Business Services** | 4+ | Conexiones a base de datos y servicios |
| **XQuery** | 8 | Transformaciones de datos |
| **WSDL** | 4 | Contratos de servicio |
| **XSD** | 5 | Esquemas de datos |
| **JCA** | 1 | Configuración de adaptadores |
| **JAR** | 6 | Archivos de deployment |
| **Pipelines** | 12 | Flujos de procesamiento |

**Total de archivos identificados**: Aproximadamente 43 archivos directamente relacionados con la funcionalidad ValidaDepositoReferenciadoCB.