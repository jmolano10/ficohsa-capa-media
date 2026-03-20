# Ejemplos de Request/Response y Mapeo de Datos - ValidaNumeroViajero (GENERAL)

## Request OSB (Ejemplo SOAP/XML)

### SOAP Envelope Completo
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/" 
               xmlns:val="http://www.ficohsa.com.hn/middleware.services/validaNumeroViajeroTypes"
               xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
  <soap:Header>
    <aut:RequestHeader>
      <Authentication>
        <UserName>ficohsa_user</UserName>
        <Password>ficohsa_pass</Password>
      </Authentication>
    </aut:RequestHeader>
  </soap:Header>
  <soap:Body>
    <val:validaNumeroViajero>
      <Type>AVIANCA</Type>
      <FlyerNumber>123456789</FlyerNumber>
    </val:validaNumeroViajero>
  </soap:Body>
</soap:Envelope>
```

### Ejemplo de Request Body
```xml
<val:validaNumeroViajero xmlns:val="http://www.ficohsa.com.hn/middleware.services/validaNumeroViajeroTypes">
  <Type>AVIANCA</Type>
  <FlyerNumber>123456789</FlyerNumber>
</val:validaNumeroViajero>
```

## Response OSB (Ejemplo SOAP/XML)

### Respuesta Exitosa
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/" 
               xmlns:val="http://www.ficohsa.com.hn/middleware.services/validaNumeroViajeroTypes"
               xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
  <soap:Header>
    <aut:ResponseHeader>
      <successIndicator>Success</successIndicator>
    </aut:ResponseHeader>
  </soap:Header>
  <soap:Body>
    <val:validaNumeroViajeroResponse>
      <Result>VALID</Result>
    </val:validaNumeroViajeroResponse>
  </soap:Body>
</soap:Envelope>
```

### Respuesta con Error
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/wsdl/soap/" 
               xmlns:val="http://www.ficohsa.com.hn/middleware.services/validaNumeroViajeroTypes"
               xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
  <soap:Header>
    <aut:ResponseHeader>
      <successIndicator>ERROR</successIndicator>
      <messages>Número de viajero no válido</messages>
    </aut:ResponseHeader>
  </soap:Header>
  <soap:Body>
    <val:validaNumeroViajeroResponse/>
  </soap:Body>
</soap:Envelope>
```

## Requests/Responses Internos a Servicios Dependientes

### Request al Stored Procedure (DB)
```xml
<ns1:InputParameters xmlns:ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/validaNumeroViajero">
  <PV_TYPE>AVIANCA</PV_TYPE>
  <PV_NUMERO_VIAJERO>123456789</PV_NUMERO_VIAJERO>
</ns1:InputParameters>
```

### Response del Stored Procedure (DB)
```xml
<ns1:OutputParameters xmlns:ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/validaNumeroViajero">
  <PV_RESULT>VALID</PV_RESULT>
  <PV_ERROR_CODE>SUCCESS</PV_ERROR_CODE>
  <PV_ERROR_MESAJE></PV_ERROR_MESAJE>
</ns1:OutputParameters>
```

## Cadenas de Conexión y Credenciales

### Conexión a Base de Datos
- **Tipo**: JCA Database Adapter
- **JNDI**: `jca://eis/DB/ConnectionInterfazSFC`
- **Connection Factory**: `eis/DB/ConnectionInterfazSFC`
- **Esquema**: SALESFORCE
- **Stored Procedure**: SFC_VALIDAR_NUMERO_VIAJERO
- **Parámetros**:
  - SchemaName: SALESFORCE
  - ProcedureName: SFC_VALIDAR_NUMERO_VIAJERO
  - GetActiveUnitOfWork: false

### Endpoint WSDL
- **URL**: `https://172.23.13.19:8004/Middleware/V2/ValidaNumeroViajero`
- **Protocolo**: HTTPS
- **Puerto**: 8004
- **Estilo**: Document/Literal
- **Transport**: HTTP

## Tablas de Mapeo de Entrada

### OSB Request → Database Input

| Campo Origen (OSB) | Transformación/Script | Campo Destino (DB) | Tipo | Obligatorio |
|-------------------|----------------------|-------------------|------|-------------|
| Type | `data($validaNumeroViajero1/Type)` | PV_TYPE | VARCHAR2 | Sí |
| FlyerNumber | `data($validaNumeroViajero1/FlyerNumber)` | PV_NUMERO_VIAJERO | VARCHAR2 | Sí |

### Transformación XQuery (ValidaNumeroViajeroIn.xq)
```xquery
declare function xf:ValidaNumeroViajeroIn($validaNumeroViajero1 as element(ns0:validaNumeroViajero))
    as element(ns1:InputParameters) {
        <ns1:InputParameters>
            <PV_TYPE>{ data($validaNumeroViajero1/Type) }</PV_TYPE>
            <PV_NUMERO_VIAJERO>{ data($validaNumeroViajero1/FlyerNumber) }</PV_NUMERO_VIAJERO>
        </ns1:InputParameters>
};
```

## Tablas de Mapeo de Salida

### Database Output → OSB Response

| Campo Origen (DB) | Transformación/Script | Campo Destino (OSB) | Tipo | Condicional |
|------------------|----------------------|-------------------|------|-------------|
| PV_RESULT | `data($PV_RESULT)` | Result | string | Solo si SUCCESS |
| PV_ERROR_CODE | `string($RSvalidaNumeroViajero/PV_ERROR_CODE/text())` | successIndicator | string | Siempre |
| PV_ERROR_MESAJE | `string($RSvalidaNumeroViajero/PV_ERROR_MESAJE/text())` | messages | string | Solo si ERROR |

### Transformación XQuery (ValidaNumeroViajeroOut.xq)
```xquery
declare function xf:ValidaNumeroViajeroOut($outputParameters1 as element(ns1:OutputParameters))
    as element(ns0:validaNumeroViajeroResponse) {
        <ns0:validaNumeroViajeroResponse>
            {
                for $PV_RESULT in $outputParameters1/PV_RESULT
                return
                    <Result>{ data($PV_RESULT) }</Result>
            }
        </ns0:validaNumeroViajeroResponse>
};
```

## Reglas de Negocio Detectadas

### Validación de Entrada
- **Ubicación**: Pipeline ValidaNumeroViajero_request, Stage ValidacionXSD
- **Regla**: Validación obligatoria contra esquema XSD
- **Implementación**: 
  ```xml
  <con2:validate>
    <con2:schema ref="Middleware/v2/Resources/ValidaNumeroViajero/xsd/validaNumeroViajeroTypes"/>
    <con2:schemaElement>val:validaNumeroViajero</con2:schemaElement>
  </con2:validate>
  ```

### Autenticación Custom
- **Ubicación**: Proxy Service Security Configuration
- **Regla**: Username/Password obligatorios en header
- **Implementación**:
  ```xml
  <con3:username-selector>
    <con3:xpath>./aut:RequestHeader/Authentication/UserName/text()</con3:xpath>
  </con3:username-selector>
  <con3:password-selector>
    <con3:xpath>./aut:RequestHeader/Authentication/Password/text()</con3:xpath>
  </con3:password-selector>
  ```

### Lógica de Respuesta Condicional
- **Ubicación**: Pipeline ValidaNumeroViajero_response, Stage FlujoSalida
- **Regla**: Respuesta basada en código de error del SP
- **Implementación**:
  ```xml
  <con2:ifThenElse>
    <con2:case>
      <con2:condition>
        <con1:xqueryText>$errorCode = 'SUCCESS'</con1:xqueryText>
      </con2:condition>
      <!-- Respuesta exitosa con datos -->
    </con2:case>
    <con2:default>
      <!-- Respuesta de error -->
    </con2:default>
  </con2:ifThenElse>
  ```

### Manejo de Errores
- **Ubicación**: Error Handler Pipeline
- **Regla**: Captura y formateo de errores técnicos
- **Implementación**:
  ```xml
  <aut:ResponseHeader>
    <successIndicator>ERROR</successIndicator>
    <messageId>{ string($fault/ctx:errorCode/text()) }</messageId>
    <messages>{ string($fault/ctx:reason/text()) }</messages>
  </aut:ResponseHeader>
  ```

## Casos de Uso Típicos

### Caso 1: Validación Exitosa
- **Input**: Type="AVIANCA", FlyerNumber="123456789"
- **SP Result**: PV_RESULT="VALID", PV_ERROR_CODE="SUCCESS"
- **Output**: Result="VALID", successIndicator="Success"

### Caso 2: Número Inválido
- **Input**: Type="AVIANCA", FlyerNumber="INVALID123"
- **SP Result**: PV_RESULT="", PV_ERROR_CODE="INVALID_NUMBER", PV_ERROR_MESAJE="Número no válido"
- **Output**: successIndicator="INVALID_NUMBER", messages="Número no válido"

### Caso 3: Error de Sistema
- **Input**: Cualquier input válido
- **Error**: Conexión DB falla
- **Output**: successIndicator="ERROR", messages="Database connection failed"