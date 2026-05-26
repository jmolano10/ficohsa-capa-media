# Listado de Ficheros — GetFundPensionClient

## Proxy Services

| # | Archivo | Tipo | Descripción |
|---|---------|------|-------------|
| 1 | `SBRG_Pension_GetFundPensionClient/PS/GetFundPensionClientRestPS.ProxyService` | REST Proxy | Proxy de entrada REST (POST) |
| 2 | `SBRG_Pension_GetFundPensionClient/PS/GetFundPensionClientSoapPS.ProxyService` | SOAP Proxy | Proxy de entrada SOAP regional |
| 3 | `SBRG_Pension_GetFundPensionClient/PS/GetFundPensionClient11gPS.ProxyService` | SOAP Proxy | Proxy de entrada SOAP legado 11g |

## Pipelines

| # | Archivo | Tipo | Descripción |
|---|---------|------|-------------|
| 1 | `SBRG_Pension_GetFundPensionClient/PP/GetFundPensionClientPP.Pipeline` | Pipeline | Pipeline principal REST/SOAP regional |
| 2 | `SBRG_Pension_GetFundPensionClient/PP/GetFundPensionClient11gPP.Pipeline` | Pipeline | Pipeline compatibilidad 11g |
| 3 | `SBRG_Pension_Commons/PP/PensionRegionalTemplateFicohsa.PipelineTemplate` | Template | Template base para servicios Pension Regional |
| 4 | `SBRG_Pension_Commons/PP/PensionRegional11gTemplate.PipelineTemplate` | Template | Template base para servicios Pension 11g |

## Business Services

| # | Archivo | Tipo | Endpoint |
|---|---------|------|----------|
| 1 | `SBRG_Pension_GetFundPensionClient/BS/GetFundPensionClientRestBS.BusinessService` | REST BS | `https://mwservices.gfficohsa.hn:8020/country/pension/rest/getFundPensionClient/v1` |
| 2 | `SBRG_Pension_GetFundPensionClient/BS/GetFundPensionClient12BS.BusinessService` | SOAP BS | `https://mwservices.gfficohsa.hn:8020/regional/pension/soap/getFundPensionClient/v1` |
| 3 | `SBRG_Pension_Commons/BS/GetCountryURLByNameRestBS` | REST BS | Servicio de regionalización dinámica |
| 4 | `SBRG_Pension_Commons/BS/LoggingRegionalRestBS` | REST BS | Servicio de logging |
| 5 | `SBRG_Pension_Commons/BS/GetCustomErrorByStackTraceRegionalRestBS` | REST BS | Mapeo de errores regionales |

## XQuery/Transformaciones

| # | Archivo | Descripción |
|---|---------|-------------|
| 1 | `SBRG_Pension_GetFundPensionClient/Transformations/ConvertIdType.Xquery` | Convierte código numérico de tipo ID a código textual (11g) |
| 2 | `SBRG_Pension_GetFundPensionClient/Transformations/Virtual11gToRegional.Xquery` | Transforma request 11g → formato regional |
| 3 | `SBRG_Pension_GetFundPensionClient/Transformations/RegionalToVirtualBody11gHN.Xquery` | Transforma body response regional → formato 11g |
| 4 | `SBRG_Pension_GetFundPensionClient/Transformations/RegionalToVirtualHeader11gHN.Xquery` | Transforma header response regional → formato 11g |
| 5 | `SBRG_Pension_GetFundPensionClient/Transformations/ErrorToGetFundPensionClient.Xquery` | Construye response de error en formato regional |
| 6 | `SBRG_Pension_Commons/Transformations/ServiceToRegionalizacion.Xquery` | Construcción request de regionalización |
| 7 | `SBRG_Pension_Commons/Transformations/ServicesToError.Xquery` | Construcción request de mapeo de error |
| 8 | `SBRG_Pension_Commons/Transformations/ServiceToLog.Xquery` | Construcción request de logging |

## Schemas (XSD)

| # | Archivo | Namespace | Descripción |
|---|---------|-----------|-------------|
| 1 | `SBRG_Pension_GetFundPensionClient/Schemas/GetFundPensionClientTypes.XMLSchema` | `https://www.ficohsa.com/regional/pension` | Tipos del servicio regional (request/response) |
| 2 | `SBRG_Pension_GetFundPensionClient/Schemas/ConsultaFondosPensionesClienteTypes.XMLSchema` | `http://www.ficohsa.com.hn/middleware.services/consultaFondosPensionesClienteTypes` | Tipos del servicio legado 11g |
| 3 | `SBRG_Pension_Commons/Schemas/CommonTypes.xsd` | `https://www.ficohsa.com/regional/common/commonTypes` | Tipos comunes (GeneralInfoType, StatusInfoType, ErrorInfoType) |
| 4 | `SBRG_Pension_Commons/Resources/SBRG_Constants_Commons/Schemas/ErrorMappingRegional.xsd` | `https://www.ficohsa.com/regional/constants` | Tipos de mapeo de error regional |
| 5 | `SBRG_Pension_Commons/Schemas/Virtual/Header11gMapper.xsd` | `http://www.ficohsa.com.hn/middleware.services/autType` | Tipos de header 11g |

## WSDL/WADL

| # | Archivo | Tipo | Descripción |
|---|---------|------|-------------|
| 1 | `SBRG_Pension_GetFundPensionClient/Resources/GetFundPensionClient.WSDL` | WSDL | Contrato del servicio regional (binding SOAP/REST) |
| 2 | `SBRG_Pension_GetFundPensionClient/Resources/GetFundPensionClientRestPS.WADL` | WADL | Definición REST del proxy (POST /) |
| 3 | `SBRG_Pension_GetFundPensionClient/Resources/GetFundPensionClientRestBS.WADL` | WADL | Definición REST del BS (POST /) |
| 4 | `SBRG_Pension_GetFundPensionClient/Resources/GetFundPensionClientRestBS.WSDL` | WSDL | WSDL generado para el BS REST |
| 5 | `SBRG_Pension_GetFundPensionClient/Resources/ConsultaFondosPensionesClientePS.WSDL` | WSDL | Contrato del servicio legado 11g |
