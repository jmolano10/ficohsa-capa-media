# Ejemplos y Mapeos - GT01 (Guatemala)

## Request OSB (Ejemplo SOAP)

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType"
                  xmlns:pag="http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes">
   <soapenv:Header>
      <aut:RequestHeader>
         <Authentication>
            <UserName>USUARIO_GT_001</UserName>
            <Password>P@ssw0rd123</Password>
         </Authentication>
         <Region>
            <SourceBank>GT01</SourceBank>
         </Region>
      </aut:RequestHeader>
   </soapenv:Header>
   <soapenv:Body>
      <pag:pagosMasivos>
         <GLOBAL_ID>TXN-GT-20240115-001</GLOBAL_ID>
         <CUSTOMER_ID>CORPGT12345</CUSTOMER_ID>
         <USERNAME>usuario.guatemala</USERNAME>
         <BATCHES>
            <BATCH>
               <CUSTOMER_BATCH_ID>LOTE-GT-2024-001</CUSTOMER_BATCH_ID>
               <TYPE>1</TYPE>
               <CONCEPT_BATCH>Pago de Proveedores Guatemala</CONCEPT_BATCH>
               <APPLICATION_DATE>2024-01-15T10:00:00</APPLICATION_DATE>
               <DATA_STRUCTURE>
                  <VALIDATIONS>
                     <DEBIT_ACCT_BALANCE>YES</DEBIT_ACCT_BALANCE>
                     <DEBIT_ACCT_STATUS>YES</DEBIT_ACCT_STATUS>
                     <NUMBER_OF_TRANSACTIONS>2</NUMBER_OF_TRANSACTIONS>
                     <TOTAL_AMOUNT>25000.00</TOTAL_AMOUNT>
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
                  <TRANSACTION>GT1234567890|GT9876543210|15000.00|Proveedor GT 1</TRANSACTION>
                  <TRANSACTION>GT1234567890|GT9876543211|10000.00|Proveedor GT 2</TRANSACTION>
               </TRANSACTIONS>
            </BATCH>
         </BATCHES>
      </pag:pagosMasivos>
   </soapenv:Body>
</soapenv:Envelope>
```

## Response OSB (Ejemplo SOAP)

### Respuesta Exitosa

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType"
                  xmlns:pag="http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes">
   <soapenv:Header>
      <aut:ResponseHeader>
         <successIndicator>SUCCESS</successIndicator>
         <messages>Lote cargado exitosamente</messages>
      </aut:ResponseHeader>
   </soapenv:Header>
   <soapenv:Body>
      <pag:pagosMasivosResponse>
         <GLOBAL_ID>TXN-GT-20240115-001</GLOBAL_ID>
         <CUSTOMER_ID>CORPGT12345</CUSTOMER_ID>
         <BATCHES>
            <BATCH>
               <BANK_BATCH_ID>GT987654</BANK_BATCH_ID>
               <CUSTOMER_BATCH_ID>LOTE-GT-2024-001</CUSTOMER_BATCH_ID>
               <STATUS>LOADED</STATUS>
            </BATCH>
         </BATCHES>
      </pag:pagosMasivosResponse>
   </soapenv:Body>
</soapenv:Envelope>
```

## Cadenas de Conexión y Credenciales

### 1. Base de Datos - Bitácora Regional

**Servicio:** registraBitacoraPagosMasivosRG_db  
**Ruta:** `Middleware/v2/BusinessServices/PMSV/registraBitacoraPagosMasivosRG/biz/registraBitacoraPagosMasivosRG_db`  
**Tipo:** DB Adapter (JCA)  
**Operación:** registraBitacoraPagosMasivosRG  
**Base de Datos:** Oracle  
**Esquema:** PMSV  
**Stored Procedure:** `registraBitacoraPagosMasivosRG`  

**Parámetros Adicionales vs HN01:**
- `PV_COUNTRY_CODE`: "GT01"

### 2. Servicio Web - Validación de Acceso

**Servicio:** validaAccesoPMS (MTR)  
**Ruta:** `Middleware/v2/BusinessServices/MTR/validaAccesoPMS/biz/validaAccesoPMS`  
**Tipo:** Web Service SOAP  
**Operación:** validaAccesoPMS  
**Namespace:** http://www.ficohsa.com.hn/schema/pms/accessCheck  

**Request:**
```xml
<acc:validaAccesoPMS>
  <customerId>CORPGT12345</customerId>
  <userName>USUARIO_GT_001</userName>
</acc:validaAccesoPMS>
```

**Response:**
```xml
<acc:validaAccesoPMSResponse>
  <status>00000</status>
  <message>Acceso autorizado</message>
</acc:validaAccesoPMSResponse>
```

**Regla de Negocio:** status = '00000' indica éxito

### 3. Servicio Web - Cargador de Lotes

**Servicio:** cargadorArchivoLote (MTR)  
**Ruta:** `Middleware/v2/BusinessServices/MTR/cargadorArchivoLote/biz/cargadorArchivoLote`  
**Tipo:** Web Service SOAP  
**Operación:** cargarLotes  
**WSDL:** cargadorArchivoLoteEndpoint.wsdl  
**Namespace:** http://servicio.cargararchivolotews.mtrpmsv.cidenet.com.co/  

**Request Interno:**
```xml
<ser:cargarLotes>
  <peticionHostToHost>
    <cabeceraPeticion>
      <pais>GT</pais>
      <empresa>01</empresa>
      <usuario>USUARIO_GT_001</usuario>
      <idCliente>CORPGT12345</idCliente>
    </cabeceraPeticion>
    <cuerpoLote>
      <idLoteCliente>LOTE-GT-2024-001</idLoteCliente>
      <tipoLote>1</tipoLote>
      <conceptoLote>Pago de Proveedores Guatemala</conceptoLote>
      <fechaAplicacion>2024-01-15T10:00:00</fechaAplicacion>
      <estructuraDatos>
        <validaciones>
          <validaSaldoCuentaCargo>YES</validaSaldoCuentaCargo>
          <validaEstadoCuentaCargo>YES</validaEstadoCuentaCargo>
          <numeroTransacciones>2</numeroTransacciones>
          <montoTotal>25000.00</montoTotal>
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
        <transaccion>GT1234567890|GT9876543210|15000.00|Proveedor GT 1</transaccion>
        <transaccion>GT1234567890|GT9876543211|10000.00|Proveedor GT 2</transaccion>
      </transacciones>
    </cuerpoLote>
  </peticionHostToHost>
</ser:cargarLotes>
```

**Response Interno:**
```xml
<ser:cargarLotesResponse>
  <respuestaHostToHost>
    <cabeceraRespuesta>
      <codigo>SUCCESS</codigo>
      <mensaje>Lote cargado exitosamente</mensaje>
    </cabeceraRespuesta>
    <cuerpoRespuesta>
      <idLoteBanco>GT987654</idLoteBanco>
      <idLoteCliente>LOTE-GT-2024-001</idLoteCliente>
      <estado>LOADED</estado>
    </cuerpoRespuesta>
  </respuestaHostToHost>
</ser:cargarLotesResponse>
```

## Mapeo de Entrada - OSB a MTR

### Transformación: pagosMasivosInternoGTIn.xq

| Campo Origen (OSB) | Transformación/Script | Campo Destino (MTR) | Notas |
|--------------------|----------------------|---------------------|-------|
| $header/aut:RequestHeader/Region/SourceBank | substring(., 1, 2) | peticionHostToHost/cabeceraPeticion/pais | Extrae "GT" |
| $header/aut:RequestHeader/Region/SourceBank | substring(., 3, 2) | peticionHostToHost/cabeceraPeticion/empresa | Extrae "01" |
| $header/aut:RequestHeader/Authentication/UserName | string | peticionHostToHost/cabeceraPeticion/usuario | Usuario autenticado |
| $body/pag:pagosMasivos/CUSTOMER_ID | string | peticionHostToHost/cabeceraPeticion/idCliente | ID del cliente |
| $body/pag:pagosMasivos/BATCHES/BATCH/CUSTOMER_BATCH_ID | string | peticionHostToHost/cuerpoLote/idLoteCliente | ID del lote |
| $body/pag:pagosMasivos/BATCHES/BATCH/TYPE | integer | peticionHostToHost/cuerpoLote/tipoLote | Tipo de lote |
| $body/pag:pagosMasivos/BATCHES/BATCH/CONCEPT_BATCH | string | peticionHostToHost/cuerpoLote/conceptoLote | Concepto |
| $body/pag:pagosMasivos/BATCHES/BATCH/APPLICATION_DATE | dateTime | peticionHostToHost/cuerpoLote/fechaAplicacion | Fecha aplicación |
| $body/pag:pagosMasivos/BATCHES/BATCH/DATA_STRUCTURE/VALIDATIONS/DEBIT_ACCT_BALANCE | string | peticionHostToHost/cuerpoLote/estructuraDatos/validaciones/validaSaldoCuentaCargo | Validación saldo |
| $body/pag:pagosMasivos/BATCHES/BATCH/DATA_STRUCTURE/VALIDATIONS/DEBIT_ACCT_STATUS | string | peticionHostToHost/cuerpoLote/estructuraDatos/validaciones/validaEstadoCuentaCargo | Validación estado |
| $body/pag:pagosMasivos/BATCHES/BATCH/DATA_STRUCTURE/VALIDATIONS/NUMBER_OF_TRANSACTIONS | integer | peticionHostToHost/cuerpoLote/estructuraDatos/validaciones/numeroTransacciones | Número de txns |
| $body/pag:pagosMasivos/BATCHES/BATCH/DATA_STRUCTURE/VALIDATIONS/TOTAL_AMOUNT | decimal | peticionHostToHost/cuerpoLote/estructuraDatos/validaciones/montoTotal | Monto total |
| $body/pag:pagosMasivos/BATCHES/BATCH/DATA_STRUCTURE/FIELDS/FIELD | for-each | peticionHostToHost/cuerpoLote/estructuraDatos/campos/campo | Lista de campos |
| $body/pag:pagosMasivos/BATCHES/BATCH/DATA_STRUCTURE/DELIMITER | string | peticionHostToHost/cuerpoLote/estructuraDatos/delimitador | Delimitador |
| $body/pag:pagosMasivos/BATCHES/BATCH/TRANSACTIONS/TRANSACTION | for-each | peticionHostToHost/cuerpoLote/transacciones/transaccion | Lista de transacciones |

**Archivo:** `Middleware/v2/Resources/PagosMasivosInterno/xq/pagosMasivosInternoGTIn.xq`

**Reglas de Negocio:**
- Divide SourceBank en país (2 chars) y empresa (2 chars)
- Mapea nombres de campos OSB a nombres MTR
- Preserva estructura de transacciones como strings delimitados
- Valida que BATCH exista antes de mapear

## Mapeo de Salida - MTR a OSB

### Transformación Response Body: pagosMasivosInternoGTOut.xq

| Campo Origen (MTR) | Transformación/Script | Campo Destino (OSB) | Notas |
|--------------------|----------------------|---------------------|-------|
| $cargarLotesResponse/respuestaHostToHost/cuerpoRespuesta/idLoteBanco | string | pag:pagosMasivosResponse/BATCHES/BATCH/BANK_BATCH_ID | ID asignado por banco |
| $cargarLotesResponse/respuestaHostToHost/cuerpoRespuesta/idLoteCliente | string | pag:pagosMasivosResponse/BATCHES/BATCH/CUSTOMER_BATCH_ID | ID del cliente |
| $cargarLotesResponse/respuestaHostToHost/cuerpoRespuesta/estado | string | pag:pagosMasivosResponse/BATCHES/BATCH/STATUS | Estado del lote |
| $originalRequestBody/pag:pagosMasivos/GLOBAL_ID | string | pag:pagosMasivosResponse/GLOBAL_ID | Del request original |
| $originalRequestBody/pag:pagosMasivos/CUSTOMER_ID | string | pag:pagosMasivosResponse/CUSTOMER_ID | Del request original |

**Archivo:** `Middleware/v2/Resources/PagosMasivosInterno/xq/pagosMasivosInternoGTOut.xq`

### Transformación Response Header: pagosMasivosInternoGTHeaderOut.xq

| Campo Origen (Variables) | Transformación/Script | Campo Destino (OSB) | Notas |
|--------------------------|----------------------|---------------------|-------|
| $errorCode | string | aut:ResponseHeader/successIndicator | SUCCESS o ERROR |
| $validationMessage | string | aut:ResponseHeader/messages | Mensaje de respuesta |

**Archivo:** `Middleware/v2/Resources/PagosMasivosInterno/xq/pagosMasivosInternoGTHeaderOut.xq`

**Lógica:**
```xquery
<aut:ResponseHeader>
  <successIndicator>{ $errorCode }</successIndicator>
  <messages>{ $validationMessage }</messages>
</aut:ResponseHeader>
```

## Reglas de Negocio Específicas GT01

### 1. Validación de Acceso MTR

**Ubicación:** Stage `ValidaAccesosPagosMasivos`  
**Archivo:** PagosMasivosInternoGT.proxy

**Lógica:**
```xquery
$errorCode := if(string($RSPValidaAccesoPMS/status/text()) = '00000') then 'SUCCESS' else 'ERROR'
$validationMessage := string($RSPValidaAccesoPMS/message/text())
```

**Regla:** El servicio MTR retorna código numérico. Solo '00000' es éxito.

### 2. Validación de Response MTR

**Ubicación:** Stage `CargarLotes`  
**Archivo:** PagosMasivosInternoGT.proxy

**Lógica:**
```xquery
$errorCode := string($RSPcargarLotes/respuestaHostToHost/cabeceraRespuesta/codigo/text())
$validationMessage := string($RSPcargarLotes/respuestaHostToHost/cabeceraRespuesta/mensaje/text())
```

**Regla:** El código de respuesta MTR se usa directamente como successIndicator.

### 3. Bitácora con Country Code

**Ubicación:** Múltiples stages  
**Archivo:** PagosMasivosInternoGT.proxy

**Parámetro Adicional:**
```xquery
<con2:param name="countryCode">
  <con2:path>string($header/aut:RequestHeader/Region/SourceBank/text())</con2:path>
</con2:param>
```

**Regla:** La bitácora regional incluye el código de país completo (GT01) para diferenciar registros.

### 4. Validación de Request MTR

**Ubicación:** Stage `CargarLotes`  
**Archivo:** PagosMasivosInternoGT.proxy

**Validación:**
```xml
<con3:validate>
  <con3:wsdl ref="Middleware/v2/BusinessServices/MTR/cargadorArchivoLote/wsdl/cargadorArchivoLoteEndpoint"/>
  <con3:schemaElement xmlns:ser1="http://servicio.cargararchivolotews.mtrpmsv.cidenet.com.co/">ser1:cargarLotes</con3:schemaElement>
</con3:validate>
```

**Regla:** El request a MTR se valida contra WSDL antes de enviar para detectar errores de estructura.

## Flujo de Datos GT01

```
Cliente → PagosMasivos.proxy
  ↓
  Enrutamiento → GT01
  ↓
PagosMasivosInternoGT.proxy
  ↓
  Bitácora Request (BD Regional)
  ↓
  Validación Acceso (MTR Web Service)
  ↓
  if (status != '00000') → Error
  ↓
  Transformación Request (XQuery)
  ↓
  Validación WSDL
  ↓
  Invocación cargadorArchivoLote (MTR)
  ↓
  Extracción código y mensaje
  ↓
  Transformación Response Header y Body
  ↓
  Bitácora Response (BD Regional)
  ↓
Cliente ← Response SOAP
```

## Diferencias Clave vs HN01

1. **Backend:** Web Service MTR vs Java Service SJS
2. **Validación Acceso:** Web Service vs Stored Procedure
3. **Bitácora:** SP Regional con countryCode vs SP estándar
4. **Transformaciones:** Mapeo a estructura MTR vs estructura Java
5. **Validación:** WSDL validation vs sin validación explícita
6. **Response:** Código directo de MTR vs mapeo de Java
