# Ejemplos y Mapeos - NI01 (Nicaragua)

## Nota Importante

La implementación de **NI01 (Nicaragua)** es **prácticamente idéntica** a **GT01 (Guatemala)**. 

Para detalles completos de:
- Estructura de Request/Response
- Servicios Dependientes
- Tablas de Mapeo
- Reglas de Negocio
- Fragmentos de Código

**Ver documento**: [03-EjemplosYMapeos-GT01.md](03-EjemplosYMapeos-GT01.md)

---

## Diferencias Específicas de NI01

### 1. Valor de idBancoOrigen

**GT01**:
```xml
<idBancoOrigen>GT01</idBancoOrigen>
```

**NI01**:
```xml
<idBancoOrigen>NI01</idBancoOrigen>
```

### 2. Archivos XQuery Específicos

| Propósito | GT01 | NI01 |
|-----------|------|------|
| Transformación Entrada | consultaEstadoLoteGTIn.xqy | consultaEstadoLoteNIIn.xqy |
| Transformación Salida | consultaEstadoLoteGTOut.xqy | consultaEstadoLoteNIOut.xqy |
| Transformación Header | consultaEstadoLoteGTHeaderOut.xqy | consultaEstadoLoteNIHeaderOut.xqy |

**Contenido**: Los archivos XQuery son idénticos en lógica, solo difieren en nombres de funciones y namespaces internos.

### 3. Pipeline Específico

**Pipeline Request**: `NI01_ConsultaEstadoLote_request`
**Pipeline Response**: `NI01_ConsultaEstadoLote_response`

**Lógica**: Idéntica a GT01

---

## Request OSB (Ejemplo SOAP/XML)

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/wsdl/soap/" 
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
            <DestinationBank>NI01</DestinationBank>
         </Region>
         <TransactionId>TXN-NI-20240115-001</TransactionId>
         <Channel>MOBILE</Channel>
      </aut:RequestHeader>
   </soapenv:Header>
   <soapenv:Body>
      <pag:consultaEstadoLote>
         <CUSTOMER_ID>9876543</CUSTOMER_ID>
         <BANK_BATCH_ID>45678</BANK_BATCH_ID>
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
         <BANK_BATCH_ID>45678</BANK_BATCH_ID>
         <CUSTOMER_ID>9876543</CUSTOMER_ID>
         <CUSTOMER_NAME>EMPRESA NICARAGUA LTDA</CUSTOMER_NAME>
         <STATUS>1</STATUS>
         <STATUS_DESC>PENDIENTE</STATUS_DESC>
         <OPTIMISTIC>YES</OPTIMISTIC>
         <ACCOUNTS>
            <ACCOUNT>
               <DEBIT_ACCOUNT>NI9876543210</DEBIT_ACCOUNT>
               <AMOUNT>180000.00</AMOUNT>
               <CURRENCY>NIO</CURRENCY>
            </ACCOUNT>
         </ACCOUNTS>
         <PAYMENTS>
            <PAYMENT>
               <CURRENCY>NIO</CURRENCY>
               <TOTAL_AMOUNT>180000.00</TOTAL_AMOUNT>
               <EXCHANGE_RATE>1.0</EXCHANGE_RATE>
            </PAYMENT>
         </PAYMENTS>
         <TOTAL_AMOUNT>180000.00</TOTAL_AMOUNT>
         <TOTAL_AMOUNT_ERROR>0.00</TOTAL_AMOUNT_ERROR>
         <NUMBER_OF_TRANSACTIONS>50</NUMBER_OF_TRANSACTIONS>
         <NUMBER_OF_TRANSACTIONS_SUCCESS>50</NUMBER_OF_TRANSACTIONS_SUCCESS>
         <NUMBER_OF_TRANSACTIONS_ERROR>0</NUMBER_OF_TRANSACTIONS_ERROR>
         <APPLICATION_DATE>2024-01-16T10:00:00</APPLICATION_DATE>
         <PROCESS_INFO>Lote pendiente de autorización</PROCESS_INFO>
      </pag:consultaEstadoLoteResponse>
   </soapenv:Body>
</soapenv:Envelope>
```

---

## Request Interno a MTR (Ejemplo)

```xml
<ns2:consultarLote xmlns:ns2="http://servicio.consultalotews.mtrpmsv.cidenet.com.co/">
   <solicitudConsultaLote>
      <fechaRegistroLote>2024-01-15T00:00:00</fechaRegistroLote>
      <idBancoOrigen>NI01</idBancoOrigen>
      <idCliente>9876543</idCliente>
      <idLote>45678</idLote>
   </solicitudConsultaLote>
</ns2:consultarLote>
```

**Diferencia con GT01**: Solo el valor de `<idBancoOrigen>` cambia de `GT01` a `NI01`.

---

## Response Interno de MTR (Ejemplo)

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
               <idMoneda>NIO</idMoneda>
               <idProductoDebito>NI9876543210</idProductoDebito>
               <monto>180000.00</monto>
            </cuenta>
         </cuentas>
         <lote>
            <cantidadTransacciones>50</cantidadTransacciones>
            <cantidadTransaccionesError>0</cantidadTransaccionesError>
            <cantidadTransaccionesExito>50</cantidadTransaccionesExito>
            <fechaAplicacion>2024-01-16T10:00:00</fechaAplicacion>
            <idClienteCore>9876543</idClienteCore>
            <idEstado>1</idEstado>
            <idLote>45678</idLote>
            <infoProceso>Lote pendiente de autorización</infoProceso>
            <montoTotal>180000.00</montoTotal>
            <montoTotalError>0.00</montoTotalError>
            <nombreCliente>EMPRESA NICARAGUA LTDA</nombreCliente>
            <nombreEstado>PENDIENTE</nombreEstado>
            <optimista>S</optimista>
         </lote>
         <pagos>
            <pago>
               <idMoneda>NIO</idMoneda>
               <monto>180000.00</monto>
               <tasaCambio>1.0</tasaCambio>
            </pago>
         </pagos>
      </detalleRespuesta>
   </respuestaConsultaLote>
</ns1:consultarLoteResponse>
```

**Estructura**: Idéntica a GT01, solo difieren los valores de datos (moneda NIO, nombres, etc.)

---

## Servicios Dependientes

### 1. ValidaServicioRegional
**Idéntico a GT01**, con `PV_REGION = NI01`

### 2. consultarLote (MTR)
**Idéntico a GT01**, con `idBancoOrigen = NI01`

### 3. MapeoErrores
**Idéntico a GT01**

---

## Reglas de Negocio

**Todas las reglas de negocio son idénticas a GT01**. Ver [03-EjemplosYMapeos-GT01.md](03-EjemplosYMapeos-GT01.md) para detalles completos.

---

## Archivos XQuery Específicos

### consultaEstadoLoteNIIn.xqy

**Ubicación**: `Middleware/v2/Resources/ConsultaEstadoLote/xq/consultaEstadoLoteNIIn.xqy`

**Contenido**: Idéntico a `consultaEstadoLoteGTIn.xqy`, solo difiere el namespace de la función:
```xquery
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaEstadoLote/xq/consultaEstadoLoteNIIn/";
```

### consultaEstadoLoteNIOut.xqy

**Ubicación**: `Middleware/v2/Resources/ConsultaEstadoLote/xq/consultaEstadoLoteNIOut.xqy`

**Contenido**: Idéntico a `consultaEstadoLoteGTOut.xqy`, solo difiere el namespace de la función:
```xquery
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaEstadoLote/xq/consultarEstadoLoteNIOut/";
```

### consultaEstadoLoteNIHeaderOut.xqy

**Ubicación**: `Middleware/v2/Resources/ConsultaEstadoLote/xq/consultaEstadoLoteNIHeaderOut.xqy`

**Contenido**: Idéntico a `consultaEstadoLoteGTHeaderOut.xqy`, solo difiere el namespace de la función:
```xquery
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaEstadoLote/xq/consultaEstadoLoteNIHeaderOut/";
```

---

## Comparación con Otras Regiones

| Aspecto | HN01 | GT01 | NI01 | PA01 |
|---------|------|------|------|------|
| **Backend** | Oracle DB | MTR SOAP | MTR SOAP | MTR SOAP |
| **idBancoOrigen** | N/A | GT01 | NI01 | PA01 |
| **Validación Acceso** | Sí | No | No | No |
| **XQuery** | Diferente | Similar | Similar | Similar |
| **Endpoint MTR** | N/A | Compartido | Compartido | Compartido |

---

## Notas Adicionales

- **Moneda Local**: NIO (Córdoba nicaragüense)
- **Encoding**: Cp1252 (Windows Latin-1)
- **XQuery Version**: 2004-draft
- **Servicio Compartido**: NI01 usa el mismo endpoint MTR que GT01 y PA01
- **Diferenciación**: La única diferencia técnica con GT01 es el valor de `idBancoOrigen`
- **Lógica de Negocio**: Completamente idéntica a GT01
