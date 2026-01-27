# Ejemplos y Mapeos - NI01 (Nicaragua)

## Request OSB

```xml
<con:consultaActivosClienteRequest>
   <CUSTOMER_ID>400123789</CUSTOMER_ID>
   <ASSET_TYPE>ALL</ASSET_TYPE>
</con:consultaActivosClienteRequest>
```

**Header**:
```xml
<aut:RequestHeader>
   <Authentication>
      <UserName>USUARIO_NI</UserName>
      <Password>PASSWORD123</Password>
   </Authentication>
   <Region>
      <SourceBank>NI01</SourceBank>
      <DestinationBank>NI01</DestinationBank>
   </Region>
</aut:RequestHeader>
```

## Response OSB

```xml
<con:consultaActivosClienteResponse>
   <consultaActivosClienteAhorrosResponseType>
      <SUCCESS_INDICATOR>Success</SUCCESS_INDICATOR>
      <consultaActivosClienteResponseRecordType>
         <ASSET_TYPE>AHO</ASSET_TYPE>
         <ASSET_NUMBER>NI1234567890123</ASSET_NUMBER>
         <ASSET_NAME>CUENTA AHORRO BASICA</ASSET_NAME>
         <ASSET_CURRENCY>NIO</ASSET_CURRENCY>
         <ASSET_TOTAL_BALANCE>35000.50</ASSET_TOTAL_BALANCE>
         <ASSET_RESERVE_BALANCE>1500.25</ASSET_RESERVE_BALANCE>
         <ASSET_LOCKED_BALANCE>500.00</ASSET_LOCKED_BALANCE>
         <ASSET_VISA_FLOATING_BALANCE>100.00</ASSET_VISA_FLOATING_BALANCE>
         <ASSET_AVAILABLE_BALANCE>32900.25</ASSET_AVAILABLE_BALANCE>
         <INTERNATIONAL_ACCOUNT_NUMBER>NI79FICO0000001234567890123</INTERNATIONAL_ACCOUNT_NUMBER>
      </consultaActivosClienteResponseRecordType>
   </consultaActivosClienteAhorrosResponseType>
   <consultaActivosClienteCorrienteResponseType>
      <SUCCESS_INDICATOR>Success</SUCCESS_INDICATOR>
      <consultaActivosClienteResponseRecordType>
         <ASSET_TYPE>CHQ</ASSET_TYPE>
         <ASSET_NUMBER>NI9876543210987</ASSET_NUMBER>
         <ASSET_NAME>CUENTA CORRIENTE COMERCIAL</ASSET_NAME>
         <ASSET_CURRENCY>NIO</ASSET_CURRENCY>
         <ASSET_TOTAL_BALANCE>75000.00</ASSET_TOTAL_BALANCE>
         <ASSET_RESERVE_BALANCE>3000.00</ASSET_RESERVE_BALANCE>
         <ASSET_LOCKED_BALANCE>0.00</ASSET_LOCKED_BALANCE>
         <ASSET_VISA_FLOATING_BALANCE>0.00</ASSET_VISA_FLOATING_BALANCE>
         <ASSET_AVAILABLE_BALANCE>72000.00</ASSET_AVAILABLE_BALANCE>
         <INTERNATIONAL_ACCOUNT_NUMBER>NI79FICO0000009876543210987</INTERNATIONAL_ACCOUNT_NUMBER>
      </consultaActivosClienteResponseRecordType>
   </consultaActivosClienteCorrienteResponseType>
   <consultaActivosClienteDepositosResponseType>
      <SUCCESS_INDICATOR>No Records</SUCCESS_INDICATOR>
   </consultaActivosClienteDepositosResponseType>
   <consultaActivosClientePensionesResponseType/>
</con:consultaActivosClienteResponse>
```

## Cadenas de Conexión

### Web Service Cobis CTS

**Business Service**: `activos` (CTS)
- **Ruta**: `Middleware/v2/BusinessServices/CTS/activos/biz/activos.biz`
- **Operación**: `OpConsultaActivosCliente`
- **Protocolo**: SOAP
- **Namespace Request**: `http://service.srvaplcobisactivos.ecobis.cobiscorp`
- **Namespace DTO**: `http://dto.srvaplcobisentidades.ecobis.cobiscorp`
- **Tipo**: Web Service Externo (Cobis Core Transaction System)

**No utiliza base de datos directamente**. Toda la lógica reside en el servicio Cobis CTS.

## Request Interno a Cobis CTS

```xml
<ns2:opConsultaActivosClienteSolicitud xmlns:ns0="http://dto.srvaplcobisentidades.ecobis.cobiscorp"
                                       xmlns:ns2="http://service.srvaplcobisactivos.ecobis.cobiscorp">
   <ns0:contextoTransaccional>
      <ns0:codCanalOriginador>1</ns0:codCanalOriginador>
   </ns0:contextoTransaccional>
   <ns0:cliente>
      <ns0:codCliente>400123789</ns0:codCliente>
      <ns0:valIdCliente>USUARIO_NI</ns0:valIdCliente>
   </ns0:cliente>
   <ns0:producto>
      <ns0:codTipoProducto>ALL</ns0:codTipoProducto>
   </ns0:producto>
</ns2:opConsultaActivosClienteSolicitud>
```

## Response Interno de Cobis CTS

```xml
<ns1:opConsultaActivosClienteRespuesta xmlns:ns0="http://dto.srvaplcobisentidades.ecobis.cobiscorp"
                                       xmlns:ns1="http://service.srvaplcobisactivos.ecobis.cobiscorp">
   <ns0:contextoRespuesta>
      <ns0:codTipoRespuesta>0</ns0:codTipoRespuesta>
      <ns0:valMensajeRespuesta>Consulta exitosa</ns0:valMensajeRespuesta>
   </ns0:contextoRespuesta>
   <ns0:activos>
      <ns0:cuenta>
         <ns0:codCuentaHabiente>NI1234567890123</ns0:codCuentaHabiente>
         <ns0:codTipoProducto>AHO</ns0:codTipoProducto>
         <ns0:valTipoProducto>CUENTA AHORRO BASICA</ns0:valTipoProducto>
         <ns0:moneda>
            <ns0:valSimboloMoneda>NIO</ns0:valSimboloMoneda>
         </ns0:moneda>
         <ns0:valSaldoTotal>35000.50</ns0:valSaldoTotal>
         <ns0:valMontoBloqueado>500.00</ns0:valMontoBloqueado>
         <ns0:valSaldoDisponible>32900.25</ns0:valSaldoDisponible>
         <ns0:codigoIBAN>NI79FICO0000001234567890123</ns0:codigoIBAN>
      </ns0:cuenta>
      <ns0:cuentaReserva>
         <ns0:montoReserva>1500.25</ns0:montoReserva>
      </ns0:cuentaReserva>
      <ns0:valBalanceFlotante>100.00</ns0:valBalanceFlotante>
   </ns0:activos>
   <ns0:activos>
      <ns0:cuenta>
         <ns0:codCuentaHabiente>NI9876543210987</ns0:codCuentaHabiente>
         <ns0:codTipoProducto>CTE</ns0:codTipoProducto>
         <ns0:valTipoProducto>CUENTA CORRIENTE COMERCIAL</ns0:valTipoProducto>
         <ns0:moneda>
            <ns0:valSimboloMoneda>NIO</ns0:valSimboloMoneda>
         </ns0:moneda>
         <ns0:valSaldoTotal>75000.00</ns0:valSaldoTotal>
         <ns0:valMontoBloqueado>0.00</ns0:valMontoBloqueado>
         <ns0:valSaldoDisponible>72000.00</ns0:valSaldoDisponible>
         <ns0:codigoIBAN>NI79FICO0000009876543210987</ns0:codigoIBAN>
      </ns0:cuenta>
      <ns0:cuentaReserva>
         <ns0:montoReserva>3000.00</ns0:montoReserva>
      </ns0:cuentaReserva>
      <ns0:valBalanceFlotante>0.00</ns0:valBalanceFlotante>
   </ns0:activos>
</ns1:opConsultaActivosClienteRespuesta>
```

## Tablas de Mapeo de Entrada

### Mapeo: OSB → Cobis CTS

| Campo Origen (OSB) | Transformación | Campo Destino (Cobis) |
|-------------------|----------------|----------------------|
| Constante "1" | Directo | contextoTransaccional/codCanalOriginador |
| consultaActivosClienteRequest/CUSTOMER_ID | data() | cliente/codCliente |
| header/Authentication/UserName | data() | cliente/valIdCliente |
| consultaActivosClienteRequest/ASSET_TYPE | data() | producto/codTipoProducto |

**XQuery**: `Middleware/v2/Resources/ConsultaActivosCliente/xq/consultaActivosClienteNIIn.xq`

**Código XQuery**:
```xquery
<ns2:opConsultaActivosClienteSolicitud>
   <ns0:contextoTransaccional>
      <ns0:codCanalOriginador>1</ns0:codCanalOriginador>
   </ns0:contextoTransaccional>
   <ns0:cliente>
      <ns0:codCliente>{ data($consultaActivosClienteRequest/CUSTOMER_ID) }</ns0:codCliente>
      <ns0:valIdCliente>{ $USER_ID }</ns0:valIdCliente>
   </ns0:cliente>
   <ns0:producto>
      <ns0:codTipoProducto>{ data($consultaActivosClienteRequest/ASSET_TYPE) }</ns0:codTipoProducto>
   </ns0:producto>
</ns2:opConsultaActivosClienteSolicitud>
```

## Tablas de Mapeo de Salida

### Mapeo: Cobis CTS → OSB (Ahorros - AHO)

| Campo Origen (Cobis) | Transformación | Campo Destino (OSB) |
|---------------------|----------------|---------------------|
| contextoRespuesta/codTipoRespuesta | mensajeRespuesta() | SUCCESS_INDICATOR |
| Constante "AHO" | Directo | ASSET_TYPE |
| activos/cuenta/codCuentaHabiente | data() | ASSET_NUMBER |
| activos/cuenta/valTipoProducto | data() | ASSET_NAME |
| activos/cuenta/moneda/valSimboloMoneda | data() | ASSET_CURRENCY |
| activos/cuenta/valSaldoTotal | fn:round-half-to-even(data(), 2) | ASSET_TOTAL_BALANCE |
| activos/cuentaReserva/montoReserva | fn:round-half-to-even(data(), 2) | ASSET_RESERVE_BALANCE |
| activos/cuenta/valMontoBloqueado | fn:round-half-to-even(data(), 2) | ASSET_LOCKED_BALANCE |
| activos/valBalanceFlotante | fn:round-half-to-even(data(), 2) | ASSET_VISA_FLOATING_BALANCE |
| activos/cuenta/valSaldoDisponible | fn:round-half-to-even(data(), 2) | ASSET_AVAILABLE_BALANCE |
| activos/cuenta/codigoIBAN | data() | INTERNATIONAL_ACCOUNT_NUMBER |

**Filtro**: `activos[cuenta/codTipoProducto = 'AHO']`

### Mapeo: Cobis CTS → OSB (Corrientes - CTE → CHQ)

| Campo Origen (Cobis) | Transformación | Campo Destino (OSB) |
|---------------------|----------------|---------------------|
| Constante "CHQ" | Transformación de CTE | ASSET_TYPE |
| (Resto de campos idénticos a Ahorros) | | |

**Filtro**: `activos[cuenta/codTipoProducto = 'CTE']`

### Mapeo: Cobis CTS → OSB (Depósitos - PFI → DEP)

| Campo Origen (Cobis) | Transformación | Campo Destino (OSB) |
|---------------------|----------------|---------------------|
| Constante "DEP" | Transformación de PFI | ASSET_TYPE |
| (Resto de campos idénticos a Ahorros) | | |

**Filtro**: `activos[cuenta/codTipoProducto = 'PFI']`

**XQuery**: `Middleware/v2/Resources/ConsultaActivosCliente/xq/consultaActivosClienteNIOut.xq`

## Reglas de Negocio

### Regla 1: Invocación Única a Cobis

**Ubicación**: `ConsultaActivosCliente.proxy` - Pipeline `NI01_ConsultaActivosCliente_request`

**Descripción**: Una sola llamada al servicio Cobis devuelve todos los tipos de activos.

```xml
<con2:wsCallout>
   <con2:service ref="Middleware/v2/BusinessServices/CTS/activos/biz/activos"/>
   <con2:operation>OpConsultaActivosCliente</con2:operation>
   <con2:request>
      <con2:body>$REQOpConsultaActivosCliente</con2:body>
   </con2:request>
   <con2:response>
      <con2:body>RSPOpConsultaActivosCliente</con2:body>
   </con2:response>
</con2:wsCallout>
```

### Regla 2: Transformación de Tipos de Producto

**Ubicación**: `consultaActivosClienteNIOut.xq`

**Descripción**: Cobis usa códigos internos que se transforman a códigos OSB estándar.

| Código Cobis | Código OSB | Descripción |
|-------------|-----------|-------------|
| AHO | AHO | Ahorro (sin cambio) |
| CTE | CHQ | Corriente → Cheques |
| PFI | DEP | Plazo Fijo → Depósito |

**Código XQuery**:
```xquery
for $activos in $opConsultaActivosClienteRespuesta/ns0:activos[ns0:cuenta/ns0:codTipoProducto = 'CTE']
return
   <ns3:consultaActivosClienteResponseRecordType>
      <ASSET_TYPE>CHQ</ASSET_TYPE>
      <!-- Resto de campos -->
   </ns3:consultaActivosClienteResponseRecordType>
```

### Regla 3: Redondeo de Montos

**Ubicación**: `consultaActivosClienteNIOut.xq`

**Descripción**: Todos los montos se redondean a 2 decimales usando round-half-to-even.

```xquery
<ASSET_TOTAL_BALANCE>{ fn:round-half-to-even(data($activos/ns0:cuenta/ns0:valSaldoTotal), 2) }</ASSET_TOTAL_BALANCE>
<ASSET_RESERVE_BALANCE>{ fn:round-half-to-even(data($activos/ns0:cuentaReserva/ns0:montoReserva), 2) }</ASSET_RESERVE_BALANCE>
<ASSET_LOCKED_BALANCE>{ fn:round-half-to-even(data($activos/ns0:cuenta/ns0:valMontoBloqueado), 2) }</ASSET_LOCKED_BALANCE>
<ASSET_VISA_FLOATING_BALANCE>{ fn:round-half-to-even(data($activos/ns0:valBalanceFlotante), 2) }</ASSET_VISA_FLOATING_BALANCE>
<ASSET_AVAILABLE_BALANCE>{ fn:round-half-to-even(data($activos/ns0:cuenta/ns0:valSaldoDisponible), 2) }</ASSET_AVAILABLE_BALANCE>
```

### Regla 4: Función de Mensaje de Respuesta

**Ubicación**: `consultaActivosClienteNIOut.xq`

**Descripción**: Evalúa el código de respuesta de Cobis (0 = éxito).

```xquery
declare function mensajeRespuesta($successIndicator as xs:string, $registros as item()*) as xs:string {
  if ((upper-case($successIndicator) = 'SUCCESS' or $successIndicator = '0') and count($registros) > 0) then
    'Success'
  else if (((upper-case($successIndicator) = 'SUCCESS' or $successIndicator = '0') and count($registros) = 0) or upper-case($successIndicator) = 'NO RECORDS') then
    'No Records'
  else
    'Error'
};
```

### Regla 5: Campo Único - IBAN

**Ubicación**: `consultaActivosClienteNIOut.xq`

**Descripción**: Nicaragua es la única región que incluye el código IBAN internacional.

```xquery
<INTERNATIONAL_ACCOUNT_NUMBER>{data($activos/ns0:cuenta/ns0:codigoIBAN)}</INTERNATIONAL_ACCOUNT_NUMBER>
```

### Regla 6: Validación de Esquema

**Ubicación**: `ConsultaActivosCliente.proxy` - Pipeline `NI01_ConsultaActivosCliente_request`

**Descripción**: Valida el request contra el esquema XSD de Cobis.

```xml
<con2:validate>
   <con2:schema ref="Middleware/v2/BusinessServices/CTS/activos/xsd/services"/>
   <con2:schemaElement xmlns:ser1="http://service.srvaplcobisactivos.ecobis.cobiscorp">ser1:opConsultaActivosClienteSolicitud</con2:schemaElement>
   <con2:varName>REQOpConsultaActivosCliente</con2:varName>
</con2:validate>
```

### Regla 7: Manejo de Respuesta Vacía

**Ubicación**: `ConsultaActivosCliente.proxy` - Pipeline `NI01_ConsultaActivosCliente_response`

**Descripción**: Si hay error, devuelve response vacío.

```xml
<con2:ifThenElse>
   <con2:case>
      <con2:condition>
         <con1:xqueryText>fn:upper-case(fn:string($header/aut:ResponseHeader/successIndicator/text()))!="SUCCESS"</con1:xqueryText>
      </con2:condition>
      <con2:actions>
         <con2:replace varName="body" contents-only="true">
            <con2:expr>
               <con1:xqueryText>&lt;con:consultaActivosClienteResponse/></con1:xqueryText>
            </con2:expr>
         </con2:replace>
      </con2:actions>
   </con2:case>
</con2:ifThenElse>
```

## Características Únicas de Nicaragua

1. **Servicio Externo**: Única región que usa web service externo (Cobis CTS)
2. **IBAN**: Única región que devuelve código IBAN internacional
3. **Redondeo Explícito**: Todos los montos se redondean a 2 decimales
4. **Transformación de Códigos**: CTE→CHQ, PFI→DEP
5. **Sin Validación de Usuario**: No invoca ValidaFuncionalidadUsuario
6. **Código de Éxito**: Cobis usa "0" en lugar de "SUCCESS"

---

**Nota**: Nicaragua tiene la implementación más simple pero depende completamente de la disponibilidad del servicio externo Cobis CTS.
