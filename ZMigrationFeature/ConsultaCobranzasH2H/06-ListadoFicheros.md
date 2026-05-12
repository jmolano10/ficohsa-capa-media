# Listado de Ficheros — ConsultaCobranzasH2H

## Proxies

| Ruta Relativa | Descripción |
|---------------|-------------|
| `v1/ProxyServices/CobranzasH2H.proxy` | Proxy padre (fachada): autenticación, bitácora, enrutamiento por operación |
| `v1/ProxyServices/ConsultaCobranzasH2H.proxy` | Proxy hijo: lógica de consulta de cobranzas con regionalización |

## Business Services

| Ruta Relativa | Tipo | Descripción |
|---------------|------|-------------|
| `v1/BusinessServices/MDW/validaServicioRegional/biz/validaServicioRegional_db` | DB Adapter | Valida servicio habilitado por región |
| `v1/BusinessServices/INTFC/validaAccesoH2H/biz/validaAccesoH2H_db` | DB Adapter | Valida acceso usuario/cliente H2H |
| `v1/BusinessServices/MDW/obtenerParametrizacion/biz/obtenerParametrizacion` | DB Adapter | Obtiene configuración (MAXAGREEMENTS) |
| `v1/BusinessServices/ABKHN/consultaPeticionesDisponiblesH2H/biz/consultaPeticionesDisponiblesH2H_db` | DB Adapter | Consulta cuota de peticiones diarias |
| `v1/BusinessServices/INTFC/consultaConveniosH2H/biz/consultaConveniosH2H_db` | DB Adapter | Consulta convenios por servicio y país |
| `v1/BusinessServices/SJS/consultaCobranzasH2H/biz/sjConsultaCobranzasH2H` | Split-Join | Consulta masiva de cobranzas en paralelo |
| `v1/BusinessServices/ABKHN/actualizaPeticionesDisponiblesH2H/biz/actualizaPeticionesDisponiblesH2H_db` | DB Adapter | Actualiza contador de peticiones |
| `v1/BusinessServices/OSB/mapeoErrores/biz/mapeoErrores` | OSB Service | Mapeo de códigos de error |
| `v1/BusinessServices/INTFC/registrarBitacoraH2H/biz/registrarBitacoraH2H_db` | DB Adapter | Registro de bitácora REQ/RSP |

## XQuery/XSLT

| Ruta Relativa | Descripción |
|---------------|-------------|
| `v1/Resources/ConsultaCobranzasH2H/xq/consultaConveniosH2HIn.xq` | Mapeo entrada para consulta de convenios |
| `v1/Resources/ConsultaCobranzasH2H/xq/sjConsultaRecaudoH2HIn.xq` | Mapeo entrada para Split-Join de cobranzas |
| `v1/Resources/ConsultaCobranzasH2H/xq/sjConsultaRecaudoH2HOut.xq` | Mapeo salida del Split-Join (incluye transformarReciboHTML) |
| `v1/Resources/CobranzasH2H/xq/validaAccesoH2HIn.xq` | Mapeo entrada para validación de acceso H2H |
| `v1/Resources/CobranzasH2H/xq/consPeticionesDispH2HIn.xq` | Mapeo entrada para consulta de peticiones disponibles |
| `v1/Resources/CobranzasH2H/xq/actualizaPeticionesDisponiblesH2HIn.xq` | Mapeo entrada para actualización de peticiones |
| `v1/Resources/CobranzasH2H/xq/registrarBitacoraH2HIn.xq` | Mapeo entrada para registro de bitácora |
| `v1/Resources/Generales/xq/validaServicioRegionalIn` | Mapeo entrada para validación de servicio regional |
| `v1/Resources/Generales/xq/obtenerParametrizacionIn` | Mapeo entrada para obtener parametrización |
| `v1/Resources/Generales/xq/mapeoErroresUsageIn` | Mapeo entrada para servicio de mapeo de errores |
| `v1/Resources/Generales/xq/mapeoErroresUsageOut` | Mapeo salida del servicio de mapeo de errores |
| `v1/Resources/Generales/xq/aplicarValoresPorDefectoRegion` | Aplica valores por defecto de región al header |
| `v1/Resources/Generales/xq/obtenerUUID` | Genera UUID para bitácora |

## XSD (Esquemas)

| Ruta Relativa | Descripción |
|---------------|-------------|
| `v1/Resources/CobranzasH2H/xsd/cobranzasH2HTypes.xsd` | Tipos de datos de cobranzas (request/response) |
| `v1/Resources/EsquemasGenerales/headerElements.xsd` | Elementos de header (RequestHeader/ResponseHeader) |

## WSDL

| Ruta Relativa | Descripción |
|---------------|-------------|
| `v1/Resources/ConsultaCobranzasH2H/wsdl/consultaCobranzasH2HPS.wsdl` | Contrato del proxy ConsultaCobranzasH2H |
| `v1/Resources/CobranzasH2H/wsdl/cobranzasH2HPS.wsdl` | Contrato del proxy padre CobranzasH2H |

## XSD de Stored Procedures (Business Services)

| Ruta Relativa | Descripción |
|---------------|-------------|
| `v1/BusinessServices/INTFC/validaAccesoH2H/xsd/validaAccesoH2H_sp.xsd` | Schema del SP validaAccesoH2H |
| `v1/BusinessServices/INTFC/consultaConveniosH2H/xsd/consultaConveniosH2H_sp.xsd` | Schema del SP consultaConveniosH2H |
| `v1/BusinessServices/ABKHN/consultaPeticionesDisponiblesH2H/xsd/consultaPeticionesDisponiblesH2H_sp.xsd` | Schema del SP consultaPeticionesDisponiblesH2H |
| `v1/BusinessServices/ABKHN/actualizaPeticionesDisponiblesH2H/xsd/actualizaPeticionesDisponiblesH2H_sp.xsd` | Schema del SP actualizaPeticionesDisponiblesH2H |
| `v1/BusinessServices/SJS/consultaCobranzasH2H/xsd/sjConsultaCobranzasH2H.xsd` | Schema del Split-Join |

## Properties/Config

No se encontraron archivos `.properties` específicos para esta funcionalidad.
