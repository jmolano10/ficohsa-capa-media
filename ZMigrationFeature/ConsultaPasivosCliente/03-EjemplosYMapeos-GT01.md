# Ejemplos y Mapeos - Guatemala (GT01)

## Request OSB

### Request SOAP - Consulta de Préstamos (PTM)

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:RequestHeader>
         <Authentication>
            <UserName>usuario_gt</UserName>
            <Password>password_gt</Password>
         </Authentication>
         <Region>
            <SourceBank>GT01</SourceBank>
         </Region>
      </aut:RequestHeader>
   </soapenv:Header>
   <soapenv:Body>
      <con:consultaPasivosClienteRequest>
         <CUSTOMER_ID>87654321</CUSTOMER_ID>
         <LIABILITY_TYPE>PTM</LIABILITY_TYPE>
      </con:consultaPasivosClienteRequest>
   </soapenv:Body>
</soapenv:Envelope>
```

---

## Response OSB

### Response SOAP - Éxito con Préstamos y Tarjetas

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
   <soapenv:Header>
      <aut:ResponseHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
         <successIndicator>Success</successIndicator>
      </aut:ResponseHeader>
   </soapenv:Header>
   <soapenv:Body>
      <con:consultaPasivosClienteResponse xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes">
         <consultaPasivosClientePrestamosResponseType>
            <consultaPasivosClienteResponseRecordType>
               <LIABILITY_TYPE>PTM</LIABILITY_TYPE>
               <LIABILITY_NUMBER>9876543210</LIABILITY_NUMBER>
               <LIABILITY_CUST_NAME>MARIA LOPEZ</LIABILITY_CUST_NAME>
               <LIABILITY_CURRENCY_1>GTQ</LIABILITY_CURRENCY_1>
               <LIABILITY_PRINCIPAL_AMT_1>75000.00</LIABILITY_PRINCIPAL_AMT_1>
               <LIABILITY_INT_COM_AMT_1>3750.00</LIABILITY_INT_COM_AMT_1>
               <LIABILITY_TOTAL_AMT_1>78750.00</LIABILITY_TOTAL_AMT_1>
               <LIABILITY_TOTAL_AMT>78750.00</LIABILITY_TOTAL_AMT>
               <LIABILITY_PAYMENT_DATE></LIABILITY_PAYMENT_DATE>
               <LIABILITY_SOURCE_BANK>PA01</LIABILITY_SOURCE_BANK>
               <LIABILITY_TOTAL_CANCELATION_AMT>78750.00</LIABILITY_TOTAL_CANCELATION_AMT>
            </consultaPasivosClienteResponseRecordType>
         </consultaPasivosClientePrestamosResponseType>
         <consultaPasivosClienteTCreditoResponseType>
            <consultaPasivosClienteResponseRecordType>
               <LIABILITY_TYPE>TRC</LIABILITY_TYPE>
               <LIABILITY_NUMBER>5200000000000000</LIABILITY_NUMBER>
               <LIABILITY_CUST_NAME>MARIA LOPEZ</LIABILITY_CUST_NAME>
               <LIABILITY_CURRENCY_1>GTQ</LIABILITY_CURRENCY_1>
               <LIABILITY_PRINCIPAL_AMT_1>25000.00</LIABILITY_PRINCIPAL_AMT_1>
               <LIABILITY_TOTAL_AMT_1>25000.00</LIABILITY_TOTAL_AMT_1>
               <LIABILITY_CURRENCY_2>USD</LIABILITY_CURRENCY_2>
               <LIABILITY_PRINCIPAL_AMT_2>1000.00</LIABILITY_PRINCIPAL_AMT_2>
               <LIABILITY_TOTAL_AMT_2>1000.00</LIABILITY_TOTAL_AMT_2>
               <LIABILITY_TOTAL_AMT>25000.00</LIABILITY_TOTAL_AMT>
               <LIABILITY_PAYMENT_DATE>2024-03-25</LIABILITY_PAYMENT_DATE>
               <LIABILITY_SOURCE_BANK>GT01</LIABILITY_SOURCE_BANK>
               <LIABILITY_TOTAL_CANCELATION_AMT>25000.00</LIABILITY_TOTAL_CANCELATION_AMT>
            </consultaPasivosClienteResponseRecordType>
         </consultaPasivosClienteTCreditoResponseType>
      </con:consultaPasivosClienteResponse>
   </soapenv:Body>
</soapenv:Envelope>
```

---

## Cadenas de Conexión

### Base de Datos - Préstamos
- **Conexión**: `eis/DB/ConnectionProxyAbanksGT`
- **Esquema**: Oracle AbanksGT
- **Package**: `OSB_K_CONLISTAPRESTAMOS`
- **Stored Procedure**: `TOPLEVEL$OSB_P_CON_LISTA_PRES`
- **Parámetros**: `CUSTOMER_ID`, `LIABILITY_TYPE`

### Base de Datos - Tarjetas de Crédito
- **Conexión**: `eis/DB/ConnectionProxyMasterDataGT`
- **Esquema**: Oracle MasterDataGT
- **Stored Procedure**: `conDatosTarjetaCliente`
- **Parámetros**: `Pais` (ISO3), `NumCliente` (19 caracteres con padding)

---

## Mapeo de Entrada - Préstamos

| Campo Origen (OSB) | Transformación | Campo Destino (SP) | Ubicación |
|--------------------|---------------|-------------------|-----------|
| `CUSTOMER_ID` | Directo | `CUSTOMER_ID` | `consultaPasivosClientePtmoGTIn.xq` |
| `LIABILITY_TYPE` | Directo | `LIABILITY_TYPE` | `consultaPasivosClientePtmoGTIn.xq` |

**Regla de Negocio**:
- **RN-GT-PTM-001**: Mapeo directo sin transformaciones adicionales
- **Ubicación**: `Middleware/v2/Resources/ConsultaPasivosCliente/xq/consultaPasivosClientePtmoGTIn.xq`

---

## Mapeo de Salida - Préstamos

| Campo Origen (SP) | Transformación | Campo Destino (OSB) | Ubicación |
|-------------------|---------------|---------------------|-----------|
| `ERROR_CODE` | `if = "SUCCESS"` | Incluir datos | `consultaPasivosClienteGTOut.xq` línea 13 |
| `LIABILITY_NUMBER/LIABILITY_NUMBER_ITEM[$i]` | Iteración | `LIABILITY_NUMBER` | `consultaPasivosClienteGTOut.xq` línea 18 |
| `LIABILITY_CUST_NAME/LIABILITY_CUST_NAME_ITEM[$i]` | Iteración | `LIABILITY_CUST_NAME` | `consultaPasivosClienteGTOut.xq` línea 19 |
| `LIABILITY_CURRENCY_1/LIABILITY_NUMBER_ITEM[$i]` | Iteración | `LIABILITY_CURRENCY_1` | `consultaPasivosClienteGTOut.xq` línea 20 |
| `LIABILITY_PRINCIPAL_AMT_1/LIABILITY_NUMBER_ITEM[$i]` | Iteración | `LIABILITY_PRINCIPAL_AMT_1` | `consultaPasivosClienteGTOut.xq` línea 21 |
| `LIABILITY_INT_COM_AMT_1/LIABILITY_NUMBER_ITEM[$i]` | Iteración | `LIABILITY_INT_COM_AMT_1` | `consultaPasivosClienteGTOut.xq` línea 22 |
| `LIABILITY_TOTAL_AMT_1/LIABILITY_NUMBER_ITEM[$i]` | Iteración | `LIABILITY_TOTAL_AMT_1` | `consultaPasivosClienteGTOut.xq` línea 23 |
| `LIABILITY_TOTAL_AMT_1/LIABILITY_NUMBER_ITEM[$i]` | Iteración | `LIABILITY_TOTAL_AMT` | `consultaPasivosClienteGTOut.xq` línea 24 |
| Constante "PA01" | Hardcoded (ERROR en código) | `LIABILITY_SOURCE_BANK` | `consultaPasivosClienteGTOut.xq` línea 26 |
| `LIABILITY_TOTAL_DEBT/LIABILITY_NUMBER_ITEM[$i]` | Iteración | `LIABILITY_TOTAL_CANCELATION_AMT` | `consultaPasivosClienteGTOut.xq` línea 27 |

**Reglas de Negocio**:
- **RN-GT-PTM-OUT-001**: Solo se incluyen préstamos si `ERROR_CODE` es "SUCCESS"
- **RN-GT-PTM-OUT-002**: Se itera sobre arrays paralelos usando índice `$i`
- **RN-GT-PTM-OUT-003**: **BUG DETECTADO**: `LIABILITY_SOURCE_BANK` está hardcoded como "PA01" en lugar de "GT01"
- **Ubicación**: `Middleware/v2/Resources/ConsultaPasivosCliente/xq/consultaPasivosClienteGTOut.xq`

---

## Mapeo de Entrada - Tarjetas de Crédito

| Campo Origen (OSB) | Transformación | Campo Destino (SP) | Ubicación |
|--------------------|---------------|-------------------|-----------|
| `CUSTOMER_ID` | `fn-bea:pad-left($customerId, 19, '0')` | `NumCliente` | `conDatosTarjetaClienteGTIn.xq` línea 15 |
| `SourceBank` | `convertirCodigoPais('OSB-ISO3', ...)` | `Pais` | `conDatosTarjetaClienteGTIn.xq` línea 14 |

**Reglas de Negocio**:
- **RN-GT-TC-001**: CUSTOMER_ID debe tener padding de 19 caracteres con ceros a la izquierda
- **RN-GT-TC-002**: Código de país convertido de GT01 a GTM (ISO3)
- **Ubicación**: `Middleware/v2/Resources/ConsultaPasivosCliente/xq/conDatosTarjetaClienteGTIn.xq`

---

## Mapeo de Salida - Tarjetas de Crédito

| Campo Origen (SP) | Transformación | Campo Destino (OSB) | Ubicación |
|-------------------|---------------|---------------------|-----------|
| `CodigoError` | `if = "-1"` | Incluir datos | `consultaPasivosClienteGTOut.xq` línea 33 |
| `RowSet/Row/Column[@name='numtarjeta']` | `distinct-values(...)` + iteración | Agrupación por tarjeta | `consultaPasivosClienteGTOut.xq` línea 35 |
| `RowSet/Row[TipoOrg='BASE']/Column[@name='numtarjeta']` | `xs:long($cardNumber)` | `LIABILITY_NUMBER` | `consultaPasivosClienteGTOut.xq` línea 41 |
| `RowSet/Row[TipoOrg='BASE']/Column[@name='cardholder_name']` | Directo | `LIABILITY_CUST_NAME` | `consultaPasivosClienteGTOut.xq` línea 42 |
| `RowSet/Row[TipoOrg='BASE']/Column[@name='codMoneda']` | Directo | `LIABILITY_CURRENCY_1` | `consultaPasivosClienteGTOut.xq` línea 43 |
| `RowSet/Row[TipoOrg='BASE']/Column[@name='MontoPrincipal']` | Directo | `LIABILITY_PRINCIPAL_AMT_1` | `consultaPasivosClienteGTOut.xq` línea 44 |
| `RowSet/Row[TipoOrg='BASE']/Column[@name='MontoTotal']` | Directo | `LIABILITY_TOTAL_AMT_1` | `consultaPasivosClienteGTOut.xq` línea 45 |
| `RowSet/Row[TipoOrg='ALT']/Column[@name='codMoneda']` | Iteración condicional | `LIABILITY_CURRENCY_2` | `consultaPasivosClienteGTOut.xq` línea 48 |
| `RowSet/Row[TipoOrg='ALT']/Column[@name='MontoPrincipal']` | Iteración condicional | `LIABILITY_PRINCIPAL_AMT_2` | `consultaPasivosClienteGTOut.xq` línea 49 |
| `RowSet/Row[TipoOrg='ALT']/Column[@name='MontoTotal']` | Iteración condicional | `LIABILITY_TOTAL_AMT_2` | `consultaPasivosClienteGTOut.xq` línea 50 |
| `RowSet/Row[TipoOrg='BASE']/Column[@name='BalanceTotal']` | Directo | `LIABILITY_TOTAL_AMT` | `consultaPasivosClienteGTOut.xq` línea 53 |
| `RowSet/Row[TipoOrg='BASE']/Column[@name='FechaMaximaPago']` | `fn-bea:dateTime-to-string-with-format("yyyy-MM-dd", ...)` | `LIABILITY_PAYMENT_DATE` | `consultaPasivosClienteGTOut.xq` línea 56 |
| Constante "GT01" | Hardcoded | `LIABILITY_SOURCE_BANK` | `consultaPasivosClienteGTOut.xq` línea 59 |
| `RowSet/Row[TipoOrg='BASE']/Column[@name='MontoCancelacion']` | Condicional | `LIABILITY_TOTAL_CANCELATION_AMT` | `consultaPasivosClienteGTOut.xq` línea 62 |

**Reglas de Negocio**:
- **RN-GT-TC-OUT-001**: Solo se incluyen tarjetas si `CodigoError` es "-1"
- **RN-GT-TC-OUT-002**: Se agrupan tarjetas por número usando `distinct-values`
- **RN-GT-TC-OUT-003**: Para cada tarjeta, se busca fila BASE para moneda principal
- **RN-GT-TC-OUT-004**: Se busca fila ALT para moneda alternativa (si existe)
- **RN-GT-TC-OUT-005**: Fecha convertida a formato "yyyy-MM-dd"
- **RN-GT-TC-OUT-006**: Campos opcionales solo se incluyen si no están vacíos
- **Ubicación**: `Middleware/v2/Resources/ConsultaPasivosCliente/xq/consultaPasivosClienteGTOut.xq`

---

## Reglas de Negocio Específicas

### RN-GT-ALL-001: Consulta ALL
**Descripción**: Cuando `LIABILITY_TYPE` es "ALL", se ejecutan ambas consultas (PTM y TRC) secuencialmente
**Ubicación**: Pipeline `GT01_ConsultaPasivosCliente_request`, stage `FlujoEntrada`
**Código**:
```xquery
if fn:string($product) = "ALL" then
    ejecutar consultaPasivosCliente_db (préstamos)
    ejecutar conDatosTarjetaCliente_db (tarjetas)
```

### RN-GT-ERR-001: Manejo de Errores
**Descripción**: Los errores se construyen en el header de respuesta basados en códigos de error de SP
**Ubicación**: `consultaPasivosClienteGTHeaderOut.xq`
**Lógica**:
- Si `ERROR_CODE` (préstamos) != "SUCCESS" O `CodigoError` (tarjetas) != "-1": ERROR
- Si ambos son "NO RECORDS": NO_RECORDS
- Si al menos uno tiene datos: Success

### RN-GT-CONV-001: Conversión de Código de País
**Descripción**: GT01 → GTM (ISO3)
**Ubicación**: Pipeline `GT01_ConsultaPasivosCliente_request`
**Transformación**: `Middleware/v2/Resources/Generales/xq/convertirCodigoPais`

---

## Dependencias de Servicios

### Servicio: consultaPasivosCliente_db (Préstamos)
- **Ubicación**: `Middleware/v2/BusinessServices/ABKGT/consultaPasivosCliente/biz/consultaPasivosCliente_db`
- **Tipo**: JCA Database Adapter
- **Operación**: `consultaPasivosCliente`
- **Retry**: 1 intento, 30 segundos de intervalo

### Servicio: conDatosTarjetaCliente_db (Tarjetas)
- **Ubicación**: `Middleware/v2/BusinessServices/MasterDataGT/conDatosTarjetaCliente/biz/conDatosTarjetaCliente_db`
- **Tipo**: JCA Database Adapter
- **Operación**: `conDatosTarjetaCliente`
- **Retry**: Configuración heredada

---

**Nota Importante**: Se detectó un bug en el código donde `LIABILITY_SOURCE_BANK` para préstamos está hardcoded como "PA01" en lugar de "GT01". Esto debe corregirse en la migración.
