# Listado de Ficheros - ConsultaFICOPEN

## Proxy Services

### Proxy Principal
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/ProxyServices/ConsultaFICOPEN.proxy`
  - **Descripción**: Proxy service principal que expone el servicio ConsultaFICOPEN
  - **Endpoint**: /SMiddleware/OperationsAndExecution/BundledProducts/ConsultaFICOPEN_v2
  - **Tipo**: SOAP 1.1

### Proxy de Soporte
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/ProxyServices/MapeoErrores.proxy`
  - **Descripción**: Servicio de mapeo de errores estandarizado
  - **Uso**: Mapear códigos de error a mensajes estándar

## Business Services

### Servicio Backend FPC
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/FPC/getFicopen12c/biz/getFicopen12c.biz`
  - **Descripción**: Business service que conecta con el sistema de Fondos de Pensiones
  - **Endpoint**: https://dynamoosbdev:8004/regional/pension/soap/getFICOPEN/v11g
  - **Timeout**: 70 segundos

### Servicio de Validación Regional
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/ValidaServicioRegional/biz/ValidaServicioRegional_db.biz`
  - **Descripción**: Adapter de base de datos para validar servicios regionales
  - **Tipo**: Database Adapter (JCA)

## Recursos WSDL

### WSDL Proxy Service
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/ConsultaFICOPEN/wsdl/consultaFICOPENPS.wsdl`
  - **Descripción**: Contrato WSDL del proxy service
  - **Namespace**: http://www.ficohsa.com.hn/middleware.services/consultaFICOPENPS/

### WSDL Business Service FPC
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/FPC/getFicopen12c/wsdl/getFicopen12c.wsdl`
  - **Descripción**: Contrato WSDL del servicio backend FPC
  - **Namespace**: http://www.ficohsa.com.hn/middleware.services/consultaFICOPENPS/

### WSDL Validación Regional
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/ValidaServicioRegional/wsdl/ValidaServicioRegional_db.wsdl`
  - **Descripción**: WSDL generado para el adapter de base de datos

## Esquemas XSD

### XSD Proxy Service
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/ConsultaFICOPEN/xsd/consultaFICOPENTypes.xsd`
  - **Descripción**: Define tipos de datos del servicio OSB
  - **Elementos**: consultaFICOPEN, consultaFICOPENResponse

### XSD Business Service FPC
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/FPC/getFicopen12c/xsd/GetFicopenTypes.xsd`
  - **Descripción**: Define tipos de datos del servicio FPC
  - **Elementos**: consultaFICOPEN, consultaFICOPENResponse

- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/FPC/getFicopen12c/xsd/HeaderElements.xsd`
  - **Descripción**: Define estructura de headers de autenticación
  - **Elementos**: RequestHeader, ResponseHeader

### XSD Validación Regional
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/ValidaServicioRegional/xsd/ValidaServicioRegional_sp.xsd`
  - **Descripción**: Define parámetros del stored procedure
  - **Elementos**: InputParameters, OutputParameters

## Transformaciones XQuery

### Transformaciones ConsultaFICOPEN
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/ConsultaFICOPEN/xq/getFICOPENIn.xq`
  - **Descripción**: Transforma request OSB a formato FPC
  - **Tipo**: Request mapping

- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/ConsultaFICOPEN/xq/getFICOPENOut.xq`
  - **Descripción**: Transforma response FPC a formato OSB
  - **Tipo**: Response mapping

- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/ConsultaFICOPEN/xq/getFICOPENHeaderIn.xq`
  - **Descripción**: Construye header de autenticación para FPC
  - **Tipo**: Header mapping
  - **Funciones**: getUsername, getPassword, lookupBasicCredentials

### Transformaciones Generales
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/Generales/xq/validaServicioRegionalIn.xq`
  - **Descripción**: Prepara request para validación regional
  - **Tipo**: Request mapping

- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/Generales/xq/aplicarValoresPorDefectoRegion.xq`
  - **Descripción**: Aplica valores por defecto según región
  - **Tipo**: Header transformation

- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/Genericos/mapeoErrorValidate.xq`
  - **Descripción**: Mapea errores de validación XSD
  - **Tipo**: Error mapping

### Transformaciones MapeoErrores
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageIn.xq`
  - **Descripción**: Prepara request para mapeo de errores
  - **Tipo**: Request mapping

- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageOut.xq`
  - **Descripción**: Procesa response de mapeo de errores
  - **Tipo**: Response mapping

## Configuraciones JCA

- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/ValidaServicioRegional/jca/ValidaServicioRegional_db.jca`
  - **Descripción**: Configuración del adapter de base de datos
  - **Connection Factory**: eis/DB/ConnectionMiddleware
  - **Stored Procedure**: MW_P_VALIDA_SERVICIO_REGIONAL

## Archivos JAR (Despliegue)

### Ambiente PRD
- `Fuentes/ficohsacore-osb-7e5cceccb837/JAR/PG-13516/PRD/mwapp_ConsultaFICOPEN_v1.jar`
- `Fuentes/ficohsacore-osb-7e5cceccb837/JAR/PG-13516/PRD/mwinterbanca_ConsultaFICOPEN_v1.jar`
- `Fuentes/ficohsacore-osb-7e5cceccb837/JAR/PG-13516/PRD/mwomnicanal_ConsultaFICOPEN_v2.jar`

### Ambiente QA
- `Fuentes/ficohsacore-osb-7e5cceccb837/JAR/PG-13516/QA/mwomniqa_ConsultaFICOPEN_v2.jar`
- `Fuentes/ficohsacore-osb-7e5cceccb837/JAR/PG-13516/QA/soabus_ConsultaFICOPEN_v1.jar`

## Recursos Adicionales (Versión Anterior)

### Business Resources (Versión Legacy)
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/Business_Resources/Ficopen/ConsultaFICOPEN/consultaFICOPENHeaderOut.xq`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/Business_Resources/Ficopen/ConsultaFICOPEN/consultaFICOPENIn.xq`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/Business_Resources/Ficopen/ConsultaFICOPEN/consultaFICOPENOut.xq`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/Business_Resources/Ficopen/ConsultaFICOPEN/consultaFICOPENPS.wsdl`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/Business_Resources/Ficopen/ConsultaFICOPEN/consultaFICOPENTypes.xsd`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/Business_Resources/Ficopen/ConsultaFICOPEN/getFICOPENIn.xq`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/Business_Resources/Ficopen/ConsultaFICOPEN/getFICOPENOut.xq`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/Business_Resources/Ficopen/ConsultaFICOPEN/getHeaderFICOPENIn.xq`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/Business_Resources/Ficopen/Resource/consultaFICOPEN.wsdl`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/Business_Resources/Ficopen/Resource/consultaFICOPENBS.biz`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/Business_Resources/Ficopen/Resource/ConsultaFICOPEN/consultaFICOPEN.wsdl`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/Business_Resources/Ficopen/Resource/ConsultaFICOPEN/consultaFICOPEN_db.jca`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/Business_Resources/Ficopen/Resource/ConsultaFICOPEN/xsd/FICOPEN_OSB_K_CONSULTAFICOPEN_TOPLEVEL-24OSB_CON_FICOPEN.xsd`

### Proxy Service Legacy
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/OperationsAndExecution/BundledProducts/ConsultaFICOPEN.proxy`

### Proxy Service Seguro (v2S)
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/SProxyServices/ConsultaFICOPEN_v2S.proxy`

### Business Service OSB (Interno)
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/OSB/ConsultaFICOPEN_v2/biz/ConsultaFICOPEN.biz`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/OSB/ConsultaFICOPEN_v2/wsdl/ConsultaFICOPEN_v2.wsdl`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/OSB/ConsultaFICOPEN_v2/xsd/XMLSchema_2058569568.xsd`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/OSB/ConsultaFICOPEN_v2/xsd/XMLSchema_2066901341.xsd`

## Referencias en Otros Servicios

### Consulta Múltiple Productos HN
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/SJS/consultaMultipleProductosHN/xq/consultaFICOPENIn.xq`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/SJS/consultaMultipleProductosHN/xq/consultaFICOPENOut.xq`

### Consulta Situación Financiera HN
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/SJS/consultaSituacionFinancieraInternoHN/xq/insertarSituacionFinancieraFicopenIn.xq`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/SJS/consultaSituacionFinancieraInternoHN/xq/sjConsultaSituacionFinancieraFicopenIn.xq`

### Actualiza Sistemas
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/ActualizaSistemas/xq/actualizacionClienteFicopenIn.xq`

## Resumen de Conteo

| Tipo de Archivo | Cantidad |
|-----------------|----------|
| Proxy Services | 2 (principal + seguro) |
| Business Services | 4 (FPC, ValidaRegional, OSB interno, Legacy) |
| WSDL | 6 |
| XSD | 7 |
| XQuery (Transformaciones) | 17 |
| JCA (Adapters) | 2 |
| JAR (Despliegue) | 5 |
| **TOTAL** | **43** |

## Notas

1. **Versión Activa**: La versión v2 en `Middleware/v2/` es la implementación activa
2. **Versión Legacy**: Los archivos en `Middleware/Business_Resources/` y `Middleware/OperationsAndExecution/` son versiones anteriores
3. **Ticket**: PG-13516 (según carpeta de JARs)
4. **Ambientes**: PRD (Producción) y QA (Quality Assurance)
5. **Dependencias**: El servicio es referenciado por otros servicios de consulta múltiple y situación financiera
