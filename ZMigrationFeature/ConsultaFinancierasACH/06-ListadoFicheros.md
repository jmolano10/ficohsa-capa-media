# Listado de Ficheros - ConsultaFinancierasACH

## Proxy Services

### Proxy Principal
- `Middleware/v2/ProxyServices/ConsultaFinancierasACH.proxy`
- `Middleware/ReferenceData/CommonBusinessInformation/ConsultaFinancierasACH.proxy`
- `Middleware/v2/SProxyServices/ConsultaFinancierasACH_v2S.proxy`
- `Middleware/External/Incoming/v2/ProxyServices/ConsultaFinancierasACH.proxy`

## Business Services

### HN01 (Honduras Core)
- `Middleware/Business_Resources/Core/Resources/CoreBS`

### HN02 (Honduras FPC)
- `Middleware/v2/BusinessServices/FPC/getFinancialACH12c/biz/getFinancialACH12c`

### GT01 (Guatemala)
- `Middleware/v2/BusinessServices/ABKGT/consultaFinancierasACH/biz/consultaFinancierasACH_db.biz`
- `Middleware/v2/BusinessServices/ABKGT/consultaFinancierasACH/jca/consultaFinancierasACH_db.jca`
- `Middleware/v2/BusinessServices/ABKGT/consultaFinancierasACH/wsdl/consultaFinancierasACH.wsdl`
- `Middleware/v2/BusinessServices/ABKGT/consultaFinancierasACH/wsdl/consultaFinancierasACH_db.wsdl`
- `Middleware/v2/BusinessServices/ABKGT/consultaFinancierasACH/xsd/consultaFinancierasACH_sp.xsd`

### PA01 (Panamá)
- `Middleware/v2/BusinessServices/ABKPA/consultaFinancierasACH/biz/consultaFinancierasACH_db.biz`
- `Middleware/v2/BusinessServices/ABKPA/consultaFinancierasACH/jca/consultaFinancierasACH_db.jca`
- `Middleware/v2/BusinessServices/ABKPA/consultaFinancierasACH/wsdl/consultaFinancierasACH.wsdl`
- `Middleware/v2/BusinessServices/ABKPA/consultaFinancierasACH/wsdl/consultaFinancierasACH_db.wsdl`
- `Middleware/v2/BusinessServices/ABKPA/consultaFinancierasACH/xsd/consultaFinancierasACH_sp.xsd`

### NI01 (Nicaragua)
- `Middleware/v2/BusinessServices/CTS/transferencia/biz/transferencia.biz`
- `Middleware/v2/BusinessServices/CTS/transferencia/wsdl/COBISCorp.eCOBIS.SrvAplCobisTransferencia.Service`
- `Middleware/v2/BusinessServices/CTS/transferencia/xsd/services.xsd`

### Servicios Auxiliares
- `Middleware/v2/BusinessServices/OSB/ConsultaFinancierasACH_v2/biz/ConsultaFinancierasACH.biz`
- `Middleware/v2/BusinessServices/OSB/ConsultaFinancierasACH_v2/wsdl/ConsultaFinancierasACH_v2.wsdl`
- `Middleware/v2/BusinessServices/OSB/ConsultaFinancierasACH_v2/xsd/XMLSchema_1196595193.xsd`
- `Middleware/v2/BusinessServices/OSB/ConsultaFinancierasACH_v2/xsd/XMLSchema_1626736503.xsd`
- `Middleware/External/Incoming/v2/BusinessServices/ConsultaFinancierasACH_v2/biz/ConsultaFinancierasACH.biz`
- `Middleware/External/Incoming/v2/BusinessServices/ConsultaFinancierasACH_v2/wsdl/ConsultaFinancierasACH_v2.wsdl`
- `Middleware/External/Incoming/v2/BusinessServices/ConsultaFinancierasACH_v2/xsd/ConsultaFinancierasACHTypes.xsd`

### Servicios de Validación y Error
- `Middleware/v2/BusinessServices/ValidaServicioRegional/biz/ValidaServicioRegional_db`
- `Middleware/v2/ProxyServices/MapeoErrores`
- `Middleware/Business_Resources/general/Resources/ObtenerParametrizacion/ObtenerParametrizacion`

## Pipelines y XQuery

### Transformaciones Comunes
- `Middleware/v2/Resources/ConsultaFinancierasACH/xq/consultaFinancierasACHIn.xq`
- `Middleware/v2/Resources/ConsultaFinancierasACH/xq/consultaFinanacierasACHOut.xq`
- `Middleware/v2/Resources/ConsultaFinancierasACH/xq/consultaFinanacierasACHHeaderOut.xq`

### Transformaciones HN02 (FPC)
- `Middleware/v2/Resources/ConsultaFinancierasACH/xq/getFinancialACHHeaderIn.xq`
- `Middleware/v2/Resources/ConsultaFinancierasACH/xq/getFinancialACHOut.xq`
- `Middleware/v2/Resources/ConsultaFinancierasACH/xq/ConsultaFinancierasACH_FPCHNOut.xq`

### Transformaciones GT01 (Guatemala)
- `Middleware/v2/Resources/ConsultaFinancierasACH/xq/consultaFinancierasACHGTIn.xq`
- `Middleware/v2/Resources/ConsultaFinancierasACH/xq/consultaFinancierasACHGTOut.xq`
- `Middleware/v2/Resources/ConsultaFinancierasACH/xq/consultaFinancierasACHGTHeaderOut.xq`

### Transformaciones PA01 (Panamá)
- `Middleware/v2/Resources/ConsultaFinancierasACH/xq/consultaFinancierasACHPAIn.xq`
- `Middleware/v2/Resources/ConsultaFinancierasACH/xq/consultaFinancierasACHPAOut.xq`
- `Middleware/v2/Resources/ConsultaFinancierasACH/xq/consultaFinancierasACHPAHeaderOut.xq`

### Transformaciones NI01 (Nicaragua)
- `Middleware/v2/Resources/ConsultaFinancierasACH/xq/consultaFinanacierasACHNIIn.xq`
- `Middleware/v2/Resources/ConsultaFinancierasACH/xq/consultaFinanacierasACHNIOut.xq`
- `Middleware/v2/Resources/ConsultaFinancierasACH/xq/consultaFinanacierasACHNIHeaderOut.xq`

### Transformaciones de Validación y Error
- `Middleware/v2/Resources/Generales/xq/validaServicioRegionalIn`
- `Middleware/v2/Resources/Generales/xq/aplicarValoresPorDefectoRegion`
- `Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageIn`
- `Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageOut`
- `Middleware/Business_Resources/general/Parametrizacion/obtenerParametrizacionIn`

## WSDL y XSD

### WSDL Principales
- `Middleware/v2/Resources/ConsultaFinancierasACH/wsdl/consultaFinancieraACHPS.wsdl`
- `Middleware/Business_Resources/Core/consultaFinancierasACH/consultaFinancierasACHPS.wsdl`

### XSD de Tipos
- `Middleware/Business_Resources/Core/consultaFinancierasACH/consultaFinancierasACHTypes.xsd`
- `Middleware/v2/Resources/esquemas_generales/HeaderElements.xsd`

### XSD Específicos por Región
- `Middleware/Business_Resources/Core/Resources/XMLSchema_1632682327.xsd` (HN01)
- `Middleware/v2/BusinessServices/ABKGT/consultaFinancierasACH/xsd/consultaFinancierasACH_sp.xsd` (GT01)
- `Middleware/v2/BusinessServices/ABKPA/consultaFinancierasACH/xsd/consultaFinancierasACH_sp.xsd` (PA01)
- `Middleware/v2/BusinessServices/CTS/transferencia/xsd/services.xsd` (NI01)

## Configuraciones y Políticas

### Archivos de Configuración
- `Middleware/Security/{USERNAME}` (Credenciales LDAP para HN01)
- Configuración de conexiones JCA:
  - `ConnectionProxyAbanksGT` (Guatemala)
  - `ConnectionProxyAbanksPA` (Panamá)

### Políticas OSB
- Políticas de seguridad custom-token-authentication
- Políticas de monitoreo y logging
- Políticas de SLA y alertas

## Java Callouts y POJOs

### Funciones Auxiliares
- Funciones LDAP lookup: `fn-bea:lookupBasicCredentials()`
- Funciones de failover: `fn-bea:fail-over()`

## Archivos de Configuración Regional

### Parametrización Nicaragua
- Parámetro: `FICBCO0118.NI.PRODUCTS_TYPES`
- Valor: Lista de tipos de producto separados por pipe (|)

## Tests Relevantes

### JAR de Despliegue
- `JAR/PG-13516/PRD/mwomnicanal_ConsultaFinancierasACH.jar`
- `JAR/PG-13516/QA/mwomniqa_ConsultaFinancierasACH.jar`

## Archivos de Recursos Adicionales

### Recursos Compartidos
- `Middleware/v2/Resources/ConsultaFinancierasACH/wsdl/` (directorio)
- `Middleware/v2/Resources/ConsultaFinancierasACH/xq/` (directorio)

### Recursos Legacy
- `Middleware/Business_Resources/Core/consultaFinancierasACH/consultaFinanacierasACHHeaderOut.xq`
- `Middleware/Business_Resources/Core/consultaFinancierasACH/consultaFinanacierasACHOut.xq`
- `Middleware/Business_Resources/Core/consultaFinancierasACH/consultaFinancierasACHIn.xq`

## Resumen de Archivos por Tipo

| Tipo de Archivo | Cantidad | Descripción |
|-----------------|----------|-------------|
| Proxy Services | 4 | Servicios proxy principales y auxiliares |
| Business Services | 15 | Servicios de negocio por región y auxiliares |
| XQuery Files | 18 | Transformaciones de entrada y salida |
| WSDL Files | 8 | Definiciones de servicios web |
| XSD Files | 8 | Esquemas de validación |
| JCA Files | 2 | Configuraciones de adaptadores DB |
| BIZ Files | 6 | Configuraciones de business services |
| JAR Files | 2 | Archivos de despliegue |

**Total de archivos identificados: 63 archivos**

## Dependencias Externas

### Sistemas Backend
1. **T24 Core Banking** (HN01)
2. **FPC Service** (HN02)  
3. **Oracle Database AbanksGT** (GT01)
4. **Oracle Database AbanksPA** (PA01)
5. **CTS COBIS Service** (NI01)

### Servicios OSB Auxiliares
1. **ValidaServicioRegional**
2. **MapeoErrores**
3. **ObtenerParametrizacion**

### Infraestructura
1. **LDAP Service** (para credenciales HN01)
2. **Connection Pools** (para bases de datos)
3. **HTTP Endpoints** (para servicios externos)