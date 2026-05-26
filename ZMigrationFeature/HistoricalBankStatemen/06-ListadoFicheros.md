# Listado de Ficheros: HistoricalBankStatemen

## Proxies

| Archivo | Descripción |
|---------|-------------|
| `SBHN_Pension_HistoricalBankStatemen/PS/HistoricalBankStatemenRestPS.ProxyService` | Proxy REST principal |
| `SBHN_Pension_HistoricalBankStatemen/PS/HistoricalBankStatemenSoapPS.ProxyService` | Proxy SOAP (alternativo) |

## Business Services

| Archivo | Descripción |
|---------|-------------|
| `SBHN_Pension_Commons/BS/CloudCodeRestBS` | Servicio principal CloudCode API (estadoCuentasHistoricos) |
| `SBHN_Pension_Commons/BS/GetParametersRestBS.bix` | Obtención de parámetros de configuración |
| `SBHN_Pension_Commons/BS/LoggingRegionalRestBS.bix` | Logging regional |
| `SBHN_Pension_Commons/BS/GetCustomErrorByStackTraceRegionalRestBS.bix` | Mapeo de errores |

## Pipelines / Proxies de Soporte

| Archivo | Descripción |
|---------|-------------|
| `SBHN_Pension_CloudCodeLogin/PS/CloudCodeLoginPS.ProxyService` | Autenticación CloudCode |

## XQuery / Transformaciones

| Archivo | Descripción |
|---------|-------------|
| `SBHN_Pension_HistoricalBankStatemen/Transformation/HistoricalBankStatemenToCloudCode.xqy` | Transformación de entrada (Regional → CloudCode) |
| `SBHN_Pension_HistoricalBankStatemen/Transformation/CloudCodeToHistoricalBankStatemen.xqy` | Transformación de salida (CloudCode → Regional) |
| `SBHN_Pension_HistoricalBankStatemen/Transformation/ErrorToHistoricalBankStatemen.xqy` | Transformación de errores |
| `SBHN_Pension_Commons/Transformations/ExtractCredentialsAPIFPC.xqy` | Extracción de credenciales |
| `SBHN_Pension_Commons/Transformations/ServiceToCloudCodeLogin.xqy` | Preparación de login |
| `SBHN_Pension_Commons/Transformations/ServiceToParameters.xqy` | Preparación de request de parámetros |
| `SBHN_Pension_Commons/Transformations/ServicesToError.xqy` | Preparación de request de mapeo de errores |

## Schemas (XSD)

| Archivo | Descripción |
|---------|-------------|
| `SBHN_Pension_HistoricalBankStatemen/Schemas/HistoricalBankStatemenTypes.xsd` | Esquema principal del servicio |
| `SBHN_Pension_HistoricalBankStatemen/Schemas/EstadoCuentaHistoricoTypes.xsd` | Esquema CloudCode |
| `SBHN_Pension_Commons/Schemas/CommonTypes.xsd` | Tipos comunes (GeneralInfoType, StatusInfoType) |

## WSDL / Resources

| Archivo | Descripción |
|---------|-------------|
| `SBHN_Pension_HistoricalBankStatemen/Resources/HistoricalBankStatemenPS.wsdl` | WSDL del servicio |

## Configuración

| Archivo | Descripción |
|---------|-------------|
| Parámetro: `PG13516.SERVICE.ACCOUNT.APIFPC` | Nombre de cuenta de servicio para CloudCode |
