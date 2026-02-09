# Ejemplos y Mapeos - GT01 (Guatemala)

## Request OSB - Operación pagosMasivos

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:pag="http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:RequestHeader>
         <Authentication>
            <UserName>USUARIO_GT</UserName>
            <Password>********</Password>
         </Authentication>
         <Region>
            <SourceBank>GT01</SourceBank>
         </Region>
      </aut:RequestHeader>
   </soapenv:Header>
   <soapenv:Body>
      <pag:pagosMasivos>
         <GLOBAL_ID>GLB-GT-20240115-001</GLOBAL_ID>
         <CUSTOMER_ID>GT1234567890</CUSTOMER_ID>
         <USERNAME>USUARIO_GT</USERNAME>
         <BATCHES>
            <BATCH>
               <CUSTOMER_BATCH_ID>BATCH-GT-001</CUSTOMER_BATCH_ID>
               <TYPE>1</TYPE>
               <CONCEPT_BATCH>Pago de Proveedores</CONCEPT_BATCH>
               <APPLICATION_DATE>2024-01-15T10:00:00</APPLICATION_DATE>
               <DATA_STRUCTURE>
                  <VALIDATIONS>
                     <DEBIT_ACCT_BALANCE>NO</DEBIT_ACCT_BALANCE>
                     <DEBIT_ACCT_STATUS>NO</DEBIT_ACCT_STATUS>
                     <NUMBER_OF_TRANSACTIONS>2</NUMBER_OF_TRANSACTIONS>
                     <TOTAL_AMOUNT>10000.00</TOTAL_AMOUNT>
                  </VALIDATIONS>
                  <FIELDS>
                     <FIELD>DEBIT_ACCOUNT</FIELD>
                     <FIELD>CREDIT_ACCOUNT</FIELD>
                     <FIELD>AMOUNT</FIELD>
                     <FIELD>BENEFICIARY</FIELD>
                  </FIELDS>
                  <DELIMITER>|</DELIMITER>
               </DATA_STRUCTURE>
               <TRANSACTIONS>
                  <TRANSACTION>GT1234567890|GT9876543210|5000.00|Proveedor A</TRANSACTION>
                  <TRANSACTION>GT1234567890|GT9876543211|5000.00|Proveedor B</TRANSACTION>
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
         <successIndicator>SUCCESS</successIndicator>
         <messages>Lote procesado exitosamente</messages>
      </aut:ResponseHeader>
   </soapenv:Header>
   <soapenv:Body>
      <pag:pagosMasivosResponse>
         <GLOBAL_ID>GLB-GT-20240115-001</GLOBAL_ID>
         <CUSTOMER_ID>GT1234567890</CUSTOMER_ID>
         <BATCHES>
            <BATCH>
               <BANK_BATCH_ID>GT100001</BANK_BATCH_ID>
               <CUSTOMER_BATCH_ID>BATCH-GT-001</CUSTOMER_BATCH_ID>
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
   <PV_SOURCE_BANK>GT01</PV_SOURCE_BANK>
</InputParameters>
```

**Response Interno**:
```xml
<OutputParameters>
   <PV_CODIGO_ERROR>SUCCESS</PV_CODIGO_ERROR>
   <PV_MENSAJE_ERROR></PV_MENSAJE_ERROR>
</OutputParameters>
```

### 2. validaAccesoPMS (Servicio MTR)

**Request Interno**:
```xml
<validaAccesoPMS>
   <customerId>GT1234567890</customerId>
   <userName>USUARIO_GT</userName>
</validaAccesoPMS>
```

**Response Interno**:
```xml
<validaAccesoPMSResponse>
   <status>00000</status>
   <message>Acceso autorizado</message>
</validaAccesoPMSResponse>
```

**Conexión**:
- Tipo: SOAP Business Service
- Ubicación: `Middleware/v2/BusinessServices/MTR/validaAccesoPMS/biz/validaAccesoPMS`
- Endpoint: Servicio externo MTR

### 3. cargadorArchivoLote (Servicio MTR)

**Request Interno**:
```xml
<ser:cargarLotes xmlns:ser="http://servicio.cargararchivolotews.mtrpmsv.cidenet.com.co/">
   <peticionHostToHost>
      <cabeceraPeticion>
         <pais>GT</pais>
         <usuario>USUARIO_GT</usuario>
         <idCliente>GT1234567890</idCliente>
      </cabeceraPeticion>
      <cuerpoLotes>
         <lote>
            <idLoteCliente>BATCH-GT-001</idLoteCliente>
            <tipoLote>1</tipoLote>
            <conceptoLote>Pago de Proveedores</conceptoLote>
            <fechaAplicacion>2024-01-15T10:00:00</fechaAplicacion>
            <estructuraDatos>
               <validaciones>
                  <validarSaldoCuentaDebito>NO</validarSaldoCuentaDebito>
                  <validarEstadoCuentaDebito>NO</validarEstadoCuentaDebito>
                  <numeroTransacciones>2</numeroTransacciones>
                  <montoTotal>10000.00</montoTotal>
               </validaciones>
               <campos>
                  <campo>DEBIT_ACCOUNT</campo>
                  <campo>CREDIT_ACCOUNT</campo>
                  <campo>AMOUNT</campo>
                  <campo>BENEFICIARY</campo>
               </campos>
               <delimitador>|</delimitador>
            </estructuraDatos>
            <transacciones>
               <transaccion>GT1234567890|GT9876543210|5000.00|Proveedor A</transaccion>
               <transaccion>GT1234567890|GT9876543211|5000.00|Proveedor B</transaccion>
            </transacciones>
         </lote>
      </cuerpoLotes>
   </peticionHostToHost>
</ser:cargarLotes>
```

**Response Interno**:
```xml
<ser:cargarLotesResponse xmlns:ser="http://servicio.cargararchivolotews.mtrpmsv.cidenet.com.co/">
   <respuestaHostToHost>
      <cabeceraRespuesta>
         <codigo>SUCCESS</codigo>
         <mensaje>Lote procesado exitosamente</mensaje>
      </cabeceraRespuesta>
      <cuerpoRespuesta>
         <lote>
            <idLoteBanco>GT100001</idLoteBanco>
            <idLoteCliente>BATCH-GT-001</idLoteCliente>
            <estado>PROCESSED</estado>
         </lote>
      </cuerpoRespuesta>
   </respuestaHostToHost>
</ser:cargarLotesResponse>
```

**Conexión**:
- Tipo: SOAP Business Service
- Ubicación: `Middleware/v2/BusinessServices/MTR/cargadorArchivoLote/biz/cargadorArchivoLote`
- Endpoint: Servicio externo MTR
- Namespace: `http://servicio.cargararchivolotews.mtrpmsv.cidenet.com.co/`
- Operación: `cargarLotes`
- WSDL: `Middleware/v2/BusinessServices/MTR/cargadorArchivoLote/wsdl/cargadorArchivoLoteEndpoint.wsdl`

### 4. registraBitacoraPagosMasivosRG_db (Base de Datos)

**Request Interno (Request)**:
```xml
<InputParameters>
   <PV_ID>uuid-gt-123</PV_ID>
   <PV_REQUEST_ID></PV_REQUEST_ID>
   <PV_RECORD_TYPE>REQ</PV_RECORD_TYPE>
   <PV_RECORD_DATE>2024-01-15T10:00:00</PV_RECORD_DATE>
   <PV_CUSTOMER_ID>GT1234567890</PV_CUSTOMER_ID>
   <PV_USERNAME>USUARIO_GT</PV_USERNAME>
   <PV_AUTH_USERNAME>USUARIO_GT</PV_AUTH_USERNAME>
   <PV_OPERATION>PagosMasivos</PV_OPERATION>
   <PV_GLOBAL_ID>GLB-GT-20240115-001</PV_GLOBAL_ID>
   <PV_REQUEST_HOST>192.168.1.100</PV_REQUEST_HOST>
   <PV_RESPONSE_CODE></PV_RESPONSE_CODE>
   <PV_RESPONSE_MESSAGE></PV_RESPONSE_MESSAGE>
   <PV_COUNTRY_CODE>GT01</PV_COUNTRY_CODE>
   <PV_SOAP_CONTENT>
      <pagosMasivos>...</pagosMasivos>
   </PV_SOAP_CONTENT>
</InputParameters>
```

**Conexión**:
- Tipo: Oracle Database Adapter
- Stored Procedure: `registraBitacoraPagosMasivosRG`
- Esquema: No especificado
- **Campo adicional**: `PV_COUNTRY_CODE` (GT01)

## Tablas de Mapeo

### Mapeo de Entrada - OSB a cargadorArchivoLote

| Campo Origen (OSB) | Transformación/Script | Campo Destino (MTR) |
|--------------------|----------------------|---------------------|
| `$header/aut:RequestHeader/Region/SourceBank` | Substring(1,2) | `peticionHostToHost/cabeceraPeticion/pais` |
| `$body/pag:pagosMasivos/USERNAME` | `fn:string(text())` | `peticionHostToHost/cabeceraPeticion/usuario` |
| `$body/pag:pagosMasivos/CUSTOMER_ID` | `fn:string(text())` | `peticionHostToHost/cabeceraPeticion/idCliente` |
| `$body/pag:pagosMasivos/BATCHES/BATCH/CUSTOMER_BATCH_ID` | `fn:string(text())` | `cuerpoLotes/lote/idLoteCliente` |
| `$body/pag:pagosMasivos/BATCHES/BATCH/TYPE` | `fn:string(text())` | `cuerpoLotes/lote/tipoLote` |
| `$body/pag:pagosMasivos/BATCHES/BATCH/CONCEPT_BATCH` | `fn:string(text())` | `cuerpoLotes/lote/conceptoLote` |
| `$body/pag:pagosMasivos/BATCHES/BATCH/APPLICATION_DATE` | `fn:string(text())` | `cuerpoLotes/lote/fechaAplicacion` |
| `DEBIT_ACCT_BALANCE` | Mapeo YES/NO | `validarSaldoCuentaDebito` |
| `DEBIT_ACCT_STATUS` | Mapeo YES/NO | `validarEstadoCuentaDebito` |
| `NUMBER_OF_TRANSACTIONS` | `fn:string(text())` | `numeroTransacciones` |
| `TOTAL_AMOUNT` | `fn:string(text())` | `montoTotal` |
| `FIELDS/FIELD` | Iteración | `campos/campo` |
| `DELIMITER` | `fn:string(text())` | `delimitador` |
| `TRANSACTIONS/TRANSACTION` | Iteración | `transacciones/transaccion` |

**XQuery**: `Middleware/v2/Resources/PagosMasivosInterno/xq/pagosMasivosInternoGTIn.xqy`

### Mapeo de Salida - cargadorArchivoLote a OSB

| Campo Origen (MTR) | Transformación/Script | Campo Destino (OSB) |
|--------------------|----------------------|---------------------|
| `$RSPcargarLotes/respuestaHostToHost/cuerpoRespuesta/lote` | Iteración | `$body/pag:pagosMasivosResponse/BATCHES/BATCH` |
| `lote/idLoteBanco` | `fn:string(text())` | `BATCH/BANK_BATCH_ID` |
| `lote/idLoteCliente` | `fn:string(text())` | `BATCH/CUSTOMER_BATCH_ID` |
| `lote/estado` | `fn:string(text())` | `BATCH/STATUS` |
| `lote/codigoError` | `fn:string(text())` | `BATCH/ERROR_CODE` |
| `lote/mensajeError` | `fn:string(text())` | `BATCH/ERROR_MESSAGE` |
| `$originalRequestBody/pag:pagosMasivos/GLOBAL_ID` | Copia | `pagosMasivosResponse/GLOBAL_ID` |
| `$originalRequestBody/pag:pagosMasivos/CUSTOMER_ID` | Copia | `pagosMasivosResponse/CUSTOMER_ID` |

**XQuery**: `Middleware/v2/Resources/PagosMasivosInterno/xq/pagosMasivosInternoGTOut.xqy`

### Mapeo de Header de Respuesta

| Campo Origen (MTR) | Transformación/Script | Campo Destino (OSB) |
|--------------------|----------------------|---------------------|
| `$RSPcargarLotes/respuestaHostToHost/cabeceraRespuesta/codigo` | Asignado a `$errorCode` | `ResponseHeader/successIndicator` |
| `$RSPcargarLotes/respuestaHostToHost/cabeceraRespuesta/mensaje` | Asignado a `$validationMessage` | `ResponseHeader/messages` |

**XQuery**: `Middleware/v2/Resources/PagosMasivosInterno/xq/pagosMasivosInternoGTHeaderOut.xqy`

## Reglas de Negocio

### RN-GT-001: Validación de Servicio Regional
**Ubicación**: `PagosMasivosInterno.pipeline` - Stage `ValidacionesGenerales`
**Descripción**: Valida que el servicio FICBCO0231 esté habilitado para GT01
**Código**: Igual que HN01

### RN-GT-002: Validación de Acceso de Usuario (MTR)
**Ubicación**: `PagosMasivosInternoGT.pipeline` - Stage `ValidaAccesosPagosMasivos`
**Descripción**: Valida acceso mediante servicio externo MTR
**Código**:
```xquery
if(string($RSPValidaAccesoPMS/status/text()) = '00000')then(
    'SUCCESS'
)else('ERROR')
```
**Acción**: Si status != '00000', retorna error

### RN-GT-003: Transformación a Formato MTR
**Ubicación**: `PagosMasivosInternoGT.pipeline` - Stage `CargarLotes`
**Descripción**: Transforma request OSB a formato esperado por MTR
**XQuery**: `pagosMasivosInternoGTIn.xqy`
**Validación**: Schema validation contra WSDL de MTR

### RN-GT-004: Procesamiento Externo
**Ubicación**: `PagosMasivosInternoGT.pipeline` - Stage `CargarLotes`
**Descripción**: Delega procesamiento completo a servicio MTR
**Código**: Invocación SOAP a `cargadorArchivoLote`

### RN-GT-005: Bitácora con Country Code
**Ubicación**: `PagosMasivosInternoGT.pipeline` - Stages `BitacoraRequest` y `BitacoraResponse`
**Descripción**: Registra con campo adicional countryCode=GT01
**Código**:
```xquery
<PV_COUNTRY_CODE>string($header/aut:RequestHeader/Region/SourceBank/text())</PV_COUNTRY_CODE>
```

### RN-GT-006: Mapeo de Errores
**Ubicación**: `PagosMasivosInternoGT.pipeline` - Error Handler
**Descripción**: Mapea errores técnicos a mensajes de negocio
**Código**: Invoca MapeoErrores con FICBCO0231

## Cadenas de Conexión

### Servicio SOAP Externo (MTR)

**cargadorArchivoLote**:
- Tipo: SOAP Business Service
- Ubicación: `Middleware/v2/BusinessServices/MTR/cargadorArchivoLote/biz/cargadorArchivoLote`
- WSDL: `Middleware/v2/BusinessServices/MTR/cargadorArchivoLote/wsdl/cargadorArchivoLoteEndpoint.wsdl`
- Namespace: `http://servicio.cargararchivolotews.mtrpmsv.cidenet.com.co/`
- Operación: `cargarLotes`
- Endpoint: Configurado en Business Service (no visible en código)

**validaAccesoPMS**:
- Tipo: SOAP Business Service
- Ubicación: `Middleware/v2/BusinessServices/MTR/validaAccesoPMS/biz/validaAccesoPMS`
- Operación: `validaAccesoPMS`
- Endpoint: Configurado en Business Service (no visible en código)

### Base de Datos Oracle

**registraBitacoraPagosMasivosRG_db**:
- Tipo: JCA Database Adapter
- Archivo: `Middleware/v2/BusinessServices/PMSV/registraBitacoraPagosMasivosRG/jca/registraBitacoraPagosMasivosRG_db.jca`
- Operación: `registraBitacoraPagosMasivosRG` (Stored Procedure)
- **Campo adicional**: `PV_COUNTRY_CODE`

**ValidaServicioRegional_db**:
- Igual que HN01

## Diferencias con HN01

1. **Sin validación de saldos**: No consulta saldos en tiempo real
2. **Sin validación de estado**: No consulta estado de cuentas
3. **Procesamiento externo**: Delega a servicio MTR
4. **Sin procesamiento paralelo**: Procesamiento secuencial en MTR
5. **Bitácora con countryCode**: Campo adicional en bitácora
6. **Validación de acceso externa**: Usa servicio MTR en lugar de BD local
7. **Sin agrupación por cuenta**: No agrupa transacciones
8. **Transformación adicional**: Requiere mapeo a formato MTR
