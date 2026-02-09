# Ejemplos y Mapeos - NI01 (Nicaragua)

## Nota Importante
La implementación de NI01 es **similar** a GT01 y PA01, con las siguientes diferencias clave:

1. **SIN Validación de Acceso**: No valida acceso de usuario
2. **SIN Bitácora**: No registra request/response en base de datos
3. **Flujo Simplificado**: Menos stages en el pipeline

## Request OSB - Operación pagosMasivos

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:pag="http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:RequestHeader>
         <Authentication>
            <UserName>USUARIO_NI</UserName>
            <Password>********</Password>
         </Authentication>
         <Region>
            <SourceBank>NI01</SourceBank>
         </Region>
      </aut:RequestHeader>
   </soapenv:Header>
   <soapenv:Body>
      <pag:pagosMasivos>
         <GLOBAL_ID>GLB-NI-20240115-001</GLOBAL_ID>
         <CUSTOMER_ID>NI1234567890</CUSTOMER_ID>
         <USERNAME>USUARIO_NI</USERNAME>
         <BATCHES>
            <BATCH>
               <CUSTOMER_BATCH_ID>BATCH-NI-001</CUSTOMER_BATCH_ID>
               <TYPE>1</TYPE>
               <CONCEPT_BATCH>Pago de Nómina</CONCEPT_BATCH>
               <APPLICATION_DATE>2024-01-15T10:00:00</APPLICATION_DATE>
               <DATA_STRUCTURE>
                  <VALIDATIONS>
                     <DEBIT_ACCT_BALANCE>NO</DEBIT_ACCT_BALANCE>
                     <DEBIT_ACCT_STATUS>NO</DEBIT_ACCT_STATUS>
                     <NUMBER_OF_TRANSACTIONS>2</NUMBER_OF_TRANSACTIONS>
                     <TOTAL_AMOUNT>6000.00</TOTAL_AMOUNT>
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
                  <TRANSACTION>NI1234567890|NI9876543210|3000.00|Empleado A</TRANSACTION>
                  <TRANSACTION>NI1234567890|NI9876543211|3000.00|Empleado B</TRANSACTION>
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
         <GLOBAL_ID>GLB-NI-20240115-001</GLOBAL_ID>
         <CUSTOMER_ID>NI1234567890</CUSTOMER_ID>
         <BATCHES>
            <BATCH>
               <BANK_BATCH_ID>NI100001</BANK_BATCH_ID>
               <CUSTOMER_BATCH_ID>BATCH-NI-001</CUSTOMER_BATCH_ID>
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
   <PV_SOURCE_BANK>NI01</PV_SOURCE_BANK>
</InputParameters>
```

**Response Interno**:
```xml
<OutputParameters>
   <PV_CODIGO_ERROR>SUCCESS</PV_CODIGO_ERROR>
   <PV_MENSAJE_ERROR></PV_MENSAJE_ERROR>
</OutputParameters>
```

### 2. cargadorArchivoLote (Servicio MTR)

**Request Interno**:
```xml
<ser:cargarLotes xmlns:ser="http://servicio.cargararchivolotews.mtrpmsv.cidenet.com.co/">
   <peticionHostToHost>
      <cabeceraPeticion>
         <pais>NI</pais>
         <usuario>USUARIO_NI</usuario>
         <idCliente>NI1234567890</idCliente>
      </cabeceraPeticion>
      <cuerpoLotes>
         <lote>
            <idLoteCliente>BATCH-NI-001</idLoteCliente>
            <tipoLote>1</tipoLote>
            <conceptoLote>Pago de Nómina</conceptoLote>
            <fechaAplicacion>2024-01-15T10:00:00</fechaAplicacion>
            <estructuraDatos>
               <validaciones>
                  <validarSaldoCuentaDebito>NO</validarSaldoCuentaDebito>
                  <validarEstadoCuentaDebito>NO</validarEstadoCuentaDebito>
                  <numeroTransacciones>2</numeroTransacciones>
                  <montoTotal>6000.00</montoTotal>
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
               <transaccion>NI1234567890|NI9876543210|3000.00|Empleado A</transaccion>
               <transaccion>NI1234567890|NI9876543211|3000.00|Empleado B</transaccion>
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
            <idLoteBanco>NI100001</idLoteBanco>
            <idLoteCliente>BATCH-NI-001</idLoteCliente>
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

## Tablas de Mapeo

### Mapeo de Entrada - OSB a cargadorArchivoLote

Idéntico a GT01 y PA01, con país = "NI"

**XQuery**: `Middleware/v2/Resources/PagosMasivosInterno/xq/pagosMasivosInternoNIIn.xqy`

### Mapeo de Salida - cargadorArchivoLote a OSB

Idéntico a GT01 y PA01

**XQuery**: `Middleware/v2/Resources/PagosMasivosInterno/xq/pagosMasivosInternoNIOut.xqy`

### Mapeo de Header de Respuesta

Idéntico a GT01 y PA01

**XQuery**: `Middleware/v2/Resources/PagosMasivosInterno/xq/pagosMasivosInternoNIHeaderOut.xqy`

## Reglas de Negocio

### RN-NI-001: Validación de Servicio Regional
**Ubicación**: `PagosMasivosInterno.pipeline` - Stage `ValidacionesGenerales`
**Descripción**: Valida que el servicio FICBCO0231 esté habilitado para NI01
**Código**: Igual que otras regiones

### RN-NI-002: Transformación a Formato MTR
**Ubicación**: `PagosMasivosInterno.pipeline` - Stage `NI01_PagosMasivosInterno_request`
**Descripción**: Transforma request OSB a formato esperado por MTR
**XQuery**: `pagosMasivosInternoNIIn.xqy`
**Validación**: Schema validation contra WSDL de MTR

### RN-NI-003: Procesamiento Externo
**Ubicación**: `PagosMasivosInterno.pipeline` - Stage `NI01_PagosMasivosInterno_request`
**Descripción**: Delega procesamiento completo a servicio MTR
**Código**: Invocación SOAP a `cargadorArchivoLote`

### RN-NI-004: Construcción de Response Header
**Ubicación**: `PagosMasivosInterno.pipeline` - Stage `NI01_PagosMasivosInterno_response`
**Descripción**: Construye header de respuesta desde response de MTR
**Código**:
```xquery
<aut:ResponseHeader>
    <successIndicator>{ $errorCode }</successIndicator>
    <messages>{ $validationMessage }</messages>
</aut:ResponseHeader>
```

### RN-NI-005: Mapeo de Errores
**Ubicación**: `PagosMasivosInterno.pipeline` - Stage `ValidacionesGenerales_response`
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

### Base de Datos Oracle

**ValidaServicioRegional_db**:
- Igual que otras regiones

**NOTA**: NI01 **NO** tiene conexión a:
- `registraBitacoraPagosMasivosRG_db` (sin bitácora)
- `validaAccesoPMS` (sin validación de acceso)

## Diferencias con GT01 y PA01

1. **SIN Validación de Acceso**: No invoca `validaAccesoPMS`
2. **SIN Bitácora**: No registra en `registraBitacoraPagosMasivosRG_db`
3. **Flujo Simplificado**: 
   - Solo 1 stage en request pipeline (vs 3 en GT01/PA01)
   - Solo 1 stage en response pipeline (vs 2 en GT01/PA01)
4. **Sin Error Handler de Bitácora**: No tiene stage `BitacoraResponseError`

## Diferencias con HN01

1. **Sin validación de saldos**: No consulta saldos en tiempo real
2. **Sin validación de estado**: No consulta estado de cuentas
3. **Procesamiento externo**: Delega a servicio MTR
4. **Sin procesamiento paralelo**: Procesamiento secuencial en MTR
5. **Sin bitácora**: No registra auditoría
6. **Sin validación de acceso**: No valida permisos de usuario
7. **Sin agrupación por cuenta**: No agrupa transacciones
8. **Transformación adicional**: Requiere mapeo a formato MTR

## Flujo Simplificado de NI01

```
1. ValidacionesGenerales (común)
   - ValidaServicioRegional
   - ValidacionXSD

2. RegionalizacionPaisEmpresa
   - Branch NI01

3. NI01_PagosMasivosInterno_request
   - Transformación a formato MTR (pagosMasivosInternoNIIn.xqy)
   - Invocación a cargadorArchivoLote
   - Schema validation

4. NI01_PagosMasivosInterno_response
   - Construcción de header (pagosMasivosInternoNIHeaderOut.xqy)
   - Transformación de response (pagosMasivosInternoNIOut.xqy)

5. ValidacionesGenerales_response (común)
   - MapeoError (si aplica)
```

## Recomendaciones para NI01

1. **Implementar Bitácora**: Agregar registro de auditoría para trazabilidad
2. **Implementar Validación de Acceso**: Agregar validación de permisos de usuario
3. **Monitoreo**: Implementar métricas específicas dado que no hay bitácora
4. **Documentación**: Documentar razón de ausencia de bitácora y validación
