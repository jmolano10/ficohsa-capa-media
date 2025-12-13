# Listado de Ficheros - ConsultaInformacionLaboral

## Proxies

### Proxy Services
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/ProxyServices/ConsultaInformacionLaboral.proxy`

## Business Services

### Servicios de Validación
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/ValidaServicioRegional/biz/ValidaServicioRegional_db.biz`

### Servicios FPC
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/FPC/consultaInformacionLaboral/biz/consultaInformacionLaboralFPC_db.biz`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/FPC/consultaInformacionLaboral/jca/consultaInformacionLaboralFPC_db.jca`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/FPC/consultaInformacionLaboral/wsdl/consultaInformacionLaboralFPC.wsdl`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/FPC/consultaInformacionLaboral/wsdl/consultaInformacionLaboralFPC_db.wsdl`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/FPC/consultaInformacionLaboral/xsd/consultaInformacionLaboralFPC_sp.xsd`

### Servicios Externos
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/FPC/getEmploymentInformation12c/biz/getEmploymentInformation12c.biz`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/FPC/getEmploymentInformation12c/wsdl/getEmploymentInformation12c.wsdl`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/FPC/getEmploymentInformation12c/xsd/GetEmploymentInformation.xsd`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/FPC/getEmploymentInformation12c/xsd/HeaderElements.xsd`

## Pipelines

### Pipelines Principales (dentro del Proxy)
- ValidacionesGenerales_request
- ValidacionesGenerales_response
- HNFPC_ConsultaInformacionLaboral_request
- HNFPC_ConsultaInformacionLaboral_response
- Default_ConsultaInformacionLaboral_request
- Default_ConsultaInformacionLaboral_response

### Error Handlers (dentro del Proxy)
- _onErrorHandler-1771452867105238821-332ff2a4.14e547ec944.-7cac
- _onErrorHandler-1771452867105238821-332ff2a4.14e547ec944.-7bcf

## XQuery/XSLT

### Transformaciones Generales
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/Generales/xq/validaServicioRegionalIn.xq`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/Generales/xq/aplicarValoresPorDefectoRegion.xq`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/Generales/mensajesError.xml`

### Transformaciones Específicas de ConsultaInformacionLaboral
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/ConsultaInformacionLaboral/xq/getEmploymentInformationIn.xq`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/ConsultaInformacionLaboral/xq/getEmploymentInformationHNOut.xq`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/ConsultaInformacionLaboral/xq/getEmploymentInformationHeaderIn.xq`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/ConsultaInformacionLaboral/xq/consultaInformacionLaboralIn_HNFPC.xq`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/ConsultaInformacionLaboral/xq/consultaInformacionLaboralOut_HNFPC.xq`

### Transformaciones de Error
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/Business_Resources/general/ServiceErrorId/obtenerServiceErrorId.xq`

## Java Callouts

No se encontraron Java Callouts específicos para esta funcionalidad.

## POJOs

No se encontraron POJOs específicos para esta funcionalidad.

## Config

### Archivos de Configuración JCA
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/FPC/consultaInformacionLaboral/jca/consultaInformacionLaboralFPC_db.jca`

### Archivos de Proyecto
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/.project`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/.settings/`

## Properties

### Archivos de Seguridad
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/Security/OSB12AUTH.sa`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/Security/HNFPINTFPCDESA.sa`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/Security/HNFPINTPRTWEB.sa`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/Security/HNFPINTSLSFRC.sa`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/Security/HNFPINTSYSDE.sa`

## Policies

### Políticas de Seguridad (dentro del Proxy)
- Custom token authentication con usuario/contraseña
- WS-Policy con binding-mode: wsdl-policy-attachments

### Políticas de Monitoreo (dentro del Proxy)
- Monitoring habilitado a nivel Pipeline
- SLA Alerting habilitado
- Pipeline Alerting habilitado
- Logging en nivel debug

## Tests

No se encontraron tests específicos para esta funcionalidad en la estructura analizada.

## XSD

### Esquemas Principales
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/ConsultaInformacionLaboral/xsd/consultaInformacionLaboralTypes.xsd`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/ConsultaInformacionLaboral/wsdl/consultaInformacionLaboralPS.wsdl`

### Esquemas de Servicios Externos
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/FPC/getEmploymentInformation12c/xsd/GetEmploymentInformation.xsd`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/FPC/getEmploymentInformation12c/xsd/HeaderElements.xsd`

### Esquemas de Base de Datos
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/FPC/consultaInformacionLaboral/xsd/consultaInformacionLaboralFPC_sp.xsd`

### Esquemas Generales
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/esquemas_generales/HeaderElements.xsd`

## WSDL

### WSDL Principales
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/ConsultaInformacionLaboral/wsdl/consultaInformacionLaboralPS.wsdl`

### WSDL de Business Services
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/FPC/consultaInformacionLaboral/wsdl/consultaInformacionLaboralFPC.wsdl`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/FPC/consultaInformacionLaboral/wsdl/consultaInformacionLaboralFPC_db.wsdl`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/FPC/getEmploymentInformation12c/wsdl/getEmploymentInformation12c.wsdl`

## JAR

### Archivos JAR Relacionados
- `Fuentes/ficohsacore-osb-7e5cceccb837/JAR/PG-13516/PRD/mwapp_ConsultaInformacionLaboral.jar`
- `Fuentes/ficohsacore-osb-7e5cceccb837/JAR/PG-13516/PRD/mwinterbanca_ConsultaInformacionLaboral.jar`
- `Fuentes/ficohsacore-osb-7e5cceccb837/JAR/PG-13516/QA/soabus_ConsultaInformacionLaboral.jar`

## Resumen de Archivos por Categoría

| Categoría | Cantidad | Descripción |
|-----------|----------|-------------|
| **Proxies** | 1 | Servicio principal |
| **Business Services** | 8 | Servicios de BD y externos |
| **XQuery** | 7 | Transformaciones de datos |
| **XSD** | 6 | Esquemas de validación |
| **WSDL** | 4 | Contratos de servicios |
| **JCA** | 1 | Configuración de adaptador BD |
| **Security** | 5 | Archivos de credenciales |
| **JAR** | 3 | Artefactos compilados |

**Total de archivos relevantes**: 35 archivos

## Dependencias Externas Identificadas

1. **Base de Datos FPC**: ConnectionFicopen
2. **Servicio Dynamo**: https://dynamoosbdev:8004
3. **Servicio de Validación Regional**: ValidaServicioRegional_db
4. **Almacén de Credenciales**: Middleware/Security/
5. **Recursos Generales**: Transformaciones y mensajes de error comunes