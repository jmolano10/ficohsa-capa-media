# Ejemplos y Mapeos - GT01 (Guatemala)

## Request OSB (Ejemplo SOAP/XML)

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/wsdl/soap/" 
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
            <DestinationBank>GT01</DestinationBank>
         </Region>
         <TransactionId>TXN-GT-20240115-001</TransactionId>
         <Channel>WEB</Channel>
      </aut:RequestHeader>
   </soapenv:Header>
   <soapenv:Body>
      <pag:consultaEstadoLote>
         <CUSTOMER_ID>7654321</CUSTOMER_ID>
         <BANK_BATCH_ID>56789</BANK_BATCH_ID>
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
         <successIndicator>SUCCESS</successIndicator>
      </aut:ResponseHeader>
   </soapenv:Header>
   <soapenv:Body>
      <pag:consultaEstadoLoteResponse>
         <BANK_BATCH_ID>56789</BANK_BATCH_ID>
         <CUSTOMER_ID>7654321</CUSTOMER_ID>
         <CUSTOMER_NAME>EMPRESA GUATEMALA S.A.</CUSTOMER_NAME>
         <STATUS>3</STATUS>
         <STATUS_DESC>AUTORIZADO</STATUS_DESC>
         <OPTIMISTIC>NO</OPTIMISTIC>
         <ACCOUNTS>
            <ACCOUNT>
               <DEBIT_ACCOUNT>GT1234567890</DEBIT_ACCOUNT>
               <AMOUNT>250000.00</AMOUNT>
               <CURRENCY>GTQ</CURRENCY>
            </ACCOUNT>
         </ACCOUNTS>
         <PAYMENTS>
            <PAYMENT>
               <CURRENCY>GTQ</CURRENCY>
               <TOTAL_AMOUNT>250000.00</TOTAL_AMOUNT>
               <EXCHANGE_RATE>1.0</EXCHANGE_RATE>
            </PAYMENT>
         </PAYMENTS>
         <TOTAL_AMOUNT>250000.00</TOTAL_AMOUNT>
         <TOTAL_AMOUNT_ERROR>0.00</TOTAL_AMOUNT_ERROR>
         <NUMBER_OF_TRANSACTIONS>75</NUMBER_OF_TRANSACTIONS>
         <NUMBER_OF_TRANSACTIONS_SUCCESS>75</NUMBER_OF_TRANSACTIONS_SUCCESS>
         <NUMBER_OF_TRANSACTIONS_ERROR>0</NUMBER_OF_TRANSACTIONS_ERROR>
         <APPLICATION_DATE>2024-01-16T09:00:00</APPLICATION_DATE>
         <PROCESS_INFO>Lote autorizado para procesamiento</PROCESS_INFO>
      </pag:consultaEstadoLoteResponse>
   </soapenv:Body>
</soapenv:Envelope>
```

---

## Servicios Dependientes

### 1. ValidaServicioRegional (Base de Datos)

**Idéntico a HN01** - Ver documento HN01 para detalles completos.

**Diferencia**: El valor de `PV_REGION` es `GT01` en lugar de `HN01`.

---

### 2. consultarLote (Servicio SOAP Externo - MTR)

#### Request Interno

```xml
<ns2:consultarLote xmlns:ns2="http://servicio.consultalotews.mtrpmsv.cidenet.com.co/">
   <solicitudConsultaLote>
      <fechaRegistroLote>2024-01-15T00:00:00</fechaRegistroLote>
      <idBancoOrigen>GT01</idBancoOrigen>
      <idCliente>7654321</idCliente>
      <idLote>56789</idLote>
   </solicitudConsultaLote>
</ns2:consultarLote>
```

#### Response Interno

```xml
<ns1:consultarLoteResponse xmlns:ns1="http://servicio.consultalotews.mtrpmsv.cidenet.com.co/">
   <respuestaConsultaLote>
      <cabeceraRespuesta>
         <codigo>SUCCESS</codigo>
         <mensaje></mensaje>
      </cabeceraRespuesta>
      <detalleRespuesta>
         <cuentas>
            <cuenta>
               <idMoneda>GTQ</idMoneda>
               <idProductoDebito>GT1234567890</idProductoDebito>
               <monto>250000.00</monto>
            </cuenta>
         </cuentas>
         <lote>
            <cantidadTransacciones>75</cantidadTransacciones>
            <cantidadTransaccionesError>0</cantidadTransaccionesError>
            <cantidadTransaccionesExito>75</cantidadTransaccionesExito>
            <fechaAplicacion>2024-01-16T09:00:00</fechaAplicacion>
            <idClienteCore>7654321</idClienteCore>
            <idEstado>3</idEstado>
            <idLote>56789</idLote>
            <infoProceso>Lote autorizado para procesamiento</infoProceso>
            <montoTotal>250000.00</montoTotal>
            <montoTotalError>0.00</montoTotalError>
            <nombreCliente>EMPRESA GUATEMALA S.A.</nombreCliente>
            <nombreEstado>AUTORIZADO</nombreEstado>
            <optimista>N</optimista>
         </lote>
         <pagos>
            <pago>
               <idMoneda>GTQ</idMoneda>
               <monto>250000.00</monto>
               <tasaCambio>1.0</tasaCambio>
            </pago>
         </pagos>
      </detalleRespuesta>
   </respuestaConsultaLote>
</ns1:consultarLoteResponse>
```

#### Cadena de Conexión
- **Tipo**: Servicio SOAP Externo
- **Endpoint**: `https://172.23.14.243:7004/ConsultaLotePmsWS/services/consultorLoteEndpoint`
- **Operación**: `consultarLote`
- **Namespace**: `http://servicio.consultalotews.mtrpmsv.cidenet.com.co/`
- **Business Service**: `Middleware/v2/BusinessServices/MTR/consultorLote/biz/consultorLote`
- **WSDL**: `Middleware/v2/BusinessServices/MTR/consultorLote/wsdl/consultorLoteEndpoint.wsdl`
- **Binding**: SOAP 1.1 Document/Literal
- **Transport**: HTTPS

#### Tabla de Mapeo de Entrada

| Campo Origen (OSB) | Transformación/Script | Campo Destino (MTR) |
|-------------------|----------------------|---------------------|
| $consultaEstadoLote/UPLOAD_DATE | XQuery: xs:date() cast as xs:dateTime | fechaRegistroLote |
| $requestHeader/Region/SourceBank | XQuery: data() | idBancoOrigen |
| $consultaEstadoLote/CUSTOMER_ID | XQuery: data() | idCliente |
| $consultaEstadoLote/BANK_BATCH_ID | XQuery: data() | idLote |

**Referencia**: `Middleware/v2/Resources/ConsultaEstadoLote/xq/consultaEstadoLoteGTIn.xqy`

**Fragmento de Código**:
```xquery
<ns2:consultarLote>
    <solicitudConsultaLote>
        {
        for $UPLOAD_DATE in $consultaEstadoLote/UPLOAD_DATE
        return
        <fechaRegistroLote>{xs:date($consultaEstadoLote/UPLOAD_DATE)cast as xs:dateTime }</fechaRegistroLote>
        }
        <idBancoOrigen>{ data($requestHeader/Region/SourceBank) }</idBancoOrigen>
        <idCliente>{ data($consultaEstadoLote/CUSTOMER_ID) }</idCliente>
        <idLote>{ data($consultaEstadoLote/BANK_BATCH_ID) }</idLote>
    </solicitudConsultaLote>
</ns2:consultarLote>
```

#### Tabla de Mapeo de Salida (Header)

| Campo Origen (MTR) | Transformación/Script | Campo Destino (OSB) |
|-------------------|----------------------|-------------------|
| respuestaConsultaLote/cabeceraRespuesta/codigo | XQuery: data() | successIndicator |
| respuestaConsultaLote/cabeceraRespuesta/mensaje | XQuery: data() | messages |

**Referencia**: `Middleware/v2/Resources/ConsultaEstadoLote/xq/consultaEstadoLoteGTHeaderOut.xqy`

**Fragmento de Código**:
```xquery
<ns0:ResponseHeader>
    {
        for $codigo in $consultarLoteResponse/respuestaConsultaLote/cabeceraRespuesta/codigo
        return
            <successIndicator>{ data($codigo) }</successIndicator>
    }
    {
        for $mensaje in $consultarLoteResponse/respuestaConsultaLote/cabeceraRespuesta/mensaje
        return
            <messages>{ data($mensaje) }</messages>
    }
</ns0:ResponseHeader>
```

#### Tabla de Mapeo de Salida (Body)

| Campo Origen (MTR) | Transformación/Script | Campo Destino (OSB) |
|-------------------|----------------------|-------------------|
| detalleRespuesta/lote/idLote | XQuery: data() | BANK_BATCH_ID |
| detalleRespuesta/lote/idClienteCore | XQuery: data() | CUSTOMER_ID |
| detalleRespuesta/lote/nombreCliente | XQuery: data() | CUSTOMER_NAME |
| detalleRespuesta/lote/idEstado | XQuery: data() | STATUS |
| detalleRespuesta/lote/nombreEstado | XQuery: data() | STATUS_DESC |
| detalleRespuesta/lote/optimista | Función optimista(): 'S'→'YES', 'N'→'NO' | OPTIMISTIC |
| detalleRespuesta/cuentas/cuenta/idProductoDebito | XQuery: data(), iteración | ACCOUNTS/ACCOUNT/DEBIT_ACCOUNT |
| detalleRespuesta/cuentas/cuenta/monto | XQuery: data(), iteración | ACCOUNTS/ACCOUNT/AMOUNT |
| detalleRespuesta/cuentas/cuenta/idMoneda | XQuery: data(), iteración | ACCOUNTS/ACCOUNT/CURRENCY |
| detalleRespuesta/pagos/pago/idMoneda | XQuery: data(), iteración | PAYMENTS/PAYMENT/CURRENCY |
| detalleRespuesta/pagos/pago/monto | XQuery: data(), iteración | PAYMENTS/PAYMENT/TOTAL_AMOUNT |
| detalleRespuesta/pagos/pago/tasaCambio | XQuery: data(), iteración | PAYMENTS/PAYMENT/EXCHANGE_RATE |
| detalleRespuesta/lote/montoTotal | XQuery: data() | TOTAL_AMOUNT |
| detalleRespuesta/lote/montoTotalError | XQuery: data() | TOTAL_AMOUNT_ERROR |
| detalleRespuesta/lote/cantidadTransacciones | XQuery: data() | NUMBER_OF_TRANSACTIONS |
| detalleRespuesta/lote/cantidadTransaccionesExito | XQuery: data() | NUMBER_OF_TRANSACTIONS_SUCCESS |
| detalleRespuesta/lote/cantidadTransaccionesError | XQuery: data() | NUMBER_OF_TRANSACTIONS_ERROR |
| detalleRespuesta/lote/fechaAplicacion | XQuery: data() | APPLICATION_DATE |
| detalleRespuesta/lote/infoProceso | XQuery: data() | PROCESS_INFO |

**Referencia**: `Middleware/v2/Resources/ConsultaEstadoLote/xq/consultaEstadoLoteGTOut.xqy`

---

### 3. MapeoErrores (Servicio OSB)

**Idéntico a HN01** - Ver documento HN01 para detalles completos.

---

## Reglas de Negocio Detectadas

### 1. Validación de Servicio Regional
**Ubicación**: Pipeline `ValidacionesGenerales_request`, stage `ValidacionServicioRegional`

**Idéntico a HN01** - Ver documento HN01 para detalles completos.

### 2. Conversión de Indicador Optimista
**Ubicación**: `consultaEstadoLoteGTOut.xqy`

**Lógica**:
```
SI optimista = 'S' (mayúscula, sin espacios) ENTONCES
    OPTIMISTIC = "YES"
SINO SI optimista = 'N' (mayúscula, sin espacios) ENTONCES
    OPTIMISTIC = "NO"
SINO
    OPTIMISTIC = "" (vacío)
FIN SI
```

**Fragmento de Código**:
```xquery
declare function optimista ($item as item())as xs:string{
    let $optimista:= fn-bea:trim(upper-case(fn:string($item/text())))
    return
        if($optimista = 'S') then (
            'YES'
        )        
        else if ($optimista = 'N') then (
            'NO'
        )
        else('')
};
```

**Diferencia con HN01**: En HN01 se compara con número (1), en GT01 se compara con string ('S'/'N') y se normaliza con trim y upper-case.

### 3. Iteración de Cuentas
**Ubicación**: `consultaEstadoLoteGTOut.xqy`

**Lógica**:
```
PARA CADA cuenta EN cuentas/cuenta HACER
    ACCOUNT.DEBIT_ACCOUNT = cuenta/idProductoDebito
    ACCOUNT.AMOUNT = cuenta/monto
    ACCOUNT.CURRENCY = cuenta/idMoneda
FIN PARA
```

**Fragmento de Código**:
```xquery
for $cuentas in $consultarLoteResponse/respuestaConsultaLote/detalleRespuesta/cuentas
return
    <ACCOUNTS>
        {
            for $cuenta in $cuentas/cuenta
            return
                <ACCOUNT>
                    {
                        for $idProductoDebito in $cuenta/idProductoDebito
                        return
                            <DEBIT_ACCOUNT>{ data($idProductoDebito) }</DEBIT_ACCOUNT>
                    }
                    {
                        for $monto in $cuenta/monto
                        return
                            <AMOUNT>{ data($monto) }</AMOUNT>
                    }
                    {
                        for $idMoneda in $cuenta/idMoneda
                        return
                            <CURRENCY>{ data($idMoneda) }</CURRENCY>
                    }
                </ACCOUNT>
        }
    </ACCOUNTS>
```

**Diferencia con HN01**: En HN01 se usan arrays paralelos con índices, en GT01 se itera directamente sobre elementos XML.

### 4. Validación de WSDL
**Ubicación**: Pipeline `GT01_ConsultaEstadoLote_request`, stage `FlujoEntrada`

**Lógica**:
```
Antes de invocar el servicio MTR:
    Validar request contra WSDL consultorLoteEndpoint
    SchemaElement: ser1:consultarLote
    Si falla validación, lanzar error
```

**Fragmento de Código**: Pipeline XML
```xml
<con3:validate>
    <con2:id>_ActionId-7468585982802995648--50635a02.1648edc728d.-7f0d</con2:id>
    <con3:wsdl ref="Middleware/v2/BusinessServices/MTR/consultorLote/wsdl/consultorLoteEndpoint"/>
    <con3:schemaElement xmlns:ser1="http://servicio.consultalotews.mtrpmsv.cidenet.com.co/">ser1:consultarLote</con3:schemaElement>
    <con3:varName>REQconsultarLote</con3:varName>
    <con3:location>
        <con2:xpathText>.</con2:xpathText>
    </con3:location>
</con3:validate>
```

### 5. Condicional de Respuesta Exitosa
**Ubicación**: Pipeline `GT01_ConsultaEstadoLote_response`, stage `FlujoSalida`

**Lógica**:
```
SI successIndicator = "SUCCESS" (mayúscula) ENTONCES
    Transformar body con consultaEstadoLoteGTOut.xqy
SINO
    body = <consultaEstadoLoteResponse/> (vacío)
FIN SI
```

**Fragmento de Código**: Pipeline XML
```xml
<con3:ifThenElse>
    <con2:id>_ActionId-7468585982802995648--50635a02.1648edc728d.-7fa1</con2:id>
    <con3:case>
        <con3:condition>
            <con2:xqueryText>fn:upper-case(fn:string($header/aut:ResponseHeader/successIndicator/text()))="SUCCESS"</con2:xqueryText>
        </con3:condition>
        <con3:actions>
            <con3:replace contents-only="true" varName="body">
                <con2:id>_ActionId-7468585982802995648--50635a02.1648edc728d.-7fa0</con2:id>
                <con3:expr>
                    <con2:xqueryTransform>
                        <con2:resource ref="Middleware/v2/Resources/ConsultaEstadoLote/xq/consultaEstadoLoteGTOut"/>
                        <con2:param name="consultarLoteResponse">
                            <con2:path>$RSPconsultarLote</con2:path>
                        </con2:param>
                    </con2:xqueryTransform>
                </con3:expr>
            </con3:replace>
        </con3:actions>
    </con3:case>
    <con3:default>
        <con3:replace varName="body" contents-only="true">
            <con2:id>_ActionId-7468585982802995648--50635a02.1648edc728d.-7f9e</con2:id>
            <con3:expr>
                <con2:xqueryText>&lt;pag:consultaEstadoLoteResponse/></con2:xqueryText>
            </con3:expr>
        </con3:replace>
    </con3:default>
</con3:ifThenElse>
```

### 6. Manejo de Errores en Response
**Ubicación**: Pipeline `ValidacionesGenerales_response`, stage `MapeoError`

**Idéntico a HN01** - Ver documento HN01 para detalles completos.

---

## Diferencias Clave con HN01

| Aspecto | HN01 | GT01 |
|---------|------|------|
| **Backend** | Base de Datos Oracle | Servicio SOAP MTR |
| **Validación de Acceso** | Sí (validaAccesoPMS) | No |
| **Estructura Request** | Flat (3 campos) | Anidada (solicitudConsultaLote) |
| **Estructura Response** | Flat con arrays Oracle | Anidada (cabeceraRespuesta + detalleRespuesta) |
| **Campo idBancoOrigen** | No usado | Incluido (GT01) |
| **Conversión Optimista** | 1/0 → YES/NO | S/N → YES/NO (con trim y upper-case) |
| **Iteración de Arrays** | Índices paralelos | Iteración directa sobre elementos |
| **Validación WSDL** | No | Sí (antes de invocar) |
| **Zona Horaria** | Ajustada con fn:adjust-dateTime-to-timezone | No ajustada |

---

## Notas Adicionales

- **Encoding**: Los archivos XQuery usan encoding `Cp1252` (Windows Latin-1)
- **XQuery Version**: `2004-draft`
- **Namespace Prefixes**: ns0 (autType), ns1 (MTR response), ns2 (MTR request), xf (función local)
- **Error Handling**: Todos los errores pasan por MapeoErrores para normalización
- **Logging**: Configurado en nivel "debug" en el pipeline
- **Monitoring**: Habilitado con intervalo de agregación de 360 segundos
- **Servicio Compartido**: GT01, NI01 y PA01 comparten el mismo endpoint MTR, solo difieren en el valor de `idBancoOrigen`
