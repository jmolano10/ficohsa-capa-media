# Ejemplos de Request/Response y Mapeo de Datos - NI01 (Nicaragua)

## Request OSB (Ejemplo SOAP/XML)

### SOAP Envelope Completo
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Header>
    <aut:RequestHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
      <Authentication>
        <UserName>userNI01</UserName>
        <Password>passwordNI01</Password>
      </Authentication>
      <Region>
        <SourceBank>NI01</SourceBank>
        <DestinationBank>NI01</DestinationBank>
      </Region>
      <TransactionId>TXN-NI-20241201-001</TransactionId>
      <Timestamp>2024-12-01T10:30:00</Timestamp>
    </aut:RequestHeader>
  </soap:Header>
  <soap:Body>
    <con:consultaPlanesCredito xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaPlanesCreditoTypes">
      <ACCOUNT_NUMBER>4111234567890123</ACCOUNT_NUMBER>
      <ORG>NI01</ORG>
    </con:consultaPlanesCredito>
  </soap:Body>
</soap:Envelope>
```

### Body Request
```xml
<con:consultaPlanesCredito xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaPlanesCreditoTypes">
  <ACCOUNT_NUMBER>4111234567890123</ACCOUNT_NUMBER>
  <ORG>NI01</ORG>
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
      <TransactionId>TXN-NI-20241201-001</TransactionId>
      <Timestamp>2024-12-01T10:30:05</Timestamp>
    </aut:ResponseHeader>
  </soap:Header>
  <soap:Body>
    <con:consultaPlanesCreditoResponse xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaPlanesCreditoTypes">
      <CREDIT_PLANS>
        <CREDIT_PLAN>
          <ORG>NI01</ORG>
          <ACCOUNT>4111234567890123</ACCOUNT>
          <SEQ_NUMBER>001</SEQ_NUMBER>
          <LOGO>VISA</LOGO>
          <PLAN_NUMBER>NI001</PLAN_NUMBER>
          <PAY_MINIMUM>180.00</PAY_MINIMUM>
          <TYPE_PLAN>REVOLVING</TYPE_PLAN>
          <INT_RATE>26.75</INT_RATE>
          <INT_RATE_BASE>20.50</INT_RATE_BASE>
          <CURRENT_BALANCE>2850.50</CURRENT_BALANCE>
          <DATE_PLAN>20241201</DATE_PLAN>
          <ACRD_INT>52.25</ACRD_INT>
          <DELAYS_ACRD_INT>8.75</DELAYS_ACRD_INT>
          <ACCUMULATED_DELAYS_INT>1.50</ACCUMULATED_DELAYS_INT>
        </CREDIT_PLAN>
        <CREDIT_PLAN>
          <ORG>NI01</ORG>
          <ACCOUNT>4111234567890123</ACCOUNT>
          <SEQ_NUMBER>002</SEQ_NUMBER>
          <LOGO>MASTERCARD</LOGO>
          <PLAN_NUMBER>NI002</PLAN_NUMBER>
          <PAY_MINIMUM>95.00</PAY_MINIMUM>
          <TYPE_PLAN>INSTALLMENT</TYPE_PLAN>
          <INT_RATE>20.25</INT_RATE>
          <INT_RATE_BASE>16.75</INT_RATE_BASE>
          <CURRENT_BALANCE>1450.75</CURRENT_BALANCE>
          <DATE_PLAN>20241125</DATE_PLAN>
          <ACRD_INT>28.50</ACRD_INT>
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
  <con1:PV_REGION>NI01</con1:PV_REGION>
  <con1:PV_USUARIO>userNI01</con1:PV_USUARIO>
</con1:InputParameters>
```

#### Response de consultaRutaRegional
```xml
<con1:OutputParameters xmlns:con1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaRutaRegional">
  <con1:PV_CODIGO_ERROR>SUCCESS</con1:PV_CODIGO_ERROR>
  <con1:PV_MENSAJE_ERROR></con1:PV_MENSAJE_ERROR>
  <con1:PV_UBICACION>Middleware/v2/ProxyServices/ConsultaPlanesCreditoNI</con1:PV_UBICACION>
</con1:OutputParameters>
```

### 2. Consulta Base de Datos (MasterData)

#### Request a conDatosPlanes_db
```xml
<con2:InputParameters xmlns:con2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatosPlanes">
  <con2:PV_CUENTA>4111234567890123</con2:PV_CUENTA>
  <con2:PV_ORG>NI01</con2:PV_ORG>
  <con2:PV_CODIGO_PAIS>NIC</con2:PV_CODIGO_PAIS>
</con2:InputParameters>
```

#### Response de conDatosPlanes_db
```xml
<con2:OutputParameters xmlns:con2="http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatosPlanes">
  <con2:CodigoError>-1</con2:CodigoError>
  <con2:MensajeError></con2:MensajeError>
  <con2:RowSet>
    <con2:Row>
      <con2:Column name="org">NI01</con2:Column>
      <con2:Column name="cuenta">4111234567890123</con2:Column>
      <con2:Column name="numseq">001</con2:Column>
      <con2:Column name="logo">VISA</con2:Column>
      <con2:Column name="numplan">NI001</con2:Column>
      <con2:Column name="total_due">180.00</con2:Column>
      <con2:Column name="tipo_plan">REVOLVING</con2:Column>
      <con2:Column name="int_rate">26.75</con2:Column>
      <con2:Column name="int_rat1_base">20.50</con2:Column>
      <con2:Column name="balanceactual">2850.50</con2:Column>
      <con2:Column name="fecplan">2024-12-01T00:00:00</con2:Column>
      <con2:Column name="acrd_int">52.25</con2:Column>
      <con2:Column name="mora_acrd_int">8.75</con2:Column>
      <con2:Column name="d2ps_mora_int_per_diem">1.50</con2:Column>
    </con2:Row>
    <con2:Row>
      <con2:Column name="org">NI01</con2:Column>
      <con2:Column name="cuenta">4111234567890123</con2:Column>
      <con2:Column name="numseq">002</con2:Column>
      <con2:Column name="logo">MASTERCARD</con2:Column>
      <con2:Column name="numplan">NI002</con2:Column>
      <con2:Column name="total_due">95.00</con2:Column>
      <con2:Column name="tipo_plan">INSTALLMENT</con2:Column>
      <con2:Column name="int_rate">20.25</con2:Column>
      <con2:Column name="int_rat1_base">16.75</con2:Column>
      <con2:Column name="balanceactual">1450.75</con2:Column>
      <con2:Column name="fecplan">2024-11-25T00:00:00</con2:Column>
      <con2:Column name="acrd_int">28.50</con2:Column>
      <con2:Column name="mora_acrd_int">0.00</con2:Column>
      <con2:Column name="d2ps_mora_int_per_diem">0.00</con2:Column>
    </con2:Row>
  </con2:RowSet>
</con2:OutputParameters>
```

## Cadenas de Conexión y Credenciales

### Base de Datos
- **Nombre de Conexión**: eis/DB/ConnectionTarjetas
- **Nombre de Base de Datos**: ConnectionTarjetas (configurado en WebLogic)
- **Stored Procedure**: OSB.dbo.OSBConDatoPlanes (único con SchemaName)
- **Esquema**: OSB.dbo
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
convertirCodigoPais("OSB-ISO3", "NI01") → "NIC"
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
- **Ubicación**: ConsultaPlanesCreditoNI.proxy - Stage "FlujoEntrada"
- **Regla**: Validación de esquema XSD obligatoria
- **Implementación**: 
```xml
<con1:validate>
  <con1:schema ref="Middleware/v2/BusinessServices/MasterData/conDatosPlanes/xsd/conDatosPlanes_sp"/>
  <con1:schemaElement>con4:InputParameters</con1:schemaElement>
</con1:validate>
```

### 2. Conversión de Código de País
- **Ubicación**: conDatosPlanesIn.xq
- **Regla**: Conversión de código OSB a ISO3
- **Implementación**:
```xquery
convertirCodigoPais("OSB-ISO3", fn:string($header/aut:RequestHeader/Region/SourceBank/text()))
```

### 3. Validación de Respuesta de BD
- **Ubicación**: ConsultaPlanesCreditoNI.proxy - Response Transform
- **Regla**: errorCode != '-1' indica éxito
- **Implementación**:
```xquery
if($errorCode != '-1') then
  string($RSPconDatosPlanes/con2:MensajeError/text())
else('')
```

### 4. Formateo de Fecha
- **Ubicación**: consultaPlanesCreditoOut.xq
- **Regla**: Fechas se formatean a YYYYMMDD solo si no están vacías
- **Implementación**:
```xquery
if($datePlan != '') then
  <DATE_PLAN>{fn-bea:dateTime-to-string-with-format('yyyyMMdd',$datePlan)}</DATE_PLAN>
else()
```

### 5. Manejo de Errores Estándar
- **Ubicación**: ConsultaPlanesCreditoNI.proxy - Response Stage
- **Regla**: successIndicator = "ERROR" cuando hay validationMessage
- **Implementación**:
```xml
<aut:ResponseHeader>
  <successIndicator>ERROR</successIndicator>
  <messages>{$validationMessage}</messages>
</aut:ResponseHeader>
```

### 6. Construcción de Response Header Exitoso
- **Ubicación**: ConsultaPlanesCreditoNI.proxy - Response Stage
- **Regla**: successIndicator = "Success" cuando validationMessage está vacío
- **Implementación**:
```xml
<aut:ResponseHeader>
  <successIndicator>Success</successIndicator>
</aut:ResponseHeader>
```

### 7. Manejo de Errores en Error Handler
- **Ubicación**: ConsultaPlanesCreditoNI.proxy - Error Handler
- **Regla**: Errores estándar con messageId = -1
- **Implementación**:
```xml
<aut:ResponseHeader>
  <messageId>-1</messageId>
  <successIndicator>ERROR</successIndicator>
  <messages>{string($fault/ctx:reason/text())}</messages>
</aut:ResponseHeader>
```

## Diferencias Específicas de NI01

### 1. Configuración de Base de Datos Única
NI01 es la única región que especifica SchemaName en la configuración JCA:
```xml
<property name="SchemaName" value="OSB"/>
<property name="PackageName" value="dbo"/>
<property name="ProcedureName" value="OSBConDatoPlanes"/>
```

Esto resulta en la llamada: `OSB.dbo.OSBConDatoPlanes`

### 2. Transport Configuration
- **Transport Provider**: Local (no HTTP)
- **Endpoint**: Sin URI específica
- **SOAP Selector**: SOAP action (no SOAP body)

### 3. Configuración de Binding
```xml
<con3:selector type="SOAP action"/>
```
En lugar de:
```xml
<con3:selector type="SOAP body"/>
```

### 4. Namespace en Validación
Utiliza namespace específico en la validación:
```xml
<con1:schemaElement xmlns:con4="http://xmlns.oracle.com/pcbpel/adapter/db/sp/conDatosPlanes">
  con4:InputParameters
</con1:schemaElement>
```

### 5. Conversión de Código de País
Utiliza `fn:string()` explícito en la conversión:
```xquery
fn:string($header/aut:RequestHeader/Region/SourceBank/text())
```

### 6. Variables de Response
- Utiliza `$RSPconDatosPlanes` (minúscula)
- Namespace `con2` para el response de base de datos

### 7. Manejo de Errores Estándar
- No incluye código de error específico en successIndicator
- Utiliza "ERROR" literal en caso de fallo
- Incluye `messageId` con valor -1 en error handler

## Consideraciones Especiales para NI01

### 1. Esquema de Base de Datos
La configuración única de SchemaName="OSB" indica que Nicaragua utiliza un esquema diferente en la base de datos, lo que debe considerarse en la migración.

### 2. Transport Local
El uso de transport local sugiere que este proxy se invoca internamente desde otros servicios, no directamente desde clientes externos.

### 3. SOAP Action Selector
La configuración de SOAP action selector requiere que los clientes especifiquen la acción SOAP correcta en el header.