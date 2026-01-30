# Ejemplos de Request/Response y Mapeo de Datos - HONDURAS (HN01)

## Request OSB (Ejemplo SOAP/XML)

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:prog="http://www.ficohsa.com.hn/middleware.services/programaLealtadTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:RequestHeader>
         <Region>
            <SourceBank>HN01</SourceBank>
         </Region>
         <TransactionId>TXN123456789</TransactionId>
         <SessionId>SES987654321</SessionId>
      </aut:RequestHeader>
   </soapenv:Header>
   <soapenv:Body>
      <prog:consultaPuntosLealtad>
         <CUSTOMER_ID_TYPE>CARD_NUMBER</CUSTOMER_ID_TYPE>
         <CUSTOMER_ID_VALUE>5041234567890123</CUSTOMER_ID_VALUE>
         <RETURN_CASH_EQUIVALENT>YES</RETURN_CASH_EQUIVALENT>
         <CASH_REDEMPTION>
            <TERMINAL_ID>TERM001</TERMINAL_ID>
            <MERCHANT_ID>MERCH123</MERCHANT_ID>
            <MERCHANT_TYPE>RETAIL</MERCHANT_TYPE>
         </CASH_REDEMPTION>
      </prog:consultaPuntosLealtad>
   </soapenv:Body>
</soapenv:Envelope>
```

## Response OSB (Ejemplo SOAP/XML)

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:prog="http://www.ficohsa.com.hn/middleware.services/programaLealtadTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:ResponseHeader>
         <successIndicator>Success</successIndicator>
      </aut:ResponseHeader>
   </soapenv:Header>
   <soapenv:Body>
      <prog:consultaPuntosLealtadResponse>
         <LEGAL_ID>0801199012345</LEGAL_ID>
         <CUSTOMER_NAME>JUAN CARLOS LOPEZ MARTINEZ</CUSTOMER_NAME>
         <AVAILABLE_POINTS>15000</AVAILABLE_POINTS>
         <CASH_EQUIVALENT>3750.00</CASH_EQUIVALENT>
         <CASH_CURRENCY>HNL</CASH_CURRENCY>
      </prog:consultaPuntosLealtadResponse>
   </soapenv:Body>
</soapenv:Envelope>
```

---

## Cadenas de Conexión y Credenciales

### 1. Base de Datos CLIENTDATA

**Conexión:**
- JNDI: `eis/DB/ConnectionClientdata`
- Tipo: Oracle Database Adapter
- Esquema: `CLIENTDATA`

**Stored Procedure:**
- Nombre: `CONSULTA_PUNTOS_LEALTAD`
- Package: CLIENTDATA
- Parámetros IN:
  - PV_CODIGO_PAIS (VARCHAR2)
  - PV_CUSTOMER_ID_TYPE (VARCHAR2)
  - PV_CUSTOMER_ID_VALUE (VARCHAR2)
  - PV_CASH_EQUIVALENT (VARCHAR2)
  - PV_CARD_NUMBER (VARCHAR2)
  - PV_MERCHANT_ID (VARCHAR2)
  - PV_MERCHANT_TYPE (VARCHAR2)
  - PV_TERMINAL_ID (VARCHAR2)
- Parámetros OUT:
  - PV_CODIGO_ERROR (VARCHAR2)
  - PV_MENSAJE_ERROR (VARCHAR2)
  - PT_PUNTOS_LEALTAD (CLIENTDATA.O_PUNTOS_LEALTAD)

### 2. Servicio conInfoLealtad (ProcesosHN)

**Conexión:**
- Business Service: `Middleware/v2/BusinessServices/ProcesosHN/conInfoLealtad/biz/conInfoLealtad_db`
- Tipo: DB Adapter
- Esquema: ProcesosHN

**Stored Procedure:**
- Nombre: `conInfoLealtad`
- Parámetros: country (ISO3), cardNumber

### 3. Mastercard Rewards Service (Programa 1)

**Conexión:**
- Business Service: `Middleware/v2/BusinessServices/Mastercard/CustomerService/biz/CustomerService`
- Endpoint WSDL: (Configurado en Business Service)
- Operación: `getPointDetails`
- Autenticación: SOAP Header personalizado
  - Institution Name: Obtenido de parametrización (FICBCO0229.MRS.INSTITUTION.NAME)
  - AppID: legalId del cliente

### 4. Vision Plus (Programa 2)

**Conexión:**
- Business Service: `Middleware/v2/BusinessServices/VisionPlus/visionPlus/biz/visionPlus`
- Endpoint: (Configurado en Business Service)
- Operación: `PointsAdjustmentInquiry`
- Parámetros: accountNumber, scheme, org

### 5. Servicio Conversión Puntos (ABK)

**Conexión:**
- Business Service: `Middleware/v2/BusinessServices/ABK/canjearPuntosEfectivo/biz/canjearPuntosEfectivo_db`
- Tipo: DB Adapter
- Esquema: ABK

**Stored Procedure:**
- Nombre: `canjearPuntosEfectivo`
- Parámetros: logo, conversionAmount, conversionType, terminalId, merchantType, merchantNumber

---

## Mapeo de Entrada - Llamada 1: consultaPuntosLealtad_db

### Tabla de Mapeo Request OSB → Stored Procedure

| Campo Origen (OSB) | Transformación/Script | Campo Destino (SP) |
|--------------------|----------------------|-------------------|
| $header/aut:RequestHeader/Region/SourceBank | string() | PV_CODIGO_PAIS |
| $body/prog:consultaPuntosLealtad/CUSTOMER_ID_TYPE | string() | PV_CUSTOMER_ID_TYPE |
| $body/prog:consultaPuntosLealtad/CUSTOMER_ID_VALUE | string() | PV_CUSTOMER_ID_VALUE |
| $body/prog:consultaPuntosLealtad/RETURN_CASH_EQUIVALENT | string() | PV_CASH_EQUIVALENT |
| $body/prog:consultaPuntosLealtad/CUSTOMER_ID_VALUE | string() (si CUSTOMER_ID_TYPE='CARD_NUMBER') | PV_CARD_NUMBER |
| $body/prog:consultaPuntosLealtad/CASH_REDEMPTION/MERCHANT_ID | string() | PV_MERCHANT_ID |
| $body/prog:consultaPuntosLealtad/CASH_REDEMPTION/MERCHANT_TYPE | string() | PV_MERCHANT_TYPE |
| $body/prog:consultaPuntosLealtad/CASH_REDEMPTION/TERMINAL_ID | string() | PV_TERMINAL_ID |

**XQuery:** `Middleware/v2/Resources/ConsultaPuntosLealtad/xq/consultaPuntosLealtadIn.xq`

### Tabla de Mapeo Response SP → Variables OSB

| Campo Origen (SP) | Transformación/Script | Campo Destino (Variable) |
|-------------------|----------------------|-------------------------|
| PV_CODIGO_ERROR | string() | $errorCode |
| PV_MENSAJE_ERROR | string() | $validationMessage |
| PT_PUNTOS_LEALTAD/LEGAL_ID | string() | $legalId |
| PT_PUNTOS_LEALTAD/BALANCE | data() | $availablePoints |
| PT_PUNTOS_LEALTAD/CUSTOMER_NAME | string() | $customerName |
| PT_PUNTOS_LEALTAD/CASH_EQUIVALENT | data() | $cashEquivalent |
| PT_PUNTOS_LEALTAD/CASH_CURRENCY | data() o '' si vacío | $cashCurrency |

---

## Mapeo de Entrada - Llamada 2: conInfoLealtad_db (Si no hay datos en BD)

### Tabla de Mapeo Variables → Request SP

| Campo Origen (Variable) | Transformación/Script | Campo Destino (SP) |
|------------------------|----------------------|-------------------|
| $codigoPais | Convertido a ISO3 (convertirCodigoPais.xq) | country |
| $customerIdValue | string() | cardNumber |

**XQuery:** `Middleware/v2/Resources/ProgramaLealtad/xq/conInfoLealtadHNIn.xq`

**Regla de Negocio:**
- Conversión código país: HN01 → HND (ISO3)
- Ubicación: `Middleware/v2/Resources/Generales/xq/convertirCodigoPais.xq`

### Tabla de Mapeo Response SP → Variables

| Campo Origen (SP) | Transformación/Script | Campo Destino (Variable) |
|-------------------|----------------------|-------------------------|
| RowSet/Row/Column[@name='LEGALID'] | fn-bea:trim(string()) | $legalId |
| RowSet/Row/Column[@name='CUSTOMERNAME'] | string() | $customerName |
| RowSet/Row/Column[@name='CARDTYPE'] | string() | $cardType |
| CodigoError | string() | $errorCode |
| MensajeError | string() | $validationMessage |
| RowSet/Row/Column[@name='LOGO'] | string() | $grupoAfinidad |

---

## Mapeo de Entrada - Llamada 3: consultaProgramaLealtad_db

### Tabla de Mapeo Variables → Request SP

| Campo Origen (Variable) | Transformación/Script | Campo Destino (SP) |
|------------------------|----------------------|-------------------|
| $header/aut:RequestHeader/Region/SourceBank | fn:string() | codigoPais |
| $grupoAfinidad | - | logo |

**XQuery:** `Middleware/v2/Resources/ProgramaLealtad/xq/consultaProgramaLealtadIn.xq`

**Regla de Negocio:**
- Si cardType = 'DEBIT': programaLealtad = '1' (sin consultar SP)
- Si cardType = 'CREDIT': consulta SP
- Si grupoAfinidad = '625' (Infinite) y existe PROGRAM_ID en request: usa PROGRAM_ID del request
- Ubicación: Stage ConsultaProgramaLealtad en proxy

### Tabla de Mapeo Response SP → Variables

| Campo Origen (SP) | Transformación/Script | Campo Destino (Variable) |
|-------------------|----------------------|-------------------------|
| PV_CODIGOMENSAJE | string() | $errorCode |
| PV_DESCRIPCIONMENSAJE | string() | $validationMessage |
| PV_CODIGOLEALTAD | string() (si validationMessage='') | $programaLealtad |

---

## Mapeo de Entrada - Llamada 4a: Mastercard getPointDetails (Programa 1)

### Tabla de Mapeo Variables → Request SOAP

| Campo Origen (Variable) | Transformación/Script | Campo Destino (SOAP) |
|------------------------|----------------------|---------------------|
| $institutionName | Obtenido de ObtenerParametrizacion | Header/MRSIdentity/InstitutionName |
| $legalId | - | Header/MRSIdentity/AppID |
| - | Vacío (sin parámetros body) | Body/getPointDetails |

**XQuery Header:** `Middleware/v2/Resources/ProgramaLealtad/xq/MRSIdentity.xq`
**XQuery Body:** `Middleware/v2/Resources/ConsultaPuntosLealtad/xq/getPointDetailsIn.xq`

**Regla de Negocio:**
- InstitutionName obtenido de parametrización: FICBCO0229.MRS.INSTITUTION.NAME
- AppID = legalId del cliente
- Ubicación: Stage ConsultaPuntos, caso programaLealtad='1'

### Tabla de Mapeo Response SOAP → Variables

| Campo Origen (SOAP) | Transformación/Script | Campo Destino (Variable) |
|---------------------|----------------------|-------------------------|
| AvailablePoints | data() | $availablePoints |

---

## Mapeo de Entrada - Llamada 4b: Vision Plus PointsAdjustmentInquiry (Programa 2)

### Tabla de Mapeo Variables → Request SOAP

| Campo Origen (Variable) | Transformación/Script | Campo Destino (SOAP) |
|------------------------|----------------------|---------------------|
| $accountNumber | Obtenido de conDatoCuenta (RowSet/Row TipoOrg='ALT', Column LMS_ACC) | accountNumber |
| $scheme | Obtenido de conDatoCuenta (Column LMS_SCHEME) | scheme |
| $org | Obtenido de conDatoCuenta (Column ORG) | org |

**XQuery:** `Middleware/v2/Resources/VisionPlus/xq/pointsAdjustmentInquiryIn.xq`

**Regla de Negocio:**
- Primero consulta conDatoCuenta (MasterDataHN)
- Extrae registro con TipoOrg='ALT'
- Ubicación: Stage ConsultaPuntos, caso programaLealtad='2'

### Tabla de Mapeo Response SOAP → Variables

| Campo Origen (SOAP) | Transformación/Script | Campo Destino (Variable) |
|---------------------|----------------------|-------------------------|
| ReturnCodes/RC/Code | fn-bea:trim(string()) | $errorCode |
| ReturnCodes/RC/Desc | fn-bea:trim(string()) si SVC-RETURN!='P' | $validationMessage |
| GPXAIO-OPEN-TO-RED-ON-SCR | xs:decimal() div 1000 (si no vacío) | $availablePoints |

---

## Mapeo de Entrada - Llamada 5: canjearPuntosEfectivo_db (Si RETURN_CASH_EQUIVALENT='YES')

### Tabla de Mapeo Variables → Request SP

| Campo Origen (Variable) | Transformación/Script | Campo Destino (SP) |
|------------------------|----------------------|-------------------|
| $availablePoints | fn:string() | conversionAmount |
| $grupoAfinidad | - | logo |
| - | '1' (constante) | conversionType |
| $body/prog:consultaPuntosLealtad/CASH_REDEMPTION/TERMINAL_ID | string() | terminalId |
| $body/prog:consultaPuntosLealtad/CASH_REDEMPTION/MERCHANT_TYPE | string() | merchantType |
| $body/prog:consultaPuntosLealtad/CASH_REDEMPTION/MERCHANT_ID | string() | merchantNumber |

**XQuery:** `Middleware/v2/Resources/ProgramaLealtad/xq/canjearPuntosEfectivoHNIn.xq`

**Regla de Negocio:**
- Solo se ejecuta si RETURN_CASH_EQUIVALENT='YES' y availablePoints > 0
- conversionType siempre es '1' (puntos a efectivo)
- Ubicación: Stage EquivalenciaEfectivo

### Tabla de Mapeo Response SP → Variables

| Campo Origen (SP) | Transformación/Script | Campo Destino (Variable) |
|-------------------|----------------------|-------------------------|
| PV_CODIGOMENSAJE | string() | $errorCode |
| PV_DESCRIPCIONMENSAJE | string() (si errorCode!='SUCCESS') | $validationMessage |
| PN_VALORSALIDA | data() | $cashEquivalent |
| - | 'HNL' (constante) | $cashCurrency |

---

## Mapeo de Entrada - Llamada 6: registraPuntosLealtad_db (Si consulta SP principal falló)

### Tabla de Mapeo Variables → Request SP

| Campo Origen (Variable) | Transformación/Script | Campo Destino (SP) |
|------------------------|----------------------|-------------------|
| $cashEquivalent | - | cashEquivalent |
| $customerName | - | customerName |
| $availablePoints | - | balance |
| $header/aut:RequestHeader | - | requestHeader |
| $body/prog:consultaPuntosLealtad | - | consultaPuntosLealtad |
| $cashCurrency | 'HNL' (constante) | cashCurrency |
| $legalId | - | legalId |

**XQuery:** `Middleware/v2/Resources/ConsultaPuntosLealtad/xq/registraPuntosLealtadIn.xq`

**Regla de Negocio:**
- Solo se ejecuta si upper-case(RSPconsultaPuntosLealtad/PV_CODIGO_ERROR) != 'SUCCESS' y validationMessage = ''
- Registra los datos obtenidos de servicios externos en BD local
- Ubicación: Stage RegistraPuntosLealtad

### Tabla de Mapeo Response SP → Variables

| Campo Origen (SP) | Transformación/Script | Campo Destino (Variable) |
|-------------------|----------------------|-------------------------|
| PV_CODIGO_ERROR | string() | $errorCode |
| PV_MENSAJE_ERROR | string() | $validationMessage |

---

## Mapeo de Salida Final

### Tabla de Mapeo Variables → Response OSB

| Campo Origen (Variable) | Transformación/Script | Campo Destino (OSB) |
|------------------------|----------------------|---------------------|
| $errorCode | 'Success' si validationMessage='', sino $errorCode | ResponseHeader/successIndicator |
| $validationMessage | - (solo si hay error) | ResponseHeader/messages |
| $legalId | - | consultaPuntosLealtadResponse/LEGAL_ID |
| $availablePoints | - | consultaPuntosLealtadResponse/AVAILABLE_POINTS |
| $customerName | - | consultaPuntosLealtadResponse/CUSTOMER_NAME |
| $cashCurrency | - | consultaPuntosLealtadResponse/CASH_CURRENCY |
| $cashEquivalent | - | consultaPuntosLealtadResponse/CASH_EQUIVALENT |
| $body/prog:consultaPuntosLealtad/RETURN_CASH_EQUIVALENT | fn:string() | isCashEquivalent (parámetro XQuery) |

**XQuery:** `Middleware/v2/Resources/ConsultaPuntosLealtad/xq/consultaPuntosLealtadHNOut.xq`

**Regla de Negocio:**
- Si validationMessage='': Response exitoso con datos
- Si validationMessage!='': Response con error, body vacío
- Ubicación: Stage FlujoSalida en pipeline response

---

## Reglas de Negocio Detectadas

### 1. Determinación de Programa de Lealtad

**Ubicación:** Stage ConsultaProgramaLealtad
**Código:**
```xquery
if($validationMessage = '' and $cardType = 'DEBIT') then (
    $programaLealtad := '1'
) else if($validationMessage = "") then (
    -- Consulta consultaProgramaLealtad_db
    if($grupoAfinidad = $logoInfinite and exists($body/prog:consultaPuntosLealtad/PROGRAM_ID/text())) then (
        $programaLealtad := $body/prog:consultaPuntosLealtad/PROGRAM_ID/text()
    ) else (
        $programaLealtad := string($RSPconsultaProgramaLealtad/con:PV_CODIGOLEALTAD/text())
    )
)
```

**Lógica:**
- Tarjetas DEBIT: Programa 1 (MRS) automático
- Tarjetas CREDIT: Consulta BD por logo
- Excepción Infinite (logo=625): Usa PROGRAM_ID del request si existe

### 2. Consulta Condicional de Información Cliente

**Ubicación:** Stage ConsultaInformacionCliente
**Condición:**
```xquery
not(exists($RSPconsultaPuntosLealtad/con1:PT_PUNTOS_LEALTAD/con1:BALANCE))
```

**Lógica:**
- Solo consulta servicios externos si el SP principal no retornó datos
- Valida que CUSTOMER_ID_TYPE = 'CARD_NUMBER'

### 3. Cálculo de Equivalencia en Efectivo

**Ubicación:** Stage EquivalenciaEfectivo
**Condición:**
```xquery
fn:string($body/prog:consultaPuntosLealtad/RETURN_CASH_EQUIVALENT/text()) = "YES"
and xs:decimal($availablePoints) > xs:decimal(0) 
and not(exists($RSPconsultaPuntosLealtad/con1:PT_PUNTOS_LEALTAD/con1:BALANCE))
```

**Lógica:**
- Solo calcula si se solicitó explícitamente
- Solo si hay puntos disponibles
- Solo si los datos vienen de servicios externos (no de BD)

### 4. Registro en Base de Datos

**Ubicación:** Stage RegistraPuntosLealtad
**Condición:**
```xquery
upper-case($RSPconsultaPuntosLealtad/con1:PV_CODIGO_ERROR/text()) != "SUCCESS" 
and $validationMessage = ""
```

**Lógica:**
- Registra datos obtenidos de servicios externos
- Solo si la consulta inicial a BD falló
- Solo si la consulta a servicios externos fue exitosa

---

## Errores/Excepciones

### Códigos de Error

| Código | Descripción | Origen |
|--------|-------------|--------|
| SUCCESS | Operación exitosa | SP / Servicios |
| ERROR | Error genérico | Validaciones OSB |
| -1 | Error de sistema | SP / Servicios |
| [Código específico] | Error de servicio externo | Mastercard / Vision Plus |

### Manejo de Errores

**Error Handler Principal:** `_onErrorHandler-4619621103130840609--4d48eba6.17956b1c079.-7f44`

**Acciones:**
1. Captura fault context
2. Construye ResponseHeader con:
   - successIndicator: errorCode del fault
   - messages: reason del fault
3. Body vacío
4. Reply al cliente

**Errores Específicos:**
- "CUSTOMER_ID_TYPE no soportado": Si no es CARD_NUMBER
- "Programa de lealtad no soportado": Si programaLealtad no es 1 o 2
- Errores de servicios externos: Se propagan en validationMessage

---

## Timeouts/Retrys

**Configuración:**
- Retry Count: 0 (sin reintentos)
- Retry Interval: 0
- Retry Application Errors: false
- Delay Interval: Deshabilitado

**Recomendación:**
- Implementar timeouts explícitos por servicio
- Configurar reintentos para servicios externos (1-2 intentos)
- Timeout sugerido: 30 segundos para servicios externos, 10 segundos para BD
