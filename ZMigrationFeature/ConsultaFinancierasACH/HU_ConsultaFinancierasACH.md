# Historia de Usuario: ConsultaFinancierasACH

> **Como** Equipo de Integración  
> **Quiero** consultar la información de las entidades financieras disponibles para transferencias ACH  
> **Para** permitir a los canales obtener la lista de destinos ACH válidos y sus configuraciones por país

## Criterios de Aceptación

### 1. Campos de Entrada del Servicio

| Campo | Descripción | Requerido | Tipo/Formato |
|-------|-------------|-----------|--------------|
| **DESTINATION_CODE** | Código de la entidad financiera de destino | No | string |

> **Validaciones:**
> - Se valida la estructura del mensaje contra el esquema XSD consultaFinancierasACHTypes.xsd
> - Se aplica validación de servicio regional con serviceId "FICBCO0118"
> - El campo DESTINATION_CODE es opcional para consultar todas las entidades

### 2. Campos de Salida del Servicio

| Campo | Descripción | Requerido | Tipo |
|-------|-------------|-----------|------|
| **consultaFinancierasACHResponse** | Respuesta del servicio de consulta de financieras ACH | **Sí** | Complex Type |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **consultaFinancierasACHResponseType** | Tipo de respuesta principal | No | Complex Type |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **consultaFinancierasACHResponseRecordType** | Registro de respuesta | No | Complex Type |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **DESTINATION_CODE** | Código de la entidad financiera | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **DESTINATION_NAME** | Nombre de la entidad financiera | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└─ **consultaFinancierasACHDetailResponseType** | Detalles de productos ACH | No | Complex Type |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **TYPE_OF_PRODUCT** | Tipo de producto | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **MIN_PRODUCT_ID_LENGTH** | Longitud mínima del ID de producto | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **MAX_PRODUCT_ID_LENGTH** | Longitud máxima del ID de producto | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **LEADING_ZEROS_YES_NO** | Indicador de ceros a la izquierda | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **PRODUCT_ID_SAMPLE** | Ejemplo de ID de producto | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└─ **TRANSFER_TYPE** | Tipo de transferencia | No | string |

> **Nota:** Todos los campos de salida están validados contra el esquema XSD consultaFinancierasACHTypes.xsd

## Tareas Técnicas

### 1. Códigos de Error

#### 1.1. Códigos de error del Proveedor

| Código Error | Descripción | Tipo Error |
|--------------|-------------|------------|
| FICBCO0118 | Error general del servicio ConsultaFinancierasACH | Técnico |
| MW-0008 | Servicio no implementado para el país/empresa | Negocio |
| MW-0011 | Error en obtención de parametrización | Técnico |

> **Nota:** Los errores se mapean a través del servicio MapeoErrores

### 2. Configuración de Timeout

- **Timeout proveedor Core:** 120 segundos
- **Timeout operación del OSB:** 120 segundos

### 3. Datos de Prueba

> **Nota:** Los siguientes son datos de ejemplo no reales, utilizados únicamente para propósitos de testing y documentación.

- **DESTINATION_CODE:** "001" (Banco ejemplo)

### 4. Datos de Contacto

**Contacto responsable OSB:**
- **David Ruiz** - david.ruiz@ficohsa.com
- **Wilmer Fernandez** - wilmer.fernandez@ficohsa.com  
- **Francia Avila** - francia.avila@ficohsa.com
- **Diego Gomez** - diego.gomez@ficohsa.com

### 5. Lógica Importante

**Flujo Principal del Servicio:**
1. **Validación XSD:** Se valida la estructura del mensaje contra el esquema consultaFinancierasACHTypes.xsd
2. **Validación Regional:** Se ejecuta ValidaServicioRegional con serviceId "FICBCO0118" para verificar disponibilidad por región
3. **Regionalización por País:** El servicio se enruta según el país de origen:
   - **HN01 (Honduras):** Consulta directa al Core Banking System
   - **HN02 (Honduras FPC):** Consulta al sistema FPC con transformación de headers
   - **GT01 (Guatemala):** Consulta a base de datos ABKGT
   - **PA01 (Panamá):** Consulta a base de datos ABKPA
   - **NI01 (Nicaragua):** Consulta al sistema CTS con obtención de parametrización adicional
   - **Default:** Error MW-0008 para países no soportados
4. **Transformación de Respuesta:** Construcción de respuesta específica por país usando archivos XQuery
5. **Manejo de Errores:** Aplicación de mapeo de errores a través del servicio MapeoErrores

**Servicios Dependientes Analizados:**
- **MapeoErrores:** Mapeo y transformación de códigos de error
- **ValidaServicioRegional:** Validación de disponibilidad del servicio por región
- **CoreBS:** Sistema Core Banking para Honduras HN01
- **FPC getFinancialACH12c:** Sistema FPC para Honduras HN02
- **ABKGT consultaFinancierasACH:** Base de datos para Guatemala
- **ABKPA consultaFinancierasACH:** Base de datos para Panamá
- **CTS transferencia:** Sistema CTS para Nicaragua
- **ObtenerParametrizacion:** Obtención de parámetros de configuración

**Arquitectura Multi-Core:** Soporta múltiples sistemas core por país con enrutamiento dinámico basado en SourceBank

**Seguridad por Usuario:** Implementa Custom Token Authentication con validación de usuario y contraseña

### 6. Datos Relevantes

- El servicio no requiere reintentos automáticos
- El servicio no requiere reversos
- Servicio de consulta de solo lectura para entidades financieras ACH
- Soporta consulta específica por código de destino o consulta completa
- Para Nicaragua incluye parametrización de tipos de productos
- Manejo especial de headers para sistema FPC (HN02)
- Validación XSD obligatoria en el flujo de entrada

### 7. Detalles Técnicos de Conexión

- **Conexión a Core (HN01):** Por HTTP - Sistema Core Banking principal
- **Conexión a FPC (HN02):** Por HTTP - Sistema FPC con autenticación OSB12AUTH
- **Conexión a ABKGT (GT01):** Por JCA - Base de datos Guatemala
- **Conexión a ABKPA (PA01):** Por JCA - Base de datos Panamá
- **Conexión a CTS (NI01):** Por HTTP - Sistema CTS Nicaragua
- **Conexión a ValidaServicioRegional:** Por JCA - Base de datos Middleware
- **Conexión a MapeoErrores:** Por SOAP - Servicio interno de mapeo

### 8. Dependencias del Servicio

**Servicios Internos:**
- MapeoErrores - Mapeo de códigos de error
- ValidaServicioRegional - Validación regional del servicio

**Servicios Externos:**
- CoreBS - Sistema Core Banking Honduras
- FPC getFinancialACH12c - Sistema FPC Honduras
- ABKGT consultaFinancierasACH - Base de datos Guatemala
- ABKPA consultaFinancierasACH - Base de datos Panamá
- CTS transferencia - Sistema CTS Nicaragua
- ObtenerParametrizacion - Servicio de parametrización

## 9. Datos del Servicio

| Campo | Valor |
|-------|-------|
| **RUTA** | Middleware\v2\ProxyServices\ConsultaFinancierasACH |
| **URI** | /SMiddleware/ReferenceData/CommonBusinessInformation/ConsultaFinancierasACH_v2 |
| **NUMERO_OPERACIONES** | 1 |
| **OPERACIONES** | consultaFinancierasACH |
| **CODIGO** | FICBCO0118 |
| **GRUPO_ASIGNADO** | ConsultaFinancierasACH |

## 10. Información del Inventario de Servicios

Servicios relacionados con ConsultaFinancierasACH encontrados en el inventario (GRUPO_ASIGNADO = "ConsultaFinancierasACH"):

| URI | NUMERO_OPERACIONES | OPERACIONES | CODIGO | GRUPO_ASIGNADO | RUTA |
|-----|-------------------|-------------|--------|-----------------|------|
| /Middleware/ReferenceData/CommonBusinessInformation/ConsultaFinancierasACH | 1 | consultaFinancierasACH |  | ConsultaFinancierasACH | Middleware\ReferenceData\CommonBusinessInformation\ConsultaFinancierasACH |
| /SMiddleware/ReferenceData/CommonBusinessInformation/ConsultaFinancierasACH_v2_ori |  |  |  | ConsultaFinancierasACH | Middleware\v2\SProxyServices\ConsultaFinancierasACH_v2S |
| /Middleware/External/ReferenceData/CommonBusinessInformation/ConsultaFinancierasACH_v2 |  |  |  | ConsultaFinancierasACH | Middleware\External\Incoming\v2\ProxyServices\ConsultaFinancierasACH |
| /SMiddleware/ReferenceData/CommonBusinessInformation/ConsultaFinancierasACH_v2 | 1 | consultaFinancierasACH | FICBCO0118 | ConsultaFinancierasACH | Middleware\v2\ProxyServices\ConsultaFinancierasACH |

## 11. Servicios Dependientes (Árbol Proxy-Biz)

Servicios que tienen como PROXY_PADRE "Middleware\v2\ProxyServices\ConsultaFinancierasACH":

| PROXY_REFERENCIA | BIZ | URI |
|------------------|-----|-----|
| Middleware\v2\ProxyServices\MapeoErrores | \Middleware\v2\BusinessServices\MapeoErrores\biz\mapeodeErrores_db | [jca://eis/DB/ConnectionMiddleware] |
| Middleware\v2\ProxyServices\ConsultaFinancierasACH | \Middleware\v2\BusinessServices\ABKPA\consultaFinancierasACH\biz\consultaFinancierasACH_db | [jca://eis/DB/ConnectionProxyAbanksPA] |
| Middleware\v2\ProxyServices\MapeoErrores | \Middleware\v2\BusinessServices\MDW\guardarBitacoraMapeoErrores\biz\guardarBitacoraMapeoErrores_db | [jca://eis/DB/ConnectionMiddleware] |
| Middleware\v2\ProxyServices\ConsultaFinancierasACH | \Middleware\Business_Resources\general\Resources\ObtenerParametrizacion\ObtenerParametrizacion | [jca://eis/DB/ConnectionMiddleware] |
| Middleware\v2\ProxyServices\ConsultaFinancierasACH | \Middleware\v2\BusinessServices\FPC\listadoEntes\biz\listadoEntesFPC_db | [jca://eis/DB/ConnectionFicopen] |
| Middleware\v2\ProxyServices\ConsultaFinancierasACH | \Middleware\v2\BusinessServices\CTS\transferencia\biz\transferencia | [http://10.235.53.149:9080/GerenciaTransferencia/SrvAplCobisTransferenciaService] |
| Middleware\v2\ProxyServices\ConsultaFinancierasACH | \Middleware\v2\BusinessServices\ValidaServicioRegional\biz\ValidaServicioRegional_db | [jca://eis/DB/ConnectionMiddleware] |
| Middleware\v2\ProxyServices\ConsultaFinancierasACH | \Middleware\v2\BusinessServices\ABKGT\consultaFinancierasACH\biz\consultaFinancierasACH_db | [jca://eis/DB/ConnectionProxyAbanksGT] |
| Middleware\v2\ProxyServices\ConsultaFinancierasACH | \Middleware\Business_Resources\Core\Resources\CoreBS | [http://10.9.104.97:7003/svcCore/services, http://10.9.104.32:7004/svcCore/services, http://10.9.104.97:7005/svcCore/services, http://10.9.104.32:7006/svcCore/services] |

## 12. Canales que utilizan la capacidad

**Canales:** INTERBANCA, INTERBANCABD, INTERFAZBD, SALESFORCE, SARA

**URIs:** /Middleware/ReferenceData/CommonBusinessInformation/ConsultaFinancierasACH, /SMiddleware/ReferenceData/CommonBusinessInformation/ConsultaFinancierasACH_v2

**Número de canales:** 5

---

## Historial de Cambios

| Fecha | Versión | Autor | Descripción |
|-------|---------|-------|-------------|
| 2025-12-22 | 1.0 | ARQ FICOHSA | Creación inicial |
