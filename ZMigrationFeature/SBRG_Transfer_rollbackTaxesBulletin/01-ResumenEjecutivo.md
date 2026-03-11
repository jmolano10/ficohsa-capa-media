# Resumen Ejecutivo - RollbackTaxesBulletin

## Índice
- [Resumen Ejecutivo](01-ResumenEjecutivo.md)
- [Comparativa entre Regiones](02-ComparativaRegiones.md)
- [Ejemplos y Mapeos - HN01](03-EjemplosYMapeos-HN01.md)
- [Diagrama de Secuencia - HN01](04-Secuencia-HN01.mmd)
- [Diagrama de Flujo Multiregión](05-FlujoMultiregion.mmd)
- [Listado de Ficheros](06-ListadoFicheros.md)

---

## 1. Propósito de la Funcionalidad

La funcionalidad **RollbackTaxesBulletin** permite realizar la reversión de transacciones de pago de recaudo de impuestos (boletines fiscales) previamente procesadas en el sistema core bancario T24. Esta operación es crítica para corregir transacciones erróneas o duplicadas relacionadas con pagos de impuestos.

## 2. Entradas y Salidas Principales

### Entrada (Request)
- **TransactionId**: Identificador único de la transacción a reversar
- **GeneralInfo**: Información general que incluye:
  - SourceBank: Banco origen (HN01 para Honduras)
  - DestinationBank: Banco destino
  - GlobalId: Identificador global de trazabilidad
  - ApplicationId: Identificador de la aplicación cliente
  - ApplicationUser: Usuario de la aplicación
  - BranchId: Identificador de sucursal
  - TransactionDate: Fecha de transacción
  - Language: Idioma (ES/EN)

### Salida (Response)
- **StatusInfo**: Información del estado de la operación
  - Status: Estado de la transacción (Success/Error)
  - TransactionId: ID de transacción procesada
  - ValueDate: Fecha valor
  - DateTime: Fecha y hora de procesamiento
  - GlobalId: Identificador global
- **ErrorInfo**: Información de errores (si aplica)
  - Code: Código de error mapeado
  - Error: Tipo de error
  - Description: Descripción detallada
  - ShortDescription: Descripción corta
  - Details: Detalles del sistema origen del error

## 3. Sistemas/Servicios OSB Involucrados

### Proxy Services (Puntos de Entrada)
- **RollbackTaxesBulletinSoapPS**: Servicio SOAP
  - Endpoint: `/honduras/transfer/soap/rollbackTaxesBulletin/v1`
  - Protocolo: HTTPS
  - Política de seguridad: HTTP Basic Auth over SSL (OWSM)
  
- **RollbackTaxesBulletinRestPS**: Servicio REST
  - Endpoint: `/honduras/transfer/rest/rollbackTaxesBulletin/v1`
  - Protocolo: HTTPS
  - Política de seguridad: HTTP Basic Auth over SSL (OWSM)

### Pipeline
- **RollbackTaxesBulletinPP**: Pipeline principal que orquesta el flujo
  - Template base: TransferHondurasFicohsaTemplate

### Business Services (Servicios Backend)
- **ReversarTransaccionSoapT24BS**: Conexión SOAP a T24
  - URL: `http://172.23.13.19:7003/RollbackTaxesBulletin/services`
  - Operación: rollbackTaxesBulletin
  - Timeout: 0 (sin límite)
  - Retry: 0 intentos

### Servicios Auxiliares
- **ExtractCredentials**: Extracción de credenciales desde LDAP
- **GetCustomErrorByStackTraceRegionalRestBS**: Mapeo de errores
- **LoggingRegionalRestBS**: Registro de logs

## 4. Riesgos/Limitaciones Conocidas

### Riesgos
1. **Sin timeout configurado**: El Business Service tiene timeout en 0, lo que puede causar bloqueos indefinidos
2. **Sin reintentos**: Retry count en 0, no hay recuperación automática ante fallos transitorios
3. **Dependencia crítica de T24**: Si T24 no está disponible, no hay mecanismo de fallback
4. **Seguridad de credenciales**: Las credenciales se extraen de LDAP pero se envían en texto plano a T24

### Limitaciones
1. **Región única**: Solo implementado para Honduras (HN01)
2. **Validación limitada**: Solo valida el esquema XML, no hay validaciones de negocio adicionales
3. **Reversión simple**: Solo permite reversar por TransactionId, sin validaciones adicionales de estado
4. **Sin idempotencia**: No hay control de reversiones duplicadas

## 5. Métricas o SLAs

**No se encontraron métricas o SLAs explícitos en el código fuente.**

### Configuraciones Relevantes
- **Dispatch Policy**: SBTransferManager (para gestión de hilos)
- **Compression**: Deshabilitada
- **Session Stickiness**: Deshabilitada
- **Chunked Streaming**: Habilitado

## 6. Flujo General

1. Cliente invoca el servicio (SOAP o REST)
2. OSB valida seguridad (HTTP Basic Auth over SSL)
3. Pipeline extrae credenciales de LDAP
4. Transforma request regional a formato T24
5. Invoca servicio T24 para reversión
6. Evalúa respuesta de T24:
   - Si Success: Transforma respuesta T24 a formato regional
   - Si Error: Mapea error y construye respuesta de error
7. Registra logs de entrada y salida
8. Retorna respuesta al cliente

## 7. Consideraciones de Migración

### Puntos Críticos
- Migrar configuración de seguridad OWSM
- Validar conectividad con T24 en nuevo ambiente
- Migrar credenciales LDAP (SB_Security/Common/)
- Configurar políticas de timeout y retry apropiadas
- Implementar monitoreo y alertas

### Recomendaciones
- Configurar timeouts razonables (sugerido: 30-60 segundos)
- Implementar estrategia de reintentos (sugerido: 2-3 intentos)
- Agregar validaciones de negocio adicionales
- Implementar control de idempotencia
- Considerar implementación para otras regiones si aplica
