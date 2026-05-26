# Comparativa entre Regiones — GetFundPensionClient

## Regiones Detectadas

- **HN01** (Honduras) — Única región detectada en el código fuente

> El servicio usa regionalización **dinámica** vía `GetCountryURLByNameRestBS`. La URL del backend se obtiene en tiempo de ejecución según el `DestinationBank`. Solo se detecta configuración explícita para HN01 en el routing del pipeline 11g.

## Tabla Comparativa

| Aspecto | HN01 |
|---------|------|
| Endpoint OSB REST | `/regional/pension/rest/getFundPensionClient/v1` |
| Endpoint OSB SOAP Regional | `/regional/pension/soap/getFundPensionClient/v1` |
| Endpoint OSB SOAP 11g | `/regional/pension/soap/getFundPensionClient/v11g` |
| Endpoint Backend REST | `https://mwservices.gfficohsa.hn:8020/country/pension/rest/getFundPensionClient/v1` |
| Endpoint Backend SOAP (12) | `https://mwservices.gfficohsa.hn:8020/regional/pension/soap/getFundPensionClient/v1` |
| URL Dinámica (11g routing) | `https://mwservices.gfficohsa.hn:8020/regional/pension/soap/getFundPensionClient/v1` |
| Regionalización | Dinámica vía `GetCountryURLByNameRestBS` (DestinationBank) |
| Validación XSD | Sí — `GetFundPensionClientTypes` / elemento `getFundPensionClient` |
| Transformación Request | Directo (`$body/pen:getFundPensionClient`) — sin XQuery de mapeo |
| Transformación Response | Directo (`$responseService`) — sin XQuery de mapeo |
| Transformación Error | `ErrorToGetFundPensionClient.Xquery` |
| Timeout Conexión | 65s |
| Timeout Respuesta | 70s |
| Retry Count | 0 |
| Política Seguridad Inbound REST | `oracle/http_basic_auth_over_ssl_service_policy` |
| Política Seguridad Outbound REST | `oracle/http_basic_auth_over_ssl_client_policy` |
| Dispatch Policy | `SBPensionManager` |
| Namespace Regional | `https://www.ficohsa.com/regional/pension` |
| Namespace 11g | `http://www.ficohsa.com.hn/middleware.services/consultaFondosPensionesClienteTypes` |
| Logging | Sí (REQUEST y RESPONSE vía LoggingRegionalRestBS) |
| Mapeo Error Regional | Sí (GetCustomErrorByStackTraceRegionalRestBS) |
| Capa 11g | Sí (proxy + pipeline de compatibilidad) |

## Detalle Región HN01

### Endpoints

- **Proxy REST**: POST sobre `/regional/pension/rest/getFundPensionClient/v1`
  - Acepta: `application/json`
  - Responde: `application/json`
- **Proxy SOAP Regional**: SOAP 1.1 sobre `/regional/pension/soap/getFundPensionClient/v1`
  - Binding: `getFundPensionClientBind` en namespace `https://www.ficohsa.com/regional/pension`
- **Proxy SOAP 11g**: SOAP 1.1 sobre `/regional/pension/soap/getFundPensionClient/v11g`
  - Binding: `consultaFondosPensionesClientePSSOAP` en namespace `http://www.ficohsa.com.hn/middleware.services/consultaFondosPensionesClientePS/`

### Validaciones

- **StageValidate**: Valida el body contra el schema XSD `GetFundPensionClientTypes`, elemento `getFundPensionClient`. Campos obligatorios: `IdentificationType`, `IdentificationNumber`, `Clientcode`.

### Regionalización Dinámica

El pipeline consulta `GetCountryURLByNameRestBS` con los parámetros `destinationBank`, `service`, `user`, `operation`, `version`, `sourceBank`. Si la respuesta es `"N/A"`, lanza error `MW-0008: SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY`.

### Políticas OSB

- Inbound REST: `oracle/http_basic_auth_over_ssl_service_policy`
- Inbound SOAP Regional: `oracle/http_basic_auth_over_ssl_service_policy`
- Inbound SOAP 11g: Sin políticas
- Outbound REST BS: `oracle/http_basic_auth_over_ssl_client_policy`
- Outbound SOAP BS (12): Sin políticas

### Manejo de Errores

1. **Error MW-0008**: País no configurado en regionalización → reply inmediato
2. **Error Handler Global** (template):
   - Report del fault (logging)
   - Mapeo de error regional vía `GetCustomErrorByStackTraceRegionalRestBS`
   - `ErrorToGetFundPensionClient.Xquery` → construye response de error
   - Si método=REST: inyecta código HTTP del error en header de respuesta
   - Logging de response error
   - Reply

### Sin Diferencias Regionales Detectadas

Solo se detecta HN01 en el código fuente. El servicio está diseñado para múltiples regiones vía regionalización dinámica, pero solo HN01 tiene configuración activa.
