# Ejemplos de Request/Response y Mapeo de Datos - NICARAGUA (NI01)

## Request OSB (Ejemplo SOAP/XML)

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:prog="http://www.ficohsa.com.hn/middleware.services/programaLealtadTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:RequestHeader>
         <Region>
            <SourceBank>NI01</SourceBank>
         </Region>
      </aut:RequestHeader>
   </soapenv:Header>
   <soapenv:Body>
      <prog:consultaPuntosLealtad>
         <CUSTOMER_ID_TYPE>CARD_NUMBER</CUSTOMER_ID_TYPE>
         <CUSTOMER_ID_VALUE>5041234567890789</CUSTOMER_ID_VALUE>
         <RETURN_CASH_EQUIVALENT>YES</RETURN_CASH_EQUIVALENT>
         <CASH_REDEMPTION>
            <TERMINAL_ID>TERM003</TERMINAL_ID>
            <MERCHANT_ID>MERCH789</MERCHANT_ID>
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
         <LEGAL_ID>001-123456-0001A</LEGAL_ID>
         <CUSTOMER_NAME>CARLOS ALBERTO MENDEZ ORTIZ</CUSTOMER_NAME>
         <AVAILABLE_POINTS>18500</AVAILABLE_POINTS>
         <CASH_EQUIVALENT>462.50</CASH_EQUIVALENT>
         <CASH_CURRENCY>USD</CASH_CURRENCY>
      </prog:consultaPuntosLealtadResponse>
   </soapenv:Body>
</soapenv:Envelope>
```

## Diferencias Clave con Otras Regiones

### 1. Servicio de Datos Maestros
- **Tipo:** Java Service (SOAP) - NO es DB Adapter
- **Servicio:** `sjConsultaTipoTarjetaNI` (SJS)
- **Operación:** `ConsultaTipoTarjeta`
- **XQuery:** `consultaTipoTarjetaNIIn.xq`
- **Retorna más información:** cardType, cardStatus, etc.

### 2. Validación de Tarjetas Débito
- **Validación de Estado:** Solo tarjetas con `cardStatus='ACTIVE'` pueden consultar
- **Consulta por BIN:** Extrae primeros 6 dígitos y consulta `obtenerTipoProgramaLealtad_db`
- **Parámetros BIN:** producto='TD0000', grupoAfinidad='000', bin

### 3. Operación Mastercard
- **Operación:** `getPointDetails`
- **AppID:** customerId con padding a 19 dígitos (`fn-bea:pad-left($customerId, 19, '0')`)
- **XQuery:** `getPointDetailsIn.xq`

### 4. Conversión de Puntos
- **Schema:** PXYNIC (compartido con Panamá)
- **Moneda:** USD (Dólar)
- **XQuery:** `conversionPuntosNIIn.xq`
- **Parámetro logo:** Usa BIN si logo está vacío

## Mapeo Específico - sjConsultaTipoTarjetaNI (Java Service)

### Request
| Campo Origen | Transformación | Campo Destino |
|--------------|----------------|---------------|
| $operation | Variable (no usada) | operation |
| $body/prog:consultaPuntosLealtad/CUSTOMER_ID_VALUE | xs:integer(fn:string()) | cardNumber |

**XQuery:** `consultaTipoTarjetaNIIn.xq`

### Response
| Campo Origen | Transformación | Campo Destino |
|--------------|----------------|---------------|
| SUCCESS_INDICATOR | fn:string() | $errorCode |
| ERROR_MESSAGE | fn:string() | $validationMessage |
| ACCOUNT_DATA_REGISTRATION | fn:string() | $registroDatoCuenta |
| CUSTOMER_ID | fn:string() | $customerId |
| CUSTOMER_NAME | fn:string() | $customerName |
| LEGAL_ID | fn:string() | $legalId |
| LOGO | fn:string() | $logo |
| ORG | fn:string() | $org |
| ACCOUNT_NUMBER | fn:string() | $accountNumber |
| SCHEME | fn:string() | $scheme |
| CARD_TYPE | fn:string() | $cardType |
| CARD_STATUS | fn:string() | $cardStatus |

## Mapeo Específico - obtenerTipoProgramaLealtad_db (Solo Débito)

### Request
| Campo Origen | Transformación | Campo Destino |
|--------------|----------------|---------------|
| 'TD0000' | Constante | producto |
| '000' | Constante | grupoAfinidad |
| $binNumber | fn:substring(..., 1, 6) | bin |

**XQuery:** `obtenerTipoProgramaLealtadIn.xq`

**Regla de Negocio:**
```xquery
$binNumber := fn:substring(fn:string($body/prog:consultaPuntosLealtad/CUSTOMER_ID_VALUE/text()), 1, 6)
```

### Response
| Campo Origen | Transformación | Campo Destino |
|--------------|----------------|---------------|
| PV_CODIGO_ERROR | fn:upper-case(fn:string()) | $errorCode |
| PV_MENSAJE_ERROR | fn:string() (si errorCode!='SUCCESS') | $validationMessage |
| PN_PROGRAMA_LEALTAD | fn:string() | $programaLealtad |

## Mapeo Específico - Mastercard getPointDetails

### Request Header
| Campo Origen | Transformación | Campo Destino |
|--------------|----------------|---------------|
| $institutionName | De parametrización | MRSIdentity/InstitutionName |
| $customerId | fn-bea:pad-left($customerId, 19, '0') | MRSIdentity/AppID |

**Nota:** Única región que usa customerId con padding a 19 dígitos

## Mapeo Específico - canjearPuntosEfectivo (PXYNIC)

### Request
| Campo Origen | Transformación | Campo Destino |
|--------------|----------------|---------------|
| $logo o $binNumber | if($logo='') then $binNumber else $logo | logo |
| "1" | Constante | tipoConversion |
| $availablePoints | - | montoConversion |
| $body/prog:consultaPuntosLealtad/CASH_REDEMPTION | - | cashRedemptionType1 |

**XQuery:** `conversionPuntosNIIn.xq`

**Regla de Negocio:**
```xquery
logo := if($logo ='') then $binNumber else $logo
```

### Response
| Campo Origen | Transformación | Campo Destino |
|--------------|----------------|---------------|
| PV_CODIGOMENSAJE | fn:string() | $errorCode |
| PV_DESCRIPCIONMENSAJE | fn:string() (si errorCode!='SUCCESS') | $validationMessage |
| PN_VALORSALIDA | data() | $cashEquivalent |
| 'USD' | Constante | $cashCurrency |

## Reglas de Negocio Específicas

### 1. Validación de Tarjeta Débito Activa
```xquery
if($cardType = "DEBIT") then (
    if($cardStatus = 'ACTIVE') then (
        -- Extraer BIN y consultar programa
        $binNumber := fn:substring(fn:string($body/prog:consultaPuntosLealtad/CUSTOMER_ID_VALUE/text()), 1, 6)
        -- Consultar obtenerTipoProgramaLealtad_db
    ) else (
        $errorCode := "ERROR"
        $validationMessage := "La tarjeta de debito no se encuentra activa"
    )
)
```

### 2. Determinación de Programa por Tipo de Tarjeta
```xquery
if($cardType = "DEBIT" and $cardStatus = "ACTIVE") then (
    -- Consulta por BIN
    obtenerTipoProgramaLealtad_db(producto='TD0000', grupoAfinidad='000', bin=$binNumber)
) else if($cardType = "CREDIT") then (
    if($logo != "") then (
        -- Consulta por logo
        consultaProgramaLealtad_db(logo=$logo, codigoPais='NI01')
    ) else (
        $errorCode := "ERROR"
        $validationMessage := "No se encontró logo para la tarjeta."
    )
)
```

### 3. Padding de CustomerId para Mastercard
```xquery
$appID := fn-bea:pad-left($customerId, 19, '0')
```
Ejemplo: customerId='12345' → AppID='0000000000000012345'

## Cadenas de Conexión Específicas

### sjConsultaTipoTarjetaNI (SJS)
- Business Service: `Middleware/v2/BusinessServices/SJS/consultaTipoTarjetaNI/biz/sjConsultaTipoTarjetaNI`
- Tipo: Java Service (SOAP)
- Endpoint: (Configurado en Business Service)

### obtenerTipoProgramaLealtad_db (INTFC)
- Business Service: `Middleware/v2/BusinessServices/INTFC/obtenerTipoProgramaLealtad/biz/obtenerTipoProgramaLealtad_db`
- JNDI: (Configurado en Business Service)
- Esquema: INTFC

### canjearPuntosEfectivo_db (PXYNIC)
- Business Service: `Middleware/v2/BusinessServices/PXYNIC/canjearPuntosEfectivo/biz/canjearPuntosEfectivo_db`
- JNDI: (Configurado en Business Service)
- Esquema: PXYNIC

## Archivos Específicos de Nicaragua

### XQuery
```
Middleware/v2/Resources/ProgramaLealtad/xq/consultaTipoTarjetaNIIn.xq
Middleware/v2/Resources/Genericos/obtenerTipoProgramaLealtadIn.xq
Middleware/v2/Resources/ConsultaPuntosLealtad/xq/consultaPuntosLealtadNIOut.xq
Middleware/v2/Resources/ProgramaLealtad/xq/conversionPuntosNIIn.xq
```

### Business Services
```
Middleware/v2/BusinessServices/SJS/consultaTipoTarjetaNI/biz/sjConsultaTipoTarjetaNI.biz
Middleware/v2/BusinessServices/INTFC/obtenerTipoProgramaLealtad/biz/obtenerTipoProgramaLealtad_db.biz
Middleware/v2/BusinessServices/PXYNIC/canjearPuntosEfectivo/biz/canjearPuntosEfectivo_db.biz
```

### JAR
```
JAR/HotFix/PG-5293_Arq_Paq04_HF03/PRD/ConsultaPuntosLealtadNI_Fix.jar
JAR/HotFix/PG-5293_Arq_Paq04_HF03/QA/ConsultaPuntosLealtadNI_Fix.jar
```

## Validaciones Adicionales

### Validación XSD Vision Plus
- Schema: `XMLSchema_769155616.xsd`
- Element: `fdcs:PointsAdjustmentInquiryRequest`
- Valida request antes de enviar a Vision Plus

## Errores Específicos

| Código | Descripción | Condición |
|--------|-------------|-----------|
| ERROR | La tarjeta de debito no se encuentra activa | cardType='DEBIT' y cardStatus≠'ACTIVE' |
| ERROR | No se encontró logo para la tarjeta | cardType='CREDIT' y logo='' |
| ERROR | CUSTOMER_ID_TYPE no soportado | CUSTOMER_ID_TYPE≠'CARD_NUMBER' |
| ERROR | Programa de lealtad no soportado | programaLealtad no es 1 o 2 |
