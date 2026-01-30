# Ejemplos de Request/Response y Mapeo de Datos - GUATEMALA (GT01)

## Request OSB (Ejemplo SOAP/XML)

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:prog="http://www.ficohsa.com.hn/middleware.services/programaLealtadTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:RequestHeader>
         <Region>
            <SourceBank>GT01</SourceBank>
         </Region>
      </aut:RequestHeader>
   </soapenv:Header>
   <soapenv:Body>
      <prog:consultaPuntosLealtad>
         <CUSTOMER_ID_TYPE>CARD_NUMBER</CUSTOMER_ID_TYPE>
         <CUSTOMER_ID_VALUE>5041234567890456</CUSTOMER_ID_VALUE>
         <RETURN_CASH_EQUIVALENT>YES</RETURN_CASH_EQUIVALENT>
         <CASH_REDEMPTION>
            <TERMINAL_ID>TERM002</TERMINAL_ID>
            <MERCHANT_ID>MERCH456</MERCHANT_ID>
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
         <LEGAL_ID>1234567890123</LEGAL_ID>
         <CUSTOMER_NAME>MARIA ELENA GARCIA RODRIGUEZ</CUSTOMER_NAME>
         <AVAILABLE_POINTS>25000</AVAILABLE_POINTS>
         <CASH_EQUIVALENT>1562.50</CASH_EQUIVALENT>
         <CASH_CURRENCY>GTQ</CASH_CURRENCY>
      </prog:consultaPuntosLealtadResponse>
   </soapenv:Body>
</soapenv:Envelope>
```

## Diferencias Clave con Honduras

### 1. Servicio de Datos Maestros
- **Servicio:** `conDatoCuenta_db` (MasterDataGT) - DB Adapter genérico
- **XQuery:** `conDatoCuentaGTIn.xq`
- **Extrae registro BASE** (no ALT como en otras regiones)

### 2. Operación Mastercard
- **Operación:** `getRTRPreferences` (única región que usa esta operación)
- **AppID:** NIT del cliente (campo `driver_lic` de conDatoCuenta)
- **XQuery:** `getPointDetailsInGT.xq`

### 3. Conversión de Puntos
- **Schema:** ABKGT
- **Moneda:** GTQ (Quetzal)
- **XQuery:** `canjearPuntosEfectivoGTIn.xq`

### 4. Lógica de Programa de Lealtad
- No hay lógica especial para tarjetas débito
- Siempre consulta `consultaProgramaLealtad_db` por logo
- Valida que logo no esté vacío antes de consultar

## Mapeo Específico - conDatoCuenta_db (Guatemala)

### Request
| Campo Origen | Transformación | Campo Destino |
|--------------|----------------|---------------|
| $customerIdValue | - | accountNumber |
| $codigoPais | Convertido a ISO3 (GT01→GTM) | countryCode |
| '' | Vacío | org |

### Response
| Campo Origen | Transformación | Campo Destino |
|--------------|----------------|---------------|
| RowSet/Row[TipoOrg='BASE']/Column[@name='CUST_NBR'] | fn:string() | $customerId |
| RowSet/Row[TipoOrg='BASE']/Column[@name='nombre_cliente'] | fn:string() | $customerName |
| RowSet/Row[TipoOrg='BASE']/Column[@name='legal_id'] | fn:string() | $legalId |
| RowSet/Row[TipoOrg='BASE']/Column[@name='logo'] | fn:string() | $logo |
| RowSet/Row[TipoOrg='BASE']/Column[@name='ORG'] | string() | $org |
| RowSet/Row[TipoOrg='BASE']/Column[@name='LMS_ACC'] | string() | $accountNumber |
| RowSet/Row[TipoOrg='BASE']/Column[@name='LMS_Scheme'] | string() | $scheme |
| RowSet/Row[TipoOrg='BASE']/Column[@name='driver_lic'] | fn-bea:trim(string()) | $nit |

## Mapeo Específico - Mastercard getRTRPreferences

### Request Header
| Campo Origen | Transformación | Campo Destino |
|--------------|----------------|---------------|
| $institutionName | De parametrización | MRSIdentity/InstitutionName |
| $nit | - | MRSIdentity/AppID |

**Nota:** Única región que usa NIT como AppID

### Request Body
- Vacío (sin parámetros)

### Response
| Campo Origen | Transformación | Campo Destino |
|--------------|----------------|---------------|
| AvailablePoints | data() | $availablePoints |

## Mapeo Específico - canjearPuntosEfectivo (ABKGT)

### Request
| Campo Origen | Transformación | Campo Destino |
|--------------|----------------|---------------|
| $logo | - | logo |
| "1" | Constante | tipoConversion |
| $availablePoints | - | montoConversion |
| $body/prog:consultaPuntosLealtad/CASH_REDEMPTION | - | cashRedemptionType |

**XQuery:** `canjearPuntosEfectivoGTIn.xq`

### Response
| Campo Origen | Transformación | Campo Destino |
|--------------|----------------|---------------|
| PV_CODIGOMENSAJE | fn:string() | $errorCode |
| PV_DESCRIPCIONMENSAJE | fn:string() (si errorCode!='SUCCESS') | $validationMessage |
| PN_VALORSALIDA | data() | $cashEquivalent |
| 'GTQ' | Constante | $cashCurrency |

## Reglas de Negocio Específicas

### 1. Validación de Logo
```xquery
if($logo != "") then (
    -- Consultar parametrización y programa lealtad
) else (
    $errorCode := 'ERROR'
    $validationMessage := "No se encontró logo para la tarjeta."
)
```

### 2. Sin Lógica Especial para Débito
- No hay validación de tipo de tarjeta
- Todas las tarjetas siguen el mismo flujo

### 3. Validación XSD Adicional
- Valida request a conDatoCuenta con XSD
- Schema: `conDatoCuenta_sp.xsd`

## Cadenas de Conexión Específicas

### conDatoCuenta_db (MasterDataGT)
- Business Service: `Middleware/v2/BusinessServices/MasterDataGT/conDatoCuenta/biz/conDatoCuenta_db`
- JNDI: (Configurado en Business Service)
- Esquema: MasterDataGT

### canjearPuntosEfectivo_db (ABKGT)
- Business Service: `Middleware/v2/BusinessServices/ABKGT/canjearPuntosEfectivo/biz/canjearPuntosEfectivo_db`
- JNDI: (Configurado en Business Service)
- Esquema: ABKGT

## Archivos Específicos de Guatemala

### XQuery
```
Middleware/v2/Resources/MasterDataGT/xq/conDatoCuentaGTIn.xq
Middleware/v2/Resources/ConsultaPuntosLealtad/xq/consultaPuntosLealtadGTOut.xq
Middleware/v2/Resources/ConsultaPuntosLealtad/xq/getPointDetailsInGT.xq
Middleware/v2/Resources/ProgramaLealtad/xq/canjearPuntosEfectivoGTIn.xq
Middleware/v2/Resources/ProgramaLealtad/xq/ConsultaPuntosGT.xq
```

### Business Services
```
Middleware/v2/BusinessServices/MasterDataGT/conDatoCuenta/biz/conDatoCuenta_db.biz
Middleware/v2/BusinessServices/ABKGT/canjearPuntosEfectivo/biz/canjearPuntosEfectivo_db.biz
```

### JAR
```
JAR/2020.8.2.0/PG-2791/Produccion/Paquete_IV/ConsultaPuntosLealtad_GT.jar
JAR/2020.8.2.0/PG-2791/QA/Paquete_IV/ConsultaPuntosLealtad_GT.jar
```
