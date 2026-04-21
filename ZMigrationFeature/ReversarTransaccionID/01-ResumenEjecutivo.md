# Resumen Ejecutivo - ReversarTransaccionID

## Índice de Documentos
- [01-ResumenEjecutivo.md](01-ResumenEjecutivo.md)
- [02-ComparativaRegiones.md](02-ComparativaRegiones.md)
- [03-EjemplosYMapeos-HN01.md](03-EjemplosYMapeos-HN01.md)
- [03-EjemplosYMapeos-GT01.md](03-EjemplosYMapeos-GT01.md)
- [03-EjemplosYMapeos-PA01.md](03-EjemplosYMapeos-PA01.md)
- [03-EjemplosYMapeos-NI01.md](03-EjemplosYMapeos-NI01.md)
- [04-Secuencia-HN01.mmd](04-Secuencia-HN01.mmd)
- [04-Secuencia-GT01.mmd](04-Secuencia-GT01.mmd)
- [04-Secuencia-PA01.mmd](04-Secuencia-PA01.mmd)
- [04-Secuencia-NI01.mmd](04-Secuencia-NI01.mmd)
- [05-FlujoMultiregión.mmd](05-FlujoMultiregión.mmd)
- [06-ListadoFicheros.md](06-ListadoFicheros.md)
- [07-MapeoErrores.md](07-MapeoErrores.md)

## Propósito de la Funcionalidad

La funcionalidad **ReversarTransaccionID** es un servicio OSB que permite reversar transacciones financieras previamente procesadas en el sistema bancario. Este servicio actúa como un mecanismo de control y corrección que permite deshacer operaciones que han sido ejecutadas incorrectamente o que requieren ser anuladas por razones operativas o de negocio.

## Entradas y Salidas Principales

### Entrada Principal
- **TRANSACTION_TYPE**: Tipo de transacción a reversar (PAGO_TC, PAGO_EEH, DEPOSITO, RETIRO, etc.)
- **TRANSACTION_ID**: Identificador único de la transacción a reversar (UUID)
- **RequestHeader**: Header de autenticación con credenciales de usuario

### Salida Principal
- **T24_REFERENCE**: Referencia de la transacción de reversión en T24
- **TRANSACTION_ID**: ID de la transacción original
- **REFERENCE_CB**: Referencia de la transacción en Core Banking
- **ResponseHeader**: Header de respuesta con indicador de éxito/error

## Sistemas/Servicios OSB Involucrados

### Servicios Principales
1. **Proxy Service**: `ReversarTransaccionID.proxy`
   - Endpoint: `/Middleware/SalesAndServices/BankingPartner/reversarTransaccionID`
   - Servicio ID: `FICBCO0516`
   - Protocolo: SOAP 1.1
   - Autenticación: Custom token authentication (Username/Password)
   - Logging: Debug level habilitado
   - Monitoring: Pipeline level
   - Alerting: SLA y Pipeline alerting en nivel normal

### Business Services Dependientes

#### Servicios de Base de Datos (MDW)
1. **consultaRutaRegional_db**
   - Conexión: `jca://eis/DB/ConnectionMiddleware`
   - Stored Procedure: `MW_P_CONSULTA_RUTA_REGIONAL`
   - Propósito: Consulta configuración regional del servicio

2. **obtenerTipoTrxGen_db**
   - Conexión: `jca://eis/DB/ConnectionMiddleware`
   - Stored Procedure: `obtenerTipoTrxGen`
   - Propósito: Determina si la transacción es genérica o específica

3. **validarEstadoTransaccion_db**
   - Conexión: `jca://eis/DB/ConnectionMiddleware`
   - Stored Procedure: `validarEstadoTransaccion`
   - Propósito: Valida que la transacción esté en estado reversible

4. **registrarReversionTCCB_db**
   - Conexión: `jca://eis/DB/ConnectionMiddleware`
   - Stored Procedure: `registrarReversionTCCB`
   - Propósito: Registra la reversión de pagos de tarjeta de crédito

5. **actualizarEstadoTransaccionUUID_db**
   - Conexión: `jca://eis/DB/ConnectionMiddleware`
   - Stored Procedure: `actualizarEstadoTransaccionUUID`
   - Propósito: Actualiza el estado de la transacción a "Reversada" (R)

6. **actualizarTransaccionGenCB_db**
   - Conexión: `jca://eis/DB/ConnectionMiddleware`
   - Stored Procedure: `actualizarTransaccionGenCB`
   - Propósito: Actualiza transacciones genéricas en Core Banking

7. **conReversarPagoTCRG_db**
   - Conexión: `jca://eis/DB/ConnectionMiddleware`
   - Stored Procedure: `conReversarPagoTCRG`
   - Propósito: Confirma la reversión de pagos TC en Master Data

#### Servicios de T24
8. **svcReversarTransaccionCB**
   - Endpoint: `http://10.242.104.55:7004/svcReversarTransaccionCB/services`
   - Operaciones: `ReversionPagoTCTengo`, `ReversionDepositoTengo`
   - Propósito: Ejecuta reversiones en T24 Core Banking

9. **svcGestionesTrxSEEHTENGO**
   - Operación: `ReversarTransaccionTENGOEEH`
   - Propósito: Gestión de reversiones para transacciones EEH (servicios públicos)

### Sistemas Backend
- **T24 Core Banking**: Sistema principal para procesamiento de transacciones financieras
- **Core Banking (CB)**: Sistema de banca central para operaciones específicas
- **Base de datos MDW**: Base de datos middleware para control y auditoría de transacciones
- **LDAP Security**: Sistema de autenticación para credenciales de usuario

## Tipos de Transacciones Soportadas

El servicio soporta la reversión de los siguientes tipos de transacciones:

- **RETIRO**: Retiros de efectivo
- **PAGO_TC**: Pagos de tarjeta de crédito
- **PAGO_REMESA**: Pagos de remesas
- **PAGO_PRESTAMO**: Pagos de préstamos
- **DEPOSITO**: Depósitos a cuentas
- **PAGO_RECAUDO**: Pagos de recaudos
- **PAGO_EEH**: Pagos de servicios públicos (EEH)
- **CUPON**: Transacciones con cupón
- **CAN_CUPON_HIST**: Cancelación de cupón histórico
- **CASHOUT/CASHIN**: Operaciones de efectivo
- **CASHIN_TC**: Depósito con tarjeta de crédito
- **TRANSFER_CRED**: Transferencias de crédito
- **MIG_TC**: Migración de tarjeta de crédito
- **ADJ_CRTPP/ADJ_CRBM/ADJ_DBTPP/ADJ_TC**: Ajustes diversos

## Regiones Detectadas

Basado en el análisis del código fuente, se identificaron las siguientes regiones:

- **HN01**: Honduras
- **GT01**: Guatemala  
- **PA01**: Panamá
- **NI01**: Nicaragua

## Flujo de Procesamiento Detallado

### Etapa 1: Validación Regional
- **Servicio**: `consultaRutaRegional_db`
- **Parámetros**: Servicio ID (`FICBCO0516`), RequestHeader, Operación, Versión (`V2`)
- **Validación**: Verifica que el servicio esté habilitado para la región
- **Error**: Si falla, retorna error y termina el procesamiento

### Etapa 2: Clasificación de Transacción
- **Servicio**: `obtenerTipoTrxGen_db`
- **Entrada**: `TRANSACTION_TYPE` del request
- **Salida**: Tipo de transacción (`GEN` para genérica, `NOGEN` para específica)
- **Lógica**: Determina el tipo de consulta (1 para NOGEN, 4 para GEN)

### Etapa 3: Validación de Estado
- **Servicio**: `validarEstadoTransaccion_db`
- **Parámetros**: UUID de transacción, tipo de consulta, código de estado (0)
- **Validación**: Verifica que `PV_MESSAGE = 'TRUE'` (transacción reversible)
- **Datos obtenidos**: Referencia T24, UUID de BD, referencia CB

### Etapa 4: Procesamiento de Reversión (Condicional)

#### Para PAGO_TC:
1. **Registro en CB**: `registrarReversionTCCB_db`
2. **Reversión en T24**: `svcReversarTransaccionCB.ReversionPagoTCTengo`
3. **Confirmación MD**: `conReversarPagoTCRG_db` (si T24 exitoso)

#### Para PAGO_EEH:
1. **Reversión directa**: `svcGestionesTrxSEEHTENGO.ReversarTransaccionTENGOEEH`

#### Para otros tipos (DEPOSITO, RETIRO, etc.):
1. **Reversión genérica**: `svcReversarTransaccionCB.ReversionDepositoTengo`

### Etapa 5: Actualización de Estado
- **Condición**: Solo si la reversión fue exitosa
- **Transacciones no genéricas**: `actualizarEstadoTransaccionUUID_db` (estado = 'R')
- **Transacciones genéricas**: `actualizarTransaccionGenCB_db`

### Etapa 6: Construcción de Respuesta
- **Éxito**: Retorna T24_REFERENCE, TRANSACTION_ID, REFERENCE_CB
- **Error**: Retorna mensaje de error específico
- **Header**: successIndicator (SUCCESS/ERROR) y messageId

## Riesgos/Limitaciones Conocidas

### Riesgos Operativos
- **Transacciones No Reversibles**: Algunas transacciones pueden no estar en estado válido para reversión
- **Dependencia de T24**: Fallas en T24 pueden impedir la reversión completa
- **Integridad de Datos**: Riesgo de inconsistencias si falla la actualización de estado

### Limitaciones Técnicas
- **Validación de Estado**: Solo se pueden reversar transacciones en estado específico
- **Tipos de Transacción**: Limitado a los tipos definidos en el enum TransactionType
- **Autenticación Requerida**: Requiere credenciales válidas en el header

### Limitaciones de Negocio
- **Ventana de Tiempo**: Puede existir limitación temporal para reversiones
- **Autorización**: Requiere permisos específicos del usuario
- **Auditoría**: Todas las reversiones quedan registradas para auditoría

## Métricas y SLAs

### Métricas de Rendimiento
- **Tiempo de Respuesta**: No especificado en configuración
- **Disponibilidad**: Configurado con alertas SLA normales
- **Logging**: Habilitado en nivel debug
- **Monitoreo**: Habilitado a nivel de pipeline

### Configuración de Alertas
- **SLA Alerting**: Habilitado con nivel normal
- **Pipeline Alerting**: Habilitado con nivel normal
- **Reporting**: Habilitado para métricas

## Consideraciones de Seguridad

- **Autenticación**: Validación de usuario/contraseña en header
- **Autorización**: Control de acceso basado en credenciales
- **Auditoría**: Registro completo de todas las operaciones de reversión
- **Trazabilidad**: Mantenimiento de referencias cruzadas entre sistemas