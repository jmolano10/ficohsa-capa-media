# Resumen Ejecutivo — FPCWithdrawalConsultation

## Índice de Entregables

- [02-ComparativaRegiones.md](./02-ComparativaRegiones.md)
- [03-EjemplosYMapeos-HN01.md](./03-EjemplosYMapeos-HN01.md)
- [06-ListadoFicheros.md](./06-ListadoFicheros.md)
- [07-ListadoXQ.md](./07-ListadoXQ.md)

---

## Propósito de la Funcionalidad

Consultar información de retiros de fondos de pensión (FPC - Fondo de Pensiones y Cesantías) para un cliente específico, identificado por su número de solicitud y número de identificación. El servicio actúa como intermediario entre los consumidores (REST/SOAP) y la API de AFP Ficohsa (CloudCode/APIFPC).

## Entradas Principales

| Campo | Tipo | Descripción |
|-------|------|-------------|
| GeneralInfo | ComplexType | Información general del request (SourceBank, GlobalId, Language, ApplicationId, DestinationBank) |
| RequestNumber | string | Número de solicitud de retiro |
| ClientId | string | Número de identificación del cliente |

## Salidas Principales (Caso Exitoso)

| Campo | Tipo | Descripción |
|-------|------|-------------|
| StatusInfo | ComplexType | Estado de la transacción (Status, TransactionId, ValueDate, DateTime, GlobalId) |
| Account | string | Cuenta del fondo de pensión |
| ClientName | string | Nombre del cliente |
| IdNumber | string | Número de identificación |
| PaymentMethod | string | Forma de pago |
| Currency | string | Moneda |
| Amount | decimal | Monto del retiro |
| WithdrawalType | string | Tipo de retiro |
| BankingAccount | string | Cuenta bancaria destino |

## Salidas (Caso Error)

| Campo | Tipo | Descripción |
|-------|------|-------------|
| StatusInfo | ComplexType | Estado con Status='Error' |
| ErrorInfo | ComplexType | Code, Error, Description, ShortDescription, DateTime, GlobalId, Details (SystemId, SystemStatus, MessageId, Messages) |

## Sistemas/Servicios OSB Involucrados

| Sistema | Rol | Endpoint/Referencia |
|---------|-----|---------------------|
| FPCWithdrawalConsultationRestPS | Proxy REST de entrada | `/honduras/pension/rest/FPCWithdrawalConsultation/v1` |
| FPCWithdrawalConsultationSoapPS | Proxy SOAP de entrada | `/honduras/pension/soap/FPCWithdrawalConsultation/v1` |
| FPCWithdrawalConsultationPP | Pipeline principal | Basado en template `PensionHondurasTemplateFicohsa` |
| CloudCodeRestBS | Business Service REST | `https://apiqa.afpficohsa.com/api/v2` — Operación: `GetFPCWithdrawal` (GET /retiros) |
| GetParametersRestBS | BS Común — Parámetros | Obtiene nombre de cuenta de servicio (`PG13516.SERVICE.ACCOUNT.APIFPC`) |
| CloudCodeLoginPS | Proxy Común — Login | Autenticación contra CloudCode para obtener token de sesión |
| LoggingRegionalRestBS | BS Común — Logging | Registro de request/response en filesystem |
| GetCustomErrorByStackTraceRegionalRestBS | BS Común — Errores | Mapeo de errores regionales |

## Flujo General

1. Cliente envía request (REST POST o SOAP)
2. Pipeline asigna variables de contexto (service=`Pension/FPCWithdrawalConsultation`, version=`V1`, key=`ClientId`, targetSystem=`APIFPC`, method=`REST`)
3. **GetSecurity**: Obtiene parámetro `PG13516.SERVICE.ACCOUNT.APIFPC` → extrae credenciales → login en CloudCode → obtiene `sesionToken`
4. **TransformRegionalToTargetSystem**: Transforma request regional a formato CloudCode (XQuery `FPCWithdrawalConsultationToCloudCodeRestBS`)
5. **LoggingInput**: Registra request en log
6. **InvokeCountry**: Invoca `CloudCodeRestBS` operación `GetFPCWithdrawal` con header `Authorization: $sesionToken`
7. **LoggingOutput**: Registra response en log
8. **TransformTargetSystemToRegional**: Si éxito → XQuery `CloudCodeRestToFPCWithdrawalConsultation`; Si error → mapeo de error regional
9. Retorna response al cliente

## Mecanismo de Retry por 401

Si la invocación a CloudCodeRestBS retorna HTTP 401 (error handler `ErrorHandlerInvokeCountry`):
1. Re-obtiene credenciales con `ExtractCredentialsAPIFPC`
2. Hace login forzado (`forceLogin=true`) en `CloudCodeLoginPS`
3. Reintenta la invocación a `CloudCodeRestBS` con el nuevo token
4. Si el reintento falla, propaga el error

## Seguridad

- **Inbound**: Política OWSM `oracle/http_basic_auth_over_ssl_service_policy` (HTTP Basic Auth sobre SSL)
- **Outbound**: Token Bearer obtenido de CloudCode Login
- **Credenciales**: Almacenadas en OSB Security Store (`SB_Security/Common/{ACCOUNT_NAME}`)
- **Dispatch Policy**: `SBPensionManager`

## Riesgos/Limitaciones

- El endpoint del Business Service apunta a QA (`https://apiqa.afpficohsa.com/api/v2`). En producción se configura vía environment.
- Timeout de conexión: 65s, timeout de respuesta: 70s — valores altos que podrían impactar tiempos de respuesta.
- No hay retry configurado a nivel de BS (`retry-count=0`).
- El mecanismo de retry por 401 solo reintenta una vez.

## Proxies Dependientes

| Proxy | Ruta | Descripción |
|-------|------|-------------|
| CloudCodeLoginPS | `SBHN_Pension_CloudCodeLogin/PS/CloudCodeLoginPS` | Autenticación contra CloudCode para obtener token |

---
