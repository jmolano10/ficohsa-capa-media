# Listado de Ficheros - ValidaDepositoReferenciadoCB

## Proxies OSB

### Proxy Services Principales
- `Middleware/v2/ProxyServices/ValidaDepositoReferenciadoCB.proxy`
- `Middleware/v2/ProxyServices/DepositosReferenciados.proxy`
- `Middleware/v2/ProxyServices/ValidaDepositoReferenciado.proxy`

### Proxy Services de Apoyo
- `Middleware/v2/ProxyServices/MapeoErrores.proxy`

## Business Services

### Business Services de Base de Datos
- `Middleware/v2/BusinessServices/ABK/validaDepositoReferenciado/biz/ValidaDepositoReferenciado_db.biz`
- `Middleware/v2/BusinessServices/MDW/consultarCorresponsalB/biz/consultarCorresponsalB_db.biz`
- `Middleware/v2/BusinessServices/ValidaServicioRegional/biz/ValidaServicioRegional_db.biz`

## Pipelines y Flujos

### Pipelines en ValidaDepositoReferenciadoCB.proxy
- Pipeline: `ValidaDepositoReferenciado_request`
- Pipeline: `ValidaDepositoReferenciado_response`
- Pipeline: `Validaciones Generales_request`
- Pipeline: `Validaciones Generales_response`
- Pipeline: `_onErrorHandler-5933896112660964401--91722ad.1696d5f7d18.-7f03` (Error Handler)

### Pipelines en ValidaDepositoReferenciado.proxy
- Pipeline: `HN01_request`
- Pipeline: `HN01_response`
- Pipeline: `DefaultBranchPP_request`
- Pipeline: `DefaultBranchPP_response`
- Pipeline: `Validaciones Generales_request`
- Pipeline: `Validaciones Generales_response`
- Pipeline: `_onErrorHandler-5933896112660964401--91722ad.1696d5f7d18.-7f0d` (Error Handler)

### Pipelines en DepositosReferenciados.proxy
- Pipeline: `_onErrorHandler-3631205292627682280-56adafd5.15c6acbe3dc.-7f8d` (Error Handler)

## XQuery/XSLT

### Transformaciones de ValidaDepositoReferenciadoCB
- `Middleware/v2/Resources/ValidaDepositoReferenciadoCB/xq/validaDepositoReferenciadoCBOUT.xq`

### Transformaciones de ValidaDepositoReferenciado
- `Middleware/v2/Resources/ValidaDepositoReferenciado/xq/validaDepositoReferenciadoOUT.xq`

### Transformaciones de Business Services
- `Middleware/v2/BusinessServices/ABK/validaDepositoReferenciado/xq/validaDepositoReferenciadoIN.xq`

### Transformaciones Genéricas
- `Middleware/v2/Resources/Genericos/consultarCorresponsalBIn.xq`
- `Middleware/v2/Resources/Genericos/mapeoErrorValidate.xq`
- `Middleware/v2/Resources/Generales/xq/validaServicioRegionalIn.xq`
- `Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageIn.xq`
- `Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageOut.xq`

## Esquemas XSD

### Esquemas de ValidaDepositoReferenciadoCB
- `Middleware/v2/Resources/ValidaDepositoReferenciadoCB/xsd/validaDepositoReferenciadoCBTypes.xsd`

### Esquemas de ValidaDepositoReferenciado
- `Middleware/v2/Resources/ValidaDepositoReferenciado/xsd/validaDepositoReferenciadoTypes.xsd`

### Esquemas de DepositosReferenciados
- `Middleware/v2/Resources/DepositosReferenciados/xsd/depositosReferenciadosTypes.xsd`

### Esquemas de Business Services
- `Middleware/v2/BusinessServices/ABK/validaDepositoReferenciado/xsd/validaDepositoReferenciado_sp.xsd`

### Esquemas Genéricos
- `Middleware/v2/Resources/esquemas_generales/HeaderElementsCB.xsd`

## WSDL

### WSDL de Proxy Services
- `Middleware/v2/Resources/ValidaDepositoReferenciadoCB/wsdl/validaDepositoReferenciadoCBPS.wsdl`
- `Middleware/v2/Resources/ValidaDepositoReferenciado/wsdl/validaDepositoReferenciadoPS.wsdl`
- `Middleware/v2/Resources/DepositosReferenciados/wsdl/depositosReferenciadosPS.wsdl`

### WSDL de Business Services
- `Middleware/v2/BusinessServices/ABK/validaDepositoReferenciado/wsdl/validaDepositoReferenciado.wsdl`
- `Middleware/v2/BusinessServices/ABK/validaDepositoReferenciado/wsdl/validaDepositoReferenciado_db.wsdl`

## Configuraciones JCA

### Adaptadores de Base de Datos
- `Middleware/v2/BusinessServices/ABK/validaDepositoReferenciado/jca/validaDepositoReferenciado_db.jca`

## Políticas de Seguridad

### Configuraciones de Autenticación
- Configuración custom-token-authentication en ValidaDepositoReferenciadoCB.proxy
- Configuración custom-token-authentication en DepositosReferenciados.proxy
- Configuración custom-token-authentication en ValidaDepositoReferenciado.proxy

## Archivos de Configuración

### Configuraciones de Endpoint
- URI: `/Middleware/OperationsAndExecution/CalculationServices/ValidaDepositoReferenciadoCB`
- URI: `/Middleware/OperationsAndExecution/Payments/DepositosReferenciados`
- Conexión JCA: `eis/DB/ConnectionProxyAbanksHN`

## Tests Relevantes

### JAR de Despliegue (Encontrados)
- `JAR/2019.8.2.0/MDA-7402/PRD/MDA-7402_ValidacionDepositoReferenciadoCB.jar`
- `JAR/2019.8.2.0/MDA-7402/QA/MDA-7402_ValidacionDepositoReferenciadoCB.jar`
- `JAR/2019.8.2.0/MDA-7402/PRD/MDA-7402_ValidacionDepositoReferenciado.jar`
- `JAR/2019.8.2.0/MDA-7402/QA/MDA-7402_ValidacionDepositoReferenciado.jar`

## Archivos de Documentación Existentes

### Documentación Previa (Encontrada)
- `Middleware/v2/BusinessServices/ABK/eliminarFactorCanje/EliminarFactorCanje/03-EjemplosYMapeos-HN01.md`
- `Middleware/v2/BusinessServices/ABK/eliminarFactorCanje/EliminarFactorCanje/04-Secuencia-HN01.mmd`

## Dependencias Externas

### Conexiones de Base de Datos
- **ConnectionProxyAbanksHN**: Conexión a base de datos Abanks Honduras
- **Esquema ABK**: Esquema de base de datos para operaciones bancarias
- **Package CBR_K_DEP_REFERENCIADOS**: Package de stored procedures

### Servicios Dependientes
- **MapeoErrores**: Servicio de mapeo de códigos de error
- **ValidaServicioRegional**: Validación de servicios por región
- **consultarCorresponsalB**: Validación de corresponsales bancarios

## Archivos de Configuración Regional

### Configuraciones por Región
- **HN01**: Implementación completa con todos los archivos listados
- **Otras regiones**: Solo configuración de error por defecto (MW-0008)

## Resumen de Conteo de Archivos

- **Proxy Services**: 4
- **Business Services**: 3
- **Pipelines**: 11
- **XQuery**: 8
- **XSD**: 5
- **WSDL**: 5
- **JCA**: 1
- **JAR**: 4
- **Total**: 41 archivos principales

## Notas Importantes

1. **Archivos Críticos**: Los archivos XQuery de transformación son críticos para el mapeo de datos
2. **Configuración Regional**: Solo HN01 tiene implementación completa
3. **Dependencias**: Fuerte dependencia de servicios genéricos (MapeoErrores, ValidaServicioRegional)
4. **Base de Datos**: Dependencia específica de conexión a Abanks Honduras
5. **Versionado**: Los JAR indican versión 2019.8.2.0 con ticket MDA-7402