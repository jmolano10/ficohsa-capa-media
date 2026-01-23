# Ejemplos y Mapeos - Honduras (HN01)

## Request OSB (Ejemplo JSON/XML)

### Request SOAP - Consulta de Préstamos (PTM)

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:RequestHeader>
         <Authentication>
            <UserName>usuario_test</UserName>
            <Password>password_test</Password>
         </Authentication>
         <Region>
            <SourceBank>HN01</SourceBank>
         </Region>
      </aut:RequestHeader>
   </soapenv:Header>
   <soapenv:Body>
      <con:consultaPasivosClienteRequest>
         <CUSTOMER_ID>12345678</CUSTOMER_ID>
         <LIABILITY_TYPE>PTM</LIABILITY_TYPE>
      </con:consultaPasivosClienteRequest>
   </soapenv:Body>
</soapenv:Envelope>
```

### Request SOAP - Consulta de Tarjetas de Crédito (TRC)

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:RequestHeader>
         <Authentication>
            <UserName>usuario_test</UserName>
            <Password>password_test</Password>
         </Authentication>
         <Region>
            <SourceBank>HN01</SourceBank>
         </Region>
      </aut:RequestHeader>
   </soapenv:Header>
   <soapenv:Body>
      <con:consultaPasivosClienteRequest>
         <CUSTOMER_ID>12345678</CUSTOMER_ID>
         <LIABILITY_TYPE>TRC</LIABILITY_TYPE>
      </con:consultaPasivosClienteRequest>
   </soapenv:Body>
</soapenv:Envelope>
```

### Request SOAP - Consulta de Líneas de Crédito (LCR)

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:RequestHeader>
         <Authentication>
            <UserName>usuario_test</UserName>
            <Password>password_test</Password>
         </Authentication>
         <Region>
            <SourceBank>HN01</SourceBank>
         </Region>
      </aut:RequestHeader>
   </soapenv:Header>
   <soapenv:Body>
      <con:consultaPasivosClienteRequest>
         <CUSTOMER_ID>12345678</CUSTOMER_ID>
         <LIABILITY_TYPE>LCR</LIABILITY_TYPE>
      </con:consultaPasivosClienteRequest>
   </soapenv:Body>
</soapenv:Envelope>
```

### Request SOAP - Consulta Todos los Productos (ALL)

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:RequestHeader>
         <Authentication>
            <UserName>usuario_test</UserName>
            <Password>password_test</Password>
         </Authentication>
         <Region>
            <SourceBank>HN01</SourceBank>
         </Region>
      </aut:RequestHeader>
   </soapenv:Header>
   <soapenv:Body>
      <con:consultaPasivosClienteRequest>
         <CUSTOMER_ID>12345678</CUSTOMER_ID>
         <LIABILITY_TYPE>ALL</LIABILITY_TYPE>
      </con:consultaPasivosClienteRequest>
   </soapenv:Body>
</soapenv:Envelope>
```

---

## Response OSB (Ejemplo JSON/XML)

### Response SOAP - Éxito con Préstamos

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
               <LIABILITY_NUMBER>1234567890</LIABILITY_NUMBER>
               <LIABILITY_CUST_NAME>JUAN PEREZ</LIABILITY_CUST_NAME>
               <LIABILITY_CURRENCY_1>HNL</LIABILITY_CURRENCY_1>
               <LIABILITY_PRINCIPAL_AMT_1>50000.00</LIABILITY_PRINCIPAL_AMT_1>
               <LIABILITY_INT_COM_AMT_1>2500.00</LIABILITY_INT_COM_AMT_1>
               <LIABILITY_TOTAL_AMT_1>52500.00</LIABILITY_TOTAL_AMT_1>
               <LIABILITY_CURRENCY_2>USD</LIABILITY_CURRENCY_2>
               <LIABILITY_PRINCIPAL_AMT_2>2000.00</LIABILITY_PRINCIPAL_AMT_2>
               <LIABILITY_INT_COM_AMT_2>100.00</LIABILITY_INT_COM_AMT_2>
               <LIABILITY_TOTAL_AMT_2>2100.00</LIABILITY_TOTAL_AMT_2>
               <LIABILITY_TOTAL_AMT>52500.00</LIABILITY_TOTAL_AMT>
               <LIABILITY_PAYMENT_DATE>20240315</LIABILITY_PAYMENT_DATE>
               <LIABILITY_SOURCE_BANK>HN01</LIABILITY_SOURCE_BANK>
               <LIABILITY_TOTAL_CANCELATION_AMT>52500.00</LIABILITY_TOTAL_CANCELATION_AMT>
            </consultaPasivosClienteResponseRecordType>
         </consultaPasivosClientePrestamosResponseType>
      </con:consultaPasivosClienteResponse>
   </soapenv:Body>
</soapenv:Envelope>
```

### Response SOAP - Éxito con Tarjetas de Crédito

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
   <soapenv:Header>
      <aut:ResponseHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
         <successIndicator>Success</successIndicator>
      </aut:ResponseHeader>
   </soapenv:Header>
   <soapenv:Body>
      <con:consultaPasivosClienteResponse xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes">
         <consultaPasivosClienteTCreditoResponseType>
            <consultaPasivosClienteResponseRecordType>
               <LIABILITY_TYPE>TRC</LIABILITY_TYPE>
               <LIABILITY_NUMBER>4111111111111111</LIABILITY_NUMBER>
               <LIABILITY_CUST_NAME>JUAN PEREZ</LIABILITY_CUST_NAME>
               <LIABILITY_CURRENCY_1>HNL</LIABILITY_CURRENCY_1>
               <LIABILITY_PRINCIPAL_AMT_1>15000.00</LIABILITY_PRINCIPAL_AMT_1>
               <LIABILITY_TOTAL_AMT_1>15000.00</LIABILITY_TOTAL_AMT_1>
               <LIABILITY_TOTAL_AMT>15000.00</LIABILITY_TOTAL_AMT>
               <LIABILITY_PAYMENT_DATE>20240320</LIABILITY_PAYMENT_DATE>
               <LIABILITY_SOURCE_BANK>HN01</LIABILITY_SOURCE_BANK>
               <LIABILITY_TOTAL_CANCELATION_AMT>15000.00</LIABILITY_TOTAL_CANCELATION_AMT>
            </consultaPasivosClienteResponseRecordType>
         </consultaPasivosClienteTCreditoResponseType>
      </con:consultaPasivosClienteResponse>
   </soapenv:Body>
</soapenv:Envelope>
```

### Response SOAP - Error

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/">
   <soapenv:Header>
      <aut:ResponseHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
         <successIndicator>ERROR</successIndicator>
         <messages>FICBCO0044: Servicio no disponible para la región</messages>
      </aut:ResponseHeader>
   </soapenv:Header>
   <soapenv:Body>
      <con:consultaPasivosClienteResponse xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaClientesTypes"/>
   </soapenv:Body>
</soapenv:Envelope>
```

---

## Cadenas de Conexión y Credenciales

### Base de Datos - Tarjetas de Crédito

**Conexión**: `eis/DB/ConnectionProxyMasterDataHN`
- **Tipo**: Oracle Database Adapter (JCA)
- **Esquema**: No especificado en archivos analizados
- **Stored Procedure**: `conDatoTarjetaClienteHN`
- **Package**: No especificado
- **Parámetros de Entrada**:
  - `Pais`: Código ISO3 del país (ej: "HND")
  - `NumCliente`: ID del cliente con padding de 19 caracteres con ceros a la izquierda

### Split-Join - Consulta de Préstamos

**Business Service**: `Middleware/Business_Resources/consultasCliente/consultaPasivosCliente/consultaPrestamos/ConsultaPrestamosCliente`
- **Tipo**: Split-Join (orquestación)
- **Operación**: `ConsultaPrestamosCliente`
- **Servicios Internos**: Múltiples servicios T24 y base de datos

### Base de Datos - Líneas de Crédito

**Conexión**: `eis/DB/ConnectionProxyABK`
- **Tipo**: Oracle Database Adapter (JCA)
- **Stored Procedure**: `consultaLineasCreditoCliente`
- **Parámetros de Entrada**:
  - `CUSTOMER_ID`: ID del cliente
  - `LIABILITY_TYPE`: Tipo de producto (LCR)

### Split-Join - Consulta ALL

**Business Service**: `Middleware/v2/BusinessServices/SJS/consultaPasivosCliente/biz/sjConsultaPasivosCliente`
- **Tipo**: Split-Join
- **Operación**: `consultaPasivosCliente`
- **Orquesta**: Consultas paralelas de PTM, TRC y LCR

---

## Mapeo de Entrada - Consulta de Tarjetas de Crédito

### Tabla de Mapeo: OSB → Stored Procedure

| Campo Origen (OSB) | Transformación/Script | Campo Destino (SP) | Ubicación Código |
|--------------------|----------------------|-------------------|------------------|
| `CUSTOMER_ID` | `fn-bea:pad-left($customerId, 19, '0')` | `NumCliente` | `conDatosTarjetaClienteHNIn.xq` línea 15 |
| `SourceBank` (header) | `convertirCodigoPais('OSB-ISO3', ...)` | `Pais` | `conDatosTarjetaClienteHNIn.xq` línea 14 |

**Regla de Negocio**:
- **RN-HN-TC-001**: El CUSTOMER_ID debe ser rellenado con ceros a la izquierda hasta completar 19 caracteres
- **RN-HN-TC-002**: El código de país debe ser convertido de formato OSB (HN01) a formato ISO3 (HND)
- **Ubicación**: `Middleware/v2/Resources/ConsultaPasivosCliente/xq/conDatosTarjetaClienteHNIn.xq`

---

## Mapeo de Salida - Consulta de Tarjetas de Crédito

### Tabla de Mapeo: Stored Procedure → OSB

| Campo Origen (SP) | Transformación/Script | Campo Destino (OSB) | Ubicación Código |
|-------------------|----------------------|---------------------|------------------|
| `CodigoError` | `if CodigoError = '-1' then 'Success'` | `successIndicator` (header) | `consultaPasivosClienteHeaderSPOut.xq` |
| `MensajeError` | Directo | `messages` (header) | `consultaPasivosClienteHeaderSPOut.xq` |
| `RowSet/Row/Column[@name='numtarjeta']` | Directo | `LIABILITY_NUMBER` | `consultaPasivosClienteSPOut.xq` |
| `RowSet/Row/Column[@name='cardholder_name']` | Directo | `LIABILITY_CUST_NAME` | `consultaPasivosClienteSPOut.xq` |
| `RowSet/Row/Column[@name='codMoneda']` | Directo | `LIABILITY_CURRENCY_1` | `consultaPasivosClienteSPOut.xq` |
| `RowSet/Row/Column[@name='MontoPrincipal']` | Directo | `LIABILITY_PRINCIPAL_AMT_1` | `consultaPasivosClienteSPOut.xq` |
| `RowSet/Row/Column[@name='MontoTotal']` | Directo | `LIABILITY_TOTAL_AMT_1` | `consultaPasivosClienteSPOut.xq` |
| `RowSet/Row/Column[@name='BalanceTotal']` | Directo | `LIABILITY_TOTAL_AMT` | `consultaPasivosClienteSPOut.xq` |
| `RowSet/Row/Column[@name='FechaMaximaPago']` | `fn-bea:dateTime-to-string-with-format("yyyyMMdd", ...)` | `LIABILITY_PAYMENT_DATE` | `consultaPasivosClienteSPOut.xq` |
| Constante "HN01" | Hardcoded | `LIABILITY_SOURCE_BANK` | `consultaPasivosClienteSPOut.xq` |
| `RowSet/Row/Column[@name='MontoCancelacion']` | Directo | `LIABILITY_TOTAL_CANCELATION_AMT` | `consultaPasivosClienteSPOut.xq` |
| `functionalityIndicator` | Variable de contexto | Controla visibilidad de datos | Pipeline HN01 |

**Reglas de Negocio**:
- **RN-HN-TC-OUT-001**: Si `CodigoError` es diferente de "-1", no se incluyen datos de tarjetas en la respuesta
- **RN-HN-TC-OUT-002**: La fecha de pago debe ser convertida de formato Date a String "yyyyMMdd"
- **RN-HN-TC-OUT-003**: El campo `LIABILITY_SOURCE_BANK` siempre debe ser "HN01" para Honduras
- **RN-HN-TC-OUT-004**: Si `functionalityIndicator` no es "ALL", se filtran ciertos campos según permisos del usuario
- **Ubicación**: `Middleware/v2/Resources/ConsultaPasivosCliente/xq/consultaPasivosClienteSPOut.xq`

---

## Mapeo de Entrada - Consulta de Líneas de Crédito

### Tabla de Mapeo: OSB → Stored Procedure

| Campo Origen (OSB) | Transformación/Script | Campo Destino (SP) | Ubicación Código |
|--------------------|----------------------|-------------------|------------------|
| `CUSTOMER_ID` | Directo | `CUSTOMER_ID` | `consultaLineasCreditoClienteIn.xq` |
| `LIABILITY_TYPE` | Directo | `LIABILITY_TYPE` | `consultaLineasCreditoClienteIn.xq` |

**Regla de Negocio**:
- **RN-HN-LCR-001**: La consulta de líneas de crédito solo está disponible en Honduras (HN01)
- **RN-HN-LCR-002**: El tipo de producto debe ser exactamente "LCR"
- **Ubicación**: `Middleware/v2/Resources/ConsultaPasivosCliente/xq/consultaLineasCreditoClienteIn.xq`

---

## Mapeo de Salida - Consulta de Líneas de Crédito

### Tabla de Mapeo: Stored Procedure → OSB

| Campo Origen (SP) | Transformación/Script | Campo Destino (OSB) | Ubicación Código |
|-------------------|----------------------|---------------------|------------------|
| `P_SUCCESSINDICATOR` | Directo | `successIndicator` (header) | Pipeline HN01 |
| `P_MESSAGES` | Directo | `messages` (header) | Pipeline HN01 |
| Datos de LCR | Transformación compleja | `consultaPasivosClienteLCRResponseType` | `consultaPasivosClienteLCROut.xq` |
| `sourceBank` variable | Directo | `LIABILITY_SOURCE_BANK` | `consultaPasivosClienteLCROut.xq` |

**Reglas de Negocio**:
- **RN-HN-LCR-OUT-001**: Si `P_SUCCESSINDICATOR` es "NO_RECORDS", se retorna respuesta vacía con mensaje
- **RN-HN-LCR-OUT-002**: Si `P_SUCCESSINDICATOR` es "-1" o "ERROR", se retorna error con mensaje de `P_MESSAGES`
- **RN-HN-LCR-OUT-003**: Solo si `P_SUCCESSINDICATOR` es "Success" se incluyen datos de líneas de crédito
- **Ubicación**: Pipeline `HN01_ConsultaPasivosCliente_response` y `consultaPasivosClienteLCROut.xq`

---

## Mapeo de Entrada - Consulta ALL (Split-Join)

### Tabla de Mapeo: OSB → Split-Join

| Campo Origen (OSB) | Transformación/Script | Campo Destino (SJ) | Ubicación Código |
|--------------------|----------------------|-------------------|------------------|
| `SourceBank` (header) | `convertirCodigoPais('OSB-ISO3', ...)` | `codigoPais` | `consultaPasivosClienteIn.xq` línea 18-24 |
| `CUSTOMER_ID` | Directo | `customerId` | `consultaPasivosClienteIn.xq` línea 20 |
| `RequestHeader` | Directo | `requestHeader1` | `consultaPasivosClienteIn.xq` línea 22 |
| Constante vacía | `''` | `legalId` | `consultaPasivosClienteIn.xq` línea 24 |

**Reglas de Negocio**:
- **RN-HN-ALL-001**: La consulta ALL ejecuta un Split-Join que orquesta consultas paralelas de PTM, TRC y LCR
- **RN-HN-ALL-002**: El código de país debe ser convertido a formato ISO3 antes de invocar el Split-Join
- **RN-HN-ALL-003**: El campo `legalId` se envía vacío en Honduras
- **Ubicación**: `Middleware/v2/Resources/ConsultaPasivosCliente/xq/consultaPasivosClienteIn.xq`

---

## Mapeo de Salida - Consulta ALL (Split-Join)

### Tabla de Mapeo: Split-Join → OSB

| Campo Origen (SJ) | Transformación/Script | Campo Destino (OSB) | Ubicación Código |
|-------------------|----------------------|---------------------|------------------|
| `sjConsultaPasivosClienteResponse` | Iteración sobre `consultaPrestamosResponse` | `consultaPasivosClientePrestamosResponseType` | `consultaPasivosClienteOut.xq` líneas 23-95 |
| `sjConsultaPasivosClienteResponse` | Iteración sobre `consultaTarjetaCreditoResponse` | `consultaPasivosClienteTCreditoResponseType` | `consultaPasivosClienteOut.xq` líneas 96-168 |
| `sjConsultaPasivosClienteResponse` | Iteración sobre `consultaLCRResponse` | `consultaPasivosClienteLCRResponseType` | `consultaPasivosClienteOut.xq` líneas 169-241 |
| `LIABILITY_PAYMENT_DATE` | `convertirStringFechaString($stringDate)` - Convierte `yyyy-MM-dd` a `yyyyMMdd` | `LIABILITY_PAYMENT_DATE` | `consultaPasivosClienteOut.xq` líneas 8-13, 143 |
| `sourceBank` variable | Directo | `LIABILITY_SOURCE_BANK` | `consultaPasivosClienteOut.xq` línea 227 |

**Reglas de Negocio**:
- **RN-HN-ALL-OUT-001**: Solo se incluyen secciones de respuesta si `overallSuccessInd` es "Success"
- **RN-HN-ALL-OUT-002**: Las fechas de pago de tarjetas de crédito deben ser convertidas de formato `yyyy-MM-dd` a `yyyyMMdd`
- **RN-HN-ALL-OUT-003**: Cada tipo de producto (PTM, TRC, LCR) se mapea a su sección correspondiente en la respuesta
- **RN-HN-ALL-OUT-004**: Si no hay éxito, se retorna respuesta con secciones vacías
- **Ubicación**: `Middleware/v2/Resources/ConsultaPasivosCliente/xq/consultaPasivosClienteOut.xq`

---

## Validación de Funcionalidad de Usuario

### Tabla de Mapeo: OSB → ValidaFuncionalidadUsuario

| Campo Origen (OSB) | Transformación/Script | Campo Destino (Validación) | Ubicación Código |
|--------------------|----------------------|---------------------------|------------------|
| `RequestHeader` | Directo | `requestHeader` | Pipeline HN01, línea ValidaFuncionalidadUsuario |
| Constante "SALDOS_PASIVOS" | Hardcoded | `functionality` | Pipeline HN01, línea ValidaFuncionalidadUsuario |

### Tabla de Mapeo: ValidaFuncionalidadUsuario → OSB

| Campo Origen (Validación) | Transformación/Script | Campo Destino (OSB) | Ubicación Código |
|---------------------------|----------------------|---------------------|------------------|
| `PV_CODIGO_ERROR` | `if = 'SUCCESS' then PV_VALOR else 'ALL'` | `functionalityIndicator` | Pipeline HN01 |
| `PV_VALOR` | Directo si SUCCESS | `functionalityIndicator` | Pipeline HN01 |

**Reglas de Negocio**:
- **RN-HN-FUNC-001**: La validación de funcionalidad solo se ejecuta en Honduras (HN01)
- **RN-HN-FUNC-002**: Si la validación falla, se asigna "ALL" como valor por defecto
- **RN-HN-FUNC-003**: El valor de `functionalityIndicator` controla qué información se muestra al usuario
- **RN-HN-FUNC-004**: La funcionalidad validada es siempre "SALDOS_PASIVOS"
- **Ubicación**: Pipeline `HN01_ConsultaPasivosCliente_request`

---

## Reglas de Negocio Adicionales

### RN-HN-VAL-001: Validación de Servicio Regional
**Descripción**: Antes de procesar cualquier solicitud, se valida que el servicio FICBCO0044 esté habilitado para la región HN01.
**Ubicación**: Pipeline `ValidacionesGenerales_request`, stage `ValidacionServicioRegional`
**Código**:
```xquery
if fn:string($respValidaServicioRegional/val:PV_CODIGO_ERROR/text()) != 'SUCCESS' then
    error con mensaje de PV_MENSAJE_ERROR
else
    continuar procesamiento
```

### RN-HN-VAL-002: Validación de Esquema XSD
**Descripción**: El request debe cumplir con el esquema XSD `consultaPasivosClienteTypes.xsd`
**Ubicación**: Pipeline `ValidacionesGenerales_request`, stage `ValidacionXSD`
**Campos Obligatorios**:
- `CUSTOMER_ID`: string no vacío
- `LIABILITY_TYPE`: string no vacío

### RN-HN-ERR-001: Manejo de Errores de Validación
**Descripción**: Si el error es BEA-382505 (error de validación XSD), se mapea usando `mapeoErrorValidate.xq`
**Ubicación**: Error Handler `_onErrorHandler`, stage `ManejoError`

### RN-HN-ERR-002: Mapeo de Errores Genéricos
**Descripción**: Todos los errores se mapean usando el servicio `MapeoErrores` con código de servicio FICBCO0044
**Ubicación**: Error Handler y Response Pipeline `MapeoError`

### RN-HN-PROD-001: Validación de Tipo de Producto
**Descripción**: Solo se soportan los tipos: PTM, TRC, LCR, ALL
**Ubicación**: Pipeline `HN01_ConsultaPasivosCliente_request`, stage `FlujoEntrada`
**Código**:
```xquery
if $product = "PTM" then consultar préstamos
else if $product = "TRC" then consultar tarjetas
else if $product = "ALL" then consultar todo
else if $product = "LCR" then consultar líneas de crédito
else error "PRODUCT NOT SUPPORTED"
```

### RN-HN-CONV-001: Conversión de Código de País
**Descripción**: El código de país se convierte de formato OSB (HN01) a formato ISO3 (HND)
**Ubicación**: Pipeline `HN01_ConsultaPasivosCliente_request`, asignación de variable `codigoPais`
**Transformación**: `Middleware/v2/Resources/Generales/xq/convertirCodigoPais`
**Parámetros**:
- `sentidoConversion`: 'OSB-ISO3'
- `codigoPais`: valor de `SourceBank` del header

---

## Dependencias de Servicios

### Servicio: ValidaServicioRegional
- **Ubicación**: `Middleware/v2/BusinessServices/ValidaServicioRegional/biz/ValidaServicioRegional_db`
- **Operación**: `ValidaServicioRegional`
- **Entrada**: `serviceId` = "FICBCO0044", `requestHeader`
- **Salida**: `PV_CODIGO_ERROR`, `PV_MENSAJE_ERROR`

### Servicio: ValidaFuncionalidadUsuario
- **Ubicación**: `Middleware/v2/BusinessServices/ValidaFuncionalidadUsuario/biz/ValidaFuncionalidadUsuario_db`
- **Operación**: `ValidaFuncionalidadUsuario`
- **Entrada**: `functionality` = "SALDOS_PASIVOS", `requestHeader`
- **Salida**: `PV_CODIGO_ERROR`, `PV_VALOR`

### Servicio: MapeoErrores
- **Ubicación**: `Middleware/v2/ProxyServices/MapeoErrores`
- **Operación**: `mapeoErrores`
- **Entrada**: `CODIGO_ERROR`, `MENSAJE_ERROR` (formato: "FICBCO0044$#$mensaje")
- **Salida**: `ResponseHeader` con error mapeado

### Servicio: ConsultaPrestamosCliente (Split-Join)
- **Ubicación**: `Middleware/Business_Resources/consultasCliente/consultaPasivosCliente/consultaPrestamos/ConsultaPrestamosCliente`
- **Operación**: `ConsultaPrestamosCliente`
- **Tipo**: Split-Join que orquesta múltiples servicios

### Servicio: sjConsultaPasivosCliente (Split-Join)
- **Ubicación**: `Middleware/v2/BusinessServices/SJS/consultaPasivosCliente/biz/sjConsultaPasivosCliente`
- **Operación**: `consultaPasivosCliente`
- **Tipo**: Split-Join para consulta ALL

---

**Nota**: Los ejemplos de request/response son ilustrativos. Los valores reales dependen de los datos en las bases de datos y la configuración específica del entorno.
