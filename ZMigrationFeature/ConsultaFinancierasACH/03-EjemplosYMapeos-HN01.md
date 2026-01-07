# Ejemplos de Request/Response y Mapeo de Datos - HN01 (Honduras Core)

## Request OSB (ejemplo SOAP/XML)

```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Header>
    <aut:RequestHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
      <Authentication>
        <UserName>USUARIO_T24</UserName>
        <Password>PASSWORD_T24</Password>
      </Authentication>
      <Region>
        <SourceBank>HN01</SourceBank>
        <DestinationBank>HN01</DestinationBank>
      </Region>
    </aut:RequestHeader>
  </soap:Header>
  <soap:Body>
    <con:consultaFinancierasACH xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaFinancierasACHTypes">
      <DESTINATION_CODE>001</DESTINATION_CODE>
    </con:consultaFinancierasACH>
  </soap:Body>
</soap:Envelope>
```

## Response OSB (ejemplo SOAP/XML)

```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Header>
    <aut:ResponseHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
      <successIndicator>Success</successIndicator>
      <messages></messages>
    </aut:ResponseHeader>
  </soap:Header>
  <soap:Body>
    <con:consultaFinancierasACHResponse xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaFinancierasACHTypes">
      <con:consultaFinancierasACHResponseType>
        <con:consultaFinancierasACHResponseRecordType>
          <DESTINATION_CODE>001</DESTINATION_CODE>
          <DESTINATION_NAME>BANCO FICOHSA</DESTINATION_NAME>
          <con:consultaFinancierasACHDetailResponseType>
            <con:consultaFinancierasACHDetailResponseRecordType>
              <TYPE_OF_PRODUCT>CUENTA_CORRIENTE</TYPE_OF_PRODUCT>
              <MIN_PRODUCT_ID_LENGTH>10</MIN_PRODUCT_ID_LENGTH>
              <MAX_PRODUCT_ID_LENGTH>15</MAX_PRODUCT_ID_LENGTH>
              <LEADING_ZEROS_YES_NO>YES</LEADING_ZEROS_YES_NO>
              <PRODUCT_ID_SAMPLE>1234567890</PRODUCT_ID_SAMPLE>
            </con:consultaFinancierasACHDetailResponseRecordType>
          </con:consultaFinancierasACHDetailResponseType>
        </con:consultaFinancierasACHResponseRecordType>
      </con:consultaFinancierasACHResponseType>
    </con:consultaFinancierasACHResponse>
  </soap:Body>
</soap:Envelope>
```

## Request/Response Interno a T24 Core Banking

### Request a T24 Core Banking

```xml
<ns0:ConsultadedestinosACH xmlns:ns0="T24WebServicesImpl">
  <WebRequestCommon>
    <userName>USUARIO_T24_REAL</userName>
    <password>PASSWORD_T24_REAL</password>
  </WebRequestCommon>
  <WSACHBANKLISTType>
    <enquiryInputCollection>
      <columnName>@ID</columnName>
      <criteriaValue>001</criteriaValue>
      <operand>EQ</operand>
    </enquiryInputCollection>
  </WSACHBANKLISTType>
</ns0:ConsultadedestinosACH>
```

### Response de T24 Core Banking

```xml
<ns0:ConsultadedestinosACHResponse xmlns:ns0="T24WebServicesImpl">
  <gTSACHBANKLISTDetailType>
    <mTSACHBANKLISTDetailType>
      <bankCode>001</bankCode>
      <bankName>BANCO FICOHSA</bankName>
      <productType>CUENTA_CORRIENTE</productType>
      <minLength>10</minLength>
      <maxLength>15</maxLength>
      <leadingZeros>YES</leadingZeros>
      <sampleId>1234567890</sampleId>
    </mTSACHBANKLISTDetailType>
  </gTSACHBANKLISTDetailType>
</ns0:ConsultadedestinosACHResponse>
```

## Cadenas de Conexión y Credenciales

### Business Service T24 Core Banking
- **Nombre del Business Service**: `Middleware/Business_Resources/Core/Resources/CoreBS`
- **Operación**: `ConsultadedestinosACH`
- **Tipo de Conexión**: SOAP Web Service
- **Endpoint**: Configurado en el Business Service CoreBS
- **Autenticación**: Usuario/Password en WebRequestCommon

### Credenciales LDAP
- **Patrón de lookup**: `Middleware/Security/{UPPER_CASE_USERNAME}`
- **Función de lookup**: `fn-bea:lookupBasicCredentials()`
- **Failover**: Si LDAP falla, usa credenciales del header original

## Mapeo de Entrada (OSB → T24 Core Banking)

| Campo Origen (OSB) | Transformación/Script | Campo Destino (T24) |
|-------------------|----------------------|-------------------|
| `$RequestHeader1/Authentication/UserName` | `getUsername()` con failover | `WebRequestCommon/userName` |
| `$RequestHeader1/Authentication/Password` | `getPassword()` con failover | `WebRequestCommon/password` |
| `$consultaFinancierasACH/DESTINATION_CODE` | `data()` directo | `enquiryInputCollection/criteriaValue` |
| Constante `"@ID"` | Valor fijo | `enquiryInputCollection/columnName` |
| Constante `"EQ"` | Valor fijo | `enquiryInputCollection/operand` |

### Script de Transformación de Entrada
**Archivo**: `Middleware/v2/Resources/ConsultaFinancierasACH/xq/consultaFinancierasACHIn.xq`

**Funciones auxiliares**:
```xquery
declare function getUsername ($LDAPUsername as xs:string) as xs:string { 
    let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
    return $data/con:username/text()
};

declare function getPassword ($LDAPUsername as xs:string) as xs:string {      
    let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
    return $data/con:password/text()
};
```

## Mapeo de Salida (T24 Core Banking → OSB)

| Campo Origen (T24) | Transformación/Script | Campo Destino (OSB) |
|-------------------|----------------------|-------------------|
| `$RESPONSE/gTSACHBANKLISTDetailType/mTSACHBANKLISTDetailType/bankCode` | `data()` directo | `DESTINATION_CODE` |
| `$RESPONSE/gTSACHBANKLISTDetailType/mTSACHBANKLISTDetailType/bankName` | `data()` directo | `DESTINATION_NAME` |
| `$RESPONSE/gTSACHBANKLISTDetailType/mTSACHBANKLISTDetailType/productType` | `data()` directo | `TYPE_OF_PRODUCT` |
| `$RESPONSE/gTSACHBANKLISTDetailType/mTSACHBANKLISTDetailType/minLength` | `data()` directo | `MIN_PRODUCT_ID_LENGTH` |
| `$RESPONSE/gTSACHBANKLISTDetailType/mTSACHBANKLISTDetailType/maxLength` | `data()` directo | `MAX_PRODUCT_ID_LENGTH` |
| `$RESPONSE/gTSACHBANKLISTDetailType/mTSACHBANKLISTDetailType/leadingZeros` | `data()` directo | `LEADING_ZEROS_YES_NO` |
| `$RESPONSE/gTSACHBANKLISTDetailType/mTSACHBANKLISTDetailType/sampleId` | `data()` directo | `PRODUCT_ID_SAMPLE` |

### Scripts de Transformación de Salida
**Header**: `Middleware/v2/Resources/ConsultaFinancierasACH/xq/consultaFinanacierasACHHeaderOut.xq`
**Body**: `Middleware/v2/Resources/ConsultaFinancierasACH/xq/consultaFinanacierasACHOut.xq`

## Reglas de Negocio Detectadas

### 1. Autenticación con Failover
**Ubicación**: `consultaFinancierasACHIn.xq` líneas 15-25
**Regla**: Si el lookup LDAP falla, utilizar credenciales del header original
**Implementación**:
```xquery
fn-bea:fail-over(getUsername(data($RequestHeader1/Authentication/UserName)),
                 data($RequestHeader1/Authentication/UserName))
```

### 2. Filtro Condicional por Código de Destino
**Ubicación**: `consultaFinancierasACHIn.xq` líneas 35-42
**Regla**: Si se proporciona DESTINATION_CODE, crear filtro específico; si no, consultar todos
**Implementación**:
```xquery
if($consultaFinancierasACH/DESTINATION_CODE/text()) then (
    <enquiryInputCollection>
        <columnName>@ID</columnName>
        <criteriaValue>{ data($consultaFinancierasACH/DESTINATION_CODE) }</criteriaValue>
        <operand>EQ</operand>
    </enquiryInputCollection>
) else ()
```

### 3. Validación de Esquema XSD
**Ubicación**: Proxy service, pipeline `ValidacionesGenerales_request`
**Regla**: Validar estructura del request contra XSD antes del procesamiento
**Esquema**: `Middleware/Business_Resources/Core/consultaFinancierasACH/consultaFinancierasACHTypes.xsd`

### 4. Validación de Servicio Regional
**Ubicación**: Proxy service, pipeline `ValidacionesGenerales_request`
**Regla**: Verificar que el servicio esté disponible para la región solicitada
**Service ID**: `FICBCO0118`
**Business Service**: `Middleware/v2/BusinessServices/ValidaServicioRegional/biz/ValidaServicioRegional_db`

### 5. Manejo de Errores Centralizado
**Ubicación**: Pipeline de error y response
**Regla**: Mapear errores técnicos a códigos de negocio estándar
**Servicio**: `Middleware/v2/ProxyServices/MapeoErrores`
**Código de servicio**: `FICBCO0118`