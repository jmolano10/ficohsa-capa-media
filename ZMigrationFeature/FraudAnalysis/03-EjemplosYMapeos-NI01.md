# Ejemplos y Mapeos - Región NI01 (Nicaragua)

## Request OSB (SOAP/XML)

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:fra="http://www.ficohsa.com.hn/middleware.services/FraudAnalysisTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:RequestHeader>
         <Authentication>
            <UserName>user_ni01</UserName>
            <Password>********</Password>
         </Authentication>
         <Region>
            <SourceBank>NI01</SourceBank>
            <DestinationBank>NI01</DestinationBank>
         </Region>
      </aut:RequestHeader>
   </soapenv:Header>
   <soapenv:Body>
      <fra:FraudAnalysisRequest>
         <fra:user>USRNI321</fra:user>
         <fra:channel>IVR</fra:channel>
         <fra:idOperationType>BAL004</fra:idOperationType>
         <fra:OperationDesc>Consulta de saldo</fra:OperationDesc>
         <fra:dateTime>2024-01-15T09:15:00</fra:dateTime>
         <fra:debitAccount>1111222233</fra:debitAccount>
         <fra:amount>0.00</fra:amount>
         <fra:optionalParams>
            <fra:entry>
               <fra:key>phoneNumber</fra:key>
               <fra:value>+505-8888-9999</fra:value>
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
            <fra:SCORERISK>5</fra:SCORERISK>
            <fra:TRIGGEREDRULENAME>LOW_RISK_INQUIRY</fra:TRIGGEREDRULENAME>
            <fra:EVENTID>789456126</fra:EVENTID>
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
   <PV_ORIGEN>NI01</PV_ORIGEN>
   <PV_DESTINO>NI01</PV_DESTINO>
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
  "idChannel": "2",
  "idOperation": "BAL004",
  "userId": "USRNI321",
  "eventDate": "2024-01-15T09:15:00",
  "amount": "0.00",
  "debitAccount": "1111222233",
  "optionalParams": [
    {"name": "phoneNumber", "value": "+505-8888-9999"}
  ]
}
```

**Response (JSON)**:
```json
{
  "result": 1,
  "score": 5,
  "eventId": 789456126,
  "ofacCoincidence": 0,
  "error": "",
  "triggeredRules": "LOW_RISK_INQUIRY",
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

1. **Validación Regional**: Verifica que FICBCO0498 esté habilitado para NI01
2. **Sin Región por Defecto**: NI01 debe especificarse explícitamente
3. **Mapeo de Canales**: Convierte nombres a IDs numéricos
4. **Evaluación de Riesgo**: status=1 indica análisis exitoso
5. **Bitácora**: Registra request (FICBCO0498) y response (FICBCO0500)

---
**Región**: NI01 (Nicaragua) | **Versión**: 1.0
