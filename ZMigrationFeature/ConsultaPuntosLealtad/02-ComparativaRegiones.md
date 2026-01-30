# Comparativa entre Regiones - ConsultaPuntosLealtad

## Tabla de Comparación General

| Aspecto | HN01 (Honduras) | GT01 (Guatemala) | NI01 (Nicaragua) | PA01 (Panamá) |
|---------|-----------------|------------------|------------------|---------------|
| **Endpoint OSB** | ConsultaPuntosLealtadHN.proxy | ConsultaPuntosLealtadGT.proxy | ConsultaPuntosLealtadNI.proxy | ConsultaPuntosLealtadPA.proxy |
| **Base de Datos** | CLIENTDATA | CLIENTDATA | CLIENTDATA | CLIENTDATA |
| **Esquema** | CLIENTDATA | CLIENTDATA | CLIENTDATA | CLIENTDATA |
| **Stored Procedure** | CONSULTA_PUNTOS_LEALTAD | CONSULTA_PUNTOS_LEALTAD | CONSULTA_PUNTOS_LEALTAD | CONSULTA_PUNTOS_LEALTAD |
| **Conexión BD** | eis/DB/ConnectionClientdata | eis/DB/ConnectionClientdata | eis/DB/ConnectionClientdata | eis/DB/ConnectionClientdata |
| **Servicio Datos Maestros** | conDatoCuenta_db (MasterDataHN) | conDatoCuenta_db (MasterDataGT) | sjConsultaTipoTarjetaNI (SJS) | conDatoCuenta_db (MasterDataPA) |
| **Tipo Servicio Maestros** | DB Adapter | DB Adapter | Java Service (SOAP) | DB Adapter |
| **Moneda** | HNL (Lempira) | GTQ (Quetzal) | USD (Dólar) | USD (Dólar) |
| **Programa Lealtad 1** | Mastercard Rewards (MRS) | Mastercard Rewards (MRS) | Mastercard Rewards (MRS) | Mastercard Rewards (MRS) |
| **Programa Lealtad 2** | Vision Plus | Vision Plus | Vision Plus | Vision Plus |
| **Operación MRS** | getPointDetails | getRTRPreferences | getPointDetails | getPointDetails |
| **Servicio Conversión** | canjearPuntosEfectivo_db (ABK) | canjearPuntosEfectivo_db (ABKGT) | canjearPuntosEfectivo_db (PXYNIC) | canjearPuntosEfectivo_db (PXYNIC) |
| **Validación Tarjeta Débito** | Por tipo de tarjeta | No específica | Por estado (ACTIVE) + BIN | No específica |
| **Identificador MRS AppID** | legalId | NIT (driver_lic) | customerId (19 dígitos) | legalId |
| **Registro Datos Maestros** | TipoOrg = BASE | TipoOrg = BASE | TipoOrg = BASE | TipoOrg = ALT o BASE |

---

## Detalle por Región

### 1. HONDURAS (HN01)

#### Endpoints y Configuración

**Proxy Service:**
- Ruta: `Middleware/v2/ProxyServices/ConsultaPuntosLealtadHN.proxy`
- WSDL: `Middleware/v2/Resources/ConsultaPuntosLealtad/wsdl/consultaPuntosLealtadPS.wsdl`
- Binding: SOAP 1.1
- Logging: Debug habilitado

#### Transformaciones Clave

**XQuery de Entrada:**
- `consultaPuntosLealtadIn.xq`: Mapeo request OSB → SP
- `conInfoLealtadHNIn.xq`: Consulta información de lealtad por tarjeta
- `consultaProgramaLealtadIn.xq`: Determina programa de lealtad
- `getPointDetailsIn.xq`: Request a Mastercard (Programa 1)
- `pointsAdjustmentInquiryIn.xq`: Request a Vision Plus (Programa 2)
- `canjearPuntosEfectivoHNIn.xq`: Cálculo equivalencia efectivo

**XQuery de Salida:**
- `consultaPuntosLealtadHNOut.xq`: Mapeo respuesta → OSB

#### Campos Diferenciadores

1. **Consulta Información Cliente (si no hay datos en BD):**
   - Usa servicio específico: `conInfoLealtad_db` (ProcesosHN)
   - Convierte código país a ISO3
   - Extrae: legalId, customerName, cardType, grupoAfinidad (logo)

2. **Determinación Programa Lealtad:**
   - Tarjeta DEBIT: Programa 1 (MRS) automático
   - Tarjeta CREDIT: Consulta `consultaProgramaLealtad_db` por logo
   - Soporte para logo Infinite (625) con PROGRAM_ID del request

3. **Consulta Mastercard (Programa 1):**
   - AppID: legalId del cliente
   - Operación: `getPointDetails`

4. **Equivalencia en Efectivo:**
   - Servicio: ABK schema
   - Parámetros: logo, conversionAmount, conversionType=1, terminalId, merchantType, merchantNumber
   - Moneda: HNL

#### Validaciones y Errores

- Validación XSD del request
- Error si CUSTOMER_ID_TYPE no es "CARD_NUMBER"
- Error si programa de lealtad no es 1 o 2
- Manejo de errores de servicios externos

#### Dependencias Internas

- `Middleware/v2/BusinessServices/ProcesosHN/conInfoLealtad/biz/conInfoLealtad_db`
- `Middleware/v2/BusinessServices/INTFC/consultaProgramaLealtad/biz/consultaProgramaLealtad_db`
- `Middleware/v2/BusinessServices/Mastercard/CustomerService/biz/CustomerService`
- `Middleware/v2/BusinessServices/VisionPlus/visionPlus/biz/visionPlus`
- `Middleware/v2/BusinessServices/ABK/canjearPuntosEfectivo/biz/canjearPuntosEfectivo_db`
- `Middleware/Business_Resources/general/Resources/ObtenerParametrizacion/ObtenerParametrizacion`
- `Middleware/v2/BusinessServices/CLIENTDATA/registraPuntosLealtad/biz/registraPuntosLealtad_db`

---

### 2. GUATEMALA (GT01)

#### Endpoints y Configuración

**Proxy Service:**
- Ruta: `Middleware/v2/ProxyServices/ConsultaPuntosLealtadGT.proxy`
- WSDL: `Middleware/v2/Resources/ConsultaPuntosLealtad/wsdl/consultaPuntosLealtadPS.wsdl`
- Binding: SOAP 1.1
- Logging: Debug habilitado

#### Transformaciones Clave

**XQuery de Entrada:**
- `consultaPuntosLealtadIn.xq`: Mapeo request OSB → SP
- `conDatoCuentaGTIn.xq`: Consulta datos de cuenta Guatemala
- `consultaProgramaLealtadIn.xq`: Determina programa de lealtad
- `getPointDetailsInGT.xq`: Request a Mastercard (Programa 1)
- `pointsAdjustmentInquiryIn.xq`: Request a Vision Plus (Programa 2)
- `canjearPuntosEfectivoGTIn.xq`: Cálculo equivalencia efectivo

**XQuery de Salida:**
- `consultaPuntosLealtadGTOut.xq`: Mapeo respuesta → OSB

#### Campos Diferenciadores

1. **Consulta Información Cliente (si no hay datos en BD):**
   - Usa servicio: `conDatoCuenta_db` (MasterDataGT)
   - Convierte código país a ISO3
   - Extrae de registro BASE: customerId, customerName, legalId, logo, org, accountNumber, scheme, NIT (driver_lic)

2. **Determinación Programa Lealtad:**
   - Valida que logo no esté vacío
   - Consulta `consultaProgramaLealtad_db` por logo y código país
   - No hay lógica especial para tarjetas débito

3. **Consulta Mastercard (Programa 1):**
   - AppID: NIT (driver_lic) del cliente
   - Operación: `getRTRPreferences` (diferente a otras regiones)

4. **Equivalencia en Efectivo:**
   - Servicio: ABKGT schema
   - Parámetros: logo, tipoConversion=1, montoConversion, cashRedemptionType
   - Moneda: GTQ

#### Validaciones y Errores

- Validación XSD del request
- Validación XSD del request a conDatoCuenta
- Error si logo está vacío
- Error si CUSTOMER_ID_TYPE no es "CARD_NUMBER"
- Error si programa de lealtad no es 1 o 2

#### Dependencias Internas

- `Middleware/v2/BusinessServices/MasterDataGT/conDatoCuenta/biz/conDatoCuenta_db`
- `Middleware/v2/BusinessServices/INTFC/consultaProgramaLealtad/biz/consultaProgramaLealtad_db`
- `Middleware/v2/BusinessServices/Mastercard/CustomerService/biz/CustomerService`
- `Middleware/v2/BusinessServices/VisionPlus/visionPlus/biz/visionPlus`
- `Middleware/v2/BusinessServices/ABKGT/canjearPuntosEfectivo/biz/canjearPuntosEfectivo_db`
- `Middleware/Business_Resources/general/Resources/ObtenerParametrizacion/ObtenerParametrizacion`
- `Middleware/v2/BusinessServices/CLIENTDATA/registraPuntosLealtad/biz/registraPuntosLealtad_db`

---

### 3. NICARAGUA (NI01)

#### Endpoints y Configuración

**Proxy Service:**
- Ruta: `Middleware/v2/ProxyServices/ConsultaPuntosLealtadNI.proxy`
- WSDL: `Middleware/v2/Resources/ConsultaPuntosLealtad/wsdl/consultaPuntosLealtadPS.wsdl`
- Binding: SOAP 1.1
- Logging: Debug habilitado

#### Transformaciones Clave

**XQuery de Entrada:**
- `consultaPuntosLealtadIn.xq`: Mapeo request OSB → SP
- `consultaTipoTarjetaNIIn.xq`: Consulta tipo de tarjeta (Java Service)
- `obtenerTipoProgramaLealtadIn.xq`: Obtiene programa por BIN (solo débito)
- `consultaProgramaLealtadIn.xq`: Determina programa de lealtad (crédito)
- `getPointDetailsIn.xq`: Request a Mastercard (Programa 1)
- `pointsAdjustmentInquiryIn.xq`: Request a Vision Plus (Programa 2)
- `conversionPuntosNIIn.xq`: Cálculo equivalencia efectivo

**XQuery de Salida:**
- `consultaPuntosLealtadNIOut.xq`: Mapeo respuesta → OSB

#### Campos Diferenciadores

1. **Consulta Información Cliente (si no hay datos en BD):**
   - Usa servicio Java: `sjConsultaTipoTarjetaNI` (SJS)
   - Operación: `ConsultaTipoTarjeta`
   - Extrae: registroDatoCuenta, customerId, customerName, legalId, logo, org, accountNumber, scheme, cardType, cardStatus

2. **Determinación Programa Lealtad:**
   - **Tarjeta DEBIT:**
     - Valida que cardStatus = 'ACTIVE'
     - Extrae BIN (primeros 6 dígitos)
     - Consulta `obtenerTipoProgramaLealtad_db` con producto='TD0000', grupoAfinidad='000', bin
   - **Tarjeta CREDIT:**
     - Valida que logo no esté vacío
     - Consulta `consultaProgramaLealtad_db` por logo

3. **Consulta Mastercard (Programa 1):**
   - AppID: customerId con padding a 19 dígitos (fn-bea:pad-left)
   - Operación: `getPointDetails`

4. **Equivalencia en Efectivo:**
   - Servicio: PXYNIC schema
   - Parámetros: logo (o BIN si logo vacío), tipoConversion=1, montoConversion, cashRedemptionType
   - Moneda: USD

#### Validaciones y Errores

- Validación XSD del request
- Validación XSD del request a Vision Plus
- Error si CUSTOMER_ID_TYPE no es "CARD_NUMBER"
- Error si tarjeta débito no está ACTIVE
- Error si logo está vacío (tarjeta crédito)
- Error si programa de lealtad no es 1 o 2

#### Dependencias Internas

- `Middleware/v2/BusinessServices/SJS/consultaTipoTarjetaNI/biz/sjConsultaTipoTarjetaNI`
- `Middleware/v2/BusinessServices/INTFC/obtenerTipoProgramaLealtad/biz/obtenerTipoProgramaLealtad_db`
- `Middleware/v2/BusinessServices/INTFC/consultaProgramaLealtad/biz/consultaProgramaLealtad_db`
- `Middleware/v2/BusinessServices/Mastercard/CustomerService/biz/CustomerService`
- `Middleware/v2/BusinessServices/VisionPlus/visionPlus/biz/visionPlus`
- `Middleware/v2/BusinessServices/PXYNIC/canjearPuntosEfectivo/biz/canjearPuntosEfectivo_db`
- `Middleware/Business_Resources/general/Resources/ObtenerParametrizacion/ObtenerParametrizacion`
- `Middleware/v2/BusinessServices/CLIENTDATA/registraPuntosLealtad/biz/registraPuntosLealtad_db`

---

### 4. PANAMÁ (PA01)

#### Endpoints y Configuración

**Proxy Service:**
- Ruta: `Middleware/v2/ProxyServices/ConsultaPuntosLealtadPA.proxy`
- WSDL: `Middleware/v2/Resources/ConsultaPuntosLealtad/wsdl/consultaPuntosLealtadPS.wsdl`
- Binding: SOAP 1.1
- Logging: Debug habilitado

#### Transformaciones Clave

**XQuery de Entrada:**
- `consultaPuntosLealtadIn.xq`: Mapeo request OSB → SP
- `conDatoCuentaPAIn.xq`: Consulta datos de cuenta Panamá
- `consultaProgramaLealtadIn.xq`: Determina programa de lealtad
- `getPointDetailsInPA.xq`: Request a Mastercard (Programa 1)
- `pointsAdjustmentInquiryIn.xq`: Request a Vision Plus (Programa 2)
- `conversionPuntosNIIn.xq`: Cálculo equivalencia efectivo (reutiliza NI)

**XQuery de Salida:**
- `consultaPuntosLealtadPAOut.xq`: Mapeo respuesta → OSB

#### Campos Diferenciadores

1. **Consulta Información Cliente (si no hay datos en BD):**
   - Usa servicio: `conDatoCuenta_db` (MasterDataPA)
   - Convierte código país a ISO3
   - Extrae de registro ALT o BASE (prioriza ALT): customerId, customerName, legalId, logo, org, accountNumber, scheme

2. **Determinación Programa Lealtad:**
   - Valida que logo no esté vacío
   - Consulta `consultaProgramaLealtad_db` por logo y código país
   - No hay lógica especial para tarjetas débito

3. **Consulta Mastercard (Programa 1):**
   - AppID: legalId del cliente
   - Operación: `getPointDetails`

4. **Equivalencia en Efectivo:**
   - Servicio: PXYNIC schema (mismo que Nicaragua)
   - Parámetros: logo, tipoConversion=1, montoConversion, cashRedemptionType
   - Moneda: USD

5. **Manejo de Errores Especial:**
   - Error handler específico para stage ConsultaPuntos
   - Captura errores de Mastercard con estructura especial (ReceivedFaultDetail)

#### Validaciones y Errores

- Validación XSD del request
- Validación XSD del request a conDatoCuenta
- Validación XSD del request a Vision Plus
- Error si logo está vacío
- Error si CUSTOMER_ID_TYPE no es "CARD_NUMBER"
- Error si programa de lealtad no es 1 o 2
- Manejo especial de errores de Mastercard

#### Dependencias Internas

- `Middleware/v2/BusinessServices/MasterDataPA/conDatoCuenta/biz/conDatoCuenta_db`
- `Middleware/v2/BusinessServices/INTFC/consultaProgramaLealtad/biz/consultaProgramaLealtad_db`
- `Middleware/v2/BusinessServices/Mastercard/CustomerService/biz/CustomerService`
- `Middleware/v2/BusinessServices/VisionPlus/visionPlus/biz/visionPlus`
- `Middleware/v2/BusinessServices/PXYNIC/canjearPuntosEfectivo/biz/canjearPuntosEfectivo_db`
- `Middleware/Business_Resources/general/Resources/ObtenerParametrizacion/ObtenerParametrizacion`
- `Middleware/v2/BusinessServices/CLIENTDATA/registraPuntosLealtad/biz/registraPuntosLealtad_db`

---

## Diferencias Clave Resumidas

### Servicios de Datos Maestros

| Región | Servicio | Tipo | Características |
|--------|----------|------|-----------------|
| HN | conInfoLealtad_db | DB Adapter | Específico para lealtad |
| GT | conDatoCuenta_db | DB Adapter | Datos maestros generales |
| NI | sjConsultaTipoTarjetaNI | Java/SOAP | Servicio Java con más información |
| PA | conDatoCuenta_db | DB Adapter | Prioriza registro ALT |

### Operaciones Mastercard

| Región | Operación | AppID |
|--------|-----------|-------|
| HN | getPointDetails | legalId |
| GT | getRTRPreferences | NIT (driver_lic) |
| NI | getPointDetails | customerId (19 dígitos) |
| PA | getPointDetails | legalId |

### Lógica de Tarjetas Débito

| Región | Validación Especial |
|--------|---------------------|
| HN | Programa 1 automático |
| GT | Sin validación especial |
| NI | Valida ACTIVE + consulta por BIN |
| PA | Sin validación especial |

### Servicios de Conversión

| Región | Schema | Moneda |
|--------|--------|--------|
| HN | ABK | HNL |
| GT | ABKGT | GTQ |
| NI | PXYNIC | USD |
| PA | PXYNIC | USD |

---

## Políticas OSB Comunes

Todas las regiones comparten:

- **Monitoring:** Deshabilitado
- **Reporting:** Habilitado
- **Logging:** Debug habilitado
- **SLA Alerting:** Habilitado (nivel normal)
- **Pipeline Alerting:** Habilitado (nivel normal)
- **Throttling:** Deshabilitado
- **Message Tracing:** Deshabilitado
- **Retry Count:** 0
- **Retry Interval:** 0

---

## Timeouts/Retrys

**No se encontraron configuraciones explícitas de timeout en los proxies.**

Configuración por defecto de OSB:
- Read Timeout: 180 segundos
- Connection Timeout: 60 segundos
- Retry Count: 0 (sin reintentos)

---

## Recomendaciones de Estandarización

1. **Unificar Servicios de Datos Maestros:**
   - Estandarizar a un solo tipo de servicio (DB Adapter o Java)
   - Homologar estructura de respuesta

2. **Estandarizar Operación Mastercard:**
   - Usar la misma operación en todas las regiones
   - Estandarizar formato de AppID

3. **Implementar Timeouts:**
   - Configurar timeouts explícitos por servicio
   - Implementar política de reintentos

4. **Validación de Tarjetas Débito:**
   - Aplicar validación de estado en todas las regiones
   - Estandarizar lógica de determinación de programa

5. **Manejo de Errores:**
   - Unificar estructura de error handlers
   - Estandarizar códigos de error

6. **Logging y Monitoreo:**
   - Habilitar monitoring con métricas consistentes
   - Implementar correlation IDs para trazabilidad
