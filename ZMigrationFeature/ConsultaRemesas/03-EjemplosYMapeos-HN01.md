# Ejemplos y Mapeos de Datos - HN01 (Honduras)

## Request OSB (Ejemplo JSON/XML)

### Consulta por ID de Remesa
```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:cons="http://www.ficohsa.com.hn/middleware.services/consultaRemesasTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:RequestHeader>
         <Authentication>
            <UserName>USRHNDEMO</UserName>
            <Password>password123</Password>
         </Authentication>
         <Region>
            <SourceBank>HN01</SourceBank>
         </Region>
      </aut:RequestHeader>
   </soapenv:Header>
   <soapenv:Body>
      <cons:consultaRemesas>
         <REMITTANCE_ID>REM123456789</REMITTANCE_ID>
      </cons:consultaRemesas>
   </soapenv:Body>
</soapenv:Envelope>
```

### Consulta por Nombres
```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:cons="http://www.ficohsa.com.hn/middleware.services/consultaRemesasTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:RequestHeader>
         <Authentication>
            <UserName>USRHNDEMO</UserName>
            <Password>password123</Password>
         </Authentication>
         <Region>
            <SourceBank>HN01</SourceBank>
         </Region>
      </aut:RequestHeader>
   </soapenv:Header>
   <soapenv:Body>
      <cons:consultaRemesas>
         <REMITTER_FIRSTNAME>JUAN</REMITTER_FIRSTNAME>
         <REMITTER_FIRSTSURNAME>PEREZ</REMITTER_FIRSTSURNAME>
         <BENEFICIARY_FIRSTNAME>MARIA</BENEFICIARY_FIRSTNAME>
         <BENEFICIARY_FIRSTSURNAME>LOPEZ</BENEFICIARY_FIRSTSURNAME>
      </cons:consultaRemesas>
   </soapenv:Body>
</soapenv:Envelope>
```

## Response OSB (Ejemplo JSON/XML)

### Respuesta Exitosa
```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
                  xmlns:cons="http://www.ficohsa.com.hn/middleware.services/consultaRemesasTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:ResponseHeader>
         <successIndicator>SUCCESS</successIndicator>
         <messages>Consulta exitosa</messages>
      </aut:ResponseHeader>
   </soapenv:Header>
   <soapenv:Body>
      <cons:consultaRemesasResponse>
         <consultaRemesasResponseType>
            <consultaRemesasResponseRecordType>
               <REMITTANCE_ID>REM123456789</REMITTANCE_ID>
               <REMITTER_ID>RMT001</REMITTER_ID>
               <REMITTER_NAME>JUAN CARLOS PEREZ MARTINEZ</REMITTER_NAME>
               <BENEFICIARY_NAME>MARIA ELENA LOPEZ GARCIA</BENEFICIARY_NAME>
               <BRANCH_NAME>SUCURSAL TEGUCIGALPA</BRANCH_NAME>
               <PAYMENT_DATE>2024-01-15</PAYMENT_DATE>
               <CURRENCY>HNL</CURRENCY>
               <EXCHANGE_RATE>24.75</EXCHANGE_RATE>
               <REMITTANCE_STATUS>DISPONIBLE</REMITTANCE_STATUS>
               <REMITTANCE_AMOUNT>2500.00</REMITTANCE_AMOUNT>
               <REMITTANCE_SOURCE_AMOUNT>100.00</REMITTANCE_SOURCE_AMOUNT>
               <ORIGIN_COUNTRY>USA</ORIGIN_COUNTRY>
            </consultaRemesasResponseRecordType>
         </consultaRemesasResponseType>
      </cons:consultaRemesasResponse>
   </soapenv:Body>
</soapenv:Envelope>
```

## Requests/Responses Internos a Servicios Dependientes

### 1. ObtenerTipoRemesadora (Base de Datos)

#### Request:
```xml
<ns0:InputParameters xmlns:ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/ObtenerTipoRemesadora">
    <ns0:PV_CLAVE>REM123456789</ns0:PV_CLAVE>
    <ns0:PV_USUARIO_SERVICIO>USRHNDEMO</ns0:PV_USUARIO_SERVICIO>
</ns0:InputParameters>
```

#### Response:
```xml
<ns0:OutputParameters xmlns:ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/ObtenerTipoRemesadora">
    <ns0:PV_SUCCESS_INDICATOR>SUCCESS</ns0:PV_SUCCESS_INDICATOR>
    <ns0:PV_MESSAGES>Consulta exitosa</ns0:PV_MESSAGES>
    <ns0:PT_TIPOS_REMESADORAS>
        <ns0:PT_TIPOS_REMESADORAS_ITEM>
            <ns0:PV_TIPO_REMESADORA>ONLINE</ns0:PV_TIPO_REMESADORA>
            <ns0:PV_ABREVIATURA_REMESADORA>MGM</ns0:PV_ABREVIATURA_REMESADORA>
            <ns0:PN_ID_CONVENIO>12345</ns0:PN_ID_CONVENIO>
            <ns0:PV_ID_CONVENIO_T24>T24-MGM-001</ns0:PV_ID_CONVENIO_T24>
        </ns0:PT_TIPOS_REMESADORAS_ITEM>
    </ns0:PT_TIPOS_REMESADORAS>
</ns0:OutputParameters>
```

### 2. sjConsultaMultipleRemesadoras (SJS - Online)

#### Request:
```xml
<cons:sjConsultaMultipleRemesadoras xmlns:cons="http://www.ficohsa.com.hn/middleware.services/sjConsultaMultipleRemesadoras">
    <cons:REMITTANCE_ID>REM123456789</cons:REMITTANCE_ID>
    <cons:USER_NAME>USRHNDEMO</cons:USER_NAME>
    <cons:REMITTERS>
        <cons:REMITTER_ITEM>
            <cons:REMITTER_ID>MGM</cons:REMITTER_ID>
            <cons:AGREEMENT_ID>12345</cons:AGREEMENT_ID>
            <cons:AGREEMENT_ID_T24>T24-MGM-001</cons:AGREEMENT_ID_T24>
            <cons:PRIORITY>1</cons:PRIORITY>
        </cons:REMITTER_ITEM>
    </cons:REMITTERS>
</cons:sjConsultaMultipleRemesadoras>
```

#### Response:
```xml
<cons:sjConsultaMultipleRemesadorasResponse xmlns:cons="http://www.ficohsa.com.hn/middleware.services/sjConsultaMultipleRemesadoras">
    <cons:SUCCESS_INDICATOR>SUCCESS</cons:SUCCESS_INDICATOR>
    <cons:REMITTANCE>
        <cons:ROUTER_RESPONSE>
            <cons:ABBREVIATION_REMITTANCE>MGM</cons:ABBREVIATION_REMITTANCE>
            <cons:AGREEMENT_ID>12345</cons:AGREEMENT_ID>
            <cons:AGREEMENT_ID_T24>T24-MGM-001</cons:AGREEMENT_ID_T24>
            <cons:PRIORITY>1</cons:PRIORITY>
            <cons:RESPONSEDATA>
                <errorCode>0</errorCode>
                <primaryKey>REM123456789</primaryKey>
                <totalAmount>100.00</totalAmount>
                <remitterName>JUAN CARLOS PEREZ MARTINEZ</remitterName>
                <beneficiaryName>MARIA ELENA LOPEZ GARCIA</beneficiaryName>
                <status>AVAILABLE</status>
            </cons:RESPONSEDATA>
        </cons:ROUTER_RESPONSE>
    </cons:REMITTANCE>
</cons:sjConsultaMultipleRemesadorasResponse>
```

### 3. consultarRemLocalId (Remesas Locales)

#### Request:
```xml
<ns0:InputParameters xmlns:ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarRemLocalId">
    <ns0:PV_CLAVE_REMESA>REM123456789</ns0:PV_CLAVE_REMESA>
</ns0:InputParameters>
```

#### Response:
```xml
<ns0:OutputParameters xmlns:ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarRemLocalId">
    <ns0:PV_ESTADO>
        <ns0:PV_CLAVE_ITEM>DISPONIBLE</ns0:PV_CLAVE_ITEM>
    </ns0:PV_ESTADO>
    <ns0:PV_REMITENTE>JUAN CARLOS PEREZ MARTINEZ</ns0:PV_REMITENTE>
    <ns0:PV_BENEFICIARIO>MARIA ELENA LOPEZ GARCIA</ns0:PV_BENEFICIARIO>
    <ns0:PV_MONTO>2500.00</ns0:PV_MONTO>
    <ns0:PV_MONEDA>HNL</ns0:PV_MONEDA>
    <ns0:PV_FECHA_PAGO>2024-01-15</ns0:PV_FECHA_PAGO>
</ns0:OutputParameters>
```

## Cadenas de Conexión y Credenciales

### Base de Datos (JCA)
- **Conexión**: `jca://eis/DB/ConnectionMiddleware`
- **Tipo**: Oracle Database Adapter
- **Pool**: ConnectionMiddleware
- **Esquemas**: 
  - T24 (Core Banking)
  - FLink (Tablas auxiliares)
  - MDW (Middleware)

### Servicios WSDL
- **SJS ConsultaMultipleRemesadoras**:
  - Endpoint: `http://172.23.13.19:8003/Middleware/SJS/ConsultaMultipleRemesadoras`
  - Operación: `consultaRemesadoras`
  - Protocolo: SOAP 1.1

- **T24 Resiliencia**:
  - Endpoint: Configurado en T24
  - Operación: `Consultaderemesa`
  - Protocolo: SOAP 1.1

## Tablas de Mapeo de Entrada

### 1. OSB → ObtenerTipoRemesadora

| Campo Origen (OSB) | Transformación/Script | Campo Destino (BD) |
|-------------------|----------------------|-------------------|
| `REMITTANCE_ID` | Directo | `PV_CLAVE` |
| `RequestHeader/Authentication/UserName` | Directo | `PV_USUARIO_SERVICIO` |

### 2. OSB → sjConsultaMultipleRemesadoras

| Campo Origen (OSB) | Transformación/Script | Campo Destino (SJS) |
|-------------------|----------------------|-------------------|
| `REMITTANCE_ID` | Directo | `REMITTANCE_ID` |
| `RequestHeader/Authentication/UserName` | Directo | `USER_NAME` |
| `RSPObtenerTipoRemesadora/PT_TIPOS_REMESADORAS` | `sjconsultaMultipleRemesadorasIn.xq` | `REMITTERS/REMITTER_ITEM` |

### 3. OSB → consultarRemLocalId

| Campo Origen (OSB) | Transformación/Script | Campo Destino (BD) |
|-------------------|----------------------|-------------------|
| `REMITTANCE_ID` | Directo | `PV_CLAVE_REMESA` |

### 4. OSB → consultaRemesaT24

| Campo Origen (OSB) | Transformación/Script | Campo Destino (T24) |
|-------------------|----------------------|-------------------|
| `REMITTANCE_ID` | `consultaRemesaT24In.xq` | `REMITTANCE_ID` |
| `RequestHeader` | `consultaRemesaT24In.xq` | `HEADER_INFO` |

## Tablas de Mapeo de Salida

### 1. sjConsultaMultipleRemesadoras → OSB

| Campo Origen (SJS) | Transformación/Script | Campo Destino (OSB) |
|-------------------|----------------------|-------------------|
| `RESPONSEDATA/primaryKey` | `EnrutadorConveniosOut.xq` | `REMITTANCE_ID` |
| `RESPONSEDATA/remitterName` | `EnrutadorConveniosOut.xq` | `REMITTER_NAME` |
| `RESPONSEDATA/beneficiaryName` | `EnrutadorConveniosOut.xq` | `BENEFICIARY_NAME` |
| `RESPONSEDATA/totalAmount` | `EnrutadorConveniosOut.xq` | `REMITTANCE_AMOUNT` |
| `RESPONSEDATA/status` | Mapeo de estados | `REMITTANCE_STATUS` |

### 2. consultarRemLocalId → OSB

| Campo Origen (BD) | Transformación/Script | Campo Destino (OSB) |
|-------------------|----------------------|-------------------|
| `PV_CLAVE_ITEM` | `consultaRemLocalIdOut.xq` | `REMITTANCE_ID` |
| `PV_REMITENTE` | `consultaRemLocalIdOut.xq` | `REMITTER_NAME` |
| `PV_BENEFICIARIO` | `consultaRemLocalIdOut.xq` | `BENEFICIARY_NAME` |
| `PV_MONTO` | `consultaRemLocalIdOut.xq` | `REMITTANCE_AMOUNT` |
| `PV_ESTADO/PV_CLAVE_ITEM` | Mapeo de estados | `REMITTANCE_STATUS` |

### 3. T24 → OSB

| Campo Origen (T24) | Transformación/Script | Campo Destino (OSB) |
|-------------------|----------------------|-------------------|
| `REMITTANCE_DATA` | `consultaRemesasOut.xq` | `consultaRemesasResponseType` |
| `STATUS` | Mapeo de estados T24 | `REMITTANCE_STATUS` |
| `AMOUNT` | Formateo numérico | `REMITTANCE_AMOUNT` |

## Reglas de Negocio Detectadas

### 1. Determinación de Tipo de Consulta
- **Archivo**: `validarTipoConsulta.xq`
- **Regla**: Si `REMITTANCE_ID` no está vacío → `ID_BASED`, sino evalúa nombres
- **Validación Nombres**: Requiere (firstName OR middleName) AND (firstSurname OR secondSurname)

### 2. Validación de Permisos de Usuario
- **Archivo**: `ConsultaRemesas.proxy` (líneas de validación)
- **Regla**: Usuario debe tener permiso para consultar tipo de remesadora específico
- **Parámetro**: `T24C070.{USUARIO}.REMITALLOW`

### 3. Priorización de Remesadoras Online
- **Archivo**: `ConsultaRemesas.proxy` (response pipeline)
- **Regla**: Si múltiples remesadoras, seleccionar por menor valor de `PRIORITY`
- **Código**: `min($RSPconsultaRemesadoras/cons:REMITTANCE/cons:ROUTER_RESPONSE/cons:PRIORITY)`

### 4. Validación de Estado de Remesa
- **Archivos**: Múltiples transformaciones
- **Regla**: Solo procesar remesas con estado `DISPONIBLE`
- **Aplicación**: Remesas locales y Ficohsa Remesas

### 5. Evaluación de Listas Restrictivas
- **Archivo**: `EvaluaListasCliente.proxy`
- **Regla**: Validar remitente/beneficiario contra listas restrictivas
- **Condición**: `$checkListsEvaluarLista = 'Yes' and fn:matches($checkRemitterIdEvaluarLista,$remittSource)`

### 6. Registro de Auditoría
- **Archivo**: `ingresoRelConsPagoRem.xq`
- **Regla**: Registrar relación consulta-pago para remesas disponibles
- **Aplicación**: Solo para remesas con estado `DISPONIBLE`

### 7. Mapeo de Estados
- **Transformaciones**: Múltiples archivos `*Out.xq`
- **Reglas**:
  - `AVAILABLE` → `DISPONIBLE`
  - `PAID` → `PAGADA`
  - `CANCELLED` → `CANCELADA`
  - `EXPIRED` → `VENCIDA`

### 8. Validación Regional
- **Archivo**: `ValidaServicioRegional`
- **Regla**: Validar que el servicio esté habilitado para la región
- **ServiceId**: `FICBCO0148`
- **Región**: Extraída de `RequestHeader/Region/SourceBank`