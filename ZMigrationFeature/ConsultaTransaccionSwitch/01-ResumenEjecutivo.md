# Resumen Ejecutivo - ConsultaTransaccionSwitch

## Índice de Documentación

1. [Resumen Ejecutivo](01-ResumenEjecutivo.md) (este documento)
2. [Comparativa entre Regiones](02-ComparativaRegiones.md)
3. [Ejemplos y Mapeos - HN01](03-EjemplosYMapeos-HN01.md)
4. [Diagrama de Secuencia - HN01](04-Secuencia-HN01.mmd)
5. [Diagrama de Flujo Multiregión](05-FlujoMultiregión.mmd)
6. [Listado de Ficheros](06-ListadoFicheros.md)

---

## Propósito de la Funcionalidad

**ConsultaTransaccionSwitch** es un servicio OSB que permite consultar información detallada de transacciones realizadas a través del switch bancario (ATM/POS). El servicio recibe un identificador de transacción (TRANSACTION_ID) y retorna los detalles completos de la transacción incluyendo:

- Información del ATM/terminal
- Datos de la red (network)
- Montos y moneda
- Códigos de autorización
- Fecha y hora de la transacción
- Información del comercio (MCC Code)
- Sucursal asociada

Este servicio es utilizado principalmente para:
- Consultas de transacciones realizadas en cajeros automáticos
- Verificación de operaciones en puntos de venta (POS)
- Auditoría y seguimiento de transacciones del switch
- Soporte a reclamos y consultas de clientes

---

## Entradas y Salidas Principales

### Entrada (Request)

**Elemento raíz:** `consultaTransaccionSwitch`

| Campo | Tipo | Obligatorio | Descripción |
|-------|------|-------------|-------------|
| TRANSACTION_ID | string | Sí | Identificador único de la transacción en el switch |

**Header de Request:**
- `RequestHeader` (autType): Contiene información de autenticación y región
  - `Authentication/UserName`: Usuario LDAP para autenticación
  - `Authentication/Password`: Contraseña (opcional, se obtiene de LDAP)
  - `Region/SourceBank`: Código del banco origen (ej: HN01)
  - `Region/DestinationBank`: Código del banco destino

### Salida (Response)

**Elemento raíz:** `consultaTransaccionSwitchResponse`

| Campo | Tipo | Descripción |
|-------|------|-------------|
| TRANSACTION_ID | string | ID de la transacción consultada |
| ATM_ID | string | Identificador del cajero automático |
| NETWORK_ID | string | Identificador de la red (ej: VISA, MASTERCARD) |
| ATM_TRACE_NUMBER | string | Número de traza del ATM |
| FULL_TRACE_NUMBER | string | Número de traza completo |
| TRANSACTION_DATE | string | Fecha de la transacción |
| TRANSACTION_TIME | string | Hora de la transacción |
| AMOUNT | string | Monto de la transacción |
| CURRENCY | string | Código de moneda |
| AUTHORIZATION | string | Código de autorización |
| MCCCODE | string | Merchant Category Code |
| BRANCH_NAME | string | Nombre de la sucursal |

**Header de Response:**
- `ResponseHeader` (autType): Contiene el resultado de la operación
  - `successIndicator`: SUCCESS, NO RECORDS, ERROR
  - `messages`: Mensaje descriptivo del resultado

---

## Sistemas/Servicios OSB Involucrados

### 1. Proxy Service Principal
- **Nombre:** ConsultaTransaccionSwitch
- **Ruta:** `/Middleware/OperationsAndExecution/CustomerDeposits/ConsultaTransaccionSwitch_v2`
- **Protocolo:** SOAP/HTTPS
- **ServiceId:** FICBCO0141

### 2. Business Services Internos

#### a) ValidaServicioRegional_db
- **Tipo:** Database Adapter (JCA)
- **Propósito:** Validar que el servicio esté habilitado para la región solicitada
- **Stored Procedure:** `MW_P_VALIDA_SERVICIO_REGIONAL`
- **Conexión:** `eis/DB/ConnectionMiddleware`
- **Base de Datos:** Oracle Database (Middleware)
- **Esquema:** No especificado en configuración (se infiere del connection pool)

#### b) consultasTransacciones (T24 Web Service)
- **Tipo:** SOAP Web Service
- **Propósito:** Consultar transacciones del switch en el core bancario T24
- **Operación:** `Consultadetransaccionswitch`
- **Endpoints (Load Balanced):**
  - `http://10.9.104.97:7003/svcConsultasTransacciones/services`
  - `http://10.9.104.32:7004/svcConsultasTransacciones/services`
  - `http://10.9.104.97:7005/svcConsultasTransacciones/services`
  - `http://10.9.104.32:7006/svcConsultasTransacciones/services`
- **Algoritmo:** Round-robin
- **Timeout:** 60 segundos
- **Connection Timeout:** 50 segundos
- **Retry:** 1 intento con intervalo de 300ms

#### c) MapeoErrores
- **Tipo:** Proxy Service interno
- **Propósito:** Homologar códigos de error a estándares del middleware
- **Operación:** `mapeoErrores`

### 3. Recursos de Transformación

#### XQuery Transformations (HN01)
- **consultaTransaccionSwitchHNIn.xq**: Mapeo de request OSB → T24
- **consultaTransaccionSwitchHNOut.xq**: Mapeo de response T24 → OSB
- **consultaTransaccionSwitchHOut.xq**: Construcción del ResponseHeader

#### XQuery Generales
- **validaServicioRegionalIn.xq**: Construcción de request para validación regional
- **aplicarValoresPorDefectoRegion.xq**: Aplicar valores por defecto a región (HN01)
- **mapeoErroresUsageIn.xq**: Preparar request para mapeo de errores
- **mapeoErroresUsageOut.xq**: Procesar response de mapeo de errores

---

## Riesgos/Limitaciones Conocidas

### Limitaciones Funcionales

1. **Región Única Implementada**
   - Solo está implementada la región **HN01** (Honduras - Banco Ficohsa)
   - Otras regiones (GT01, PA01, NI01, HN02) retornan error: "SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY" (MW-0008)

2. **Dependencia de T24**
   - El servicio depende completamente de la disponibilidad del core bancario T24
   - No hay mecanismo de fallback o caché para consultas

3. **Autenticación LDAP**
   - Requiere credenciales configuradas en el servidor OSB bajo `Middleware/Security/{USERNAME}`
   - Si las credenciales no existen, el servicio falla

4. **Búsqueda Exacta**
   - Solo soporta búsqueda por TRANSACTION_ID exacto (operador EQ)
   - No permite búsquedas por rangos, wildcards o múltiples criterios

### Riesgos Técnicos

1. **Alta Disponibilidad**
   - Aunque hay 4 endpoints configurados, todos apuntan a solo 2 servidores físicos (10.9.104.97 y 10.9.104.32)
   - Fallo de uno de estos servidores reduce la capacidad en 50%

2. **Timeouts**
   - Timeout de 60 segundos puede ser insuficiente para consultas complejas en T24
   - Connection timeout de 50 segundos muy cercano al timeout de operación

3. **Manejo de Errores**
   - El campo ZERORECORDS en la respuesta de T24 indica "sin resultados", pero se trata como error
   - Posible confusión entre "transacción no encontrada" vs "error de sistema"

4. **Validación Regional**
   - La validación regional se hace contra base de datos, agregando latencia
   - Cache de 5 minutos (PT5M) puede causar inconsistencias si se actualizan configuraciones

5. **Seguridad**
   - Las credenciales de T24 se almacenan en el servidor OSB
   - No hay rotación automática de credenciales
   - El servicio no valida permisos específicos del usuario sobre la transacción consultada

### Limitaciones de Datos

1. **Formato de Fechas/Horas**
   - No se especifica el formato esperado de TRANSACTION_DATE y TRANSACTION_TIME
   - Posibles inconsistencias entre zonas horarias

2. **Montos**
   - Los montos se retornan como string sin formato específico
   - No se indica número de decimales o separadores

3. **Códigos**
   - No hay catálogos documentados para NETWORK_ID, MCCCODE, CURRENCY
   - Dificulta la interpretación de los datos

---

## Métricas o SLAs

### Configuración Actual

**Monitoring:**
- Habilitado: Sí
- Intervalo de agregación: 10 segundos
- Nivel: Pipeline

**Logging:**
- Habilitado: Sí
- Nivel: Debug

**Alerting:**
- SLA Alerting: Habilitado (nivel normal)
- Pipeline Alerting: Habilitado (nivel normal)

**Performance:**
- Timeout de operación: 60 segundos
- Connection timeout: 50 segundos
- Retry count: 1
- Retry interval: 300ms

**Caching (Validación Regional):**
- Habilitado: Sí
- TTL: 5 minutos (PT5M)
- Token: Concatenación de PV_SERVICIO + PV_ORIGEN + PV_DESTINO

### SLAs Recomendados (No Configurados)

Basado en la configuración actual, se recomienda establecer:

1. **Tiempo de Respuesta**
   - P95: < 3 segundos
   - P99: < 5 segundos
   - Máximo: 60 segundos (timeout)

2. **Disponibilidad**
   - Objetivo: 99.5% (considerando dependencia de T24)
   - Ventana de medición: 24x7

3. **Tasa de Error**
   - Errores de sistema: < 0.5%
   - Transacciones no encontradas: No aplica (es resultado válido)

4. **Throughput**
   - No hay límite configurado (throttling deshabilitado)
   - Limitado por capacidad de T24

---

## Regiones Detectadas

Basado en el análisis del código fuente:

### Región Implementada

| Código | País | Entidad | Estado | Notas |
|--------|------|---------|--------|-------|
| HN01 | Honduras | Banco Ficohsa | ✅ IMPLEMENTADO | Región completamente funcional |

### Regiones No Implementadas

| Código | País | Entidad | Estado | Mensaje de Error |
|--------|------|---------|--------|------------------|
| GT01 | Guatemala | Banco Ficohsa | ❌ NO IMPLEMENTADO | MW-0008: SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY |
| PA01 | Panamá | Banco Ficohsa | ❌ NO IMPLEMENTADO | MW-0008: SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY |
| NI01 | Nicaragua | Banco Ficohsa | ❌ NO IMPLEMENTADO | MW-0008: SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY |
| HN02 | Honduras | Otra entidad | ❌ NO IMPLEMENTADO | MW-0008: SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY |
| Otros | - | - | ❌ NO IMPLEMENTADO | MW-0008: SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY |

**Nota:** La detección de regiones se basa en:
1. Branch condicional en el proxy: `SourceBank = 'HN01'`
2. Pipeline por defecto que retorna error MW-0008 para cualquier otra región
3. Validación regional contra stored procedure `MW_P_VALIDA_SERVICIO_REGIONAL`

---

## Arquitectura de Alto Nivel

```
Cliente/Aplicación
       ↓
   [HTTPS/SOAP]
       ↓
ConsultaTransaccionSwitch Proxy (OSB)
       ↓
   [Validaciones]
       ├─→ ValidaServicioRegional_db (Oracle DB)
       │   └─→ MW_P_VALIDA_SERVICIO_REGIONAL
       │
   [Regionalización: HN01]
       ↓
   [Transformación XQuery]
       ↓
consultasTransacciones (T24 Web Service)
   └─→ Consultadetransaccionswitch
       └─→ WS.SWITCH.TRANSACTION (Enquiry T24)
       ↓
   [Respuesta T24]
       ↓
   [Transformación XQuery]
       ↓
   [Mapeo de Errores]
       ↓
Cliente/Aplicación
```

---

## Consideraciones para Migración

### Prioridad Alta
1. Implementar regiones faltantes (GT01, PA01, NI01)
2. Documentar y validar formatos de fecha/hora y montos
3. Establecer SLAs formales
4. Implementar rotación de credenciales

### Prioridad Media
5. Agregar caché de consultas frecuentes
6. Mejorar manejo de "transacción no encontrada" vs errores
7. Implementar circuit breaker para T24
8. Agregar métricas de negocio (transacciones consultadas por tipo)

### Prioridad Baja
9. Permitir búsquedas por criterios adicionales
10. Agregar validación de permisos por usuario
11. Implementar versionado del servicio

---

**Fecha de Análisis:** 2024
**Versión del Servicio:** v2
**ServiceId:** FICBCO0141
