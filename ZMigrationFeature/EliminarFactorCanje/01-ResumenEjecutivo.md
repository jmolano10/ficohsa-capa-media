# Resumen Ejecutivo - EliminarFactorCanje

## Índice de Documentación

1. [Resumen Ejecutivo](01-ResumenEjecutivo.md)
2. [Comparativa entre Regiones](02-ComparativaRegiones.md)
3. [Ejemplos y Mapeos - Honduras (HN01)](03-EjemplosYMapeos-HN01.md)
4. [Ejemplos y Mapeos - Guatemala (GT01)](03-EjemplosYMapeos-GT01.md)
5. [Ejemplos y Mapeos - Panamá (PA01)](03-EjemplosYMapeos-PA01.md)
6. [Ejemplos y Mapeos - Nicaragua (NI01)](03-EjemplosYMapeos-NI01.md)
7. [Diagrama de Secuencia - Honduras (HN01)](04-Secuencia-HN01.mmd)
8. [Diagrama de Secuencia - Guatemala (GT01)](04-Secuencia-GT01.mmd)
9. [Diagrama de Secuencia - Panamá (PA01)](04-Secuencia-PA01.mmd)
10. [Diagrama de Secuencia - Nicaragua (NI01)](04-Secuencia-NI01.mmd)
11. [Diagrama de Flujo Multiregión](05-FlujoMultiregion.mmd)
12. [Listado de Ficheros](06-ListadoFicheros.md)

---

## 1. Propósito de la Funcionalidad

La funcionalidad **EliminarFactorCanje** permite eliminar factores de canje (promociones) asociados a programas de puntos de tarjetas de crédito/débito en el sistema bancario de Ficohsa. Esta operación es crítica para la gestión de promociones y programas de lealtad, permitiendo dar de baja factores de canje que ya no están vigentes o que fueron creados por error.

### Objetivo del Negocio
- Eliminar promociones de canje de puntos por ID de promoción
- Mantener la integridad de los programas de lealtad
- Auditar las eliminaciones mediante registro de usuario
- Soportar operaciones multiregionales (Honduras, Guatemala, Panamá, Nicaragua)

---

## 2. Entradas y Salidas Principales

### 2.1. Entrada Principal

**Request SOAP Body:**
```xml
<eliminarFactorCanje>
	<PROMO_ID>string</PROMO_ID>
</eliminarFactorCanje>
```

**Request SOAP Header:**
```xml
<RequestHeader>
	<Authentication>
		<UserName>string</UserName>
	</Authentication>
</RequestHeader>
```

**Campos de Entrada:**
- `PROMO_ID` (string, obligatorio, minLength=1): Identificador único de la promoción a eliminar
- `UserName` (string, obligatorio): Usuario que ejecuta la eliminación (se convierte a mayúsculas)

### 2.2. Salida Principal

**Response SOAP Body:**
```xml
<eliminarFactorCanjeResponse/>
```

**Response SOAP Header (Éxito):**
```xml
<ResponseHeader>
	<successIndicator>Success</successIndicator>
</ResponseHeader>
```

**Response SOAP Header (Error):**
```xml
<ResponseHeader>
	<successIndicator>ERROR</successIndicator>
	<messages>Descripción del error</messages>
</ResponseHeader>
```

---

## 3. Sistemas/Servicios OSB Involucrados

### 3.1. Proxy Services (Puntos de Entrada)

#### Proxy Principal con Enrutamiento Dinámico
- **EliminarFactorCanje** (`Middleware/v2/ProxyServices/EliminarFactorCanje.proxy`)
	- Service ID: `FICBCO0275`
	- Realiza validación XSD
	- Consulta ruta regional mediante `consultaRutaRegional_db`
	- Enruta dinámicamente a proxy regional según configuración
	- Aplica mapeo de errores mediante `MapeoErrores`

#### Proxies Regionales
- **EliminarFactorCanjeHN** (`Middleware/v2/ProxyServices/EliminarFactorCanjeHN.proxy`) - Honduras (HN01)
- **EliminarFactorCanjeGT** (`Middleware/v2/ProxyServices/EliminarFactorCanjeGT.proxy`) - Guatemala (GT01)
- **EliminarFactorCanjePA** (`Middleware/v2/ProxyServices/EliminarFactorCanjePA.proxy`) - Panamá (PA01)
- **EliminarFactorCanjeNI** (`Middleware/v2/ProxyServices/EliminarFactorCanjeNI.proxy`) - Nicaragua (NI01)

### 3.2. Business Services (Conexiones a Base de Datos)

Cada región tiene su propio Business Service que ejecuta el stored procedure:

| Región | Business Service | Conexión DB | Esquema | Stored Procedure |
|--------|-----------------|-------------|---------|------------------|
| HN01 | `Middleware/v2/BusinessServices/ABK/eliminarFactorCanje/biz/eliminarFactorCanje_db` | `ConnectionProxyAbanksHN` | (default) | `PL_P_ELIMINAR_FACTOR_CANJE` |
| GT01 | `Middleware/v2/BusinessServices/ABKGT/eliminarFactorCanje/biz/eliminarFactorCanje_db` | `ConnectionProxyAbanksGT` | `PROXYABANKSGT` | `PL_P_ELIMINAR_FACTOR_CANJE` |
| PA01 | `Middleware/v2/BusinessServices/ABKPA/eliminarFactorCanje/biz/eliminarFactorCanje_db` | `ConnectionProxyAbanksPA` | `PROXYABANKSPA` | `PL_P_ELIMINAR_FACTOR_CANJE` |
| NI01 | `Middleware/v2/BusinessServices/PXYNIC/eliminarFactorCanje/biz/eliminarFactorCanje_db` | `ConnectionProxyNI` | `PROXYNICARAGUA` | `PL_P_ELIMINAR_FACTOR_CANJE` |

### 3.3. Servicios de Soporte

- **consultaRutaRegional_db**: Determina el proxy regional a invocar según el Service ID y región del header
- **MapeoErrores**: Traduce códigos de error técnicos a mensajes de negocio estandarizados

### 3.4. Transformaciones XQuery

- `eliminarFactorCanjeHNIn.xq`: Mapeo de request OSB a parámetros de SP para Honduras
- `eliminarFactorCanjeGTIn.xq`: Mapeo de request OSB a parámetros de SP para Guatemala
- `eliminarFactorCanjePAIn.xq`: Mapeo de request OSB a parámetros de SP para Panamá
- `eliminarFactorCanjeIn.xq`: Mapeo de request OSB a parámetros de SP para Nicaragua

---

## 4. Riesgos/Limitaciones Conocidas

### 4.1. Riesgos Operacionales

1. **Eliminación Irreversible**: No se detectó lógica de soft-delete o auditoría de respaldo. La eliminación es permanente.

2. **Validación Limitada**: Solo se valida que `PROMO_ID` no esté vacío. No hay validaciones de:
	- Existencia previa de la promoción
	- Estado de la promoción (activa/inactiva)
	- Dependencias con otras entidades

3. **Concurrencia**: No se detectaron mecanismos de bloqueo optimista/pesimista para evitar eliminaciones concurrentes.

4. **Auditoría**: Aunque se registra el usuario, no se detectó logging detallado de:
	- Timestamp de eliminación
	- Datos de la promoción eliminada
	- IP de origen

### 4.2. Riesgos Técnicos

1. **Timeout Configuration**: 
	- Retry count: 0 (no hay reintentos automáticos)
	- Retry interval: 30 segundos
	- No se detectó timeout explícito en las conexiones DB

2. **Manejo de Errores**:
	- Los errores de base de datos se propagan directamente al cliente
	- El mapeo de errores depende del servicio `MapeoErrores` (punto único de falla)

3. **Enrutamiento Dinámico**:
	- Dependencia crítica del servicio `consultaRutaRegional_db`
	- Si falla la consulta de ruta, toda la operación falla

4. **Consistencia Regional**:
	- Cada región tiene su propia base de datos
	- No hay sincronización cross-regional detectada
	- Posible inconsistencia si una promoción existe en múltiples regiones

### 4.3. Limitaciones de Diseño

1. **Response Vacío**: El body de respuesta siempre está vacío (`<eliminarFactorCanjeResponse/>`), solo el header contiene información de éxito/error.

2. **Selector Type Inconsistente**:
	- HN01 y GT01: `SOAP body`
	- PA01 y NI01: `SOAP action`
	- Puede causar problemas de interoperabilidad

3. **Logging Level**: Configurado en `debug` en todos los proxies, puede generar volumen excesivo de logs en producción.

4. **Sin Paginación**: No aplica para esta operación (eliminación única por ID).

---

## 5. Métricas o SLAs

### 5.1. Configuración Detectada

**Monitoring:**
- Habilitado: `false` en todos los proxies
- Aggregation Interval: 10 segundos
- Pipeline Monitoring Level: Pipeline

**Alerting:**
- SLA Alerting: `enabled=true`, level=`normal`
- Pipeline Alerting: `enabled=true`, level=`normal`

**Reporting:**
- Habilitado: `true` en todos los proxies

**Throttling:**
- Habilitado: `false`
- Capacity: 0
- Max Queue Length: 0
- Time to Live: 0

**Result Caching:**
- Supported: `false`
- Enabled: `true` (aunque no soportado)

### 5.2. Métricas Recomendadas (No Implementadas)

Basado en el análisis del código, se recomienda implementar:

1. **Tiempo de Respuesta**:
	- Target: < 2 segundos (percentil 95)
	- Crítico: > 5 segundos

2. **Tasa de Éxito**:
	- Target: > 99%
	- Crítico: < 95%

3. **Disponibilidad**:
	- Target: 99.9% (8.76 horas downtime/año)

4. **Throughput**:
	- No se detectaron límites configurados
	- Recomendado: Definir según volumetría esperada

### 5.3. Observaciones

- **No se detectaron timeouts explícitos** en las configuraciones de Business Services
- **No hay circuit breakers** implementados
- **No hay rate limiting** configurado
- **Retry count = 0**: Las operaciones no se reintentan automáticamente en caso de fallo

---

## 6. Flujo General de Operación

### 6.1. Flujo con Enrutamiento Dinámico (Proxy Principal)

```
Cliente → EliminarFactorCanje (Proxy Principal)
	↓
	1. Validación XSD del request
	↓
	2. Consulta ruta regional (consultaRutaRegional_db)
		- Service ID: FICBCO0275
		- Región del header
	↓
	3. Enrutamiento dinámico al proxy regional
	↓
	4. Mapeo de errores (si aplica)
	↓
	← Response al cliente
```

### 6.2. Flujo Regional (Proxies Específicos)

```
Proxy Regional (HN/GT/PA/NI)
	↓
	1. Transformación XQuery (request → SP params)
		- PROMO_ID → PV_IDPROMOCION
		- UserName → PV_USUARIO (uppercase)
	↓
	2. Invocación a Business Service (DB Adapter)
		- Stored Procedure: PL_P_ELIMINAR_FACTOR_CANJE
	↓
	3. Evaluación de respuesta
		- Si PV_CODIGOMENSAJE = 'SUCCESS' → successIndicator=Success
		- Si PV_CODIGOMENSAJE != 'SUCCESS' → successIndicator=ERROR + mensaje
	↓
	4. Construcción de response header
	↓
	← Response al cliente (body vacío)
```

### 6.3. Manejo de Errores

```
Error en cualquier etapa
	↓
	1. Captura en error handler
	↓
	2. Extracción de errorCode y errorMessage
	↓
	3. Construcción de response header con ERROR
	↓
	← Response al cliente con detalles del error
```

---

## 7. Regiones Detectadas

| Código | Región | Proxy Service | Business Service | Conexión DB | Esquema |
|--------|--------|---------------|------------------|-------------|---------|
| HN01 | Honduras | EliminarFactorCanjeHN | ABK/eliminarFactorCanje | ConnectionProxyAbanksHN | (default) |
| GT01 | Guatemala | EliminarFactorCanjeGT | ABKGT/eliminarFactorCanje | ConnectionProxyAbanksGT | PROXYABANKSGT |
| PA01 | Panamá | EliminarFactorCanjePA | ABKPA/eliminarFactorCanje | ConnectionProxyAbanksPA | PROXYABANKSPA |
| NI01 | Nicaragua | EliminarFactorCanjeNI | PXYNIC/eliminarFactorCanje | ConnectionProxyNI | PROXYNICARAGUA |

---

## 8. Dependencias Críticas

### 8.1. Servicios Externos
- **consultaRutaRegional_db**: Servicio de enrutamiento regional (solo en proxy principal)
- **MapeoErrores**: Servicio de traducción de errores (solo en proxy principal)

### 8.2. Bases de Datos
- **Oracle Database** (una instancia por región)
- **Stored Procedure**: `PL_P_ELIMINAR_FACTOR_CANJE` (debe existir en todas las regiones)

### 8.3. Recursos Compartidos
- **WSDL**: `eliminarFactorCanjePS.wsdl` (compartido por todas las regiones)
- **XSD**: `gestionPuntosTarjetasTypes.xsd` (definición de tipos compartida)
- **HeaderElements.xsd**: Definición de headers de autenticación

---

## 9. Consideraciones de Migración

### 9.1. Puntos de Atención

1. **Stored Procedures**: Verificar que `PL_P_ELIMINAR_FACTOR_CANJE` existe y tiene la misma firma en todas las regiones.

2. **Conexiones DB**: Validar que las conexiones JNDI están configuradas correctamente:
	- `ConnectionProxyAbanksHN`
	- `ConnectionProxyAbanksGT`
	- `ConnectionProxyAbanksPA`
	- `ConnectionProxyNI`

3. **Esquemas**: Confirmar nombres de esquemas en cada región:
	- GT: `PROXYABANKSGT`
	- PA: `PROXYABANKSPA`
	- NI: `PROXYNICARAGUA`
	- HN: esquema por defecto del usuario de conexión

4. **Service ID**: El proxy principal usa `FICBCO0275` para consultar la ruta regional. Verificar que este ID está registrado en la tabla de configuración regional.

5. **Selector Type**: Decidir si estandarizar en `SOAP body` o `SOAP action` para todas las regiones.

### 9.2. Testing Recomendado

1. **Pruebas Unitarias por Región**: Validar eliminación exitosa en cada región.
2. **Pruebas de Error**: Validar manejo de errores (promoción inexistente, errores de DB, etc.).
3. **Pruebas de Enrutamiento**: Validar que el enrutamiento dinámico funciona correctamente.
4. **Pruebas de Concurrencia**: Validar comportamiento con múltiples eliminaciones simultáneas.
5. **Pruebas de Auditoría**: Verificar que el usuario se registra correctamente en la base de datos.

---

## 10. Conclusiones

La funcionalidad **EliminarFactorCanje** es una operación crítica de gestión de promociones con las siguientes características:

**Fortalezas:**
- Arquitectura multiregional bien estructurada
- Separación clara entre proxy principal (enrutamiento) y proxies regionales (ejecución)
- Transformaciones XQuery consistentes entre regiones
- Manejo de errores estandarizado

**Áreas de Mejora:**
- Implementar validaciones de negocio más robustas
- Agregar auditoría detallada de eliminaciones
- Configurar timeouts y reintentos apropiados
- Estandarizar selector type entre regiones
- Implementar soft-delete en lugar de eliminación física
- Habilitar monitoring para métricas de performance

**Riesgo General**: **MEDIO**
- La operación es relativamente simple pero irreversible
- Dependencias críticas en servicios de enrutamiento y mapeo de errores
- Falta de validaciones de negocio puede llevar a eliminaciones no deseadas
