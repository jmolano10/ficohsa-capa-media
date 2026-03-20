# Historia de Usuario: ValidaNumeroViajero

> **Como** Equipo de Integración  
> **Quiero** validar números de viajero frecuente para verificar su existencia y estado en el sistema  
> **Para** permitir que los canales digitales puedan validar la información de clientes viajeros frecuentes antes de procesar transacciones relacionadas

## Criterios de Aceptación

### 1. Campos de Entrada del Servicio

| Campo | Descripción | Requerido | Tipo/Formato |
|-------|-------------|-----------|--------------|
| **Type** | Tipo de validación a realizar | **Sí** | string |
| **FlyerNumber** | Número de viajero frecuente a validar | **Sí** | string |

> **Validaciones:**
> - Type debe ser un valor válido según catálogo del sistema
> - FlyerNumber debe tener formato válido de número de viajero
> - Se valida la estructura del mensaje contra el esquema XSD
> - Se aplica validación de servicio regional

### 2. Campos de Salida del Servicio

| Campo | Descripción | Requerido | Tipo |
|-------|-------------|-----------|------|
| **validaNumeroViajeroResponse** | Respuesta del servicio de validación | **Sí** | Complex Type |
| &nbsp;&nbsp;&nbsp;&nbsp;└─ **Result** | Resultado de la validación del número de viajero | No | string |

> **Nota:** Todos los campos de salida están validados contra el esquema XSD validaNumeroViajeroTypes.xsd

## Tareas Técnicas

### 1. Códigos de Error

#### 1.1. Códigos de error del Proveedor

| Código Error | Descripción | Tipo Error |
|--------------|-------------|------------|
| SUCCESS | Validación exitosa | Negocio |
| ERROR | Error en la validación | Técnico |

> **Nota:** Los códigos de error se mapean desde el procedimiento almacenado SFC_VALIDAR_NUMERO_VIAJERO

### 2. Configuración de Timeout

- **Timeout proveedor Base de Datos:** 30 segundos
- **Timeout operación del OSB:** 30 segundos

### 3. Datos de Prueba

> **Nota:** Los siguientes son datos de ejemplo no reales, utilizados únicamente para propósitos de testing y documentación.

- **Type:** "VALIDATION"
- **FlyerNumber:** "FF123456789"

### 4. Datos de Contacto

**Contacto responsable OSB:**
- **David Ruiz** - david.ruiz@ficohsa.com
- **Wilmer Fernandez** - wilmer.fernandez@ficohsa.com  
- **Francia Avila** - francia.avila@ficohsa.com
- **Diego Gomez** - diego.gomez@ficohsa.com
- **Christofer Giron** - josep.giron@ficohsa.com

### 5. Lógica Importante

**Flujo Principal del Servicio:**
1. **Validación XSD:** Se valida la estructura del mensaje contra el esquema validaNumeroViajeroTypes.xsd
2. **Transformación de Entrada:** Se transforma el request usando ValidaNumeroViajeroIn.xq para mapear a los parámetros del procedimiento almacenado
3. **Llamada a Base de Datos:** Se ejecuta el procedimiento almacenado SFC_VALIDAR_NUMERO_VIAJERO en el esquema SALESFORCE de la base de datos de Interfaz
4. **Evaluación de Resultado:** Se evalúa el código de error retornado por el procedimiento
5. **Transformación de Respuesta:** Si es exitoso, se transforma usando ValidaNumeroViajeroOut.xq; si hay error, se retorna respuesta vacía
6. **Manejo de Errores:** Se aplica mapeo de errores y se construye el header de respuesta apropiado

**Servicios Dependientes Analizados:**
- **validaNumeroViajero_db:** Business service que conecta con la base de datos de Interfaz

**Arquitectura Simple:** Servicio directo que conecta con base de datos sin lógica regional compleja

**Seguridad por Usuario:** Implementa Custom Token Authentication con validación de usuario y contraseña en el header

### 6. Datos Relevantes

- El servicio no requiere reintentos automáticos
- El servicio no requiere reversos
- Conecta directamente con base de datos de Interfaz
- Utiliza procedimiento almacenado específico para validación
- Manejo de errores centralizado en pipeline de error
- Respuesta condicional basada en código de error del procedimiento

### 7. Detalles Técnicos de Conexión

- **Conexión a Base de Datos de Interfaz:** Por JCA - Conexión administrada usando ConnectionInterfazSFC

### 8. Dependencias del Servicio

**Servicios Internos:**
- validaNumeroViajero_db - Business service para conexión con base de datos de Interfaz

**Servicios Externos:**
- Base de Datos de Interfaz - Esquema SALESFORCE, procedimiento SFC_VALIDAR_NUMERO_VIAJERO

## 9. Datos del Servicio

| Campo | Valor |
|-------|-------|
| **RUTA** | Middleware\v2\ProxyServices\ValidaNumeroViajero |
| **URI** | /Middleware/CreditCard/Customer/ValidaNumeroViajero |
| **NUMERO_OPERACIONES** | 1 |
| **OPERACIONES** | ValidaNumeroViajero |
| **CODIGO** | 1 |
| **GRUPO_ASIGNADO** | ValidaNumeroViajero |

## 10. Información del Inventario de Servicios

Servicios relacionados con ValidaNumeroViajero encontrados en el inventario (GRUPO_ASIGNADO = "ValidaNumeroViajero"):

| URI | NUMERO_OPERACIONES | OPERACIONES | CODIGO | GRUPO_ASIGNADO | RUTA |
|-----|-------------------|-------------|--------|-----------------|------|
| /Middleware/CreditCard/Customer/ValidaNumeroViajero | 1 | ValidaNumeroViajero | 1 | ValidaNumeroViajero | Middleware\v2\ProxyServices\ValidaNumeroViajero |

## 11. Servicios Dependientes (Árbol Proxy-Biz)

Servicios que tienen como PROXY_PADRE "Middleware\v2\ProxyServices\ValidaNumeroViajero":

| PROXY_REFERENCIA | BIZ | URI |
|------------------|-----|-----|
| Middleware\v2\ProxyServices\ValidaNumeroViajero | \Middleware\v2\BusinessServices\ValidaNumeroViajero\biz\validaNumeroViajero_db | [jca://eis/DB/ConnectionInterfazSFC] |

## 12. Canales que utilizan la capacidad

**Canales:** SALESFORCE

**URIs:** /Middleware/CreditCard/Customer/ValidaNumeroViajero

**Número de canales:** 1

---

## Historial de Cambios

| Fecha | Versión | Autor | Descripción |
|-------|---------|-------|-------------|
| 29-01-2026 | 1.0 | Joseph Giron | Creación inicial |