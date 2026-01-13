# Resumen Ejecutivo - ConsultaDGI

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

La funcionalidad **ConsultaDGI** es un servicio OSB que permite consultar información de impuestos en la Dirección General de Ingresos (DGI) de Nicaragua. Este servicio facilita la consulta de detalles de facturas de impuestos, incluyendo montos, fechas de vencimiento, multas y otros datos fiscales necesarios para el procesamiento de pagos tributarios.

## Entradas y Salidas Principales

### Entrada Principal
- **RUC** (obligatorio): Registro Único de Contribuyente
- **BILL_NUMBER** (obligatorio): Número de factura o BIT (Boleta de Ingreso Tributario)
- **RequestHeader**: Header estándar con información de autenticación y región

### Salida Principal
- **consultaDGIResponse**: Información detallada del impuesto con:
  - TOTAL_AMOUNT: Monto total a pagar
  - DUE_DATE: Fecha de vencimiento
  - TAX_VALUE: Valor del impuesto
  - EXCH_RATE_FEE: Comisión por tipo de cambio
  - LATE_FEE: Multa por mora
  - PENALTY_FEE: Multa por penalización
  - BILL_AMOUNT: Monto de la factura
  - ACCOUNT_CODE: Código de cuenta
  - TAX_DESCRIPTION: Descripción del impuesto

## Sistemas/Servicios OSB Involucrados

### Servicios Principales
- **ConsultaDGI.proxy**: Proxy service principal con enrutamiento regional
- **MapeoErrores**: Servicio para mapeo y manejo de errores
- **ValidaServicioRegional**: Validación de disponibilidad del servicio por región
- **ObtenerParametrizacion**: Servicio para obtener configuraciones específicas

### Servicios por Región

#### NI01 (Nicaragua)
- **CTS impuesto**: Business service que conecta con COBIS Impuestos
- Operación: `OpConsultaDGI`
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
   - Requiere configuración de `FICBCO0256.TIPOCONSULTADGI`
   - Requiere configuración de `FICBCO0256.CODIGOBANCODGI`

3. **Validación de Esquemas**:
   - Validación XSD estricta en entrada
   - Validación de esquema CTS en request a COBIS

### Limitaciones Funcionales
1. **Cobertura Regional Limitada**:
   - Solo implementado para Nicaragua (NI01)
   - Otras regiones retornan error MW-0008

2. **Dependencia de Parametrización**:
   - Falla si no se encuentran los parámetros requeridos
   - Sin parametrización, el servicio no puede procesar solicitudes

3. **Contexto Transaccional COBIS**:
   - Requiere contexto específico de COBIS
   - Canal originador fijo (codCanalOriginador = 1)

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
- **Service ID**: FICBCO0256
- **Endpoint URI**: `/Middleware/OperationsAndExecution/Payments/consultaDGI`
- **Protocolo**: HTTPS/SOAP 1.1

## Parámetros de Configuración

### Parámetros Requeridos (Nicaragua)
1. **FICBCO0256.TIPOCONSULTADGI**: Tipo de consulta DGI
2. **FICBCO0256.CODIGOBANCODGI**: Código del banco para DGI

### Validaciones de Entrada
- **RUC**: String con longitud mínima 1
- **BILL_NUMBER**: String con longitud mínima 1
- **Esquema XSD**: Validación obligatoria contra consultaDGITypes.xsd

## Transformaciones de Datos

### Mapeo de Entrada (OSB → CTS COBIS)
- RUC → valRUC
- BILL_NUMBER → bit
- Parámetros → tipoConsulta, valCodigoBanco
- Contexto fijo → codCanalOriginador = 1

### Mapeo de Salida (CTS COBIS → OSB)
- valMontoBit → TOTAL_AMOUNT y BILL_AMOUNT
- fechaVencimiento → DUE_DATE (con ajuste de timezone)
- valImpuesto → TAX_VALUE
- valMontoMantenimiento → EXCH_RATE_FEE
- valMora → LATE_FEE
- valMulta → PENALTY_FEE
- codigoCuenta → ACCOUNT_CODE
- descripcionImpuesto → TAX_DESCRIPTION

## Manejo de Errores

### Códigos de Respuesta CTS
- **"0"**: Success (mapea a "Success")
- **Otros códigos**: Error (mantiene código original)

### Errores de Parametrización
- **Sin parámetros**: Error con mensaje de validación
- **Parámetros vacíos**: Procesamiento se omite

### Errores Regionales
- **Regiones no NI01**: Error MW-0008
- **Servicio no disponible**: Error de validación regional