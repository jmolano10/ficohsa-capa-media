# Ejemplos y Mapeos - HN01 (Honduras)

## Request OSB (Ejemplo JSON/XML)

### Ejemplo 1: Consulta de Cuentas de Ahorro

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:RequestHeader>
         <Authentication>
            <UserName>USUARIO_HN</UserName>
            <Password>PASSWORD123</Password>
         </Authentication>
         <Region>
            <SourceBank>HN01</SourceBank>
            <DestinationBank>HN01</DestinationBank>
         </Region>
      </aut:RequestHeader>
   </soapenv:Header>
   <soapenv:Body>
      <con:consultaActivosClienteRequest>
         <CUSTOMER_ID>100123456</CUSTOMER_ID>
         <ASSET_TYPE>AHO</ASSET_TYPE>
      </con:consultaActivosClienteRequest>
   </soapenv:Body>
</soapenv:Envelope>
```

### Ejemplo 2: Consulta de Fondos de Pensiones

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:RequestHeader>
         <Authentication>
            <UserName>USUARIO_HN</UserName>
            <Password>PASSWORD123</Password>
         </Authentication>
         <Region>
            <SourceBank>HN01</SourceBank>
            <DestinationBank>HN01</DestinationBank>
         </Region>
      </aut:RequestHeader>
   </soapenv:Header>
   <soapenv:Body>
      <con:consultaActivosClienteRequest>
         <CUSTOMER_ID>100123456</CUSTOMER_ID>
         <ASSET_TYPE>FPC</ASSET_TYPE>
      </con:consultaActivosClienteRequest>
   </soapenv:Body>
</soapenv:Envelope>
```

### Ejemplo 3: Consulta de Cuentas Corrientes

```xml
<con:consultaActivosClienteRequest>
   <CUSTOMER_ID>100123456</CUSTOMER_ID>
   <ASSET_TYPE>CHQ</ASSET_TYPE>
</con:consultaActivosClienteRequest>
```

### Ejemplo 4: Consulta de Certificados de Depósito

```xml
<con:consultaActivosClienteRequest>
   <CUSTOMER_ID>100123456</CUSTOMER_ID>
   <ASSET_TYPE>DEP</ASSET_TYPE>
</con:consultaActivosClienteRequest>
```

### Ejemplo 5: Consulta de Todos los Activos

```xml
<con:consultaActivosClienteRequest>
   <CUSTOMER_ID>100123456</CUSTOMER_ID>
   <ASSET_TYPE>ALL</ASSET_TYPE>
</con:consultaActivosClienteRequest>
```

---

## Response OSB (Ejemplo JSON/XML)

### Respuesta Exitosa - Cuentas de Ahorro

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
   <soapenv:Header>
      <aut:ResponseHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
         <messageId>12345</messageId>
         <successIndicator>SUCCESS</successIndicator>
         <messages>Success</messages>
      </aut:ResponseHeader>
   </soapenv:Header>
   <soapenv:Body>
      <con:consultaActivosClienteResponse xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes">
         <consultaActivosClienteAhorrosResponseType>
            <SUCCESS_INDICATOR>Success</SUCCESS_INDICATOR>
            <consultaActivosClienteResponseRecordType>
               <ASSET_TYPE>AHO</ASSET_TYPE>
               <ASSET_NUMBER>1234567890</ASSET_NUMBER>
               <ASSET_NAME>CUENTA AHORRO CORRIENTE</ASSET_NAME>
               <ASSET_CURRENCY>HNL</ASSET_CURRENCY>
               <ASSET_TOTAL_BALANCE>15000.50</ASSET_TOTAL_BALANCE>
               <ASSET_RESERVE_BALANCE>500.00</ASSET_RESERVE_BALANCE>
               <ASSET_LOCKED_BALANCE>0.00</ASSET_LOCKED_BALANCE>
               <ASSET_VISA_FLOATING_BALANCE>0.00</ASSET_VISA_FLOATING_BALANCE>
               <ASSET_AVAILABLE_BALANCE>14500.50</ASSET_AVAILABLE_BALANCE>
               <ASSET_PRODUCT_TYPE>AHORRO</ASSET_PRODUCT_TYPE>
            </consultaActivosClienteResponseRecordType>
         </consultaActivosClienteAhorrosResponseType>
         <consultaActivosClienteCorrienteResponseType>
            <SUCCESS_INDICATOR>No Records</SUCCESS_INDICATOR>
         </consultaActivosClienteCorrienteResponseType>
         <consultaActivosClienteDepositosResponseType>
            <SUCCESS_INDICATOR>No Records</SUCCESS_INDICATOR>
         </consultaActivosClienteDepositosResponseType>
         <consultaActivosClientePensionesResponseType/>
      </con:consultaActivosClienteResponse>
   </soapenv:Body>
</soapenv:Envelope>
```

### Respuesta Exitosa - Cuentas Corrientes

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
   <soapenv:Header>
      <aut:ResponseHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
         <messageId>12346</messageId>
         <successIndicator>SUCCESS</successIndicator>
         <messages>Success</messages>
      </aut:ResponseHeader>
   </soapenv:Header>
   <soapenv:Body>
      <con:consultaActivosClienteResponse xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes">
         <consultaActivosClienteAhorrosResponseType>
            <SUCCESS_INDICATOR>No Records</SUCCESS_INDICATOR>
         </consultaActivosClienteAhorrosResponseType>
         <consultaActivosClienteCorrienteResponseType>
            <SUCCESS_INDICATOR>Success</SUCCESS_INDICATOR>
            <consultaActivosClienteResponseRecordType>
               <ASSET_TYPE>CHQ</ASSET_TYPE>
               <ASSET_NUMBER>9876543210</ASSET_NUMBER>
               <ASSET_NAME>CUENTA CORRIENTE EMPRESARIAL</ASSET_NAME>
               <ASSET_CURRENCY>HNL</ASSET_CURRENCY>
               <ASSET_TOTAL_BALANCE>85000.00</ASSET_TOTAL_BALANCE>
               <ASSET_RESERVE_BALANCE>5000.00</ASSET_RESERVE_BALANCE>
               <ASSET_LOCKED_BALANCE>2000.00</ASSET_LOCKED_BALANCE>
               <ASSET_VISA_FLOATING_BALANCE>0.00</ASSET_VISA_FLOATING_BALANCE>
               <ASSET_AVAILABLE_BALANCE>78000.00</ASSET_AVAILABLE_BALANCE>
               <ASSET_PRODUCT_TYPE>CORRIENTE</ASSET_PRODUCT_TYPE>
            </consultaActivosClienteResponseRecordType>
         </consultaActivosClienteCorrienteResponseType>
         <consultaActivosClienteDepositosResponseType>
            <SUCCESS_INDICATOR>No Records</SUCCESS_INDICATOR>
         </consultaActivosClienteDepositosResponseType>
         <consultaActivosClientePensionesResponseType/>
      </con:consultaActivosClienteResponse>
   </soapenv:Body>
</soapenv:Envelope>
```

### Respuesta Exitosa - Certificados de Depósito

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
   <soapenv:Header>
      <aut:ResponseHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
         <messageId>12347</messageId>
         <successIndicator>SUCCESS</successIndicator>
         <messages>Success</messages>
      </aut:ResponseHeader>
   </soapenv:Header>
   <soapenv:Body>
      <con:consultaActivosClienteResponse xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes">
         <consultaActivosClienteAhorrosResponseType>
            <SUCCESS_INDICATOR>No Records</SUCCESS_INDICATOR>
         </consultaActivosClienteAhorrosResponseType>
         <consultaActivosClienteCorrienteResponseType>
            <SUCCESS_INDICATOR>No Records</SUCCESS_INDICATOR>
         </consultaActivosClienteCorrienteResponseType>
         <consultaActivosClienteDepositosResponseType>
            <SUCCESS_INDICATOR>Success</SUCCESS_INDICATOR>
            <consultaActivosClienteResponseRecordType>
               <ASSET_TYPE>DEP</ASSET_TYPE>
               <ASSET_NUMBER>CD20240001</ASSET_NUMBER>
               <ASSET_NAME>CERTIFICADO DEPOSITO 12 MESES</ASSET_NAME>
               <ASSET_CURRENCY>HNL</ASSET_CURRENCY>
               <ASSET_TOTAL_BALANCE>100000.00</ASSET_TOTAL_BALANCE>
               <ASSET_RESERVE_BALANCE>0.00</ASSET_RESERVE_BALANCE>
               <ASSET_LOCKED_BALANCE>100000.00</ASSET_LOCKED_BALANCE>
               <ASSET_VISA_FLOATING_BALANCE>0.00</ASSET_VISA_FLOATING_BALANCE>
               <ASSET_AVAILABLE_BALANCE>0.00</ASSET_AVAILABLE_BALANCE>
               <ASSET_PRODUCT_TYPE>DEPOSITO A PLAZO</ASSET_PRODUCT_TYPE>
            </consultaActivosClienteResponseRecordType>
         </consultaActivosClienteDepositosResponseType>
         <consultaActivosClientePensionesResponseType/>
      </con:consultaActivosClienteResponse>
   </soapenv:Body>
</soapenv:Envelope>
```

---

## Requests/Responses Internos a Servicios Dependientes

### 1. Servicio: ValidaServicioRegional

**Request**:
```xml
<InputParameters xmlns="http://xmlns.oracle.com/pcbpel/adapter/db/sp/ValidaServicioRegional">
   <PV_SERVICE_ID>FICBCO0043</PV_SERVICE_ID>
   <PV_SOURCE_BANK>HN01</PV_SOURCE_BANK>
</InputParameters>
```

**Response**:
```xml
<OutputParameters xmlns="http://xmlns.oracle.com/pcbpel/adapter/db/sp/ValidaServicioRegional">
   <PV_CODIGO_ERROR>SUCCESS</PV_CODIGO_ERROR>
   <PV_MENSAJE_ERROR>Servicio habilitado</PV_MENSAJE_ERROR>
</OutputParameters>
```

### 2. Servicio: ConsultaCliente (T24)

**Request**:
```xml
<Consultadecliente xmlns="T24WebServicesImpl">
   <CUSTOMER_ID>100123456</CUSTOMER_ID>
</Consultadecliente>
```

**Response**:
```xml
<WSCUSTOMERType>
   <gWSCUSTOMERDetailType>
      <mWSCUSTOMERDetailType>
         <LEGALID>0801199012345</LEGALID>
         <LEGALDOCNAME>IDENTIDAD</LEGALDOCNAME>
      </mWSCUSTOMERDetailType>
   </gWSCUSTOMERDetailType>
</WSCUSTOMERType>
```

### 3. Servicio: ConsultaCuentaAhorro (T24)

**Request**:
```xml
<ConsultaCuentaAhorroxCliente>
   <CUSTOMER_ID>100123456</CUSTOMER_ID>
</ConsultaCuentaAhorroxCliente>
```

**Response**:
```xml
<ConsultaCuentaAhorroxClienteResponse>
   <ACCOUNT>
      <ACCOUNTNUMBER>1234567890</ACCOUNTNUMBER>
      <ACCOUNTNAME>CUENTA AHORRO CORRIENTE</ACCOUNTNAME>
      <CURRENCY>HNL</CURRENCY>
      <TOTALBALANCE>15000.50</TOTALBALANCE>
      <RESERVEBALANCE>500.00</RESERVEBALANCE>
      <LIENBALANCE>0.00</LIENBALANCE>
      <AVAILABLEBAL>14500.50</AVAILABLEBAL>
      <PRODUCTTYPE>AHORRO</PRODUCTTYPE>
   </ACCOUNT>
</ConsultaCuentaAhorroxClienteResponse>
```

### 3a. Servicio: ConsultaCuentaCorriente (T24)

**Request**:
```xml
<ConsultaCuentaCorrientexCliente>
   <CUSTOMER_ID>100123456</CUSTOMER_ID>
</ConsultaCuentaCorrientexCliente>
```

**Response**:
```xml
<ConsultaCuentaCorrientexClienteResponse>
   <ACCOUNT>
      <ACCOUNTNUMBER>9876543210</ACCOUNTNUMBER>
      <ACCOUNTNAME>CUENTA CORRIENTE EMPRESARIAL</ACCOUNTNAME>
      <CURRENCY>HNL</CURRENCY>
      <TOTALBALANCE>85000.00</TOTALBALANCE>
      <RESERVEBALANCE>5000.00</RESERVEBALANCE>
      <LIENBALANCE>2000.00</LIENBALANCE>
      <AVAILABLEBAL>78000.00</AVAILABLEBAL>
      <PRODUCTTYPE>CORRIENTE</PRODUCTTYPE>
   </ACCOUNT>
</ConsultaCuentaCorrientexClienteResponse>
```

### 3b. Servicio: Consultadecertifdepporcliente (Oracle DB)

**Request**:
```xml
<Consultadecertifdepporcliente>
   <CUSTOMER_ID>100123456</CUSTOMER_ID>
</Consultadecertifdepporcliente>
```

**Response**:
```xml
<ConsultadecertifdepporclienteResponse>
   <CERTIFICATE>
      <CERTIFICATENUMBER>CD20240001</CERTIFICATENUMBER>
      <CERTIFICATENAME>CERTIFICADO DEPOSITO 12 MESES</CERTIFICATENAME>
      <CURRENCY>HNL</CURRENCY>
      <TOTALBALANCE>100000.00</TOTALBALANCE>
      <RESERVEBALANCE>0.00</RESERVEBALANCE>
      <LIENBALANCE>100000.00</LIENBALANCE>
      <AVAILABLEBAL>0.00</AVAILABLEBAL>
      <PRODUCTTYPE>DEPOSITO A PLAZO</PRODUCTTYPE>
   </CERTIFICATE>
</ConsultadecertifdepporclienteResponse>
```

### 4. Servicio: consultaFondoPensiones12c

**Request**:
```xml
<getAssetsCustomer xmlns="http://www.ficohsa.com.hn/middleware.services/pensiones">
   <sourceBank>HN01</sourceBank>
   <destinationBank>HN01</destinationBank>
   <userName>USUARIO_HN</userName>
   <legalId>0801199012345</legalId>
   <legalIdType>1</legalIdType>
</getAssetsCustomer>
```

**Response**:
```xml
<OutputParameters xmlns="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaFondoPensiones">
   <PV_ERROR_CODE>SUCCESS</PV_ERROR_CODE>
   <PV_ASSET_NUMBER>FP123456</PV_ASSET_NUMBER>
   <PV_ASSET_NAME>FONDO PENSION VOLUNTARIO</PV_ASSET_NAME>
   <PV_ASSET_CURRENCY>HNL</PV_ASSET_CURRENCY>
   <PV_ASSET_TOTAL_BALANCE>50000.00</PV_ASSET_TOTAL_BALANCE>
   <PV_ASSET_AVAILABLE_BALANCE>50000.00</PV_ASSET_AVAILABLE_BALANCE>
</OutputParameters>
```

### 5. Servicio: ValidaFuncionalidadUsuario

**Request**:
```xml
<InputParameters xmlns="http://xmlns.oracle.com/pcbpel/adapter/db/sp/ValidaFuncionalidadUsuario">
   <PV_USER_NAME>USUARIO_HN</PV_USER_NAME>
   <PV_FUNCTIONALITY>SALDOS_ACTIVOS</PV_FUNCTIONALITY>
   <PV_SOURCE_BANK>HN01</PV_SOURCE_BANK>
</InputParameters>
```

**Response**:
```xml
<OutputParameters xmlns="http://xmlns.oracle.com/pcbpel/adapter/db/sp/ValidaFuncionalidadUsuario">
   <PV_CODIGO_ERROR>SUCCESS</PV_CODIGO_ERROR>
   <PV_VALOR>ALL</PV_VALOR>
</OutputParameters>
```

---

## Cadenas de Conexión y Credenciales

### Base de Datos Oracle

**Servicio**: `consultasClienteBS`
- **Tipo**: SOAP/DB Adapter
- **Operaciones**: 
  - `Consultadecliente`
  - `Consultadecertifdepporcliente`
- **Referencia**: `Middleware/Business_Resources/consultasCliente/Resources/consultasClienteBS`

### T24 Web Services

**Servicio Ahorros**: `ConsultaCuentaAhorro`
- **Referencia**: `Middleware/v2/BusinessServices/T24/ConsultaCuentaAhorro/biz/ConsultaCuentaAhorro`
- **Operación**: `ConsultaCuentaAhorroxCliente`

**Servicio Corrientes**: `ConsultaCuentaCorriente`
- **Referencia**: `Middleware/v2/BusinessServices/T24/ConsultaCuentaCorriente/biz/ConsultaCuentaCorriente`
- **Operación**: `ConsultaCuentaCorrientexCliente`

### OSB 12c - Fondos de Pensiones

**Servicio**: `consultaFondoPensiones12c`
- **Referencia**: `Middleware/v2/BusinessServices/ConsultaFondoPensiones12c/biz/consultaFondoPensiones12c`
- **Operación**: `getAssetsCustomer`
- **Credenciales Header**: `OSB12AUTH`

### Servicios de Validación

**ValidaServicioRegional**:
- **Referencia**: `Middleware/v2/BusinessServices/ValidaServicioRegional/biz/ValidaServicioRegional_db`
- **Operación**: `ValidaServicioRegional`
- **Tipo**: DB Adapter (Stored Procedure)

**ValidaFuncionalidadUsuario**:
- **Referencia**: `Middleware/v2/BusinessServices/ValidaFuncionalidadUsuario/biz/ValidaFuncionalidadUsuario_db`
- **Operación**: `ValidaFuncionalidadUsuario`
- **Tipo**: DB Adapter (Stored Procedure)

---

## Tablas de Mapeo de Entrada

### Mapeo 1: OSB → ValidaServicioRegional

| Campo Origen (OSB) | Transformación/Script | Campo Destino (ValidaServicioRegional) |
|-------------------|----------------------|----------------------------------------|
| Constante "FICBCO0043" | Directo | PV_SERVICE_ID |
| $header/RequestHeader/Region/SourceBank | XPath | PV_SOURCE_BANK |

**XQuery**: `Middleware/v2/Resources/Generales/xq/validaServicioRegionalIn`

### Mapeo 2: OSB → ConsultaCliente

| Campo Origen (OSB) | Transformación/Script | Campo Destino (ConsultaCliente) |
|-------------------|----------------------|--------------------------------|
| $body/consultaActivosClienteRequest/CUSTOMER_ID | XPath | CUSTOMER_ID |
| $header/RequestHeader | Completo | Header |

**XQuery**: `Middleware/v2/Resources/ConsultaCliente/xq/ConsultaClienteFPIn`

### Mapeo 3: OSB → ConsultaCuentaAhorro (T24)

| Campo Origen (OSB) | Transformación/Script | Campo Destino (T24) |
|-------------------|----------------------|---------------------|
| $body/consultaActivosClienteRequest/CUSTOMER_ID | XPath | CUSTOMER_ID |
| $header/RequestHeader | Completo | Header |

**XQuery**: `Middleware/v2/Resources/ConsultaActivosCliente/xq/consultaActivosAhorrosClienteV2In`

### Mapeo 3a: OSB → ConsultaCuentaCorriente (T24)

| Campo Origen (OSB) | Transformación/Script | Campo Destino (T24) |
|-------------------|----------------------|---------------------|
| $body/consultaActivosClienteRequest/CUSTOMER_ID | XPath | CUSTOMER_ID |
| $header/RequestHeader | Completo | Header |

**XQuery**: `Middleware/v2/Resources/ConsultaActivosCliente/xq/consultaActivosCorrientesClienteV2In`

### Mapeo 3b: OSB → Consultadecertifdepporcliente (Oracle DB)

| Campo Origen (OSB) | Transformación/Script | Campo Destino (DB) |
|-------------------|----------------------|--------------------|
| $body/consultaActivosClienteRequest/CUSTOMER_ID | XPath | CUSTOMER_ID |
| $header/RequestHeader | Completo | Header |

**XQuery**: `Middleware/v2/Resources/ConsultaActivosCliente/xq/consultaActivosDepositosClienteIn`

### Mapeo 4: OSB → consultaFondoPensiones12c

| Campo Origen (OSB) | Transformación/Script | Campo Destino (Pensiones) |
|-------------------|----------------------|---------------------------|
| $header/RequestHeader/Region/SourceBank | fn:data() | sourceBank |
| $header/RequestHeader/Region/DestinationBank | fn:data() | destinationBank |
| $header/RequestHeader/Authentication/UserName | fn:data() | userName |
| $legalId (de ConsultaCliente) | Variable | legalId |
| $legalIdType (transformado) | convertirTipoDocumento.xq | legalIdType |

**XQuery**: `Middleware/v2/Resources/ConsultaFondoPensiones/xq/getAssetsCustomerIn`

**Transformación Tipo Documento**:
```xquery
declare function convertirTipoDocumento($tipoDocumento as xs:string) as xs:string {
  if ($tipoDocumento = "IDENTIDAD") then "1"
  else if ($tipoDocumento = "RTN") then "2"
  else "0"
};
```

### Mapeo 5: OSB → ValidaFuncionalidadUsuario

| Campo Origen (OSB) | Transformación/Script | Campo Destino (ValidaFuncionalidad) |
|-------------------|----------------------|-------------------------------------|
| $header/RequestHeader/Authentication/UserName | XPath | PV_USER_NAME |
| Constante "SALDOS_ACTIVOS" | Directo | PV_FUNCTIONALITY |
| $header/RequestHeader/Region/SourceBank | XPath | PV_SOURCE_BANK |

**XQuery**: `Middleware/v2/Resources/ConsultaActivosCliente/xq/consultaFuncionalidadUsuario`

---

## Tablas de Mapeo de Salida

### Mapeo 1: ConsultaCuentaAhorro (T24) → OSB

| Campo Origen (T24) | Transformación/Script | Campo Destino (OSB) |
|-------------------|----------------------|---------------------|
| ACCOUNT/ACCOUNTNUMBER | Directo | ASSET_NUMBER |
| ACCOUNT/ACCOUNTNAME | Directo | ASSET_NAME |
| ACCOUNT/CURRENCY | Directo | ASSET_CURRENCY |
| ACCOUNT/TOTALBALANCE | Directo | ASSET_TOTAL_BALANCE |
| ACCOUNT/RESERVEBALANCE | Directo | ASSET_RESERVE_BALANCE |
| ACCOUNT/LIENBALANCE | Directo | ASSET_LOCKED_BALANCE |
| 0.00 | Constante | ASSET_VISA_FLOATING_BALANCE |
| ACCOUNT/AVAILABLEBAL | Directo | ASSET_AVAILABLE_BALANCE |
| ACCOUNT/PRODUCTTYPE | Directo | ASSET_PRODUCT_TYPE |
| "AHO" | Constante | ASSET_TYPE |

**XQuery**: `Middleware/v2/Resources/ConsultaActivosCliente/xq/consultaActivosClienteV2Out`

### Mapeo 1a: ConsultaCuentaCorriente (T24) → OSB

| Campo Origen (T24) | Transformación/Script | Campo Destino (OSB) |
|-------------------|----------------------|---------------------|
| ACCOUNT/ACCOUNTNUMBER | Directo | ASSET_NUMBER |
| ACCOUNT/ACCOUNTNAME | Directo | ASSET_NAME |
| ACCOUNT/CURRENCY | Directo | ASSET_CURRENCY |
| ACCOUNT/TOTALBALANCE | Directo | ASSET_TOTAL_BALANCE |
| ACCOUNT/RESERVEBALANCE | Directo | ASSET_RESERVE_BALANCE |
| ACCOUNT/LIENBALANCE | Directo | ASSET_LOCKED_BALANCE |
| 0.00 | Constante | ASSET_VISA_FLOATING_BALANCE |
| ACCOUNT/AVAILABLEBAL | Directo | ASSET_AVAILABLE_BALANCE |
| ACCOUNT/PRODUCTTYPE | Directo | ASSET_PRODUCT_TYPE |
| "CHQ" | Constante | ASSET_TYPE |

**XQuery**: `Middleware/v2/Resources/ConsultaActivosCliente/xq/consultaActivosClienteV2Out`

### Mapeo 1b: Consultadecertifdepporcliente (Oracle DB) → OSB

| Campo Origen (DB) | Transformación/Script | Campo Destino (OSB) |
|------------------|----------------------|---------------------|
| CERTIFICATE/CERTIFICATENUMBER | Directo | ASSET_NUMBER |
| CERTIFICATE/CERTIFICATENAME | Directo | ASSET_NAME |
| CERTIFICATE/CURRENCY | Directo | ASSET_CURRENCY |
| CERTIFICATE/TOTALBALANCE | Directo | ASSET_TOTAL_BALANCE |
| CERTIFICATE/RESERVEBALANCE | Directo | ASSET_RESERVE_BALANCE |
| CERTIFICATE/LIENBALANCE | Directo | ASSET_LOCKED_BALANCE |
| 0.00 | Constante | ASSET_VISA_FLOATING_BALANCE |
| CERTIFICATE/AVAILABLEBAL | Directo | ASSET_AVAILABLE_BALANCE |
| CERTIFICATE/PRODUCTTYPE | Directo | ASSET_PRODUCT_TYPE |
| "DEP" | Constante | ASSET_TYPE |

**XQuery**: `Middleware/v2/Resources/ConsultaActivosCliente/xq/consultaActivosClienteV2Out`

**Nota**: Los certificados de depósito tienen ASSET_LOCKED_BALANCE = ASSET_TOTAL_BALANCE y ASSET_AVAILABLE_BALANCE = 0.00 porque los fondos están bloqueados hasta el vencimiento.

### Mapeo 2: consultaFondoPensiones12c → OSB

| Campo Origen (Pensiones) | Transformación/Script | Campo Destino (OSB) |
|-------------------------|----------------------|---------------------|
| PV_ASSET_NUMBER | Directo | ASSET_NUMBER |
| PV_ASSET_NAME | Directo | ASSET_NAME |
| PV_ASSET_CURRENCY | Directo | ASSET_CURRENCY |
| PV_ASSET_TOTAL_BALANCE | Directo | ASSET_TOTAL_BALANCE |
| 0.00 | Constante | ASSET_RESERVE_BALANCE |
| 0.00 | Constante | ASSET_LOCKED_BALANCE |
| 0.00 | Constante | ASSET_VISA_FLOATING_BALANCE |
| PV_ASSET_AVAILABLE_BALANCE | Directo | ASSET_AVAILABLE_BALANCE |
| "FPC" | Constante | ASSET_TYPE |

**XQuery**: `Middleware/v2/Resources/ConsultaActivosCliente/xq/consultaActivosClienteHeaderFPCV2Out`

### Mapeo 3: Header de Respuesta

| Campo Origen | Transformación/Script | Campo Destino (ResponseHeader) |
|-------------|----------------------|-------------------------------|
| T24/Pensiones/DB Response | Evaluación de SUCCESS_INDICATOR | successIndicator |
| Múltiples fuentes | Agregación | messages |
| Generado | Secuencial | messageId |

**Lógica de SUCCESS_INDICATOR**:
```xquery
if (all responses SUCCESS and count > 0) then "SUCCESS"
else if (all responses SUCCESS and count = 0) then "SUCCESS" with "No Records"
else "ERROR"
```

---

## Reglas de Negocio

### Regla 1: Enrutamiento por Tipo de Activo

**Ubicación**: `ConsultaActivosCliente.proxy` - Pipeline `HN01_ConsultaActivosCliente_request`

**Código**:
```xml
<con2:ifThenElse>
  <con2:case>
    <con2:condition>
      <con1:xqueryText>fn:string($product) = "AHO"</con1:xqueryText>
    </con2:condition>
    <con2:actions>
      <con2:wsCallout>
        <con2:service ref="Middleware/v2/BusinessServices/T24/ConsultaCuentaAhorro/biz/ConsultaCuentaAhorro"/>
        <con2:operation>ConsultaCuentaAhorroxCliente</con2:operation>
      </con2:wsCallout>
    </con2:actions>
  </con2:case>
  <!-- Más casos para CHQ, DEP, FPC, CTA, ALL -->
</con2:ifThenElse>
```

### Regla 2: Consulta Previa de Cliente

**Ubicación**: `ConsultaActivosCliente.proxy` - Stage `FlujoEntrada`

**Descripción**: Antes de consultar activos, siempre se consulta información del cliente para obtener Legal ID.

**Código**:
```xml
<con2:wsCallout>
  <con2:service ref="Middleware/Business_Resources/consultasCliente/Resources/consultasClienteBS"/>
  <con2:operation>Consultadecliente</con2:operation>
  <con2:request>
    <con2:body>$REQUESTCliente</con2:body>
  </con2:request>
  <con2:response>
    <con2:body>RESPONSECliente</con2:body>
  </con2:response>
</con2:wsCallout>
```

**Transformación**:
```xquery
<con2:assign varName="legalId">
  <con2:expr>
    <con1:xqueryText>fn:data($RESPONSECliente/WSCUSTOMERType[1]/gWSCUSTOMERDetailType/mWSCUSTOMERDetailType[1]/LEGALID)</con1:xqueryText>
  </con2:expr>
</con2:assign>
```

### Regla 3: Validación de Funcionalidad Usuario

**Ubicación**: `ConsultaActivosCliente.proxy` - Stage `FlujoEntrada`

**Descripción**: Valida si el usuario tiene permisos para ver saldos completos.

**Código**:
```xml
<con2:wsCallout>
  <con2:service ref="Middleware/v2/BusinessServices/ValidaFuncionalidadUsuario/biz/ValidaFuncionalidadUsuario_db"/>
  <con2:operation>ValidaFuncionalidadUsuario</con2:operation>
</con2:wsCallout>
```

**Lógica**:
```xquery
if (data($RspFuncionalidadUsuario/val:PV_CODIGO_ERROR) = 'SUCCESS') then
  data($RspFuncionalidadUsuario/val:PV_VALOR)
else
  "ALL"
```

### Regla 4: Manejo de Error de Validación

**Ubicación**: `ConsultaActivosCliente.proxy` - Error Handler

**Descripción**: Captura error BEA-382505 (validación XSD) y transforma a respuesta estándar.

**Código**:
```xml
<con2:ifThenElse>
  <con2:case>
    <con2:condition>
      <con1:xqueryText>fn:string($fault/ctx:errorCode/text()) = "BEA-382505"</con1:xqueryText>
    </con2:condition>
    <con2:actions>
      <con2:replace varName="header" contents-only="true">
        <con2:expr>
          <con1:xqueryTransform>
            <con1:resource ref="Middleware/v2/Resources/Genericos/mapeoErrorValidate"/>
          </con1:xqueryTransform>
        </con2:expr>
      </con2:replace>
    </con2:actions>
  </con2:case>
</con2:ifThenElse>
```

### Regla 5: Mapeo de Errores

**Ubicación**: `ConsultaActivosCliente.proxy` - Pipeline Response

**Descripción**: Normaliza códigos de error usando servicio MapeoErrores.

**Código**:
```xml
<con2:wsCallout>
  <con2:service ref="Middleware/v2/ProxyServices/MapeoErrores"/>
  <con2:operation>mapeoErrores</con2:operation>
  <con2:requestTransform>
    <con2:assign varName="REQMapeoErrores">
      <con2:expr>
        <con1:xqueryTransform>
          <con1:resource ref="Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageIn"/>
          <con1:param name="CODIGO_ERROR">
            <con1:path>fn:upper-case(fn:string($header/aut:ResponseHeader/successIndicator/text()))</con1:path>
          </con1:param>
          <con1:param name="MENSAJE_ERROR">
            <con1:path>fn:concat("FICBCO0043","$#$",fn:string-join($header/aut:ResponseHeader/messages, '||'))</con1:path>
          </con1:param>
        </con1:xqueryTransform>
      </con2:expr>
    </con2:assign>
  </con2:requestTransform>
</con2:wsCallout>
```

---

**Nota**: Honduras (HN01) es la región más compleja con múltiples integraciones y la única que soporta Fondos de Pensiones.
