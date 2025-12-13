# Ejemplos de Request/Response y Mapeo de Datos - HN02 (FPC)

## Request OSB (ejemplo XML)

```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Header>
    <aut:RequestHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
      <Authentication>
        <UserName>fpcuser</UserName>
        <Password>fpcpass</Password>
      </Authentication>
      <Region>
        <SourceBank>HN02</SourceBank>
        <DestinationBank>HN02</DestinationBank>
      </Region>
    </aut:RequestHeader>
  </soap:Header>
  <soap:Body>
    <con:consultaFondoPensionesRequest xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaFondoPensionesTypes">
      <con:ACCOUNT_NUMBER>FP001234567890</con:ACCOUNT_NUMBER>
    </con:consultaFondoPensionesRequest>
  </soap:Body>
</soap:Envelope>
```

## Response OSB (ejemplo XML - Exitoso)

```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Header>
    <aut:ResponseHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
      <successIndicator>SUCCESS</successIndicator>
      <messages/>
    </aut:ResponseHeader>
  </soap:Header>
  <soap:Body>
    <con:consultaFondoPensionesResponse xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaFondoPensionesTypes">
      <con:ACCOUNT_NUMBER>FP001234567890</con:ACCOUNT_NUMBER>
      <con:CUSTOMER_ID>0801198012345</con:CUSTOMER_ID>
      <con:CUSTOMER_NAME>JUAN CARLOS PEREZ LOPEZ</con:CUSTOMER_NAME>
      <con:PRODUCT_CODE>FP</con:PRODUCT_CODE>
      <con:PRODUCT_NAME>FONDO DE PENSIONES</con:PRODUCT_NAME>
      <con:SUB_PRODUCT_CODE>FP01</con:SUB_PRODUCT_CODE>
      <con:OPENING_DATE>2020-01-15</con:OPENING_DATE>
      <con:FREQUENCY>MENSUAL</con:FREQUENCY>
      <con:PAYMENT_METHOD>DEBITO_AUTOMATICO</con:PAYMENT_METHOD>
      <con:INSURED_AMOUNT>500000.00</con:INSURED_AMOUNT>
      <con:CONTRIBUTION_AMOUNT>2500.00</con:CONTRIBUTION_AMOUNT>
      <con:LAST_CONTRIBUTION_AMOUNT>2500.00</con:LAST_CONTRIBUTION_AMOUNT>
      <con:LAST_CONTRIBUTION_DATE>2023-11-15</con:LAST_CONTRIBUTION_DATE>
      <con:NEXT_CONTRIBUTION_DATE>2023-12-15</con:NEXT_CONTRIBUTION_DATE>
      <con:LAST_EXTRA_CONTRIBUTION_AMOUNT>5000.00</con:LAST_EXTRA_CONTRIBUTION_AMOUNT>
      <con:BENEFICIARY_INFO>
        <con:BENEFICIARY_ITEM>
          <con:FULL_NAME>MARIA ELENA LOPEZ GARCIA</con:FULL_NAME>
          <con:RELATIONSHIP>ESPOSA</con:RELATIONSHIP>
        </con:BENEFICIARY_ITEM>
        <con:BENEFICIARY_ITEM>
          <con:FULL_NAME>CARLOS ANDRES PEREZ LOPEZ</con:FULL_NAME>
          <con:RELATIONSHIP>HIJO</con:RELATIONSHIP>
        </con:BENEFICIARY_ITEM>
      </con:BENEFICIARY_INFO>
    </con:consultaFondoPensionesResponse>
  </soap:Body>
</soap:Envelope>
```

## Response OSB (ejemplo XML - Error)

```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Header>
    <aut:ResponseHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
      <successIndicator>Error</successIndicator>
      <messages>Cuenta de fondo de pensiones no encontrada</messages>
    </aut:ResponseHeader>
  </soap:Header>
  <soap:Body>
    <con:consultaFondoPensionesResponse xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaFondoPensionesTypes"/>
  </soap:Body>
</soap:Envelope>
```

## Requests/Responses internos a servicios dependientes

### Servicio Externo getPensionFund12c

**Request Header a getPensionFund12c**:
```xml
<aut:RequestHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
  <Authentication>
    <UserName>OSB12AUTH</UserName>
    <Password>credential_password</Password>
  </Authentication>
  <Region>
    <SourceBank>HN02</SourceBank>
    <DestinationBank>HN02</DestinationBank>
  </Region>
</aut:RequestHeader>
```

**Request Body a getPensionFund12c**:
```xml
<ns0:getPensionFund xmlns:ns0="https://www.ficohsa.com/regional/pension">
  <GeneralInfo>
    <SourceBank>HN02</SourceBank>
    <DestinationBank>HN02</DestinationBank>
    <Language>es</Language>
  </GeneralInfo>
  <AccountCode>FP001234567890</AccountCode>
</ns0:getPensionFund>
```

**Response de getPensionFund12c (Exitoso)**:
```xml
<ns0:getPensionFundResponse xmlns:ns0="https://www.ficohsa.com/regional/pension">
  <StatusInfo>
    <Status>SUCCESS</Status>
  </StatusInfo>
  <Data>
    <Account>
      <CustomerCode>0801198012345</CustomerCode>
      <CustomerName>JUAN CARLOS PEREZ LOPEZ</CustomerName>
      <CodeProductLine>FP</CodeProductLine>
      <ProductName>FONDO DE PENSIONES</ProductName>
      <ProductCode>FP01</ProductCode>
      <OpeningDate>2020-01-15</OpeningDate>
      <FrequencyContribution>MENSUAL</FrequencyContribution>
      <FormContribution>DEBITO_AUTOMATICO</FormContribution>
      <InsuredAmount>500000.00</InsuredAmount>
      <AmountContribution>2500.00</AmountContribution>
      <LastContributionAmount>2500.00</LastContributionAmount>
      <LastContribution>2023-11-15</LastContribution>
      <NextContribution>2023-12-15</NextContribution>
      <LastContributionExtra>5000.00</LastContributionExtra>
      <Beneficiaries>
        <NameBeneficiary>MARIA ELENA LOPEZ GARCIA</NameBeneficiary>
        <RelationshipBeneficiary>ESPOSA</RelationshipBeneficiary>
      </Beneficiaries>
      <Beneficiaries>
        <NameBeneficiary>CARLOS ANDRES PEREZ LOPEZ</NameBeneficiary>
        <RelationshipBeneficiary>HIJO</RelationshipBeneficiary>
      </Beneficiaries>
    </Account>
  </Data>
</ns0:getPensionFundResponse>
```

**Response de getPensionFund12c (Error)**:
```xml
<ns0:getPensionFundResponse xmlns:ns0="https://www.ficohsa.com/regional/pension">
  <StatusInfo>
    <Status>ERROR</Status>
  </StatusInfo>
  <ErrorInfo>
    <Description>Cuenta de fondo de pensiones no encontrada</Description>
  </ErrorInfo>
</ns0:getPensionFundResponse>
```

## Cadenas de conexión detectadas y credenciales

### Servicio WSDL Externo
- **Endpoint WSDL**: `https://dynamoosbdev:8004/regional/pension/soap/getPensionFund11g/v1`
- **Operación**: `getPensionFund`
- **Protocolo**: HTTPS/SOAP
- **Timeout**: 70 segundos
- **Connection Timeout**: 65 segundos

### Credenciales
- **Referencia de Credenciales**: `Middleware/Security/OSB12AUTH`
- **Tipo**: Basic Authentication
- **Uso**: Para autenticación con el servicio externo Dynamo

## Tablas de mapeo de entrada por cada llamada a servicio dependiente

### Servicio Externo getPensionFund12c

**Header Transformation** (`getPensionFundHeaderIn.xq`):

| Campo Origen (OSB) | Transformación/Script | Campo Destino (Servicio Externo) |
|-------------------|----------------------|----------------------------------|
| Constante 'OSB12AUTH' | getUsername($serviceAccountName) | Authentication/UserName |
| Constante 'OSB12AUTH' | getPassword($serviceAccountName) | Authentication/Password |
| header/aut:RequestHeader/Region/SourceBank | Mapeo directo | Region/SourceBank |
| header/aut:RequestHeader/Region/DestinationBank | Mapeo directo | Region/DestinationBank |

**Body Transformation** (`getPensionFundIn.xq`):

| Campo Origen (OSB) | Transformación/Script | Campo Destino (Servicio Externo) |
|-------------------|----------------------|----------------------------------|
| ACCOUNT_NUMBER | Mapeo directo | AccountCode |
| sourceBank (parámetro) | Mapeo directo | GeneralInfo/SourceBank |
| destinationBank (parámetro) | Mapeo directo | GeneralInfo/DestinationBank |
| Constante 'es' | Valor fijo | GeneralInfo/Language |

## Tablas de mapeo de salida por cada respuesta de servicio dependiente

### Servicio Externo getPensionFund12c

**Transformation** (`consultaFondoPensionesHNOut.xq`):

| Campo Origen (Servicio Externo) | Transformación/Script | Campo Destino (OSB) |
|--------------------------------|----------------------|-------------------|
| accountNumber (parámetro) | Mapeo directo | ACCOUNT_NUMBER |
| Data/Account/CustomerCode | Mapeo directo | CUSTOMER_ID |
| Data/Account/CustomerName | Mapeo directo | CUSTOMER_NAME |
| Data/Account/CodeProductLine | Mapeo directo | PRODUCT_CODE |
| Data/Account/ProductName | Mapeo directo | PRODUCT_NAME |
| Data/Account/ProductCode | Mapeo directo | SUB_PRODUCT_CODE |
| Data/Account/OpeningDate | Mapeo directo | OPENING_DATE |
| Data/Account/FrequencyContribution | Mapeo directo | FREQUENCY |
| Data/Account/FormContribution | Mapeo directo | PAYMENT_METHOD |
| Data/Account/InsuredAmount | Mapeo condicional con for loop | INSURED_AMOUNT |
| Data/Account/AmountContribution | Mapeo directo | CONTRIBUTION_AMOUNT |
| Data/Account/LastContributionAmount | Mapeo condicional con for loop | LAST_CONTRIBUTION_AMOUNT |
| Data/Account/LastContribution | Mapeo directo | LAST_CONTRIBUTION_DATE |
| Data/Account/NextContribution | Mapeo directo | NEXT_CONTRIBUTION_DATE |
| Data/Account/LastContributionExtra | Mapeo directo | LAST_EXTRA_CONTRIBUTION_AMOUNT |

**Mapeo de Beneficiarios**:

| Campo Origen (Servicio Externo) | Transformación/Script | Campo Destino (OSB) |
|--------------------------------|----------------------|-------------------|
| Data/Account/Beneficiaries/NameBeneficiary | for loop sobre beneficiarios | BENEFICIARY_INFO/BENEFICIARY_ITEM/FULL_NAME |
| Data/Account/Beneficiaries/RelationshipBeneficiary | for loop sobre beneficiarios | BENEFICIARY_INFO/BENEFICIARY_ITEM/RELATIONSHIP |

**Campos No Mapeados (siempre vacíos en respuesta)**:
- ACCOUNT_TYPE, ACCOUNT_CURRENCY, ACCOUNT_STATUS
- REQUEST_ID, GROUP_CODE, CONTRACT_ID
- SUB_PRODUCT_NAME, EXPIRATION_DATE, CLOSING_DATE
- OFFICER_CODE, BRANCH_CODE, NOTIFICATION_TYPE
- APPLY_INSURANCE, FREQUENCY_DATE
- SALARY_AMOUNT, PREMIUM_AMOUNT, CONTRIBUTION_TYPE
- FIRST_CONTRIBUTION_AMOUNT, FIRST_CONTRIBUTION_DATE
- NEXT_CONTRIBUTION_AMOUNT, LAST_EXTRA_CONTRIBUTION_DATE
- BALANCE_TYPE_INFO (estructura completa)
- Campos adicionales de beneficiarios

## Reglas de negocio detectadas

### 1. Evaluación de Status de Respuesta
- **Ubicación**: Pipeline FPCHN_ConsultaFondoPensiones_request
- **Archivo**: ConsultaFondoPensiones.proxy
- **Lógica**:
  ```xquery
  let $successIndicator := fn:string($RSPgetPensionFund/StatusInfo/Status)
  return
  if(fn:upper-case($successIndicator) = "SUCCESS") then (
      $successIndicator
  ) else ('Error')
  ```
- **Descripción**: Evalúa si la respuesta del servicio externo fue exitosa

### 2. Extracción de Mensaje de Error
- **Ubicación**: Pipeline FPCHN_ConsultaFondoPensiones_request
- **Lógica**:
  ```xquery
  if(fn:not(fn:upper-case($errorCode) = "SUCCESS")) then (
      fn:data($RSPgetPensionFund/ErrorInfo/Description)
  ) else ('')
  ```
- **Descripción**: Extrae el mensaje de error del servicio externo si existe

### 3. Construcción Condicional de Response Header
- **Ubicación**: Pipeline FPCHN_ConsultaFondoPensiones_response
- **Lógica**:
  ```xquery
  <aut:ResponseHeader>
        <successIndicator>{ $errorCode }</successIndicator>
        {
            if(fn:not(fn:upper-case($errorCode) = "SUCCESS")) then (
                <messages>{ $validationMessage }</messages>
            ) else (<messages/>)
        }
  </aut:ResponseHeader>
  ```
- **Descripción**: Construye el header de respuesta con mensaje condicional

### 4. Transformación Condicional del Body
- **Ubicación**: Pipeline FPCHN_ConsultaFondoPensiones_response
- **Lógica**: `$validationMessage = ""`
- **Descripción**: Solo transforma los datos si no hay mensaje de error

### 5. Mapeo Condicional de Campos Opcionales
- **Ubicación**: consultaFondoPensionesHNOut.xq
- **Lógica**:
  ```xquery
  {
      for $InsuredAmount in $getPensionFundResponse/Data/Account/InsuredAmount
      return
          <ns2:INSURED_AMOUNT>{ data($InsuredAmount) }</ns2:INSURED_AMOUNT>
  }
  ```
- **Descripción**: Usa for loops para manejar campos que pueden estar ausentes

### 6. Procesamiento de Lista de Beneficiarios
- **Ubicación**: consultaFondoPensionesHNOut.xq
- **Lógica**:
  ```xquery
  {
      for $beneficiary in $getPensionFundResponse/Data/Account/Beneficiaries
      return
          <ns2:BENEFICIARY_ITEM>
              <ns2:FULL_NAME>{ data($beneficiary/NameBeneficiary) }</ns2:FULL_NAME>
              <ns2:RELATIONSHIP>{ data($beneficiary/RelationshipBeneficiary) }</ns2:RELATIONSHIP>
          </ns2:BENEFICIARY_ITEM>
  }
  ```
- **Descripción**: Procesa múltiples beneficiarios en una lista

### 7. Obtención de Credenciales
- **Ubicación**: getPensionFundHeaderIn.xq
- **Funciones**: `getUsername()`, `getPassword()`
- **Lógica**:
  ```xquery
  declare function getUsername ($serviceAccountName as xs:string)  as xs:string { 
      let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($serviceAccountName)))
      return $data/con:username/text()
  };
  ```
- **Descripción**: Obtiene credenciales del almacén de seguridad de OSB

### 8. Configuración de Idioma
- **Ubicación**: getPensionFundIn.xq
- **Lógica**: `<Language>es</Language>`
- **Descripción**: Configura el idioma español para el servicio externo

### 9. Enrutamiento Regional
- **Ubicación**: Branch node ConditionalBranchPaisEmpresa
- **Lógica**: `./aut:RequestHeader/Region/SourceBank = 'HN02'`
- **Descripción**: Enruta a pipeline específico solo para HN02

### 10. Manejo de Errores Generales
- **Ubicación**: Error Handler
- **Lógica**: `concat(fn:string($fault/ctx:errorCode/text()), ": ", fn:string($fault/ctx:reason/text()))`
- **Descripción**: Concatena código y razón del error para el mensaje final

## Consideraciones Técnicas

### Campos Opcionales
El servicio maneja varios campos que pueden estar ausentes en la respuesta del servicio externo:
- InsuredAmount
- LastContributionAmount
- Beneficiaries (lista completa)

### Estructura de Datos Compleja
La respuesta incluye estructuras anidadas que no están completamente implementadas:
- BALANCE_TYPE_INFO: Definida en el XSD pero no mapeada
- Campos detallados de beneficiarios: Solo se mapean nombre y relación

### Limitaciones del Mapeo
Muchos campos definidos en el XSD no tienen correspondencia en el servicio externo:
- Información de cuenta (tipo, moneda, estado)
- Fechas adicionales (vencimiento, cierre)
- Información organizacional (oficial, sucursal)
- Detalles de contribuciones (primera, siguiente)
- Información de seguros detallada