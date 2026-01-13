# Resumen Ejecutivo - PagoDGI

## Índice de Documentación

1. [Resumen Ejecutivo](01-ResumenEjecutivo.md)
2. [Comparación entre Regiones](02-ComparativaRegiones.md)
3. [Ejemplos y Mapeos - NI01](03-EjemplosYMapeos-NI01.md)
4. [Ejemplos y Mapeos - OtrasRegiones](03-EjemplosYMapeos-OtrasRegiones.md)
5. [Diagrama de Secuencia - NI01](04-Secuencia-NI01.mmd)
6. [Diagrama de Secuencia - OtrasRegiones](04-Secuencia-OtrasRegiones.mmd)
7. [Flujo Multiregión](05-FlujoMultiregión.mmd)
8. [Listado de Ficheros](06-ListadoFicheros.md)

## Propósito de la Funcionalidad

La funcionalidad **PagoDGI** es un servicio OSB que permite realizar pagos de impuestos a la Dirección General de Ingresos (DGI) de Nicaragua. Este servicio procesa pagos tributarios completos, incluyendo el cálculo de indicadores de pago, registro de transacciones y generación de códigos SIF (Sistema de Información Fiscal) para comprobantes de pago.

## Entradas y Salidas Principales

### Entrada Principal
- **RUC**: Registro Único de Contribuyente (obligatorio)
- **BILL_NUMBER**: Número de factura o BIT (obligatorio)
- **TOTAL_AMOUNT**: Monto total del impuesto (obligatorio)
- **PAYMENT_AMOUNT**: Monto del pago a realizar (obligatorio)
- **ACCOUNT_NUMBER**: Número de cuenta del pagador (obligatorio)
- **TAX_VALUE**: Valor del impuesto (obligatorio)
- **EXCH_RATE_FEE**: Comisión por tipo de cambio (obligatorio)
- **LATE_FEE**: Multa por mora (obligatorio)
- **PENALTY_FEE**: Multa por penalización (obligatorio)
- **DUE_DATE**: Fecha de vencimiento (obligatorio)
- **TAX_DESCRIPTION**: Descripción del impuesto (obligatorio)
- **ACCOUNT_CODE**: Código de cuenta (obligatorio)
- **RequestHeader**: Header estándar con información de autenticación y región

### Salida Principal
- **pagoDGIResponse**: Confirmación del pago con:
  - TOTAL_AMOUNT: Monto total (del request original)
  - DUE_DATE: Fecha de vencimiento (del request original)
  - TAX_VALUE: Valor del impuesto (de la respuesta CTS)
  - EXCH_RATE_FEE: Comisión por tipo de cambio (de la respuesta CTS)
  - LATE_FEE: Multa por mora (de la respuesta CTS)
  - PENALTY_FEE: Multa por penalización (de la respuesta CTS)
  - BILL_AMOUNT: Monto pagado (redondeado)
  - SIF_CODE: Código SIF generado por DGI

## Sistemas/Servicios OSB Involucrados

### Servicios Principales
- **PagoDGI.proxy**: Proxy service principal con enrutamiento regional
- **MapeoErrores**: Servicio para mapeo y manejo de errores
- **ValidaServicioRegional**: Validación de disponibilidad del servicio por región
- **ObtenerParametrizacion**: Servicio para obtener configuraciones específicas

### Servicios por Región

#### NI01 (Nicaragua)
- **CTS impuesto**: Business service que conecta con COBIS Impuestos
- Operación: `OpPagoDGI`
- Endpoint: `http://10.235.53.149:9080/GerenciaCobisImpuestos/SrvAplCobisImpuestosService`

#### Otras Regiones (Default)
- **Error MW-0008**: Servicio no implementado para otras regiones
- Mensaje: "SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY"

## Riesgos/Limitaciones Conocidas

### Riesgos Técnicos
1. **Dependencia Externa Crítica**: 
   - Servicio CTS COBIS Impuestos (solo Nicaragua)
   - Disponibilidad del sistema DGI de Nicaragua

2. **Parametrización Obligatoria**:
   - Requiere 4 parámetros de configuración para NI01
   - Sin parametrización, el servicio no puede procesar pagos

3. **Transaccionalidad**:
   - Pagos son transacciones financieras irreversibles
   - Requiere validación estricta de montos y datos

### Limitaciones Funcionales
1. **Cobertura Regional Limitada**:
   - Solo implementado para Nicaragua (NI01)
   - Otras regiones retornan error MW-0008

2. **Dependencia de Parametrización**:
   - Falla si no se encuentran los parámetros requeridos
   - 4 parámetros obligatorios para funcionamiento

3. **Cálculo de Indicador de Pago**:
   - Lógica específica: 1=Pago completo, 2=Pago parcial
   - Basado en comparación TOTAL_AMOUNT vs PAYMENT_AMOUNT

## Métricas o SLAs

### Configuración de Monitoreo
- **Monitoring**: Deshabilitado (isEnabled="false")
- **Pipeline Monitoring Level**: Pipeline
- **Logging**: Habilitado en nivel debug
- **SLA Alerting**: Habilitado en nivel normal
- **Pipeline Alerting**: Habilitado en nivel normal

### Timeouts Configurados
- **CTS COBIS**: Sin timeout específico configurado (0 = sin límite)
- **Connection Timeout**: Sin límite configurado

### Políticas de Retry
- **Retry Count**: 0 (sin reintentos)
- **Load Balancing**: Round-robin

## Identificador de Servicio
- **Service ID**: FICBCO0257
- **Endpoint URI**: `/Middleware/OperationsAndExecution/Payments/PagoDGI`
- **Protocolo**: HTTPS/SOAP 1.1

## Parámetros de Configuración

### Parámetros Requeridos (Nicaragua)
1. **FICBCO0257.CAJADGI**: Código de caja DGI
2. **FICBCO0257.FORMAPAGODGI**: Forma de pago DGI
3. **FICBCO0256.CODIGOBANCODGI**: Código del banco para DGI (reutilizado de ConsultaDGI)
4. **FICBCO0257.TIPOIMPUESTODGI**: Tipo de impuesto DGI

### Validaciones de Entrada
- **Todos los campos**: Obligatorios según XSD
- **Esquema XSD**: Validación obligatoria contra pagoDGITypes.xsd
- **Montos**: Tipo decimal para cálculos precisos
- **Fechas**: Formato date para DUE_DATE

## Transformaciones de Datos

### Mapeo de Entrada (OSB → CTS COBIS)
- RUC → valRUC
- BILL_NUMBER → bit
- PAYMENT_AMOUNT → valMontoPago
- Fecha/Hora actual → fechaPago/horaPago
- Cálculo indicadorPago → indicadorPago
- Parámetros → formaPago, codigoBanco, caja, tipoImpuesto
- Campos fiscales → valImpuesto, valMontoMantenimiento, valMora, valMulta
- TOTAL_AMOUNT → valMontoBit
- ACCOUNT_NUMBER → cuenta

### Mapeo de Salida (CTS COBIS → OSB)
- Request original → TOTAL_AMOUNT, DUE_DATE
- Respuesta CTS → TAX_VALUE, EXCH_RATE_FEE, LATE_FEE, PENALTY_FEE
- PAYMENT_AMOUNT redondeado → BILL_AMOUNT
- sif → SIF_CODE

## Reglas de Negocio Específicas

### Cálculo de Indicador de Pago
```xquery
if(($valTotal - $valPago) = 0) then '1' else '2'
```
- **"1"**: Pago completo (TOTAL_AMOUNT = PAYMENT_AMOUNT)
- **"2"**: Pago parcial (TOTAL_AMOUNT > PAYMENT_AMOUNT)

### Generación de Fecha/Hora de Pago
- **fechaPago**: Fecha actual con ajuste de timezone
- **horaPago**: Hora actual en formato HH:mm:ss

### Redondeo de Montos
- **BILL_AMOUNT**: `round-half-to-even(PAYMENT_AMOUNT, 2)`

## Manejo de Errores

### Códigos de Respuesta CTS
- **"0"**: Success (incluye transactionId)
- **Otros códigos**: Error (mantiene código original)

### Errores de Parametrización
- **Sin parámetros**: Error con mensaje de validación
- **Parámetros vacíos**: Procesamiento se omite

### Errores Regionales
- **Regiones no NI01**: Error MW-0008
- **Servicio no disponible**: Error de validación regional

## Campos Únicos de PagoDGI

### Campos de Entrada Específicos
- **PAYMENT_AMOUNT**: Monto específico del pago (puede ser menor al total)
- **ACCOUNT_NUMBER**: Cuenta desde la cual se realiza el pago

### Campos de Salida Específicos
- **SIF_CODE**: Código único generado por DGI para el comprobante
- **transactionId**: ID de transacción en header (solo si exitoso)

### Diferencias con ConsultaDGI
- **Más campos**: 12 campos vs 2 en ConsultaDGI
- **Transaccional**: Modifica estado vs solo consulta
- **Más parámetros**: 4 parámetros vs 2 en ConsultaDGI
- **Cálculos**: Incluye lógica de negocio para indicadores