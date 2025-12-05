# Historia de Usuario: ActivacionTarjetaDebito

> **Como** Equipo de Integración  
> **Quiero** Activar tarjetas de débito para clientes  
> **Para** Permitir a los canales habilitar tarjetas de débito recién emitidas o bloqueadas, validando la disponibilidad regional del servicio antes de procesar la activación

## Criterios de Aceptación

### 1. Campos de Entrada del Servicio

| Campo | Descripción | Requerido | Tipo/Formato |
|-------|-------------|-----------|--------------|
| **activacionTarjetaDebito** | Solicitud de activación de tarjeta | **Sí** | Complex Type |
| &nbsp;&nbsp;&nbsp;&nbsp;└─ **DEBIT_CARD_NUMBER** | Número de tarjeta de débito | **Sí** | string |

> **Validaciones:**
> - El campo DEBIT_CARD_NUMBER es obligatorio
> - Se valida la estructura del mensaje contra el esquema XSD activacionTarjetaDebitoTypes.xsd
> - Se ejecuta ValidaServicioRegional con código FICBCO0324 para verificar disponibilidad por región

### 2. Campos de Salida del Servicio

| Campo | Descripción | Requerido | Tipo |
|-------|-------------|-----------|------|
| **activacionTarjetaDebitoResponse** | Respuesta de activación | **Sí** | Empty Type |

> **Nota:** Todos los campos de salida están validados contra el esquema XSD activacionTarjetaDebitoTypes.xsd. El response es un elemento vacío.

## Tareas Técnicas

### 1. Códigos de Error

#### 1.1. Códigos de error del Proveedor

| Código Error | Descripción | Tipo Error |
|--------------|-------------|------------|
| SUCCESS | Validación regional exitosa | Negocio |
| [REGIONAL_ERROR] | Servicio no disponible en la región solicitada | Negocio |
| OSB-382033 | Error de validación XSD del request | Técnico |
| OSB-382505 | Elemento requerido faltante en el request | Técnico |
| BEA-380000 | Error general de Oracle Service Bus | Técnico |
| BEA-382500 | Error en transformación XQuery | Técnico |

> **Nota:** Los errores son procesados por el servicio MapeoErrores para estandarización de códigos y mensajes

### 2. Configuración de Timeout

- **Timeout ValidaServicioRegional:** [TIMEOUT_VALIDACION_REGIONAL] segundos
- **Timeout operación del OSB:** [TIMEOUT_OSB_ACTIVACION_TARJETA] segundos

### 3. Datos de Prueba

> **Nota:** Los siguientes son datos de ejemplo no reales, utilizados únicamente para propósitos de testing y documentación.

- **DEBIT_CARD_NUMBER:** 4111111111111111

### 4. Datos de Contacto

**Contacto responsable OSB:**
- **David Ruiz** - david.ruiz@ficohsa.com
- **Wilmer Fernandez** - wilmer.fernandez@ficohsa.com  
- **Francia Avila** - francia.avila@ficohsa.com
- **Diego Gomez** - diego.gomez@ficohsa.com

### 5. Lógica Importante

**Flujo Principal del Servicio:**
1. **Validación XSD:** Se valida la estructura del mensaje contra el esquema activacionTarjetaDebitoTypes.xsd
2. **Validación Regional:** Se ejecuta ValidaServicioRegional con serviceId "FICBCO0324" para verificar disponibilidad por región
3. **Evaluación de Resultado de Validación:**
   - Si errorCode = 'SUCCESS': Se aplican valores por defecto de la región al header y continúa el procesamiento
   - Si errorCode != 'SUCCESS': Se retorna error inmediatamente sin procesar la activación
4. **Procesamiento Regional:** El servicio procesa la activación según la región validada
5. **Manejo de Errores:** En caso de error, se captura el errorCode y errorMessage, se invoca MapeoErrores usando mapeoErroresUsageIn.xq y mapeoErroresUsageOut.xq

**Servicios Dependientes Analizados:**
- **ValidaServicioRegional:** Valida disponibilidad del servicio en la región del solicitante (conexión JCA a base de datos)
- **MapeoErrores:** Estandariza códigos y mensajes de error para respuesta uniforme

**Arquitectura Multi-Core:** El servicio soporta múltiples sistemas core regionales mediante validación previa de disponibilidad

**Seguridad por Usuario:** El servicio NO implementa autenticación custom token en la configuración del proxy

### 6. Datos Relevantes

- El servicio requiere validación regional obligatoria antes de procesar cualquier solicitud
- El servicio no requiere reintentos automáticos (manejo de error directo)
- El servicio puede requerir reversos (operación de activación/transaccional)
- El response es un elemento vacío (sin campos de salida)
- El servicio utiliza HTTPS obligatorio según configuración de endpoint
- Logging habilitado en nivel debug para trazabilidad completa
- Alertas SLA y Pipeline habilitadas en nivel normal
- Monitoring deshabilitado
- El servicio NO implementa router dinámico
- El servicio NO tiene autenticación custom token configurada

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
| **RUTA** | Middleware\v2\ProxyServices\ActivacionTarjetaDebito |
| **URI** | /Middleware/OperationsAndExecution/CustomerDeposits/ActivacionTarjetaDebito |
| **NUMERO_OPERACIONES** | 1 |
| **OPERACIONES** | activacionTarjetaDebito |
| **CODIGO** | FICBCO0324 |
| **GRUPO_ASIGNADO** | ActivacionTarjetaDebito |

## 10. Información del Inventario de Servicios

Servicios relacionados con ActivacionTarjetaDebito encontrados en el inventario (GRUPO_ASIGNADO = "ActivacionTarjetaDebito"):

| URI | NUMERO_OPERACIONES | OPERACIONES | CODIGO | GRUPO_ASIGNADO | RUTA |
|-----|-------------------|-------------|--------|-----------------|------|
| /Middleware/OperationsAndExecution/CustomerDeposits/ActivacionTarjetaDebito | 1 | activacionTarjetaDebito | FICBCO0324 | ActivacionTarjetaDebito | Middleware\v2\ProxyServices\ActivacionTarjetaDebito |
| /MiddlewareCaja/ActivacionTarjetaDebito | 1 | Activaciondetarjetadedebito | [Sin código] | ActivacionTarjetaDebito | MiddlewareCaja\ProxyServices\ActivacionTarjetaDebito |

## 11. Servicios Dependientes (Árbol Proxy-Biz)

No se encontraron servicios que tengan como PROXY_PADRE "Middleware\v2\ProxyServices\ActivacionTarjetaDebito" en el archivo Arbol_Proxy_Biz.csv.

## 12. Canales que utilizan la capacidad

**Canales:** NST, ONBASE

**URIs:** /Middleware/OperationsAndExecution/CustomerDeposits/ActivacionTarjetaDebito, /MiddlewareCaja/ActivacionTarjetaDebito

**Número de canales:** 2

---

## Historial de Cambios

| Fecha | Versión | Autor | Descripción |
|-------|---------|-------|-------------|
| 2025-01-15 | 1.0 | ARQ FICOHSA | Creación inicial |
