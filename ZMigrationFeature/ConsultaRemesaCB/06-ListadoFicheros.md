# Listado de Ficheros - ConsultaRemesaCB

## Proxies (Proxy Services)

### Proxy Principal
- `Middleware/v2/ProxyServices/ConsultaRemesaCB.proxy`

### Proxies Dependientes
- `Middleware/v2/ProxyServices/ConsultaRemesas.proxy`
- `Middleware/v2/ProxyServices/OperacionesCriptograficas.proxy`
- `Middleware/v2/ProxyServices/MapeoErrores.proxy`
- `Middleware/v2/ProxyServices/EvaluaListasCliente.proxy`

### Proxies Seguros (SProxyServices)
- `Middleware/v2/SProxyServices/ConsultaRemesasS.proxy`

## Business Services

### Base de Datos - Middleware (ORA_BANK)
- `Middleware/v2/BusinessServices/MDW/obtenerTipoRemesadora/biz/ObtenerTipoRemesadora_db.biz`
- `Middleware/v2/BusinessServices/MDW/consultarCorresponsalB/biz/consultarCorresponsalB_db.biz`
- `Middleware/v2/BusinessServices/ValidaServicioRegional/biz/ValidaServicioRegional_db.biz`
- `Middleware/v2/BusinessServices/MDW/LimitesTransaccionalesTNG/limiteTrxregistrar/biz/limiteTrxRegistrar_db.biz`
- `Middleware/Business_Resources/general/Resources/ObtenerParametrizacion/ObtenerParametrizacion.biz`

### Base de Datos - Convenios (TERCEROS/FLINK)
- `Middleware/v2/BusinessServices/ConsultarRemLocalId/biz/consultarRemLocalId_db.biz`
- `Middleware/v2/BusinessServices/consultarRemFRemXPagador/biz/consultarRemFRemXPagador_db.biz`
- `Middleware/v2/BusinessServices/armarMensajeRecaudo/biz/armarMensajeRecaudo_db.biz`
- `Middleware/v2/BusinessServices/MDW/obtenerCamposRemesasRel/biz/obtenerCamposRemesasRel_db.biz`
- `Middleware/v2/BusinessServices/registraRelConsPagoRem/biz/ingresoRelConsPagoRem_db.biz`

### Servicios HTTP
- `Middleware/v2/BusinessServices/enrutadorConvenios/biz/enrutadorConvenios.biz`

### Servicios de Flujo (BPEL)
- `Middleware/v2/BusinessServices/SJS/consultaMultipleRemesadoras/biz/sjConsultaMultipleRemesadoras.biz`
- `Middleware/v2/BusinessServices/Remesas/biz/sjConsultaRemesaResiliencia.biz`

### Servicios Externos
- `Middleware/External/Incoming/v2/BussinessServices/ConsultaRemesas/biz/consultaRemesas.biz`

## Pipelines y Flows

### BPEL Flows
- `Middleware/v2/BusinessServices/SJS/consultaMultipleRemesadoras/flow/sjConsultaMultipleRemesadoras.flow`
- `Middleware/v2/BusinessServices/Remesas/flow/sjConsultaRemesaResiliencia.flow`

## XQuery Transformaciones

### ConsultaRemesaCB - Transformaciones Principales
- `Middleware/v2/Resources/ConsultaRemesasCB/xq/consultaRemesaCBHeaderIn.xq`
- `Middleware/v2/Resources/ConsultaRemesasCB/xq/consultaRemesaCBIn.xq`
- `Middleware/v2/Resources/ConsultaRemesasCB/xq/consultaRemesaCBOut.xq`
- `Middleware/v2/Resources/ConsultaRemesasCB/xq/limiteTransacionalRegistrarIn.xq`

### ConsultaRemesas - Transformaciones Core
- `Middleware/v2/Resources/ConsultaRemesas/xq/validarTipoConsulta.xq`
- `Middleware/v2/Resources/ConsultaRemesas/xq/obtenerTipoRemesadoraIn.xq`
- `Middleware/v2/Resources/ConsultaRemesas/xq/consultaRemesaT24In.xq`
- `Middleware/v2/Resources/ConsultaRemesas/xq/consultaRemLocalIdIn.xq`
- `Middleware/v2/Resources/ConsultaRemesas/xq/consultaRemLocalIdOut.xq`
- `Middleware/v2/Resources/ConsultaRemesas/xq/consultaFRemPagIdIn.xq`
- `Middleware/v2/Resources/ConsultaRemesas/xq/consultaRemFRemIdOut.xq`
- `Middleware/v2/Resources/ConsultaRemesas/xq/sjconsultaMultipleRemesadorasIn.xq`
- `Middleware/v2/Resources/ConsultaRemesas/xq/EnrutadorConveniosOut.xq`
- `Middleware/v2/Resources/ConsultaRemesas/xq/consultaRemesasOut.xq`
- `Middleware/v2/Resources/ConsultaRemesas/xq/obtenerCamposRemesasRelIn.xq`
- `Middleware/v2/Resources/ConsultaRemesas/xq/generaEntradaRelConsPagoConv.xq`
- `Middleware/v2/Resources/ConsultaRemesas/xq/ingRelConsPagoConv.xq`
- `Middleware/v2/Resources/ConsultaRemesas/xq/ingresoRelConsPagoRem.xq`
- `Middleware/v2/Resources/ConsultaRemesas/xq/ingresoRelConsPagFRem.xq`

### Múltiples Remesadoras - Transformaciones
- `Middleware/v2/BusinessServices/SJS/consultaMultipleRemesadoras/xq/armarInfoParametrosRemesas.xq`
- `Middleware/v2/BusinessServices/SJS/consultaMultipleRemesadoras/xq/enrutadorConveniosIn.xq`
- `Middleware/v2/BusinessServices/SJS/consultaMultipleRemesadoras/xq/sjConsultaMultipleRemesadoraOut.xq`

### Validaciones y Utilidades
- `Middleware/Business_Resources/remesas/ConsultaRemesas/validarTipoRemesaLocal.xq`
- `Middleware/Business_Resources/remesas/ConsultaRemesas/validarOrigenRemesaLocal.xq`
- `Middleware/Business_Resources/remesas/ConsultaRemesas/validarTipoRemesadora.xq`
- `Middleware/v2/Resources/Genericos/consultarCorresponsalBIn.xq`
- `Middleware/v2/Resources/Generales/xq/validaServicioRegionalIn.xq`
- `Middleware/v2/Resources/Generales/xq/aplicarValoresPorDefectoRegion.xq`
- `Middleware/Business_Resources/general/Parametrizacion/obtenerParametrizacionIn.xq`

### Operaciones Criptográficas
- `Middleware/v2/Resources/OperacionesCriptograficas/xq/descifrarDatosIn.xq`

### Mapeo de Errores
- `Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageIn.xq`
- `Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageOut.xq`

### Evaluación de Listas
- `Middleware/v2/Resources/EvaluaListasCliente/xq/evaluaListasClienteConsultaRemesaIn.xq`

## XSLT Transformaciones

### Legacy Business Resources
- `Middleware/Business_Resources/remesas/ConsultaRemesas/consultaRemesasHeaderOut.xq`
- `Middleware/Business_Resources/remesas/ConsultaRemesas/consultaRemesasIn.xq`
- `Middleware/Business_Resources/remesas/ConsultaRemesas/consultaRemesasOut.xq`
- `Middleware/Business_Resources/remesas/ConsultaRemesas/EnrutadorConveniosHeaderOut.xq`
- `Middleware/Business_Resources/remesas/ConsultaRemesas/EnrutadorConveniosIn.xq`
- `Middleware/Business_Resources/remesas/ConsultaRemesas/EnrutadorConveniosOut.xq`
- `Middleware/Business_Resources/remesas/ConsultaRemesas/consultaRemFRemIdHeaderOut.xq`
- `Middleware/Business_Resources/remesas/ConsultaRemesas/consultaRemFRemIdIn.xq`
- `Middleware/Business_Resources/remesas/ConsultaRemesas/ConsultaRemFRemIdOut.xq`
- `Middleware/Business_Resources/remesas/ConsultaRemesas/consultaRemLocalIdHeaderOut.xq`
- `Middleware/Business_Resources/remesas/ConsultaRemesas/consultaRemLocalIdIn.xq`
- `Middleware/Business_Resources/remesas/ConsultaRemesas/consultaRemLocalIdOut.xq`
- `Middleware/Business_Resources/remesas/ConsultaRemesas/consultaRemLocalNomHeaderOut.xq`
- `Middleware/Business_Resources/remesas/ConsultaRemesas/consultaRemLocalNomIn.xq`
- `Middleware/Business_Resources/remesas/ConsultaRemesas/consultaRemLocalNomOut.xq`
- `Middleware/Business_Resources/remesas/ConsultaRemesas/validarTipoRemesaLocal.xq`
- `Middleware/Business_Resources/remesas/ConsultaRemesas/validarOrigenRemesaLocal.xq`
- `Middleware/Business_Resources/remesas/ConsultaRemesas/validarTipoRemesadora.xq`
- `Middleware/Business_Resources/remesas/ConsultaRemesas/requestEnrutador.xq`

## Java Callouts

### No se encontraron Java Callouts específicos para ConsultaRemesaCB

## POJOs

### No se encontraron POJOs específicos para ConsultaRemesaCB

## Configuración

### WSDL - Contratos de Servicio
- `Middleware/v2/Resources/ConsultaRemesasCB/wsdl/consultaRemesaCB.wsdl`
- `Middleware/v2/Resources/ConsultaRemesas/wsdl/consultaRemesasPS.wsdl`
- `Middleware/v2/BusinessServices/MDW/obtenerTipoRemesadora/wsdl/ObtenerTipoRemesadora_db.wsdl`
- `Middleware/v2/BusinessServices/MDW/obtenerTipoRemesadora/wsdl/ObtenerTipoRemesadora.wsdl`
- `Middleware/v2/BusinessServices/ConsultarRemLocalId/wsdl/consultarRemLocalId_db.wsdl`
- `Middleware/v2/BusinessServices/consultarRemFRemXPagador/wsdl/consultarRemFRemXPagador_db.wsdl`
- `Middleware/v2/BusinessServices/armarMensajeRecaudo/wsdl/armarMensajeRecaudo_db.wsdl`
- `Middleware/v2/BusinessServices/enrutadorConvenios/wsdl/enrutadorConvenios.wsdl`
- `Middleware/v2/BusinessServices/SJS/consultaMultipleRemesadoras/wsdl/sjConsultaMultipleRemesadoras.wsdl`
- `Middleware/v2/BusinessServices/Remesas/wsdl/sjConsultaRemesaResiliencia.wsdl`

### XSD - Esquemas de Datos
- `Middleware/v2/Resources/ConsultaRemesasCB/xsd/consultaRemesasCBTypes.xsd`
- `Middleware/v2/Resources/ConsultaRemesas/xsd/consultaRemesasTypes.xsd`
- `Middleware/v2/BusinessServices/MDW/obtenerTipoRemesadora/xsd/ObtenerTipoRemesadora_sp.xsd`
- `Middleware/v2/BusinessServices/ConsultarRemLocalId/xsd/consultarRemLocalId_sp.xsd`
- `Middleware/v2/BusinessServices/consultarRemFRemXPagador/xsd/consultarRemFRemXPagador_sp.xsd`
- `Middleware/v2/BusinessServices/armarMensajeRecaudo/xsd/FLINK_OSB_K_RECAUDOS_REF_ONLINE_OSB_ARMAR_MENSAJE.xsd`
- `Middleware/v2/BusinessServices/SJS/consultaMultipleRemesadoras/xsd/sjConsultaMultipleRemesadoras.xsd`
- `Middleware/v2/BusinessServices/MDW/LimitesTransaccionalesTNG/limiteTrxregistrar/xsd/limiteTrxRegistrar_sp.xsd`

### Esquemas Generales
- `Middleware/v2/Resources/esquemas_generales/HeaderElementsCB.xsd`
- `Middleware/v2/Resources/esquemas_generales/HeaderElements.xsd`

### JCA - Adaptadores de Base de Datos
- `Middleware/v2/BusinessServices/MDW/obtenerTipoRemesadora/jca/ObtenerTipoRemesadora_db.jca`
- `Middleware/v2/BusinessServices/ConsultarRemLocalId/jca/consultarRemLocalId_db.jca`
- `Middleware/v2/BusinessServices/consultarRemFRemXPagador/jca/consultarRemFRemXPagador_db.jca`
- `Middleware/v2/BusinessServices/armarMensajeRecaudo/jca/armarMensajeRecaudo_db.jca`
- `Middleware/v2/BusinessServices/MDW/LimitesTransaccionalesTNG/limiteTrxregistrar/jca/limiteTrxRegistrar_db.jca`

## Properties

### No se encontraron archivos .properties específicos

## Policies

### No se encontraron políticas específicas configuradas

## Tests Relevantes

### JAR Files - Posibles Tests
- `JAR/2022.06.1.0/MDA-29237/PRD/MDA-29237_ConsultaRemesaCB.jar`
- `JAR/2022.06.1.0/MDA-29237/QA/MDA-29237_ConsultaRemesaCB.jar`
- `JAR/2022.06.1.0/MDA-29237/PRD/MDA-29237_ConsultaRemesa.jar`
- `JAR/2022.06.1.0/MDA-29237/QA/MDA-29237_ConsultaRemesa.jar`

### Legacy JAR Files
- `JAR/2018.12.1.0/MDA-4617/ConsultaRemesas.jar`
- `JAR/2018.7.1.0/PRD/MDA-2245_ConsultaRemesa.jar`
- `JAR/2018.7.1.0/QA/MDA-2245_ConsultaRemesa.jar`
- `JAR/2021.6.1.4/MDA-27651/PRD/MDA-27651_ConsultaRemesas.jar`
- `JAR/2021.6.1.4/MDA-27651/QA/MDA-27651_ConsultaRemesas.jar`

## Archivos de Configuración Adicionales

### Certificados
- `Certificados/` (directorio con certificados de seguridad)

### Archivos de Entrada/Salida
- `DebitosGTIn.xq` (transformación para débitos Guatemala)
- `DebitosHNIn.xq` (transformación para débitos Honduras)

## Archivos de Recursos Legacy

### Business Resources - Remesas
- `Middleware/Business_Resources/remesas/ConsultaRemesas/consultaRemesasPS.wsdl`
- `Middleware/Business_Resources/remesas/ConsultaRemesas/consultaRemesasTypes.xsd`
- `Middleware/Business_Resources/remesas/ConsultaRemesas/consultaRemesasValidate.xq`
- `Middleware/Business_Resources/remesas/ConsultaRemesas/requestEnrutador.xq`
- `Middleware/Business_Resources/remesas/ConsultaRemesas/validarTipoConsulta.xq`

### Operaciones y Ejecución
- `Middleware/OperationsAndExecution/Payments/ConsultaRemesas.proxy`

### Middleware Caja
- `MiddlewareCaja/Resources/xqueries/PagoRemesas/ConsultaRemesaIn.xq`
- `MiddlewareCaja/Resources/xqueries/PagoRemesas/ConsultaRemesaValidate.xq`

## Archivos de Migración y Versionado

### Archivos de Lectura
- `leeme.txt` (instrucciones de despliegue)

### Archivos de Workspace
- `DynamoMigrate.jws` (workspace de JDeveloper)

## Resumen de Conteo de Archivos

| Tipo de Archivo | Cantidad |
|-----------------|----------|
| **Proxy Services** | 5 |
| **Business Services** | 15 |
| **XQuery Files** | 45+ |
| **WSDL Files** | 12 |
| **XSD Files** | 10 |
| **JCA Files** | 5 |
| **BPEL Flows** | 2 |
| **JAR Files** | 8 |
| **Legacy Resources** | 20+ |

## Notas Importantes

1. **Rutas Relativas**: Todas las rutas están expresadas desde la raíz del proyecto OSB (`ficohsacore-osb-7e5cceccb837/`)

2. **Dependencias Críticas**: Los archivos más críticos para la funcionalidad son:
   - `ConsultaRemesaCB.proxy` (punto de entrada)
   - `ConsultaRemesas.proxy` (lógica principal)
   - Transformaciones XQuery en `ConsultaRemesasCB/xq/`
   - Business Services de base de datos

3. **Archivos Legacy**: Existen múltiples versiones y archivos legacy que pueden no estar en uso activo

4. **Configuración de Seguridad**: Los certificados y configuraciones de seguridad están en directorios separados

5. **Versionado**: Los archivos JAR indican diferentes versiones y ambientes (PRD/QA) del servicio

6. **Estructura Modular**: La funcionalidad está distribuida en múltiples módulos y capas, siguiendo patrones de arquitectura SOA

7. **Transformaciones Complejas**: Existe una gran cantidad de transformaciones XQuery que manejan el mapeo entre diferentes estructuras de datos

8. **Múltiples Fuentes de Datos**: Los archivos reflejan la integración con múltiples sistemas (T24, FLink, Enrutador de Convenios)