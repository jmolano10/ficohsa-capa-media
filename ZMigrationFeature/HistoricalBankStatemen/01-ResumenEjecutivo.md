# Resumen Ejecutivo: HistoricalBankStatemen

## Índice de Documentos

- [02-ComparativaRegiones](./02-ComparativaRegiones.md)
- [03-EjemplosYMapeos-HN01](./03-EjemplosYMapeos-HN01.md)
- [06-ListadoFicheros](./06-ListadoFicheros.md)
- [07-ListadoXQ](./07-ListadoXQ.md)

## Propósito

El servicio **HistoricalBankStatemen** (Pension/HistoricalBankStatemen) permite consultar el estado de cuenta histórico de un cliente de fondo de pensión a partir de su tipo de identificación, número de identificación y rango de fechas. Retorna información del cliente, movimientos por moneda/cuenta y transacciones detalladas dentro del período consultado.

## Entradas Principales

| Campo | Tipo | Descripción |
|-------|------|-------------|
| IdentificationType | string | Tipo de identificación del cliente (1=CC, 2=CAR, 4=PAS, 5=NIT) |
| IdentificationNumber | string | Número de identificación del cliente |
| StartDate | string | Fecha de inicio del rango de consulta |
| EndDate | string | Fecha final del rango de consulta |

## Salidas Principales

| Campo | Tipo | Descripción |
|-------|------|-------------|
| StatusInfo | object | Estado de la transacción (Success/Error) |
| Data/Message | string | Mensaje de respuesta |
| Data/StatusAccount/Date | string | Fecha del estado de cuenta |
| Data/StatusAccount/NameClient | string | Nombre del cliente |
| Data/StatusAccount/EmailClient | string | Email del cliente |
| Data/StatusAccount/CustomerNumber | string | Número de cliente |
| Data/StatusAccount/Movements[] | array | Movimientos (moneda, cuenta, rendimiento, totales) |
| Data/StatusAccount/Movements[]/Transactions[] | array | Transacciones (fecha, tipo, descripción, montos) |

## Sistemas/Servicios OSB Involucrados

| Servicio | Tipo | Propósito |
|----------|------|-----------|
| HistoricalBankStatemenRestPS | Proxy REST | Punto de entrada del servicio |
| GetParametersRestBS | HTTP/REST | Obtención de parámetros de configuración |
| CloudCodeLoginPS | SOAP | Autenticación y generación de tokens CloudCode |
| CloudCodeRestBS | HTTP/REST | Servicio principal - estadoCuentasHistoricos |
| LoggingRegionalRestBS | HTTP/REST | Logging de entrada/salida |
| GetCustomErrorByStackTraceRegionalRestBS | HTTP/REST | Mapeo de errores |

## Patrón de Diseño

- **Tipo**: Servicio Local HTTP Rest / Soap
- **Template**: PensionHondurasTemplateFicohsa
- **Backend**: CloudCode API (apidev.afpficohsa.com/api/v2)
- **Autenticación Backend**: Bearer Token (OAuth gestionado por CloudCodeLoginPS)
- **Retry**: Automático en caso de error 401 (re-autenticación)

## Riesgos/Limitaciones

- Servicio exclusivo para Honduras (HN01) — no hay implementación multi-región
- Dependencia directa de CloudCode API (AFP Ficohsa) — si el servicio externo no responde, el flujo falla
- Timeout de conexión: 65s, timeout de lectura: 70s
- La homologación de tipo de identificación es hardcodeada en XQuery (1→CC, 2→CAR, 4→PAS, 5→NIT)
- No hay validación de rango de fechas (StartDate <= EndDate) en el servicio legacy
