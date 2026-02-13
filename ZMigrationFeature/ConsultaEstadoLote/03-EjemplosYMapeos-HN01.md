# Ejemplos y Mapeos - HN01 (Honduras)

## Request OSB (Ejemplo SOAP/XML)

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/wsdl/soap/" 
                  xmlns:pag="http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:RequestHeader>
         <Authentication>
            <UserName>USUARIO_PRUEBA</UserName>
            <Password>********</Password>
         </Authentication>
         <Region>
            <SourceBank>HN01</SourceBank>
            <DestinationBank>HN01</DestinationBank>
         </Region>
         <TransactionId>TXN-20240115-001</TransactionId>
         <Channel>WEB</Channel>
      </aut:RequestHeader>
   </soapenv:Header>
   <soapenv:Body>
      <pag:consultaEstadoLote>
         <CUSTOMER_ID>1234567</CUSTOMER_ID>
         <BANK_BATCH_ID>98765</BANK_BATCH_ID>
         <UPLOAD_DATE>2024-01-15</UPLOAD_DATE>
      </pag:consultaEstadoLote>
   </soapenv:Body>
</soapenv:Envelope>
```

## Response OSB (Ejemplo SOAP/XML)

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/wsdl/soap/" 
                  xmlns:pag="http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:ResponseHeader>
         <successIndicator>Success</successIndicator>
      </aut:ResponseHeader>
   </soapenv:Header>
   <soapenv:Body>
      <pag:consultaEstadoLoteResponse>
         <BANK_BATCH_ID>98765</BANK_BATCH_ID>
         <CUSTOMER_ID>1234567</CUSTOMER_ID>
         <CUSTOMER_NAME>EMPRESA DEMO S.A.</CUSTOMER_NAME>
         <STATUS>2</STATUS>
         <STATUS_DESC>PROCESADO</STATUS_DESC>
         <OPTIMISTIC>YES</OPTIMISTIC>
         <ACCOUNTS>
            <ACCOUNT>
               <DEBIT_ACCOUNT>1234567890</DEBIT_ACCOUNT>
               <AMOUNT>150000.00</AMOUNT>
               <CURRENCY>HNL</CURRENCY>
            </ACCOUNT>
            <ACCOUNT>
               <DEBIT_ACCOUNT>9876543210</DEBIT_ACCOUNT>
               <AMOUNT>50000.00</AMOUNT>
               <CURRENCY>USD</CURRENCY>
            </ACCOUNT>
         </ACCOUNTS>
         <PAYMENTS>
            <PAYMENT>
               <CURRENCY>HNL</CURRENCY>
               <TOTAL_AMOUNT>150000.00</TOTAL_AMOUNT>
               <EXCHANGE_RATE>1.0</EXCHANGE_RATE>
            </PAYMENT>
            <PAYMENT>
               <CURRENCY>USD</CURRENCY>
               <TOTAL_AMOUNT>50000.00</TOTAL_AMOUNT>
               <EXCHANGE_RATE>24.50</EXCHANGE_RATE>
            </PAYMENT>
         </PAYMENTS>
         <TOTAL_AMOUNT>200000.00</TOTAL_AMOUNT>
         <TOTAL_AMOUNT_ERROR>0.00</TOTAL_AMOUNT_ERROR>
         <NUMBER_OF_TRANSACTIONS>150</NUMBER_OF_TRANSACTIONS>
         <NUMBER_OF_TRANSACTIONS_SUCCESS>148</NUMBER_OF_TRANSACTIONS_SUCCESS>
         <NUMBER_OF_TRANSACTIONS_ERROR>2</NUMBER_OF_TRANSACTIONS_ERROR>
         <APPLICATION_DATE>2024-01-16T08:00:00</APPLICATION_DATE>
         <PROCESS_INFO>Lote procesado exitosamente</PROCESS_INFO>
      </pag:consultaEstadoLoteResponse>
   </soapenv:Body>
</soapenv:Envelope>
```

---

## Servicios Dependientes

### 1. ValidaServicioRegional (Base de Datos)

#### Request Interno

```xml
<ns:InputParameters xmlns:ns="http://xmlns.oracle.com/pcbpel/adapter/db/sp/ValidaServicioRegional">
   <ns:PV_SERVICIO_ID>FICBCO0231</ns:PV_SERVICIO_ID>
   <ns:PV_REGION>HN01</ns:PV_REGION>
</ns:InputParameters>
```

#### Response Interno

```xml
<ns:OutputParameters xmlns:ns="http://xmlns.oracle.com/pcbpel/adapter/db/sp/ValidaServicioRegional">
   <ns:PV_CODIGO_ERROR>SUCCESS</ns:PV_CODIGO_ERROR>
   <ns:PV_MENSAJE_ERROR></ns:PV_MENSAJE_ERROR>
</ns:OutputParameters>
```

#### Cadena de Conexión
- **Tipo**: Base de Datos Oracle
- **JNDI**: `eis/DB/ConnectionProxyAbanksHN` (inferido, puede ser diferente)
- **Stored Procedure**: `ValidaServicioRegional` (package no especificado)

#### Tabla de Mapeo de Entrada

| Campo Origen (OSB) | Transformación/Script | Campo Destino (BD) |
|-------------------|----------------------|-------------------|
| Constante "FICBCO0231" | Valor fijo | PV_SERVICIO_ID |
| $header/aut:RequestHeader/Region/SourceBank | XQuery: data() | PV_REGION |

**Referencia**: `Middleware/v2/Resources/Generales/xq/validaServicioRegionalIn.xqy`

#### Tabla de Mapeo de Salida

| Campo Origen (BD) | Transformación/Script | Campo Destino (OSB) |
|------------------|----------------------|-------------------|
| PV_CODIGO_ERROR | XQuery: fn:string() | successIndicator (si != SUCCESS) |
| PV_MENSAJE_ERROR | XQuery: fn:string() | messages (si error) |

**Referencia**: Pipeline `ValidacionesGenerales_request`, stage `ValidacionServicioRegional`

---

### 2. validaAccesoPMS (Base de Datos)

#### Request Interno

```xml
<ns:InputParameters xmlns:ns="http://xmlns.oracle.com/pcbpel/adapter/db/sp/validaAccesoPMS">
   <ns:PV_CUSTOMER_ID>1234567</ns:PV_CUSTOMER_ID>
   <ns:PV_USER_NAME>USUARIO_PRUEBA</ns:PV_USER_NAME>
</ns:InputParameters>
```

#### Response Interno

```xml
<ns:OutputParameters xmlns:ns="http://xmlns.oracle.com/pcbpel/adapter/db/sp/validaAccesoPMS">
   <ns:ERROR_MESSAGE></ns:ERROR_MESSAGE>
</ns:OutputParameters>
```

#### Cadena de Conexión
- **Tipo**: Base de Datos Oracle
- **JNDI**: `eis/DB/ConnectionProxyAbanksHN` (inferido)
- **Stored Procedure**: `validaAccesoPMS` (package no especificado)
- **Business Service**: `Middleware/v2/BusinessServices/PMSV/validaAccesoPMS/biz/validaAccesoPMS_db`

#### Tabla de Mapeo de Entrada

| Campo Origen (OSB) | Transformación/Script | Campo Destino (BD) |
|-------------------|----------------------|-------------------|
| $body/pag:consultaEstadoLote/CUSTOMER_ID | XQuery: fn:string(text()) | PV_CUSTOMER_ID |
| $header/aut:RequestHeader/Authentication/UserName | XQuery: fn:string(text()) | PV_USER_NAME |

**Referencia**: `Middleware/v2/Resources/PagosMasivos/xq/validarAccesoPMSIn.xqy`

#### Tabla de Mapeo de Salida

| Campo Origen (BD) | Transformación/Script | Campo Destino (OSB) |
|------------------|----------------------|-------------------|
| ERROR_MESSAGE | XQuery: fn:string(text()) | $validationMessage (variable) |

**Referencia**: Pipeline `HN01_ConsultaEstadoLote_request`, stage `FlujoEntrada`

---

### 3. consultarEstadoLote (Base de Datos - Stored Procedure)

#### Request Interno

```xml
<ns:InputParameters xmlns:ns="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarEstadoLote">
   <ns:PV_CODIGOCLIENTE>1234567</ns:PV_CODIGOCLIENTE>
   <ns:PN_NUMEROLOTE>98765</ns:PN_NUMEROLOTE>
   <ns:PD_FECINGRESO>2024-01-15T00:00:00</ns:PD_FECINGRESO>
</ns:InputParameters>
```

#### Response Interno

```xml
<ns:OutputParameters xmlns:ns="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultarEstadoLote">
   <ns:PV_CODIGOCLIENTE>1234567</ns:PV_CODIGOCLIENTE>
   <ns:PN_NUMEROLOTE>98765</ns:PN_NUMEROLOTE>
   <ns:PV_NOMBRECLIENTE>EMPRESA DEMO S.A.</ns:PV_NOMBRECLIENTE>
   <ns:PN_ESTADOLOTE>2</ns:PN_ESTADOLOTE>
   <ns:PV_DESCESTADOLOTE>PROCESADO</ns:PV_DESCESTADOLOTE>
   <ns:PN_OPTIMISTA>1</ns:PN_OPTIMISTA>
   <ns:PT_CUENTADB>
      <ns:ITEM>1234567890</ns:ITEM>
      <ns:ITEM>9876543210</ns:ITEM>
   </ns:PT_CUENTADB>
   <ns:PT_MONTO>
      <ns:ITEM>150000.00</ns:ITEM>
      <ns:ITEM>50000.00</ns:ITEM>
   </ns:PT_MONTO>
   <ns:PT_MONEDA>
      <ns:ITEM>HNL</ns:ITEM>
      <ns:ITEM>USD</ns:ITEM>
   </ns:PT_MONEDA>
   <ns:PT_MONEDAPAGOS>
      <ns:ITEM>HNL</ns:ITEM>
      <ns:ITEM>USD</ns:ITEM>
   </ns:PT_MONEDAPAGOS>
   <ns:PT_MONTOPAGOS>
      <ns:ITEM>150000.00</ns:ITEM>
      <ns:ITEM>50000.00</ns:ITEM>
   </ns:PT_MONTOPAGOS>
   <ns:PT_TASAPAGOS>
      <ns:ITEM>1.0</ns:ITEM>
      <ns:ITEM>24.50</ns:ITEM>
   </ns:PT_TASAPAGOS>
   <ns:PN_MONTOTOTAL>200000.00</ns:PN_MONTOTOTAL>
   <ns:PN_MONTOERROR>0.00</ns:PN_MONTOERROR>
   <ns:PN_NROTRANS>150</ns:PN_NROTRANS>
   <ns:PN_NROTRANSEXITO>148</ns:PN_NROTRANSEXITO>
   <ns:PN_NROTRANSERROR>2</ns:PN_NROTRANSERROR>
   <ns:PD_FECAPLICACION>2024-01-16T08:00:00</ns:PD_FECAPLICACION>
   <ns:PV_INFORMACIONPROCESO>Lote procesado exitosamente</ns:PV_INFORMACIONPROCESO>
   <ns:PV_CODIGOMENSAJE>SUCCESS</ns:PV_CODIGOMENSAJE>
   <ns:PV_DESCRIPCIONMENSAJE></ns:PV_DESCRIPCIONMENSAJE>
</ns:OutputParameters>
```

#### Cadena de Conexión
- **Tipo**: Base de Datos Oracle
- **JNDI**: `eis/DB/ConnectionProxyAbanksHN`
- **Package**: `PMS_K_PAGOS_MASIVOS`
- **Stored Procedure**: `PMS_P_CON_ESTADO_LOTE`
- **Business Service**: `Middleware/v2/BusinessServices/PMSV/consultaEstadoLote/biz/consultarEstadoLote_db`
- **JCA File**: `Middleware/v2/BusinessServices/PMSV/consultaEstadoLote/jca/consultarEstadoLote_db.jca`

#### Tabla de Mapeo de Entrada

| Campo Origen (OSB) | Transformación/Script | Campo Destino (BD) |
|-------------------|----------------------|-------------------|
| $body/pag:consultaEstadoLote/CUSTOMER_ID | XQuery: data() | PV_CODIGOCLIENTE |
| $body/pag:consultaEstadoLote/BANK_BATCH_ID | XQuery: data() | PN_NUMEROLOTE |
| $body/pag:consultaEstadoLote/UPLOAD_DATE | XQuery: data() | PD_FECINGRESO |

**Referencia**: `Middleware/v2/Resources/ConsultaEstadoLote/xq/consultaEstadoLoteIn.xqy`

#### Tabla de Mapeo de Salida (Header)

| Campo Origen (BD) | Transformación/Script | Campo Destino (OSB) |
|------------------|----------------------|-------------------|
| PV_CODIGOMENSAJE | XQuery: fn:string(text()) | successIndicator |
| PV_DESCRIPCIONMENSAJE | XQuery: fn:string(text()), solo si error | messages |

**Referencia**: `Middleware/v2/Resources/ConsultaEstadoLote/xq/consultaEstadoLoteHeaderOut.xqy`

**Regla de Negocio**:
```xquery
if ($successIndicator = "SUCCESS") then (
    <successIndicator>Success</successIndicator>
) else (
    <successIndicator>{ $successIndicator }</successIndicator>,
    <messages>{ $message }</messages>
)
```

#### Tabla de Mapeo de Salida (Body)

| Campo Origen (BD) | Transformación/Script | Campo Destino (OSB) |
|------------------|----------------------|-------------------|
| PN_NUMEROLOTE | XQuery: data() | BANK_BATCH_ID |
| PV_CODIGOCLIENTE | XQuery: data() | CUSTOMER_ID |
| PV_NOMBRECLIENTE | XQuery: data() | CUSTOMER_NAME |
| PN_ESTADOLOTE | XQuery: data() | STATUS |
| PV_DESCESTADOLOTE | XQuery: data() | STATUS_DESC |
| PN_OPTIMISTA | Conversión: 1→"YES", otro→"NO" | OPTIMISTIC |
| PT_CUENTADB/ITEM[i] | Iteración con índice | ACCOUNTS/ACCOUNT/DEBIT_ACCOUNT |
| PT_MONTO/ITEM[i] | Iteración con índice | ACCOUNTS/ACCOUNT/AMOUNT |
| PT_MONEDA/ITEM[i] | Iteración con índice | ACCOUNTS/ACCOUNT/CURRENCY |
| PT_MONEDAPAGOS/ITEM[i] | Iteración con índice | PAYMENTS/PAYMENT/CURRENCY |
| PT_MONTOPAGOS/ITEM[i] | Iteración con índice | PAYMENTS/PAYMENT/TOTAL_AMOUNT |
| PT_TASAPAGOS/ITEM[i] | Iteración con índice | PAYMENTS/PAYMENT/EXCHANGE_RATE |
| PN_MONTOTOTAL | XQuery: data() | TOTAL_AMOUNT |
| PN_MONTOERROR | XQuery: data() | TOTAL_AMOUNT_ERROR |
| PN_NROTRANS | XQuery: data() | NUMBER_OF_TRANSACTIONS |
| PN_NROTRANSEXITO | XQuery: data() | NUMBER_OF_TRANSACTIONS_SUCCESS |
| PN_NROTRANSERROR | XQuery: data() | NUMBER_OF_TRANSACTIONS_ERROR |
| PD_FECAPLICACION | fn:adjust-dateTime-to-timezone(data(), ()) | APPLICATION_DATE |
| PV_INFORMACIONPROCESO | XQuery: data() | PROCESS_INFO |

**Referencia**: `Middleware/v2/Resources/ConsultaEstadoLote/xq/consultaEstadoLoteOut.xqy`

**Reglas de Negocio**:

1. **Conversión de Optimista**:
```xquery
if (data($outputParameters/ns1:PN_OPTIMISTA) = 1) then
    ("YES")
else 
    "NO"
```

2. **Iteración de Arrays Paralelos (Cuentas)**:
```xquery
let $cuentaDB := $outputParameters/ns1:PT_CUENTADB/ns1:ITEM
let $monto := $outputParameters/ns1:PT_MONTO/ns1:ITEM
let $moneda := $outputParameters/ns1:PT_MONEDA/ns1:ITEM
for $i in 1 to count($cuentaDB)
return
    <ACCOUNT>
        <DEBIT_ACCOUNT>{ data($cuentaDB[$i]) }</DEBIT_ACCOUNT>
        <AMOUNT>{ data($monto[$i]) }</AMOUNT>
        <CURRENCY>{ data($moneda[$i]) }</CURRENCY>
    </ACCOUNT>
```

3. **Ajuste de Zona Horaria**:
```xquery
fn:adjust-dateTime-to-timezone(data($outputParameters/ns1:PD_FECAPLICACION), ())
```
Elimina la zona horaria de la fecha para normalizarla.

---

### 4. MapeoErrores (Servicio OSB)

#### Request Interno

```xml
<mapeoErrores>
   <CODIGO_ERROR>OSB-382505</CODIGO_ERROR>
   <MENSAJE_ERROR>FICBCO0231$#$Error al consultar estado del lote</MENSAJE_ERROR>
</mapeoErrores>
```

#### Response Interno

```xml
<mapeoErroresResponse>
   <CODIGO_ERROR_MAPEADO>MW-0001</CODIGO_ERROR_MAPEADO>
   <MENSAJE_ERROR_MAPEADO>Error en consulta de lote</MENSAJE_ERROR_MAPEADO>
</mapeoErroresResponse>
```

#### Cadena de Conexión
- **Tipo**: Proxy Service OSB
- **Referencia**: `Middleware/v2/ProxyServices/MapeoErrores`
- **Operación**: `mapeoErrores`

#### Tabla de Mapeo de Entrada

| Campo Origen (OSB) | Transformación/Script | Campo Destino (MapeoErrores) |
|-------------------|----------------------|------------------------------|
| $errorCode o successIndicator | XQuery: fn:upper-case(fn:string()) | CODIGO_ERROR |
| Constante "FICBCO0231" + "$#$" + mensaje | XQuery: fn:concat() | MENSAJE_ERROR |

**Referencia**: `Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageIn.xqy`

#### Tabla de Mapeo de Salida

| Campo Origen (MapeoErrores) | Transformación/Script | Campo Destino (OSB) |
|----------------------------|----------------------|-------------------|
| CODIGO_ERROR_MAPEADO | XQuery | successIndicator |
| MENSAJE_ERROR_MAPEADO | XQuery | messages |

**Referencia**: `Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageOut.xqy`

---

## Reglas de Negocio Detectadas

### 1. Validación de Acceso de Usuario
**Ubicación**: Pipeline `HN01_ConsultaEstadoLote_request`, stage `FlujoEntrada`

**Lógica**:
```
SI validationMessage != "" ENTONCES
    Retornar error sin consultar el lote
    successIndicator = "Error"
    messages = validationMessage
    body = <consultaEstadoLoteResponse/> (vacío)
FIN SI
```

**Fragmento de Código**: Pipeline XML, líneas con `$validationMessage != ""`

### 2. Validación de Servicio Regional
**Ubicación**: Pipeline `ValidacionesGenerales_request`, stage `ValidacionServicioRegional`

**Lógica**:
```
SI PV_CODIGO_ERROR != 'SUCCESS' ENTONCES
    Retornar error inmediatamente
    successIndicator = "ERROR"
    messages = PV_MENSAJE_ERROR
    body = <consultaEstadoLoteResponse/> (vacío)
    REPLY (terminar flujo)
SINO
    Aplicar valores por defecto de región
    Continuar flujo
FIN SI
```

**Fragmento de Código**: Pipeline XML, `<con3:ifThenElse>` con condición `fn:string($respValidaServicioRegional/val:PV_CODIGO_ERROR/text()) != 'SUCCESS'`

### 3. Conversión de Indicador Optimista
**Ubicación**: `consultaEstadoLoteOut.xqy`

**Lógica**:
```
SI PN_OPTIMISTA = 1 ENTONCES
    OPTIMISTIC = "YES"
SINO
    OPTIMISTIC = "NO"
FIN SI
```

**Fragmento de Código**:
```xquery
if (data($outputParameters/ns1:PN_OPTIMISTA) = 1) then
    ("YES")
else 
    "NO"
```

### 4. Construcción de Arrays Paralelos
**Ubicación**: `consultaEstadoLoteOut.xqy`

**Lógica**:
```
PARA i = 1 HASTA count(PT_CUENTADB/ITEM) HACER
    ACCOUNT[i].DEBIT_ACCOUNT = PT_CUENTADB/ITEM[i]
    ACCOUNT[i].AMOUNT = PT_MONTO/ITEM[i]
    ACCOUNT[i].CURRENCY = PT_MONEDA/ITEM[i]
FIN PARA
```

**Fragmento de Código**:
```xquery
let $cuentaDB := $outputParameters/ns1:PT_CUENTADB/ns1:ITEM
let $monto := $outputParameters/ns1:PT_MONTO/ns1:ITEM
let $moneda := $outputParameters/ns1:PT_MONEDA/ns1:ITEM
for $i in 1 to count($cuentaDB)
return
    <ACCOUNT>
        <DEBIT_ACCOUNT>{ data($cuentaDB[$i]) }</DEBIT_ACCOUNT>
        <AMOUNT>{ data($monto[$i]) }</AMOUNT>
        <CURRENCY>{ data($moneda[$i]) }</CURRENCY>
    </ACCOUNT>
```

### 5. Manejo de Errores en Response
**Ubicación**: Pipeline `ValidacionesGenerales_response`, stage `MapeoError`

**Lógica**:
```
SI successIndicator != "SUCCESS" ENTONCES
    Invocar MapeoErrores
    Reemplazar header con error mapeado
FIN SI
```

**Fragmento de Código**: Pipeline XML, `<con5:ifThenElse>` con condición `fn:upper-case(fn:string($header/aut:ResponseHeader/successIndicator/text())) != "SUCCESS"`

### 6. Condicional de Respuesta Exitosa
**Ubicación**: Pipeline `HN01_ConsultaEstadoLote_response`, stage `FlujoSalida`

**Lógica**:
```
SI successIndicator = "SUCCESS" ENTONCES
    Transformar body con consultaEstadoLoteOut.xqy
SINO
    body = <consultaEstadoLoteResponse/> (vacío)
FIN SI
```

**Fragmento de Código**: Pipeline XML, `<con3:ifThenElse>` con condición `fn:upper-case(fn:string($header/aut:ResponseHeader/successIndicator/text())) = "SUCCESS"`

---

## Notas Adicionales

- **Encoding**: Los archivos XQuery usan encoding `Cp1252` (Windows Latin-1)
- **XQuery Version**: `2004-draft`
- **Namespace Prefixes**: Consistentes en todos los archivos (ns0, ns1, xf)
- **Error Handling**: Todos los errores pasan por MapeoErrores para normalización
- **Logging**: Configurado en nivel "debug" en el pipeline
- **Monitoring**: Habilitado con intervalo de agregación de 360 segundos
