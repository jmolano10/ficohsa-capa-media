# Comparativa entre Regiones — FPCWithdrawalConsultation

## Regiones Detectadas

- **HN01** (Honduras) — Única región detectada

## Tabla Comparativa

| Aspecto | HN01 |
|---------|------|
| Endpoint OSB REST | `/honduras/pension/rest/FPCWithdrawalConsultation/v1` |
| Endpoint OSB SOAP | `/honduras/pension/soap/FPCWithdrawalConsultation/v1` |
| Endpoint Backend (BS) | `https://apiqa.afpficohsa.com/api/v2/retiros` |
| Operación Backend | `GET /retiros?numeroSolicitud={}&numeroIdentificacion={}` |
| Nombre de Conexión | CloudCodeRestBS |
| Sistema Destino | APIFPC |
| Cuenta de Servicio (Parámetro) | `PG13516.SERVICE.ACCOUNT.APIFPC` |
| Credenciales Store | `SB_Security/Common/{ACCOUNT_NAME}` |
| Transformación Request | `FPCWithdrawalConsultationToCloudCodeRestBS.Xquery` |
| Transformación Response | `CloudCodeRestToFPCWithdrawalConsultation.Xquery` |
| Transformación Error | `ErrorMapeoRegionalToFPCWithdrawalConsultation.Xquery` |
| Timeout Conexión | 65s |
| Timeout Respuesta | 70s |
| Retry Count | 0 |
| Retry por 401 | Sí (1 reintento con forceLogin=true) |
| Política Seguridad Inbound | `oracle/http_basic_auth_over_ssl_service_policy` |
| Dispatch Policy | `SBPensionManager` |
| Namespace | `https://www.ficohsa.com/regional/pension` |
| Logging | Sí (REQUEST y RESPONSE vía LoggingRegionalRestBS) |
| Mapeo Error Regional | Sí (GetCustomErrorByStackTraceRegionalRestBS) |

## Detalle Región HN01

### Endpoints

- **Proxy REST**: POST sobre `/honduras/pension/rest/FPCWithdrawalConsultation/v1`
  - Acepta: `application/json`, `application/xml`
  - Responde: `application/json`, `application/xml`
- **Proxy SOAP**: SOAP 1.1 sobre `/honduras/pension/soap/FPCWithdrawalConsultation/v1`
  - Binding: `FPCWithdrawalConsultationBind` en namespace `https://www.ficohsa.com/regional/pension`

### Validaciones

- No se detectan validaciones explícitas de campos en el pipeline (no hay stage de validación de esquema adicional al binding).
- La validación se delega al esquema XSD del binding.

### Políticas OSB

- Inbound: `oracle/http_basic_auth_over_ssl_service_policy` (autenticación básica sobre SSL)
- Outbound (BS): Sin políticas (`no-policies`)

### Handlers de Error

1. **ErrorHandlerInvokeCountry** (error handler del stage InvokeCountry):
   - Si HTTP 401: re-login forzado + reintento
   - Otros errores: extrae código y mensaje del fault
2. **Error Handler Global** (template):
   - Report del fault (logging)
   - Mapeo de error regional vía `GetCustomErrorByStackTraceRegionalRestBS`
   - Transformación a formato de respuesta de error
   - Logging de response error
   - Reply

### Sin Diferencias Regionales

Este servicio solo opera en Honduras (HN01). No se detectan branches por región (SourceBank) en el pipeline ni en las transformaciones.
