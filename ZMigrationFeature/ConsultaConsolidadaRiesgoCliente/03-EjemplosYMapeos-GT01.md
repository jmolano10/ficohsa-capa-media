# Ejemplos de Request/Response y Mapeo de Datos - GT01 (Guatemala)

## Request OSB (Ejemplo JSON/XML)

### SOAP Request
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Header>
    <aut:RequestHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
      <Authentication>
        <UserName>usuario_gt</UserName>
        <Password>password123</Password>
      </Authentication>
      <Region>
        <SourceBank>GT01</SourceBank>
      </Region>
    </aut:RequestHeader>
  </soap:Header>
  <soap:Body>
    <con:consultaConsolidadaRiesgoCliente xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaConsolidadaRiesgoClienteTypes">
      <CUSTOMER_LEGAL_ID>1234567890123</CUSTOMER_LEGAL_ID>
      <FISCAL_ID>12345678</FISCAL_ID>
      <FIRST_NAME>JUAN</FIRST_NAME>
      <LAST_NAME>PEREZ</LAST_NAME>
      <BIRTH_DATE>1985-05-15</BIRTH_DATE>
      <USER_NAME>usuario_gt</USER_NAME>
      <PERSON_TYPE>F</PERSON_TYPE>
      <PRODUCT_CODE>CREDITO</PRODUCT_CODE>
    </con:consultaConsolidadaRiesgoCliente>
  </soap:Body>
</soap:Envelope>
```

## Response OSB (Ejemplo JSON/XML)

### SOAP Response
```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Header>
    <aut:ResponseHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
      <successIndicator>Success</successIndicator>
    </aut:ResponseHeader>
  </soap:Header>
  <soap:Body>
    <con:consultaConsolidadaRiesgoClienteResponse xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaConsolidadaRiesgoClienteTypes">
      <LOAN_MAINTENANCE>
        <CUSTOMER_INFO>
          <ID>1234567890123</ID>
          <FISCAL_ID>12345678</FISCAL_ID>
          <FIRST_NAME>JUAN</FIRST_NAME>
          <LAST_NAME>PEREZ</LAST_NAME>
          <DATE_OF_BIRTH>1985-05-15</DATE_OF_BIRTH>
          <AGE>38</AGE>
          <TYPE>PERSONA_FISICA</TYPE>
          <SALARY>15000.00</SALARY>
          <FLAG_BLAZE>Y</FLAG_BLAZE>
          <ADDRESSES_INFO>
            <ADDRESS_ITEM>
              <ADDRESS>ZONA 10, GUATEMALA CITY</ADDRESS>
            </ADDRESS_ITEM>
          </ADDRESSES_INFO>
          <PHONES_INFO>
            <PHONE_ITEM>
              <PHONE>50212345678</PHONE>
            </PHONE_ITEM>
          </PHONES_INFO>
          <EXTERNAL_SCORE>750.5</EXTERNAL_SCORE>
          <LIABILITIES>
            <CREDIT_CARDS_INFO>
              <CREDIT_CARD>
                <ACCOUNT>4111111111111111</ACCOUNT>
                <BEHAVIOR_SCORE>720.0</BEHAVIOR_SCORE>
                <QUALIFICATION_SCORE>A</QUALIFICATION_SCORE>
                <STATUS>ACTIVA</STATUS>
                <CURRENT_LIMIT>50000.00</CURRENT_LIMIT>
                <CURRENT_BALANCE>15000.00</CURRENT_BALANCE>
              </CREDIT_CARD>
            </CREDIT_CARDS_INFO>
            <LOANS_INFO>
              <LOAN>
                <AGENCY_CODE>001</AGENCY_CODE>
                <INITIAL_AMOUNT>100000.00</INITIAL_AMOUNT>
                <CURRENT_BALANCE>75000.00</CURRENT_BALANCE>
                <RATE>12.5</RATE>
              </LOAN>
            </LOANS_INFO>
          </LIABILITIES>
          <REFERENCIA_SIB>GT123456789</REFERENCIA_SIB>
        </CUSTOMER_INFO>
      </LOAN_MAINTENANCE>
      <LOAN_ORIGINATIONS>
        <REFERENCES_DETAILS>
          <QUERIES>
            <QUERY_ITEM>
              <DATE>2023-10-15</DATE>
              <ENTITY>BANCO_INDUSTRIAL</ENTITY>
              <TYPE>CREDITO</TYPE>
              <MOTIVE>EVALUACION</MOTIVE>
            </QUERY_ITEM>
          </QUERIES>
          <REFERENCE_BUREAU_TUCA>
            <REFERENCE>
              <CREDITOR>BANCO_INDUSTRIAL</CREDITOR>
              <CREDIT_TYPE>PERSONAL</CREDIT_TYPE>
              <BALANCE>25000.00</BALANCE>
              <STATUS>VIGENTE</STATUS>
            </REFERENCE>
          </REFERENCE_BUREAU_TUCA>
          <REFERENCE_BUREAU_SIRC>
            <REFERENCE>
              <CREDITOR>BANCO_AGROMERCANTIL</CREDITOR>
              <ASSET_TYPE>PRESTAMO</ASSET_TYPE>
              <BALANCE>50000.00</BALANCE>
              <STATUS>VIGENTE</STATUS>
            </REFERENCE>
          </REFERENCE_BUREAU_SIRC>
        </REFERENCES_DETAILS>
      </LOAN_ORIGINATIONS>
    </con:consultaConsolidadaRiesgoClienteResponse>
  </soap:Body>
</soap:Envelope>
```

## Requests/Responses Internos a Servicios Dependientes

### 1. Servicio SJS (sjConsultaConsolidadaRiesgoClienteGT)

#### Request Interno
```xml
<sjConsultaConsolidadaRiesgoClienteGTRequest>
  <CUSTOMER_LEGAL_ID>1234567890123</CUSTOMER_LEGAL_ID>
  <FISCAL_ID>12345678</FISCAL_ID>
  <FIRST_NAME>JUAN</FIRST_NAME>
  <LAST_NAME>PEREZ</LAST_NAME>
  <BIRTH_DATE>1985-05-15</BIRTH_DATE>
  <USER_NAME>usuario_gt</USER_NAME>
  <PERSON_TYPE>F</PERSON_TYPE>
  <PRODUCT_CODE>CREDITO</PRODUCT_CODE>
</sjConsultaConsolidadaRiesgoClienteGTRequest>
```

#### Response Interno
```xml
<sjConsultaConsolidadaRiesgoClienteGTResponse>
  <APPLICANT_RESPONSE>
    <APPLICANT>
      <BIRTH_DATE>1985-05-15</BIRTH_DATE>
      <AGE>38</AGE>
      <CUSTOMER_TYPE>PERSONA_FISICA</CUSTOMER_TYPE>
      <CUSTOMER_SALARY>15000.00</CUSTOMER_SALARY>
      <FLAG_BLAZE>Y</FLAG_BLAZE>
    </APPLICANT>
  </APPLICANT_RESPONSE>
  <CARDS_RESPONSE>
    <CARDS>
      <ACCOUNT_NUMBER>4111111111111111</ACCOUNT_NUMBER>
      <BEHAVIOR_SCORE>720.0</BEHAVIOR_SCORE>
      <RATING_SCORE>A</RATING_SCORE>
      <STATUS>ACTIVA</STATUS>
      <CURRENT_LIMIT>50000.00</CURRENT_LIMIT>
      <CURRENT_BALANCE>15000.00</CURRENT_BALANCE>
    </CARDS>
  </CARDS_RESPONSE>
  <LOANS_RESPONSE>
    <LOANS>
      <AGENCY_CODE>001</AGENCY_CODE>
      <INITIAL_AMOUNT>100000.00</INITIAL_AMOUNT>
      <CURRENT_BALANCE>75000.00</CURRENT_BALANCE>
      <RATE>12.5</RATE>
    </LOANS>
  </LOANS_RESPONSE>
</sjConsultaConsolidadaRiesgoClienteGTResponse>
```

### 2. Servicio de Burós de Crédito (consultaBurosPrecreditoGT)

#### Request Interno
```xml
<ns1:ConsultaBuros xmlns:ns1="http://tempuri.org/">
  <ns1:MSGPRE>
    <ns1:HEADER>
      <ns1:KEY>GT_BUROS_KEY_12345</ns1:KEY>
      <ns1:CODIGO_EMPRESA>1</ns1:CODIGO_EMPRESA>
      <ns1:RELACION_PROSPECTO>DE</ns1:RELACION_PROSPECTO>
      <ns1:TIPO_PERSONA>F</ns1:TIPO_PERSONA>
      <ns1:CODIGO_PRODUCTO>CREDITO</ns1:CODIGO_PRODUCTO>
      <ns1:USUARIO>usuario_gt</ns1:USUARIO>
      <ns1:PC>Ficohsa</ns1:PC>
      <ns1:IP>192.168.1.1</ns1:IP>
    </ns1:HEADER>
    <ns1:BODY>
      <ns1:NIT>12345678</ns1:NIT>
      <ns1:PRIMER_NOMBRE>JUAN</ns1:PRIMER_NOMBRE>
      <ns1:SEGUNDO_NOMBRE/>
      <ns1:TERCER_NOMBRE/>
      <ns1:PRIMER_APELLIDO>PEREZ</ns1:PRIMER_APELLIDO>
      <ns1:SEGUNDO_APELLIDO/>
      <ns1:TERCER_APELLIDO/>
      <ns1:PASAPORTE/>
      <ns1:PAIS_PASAPORTE/>
      <ns1:DPI>1234567890123</ns1:DPI>
      <ns1:FECHA_NACIMIENTO>1985-05-15</ns1:FECHA_NACIMIENTO>
    </ns1:BODY>
  </ns1:MSGPRE>
</ns1:ConsultaBuros>
```

#### Response Interno
```xml
<ns1:ConsultaBurosResponse xmlns:ns1="http://tempuri.org/">
  <ns1:MSGPRE>
    <ns1:BODY>
      <ns1:ESTADO_CONSULTA>
        <ns1:CODIGO>1</ns1:CODIGO>
        <ns1:MENSAJE>Consulta exitosa</ns1:MENSAJE>
      </ns1:ESTADO_CONSULTA>
      <ns1:TRANSUNION>
        <ns1:INFORMACION_CLIENTE>
          <ns1:DIRECCIONES>
            <ns1:DIRECCION>
              <ns1:DESC>ZONA 10, GUATEMALA CITY</ns1:DESC>
            </ns1:DIRECCION>
          </ns1:DIRECCIONES>
          <ns1:TELEFONOS>
            <ns1:TELEFONO>
              <ns1:TELEFONO>50212345678</ns1:TELEFONO>
            </ns1:TELEFONO>
          </ns1:TELEFONOS>
        </ns1:INFORMACION_CLIENTE>
        <ns1:MODELOS_ANALISIS>
          <ns1:MODELO>
            <ns1:RESULTADO>750.5</ns1:RESULTADO>
          </ns1:MODELO>
        </ns1:MODELOS_ANALISIS>
        <ns1:LISTA_CONSULTAS>
          <ns1:CONSULTA>
            <ns1:FECHA_CONSULTA>2023-10-15</ns1:FECHA_CONSULTA>
            <ns1:ENTIDAD_CONSULTANTE>BANCO_INDUSTRIAL</ns1:ENTIDAD_CONSULTANTE>
            <ns1:TIPO_CONSULTA>CREDITO</ns1:TIPO_CONSULTA>
            <ns1:MOTIVO>EVALUACION</ns1:MOTIVO>
          </ns1:CONSULTA>
        </ns1:LISTA_CONSULTAS>
        <ns1:COMPORTAMIENTO_OBLIGACIONES>
          <ns1:OBLIGACION TIPO="CREDITO" SECTOR="BANCARIO">
            <ns1:NUMERO>REF123456</ns1:NUMERO>
            <ns1:ENTIDAD_INFORMANTE>BANCO_INDUSTRIAL</ns1:ENTIDAD_INFORMANTE>
            <ns1:TIPO>PERSONAL</ns1:TIPO>
            <ns1:COMPORTAMIENTO_PAGO>
              <ns1:SALDO_ACTUAL>25000.00</ns1:SALDO_ACTUAL>
              <ns1:ESTADO>VIGENTE</ns1:ESTADO>
            </ns1:COMPORTAMIENTO_PAGO>
          </ns1:OBLIGACION>
        </ns1:COMPORTAMIENTO_OBLIGACIONES>
      </ns1:TRANSUNION>
      <ns1:SIRC>
        <ns1:REFERENCIA_SIB>GT123456789</ns1:REFERENCIA_SIB>
        <ns1:DIRECTOS>
          <ns1:DEUDAS_VIGENTES>
            <ns1:ENTIDAD>BANCO_AGROMERCANTIL</ns1:ENTIDAD>
            <ns1:DESC_TIPO_ACTIVO>PRESTAMO</ns1:DESC_TIPO_ACTIVO>
            <ns1:SALDO>50000.00</ns1:SALDO>
            <ns1:FECHA_ACTIVO>2022-01-15</ns1:FECHA_ACTIVO>
          </ns1:DEUDAS_VIGENTES>
        </ns1:DIRECTOS>
      </ns1:SIRC>
    </ns1:BODY>
  </ns1:MSGPRE>
</ns1:ConsultaBurosResponse>
```

## Cadenas de Conexión y Credenciales

### Base de Datos
- **Conexión**: `jca://eis/DB/ConnectionCustomerCreditRisk`
- **Esquema**: `CREDITOS_RIESGOS`
- **Package**: `dbo`
- **Stored Procedure**: `p_consulta_ONBASE`
- **Parámetro**: `IDENTIDAD` (SYSNAME, 20 caracteres)

### Servicios WSDL
- **sjConsultaConsolidadaRiesgoClienteGT**:
  - Endpoint: Servicio SJS interno
  - Operación: `sjConsultaConsolidadaRiesgoClienteGT`
  
- **consultaBurosPrecreditoGT**:
  - Endpoint: Servicio de burós de crédito
  - Operación: `ConsultaBuros`

### Parámetros de Configuración
- **KEY Parameter**: `FICBCO0398.GT01.KEY`
- **Service**: `ObtenerParametrizacion`
- **Operation**: `obtenerParametrizacion`

## Tablas de Mapeo de Entrada

### Mapeo OSB → Servicio SJS
| Campo Origen (OSB) | Transformación/Script | Campo Destino (SJS) |
|-------------------|----------------------|-------------------|
| CUSTOMER_LEGAL_ID | Directo | CUSTOMER_LEGAL_ID |
| FISCAL_ID | Directo | FISCAL_ID |
| FIRST_NAME | Directo | FIRST_NAME |
| LAST_NAME | Directo | LAST_NAME |
| BIRTH_DATE | Directo | BIRTH_DATE |
| USER_NAME | Directo | USER_NAME |
| PERSON_TYPE | Directo | PERSON_TYPE |
| PRODUCT_CODE | Directo | PRODUCT_CODE |

### Mapeo OSB → Burós de Crédito
| Campo Origen (OSB) | Transformación/Script | Campo Destino (Burós) |
|-------------------|----------------------|---------------------|
| CUSTOMER_LEGAL_ID | Directo | DPI |
| FISCAL_ID | Directo | NIT |
| FIRST_NAME | Directo | PRIMER_NOMBRE |
| LAST_NAME | Directo | PRIMER_APELLIDO |
| BIRTH_DATE | Directo | FECHA_NACIMIENTO |
| PERSON_TYPE | Directo | TIPO_PERSONA |
| PRODUCT_CODE | Directo | CODIGO_PRODUCTO |
| USER_NAME | Directo | USUARIO |
| $KEY | Parámetro configuración | KEY |
| "192.168.1.1" | Valor fijo | IP |
| "Ficohsa" | Valor fijo | PC |
| "1" | Valor fijo | CODIGO_EMPRESA |
| "DE" | Valor fijo | RELACION_PROSPECTO |

## Tablas de Mapeo de Salida

### Mapeo SJS → OSB
| Campo Origen (SJS) | Transformación/Script | Campo Destino (OSB) |
|-------------------|----------------------|-------------------|
| APPLICANT[1]/BIRTH_DATE | Directo | DATE_OF_BIRTH |
| APPLICANT[1]/AGE | Directo | AGE |
| APPLICANT[1]/CUSTOMER_TYPE | Directo | TYPE |
| APPLICANT[1]/CUSTOMER_SALARY | Directo | SALARY |
| APPLICANT[1]/FLAG_BLAZE | Directo | FLAG_BLAZE |
| CARDS/ACCOUNT_NUMBER | Directo | CREDIT_CARD/ACCOUNT |
| CARDS/BEHAVIOR_SCORE | Directo | CREDIT_CARD/BEHAVIOR_SCORE |
| CARDS/RATING_SCORE | Directo | CREDIT_CARD/QUALIFICATION_SCORE |
| LOANS/AGENCY_CODE | Directo | LOAN/AGENCY_CODE |
| LOANS/INITIAL_AMOUNT | Directo | LOAN/INITIAL_AMOUNT |

### Mapeo Burós → OSB
| Campo Origen (Burós) | Transformación/Script | Campo Destino (OSB) |
|---------------------|----------------------|-------------------|
| DIRECCIONES/DIRECCION/DESC | Directo | ADDRESSES_INFO/ADDRESS_ITEM/ADDRESS |
| TELEFONOS/TELEFONO/TELEFONO | Directo | PHONES_INFO/PHONE_ITEM/PHONE |
| MODELOS_ANALISIS/MODELO/RESULTADO | Directo | EXTERNAL_SCORE |
| SIRC/REFERENCIA_SIB | Directo | REFERENCIA_SIB |
| LISTA_CONSULTAS/CONSULTA/FECHA_CONSULTA | Directo | QUERIES/QUERY_ITEM/DATE |
| LISTA_CONSULTAS/CONSULTA/ENTIDAD_CONSULTANTE | Directo | QUERIES/QUERY_ITEM/ENTITY |
| COMPORTAMIENTO_OBLIGACIONES/OBLIGACION/ENTIDAD_INFORMANTE | Directo | REFERENCE_BUREAU_TUCA/REFERENCE/CREDITOR |
| DIRECTOS/DEUDAS_VIGENTES/ENTIDAD | Directo | REFERENCE_BUREAU_SIRC/REFERENCE/CREDITOR |

## Reglas de Negocio Detectadas

### 1. Validación de Estado de Burós
- **Ubicación**: `ConsultaConsolidadaRiesgoClienteGT.pipeline` línea ~150
- **Regla**: `$errorCode = '1'` indica consulta exitosa
- **Lógica**: Si código ≠ '1', retorna error con mensaje de validación

### 2. Obtención de Parámetros Regionales
- **Ubicación**: `ConsultaConsolidadaRiesgoClienteGT.pipeline` línea ~80
- **Regla**: `fn:concat("FICBCO0398.", fn:data($header/aut:RequestHeader/Region/SourceBank), ".KEY")`
- **Lógica**: Construye nombre de parámetro basado en región

### 3. Mapeo de Datos de Entrada para Burós
- **Ubicación**: `consultaBurosGT.xqy`
- **Regla**: Mapeo específico de campos OSB a formato de burós
- **Lógica**: CUSTOMER_LEGAL_ID → DPI, FISCAL_ID → NIT

### 4. Consolidación de Respuestas
- **Ubicación**: `consultaConsolidadaRiesgoClienteGTOut.xqy`
- **Regla**: Consolidación de datos de SJS y burós de crédito
- **Lógica**: Combina información interna con datos externos de burós

### 5. Manejo de Fechas de Nacimiento
- **Ubicación**: `consultaConsolidadaRiesgoClienteGTOut.xqy` línea ~15
- **Regla**: Prioridad de fecha de nacimiento del request sobre SJS
- **Lógica**: `if ((exists($consultaConsolidadaRiesgoCliente/BIRTH_DATE) and string($consultaConsolidadaRiesgoCliente/BIRTH_DATE) != '')) then ... else ...`

### 6. Construcción de Referencias de Burós
- **Ubicación**: `consultaConsolidadaRiesgoClienteGTOut.xqy` líneas 200+
- **Regla**: Mapeo específico por tipo de referencia (DirectosVigentes, DirectosCancelados, etc.)
- **Lógica**: Diferentes secciones SIRC mapeadas a tipos específicos de referencia