# Comparativa entre Regiones - ConsultaPasivosCliente

## Tabla de Comparación General

| Aspecto | HN01 (Honduras) | GT01 (Guatemala) | PA01 (Panamá) | NI01 (Nicaragua) |
|---------|-----------------|------------------|---------------|------------------|
| **Endpoint OSB** | `/Middleware/OperationsAndExecution/PositionManagement/ConsultaPasivosCliente_v2` | `/Middleware/OperationsAndExecution/PositionManagement/ConsultaPasivosCliente_v2` | `/Middleware/OperationsAndExecution/PositionManagement/ConsultaPasivosCliente_v2` | `/Middleware/OperationsAndExecution/PositionManagement/ConsultaPasivosCliente_v2` |
| **Base de Datos Principal** | Oracle (implícito) | Oracle AbanksGT | Oracle AbanksPA | N/A (SOAP) |
| **Esquema/Package Préstamos** | N/A (Split-Join) | OSB_K_CONLISTAPRESTAMOS | OSB_K_CONLISTAPRESTAMOS | N/A |
| **Store Procedure Préstamos** | ConsultaPrestamosCliente (Split-Join) | TOPLEVEL$OSB_P_CON_LISTA_PRES | TOPLEVEL$OSB_P_CON_LISTA_PRES | N/A |
| **Conexión DB Préstamos** | Implícita en Split-Join | eis/DB/ConnectionProxyAbanksGT | eis/DB/ConnectionProxyAbanksPA | N/A |
| **Base de Datos Tarjetas** | Oracle MasterDataHN | Oracle MasterDataGT | Oracle MasterDataPA | N/A (SOAP) |
| **Store Procedure Tarjetas** | conDatoTarjetaClienteHN | conDatosTarjetaCliente | conDatosTarjetaCliente | N/A |
| **Conexión DB Tarjetas** | eis/DB/ConnectionProxyMasterDataHN | eis/DB/ConnectionProxyMasterDataGT | eis/DB/ConnectionProxyMasterDataPA | N/A |
| **Servicio Externo** | No | No | No | COBIS: http://10.235.53.149:9082/GerenciaProductoPasivos/SrvAplCobisPasivosService |
| **Operación SOAP Externa** | N/A | N/A | N/A | OpConsultaPasivosCliente |
| **Productos Soportados** | PTM, TRC, LCR, ALL | PTM, TRC, ALL | PTM, TRC, ALL | PTM, TRC, PTC, ALL |
| **Validación Funcionalidad Usuario** | Sí (ValidaFuncionalidadUsuario) | No | No | No |
| **Formato Fecha Salida** | yyyyMMdd (convertido) | yyyy-MM-dd | yyyy-MM-dd | yyyyMMdd |
| **Padding CUSTOMER_ID** | Sí (19 caracteres, ceros) | Sí (19 caracteres, ceros) | Sí (19 caracteres, ceros) | No |
| **Filtrado por BINes** | No | No | No | Sí (configurable) |
| **Filtrado por Códigos Bloqueo** | No | No | No | Sí (configurable) |
| **Retry Count** | N/A | 1 | 1 | 0 |
| **Retry Interval** | N/A | 30 seg | 30 seg | 0 seg |
| **Timeout Configurado** | N/A | N/A | N/A | 0 (sin timeout) |

---

## Detalles por Región

### 1. Honduras (HN01)

#### Características Distintivas
- **Única región con soporte de Líneas de Crédito (LCR)**
- **Validación de funcionalidad de usuario** para control de permisos
- **Arquitectura Split-Join** para consultas paralelas
- **Conversión de formato de fecha** en respuesta

#### Endpoints y Conexiones

**Préstamos (PTM)**:
- Business Service: `Middleware/Business_Resources/consultasCliente/consultaPasivosCliente/consultaPrestamos/ConsultaPrestamosCliente`
- Tipo: Split-Join (orquestación de múltiples servicios)
- Operación: `ConsultaPrestamosCliente`

**Tarjetas de Crédito (TRC)**:
- Business Service: `Middleware/v2/BusinessServices/MasterDataHN/conDatosTarjetaCliente/biz/conDatoTarjetaClienteHN_db`
- Conexión: `eis/DB/ConnectionProxyMasterDataHN`
- Package: No especificado en archivos analizados
- Procedure: `conDatoTarjetaClienteHN`

**Líneas de Crédito (LCR)**:
- Business Service: `Middleware/v2/BusinessServices/ABK/consultaLineasCreditoCliente/biz/consultaLineasCreditoCliente_db`
- Conexión: `eis/DB/ConnectionProxyABK`
- Procedure: `consultaLineasCreditoCliente`

**Consulta ALL**:
- Business Service: `Middleware/v2/BusinessServices/SJS/consultaPasivosCliente/biz/sjConsultaPasivosCliente`
- Tipo: Split-Join que orquesta consultas de PTM, TRC y LCR en paralelo

#### Transformaciones Clave

**Entrada**:
- `consultaPrestamosIn.xq`: Mapeo para consulta de préstamos
- `conDatosTarjetaClienteHNIn.xq`: Mapeo para tarjetas (padding de CUSTOMER_ID)
- `consultaLineasCreditoClienteIn.xq`: Mapeo para líneas de crédito
- `consultaPasivosClienteIn.xq`: Mapeo para consulta ALL

**Salida**:
- `consultaPrestamosOut.xq`: Transformación de respuesta de préstamos
- `consultaPasivosClienteHeaderOut.xq`: Construcción de header de respuesta
- `consultaPasivosClienteOut.xq`: Transformación completa de respuesta ALL
- `consultaPasivosClienteLCROut.xq`: Transformación específica para LCR

#### Campos Diferenciadores
- `functionalityIndicator`: Controla visibilidad de información según permisos
- Conversión de fecha: `yyyy-MM-dd` → `yyyyMMdd` en LIABILITY_PAYMENT_DATE
- Soporte de 3 tipos de respuesta: Préstamos, Tarjetas y LCR

#### Errores/Excepciones
- Validación de funcionalidad: Si falla, se asigna "ALL" por defecto
- Error de validación regional: Retorna error inmediato
- Error en consulta LCR: Códigos `NO_RECORDS`, `-1`, `ERROR`

#### Timeouts/Retries
- No configurados explícitamente en servicios de base de datos
- Split-Join maneja timeouts internos

#### Dependencias Internas
- `ValidaServicioRegional`: Validación de servicio habilitado
- `ValidaFuncionalidadUsuario`: Validación de permisos
- `MapeoErrores`: Mapeo de códigos de error
- `convertirCodigoPais`: Conversión de código de país OSB a ISO3

---

### 2. Guatemala (GT01)

#### Características Distintivas
- **Arquitectura más simple** basada en llamadas directas a DB
- **Mismo package de préstamos que Panamá**
- **Transformaciones específicas** para manejo de tarjetas con monedas múltiples

#### Endpoints y Conexiones

**Préstamos (PTM)**:
- Business Service: `Middleware/v2/BusinessServices/ABKGT/consultaPasivosCliente/biz/consultaPasivosCliente_db`
- Conexión: `eis/DB/ConnectionProxyAbanksGT`
- Package: `OSB_K_CONLISTAPRESTAMOS`
- Procedure: `TOPLEVEL$OSB_P_CON_LISTA_PRES`
- Adapter: Database Adapter (JCA)

**Tarjetas de Crédito (TRC)**:
- Business Service: `Middleware/v2/BusinessServices/MasterDataGT/conDatosTarjetaCliente/biz/conDatosTarjetaCliente_db`
- Conexión: `eis/DB/ConnectionProxyMasterDataGT`
- Procedure: `conDatosTarjetaCliente`

**Consulta ALL**:
- Ejecuta ambos servicios (PTM y TRC) secuencialmente

#### Transformaciones Clave

**Entrada**:
- `consultaPasivosClientePtmoGTIn.xq`: Mapeo simple de CUSTOMER_ID y LIABILITY_TYPE
- `conDatosTarjetaClienteGTIn.xq`: Mapeo con padding de CUSTOMER_ID y código de país

**Salida**:
- `consultaPasivosClienteGTOut.xq`: Transformación compleja con:
  - Iteración sobre arrays de préstamos
  - Agrupación de tarjetas por número (distinct-values)
  - Manejo de monedas BASE y ALT
  - Conversión de fechas con `fn-bea:dateTime-to-string-with-format`
- `consultaPasivosClienteGTHeaderOut.xq`: Construcción de header basado en códigos de error

#### Campos Diferenciadores
- **LIABILITY_SOURCE_BANK**: Siempre "GT01" (hardcoded en transformación)
- **Agrupación de tarjetas**: Por número de tarjeta con tipos BASE/ALT
- **Formato fecha**: `yyyy-MM-dd` (sin conversión)
- **Monedas múltiples**: Manejo explícito de CURRENCY_1 y CURRENCY_2

#### Errores/Excepciones
- Préstamos: `ERROR_CODE = "SUCCESS"` indica éxito
- Tarjetas: `CodigoError = "-1"` indica éxito
- Otros códigos indican error o sin registros

#### Timeouts/Retries
- **Retry Count**: 1
- **Retry Interval**: 30 segundos
- **Retry Application Errors**: true

#### Dependencias Internas
- `ValidaServicioRegional`
- `MapeoErrores`
- `convertirCodigoPais`

---

### 3. Panamá (PA01)

#### Características Distintivas
- **Arquitectura idéntica a Guatemala** en estructura
- **Mismo package y procedure** para préstamos
- **Diferencias en transformaciones** de salida

#### Endpoints y Conexiones

**Préstamos (PTM)**:
- Business Service: `Middleware/v2/BusinessServices/ABKPA/consultaPasivosCliente/biz/consultaPasivosCliente_db`
- Conexión: `eis/DB/ConnectionProxyAbanksPA`
- Package: `OSB_K_CONLISTAPRESTAMOS`
- Procedure: `TOPLEVEL$OSB_P_CON_LISTA_PRES`
- Operación: `consultaListaPrestamos` (nombre diferente a GT)

**Tarjetas de Crédito (TRC)**:
- Business Service: `Middleware/v2/BusinessServices/MasterDataPA/conDatosTarjetaCliente/biz/conDatosTarjetaCliente_db`
- Conexión: `eis/DB/ConnectionProxyMasterDataPA`
- Procedure: `conDatosTarjetaCliente`

**Consulta ALL**:
- Ejecuta ambos servicios (PTM y TRC) secuencialmente

#### Transformaciones Clave

**Entrada**:
- `consultaPasivosClientePtmoPAIn.xq`: Mapeo simple (idéntico a GT en estructura)
- `conDatosTarjetaClientePAIn.xq`: Mapeo con padding y código de país

**Salida**:
- `consultaPasivosClientePAOut.xq`: Transformación con:
  - Iteración directa sobre filas (sin agrupación por tarjeta)
  - Validaciones condicionales para cada campo
  - Conversión de fecha con formato `YYY-MM-dd` (typo en código)
- `consultaPasivosClientePAHeaderOut.xq`: Construcción de header

#### Campos Diferenciadores
- **LIABILITY_SOURCE_BANK**: Siempre "PA01"
- **Sin agrupación de tarjetas**: Cada fila es un registro independiente
- **Validaciones más estrictas**: Verifica que campos no estén vacíos antes de incluirlos
- **Formato fecha**: `yyyy-MM-dd`

#### Errores/Excepciones
- Préstamos: `ERROR_CODE = "SUCCESS"` indica éxito
- Tarjetas: `CodigoError = "-1"` indica éxito
- Variable `validationMessagess` (con doble 's') para mensajes de error

#### Timeouts/Retries
- **Retry Count**: 1
- **Retry Interval**: 30 segundos
- **Retry Application Errors**: true

#### Dependencias Internas
- `ValidaServicioRegional`
- `MapeoErrores`
- `convertirCodigoPais`

---

### 4. Nicaragua (NI01)

#### Características Distintivas
- **Única región con servicio SOAP externo** (COBIS)
- **Soporte de producto PTC** (Préstamos con Tarjeta de Crédito)
- **Filtrado avanzado** por BINes y códigos de bloqueo
- **Obtención de parámetros** desde base de datos de configuración

#### Endpoints y Conexiones

**Servicio Principal**:
- Business Service: `Middleware/v2/BusinessServices/CTS/pasivos/biz/pasivos`
- Protocolo: SOAP 1.2
- Endpoint: `http://10.235.53.149:9082/GerenciaProductoPasivos/SrvAplCobisPasivosService`
- Operación: `OpConsultaPasivosCliente`
- Namespace: `http://impl.service.srvaplcobispasivos.ecobis.cobiscorp/`

**Servicio de Configuración**:
- Business Service: `Middleware/Business_Resources/general/Resources/ObtenerParametrizacion/ObtenerParametrizacion`
- Operación: `obtenerParametrizacion`
- Parámetros obtenidos:
  - `FICBCO0044.CODIGOSBLOQUEO`: Códigos de bloqueo de tarjetas
  - `FICBCO0044.BINES.PTC`: BINes de tarjetas PTC

#### Transformaciones Clave

**Entrada**:
- `consultaPasivosClienteNIIn.xq`: Mapeo a estructura COBIS
  - Conversión de tipo producto: `PTC` → `TRC` en el request
  - Estructura con `contextoTransaccional`, `cliente`, `producto`
  - Campo `valIdCliente` tomado del username de autenticación

**Salida**:
- `consultaPasivosClienteNIOut.xq`: Transformación compleja con:
  - Filtrado de préstamos: `codTipoProducto = 'CCA'`
  - Filtrado de tarjetas: `codTipoProducto = 'TCR'`
  - Exclusión de BINes configurados para TRC
  - Inclusión de BINes configurados para PTC
  - Validación de códigos de bloqueo
  - Redondeo de decimales: `fn:round-half-to-even(xs:decimal(...), 2)`
  - Conversión de fecha: `fn-bea:dateTime-to-string-with-format("yyyyMMdd", ...)`

#### Campos Diferenciadores
- **LIABILITY_SOURCE_BANK**: Siempre "NI01"
- **Tres tipos de respuesta**: PTM, TRC, PTC
- **Filtrado por BINes**: 
  - TRC: Excluye tarjetas con BINes en lista
  - PTC: Incluye solo tarjetas con BINes en lista
- **Filtrado por bloqueo**:
  - Excluye si `codigoDelBloqueDol1` o `codigoDelBloque1` están en lista de bloqueos
  - Para PTC: Lógica especial con estado "A" y validación de saldo
- **Formato fecha**: `yyyyMMdd`
- **Sin padding de CUSTOMER_ID**

#### Errores/Excepciones
- Validación de parámetros: Si falla obtención de configuración, retorna error
- Respuesta COBIS: Estructura con `contextoTransaccional` y códigos de error específicos
- Variable `validationMessage` controla flujo de error

#### Timeouts/Retries
- **Retry Count**: 0 (sin retry)
- **Retry Interval**: 0 segundos
- **Request Timeout**: 0 (sin timeout configurado)
- **Connection Timeout**: 0 (sin timeout configurado)
- **Chunked Streaming Mode**: true

#### Dependencias Internas
- `ValidaServicioRegional`
- `MapeoErrores`
- `ObtenerParametrizacion`

---

## Diferencias Clave entre Regiones

### Arquitectura
- **HN01**: Split-Join con orquestación compleja
- **GT01/PA01**: Llamadas directas a DB con lógica secuencial
- **NI01**: Integración con servicio SOAP externo

### Tecnología Backend
- **HN01/GT01/PA01**: Oracle Database con Stored Procedures
- **NI01**: Sistema COBIS (SOAP)

### Productos Soportados
- **HN01**: PTM, TRC, LCR, ALL (único con LCR)
- **GT01/PA01**: PTM, TRC, ALL
- **NI01**: PTM, TRC, PTC, ALL (único con PTC)

### Complejidad de Transformación
- **HN01**: Alta (Split-Join + conversión de fechas)
- **GT01**: Media-Alta (agrupación de tarjetas)
- **PA01**: Media (sin agrupación)
- **NI01**: Muy Alta (filtrado múltiple + configuración dinámica)

### Resiliencia
- **HN01**: Sin retry configurado
- **GT01/PA01**: Retry 1 vez con 30 seg de intervalo
- **NI01**: Sin retry ni timeout

---

## Recomendaciones de Estandarización

1. **Unificar formato de fechas**: Adoptar `yyyyMMdd` en todas las regiones
2. **Estandarizar códigos de error**: Usar misma convención (SUCCESS, ERROR, NO_RECORDS)
3. **Implementar retry en todas las regiones**: Configurar retry count y timeout apropiados
4. **Consolidar lógica de transformación**: Extraer lógica común a funciones reutilizables
5. **Estandarizar nombres de operaciones**: Usar mismos nombres para operaciones equivalentes
6. **Implementar circuit breakers**: Especialmente para NI01 (servicio externo)
7. **Validación de funcionalidad**: Extender a todas las regiones o eliminar de HN01
8. **Documentar SLAs**: Establecer y documentar SLAs por región
