# Historia de Usuario: ConsultaDGI

> **Como** Equipo de Integración  
> **Quiero** consultar información de impuestos de la Dirección General de Ingresos (DGI) de Nicaragua  
> **Para** permitir a los clientes consultar el estado y detalles de sus obligaciones tributarias

## Criterios de Aceptación

### 1. Campos de Entrada del Servicio

| Campo | Descripción | Requerido | Tipo/Formato |
|-------|-------------|-----------|--------------|
| **consultaDGI** | Elemento raíz de la consulta DGI | **Sí** | Complex Type |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **RUC** | Registro Único de Contribuyente | **Sí** | stringMinLength1 |
| &nbsp;&nbsp;&nbsp;&nbsp;└─ **BILL_NUMBER** | Número de factura o BIT a consultar | **Sí** | stringMinLength1 |

> **Validaciones:**
> - RUC debe tener al menos 1 carácter
> - BILL_NUMBER debe tener al menos 1 carácter
> - Se valida la estructura del mensaje contra el esquema XSD
> - Se aplica validación de servicio regional

### 2. Campos de Salida del Servicio

| Campo | Descripción | Requerido | Tipo |
|-------|-------------|-----------|------|
| **consultaDGIResponse** | Respuesta del servicio de consulta DGI | **Sí** | Complex Type |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **TOTAL_AMOUNT** | Monto total a pagar | No | decimal |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **DUE_DATE** | Fecha de vencimiento | No | date |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **TAX_VALUE** | Valor del impuesto | No | decimal |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **EXCH_RATE_FEE** | Comisión por tipo de cambio | No | decimal |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **LATE_FEE** | Comisión por mora | No | decimal |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **PENALTY_FEE** | Comisión por multa | No | decimal |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **BILL_AMOUNT** | Monto de la factura | No | decimal |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **ACCOUNT_CODE** | Código de cuenta | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;└─ **TAX_DESCRIPTION** | Descripción del impuesto | No | string |

> **Nota:** Todos los campos de salida están validados contra el esquema XSD consultaDGITypes.xsd

## Tareas Técnicas

### 1. Códigos de Error

#### 1.1. Códigos de error del Proveedor

| Código Error | Descripción | Tipo Error |
|--------------|-------------|------------|
| MW-0008 | SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY | Técnico |
| ERROR | Error en validación de servicio regional | Técnico |
| ERROR | Error en obtención de parámetros | Técnico |

> **Nota:** El servicio utiliza mapeo de errores centralizado a través del servicio MapeoErrores

### 2. Configuración de Timeout

- **Timeout proveedor CTS:** 30 segundos
- **Timeout operación del OSB:** 60 segundos

### 3. Datos de Prueba

> **Nota:** Los siguientes son datos de ejemplo no reales, utilizados únicamente para propósitos de testing y documentación.

- **RUC:** J0310000000001
- **BILL_NUMBER:** 123456789
- **TOTAL_AMOUNT:** 1500.00

### 4. Datos de Contacto

**Contacto responsable OSB:**
- **David Ruiz** - david.ruiz@ficohsa.com
- **Wilmer Fernandez** - wilmer.fernandez@ficohsa.com  
- **Francia Avila** - francia.avila@ficohsa.com
- **Diego Gomez** - diego.gomez@ficohsa.com

### 5. Lógica Importante

**Flujo Principal del Servicio:**
1. **Validación XSD:** Se valida la estructura del mensaje contra el esquema consultaDGITypes.xsd
2. **Validación Regional:** Se ejecuta ValidaServicioRegional con serviceId "FICBCO0256" para verificar disponibilidad por región
3. **Regionalización por País:** El servicio se enruta según el país de origen:
   - **NI01 (Nicaragua):** Obtiene parámetros de configuración y consulta el servicio CTS de impuestos
   - **Default:** Retorna error "SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY"
4. **Obtención de Parámetros:** Para Nicaragua, obtiene FICBCO0256.TIPOCONSULTADGI y FICBCO0256.CODIGOBANCODGI
5. **Consulta CTS:** Invoca el servicio de impuestos con la operación OpConsultaDGI
6. **Transformación de Respuesta:** Mapea la respuesta del CTS al formato esperado por el cliente
7. **Manejo de Errores:** Aplicación de mapeo de errores centralizado

**Servicios Dependientes Analizados:**
- **MapeoErrores:** Mapeo centralizado de códigos de error
- **ValidaServicioRegional:** Validación de disponibilidad del servicio por región
- **ObtenerParametrizacion:** Obtención de parámetros de configuración
- **CTS/impuesto:** Servicio backend de consulta de impuestos

**Arquitectura Multi-Core:** Servicio regional específico para Nicaragua (NI01)

**Seguridad por Usuario:** Custom Token Authentication con validación de usuario y contraseña en el header

### 6. Datos Relevantes

- El servicio no requiere reintentos automáticos
- El servicio no requiere reversos
- Servicio específico para consultas tributarias de Nicaragua
- Utiliza parámetros configurables para tipo de consulta y código de banco
- Implementa validación de servicio regional antes del procesamiento
- Manejo de errores centralizado con mapeo específico

### 7. Detalles Técnicos de Conexión

- **Conexión a CTS:** Por HTTP - Servicio de impuestos de Cobis
- **Conexión a Base de Datos:** Por JCA - Para validación regional y parámetros
- **Conexión a MapeoErrores:** Por Proxy - Para manejo centralizado de errores

### 8. Dependencias del Servicio

**Servicios Internos:**
- MapeoErrores - Mapeo centralizado de códigos de error
- ValidaServicioRegional - Validación de disponibilidad por región
- ObtenerParametrizacion - Obtención de parámetros de configuración

**Servicios Externos:**
- CTS/impuesto - Servicio backend de consulta de impuestos de Cobis

## 9. Datos del Servicio

| Campo | Valor |
|-------|-------|
| **RUTA** | Middleware\v2\ProxyServices\ConsultaDGI |
| **URI** | /Middleware/OperationsAndExecution/Payments/consultaDGI |
| **NUMERO_OPERACIONES** | 1 |
| **OPERACIONES** | consultaDGI |
| **CODIGO** | FICBCO0256 |
| **GRUPO_ASIGNADO** | consultaDGI |

## 10. Información del Inventario de Servicios

Servicios relacionados con ConsultaDGI encontrados en el inventario (GRUPO_ASIGNADO = "consultaDGI"):

| URI | NUMERO_OPERACIONES | OPERACIONES | CODIGO | GRUPO_ASIGNADO | RUTA |
|-----|-------------------|-------------|--------|-----------------|------|
| /Middleware/OperationsAndExecution/Payments/consultaDGI | 1 | consultaDGI | FICBCO0256 | consultaDGI | Middleware\v2\ProxyServices\ConsultaDGI |

## 11. Servicios Dependientes (Árbol Proxy-Biz)

Servicios que tienen como PROXY_PADRE "Middleware\v2\ProxyServices\ConsultaDGI":

| PROXY_REFERENCIA | BIZ | URI |
|------------------|-----|-----|
| Middleware\v2\ProxyServices\MapeoErrores | \Middleware\v2\BusinessServices\MapeoErrores\biz\mapeodeErrores_db | [jca://eis/DB/ConnectionMiddleware] |
| Middleware\v2\ProxyServices\MapeoErrores | \Middleware\v2\BusinessServices\MDW\guardarBitacoraMapeoErrores\biz\guardarBitacoraMapeoErrores_db | [jca://eis/DB/ConnectionMiddleware] |
| Middleware\v2\ProxyServices\ConsultaDGI | \Middleware\Business_Resources\general\Resources\ObtenerParametrizacion\ObtenerParametrizacion | [jca://eis/DB/ConnectionMiddleware] |
| Middleware\v2\ProxyServices\ConsultaDGI | \Middleware\v2\BusinessServices\ValidaServicioRegional\biz\ValidaServicioRegional_db | [jca://eis/DB/ConnectionMiddleware] |
| Middleware\v2\ProxyServices\ConsultaDGI | \Middleware\v2\BusinessServices\CTS\impuesto\biz\impuesto | [http://10.235.53.149:9080/GerenciaCobisImpuestos/SrvAplCobisImpuestosService] |

## 12. Canales que utilizan la capacidad

**Canales:** INTERBANCA

**URIs:** /Middleware/OperationsAndExecution/Payments/consultaDGI

**Número de canales:** 1

---

## Comentarios
En el diseño no debería pasar por CTS.

## Historial de Cambios

| Fecha | Versión | Autor | Descripción |
|-------|---------|-------|-------------|
| 2024-12-19 | 1.0 | ARQ FICOHSA | Creación inicial |