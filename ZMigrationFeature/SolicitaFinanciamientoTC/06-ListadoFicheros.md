# Listado de Ficheros - SolicitaFinanciamientoTC

## Proxies (Proxy Services)

### Proxy Principal
- `Middleware/v2/ProxyServices/SolicitaFinanciamientoTC.proxy`
  - **Descripción**: Proxy service principal que maneja las solicitudes de financiamiento TC
  - **Binding**: SOAP 1.1
  - **Operación**: solicitaFinanciamientoTC
  - **Enrutamiento**: Por región (HN01, GT01, Default)

## Business Services

### Servicios de Base de Datos
- `Middleware/v2/BusinessServices/ProcesosHN/consultaOferta/biz/consultaOferta_db`
  - **Descripción**: Conexión a base de datos VASA para consultar ofertas en Honduras
  - **Operación**: consultaOferta
  - **Región**: HN01

- `Middleware/v2/BusinessServices/BLAZEGT/consultaOferta/biz/consultaOferta_db`
  - **Descripción**: Conexión a base de datos BLAZEGT para consultar ofertas en Guatemala
  - **Operación**: consultaOferta
  - **Región**: GT01

### Servicios Salesforce
- `Middleware/v2/BusinessServices/External/SalesforceHNIngresaGestionExtra/biz/SalesforceHNIngresaGestionExtra`
  - **Descripción**: Servicio Salesforce específico para Honduras
  - **Operación**: CrearExtra
  - **Región**: HN01

- `Middleware/v2/BusinessServices/External/SalesforceRGNIngresaGestionExtra/biz/SalesforceRGNIngresaGestionExtra`
  - **Descripción**: Servicio Salesforce regional para Guatemala
  - **Operación**: CrearExtra
  - **Región**: GT01

### Servicios de Validación
- `Middleware/v2/BusinessServices/ValidaServicioRegional/biz/ValidaServicioRegional_db`
  - **Descripción**: Validación de disponibilidad del servicio por región
  - **Operación**: ValidaServicioRegional

### Servicios de Parametrización
- `Middleware/Business_Resources/general/Resources/ObtenerParametrizacion/ObtenerParametrizacion`
  - **Descripción**: Obtención de parámetros de configuración
  - **Operación**: obtenerParametrizacion

### Servicios de Bitácora
- `Middleware/v2/BusinessServices/OSB/RegistrarBitacoraOSB_v2/biz/RegistrarBitacoraOSB_v2`
  - **Descripción**: Registro de bitácora de transacciones OSB
  - **Operación**: Registro automático

## Pipelines

### Pipelines de Request
- **Pipeline**: `SolicitaFinanciamientoTC_request` (HN01)
  - **Stages**:
    - ParametrizacionMiddleware
    - ConsultaOfertaCliente
    - AnalisisVasaVsSolicitudCliente
    - ConsultaCredencialesIngresoGestionPorExtrafinanciamiento
    - ConfirmacionIngresoGestionExtrafinanciamiento

- **Pipeline**: `SolicitaFinanciamientoTCGT_request` (GT01)
  - **Stages**:
    - ParametrizacionMiddleware
    - ConsultaOfertaCliente
    - AnalisisVasaVsSolicitudCliente
    - ConsultaCredencialesIngresoGestionPorExtrafinanciamiento
    - ConfirmacionIngresoGestionExtrafinanciamiento

- **Pipeline**: `Default_SolicitaFinanciamientoTC_request` (Otras regiones)
  - **Stages**:
    - FlujoEntrada

### Pipelines de Response
- **Pipeline**: `SolicitaFinanciamientoTC_response` (HN01)
  - **Stages**:
    - FlujoSalida

- **Pipeline**: `SolicitaFinanciamientoTCGT_response` (GT01)
  - **Stages**:
    - FlujoSalida

- **Pipeline**: `Default_SolicitaFinanciamientoTC_response` (Otras regiones)
  - **Stages**:
    - FlujoSalida

### Pipelines Generales
- **Pipeline**: `ValidacionesGenerales_request`
  - **Stages**:
    - ValidacionXSD
    - ValidacionServicioRegional
    - BitacoraRequest

- **Pipeline**: `ValidacionesGenerales_response`
  - **Stages**:
    - MapeoError
    - BitacoraResponse

### Error Handlers
- **Pipeline**: `_onErrorHandler-7908611298617121392--4ebd19fc.164898eb0db.-76ad` (HN01)
  - **Stages**:
    - errorHandlerIngresoGestionExtrafinanciamiento

- **Pipeline**: `_onErrorHandler-1384382121503434113--426f75e4.16fa9cf67de.-4acc` (GT01)
  - **Stages**:
    - errorHandlerIngresoGestionExtrafinanciamiento

- **Pipeline**: `_onErrorHandler-299465145049024412--217aff33.16481a1ebbc.-7d9e` (General)
  - **Stages**:
    - ManejoError
    - BitacoraResponseError

## XQuery/XSLT

### Transformaciones de Entrada (Request)
- `Middleware/v2/Resources/SolicitaFinanciamientoTC/xq/consultaOfertaIn.xq`
  - **Descripción**: Mapeo de request OSB a consulta de ofertas VASA (HN01)
  - **Función**: Mapear CUSTOMER_ID y CREDIT_LINE

- `Middleware/v2/Resources/SolicitaFinanciamientoTC/xq/consultaOfertaGTIn.xq`
  - **Descripción**: Mapeo de request OSB a consulta de ofertas BLAZEGT (GT01)
  - **Función**: Mapear CUSTOMER_ID y CREDIT_LINE

- `Middleware/v2/Resources/SolicitaFinanciamientoTC/xq/ingresaGestionExtraIn.xq`
  - **Descripción**: Mapeo de request OSB a Salesforce Honduras (HN01)
  - **Función**: Crear estructura CrearExtra con país "Honduras"

- `Middleware/v2/Resources/SolicitaFinanciamientoTC/xq/ingresaGestionExtraRGNGTIn.xq`
  - **Descripción**: Mapeo de request OSB a Salesforce Guatemala (GT01)
  - **Función**: Crear estructura CrearExtra con país "Guatemala"

### Transformaciones de Salida (Response)
- `Middleware/v2/Resources/SolicitaFinanciamientoTC/xq/solicitaFinanciamientoTCOut.xq`
  - **Descripción**: Mapeo de response Salesforce a response OSB (HN01)
  - **Función**: Construir solicitaFinanciamientoTCResponse con cálculos

- `Middleware/v2/Resources/SolicitaFinanciamientoTC/xq/solicitaFinanciamientoTCRGNGTOut.xq`
  - **Descripción**: Mapeo de response Salesforce a response OSB (GT01)
  - **Función**: Construir solicitaFinanciamientoTCResponse con cálculos

### Transformaciones de Sesión
- `Middleware/v2/Resources/SolicitaFinanciamientoTC/xq/sessionHeaderIn.xq`
  - **Descripción**: Construcción de header de sesión Salesforce
  - **Función**: Agregar sessionId al header SOAP

### Transformaciones de Validación
- `Middleware/v2/Resources/SolicitudFinanciamientoTC/xq/validaCondicionesCredito.xq`
  - **Descripción**: Validación de condiciones crediticias
  - **Función**: Verificar disponibilidad de ofertas para monto/plazo/moneda

## Java Callouts

### Clases Java de Cálculo
- `Java/CalculaCuotaFinanciamientoTC/src/main/java/co/com/cidenet/calcularcuota/Application.java`
  - **Descripción**: Aplicación Java para cálculo de cuotas de financiamiento
  - **Función**: Cálculos financieros complementarios

- `Java/CalculaCuotaFinanciamientoTC/src/main/java/co/com/cidenet/model/Cuota.java`
  - **Descripción**: Modelo de datos para cuotas
  - **Función**: Estructura de datos para cálculos

- `Java/CalculaCuotaFinanciamientoTCHN/src/main/java/co/com/cidenet/calcularcuota/Application.java`
  - **Descripción**: Aplicación Java específica para Honduras
  - **Función**: Cálculos financieros específicos HN

- `Java/CalculaCuotaFinanciamientoTCHN/src/main/java/co/com/cidenet/model/Cuota.java`
  - **Descripción**: Modelo de datos para cuotas Honduras
  - **Función**: Estructura de datos específica HN

### JARs Compilados
- `Middleware/v2/Resources/Utilities/Java/CalculaCuotaFinanciamientoTC.jar`
  - **Descripción**: JAR compilado para cálculos generales

- `Middleware/v2/Resources/Utilities/Java/CalculaCuotaFinanciamientoTCHN.jar`
  - **Descripción**: JAR compilado para cálculos Honduras

## POJOs

### Proyectos Maven
- `Java/CalculaCuotaFinanciamientoTC/pom.xml`
  - **Descripción**: Configuración Maven para proyecto general
  - **Dependencias**: Librerías de cálculo financiero

- `Java/CalculaCuotaFinanciamientoTCHN/pom.xml`
  - **Descripción**: Configuración Maven para proyecto Honduras
  - **Dependencias**: Librerías específicas HN

## Configuración

### WSDL
- `Middleware/v2/Resources/SolicitaFinanciamientoTC/wsdl/solicitaFinanciamientoTCPS.wsdl`
  - **Descripción**: Contrato WSDL del servicio
  - **Operaciones**: solicitaFinanciamientoTC
  - **Tipos**: Referencia a solicitudFinanciamientoTCTypes.xsd

### XSD (Esquemas)
- `Middleware/v2/Resources/SolicitudFinanciamientoTC/xsd/solicitudFinanciamientoTCTypes.xsd`
  - **Descripción**: Definición de tipos de datos
  - **Elementos**: solicitaFinanciamientoTC, solicitaFinanciamientoTCResponse
  - **Tipos**: Enumeraciones, tipos complejos, validaciones

### Properties
- **No encontrados archivos .properties específicos**
- **Configuración**: A través de servicio ObtenerParametrizacion

## Políticas (Policies)

### Políticas de Seguridad
- **WS-Policy**: Configurado en binding-mode wsdl-policy-attachments
- **Autenticación**: A través de headers SOAP

### Políticas de Timeout
- **No encontradas políticas específicas de timeout**
- **Configuración**: A nivel de Business Service

## Tests

### Tests Unitarios Java
- `Java/CalculaCuotaFinanciamientoTC/src/test/java/test/Test.java`
  - **Descripción**: Tests unitarios para cálculos generales

- `Java/CalculaCuotaFinanciamientoTCHN/src/test/java/test/Test.java`
  - **Descripción**: Tests unitarios para cálculos Honduras

### Tests OSB
- **No encontrados tests específicos OSB**
- **Recomendación**: Crear tests de integración

## Archivos de Despliegue (JARs)

### Versiones de Producción
- `JAR/MAN-3975/PRD/MAN-3975-solicitaFinanciamientoTC.jar`
- `JAR/PM-7608/PRD/SolicitaFinanciamientoTC_PRD.jar`
- `JAR/2019.9.1.5/Hotfix/PM-71/PRD/SolicitaFinanciamientoTC.jar`
- `JAR/2019.9.1.5/Hotfix/PM-71/PRD/SolicitaFinanciamientoTC_DMZ.jar`

### Versiones de QA
- `JAR/MAN-3975/QA/MAN-3975-solicitaFinanciamientoTC.jar`
- `JAR/PM-7608/QA/SolicitaFinanciamientoTC_QA.jar`
- `JAR/2019.9.1.5/Hotfix/PM-71/QA/SolicitaFinanciamientoTC.jar`
- `JAR/2019.9.1.5/Hotfix/PM-71/QA/SolicitaFinanciamientoTC_DMZ.jar`

## Archivos de Configuración de Despliegue

### Configuraciones MDA
- `JAR/2020.8.1.0/MDA-11608/PRD_DMZ/MDA-11608_SolicitudFinanciamientoTC_DMZ_PRD.xml`
- `JAR/2020.8.1.0/MDA-11608/PRD_OMNI/MDA-11608_SolicitudFinanciamientoTC_OMNI_PRD.xml`
- `JAR/2020.8.1.0/MDA-11608/QA_OMNI/MDA-11608_SolicitudFinancimientoTC_ConfigToQA_OMNI.xml`

### Configuraciones PG
- `JAR/2020.8.2.0/PG-2791/PRD/PG-2791-RMT-112_SolicitudFinanciamientoTC.jar`
- `JAR/2020.8.2.0/PG-2791/QA/PG-2791-RMT-112_SolicitudFinanciamientoTC.jar`

## Archivos de Migración

### Versiones de Migración Procesador
- `JAR/V.HN.MIGRACION.PROCESADOR/PG-5293/PRD/PG_5293_SolicitaFinanciamento.jar`
- `JAR/V.HN.MIGRACION.PROCESADOR/PG-5293/PRD/PG_5293_SolicitaFinanciamento_DMZ.jar`
- `JAR/V.HN.MIGRACION.PROCESADOR/PG-5293/QA/PG_5293_SolicitaFinanciamento.jar`
- `JAR/V.HN.MIGRACION.PROCESADOR/PG-5293/QA/PG_5293_SolicitaFinanciamento_DMZ_Fix_3.jar`
- `JAR/V.HN.MIGRACION.PROCESADOR/PG-5293/QA/PG_5293_SolicitaFinanciamento_Fix_1.jar`
- `JAR/V.HN.MIGRACION.PROCESADOR/PG-5293/QA/PG_5293_SolicitaFinanciamento_Fix_2.jar`
- `JAR/V.HN.MIGRACION.PROCESADOR/PG-5293/QA/PG_5293_SolicitaFinanciamento_Fix_4.jar`
- `JAR/V.HN.MIGRACION.PROCESADOR/PG-5293/QA/PG_5293_SolicitaFinanciamento_Fix_5.jar`

## Archivos de Dependencias Generales

### Recursos Generales
- `Middleware/v2/Resources/Generales/xq/validaServicioRegionalIn.xq`
- `Middleware/v2/Resources/Generales/xq/aplicarValoresPorDefectoRegion.xq`
- `Middleware/v2/Resources/Generales/xq/credencialSalesforceIn.xq`
- `Middleware/v2/Resources/Generales/xq/registrarBitacoraOSBIn.xq`
- `Middleware/Business_Resources/general/UUID/obtenerUUID.xq`
- `Middleware/Business_Resources/general/Parametrizacion/obtenerParametrizacionIn.xq`

### Recursos de Mapeo de Errores
- `Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageIn.xq`
- `Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageOut.xq`

### Esquemas Generales
- `Middleware/v2/Resources/esquemas_generales/HeaderElements.xsd`

## Resumen de Conteo

- **Proxies**: 1
- **Business Services**: 6
- **Pipelines**: 11 (incluyendo error handlers)
- **XQuery Files**: 8
- **Java Classes**: 4
- **JAR Files**: 2 (utilities)
- **WSDL Files**: 1
- **XSD Files**: 1
- **Test Files**: 2
- **Deployment JARs**: 20+
- **Configuration Files**: 5+

**Total aproximado**: 60+ archivos directamente relacionados con la funcionalidad