# Comparativa entre Regiones - Redención de Puntos de Lealtad

## Tabla de Comparación General

| Aspecto | HN01 (Honduras) | GT01 (Guatemala) | PA01 (Panamá) | NI01 (Nicaragua) |
|---------|-----------------|------------------|---------------|------------------|
| **Endpoint OSB** | RedencionPuntosLealtadHN.proxy | RedencionPuntosLealtadGT.proxy | RedencionPuntosLealtadPA.proxy | RedencionPuntosLealtadNI.proxy |
| **Base de Datos Principal** | ABK, MasterDataHN, ProcesosHN | ABKGT, MasterDataGT | PXYNIC, MasterDataPA | PXYNIC, SJS |
| **Esquemas DB** | ABK, MASTERDATA_HN, PROCESOS_HN | ABKGT, MASTERDATA_GT | PXYNIC, MASTERDATA_PA | PXYNIC, SJS |
| **SP Conversión Puntos** | ABK.canjearPuntosEfectivo | ABKGT.canjearPuntosEfectivo | PXYNIC.canjearPuntosEfectivo | PXYNIC.canjearPuntosEfectivo |
| **SP Consulta Info Cliente** | PROCESOS_HN.conInfoLealtad | MASTERDATA_GT.conDatoCuenta | MASTERDATA_PA.conDatoCuenta | SJS.sjConsultaTipoTarjeta |
| **SP Programa Lealtad** | INTFC.consultaProgramaLealtad | INTFC.consultaProgramaLealtad | INTFC.consultaProgramaLealtad | INTFC.consultaProgramaLealtad, INTFC.obtenerTipoProgramaLealtad |
| **SP Registro Transacción** | MASTERDATA.INSTransaccionRedencion | MASTERDATA.INSTransaccionRedencion | No aplica | No aplica |
| **Conexión Mastercard** | RedemptionService | RedemptionService | RedemptionService | RedemptionService |
| **Conexión VisionPlus** | visionPlus (PointsRedeem, PointsAdjustmentInquiry) | visionPlus (PointsRedeem) | visionPlus (PointsRedeem) | visionPlus (PointsRedeem) |
| **Tipos ID Soportados** | CARD_NUMBER, CUSTOMER_ID, LEGAL_ID | CARD_NUMBER | CARD_NUMBER | CARD_NUMBER |
| **Validación Estado Tarjeta** | No | No | No | Sí (ACTIVE) |
| **Consulta Saldo Post-Redención** | Sí (Programa 2) | No | No | No |
| **Transformaciones XQuery** | conInfoLealtadHNIn, canjearPuntosEfectivoHNIn, redencionPuntosLealtadHNOut | canjearPuntosEfectivoGTIn, redencionPuntosLealtadGTOut | conversionPuntosNIIn, redencionPuntosLealtadNIOut | conversionPuntosNIIn, consultaTipoTarjetaNIIn, redencionPuntosLealtadNIOut |
| **Campos Diferenciadores** | Soporta múltiples tipos ID, consulta saldo restante | Solo CARD_NUMBER, sin saldo restante | Solo CARD_NUMBER, sin saldo restante, sin registro transacción | Solo CARD_NUMBER, valida estado tarjeta, usa timestamp para redemptionId |
| **Manejo Errores** | MapeoErrores centralizado | MapeoErrores centralizado | MapeoErrores centralizado | MapeoErrores centralizado |
| **Timeouts/Retries** | Configurado en Business Services | Configurado en Business Services | Configurado en Business Services | Configurado en Business Services |
| **Dependencias Internas** | T24, Alcance, Mastercard, VisionPlus | VisionPlus, Mastercard | VisionPlus, Mastercard | VisionPlus, Mastercard |

---

## Detalle por Región

### 1. HN01 - Honduras

#### 1.1. Características Principales

- **Implementación más completa** con soporte para múltiples tipos de identificación
- Soporta consulta de saldo restante después de redención (Programa 2)
- Integración con T24 Core Banking y Alcance para consulta de información de cliente

#### 1.2. Endpoints y Conexiones

**Proxy Service**: `Middleware/v2/ProxyServices/RedencionPuntosLealtadHN.proxy`

**Business Services**:
- `Middleware/v2/BusinessServices/ABK/canjearPuntosEfectivo/biz/canjearPuntosEfectivo_db`
- `Middleware/v2/BusinessServices/ProcesosHN/conInfoLealtad/biz/conInfoLealtad_db`
- `Middleware/v2/BusinessServices/MasterDataHN/conDatoCuenta/biz/conDatoCuenta_db`
- `Middleware/v2/BusinessServices/INTFC/consultaProgramaLealtad/biz/consultaProgramaLealtad_db`
- `Middleware/v2/BusinessServices/MasterData/iNSTransaccionRedencion/biz/INSTransaccionRedencion_db`
- `Middleware/v2/BusinessServices/Mastercard/RedemptionService/biz/RedemptionService`
- `Middleware/v2/BusinessServices/VisionPlus/visionPlus/biz/visionPlus`
- `Middleware/Business_Resources/consultasCliente/Resources/consultasClienteBS` (T24)
- `Middleware/Business_Resources/tarjetasDebito/Resources/tarjetasDebitoBS` (T24)
- `Middleware/v2/BusinessServices/transaccionesAlcance/biz/transaccionesAlcance`
- `Middleware/v2/BusinessServices/SJS/consultaTipoTarjeta/biz/sjConsultaTipoTarjeta`

#### 1.3. Stored Procedures

| SP | Esquema | Parámetros Entrada | Parámetros Salida |
|----|---------|-------------------|-------------------|
| `canjearPuntosEfectivo` | ABK | PN_TIPOCONVERSION, PN_MONTOCONVERSION, PV_LOGO, PV_TERMINALID, PV_MERCHANTTYPE, PV_MERCHANTNUMBER | PN_VALORSALIDA, PV_CODIGOMENSAJE, PV_DESCRIPCIONMENSAJE |
| `conInfoLealtad` | PROCESOS_HN | PV_COUNTRY, PV_CARDNUMBER | CodigoError, MensajeError, RowSet (legalId, customerName, cardType, logo) |
| `conDatoCuenta` | MASTERDATA_HN | PV_ACCOUNTNUMBER, PV_COUNTRYCODE, PV_ORG | CodigoError, MensajeError, RowSet (CUST_NBR, TipoOrg, LMS_SCHEME, LMS_ACC, ORG) |
| `consultaProgramaLealtad` | INTFC | PV_LOGO, PV_CODIGOPAIS | PV_CODIGOMENSAJE, PV_DESCRIPCIONMENSAJE, PV_CODIGOLEALTAD |
| `INSTransaccionRedencion` | MASTERDATA | PV_CARDNUMBER, PN_AMOUNT, PV_MERCHANT, PV_DESCRIPTION, PV_SERVICEID, PV_CHANNELID, PV_COUNTRYCODE | CodigoError, MensajeError, IDTransaccion |

#### 1.4. Reglas de Negocio Específicas

1. **Consulta de Información de Cliente**:
   - Si `CUSTOMER_ID_TYPE = "CUSTOMER_ID"`: Consulta T24 con `Consultadecliente`
   - Si `CUSTOMER_ID_TYPE = "CARD_NUMBER"`:
     - Consulta tipo de tarjeta con `sjConsultaTipoTarjeta`
     - Si es DEBIT: Consulta `ConsultaMaestraTarjetaDebito` en T24
     - Si es CREDIT: Consulta `InformacionTarjeta` en Alcance
   - Si `CUSTOMER_ID_TYPE = "LEGAL_ID"`: Consulta T24 con `Consultadecliente` por legal ID

2. **Determinación de Programa de Lealtad**:
   - Tarjetas DEBIT: Programa 1 (Mastercard)
   - Tarjetas CREDIT: Consulta `consultaProgramaLealtad` por logo

3. **Conversión de Puntos a Efectivo**:
   - XQuery: `canjearPuntosEfectivoHNIn.xq`
   - Parámetros: logo, tipoConversion='2', conversionAmount, terminalId, merchantType, merchantNumber

4. **Redención Programa 1 (Mastercard)**:
   - Genera header MRSIdentity con institutionName y legalId
   - Invoca `doItemRedemption` con matrixId y cantidad de puntos
   - Retorna `pointTotalRemaining` y `redemptionId`

5. **Redención Programa 2 (VisionPlus)**:
   - Registra transacción con `INSTransaccionRedencion`
   - Invoca `PointsRedeem` con datos de cuenta desde `conDatoCuenta`
   - Consulta saldo con `PointsAdjustmentInquiry` (accountNumber, org, scheme)
   - Retorna `pointTotalRemaining` calculado

#### 1.5. Mapeos de Datos

**Request OSB → conInfoLealtad**:
- `CUSTOMER_ID_VALUE` → `PV_CARDNUMBER`
- `RequestHeader/Region/SourceBank` (convertido a ISO3) → `PV_COUNTRY`

**conInfoLealtad → Variables**:
- `RowSet/Row/Column[@name='legalId']` → `$legalId`
- `RowSet/Row/Column[@name='customerName']` → `$customerName`
- `RowSet/Row/Column[@name='cardType']` → `$cardType`
- `RowSet/Row/Column[@name='logo']` → `$logo`

**Request OSB → doItemRedemption (Mastercard)**:
- `$totalPoints` → `quantity`
- `$matrixId` → `rewardMatrixItemId`
- `$legalId` → MRSIdentity header `appID`
- `$institutionName` → MRSIdentity header `institutionName`

---

### 2. GT01 - Guatemala

#### 2.1. Características Principales

- Implementación simplificada, solo soporta `CARD_NUMBER`
- No consulta saldo restante después de redención
- Registra transacción en base de datos para Programa 2

#### 2.2. Endpoints y Conexiones

**Proxy Service**: `Middleware/v2/ProxyServices/RedencionPuntosLealtadGT.proxy`

**Business Services**:
- `Middleware/v2/BusinessServices/ABKGT/canjearPuntosEfectivo/biz/canjearPuntosEfectivo_db`
- `Middleware/v2/BusinessServices/MasterDataGT/conDatoCuenta/biz/conDatoCuenta_db`
- `Middleware/v2/BusinessServices/INTFC/consultaProgramaLealtad/biz/consultaProgramaLealtad_db`
- `Middleware/v2/BusinessServices/MasterData/iNSTransaccionRedencion/biz/INSTransaccionRedencion_db`
- `Middleware/v2/BusinessServices/Mastercard/RedemptionService/biz/RedemptionService`
- `Middleware/v2/BusinessServices/VisionPlus/visionPlus/biz/visionPlus`

#### 2.3. Stored Procedures

| SP | Esquema | Parámetros Entrada | Parámetros Salida |
|----|---------|-------------------|-------------------|
| `canjearPuntosEfectivo` | ABKGT | PN_TIPOCONVERSION, PN_MONTOCONVERSION, PV_LOGO, PV_TERMINALID, PV_MERCHANTTYPE, PV_MERCHANTNUMBER | PN_VALORSALIDA, PV_CODIGOMENSAJE, PV_DESCRIPCIONMENSAJE |
| `conDatoCuenta` | MASTERDATA_GT | PV_ACCOUNTNUMBER, PV_COUNTRYCODE, PV_ORG | CodigoError, MensajeError, RowSet (CUST_NBR, logo, nombre_cliente, legal_id, TipoOrg) |
| `consultaProgramaLealtad` | INTFC | PV_LOGO, PV_CODIGOPAIS | PV_CODIGOMENSAJE, PV_DESCRIPCIONMENSAJE, PV_CODIGOLEALTAD |
| `INSTransaccionRedencion` | MASTERDATA | PV_CARDNUMBER, PN_AMOUNT, PV_MERCHANT | CodigoError, MensajeError, IDTransaccion |

#### 2.4. Reglas de Negocio Específicas

1. **Validación de Entrada**: Solo acepta `CUSTOMER_ID_TYPE = "CARD_NUMBER"`

2. **Consulta de Datos de Cuenta**:
   - Invoca `conDatoCuenta` con número de tarjeta
   - Filtra registro con `TipoOrg = 'BASE'`
   - Extrae: logo, customerId, customerName, legalId

3. **Conversión de Puntos**:
   - XQuery: `canjearPuntosEfectivoGTIn.xq`
   - Similar a HN01 pero con estructura específica de GT

4. **Registro de Transacción**:
   - XQuery: `insTransaccionRedencion.xq`
   - Parámetros: numeroTarjeta, monto, comercio

5. **Redención Programa 2**:
   - Invoca `PointsRedeem` con datos de `conDatoCuenta`
   - No consulta saldo restante

#### 2.5. Diferencias con HN01

- No soporta CUSTOMER_ID ni LEGAL_ID
- No consulta información desde T24 o Alcance
- No consulta saldo restante después de redención
- Usa `conDatoCuenta` como única fuente de información de cliente

---

### 3. PA01 - Panamá

#### 3.1. Características Principales

- Implementación similar a GT01
- No registra transacción en base de datos
- Genera `redemptionId` con timestamp para Programa 2

#### 3.2. Endpoints y Conexiones

**Proxy Service**: `Middleware/v2/ProxyServices/RedencionPuntosLealtadPA.proxy`

**Business Services**:
- `Middleware/v2/BusinessServices/PXYNIC/canjearPuntosEfectivo/biz/canjearPuntosEfectivo_db`
- `Middleware/v2/BusinessServices/MasterDataPA/conDatoCuenta/biz/conDatoCuenta_db`
- `Middleware/v2/BusinessServices/INTFC/consultaProgramaLealtad/biz/consultaProgramaLealtad_db`
- `Middleware/v2/BusinessServices/Mastercard/RedemptionService/biz/RedemptionService`
- `Middleware/v2/BusinessServices/VisionPlus/visionPlus/biz/visionPlus`

#### 3.3. Stored Procedures

| SP | Esquema | Parámetros Entrada | Parámetros Salida |
|----|---------|-------------------|-------------------|
| `canjearPuntosEfectivo` | PXYNIC | PN_TIPOCONVERSION, PN_MONTOCONVERSION, PV_LOGO, PV_TERMINALID, PV_MERCHANTTYPE, PV_MERCHANTNUMBER | PN_VALORSALIDA, PV_CODIGOMENSAJE, PV_DESCRIPCIONMENSAJE |
| `conDatoCuenta` | MASTERDATA_PA | PV_ACCOUNTNUMBER, PV_COUNTRYCODE, PV_ORG | CodigoError, MensajeError, RowSet (CUST_NBR, logo, nombre_cliente, legal_id) |
| `consultaProgramaLealtad` | INTFC | PV_LOGO, PV_CODIGOPAIS | PV_CODIGOMENSAJE, PV_DESCRIPCIONMENSAJE, PV_CODIGOLEALTAD |

#### 3.4. Reglas de Negocio Específicas

1. **Validación de Entrada**: Solo acepta `CUSTOMER_ID_TYPE = "CARD_NUMBER"`

2. **Conversión de Puntos**:
   - XQuery: `conversionPuntosNIIn.xq` (reutiliza el de Nicaragua)

3. **Generación de Redemption ID**:
   - Programa 2: `fn-bea:dateTime-to-string-with-format('yyyyMMddHHmmssSSS', adjust-dateTime-to-timezone(fn:current-dateTime(), ()))`
   - Formato: yyyyMMddHHmmssSSS

#### 3.5. Diferencias con GT01

- No registra transacción con `INSTransaccionRedencion`
- Genera redemptionId con timestamp en lugar de obtenerlo de BD
- Usa esquema PXYNIC en lugar de ABKGT

---

### 4. NI01 - Nicaragua

#### 4.1. Características Principales

- Validación adicional de estado de tarjeta (debe estar ACTIVE)
- Usa `sjConsultaTipoTarjetaNI` para obtener información completa
- Soporta `obtenerTipoProgramaLealtad` para tarjetas débito
- Genera `redemptionId` con timestamp

#### 4.2. Endpoints y Conexiones

**Proxy Service**: `Middleware/v2/ProxyServices/RedencionPuntosLealtadNI.proxy`

**Business Services**:
- `Middleware/v2/BusinessServices/PXYNIC/canjearPuntosEfectivo/biz/canjearPuntosEfectivo_db`
- `Middleware/v2/BusinessServices/SJS/consultaTipoTarjetaNI/biz/sjConsultaTipoTarjetaNI`
- `Middleware/v2/BusinessServices/INTFC/consultaProgramaLealtad/biz/consultaProgramaLealtad_db`
- `Middleware/v2/BusinessServices/INTFC/obtenerTipoProgramaLealtad/biz/obtenerTipoProgramaLealtad_db`
- `Middleware/v2/BusinessServices/Mastercard/RedemptionService/biz/RedemptionService`
- `Middleware/v2/BusinessServices/VisionPlus/visionPlus/biz/visionPlus`

#### 4.3. Stored Procedures

| SP | Esquema | Parámetros Entrada | Parámetros Salida |
|----|---------|-------------------|-------------------|
| `canjearPuntosEfectivo` | PXYNIC | PN_TIPOCONVERSION, PN_MONTOCONVERSION, PV_LOGO, PV_TERMINALID, PV_MERCHANTTYPE, PV_MERCHANTNUMBER | PN_VALORSALIDA, PV_CODIGOMENSAJE, PV_DESCRIPCIONMENSAJE |
| `sjConsultaTipoTarjeta` | SJS | CARD_NUMBER, OPERATION | SUCCESS_INDICATOR, ERROR_MESSAGE, LOGO, CUSTOMER_ID, CUSTOMER_NAME, LEGAL_ID, CARD_TYPE, CARD_STATUS |
| `consultaProgramaLealtad` | INTFC | PV_LOGO, PV_CODIGOPAIS | PV_CODIGOMENSAJE, PV_DESCRIPCIONMENSAJE, PV_CODIGOLEALTAD |
| `obtenerTipoProgramaLealtad` | INTFC | PV_PRODUCTO, PV_GRUPOAFINIDAD, PV_BIN | PV_CODIGO_ERROR, PV_MENSAJE_ERROR, PN_PROGRAMA_LEALTAD |

#### 4.4. Reglas de Negocio Específicas

1. **Validación de Entrada**: Solo acepta `CUSTOMER_ID_TYPE = "CARD_NUMBER"`

2. **Consulta de Tipo de Tarjeta**:
   - Invoca `sjConsultaTipoTarjeta` con número de tarjeta
   - Obtiene: LOGO, CUSTOMER_ID, CUSTOMER_NAME, LEGAL_ID, CARD_TYPE, CARD_STATUS
   - **Validación crítica**: `CARD_STATUS = 'ACTIVE'`

3. **Determinación de Programa**:
   - Si `CARD_TYPE = "DEBIT"` y `CARD_STATUS = "ACTIVE"`:
     - Extrae BIN (primeros 6 dígitos)
     - Invoca `obtenerTipoProgramaLealtad` con producto='TD0000', grupoAfinidad='000', bin
     - Obtiene `PN_PROGRAMA_LEALTAD`
   - Si `CARD_TYPE = "CREDIT"`:
     - Invoca `consultaProgramaLealtad` por logo

4. **Conversión de Puntos**:
   - XQuery: `conversionPuntosNIIn.xq`
   - Si logo está vacío, usa binNumber

5. **Redención**:
   - Programa 1: Usa customerId con padding a 19 caracteres
   - Programa 2: Usa datos de `sjConsultaTipoTarjeta`

#### 4.5. Diferencias con Otras Regiones

- **Única región que valida estado de tarjeta**
- Usa `sjConsultaTipoTarjetaNI` como fuente única de información
- Soporta `obtenerTipoProgramaLealtad` para tarjetas débito
- No registra transacción en base de datos
- Genera redemptionId con timestamp

---

## Resumen de Diferencias Críticas

### Validaciones de Entrada

| Región | CUSTOMER_ID | LEGAL_ID | CARD_NUMBER | Estado Tarjeta |
|--------|-------------|----------|-------------|----------------|
| HN01 | ✅ | ✅ | ✅ | ❌ |
| GT01 | ❌ | ❌ | ✅ | ❌ |
| PA01 | ❌ | ❌ | ✅ | ❌ |
| NI01 | ❌ | ❌ | ✅ | ✅ (ACTIVE) |

### Fuentes de Información de Cliente

| Región | Fuente Principal | Fuentes Secundarias |
|--------|------------------|---------------------|
| HN01 | conInfoLealtad | T24 (Consultadecliente, ConsultaMaestraTarjetaDebito), Alcance (InformacionTarjeta), sjConsultaTipoTarjeta |
| GT01 | conDatoCuenta | Ninguna |
| PA01 | conDatoCuenta | Ninguna |
| NI01 | sjConsultaTipoTarjetaNI | obtenerTipoProgramaLealtad |

### Registro de Transacciones

| Región | Programa 1 | Programa 2 |
|--------|-----------|-----------|
| HN01 | Mastercard genera ID | INSTransaccionRedencion |
| GT01 | Mastercard genera ID | INSTransaccionRedencion |
| PA01 | Mastercard genera ID | Timestamp |
| NI01 | Mastercard genera ID | Timestamp |

### Consulta de Saldo Restante

| Región | Programa 1 | Programa 2 |
|--------|-----------|-----------|
| HN01 | Mastercard retorna | PointsAdjustmentInquiry |
| GT01 | Mastercard retorna | No consulta |
| PA01 | Mastercard retorna | No consulta |
| NI01 | Mastercard retorna | No consulta |

---

**Conclusión**: HN01 tiene la implementación más completa y robusta, mientras que las demás regiones tienen implementaciones simplificadas con funcionalidad reducida.
