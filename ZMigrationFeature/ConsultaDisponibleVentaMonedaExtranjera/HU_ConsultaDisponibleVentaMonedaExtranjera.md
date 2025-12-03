# Historia de Usuario: ConsultaDisponibleVentaMonedaExtranjera

> **Como** Equipo de Integración  
> **Quiero** Consultar el monto disponible para venta de moneda extranjera  
> **Para** Permitir a los canales verificar la disponibilidad de divisas antes de realizar operaciones de venta, asegurando que exista suficiente inventario de la moneda solicitada

## Criterios de Aceptación

### 1. Campos de Entrada del Servicio

| Campo | Descripción | Requerido | Tipo/Formato |
|-------|-------------|-----------|--------------|
| **consultaDisponibleVentaMonedaExtranjera** | Solicitud de consulta de disponible | **Sí** | Complex Type |
| &nbsp;&nbsp;&nbsp;&nbsp;└─ **CURRENCY** | Código de moneda extranjera | **Sí** | stringMinLength1 (mínimo 1 carácter) |

> **Validaciones:**
> - El campo CURRENCY es obligatorio y debe tener al menos 1 carácter
> - Se valida la estructura del mensaje contra el esquema XSD consultaDisponibleVentaMonedaExtranjeraTypes.xsd
> - Se ejecuta consultaRutaRegional con código FICBCO0434 para determinar el servicio regional

### 2. Campos de Salida del Servicio

| Campo | Descripción | Requerido | Tipo |
|-------|-------------|-----------|------|
| **consultaDisponibleVentaMonedaExtranjeraResponse** | Respuesta con monto disponible | **Sí** | Complex Type |
| &nbsp;&nbsp;&nbsp;&nbsp;└─ **AMOUNT_AVAILABLE** | Monto disponible para venta | No | string |

> **Nota:** Todos los campos de salida están validados contra el esquema XSD consultaDisponibleVentaMonedaExtranjeraTypes.xsd

## Tareas Técnicas

### 1. Códigos de Error

#### 1.1. Códigos de error del Proveedor

| Código Error | Descripción | Tipo Error |
|--------------|-------------|------------|
| SUCCESS | Ruta regional obtenida exitosamente | Negocio |
| [ERROR_CODE_RUTA] | Error al obtener ruta regional del servicio | Negocio |
| OSB-382033 | Error de validación XSD del request | Técnico |
| OSB-382505 | Elemento requerido faltante en el request | Técnico |
| BEA-380000 | Error general de Oracle Service Bus | Técnico |
| BEA-382500 | Error en transformación XQuery | Técnico |

> **Nota:** Los errores son procesados por el servicio MapeoErrores para estandarización de códigos y mensajes. El mapeo se aplica tanto en response pipeline como en error handler

### 2. Configuración de Timeout

- **Timeout consultaRutaRegional:** [TIMEOUT_CONSULTA_RUTA_REGIONAL] segundos
- **Timeout servicio regional dinámico:** [TIMEOUT_SERVICIO_REGIONAL] segundos
- **Timeout operación del OSB:** [TIMEOUT_OSB_CONSULTA_DISPONIBLE] segundos

### 3. Datos de Prueba

> **Nota:** Los siguientes son datos de ejemplo no reales, utilizados únicamente para propósitos de testing y documentación.

- **CURRENCY:** USD
- **AMOUNT_AVAILABLE (esperado):** 50000.00

### 4. Datos de Contacto

**Contacto responsable OSB:**
- **David Ruiz** - david.ruiz@ficohsa.com
- **Wilmer Fernandez** - wilmer.fernandez@ficohsa.com  
- **Francia Avila** - francia.avila@ficohsa.com
- **Diego Gomez** - diego.gomez@ficohsa.com

### 5. Lógica Importante

**Flujo Principal del Servicio:**
1. **Validación XSD:** Se valida la estructura del mensaje contra el esquema consultaDisponibleVentaMonedaExtranjeraTypes.xsd
2. **Consulta de Ruta Regional:** Se ejecuta consultaRutaRegional con los siguientes parámetros:
   - idServicio: "FICBCO0434"
   - requestHeader: Header de autenticación
   - operacion: Operación invocada
   - version: "V2"
3. **Evaluación de Resultado de Ruta:**
   - Si PV_CODIGO_ERROR != 'SUCCESS': Se retorna error con PV_MENSAJE_ERROR sin procesar
   - Si PV_CODIGO_ERROR = 'SUCCESS': Se aplican valores por defecto de región y continúa
4. **Enrutamiento Dinámico:** Se enruta dinámicamente al servicio regional usando PV_UBICACION obtenido de consultaRutaRegional
5. **Mapeo de Errores en Response:** Si successIndicator != "SUCCESS", se invoca MapeoErrores con código FICBCO0434
6. **Manejo de Errores:** En caso de error, se captura errorCode y errorMessage, se invoca MapeoErrores usando mapeoErroresUsageIn.xq y mapeoErroresUsageOut.xq

**Servicios Dependientes Analizados:**
- **consultaRutaRegional:** Determina la ruta del servicio regional según país y versión (conexión JCA a base de datos)
- **MapeoErrores:** Estandariza códigos y mensajes de error para respuesta uniforme
- **Servicio Regional Dinámico:** Servicio determinado en tiempo de ejecución por consultaRutaRegional

**Arquitectura Multi-Core:** El servicio implementa router dinámico que determina en tiempo de ejecución el servicio regional a invocar basado en la configuración de consultaRutaRegional

**Seguridad por Usuario:** Implementa autenticación custom token con username y password extraídos del header (namespace aut:RequestHeader/Authentication)

### 6. Datos Relevantes

- El servicio implementa router dinámico (`<con3:dynamic-route>`)
- El servicio requiere consulta de ruta regional obligatoria antes de procesar
- El servicio no requiere reintentos automáticos (manejo de error directo)
- El servicio no requiere reversos (operación de consulta)
- El campo AMOUNT_AVAILABLE en el response es opcional (minOccurs="0")
- El servicio utiliza HTTPS obligatorio según configuración de endpoint
- Logging habilitado en nivel debug para trazabilidad completa
- Alertas SLA y Pipeline habilitadas en nivel normal
- Monitoring deshabilitado
- El mapeo de errores se aplica en dos puntos: response pipeline y error handler
- El servicio usa versión "V2" para consulta de ruta regional

### 7. Detalles Técnicos de Conexión

- **Conexión a consultaRutaRegional:** Por JCA (Database Adapter) - Obtención de ruta del servicio regional desde base de datos
- **Conexión a Servicio Regional Dinámico:** Por SOAP - Determinado en tiempo de ejecución según PV_UBICACION
- **Conexión a MapeoErrores:** Por SOAP - Estandarización de errores mediante proxy service interno

### 8. Dependencias del Servicio

**Servicios Internos:**
- MapeoErrores - Estandarización de códigos y mensajes de error
- Servicio Regional Dinámico - Consulta de disponible por región (determinado en runtime)

**Servicios Externos:**
- consultaRutaRegional (DB) - Obtención de ruta del servicio regional

## 9. Datos del Servicio

| Campo | Valor |
|-------|-------|
| **RUTA** | Middleware\v2\ProxyServices\ConsultaDisponibleVentaMonedaExtranjera |
| **URI** | /Middleware/OperationsAndExecution/ConsumerService/ConsultaDisponibleVentaMonedaExtranjera |
| **NUMERO_OPERACIONES** | 1 |
| **OPERACIONES** | consultaDisponibleVentaMonedaExtranjera |
| **CODIGO** | FICBCO0434 |
| **GRUPO_ASIGNADO** | ConsultaDisponibleVentaMonedaExtranjera |

## 10. Información del Inventario de Servicios

Servicios relacionados con ConsultaDisponibleVentaMonedaExtranjera encontrados en el inventario (GRUPO_ASIGNADO = "ConsultaDisponibleVentaMonedaExtranjera"):

| URI | NUMERO_OPERACIONES | OPERACIONES | CODIGO | GRUPO_ASIGNADO | RUTA |
|-----|-------------------|-------------|--------|-----------------|------|
| /Middleware/OperationsAndExecution/ConsumerService/ConsultaDisponibleVentaMonedaExtranjera | 1 | consultaDisponibleVentaMonedaExtranjera | FICBCO0434 | ConsultaDisponibleVentaMonedaExtranjera | Middleware\v2\ProxyServices\ConsultaDisponibleVentaMonedaExtranjera |
| local | N/A | N/A | [Sin código] | [Sin grupo] | Middleware\v2\ProxyServices\ConsultaDisponibleVentaMonedaExtranjeraHN |

## 11. Servicios Dependientes (Árbol Proxy-Biz)

No se encontraron servicios que tengan como PROXY_PADRE "Middleware\v2\ProxyServices\ConsultaDisponibleVentaMonedaExtranjera" en el archivo Arbol_Proxy_Biz.csv.

## 12. Canales que utilizan la capacidad

No se encontró información de canales para esta capacidad (GRUPO_ASIGNADO: ConsultaDisponibleVentaMonedaExtranjera) en el archivo Servicios-Priorizados.csv.

**Canales:** No se encontró información de canales para esta capacidad

**URIs:** N/A

**Número de canales:** 0

---

## Historial de Cambios

| Fecha | Versión | Autor | Descripción |
|-------|---------|-------|-------------|
| 2025-01-15 | 1.0 | ARQ FICOHSA | Creación inicial |
