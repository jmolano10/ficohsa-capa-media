# Listado de Ficheros - ConsultaGestionesMonetarias

## Proxy Services

### Proxy Principal
- `Middleware/v2/ProxyServices/ConsultaGestionesMonetarias.proxy`
  - **Descripción**: Proxy service principal que maneja el enrutamiento regional
  - **Endpoint**: `/Middleware/OperationsAndExecution/BundledProducts/ConsultaGestionesMonetarias`
  - **Protocolo**: SOAP/HTTP
  - **Autenticación**: Custom token authentication

### Proxy Externo
- `Middleware/v2/ExternalServices/ConsultaGestionesMonetarias.proxy`
  - **Descripción**: Proxy service externo que actúa como punto de entrada
  - **Endpoint**: `/Middleware/External/OperationsAndExecution/BundledProducts/ConsultaGestionesMonetarias`
  - **Protocolo**: SOAP/HTTP

## Business Services

### Adaptador Base de Datos Principal
- `Middleware/v2/BusinessServices/IntefazSalesforce/GestionesMonetarias/biz/consultaGestionesMonetarias_db.biz`
  - **Descripción**: Business service para conexión a base de datos Oracle
  - **Tipo**: JCA Database Adapter
  - **Conexión**: `eis/DB/ConnectionInterfazSFC`

### Configuración JCA
- `Middleware/v2/BusinessServices/IntefazSalesforce/GestionesMonetarias/jca/consultaGestionesMonetarias_db.jca`
  - **Descripción**: Configuración del adaptador JCA para base de datos
  - **Esquema**: SALESFORCE
  - **Stored Procedure**: SFC_P_CON_GESTIONES_MONETARIAS

### Business Service OSB v2
- `Middleware/v2/BusinessServices/OSB/ConsultaGestionesMonetarias_v2/biz/ConsultaGestionesMonetarias.biz`
  - **Descripción**: Business service OSB versión 2

## Pipelines

### Pipelines por Región (Definidos en el Proxy Principal)
- **HN01_ConsultasGestionesMonetarias_request**: Pipeline de entrada para Honduras
- **HN01_ConsultasGestionesMonetarias_response**: Pipeline de salida para Honduras
- **GT01_ConsultasGestionesMonetarias_request**: Pipeline de entrada para Guatemala
- **GT01_ConsultasGestionesMonetarias_response**: Pipeline de salida para Guatemala
- **PA01_ConsultasGestionesMonetarias_request**: Pipeline de entrada para Panamá
- **PA01_ConsultasGestionesMonetarias_response**: Pipeline de salida para Panamá
- **DEFAULT_ConsultasGestionesMonetarias_request**: Pipeline por defecto (error)
- **DEFAULT_ConsultasGestionesMonetarias_response**: Pipeline por defecto (error)

### Pipelines de Validación y Error
- **ValidacionesGenerales_request**: Pipeline de validaciones generales
- **ValidacionesGenerales_response**: Pipeline de respuesta de validaciones
- **_onErrorHandler-4368734614033876815-6f74fcfe.163ff6a96e7.-7fa6**: Pipeline de manejo de errores

## XQuery/XSLT

### Transformaciones de Entrada por Región
- `Middleware/v2/Resources/ConsultaGestionesMonetarias/xq/consultaGestionesMonetariasIn.xq`
  - **Región**: HN01 (Honduras)
  - **Función**: Transformar request OSB a parámetros de stored procedure

- `Middleware/v2/Resources/ConsultaGestionesMonetarias/xq/consultaGestionesMonetariasGTIn.xq`
  - **Región**: GT01 (Guatemala)
  - **Función**: Transformar request OSB a parámetros de stored procedure

- `Middleware/v2/Resources/ConsultaGestionesMonetarias/xq/consultaGestionesMonetariasPAIn.xq`
  - **Región**: PA01 (Panamá)
  - **Función**: Transformar request OSB a parámetros de stored procedure

### Transformaciones de Salida por Región
- `Middleware/v2/Resources/ConsultaGestionesMonetarias/xq/consultaGestionesMonetariasOut.xq`
  - **Región**: HN01 (Honduras)
  - **Función**: Transformar respuesta de stored procedure a response OSB

- `Middleware/v2/Resources/ConsultaGestionesMonetarias/xq/consultaGestionesMonetariasGTOut.xq`
  - **Región**: GT01 (Guatemala)
  - **Función**: Transformar respuesta de stored procedure a response OSB

- `Middleware/v2/Resources/ConsultaGestionesMonetarias/xq/consultaGestionesMonetariasPAOut.xq`
  - **Región**: PA01 (Panamá)
  - **Función**: Transformar respuesta de stored procedure a response OSB

### Transformaciones de Header por Región
- `Middleware/v2/Resources/ConsultaGestionesMonetarias/xq/consultaGestionesMonetariasHeaderOut.xq`
  - **Región**: HN01 (Honduras)
  - **Función**: Construir header de respuesta

- `Middleware/v2/Resources/ConsultaGestionesMonetarias/xq/consultaGestionesMonetariasGTHeaderOut.xq`
  - **Región**: GT01 (Guatemala)
  - **Función**: Construir header de respuesta

- `Middleware/v2/Resources/ConsultaGestionesMonetarias/xq/consultaGestionesMonetariasPAHeaderOut.xq`
  - **Región**: PA01 (Panamá)
  - **Función**: Construir header de respuesta

## Java Callouts

**No se encontraron Java Callouts específicos** para esta funcionalidad en el análisis del código fuente.

## POJOs

**No se encontraron POJOs específicos** para esta funcionalidad en el análisis del código fuente.

## Configuración

### Esquemas XSD
- `Middleware/v2/Resources/ConsultaGestionesMonetarias/xsd/consultaGestionesMonetariasTypes.xsd`
  - **Descripción**: Definición de tipos de datos para request/response
  - **Elementos**: consultaGestionesMonetarias, consultaGestionesMonetariasResponse

- `Middleware/v2/BusinessServices/IntefazSalesforce/GestionesMonetarias/xsd/consultaGestionesMonetarias_sp.xsd`
  - **Descripción**: Esquema del stored procedure
  - **Tipos**: InputParameters, OutputParameters, T_GESTIONES_MONETARIAS

### WSDL
- `Middleware/v2/Resources/ConsultaGestionesMonetarias/wsdl/consultaGestionesMonetariasPS.wsdl`
  - **Descripción**: Definición del servicio web SOAP
  - **Operación**: consultaGestionesMonetarias
  - **Binding**: SOAP 1.1

- `Middleware/v2/BusinessServices/IntefazSalesforce/GestionesMonetarias/wsdl/consultaGestionesMonetarias.wsdl`
  - **Descripción**: WSDL del adaptador de base de datos

- `Middleware/v2/BusinessServices/IntefazSalesforce/GestionesMonetarias/wsdl/consultaGestionesMonetarias_db.wsdl`
  - **Descripción**: WSDL específico del stored procedure

- `Middleware/v2/BusinessServices/OSB/ConsultaGestionesMonetarias_v2/wsdl/ConsultaGestionesMonetarias.wsdl`
  - **Descripción**: WSDL del business service OSB v2

### Esquemas Adicionales OSB v2
- `Middleware/v2/BusinessServices/OSB/ConsultaGestionesMonetarias_v2/xsd/XMLSchema_1132612532.xsd`
- `Middleware/v2/BusinessServices/OSB/ConsultaGestionesMonetarias_v2/xsd/XMLSchema_447818794.xsd`

## Properties

**No se encontraron archivos .properties específicos** para esta funcionalidad en el análisis del código fuente.

## Políticas OSB

### Políticas de Seguridad
- **Custom Token Authentication**: Configurada en el proxy principal
- **WSDL Policy Attachments**: Configuradas en ambos proxies
- **HTTPS**: Habilitado en el proxy principal

### Políticas de Monitoreo
- **Logging**: Habilitado en nivel debug
- **SLA Alerting**: Habilitado en nivel normal
- **Pipeline Alerting**: Habilitado en nivel normal
- **Reporting**: Habilitado

## Tests Relevantes

**No se encontraron tests específicos** para esta funcionalidad en el análisis del código fuente realizado.

## Archivos JAR (Deployments)

### Ambiente Productivo (PRD)
- `JAR/2018.9.2.0/MDA-2514/PRD/MWAPP_ConsultaGestionesMonetarias.jar`
- `JAR/2018.9.2.0/MDA-2514/PRD/MWINTERBANCA_ConsultaGestionesMonetarias.jar`
- `JAR/2018.9.2.0/MDA-2514/PRD/OMNICANAL_ConsultaGestionesMonetarias.jar`
- `JAR/2018.9.2.0/MDA-2514/PRD/PRD-DMZ_ConsultaGestionesMonetarias.jar`

### Ambiente QA
- `JAR/2018.9.2.0/MDA-2514/QA/OMNIQA_ConsultaGestionesMonetarias.jar`
- `JAR/2018.9.2.0/MDA-2514/QA/QA-DMZ_ConsultaGestionesMonetarias.jar`
- `JAR/2018.9.2.0/MDA-2514/QA/SOABUS_ConsultaGestionesMonetarias.jar`

## Dependencias Externas

### Servicios Dependientes
- **ValidaServicioRegional**: Servicio de validación regional
  - Ubicación: `Middleware/v2/BusinessServices/ValidaServicioRegional/biz/ValidaServicioRegional_db`
  - Función: Validar que la región sea válida para el servicio

- **MapeoErrores**: Servicio de mapeo de errores
  - Ubicación: `Middleware/v2/ProxyServices/MapeoErrores`
  - Función: Mapear códigos de error técnicos a códigos de negocio

### Recursos Generales
- `Middleware/v2/Resources/Generales/xq/validaServicioRegionalIn`
  - **Función**: Transformación para validación regional

- `Middleware/v2/Resources/Generales/xq/aplicarValoresPorDefectoRegion`
  - **Función**: Aplicar valores por defecto según región

- `Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageIn`
  - **Función**: Transformación de entrada para mapeo de errores

- `Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageOut`
  - **Función**: Transformación de salida para mapeo de errores

- `Middleware/v2/Resources/esquemas_generales/HeaderElements.xsd`
  - **Función**: Esquema de elementos de header comunes

## Resumen de Archivos por Categoría

| Categoría | Cantidad | Descripción |
|-----------|----------|-------------|
| **Proxy Services** | 2 | Servicios proxy principal y externo |
| **Business Services** | 3 | Adaptadores de base de datos y servicios OSB |
| **XQuery Transformaciones** | 9 | Transformaciones de entrada, salida y header por región |
| **Esquemas XSD** | 5 | Definiciones de tipos de datos |
| **WSDL** | 4 | Definiciones de servicios web |
| **Configuraciones JCA** | 1 | Configuración de adaptador de base de datos |
| **JAR Deployments** | 7 | Archivos de despliegue para diferentes ambientes |
| **Pipelines** | 8 | Pipelines definidos dentro del proxy principal |

**Total de archivos identificados**: 39 archivos principales más las dependencias externas.