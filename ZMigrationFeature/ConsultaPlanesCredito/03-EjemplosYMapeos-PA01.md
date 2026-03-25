# Ejemplos de Request/Response y Mapeo de Datos - PA01 (Panamá)

## Request OSB (Ejemplo SOAP/XML)

### SOAP Envelope Completo
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Header>
    <aut:RequestHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
      <Authentication>
        <UserName>userPA01</UserName>
        <Password>passwordPA01</Password>
      </Authentication>
      <Region>
        <SourceBank>PA01</SourceBank>
        <DestinationBank>PA01</DestinationBank>
      </Region>
      <TransactionId>TXN-PA-20241201-001</TransactionId>
      <Timestamp>2024-12-01T10:30:00</Timestamp>
    </aut:RequestHeader>
  </soap:Header>
  <soap:Body>
    <con:consultaPlanesCredito xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaPlanesCreditoTypes">
      <ACCOUNT_NUMBER>3782123456789012</ACCOUNT_NUMBER>
      <ORG>PA01</ORG>
    </con:consultaPlanesCredito>
  </soap:Body>
</soap:Envelope>
```

### Body Request
```xml
<con:consultaPlanesCredito xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaPlanesCreditoTypes">
  <ACCOUNT_NUMBER>3782123456789012</ACCOUNT_NUMBER>
  <ORG>PA01</ORG>
</con:consultaPlanesCredito>
```

## Response OSB (Ejemplo SOAP/XML)

### SOAP Envelope Completo
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Header>
    <aut:ResponseHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
      <successIndicator>Success</successIndicator>
      <messages></messages>
      <TransactionId>TXN-PA-20241201-001</TransactionId>
      <Timestamp>2024-12-01T10:30:05</Timestamp>
    </aut:ResponseHeader>
  </soap:Header>
  <soap:Body>
    <con:consultaPlanesCreditoResponse xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaPlanesCreditoTypes">
      <CREDIT_PLANS>
        <CREDIT_PLAN>
          <ORG>PA01</ORG>
          <ACCOUNT>3782123456789012</ACCOUNT>
          <SEQ_NUMBER>001</SEQ_NUMBER>
          <LOGO>AMEX</LOGO>
          <PLAN_NUMBER>PA001</PLAN_NUMBER>
          <PAY_MINIMUM>220.00</PAY_MINIMUM>
          <TYPE_PLAN>REVOLVING</TYPE_PLAN>
          <INT_RATE>25.50</INT_RATE>
          <INT_RATE_BASE>19.75</INT_RATE_BASE>
          <CURRENT_BALANCE>4200.80</CURRENT_BALANCE>
          <DATE_PLAN>20241201</DATE_PLAN>
          <ACRD_INT>78.25</ACRD_INT>
          <DELAYS_ACRD_INT>12.50</DELAYS_ACRD_INT>
          <ACCUMULATED_DELAYS_INT>3.75</ACCUMULATED_DELAYS_INT>
        </CREDIT_PLAN>
        <CREDIT_PLAN>
          <ORG>PA01</ORG>
          <ACCOUNT>3782123456789012</ACCOUNT>
          <SEQ_NUMBER>002</SEQ_NUMBER>
          <LOGO>VISA</LOGO>
          <PLAN_NUMBER>PA002</PLAN_NUMBER>
          <PAY_MINIMUM>165.00</PAY_MINIMUM>
          <TYPE_PLAN>INSTALLMENT</TYPE_PLAN>
          <INT_RATE>21.25</INT_RATE>
          <INT_RATE_BASE>17.50</INT_RATE_BASE>
          <CURRENT_BALANCE>2750.25</CURRENT_BALANCE>
          <DATE_PLAN>20241118</DATE_PLAN>
          <ACRD_INT>42.75</ACRD_INT>
          <DELAYS_ACRD_INT>0.00</DELAYS_ACRD_INT>
          <ACCUMULATED_DELAYS_INT>0.00</ACCUMULATED_DELAYS_INT>
        </CREDIT_PLAN>
      </CREDIT_PLANS>
    </con:consultaPlanesCreditoResponse>
  </soap:Body>
</soap:Envelope>
```

## Requests/Responses Internos a Servicios Dependientes

### 1. Consulta Ruta Regional

#### Request a consultaRutaRegional
```xml
<con1:InputParameters xmlns:con1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaRutaRegional">
  <con1:PV_VERSION>V2</con1:PV_VERSION>
  <con1:PV_ID_SERVICIO>FICBCO0321</con1:PV_ID_SERVICIO>
  <con1:PV_OPERACION>consultaPlanesCredito</con1:PV_OPERACION>
  <con1:PV_REGION>PA01</con1:PV_REGION>
  <con1:PV_USUARIO>userPA01</con1:PV_USUARIO>
</con1:InputParameters>
```

#### Response de consultaRutaRegional
```xml
<con1:OutputParameters xmlns:con1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaRutaRegional">
  <con1:PV_CODIGO_ERROR>SUCCESS</con1:PV_CODIGO_ERROR>
  <con1:PV_MENSAJE_ERROR></con1:PV_MENSAJE_ERROR>
  <con1:PV_UBICACION>Middleware/v2/ProxyServices/ConsultaPlanesCreditoPA</con1:PV_UBICACION>
</con1:OutputParameters>
```

### 2. Consulta Base de Datos (MasterDataPA)

#### Request a conDatosPlanes_db
```xml
<con1:InputParameters xmlns:con1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatosPlanes">
  <con1:PV_CUENTA>3782123456789012</con1:PV_CUENTA>
  <con1:PV_ORG>PA01</con1:PV_ORG>
  <con1:PV_CODIGO_PAIS>PAN</con1:PV_CODIGO_PAIS>
</con1:InputParameters>
```

#### Response de conDatosPlanes_db
```xml
<con1:OutputParameters xmlns:con1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatosPlanes">
  <con1:CodigoError>-1</con1:CodigoError>
  <con1:MensajeError></con1:MensajeError>
  <con1:RowSet>
    <con1:Row>
      <con1:Column name="org">PA01</con1:Column>
      <con1:Column name="cuenta">3782123456789012</con1:Column>
      <con1:Column name="numseq">001</con1:Column>
      <con1:Column name="logo">AMEX</con1:Column>
      <con1:Column name="numplan">PA001</con1:Column>
      <con1:Column name="total_due">220.00</con1:Column>
      <con1:Column name="tipo_plan">REVOLVING</con1:Column>
      <con1:Column name="int_rate">25.50</con1:Column>
      <con1:Column name="int_rat1_base">19.75</con1:Column>
      <con1:Column name="balanceactual">4200.80</con1:Column>
      <con1:Column name="fecplan">2024-12-01T00:00:00</con1:Column>
      <con1:Column name="acrd_int">78.25</con1:Column>
      <con1:Column name="mora_acrd_int">12.50</con1:Column>
      <con1:Column name="d2ps_mora_int_per_diem">3.75</con1:Column>
    </con1:Row>
    <con1:Row>
      <con1:Column name="org">PA01</con1:Column>
      <con1:Column name="cuenta">3782123456789012</con1:Column>
      <con1:Column name="numseq">002</con1:Column>
      <con1:Column name="logo">VISA</con1:Column>
      <con1:Column name="numplan">PA002</con1:Column>
      <con1:Column name="total_due">165.00</con1:Column>
      <con1:Column name="tipo_plan">INSTALLMENT</con1:Column>
      <con1:Column name="int_rate">21.25</con1:Column>
      <con1:Column name="int_rat1_base">17.50</con1:Column>
      <con1:Column name="balanceactual">2750.25</con1:Column>
      <con1:Column name="fecplan">2024-11-18T00:00:00</con1:Column>
      <con1:Column name="acrd_int">42.75</con1:Column>
      <con1:Column name="mora_acrd_int">0.00</con1:Column>
      <con1:Column name="d2ps_mora_int_per_diem">0.00</con1:Column>
    </con1:Row>
  </con1:RowSet>
</con1:OutputParameters>
```

## Cadenas de Conexión y Credenciales

### Base de Datos
- **Nombre de Conexión**: eis/DB/ConnectionTarjetas
- **Nombre de Base de Datos**: ConnectionTarjetas (configurado en WebLogic)
- **Stored Procedure**: dbo.OSBConDatoPlanes
- **Esquema**: dbo
- **Package**: dbo

### Endpoint WSDL
- **Endpoint**: Local transport (sin URI HTTP específica)
- **Operación**: consultaPlanesCredito
- **Namespace**: http://www.ficohsa.com.hn/middleware.services/consultaPlanesCreditoPS/

## Tablas de Mapeo de Entrada

### Mapeo OSB Request → consultaRutaRegional
| Campo Origen (OSB) | Transformación/Script | Campo Destino (consultaRutaRegional) |
|-------------------|----------------------|-------------------------------------|
| Header/Region/SourceBank | Directo | PV_REGION |
| Constante "V2" | Literal | PV_VERSION |
| Constante "FICBCO0321" | Literal | PV_ID_SERVICIO |
| $operation | Variable OSB | PV_OPERACION |
| Header/Authentication/UserName | Directo | PV_USUARIO |

### Mapeo OSB Request → conDatosPlanes
| Campo Origen (OSB) | Transformación/Script | Campo Destino (conDatosPlanes) |
|-------------------|----------------------|-------------------------------|
| ACCOUNT_NUMBER | Directo | PV_CUENTA |
| ORG | Directo | PV_ORG |
| Header/Region/SourceBank | convertirCodigoPais("OSB-ISO3") | PV_CODIGO_PAIS |

**Transformación convertirCodigoPais:**
```xquery
convertirCodigoPais("OSB-ISO3", "PA01") → "PAN"
```

## Tablas de Mapeo de Salida

### Mapeo conDatosPlanes Response → OSB Response
| Campo Origen (conDatosPlanes) | Transformación/Script | Campo Destino (OSB) |
|------------------------------|----------------------|-------------------|
| Column[@name='org'] | data($org) | ORG |
| Column[@name='cuenta'] | data($account) | ACCOUNT |
| Column[@name='numseq'] | data($seqNumber) | SEQ_NUMBER |
| Column[@name='logo'] | data($logo) | LOGO |
| Column[@name='numplan'] | data($planNumber) | PLAN_NUMBER |
| Column[@name='total_due'] | data($payMinimum) | PAY_MINIMUM |
| Column[@name='tipo_plan'] | data($type) | TYPE_PLAN |
| Column[@name='int_rate'] | data($intRate) | INT_RATE |
| Column[@name='int_rat1_base'] | data($intRateBase) | INT_RATE_BASE |
| Column[@name='balanceactual'] | data($currentBalance) | CURRENT_BALANCE |
| Column[@name='fecplan'] | fn-bea:dateTime-to-string-with-format('yyyyMMdd', $datePlan) | DATE_PLAN |
| Column[@name='acrd_int'] | data($acrdInt) | ACRD_INT |
| Column[@name='mora_acrd_int'] | data($delaysAcrdInt) | DELAYS_ACRD_INT |
| Column[@name='d2ps_mora_int_per_diem'] | data($accumulatedDelaysInt) | ACCUMULATED_DELAYS_INT |

**Transformación de Fecha:**
```xquery
if($datePlan != '') then
  fn-bea:dateTime-to-string-with-format('yyyyMMdd', $datePlan)
else()
```

## Reglas de Negocio Detectadas

### 1. Validación de Entrada
- **Ubicación**: ConsultaPlanesCreditoPA.proxy - Stage "FlujoEntrada"
- **Regla**: Validación de esquema XSD obligatoria
- **Implementación**: 
```xml
<con2:validate>
  <con2:schema ref="Middleware/v2/BusinessServices/MasterDataPA/conDatosPlanes/xsd/conDatosPlanes_sp"/>
  <con3:schemaElement>con2:InputParameters</con3:schemaElement>
</con2:validate>
```

### 2. Conversión de Código de País
- **Ubicación**: conDatosPlanesPAIn.xq
- **Regla**: Conversión de código OSB a ISO3
- **Implementación**:
```xquery
convertirCodigoPais("OSB-ISO3", string($header/aut:RequestHeader/Region/SourceBank/text()))
```

### 3. Validación de Respuesta de BD
- **Ubicación**: ConsultaPlanesCreditoPA.proxy - Response Transform
- **Regla**: errorCode != '-1' indica éxito
- **Implementación**:
```xquery
if($errorCode != '-1') then
  string($RSPconDatosPlanes/con1:MensajeError/text())
else('')
```

### 4. Formateo de Fecha
- **Ubicación**: consultaPlanesCreditoPAOut.xq
- **Regla**: Fechas se formatean a YYYYMMDD solo si no están vacías
- **Implementación**:
```xquery
if($datePlan != '') then
  <DATE_PLAN>{fn-bea:dateTime-to-string-with-format('yyyyMMdd', $datePlan)}</DATE_PLAN>
else()
```

### 5. Manejo de Errores Estándar
- **Ubicación**: ConsultaPlanesCreditoPA.proxy - Response Stage
- **Regla**: successIndicator = "ERROR" cuando hay validationMessage
- **Implementación**:
```xml
<aut:ResponseHeader>
  <successIndicator>ERROR</successIndicator>
  <messages>{$validationMessage}</messages>
</aut:ResponseHeader>
```

### 6. Construcción de Response Header Exitoso
- **Ubicación**: ConsultaPlanesCreditoPA.proxy - Response Stage
- **Regla**: successIndicator = "Success" cuando validationMessage está vacío
- **Implementación**:
```xml
<aut:ResponseHeader>
  <successIndicator>Success</successIndicator>
</aut:ResponseHeader>
```

### 7. Manejo de Errores en Error Handler
- **Ubicación**: ConsultaPlanesCreditoPA.proxy - Error Handler
- **Regla**: Errores estándar con messageId = -1
- **Implementación**:
```xml
<aut:ResponseHeader>
  <messageId>-1</messageId>
  <successIndicator>ERROR</successIndicator>
  <messages>{string($fault/ctx:reason/text())}</messages>
</aut:ResponseHeader>
```

## Diferencias Específicas de PA01

### 1. Transport Configuration
- **Transport Provider**: Local (no HTTP)
- **Endpoint**: Sin URI específica
- **SOAP Selector**: SOAP action (no SOAP body)

### 2. Configuración de Binding
```xml
<con2:selector type="SOAP action"/>
```

### 3. Transformación XQuery Específica
PA01 utiliza una estructura ligeramente diferente en la transformación:
```xquery
let $OutputParameters := $outputParameters
return
  <ns0:consultaPlanesCreditoResponse>
```

En lugar del acceso directo utilizado por otras regiones.

### 4. Namespace en Validación
Utiliza namespace específico con prefijo diferente:
```xml
<con3:schemaElement xmlns:con2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatosPlanes">
  con2:InputParameters
</con3:schemaElement>
```

### 5. Conversión de Código de País
Utiliza `string()` explícito en la conversión:
```xquery
string($header/aut:RequestHeader/Region/SourceBank/text())
```

### 6. Variables de Response
- Utiliza `$RSPconDatosPlanes` (minúscula)
- Namespace `con1` para el response de base de datos

### 7. Manejo de Errores Estándar
- No incluye código de error específico en successIndicator
- Utiliza "ERROR" literal en caso de fallo
- Incluye `messageId` con valor -1 en error handler

### 8. Formateo de Fecha Específico
Utiliza espaciado diferente en la transformación de fecha:
```xquery
fn-bea:dateTime-to-string-with-format('yyyyMMdd', $datePlan)
```

## Consideraciones Especiales para PA01

### 1. Transport Local
Similar a NI01, PA01 utiliza transport local, sugiriendo que este proxy se invoca internamente desde otros servicios.

### 2. SOAP Action Selector
La configuración de SOAP action selector requiere que los clientes especifiquen la acción SOAP correcta en el header.

### 3. Variable Intermedia en Transformación
El uso de `let $OutputParameters := $outputParameters` sugiere una práctica de programación más defensiva para evitar referencias múltiples al parámetro original.

### 4. Configuración de Base de Datos Estándar
A diferencia de NI01, PA01 no especifica SchemaName, utilizando la configuración estándar de base de datos.

### 5. Namespace Consistency
PA01 mantiene consistencia en el uso de namespaces con otras regiones, excepto por las diferencias menores en los prefijos utilizados en las transformaciones.