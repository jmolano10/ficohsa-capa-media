# Ejemplos de Request/Response y Mapeo de Datos - HN01

## Request OSB (Ejemplo JSON/XML)

### SOAP Request Header
```xml
<soap:Header>
    <RequestHeader xmlns="http://www.ficohsa.com.hn/middleware.services/autType">
        <Authentication>
            <UserName>CBUSER01</UserName>
            <Password>password123</Password>
        </Authentication>
        <Region>
            <SourceBank>HN01</SourceBank>
            <DestinationBank>HN01</DestinationBank>
        </Region>
        <BankingCorrespondent>
            <Id>CORRESP001</Id>
        </BankingCorrespondent>
    </RequestHeader>
</soap:Header>
```

### SOAP Request Body
```xml
<soap:Body>
    <consultaRemesas xmlns="http://www.ficohsa.com.hn/middleware.services/consultaRemesasCBTypes">
        <REMITTANCE_ID>REM123456789</REMITTANCE_ID>
        <REMITTER_FIRSTNAME></REMITTER_FIRSTNAME>
        <REMITTER_MIDDLENAME></REMITTER_MIDDLENAME>
        <REMITTER_FIRSTSURNAME></REMITTER_FIRSTSURNAME>
        <REMITTER_SECONDSURNAME></REMITTER_SECONDSURNAME>
        <BENEFICIARY_FIRSTNAME></BENEFICIARY_FIRSTNAME>
        <BENEFICIARY_MIDDLENAME></BENEFICIARY_MIDDLENAME>
        <BENEFICIARY_FIRSTSURNAME></BENEFICIARY_FIRSTSURNAME>
        <BENEFICIARY_SECONDSURNAME></BENEFICIARY_SECONDSURNAME>
        <CORRESPONSAL_BRANCHCODE>001</CORRESPONSAL_BRANCHCODE>
        <ADDITIONAL_INFO>
            <INFO>
                <NAME>ID</NAME>
                <VALUE>CLI123456</VALUE>
            </INFO>
            <INFO>
                <NAME>LOGINUSER</NAME>
                <VALUE>encrypted_username_base64</VALUE>
            </INFO>
            <INFO>
                <NAME>LOGINPASS</NAME>
                <VALUE>encrypted_password_base64</VALUE>
            </INFO>
        </ADDITIONAL_INFO>
    </consultaRemesas>
</soap:Body>
```

## Response OSB (Ejemplo JSON/XML)

### SOAP Response Header - Éxito
```xml
<soap:Header>
    <ResponseHeader xmlns="http://www.ficohsa.com.hn/middleware.services/autType">
        <successIndicator>SUCCESS</successIndicator>
        <messages>Consulta exitosa</messages>
    </ResponseHeader>
</soap:Header>
```

### SOAP Response Body - Éxito
```xml
<soap:Body>
    <consultaRemesasResponse xmlns="http://www.ficohsa.com.hn/middleware.services/consultaRemesasCBTypes">
        <consultaRemesasResponseType>
            <consultaRemesasResponseRecordType>
                <REMITTANCE_ID>REM123456789</REMITTANCE_ID>
                <REMITTER_ID>MONEYGRAM</REMITTER_ID>
                <REMITTER_NAME>JUAN CARLOS PEREZ LOPEZ</REMITTER_NAME>
                <BENEFICIARY_NAME>MARIA ELENA RODRIGUEZ GARCIA</BENEFICIARY_NAME>
                <BRANCH_NAME>SUCURSAL CENTRO</BRANCH_NAME>
                <PAYMENT_DATE></PAYMENT_DATE>
                <CURRENCY>HNL</CURRENCY>
                <EXCHANGE_RATE>24.85</EXCHANGE_RATE>
                <REMITTANCE_STATUS>DISPONIBLE</REMITTANCE_STATUS>
                <REMITTANCE_AMOUNT>2500.00</REMITTANCE_AMOUNT>
                <REMITTANCE_SOURCE_AMOUNT>100.00</REMITTANCE_SOURCE_AMOUNT>
                <ORIGIN_COUNTRY>USA</ORIGIN_COUNTRY>
            </consultaRemesasResponseRecordType>
        </consultaRemesasResponseType>
    </consultaRemesasResponse>
</soap:Body>
```

### SOAP Response - Error
```xml
<soap:Header>
    <ResponseHeader xmlns="http://www.ficohsa.com.hn/middleware.services/autType">
        <successIndicator>ERROR</successIndicator>
        <messages>Corresponsal no autorizado para este tipo de transacción</messages>
    </ResponseHeader>
</soap:Header>
<soap:Body>
    <consultaRemesasResponse xmlns="http://www.ficohsa.com.hn/middleware.services/consultaRemesasCBTypes"/>
</soap:Body>
```

## Requests/Responses Internos a Servicios Dependientes

### 1. Validación de Corresponsal (consultarCorresponsalB)

**Request:**
```xml
<InputParameters xmlns="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarCorresponsalB">
    <PV_TIPO_TRANSACCION>9</PV_TIPO_TRANSACCION>
    <PV_ID_CORRESPONSAL_BANCARIO>CORRESP001</PV_ID_CORRESPONSAL_BANCARIO>
    <PV_BANCO_ORIGEN>HN01</PV_BANCO_ORIGEN>
</InputParameters>
```

**Response:**
```xml
<OutputParameters xmlns="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarCorresponsalB">
    <PV_CODIGO_MENSAJE>SUCCESS</PV_CODIGO_MENSAJE>
    <PV_MENSAJE_ERROR></PV_MENSAJE_ERROR>
</OutputParameters>
```

### 2. Descifrado de Credenciales (OperacionesCriptograficas)

**Request:**
```xml
<descifrarDatos xmlns="http://www.ficohsa.com.hn/middleware.services/operacionesCriptograficasTypes">
    <ENCRYPTED_DATA>encrypted_username_base64</ENCRYPTED_DATA>
    <KEY_ALIAS>ONE-TIME-PASSWORD</KEY_ALIAS>
    <CIPHER>RSA</CIPHER>
</descifrarDatos>
```

**Response:**
```xml
<descifrarDatosResponse xmlns="http://www.ficohsa.com.hn/middleware.services/operacionesCriptograficasTypes">
    <DECRYPTED_DATA>actual_username</DECRYPTED_DATA>
</descifrarDatosResponse>
```

### 3. Obtener Tipo de Remesadora (MW_P_OBTENER_TIPO_REMESADORA)

**Request:**
```xml
<InputParameters xmlns="http://xmlns.oracle.com/pcbpel/adapter/db/sp/ObtenerTipoRemesadora">
    <PV_CLAVE>REM123456789</PV_CLAVE>
    <PV_USUARIO_SERVICIO>CBUSER01</PV_USUARIO_SERVICIO>
</InputParameters>
```

**Response:**
```xml
<OutputParameters xmlns="http://xmlns.oracle.com/pcbpel/adapter/db/sp/ObtenerTipoRemesadora">
    <PT_TIPOS_REMESADORAS>
        <PT_TIPOS_REMESADORAS_ITEM>
            <PV_NOMBRE_REMESADORA>MONEYGRAM</PV_NOMBRE_REMESADORA>
            <PV_TIPO_REMESADORA>ONLINE</PV_TIPO_REMESADORA>
            <PN_ID_CONVENIO>12345</PN_ID_CONVENIO>
            <PV_ID_CONVENIO_T24>MGR001</PV_ID_CONVENIO_T24>
            <PV_ABREVIATURA_REMESADORA>MGR</PV_ABREVIATURA_REMESADORA>
            <PN_PRIORIDAD>1</PN_PRIORIDAD>
        </PT_TIPOS_REMESADORAS_ITEM>
    </PT_TIPOS_REMESADORAS>
    <PV_SUCCESS_INDICATOR>SUCCESS</PV_SUCCESS_INDICATOR>
    <PV_MESSAGES></PV_MESSAGES>
</OutputParameters>
```

### 4. Consulta Remesa Local (consultarRemLocalId)

**Request:**
```xml
<InputParameters xmlns="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarRemLocalId">
    <PV_REMESA>REM123456789</PV_REMESA>
</InputParameters>
```

**Response:**
```xml
<OutputParameters xmlns="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarRemLocalId">
    <PV_CLAVE>
        <PV_CLAVE_ITEM>REM123456789</PV_CLAVE_ITEM>
    </PV_CLAVE>
    <PV_CODREMESADORA>
        <PV_CLAVE_ITEM>FICOHSA</PV_CLAVE_ITEM>
    </PV_CODREMESADORA>
    <PV_BENEFICIARIO>
        <PV_CLAVE_ITEM>MARIA ELENA RODRIGUEZ GARCIA</PV_CLAVE_ITEM>
    </PV_BENEFICIARIO>
    <PV_REMITENTE>
        <PV_CLAVE_ITEM>JUAN CARLOS PEREZ LOPEZ</PV_CLAVE_ITEM>
    </PV_REMITENTE>
    <PV_AGENCIA_PAGO>
        <PV_CLAVE_ITEM>SUCURSAL CENTRO</PV_CLAVE_ITEM>
    </PV_AGENCIA_PAGO>
    <PV_FECHA_PAGO>
        <PV_CLAVE_ITEM></PV_CLAVE_ITEM>
    </PV_FECHA_PAGO>
    <PV_ESTADO>
        <PV_CLAVE_ITEM>DISPONIBLE</PV_CLAVE_ITEM>
    </PV_ESTADO>
    <PN_TASACAMBIO>
        <PN_TASACAMBIO_ITEM>24.85</PN_TASACAMBIO_ITEM>
    </PN_TASACAMBIO>
    <PN_VALOR>
        <PN_TASACAMBIO_ITEM>2500.00</PN_TASACAMBIO_ITEM>
    </PN_VALOR>
    <PV_MONEDA>
        <PV_CLAVE_ITEM>HNL</PV_CLAVE_ITEM>
    </PV_MONEDA>
    <PV_ERROR></PV_ERROR>
</OutputParameters>
```

### 5. Enrutador de Convenios (HTTP)

**Request:**
```xml
<serviceRequest>
    <primaryKey>REM123456789</primaryKey>
    <operationCode>1</operationCode>
    <totalAmount>0</totalAmount>
    <coreRunningDate>20241201120000</coreRunningDate>
    <transactionID>20241201120000</transactionID>
    <moreParameters>
        <data fieldName="CODIGOCONTRATO">MGR001</data>
        <data fieldName="CLAVEREMESA">REM123456789</data>
        <data fieldName="REMITENTE">JUAN CARLOS PEREZ LOPEZ</data>
        <data fieldName="BENEFICIARIO">MARIA ELENA RODRIGUEZ GARCIA</data>
        <data fieldName="MONEDA">HNL</data>
        <data fieldName="TASACAMBIO">24.85</data>
    </moreParameters>
</serviceRequest>
```

**Response:**
```xml
<serviceResponse>
    <primaryKey>REM123456789</primaryKey>
    <operationCode>1</operationCode>
    <totalAmount>2500.00</totalAmount>
    <coreRunningDate>20241201120000</coreRunningDate>
    <transactionID>20241201120000</transactionID>
    <errorCode>0</errorCode>
    <errorMessage></errorMessage>
    <responseData>
        <moreParameters>
            <data fieldName="CODIGOCONTRATO">MGR001</data>
            <data fieldName="REMITENTE">JUAN CARLOS PEREZ LOPEZ</data>
            <data fieldName="BENEFICIARIO">MARIA ELENA RODRIGUEZ GARCIA</data>
            <data fieldName="MONEDA">HNL</data>
            <data fieldName="TASACAMBIO">24.85</data>
            <data fieldName="MONTOLOCAL">100.00</data>
            <data fieldName="PAISORIGEN">USA</data>
        </moreParameters>
    </responseData>
</serviceResponse>
```

### 6. Registro de Límite Transaccional

**Request:**
```xml
<InputParameters xmlns="http://xmlns.oracle.com/pcbpel/adapter/db/sp/limiteTrxRegistrar">
    <PV_ID_CLIENTE>CLI123456</PV_ID_CLIENTE>
    <PV_MONTO_FLOTANTE>2500.00</PV_MONTO_FLOTANTE>
    <PV_TASA_CAMBIO>24.85</PV_TASA_CAMBIO>
</InputParameters>
```

## Cadenas de Conexión y Credenciales

### Base de Datos - Middleware
- **Conexión**: `jca://eis/DB/ConnectionMiddleware`
- **Esquema**: `ORA_BANK`
- **Timeout**: Default (30s retry interval)
- **Retry**: 0 reintentos

### Base de Datos - Convenios
- **Conexión**: `jca://eis/DB/ConnectionConvenios`
- **Esquemas**: `TERCEROS`, `FLINK`
- **Timeout**: 60 segundos (armarMensajeRecaudo)
- **Retry**: 1 reintento con 30s de intervalo

### Servicio HTTP - Enrutador de Convenios
- **Endpoint**: `http://192.9.200.176:8003/Middleware/OperationsAndExecution/BillingServices/EnrutadorConvenios`
- **Método**: POST
- **Timeout**: Ilimitado (0)
- **Retry**: 0 reintentos
- **Cache**: Habilitado (TTL: 30 minutos)

### Servicio SOAP - T24 Resiliencia
- **Binding**: T24WebServicesImplPortBinding
- **Namespace**: T24WebServicesImpl
- **Timeout**: Ilimitado (0)
- **Retry**: 0 reintentos

## Tablas de Mapeo de Entrada

### Mapeo OSB → consultarCorresponsalB
| Campo Origen (OSB) | Transformación/Script | Campo Destino (SP) |
|-------------------|----------------------|-------------------|
| header/RequestHeader/BankingCorrespondent/Id | fn:string() | PV_ID_CORRESPONSAL_BANCARIO |
| header/RequestHeader/Region/SourceBank | fn:string() | PV_BANCO_ORIGEN |
| Constante "9" | Literal | PV_TIPO_TRANSACCION |

### Mapeo OSB → ObtenerTipoRemesadora
| Campo Origen (OSB) | Transformación/Script | Campo Destino (SP) |
|-------------------|----------------------|-------------------|
| body/consultaRemesas/REMITTANCE_ID | fn:string() | PV_CLAVE |
| header/RequestHeader/Authentication/UserName | fn:string() | PV_USUARIO_SERVICIO |

### Mapeo OSB → OperacionesCriptograficas
| Campo Origen (OSB) | Transformación/Script | Campo Destino (Servicio) |
|-------------------|----------------------|-------------------------|
| ADDITIONAL_INFO/INFO[NAME='LOGINUSER']/VALUE | fn:string() | ENCRYPTED_DATA |
| ADDITIONAL_INFO/INFO[NAME='LOGINPASS']/VALUE | fn:string() | ENCRYPTED_DATA |
| Constante "ONE-TIME-PASSWORD" | Literal | KEY_ALIAS |
| Constante "RSA" | Literal | CIPHER |

### Mapeo OSB → consultaRemLocalId
| Campo Origen (OSB) | Transformación/Script | Campo Destino (SP) |
|-------------------|----------------------|-------------------|
| body/consultaRemesas/REMITTANCE_ID | fn:string() | PV_REMESA |

### Mapeo OSB → consultaRemFRemXPagador
| Campo Origen (OSB) | Transformación/Script | Campo Destino (SP) |
|-------------------|----------------------|-------------------|
| body/consultaRemesas/REMITTANCE_ID | fn:string() | PV_REMESA |
| $idPayer (parámetro IDPAYERGUSER) | fn:string() | PV_PAGADOR_DEST |

### Mapeo OSB → T24 (sjConsultaRemesaResiliencia)
| Campo Origen (OSB) | Transformación/Script | Campo Destino (T24) |
|-------------------|----------------------|--------------------|
| requestHeader/Authentication/UserName | getUsername() con fallback | WebRequestCommon/userName |
| requestHeader/Authentication/Password | getPassword() con fallback | WebRequestCommon/password |
| consultaRemesas/REMITTANCE_ID | fn:string() | enquiryInputCollection/criteriaValue |
| Constante "REMITTANCE.KEY" | Literal | enquiryInputCollection/columnName |
| Constante "EQ" | Literal | enquiryInputCollection/operand |

### Mapeo OSB → armarMensajeRecaudo
| Campo Origen (OSB) | Transformación/Script | Campo Destino (SP) |
|-------------------|----------------------|-------------------|
| TYPES_REMITTANCE_ITEM/AGREEMENT_ID_T24 | data() | CODIGO_CONTRATO |
| Constante "1" | Literal | TIPO_OPERACION |
| Constante "REQ" | Literal | TIPO_PARAM |
| Constante "ENQ" | Literal | APLICACION |
| CORRESPONSAL_BRANCHCODE | data() | INFO/DATA[NAME='corresponsalBranchCode']/VALUE |
| REMITTANCE_ID | data() | INFO/DATA[NAME='primaryKey']/VALUE |
| USERNAME | data() | INFO/DATA[NAME='UserName']/VALUE |
| AGREEMENT_ID_T24 | data() | INFO/DATA[NAME='CONTRAC_ID']/VALUE |
| fn:current-dateTime() | fn-bea:dateTime-to-string-with-format("yyyyMMddHHmmss") | INFO/DATA[NAME='coreRunningDate']/VALUE |
| fn:current-dateTime() | fn-bea:dateTime-to-string-with-format("yyyyMMddHHmmss") | INFO/DATA[NAME='transactionID']/VALUE |
| BENEFICIARY_FIRSTNAME | data() | INFO/DATA[NAME='beneficiaryFirstName']/VALUE |
| BENEFICIARY_MIDDLENAME | data() | INFO/DATA[NAME='beneficiaryMiddleName']/VALUE |
| BENEFICIARY_FIRSTSURNAME | data() | INFO/DATA[NAME='beneficiaryFirstSurname']/VALUE |
| BENEFICIARY_SECONDSURNAME | data() | INFO/DATA[NAME='beneficiarySecondSurname']/VALUE |
| ADDITIONAL_INFO/INFO | Loop: data(NAME) → NAME, data(VALUE) → VALUE | INFO/DATA[NAME='{NAME}']/VALUE |

## Tablas de Mapeo de Salida

### Mapeo consultarRemLocalId → OSB Response
| Campo Origen (SP) | Transformación/Script | Campo Destino (OSB) |
|------------------|----------------------|-------------------|
| PV_CLAVE/PV_CLAVE_ITEM[1] | data() | REMITTANCE_ID |
| PV_CODREMESADORA/PV_CLAVE_ITEM[1] | data() | REMITTER_ID |
| PV_REMITENTE/PV_CLAVE_ITEM[1] | data() | REMITTER_NAME |
| PV_BENEFICIARIO/PV_CLAVE_ITEM[1] | data() | BENEFICIARY_NAME |
| PV_AGENCIA_PAGO/PV_CLAVE_ITEM[1] | data() | BRANCH_NAME |
| PV_FECHA_PAGO/PV_CLAVE_ITEM[1] | data() | PAYMENT_DATE |
| PV_MONEDA/PV_CLAVE_ITEM[1] | data() | CURRENCY |
| PN_TASACAMBIO/PN_TASACAMBIO_ITEM[1] | data() | EXCHANGE_RATE |
| PV_ESTADO/PV_CLAVE_ITEM[1] | data() | REMITTANCE_STATUS |
| PN_VALOR/PN_TASACAMBIO_ITEM[1] | data() | REMITTANCE_AMOUNT |
| Constante vacía | "" | REMITTANCE_SOURCE_AMOUNT |

### Mapeo consultarRemFRemXPagador → OSB Response
| Campo Origen (SP) | Transformación/Script | Campo Destino (OSB) |
|------------------|----------------------|-------------------|
| PV_CLAVE/PV_CLAVE_ITEM[1] | data() | REMITTANCE_ID |
| PV_CODREMESADORA/PV_CLAVE_ITEM[1] | data() | REMITTER_ID |
| PV_REMITENTE/PV_CLAVE_ITEM[1] | data() | REMITTER_NAME |
| PV_BENEFICIARIO/PV_CLAVE_ITEM[1] | data() | BENEFICIARY_NAME |
| PV_AGENCIA_PAGO/PV_CLAVE_ITEM[1] | data() | BRANCH_NAME |
| PV_FECHA_PAGO/PV_CLAVE_ITEM[1] | data() | PAYMENT_DATE |
| PV_MONEDA/PV_CLAVE_ITEM[1] | data() | CURRENCY |
| PN_TASACAMBIO/PN_TASACAMBIO_ITEM[1] | data() | EXCHANGE_RATE |
| PV_ESTADO/PV_CLAVE_ITEM[1] | data() | REMITTANCE_STATUS |
| PN_VALOR/PN_TASACAMBIO_ITEM[1] | data() | REMITTANCE_AMOUNT |
| Constante vacía | "" | REMITTANCE_SOURCE_AMOUNT |

### Mapeo T24 → OSB Response
| Campo Origen (T24) | Transformación/Script | Campo Destino (OSB) |
|-------------------|----------------------|-------------------|
| REMITTANCEKEY | data() | REMITTANCE_ID |
| STATUS | data() | REMITTANCE_STATUS |
| Constante vacía | "" | REMITTANCE_SOURCE_AMOUNT |
| Otros campos | No mapeados | Campos vacíos |

### Mapeo EnrutadorConvenios → OSB Response
| Campo Origen (Servicio) | Transformación/Script | Campo Destino (OSB) |
|------------------------|----------------------|-------------------|
| primaryKey | data() | REMITTANCE_ID |
| moreParameters/data[@fieldName=$codigoContrato] | data() | REMITTER_ID |
| moreParameters/data[@fieldName=$remitente] | data() | REMITTER_NAME |
| moreParameters/data[@fieldName=$beneficiario] | data() | BENEFICIARY_NAME |
| Vacío | "" | BRANCH_NAME |
| moreParameters/data[@fieldName=$fechaRemesa] | data() si errorCode=2, vacío si errorCode=0 | PAYMENT_DATE |
| moreParameters/data[@fieldName=$moneda] | data() | CURRENCY |
| moreParameters/data[@fieldName=$tasaCambio] | data() | EXCHANGE_RATE |
| errorCode | if errorCode=0 then "DISPONIBLE" else if errorCode=2 then "PAGADA" else errorMessage | REMITTANCE_STATUS |
| totalAmount | data() | REMITTANCE_AMOUNT |
| moreParameters/data[@fieldName=$montoLocal] | data() | REMITTANCE_SOURCE_AMOUNT |
| moreParameters/data[@fieldName=$paisOrigen] | data() | ORIGIN_COUNTRY |

### Mapeo OSB Response → limiteTrxRegistrar
| Campo Origen (OSB Response) | Transformación/Script | Campo Destino (SP) |
|----------------------------|----------------------|-------------------|
| $IdClientelim (de ADDITIONAL_INFO) | fn:string() | PV_ID_CLIENTE |
| consultaRemesasResponseRecordType[1]/REMITTANCE_AMOUNT | data() | PV_MONTO_FLOTANTE |
| consultaRemesasResponseRecordType[1]/EXCHANGE_RATE | data() | PV_TASA_CAMBIO |

## Reglas de Negocio Detectadas

### 1. Validación de Tipo de Consulta
**Ubicación**: `Middleware/v2/Resources/ConsultaRemesas/xq/validarTipoConsulta.xq`
**Regla**: Solo permite consulta por ID (ID_BASED)
```xquery
if ( fn:string($consultaRemesas1/REMITTANCE_ID/text()) != "" ) then (
    "ID_BASED"
) else (
    ""
)
```

### 2. Selección de Remesadora por Prioridad
**Ubicación**: `Middleware/v2/Resources/ConsultaRemesas/xq/sjconsultaMultipleRemesadorasIn.xq`
**Regla**: Si hay múltiples remesadoras, selecciona la de menor prioridad
```xquery
if (xs:integer($contadorRemesas) = 1) then (
    $RSPconsultaRemesadoras/cons:REMITTANCE/cons:ROUTER_RESPONSE
) else(
    let $prioridad := min($RSPconsultaRemesadoras/cons:REMITTANCE/cons:ROUTER_RESPONSE/cons:PRIORITY) return
    $RSPconsultaRemesadoras/cons:REMITTANCE/cons:ROUTER_RESPONSE[cons:PRIORITY= $prioridad]
)
```

### 3. Validación de Permisos por Usuario
**Ubicación**: `Middleware/v2/ProxyServices/ConsultaRemesas.proxy` (ID_request pipeline)
**Regla**: Valida que el usuario tenga permiso para consultar el tipo de remesadora
```xquery
let $allowsUserList := fn:tokenize(fn:string($remittanceAllowed),"\\|\\|")
return empty(fn:index-of($allowsUserList,$remittSource))
```

### 4. Determinación de Fuente de Remesa Local
**Ubicación**: `Middleware/Business_Resources/remesas/ConsultaRemesas/validarOrigenRemesaLocal.xq`
**Regla**: Determina si consultar en T24 o FLink basado en parámetro REMITSOURCE
```xquery
if ($localRemitSource = "T24") then (
    // Consulta en T24
) else (
    // Consulta en FLink
)
```

### 5. Evaluación de Listas Restrictivas
**Ubicación**: `Middleware/v2/ProxyServices/ConsultaRemesas.proxy` (ID_response pipeline)
**Regla**: Solo evalúa listas si está configurado y es remesadora ONLINE disponible
```xquery
if ($checkListsEvaluarLista = 'Yes' and fn:matches($checkRemitterIdEvaluarLista,$remittSource) and $successIndOnline = "0") then (
    // Evaluar listas
)
```

### 6. Registro de Relación Consulta-Pago
**Ubicación**: Múltiples pipelines en ConsultaRemesas.proxy
**Regla**: Solo registra relación si el estado es DISPONIBLE
```xquery
if ($estado='DISPONIBLE') then (
    // Registrar relación
)
```

### 7. Mapeo de Estados de Remesa
**Ubicación**: `Middleware/v2/Resources/ConsultaRemesas/xq/EnrutadorConveniosOut.xq`
**Regla**: Mapea códigos de error a estados de negocio
```xquery
if (data($parametersOut/errorCode/text()) = 0) then (
    <REMITTANCE_STATUS>DISPONIBLE</REMITTANCE_STATUS>
) else if (data($parametersOut/errorCode/text()) = 2) then (
    <REMITTANCE_STATUS>PAGADA</REMITTANCE_STATUS>
) else (
    <REMITTANCE_STATUS>{ data($parametersOut/errorMessage/text()) }</REMITTANCE_STATUS>
)
```

### 8. Descifrado Condicional de Credenciales
**Ubicación**: `Middleware/v2/ProxyServices/ConsultaRemesaCB.proxy` (OperacionesCriptograficas stage)
**Regla**: Solo descifra si existen campos LOGINUSER y LOGINPASS no vacíos
```xquery
if ($name="LOGINUSER" or $name ="LOGINPASS" and $value!= "") then (
    // Descifrar usando RSA
)
```

### 9. Registro de Límite Transaccional
**Ubicación**: `Middleware/v2/ProxyServices/ConsultaRemesaCB.proxy` (Registrar Limite Remesa stage)
**Regla**: Solo registra límite si la consulta fue exitosa
```xquery
if (fn:upper-case($respuesta) = "SUCCESS") then (
    // Registrar límite con ID cliente, monto y tasa de cambio
)
```

### 10. Validación de Remesadora No Válida
**Ubicación**: `Middleware/v2/ProxyServices/ConsultaRemesas.proxy` (ID_request pipeline)
**Regla**: Valida que la abreviatura de remesadora no sea 'NA'
```xquery
if ($remittSource='NA') then (
    // Error: Codigo de remesa no valido
)
```

### 11. Identificación de Tipo de Remesa Local
**Ubicación**: `Middleware/Business_Resources/remesas/ConsultaRemesas/validarTipoRemesaLocal.xq`
**Regla**: Identifica el tipo de remesa local basado en prefijos de la clave
```xquery
if ( fn:substring($ClaveRemesa,1,2) = "LX") then (
    "DOLEX"
) else if ( fn:substring($ClaveRemesa,1,2) = "RF") then (
    "RIA"
) else if ( fn:substring($ClaveRemesa,1,3) = ("FCX","FTL","FOR","FNJ","TAM","CHA","BRX","HEM","HST","PLF","GNA","NBW","NWO","FNW")) then (
    "FICOEXP"
) else if ( fn:substring($ClaveRemesa,1,3) = "GPX") then (
    "GROUPEX"
) else if ( fn:substring($ClaveRemesa,1,2) = ("RT","US") or fn:substring($ClaveRemesa,1,3) = ("GMT","IDT")) then (
    "REMTRAS"
) else if ( fn:substring($ClaveRemesa,1,2) = "TF") then (
    "TRANSFAST"
) else if ( fn:substring($ClaveRemesa,1,3) = "SIG") then (
    "SIGUE"
) else if ( fn:substring($ClaveRemesa,1,2) = "GS") then (
    "GIROSOL"
) else (
    "REMESA NO IDENTIFICADA"
)
```

### 12. Obtención de Credenciales LDAP
**Ubicación**: `Middleware/v2/Resources/ConsultaRemesas/xq/consultaRemesaT24In.xq`
**Regla**: Obtiene credenciales LDAP con fallback a credenciales del header
```xquery
declare function getUsername ($LDAPUsername as xs:string) as xs:string { 
    let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
    return $data/con:username/text()
};

declare function getPassword ($LDAPUsername as xs:string) as xs:string {      
    let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
    return $data/con:password/text()
};

// Uso con failover
<userName>{ fn-bea:fail-over( getUsername(data($requestHeader1/Authentication/UserName)), 
                              data($requestHeader1/Authentication/UserName)) }</userName>
<password>{ fn-bea:fail-over( getPassword(data($requestHeader1/Authentication/UserName)),
                              data($requestHeader1/Authentication/Password)) }</password>
```

### 13. Generación de Timestamps
**Ubicación**: `Middleware/v2/BusinessServices/SJS/consultaMultipleRemesadoras/xq/armarInfoParametrosRemesas.xq`
**Regla**: Genera timestamps únicos para transactionID y coreRunningDate
```xquery
let $currentDateTime := fn:adjust-dateTime-to-timezone(fn:current-dateTime())
let $strDateTime := fn-bea:dateTime-to-string-with-format("yyyyMMddHHmmss",$currentDateTime)
return <ns1:VALUE>{ $strDateTime }</ns1:VALUE>
```