# Historia de Usuario: IngresoDataCapture

> **Como** Equipo de Integración  
> **Quiero** Procesar ingresos de data capture para transacciones bancarias  
> **Para** Permitir el registro de transacciones de débito y crédito en diferentes monedas con información detallada de departamento, centro de beneficio y categorización

## Criterios de Aceptación

### 1. Campos de Entrada del Servicio

| Campo | Descripción | Requerido | Tipo/Formato |
|-------|-------------|-----------|--------------|
| **BATCH_ID** | Identificador único del lote de transacciones | **Sí** | string |
| **DEPARTMENT_CODE** | Código del departamento que procesa la transacción | No | string |
| **ACCOUNT_NUMBER** | Número de cuenta asociada a la transacción | No | string |
| **CURRENCY** | Código de moneda de la transacción | **Sí** | string |
| **AMOUNT** | Monto de la transacción | **Sí** | string |
| **DEBIT_CREDIT** | Indicador de débito o crédito | **Sí** | string |
| **DESCRIPTION** | Descripción de la transacción | **Sí** | string |
| **VALUE_DATE** | Fecha valor de la transacción | No | string |
| **PROFIT_CENTER** | Centro de beneficio asociado | No | string |
| **PROFIT_LOSS_CATEGORY** | Categoría de pérdidas y ganancias | No | string |
| **PRODUCT_CATEGORY** | Categoría del producto | No | string |

> **Validaciones:**
> - BATCH_ID es obligatorio y debe ser único
> - CURRENCY debe ser un código válido de moneda
> - AMOUNT debe ser un valor numérico válido
> - DEBIT_CREDIT debe ser 'D' para débito o 'C' para crédito
> - Se valida la estructura del mensaje contra el esquema XSD
> - Se aplica validación de servicio regional

### 2. Campos de Salida del Servicio

| Campo | Descripción | Requerido | Tipo |
|-------|-------------|-----------|------|
| **ingresoDataCaptureResponse** | Respuesta del servicio de ingreso de data capture | **Sí** | Complex Type |
| &nbsp;&nbsp;&nbsp;&nbsp;└─ **RECORD_STATUS** | Estado del registro procesado | **Sí** | string |

> **Nota:** Todos los campos de salida están validados contra el esquema XSD ingresoDataCaptureTypes.xsd

## Tareas Técnicas

### 1. Códigos de Error

#### 1.1. Códigos de error del Proveedor

| Código Error | Descripción | Tipo Error |
|--------------|-------------|------------|
| T001 | Timeout de conexión al sistema backend | Técnico |
| T002 | Error de formato en respuesta del proveedor | Técnico |
| B001 | BATCH_ID duplicado o inválido | Negocio |
| B002 | Moneda no soportada | Negocio |
| B003 | Monto inválido o fuera de rango | Negocio |
| S001 | Error de conexión a base de datos | Sistema |

> **Nota:** Los códigos de error se mapean desde el sistema backend y se transforman según el estándar del middleware

### 2. Configuración de Timeout

- **Timeout proveedor DataCapture:** 30 segundos
- **Timeout operación del OSB:** 45 segundos

### 3. Datos de Prueba

> **Nota:** Los siguientes son datos de ejemplo no reales, utilizados únicamente para propósitos de testing y documentación.

- **BATCH_ID:** "BATCH001"
- **DEPARTMENT_CODE:** "DEP001"
- **ACCOUNT_NUMBER:** "1234567890"
- **CURRENCY:** "HNL"
- **AMOUNT:** "1000.00"
- **DEBIT_CREDIT:** "D"
- **DESCRIPTION:** "Transacción de prueba"

### 4. Datos de Contacto

**Contacto responsable OSB:**
- **David Ruiz** - david.ruiz@ficohsa.com
- **Wilmer Fernandez** - wilmer.fernandez@ficohsa.com  
- **Francia Avila** - francia.avila@ficohsa.com
- **Diego Gomez** - diego.gomez@ficohsa.com

### 5. Lógica Importante

**Flujo Principal del Servicio:**
1. **Validación XSD:** Se valida la estructura del mensaje contra el esquema ingresoDataCaptureTypes.xsd
2. **Validación Regional:** Se ejecuta ValidaServicioRegional con serviceId "ingresoDataCapture" para verificar disponibilidad por región
3. **Regionalización por País:** El servicio se enruta según el país de origen:
   - **HN01 (Honduras):** Conexión directa al sistema DataCapture local
   - **GT01 (Guatemala):** Conexión al sistema DataCapture Guatemala
   - **PA01 (Panamá):** Conexión al sistema DataCapture Panamá
   - **NI01 (Nicaragua):** Conexión al sistema DataCapture Nicaragua
   - **Default:** Error de país no soportado
4. **Procesamiento de Transacción:** Envío de datos al sistema backend correspondiente
5. **Transformación de Respuesta:** Construcción de respuesta con RECORD_STATUS
6. **Manejo de Errores:** Aplicación de mapeo de errores según tipo

**Servicios Dependientes Analizados:**
- **DataCapture:** Sistema backend para procesamiento de transacciones
- **ObtenerParametrizacion:** Servicio para obtener parámetros de configuración

**Arquitectura Multi-Core:** Servicio Regional Multi-Core que soporta múltiples sistemas core por país

**Seguridad por Usuario:** Autenticación mediante custom token con username/password

### 6. Datos Relevantes

- El servicio no requiere reintentos automáticos
- El servicio no requiere reversos
- Soporte para múltiples monedas según configuración por país
- Procesamiento por lotes mediante BATCH_ID
- Categorización avanzada con centro de beneficio y producto
- Validación de integridad de datos antes del procesamiento
- Logging detallado habilitado para auditoría

### 7. Detalles Técnicos de Conexión

- **Conexión a DataCapture:** Por HTTP - Sistema backend de procesamiento de transacciones
- **Conexión a ObtenerParametrizacion:** Por JCA - Base de datos de parámetros del middleware

### 8. Dependencias del Servicio

**Servicios Internos:**
- ObtenerParametrizacion - Obtención de parámetros de configuración

**Servicios Externos:**
- DataCapture - Sistema backend de procesamiento de transacciones

## 9. Datos del Servicio

| Campo | Valor |
|-------|-------|
| **RUTA** | Middleware\OperationsAndExecution\CustomerDeposits\IngresoDataCapture |
| **URI** | /Middleware/OperationsAndExecution/CustomerDeposits/IngresoDataCapture |
| **NUMERO_OPERACIONES** | 1 |
| **OPERACIONES** | ingresoDataCapture |
| **CODIGO** | ingresoDataCapture |
| **GRUPO_ASIGNADO** | IngresoDataCapture |

## 10. Información del Inventario de Servicios

Servicios relacionados con IngresoDataCapture encontrados en el inventario (GRUPO_ASIGNADO = "IngresoDataCapture"):

| URI | NUMERO_OPERACIONES | OPERACIONES | CODIGO | GRUPO_ASIGNADO | RUTA |
|-----|-------------------|-------------|--------|-----------------|------|
| /Middleware/OperationsAndExecution/CustomerDeposits/IngresoDataCapture | 1 | ingresoDataCapture | ingresoDataCapture | IngresoDataCapture | Middleware\OperationsAndExecution\CustomerDeposits\IngresoDataCapture |

## 11. Servicios Dependientes (Árbol Proxy-Biz)

Servicios que tienen como PROXY_PADRE "Middleware\OperationsAndExecution\CustomerDeposits\IngresoDataCapture":

| PROXY_REFERENCIA | BIZ | URI |
|------------------|-----|-----|
| Middleware\OperationsAndExecution\CustomerDeposits\IngresoDataCapture | \Middleware\Business_Resources\dataCapture\Resources\DataCapture | [http://mwinterbanca:7003/svcDataCapture/services] |
| Middleware\OperationsAndExecution\CustomerDeposits\IngresoDataCapture | \Middleware\Business_Resources\general\Resources\ObtenerParametrizacion\ObtenerParametrizacion | [jca://eis/DB/ConnectionMiddleware] |

## 12. Canales que utilizan la capacidad

**Canales:** No se encontró información de canales para esta capacidad (GRUPO_ASIGNADO: IngresoDataCapture)

**URIs:** N/A

**Número de canales:** 0

---

## Historial de Cambios

| Fecha | Versión | Autor | Descripción |
|-------|---------|-------|-------------|
| 2026-01-02 | 1.0 | ARQ FICOHSA | Creación inicial |
