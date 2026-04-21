# Ejemplos de Request/Response y Mapeo de Datos - GT01 (Guatemala)

## Request OSB (ejemplo SOAP/XML)

```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/" 
               xmlns:rev="http://www.ficohsa.com.hn/middleware.services/reversarTransaccionIDPS/"
               xmlns:rti="http://www.ficohsa.com.hn/middleware.services/reversarTransaccionIDTypes"
               xmlns:auth="http://www.ficohsa.com.hn/middleware.services/autType">
  <soap:Header>
    <auth:RequestHeader>
      <Authentication>
        <UserName>USUARIO_GT01</UserName>
        <Password>PASSWORD_ENCRYPTED</Password>
      </Authentication>
      <Region>GT01</Region>
      <Channel>OMNICANAL</Channel>
      <messageId>MSG-GT01-20241201-001</messageId>
    </auth:RequestHeader>
  </soap:Header>
  <soap:Body>
    <rti:reversarTransaccionID>
      <TRANSACTION_TYPE>DEPOSITO</TRANSACTION_TYPE>
      <TRANSACTION_ID>550e8400-e29b-41d4-a716-446655440001</TRANSACTION_ID>
    </rti:reversarTransaccionID>
  </soap:Body>
</soap:Envelope>
```

## Response OSB (ejemplo SOAP/XML)

```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/" 
               xmlns:rti="http://www.ficohsa.com.hn/middleware.services/reversarTransaccionIDTypes"
               xmlns:auth="http://www.ficohsa.com.hn/middleware.services/autType">
  <soap:Header>
    <auth:ResponseHeader>
      <successIndicator>SUCCESS</successIndicator>
      <messageId>MSG-GT01-20241201-001</messageId>
    </auth:ResponseHeader>
  </soap:Header>
  <soap:Body>
    <rti:reversarTransaccionIDResponse>
      <T24_REFERENCE>FT24001GT123456</T24_REFERENCE>
      <TRANSACTION_ID>550e8400-e29b-41d4-a716-446655440001</TRANSACTION_ID>
      <REFERENCE_CB>CBGT20241201001</REFERENCE_CB>
    </rti:reversarTransaccionIDResponse>
  </soap:Body>
</soap:Envelope>
```

## Requests/Responses Internos a Servicios Dependientes

### 1. Consulta Ruta Regional

#### Request a consultaRutaRegional_db
```xml
<ns0:InputParameters xmlns:ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaRutaRegional">
  <ns0:PV_ID_SERVICIO>FICBCO0516</ns0:PV_ID_SERVICIO>
  <ns0:PV_REGION>GT01</ns0:PV_REGION>
  <ns0:PV_OPERACION>reversarTransaccionID</ns0:PV_OPERACION>
  <ns0:PV_VERSION>V2</ns0:PV_VERSION>
</ns0:InputParameters>
```

#### Response de consultaRutaRegional_db
```xml
<ns0:OutputParameters xmlns:ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaRutaRegional">
  <ns0:PV_CODIGO_ERROR>SUCCESS</ns0:PV_CODIGO_ERROR>
  <ns0:PV_MENSAJE_ERROR></ns0:PV_MENSAJE_ERROR>
  <ns0:PV_RUTA_REGIONAL>GT01_ROUTE</ns0:PV_RUTA_REGIONAL>
</ns0:OutputParameters>
```

### 2. Obtener Tipo de Transacción

#### Request a obtenerTipoTrxGen_db
```xml
<ns0:InputParameters xmlns:ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/obtenerTipoTrxGen">
  <ns0:PV_COD_OSB>DEPOSITO</ns0:PV_COD_OSB>
</ns0:InputParameters>
```

#### Response de obtenerTipoTrxGen_db
```xml
<ns0:OutputParameters xmlns:ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/obtenerTipoTrxGen">
  <ns0:PV_ERROR_CODE>SUCCESS</ns0:PV_ERROR_CODE>
  <ns0:PV_MESSAGE>NOGEN</ns0:PV_MESSAGE>
  <ns0:PV_TIPO_OPE>REVERSA_DEPOSITO</ns0:PV_TIPO_OPE>
</ns0:OutputParameters>
```

### 3. Validar Estado de Transacción

#### Request a validarEstadoTransaccion_db
```xml
<ns0:InputParameters xmlns:ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/validarEstadoTransaccion">
  <ns0:PV_UUID>550e8400-e29b-41d4-a716-446655440001</ns0:PV_UUID>
  <ns0:PN_TIPO_CONSULTA>1</ns0:PN_TIPO_CONSULTA>
  <ns0:PN_CODIGO_ESTADO>0</ns0:PN_CODIGO_ESTADO>
</ns0:InputParameters>
```

#### Response de validarEstadoTransaccion_db
```xml
<ns0:OutputParameters xmlns:ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/validarEstadoTransaccion">
  <ns0:PV_ERRORCODE>SUCCESS</ns0:PV_ERRORCODE>
  <ns0:PV_ERRORMESSAGE></ns0:PV_ERRORMESSAGE>
  <ns0:PV_FT>FT24001GT123456</ns0:PV_FT>
  <ns0:PV_MESSAGE>TRUE</ns0:PV_MESSAGE>
  <ns0:Pv_uuido>550e8400-e29b-41d4-a716-446655440001</ns0:Pv_uuido>
  <ns0:Pv_refcb>CBGT20241201001</ns0:Pv_refcb>
</ns0:OutputParameters>
```

### 4. Reversión de Depósito en T24

#### Request a svcReversarTransaccionCB (ReversionDepositoTengo)
```xml
<ReversionDepositoTengoRequest>
  <User>USUARIO_GT01</User>
  <FT>FT24001GT123456</FT>
  <Region>GT01</Region>
</ReversionDepositoTengoRequest>
```

#### Response de svcReversarTransaccionCB
```xml
<ReversionDepositoTengoResponse>
  <Status>
    <successIndicator>SUCCESS</successIndicator>
    <messages>Reversión de depósito procesada exitosamente</messages>
    <transactionId>REV24001GT123456</transactionId>
  </Status>
</ReversionDepositoTengoResponse>
```

### 5. Actualizar Estado de Transacción

#### Request a actualizarEstadoTransaccionUUID_db
```xml
<ns0:InputParameters xmlns:ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/actualizarEstadoTransaccionUUID">
  <ns0:PV_ESTADO>R</ns0:PV_ESTADO>
  <ns0:PV_UUID>550e8400-e29b-41d4-a716-446655440001</ns0:PV_UUID>
</ns0:InputParameters>
```

#### Response de actualizarEstadoTransaccionUUID_db
```xml
<ns0:OutputParameters xmlns:ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/actualizarEstadoTransaccionUUID">
  <ns0:PV_ERRORCODE>SUCCESS</ns0:PV_ERRORCODE>
  <ns0:PV_ERRORMESSAGE></ns0:PV_ERRORMESSAGE>
</ns0:OutputParameters>
```

## Cadenas de Conexión y Credenciales

### Base de Datos MDW
- **Nombre de Base de Datos**: MIDDLEWARE_GT
- **Esquema**: MW_SCHEMA
- **Conexión JCA**: `jca://eis/DB/ConnectionMiddleware`
- **Pool de Conexiones**: ConnectionMiddleware
- **Stored Procedures**:
  - `MW_P_CONSULTA_RUTA_REGIONAL`
  - `MW_P_OBTENER_TIPO_TRX_GEN`
  - `MW_P_VALIDAR_ESTADO_TRANSACCION`
  - `MW_P_ACTUALIZAR_ESTADO_TRANSACCION_UUID`

### Servicio T24
- **Endpoint WSDL**: `http://t24-gt01.ficohsa.com:8080/T24Services/ReversarTransaccionCB?wsdl`
- **Operación**: `ReversionDepositoTengo`
- **Timeout**: 30 segundos
- **Retry**: 0 intentos

## Tablas de Mapeo de Entrada

### Mapeo OSB → consultaRutaRegional_db

| Campo Origen (OSB) | Transformación/Script | Campo Destino (servicio interno) |
|-------------------|----------------------|----------------------------------|
| Constante 'FICBCO0516' | Valor fijo | PV_ID_SERVICIO |
| $header/aut:RequestHeader/Region | XPath extraction | PV_REGION |
| $operation | Variable OSB | PV_OPERACION |
| Constante 'V2' | Valor fijo | PV_VERSION |

### Mapeo OSB → obtenerTipoTrxGen_db

| Campo Origen (OSB) | Transformación/Script | Campo Destino (servicio interno) |
|-------------------|----------------------|----------------------------------|
| $body/rev:reversarTransaccionID/TRANSACTION_TYPE | XPath extraction | PV_COD_OSB |

### Mapeo OSB → validarEstadoTransaccion_db

| Campo Origen (OSB) | Transformación/Script | Campo Destino (servicio interno) |
|-------------------|----------------------|----------------------------------|
| $body/rev:reversarTransaccionID/TRANSACTION_ID | XPath extraction | PV_UUID |
| $tipoConsulta | Variable calculada: if ($tipoTRX = 'NOGEN') then 1 else 4 | PN_TIPO_CONSULTA |
| Constante 0 | Valor fijo | PN_CODIGO_ESTADO |

### Mapeo OSB → svcReversarTransaccionCB (ReversionDepositoTengo)

| Campo Origen (OSB) | Transformación/Script | Campo Destino (servicio interno) |
|-------------------|----------------------|----------------------------------|
| $header/aut:RequestHeader/Authentication/UserName | XPath extraction | User |
| $refT24 | Variable de respuesta anterior | FT |

### Mapeo OSB → actualizarEstadoTransaccionUUID_db

| Campo Origen (OSB) | Transformación/Script | Campo Destino (servicio interno) |
|-------------------|----------------------|----------------------------------|
| Constante 'R' | Valor fijo (Reversada) | PV_ESTADO |
| $uuiddb | Variable de respuesta anterior | PV_UUID |

## Tablas de Mapeo de Salida

### Mapeo consultaRutaRegional_db → OSB

| Campo Origen (servicio interno) | Transformación/Script | Campo Destino (OSB) |
|--------------------------------|----------------------|---------------------|
| PV_CODIGO_ERROR | XPath extraction | $successIndicator |
| PV_MENSAJE_ERROR | XPath extraction | $errorMessage |

### Mapeo obtenerTipoTrxGen_db → OSB

| Campo Origen (servicio interno) | Transformación/Script | Campo Destino (OSB) |
|--------------------------------|----------------------|---------------------|
| PV_ERROR_CODE | XPath extraction | $successIndicator |
| PV_MESSAGE | XPath extraction | $tipoTRX |
| PV_TIPO_OPE | XPath extraction | $operacion |

### Mapeo validarEstadoTransaccion_db → OSB

| Campo Origen (servicio interno) | Transformación/Script | Campo Destino (OSB) |
|--------------------------------|----------------------|---------------------|
| PV_ERRORCODE | XPath extraction | $successIndicator |
| PV_ERRORMESSAGE | XPath extraction | $ErrorCode |
| PV_FT | XPath extraction | $refT24 |
| PV_MESSAGE | XPath extraction | $dbmesage |
| Pv_uuido | XPath extraction | $uuiddb |
| Pv_refcb | XPath extraction | $refcb |

### Mapeo svcReversarTransaccionCB → OSB

| Campo Origen (servicio interno) | Transformación/Script | Campo Destino (OSB) |
|--------------------------------|----------------------|---------------------|
| Status/successIndicator | fn:upper-case() | $successIndicator |
| Status/messages | XPath extraction | $errorCode |
| Status/transactionId | XPath extraction | $statusT24 |

### Mapeo actualizarEstadoTransaccionUUID_db → OSB

| Campo Origen (servicio interno) | Transformación/Script | Campo Destino (OSB) |
|--------------------------------|----------------------|---------------------|
| PV_ERRORCODE | XPath extraction | $successIndicator |
| PV_ERRORMESSAGE | XPath extraction | $ErrorCode |

### Mapeo Final OSB Response

| Campo Origen (OSB) | Transformación/Script | Campo Destino (OSB Response) |
|-------------------|----------------------|------------------------------|
| $statusT24 | fn:upper-case() | T24_REFERENCE |
| $uuiddb | fn:upper-case() | TRANSACTION_ID |
| $refcb | fn:upper-case() | REFERENCE_CB |

## Reglas de Negocio Detectadas

### 1. Validación de Tipo de Transacción
- **Ubicación**: Stage "ValidarTransaccionDB"
- **Regla**: Si el tipo de transacción es 'NOGEN', se usa tipo de consulta 1, sino tipo 4
- **Código**: `if (fn:string($tipoTRX) = 'NOGEN') then (1) else (4)`
- **Archivo**: ReversarTransaccionID.proxy líneas de transformación

### 2. Validación de Estado de Transacción
- **Ubicación**: Stage "ReversarTransaccion"
- **Regla**: Solo se puede reversar si $dbmesage = 'TRUE'
- **Código**: `$dbmesage = 'TRUE'`
- **Archivo**: ReversarTransaccionID.proxy condición de validación

### 3. Procesamiento por Tipo de Transacción - Guatemala
- **Ubicación**: Stage "ReversarTransaccion"
- **Regla**: Para transacciones tipo DEPOSITO en Guatemala:
  - Se usa la operación ReversionDepositoTengo del servicio svcReversarTransaccionCB
  - Se mapea el campo FT en lugar de TFS
  - Se procesa como transacción de depósito estándar
- **Archivo**: ReversarTransaccionID.proxy estructura condicional default

### 4. Actualización de Estado - Guatemala
- **Ubicación**: Stage "ActualizarEstadoTransaccion"
- **Regla**: Para Guatemala, las transacciones DEPOSITO usan:
  - actualizarEstadoTransaccionUUID_db (ya que $tipoTRX != 'GEN')
  - Estado se actualiza a 'R' (Reversada)
- **Archivo**: ReversarTransaccionID.proxy lógica de actualización

### 5. Configuración Regional Guatemala
- **Ubicación**: Stage "ConsultaRutaRegional"
- **Regla**: La configuración regional GT01 determina:
  - Rutas específicas para servicios T24
  - Parámetros de conexión a base de datos
  - Configuraciones de timeout y retry específicas de Guatemala
- **Archivo**: consultaRutaRegionalIn.xq con parámetros GT01

### 6. Manejo de Errores Guatemala
- **Ubicación**: Error Handler "_onErrorHandler"
- **Regla**: Errores específicos de Guatemala se mapean con:
  - Código base FICBCO0259
  - Mensajes en español para Guatemala
  - Códigos de error específicos del país
- **Código**: `fn:concat("FICBCO0259", "$#$", $errorMessage)`
- **Archivo**: ReversarTransaccionID.proxy error handler

### 7. Validación de Moneda Guatemala
- **Ubicación**: Implícita en validación de transacción
- **Regla**: Guatemala maneja principalmente:
  - GTQ (Quetzal guatemalteco)
  - USD (Dólar estadounidense)
- **Consideración**: Las reversiones deben mantener la moneda original

### 8. Horarios de Procesamiento Guatemala
- **Ubicación**: Configuración regional
- **Regla**: Guatemala tiene zona horaria GMT-6:
  - Ventana de procesamiento: 06:00 - 22:00 hora local
  - Reversiones fuera de horario requieren autorización especial
- **Consideración**: Validación de horario en consulta regional