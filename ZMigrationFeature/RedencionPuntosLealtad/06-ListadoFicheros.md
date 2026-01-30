# Listado de Ficheros - Redención de Puntos de Lealtad

## Proxy Services

### Proxy Principal y Regionales

| Archivo | Ruta Relativa | Descripción |
|---------|---------------|-------------|
| RedencionPuntosLealtad.proxy | Middleware/v2/ProxyServices/RedencionPuntosLealtad.proxy | Proxy principal con enrutamiento regional |
| RedencionPuntosLealtadHN.proxy | Middleware/v2/ProxyServices/RedencionPuntosLealtadHN.proxy | Implementación Honduras |
| RedencionPuntosLealtadGT.proxy | Middleware/v2/ProxyServices/RedencionPuntosLealtadGT.proxy | Implementación Guatemala |
| RedencionPuntosLealtadPA.proxy | Middleware/v2/ProxyServices/RedencionPuntosLealtadPA.proxy | Implementación Panamá |
| RedencionPuntosLealtadNI.proxy | Middleware/v2/ProxyServices/RedencionPuntosLealtadNI.proxy | Implementación Nicaragua |
| RedencionPuntosLealtadFacade.proxy | Middleware/v2/ProxyServices/RedencionPuntosLealtadFacade.proxy | Facade (si existe) |

## Business Services

### Servicios de Programas de Lealtad

| Archivo | Ruta Relativa | Descripción |
|---------|---------------|-------------|
| RedemptionService.bix | Middleware/v2/BusinessServices/Mastercard/RedemptionService/biz/RedemptionService.bix | Servicio Mastercard Rewards |
| visionPlus.bix | Middleware/v2/BusinessServices/VisionPlus/visionPlus/biz/visionPlus.bix | Servicio VisionPlus/FDCS |

### Servicios de Base de Datos - Honduras

| Archivo | Ruta Relativa | Descripción |
|---------|---------------|-------------|
| canjearPuntosEfectivo_db.bix | Middleware/v2/BusinessServices/ABK/canjearPuntosEfectivo/biz/canjearPuntosEfectivo_db.bix | Conversión puntos HN |
| conInfoLealtad_db.bix | Middleware/v2/BusinessServices/ProcesosHN/conInfoLealtad/biz/conInfoLealtad_db.bix | Info lealtad HN |
| conDatoCuenta_db.bix | Middleware/v2/BusinessServices/MasterDataHN/conDatoCuenta/biz/conDatoCuenta_db.bix | Datos cuenta HN |

### Servicios de Base de Datos - Guatemala

| Archivo | Ruta Relativa | Descripción |
|---------|---------------|-------------|
| canjearPuntosEfectivo_db.bix | Middleware/v2/BusinessServices/ABKGT/canjearPuntosEfectivo/biz/canjearPuntosEfectivo_db.bix | Conversión puntos GT |
| conDatoCuenta_db.bix | Middleware/v2/BusinessServices/MasterDataGT/conDatoCuenta/biz/conDatoCuenta_db.bix | Datos cuenta GT |

### Servicios de Base de Datos - Panamá/Nicaragua

| Archivo | Ruta Relativa | Descripción |
|---------|---------------|-------------|
| canjearPuntosEfectivo_db.bix | Middleware/v2/BusinessServices/PXYNIC/canjearPuntosEfectivo/biz/canjearPuntosEfectivo_db.bix | Conversión puntos PA/NI |
| conDatoCuenta_db.bix | Middleware/v2/BusinessServices/MasterDataPA/conDatoCuenta/biz/conDatoCuenta_db.bix | Datos cuenta PA |

### Servicios de Base de Datos - Comunes

| Archivo | Ruta Relativa | Descripción |
|---------|---------------|-------------|
| consultaProgramaLealtad_db.bix | Middleware/v2/BusinessServices/INTFC/consultaProgramaLealtad/biz/consultaProgramaLealtad_db.bix | Consulta programa lealtad |
| obtenerTipoProgramaLealtad_db.bix | Middleware/v2/BusinessServices/INTFC/obtenerTipoProgramaLealtad/biz/obtenerTipoProgramaLealtad_db.bix | Tipo programa (NI) |
| INSTransaccionRedencion_db.bix | Middleware/v2/BusinessServices/MasterData/iNSTransaccionRedencion/biz/INSTransaccionRedencion_db.bix | Registro transacción |
| ValidaServicioRegional_db.bix | Middleware/v2/BusinessServices/ValidaServicioRegional/biz/ValidaServicioRegional_db.bix | Validación regional |
| sjConsultaTipoTarjeta.bix | Middleware/v2/BusinessServices/SJS/consultaTipoTarjeta/biz/sjConsultaTipoTarjeta.bix | Tipo tarjeta HN |
| sjConsultaTipoTarjetaNI.bix | Middleware/v2/BusinessServices/SJS/consultaTipoTarjetaNI/biz/sjConsultaTipoTarjetaNI.bix | Tipo tarjeta NI |

### Servicios Core Banking

| Archivo | Ruta Relativa | Descripción |
|---------|---------------|-------------|
| consultasClienteBS.bix | Middleware/Business_Resources/consultasCliente/Resources/consultasClienteBS.bix | Consulta cliente T24 |
| tarjetasDebitoBS.bix | Middleware/Business_Resources/tarjetasDebito/Resources/tarjetasDebitoBS.bix | Tarjetas débito T24 |
| transaccionesAlcance.bix | Middleware/v2/BusinessServices/transaccionesAlcance/biz/transaccionesAlcance.bix | Info tarjeta Alcance |

### Servicios de Soporte

| Archivo | Ruta Relativa | Descripción |
|---------|---------------|-------------|
| MapeoErrores.proxy | Middleware/v2/ProxyServices/MapeoErrores.proxy | Mapeo errores |
| ObtenerParametrizacion.bix | Middleware/Business_Resources/general/Resources/ObtenerParametrizacion/ObtenerParametrizacion.bix | Parámetros config |

## Pipelines

No se detectaron pipelines separados. La lógica está contenida en los proxy services.

## XQuery Transformations

### Transformaciones Específicas de Redención

| Archivo | Ruta Relativa | Descripción |
|---------|---------------|-------------|
| redencionPuntosLealtadValidate.xq | Middleware/v2/Resources/RedencionPuntosLealtad/xq/redencionPuntosLealtadValidate.xq | Validación request |
| doItemRedemptionIn.xq | Middleware/v2/Resources/RedencionPuntosLealtad/xq/doItemRedemptionIn.xq | Request Mastercard |
| redencionPuntosLealtadOut.xq | Middleware/v2/Resources/RedencionPuntosLealtad/xq/redencionPuntosLealtadOut.xq | Response genérico |
| redencionPuntosLealtadHNOut.xq | Middleware/v2/Resources/RedencionPuntosLealtad/xq/redencionPuntosLealtadHNOut.xq | Response HN |
| redencionPuntosLealtadGTOut.xq | Middleware/v2/Resources/RedencionPuntosLealtad/xq/redencionPuntosLealtadGTOut.xq | Response GT |
| redencionPuntosLealtadNIOut.xq | Middleware/v2/Resources/RedencionPuntosLealtad/xq/redencionPuntosLealtadNIOut.xq | Response NI/PA |
| insTransaccionRedencion.xq | Middleware/v2/Resources/RedencionPuntosLealtad/xq/insTransaccionRedencion.xq | Registro transacción GT |
| insTransaccionRedencionIn.xq | Middleware/v2/Resources/RedencionPuntosLealtad/xq/insTransaccionRedencionIn.xq | Registro transacción HN |
| pointsRedeemIn.xq | Middleware/v2/Resources/RedencionPuntosLealtad/xq/pointsRedeemIn.xq | Request VisionPlus HN |
| pointsRedeemGTIn.xq | Middleware/v2/Resources/RedencionPuntosLealtad/xq/pointsRedeemGTIn.xq | Request VisionPlus GT |
| pointsRedeemNIIn.xq | Middleware/v2/Resources/RedencionPuntosLealtad/xq/pointsRedeemNIIn.xq | Request VisionPlus NI |

### Transformaciones de Programa de Lealtad

| Archivo | Ruta Relativa | Descripción |
|---------|---------------|-------------|
| canjearPuntosEfectivoHNIn.xq | Middleware/v2/Resources/ProgramaLealtad/xq/canjearPuntosEfectivoHNIn.xq | Conversión puntos HN |
| canjearPuntosEfectivoGTIn.xq | Middleware/v2/Resources/ProgramaLealtad/xq/canjearPuntosEfectivoGTIn.xq | Conversión puntos GT |
| conversionPuntosNIIn.xq | Middleware/v2/Resources/ProgramaLealtad/xq/conversionPuntosNIIn.xq | Conversión puntos NI/PA |
| conversionPuntosIn.xq | Middleware/v2/Resources/ProgramaLealtad/xq/conversionPuntosIn.xq | Conversión puntos genérico |
| conInfoLealtadHNIn.xq | Middleware/v2/Resources/ProgramaLealtad/xq/conInfoLealtadHNIn.xq | Info lealtad HN |
| consultaProgramaLealtadIn.xq | Middleware/v2/Resources/ProgramaLealtad/xq/consultaProgramaLealtadIn.xq | Consulta programa |
| consultaTipoTarjetaNIIn.xq | Middleware/v2/Resources/ProgramaLealtad/xq/consultaTipoTarjetaNIIn.xq | Tipo tarjeta NI |
| MRSIdentity.xq | Middleware/v2/Resources/ProgramaLealtad/xq/MRSIdentity.xq | Header Mastercard |

### Transformaciones Genéricas

| Archivo | Ruta Relativa | Descripción |
|---------|---------------|-------------|
| consultaClienteHNIn.xq | Middleware/v2/Resources/Genericos/consultaClienteHNIn.xq | Consulta cliente T24 |
| consultaClienteLegalHNIn.xq | Middleware/v2/Resources/Genericos/consultaClienteLegalHNIn.xq | Consulta cliente por legal ID |
| consultaTipoTarjetaHNIn.xq | Middleware/v2/Resources/Genericos/consultaTipoTarjetaHNIn.xq | Tipo tarjeta HN |
| consultaInfoTDHNIn.xq | Middleware/v2/Resources/Genericos/consultaInfoTDHNIn.xq | Info tarjeta débito |
| consultaInfoTCHNIn.xq | Middleware/v2/Resources/Genericos/consultaInfoTCHNIn.xq | Info tarjeta crédito |
| conDatoCuentaHNIn.xq | Middleware/v2/Resources/MasterDataHN/xq/conDatoCuentaHNIn.xq | Datos cuenta HN |
| conDatoCuentaGTIn.xq | Middleware/v2/Resources/MasterDataGT/xq/conDatoCuentaGTIn.xq | Datos cuenta GT |
| conDatoCuentaPAIn.xq | Middleware/v2/Resources/MasterDataPA/xq/conDatoCuentaPAIn.xq | Datos cuenta PA |
| obtenerTipoProgramaLealtadIn.xq | Middleware/v2/Resources/Genericos/obtenerTipoProgramaLealtadIn.xq | Tipo programa NI |
| pointsAdjustmentInquiryIn.xq | Middleware/v2/Resources/VisionPlus/xq/pointsAdjustmentInquiryIn.xq | Consulta saldo VP |
| validaServicioRegionalIn.xq | Middleware/v2/Resources/Generales/xq/validaServicioRegionalIn.xq | Validación regional |
| aplicarValoresPorDefectoRegion.xq | Middleware/v2/Resources/Generales/xq/aplicarValoresPorDefectoRegion.xq | Valores por defecto |
| convertirCodigoPais.xq | Middleware/v2/Resources/Generales/xq/convertirCodigoPais.xq | Conversión código país |
| mapeoErroresUsageIn.xq | Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageIn.xq | Mapeo errores entrada |
| mapeoErroresUsageOut.xq | Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageOut.xq | Mapeo errores salida |
| obtenerParametrizacionIn.xq | Middleware/Business_Resources/general/Parametrizacion/obtenerParametrizacionIn.xq | Parámetros entrada |

## XSLT Transformations

No se detectaron transformaciones XSLT. Todas las transformaciones son XQuery.

## XSD Schemas

### Schemas Principales

| Archivo | Ruta Relativa | Descripción |
|---------|---------------|-------------|
| programaLealtadTypes.xsd | Middleware/v2/Resources/ProgramaLealtad/xsd/programaLealtadTypes.xsd | Tipos programa lealtad |
| HeaderElements.xsd | Middleware/v2/Resources/esquemas_generales/HeaderElements.xsd | Headers autenticación |
| CommonTypes.xsd | CommonResources/XSD/CommonTypes.xsd | Tipos comunes |
| DynamoTypes.xsd | CommonResources/XSD/DynamoTypes.xsd | Tipos Dynamo |

### Schemas de Business Services

| Archivo | Ruta Relativa | Descripción |
|---------|---------------|-------------|
| RedemptionService.xsd | Middleware/v2/BusinessServices/Mastercard/RedemptionService/xsd/RedemptionService.xsd | Schema Mastercard |
| XMLSchema_769155616.xsd | Middleware/v2/BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd | Schema VisionPlus |
| canjearPuntosEfectivo_sp.xsd | Middleware/v2/BusinessServices/ABK/canjearPuntosEfectivo/xsd/canjearPuntosEfectivo_sp.xsd | SP conversión HN |
| conInfoLealtad_sp.xsd | Middleware/v2/BusinessServices/ProcesosHN/conInfoLealtad/xsd/conInfoLealtad_sp.xsd | SP info lealtad HN |
| conDatoCuenta_sp.xsd | Middleware/v2/BusinessServices/MasterDataHN/conDatoCuenta/xsd/conDatoCuenta_sp.xsd | SP datos cuenta HN |
| consultaProgramaLealtad_sp.xsd | Middleware/v2/BusinessServices/INTFC/consultaProgramaLealtad/xsd/consultaProgramaLealtad_sp.xsd | SP programa lealtad |
| INSTransaccionRedencion_sp.xsd | Middleware/v2/BusinessServices/MasterData/iNSTransaccionRedencion/xsd/INSTransaccionRedencion_sp.xsd | SP registro transacción |
| ValidaServicioRegional_sp.xsd | Middleware/v2/BusinessServices/ValidaServicioRegional/xsd/ValidaServicioRegional_sp.xsd | SP validación regional |

## WSDL Contracts

### WSDL Principales

| Archivo | Ruta Relativa | Descripción |
|---------|---------------|-------------|
| redencionPuntosLealtadPS.wsdl | Middleware/v2/Resources/RedencionPuntosLealtad/wsdl/redencionPuntosLealtadPS.wsdl | Contrato proxy service |
| RedemptionService.wsdl | Middleware/v2/BusinessServices/Mastercard/RedemptionService/wsdl/RedemptionService.wsdl | Contrato Mastercard |
| visionPlus.wsdl | Middleware/v2/BusinessServices/VisionPlus/visionPlus/wsdl/visionPlus.wsdl | Contrato VisionPlus |

### WSDL de Base de Datos

| Archivo | Ruta Relativa | Descripción |
|---------|---------------|-------------|
| canjearPuntosEfectivo_db.wsdl | Middleware/v2/BusinessServices/ABK/canjearPuntosEfectivo/wsdl/canjearPuntosEfectivo_db.wsdl | WSDL conversión HN |
| conInfoLealtad_db.wsdl | Middleware/v2/BusinessServices/ProcesosHN/conInfoLealtad/wsdl/conInfoLealtad_db.wsdl | WSDL info lealtad HN |
| conDatoCuenta_db.wsdl | Middleware/v2/BusinessServices/MasterDataHN/conDatoCuenta/wsdl/conDatoCuenta_db.wsdl | WSDL datos cuenta HN |
| consultaProgramaLealtad_db.wsdl | Middleware/v2/BusinessServices/INTFC/consultaProgramaLealtad/wsdl/consultaProgramaLealtad_db.wsdl | WSDL programa lealtad |
| INSTransaccionRedencion_db.wsdl | Middleware/v2/BusinessServices/MasterData/iNSTransaccionRedencion/wsdl/INSTransaccionRedencion_db.wsdl | WSDL registro transacción |
| ValidaServicioRegional_db.wsdl | Middleware/v2/BusinessServices/ValidaServicioRegional/wsdl/ValidaServicioRegional_db.wsdl | WSDL validación regional |

## JCA Adapters

### JCA de Base de Datos

| Archivo | Ruta Relativa | Descripción |
|---------|---------------|-------------|
| canjearPuntosEfectivo_db.jca | Middleware/v2/BusinessServices/ABK/canjearPuntosEfectivo/jca/canjearPuntosEfectivo_db.jca | Adapter conversión HN |
| conInfoLealtad_db.jca | Middleware/v2/BusinessServices/ProcesosHN/conInfoLealtad/jca/conInfoLealtad_db.jca | Adapter info lealtad HN |
| conDatoCuenta_db.jca | Middleware/v2/BusinessServices/MasterDataHN/conDatoCuenta/jca/conDatoCuenta_db.jca | Adapter datos cuenta HN |
| consultaProgramaLealtad_db.jca | Middleware/v2/BusinessServices/INTFC/consultaProgramaLealtad/jca/consultaProgramaLealtad_db.jca | Adapter programa lealtad |
| INSTransaccionRedencion_db.jca | Middleware/v2/BusinessServices/MasterData/iNSTransaccionRedencion/jca/INSTransaccionRedencion_db.jca | Adapter registro transacción |
| ValidaServicioRegional_db.jca | Middleware/v2/BusinessServices/ValidaServicioRegional/jca/ValidaServicioRegional_db.jca | Adapter validación regional |

## Java Callouts

No se detectaron Java Callouts específicos para esta funcionalidad.

## POJOs

No se detectaron POJOs específicos para esta funcionalidad.

## Configuration Files

### Properties

No se detectaron archivos .properties específicos. La configuración se obtiene dinámicamente desde base de datos mediante `ObtenerParametrizacion`.

### Políticas OSB

Las políticas están embebidas en los proxy services:
- Logging: debug level
- SLA Alerting: normal level
- Pipeline Alerting: normal level
- WS-Policy: wsdl-policy-attachments mode

## Tests Relevantes

No se encontraron tests unitarios o de integración en el repositorio para esta funcionalidad.

## Archivos de Soporte

### DVM (Domain Value Maps)

| Archivo | Ruta Relativa | Descripción |
|---------|---------------|-------------|
| RegionalParameters.dvm | CommonResources/DVM/RegionalParameters.dvm | Parámetros regionales |

### Recursos Adicionales

| Archivo | Ruta Relativa | Descripción |
|---------|---------------|-------------|
| servicebus.sboverview | Middleware/servicebus.sboverview | Overview del proyecto |

---

## Resumen de Conteo

| Tipo de Archivo | Cantidad |
|-----------------|----------|
| Proxy Services | 6 |
| Business Services | 20+ |
| XQuery Transformations | 35+ |
| XSLT Transformations | 0 |
| XSD Schemas | 15+ |
| WSDL Contracts | 10+ |
| JCA Adapters | 6+ |
| Java Callouts | 0 |
| POJOs | 0 |
| Properties Files | 0 |
| DVM Files | 1 |
| Tests | 0 |

**Total de Archivos**: 90+ archivos involucrados en la funcionalidad RedencionPuntosLealtad

---

**Nota**: Este listado incluye todos los archivos directamente referenciados en el código fuente de los proxy services. Las rutas son relativas al directorio base del proyecto OSB.
