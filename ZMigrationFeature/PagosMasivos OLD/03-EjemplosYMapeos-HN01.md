# Ejemplos y Mapeos - HN01 (Honduras)

## Request OSB - Operación pagosMasivos

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:pag="http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:RequestHeader>
         <Authentication>
            <UserName>USUARIO_CORP</UserName>
            <Password>********</Password>
         </Authentication>
         <Region>
            <SourceBank>HN01</SourceBank>
         </Region>
      </aut:RequestHeader>
   </soapenv:Header>
   <soapenv:Body>
      <pag:pagosMasivos>
         <GLOBAL_ID>GLB-20240115-001</GLOBAL_ID>
         <CUSTOMER_ID>1234567890</CUSTOMER_ID>
         <USERNAME>USUARIO_CORP</USERNAME>
         <BATCHES>
            <BATCH>
               <CUSTOMER_BATCH_ID>BATCH-001</CUSTOMER_BATCH_ID>
               <TYPE>1</TYPE>
               <CONCEPT_BATCH>Pago de Nómina Enero 2024</CONCEPT_BATCH>
               <APPLICATION_DATE>2024-01-15T10:00:00</APPLICATION_DATE>
               <DATA_STRUCTURE>
                  <VALIDATIONS>
                     <DEBIT_ACCT_BALANCE>YES</DEBIT_ACCT_BALANCE>
                     <DEBIT_ACCT_STATUS>YES</DEBIT_ACCT_STATUS>
                     <NUMBER_OF_TRANSACTIONS>3</NUMBER_OF_TRANSACTIONS>
                     <TOTAL_AMOUNT>15000.00</TOTAL_AMOUNT>
                  </VALIDATIONS>
                  <FIELDS>
                     <FIELD>DEBIT_ACCOUNT</FIELD>
                     <FIELD>CREDIT_ACCOUNT</FIELD>
                     <FIELD>AMOUNT</FIELD>
                     <FIELD>BENEFICIARY</FIELD>
                     <FIELD>DESCRIPTION</FIELD>
                  </FIELDS>
                  <DELIMITER>|</DELIMITER>
               </DATA_STRUCTURE>
               <TRANSACTIONS>
                  <TRANSACTION>1234567890|9876543210|5000.00|Juan Perez|Pago Salario</TRANSACTION>
                  <TRANSACTION>1234567890|9876543211|5000.00|Maria Lopez|Pago Salario</TRANSACTION>
                  <TRANSACTION>1234567890|9876543212|5000.00|Carlos Gomez|Pago Salario</TRANSACTION>
               </TRANSACTIONS>
            </BATCH>
         </BATCHES>
      </pag:pagosMasivos>
   </soapenv:Body>
</soapenv:Envelope>
```

## Response OSB - Operación pagosMasivos

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:pag="http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:ResponseHeader>
         <successIndicator>Success</successIndicator>
      </aut:ResponseHeader>
   </soapenv:Header>
   <soapenv:Body>
      <pag:pagosMasivosResponse>
         <GLOBAL_ID>GLB-20240115-001</GLOBAL_ID>
         <CUSTOMER_ID>1234567890</CUSTOMER_ID>
         <BATCHES>
            <BATCH>
               <BANK_BATCH_ID>100001</BANK_BATCH_ID>
               <CUSTOMER_BATCH_ID>BATCH-001</CUSTOMER_BATCH_ID>
               <STATUS>PROCESSED</STATUS>
            </BATCH>
         </BATCHES>
      </pag:pagosMasivosResponse>
   </soapenv:Body>
</soapenv:Envelope>
```

## Servicios Dependientes

### 1. ValidaServicioRegional (Base de Datos)

**Request Interno**:
```xml
<InputParameters>
   <PV_SERVICE_ID>FICBCO0231</PV_SERVICE_ID>
   <PV_SOURCE_BANK>HN01</PV_SOURCE_BANK>
</InputParameters>
```

**Response Interno**:
```xml
<OutputParameters>
   <PV_CODIGO_ERROR>SUCCESS</PV_CODIGO_ERROR>
   <PV_MENSAJE_ERROR></PV_MENSAJE_ERROR>
</OutputParameters>
```

**Conexión**:
- Tipo: Oracle Database Adapter
- Stored Procedure: `ValidaServicioRegional`
- Esquema: No especificado

### 2. validaAccesoPMS_db (Base de Datos)

**Request Interno**:
```xml
<InputParameters>
   <PV_CUSTOMER_ID>1234567890</PV_CUSTOMER_ID>
   <PV_USER_NAME>USUARIO_CORP</PV_USER_NAME>
</InputParameters>
```

**Response Interno**:
```xml
<OutputParameters>
   <ERROR_MESSAGE></ERROR_MESSAGE>
</OutputParameters>
```

**Conexión**:
- Tipo: Oracle Database Adapter
- Stored Procedure: `validaAccesoPMS`
- Esquema: No especificado

### 3. sjPagosMasivosInterno (BPEL Flow)

**Request Interno**:
```xml
<inputParameters>
   <GLOBAL_ID>GLB-20240115-001</GLOBAL_ID>
   <CUSTOMER_ID>1234567890</CUSTOMER_ID>
   <USERNAME>USUARIO_CORP</USERNAME>
   <BATCHES>
      <BATCH>
         <CUSTOMER_BATCH_ID>BATCH-001</CUSTOMER_BATCH_ID>
         <TYPE>1</TYPE>
         <CONCEPT_BATCH>Pago de Nómina Enero 2024</CONCEPT_BATCH>
         <APPLICATION_DATE>2024-01-15T10:00:00</APPLICATION_DATE>
         <DATA_STRUCTURE>
            <VALIDATIONS>
               <DEBIT_ACCT_BALANCE>YES</DEBIT_ACCT_BALANCE>
               <DEBIT_ACCT_STATUS>YES</DEBIT_ACCT_STATUS>
               <NUMBER_OF_TRANSACTIONS>3</NUMBER_OF_TRANSACTIONS>
               <TOTAL_AMOUNT>15000.00</TOTAL_AMOUNT>
            </VALIDATIONS>
            <FIELDS>
               <FIELD>DEBIT_ACCOUNT</FIELD>
               <FIELD>CREDIT_ACCOUNT</FIELD>
               <FIELD>AMOUNT</FIELD>
               <FIELD>BENEFICIARY</FIELD>
               <FIELD>DESCRIPTION</FIELD>
            </FIELDS>
            <DELIMITER>|</DELIMITER>
         </DATA_STRUCTURE>
         <TRANSACTIONS>
            <TRANSACTION>1234567890|9876543210|5000.00|Juan Perez|Pago Salario</TRANSACTION>
            <TRANSACTION>1234567890|9876543211|5000.00|Maria Lopez|Pago Salario</TRANSACTION>
            <TRANSACTION>1234567890|9876543212|5000.00|Carlos Gomez|Pago Salario</TRANSACTION>
         </TRANSACTIONS>
      </BATCH>
   </BATCHES>
</inputParameters>
```

**Response Interno**:
```xml
<outputParameters>
   <GLOBAL_ID>GLB-20240115-001</GLOBAL_ID>
   <CUSTOMER_ID>1234567890</CUSTOMER_ID>
   <BATCHES>
      <BATCH>
         <ID_POSITION>1</ID_POSITION>
         <BANK_BATCH_ID>100001</BANK_BATCH_ID>
         <CUSTOMER_BATCH_ID>BATCH-001</CUSTOMER_BATCH_ID>
         <STATUS>PROCESSED</STATUS>
      </BATCH>
   </BATCHES>
</outputParameters>
```

**Conexión**:
- Tipo: BPEL Flow
- Ubicación: `Middleware/v2/BusinessServices/SJS/pagosMasivosInterno/flow/sjPagosMasivosInterno.flow`

### 4. validaEstructuraLote_db (Base de Datos)

**Request Interno**:
```xml
<InputParameters>
   <PV_CUSTOMER_ID>1234567890</PV_CUSTOMER_ID>
   <PV_BATCH>
      <BATCH>
         <CUSTOMER_BATCH_ID>BATCH-001</CUSTOMER_BATCH_ID>
         <TYPE>1</TYPE>
         <DATA_STRUCTURE>
            <VALIDATIONS>
               <NUMBER_OF_TRANSACTIONS>3</NUMBER_OF_TRANSACTIONS>
               <TOTAL_AMOUNT>15000.00</TOTAL_AMOUNT>
            </VALIDATIONS>
            <FIELDS>
               <FIELD>DEBIT_ACCOUNT</FIELD>
               <FIELD>CREDIT_ACCOUNT</FIELD>
               <FIELD>AMOUNT</FIELD>
               <FIELD>BENEFICIARY</FIELD>
               <FIELD>DESCRIPTION</FIELD>
            </FIELDS>
            <DELIMITER>|</DELIMITER>
         </DATA_STRUCTURE>
         <TRANSACTIONS>
            <TRANSACTION>1234567890|9876543210|5000.00|Juan Perez|Pago Salario</TRANSACTION>
            <TRANSACTION>1234567890|9876543211|5000.00|Maria Lopez|Pago Salario</TRANSACTION>
            <TRANSACTION>1234567890|9876543212|5000.00|Carlos Gomez|Pago Salario</TRANSACTION>
         </TRANSACTIONS>
      </BATCH>
   </PV_BATCH>
   <PV_BATCH_NUMBER>1</PV_BATCH_NUMBER>
</InputParameters>
```

**Response Interno**:
```xml
<OutputParameters>
   <ERROR_CODE>SUCCESS</ERROR_CODE>
   <ERROR_MESSAGE></ERROR_MESSAGE>
</OutputParameters>
```

**Conexión**:
- Tipo: Oracle Database Adapter
- Stored Procedure: `validaEstructuraLote`
- Esquema: No especificado

### 5. ConsultaDetallesCuentaMasivos (Proxy Service)

**Request Interno**:
```xml
<consultaDetallesCuentaMasivos>
   <ACCOUNT_NUMBER>1234567890</ACCOUNT_NUMBER>
</consultaDetallesCuentaMasivos>
```

**Response Interno**:
```xml
<consultaDetallesCuentaMasivosResponse>
   <ACCOUNT_NUMBER>1234567890</ACCOUNT_NUMBER>
   <CURRENT_BALANCE>50000.00</CURRENT_BALANCE>
   <AVAILABLE_BALANCE>45000.00</AVAILABLE_BALANCE>
   <CURRENCY>HNL</CURRENCY>
</consultaDetallesCuentaMasivosResponse>
```

**Conexión**:
- Tipo: SOAP Proxy Service
- Ubicación: `Middleware/v2/ProxyServices/ConsultaDetallesCuentaMasivos`

### 6. consultaCuentasBS (Business Service - T24)

**Request Interno**:
```xml
<Consultadedetallesdelacuenta>
   <parameters>
      <ACCOUNTID>1234567890</ACCOUNTID>
   </parameters>
</Consultadedetallesdelacuenta>
```

**Response Interno**:
```xml
<ConsultadedetallesdelacuentaResponse>
   <parameters>
      <Status>
         <successIndicator>Success</successIndicator>
      </Status>
      <WSACCOUNTLISTType>
         <ZERORECORDS></ZERORECORDS>
         <gWSACCOUNTLISTDetailType>
            <mWSACCOUNTLISTDetailType>
               <INACTIVEMARKER>N</INACTIVEMARKER>
               <POSTINGRESTRICT></POSTINGRESTRICT>
            </mWSACCOUNTLISTDetailType>
         </gWSACCOUNTLISTDetailType>
      </WSACCOUNTLISTType>
   </parameters>
</ConsultadedetallesdelacuentaResponse>
```

**Conexión**:
- Tipo: SOAP Business Service (T24)
- Ubicación: `Middleware/Business_Resources/ConsultasCuenta/Resources/consultaCuentasBS`
- Operación: `Consultadedetallesdelacuenta`

### 7. procesaLotePagoMasivo_db (Base de Datos)

**Request Interno**:
```xml
<InputParameters>
   <PV_CUSTOMER_ID>1234567890</PV_CUSTOMER_ID>
   <PV_USERNAME>USUARIO_CORP</PV_USERNAME>
   <PV_GLOBAL_ID>GLB-20240115-001</PV_GLOBAL_ID>
   <PV_BATCH>
      <BATCH>
         <CUSTOMER_BATCH_ID>BATCH-001</CUSTOMER_BATCH_ID>
         <TYPE>1</TYPE>
         <CONCEPT_BATCH>Pago de Nómina Enero 2024</CONCEPT_BATCH>
         <APPLICATION_DATE>2024-01-15T10:00:00</APPLICATION_DATE>
         <TRANSACTIONS>
            <TRANSACTION>1234567890|9876543210|5000.00|Juan Perez|Pago Salario</TRANSACTION>
            <TRANSACTION>1234567890|9876543211|5000.00|Maria Lopez|Pago Salario</TRANSACTION>
            <TRANSACTION>1234567890|9876543212|5000.00|Carlos Gomez|Pago Salario</TRANSACTION>
         </TRANSACTIONS>
      </BATCH>
   </PV_BATCH>
   <PV_BATCH_NUMBER>1</PV_BATCH_NUMBER>
</InputParameters>
```

**Response Interno**:
```xml
<OutputParameters>
   <BANK_BATCH_ID>100001</BANK_BATCH_ID>
   <STATUS>PROCESSED</STATUS>
   <ERROR_CODE></ERROR_CODE>
   <ERROR_MESSAGE></ERROR_MESSAGE>
</OutputParameters>
```

**Conexión**:
- Tipo: Oracle Database Adapter
- Stored Procedure: `procesaLotePagoMasivo`
- Esquema: No especificado

### 8. registraBitacoraPagosMasivos_db (Base de Datos)

**Request Interno (Request)**:
```xml
<InputParameters>
   <PV_ID>uuid-generated-123</PV_ID>
   <PV_REQUEST_ID></PV_REQUEST_ID>
   <PV_RECORD_TYPE>REQ</PV_RECORD_TYPE>
   <PV_RECORD_DATE>2024-01-15T10:00:00</PV_RECORD_DATE>
   <PV_CUSTOMER_ID>1234567890</PV_CUSTOMER_ID>
   <PV_USERNAME>USUARIO_CORP</PV_USERNAME>
   <PV_AUTH_USERNAME>USUARIO_CORP</PV_AUTH_USERNAME>
   <PV_OPERATION>PagosMasivos</PV_OPERATION>
   <PV_GLOBAL_ID>GLB-20240115-001</PV_GLOBAL_ID>
   <PV_REQUEST_HOST>192.168.1.100</PV_REQUEST_HOST>
   <PV_RESPONSE_CODE></PV_RESPONSE_CODE>
   <PV_RESPONSE_MESSAGE></PV_RESPONSE_MESSAGE>
   <PV_SOAP_CONTENT>
      <pagosMasivos>...</pagosMasivos>
   </PV_SOAP_CONTENT>
</InputParameters>
```

**Request Interno (Response)**:
```xml
<InputParameters>
   <PV_ID>uuid-generated-456</PV_ID>
   <PV_REQUEST_ID>uuid-generated-123</PV_REQUEST_ID>
   <PV_RECORD_TYPE>RSP</PV_RECORD_TYPE>
   <PV_RECORD_DATE>2024-01-15T10:00:05</PV_RECORD_DATE>
   <PV_CUSTOMER_ID>1234567890</PV_CUSTOMER_ID>
   <PV_USERNAME>USUARIO_CORP</PV_USERNAME>
   <PV_AUTH_USERNAME>USUARIO_CORP</PV_AUTH_USERNAME>
   <PV_OPERATION>PagosMasivos</PV_OPERATION>
   <PV_GLOBAL_ID>GLB-20240115-001</PV_GLOBAL_ID>
   <PV_REQUEST_HOST>192.168.1.100</PV_REQUEST_HOST>
   <PV_RESPONSE_CODE>Success</PV_RESPONSE_CODE>
   <PV_RESPONSE_MESSAGE></PV_RESPONSE_MESSAGE>
   <PV_SOAP_CONTENT>
      <pagosMasivosResponse>...</pagosMasivosResponse>
   </PV_SOAP_CONTENT>
</InputParameters>
```

**Conexión**:
- Tipo: Oracle Database Adapter
- Stored Procedure: `registraBitacoraPagosMasivos`
- Esquema: No especificado

## Tablas de Mapeo

### Mapeo de Entrada - OSB a sjPagosMasivosInterno

| Campo Origen (OSB) | Transformación/Script | Campo Destino (BPEL) |
|--------------------|----------------------|----------------------|
| `$body/pag:pagosMasivos` | Copia directa | `$request.inputParameters` |
| `$body/pag:pagosMasivos/GLOBAL_ID` | `fn:string(text())` | `inputParameters/GLOBAL_ID` |
| `$body/pag:pagosMasivos/CUSTOMER_ID` | `fn:string(text())` | `inputParameters/CUSTOMER_ID` |
| `$body/pag:pagosMasivos/USERNAME` | `fn:string(text())` | `inputParameters/USERNAME` |
| `$body/pag:pagosMasivos/BATCHES` | Copia completa | `inputParameters/BATCHES` |
| `$header/aut:RequestHeader` | Almacenado en variable | `$originalRequestHeader` |

**XQuery**: `Middleware/v2/Resources/PagosMasivosInterno/xq/sjPagosMasivosInternoIn.xqy`

### Mapeo de Salida - sjPagosMasivosInterno a OSB

| Campo Origen (BPEL) | Transformación/Script | Campo Destino (OSB) |
|---------------------|----------------------|---------------------|
| `$RSPPagosMasivosInterno/outputParameters` | XQuery transform | `$body/pag:pagosMasivosResponse` |
| `outputParameters/GLOBAL_ID` | `fn:string(text())` | `pagosMasivosResponse/GLOBAL_ID` |
| `outputParameters/CUSTOMER_ID` | `fn:string(text())` | `pagosMasivosResponse/CUSTOMER_ID` |
| `outputParameters/BATCHES/BATCH` | Iteración y mapeo | `pagosMasivosResponse/BATCHES/BATCH` |
| `BATCH/BANK_BATCH_ID` | `fn:string(text())` | `BATCH/BANK_BATCH_ID` |
| `BATCH/CUSTOMER_BATCH_ID` | `fn:string(text())` | `BATCH/CUSTOMER_BATCH_ID` |
| `BATCH/STATUS` | `fn:string(text())` | `BATCH/STATUS` |
| `BATCH/ERROR_CODE` | `fn:string(text())` | `BATCH/ERROR_CODE` |
| `BATCH/ERROR_MESSAGE` | `fn:string(text())` | `BATCH/ERROR_MESSAGE` |

**XQuery**: `Middleware/v2/Resources/PagosMasivosInterno/xq/pagosMasivosInternoOut.xqy`

### Mapeo de Agrupación por Cuenta

| Campo Origen | Transformación/Script | Campo Destino |
|--------------|----------------------|---------------|
| `$request.inputParameters/BATCHES/BATCH[xs:int($contador)]` | Agrupación XQuery | `$batchAgrupado` |
| `TRANSACTIONS/TRANSACTION` | Parse con delimiter | Campos individuales |
| Campo débito (posición según FIELDS) | Agrupación por cuenta | `ACCOUNT/ACCOUNT_NUMBER` |
| Suma de montos por cuenta | `sum()` | `ACCOUNT/TOTAL_AMOUNT` |

**XQuery**: `Middleware/v2/Resources/PagosMasivosInterno/xq/agrupaTxnLoteXCuenta.xqy`

## Reglas de Negocio

### RN-001: Validación de Servicio Regional
**Ubicación**: `PagosMasivosInterno.pipeline` - Stage `ValidacionServicioRegional`
**Descripción**: Valida que el servicio FICBCO0231 esté habilitado para la región HN01
**Código**:
```xquery
fn:string($respValidaServicioRegional/val:PV_CODIGO_ERROR/text()) != 'SUCCESS'
```
**Acción**: Si falla, retorna error y termina flujo

### RN-002: Validación de Acceso de Usuario
**Ubicación**: `PagosMasivosInterno.pipeline` - Stage `FlujoEntrada`
**Descripción**: Valida que el usuario tenga acceso a pagos masivos para el cliente
**Código**:
```xquery
$validationMessage != ""
```
**Acción**: Si falla, retorna error sin procesar lote

### RN-003: Validación de Estructura de Lote
**Ubicación**: `sjPagosMasivosInterno.flow` - Invoke `validaEstructuraLote_db`
**Descripción**: Valida formato, campos y estructura del lote
**Código**:
```xquery
fn:string($RSPvalidaEstructuraLote.OutputParameters/val:ERROR_CODE/text()) = "SUCCESS"
```
**Acción**: Si falla, retorna error específico del lote

### RN-004: Validación de Saldo (Opcional)
**Ubicación**: `sjPagosMasivosInterno.flow` - Condicional `$validarSaldo`
**Descripción**: Si `DEBIT_ACCT_BALANCE=YES`, valida saldo disponible
**Código**:
```xquery
fn:string($request.inputParameters/BATCHES/BATCH[xs:int($contador)]/DATA_STRUCTURE/VALIDATIONS/DEBIT_ACCT_BALANCE/text()) = "YES"
```
**Validación**:
```xquery
$disponible < $totalAmount
```
**Acción**: Si saldo insuficiente, lanza fault `tns:saldoInsuficiente`

### RN-005: Validación de Estado de Cuenta (Opcional)
**Ubicación**: `sjPagosMasivosInterno.flow` - Condicional `$validarEstado`
**Descripción**: Si `DEBIT_ACCT_STATUS=YES`, valida estado de cuenta
**Código**:
```xquery
fn:string($request.inputParameters/BATCHES/BATCH[xs:int($contador)]/DATA_STRUCTURE/VALIDATIONS/DEBIT_ACCT_STATUS/text()) = "YES"
```
**Validaciones**:
```xquery
-- Cuenta inactiva
fn:string($RSPconsultadedetalledelacuentaResponse.parameters/WSACCOUNTLISTType[1]/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType/INACTIVEMARKER/text())="Y"

-- Restricción de débito
fn:string($RSPconsultadedetalledelacuentaResponse.parameters/WSACCOUNTLISTType[1]/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType/POSTINGRESTRICT/text()) = "DEBIT"
or
fn:string($RSPconsultadedetalledelacuentaResponse.parameters/WSACCOUNTLISTType[1]/gWSACCOUNTLISTDetailType/mWSACCOUNTLISTDetailType/POSTINGRESTRICT/text()) = "ALL"
```
**Acción**: Si cuenta inactiva o con restricciones, lanza fault `tns:estadoInvalido`

### RN-006: Procesamiento Paralelo de Batches
**Ubicación**: `sjPagosMasivosInterno.flow` - forEach
**Descripción**: Procesa múltiples batches en paralelo
**Código**:
```xml
<bpel:forEach parallel="yes" counterName="contador">
    <bpel:startCounterValue>1</bpel:startCounterValue>
    <bpel:finalCounterValue>count($request.inputParameters/BATCHES/BATCH)</bpel:finalCounterValue>
</bpel:forEach>
```
**Acción**: Cada batch se procesa independientemente

### RN-007: Agrupación de Transacciones por Cuenta
**Ubicación**: `sjPagosMasivosInterno.flow` - XQuery `agrupaTxnLoteXCuenta.xqy`
**Descripción**: Agrupa transacciones por cuenta débito para validación de saldos
**Código**: Ver XQuery `agrupaTxnLoteXCuenta.xqy`
**Acción**: Crea estructura con suma de montos por cuenta

### RN-008: Mapeo de Errores
**Ubicación**: `PagosMasivosInterno.pipeline` - Stage `MapeoError`
**Descripción**: Mapea códigos de error técnicos a mensajes de negocio
**Código**:
```xquery
fn:upper-case(fn:string($header/aut:ResponseHeader/successIndicator/text())) != "SUCCESS"
```
**Acción**: Invoca servicio MapeoErrores con código FICBCO0231

### RN-009: Bitácora de Auditoría
**Ubicación**: `PagosMasivosInterno.pipeline` - Stages `BitacoraRequest` y `BitacoraResponse`
**Descripción**: Registra request y response para auditoría
**Código**: Invocación a `registraBitacoraPagosMasivos_db`
**Acción**: Almacena en BD con UUID único

## Cadenas de Conexión

### Base de Datos Oracle

**validaEstructuraLote_db**:
- Tipo: JCA Database Adapter
- Archivo: `Middleware/v2/BusinessServices/PMSV/validaEstructuraLote/jca/validaEstructuraLote_db.jca`
- Operación: `validaEstructuraLote` (Stored Procedure)

**procesaLotePagoMasivo_db**:
- Tipo: JCA Database Adapter
- Archivo: `Middleware/v2/BusinessServices/PMSV/procesaLotePagoMasivo/jca/procesaLotePagoMasivo_db.jca`
- Operación: `procesaLotePagoMasivo` (Stored Procedure)

**registraBitacoraPagosMasivos_db**:
- Tipo: JCA Database Adapter
- Archivo: `Middleware/v2/BusinessServices/PMSV/registraBitacoraPagosMasivos/jca/registraBitacoraPagosMasivos_db.jca`
- Operación: `registraBitacoraPagosMasivos` (Stored Procedure)

**validaAccesoPMS_db**:
- Tipo: JCA Database Adapter
- Archivo: `Middleware/v2/BusinessServices/PMSV/validaAccesoPMS/jca/validaAccesoPMS_db.jca`
- Operación: `validaAccesoPMS` (Stored Procedure)

**ValidaServicioRegional_db**:
- Tipo: JCA Database Adapter
- Archivo: `Middleware/v2/BusinessServices/ValidaServicioRegional/biz/ValidaServicioRegional_db.jca`
- Operación: `ValidaServicioRegional` (Stored Procedure)

### Servicios SOAP

**ConsultaDetallesCuentaMasivos**:
- Tipo: SOAP Proxy Service
- Ubicación: `Middleware/v2/ProxyServices/ConsultaDetallesCuentaMasivos`
- Operación: `consultaDetallesCuentaMasivos`

**consultaCuentasBS** (T24):
- Tipo: SOAP Business Service
- Ubicación: `Middleware/Business_Resources/ConsultasCuenta/Resources/consultaCuentasBS`
- Operación: `Consultadedetallesdelacuenta`
- WSDL: T24 Web Services

**MapeoErrores**:
- Tipo: SOAP Proxy Service
- Ubicación: `Middleware/v2/ProxyServices/MapeoErrores`
- Operación: `mapeoErrores`
