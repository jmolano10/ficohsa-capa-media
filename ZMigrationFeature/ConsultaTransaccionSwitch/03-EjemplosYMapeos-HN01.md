# Ejemplos y Mapeos - HN01 (Honduras)

## Request OSB (Ejemplo JSON/XML)

### Request SOAP Completo
```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:cons="http://www.ficohsa.com.hn/middleware.services/consultaTransaccionSwitchTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:RequestHeader>
         <Authentication>
            <UserName>USUARIO_LDAP</UserName>
            <Password>opcional</Password>
         </Authentication>
         <Region>
            <SourceBank>HN01</SourceBank>
            <DestinationBank>HN01</DestinationBank>
         </Region>
      </aut:RequestHeader>
   </soapenv:Header>
   <soapenv:Body>
      <cons:consultaTransaccionSwitch>
         <TRANSACTION_ID>TXN123456789</TRANSACTION_ID>
      </cons:consultaTransaccionSwitch>
   </soapenv:Body>
</soapenv:Envelope>
```

## Response OSB (Ejemplo JSON/XML)

### Response SOAP Exitoso
```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
   <soapenv:Header>
      <aut:ResponseHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
         <successIndicator>SUCCESS</successIndicator>
         <messages>Consulta Exitosa</messages>
      </aut:ResponseHeader>
   </soapenv:Header>
   <soapenv:Body>
      <cons:consultaTransaccionSwitchResponse xmlns:cons="http://www.ficohsa.com.hn/middleware.services/consultaTransaccionSwitchTypes">
         <TRANSACTION_ID>TXN123456789</TRANSACTION_ID>
         <ATM_ID>ATM001</ATM_ID>
         <NETWORK_ID>VISA</NETWORK_ID>
         <ATM_TRACE_NUMBER>987654</ATM_TRACE_NUMBER>
         <FULL_TRACE_NUMBER>HN01987654321</FULL_TRACE_NUMBER>
         <TRANSACTION_DATE>20240115</TRANSACTION_DATE>
         <TRANSACTION_TIME>143025</TRANSACTION_TIME>
         <AMOUNT>500.00</AMOUNT>
         <CURRENCY>HNL</CURRENCY>
         <AUTHORIZATION>AUTH123</AUTHORIZATION>
         <MCCCODE>6011</MCCCODE>
         <BRANCH_NAME>SUCURSAL CENTRO</BRANCH_NAME>
      </cons:consultaTransaccionSwitchResponse>
   </soapenv:Body>
</soapenv:Envelope>
```

### Response SOAP Sin Resultados
```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
   <soapenv:Header>
      <aut:ResponseHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
         <successIndicator>NO RECORDS</successIndicator>
         <messages>No se encontraron registros para la transacción solicitada</messages>
      </aut:ResponseHeader>
   </soapenv:Header>
   <soapenv:Body>
      <cons:consultaTransaccionSwitchResponse xmlns:cons="http://www.ficohsa.com.hn/middleware.services/consultaTransaccionSwitchTypes"/>
   </soapenv:Body>
</soapenv:Envelope>
```

## Requests/Responses Internos

### 1. Validación Regional (Base de Datos)

#### Request a ValidaServicioRegional_db
```xml
<ns0:InputParameters xmlns:ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/ValidaServicioRegional">
   <ns0:PV_SERVICIO>FICBCO0141</ns0:PV_SERVICIO>
   <ns0:PV_ORIGEN>HN01</ns0:PV_ORIGEN>
   <ns0:PV_DESTINO>HN01</ns0:PV_DESTINO>
</ns0:InputParameters>
```

#### Response de ValidaServicioRegional_db (Exitoso)
```xml
<ns0:OutputParameters xmlns:ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/ValidaServicioRegional">
   <ns0:PV_CODIGO_ERROR>SUCCESS</ns0:PV_CODIGO_ERROR>
   <ns0:PV_MENSAJE_ERROR>Servicio habilitado para la región</ns0:PV_MENSAJE_ERROR>
</ns0:OutputParameters>
```

### 2. Consulta a T24 (Web Service)

#### Request a consultasTransacciones
```xml
<ns0:Consultadetransaccionswitch xmlns:ns0="T24WebServicesImpl">
   <WebRequestCommon>
      <userName>T24USER</userName>
      <password>T24PASS</password>
   </WebRequestCommon>
   <WSSWITCHTRANSACTIONType>
      <enquiryInputCollection>
         <columnName>TXN.REF</columnName>
         <criteriaValue>TXN123456789</criteriaValue>
         <operand>EQ</operand>
      </enquiryInputCollection>
   </WSSWITCHTRANSACTIONType>
</ns0:Consultadetransaccionswitch>
```

#### Response de consultasTransacciones (Exitoso)
```xml
<ConsultadetransaccionswitchResponse xmlns="T24WebServicesImpl">
   <Status>
      <successIndicator>Success</successIndicator>
   </Status>
   <WSSWITCHTRANSACTIONType>
      <gWSSWITCHTRANSACTIONDetailType>
         <mWSSWITCHTRANSACTIONDetailType>
            <ID>HN01987654321</ID>
            <TXNREFERENCE>TXN123456789</TXNREFERENCE>
            <VALUEDATE>20240115</VALUEDATE>
            <CURRENCY>HNL</CURRENCY>
            <AMOUNT>500.00</AMOUNT>
            <ATMID>ATM001</ATMID>
            <NETWORKID>VISA</NETWORKID>
            <TRACENUMBER>987654</TRACENUMBER>
            <TXNDATE>20240115</TXNDATE>
            <TXNTIME>143025</TXNTIME>
            <MCCCODE>6011</MCCCODE>
            <AUTHCODE>AUTH123</AUTHCODE>
            <BRANCHNAME>SUCURSAL CENTRO</BRANCHNAME>
         </mWSSWITCHTRANSACTIONDetailType>
      </gWSSWITCHTRANSACTIONDetailType>
   </WSSWITCHTRANSACTIONType>
</ConsultadetransaccionswitchResponse>
```

## Cadenas de Conexión y Credenciales

### Base de Datos (Validación Regional)
- **Tipo:** Oracle Database via JCA Adapter
- **JNDI:** `eis/DB/ConnectionMiddleware`
- **Stored Procedure:** `MW_P_VALIDA_SERVICIO_REGIONAL`
- **Esquema:** No especificado (inferido del pool de conexión)
- **Parámetros IN:**
  - `PV_SERVICIO`: VARCHAR2 - Código del servicio
  - `PV_ORIGEN`: VARCHAR2 - Región origen
  - `PV_DESTINO`: VARCHAR2 - Región destino
- **Parámetros OUT:**
  - `PV_CODIGO_ERROR`: VARCHAR2 - Código de resultado
  - `PV_MENSAJE_ERROR`: VARCHAR2 - Mensaje descriptivo

### Web Service T24
- **Endpoints (Load Balanced):**
  1. `http://10.9.104.97:7003/svcConsultasTransacciones/services`
  2. `http://10.9.104.32:7004/svcConsultasTransacciones/services`
  3. `http://10.9.104.97:7005/svcConsultasTransacciones/services`
  4. `http://10.9.104.32:7006/svcConsultasTransacciones/services`
- **Namespace:** `T24WebServicesImpl`
- **Operación:** `Consultadetransaccionswitch`
- **Enquiry T24:** `WS.SWITCH.TRANSACTION`
- **Credenciales:** Obtenidas de LDAP OSB (`Middleware/Security/{USERNAME}`)

## Tablas de Mapeo

### Mapeo de Entrada: OSB → ValidaServicioRegional_db

| Campo Origen (OSB) | Transformación | Campo Destino (DB) |
|-------------------|----------------|-------------------|
| Constante | "FICBCO0141" | PV_SERVICIO |
| RequestHeader/Region/SourceBank | Directo | PV_ORIGEN |
| RequestHeader/Region/DestinationBank | Directo | PV_DESTINO |

### Mapeo de Entrada: OSB → T24

| Campo Origen (OSB) | Transformación | Campo Destino (T24) |
|-------------------|----------------|-------------------|
| RequestHeader/Authentication/UserName | getUsername() - LDAP lookup | WebRequestCommon/userName |
| RequestHeader/Authentication/UserName | getPassword() - LDAP lookup con failover | WebRequestCommon/password |
| consultaTransaccionSwitch/TRANSACTION_ID | Directo | WSSWITCHTRANSACTIONType/enquiryInputCollection/criteriaValue |
| Constante | "TXN.REF" | WSSWITCHTRANSACTIONType/enquiryInputCollection/columnName |
| Constante | "EQ" | WSSWITCHTRANSACTIONType/enquiryInputCollection/operand |

### Mapeo de Salida: T24 → OSB

| Campo Origen (T24) | Transformación | Campo Destino (OSB) |
|-------------------|----------------|-------------------|
| WSSWITCHTRANSACTIONType[1]/.../TXNREFERENCE | data() | consultaTransaccionSwitchResponse/TRANSACTION_ID |
| WSSWITCHTRANSACTIONType[1]/.../ATMID | data() | consultaTransaccionSwitchResponse/ATM_ID |
| WSSWITCHTRANSACTIONType[1]/.../NETWORKID | data() | consultaTransaccionSwitchResponse/NETWORK_ID |
| WSSWITCHTRANSACTIONType[1]/.../TRACENUMBER | data() | consultaTransaccionSwitchResponse/ATM_TRACE_NUMBER |
| WSSWITCHTRANSACTIONType[1]/.../ID | data() | consultaTransaccionSwitchResponse/FULL_TRACE_NUMBER |
| WSSWITCHTRANSACTIONType[1]/.../TXNDATE | data() | consultaTransaccionSwitchResponse/TRANSACTION_DATE |
| WSSWITCHTRANSACTIONType[1]/.../TXNTIME | data() | consultaTransaccionSwitchResponse/TRANSACTION_TIME |
| WSSWITCHTRANSACTIONType[1]/.../AMOUNT | data() | consultaTransaccionSwitchResponse/AMOUNT |
| WSSWITCHTRANSACTIONType[1]/.../CURRENCY | data() | consultaTransaccionSwitchResponse/CURRENCY |
| WSSWITCHTRANSACTIONType[1]/.../AUTHCODE | data() | consultaTransaccionSwitchResponse/AUTHORIZATION |
| WSSWITCHTRANSACTIONType[1]/.../MCCCODE | data() | consultaTransaccionSwitchResponse/MCCCODE |
| WSSWITCHTRANSACTIONType[1]/.../BRANCHNAME | data() | consultaTransaccionSwitchResponse/BRANCH_NAME |

## Reglas de Negocio Detalladas

### RN-001: Obtención de Credenciales LDAP
**Archivo:** `consultaTransaccionSwitchHNIn.xq`
**Líneas:** 15-27

```xquery
declare function getUsername ($LDAPUsername as xs:string) as xs:string { 
    let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
    return $data/con:username/text()
};

declare function getPassword ($LDAPUsername as xs:string) as xs:string {      
    let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
    return $data/con:password/text()
};
```

**Uso:**
```xquery
<userName>{ fn-bea:fail-over( getUsername(data($requestHeader/Authentication/UserName)), 
                              data($requestHeader/Authentitacion/UserName)) }</userName>
<password>{ fn-bea:fail-over( getPassword(data($requestHeader/Authentication/UserName)),
                              data($requestHeader/Authentication/Password)) }</password>
```

### RN-002: Detección de Sin Resultados
**Archivo:** `ConsultaTransaccionSwitch.proxy`
**Stage:** ConsultaCoreResponse

```xquery
if (empty($RSPConsultadetransaccionswitch/WSSWITCHTRANSACTIONType[1]/ZERORECORDS/text())) then (
    "SUCCESS"
) else (
    "NO RECORDS"
)
```

### RN-003: Construcción de ResponseHeader
**Archivo:** `consultaTransaccionSwitchHOut.xq`

```xquery
<ns0:ResponseHeader>   
    <successIndicator>{ $Error }</successIndicator>
    <messages>{ $Message }</messages>
</ns0:ResponseHeader>
```

**Parámetros:**
- `$Error`: "SUCCESS" o "NO RECORDS"
- `$Message`: "Consulta Exitosa" o contenido de ZERORECORDS
