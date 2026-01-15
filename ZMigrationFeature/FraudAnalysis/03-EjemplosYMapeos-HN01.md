# Ejemplos y Mapeos - Región HN01 (Honduras)

## Request OSB (SOAP/XML)

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:fra="http://www.ficohsa.com.hn/middleware.services/FraudAnalysisTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:RequestHeader>
         <Authentication>
            <UserName>user_hn01</UserName>
            <Password>********</Password>
         </Authentication>
         <Region>
            <SourceBank>HN01</SourceBank>
            <DestinationBank>HN01</DestinationBank>
         </Region>
      </aut:RequestHeader>
   </soapenv:Header>
   <soapenv:Body>
      <fra:FraudAnalysisRequest>
         <fra:user>USR123456</fra:user>
         <fra:channel>INTERBANCA_WEB</fra:channel>
         <fra:idOperationType>TRF001</fra:idOperationType>
         <fra:OperationDesc>Transferencia entre cuentas</fra:OperationDesc>
         <fra:dateTime>2024-01-15T10:30:00</fra:dateTime>
         <fra:debitAccount>1234567890</fra:debitAccount>
         <fra:creditAccount>0987654321</fra:creditAccount>
         <fra:amount>5000.00</fra:amount>
         <fra:optionalParams>
            <fra:entry>
               <fra:key>ipAddress</fra:key>
               <fra:value>192.168.1.100</fra:value>
            </fra:entry>
         </fra:optionalParams>
      </fra:FraudAnalysisRequest>
   </soapenv:Body>
</soapenv:Envelope>
```

## Response OSB (SOAP/XML)

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:fra="http://www.ficohsa.com.hn/middleware.services/FraudAnalysisTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:ResponseHeader>
         <messageId>0</messageId>
         <successIndicator>Success</successIndicator>
         <messages></messages>
      </aut:ResponseHeader>
   </soapenv:Header>
   <soapenv:Body>
      <fra:FraudAnalysisResponse>
         <fra:FraudAnalysisRecordType>
            <fra:ACTION>ALLOW</fra:ACTION>
            <fra:SCORERISK>15</fra:SCORERISK>
            <fra:TRIGGEREDRULENAME>LOW_RISK_PROFILE</fra:TRIGGEREDRULENAME>
            <fra:EVENTID>789456123</fra:EVENTID>
         </fra:FraudAnalysisRecordType>
      </fra:FraudAnalysisResponse>
   </soapenv:Body>
</soapenv:Envelope>
```

## Servicios Dependientes

### 1. ValidaServicioRegional_db

**Request**:
```xml
<InputParameters>
   <PV_SERVICIO>FICBCO0498</PV_SERVICIO>
   <PV_ORIGEN>HN01</PV_ORIGEN>
   <PV_DESTINO>HN01</PV_DESTINO>
</InputParameters>
```

**Response**:
```xml
<OutputParameters>
   <PV_CODIGO_ERROR>SUCCESS</PV_CODIGO_ERROR>
   <PV_MENSAJE_ERROR></PV_MENSAJE_ERROR>
</OutputParameters>
```

**Conexión**: eis/DB/ConnectionMiddleware | SP: MW_P_VALIDA_SERVICIO_REGIONAL

### 2. GetAPIAuth_BS

**Request**:
```xml
<InputParameters>
   <PV_NOMBRE_APP>REGFRAUD</PV_NOMBRE_APP>
</InputParameters>
```

**Response**:
```xml
<OutputParameters>
   <PV_CLAVE>eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...</PV_CLAVE>
</OutputParameters>
```

**Conexión**: eis/DB/ConnectionMiddleware | Schema: MIDDLEWARE2 | SP: MW_P_OBTENER_APIREST_AUT

### 3. FraudAnalysis_BS (VU Security)

**Request (JSON)**:
```json
{
  "apiKey": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9...",
  "idChannel": "1",
  "idOperation": "TRF001",
  "userId": "USR123456",
  "eventDate": "2024-01-15T10:30:00",
  "amount": "5000.00",
  "debitAccount": "1234567890",
  "creditAccount": "0987654321",
  "optionalParams": [
    {"name": "ipAddress", "value": "192.168.1.100"}
  ]
}
```

**Response (JSON)**:
```json
{
  "result": 1,
  "score": 15,
  "eventId": 789456123,
  "ofacCoincidence": 0,
  "error": "",
  "triggeredRules": "LOW_RISK_PROFILE",
  "status": 1
}
```

**Endpoint**: https://10.242.25.20:8080/FraudAnalysis/service | Operación: analyze

## Mapeos de Entrada

### OSB → ValidaServicioRegional_db

| Campo Origen | Transformación | Campo Destino |
|--------------|----------------|---------------|
| Constante | "FICBCO0498" | PV_SERVICIO |
| Header: Region/SourceBank | Directo | PV_ORIGEN |
| Header: Region/DestinationBank | Directo | PV_DESTINO |

**XQuery**: validaServicioRegionalIn.xqy

### OSB → GetAPIAuth_BS

| Campo Origen | Transformación | Campo Destino |
|--------------|----------------|---------------|
| Constante | "REGFRAUD" | PV_NOMBRE_APP |

**XQuery**: DeviceManagement_To_API_Token_Request.xqy

### OSB → FraudAnalysis_BS (VU Security)

| Campo Origen | Transformación | Campo Destino |
|--------------|----------------|---------------|
| Variable $apiKey | Directo | apiKey |
| channel | INTERBANCA_WEB→1, IVR→2, ATM→3, INTERBANCA_APP→4 | idChannel |
| idOperationType | Directo | idOperation |
| user | Directo | userId |
| dateTime | Directo | eventDate |
| amount | Directo | amount |
| debitAccount | Directo | debitAccount |
| creditAccount | Condicional (si existe) | creditAccount |
| optionalParams/entry | key→name, value→value | optionalParams[] |

**XQuery**: FraudAnalysis_To_VU.xqy

**Fragmento clave**:
```xquery
<idChannel>{
  if(fn:data($fraudAnalysis/channel)='INTERBANCA_WEB') then 1
  else if(fn:data($fraudAnalysis/channel)='IVR') then 2
  else if(fn:data($fraudAnalysis/channel)='ATM') then 3
  else if(fn:data($fraudAnalysis/channel)='INTERBANCA_APP') then 4
  else ()
}</idChannel>
```

## Mapeos de Salida

### FraudAnalysis_BS → OSB

| Campo Origen | Transformación | Campo Destino |
|--------------|----------------|---------------|
| result | 1→ALLOW, 2→AUTHENTICATE, 3→DENY, 4→CHECK_OPERATION, 5→BLOCK, 6→CHECK_BY_AGENT | ACTION |
| score | Directo | SCORERISK |
| triggeredRules | Directo | TRIGGEREDRULENAME |
| eventId | Directo | EVENTID |
| status | if=1 then "Success" else "ERROR" | successIndicator |

**XQuery**: Vu_To_FraudAnalysis_Response.xqy

## Reglas de Negocio

1. **Validación Regional**: Verifica que FICBCO0498 esté habilitado para HN01
2. **Región por Defecto**: Si SourceBank vacío → "HN01"
3. **Mapeo de Canales**: Convierte nombres a IDs numéricos
4. **Evaluación de Riesgo**: status=1 indica análisis exitoso
5. **Bitácora**: Registra request (FICBCO0498) y response (FICBCO0500)

---
**Región**: HN01 (Honduras) | **Versión**: 1.0
