# Resumen Ejecutivo — GetFundPensionClient

## Índice de Entregables

- [02-ComparativaRegiones.md](./02-ComparativaRegiones.md)
- [03-EjemplosYMapeos-HN01.md](./03-EjemplosYMapeos-HN01.md)
- [06-ListadoFicheros.md](./06-ListadoFicheros.md)
- [07-ListadoXQ.md](./07-ListadoXQ.md)

---

## Propósito de la Funcionalidad

Consultar los fondos de pensión asociados a un cliente, identificado por tipo y número de identificación y código de cliente. El servicio actúa como intermediario entre los consumidores (REST/SOAP/11g) y el servicio regional de pensiones de Honduras, usando un patrón de **regionalización dinámica** para obtener la URL del backend según el banco destino.

## Entradas Principales

| Campo | Tipo | Descripción |
|-------|------|-------------|
| GeneralInfo | ComplexType | Información general (SourceBank, DestinationBank, GlobalId, Language, ApplicationId) |
| IdentificationType | string | Tipo de identificación del cliente |
| IdentificationNumber | string | Número de identificación del cliente |
| Clientcode | string | Código del cliente en el sistema de pensiones |

## Salidas Principales (Caso Exitoso)

| Campo | Tipo | Descripción |
|-------|------|-------------|
| StatusInfo | ComplexType | Estado de la transacción (Status, TransactionId, ValueDate, DateTime, GlobalId) |
| Data.Client | ComplexType | Datos del cliente con sus cuentas de pensión |
| Data.Client.IdentificationType | string | Tipo de identificación |
| Data.Client.IdentificationNumber | string | Número de identificación |
| Data.Client.Clientcode | string | Código del cliente |
| Data.Client.Accounts[] | Array | Lista de cuentas de pensión con AccountCode, CurrencyCode, CurrencyName, CodeProductLine, ProductLineName, ProductCode, ProductName, Alternative |

## Salidas (Caso Error)

| Campo | Tipo | Descripción |
|-------|------|-------------|
| StatusInfo | ComplexType | Estado con Status='Error' |
| ErrorInfo | ComplexType | Code, Error, Description, ShortDescription, DateTime, GlobalId, Details |

## Sistemas/Servicios OSB Involucrados

| Sistema | Rol | Endpoint/Referencia |
|---------|-----|---------------------|
| GetFundPensionClientRestPS | Proxy REST de entrada | `/regional/pension/rest/getFundPensionClient/v1` |
| GetFundPensionClientSoapPS | Proxy SOAP de entrada (regional) | `/regional/pension/soap/getFundPensionClient/v1` |
| GetFundPensionClient11gPS | Proxy SOAP de entrada (legado 11g) | `/regional/pension/soap/getFundPensionClient/v11g` |
| GetFundPensionClientPP | Pipeline principal (REST/SOAP regional) | Template: `PensionRegionalTemplateFicohsa` |
| GetFundPensionClient11gPP | Pipeline legado 11g | Template: `PensionRegional11gTemplate` |
| GetFundPensionClientRestBS | Business Service REST | `https://mwservices.gfficohsa.hn:8020/country/pension/rest/getFundPensionClient/v1` |
| GetFundPensionClient12BS | Business Service SOAP | `https://mwservices.gfficohsa.hn:8020/regional/pension/soap/getFundPensionClient/v1` |
| GetCountryURLByNameRestBS | BS Común — Regionalización | Obtiene URL dinámica del backend según DestinationBank |
| LoggingRegionalRestBS | BS Común — Logging | Registro de request/response en filesystem |
| GetCustomErrorByStackTraceRegionalRestBS | BS Común — Errores | Mapeo de errores regionales |

## Flujo General (REST/SOAP Regional — GetFundPensionClientPP)

1. Cliente envía request (REST POST o SOAP)
2. Pipeline asigna variables de contexto: `service='Pension/GetFundPensionClient'`, `version='v1'`, `key='IdentificationNumber'`, `value=data(IdentificationNumber)`, `method='REST'|'SOAP'`
3. **StageLoggingInput**: Registra request en log
4. **StageValidate**: Valida el body contra el schema XSD `GetFundPensionClientTypes` (elemento `getFundPensionClient`)
5. **StageRegionalitation**: Invoca `GetCountryURLByNameRestBS` para obtener la URL del backend según `DestinationBank`. Si retorna `"N/A"` → error `MW-0008` (servicio no implementado para ese país)
6. **InvokeCountry**: Invoca `GetFundPensionClientRestBS` con la URL dinámica obtenida. El body se pasa directamente (`$body/pen:getFundPensionClient`)
7. **StageLoggingOutput**: Registra response en log. Extrae `StatusInfo/Status`, `ErrorInfo/Code`, `ErrorInfo/Description`
8. **StageReplaceCodeError**: Si método=REST y status!=SUCCESS, inyecta el código HTTP de error en el header de respuesta
9. Retorna response al cliente

## Flujo 11g (GetFundPensionClient11gPP)

1. Cliente 11g envía request SOAP con formato `consultaFondosPensionesClienteRequest`
2. **ConvertIdType**: Convierte el código numérico de tipo de ID al código textual (1→CC, 9→NIT, 4→PAS, 2→CAR)
3. **Virtual11gToRegional**: Transforma el request 11g al formato regional estándar (`getFundPensionClient`)
4. Invoca `GetFundPensionClient12BS` (SOAP) con routing dinámico a `https://mwservices.gfficohsa.hn:8020/regional/pension/soap/getFundPensionClient/v1`
5. **RegionalToVirtualHeader11gHN**: Transforma el header de respuesta regional al formato 11g
6. **RegionalToVirtualBody11gHN**: Transforma el body de respuesta regional al formato `consultaFondosPensionesClienteResponse`

## Diferencia Clave con HU9498 (FPCWithdrawalConsultation)

| Aspecto | GetFundPensionClient (HU69257) | FPCWithdrawalConsultation (HU9498) |
|---------|-------------------------------|-------------------------------------|
| Template | `PensionRegionalTemplateFicohsa` | `PensionHondurasTemplateFicohsa` |
| Regionalización | Dinámica vía `GetCountryURLByNameRestBS` | Fija (solo HN01) |
| Autenticación outbound | HTTP Basic Auth (OWSM policy) | Bearer Token (CloudCode Login) |
| Backend | `mwservices.gfficohsa.hn:8020` (OSB interno) | `apiqa.afpficohsa.com` (AFP Ficohsa) |
| Capa 11g | Sí (proxy + pipeline de compatibilidad) | No |
| Validación XSD | Sí (StageValidate explícito) | No (solo binding) |

## Seguridad

- **Inbound REST/SOAP**: Política OWSM `oracle/http_basic_auth_over_ssl_service_policy`
- **Inbound 11g**: Sin políticas (`no-policies`)
- **Outbound REST BS**: Política OWSM `oracle/http_basic_auth_over_ssl_client_policy`
- **Outbound SOAP BS (12)**: Sin políticas

## Riesgos/Limitaciones

- El endpoint del BS REST apunta a `mwservices.gfficohsa.hn:8020` — es un endpoint interno del OSB (otro servicio OSB regional), no un backend externo directo.
- La URL dinámica de regionalización puede retornar `"N/A"` si el país no está configurado → error `MW-0008`.
- Timeout: 70s respuesta, 65s conexión. Sin retry.
- El flujo 11g hace un routing dinámico hardcodeado a `https://mwservices.gfficohsa.hn:8020/regional/pension/soap/getFundPensionClient/v1`.

## Proxies Dependientes

| Proxy/BS | Ruta | Descripción |
|----------|------|-------------|
| GetCountryURLByNameRestBS | `SBRG_Pension_Commons/BS/GetCountryURLByNameRestBS` | Servicio de regionalización dinámica |
