# Historia de Usuario: ReversarTransaccion

> **Como** Equipo de Integración  
> **Quiero** Reversar transacciones bancarias previamente ejecutadas  
> **Para** Permitir a los canales anular operaciones erróneas o no autorizadas, validando la disponibilidad regional del servicio antes de procesar la reversión y asegurando la integridad de las transacciones

## Criterios de Aceptación

### 1. Campos de Entrada del Servicio

| Campo | Descripción | Requerido | Tipo/Formato |
|-------|-------------|-----------|--------------|
| **reversarTransaccion** | Solicitud de reversión de transacción | **Sí** | Complex Type |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **TRANSACTION_ID** | Identificador de la transacción a reversar | **Sí** | string |
| &nbsp;&nbsp;&nbsp;&nbsp;└─ **TRANSACTION_TYPE** | Tipo de transacción | No | string |

> **Validaciones:**
> - El campo TRANSACTION_ID es obligatorio
> - El campo TRANSACTION_TYPE es opcional
> - Se valida la estructura del mensaje contra el esquema XSD reversarTransaccionTypes.xsd
> - Se ejecuta ValidaServicioRegional con código FICBCO0084 para verificar disponibilidad por región

### 2. Campos de Salida del Servicio

| Campo | Descripción | Requerido | Tipo |
|-------|-------------|-----------|------|
| **reversarTransaccionResponse** | Respuesta de reversión | **Sí** | Empty Type |

> **Nota:** Todos los campos de salida están validados contra el esquema XSD reversarTransaccionTypes.xsd. El response es un elemento vacío.

## Tareas Técnicas

### 1. Códigos de Error

#### 1.1. Códigos de error del Proveedor

| Código Error | Descripción | Tipo Error |
|--------------|-------------|------------|
| SUCCESS | Validación regional exitosa | Negocio |
| [REGIONAL_ERROR] | Servicio no disponible en la región solicitada | Negocio |
| MW-0008 | SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY | Negocio |
| OSB-382033 | Error de validación XSD del request | Técnico |
| OSB-382505 | Elemento requerido faltante en el request | Técnico |
| BEA-380000 | Error general de Oracle Service Bus | Técnico |
| BEA-382500 | Error en transformación XQuery | Técnico |

> **Nota:** Los errores son procesados por el servicio MapeoErrores para estandarización de códigos y mensajes. El servicio incluye un pipeline de respuesta por defecto que retorna error MW-0008 para países/compañías no implementados

### 2. Configuración de Timeout

- **Timeout ValidaServicioRegional:** [TIMEOUT_VALIDACION_REGIONAL] segundos
- **Timeout operación del OSB:** [TIMEOUT_OSB_REVERSAR_TRANSACCION] segundos

### 3. Datos de Prueba

> **Nota:** Los siguientes son datos de ejemplo no reales, utilizados únicamente para propósitos de testing y documentación.

- **TRANSACTION_ID:** TXN123456789
- **TRANSACTION_TYPE:** TRANSFER

### 4. Datos de Contacto

**Contacto responsable OSB:**
- **David Ruiz** - david.ruiz@ficohsa.com
- **Wilmer Fernandez** - wilmer.fernandez@ficohsa.com  
- **Francia Avila** - francia.avila@ficohsa.com
- **Diego Gomez** - diego.gomez@ficohsa.com

### 5. Lógica Importante

**Flujo Principal del Servicio:**
1. **Validación XSD:** Se valida la estructura del mensaje contra el esquema reversarTransaccionTypes.xsd
2. **Validación Regional:** Se ejecuta ValidaServicioRegional con serviceId "FICBCO0084" para verificar disponibilidad por región
3. **Evaluación de Resultado de Validación:**
   - Si errorCode = 'SUCCESS': Se aplican valores por defecto de la región al header y continúa el procesamiento
   - Si errorCode != 'SUCCESS': Se retorna error inmediatamente sin procesar la reversión
4. **Enrutamiento Regional:** El servicio tiene múltiples pipelines de respuesta según país/compañía:
   - **HNBanco_ReversarTransaccion_response:** Pipeline específico para Honduras Banco
   - **Default_ReversarTransaccion_response:** Pipeline por defecto que retorna error MW-0008 para implementaciones no disponibles
5. **Manejo de Errores:** En caso de error, se captura el errorCode y errorMessage, se invoca MapeoErrores usando mapeoErroresUsageIn.xq y mapeoErroresUsageOut.xq

**Servicios Dependientes Analizados:**
- **ValidaServicioRegional:** Valida disponibilidad del servicio en la región del solicitante (conexión JCA a base de datos)
- **MapeoErrores:** Estandariza códigos y mensajes de error para respuesta uniforme

**Arquitectura Multi-Core:** El servicio soporta múltiples sistemas core regionales mediante validación previa de disponibilidad y pipelines de respuesta específicos por país/compañía

**Seguridad por Usuario:** Implementa autenticación custom token con username y password extraídos del header (namespace aut:RequestHeader/Authentication)

### 6. Datos Relevantes

- El servicio requiere validación regional obligatoria antes de procesar cualquier solicitud
- El servicio requiere reversos por naturaleza (es un servicio de reversión)
- El response es un elemento vacío (sin campos de salida)
- El servicio NO utiliza HTTPS (solo HTTP configurado)
- Logging habilitado en nivel debug para trazabilidad completa
- Monitoring habilitado con intervalo de agregación de 360 segundos y nivel Action
- Alertas SLA y Pipeline habilitadas en nivel normal
- El servicio NO implementa router dinámico
- El servicio tiene múltiples pipelines de respuesta según país/compañía
- El servicio es utilizado por 5 canales: INTERBANCABD, INTERFAZBD, NST, PAGOSWS, TENGO
- El campo TRANSACTION_TYPE es opcional

### 7. Detalles Técnicos de Conexión

- **Conexión a ValidaServicioRegional:** Por JCA (Database Adapter) - Validación de disponibilidad del servicio en base de datos regional
- **Conexión a MapeoErrores:** Por SOAP - Estandarización de errores mediante proxy service interno

### 8. Dependencias del Servicio

**Servicios Internos:**
- MapeoErrores - Estandarización de códigos y mensajes de error

**Servicios Externos:**
- ValidaServicioRegional (DB) - Validación de disponibilidad regional del servicio

## 9. Datos del Servicio

| Campo | Valor |
|-------|-------|
| **RUTA** | Middleware\v2\ProxyServices\ReversarTransaccion |
| **URI** | /Middleware/OperationsAndExecution/CustomerDeposits/ReversarTransaccion_v2 |
| **NUMERO_OPERACIONES** | 1 |
| **OPERACIONES** | reversarTransaccion |
| **CODIGO** | FICBCO0084 |
| **GRUPO_ASIGNADO** | ReversarTransaccion |

## 10. Información del Inventario de Servicios

Servicios relacionados con ReversarTransaccion encontrados en el inventario (GRUPO_ASIGNADO = "ReversarTransaccion"):

| URI | NUMERO_OPERACIONES | OPERACIONES | CODIGO | GRUPO_ASIGNADO | RUTA |
|-----|-------------------|-------------|--------|-----------------|------|
| /Middleware/OperationsAndExecution/CustomerDeposits/ReversarTransaccion_v2 | 1 | reversarTransaccion | FICBCO0084 | ReversarTransaccion | Middleware\v2\ProxyServices\ReversarTransaccion |
| /Middleware/OperationsAndExecution/CustomerDeposits/ReversarTransaccion | 1 | reversarTransaccion | [Sin código] | ReversarTransaccion | Middleware\OperationsAndExecution\CustomerDeposits\ReversarTransaccion |
| /MiddlewareCaja/ReversarTransaccion | 1 | reversarTransaccion | [Sin código] | ReversarTransaccion | MiddlewareCaja\ProxyServices\ReversarTransaccion |
| /Middleware/SalesAndServices/BankingPartner/reversarTransaccionID | 1 | reversarTransaccionID | FICBCO0516$0259 | ReversarTransaccion | Middleware\v2\ProxyServices\ReversarTransaccionID |

## 11. Servicios Dependientes (Árbol Proxy-Biz)

No se encontraron servicios que tengan como PROXY_PADRE "Middleware\v2\ProxyServices\ReversarTransaccion" en el archivo Arbol_Proxy_Biz.csv.

## 12. Canales que utilizan la capacidad

**Canales:** INTERBANCABD, INTERFAZBD, NST, PAGOSWS, TENGO

**URIs:** /Middleware/OperationsAndExecution/CustomerDeposits/ReversarTransaccion, /Middleware/OperationsAndExecution/CustomerDeposits/ReversarTransaccion_v2, /Middleware/SalesAndServices/BankingPartner/reversarTransaccionID, /MiddlewareCaja/ReversarTransaccion

**Número de canales:** 5

---

## Historial de Cambios

| Fecha | Versión | Autor | Descripción |
|-------|---------|-------|-------------|
| 2025-01-15 | 1.0 | ARQ FICOHSA | Creación inicial |
