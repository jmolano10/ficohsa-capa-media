# Resumen Ejecutivo - Depositoenefectivofase12

## Índice
- [Resumen Ejecutivo](01-ResumenEjecutivo.md)
- [Comparativa entre Regiones](02-ComparativaRegiones.md)
- [Ejemplos y Mapeos - HN01](03-EjemplosYMapeos-HN01.md)
- [Diagrama de Secuencia - HN01](04-Secuencia-HN01.mmd)
- [Flujo Multi-región](05-FlujoMultiregión.mmd)
- [Listado de Ficheros](06-ListadoFicheros.md)

## Propósito de la Funcionalidad

La funcionalidad **Depositoenefectivofase12** corresponde a la operación de **depósito en efectivo en moneda extranjera (USD)** dentro del servicio de pago de préstamos de caja. Esta operación permite realizar pagos de préstamos mediante depósitos en efectivo en dólares estadounidenses.

## Entradas y Salidas Principales

### Entradas
- **LOAN_NUMBER**: Número del préstamo a pagar
- **PAYMENT_AMOUNT**: Monto del pago en moneda extranjera (USD)
- **PAYMENT_TYPE**: Tipo de pago = "CASH"
- **Credenciales de autenticación**: UserName y Password

### Salidas
- **Status**: Indicador de éxito/error de la transacción
- **TransactionId**: Identificador único de la transacción T24
- **ValueDate**: Fecha valor de la transacción
- **RTEForm**: Indicador de formulario RTE requerido
- **Messages**: Mensajes de respuesta o error

## Sistemas/Servicios OSB Involucrados

### Proxy Services
- **PagoPrestamoCaja.proxy**: Servicio principal que orquesta el flujo

### Business Services
- **Depositos.biz**: Servicio para operaciones de depósito en T24
- **ObtenerParametrizacion_db.biz**: Obtención de parámetros de configuración
- **consultarPtmoMigrado_db.biz**: Validación de préstamos migrados
- **PagoPrestamo_db.biz**: Registro del pago en base de datos

### Servicios T24
- **Depositoefecenmonedaextranjera**: Operación T24 para depósito en moneda extranjera
- **TELLERFICOHNANYCASHINFCYType**: Tipo de transacción T24 específica

## Riesgos/Limitaciones Conocidas

### Validaciones Críticas
1. **Validación de moneda**: Solo acepta préstamos en USD
2. **Validación de tipo de pago**: Debe ser "CASH"
3. **Validación de préstamo**: Debe existir y estar activo
4. **Parámetros de configuración**: Dependencia de parámetro T24T044.USDCREDITAACCTNO

### Limitaciones
- Solo opera con moneda extranjera (USD)
- Requiere configuración específica de cuentas contables en T24
- Dependiente de disponibilidad de servicios T24
- Sujeto a regulaciones de divisas

## Métricas o SLAs

### Códigos de Error HTTP y Homologación

| Código HTTP | Código Interno | Descripción | Origen |
|-------------|----------------|-------------|---------|
| 200 | SUCCESS | Transacción exitosa | T24 Response |
| 400 | MW-0001 | Parámetros inválidos o faltantes | Validación OSB |
| 400 | MW-0002 | Tipo de préstamo no válido | Validación OSB |
| 500 | T24-ERR-001 | Error en operación T24 | T24 Core |
| 500 | T24-ERR-002 | Cuenta contable no configurada | Configuración |
| 500 | DB-ERR-001 | Error en base de datos | Oracle DB |
| 503 | SVC-UNAVAIL | Servicio T24 no disponible | Infraestructura |

### Mensajes de Error Específicos

| Mensaje de Error | Código HTTP | Acción Recomendada |
|------------------|-------------|-------------------|
| "CURRENCY LOAN NOT SUPPORTED" | 400 | Verificar moneda del préstamo (debe ser USD) |
| "ERROR TRYING TO GET LOAN CURRENCY" | 500 | Revisar conectividad con T24 |
| "ERROR IN T24 OPERATION" | 500 | Verificar logs de T24 |
| "INVALID REQUEST" | 400 | Validar estructura del request |
| "Foreign currency limit exceeded" | 400 | Verificar límites de divisas |
| "Exchange rate not available" | 500 | Verificar configuración de tasas |

### Timeouts y Reintentos
- **Timeout T24**: 30 segundos
- **Timeout DB**: 15 segundos
- **Reintentos**: No configurados (transacción única)

## Región Principal
- **HN01**: Honduras - Región principal donde opera esta funcionalidad