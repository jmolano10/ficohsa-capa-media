# Ejemplos y Mapeos - HN01 (Honduras)

## Request OSB (Ejemplo SOAP)

### SOAP Envelope Completo

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType"
                  xmlns:pag="http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes">
   <soapenv:Header>
      <aut:RequestHeader>
         <Authentication>
            <UserName>USUARIO_CORP_001</UserName>
            <Password>P@ssw0rd123</Password>
         </Authentication>
         <Region>
            <SourceBank>HN01</SourceBank>
         </Region>
      </aut:RequestHeader>
   </soapenv:Header>
   <soapenv:Body>
      <pag:pagosMasivos>
         <GLOBAL_ID>TXN-20240115-001</GLOBAL_ID>
         <CUSTOMER_ID>CORP12345</CUSTOMER_ID>
         <USERNAME>usuario.corporativo</USERNAME>
         <BATCHES>
            <BATCH>
               <CUSTOMER_BATCH_ID>LOTE-2024-001</CUSTOMER_BATCH_ID>
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
                     <FIELD>DOCUMENT_NUMBER</FIELD>
                  </FIELDS>
                  <DELIMITER>|</DELIMITER>
               </DATA_STRUCTURE>
               <TRANSACTIONS>
                  <TRANSACTION>1234567890|9876543210|5000.00|Juan Perez|0801199012345</TRANSACTION>
                  <TRANSACTION>1234567890|9876543211|4500.00|Maria Lopez|0801199012346</TRANSACTION>
                  <TRANSACTION>1234567890|9876543212|5500.00|Carlos Gomez|0801199012347</TRANSACTION>
               </TRANSACTIONS>
            </BATCH>
         </BATCHES>
      </pag:pagosMasivos>
   </soapenv:Body>
</soapenv:Envelope>
```

---

## Response OSB (Ejemplo SOAP)

### Respuesta Exitosa

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType"
                  xmlns:pag="http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes">
   <soapenv:Header>
      <aut:ResponseHeader>
         <successIndicator>Success</successIndicator>
      </aut:ResponseHeader>
   </soapenv:Header>
   <soapenv:Body>
      <pag:pagosMasivosResponse>
         <GLOBAL_ID>TXN-20240115-001</GLOBAL_ID>
         <CUSTOMER_ID>CORP12345</CUSTOMER_ID>
         <BATCHES>
            <BATCH>
               <BANK_BATCH_ID>987654</BANK_BATCH_ID>
               <CUSTOMER_BATCH_ID>LOTE-2024-001</CUSTOMER_BATCH_ID>
               <STATUS>PENDING</STATUS>
               <ERROR_CODE></ERROR_CODE>
               <ERROR_MESSAGE></ERROR_MESSAGE>
            </BATCH>
         </BATCHES>
      </pag:pagosMasivosResponse>
   </soapenv:Body>
</soapenv:Envelope>
```

### Respuesta con Error

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType"
                  xmlns:pag="http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes">
   <soapenv:Header>
      <aut:ResponseHeader>
         <successIndicator>Error</successIndicator>
         <messages>El usuario no tiene permisos para realizar pagos masivos</messages>
      </aut:ResponseHeader>
   </soapenv:Header>
   <soapenv:Body>
      <pag:pagosMasivosResponse/>
   </soapenv:Body>
</soapenv:Envelope>
```

---

## Cadenas de Conexión y Credenciales

### 1. Base de Datos - Validación Regional

**Servicio:** ValidaServicioRegional_db  
**Ruta:** `Middleware/v2/BusinessServices/ValidaServicioRegional/biz/ValidaServicioRegional_db`  
**Tipo:** DB Adapter (JCA)  
**Operación:** ValidaServicioRegional  
**Base de Datos:** Oracle (esquema no especificado en proxy)  
**Stored Procedure:** `ValidaServicioRegional`  

**Parámetros de Entrada:**
- `PV_SERVICE_ID`: "FICBCO0231"
- `PV_SOURCE_BANK`: Valor de header/aut:RequestHeader/Region/SourceBank

**Parámetros de Salida:**
- `PV_CODIGO_ERROR`: Código de error (SUCCESS si ok)
- `PV_MENSAJE_ERROR`: Mensaje de error

---

### 2. Base de Datos - Bitácora de Pagos Masivos

**Servicio:** registraBitacoraPagosMasivos_db  
**Ruta:** `Middleware/v2/BusinessServices/PMSV/registraBitacoraPagosMasivos/biz/registraBitacoraPagosMasivos_db`  
**Tipo:** DB Adapter (JCA)  
**Operación:** registraBitacoraPagosMasivos  
**Base de Datos:** Oracle  
**Esquema:** PMSV  
**Stored Procedure:** `registraBitacoraPagosMasivos`  

**Parámetros:**
- `PV_ID`: UUID generado
- `PV_REQUEST_ID`: UUID del request (vacío en request, lleno en response)
- `PV_RECORD_DATE`: fn:current-dateTime()
- `PV_RECORD_TYPE`: "REQ" o "RSP"
- `PV_OPERATION`: "PagosMasivos"
- `PV_CUSTOMER_ID`: Del body
- `PV_USERNAME`: Del body
- `PV_AUTH_USERNAME`: Del header Authentication/UserName
- `PV_REQUEST_HOST`: Del header HTTP 'host'
- `PV_SOAP_CONTENT`: XML del body completo
- `PV_RESPONSE_CODE`: successIndicator (vacío en request)
- `PV_RESPONSE_MESSAGE`: messages (vacío en request)
- `PV_GLOBAL_ID`: Del body

---

### 3. Base de Datos - Validación de Acceso

**Servicio:** validaAccesoPMS_db  
**Ruta:** `Middleware/v2/BusinessServices/PMSV/validaAccesoPMS/biz/validaAccesoPMS_db`  
**Tipo:** DB Adapter (JCA)  
**Operación:** validaAccesoPMS  
**Base de Datos:** Oracle  
**Esquema:** PMSV  
**Stored Procedure:** `validaAccesoPMS`  

**Parámetros de Entrada:**
- `PV_CUSTOMER_ID`: ID del cliente corporativo
- `PV_USER_NAME`: Usuario autenticado del header

**Parámetros de Salida:**
- `PV_ERROR_MESSAGE`: Mensaje de error (vacío si ok)

---

### 4. Servicio Java - Procesamiento de Pagos Masivos

**Servicio:** sjPagosMasivosInterno  
**Ruta:** `Middleware/v2/BusinessServices/SJS/pagosMasivosInterno/biz/sjPagosMasivosInterno`  
**Tipo:** Business Service (Java)  
**Operación:** PagosMasivosInterno  
**WSDL:** `Middleware/v2/BusinessServices/SJS/pagosMasivosInterno/wsdl/sjPagosMasivosInterno.wsdl`  

**Dependencias Internas del Servicio Java:**
- `consultaDeSaldoDeCuentaIn.xq`: Consulta saldo de cuenta
- `consultaDetalleDeCuentaIn.xq`: Consulta detalle de cuenta
- `consultaDetallesCuentaMasivosIn.Xquery`: Consulta detalles masivos
- `procesaLotePagoMasivoIn.xq`: Procesa lote de pagos
- `validaEstructuraLoteIn.xq`: Valida estructura del lote
- `sjPagosMasivosInternoBacthOut.xq`: Transforma respuesta batch

---

### 5. Servicio - Mapeo de Errores

**Servicio:** MapeoErrores  
**Ruta:** `Middleware/v2/ProxyServices/MapeoErrores`  
**Tipo:** Proxy Service  
**Operación:** mapeoErrores  

**Request:**
- `CODIGO_ERROR`: Código de error capturado
- `MENSAJE_ERROR`: "FICBCO0231$#$" + mensaje de error

**Response:**
- Header con successIndicator y messages mapeados

---

## Mapeo de Entrada - OSB a Servicio Java (sjPagosMasivosInterno)

### Transformación: sjPagosMasivosInternoIn.xq

| Campo Origen (OSB) | Transformación/Script | Campo Destino (SJS) | Notas |
|--------------------|----------------------|---------------------|-------|
| $body/pag:pagosMasivos | Elemento raíz | Request completo | Se pasa el elemento completo |
| $header/aut:RequestHeader | Elemento header | Header del request | Se pasa el header completo |
| - | Construcción de estructura | Estructura específica SJS | El XQuery construye estructura esperada por Java |

**Archivo:** `Middleware/v2/Resources/PagosMasivosInterno/xq/sjPagosMasivosInternoIn.xq`

**Reglas de Negocio:**
- Valida que pagosMasivos no sea nulo
- Valida que requestHeader no sea nulo
- Construye estructura compatible con servicio Java
- Preserva todos los campos del request original

---

## Mapeo de Salida - Servicio Java a OSB

### Transformación: pagosMasivosInternoOut.xq

| Campo Origen (SJS) | Transformación/Script | Campo Destino (OSB) | Notas |
|--------------------|----------------------|---------------------|-------|
| $RSPPagosMasivosInterno | Elemento raíz response | pag:pagosMasivosResponse | Mapeo de respuesta Java |
| - | Extracción de campos | GLOBAL_ID, CUSTOMER_ID, BATCHES | Construcción de response OSB |

**Archivo:** `Middleware/v2/Resources/PagosMasivosInterno/xq/pagosMasivosInternoOut.xq`

**Reglas de Negocio:**
- Extrae información de respuesta Java
- Construye estructura OSB estándar
- Mapea códigos de estado
- Preserva información de errores

---

## Mapeo de Entrada - Validación de Acceso

### Transformación: validarAccesoPMSIn.xq

| Campo Origen (OSB) | Transformación/Script | Campo Destino (DB) | Notas |
|--------------------|----------------------|-------------------|-------|
| $body/pag:pagosMasivos/CUSTOMER_ID/text() | fn:string() | PV_CUSTOMER_ID | ID del cliente |
| $header/aut:RequestHeader/Authentication/UserName/text() | fn:string() | PV_USER_NAME | Usuario autenticado |

**Archivo:** `Middleware/v2/Resources/PagosMasivos/xq/validarAccesoPMSIn.xq`

**Reglas de Negocio:**
- Valida que CUSTOMER_ID no esté vacío
- Valida que UserName no esté vacío
- Convierte a string para evitar problemas de tipo

---

## Mapeo de Entrada - Bitácora

### Transformación: registrarBitacoraPagosMasivosIn.xq

| Campo Origen (OSB) | Transformación/Script | Campo Destino (DB) | Notas |
|--------------------|----------------------|-------------------|-------|
| $id (parámetro) | fn:string() | PV_ID | UUID generado previamente |
| $requestId (parámetro) | string | PV_REQUEST_ID | UUID del request relacionado |
| fn:current-dateTime() | Función XQuery | PV_RECORD_DATE | Timestamp actual |
| $recordType (parámetro) | string | PV_RECORD_TYPE | "REQ" o "RSP" |
| "PagosMasivos" | Constante | PV_OPERATION | Nombre de operación |
| $customerId (parámetro) | string | PV_CUSTOMER_ID | ID del cliente |
| $username (parámetro) | string | PV_USERNAME | Usuario del body |
| $authUsername (parámetro) | string | PV_AUTH_USERNAME | Usuario autenticado |
| $requestHost (parámetro) | string | PV_REQUEST_HOST | Host del request HTTP |
| $soapContent (parámetro) | XML | PV_SOAP_CONTENT | Contenido SOAP completo |
| $responseCode (parámetro) | string | PV_RESPONSE_CODE | Código de respuesta |
| $responseMessage (parámetro) | substring(..., 1, 4000) | PV_RESPONSE_MESSAGE | Mensaje (máx 4000 chars) |
| $globalId (parámetro) | string | PV_GLOBAL_ID | ID global de transacción |

**Archivo:** `Middleware/v2/Resources/PagosMasivosInterno/xq/registrarBitacoraPagosMasivosIn.xq`

**Reglas de Negocio:**
- Genera UUID único para cada registro
- Relaciona request y response mediante REQUEST_ID
- Limita mensaje a 4000 caracteres
- Registra contenido SOAP completo para auditoría
- Captura host del cliente para trazabilidad

---

## Reglas de Negocio Detectadas

### 1. Validación de Servicio Regional

**Ubicación:** Pipeline `ValidacionesGenerales_request`, Stage `ValidacionServicioRegional`  
**Archivo:** PagosMasivosInterno.proxy

**Lógica:**
```xquery
if (fn:string($respValidaServicioRegional/val:PV_CODIGO_ERROR/text()) != 'SUCCESS') then
  -- Retornar error y detener procesamiento
else
  -- Continuar con flujo normal
```

**Regla:** El servicio debe estar habilitado para la región HN01. Si no está habilitado, se retorna error inmediatamente sin procesar.

---

### 2. Validación de Acceso del Cliente

**Ubicación:** Pipeline `HN01_PagosMasivosInterno_request`, Stage `FlujoEntrada`  
**Archivo:** PagosMasivosInterno.proxy

**Lógica:**
```xquery
if ($validationMessage != "") then
  -- Cliente no tiene acceso, retornar error
else
  -- Cliente tiene acceso, invocar servicio Java
```

**Regla:** El cliente debe tener permisos configurados en base de datos para realizar pagos masivos. La validación se hace contra stored procedure que verifica permisos.

---

### 3. Validación XSD

**Ubicación:** Pipeline `ValidacionesGenerales_request`, Stage `ValidacionXSD`  
**Archivo:** PagosMasivosInterno.proxy

**Lógica:**
```xml
<con3:validate>
  <con3:schema ref="Middleware/v2/Resources/PagosMasivos/xsd/pagosMasivosTypes"/>
  <con3:schemaElement>pag:pagosMasivos</con3:schemaElement>
</con3:validate>
```

**Regla:** El request debe cumplir con el esquema XSD definido. Campos obligatorios:
- GLOBAL_ID
- CUSTOMER_ID (minLength=1)
- USERNAME (minLength=1)
- BATCHES con al menos un BATCH

---

### 4. Aplicación de Valores por Defecto Regional

**Ubicación:** Pipeline `ValidacionesGenerales_request`, Stage `ValidacionServicioRegional`  
**Archivo:** PagosMasivosInterno.proxy

**Transformación:**
```xquery
<con2:resource ref="Middleware/v2/Resources/Generales/xq/aplicarValoresPorDefectoRegion"/>
```

**Regla:** Después de validar la región, se aplican valores por defecto específicos de HN01 al header del request.

---

### 5. Mapeo de Errores

**Ubicación:** Pipeline `ValidacionesGenerales_response`, Stage `MapeoError`  
**Archivo:** PagosMasivosInterno.proxy

**Lógica:**
```xquery
if (fn:upper-case(fn:string($header/aut:ResponseHeader/successIndicator/text())) != "SUCCESS") then
  -- Invocar servicio MapeoErrores
  -- Parámetros: CODIGO_ERROR, MENSAJE_ERROR con prefijo "FICBCO0231$#$"
```

**Regla:** Todos los errores se mapean a través del servicio centralizado MapeoErrores para estandarizar mensajes al cliente.

---

### 6. Bitácora Completa

**Ubicación:** Múltiples stages  
**Archivo:** PagosMasivosInterno.proxy

**Regla:** Se registra:
- **Request**: Al inicio del procesamiento con recordType="REQ"
- **Response**: Al finalizar exitosamente con recordType="RSP"
- **Error**: Al capturar excepción con recordType="RSP"

Cada registro incluye:
- UUID único
- Relación request-response mediante REQUEST_ID
- Contenido SOAP completo
- Timestamp
- Usuario y host

---

### 7. Manejo de Errores en Pipeline

**Ubicación:** Error Handler `_onErrorHandler-2505472247673107556-63174895.1566ba355e3.-64f8`  
**Archivo:** PagosMasivosInterno.proxy

**Lógica:**
1. Capturar errorCode y errorMessage del fault
2. Invocar MapeoErrores con código FICBCO0231
3. Registrar error en bitácora
4. Construir response vacío con error en header
5. Retornar al cliente

**Regla:** Cualquier excepción no controlada se captura, se mapea, se registra y se retorna de forma estándar.

---

### 8. Generación de UUID

**Ubicación:** Múltiples stages  
**Archivo:** PagosMasivosInterno.proxy

**Transformación:**
```xquery
<con2:resource ref="Middleware/Business_Resources/general/UUID/obtenerUUID"/>
```

**Regla:** Se generan UUIDs únicos para:
- Bitácora de request
- Bitácora de response
- Bitácora de error

Esto permite trazabilidad completa de cada transacción.

---

## Flujo de Datos Completo

### Flujo Exitoso

```
Cliente → PagosMasivos.proxy
  ↓
  Validación Autenticación (custom-token)
  ↓
  Enrutamiento por operación → pagosMasivos
  ↓
PagosMasivosInterno.proxy
  ↓
  Validación XSD
  ↓
  Validación Servicio Regional (BD)
  ↓
  Bitácora Request (BD)
  ↓
  Validación Acceso Cliente (BD)
  ↓
  Transformación Request (XQuery)
  ↓
  Invocación sjPagosMasivosInterno (Java)
  ↓
  Transformación Response (XQuery)
  ↓
  Bitácora Response (BD)
  ↓
  Mapeo Errores (si aplica)
  ↓
Cliente ← Response SOAP
```

### Flujo con Error

```
Cliente → PagosMasivos.proxy
  ↓
  [Error en cualquier punto]
  ↓
  Error Handler
  ↓
  Captura errorCode y errorMessage
  ↓
  Invoca MapeoErrores
  ↓
  Registra en Bitácora (si UUID existe)
  ↓
  Construye Response con error
  ↓
Cliente ← Response SOAP con error
```

---

## Consideraciones Técnicas

### Performance
- Múltiples llamadas a BD (validación, bitácora)
- Procesamiento síncrono con Java
- Sin timeout configurado explícitamente

### Seguridad
- Autenticación custom-token
- Validación de permisos en BD
- Auditoría completa en bitácora

### Escalabilidad
- Procesamiento síncrono limita throughput
- Dependencia de BD para cada request
- Sin pooling de conexiones visible

### Resiliencia
- Error handler robusto
- Bitácora de errores
- Mapeo centralizado de errores
- Sin retry automático
