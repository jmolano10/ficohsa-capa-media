# Ejemplos de Request/Response y Mapeo de Datos - PA01 (Panamá)

## Request OSB (ejemplo SOAP/XML)

```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/" 
               xmlns:rev="http://www.ficohsa.com.hn/middleware.services/reversarTransaccionIDPS/"
               xmlns:rti="http://www.ficohsa.com.hn/middleware.services/reversarTransaccionIDTypes"
               xmlns:auth="http://www.ficohsa.com.hn/middleware.services/autType">
  <soap:Header>
    <auth:RequestHeader>
      <Authentication>
        <UserName>USUARIO_PA01</UserName>
        <Password>PASSWORD_ENCRYPTED</Password>
      </Authentication>
      <Region>PA01</Region>
      <Channel>OMNICANAL</Channel>
      <messageId>MSG-PA01-20241201-001</messageId>
    </auth:RequestHeader>
  </soap:Header>
  <soap:Body>
    <rti:reversarTransaccionID>
      <TRANSACTION_TYPE>PAGO_EEH</TRANSACTION_TYPE>
      <TRANSACTION_ID>550e8400-e29b-41d4-a716-446655440002</TRANSACTION_ID>
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
      <messageId>MSG-PA01-20241201-001</messageId>
    </auth:ResponseHeader>
  </soap:Header>
  <soap:Body>
    <rti:reversarTransaccionIDResponse>
      <T24_REFERENCE>FT24001PA123456</T24_REFERENCE>
      <TRANSACTION_ID>550e8400-e29b-41d4-a716-446655440002</TRANSACTION_ID>
      <REFERENCE_CB>CBPA20241201001</REFERENCE_CB>
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
  <ns0:PV_REGION>PA01</ns0:PV_REGION>
  <ns0:PV_OPERACION>reversarTransaccionID</ns0:PV_OPERACION>
  <ns0:PV_VERSION>V2</ns0:PV_VERSION>
</ns0:InputParameters>
```

#### Response de consultaRutaRegional_db
```xml
<ns0:OutputParameters xmlns:ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaRutaRegional">
  <ns0:PV_CODIGO_ERROR>SUCCESS</ns0:PV_CODIGO_ERROR>
  <ns0:PV_MENSAJE_ERROR></ns0:PV_MENSAJE_ERROR>
  <ns0:PV_RUTA_REGIONAL>PA01_ROUTE</ns0:PV_RUTA_REGIONAL>
</ns0:OutputParameters>
```

### 2. Obtener Tipo de Transacción

#### Request a obtenerTipoTrxGen_db
```xml
<ns0:InputParameters xmlns:ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/obtenerTipoTrxGen">
  <ns0:PV_COD_OSB>PAGO_EEH</ns0:PV_COD_OSB>
</ns0:InputParameters>
```

#### Response de obtenerTipoTrxGen_db
```xml
<ns0:OutputParameters xmlns:ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/obtenerTipoTrxGen">
  <ns0:PV_ERROR_CODE>SUCCESS</ns0:PV_ERROR_CODE>
  <ns0:PV_MESSAGE>GEN</ns0:PV_MESSAGE>
  <ns0:PV_TIPO_OPE>REVERSA_EEH</ns0:PV_TIPO_OPE>
</ns0:OutputParameters>
```

### 3. Validar Estado de Transacción

#### Request a validarEstadoTransaccion_db
```xml
<ns0:InputParameters xmlns:ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/validarEstadoTransaccion">
  <ns0:PV_UUID>550e8400-e29b-41d4-a716-446655440002</ns0:PV_UUID>
  <ns0:PN_TIPO_CONSULTA>4</ns0:PN_TIPO_CONSULTA>
  <ns0:PN_CODIGO_ESTADO>0</ns0:PN_CODIGO_ESTADO>
</ns0:InputParameters>
```

#### Response de validarEstadoTransaccion_db
```xml
<ns0:OutputParameters xmlns:ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/validarEstadoTransaccion">
  <ns0:PV_ERRORCODE>SUCCESS</ns0:PV_ERRORCODE>
  <ns0:PV_ERRORMESSAGE></ns0:PV_ERRORMESSAGE>
  <ns0:PV_FT>FT24001PA123456</ns0:PV_FT>
  <ns0:PV_MESSAGE>TRUE</ns0:PV_MESSAGE>
  <ns0:Pv_uuido>550e8400-e29b-41d4-a716-446655440002</ns0:Pv_uuido>
  <ns0:Pv_refcb>CBPA20241201001</ns0:Pv_refcb>
</ns0:OutputParameters>
```

### 4. Reversión EEH en T24

#### Request a svcGestionesTrxSEEHTENGO
```xml
<ReversarTransaccionTENGOEEHRequest>
  <User>USUARIO_PA01</User>
  <FT>FT24001PA123456</FT>
  <Region>PA01</Region>
  <ServiceType>EEH</ServiceType>
</ReversarTransaccionTENGOEEHRequest>
```

#### Response de svcGestionesTrxSEEHTENGO
```xml
<ReversarTransaccionTENGOEEHResponse>
  <Status>
    <successIndicator>SUCCESS</successIndicator>
    <messages>Reversión EEH procesada exitosamente</messages>
    <transactionId>REV24001PA123456</transactionId>
  </Status>
</ReversarTransaccionTENGOEEHResponse>
```

### 5. Actualizar Transacción Genérica

#### Request a actualizarTransaccionGenCB_db
```xml
<ns0:InputParameters xmlns:ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/actualizarTransaccionGenCB">
  <ns0:PV_UUID>550e8400-e29b-41d4-a716-446655440002</ns0:PV_UUID>
  <ns0:PV_FT></ns0:PV_FT>
  <ns0:PV_ESTADO>R</ns0:PV_ESTADO>
</ns0:InputParameters>
```

#### Response de actualizarTransaccionGenCB_db
```xml
<ns0:OutputParameters xmlns:ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/actualizarTransaccionGenCB">
  <ns0:PV_ERROR_CODE>SUCCESS</ns0:PV_ERROR_CODE>
  <ns0:Pv_ERRORMESSAGE></ns0:Pv_ERRORMESSAGE>
</ns0:OutputParameters>
```

## Cadenas de Conexión y Credenciales

### Base de Datos MDW
- **Nombre de Base de Datos**: MIDDLEWARE_PA
- **Esquema**: MW_SCHEMA
- **Conexión JCA**: `jca://eis/DB/ConnectionMiddleware`
- **Pool de Conexiones**: ConnectionMiddleware
- **Stored Procedures**:
  - `MW_P_CONSULTA_RUTA_REGIONAL`
  - `MW_P_OBTENER_TIPO_TRX_GEN`
  - `MW_P_VALIDAR_ESTADO_TRANSACCION`
  - `MW_P_ACTUALIZAR_TRANSACCION_GEN_CB`

### Servicio T24 EEH
- **Endpoint WSDL**: `http://t24-pa01.ficohsa.com:8080/T24Services/GestionesTrxSEEHTENGO?wsdl`
- **Operación**: `ReversarTransaccionTENGOEEH`
- **Timeout**: 30 segundos
- **Retry**: 0 intentos

### Servicios EEH Panamá
- **Endpoint EEH**: `http://eeh-pa01.ficohsa.com:8080/EEHServices/ReversarPago?wsdl`
- **Operación**: `ReversarPagoEEH`
- **Timeout**: 45 segundos
- **Retry**: 1 intento

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

### Mapeo OSB → svcGestionesTrxSEEHTENGO

| Campo Origen (OSB) | Transformación/Script | Campo Destino (servicio interno) |
|-------------------|----------------------|----------------------------------|
| $header/aut:RequestHeader/Authentication/UserName | XPath extraction | User |
| $refT24 | Variable de respuesta anterior | FT |

### Mapeo OSB → actualizarTransaccionGenCB_db

| Campo Origen (OSB) | Transformación/Script | Campo Destino (servicio interno) |
|-------------------|----------------------|----------------------------------|
| $uuiddb | Variable de respuesta anterior | PV_UUID |
| Constante '' | Valor vacío | PV_FT |

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

### Mapeo svcGestionesTrxSEEHTENGO → OSB

| Campo Origen (servicio interno) | Transformación/Script | Campo Destino (OSB) |
|--------------------------------|----------------------|---------------------|
| Status/successIndicator | fn:upper-case() | $successIndicator |
| Status/messages | XPath extraction | $errorCode |
| Status/transactionId | XPath extraction | $statusT24 |

### Mapeo actualizarTransaccionGenCB_db → OSB

| Campo Origen (servicio interno) | Transformación/Script | Campo Destino (OSB) |
|--------------------------------|----------------------|---------------------|
| PV_ERROR_CODE | XPath extraction | $successIndicator |
| Pv_ERRORMESSAGE | XPath extraction | $ErrorCode |

### Mapeo Final OSB Response

| Campo Origen (OSB) | Transformación/Script | Campo Destino (OSB Response) |
|-------------------|----------------------|------------------------------|
| $statusT24 | fn:upper-case() | T24_REFERENCE |
| $uuiddb | fn:upper-case() | TRANSACTION_ID |
| $refcb | fn:upper-case() | REFERENCE_CB |

## Reglas de Negocio Detectadas

### 1. Validación de Tipo de Transacción EEH
- **Ubicación**: Stage "ValidarTransaccionDB"
- **Regla**: Para transacciones PAGO_EEH, el tipo retornado es 'GEN', por lo que se usa tipo de consulta 4
- **Código**: `if (fn:string($tipoTRX) = 'NOGEN') then (1) else (4)`
- **Archivo**: ReversarTransaccionID.proxy líneas de transformación

### 2. Validación de Estado de Transacción EEH
- **Ubicación**: Stage "ReversarTransaccion"
- **Regla**: Solo se puede reversar si $dbmesage = 'TRUE' y la transacción está en estado válido
- **Código**: `$dbmesage = 'TRUE'`
- **Archivo**: ReversarTransaccionID.proxy condición de validación

### 3. Procesamiento Específico EEH - Panamá
- **Ubicación**: Stage "ReversarTransaccion"
- **Regla**: Para transacciones PAGO_EEH en Panamá:
  - Se usa svcGestionesTrxSEEHTENGO con operación ReversarTransaccionTENGOEEH
  - Se requiere validación adicional con empresa de servicios públicos
  - Se maneja integración específica con sistema EEH de Panamá
- **Archivo**: ReversarTransaccionID.proxy estructura condicional PAGO_EEH

### 4. Actualización de Transacciones Genéricas - Panamá
- **Ubicación**: Stage "ActualizarEstadoTransaccion"
- **Regla**: Para Panamá, las transacciones EEH usan:
  - actualizarTransaccionGenCB_db (ya que $tipoTRX = 'GEN')
  - Estado se actualiza a 'R' (Reversada)
  - Se mantiene referencia vacía en PV_FT
- **Archivo**: ReversarTransaccionID.proxy lógica de actualización

### 5. Configuración Regional Panamá
- **Ubicación**: Stage "ConsultaRutaRegional"
- **Regla**: La configuración regional PA01 determina:
  - Rutas específicas para servicios EEH
  - Parámetros de conexión a empresas de servicios públicos
  - Configuraciones de timeout extendidas para EEH (45 segundos)
- **Archivo**: consultaRutaRegionalIn.xq con parámetros PA01

### 6. Validación de Empresa de Servicios - Panamá
- **Ubicación**: Implícita en svcGestionesTrxSEEHTENGO
- **Regla**: Panamá requiere validación específica con:
  - Empresa Eléctrica de Panamá
  - Autoridad Nacional de los Servicios Públicos (ASEP)
  - Validación de códigos de servicio específicos de PA
- **Consideración**: Reversiones EEH requieren confirmación de empresa

### 7. Manejo de Moneda Panamá
- **Ubicación**: Implícita en validación de transacción
- **Regla**: Panamá maneja:
  - USD (Dólar estadounidense) - moneda oficial
  - PAB (Balboa panameño) - equivalente 1:1 con USD
- **Consideración**: Las reversiones mantienen moneda original

### 8. Horarios de Procesamiento EEH Panamá
- **Ubicación**: Configuración regional
- **Regla**: Panamá tiene zona horaria GMT-5:
  - Ventana EEH: 06:00 - 20:00 hora local
  - Reversiones EEH fuera de horario requieren autorización especial
  - Fines de semana: procesamiento limitado
- **Consideración**: Validación de horario en consulta regional

### 9. Códigos de Error EEH Específicos
- **Ubicación**: Error Handler "_onErrorHandler"
- **Regla**: Errores EEH en Panamá incluyen:
  - Códigos específicos de empresa de servicios
  - Mensajes en español para Panamá
  - Códigos de error específicos del país y tipo EEH
- **Código**: `fn:concat("FICBCO0259", "$#$", $errorMessage)`
- **Archivo**: ReversarTransaccionID.proxy error handler

### 10. Validación de Número de Servicio EEH
- **Ubicación**: Implícita en validación de transacción
- **Regla**: Números de servicio EEH en Panamá:
  - Formato específico por empresa
  - Validación de dígito verificador
  - Validación de zona geográfica
- **Consideración**: Validación previa a reversión