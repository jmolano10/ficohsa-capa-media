# Historia de Usuario: PagoDGI

> **Como** Equipo de Integración  
> **Quiero** Implementar el servicio de pago de impuestos a la Dirección General de Ingresos (DGI)  
> **Para** Permitir a los clientes realizar pagos de tributos e impuestos de manera digital y segura

## Criterios de Aceptación

### 1. Campos de Entrada del Servicio

| Campo | Descripción | Requerido | Tipo/Formato |
|-------|-------------|-----------|--------------| 
| **RUC** | Registro Único de Contribuyente | **Sí** | string |
| **BILL_NUMBER** | Número de factura o documento tributario | **Sí** | string |
| **TOTAL_AMOUNT** | Monto total del impuesto | **Sí** | decimal |
| **PAYMENT_AMOUNT** | Monto a pagar | **Sí** | decimal |
| **ACCOUNT_NUMBER** | Número de cuenta del cliente | **Sí** | string |
| **TAX_VALUE** | Valor del impuesto base | **Sí** | decimal |
| **EXCH_RATE_FEE** | Comisión por tipo de cambio | **Sí** | decimal |
| **LATE_FEE** | Recargo por mora | **Sí** | decimal |
| **PENALTY_FEE** | Multa o penalización | **Sí** | decimal |
| **DUE_DATE** | Fecha de vencimiento | **Sí** | date |
| **TAX_DESCRIPTION** | Descripción del impuesto | **Sí** | string |
| **ACCOUNT_CODE** | Código de cuenta contable | **Sí** | string |

> **Validaciones:**
> - Se valida que el RUC tenga formato válido
> - Se valida que los montos sean positivos
> - Se valida que la fecha de vencimiento sea válida
> - Se valida la estructura del mensaje contra el esquema XSD
> - Se aplica validación de servicio regional

### 2. Campos de Salida del Servicio

| Campo | Descripción | Requerido | Tipo |
|-------|-------------|-----------|------|
| **pagoDGIResponse** | Respuesta del servicio de pago DGI | **Sí** | Complex Type |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **TOTAL_AMOUNT** | Monto total procesado | No | decimal |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **DUE_DATE** | Fecha de vencimiento confirmada | No | date |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **TAX_VALUE** | Valor del impuesto confirmado | No | decimal |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **EXCH_RATE_FEE** | Comisión por tipo de cambio aplicada | No | decimal |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **LATE_FEE** | Recargo por mora aplicado | No | decimal |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **PENALTY_FEE** | Multa aplicada | No | decimal |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **BILL_AMOUNT** | Monto de la factura | No | decimal |
| &nbsp;&nbsp;&nbsp;&nbsp;└─ **SIF_CODE** | Código SIF de la transacción | No | string |

> **Nota:** Todos los campos de salida están validados contra el esquema XSD pagoDGITypes.xsd

## Tareas Técnicas

### 1. Códigos de Error

#### 1.1. Códigos de error del Proveedor

| Código Error | Descripción | Tipo Error |
|--------------|-------------|------------|
| MW-0008 | SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY | Técnico |
| FICBCO0257 | Error específico del servicio PagoDGI | Negocio |

> **Nota:** Los errores se mapean a través del servicio MapeoErrores

### 2. Configuración de Timeout

- **Timeout proveedor CTS:** 60 segundos
- **Timeout operación del OSB:** 30 segundos

### 3. Datos de Prueba

> **Nota:** Los siguientes son datos de ejemplo no reales, utilizados únicamente para propósitos de testing y documentación.

- **RUC:** J0310000000001
- **BILL_NUMBER:** FAC-2024-001
- **TOTAL_AMOUNT:** 1500.00
- **PAYMENT_AMOUNT:** 1500.00
- **ACCOUNT_NUMBER:** 1234567890
- **TAX_VALUE:** 1200.00
- **EXCH_RATE_FEE:** 50.00
- **LATE_FEE:** 100.00
- **PENALTY_FEE:** 150.00
- **DUE_DATE:** 2024-12-31
- **TAX_DESCRIPTION:** Impuesto sobre la Renta
- **ACCOUNT_CODE:** 4110001

### 4. Datos de Contacto

**Contacto responsable OSB:**
- **David Ruiz** - david.ruiz@ficohsa.com
- **Wilmer Fernandez** - wilmer.fernandez@ficohsa.com  
- **Francia Avila** - francia.avila@ficohsa.com
- **Diego Gomez** - diego.gomez@ficohsa.com

### 5. Lógica Importante

**Flujo Principal del Servicio:**
1. **Validación XSD:** Se valida la estructura del mensaje contra el esquema pagoDGITypes.xsd
2. **Validación Regional:** Se ejecuta ValidaServicioRegional con serviceId "FICBCO0257" para verificar disponibilidad por región
3. **Regionalización por País:** El servicio se enruta según el país de origen:
   - **NI01 (Nicaragua):** Implementación completa con flujo específico:
     - Validación de parámetros específicos de DGI Nicaragua (CAJADGI, FORMAPAGODGI, CODIGOBANCODGI, TIPOIMPUESTODGI)
     - Conexión directa al sistema CTS (Cobis Tax System) en endpoint http://10.235.53.149:9080/GerenciaCobisImpuestos/SrvAplCobisImpuestosService
     - Transformación de datos según formato requerido por la DGI de Nicaragua
     - Manejo de códigos de respuesta específicos del sistema tributario nicaragüense
     - Procesamiento de diferentes tipos de impuestos: ISR, IVA, IR, Selectivo de Consumo
     - Validación de RUC según formato nicaragüense (14 dígitos)
     - Cálculo automático de recargos por mora según tabla de la DGI
     - Generación de comprobante de pago con formato oficial DGI
   - **Default:** Retorna error "SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY"
4. **Obtención de Parámetros:** Se consultan parámetros de configuración específicos para DGI
5. **Procesamiento de Pago:** Se invoca el servicio CTS para procesar el pago de impuestos
6. **Transformación de Respuesta:** Se construye la respuesta con los datos del pago procesado
7. **Manejo de Errores:** Se aplica mapeo de errores a través del servicio MapeoErrores

**Servicios Dependientes Analizados:**
- **MapeoErrores:** Mapeo y transformación de códigos de error
- **ValidaServicioRegional:** Validación de disponibilidad del servicio por región
- **CTS/impuesto:** Servicio backend para procesamiento de pagos de impuestos
- **ObtenerParametrizacion:** Obtención de parámetros de configuración

**Arquitectura Multi-Core:** Soporte únicamente para Nicaragua (NI01) a través del sistema CTS

**Seguridad por Usuario:** Custom Token Authentication con validación de usuario y contraseña en el header

### 6. Datos Relevantes

- El servicio requiere parámetros de configuración específicos para DGI
- El servicio no requiere reintentos automáticos
- El servicio no requiere reversos
- Implementación específica para pagos de impuestos en Nicaragua
- Conexión directa con el sistema CTS (Cobis Tax System)
- Validación de parámetros: CAJADGI, FORMAPAGODGI, CODIGOBANCODGI, TIPOIMPUESTODGI
- Manejo de diferentes tipos de comisiones y recargos
- Soporte para múltiples tipos de impuestos

### 7. Detalles Técnicos de Conexión

- **Conexión a CTS:** Por HTTP/SOAP - Sistema de impuestos Cobis
- **Conexión a Base de Datos:** Por JCA - Consulta de parámetros y validaciones regionales

### 8. Dependencias del Servicio

**Servicios Internos:**
- MapeoErrores - Mapeo de códigos de error
- ValidaServicioRegional - Validación regional del servicio
- ObtenerParametrizacion - Obtención de parámetros de configuración

**Servicios Externos:**
- CTS/impuesto - Sistema de procesamiento de impuestos Cobis

## 9. Datos del Servicio

| Campo | Valor |
|-------|-------|
| **RUTA** | Middleware\v2\ProxyServices\PagoDGI |
| **URI** | /Middleware/OperationsAndExecution/Payments/PagoDGI |
| **NUMERO_OPERACIONES** | 1 |
| **OPERACIONES** | pagoDGI |
| **CODIGO** | FICBCO0257$0256 |
| **GRUPO_ASIGNADO** | PagoDGI |

## 10. Información del Inventario de Servicios

Servicios relacionados con PagoDGI encontrados en el inventario (GRUPO_ASIGNADO = "PagoDGI"):

| URI | NUMERO_OPERACIONES | OPERACIONES | CODIGO | GRUPO_ASIGNADO | RUTA |
|-----|-------------------|-------------|--------|-----------------|------|
| /Middleware/OperationsAndExecution/Payments/PagoDGI | 1 | pagoDGI | FICBCO0257$0256 | PagoDGI | Middleware\v2\ProxyServices\PagoDGI |

## 11. Servicios Dependientes (Árbol Proxy-Biz)

Servicios que tienen como PROXY_PADRE "Middleware\v2\ProxyServices\PagoDGI":

| PROXY_REFERENCIA | BIZ | URI |
|------------------|-----|-----|
| Middleware\v2\ProxyServices\PagoDGI | \Middleware\v2\BusinessServices\CTS\impuesto\biz\impuesto | [http://10.235.53.149:9080/GerenciaCobisImpuestos/SrvAplCobisImpuestosService] |
| Middleware\v2\ProxyServices\MapeoErrores | \Middleware\v2\BusinessServices\MapeoErrores\biz\mapeodeErrores_db | [jca://eis/DB/ConnectionMiddleware] |
| Middleware\v2\ProxyServices\PagoDGI | \Middleware\v2\BusinessServices\ValidaServicioRegional\biz\ValidaServicioRegional_db | [jca://eis/DB/ConnectionMiddleware] |
| Middleware\Business_Resources\general\Resources\ObtenerParametrizacion\ObtenerParametrizacion | \Middleware\Business_Resources\general\Resources\ObtenerParametrizacion\ObtenerParametrizacion | [jca://eis/DB/ConnectionMiddleware] |

## 12. Canales que utilizan la capacidad

**Canales:** INTERBANCA

**URIs:** /Middleware/OperationsAndExecution/Payments/PagoDGI

**Número de canales:** 1

---

## Historial de Cambios

| Fecha | Versión | Autor | Descripción |
|-------|---------|-------|-------------|
| 2024-12-19 | 1.0 | ARQ FICOHSA | Creación inicial |