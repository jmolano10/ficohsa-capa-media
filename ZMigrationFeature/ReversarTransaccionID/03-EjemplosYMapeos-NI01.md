# Ejemplos de Request/Response y Mapeo de Datos - NI01 (Nicaragua)

## Request OSB (ejemplo SOAP/XML)

```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/" 
               xmlns:rev="http://www.ficohsa.com.hn/middleware.services/reversarTransaccionIDPS/"
               xmlns:rti="http://www.ficohsa.com.hn/middleware.services/reversarTransaccionIDTypes"
               xmlns:auth="http://www.ficohsa.com.hn/middleware.services/autType">
  <soap:Header>
    <auth:RequestHeader>
      <Authentication>
        <UserName>USUARIO_NI01</UserName>
        <Password>PASSWORD_ENCRYPTED</Password>
      </Authentication>
      <Region>NI01</Region>
      <Channel>OMNICANAL</Channel>
      <messageId>MSG-NI01-20241201-001</messageId>
    </auth:RequestHeader>
  </soap:Header>
  <soap:Body>
    <rti:reversarTransaccionID>
      <TRANSACTION_TYPE>RETIRO</TRANSACTION_TYPE>
      <TRANSACTION_ID>550e8400-e29b-41d4-a716-446655440003</TRANSACTION_ID>
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
      <messageId>MSG-NI01-20241201-001</messageId>
    </auth:ResponseHeader>
  </soap:Header>
  <soap:Body>
    <rti:reversarTransaccionIDResponse>
      <T24_REFERENCE>FT24001NI123456</T24_REFERENCE>
      <TRANSACTION_ID>550e8400-e29b-41d4-a716-446655440003</TRANSACTION_ID>
      <REFERENCE_CB>CBNI20241201001</REFERENCE_CB>
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
  <ns0:PV_REGION>NI01</ns0:PV_REGION>
  <ns0:PV_OPERACION>reversarTransaccionID</ns0:PV_OPERACION>
  <ns0:PV_VERSION>V2</ns0:PV_VERSION>
</ns0:InputParameters>
```

#### Response de consultaRutaRegional_db
```xml
<ns0:OutputParameters xmlns:ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaRutaRegional">
  <ns0:PV_CODIGO_ERROR>SUCCESS</ns0:PV_CODIGO_ERROR>
  <ns0:PV_MENSAJE_ERROR></ns0:PV_MENSAJE_ERROR>
  <ns0:PV_RUTA_REGIONAL>NI01_ROUTE</ns0:PV_RUTA_REGIONAL>
</ns0:OutputParameters>
```

### 2. Obtener Tipo de Transacción

#### Request a obtenerTipoTrxGen_db
```xml
<ns0:InputParameters xmlns:ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/obtenerTipoTrxGen">
  <ns0:PV_COD_OSB>RETIRO</ns0:PV_COD_OSB>
</ns0:InputParameters>
```

#### Response de obtenerTipoTrxGen_db
```xml
<ns0:OutputParameters xmlns:ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/obtenerTipoTrxGen">
  <ns0:PV_ERROR_CODE>SUCCESS</ns0:PV_ERROR_CODE>
  <ns0:PV_MESSAGE>NOGEN</ns0:PV_MESSAGE>
  <ns0:PV_TIPO_OPE>REVERSA_RETIRO</ns0:PV_TIPO_OPE>
</ns0:OutputParameters>
```

### 3. Validar Estado de Transacción

#### Request a validarEstadoTransaccion_db
```xml
<ns0:InputParameters xmlns:ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/validarEstadoTransaccion">
  <ns0:PV_UUID>550e8400-e29b-41d4-a716-446655440003</ns0:PV_UUID>
  <ns0:PN_TIPO_CONSULTA>1</ns0:PN_TIPO_CONSULTA>
  <ns0:PN_CODIGO_ESTADO>0</ns0:PN_CODIGO_ESTADO>
</ns0:InputParameters>
```

#### Response de validarEstadoTransaccion_db
```xml
<ns0:OutputParameters xmlns:ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/validarEstadoTransaccion">
  <ns0:PV_ERRORCODE>SUCCESS</ns0:PV_ERRORCODE>
  <ns0:PV_ERRORMESSAGE></ns0:PV_ERRORMESSAGE>
  <ns0:PV_FT>FT24001NI123456</ns0:PV_FT>
  <ns0:PV_MESSAGE>TRUE</ns0:PV_MESSAGE>
  <ns0:Pv_uuido>550e8400-e29b-41d4-a716-446655440003</ns0:Pv_uuido>
  <ns0:Pv_refcb>CBNI20241201001</ns0:Pv_refcb>
</ns0:OutputParameters>
```

### 4. Reversión de Retiro en T24

#### Request a svcReversarTransaccionCB (ReversionDepositoTengo)
```xml
<ReversionDepositoTengoRequest>
  <User>USUARIO_NI01</User>
  <FT>FT24001NI123456</FT>
  <Region>NI01</Region>
  <TransactionType>RETIRO</TransactionType>
</ReversionDepositoTengoRequest>
```

#### Response de svcReversarTransaccionCB
```xml
<ReversionDepositoTengoResponse>
  <Status>
    <successIndicator>SUCCESS</successIndicator>
    <messages>Reversión de retiro procesada exitosamente</messages>
    <transactionId>REV24001NI123456</transactionId>
  </Status>
</ReversionDepositoTengoResponse>
```

### 5. Actualizar Estado de Transacción

#### Request a actualizarEstadoTransaccionUUID_db
```xml
<ns0:InputParameters xmlns:ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/actualizarEstadoTransaccionUUID">
  <ns0:PV_ESTADO>R</ns0:PV_ESTADO>
  <ns0:PV_UUID>550e8400-e29b-41d4-a716-446655440003</ns0:PV_UUID>
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
- **Nombre de Base de Datos**: MIDDLEWARE_NI
- **Esquema**: MW_SCHEMA
- **Conexión JCA**: `jca://eis/DB/ConnectionMiddleware`
- **Pool de Conexiones**: ConnectionMiddleware
- **Stored Procedures**:
  - `MW_P_CONSULTA_RUTA_REGIONAL`
  - `MW_P_OBTENER_TIPO_TRX_GEN`
  - `MW_P_VALIDAR_ESTADO_TRANSACCION`
  - `MW_P_ACTUALIZAR_ESTADO_TRANSACCION_UUID`

### Servicio T24
- **Endpoint WSDL**: `http://t24-ni01.ficohsa.com:8080/T24Services/ReversarTransaccionCB?wsdl`
- **Operación**: `ReversionDepositoTengo`
- **Timeout**: 30 segundos
- **Retry**: 0 intentos

### Sistema ATM Nicaragua
- **Endpoint ATM**: `http://atm-ni01.ficohsa.com:8080/ATMServices/ReversarRetiro?wsdl`
- **Operación**: `ReversarRetiroATM`
- **Timeout**: 60 segundos
- **Retry**: 2 intentos

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

### 1. Validación de Tipo de Transacción RETIRO
- **Ubicación**: Stage "ValidarTransaccionDB"
- **Regla**: Para transacciones RETIRO, el tipo retornado es 'NOGEN', por lo que se usa tipo de consulta 1
- **Código**: `if (fn:string($tipoTRX) = 'NOGEN') then (1) else (4)`
- **Archivo**: ReversarTransaccionID.proxy líneas de transformación

### 2. Validación de Estado de Transacción RETIRO
- **Ubicación**: Stage "ReversarTransaccion"
- **Regla**: Solo se puede reversar si $dbmesage = 'TRUE' y el retiro no ha sido dispensado físicamente
- **Código**: `$dbmesage = 'TRUE'`
- **Archivo**: ReversarTransaccionID.proxy condición de validación

### 3. Procesamiento de Retiros - Nicaragua
- **Ubicación**: Stage "ReversarTransaccion"
- **Regla**: Para transacciones RETIRO en Nicaragua:
  - Se usa la operación ReversionDepositoTengo del servicio svcReversarTransaccionCB
  - Se requiere validación adicional con red ATM
  - Se maneja integración específica con sistema ATM de Nicaragua
- **Archivo**: ReversarTransaccionID.proxy estructura condicional default

### 4. Actualización de Estado - Nicaragua
- **Ubicación**: Stage "ActualizarEstadoTransaccion"
- **Regla**: Para Nicaragua, las transacciones RETIRO usan:
  - actualizarEstadoTransaccionUUID_db (ya que $tipoTRX != 'GEN')
  - Estado se actualiza a 'R' (Reversada)
  - Se mantiene trazabilidad con ATM
- **Archivo**: ReversarTransaccionID.proxy lógica de actualización

### 5. Configuración Regional Nicaragua
- **Ubicación**: Stage "ConsultaRutaRegional"
- **Regla**: La configuración regional NI01 determina:
  - Rutas específicas para servicios ATM
  - Parámetros de conexión a red ATM nacional
  - Configuraciones de timeout extendidas para ATM (60 segundos)
- **Archivo**: consultaRutaRegionalIn.xq con parámetros NI01

### 6. Validación de Red ATM - Nicaragua
- **Ubicación**: Implícita en svcReversarTransaccionCB
- **Regla**: Nicaragua requiere validación específica con:
  - Red ATM nacional de Nicaragua
  - Banco Central de Nicaragua (BCN)
  - Validación de códigos de ATM específicos de NI
- **Consideración**: Reversiones de retiro requieren confirmación de ATM

### 7. Manejo de Moneda Nicaragua
- **Ubicación**: Implícita en validación de transacción
- **Regla**: Nicaragua maneja:
  - NIO (Córdoba nicaragüense) - moneda oficial
  - USD (Dólar estadounidense) - moneda de referencia
- **Consideración**: Las reversiones mantienen moneda original

### 8. Horarios de Procesamiento ATM Nicaragua
- **Ubicación**: Configuración regional
- **Regla**: Nicaragua tiene zona horaria GMT-6:
  - Ventana ATM: 05:00 - 23:00 hora local
  - Reversiones ATM fuera de horario requieren autorización especial
  - Mantenimiento ATM: 02:00 - 04:00 diario
- **Consideración**: Validación de horario en consulta regional

### 9. Códigos de Error ATM Específicos
- **Ubicación**: Error Handler "_onErrorHandler"
- **Regla**: Errores ATM en Nicaragua incluyen:
  - Códigos específicos de red ATM
  - Mensajes en español para Nicaragua
  - Códigos de error específicos del país y tipo ATM
- **Código**: `fn:concat("FICBCO0259", "$#$", $errorMessage)`
- **Archivo**: ReversarTransaccionID.proxy error handler

### 10. Validación de Límites de Retiro
- **Ubicación**: Implícita en validación de transacción
- **Regla**: Límites de retiro en Nicaragua:
  - Límite diario por tarjeta
  - Límite por transacción
  - Validación de saldo disponible
- **Consideración**: Validación previa a reversión

### 11. Validación de Estado de ATM
- **Ubicación**: Implícita en validación de transacción
- **Regla**: Estado de ATM en Nicaragua:
  - ATM operativo y con efectivo
  - Validación de dispensación física
  - Estado de comunicación con banco
- **Consideración**: Solo se reversa si no hubo dispensación física

### 12. Integración con Sistema de Compensación
- **Ubicación**: Implícita en actualización de estado
- **Regla**: Nicaragua requiere:
  - Notificación al sistema de compensación nacional
  - Actualización de saldos en tiempo real
  - Reconciliación con BCN
- **Consideración**: Reversiones impactan compensación interbancaria