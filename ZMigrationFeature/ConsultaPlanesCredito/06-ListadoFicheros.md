# Listado de Ficheros - ConsultaPlanesCredito

## Proxy Services

### Proxy Principal
- `Middleware/v2/ProxyServices/ConsultaPlanesCredito.proxy`

### Proxies Regionales
- `Middleware/v2/ProxyServices/ConsultaPlanesCreditoGT.proxy`
- `Middleware/v2/ProxyServices/ConsultaPlanesCreditoHN.proxy`
- `Middleware/v2/ProxyServices/ConsultaPlanesCreditoNI.proxy`
- `Middleware/v2/ProxyServices/ConsultaPlanesCreditoPA.proxy`

### Proxy Externo
- `Middleware/v2/ExternalServices/ConsultaPlanesCredito.proxy`

## Business Services

### Business Service Principal
- `Middleware/v2/BusinessServices/OSB/ConsultaPlanesCredito/biz/consultaPlanesCredito.biz`
- `Middleware/v2/BusinessServices/OSB/ConsultaPlanesCredito/wsdl/ConsultaPlanesCredito.wsdl`
- `Middleware/v2/BusinessServices/OSB/ConsultaPlanesCredito/xsd/XMLSchema_-324660614.xsd`
- `Middleware/v2/BusinessServices/OSB/ConsultaPlanesCredito/xsd/XMLSchema_1616260754.xsd`

### Business Services de Base de Datos por Región

#### Guatemala (GT01)
- `Middleware/v2/BusinessServices/MasterDataGT/conDatosPlanes/biz/conDatosPlanes_db.biz`
- `Middleware/v2/BusinessServices/MasterDataGT/conDatosPlanes/jca/conDatosPlanes_db.jca`
- `Middleware/v2/BusinessServices/MasterDataGT/conDatosPlanes/wsdl/conDatosPlanes.wsdl`
- `Middleware/v2/BusinessServices/MasterDataGT/conDatosPlanes/wsdl/conDatosPlanes_db.wsdl`
- `Middleware/v2/BusinessServices/MasterDataGT/conDatosPlanes/xsd/conDatosPlanes_sp.xsd`

#### Honduras (HN01)
- `Middleware/v2/BusinessServices/MasterDataHN/conDatosPlanes/biz/conDatosPlanes_db.biz`
- `Middleware/v2/BusinessServices/MasterDataHN/conDatosPlanes/jca/conDatosPlanes_db.jca`
- `Middleware/v2/BusinessServices/MasterDataHN/conDatosPlanes/wsdl/conDatosPlanes.wsdl`
- `Middleware/v2/BusinessServices/MasterDataHN/conDatosPlanes/wsdl/conDatosPlanes_db.wsdl`
- `Middleware/v2/BusinessServices/MasterDataHN/conDatosPlanes/xsd/conDatosPlanes_sp.xsd`

#### Nicaragua (NI01)
- `Middleware/v2/BusinessServices/MasterData/conDatosPlanes/biz/conDatosPlanes_db.biz`
- `Middleware/v2/BusinessServices/MasterData/conDatosPlanes/jca/conDatosPlanes_db.jca`
- `Middleware/v2/BusinessServices/MasterData/conDatosPlanes/wsdl/conDatosPlanes.wsdl`
- `Middleware/v2/BusinessServices/MasterData/conDatosPlanes/wsdl/conDatosPlanes_db.wsdl`
- `Middleware/v2/BusinessServices/MasterData/conDatosPlanes/xsd/conDatosPlanes_sp.xsd`

#### Panamá (PA01)
- `Middleware/v2/BusinessServices/MasterDataPA/conDatosPlanes/biz/conDatosPlanes_db.biz`
- `Middleware/v2/BusinessServices/MasterDataPA/conDatosPlanes/jca/conDatosPlanes_db.jca`
- `Middleware/v2/BusinessServices/MasterDataPA/conDatosPlanes/wsdl/conDatosPlanes.wsdl`
- `Middleware/v2/BusinessServices/MasterDataPA/conDatosPlanes/wsdl/conDatosPlanes_db.wsdl`
- `Middleware/v2/BusinessServices/MasterDataPA/conDatosPlanes/xsd/conDatosPlanes_sp.xsd`

### Business Services de Apoyo
- `Middleware/v2/BusinessServices/MDW/consultaRutaRegional/biz/consultaRutaRegional_db.biz`
- `Middleware/v2/ProxyServices/MapeoErrores.proxy`

## Recursos (WSDL, XSD, XQuery)

### WSDL y XSD Principales
- `Middleware/v2/Resources/ConsultaPlanesCredito/wsdl/consultaPlanesCreditoPS.wsdl`
- `Middleware/v2/Resources/ConsultaPlanesCredito/xsd/consultaPlanesCreditoTypes.xsd`

### Transformaciones XQuery de Salida
- `Middleware/v2/Resources/ConsultaPlanesCredito/xq/consultaPlanesCreditoGTOut.xq`
- `Middleware/v2/Resources/ConsultaPlanesCredito/xq/consultaPlanesCreditoHNOut.xq`
- `Middleware/v2/Resources/ConsultaPlanesCredito/xq/consultaPlanesCreditoOut.xq`
- `Middleware/v2/Resources/ConsultaPlanesCredito/xq/consultaPlanesCreditoPAOut.xq`

### Transformaciones XQuery de Entrada por Región

#### Guatemala (GT01)
- `Middleware/v2/Resources/MasterDataGT/xq/conDatosPlanesGTIn.xq`

#### Honduras (HN01)
- `Middleware/v2/Resources/MasterDataHN/xq/conDatosPlanesHNIn.xq`

#### Nicaragua (NI01)
- `Middleware/v2/Resources/MasterData/xq/conDatosPlanesIn.xq`

#### Panamá (PA01)
- `Middleware/v2/Resources/MasterDataPA/xq/conDatosPlanesPAIn.xq`

### Transformaciones XQuery Generales
- `Middleware/v2/Resources/Generales/xq/consultaRutaRegionalIn.xq`
- `Middleware/v2/Resources/Generales/xq/aplicarValoresPorDefectoRegion.xq`
- `Middleware/v2/Resources/Generales/xq/convertirCodigoPais.xq`

### Transformaciones XQuery de Mapeo de Errores
- `Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageIn.xq`
- `Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageOut.xq`

## Esquemas Generales
- `Middleware/v2/Resources/esquemas_generales/HeaderElements.xsd`

## Java Callouts
No se encontraron Java Callouts específicos para esta funcionalidad.

## POJOs
No se encontraron POJOs específicos para esta funcionalidad.

## Archivos de Configuración

### Properties
No se encontraron archivos .properties específicos para esta funcionalidad.

### Policies
- Configuraciones de seguridad embebidas en los proxies (custom-token-authentication)
- Configuraciones de WS-Policy en binding-mode

## Tests Relevantes
No se encontraron tests específicos para esta funcionalidad en el código fuente analizado.

## Archivos JAR de Despliegue

### Versiones de Producción
- `JAR/2019.10.1.4/PG-1208/DMZ/21.TA-378-Consulta_Planes_Credito_DMZ.jar`
- `JAR/2019.10.1.5/PG-1208/OSB/48.TA-378-Consulta_Planes_Credito.jar`
- `JAR/2020.8.2.0/PG-2791/Produccion/Paquete_III/ConsultaPlanesCredito_GT.jar`
- `JAR/V.HN.MIGRACION.PROCESADOR/PG-5293/PRD/mwomnicanal_ConsultaPlanesCredito.jar`

### Versiones de QA
- `JAR/2020.8.2.0/PG-2791/QA/Paquete_III/ConsultaPlanesCredito_GT.jar`
- `JAR/V.HN.MIGRACION.PROCESADOR/PG-5293/QA/mwomniqa_ConsultaPlanesCredito.jar`

## Resumen de Archivos por Tipo

| Tipo de Archivo | Cantidad | Descripción |
|-----------------|----------|-------------|
| Proxy Services | 6 | 1 principal + 4 regionales + 1 externo |
| Business Services | 17 | 1 principal + 16 regionales (4x4) |
| WSDL | 10 | 1 principal + 9 de business services |
| XSD | 10 | 1 principal + 9 de business services |
| XQuery Transformaciones | 12 | 4 salida + 4 entrada + 4 generales |
| JCA Adapters | 4 | 1 por región |
| JAR Files | 6 | Despliegues de producción y QA |

## Dependencias Externas Identificadas

### Servicios OSB
- `consultaRutaRegional_db` (enrutamiento regional)
- `MapeoErrores` (homologación de errores)
- `convertirCodigoPais` (conversión de códigos de país)

### Conexiones de Base de Datos
- `eis/DB/ConnectionTarjetas` (conexión JNDI a Oracle)

### Stored Procedures
- `dbo.OSBConDatoPlanes` (GT, HN, PA)
- `OSB.dbo.OSBConDatoPlanes` (NI - con esquema específico)

### Namespaces Utilizados
- `http://www.ficohsa.com.hn/middleware.services/consultaPlanesCreditoTypes`
- `http://www.ficohsa.com.hn/middleware.services/consultaPlanesCreditoPS/`
- `http://www.ficohsa.com.hn/middleware.services/autType`
- `http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatosPlanes`
- `http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaRutaRegional`

## Archivos de Configuración Implícitos

### WebLogic Configuration
- Configuración de DataSource para `ConnectionTarjetas`
- Configuración de JNDI para `eis/DB/ConnectionTarjetas`
- Configuración de pools de conexión por región

### OSB Configuration
- Configuración de endpoints HTTP
- Configuración de políticas de seguridad
- Configuración de timeouts y reintentos