# Ejemplos de Request/Response y Mapeo de Datos - PANAMÁ (PA01)

## Request OSB (Ejemplo SOAP/XML)

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:prog="http://www.ficohsa.com.hn/middleware.services/programaLealtadTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:RequestHeader>
         <Region>
            <SourceBank>PA01</SourceBank>
         </Region>
      </aut:RequestHeader>
   </soapenv:Header>
   <soapenv:Body>
      <prog:consultaPuntosLealtad>
         <CUSTOMER_ID_TYPE>CARD_NUMBER</CUSTOMER_ID_TYPE>
         <CUSTOMER_ID_VALUE>5041234567890321</CUSTOMER_ID_VALUE>
         <RETURN_CASH_EQUIVALENT>YES</RETURN_CASH_EQUIVALENT>
         <CASH_REDEMPTION>
            <TERMINAL_ID>TERM004</TERMINAL_ID>
            <MERCHANT_ID>MERCH321</MERCHANT_ID>
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
         <LEGAL_ID>8-123-4567</LEGAL_ID>
         <CUSTOMER_NAME>ROBERTO JOSE CASTILLO PEREZ</CUSTOMER_NAME>
         <AVAILABLE_POINTS>32000</AVAILABLE_POINTS>
         <CASH_EQUIVALENT>800.00</CASH_EQUIVALENT>
         <CASH_CURRENCY>USD</CASH_CURRENCY>
      </prog:consultaPuntosLealtadResponse>
   </soapenv:Body>
</soapenv:Envelope>
```

## Diferencias Clave con Otras Regiones

### 1. Servicio de Datos Maestros
- **Servicio:** `conDatoCuenta_db` (MasterDataPA) - DB Adapter
- **XQuery:** `conDatoCuentaPAIn.xq`
- **Prioriza registro ALT:** Busca primero TipoOrg='ALT', si no existe usa BASE

### 2. Operación Mastercard
- **Operación:** `getPointDetails`
- **AppID:** legalId del cliente (igual que Honduras)
- **XQuery:** `getPointDetailsInPA.xq`

### 3. Conversión de Puntos
- **Schema:** PXYNIC (compartido con Nicaragua)
- **Moneda:** USD (Dólar)
- **XQuery:** `conversionPuntosNIIn.xq` (reutiliza de Nicaragua)

### 4. Manejo de Errores Especial
- **Error Handler Específico:** Para stage ConsultaPuntos
- **Captura errores Mastercard:** Con estructura ReceivedFaultDetail
- **Extrae código y mensaje:** De estructura especial de Mastercard

## Mapeo Específico - conDatoCuenta_db (Panamá)

### Request
| Campo Origen | Transformación | Campo Destino |
|--------------|----------------|---------------|
| $customerIdValue | - | accountNumber |
| $codigoPais | Convertido a ISO3 (PA01→PAN) | countryCode |
| '' | Vacío | org |

**XQuery:** `conDatoCuentaPAIn.xq`

### Response - Lógica de Priorización
```xquery
let $rowAlt := $RSPconDatoCuenta/con:RowSet[1]/con:Row[1][con:Column/@name='TipoOrg' and con:Column/text() = 'ALT']
let $rowBase := $RSPconDatoCuenta/con:RowSet[1]/con:Row[1][con:Column/@name='TipoOrg' and con:Column/text() = 'BASE']
return
    (
        if(fn:count($rowAlt) > 0) then
            ( $rowAlt ) else
                ( $rowBase )
    )
```

### Mapeo de Campos
| Campo Origen | Transformación | Campo Destino |
|--------------|----------------|---------------|
| RowSet[1]/Row[1]/Column[@name='CUST_NBR'] | fn:string() | $customerId |
| RowSet[1]/Row[1]/Column[@name='nombre_cliente'] | fn:string() | $customerName |
| RowSet[1]/Row[1]/Column[@name='legal_id'] | fn:string() | $legalId |
| RowSet[1]/Row[1]/Column[@name='logo'] | fn:string() | $logo |
| $registroDatoCuenta/Column[@name='ORG'] | string() | $org |
| $registroDatoCuenta/Column[@name='LMS_ACC'] | string() | $accountNumber |
| $registroDatoCuenta/Column[@name='LMS_Scheme'] | string() | $scheme |

**Nota:** Usa el registro seleccionado (ALT o BASE) para extraer org, accountNumber, scheme

## Mapeo Específico - Mastercard getPointDetails

### Request Header
| Campo Origen | Transformación | Campo Destino |
|--------------|----------------|---------------|
| $institutionName | De parametrización | MRSIdentity/InstitutionName |
| $legalId | - | MRSIdentity/AppID |

**XQuery:** `getPointDetailsInPA.xq`

### Request Body
- Vacío (sin parámetros)

### Response
| Campo Origen | Transformación | Campo Destino |
|--------------|----------------|---------------|
| AvailablePoints | data() | $availablePoints |

## Mapeo Específico - canjearPuntosEfectivo (PXYNIC)

### Request
| Campo Origen | Transformación | Campo Destino |
|--------------|----------------|---------------|
| $logo | - | logo |
| "1" | Constante | tipoConversion |
| $availablePoints | - | montoConversion |
| $body/prog:consultaPuntosLealtad/CASH_REDEMPTION | - | cashRedemptionType1 |

**XQuery:** `conversionPuntosNIIn.xq` (reutiliza de Nicaragua)

### Response
| Campo Origen | Transformación | Campo Destino |
|--------------|----------------|---------------|
| PV_CODIGOMENSAJE | fn:string() | $errorCode |
| PV_DESCRIPCIONMENSAJE | fn:string() (si errorCode!='SUCCESS') | $validationMessage |
| PN_VALORSALIDA | data() | $cashEquivalent |
| 'USD' | Constante | $cashCurrency |

## Reglas de Negocio Específicas

### 1. Priorización de Registro ALT sobre BASE
```xquery
$registroDatoCuenta := 
    let $rowAlt := $RSPconDatoCuenta/con:RowSet[1]/con:Row[1][con:Column/@name='TipoOrg' and con:Column/text() = 'ALT']
    let $rowBase := $RSPconDatoCuenta/con:RowSet[1]/con:Row[1][con:Column/@name='TipoOrg' and con:Column/text() = 'BASE']
    return
        (
            if(fn:count($rowAlt) > 0) then
                ( $rowAlt ) else
                    ( $rowBase )
        )
```

**Ubicación:** Stage ConsultaInformacionCliente

### 2. Validación de Logo
```xquery
if($logo != "") then (
    -- Consultar parametrización y programa lealtad
) else (
    $errorCode := 'ERROR'
    $validationMessage := "No se encontró logo para la tarjeta."
)
```

### 3. Sin Lógica Especial para Débito
- No hay validación de tipo de tarjeta
- Todas las tarjetas siguen el mismo flujo

## Manejo de Errores Especial

### Error Handler para ConsultaPuntos

**Nombre:** `_onErrorHandler-9093894123929216395-d318143.16d075d4c4d.-78af`

**Lógica:**
```xquery
-- Captura errores de Mastercard con estructura especial
$errorCode := 
    if(exists($fault/ctx:details/con1:ReceivedFaultDetail/con1:detail/con2:ErrorResp/con2:code)) then (
        string($fault/ctx:details/con1:ReceivedFaultDetail/con1:detail/con2:ErrorResp/con2:code/text())
    ) else (
        string($fault/ctx:errorCode/text())
    )

$validationMessage := 
    if(exists($fault/ctx:details/con1:ReceivedFaultDetail/con1:faultstring)) then (
        string($fault/ctx:details/con1:ReceivedFaultDetail/con1:faultstring/text())
    ) else (
        string($fault/ctx:reason/text())
    )
```

**Acción:** Resume (continúa flujo con variables de error asignadas)

**Namespaces:**
- `con1`: `http://www.bea.com/wli/sb/stages/transform/config`
- `con2`: `http://common.ws.mcrewards.mastercard.com/`

## Validaciones Adicionales

### Validación XSD conDatoCuenta
- Schema: `conDatoCuenta_sp.xsd`
- Element: `con:InputParameters`
- Valida request antes de enviar a conDatoCuenta

### Validación XSD Vision Plus
- Schema: `XMLSchema_769155616.xsd`
- Element: `fdcs:PointsAdjustmentInquiryRequest`
- Valida request antes de enviar a Vision Plus

## Cadenas de Conexión Específicas

### conDatoCuenta_db (MasterDataPA)
- Business Service: `Middleware/v2/BusinessServices/MasterDataPA/conDatoCuenta/biz/conDatoCuenta_db`
- JNDI: (Configurado en Business Service)
- Esquema: MasterDataPA

### canjearPuntosEfectivo_db (PXYNIC)
- Business Service: `Middleware/v2/BusinessServices/PXYNIC/canjearPuntosEfectivo/biz/canjearPuntosEfectivo_db`
- JNDI: (Configurado en Business Service)
- Esquema: PXYNIC (compartido con Nicaragua)

## Archivos Específicos de Panamá

### XQuery
```
Middleware/v2/Resources/MasterDataPA/xq/conDatoCuentaPAIn.xq
Middleware/v2/Resources/ConsultaPuntosLealtad/xq/consultaPuntosLealtadPAOut.xq
Middleware/v2/Resources/ConsultaPuntosLealtad/xq/getPointDetailsInPA.xq
Middleware/v2/Resources/ProgramaLealtad/xq/conversionPuntosNIIn.xq (compartido con NI)
Middleware/v2/Resources/ProgramaLealtad/xq/ConsultaPuntosPA.xq
```

### Business Services
```
Middleware/v2/BusinessServices/MasterDataPA/conDatoCuenta/biz/conDatoCuenta_db.biz
Middleware/v2/BusinessServices/PXYNIC/canjearPuntosEfectivo/biz/canjearPuntosEfectivo_db.biz (compartido con NI)
```

### JAR
```
JAR/2021.8.1.0/MDA-26806/PRD/mwomnicanal_RedencionPuntosLealtadPA.jar
JAR/2021.8.1.0/MDA-26806/QA/mwomniqa_RedencionPuntosLealtadPA.jar
```

## Errores Específicos

| Código | Descripción | Condición |
|--------|-------------|-----------|
| ERROR | No se encontró logo para la tarjeta | logo='' |
| ERROR | CUSTOMER_ID_TYPE no soportado | CUSTOMER_ID_TYPE≠'CARD_NUMBER' |
| ERROR | Programa de lealtad no soportado | programaLealtad no es 1 o 2 |
| [Código Mastercard] | Error de servicio Mastercard | Capturado de ReceivedFaultDetail |

## Comparación con Otras Regiones

| Aspecto | Panamá | Honduras | Guatemala | Nicaragua |
|---------|--------|----------|-----------|-----------|
| Servicio Maestros | conDatoCuenta (PA) | conInfoLealtad | conDatoCuenta (GT) | sjConsultaTipoTarjeta (Java) |
| Registro Priorizado | ALT o BASE | - | BASE | BASE |
| Operación MRS | getPointDetails | getPointDetails | getRTRPreferences | getPointDetails |
| AppID MRS | legalId | legalId | NIT | customerId (19 dígitos) |
| Schema Conversión | PXYNIC | ABK | ABKGT | PXYNIC |
| Moneda | USD | HNL | GTQ | USD |
| Error Handler Especial | Sí (ConsultaPuntos) | No | No | No |
| Validación Débito | No | Sí (Programa 1) | No | Sí (ACTIVE + BIN) |

## Notas de Implementación

1. **Priorización ALT/BASE:**
   - Implementar lógica de selección correcta
   - Validar que ambos tipos de registro existan en BD

2. **Error Handler Mastercard:**
   - Configurar correctamente namespaces
   - Validar estructura de errores de Mastercard

3. **Compartir Recursos con Nicaragua:**
   - Validar que XQuery `conversionPuntosNIIn.xq` funcione para ambas regiones
   - Validar schema PXYNIC compartido

4. **Validaciones XSD:**
   - Habilitar validaciones en ambiente de pruebas
   - Validar schemas antes de despliegue
