# Ejemplos de Request/Response y Mapeo de Datos - HN01 (Honduras)

## Request OSB (ejemplo SOAP/XML)

```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Header>
    <aut:RequestHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
      <Authentication>
        <UserName>usuario_sistema</UserName>
        <Password>password_sistema</Password>
      </Authentication>
      <SourceBank>HN01</SourceBank>
      <ServiceId>FICBCO0398</ServiceId>
    </aut:RequestHeader>
  </soap:Header>
  <soap:Body>
    <tns:consultaConsolidadaRiesgoCliente xmlns:tns="http://www.ficohsa.com.hn/middleware.services/consultaConsolidadaRiesgoClienteTypes">
      <CUSTOMER_LEGAL_ID>0801199012345</CUSTOMER_LEGAL_ID>
    </tns:consultaConsolidadaRiesgoCliente>
  </soap:Body>
</soap:Envelope>
```

## Response OSB (ejemplo SOAP/XML)

```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Header>
    <aut:ResponseHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
      <successIndicator>Success</successIndicator>
      <messages>Consulta exitosa</messages>
    </aut:ResponseHeader>
  </soap:Header>
  <soap:Body>
    <tns:consultaConsolidadaRiesgoClienteResponse xmlns:tns="http://www.ficohsa.com.hn/middleware.services/consultaConsolidadaRiesgoClienteTypes">
      <LOAN_MAINTENANCE>
        <CUSTOMER_INFO>
          <ID>0801199012345</ID>
          <TARGET>PREMIUM</TARGET>
          <DATE_OF_BIRTH>1990-01-01</DATE_OF_BIRTH>
          <AGE>34</AGE>
          <TYPE>PERSONA_NATURAL</TYPE>
          <SALARY>50000.00</SALARY>
          <PAYROLL_SALARY>45000.00</PAYROLL_SALARY>
          <CREDIT_MONTHS>12</CREDIT_MONTHS>
          <FLAG_BLAZE>Y</FLAG_BLAZE>
          <FLAG_HIT>N</FLAG_HIT>
          <EVALUATION_RESULT>APROBADO</EVALUATION_RESULT>
          <EXTERNAL_SCORE>750.0</EXTERNAL_SCORE>
          <SCORE_INFO>
            <SCORE_CALCULATION>720.5</SCORE_CALCULATION>
            <QUALIFICATION>A</QUALIFICATION>
            <RISK_LEVEL>BAJO</RISK_LEVEL>
          </SCORE_INFO>
          <ASSETS>
            <ASSET>
              <NUMBER>1234567890</NUMBER>
              <CATEGORY>AHORRO</CATEGORY>
              <CURRENCY>HNL</CURRENCY>
              <OPENING_DATE>2020-01-15</OPENING_DATE>
              <CURRENT_BALANCE>25000.50</CURRENT_BALANCE>
              <END_OF_MONTH_BALANCE>24500.00</END_OF_MONTH_BALANCE>
              <AVERAGE_BALANCE>23000.00</AVERAGE_BALANCE>
            </ASSET>
          </ASSETS>
          <LIABILITIES>
            <CREDIT_CARDS_INFO>
              <CREDIT_CARD>
                <ACCOUNT>4567890123456789</ACCOUNT>
                <BEHAVIOR_SCORE>680.0</BEHAVIOR_SCORE>
                <QUALIFICATION_SCORE>B</QUALIFICATION_SCORE>
                <STATUS>ACTIVA</STATUS>
                <CURRENT_LIMIT>100000.00</CURRENT_LIMIT>
                <CURRENT_BALANCE>15000.00</CURRENT_BALANCE>
                <AVAILABLE_CASH>85000.00</AVAILABLE_CASH>
              </CREDIT_CARD>
            </CREDIT_CARDS_INFO>
            <LOANS_INFO>
              <LOAN>
                <NUMBER>PTM-2023-001234</NUMBER>
                <OPENING_DATE>2023-01-15</OPENING_DATE>
                <INITIAL_AMOUNT>200000.00</INITIAL_AMOUNT>
                <CURRENT_BALANCE>150000.00</CURRENT_BALANCE>
                <PAYMENT_AMOUNT>5500.00</PAYMENT_AMOUNT>
                <RATE>12.5</RATE>
                <TERM>36.0</TERM>
              </LOAN>
            </LOANS_INFO>
          </LIABILITIES>
        </CUSTOMER_INFO>
      </LOAN_MAINTENANCE>
      <LOAN_ORIGINATIONS>
        <PRE_APPROVED_OFFERS>
          <OFFER>
            <TYPE>FICOCREDITO</TYPE>
            <DETAILS>
              <FOR_12_MONTHS>50000.00</FOR_12_MONTHS>
              <FOR_24_MONTHS>75000.00</FOR_24_MONTHS>
              <FOR_36_MONTHS>100000.00</FOR_36_MONTHS>
            </DETAILS>
            <INSTALLMENT>3500.00</INSTALLMENT>
            <RATE>15</RATE>
            <TIMES_INCOME>2</TIMES_INCOME>
          </OFFER>
        </PRE_APPROVED_OFFERS>
      </LOAN_ORIGINATIONS>
    </tns:consultaConsolidadaRiesgoClienteResponse>
  </soap:Body>
</soap:Envelope>
```

## Requests/Responses Internos a Servicios Dependientes

### 1. Consulta a consultaRutaRegional_db

**Request:**
```xml
<ns0:InputParameters xmlns:ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaRutaRegional">
  <ns0:P_ID_SERVICIO>FICBCO0398</ns0:P_ID_SERVICIO>
  <ns0:P_USUARIO>usuario_sistema</ns0:P_USUARIO>
  <ns0:P_OPERACION>consultaConsolidadaRiesgoCliente</ns0:P_OPERACION>
  <ns0:P_VERSION>V2</ns0:P_VERSION>
</ns0:InputParameters>
```

**Response:**
```xml
<ns0:OutputParameters xmlns:ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaRutaRegional">
  <ns0:PV_CODIGO_ERROR>SUCCESS</ns0:PV_CODIGO_ERROR>
  <ns0:PV_MENSAJE_ERROR></ns0:PV_MENSAJE_ERROR>
  <ns0:PV_UBICACION>Middleware/v2/ProxyServices/ConsultaConsolidadaRiesgoClienteHN</ns0:PV_UBICACION>
</ns0:OutputParameters>
```

### 2. Consulta al Stored Procedure Principal

**Request:**
```xml
<ns0:InputParameters xmlns:ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaConsolidadRiesgoCliente">
  <ns0:IDENTIDAD>0801199012345</ns0:IDENTIDAD>
</ns0:InputParameters>
```

**Response:**
```xml
<ns0:OutputParameters xmlns:ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaConsolidadRiesgoCliente">
  <ns0:RowSet>
    <ns0:Row>
      <ns0:Column name="XML_DATA" sqltype="NVARCHAR">
        <![CDATA[
        <root>
          <IDENTIDAD>0801199012345</IDENTIDAD>
          <SEGMENTOCLIENTE>PREMIUM</SEGMENTOCLIENTE>
          <FECHANACIMIENTO>1990-01-01</FECHANACIMIENTO>
          <EDAD>34</EDAD>
          <!-- XML complejo con toda la información del cliente -->
        </root>
        ]]>
      </ns0:Column>
    </ns0:Row>
  </ns0:RowSet>
</ns0:OutputParameters>
```

## Cadenas de Conexión y Credenciales

### Base de Datos Principal
- **Nombre de Conexión**: eis/DB/ConnectionCustomerCreditRisk
- **Base de Datos**: CREDITOS_RIESGOS
- **Esquema**: CREDITOS_RIESGOS
- **Package**: dbo
- **Stored Procedure**: p_consulta_ONBASE_V2
- **Tipo de Conexión**: JCA Database Adapter
- **Modo de Conexión**: Managed

### Servicios WSDL
- **Endpoint Principal**: http://172.23.13.19:8003/Middleware/OperationsAndExecution/Cards/consultaConsolidadaRiesgoCliente/
- **Operación**: consultaConsolidadaRiesgoCliente
- **Namespace**: http://www.ficohsa.com.hn/middleware.services/consultaConsolidadaRiesgoClientePS/

## Tablas de Mapeo de Entrada

### Mapeo OSB → Stored Procedure

| Campo Origen (OSB) | Transformación/Script | Campo Destino (SP) |
|-------------------|----------------------|-------------------|
| CUSTOMER_LEGAL_ID | data($consultaConsolidadaRiesgoCliente/CUSTOMER_LEGAL_ID) | IDENTIDAD |

**Archivo de Transformación**: `consultaConsolidadaRiesgoClienteIn.xq`

## Tablas de Mapeo de Salida

### Mapeo Stored Procedure → OSB Response

| Campo Origen (SP) | Transformación/Script | Campo Destino (OSB) |
|------------------|----------------------|-------------------|
| IDENTIDAD | data($IDENTIDAD) | ID |
| SEGMENTOCLIENTE | data($TARGET) | TARGET |
| FECHANACIMIENTO | fn-bea:date-from-string-with-format("yyyy-MM-dd",data($DATE_OF_BIRTH)) | DATE_OF_BIRTH |
| EDAD | xs:int(data($AGE)) | AGE |
| TIPOCLIENTE | data($TYPE) | TYPE |
| SALARIOCLIENTE | data($SALARY) | SALARY |
| MONTOLPSPLANILLA | data($PAYROLL_SALARY) | PAYROLL_SALARY |
| MESPLANILLA | data($CREDIT_MONTHS) | CREDIT_MONTHS |
| FLAGBLAZE | data($FLAG_BLAZE) | FLAG_BLAZE |
| FLAGHIT | data($FLAG_HIT) | FLAG_HIT |
| CALIFICACIONSCORE | data($QUALIFICATION) | QUALIFICATION |
| NIVELRIESGO | data($RISK_LEVEL) | RISK_LEVEL |

**Archivo de Transformación**: `consultaConsolidadaRiesgoClienteOut.xq`

### Mapeo de Header Response

| Campo Origen (SP) | Transformación/Script | Campo Destino (Header) |
|------------------|----------------------|----------------------|
| RowSet count | if(count($rowOne/*) > 0) | successIndicator: "Success" |
| RowSet empty | else | successIndicator: "NO RECORS", messages: "NO RECORDS FOUND" |

**Archivo de Transformación**: `consultaConsolidadaRiesgoClienteHeaderOut.xq`

## Reglas de Negocio Detectadas

### 1. Validación de Entrada
- **Ubicación**: ValidacionXSD stage en ConsultaConsolidadaRiesgoCliente.proxy
- **Regla**: CUSTOMER_LEGAL_ID debe tener mínimo 1 carácter
- **Implementación**: XSD validation usando consultaConsolidadaRiesgoClienteTypes.xsd

### 2. Enrutamiento Regional
- **Ubicación**: ConsultaRutaRegional stage
- **Regla**: Determinar proxy de destino basado en serviceId FICBCO0398
- **Implementación**: Consulta a consultaRutaRegional_db con parámetros de header

### 3. Parsing de XML Incrustado
- **Ubicación**: ConsultaConsolidadRiesgoCliente stage en ConsultaConsolidadaRiesgoClienteHN.proxy
- **Regla**: Extraer XML del primer column del primer row del RowSet
- **Implementación**: `fn-bea:inlinedXML($RSPConsultaConsolidadRiesgoCliente/con1:RowSet/con1:Row[1]/con1:Column[1]/text())`

### 4. Transformación de Fechas
- **Ubicación**: consultaConsolidadaRiesgoClienteOut.xq
- **Regla**: Convertir fechas de formato dd/MM/yyyy a yyyy-MM-dd, validar "00/00/0000"
- **Implementación**: 
  ```xquery
  if(data($recordh/@infoDate) != "00/00/0000") then (
    fn-bea:date-to-string-with-format("yyyy-MM-dd",
      fn-bea:date-from-string-with-format("dd/MM/yyyy",data($recordh/@infoDate)))
  ) else ()
  ```

### 5. Agregación de Disponibles de Tarjeta
- **Ubicación**: consultaConsolidadaRiesgoClienteOut.xq
- **Regla**: Sumar DISPONIBLE_1 a DISPONIBLE_12 para obtener AVAILABLE_CASH
- **Implementación**:
  ```xquery
  let $disponible := (data($card/@DISPONIBLE_1), data($card/@DISPONIBLE_2), ..., data($card/@DISPONIBLE_12))
  return sum($disponible)
  ```

### 6. Manejo de Errores
- **Ubicación**: MapeoError stage y Error Handler
- **Regla**: Homologar errores usando código FICBCO0398 como prefijo
- **Implementación**: Concatenación "FICBCO0398$#$" + mensaje de error original

### 7. Validación de Datos Vacíos
- **Ubicación**: Múltiples ubicaciones en consultaConsolidadaRiesgoClienteOut.xq
- **Regla**: Aplicar fn-bea:trim() y validar campos no vacíos antes de mapear
- **Implementación**: `fn-bea:trim(data($field))` para strings, validaciones condicionales para fechas