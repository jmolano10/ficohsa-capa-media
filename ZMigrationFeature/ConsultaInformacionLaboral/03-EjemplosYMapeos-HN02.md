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
    <con:consultaInformacionLaboralRequest xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaInformacionLaboralTypes">
      <con:CUSTOMER_ACCOUNT>0801198012345</con:CUSTOMER_ACCOUNT>
      <con:FROM_DATE>20230101</con:FROM_DATE>
      <con:TO_DATE>20231231</con:TO_DATE>
    </con:consultaInformacionLaboralRequest>
  </soap:Body>
</soap:Envelope>
```

## Response OSB (ejemplo XML - Exitoso)

```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Header>
    <aut:ResponseHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
      <successIndicator>Success</successIndicator>
      <messages/>
    </aut:ResponseHeader>
  </soap:Header>
  <soap:Body>
    <con:consultaInformacionLaboralResponse xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaInformacionLaboralTypes">
      <con:JOB_INFO_HISTORY>
        <con:JOB_INFO_HISTORY_ITEM>
          <con:CUSTOMER_ACCOUNT>0801198012345</con:CUSTOMER_ACCOUNT>
          <con:STATUS>A</con:STATUS>
          <con:START_DATE/>
          <con:END_DATE>20231215120000</con:END_DATE>
          <con:PAYMENT_PERIOD>12</con:PAYMENT_PERIOD>
          <con:EMPLOYER_CODE>EMP001</con:EMPLOYER_CODE>
          <con:EMPLOYER_NAME>EMPRESA EJEMPLO S.A.</con:EMPLOYER_NAME>
          <con:EMPLOYER_RTN>08011980123456</con:EMPLOYER_RTN>
          <con:BALANCE_TYPE>01</con:BALANCE_TYPE>
          <con:PAYMENT_AMOUNT>25000.00</con:PAYMENT_AMOUNT>
          <con:SALARY_CURRENCY/>
          <con:SALARY_AMOUNT>30000.00</con:SALARY_AMOUNT>
          <con:OCCUPATION_CODE/>
          <con:OCCUPATION_DESC>ANALISTA DE SISTEMAS</con:OCCUPATION_DESC>
          <con:JOB_TITLE_CODE/>
          <con:JOB_TITLE_DESC>DESARROLLADOR SENIOR</con:JOB_TITLE_DESC>
        </con:JOB_INFO_HISTORY_ITEM>
      </con:JOB_INFO_HISTORY>
    </con:consultaInformacionLaboralResponse>
  </soap:Body>
</soap:Envelope>
```

## Requests/Responses internos a servicios dependientes

### 1. Validación de Servicio Regional

**Request a ValidaServicioRegional_db**:
```xml
<val:InputParameters xmlns:val="http://xmlns.oracle.com/pcbpel/adapter/db/sp/ValidaServicioRegional">
  <val:PV_SERVICE_ID>FICBCO0181</val:PV_SERVICE_ID>
  <val:PV_SOURCE_BANK>HN02</val:PV_SOURCE_BANK>
  <val:PV_DESTINATION_BANK>HN02</val:PV_DESTINATION_BANK>
</val:InputParameters>
```

**Response de ValidaServicioRegional_db**:
```xml
<val:OutputParameters xmlns:val="http://xmlns.oracle.com/pcbpel/adapter/db/sp/ValidaServicioRegional">
  <val:PV_CODIGO_ERROR>SUCCESS</val:PV_CODIGO_ERROR>
  <val:PV_MENSAJE_ERROR/>
</val:OutputParameters>
```

### 2. Servicio Externo getEmploymentInformation12c

**Request Header a getEmploymentInformation12c**:
```xml
<aut:RequestHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
  <Authentication>
    <UserName>OSB12AUTH</UserName>
    <Password>credential_password</Password>
  </Authentication>
  <Region>
    <SourceBank>HN01</SourceBank>
    <DestinationBank>HN01</DestinationBank>
  </Region>
</aut:RequestHeader>
```

**Request Body a getEmploymentInformation12c**:
```xml
<con:consultaInformacionLaboralRequest xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaInformacionLaboralTypes">
  <con:CUSTOMER_ACCOUNT>0801198012345</con:CUSTOMER_ACCOUNT>
  <con:FROM_DATE>01/01/2023</con:FROM_DATE>
  <con:TO_DATE>31/12/2023</con:TO_DATE>
</con:consultaInformacionLaboralRequest>
```

**Response de getEmploymentInformation12c**:
```xml
<con:consultaInformacionLaboralResponse xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaInformacionLaboralTypes">
  <con:JOB_INFO_HISTORY>
    <con:JOB_INFO_HISTORY_ITEM>
      <con:CUSTOMER_ACCOUNT>0801198012345</con:CUSTOMER_ACCOUNT>
      <con:STATUS>A</con:STATUS>
      <con:START_DATE/>
      <con:END_DATE>2023-12-15</con:END_DATE>
      <con:PAYMENT_PERIOD>12</con:PAYMENT_PERIOD>
      <con:EMPLOYER_CODE>EMP001</con:EMPLOYER_CODE>
      <con:EMPLOYER_NAME>EMPRESA EJEMPLO S.A.</con:EMPLOYER_NAME>
      <con:EMPLOYER_RTN>08011980123456</con:EMPLOYER_RTN>
      <con:BALANCE_TYPE>01</con:BALANCE_TYPE>
      <con:PAYMENT_AMOUNT>25000.00</con:PAYMENT_AMOUNT>
      <con:SALARY_CURRENCY/>
      <con:SALARY_AMOUNT>30000.00</con:SALARY_AMOUNT>
      <con:OCCUPATION_CODE/>
      <con:OCCUPATION_DESC>ANALISTA DE SISTEMAS</con:OCCUPATION_DESC>
      <con:JOB_TITLE_CODE/>
      <con:JOB_TITLE_DESC>DESARROLLADOR SENIOR</con:JOB_TITLE_DESC>
    </con:JOB_INFO_HISTORY_ITEM>
  </con:JOB_INFO_HISTORY>
</con:consultaInformacionLaboralResponse>
```

### 3. Base de Datos FPC (Alternativo)

**Request a consultaInformacionLaboralFPC_db**:
```xml
<ns1:InputParameters xmlns:ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaInformacionLaboralFPC">
  <ns1:PC_COD_CTA>0801198012345</ns1:PC_COD_CTA>
  <ns1:PD_FECHA_INICIO>2023-01-01</ns1:PD_FECHA_INICIO>
  <ns1:PD_FECHA_FIN>2023-12-31</ns1:PD_FECHA_FIN>
</ns1:InputParameters>
```

**Response de consultaInformacionLaboralFPC_db**:
```xml
<ns1:OutputParameters xmlns:ns1="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaInformacionLaboralFPC">
  <ns1:PT_HIST_LABORAL>
    <ns1:PT_HIST_LABORAL_ITEM>
      <ns1:COD_CUENTA_FO>0801198012345</ns1:COD_CUENTA_FO>
      <ns1:ESTADO>A</ns1:ESTADO>
      <ns1:FEC_SALIDA>2023-12-15T12:00:00</ns1:FEC_SALIDA>
      <ns1:NUM_PERIODO>12</ns1:NUM_PERIODO>
      <ns1:COD_PATRONO>EMP001</ns1:COD_PATRONO>
      <ns1:NOM_PATRONO>EMPRESA EJEMPLO S.A.</ns1:NOM_PATRONO>
      <ns1:RTN_PATRONO>08011980123456</ns1:RTN_PATRONO>
      <ns1:TIP_INGRESO>01</ns1:TIP_INGRESO>
      <ns1:MONTO_PAGADO>25000.00</ns1:MONTO_PAGADO>
      <ns1:SALARIO>30000.00</ns1:SALARIO>
      <ns1:OCUPACION>ANALISTA DE SISTEMAS</ns1:OCUPACION>
      <ns1:PUESTO>DESARROLLADOR SENIOR</ns1:PUESTO>
    </ns1:PT_HIST_LABORAL_ITEM>
  </ns1:PT_HIST_LABORAL>
  <ns1:PN_CODIGO_ERROR>0</ns1:PN_CODIGO_ERROR>
  <ns1:PC_MENSAJE_ERROR/>
</ns1:OutputParameters>
```

## Cadenas de conexión detectadas y credenciales

### Base de Datos FPC
- **Nombre de Conexión**: `eis/DB/ConnectionFicopen`
- **Tipo**: JCA Database Adapter
- **Esquema**: `FO`
- **Package**: `WCONSULTAINFORMACIONLABORALFPC`
- **Stored Procedure**: `FO_WEB_SERVICE$DEME_HIS_INFO_`
- **Archivo JCA**: `Middleware/v2/BusinessServices/FPC/consultaInformacionLaboral/jca/consultaInformacionLaboralFPC_db.jca`

### Servicio WSDL Externo
- **Endpoint WSDL**: `https://dynamoosbdev:8004/regional/pension/soap/getEmploymentInformation/v11g`
- **Operación**: `consultaInformacionLaboral`
- **Protocolo**: HTTPS/SOAP
- **Timeout**: 70 segundos
- **Connection Timeout**: 65 segundos

### Credenciales
- **Referencia de Credenciales**: `Middleware/Security/OSB12AUTH`
- **Tipo**: Basic Authentication
- **Uso**: Para autenticación con el servicio externo

## Tablas de mapeo de entrada por cada llamada a servicio dependiente

### 1. Validación Regional

| Campo Origen (OSB) | Transformación/Script | Campo Destino (ValidaServicioRegional) |
|-------------------|----------------------|---------------------------------------|
| Constante "FICBCO0181" | Valor fijo | PV_SERVICE_ID |
| header/aut:RequestHeader/Region/SourceBank | Mapeo directo | PV_SOURCE_BANK |
| header/aut:RequestHeader/Region/DestinationBank | Mapeo directo | PV_DESTINATION_BANK |

### 2. Servicio Externo getEmploymentInformation12c

**Header Transformation** (`getEmploymentInformationHeaderIn.xq`):

| Campo Origen (OSB) | Transformación/Script | Campo Destino (Servicio Externo) |
|-------------------|----------------------|----------------------------------|
| Constante 'OSB12AUTH' | getUsername($serviceAccountName) | Authentication/UserName |
| Constante 'OSB12AUTH' | getPassword($serviceAccountName) | Authentication/Password |
| header/aut:RequestHeader/Region/SourceBank | Mapeo con lógica: si HN02 → HN01 | Region/SourceBank |
| header/aut:RequestHeader/Region/DestinationBank | Mapeo con lógica: si HN02 → HN01 | Region/DestinationBank |

**Body Transformation** (`getEmploymentInformationIn.xq`):

| Campo Origen (OSB) | Transformación/Script | Campo Destino (Servicio Externo) |
|-------------------|----------------------|----------------------------------|
| CUSTOMER_ACCOUNT | Mapeo directo | CUSTOMER_ACCOUNT |
| FROM_DATE | local:formatDate() - YYYYMMDD → dd/MM/yyyy | FROM_DATE |
| TO_DATE | local:formatDate() - YYYYMMDD → dd/MM/yyyy | TO_DATE |

### 3. Base de Datos FPC

**Transformation** (`consultaInformacionLaboralIn_HNFPC.xq`):

| Campo Origen (OSB) | Transformación/Script | Campo Destino (BD) |
|-------------------|----------------------|-------------------|
| CUSTOMER_ACCOUNT | Mapeo directo | PC_COD_CTA |
| FROM_DATE | local:format-date-FPC() - YYYYMMDD → YYYY-MM-DD | PD_FECHA_INICIO |
| TO_DATE | local:format-date-FPC() - YYYYMMDD → YYYY-MM-DD | PD_FECHA_FIN |

## Tablas de mapeo de salida por cada respuesta de servicio dependiente

### 1. Validación Regional

| Campo Origen (ValidaServicioRegional) | Transformación/Script | Campo Destino (OSB) |
|--------------------------------------|----------------------|-------------------|
| PV_CODIGO_ERROR | Evaluación: si != 'SUCCESS' | successIndicator = 'ERROR' |
| PV_MENSAJE_ERROR | Mapeo directo | messages |

### 2. Servicio Externo getEmploymentInformation12c

**Transformation** (`getEmploymentInformationHNOut.xq`):

| Campo Origen (Servicio Externo) | Transformación/Script | Campo Destino (OSB) |
|--------------------------------|----------------------|-------------------|
| CUSTOMER_ACCOUNT | Mapeo directo | CUSTOMER_ACCOUNT |
| STATUS | Mapeo directo | STATUS |
| END_DATE | Mapeo directo | END_DATE |
| PAYMENT_PERIOD | Mapeo directo | PAYMENT_PERIOD |
| EMPLOYER_CODE | Mapeo directo | EMPLOYER_CODE |
| EMPLOYER_NAME | Mapeo directo | EMPLOYER_NAME |
| EMPLOYER_RTN | Mapeo directo | EMPLOYER_RTN |
| BALANCE_TYPE | Mapeo directo | BALANCE_TYPE |
| PAYMENT_AMOUNT | Mapeo directo | PAYMENT_AMOUNT |
| SALARY_AMOUNT | Mapeo directo | SALARY_AMOUNT |
| OCCUPATION_DESC | Mapeo directo | OCCUPATION_DESC |
| JOB_TITLE_DESC | Mapeo directo | JOB_TITLE_DESC |

**Campos siempre vacíos**:
- START_DATE
- SALARY_CURRENCY
- OCCUPATION_CODE
- JOB_TITLE_CODE

### 3. Base de Datos FPC

**Transformation** (`consultaInformacionLaboralOut_HNFPC.xq`):

| Campo Origen (BD) | Transformación/Script | Campo Destino (OSB) |
|------------------|----------------------|-------------------|
| COD_CUENTA_FO | Mapeo directo | CUSTOMER_ACCOUNT |
| ESTADO | Mapeo directo | STATUS |
| FEC_SALIDA | local:format-date-from-FPC() - timestamp → YYYYMMDDHHMMSS | END_DATE |
| NUM_PERIODO | Mapeo directo | PAYMENT_PERIOD |
| COD_PATRONO | Mapeo directo | EMPLOYER_CODE |
| NOM_PATRONO | Mapeo directo | EMPLOYER_NAME |
| RTN_PATRONO | Mapeo directo | EMPLOYER_RTN |
| TIP_INGRESO | Mapeo directo | BALANCE_TYPE |
| MONTO_PAGADO | Mapeo directo | PAYMENT_AMOUNT |
| SALARIO | Mapeo directo | SALARY_AMOUNT |
| OCUPACION | Mapeo directo | OCCUPATION_DESC |
| PUESTO | Mapeo directo | JOB_TITLE_DESC |

## Reglas de negocio detectadas

### 1. Mapeo de Región HN02 → HN01
- **Ubicación**: `getEmploymentInformationHeaderIn.xq`
- **Archivo**: `Middleware/v2/Resources/ConsultaInformacionLaboral/xq/getEmploymentInformationHeaderIn.xq`
- **Lógica**:
  ```xquery
  let $SourceBank := fn:data($header/aut:RequestHeader/Region/SourceBank)
  return
  if($SourceBank = 'HN02')then ('HN01')else (fn:data($header/aut:RequestHeader/Region/SourceBank))
  ```
- **Descripción**: Cuando SourceBank es HN02, se mapea a HN01 para el servicio externo

### 2. Formato de Fechas de Entrada (Servicio Externo)
- **Ubicación**: `getEmploymentInformationIn.xq`
- **Función**: `local:formatDate()`
- **Lógica**:
  ```xquery
  declare function local:formatDate($date as xs:string) as xs:string{
       let $finalDate := if(not(string-length($date) > 8))then (replace($date, "(\\d{4})(\\d{2})(\\d{2})", "$1-$2-$3"))else($date)
       return
       fn-bea:date-to-string-with-format("dd/MM/yyyy",xs:date($finalDate))
  };
  ```
- **Descripción**: Convierte YYYYMMDD a formato dd/MM/yyyy

### 3. Formato de Fechas de Entrada (Base de Datos)
- **Ubicación**: `consultaInformacionLaboralIn_HNFPC.xq`
- **Función**: `local:format-date-FPC()`
- **Lógica**:
  ```xquery
  declare function local:format-date-FPC($textdate as xs:string) as xs:string
  {
      fn:concat(fn:substring($textdate,1,4),'-',fn:substring($textdate,5,2),'-',fn:substring($textdate,7,2))
  };
  ```
- **Descripción**: Convierte YYYYMMDD a formato YYYY-MM-DD

### 4. Formato de Fechas de Salida (Base de Datos)
- **Ubicación**: `consultaInformacionLaboralOut_HNFPC.xq`
- **Función**: `local:format-date-from-FPC()`
- **Lógica**:
  ```xquery
  declare function local:format-date-from-FPC($textdate as xs:string) as xs:string
  {
      fn:concat(fn:substring($textdate,1,4),fn:substring($textdate,6,2),fn:substring($textdate,9,2),fn:substring($textdate,12,2),fn:substring($textdate,15,2),fn:substring($textdate,18,2))
  };
  ```
- **Descripción**: Convierte timestamp de BD a formato YYYYMMDDHHMMSS

### 5. Manejo de Fechas Opcionales
- **Ubicación**: `consultaInformacionLaboralIn_HNFPC.xq`
- **Lógica**:
  ```xquery
  if (fn:empty($consultaInformacionLaboralRequest1/ns0:FROM_DATE) or fn:empty($consultaInformacionLaboralRequest1/ns0:FROM_DATE/text())) then
      <ns1:PD_FECHA_INICIO/>
  else 
      <ns1:PD_FECHA_INICIO>{ local:format-date-FPC(data($consultaInformacionLaboralRequest1/ns0:FROM_DATE)) }</ns1:PD_FECHA_INICIO>
  ```
- **Descripción**: Si las fechas están vacías, se envían como elementos vacíos

### 6. Validación de Respuesta Exitosa
- **Ubicación**: Pipeline HNFPC_ConsultaInformacionLaboral_response
- **Lógica**: `upper-case($errorCode) = 'SUCCESS'`
- **Descripción**: Determina si la respuesta del servicio externo fue exitosa

### 7. Obtención de Credenciales
- **Ubicación**: `getEmploymentInformationHeaderIn.xq`
- **Funciones**: `getUsername()`, `getPassword()`
- **Lógica**:
  ```xquery
  declare function getUsername ($serviceAccountName as xs:string)  as xs:string { 
      let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($serviceAccountName)))
      return $data/con:username/text()
  };
  ```
- **Descripción**: Obtiene credenciales del almacén de seguridad de OSB