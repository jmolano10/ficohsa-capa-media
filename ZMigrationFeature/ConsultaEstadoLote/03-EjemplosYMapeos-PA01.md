# Ejemplos y Mapeos - PA01 (Panamá)

## Nota Importante

La implementación de **PA01 (Panamá)** es **prácticamente idéntica** a **GT01 (Guatemala)** y **NI01 (Nicaragua)**.

Para detalles completos de:
- Estructura de Request/Response
- Servicios Dependientes
- Tablas de Mapeo
- Reglas de Negocio
- Fragmentos de Código

**Ver documento**: [03-EjemplosYMapeos-GT01.md](03-EjemplosYMapeos-GT01.md)

---

## Diferencias Específicas de PA01

### 1. Valor de idBancoOrigen

**GT01**:
```xml
<idBancoOrigen>GT01</idBancoOrigen>
```

**PA01**:
```xml
<idBancoOrigen>PA01</idBancoOrigen>
```

### 2. Archivos XQuery Específicos

| Propósito | GT01 | PA01 |
|-----------|------|------|
| Transformación Entrada | consultaEstadoLoteGTIn.xqy | consultaEstadoLotePAIn.xqy |
| Transformación Salida | consultaEstadoLoteGTOut.xqy | consultaEstadoLotePAOut.xqy |
| Transformación Header | consultaEstadoLoteGTHeaderOut.xqy | consultaEstadoLotePAHeaderOut.xqy |

**Contenido**: Los archivos XQuery son idénticos en lógica, solo difieren en nombres de funciones y namespaces internos.

### 3. Pipeline Específico

**Pipeline Request**: `PA01_ConsultaEstadoLote_request`
**Pipeline Response**: `PA01_ConsultaEstadoLote_response`

**Lógica**: Idéntica a GT01 y NI01

---

## Request OSB (Ejemplo SOAP/XML)

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/wsdl/soap/" 
                  xmlns:pag="http://www.ficohsa.com.hn/middleware.services/pagosMasivosTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:RequestHeader>
         <Authentication>
            <UserName>USUARIO_PA</UserName>
            <Password>********</Password>
         </Authentication>
         <Region>
            <SourceBank>PA01</SourceBank>
            <DestinationBank>PA01</DestinationBank>
         </Region>
         <TransactionId>TXN-PA-20240115-001</TransactionId>
         <Channel>ATM</Channel>
      </aut:RequestHeader>
   </soapenv:Header>
   <soapenv:Body>
      <pag:consultaEstadoLote>
         <CUSTOMER_ID>5432109</CUSTOMER_ID>
         <BANK_BATCH_ID>34567</BANK_BATCH_ID>
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
         <BANK_BATCH_ID>34567</BANK_BATCH_ID>
         <CUSTOMER_ID>5432109</CUSTOMER_ID>
         <CUSTOMER_NAME>CORPORACION PANAMA S.A.</CUSTOMER_NAME>
         <STATUS>4</STATUS>
         <STATUS_DESC>APLICADO</STATUS_DESC>
         <OPTIMISTIC>NO</OPTIMISTIC>
         <ACCOUNTS>
            <ACCOUNT>
               <DEBIT_ACCOUNT>PA5432109876</DEBIT_ACCOUNT>
               <AMOUNT>320000.00</AMOUNT>
               <CURRENCY>USD</CURRENCY>
            </ACCOUNT>
            <ACCOUNT>
               <DEBIT_ACCOUNT>PA9876543210</DEBIT_ACCOUNT>
               <AMOUNT>80000.00</AMOUNT>
               <CURRENCY>PAB</CURRENCY>
            </ACCOUNT>
         </ACCOUNTS>
         <PAYMENTS>
            <PAYMENT>
               <CURRENCY>USD</CURRENCY>
               <TOTAL_AMOUNT>320000.00</TOTAL_AMOUNT>
               <EXCHANGE_RATE>1.0</EXCHANGE_RATE>
            </PAYMENT>
            <PAYMENT>
               <CURRENCY>PAB</CURRENCY>
               <TOTAL_AMOUNT>80000.00</TOTAL_AMOUNT>
               <EXCHANGE_RATE>1.0</EXCHANGE_RATE>
            </PAYMENT>
         </PAYMENTS>
         <TOTAL_AMOUNT>400000.00</TOTAL_AMOUNT>
         <TOTAL_AMOUNT_ERROR>0.00</TOTAL_AMOUNT_ERROR>
         <NUMBER_OF_TRANSACTIONS>120</NUMBER_OF_TRANSACTIONS>
         <NUMBER_OF_TRANSACTIONS_SUCCESS>120</NUMBER_OF_TRANSACTIONS_SUCCESS>
         <NUMBER_OF_TRANSACTIONS_ERROR>0</NUMBER_OF_TRANSACTIONS_ERROR>
         <APPLICATION_DATE>2024-01-16T11:00:00</APPLICATION_DATE>
         <PROCESS_INFO>Lote aplicado exitosamente</PROCESS_INFO>
      </pag:consultaEstadoLoteResponse>
   </soapenv:Body>
</soapenv:Envelope>
```

---

## Request Interno a MTR (Ejemplo)

```xml
<ns0:consultarLote xmlns:ns0="http://servicio.consultalotews.mtrpmsv.cidenet.com.co/">
   <solicitudConsultaLote>
      <fechaRegistroLote>2024-01-15T00:00:00</fechaRegistroLote>
      <idBancoOrigen>PA01</idBancoOrigen>
      <idCliente>5432109</idCliente>
      <idLote>34567</idLote>
   </solicitudConsultaLote>
</ns0:consultarLote>
```

**Diferencia con GT01/NI01**: Solo el valor de `<idBancoOrigen>` cambia a `PA01`.

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
               <idMoneda>USD</idMoneda>
               <idProductoDebito>PA5432109876</idProductoDebito>
               <monto>320000.00</monto>
            </cuenta>
            <cuenta>
               <idMoneda>PAB</idMoneda>
               <idProductoDebito>PA9876543210</idProductoDebito>
               <monto>80000.00</monto>
            </cuenta>
         </cuentas>
         <lote>
            <cantidadTransacciones>120</cantidadTransacciones>
            <cantidadTransaccionesError>0</cantidadTransaccionesError>
            <cantidadTransaccionesExito>120</cantidadTransaccionesExito>
            <fechaAplicacion>2024-01-16T11:00:00</fechaAplicacion>
            <idClienteCore>5432109</idClienteCore>
            <idEstado>4</idEstado>
            <idLote>34567</idLote>
            <infoProceso>Lote aplicado exitosamente</infoProceso>
            <montoTotal>400000.00</montoTotal>
            <montoTotalError>0.00</montoTotalError>
            <nombreCliente>CORPORACION PANAMA S.A.</nombreCliente>
            <nombreEstado>APLICADO</nombreEstado>
            <optimista>N</optimista>
         </lote>
         <pagos>
            <pago>
               <idMoneda>USD</idMoneda>
               <monto>320000.00</monto>
               <tasaCambio>1.0</tasaCambio>
            </pago>
            <pago>
               <idMoneda>PAB</idMoneda>
               <monto>80000.00</monto>
               <tasaCambio>1.0</tasaCambio>
            </pago>
         </pagos>
      </detalleRespuesta>
   </respuestaConsultaLote>
</ns1:consultarLoteResponse>
```

**Estructura**: Idéntica a GT01 y NI01, solo difieren los valores de datos (monedas USD/PAB, nombres, etc.)

---

## Servicios Dependientes

### 1. ValidaServicioRegional
**Idéntico a GT01 y NI01**, con `PV_REGION = PA01`

### 2. consultarLote (MTR)
**Idéntico a GT01 y NI01**, con `idBancoOrigen = PA01`

### 3. MapeoErrores
**Idéntico a GT01 y NI01**

---

## Reglas de Negocio

**Todas las reglas de negocio son idénticas a GT01 y NI01**. Ver [03-EjemplosYMapeos-GT01.md](03-EjemplosYMapeos-GT01.md) para detalles completos.

---

## Archivos XQuery Específicos

### consultaEstadoLotePAIn.xqy

**Ubicación**: `Middleware/v2/Resources/ConsultaEstadoLote/xq/consultaEstadoLotePAIn.xqy`

**Contenido**: Idéntico a `consultaEstadoLoteGTIn.xqy`, solo difiere el namespace de la función:
```xquery
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaEstadoLote/xq/consultaEstadoLotePAIn/";
```

**Nota**: Este archivo tiene encoding `Cp1252` explícito en la declaración:
```xquery
xquery version "2004-draft" encoding "Cp1252";
```

### consultaEstadoLotePAOut.xqy

**Ubicación**: `Middleware/v2/Resources/ConsultaEstadoLote/xq/consultaEstadoLotePAOut.xqy`

**Contenido**: Idéntico a `consultaEstadoLoteGTOut.xqy`, solo difiere el namespace de la función:
```xquery
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaEstadoLote/xq/consultaEstadoLotePAOut/";
```

**Nota**: Este archivo tiene encoding `Cp1252` explícito en la declaración.

### consultaEstadoLotePAHeaderOut.xqy

**Ubicación**: `Middleware/v2/Resources/ConsultaEstadoLote/xq/consultaEstadoLotePAHeaderOut.xqy`

**Contenido**: Idéntico a `consultaEstadoLoteGTHeaderOut.xqy`, solo difiere el namespace de la función:
```xquery
declare namespace xf = "http://tempuri.org/Middleware/v2/Resources/ConsultaEstadoLote/xq/consultaEstadoLotePAHeaderOut/";
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
| **Encoding Explícito** | No | No | No | Sí |

---

## Características Específicas de Panamá

### 1. Monedas Soportadas
- **USD**: Dólar estadounidense (moneda oficial)
- **PAB**: Balboa panameño (paridad 1:1 con USD)

### 2. Encoding Explícito
Los archivos XQuery de PA01 declaran explícitamente el encoding:
```xquery
xquery version "2004-draft" encoding "Cp1252";
```

Mientras que GT01 y NI01 no lo declaran explícitamente (usan el default).

### 3. Estados de Lote Comunes
- **1**: PENDIENTE
- **2**: PROCESADO
- **3**: AUTORIZADO
- **4**: APLICADO (común en PA01 por procesos bancarios)
- **5**: RECHAZADO
- **6**: CANCELADO

---

## Notas Adicionales

- **Monedas Locales**: USD y PAB (paridad 1:1)
- **Encoding**: Cp1252 (Windows Latin-1) - **Explícito en declaración**
- **XQuery Version**: 2004-draft
- **Servicio Compartido**: PA01 usa el mismo endpoint MTR que GT01 y NI01
- **Diferenciación**: La única diferencia técnica con GT01/NI01 es:
  1. Valor de `idBancoOrigen` (PA01)
  2. Declaración explícita de encoding en XQuery
- **Lógica de Negocio**: Completamente idéntica a GT01 y NI01
- **Zona Horaria**: UTC-5 (EST, sin cambio horario de verano)

---

## Recomendaciones Específicas para PA01

### Consolidación de Código
Dado que PA01, GT01 y NI01 son prácticamente idénticos, se recomienda:

1. **Crear XQuery Genérico Parametrizado**
   ```xquery
   declare function xf:consultaEstadoLoteIn(
       $requestHeader as element(ns0:RequestHeader),
       $consultaEstadoLote as element(ns1:consultaEstadoLote),
       $region as xs:string
   ) as element(ns2:consultarLote) {
       <ns2:consultarLote>
           <solicitudConsultaLote>
               <idBancoOrigen>{ $region }</idBancoOrigen>
               <!-- resto del mapeo -->
           </solicitudConsultaLote>
       </ns2:consultarLote>
   };
   ```

2. **Unificar Pipelines**
   - Crear un pipeline genérico para GT01/NI01/PA01
   - Parametrizar por región
   - Reducir duplicación de código

3. **Externalizar Configuración**
   - Mover endpoint MTR a archivo de configuración
   - Permitir cambios sin redespliegue
   - Facilitar gestión de ambientes (DEV/QA/PROD)
