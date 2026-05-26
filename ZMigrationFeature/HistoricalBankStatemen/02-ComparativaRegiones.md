# Comparativa de Regiones: HistoricalBankStatemen

## Tabla de Comparación

| Aspecto | Honduras (HN01) |
|---------|-----------------|
| **Endpoint OSB** | `/regional/pension/rest/HistoricalBankStatemen/v1` |
| **Nombre de Base de Datos** | N/A (no usa BD directa) |
| **Esquemas** | N/A |
| **Store Procedure** | N/A |
| **Nombre de Conexión** | CloudCodeRestBS → `apidev.afpficohsa.com/api/v2` |
| **Transformaciones clave** | `HistoricalBankStatemenToCloudCode.xqy` (entrada), `CloudCodeToHistoricalBankStatemen.xqy` (salida) |
| **Campos diferenciadores** | Homologación tipoIdentificacion: 1→CC, 2→CAR, 4→PAS, 5→NIT |
| **Errores/Excepciones** | Manejo de 401 con re-autenticación automática, mapeo de errores vía GetCustomErrorByStackTrace |
| **Timeouts/Retrys** | Connection: 65s, Read: 70s. Retry automático en 401 |
| **Dependencias internas** | GetParametersRestBS, CloudCodeLoginPS, LoggingRegionalRestBS, GetCustomErrorByStackTraceRegionalRestBS |
| **Protocolo Backend** | HTTP/REST (JSON) |
| **Autenticación Backend** | Bearer Token (OAuth CloudCode) |
| **Parámetro de Configuración** | PG13516.SERVICE.ACCOUNT.APIFPC |

## Detalle Honduras (HN01)

### Endpoint y Operación
- **Proxy**: `SBHN_Pension_HistoricalBankStatemen/PS/HistoricalBankStatemenRestPS.ProxyService`
- **Operación Backend**: `POST /estados-cuentas/historicos`
- **URL Backend**: `https://apidev.afpficohsa.com/api/v2/estados-cuentas/historicos`

### Flujo de Autenticación
1. Obtener parámetros de configuración (GetParametersRestBS)
2. Extraer credenciales (ExtractCredentialsAPIFPC.xqy)
3. Login en CloudCode (CloudCodeLoginPS) → obtener token
4. Usar token como Bearer en llamada al backend
5. Si respuesta 401 → re-login con `forceLogin=true` → retry

### Validaciones
- Validación de esquema XSD en entrada
- Campos obligatorios: IdentificationType, IdentificationNumber, StartDate, EndDate
- No hay validación de rango de fechas en el servicio legacy

### Políticas OSB
- Dispatch Policy: SBPensionManager
- SSL/TLS requerido
- Load Balancing: Round-robin en CloudCodeRestBS

### Manejo de Errores
- Error de parámetros → respuesta de error inmediata
- Error 401 → re-autenticación automática con retry
- Otros errores → GetCustomErrorByStackTraceRegionalRestBS para homologar código HTTP
- Transformación de error: `ErrorToHistoricalBankStatemen.xqy`

## Regiones No Implementadas

| Región | Estado |
|--------|--------|
| Guatemala (GT01) | No implementado |
| Nicaragua (NI01) | No implementado |
| Panamá (PA01) | No implementado |

> **Nota**: Este servicio es exclusivo para Honduras. No existe implementación para otras regiones.
