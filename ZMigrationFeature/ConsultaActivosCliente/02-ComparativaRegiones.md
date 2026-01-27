# Comparativa entre Regiones - ConsultaActivosCliente

## Tabla Comparativa General

| Aspecto | HN01 (Honduras) | GT01 (Guatemala) | PA01 (Panamá) | NI01 (Nicaragua) |
|---------|----------------|------------------|---------------|------------------|
| **Endpoint OSB** | `/SMiddleware/OperationsAndExecution/PositionManagement/ConsultaActivosCliente_v2` | `/SMiddleware/OperationsAndExecution/PositionManagement/ConsultaActivosCliente_v2` | `/SMiddleware/OperationsAndExecution/PositionManagement/ConsultaActivosCliente_v2` | `/SMiddleware/OperationsAndExecution/PositionManagement/ConsultaActivosCliente_v2` |
| **Tecnología Backend** | T24 + Oracle DB + OSB 12c | Oracle DB (Stored Procedures) | Oracle DB (Stored Procedures) | Cobis CTS (Web Service) |
| **Nombre de Base de Datos** | T24 Database + Oracle | AbanksGT | AbanksPA | N/A (Web Service) |
| **Esquema** | Múltiples esquemas | OSB_K_CONLISTACUENTAS | OSB_K_CONLISTACUENTAS | N/A |
| **Stored Procedure Principal** | Múltiples SPs | `TOPLEVEL$OSB_P_CON_LISTA_CUEN` | `TOPLEVEL$OSB_P_CON_LISTA_CUEN` | N/A |
| **Nombre de Conexión DB** | `consultasClienteBS` (T24) | `ConnectionProxyAbanksGT` | `ConnectionProxyAbanksPA` | N/A |
| **Endpoint Web Service** | T24 Web Services | N/A | N/A | CTS Activos Service |
| **Operación WS** | `ConsultaCuentaAhorroxCliente`, `ConsultaCuentaCorrientexCliente`, `Consultadecertifdepporcliente` | N/A | N/A | `OpConsultaActivosCliente` |
| **Transformaciones Clave** | XQuery por tipo de producto | XQuery con Split-Join | XQuery con Split-Join | XQuery con mapeo Cobis |
| **Campos Diferenciadores** | `ASSET_SOURCE_BANK`, Fondos Pensiones | `ASSET_SOURCE_BANK`, `ASSET_PRODUCT_TYPE` | `ASSET_SOURCE_BANK`, `ASSET_PRODUCT_TYPE` | `INTERNATIONAL_ACCOUNT_NUMBER` |
| **Errores/Excepciones** | Validación XSD, MapeoErrores | MapeoErrores | MapeoErrores | MapeoErrores |
| **Timeouts** | No especificado | 0 (sin límite) | 0 (sin límite) | No especificado |
| **Retrys** | No especificado | 0 | 1 | No especificado |
| **Dependencias Internas** | ValidaServicioRegional, ValidaFuncionalidadUsuario, ConsultaCliente | ValidaServicioRegional, ValidaFuncionalidadUsuario | ValidaServicioRegional, ValidaFuncionalidadUsuario | ValidaServicioRegional |
| **Autenticación** | Custom Token (Username/Password) | Heredada del header | Heredada del header | Heredada del header |
| **Validación Request** | Sí (XSD Schema) | No explícita | No explícita | Sí (XSD Schema) |
| **Tipos de Activos Soportados** | AHO, CHQ, DEP, FPC, CTA, ALL | AHO, CHQ, DEP, CTA, ALL | AHO, CHQ, DEP, CTA, ALL | AHO, CHQ (CTE), DEP (PFI), ALL |
| **Ejecución Paralela** | No (secuencial) | Sí (Split-Join) | Sí (Split-Join) | No (servicio único) |

---

## Detalle por Región

### 1. HN01 - Honduras

#### 1.1. Arquitectura

- **Patrón**: Enrutamiento condicional por tipo de producto
- **Backend**: Múltiples sistemas (T24, Oracle DB, OSB 12c)
- **Flujo**: Secuencial con múltiples llamadas

#### 1.2. Endpoints y Conexiones

**Base de Datos Oracle**:
- **Conexión**: `consultasClienteBS`
- **Operaciones**:
  - `Consultadecliente`: Obtiene información del cliente
  - `Consultadecertifdepporcliente`: Consulta depósitos a plazo

**T24 Web Services**:
- **Business Service**: `ConsultaCuentaAhorro`, `ConsultaCuentaCorriente`
- **Operaciones**:
  - `ConsultaCuentaAhorroxCliente`: Consulta cuentas de ahorro
  - `ConsultaCuentaCorrientexCliente`: Consulta cuentas corrientes

**OSB 12c - Fondos de Pensiones**:
- **Business Service**: `consultaFondoPensiones12c`
- **Operación**: `getAssetsCustomer`
- **Endpoint**: Servicio OSB 12c interno

**Stored Procedures**:
- No se utilizan directamente para consulta de activos
- Se usa para consulta de cliente y validaciones

#### 1.3. Mapeos de Datos

**Request OSB → T24 (Ahorros)**:
- `CUSTOMER_ID` → `CUSTOMER_ID` (T24)
- `ASSET_TYPE` → Filtro interno

**Request OSB → Oracle DB (Depósitos)**:
- `CUSTOMER_ID` → Parámetro SP
- `ASSET_TYPE` → Filtro

**Request OSB → OSB 12c (Pensiones)**:
- `CUSTOMER_ID` → `legalId` (obtenido de ConsultaCliente)
- `LEGAL_ID_TYPE` → `legalIdType` (transformado)
- `SourceBank` → Header
- `UserName` → Header

**Response T24 → OSB**:
- Campos T24 → Estructura estándar OSB
- Agregación de múltiples respuestas

#### 1.4. Reglas de Negocio

1. **Consulta de Cliente Previa**:
   - Siempre se consulta información del cliente antes de consultar activos
   - Se obtiene `LEGALID` y `LEGALDOCNAME`
   - Se transforma tipo de documento con XQuery `convertirTipoDocumento`

2. **Enrutamiento por Tipo de Producto**:
   ```
   IF ASSET_TYPE = "AHO" THEN
       → ConsultaCuentaAhorro
   ELSE IF ASSET_TYPE = "FPC" THEN
       → consultaFondoPensiones12c
   ELSE IF ASSET_TYPE = "CHQ" THEN
       → ConsultaCuentaCorriente
   ELSE IF ASSET_TYPE = "DEP" THEN
       → Consultadecertifdepporcliente
   ELSE IF ASSET_TYPE = "CTA" OR "ALL" THEN
       → sjConsultaCuentasCliente (Split-Join)
   ```

3. **Validación de Funcionalidad Usuario**:
   - Se valida funcionalidad `SALDOS_ACTIVOS`
   - Si falla, se asigna valor por defecto "ALL"
   - Determina qué información se muestra al usuario

4. **Transformación de Respuesta**:
   - Diferentes XQuery según tipo de producto
   - Agregación de respuestas vacías para productos no consultados

#### 1.5. Manejo de Errores

- **Validación XSD**: Error BEA-382505 para request inválido
- **Error Handler**: Pipeline de error con transformación de faults
- **MapeoErrores**: Servicio para normalizar códigos de error
- **Código de Servicio**: FICBCO0043

#### 1.6. Políticas y Configuración

- **Autenticación**: Custom token con username/password en header
- **Monitoring**: Habilitado (720 min aggregation)
- **Logging**: Debug level
- **HTTPS**: Requerido

---

### 2. GT01 - Guatemala

#### 2.1. Arquitectura

- **Patrón**: Split-Join para ejecución paralela
- **Backend**: Oracle Database con Stored Procedures
- **Flujo**: Paralelo (cuentas y depósitos simultáneos)

#### 2.2. Endpoints y Conexiones

**Base de Datos Oracle**:
- **Conexión JCA**: `jca://eis/DB/ConnectionProxyAbanksGT`
- **Adapter**: DB Adapter
- **Connection Mode**: Managed

**Stored Procedures**:

1. **Consulta de Cuentas**:
   - **Package**: `OSB_K_CONLISTACUENTAS`
   - **Procedure**: `TOPLEVEL$OSB_P_CON_LISTA_CUEN`
   - **Business Service**: `consultaListaCuentas_db`
   - **Operación**: `consultaListaCuentas`

2. **Consulta de Depósitos**:
   - **Package**: Similar al de cuentas
   - **Procedure**: Para depósitos
   - **Business Service**: `consultaListaDepositosCliente_db`
   - **Operación**: `consultaListaDepositosCliente`

#### 2.3. Mapeos de Datos

**Request OSB → DB (Entrada)**:

XQuery: `sjConsultaActivosClientesGTIn.xq`
```
consultaActivosClienteRequest/CUSTOMER_ID → PV_CUSTOMER_ID
consultaActivosClienteRequest/ASSET_TYPE → PV_ASSET_TYPE
```

**Request OSB → DB Cuentas (Split-Join)**:

XQuery: `consultaListaCuentasGTIn.xq`
```
consultaActivosClienteRequest/CUSTOMER_ID → PV_CUSTOMER_ID
```

**Request OSB → DB Depósitos (Split-Join)**:

XQuery: `consultaListaDepositosGTIn.xq`
```
consultaActivosClienteRequest/CUSTOMER_ID → PV_CUSTOMER_ID
```

**Response DB → OSB (Salida)**:

XQuery: `sjConsultaActivosClienteGTOut.xq`

**Cuentas (Ahorros y Corrientes)**:
```
OutputParametersCuentas/PV_ERROR_CODE → SUCCESS_INDICATOR
OutputParametersCuentas/PV_ASSET_TYPE_OUT → ASSET_TYPE (filtrado por AHO/CHQ)
OutputParametersCuentas/PV_ASSET_NUMBER → ASSET_NUMBER
OutputParametersCuentas/PV_ASSET_NAME → ASSET_NAME
OutputParametersCuentas/PV_ASSET_CURRENCY → ASSET_CURRENCY
OutputParametersCuentas/PV_ASSET_TOTAL_BALANCE → ASSET_TOTAL_BALANCE
OutputParametersCuentas/PV_ASSET_RESERVE_BALANCE → ASSET_RESERVE_BALANCE
OutputParametersCuentas/PV_ASSET_LOCKED_BALANCE → ASSET_LOCKED_BALANCE
OutputParametersCuentas/PV_ASSET_VISA_FLOATING_BALANCE → ASSET_VISA_FLOATING_BALANCE
OutputParametersCuentas/PV_ASSET_AVAILABLE_BALANCE → ASSET_AVAILABLE_BALANCE
OutputParametersCuentas/PV_ASSET_PRODUCT_TYPE → ASSET_PRODUCT_TYPE
Constante "GT01" → ASSET_SOURCE_BANK
```

**Depósitos**:
```
OutputParametersDepositos/PV_ERROR_CODE → SUCCESS_INDICATOR
OutputParametersDepositos/PV_ASSET_TYPE → ASSET_TYPE
OutputParametersDepositos/PV_ASSET_NUMBER → ASSET_NUMBER
OutputParametersDepositos/PV_ASSET_NAME → ASSET_NAME
OutputParametersDepositos/PV_ASSET_CURRENCY → ASSET_CURRENCY
OutputParametersDepositos/PV_ASSET_TOTAL_BALANCE → ASSET_TOTAL_BALANCE
OutputParametersDepositos/PV_ASSET_RESERVE_BALANCE → ASSET_RESERVE_BALANCE
OutputParametersDepositos/PV_ASSET_LOCKED_BALANCE → ASSET_LOCKED_BALANCE
OutputParametersDepositos/PV_ASSET_VISA_FLOATING_BALANCE → ASSET_VISA_FLOATING_BALANCE
OutputParametersDepositos/PV_ASSET_AVAILABLE_BALANCE → ASSET_AVAILABLE_BALANCE
Constante "GT01" → ASSET_SOURCE_BANK
```

#### 2.4. Reglas de Negocio

1. **Enrutamiento por Tipo de Producto**:
   ```
   IF ASSET_TYPE = "AHO" OR "CHQ" OR "CTA" THEN
       → consultaListaCuentas_db
   ELSE IF ASSET_TYPE = "DEP" THEN
       → consultaListaDepositosCliente_db
   ELSE IF ASSET_TYPE = "ALL" THEN
       → sjConsultaActivosCliente (Split-Join: cuentas + depósitos en paralelo)
   ```

2. **Split-Join Flow**:
   - Ejecución paralela de `consultaListaCuentas` y `consultaListaDepositos`
   - Agregación de resultados en XQuery de salida
   - Filtrado por tipo de activo (AHO/CHQ) en la transformación

3. **Función de Mensaje de Respuesta**:
   ```xquery
   IF (SUCCESS AND count > 0) THEN "Success"
   ELSE IF (SUCCESS AND count = 0) OR "NO RECORDS" THEN "No Records"
   ELSE "Error"
   ```

4. **Validación de Funcionalidad Usuario**:
   - Similar a HN01
   - Funcionalidad: `SALDOS_ACTIVOS`
   - Default: "ALL"

#### 2.5. Manejo de Errores

- **Sin validación XSD explícita** en el proxy regional
- **MapeoErrores**: Código FICBCO0043
- **Error Handler**: Heredado del pipeline general

#### 2.6. Políticas y Configuración

- **Timeout**: 0 (sin límite explícito)
- **Retry**: 0 (sin reintentos)
- **Monitoring**: Habilitado (360 min aggregation para BS)
- **Logging**: Debug level

---

### 3. PA01 - Panamá

#### 3.1. Arquitectura

- **Patrón**: Split-Join para ejecución paralela (idéntico a GT01)
- **Backend**: Oracle Database con Stored Procedures
- **Flujo**: Paralelo (cuentas y depósitos simultáneos)

#### 3.2. Endpoints y Conexiones

**Base de Datos Oracle**:
- **Conexión JCA**: `jca://eis/DB/ConnectionProxyAbanksPA`
- **Adapter**: DB Adapter
- **Connection Mode**: Managed
- **Dispatch Policy**: `weblogic.wsee.mdb.DispatchPolicy`

**Stored Procedures**:

1. **Consulta de Cuentas**:
   - **Package**: `OSB_K_CONLISTACUENTAS`
   - **Procedure**: `TOPLEVEL$OSB_P_CON_LISTA_CUEN`
   - **Business Service**: `consultaListaCuentas_db`
   - **Operación**: `consultaListaCuentas`

2. **Consulta de Depósitos**:
   - **Package**: Similar al de cuentas
   - **Procedure**: Para depósitos
   - **Business Service**: `consultaListaDepositosCliente_db`
   - **Operación**: `consultaListaDepositosCliente`

#### 3.3. Mapeos de Datos

**Request OSB → DB (Entrada)**:

XQuery: `sjConsultaActivosClientesPAIn.xq`
```
consultaActivosClienteRequest/CUSTOMER_ID → PV_CUSTOMER_ID
consultaActivosClienteRequest/ASSET_TYPE → PV_ASSET_TYPE
```

**Request OSB → DB Cuentas (Split-Join)**:

XQuery: `consultaListaCuentasPAIn.xq`
```
consultaActivosClienteRequest/CUSTOMER_ID → PV_CUSTOMER_ID
```

**Request OSB → DB Depósitos (Split-Join)**:

XQuery: `consultaListaDepositosPAIn.xq`
```
consultaActivosClienteRequest/CUSTOMER_ID → PV_CUSTOMER_ID
```

**Response DB → OSB (Salida)**:

XQuery: `sjConsultaActivosClientePAOut.xq`

**Mapeo idéntico a GT01**, con la diferencia:
```
Constante "PA01" → ASSET_SOURCE_BANK (en lugar de GT01)
```

#### 3.4. Reglas de Negocio

**Idénticas a GT01**, con las mismas condiciones de enrutamiento y lógica de Split-Join.

#### 3.5. Manejo de Errores

- **Sin validación XSD explícita** en el proxy regional
- **MapeoErrores**: Código FICBCO0043
- **Error Handler**: Heredado del pipeline general

#### 3.6. Políticas y Configuración

- **Timeout**: 0 (sin límite explícito)
- **Retry**: 1 (un reintento configurado)
- **Monitoring**: Habilitado (10 min aggregation para BS)
- **Logging**: Debug level
- **Dispatch Policy**: Configurado (diferencia con GT01)

---

### 4. NI01 - Nicaragua

#### 4.1. Arquitectura

- **Patrón**: Invocación directa a servicio externo
- **Backend**: Cobis CTS (Core Transaction System)
- **Flujo**: Llamada única a web service

#### 4.2. Endpoints y Conexiones

**Web Service Cobis CTS**:
- **Business Service**: `activos` (CTS)
- **Operación**: `OpConsultaActivosCliente`
- **Protocolo**: SOAP
- **Namespace**: `http://service.srvaplcobisactivos.ecobis.cobiscorp`

**No utiliza base de datos directamente**, toda la lógica está en el servicio Cobis.

#### 4.3. Mapeos de Datos

**Request OSB → Cobis (Entrada)**:

XQuery: `consultaActivosClienteNIIn.xq`
```
consultaActivosClienteRequest/CUSTOMER_ID → cliente/codCliente
consultaActivosClienteRequest/ASSET_TYPE → producto/codTipoProducto
header/Authentication/UserName → cliente/valIdCliente
Constante "1" → contextoTransaccional/codCanalOriginador
```

**Response Cobis → OSB (Salida)**:

XQuery: `consultaActivosClienteNIOut.xq`

**Ahorros (AHO)**:
```
contextoRespuesta/codTipoRespuesta → SUCCESS_INDICATOR
activos[cuenta/codTipoProducto = 'AHO']/cuenta/codCuentaHabiente → ASSET_NUMBER
activos/cuenta/valTipoProducto → ASSET_NAME
activos/cuenta/moneda/valSimboloMoneda → ASSET_CURRENCY
activos/cuenta/valSaldoTotal → ASSET_TOTAL_BALANCE (round-half-to-even, 2 decimales)
activos/cuentaReserva/montoReserva → ASSET_RESERVE_BALANCE (round-half-to-even, 2 decimales)
activos/cuenta/valMontoBloqueado → ASSET_LOCKED_BALANCE (round-half-to-even, 2 decimales)
activos/valBalanceFlotante → ASSET_VISA_FLOATING_BALANCE (round-half-to-even, 2 decimales)
activos/cuenta/valSaldoDisponible → ASSET_AVAILABLE_BALANCE (round-half-to-even, 2 decimales)
activos/cuenta/codigoIBAN → INTERNATIONAL_ACCOUNT_NUMBER
Constante "AHO" → ASSET_TYPE
```

**Corrientes (CTE → CHQ)**:
```
activos[cuenta/codTipoProducto = 'CTE'] → Filtro
Mapeo similar a ahorros
Constante "CHQ" → ASSET_TYPE (transformación de CTE a CHQ)
```

**Depósitos (PFI → DEP)**:
```
activos[cuenta/codTipoProducto = 'PFI'] → Filtro
Mapeo similar a ahorros
Constante "DEP" → ASSET_TYPE (transformación de PFI a DEP)
```

#### 4.4. Reglas de Negocio

1. **Invocación Única**:
   - Una sola llamada al servicio Cobis
   - El servicio devuelve todos los tipos de activos
   - Filtrado por tipo en la transformación XQuery

2. **Transformación de Tipos de Producto**:
   - Cobis usa códigos internos: AHO, CTE, PFI
   - OSB normaliza a: AHO, CHQ, DEP
   - Mapeo en XQuery de salida

3. **Redondeo de Montos**:
   - Todos los montos se redondean a 2 decimales
   - Función: `fn:round-half-to-even(valor, 2)`

4. **Función de Mensaje de Respuesta**:
   ```xquery
   IF ((SUCCESS OR codTipoRespuesta = '0') AND count > 0) THEN "Success"
   ELSE IF ((SUCCESS OR '0') AND count = 0) OR "NO RECORDS" THEN "No Records"
   ELSE "Error"
   ```

5. **Campo Único: IBAN**:
   - Nicaragua es la única región que devuelve `INTERNATIONAL_ACCOUNT_NUMBER`
   - Campo: `codigoIBAN` de Cobis

6. **Sin Validación de Funcionalidad Usuario**:
   - No se invoca `ValidaFuncionalidadUsuario`
   - Todos los saldos se muestran siempre

#### 4.5. Manejo de Errores

- **Validación XSD**: Sí, valida request contra esquema Cobis
- **MapeoErrores**: Código FICBCO0043
- **Manejo de respuesta vacía**: Si error, devuelve response vacío

#### 4.6. Políticas y Configuración

- **Timeout**: No especificado
- **Retry**: No especificado
- **Monitoring**: No especificado explícitamente
- **Logging**: Heredado del proxy principal

---

## Diferencias Clave entre Regiones

### Arquitectura y Tecnología

| Aspecto | HN01 | GT01 | PA01 | NI01 |
|---------|------|------|------|------|
| **Patrón de Integración** | Múltiples servicios secuenciales | Split-Join paralelo | Split-Join paralelo | Servicio único |
| **Tecnología Backend** | Híbrida (T24 + Oracle + OSB12c) | Oracle DB | Oracle DB | Cobis Web Service |
| **Complejidad** | Alta | Media | Media | Baja |

### Funcionalidades Únicas

| Funcionalidad | HN01 | GT01 | PA01 | NI01 |
|---------------|------|------|------|------|
| **Fondos de Pensiones** | ✅ | ❌ | ❌ | ❌ |
| **IBAN** | ❌ | ❌ | ❌ | ✅ |
| **Validación Usuario** | ✅ | ✅ | ✅ | ❌ |
| **Consulta Cliente Previa** | ✅ | ❌ | ❌ | ❌ |

### Rendimiento y Configuración

| Aspecto | HN01 | GT01 | PA01 | NI01 |
|---------|------|------|------|------|
| **Ejecución Paralela** | ❌ | ✅ | ✅ | N/A |
| **Retry Configurado** | No | 0 | 1 | No |
| **Timeout** | No especificado | 0 | 0 | No especificado |
| **Validación XSD** | ✅ | ❌ | ❌ | ✅ |

### Campos de Respuesta

| Campo | HN01 | GT01 | PA01 | NI01 |
|-------|------|------|------|------|
| `ASSET_SOURCE_BANK` | ❌ | ✅ (GT01) | ✅ (PA01) | ❌ |
| `ASSET_PRODUCT_TYPE` | ✅ | ✅ | ✅ | ❌ |
| `INTERNATIONAL_ACCOUNT_NUMBER` | ❌ | ❌ | ❌ | ✅ |

---

## Recomendaciones de Estandarización

1. **Unificar Validación XSD**: Aplicar en todas las regiones
2. **Estandarizar Timeouts**: Definir valores consistentes
3. **Normalizar Retry**: Configurar política uniforme
4. **Campos Comunes**: Incluir `ASSET_SOURCE_BANK` en todas las regiones
5. **Monitoreo**: Alinear intervalos de agregación
6. **Logging**: Considerar nivel INFO en producción (actualmente DEBUG)
7. **Autenticación**: Evaluar modelo de seguridad consistente

---

**Conclusión**: Las cuatro regiones tienen implementaciones significativamente diferentes, reflejando la heterogeneidad de los sistemas bancarios en cada país. La migración debe considerar estas diferencias y evaluar oportunidades de estandarización sin comprometer funcionalidades regionales específicas.
