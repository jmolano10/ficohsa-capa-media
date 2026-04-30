# Análisis AS-IS: RetiroEfectivoCBS

## Índice de Documentos

1. [Resumen Ejecutivo](01-ResumenEjecutivo.md)
2. [Comparación entre Regiones](02-ComparativaRegiones.md)
3. [Ejemplos y Mapeos - HN01](03-EjemplosYMapeos-HN01.md)
4. [Diagrama de Secuencia - HN01](04-Secuencia-HN01.mmd)
5. [Diagrama de Flujo Multiregión](05-FlujoMultiregión.mmd)
6. [Listado de Ficheros](06-ListadoFicheros.md)
7. [Mapeo de Errores](07-MapeoErrores.md)

---

## 1. Propósito de la Funcionalidad

**RetiroEfectivoCBS** es un servicio OSB que permite realizar retiros de efectivo a través de corresponsales bancarios (CB). La funcionalidad procesa transacciones de retiro validando la cuenta del cliente, calculando comisiones aplicables y ejecutando la transferencia de fondos desde la cuenta del cliente hacia la cuenta del corresponsal bancario.

## 2. Entradas y Salidas Principales

### Entradas (Request)
- **ACCOUNT_NUMBER**: Número de cuenta del cliente
- **CURRENCY**: Moneda de la transacción
- **AMOUNT**: Monto a retirar
- **TOKEN_ID**: Identificador del token de seguridad
- **TRANSACTION_ID_CB**: Identificador único de la transacción del corresponsal

### Salidas (Response)
- **ACCOUNT_NUMBER**: Número de cuenta procesada
- **AMOUNT**: Monto retirado
- **CURRENCY**: Moneda de la transacción
- **ACCOUNT_NAME**: Nombre de la cuenta
- **TOKEN_ID**: Token de seguridad
- **COMMISION_AMOUNT**: Monto de la comisión aplicada

## 3. Sistemas/Servicios OSB Involucrados

### Servicios Principales
- **RetiroEfectivoCBS.proxy**: Proxy service principal que expone la funcionalidad
- **consultaComisionesCB_db**: Business service para consulta de comisiones
- **svcRegistraTransaccionTengo**: Business service para registro de transacciones en T24
- **consultaCuentasBS**: Business service para consulta de saldos de cuenta
- **transferenciasBS**: Business service para transferencias entre cuentas

### Servicios de Soporte
- **ValidaServicioRegional**: Validación de servicios por región
- **consultarCorresponsalB_db**: Consulta de parámetros del corresponsal
- **registrarUsoServicio_db**: Registro de uso del servicio
- **registraEstadoTransaccion_db**: Registro de estados de transacción
- **actualizaEstadoTransaccion_db**: Actualización de estados de transacción
- **MapeoErrores**: Mapeo de códigos de error

## 4. Regiones Detectadas

Basado en el análisis del código fuente, se identificó la siguiente región:

- **HN01**: Honduras - Única región implementada actualmente en el servicio

## 5. Flujo de Procesamiento

1. **Validación de Esquema**: Validación del request contra el XSD
2. **Registro Inicial**: Registro de la transacción en estado "REGISTRADO"
3. **Validación Regional**: Verificación del servicio para la región (FICBCO0218)
4. **Validación de Corresponsal**: Consulta y validación de parámetros del corresponsal
5. **Validación de Moneda**: Verificación de moneda permitida para el corresponsal
6. **Registro de Uso**: Registro del uso del servicio
7. **Consulta de Comisión**: Cálculo de comisión aplicable (MW_P_CON_COMISION_CORBAN)
8. **Consulta de Saldo**: Verificación de saldo disponible en la cuenta
9. **Validación de Fondos**: Verificación de fondos suficientes (monto + comisión)
10. **Transferencia Principal**: Ejecución de transferencia en T24 (RetiroEfectivoTengo)
11. **Cobro de Comisión**: Transferencia de comisión si aplica
12. **Actualización de Estado**: Actualización final del estado de la transacción

## 6. Riesgos/Limitaciones Conocidas

### Riesgos Identificados
- **Reversión Manual**: En caso de error en el cobro de comisión, se ejecuta reversión automática
- **Validación de Moneda**: Solo se permite una moneda específica por corresponsal
- **Dependencia T24**: El servicio depende completamente de la disponibilidad de T24
- **Transacciones Atómicas**: No hay control de transacciones distribuidas

### Limitaciones
- **Región Única**: Solo implementado para Honduras (HN01)
- **Corresponsal Específico**: Cada corresponsal tiene configuración específica de cuentas y monedas
- **Timeout**: No se especifican timeouts explícitos en las llamadas a servicios externos

## 7. Métricas y SLAs

### Configuración de Monitoreo
- **Monitoring**: Deshabilitado a nivel de pipeline
- **Reporting**: Habilitado
- **SLA Alerting**: Habilitado con nivel normal
- **Pipeline Alerting**: Habilitado con nivel normal
- **Logging**: Habilitado en nivel debug

### Configuración de Retry
- **Retry Count**: 0 (sin reintentos automáticos)
- **Retry Interval**: 30 segundos
- **Retry Application Errors**: Habilitado

### Endpoints
- **URI Principal**: `/SMiddleware/OperationsAndExecution/Payments/RetiroEfectivoCBS`
- **T24 Endpoint**: `http://10.242.104.55:7005/svcRegistraTransaccionTengo/services`

## 8. Consideraciones de Seguridad

- **Autenticación**: Custom token authentication con usuario/contraseña en header
- **Validación de Credenciales**: Lookup de credenciales desde configuración OSB
- **Trazabilidad**: Logging completo de transacciones con identificadores únicos