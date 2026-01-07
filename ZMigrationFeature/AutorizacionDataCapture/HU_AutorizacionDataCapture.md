# Historia de Usuario: AutorizacionDataCapture

> **Como** Equipo de Integración  
> **Quiero** Autorizar transacciones de data capture mediante identificador único  
> **Para** Validar y confirmar transacciones previamente ingresadas en el sistema de data capture

## Criterios de Aceptación

### 1. Campos de Entrada del Servicio

| Campo | Descripción | Requerido | Tipo/Formato |
|-------|-------------|-----------|--------------|
| **DATA_CAPTURE_ID** | Identificador único de la transacción de data capture a autorizar | **Sí** | string |

> **Validaciones:**
> - DATA_CAPTURE_ID es obligatorio y debe existir en el sistema
> - El identificador debe corresponder a una transacción válida pendiente de autorización
> - Se valida la estructura del mensaje contra el esquema XSD
> - Se aplica validación de servicio regional

### 2. Campos de Salida del Servicio

| Campo | Descripción | Requerido | Tipo |
|-------|-------------|-----------|------|
| **autorizacionDataCaptureResponse** | Respuesta del servicio de autorización de data capture | **Sí** | Complex Type |
| &nbsp;&nbsp;&nbsp;&nbsp;└─ **TRANSACTION_DATE** | Fecha y hora de autorización de la transacción | **Sí** | string |

> **Nota:** Todos los campos de salida están validados contra el esquema XSD autorizacionDataCaptureTypes.xsd

## Tareas Técnicas

### 1. Códigos de Error

#### 1.1. Códigos de error del Proveedor

| Código Error | Descripción | Tipo Error |
|--------------|-------------|------------|
| T001 | Timeout de conexión al sistema backend | Técnico |
| T002 | Error de formato en respuesta del proveedor | Técnico |
| B001 | DATA_CAPTURE_ID no encontrado | Negocio |
| B002 | Transacción ya autorizada previamente | Negocio |
| B003 | Transacción en estado inválido para autorización | Negocio |
| S001 | Error de conexión a base de datos | Sistema |

> **Nota:** Los códigos de error se mapean desde el sistema backend y se transforman según el estándar del middleware

### 2. Configuración de Timeout

- **Timeout proveedor DataCapture:** 30 segundos
- **Timeout operación del OSB:** 45 segundos

### 3. Datos de Prueba

> **Nota:** Los siguientes son datos de ejemplo no reales, utilizados únicamente para propósitos de testing y documentación.

- **DATA_CAPTURE_ID:** "DC001234567890"

### 4. Datos de Contacto

**Contacto responsable OSB:**
- **David Ruiz** - david.ruiz@ficohsa.com
- **Wilmer Fernandez** - wilmer.fernandez@ficohsa.com  
- **Francia Avila** - francia.avila@ficohsa.com
- **Diego Gomez** - diego.gomez@ficohsa.com

### 5. Lógica Importante

**Flujo Principal del Servicio:**
1. **Validación XSD:** Se valida la estructura del mensaje contra el esquema autorizacionDataCaptureTypes.xsd
2. **Validación Regional:** Se ejecuta ValidaServicioRegional con serviceId "autorizacionDataCapture" para verificar disponibilidad por región
3. **Regionalización por País:** El servicio se enruta según el país de origen:
   - **HN01 (Honduras):** Conexión directa al sistema DataCapture local
   - **GT01 (Guatemala):** Conexión al sistema DataCapture Guatemala
   - **PA01 (Panamá):** Conexión al sistema DataCapture Panamá
   - **NI01 (Nicaragua):** Conexión al sistema DataCapture Nicaragua
   - **Default:** Error de país no soportado
4. **Validación de Transacción:** Verificación de existencia y estado de la transacción
5. **Proceso de Autorización:** Actualización del estado de la transacción a autorizada
6. **Transformación de Respuesta:** Construcción de respuesta con TRANSACTION_DATE
7. **Manejo de Errores:** Aplicación de mapeo de errores según tipo

**Servicios Dependientes Analizados:**
- **DataCapture:** Sistema backend para autorización de transacciones

**Arquitectura Multi-Core:** Servicio Regional Multi-Core que soporta múltiples sistemas core por país

**Seguridad por Usuario:** Autenticación mediante custom token con username/password

### 6. Datos Relevantes

- El servicio no requiere reintentos automáticos
- El servicio no requiere reversos
- Autorización inmediata con timestamp de confirmación
- Validación de estado previo de la transacción
- Logging detallado habilitado para auditoría
- Control de transacciones duplicadas
- Soporte para autorización masiva mediante lotes

### 7. Detalles Técnicos de Conexión

- **Conexión a DataCapture:** Por HTTP - Sistema backend de autorización de transacciones

### 8. Dependencias del Servicio

**Servicios Internos:**
- Ninguno identificado

**Servicios Externos:**
- DataCapture - Sistema backend de autorización de transacciones

## 9. Datos del Servicio

| Campo | Valor |
|-------|-------|
| **RUTA** | Middleware\OperationsAndExecution\CustomerDeposits\AutorizacionDataCapture |
| **URI** | /Middleware/OperationsAndExecution/CustomerDeposits/AutorizacionDataCapture |
| **NUMERO_OPERACIONES** | 1 |
| **OPERACIONES** | autorizacionDataCapture |
| **CODIGO** | autorizacionDataCapture |
| **GRUPO_ASIGNADO** | AutorizacionDataCapture |

## 10. Información del Inventario de Servicios

Servicios relacionados con AutorizacionDataCapture encontrados en el inventario (GRUPO_ASIGNADO = "AutorizacionDataCapture"):

| URI | NUMERO_OPERACIONES | OPERACIONES | CODIGO | GRUPO_ASIGNADO | RUTA |
|-----|-------------------|-------------|--------|-----------------|------|
| /Middleware/OperationsAndExecution/CustomerDeposits/AutorizacionDataCapture | 1 | autorizacionDataCapture | autorizacionDataCapture | AutorizacionDataCapture | Middleware\OperationsAndExecution\CustomerDeposits\AutorizacionDataCapture |

## 11. Servicios Dependientes (Árbol Proxy-Biz)

Servicios que tienen como PROXY_PADRE "Middleware\OperationsAndExecution\CustomerDeposits\AutorizacionDataCapture":

| PROXY_REFERENCIA | BIZ | URI |
|------------------|-----|-----|
| Middleware\OperationsAndExecution\CustomerDeposits\AutorizacionDataCapture | \Middleware\Business_Resources\dataCapture\Resources\DataCapture | [http://mwinterbanca:7003/svcDataCapture/services] |

## 12. Canales que utilizan la capacidad

**Canales:** No se encontró información de canales para esta capacidad (GRUPO_ASIGNADO: AutorizacionDataCapture)

**URIs:** N/A

**Número de canales:** 0

---

## Historial de Cambios

| Fecha | Versión | Autor | Descripción |
|-------|---------|-------|-------------|
| 2026-01-02 | 1.0 | ARQ FICOHSA | Creación inicial |
