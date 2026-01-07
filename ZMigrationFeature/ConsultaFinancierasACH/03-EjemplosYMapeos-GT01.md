# Ejemplos de Request/Response y Mapeo de Datos - GT01 (Guatemala)

## Request OSB (ejemplo SOAP/XML)

```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Header>
    <aut:RequestHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
      <Authentication>
        <UserName>USUARIO_GT</UserName>
        <Password>PASSWORD_GT</Password>
      </Authentication>
      <Region>
        <SourceBank>GT01</SourceBank>
        <DestinationBank>GT01</DestinationBank>
      </Region>
    </aut:RequestHeader>
  </soap:Header>
  <soap:Body>
    <con:consultaFinancierasACH xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaFinancierasACHTypes">
      <DESTINATION_CODE>101</DESTINATION_CODE>
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
          <DESTINATION_CODE>101</DESTINATION_CODE>
          <DESTINATION_NAME>BANCO INDUSTRIAL GT</DESTINATION_NAME>
          <con:consultaFinancierasACHDetailResponseType>
            <con:consultaFinancierasACHDetailResponseRecordType>
              <TYPE_OF_PRODUCT>CUENTA_MONETARIA</TYPE_OF_PRODUCT>
              <MIN_PRODUCT_ID_LENGTH>12</MIN_PRODUCT_ID_LENGTH>
              <MAX_PRODUCT_ID_LENGTH>16</MAX_PRODUCT_ID_LENGTH>
              <LEADING_ZEROS_YES_NO>YES</LEADING_ZEROS_YES_NO>
              <PRODUCT_ID_SAMPLE>123456789012</PRODUCT_ID_SAMPLE>
              <TRANSFER_TYPE>ACH_CREDIT</TRANSFER_TYPE>
            </con:consultaFinancierasACHDetailResponseRecordType>
            <con:consultaFinancierasACHDetailResponseRecordType>
              <TYPE_OF_PRODUCT>CUENTA_AHORRO</TYPE_OF_PRODUCT>
              <MIN_PRODUCT_ID_LENGTH>12</MIN_PRODUCT_ID_LENGTH>
              <MAX_PRODUCT_ID_LENGTH>16</MAX_PRODUCT_ID_LENGTH>
              <LEADING_ZEROS_YES_NO>YES</LEADING_ZEROS_YES_NO>
              <PRODUCT_ID_SAMPLE>987654321098</PRODUCT_ID_SAMPLE>
              <TRANSFER_TYPE>ACH_DEBIT</TRANSFER_TYPE>
            </con:consultaFinancierasACHDetailResponseRecordType>
          </con:consultaFinancierasACHDetailResponseType>
        </con:consultaFinancierasACHResponseRecordType>
      </con:consultaFinancierasACHResponseType>
    </con:consultaFinancierasACHResponse>
  </soap:Body>
</soap:Envelope>
```

## Request/Response Interno a Base de Datos Oracle

### Request a Stored Procedure

```xml
<ns0:InputParameters xmlns:ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaFinancierasACH">
  <ns0:DESTINATION_CODE>101</ns0:DESTINATION_CODE>
</ns0:InputParameters>
```

### Response de Stored Procedure

```xml
<ns0:OutputParameters xmlns:ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaFinancierasACH">
  <ns0:DESTINATION_CODES>
    <ns0:DESTINATION_CODES_ITEM>101</ns0:DESTINATION_CODES_ITEM>
    <ns0:DESTINATION_CODES_ITEM>101</ns0:DESTINATION_CODES_ITEM>
    <ns0:DESTINATION_CODES_ITEM>101</ns0:DESTINATION_CODES_ITEM>
    <ns0:DESTINATION_CODES_ITEM>101</ns0:DESTINATION_CODES_ITEM>
  </ns0:DESTINATION_CODES>
  <ns0:DESTINATION_NAMES>
    <ns0:DESTINATION_NAMES_ITEM>BANCO INDUSTRIAL GT</ns0:DESTINATION_NAMES_ITEM>
    <ns0:DESTINATION_NAMES_ITEM>BANCO INDUSTRIAL GT</ns0:DESTINATION_NAMES_ITEM>
    <ns0:DESTINATION_NAMES_ITEM>BANCO INDUSTRIAL GT</ns0:DESTINATION_NAMES_ITEM>
    <ns0:DESTINATION_NAMES_ITEM>BANCO INDUSTRIAL GT</ns0:DESTINATION_NAMES_ITEM>
  </ns0:DESTINATION_NAMES>
  <ns0:TYPE_OF_PRODUCTS>
    <ns0:TYPE_OF_PRODUCTS_ITEM>CUENTA_MONETARIA</ns0:TYPE_OF_PRODUCTS_ITEM>
    <ns0:TYPE_OF_PRODUCTS_ITEM>CUENTA_AHORRO</ns0:TYPE_OF_PRODUCTS_ITEM>
    <ns0:TYPE_OF_PRODUCTS_ITEM>CUENTA_CORRIENTE</ns0:TYPE_OF_PRODUCTS_ITEM>
    <ns0:TYPE_OF_PRODUCTS_ITEM>CUENTA_PLAZO</ns0:TYPE_OF_PRODUCTS_ITEM>
  </ns0:TYPE_OF_PRODUCTS>
  <ns0:MIN_PRODUCT_ID_LENGTH>
    <ns0:DESTINATION_CODES_ITEM>12</ns0:DESTINATION_CODES_ITEM>
    <ns0:DESTINATION_CODES_ITEM>12</ns0:DESTINATION_CODES_ITEM>
    <ns0:DESTINATION_CODES_ITEM>10</ns0:DESTINATION_CODES_ITEM>
    <ns0:DESTINATION_CODES_ITEM>8</ns0:DESTINATION_CODES_ITEM>
  </ns0:MIN_PRODUCT_ID_LENGTH>
  <ns0:MAX_PRODUCT_ID_LENGTH>
    <ns0:DESTINATION_CODES_ITEM>16</ns0:DESTINATION_CODES_ITEM>
    <ns0:DESTINATION_CODES_ITEM>16</ns0:DESTINATION_CODES_ITEM>
    <ns0:DESTINATION_CODES_ITEM>15</ns0:DESTINATION_CODES_ITEM>
    <ns0:DESTINATION_CODES_ITEM>12</ns0:DESTINATION_CODES_ITEM>
  </ns0:MAX_PRODUCT_ID_LENGTH>
  <ns0:LEADING_ZEROS_YES_NO>
    <ns0:DESTINATION_CODES_ITEM>YES</ns0:DESTINATION_CODES_ITEM>
    <ns0:DESTINATION_CODES_ITEM>YES</ns0:DESTINATION_CODES_ITEM>
    <ns0:DESTINATION_CODES_ITEM>NO</ns0:DESTINATION_CODES_ITEM>
    <ns0:DESTINATION_CODES_ITEM>YES</ns0:DESTINATION_CODES_ITEM>
  </ns0:LEADING_ZEROS_YES_NO>
  <ns0:PRODUCT_ID_SAMPLE>
    <ns0:PRODUCT_ID_SAMPLE_ITEM>123456789012</ns0:PRODUCT_ID_SAMPLE_ITEM>
    <ns0:PRODUCT_ID_SAMPLE_ITEM>987654321098</ns0:PRODUCT_ID_SAMPLE_ITEM>
    <ns0:PRODUCT_ID_SAMPLE_ITEM>1234567890</ns0:PRODUCT_ID_SAMPLE_ITEM>
    <ns0:PRODUCT_ID_SAMPLE_ITEM>12345678</ns0:PRODUCT_ID_SAMPLE_ITEM>
  </ns0:PRODUCT_ID_SAMPLE>
  <ns0:TRANSFER_TYPE>
    <ns0:TRANSFER_TYPE_ITEM>ACH_CREDIT</ns0:TRANSFER_TYPE_ITEM>
    <ns0:TRANSFER_TYPE_ITEM>ACH_DEBIT</ns0:TRANSFER_TYPE_ITEM>
    <ns0:TRANSFER_TYPE_ITEM>ACH_CREDIT</ns0:TRANSFER_TYPE_ITEM>
    <ns0:TRANSFER_TYPE_ITEM>ACH_DEBIT</ns0:TRANSFER_TYPE_ITEM>
  </ns0:TRANSFER_TYPE>
  <ns0:ERROR_CODE>SUCCESS</ns0:ERROR_CODE>
  <ns0:ERROR_MESSAGE></ns0:ERROR_MESSAGE>
</ns0:OutputParameters>
```

## Cadenas de Conexión y Credenciales

### Base de Datos Oracle Guatemala
- **Nombre de la Base de Datos**: AbanksGT
- **Esquema**: OSB_K_CONFINANCIERAS
- **Stored Procedure**: TOPLEVEL$OSB_P_CON_FINANCIERA
- **Conexión JCA**: `eis/DB/ConnectionProxyAbanksGT`
- **Adapter**: Database Adapter (Oracle)

### Configuración JCA
- **Connection Factory**: `eis/DB/ConnectionProxyAbanksGT`
- **UI Connection Name**: ConnectionProxyAbanksGT
- **Package Name**: OSB_K_CONFINANCIERAS
- **Procedure Name**: TOPLEVEL$OSB_P_CON_FINANCIERA

## Mapeo de Entrada (OSB → Oracle DB)

| Campo Origen (OSB) | Transformación/Script | Campo Destino (Oracle) |
|-------------------|----------------------|----------------------|
| `$body/con:consultaFinancierasACH/DESTINATION_CODE` | `data()` directo | `ns0:DESTINATION_CODE` |

### Script de Transformación de Entrada
**Archivo**: `Middleware/v2/Resources/ConsultaFinancierasACH/xq/consultaFinancierasACHGTIn.xq`

```xquery
declare function xf:consultaFinancierasACHIn($consultaFinancierasACH1 as element(ns1:consultaFinancierasACH))
    as element(ns0:InputParameters) {
        <ns0:InputParameters>
            {
                for $DESTINATION_CODE in $consultaFinancierasACH1/DESTINATION_CODE
                return
                    <ns0:DESTINATION_CODE>{ data($DESTINATION_CODE) }</ns0:DESTINATION_CODE>
            }
        </ns0:InputParameters>
};
```

## Mapeo de Salida (Oracle DB → OSB)

| Campo Origen (Oracle) | Transformación/Script | Campo Destino (OSB) |
|----------------------|----------------------|-------------------|
| `$outputParameters1/ns0:DESTINATION_CODES/ns0:DESTINATION_CODES_ITEM` | Agrupación cada 4 registros | `DESTINATION_CODE` |
| `$outputParameters1/ns0:DESTINATION_NAMES/ns0:DESTINATION_NAMES_ITEM` | Agrupación cada 4 registros | `DESTINATION_NAME` |
| `$outputParameters1/ns0:TYPE_OF_PRODUCTS/ns0:TYPE_OF_PRODUCTS_ITEM` | Iteración por grupo | `TYPE_OF_PRODUCT` |
| `$outputParameters1/ns0:MIN_PRODUCT_ID_LENGTH/ns0:DESTINATION_CODES_ITEM` | Iteración por grupo | `MIN_PRODUCT_ID_LENGTH` |
| `$outputParameters1/ns0:MAX_PRODUCT_ID_LENGTH/ns0:DESTINATION_CODES_ITEM` | Iteración por grupo | `MAX_PRODUCT_ID_LENGTH` |
| `$outputParameters1/ns0:LEADING_ZEROS_YES_NO/ns0:DESTINATION_CODES_ITEM` | Iteración por grupo | `LEADING_ZEROS_YES_NO` |
| `$outputParameters1/ns0:PRODUCT_ID_SAMPLE/ns0:PRODUCT_ID_SAMPLE_ITEM` | Iteración por grupo | `PRODUCT_ID_SAMPLE` |
| `$outputParameters1/ns0:TRANSFER_TYPE/ns0:TRANSFER_TYPE_ITEM` | Iteración por grupo | `TRANSFER_TYPE` |

### Script de Transformación de Salida
**Archivo**: `Middleware/v2/Resources/ConsultaFinancierasACH/xq/consultaFinancierasACHGTOut.xq`

**Lógica de agrupación cada 4 registros**:
```xquery
for $i in (1 to count($destinationCodes))
where (($i mod 4) = 0)
return
    <ns1:consultaFinancierasACHResponseRecordType>
        <DESTINATION_CODE>{ data($destinationCodes[$i]) }</DESTINATION_CODE>
        <DESTINATION_NAME>{ data($destinationNames[$i]) }</DESTINATION_NAME>
        
        <ns1:consultaFinancierasACHDetailResponseType>
        {
            for $j in (($i - 3) to $i)
            return  
                <ns1:consultaFinancierasACHDetailResponseRecordType>
                   <TYPE_OF_PRODUCT>{ data($typeOfProducts[$j]) }</TYPE_OF_PRODUCT>
                   <MIN_PRODUCT_ID_LENGTH>{ data($minProductIdLength[$j]) }</MIN_PRODUCT_ID_LENGTH>
                   <MAX_PRODUCT_ID_LENGTH>{ data($maxProductIdLength[$j]) }</MAX_PRODUCT_ID_LENGTH>
                   <LEADING_ZEROS_YES_NO>{ data($leadingZerosYesNO[$j]) }</LEADING_ZEROS_YES_NO>
                   <PRODUCT_ID_SAMPLE>{ data($productIdSampleItem[$j]) }</PRODUCT_ID_SAMPLE>
                   <TRANSFER_TYPE>{ data($transferType[$j]) }</TRANSFER_TYPE>
                </ns1:consultaFinancierasACHDetailResponseRecordType>
        }
        </ns1:consultaFinancierasACHDetailResponseType>
    </ns1:consultaFinancierasACHResponseRecordType>
```

### Script de Transformación de Header
**Archivo**: `Middleware/v2/Resources/ConsultaFinancierasACH/xq/consultaFinancierasACHGTHeaderOut.xq`

## Reglas de Negocio Detectadas

### 1. Agrupación de Productos cada 4 Registros
**Ubicación**: `consultaFinancierasACHGTOut.xq` líneas 15-20
**Regla**: Los productos se agrupan en bloques de 4 registros por entidad financiera
**Implementación**:
```xquery
for $i in (1 to count($destinationCodes))
where (($i mod 4) = 0)
```

### 2. Iteración de Detalles por Grupo
**Ubicación**: `consultaFinancierasACHGTOut.xq` líneas 25-35
**Regla**: Para cada grupo de 4, iterar desde (i-3) hasta i para obtener todos los productos
**Implementación**:
```xquery
for $j in (($i - 3) to $i)
return  
    <ns1:consultaFinancierasACHDetailResponseRecordType>
```

### 3. Campo TRANSFER_TYPE Específico de Guatemala
**Ubicación**: `consultaFinancierasACHGTOut.xq` línea 32
**Regla**: Guatemala es la única región que incluye el campo TRANSFER_TYPE en la respuesta
**Implementación**:
```xquery
<TRANSFER_TYPE>{ data($transferType[$j]) }</TRANSFER_TYPE>
```

### 4. Mapeo Directo de Parámetros de Entrada
**Ubicación**: `consultaFinancierasACHGTIn.xq` líneas 8-15
**Regla**: El DESTINATION_CODE se mapea directamente sin transformaciones adicionales
**Implementación**:
```xquery
for $DESTINATION_CODE in $consultaFinancierasACH1/DESTINATION_CODE
return
    <ns0:DESTINATION_CODE>{ data($DESTINATION_CODE) }</ns0:DESTINATION_CODE>
```

### 5. Validación de Esquema de Entrada
**Ubicación**: Pipeline `GT01_ConsultaFinancierasACH_request`
**Regla**: Validar el request contra el esquema XSD antes de invocar el stored procedure
**Esquema**: `Middleware/v2/BusinessServices/ABKGT/consultaFinancierasACH/xsd/consultaFinancierasACH_sp.xsd`

### 6. Manejo de Arrays Oracle
**Ubicación**: XSD y transformaciones
**Regla**: Los arrays de Oracle se mapean a elementos repetidos en XML
**Tipos de Array**:
- TOPLEVEL_TVARCHAR31 (códigos de destino)
- TOPLEVEL_TVARCHAR50 (nombres de destino)
- TOPLEVEL_TVARCHAR304 (tipos de producto)
- TOPLEVEL_TVARCHAR2565 (ejemplos de ID)
- TOPLEVEL_TVARCHAR10 (tipos de transferencia)

## Dependencias Específicas de GT01

### Base de Datos Oracle
- **Servidor**: AbanksGT
- **Package**: OSB_K_CONFINANCIERAS
- **Stored Procedure**: TOPLEVEL$OSB_P_CON_FINANCIERA
- **Parámetros de Entrada**: DESTINATION_CODE (VARCHAR2)
- **Parámetros de Salida**: Arrays de información de productos financieros

### Configuración JCA
- **Adapter**: Database Adapter
- **Connection**: ConnectionProxyAbanksGT
- **Interaction Spec**: DBStoredProcedureInteractionSpec

### Transformaciones Específicas
- **Input**: `consultaFinancierasACHGTIn.xq`
- **Output**: `consultaFinancierasACHGTOut.xq`
- **Header Output**: `consultaFinancierasACHGTHeaderOut.xq`

### Campos Únicos de Guatemala
- **TRANSFER_TYPE**: Tipo de transferencia ACH (ACH_CREDIT, ACH_DEBIT)
- **Lógica de agrupación**: Cada 4 registros por entidad financiera