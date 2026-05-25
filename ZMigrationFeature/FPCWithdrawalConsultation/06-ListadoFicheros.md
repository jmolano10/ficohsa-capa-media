# Listado de Ficheros — FPCWithdrawalConsultation

## Proxy Services

| # | Archivo | Tipo | Descripción |
|---|---------|------|-------------|
| 1 | `SBHN_Pension_FPCWithdrawalConsultation/PS/FPCWithdrawalConsultationRestPS.ProxyService` | REST Proxy | Proxy de entrada REST (POST) |
| 2 | `SBHN_Pension_FPCWithdrawalConsultation/PS/FPCWithdrawalConsultationSoapPS.ProxyService` | SOAP Proxy | Proxy de entrada SOAP |

## Pipelines

| # | Archivo | Tipo | Descripción |
|---|---------|------|-------------|
| 1 | `SBHN_Pension_FPCWithdrawalConsultation/PP/FPCWithdrawalConsultationPP.Pipeline` | Pipeline | Pipeline principal (basado en template) |
| 2 | `SBHN_Pension_Commons/PP/PensionHondurasTemplateFicohsa.PipelineTemplate` | Template | Template base para servicios Pension Honduras |

## Business Services

| # | Archivo | Tipo | Endpoint |
|---|---------|------|----------|
| 1 | `SBHN_Pension_FPCWithdrawalConsultation/BS/CloudCodeRestBS.BusinessService` | REST BS | `https://apiqa.afpficohsa.com/api/v2` |
| 2 | `SBHN_Pension_Commons/BS/GetParametersRestBS` | REST BS | Servicio de parámetros |
| 3 | `SBHN_Pension_Commons/BS/LoggingRegionalRestBS` | REST BS | Servicio de logging |
| 4 | `SBHN_Pension_Commons/BS/GetCustomErrorByStackTraceRegionalRestBS` | REST BS | Mapeo de errores regionales |

## Proxy Services Dependientes

| # | Archivo | Tipo | Descripción |
|---|---------|------|-------------|
| 1 | `SBHN_Pension_CloudCodeLogin/PS/CloudCodeLoginPS` | Proxy | Autenticación CloudCode |

## XQuery/Transformaciones

| # | Archivo | Descripción |
|---|---------|-------------|
| 1 | `SBHN_Pension_FPCWithdrawalConsultation/Transformations/FPCWithdrawalConsultationToCloudCodeRestBS.Xquery` | Request regional → CloudCode |
| 2 | `SBHN_Pension_FPCWithdrawalConsultation/Transformations/CloudCodeRestToFPCWithdrawalConsultation.Xquery` | Response CloudCode → regional |
| 3 | `SBHN_Pension_FPCWithdrawalConsultation/Transformations/ErrorMapeoRegionalToFPCWithdrawalConsultation.Xquery` | Error → Response regional |
| 4 | `SBHN_Pension_Commons/Transformations/ExtractCredentialsAPIFPC.Xquery` | Extracción de credenciales del Security Store |
| 5 | `SBHN_Pension_Commons/Transformations/ServiceToCloudCodeLogin.Xquery` | Construcción request de login |
| 6 | `SBHN_Pension_Commons/Transformations/ServiceToParameters.Xquery` | Construcción request de parámetros |
| 7 | `SBHN_Pension_Commons/Transformations/ServicesToError.Xquery` | Construcción request de mapeo de error |
| 8 | `SBHN_Pension_Commons/Transformations/ServiceToLog.Xquery` | Construcción request de logging |

## Schemas (XSD)

| # | Archivo | Namespace | Descripción |
|---|---------|-----------|-------------|
| 1 | `SBHN_Pension_FPCWithdrawalConsultation/Schemas/APIFPCTypes.XMLSchema` | `https://www.ficohsa.com/regional/pension` | Tipos CloudCode (request/response) |
| 2 | `SBHN_Pension_FPCWithdrawalConsultation/Schemas/FPCWithdrawalConsultationTypes.XMLSchema` | `https://www.ficohsa.com/regional/pension` | Tipos del servicio regional |
| 3 | `SBHN_Pension_Commons/Schemas/CommonTypes.xsd` | `https://www.ficohsa.com/regional/common/commonTypes` | Tipos comunes (GeneralInfoType, StatusInfoType, ErrorInfoType) |
| 4 | `SBHN_Pension_Commons/Resources/SBRG_Constants_Commons/Schemas/ErrorMappingRegional.xsd` | `https://www.ficohsa.com/regional/constants` | Tipos de mapeo de error regional |
| 5 | `SBHN_Pension_CloudCodeLogin/Schemas/GetEncryptCredentialsTypes.xsd` | `https://www.ficohsa.com/honduras/pension/getEncryptCredentialsTypes` | Tipos de login CloudCode |
| 6 | `SBHN_Pension_Commons/Schemas/UserLoginTypes.xsd` | `https://www.ficohsa.com/honduras/pension/user` | Tipos de usuario/credenciales |

## WSDL/WADL

| # | Archivo | Tipo | Descripción |
|---|---------|------|-------------|
| 1 | `SBHN_Pension_FPCWithdrawalConsultation/Resources/FPCWithdrawalConsultation.WSDL` | WSDL | Contrato del servicio (binding SOAP/REST) |
| 2 | `SBHN_Pension_FPCWithdrawalConsultation/Resources/FPCWithdrawalConsultationRestPS.WADL` | WADL | Definición REST del proxy (POST /) |
| 3 | `SBHN_Pension_FPCWithdrawalConsultation/Resources/CloudCodeRestBS.WADL` | WADL | Definición REST del BS (GET /retiros) |
| 4 | `SBHN_Pension_FPCWithdrawalConsultation/Resources/CloudCodeRestBS.WSDL` | WSDL | WSDL generado para el BS REST |

## Configuración

| # | Archivo | Descripción |
|---|---------|-------------|
| 1 | `SBHN_Pension_FPCWithdrawalConsultation/_projectdata.LocationData` | Metadata del proyecto OSB |
