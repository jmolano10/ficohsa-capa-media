# Ejemplos de Request/Response y Mapeo de Datos - PA01 (Panamá)

## Request OSB (ejemplo SOAP/XML)

```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Header>
    <aut:RequestHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
      <Authentication>
        <UserName>USUARIO_PA</UserName>
        <Password>PASSWORD_PA</Password>
      </Authentication>
      <Region>
        <SourceBank>PA01</SourceBank>
        <DestinationBank>PA01</DestinationBank>
      </Region>
    </aut:RequestHeader>
  </soap:Header>
  <soap:Body>
    <con:consultaFinancierasACH xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaFinancierasACHTypes">
      <DESTINATION_CODE>201</DESTINATION_CODE>
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
          <DESTINATION_CODE>201</DESTINATION_CODE>
          <DESTINATION_NAME>BANCO GENERAL PANAMA</DESTINATION_NAME>
          <con:consultaFinancierasACHDetailResponseType>
            <con:consultaFinancierasACHDetailResponseRecordType>
              <TYPE_OF_PRODUCT>CUENTA_CORRIENTE</TYPE_OF_PRODUCT>
              <MIN_PRODUCT_ID_LENGTH>10</MIN_PRODUCT_ID_LENGTH>
              <MAX_PRODUCT_ID_LENGTH>14</MAX_PRODUCT_ID_LENGTH>
              <LEADING_ZEROS_YES_NO>NO</LEADING_ZEROS_YES_NO>
              <PRODUCT_ID_SAMPLE>1234567890</PRODUCT_ID_SAMPLE>
            </con:consultaFinancierasACHDetailResponseRecordType>
            <con:consultaFinancierasACHDetailResponseRecordType>
              <TYPE_OF_PRODUCT>CUENTA_AHORRO</TYPE_OF_PRODUCT>
              <MIN_PRODUCT_ID_LENGTH>10</MIN_PRODUCT_ID_LENGTH>
              <MAX_PRODUCT_ID_LENGTH>14</MAX_PRODUCT_ID_LENGTH>
              <LEADING_ZEROS_YES_NO>YES</LEADING_ZEROS_YES_NO>
              <PRODUCT_ID_SAMPLE>0987654321</PRODUCT_ID_SAMPLE>
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
  <ns0:DESTINATION_CODE>201</ns0:DESTINATION_CODE>
</ns0:InputParameters>
```

### Response de Stored Procedure

```xml
<ns0:OutputParameters xmlns:ns0="http://xmlns.oracle.com/pcbpel/adapter/db/sp/consultaFinancierasACH">
  <ns0:DESTINATION_CODES>
    <ns0:DESTINATION_CODES_ITEM>201</ns0:DESTINATION_CODES_ITEM>
    <ns0:DESTINATION_CODES_ITEM>201</ns0:DESTINATION_CODES_ITEM>
    <ns0:DESTINATION_CODES_ITEM>202</ns0:DESTINATION_CODES_ITEM>
    <ns0:DESTINATION_CODES_ITEM>202</ns0:DESTINATION_CODES_ITEM>
  </ns0:DESTINATION_CODES>
  <ns0:DESTINATION_NAMES>
    <ns0:DESTINATION_NAMES_ITEM>BANCO GENERAL PANAMA</ns0:DESTINATION_NAMES_ITEM>
    <ns0:DESTINATION_NAMES_ITEM>BANCO GENERAL PANAMA</ns0:DESTINATION_NAMES_ITEM>
    <ns0:DESTINATION_NAMES_ITEM>BANCO NACIONAL PANAMA</ns0:DESTINATION_NAMES_ITEM>
    <ns0:DESTINATION_NAMES_ITEM>BANCO NACIONAL PANAMA</ns0:DESTINATION_NAMES_ITEM>
  </ns0:DESTINATION_NAMES>
  <ns0:TYPE_OF_PRODUCTS>
    <ns0:TYPE_OF_PRODUCTS_ITEM>CUENTA_CORRIENTE</ns0:TYPE_OF_PRODUCTS_ITEM>
    <ns0:TYPE_OF_PRODUCTS_ITEM>CUENTA_AHORRO</ns0:TYPE_OF_PRODUCTS_ITEM>
    <ns0:TYPE_OF_PRODUCTS_ITEM>CUENTA_CORRIENTE</ns0:TYPE_OF_PRODUCTS_ITEM>
    <ns0:TYPE_OF_PRODUCTS_ITEM>CUENTA_AHORRO</ns0:TYPE_OF_PRODUCTS_ITEM>
  </ns0:TYPE_OF_PRODUCTS>
  <ns0:MIN_PRODUCT_ID_LENGTH>
    <ns0:DESTINATION_CODES_ITEM>10</ns0:DESTINATION_CODES_ITEM>
    <ns0:DESTINATION_CODES_ITEM>10</ns0:DESTINATION_CODES_ITEM>
    <ns0:DESTINATION_CODES_ITEM>8</ns0:DESTINATION_CODES_ITEM>
    <ns0:DESTINATION_CODES_ITEM>8</ns0:DESTINATION_CODES_ITEM>
  </ns0:MIN_PRODUCT_ID_LENGTH>
  <ns0:MAX_PRODUCT_ID_LENGTH>
    <ns0:DESTINATION_CODES_ITEM>14</ns0:DESTINATION_CODES_ITEM>
    <ns0:DESTINATION_CODES_ITEM>14</ns0:DESTINATION_CODES_ITEM>
    <ns0:DESTINATION_CODES_ITEM>12</ns0:DESTINATION_CODES_ITEM>
    <ns0:DESTINATION_CODES_ITEM>12</ns0:DESTINATION_CODES_ITEM>
  </ns0:MAX_PRODUCT_ID_LENGTH>
  <ns0:LEADING_ZEROS_YES_NO>
    <ns0:DESTINATION_CODES_ITEM>NO</ns0:DESTINATION_CODES_ITEM>
    <ns0:DESTINATION_CODES_ITEM>YES</ns0:DESTINATION_CODES_ITEM>
    <ns0:DESTINATION_CODES_ITEM>NO</ns0:DESTINATION_CODES_ITEM>
    <ns0:DESTINATION_CODES_ITEM>YES</ns0:DESTINATION_CODES_ITEM>
  </ns0:LEADING_ZEROS_YES_NO>
  <ns0:PRODUCT_ID_SAMPLE>
    <ns0:PRODUCT_ID_SAMPLE_ITEM>1234567890</ns0:PRODUCT_ID_SAMPLE_ITEM>
    <ns0:PRODUCT_ID_SAMPLE_ITEM>0987654321</ns0:PRODUCT_ID_SAMPLE_ITEM>
    <ns0:PRODUCT_ID_SAMPLE_ITEM>87654321</ns0:PRODUCT_ID_SAMPLE_ITEM>
    <ns0:PRODUCT_ID_SAMPLE_ITEM>012345678</ns0:PRODUCT_ID_SAMPLE_ITEM>
  </ns0:PRODUCT_ID_SAMPLE>
  <ns0:ERROR_CODE>SUCCESS</ns0:ERROR_CODE>
  <ns0:ERROR_MESSAGE></ns0:ERROR_MESSAGE>
</ns0:OutputParameters>
```

## Cadenas de Conexión y Credenciales

### Base de Datos Oracle Panamá
- **Nombre de la Base de Datos**: AbanksPA
- **Esquema**: OSB_K_CONFINANCIERAS
- **Stored Procedure**: TOPLEVEL$OSB_P_CON_FINANCIERA
- **Conexión JCA**: `eis/DB/ConnectionProxyAbanksPA`
- **Adapter**: Database Adapter (Oracle)

### Configuración JCA
- **Connection Factory**: `eis/DB/ConnectionProxyAbanksPA`
- **UI Connection Name**: ConnectionProxyAbanksPA
- **Package Name**: OSB_K_CONFINANCIERAS
- **Procedure Name**: TOPLEVEL$OSB_P_CON_FINANCIERA

## Mapeo de Entrada (OSB → Oracle DB)

| Campo Origen (OSB) | Transformación/Script | Campo Destino (Oracle) |
|-------------------|----------------------|----------------------|
| `$body/con:consultaFinancierasACH/DESTINATION_CODE` | `data()` directo | `ns0:DESTINATION_CODE` |

### Script de Transformación de Entrada
**Archivo**: `Middleware/v2/Resources/ConsultaFinancierasACH/xq/consultaFinancierasACHPAIn.xq`

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
| `$outputParameters1/ns0:DESTINATION_CODES/ns0:DESTINATION_CODES_ITEM` | Agrupación por cambio de código | `DESTINATION_CODE` |
| `$outputParameters1/ns0:DESTINATION_NAMES/ns0:DESTINATION_NAMES_ITEM` | Agrupación por cambio de código | `DESTINATION_NAME` |
| `$outputParameters1/ns0:TYPE_OF_PRODUCTS/ns0:TYPE_OF_PRODUCTS_ITEM` | Iteración por grupo | `TYPE_OF_PRODUCT` |
| `$outputParameters1/ns0:MIN_PRODUCT_ID_LENGTH/ns0:DESTINATION_CODES_ITEM` | Iteración por grupo | `MIN_PRODUCT_ID_LENGTH` |
| `$outputParameters1/ns0:MAX_PRODUCT_ID_LENGTH/ns0:DESTINATION_CODES_ITEM` | Iteración por grupo | `MAX_PRODUCT_ID_LENGTH` |
| `$outputParameters1/ns0:LEADING_ZEROS_YES_NO/ns0:DESTINATION_CODES_ITEM` | Iteración por grupo | `LEADING_ZEROS_YES_NO` |
| `$outputParameters1/ns0:PRODUCT_ID_SAMPLE/ns0:PRODUCT_ID_SAMPLE_ITEM` | Iteración por grupo | `PRODUCT_ID_SAMPLE` |

### Script de Transformación de Salida
**Archivo**: `Middleware/v2/Resources/ConsultaFinancierasACH/xq/consultaFinancierasACHPAOut.xq`

**Lógica de agrupación por cambio de código**:
```xquery
for $i in (1 to count($destinationCodes))
where (data($destinationCodes[$i]) != data($destinationCodes[$i+1])) or ($i = count($destinationCodes))
return
    <ns1:consultaFinancierasACHResponseRecordType>
        <DESTINATION_CODE>{ data($destinationCodes[$i]) }</DESTINATION_CODE>
        <DESTINATION_NAME>{ data($destinationNames[$i]) }</DESTINATION_NAME>
        <ns1:consultaFinancierasACHDetailResponseType>
        {
            (: se retroce hasta cuatro posicione para evaluacion :)
            if (($i - 4) <= 0 ) then
                for $j in (1 to $i)
                where  data($destinationCodes[$j]) = data($destinationCodes[$i])
                return  
                    <ns1:consultaFinancierasACHDetailResponseRecordType>
                        <TYPE_OF_PRODUCT>{ data($typeOfProducts[$j]) }</TYPE_OF_PRODUCT>
                        <MIN_PRODUCT_ID_LENGTH>{ data($minProductIdLength[$j]) }</MIN_PRODUCT_ID_LENGTH>
                        <MAX_PRODUCT_ID_LENGTH>{ data($maxProductIdLength[$j]) }</MAX_PRODUCT_ID_LENGTH>
                        <LEADING_ZEROS_YES_NO>{ data($leadingZerosYesNO[$j]) }</LEADING_ZEROS_YES_NO>
                        <PRODUCT_ID_SAMPLE>{ data($productIdSampleItem[$j]) }</PRODUCT_ID_SAMPLE>
                    </ns1:consultaFinancierasACHDetailResponseRecordType>
            else
                for $j in (($i - 4) to $i)
                where  data($destinationCodes[$j]) = data($destinationCodes[$i])
                return  
                    <ns1:consultaFinancierasACHDetailResponseRecordType>
                        <TYPE_OF_PRODUCT>{ data($typeOfProducts[$j]) }</TYPE_OF_PRODUCT>
                        <MIN_PRODUCT_ID_LENGTH>{ data($minProductIdLength[$j]) }</MIN_PRODUCT_ID_LENGTH>
                        <MAX_PRODUCT_ID_LENGTH>{ data($maxProductIdLength[$j]) }</MAX_PRODUCT_ID_LENGTH>
                        <LEADING_ZEROS_YES_NO>{ data($leadingZerosYesNO[$j]) }</LEADING_ZEROS_YES_NO>
                        <PRODUCT_ID_SAMPLE>{ data($productIdSampleItem[$j]) }</PRODUCT_ID_SAMPLE>
                    </ns1:consultaFinancierasACHDetailResponseRecordType>
        }
        </ns1:consultaFinancierasACHDetailResponseType>
    </ns1:consultaFinancierasACHResponseRecordType>
```

### Script de Transformación de Header
**Archivo**: `Middleware/v2/Resources/ConsultaFinancierasACH/xq/consultaFinancierasACHPAHeaderOut.xq`

## Reglas de Negocio Detectadas

### 1. Agrupación por Cambio de Código de Destino
**Ubicación**: `consultaFinancierasACHPAOut.xq` líneas 15-20
**Regla**: Los productos se agrupan cuando cambia el código de destino o se llega al final de la lista
**Implementación**:
```xquery
for $i in (1 to count($destinationCodes))
where (data($destinationCodes[$i]) != data($destinationCodes[$i+1])) or ($i = count($destinationCodes))
```

### 2. Búsqueda Retrospectiva Limitada
**Ubicación**: `consultaFinancierasACHPAOut.xq` líneas 25-30
**Regla**: Buscar hacia atrás máximo 4 posiciones para agrupar productos del mismo banco
**Implementación**:
```xquery
if (($i - 4) <= 0 ) then
    for $j in (1 to $i)
    where  data($destinationCodes[$j]) = data($destinationCodes[$i])
else
    for $j in (($i - 4) to $i)
    where  data($destinationCodes[$j]) = data($destinationCodes[$i])
```

### 3. Filtro por Código de Destino Igual
**Ubicación**: `consultaFinancierasACHPAOut.xq` líneas 28 y 38
**Regla**: Solo incluir productos que tengan el mismo código de destino que el registro actual
**Implementación**:
```xquery
where  data($destinationCodes[$j]) = data($destinationCodes[$i])
```

### 4. Ausencia del Campo TRANSFER_TYPE
**Ubicación**: `consultaFinancierasACHPAOut.xq`
**Regla**: Panamá no incluye el campo TRANSFER_TYPE en la respuesta (diferencia con Guatemala)
**Implementación**: El campo no está presente en la estructura de respuesta

### 5. Mapeo Directo de Parámetros de Entrada
**Ubicación**: `consultaFinancierasACHPAIn.xq` líneas 8-15
**Regla**: El DESTINATION_CODE se mapea directamente sin transformaciones adicionales
**Implementación**:
```xquery
for $DESTINATION_CODE in $consultaFinancierasACH1/DESTINATION_CODE
return
    <ns0:DESTINATION_CODE>{ data($DESTINATION_CODE) }</ns0:DESTINATION_CODE>
```

### 6. Manejo de Arrays Oracle Específicos de PA
**Ubicación**: XSD PA01
**Regla**: Los arrays de Oracle tienen tipos específicos para Panamá (sin TRANSFER_TYPE)
**Tipos de Array**:
- TOPLEVEL_TVARCHAR3 (códigos de destino - 3 caracteres)
- TOPLEVEL_TVARCHAR50 (nombres de destino)
- TOPLEVEL_TVARCHAR30 (tipos de producto)
- TOPLEVEL_TVARCHAR256 (ejemplos de ID)

## Diferencias con Guatemala (GT01)

### Estructura de Arrays
| Aspecto | GT01 | PA01 |
|---------|------|------|
| DESTINATION_CODES | TOPLEVEL_TVARCHAR31 | TOPLEVEL_TVARCHAR3 |
| TYPE_OF_PRODUCTS | TOPLEVEL_TVARCHAR304 | TOPLEVEL_TVARCHAR30 |
| PRODUCT_ID_SAMPLE | TOPLEVEL_TVARCHAR2565 | TOPLEVEL_TVARCHAR256 |
| TRANSFER_TYPE | TOPLEVEL_TVARCHAR10 | No existe |

### Lógica de Agrupación
- **GT01**: Agrupación cada 4 registros fijos
- **PA01**: Agrupación por cambio de código de destino

### Campos de Respuesta
- **GT01**: Incluye TRANSFER_TYPE
- **PA01**: No incluye TRANSFER_TYPE

## Dependencias Específicas de PA01

### Base de Datos Oracle
- **Servidor**: AbanksPA
- **Package**: OSB_K_CONFINANCIERAS
- **Stored Procedure**: TOPLEVEL$OSB_P_CON_FINANCIERA
- **Parámetros de Entrada**: DESTINATION_CODE (VARCHAR2)
- **Parámetros de Salida**: Arrays de información de productos financieros (sin TRANSFER_TYPE)

### Configuración JCA
- **Adapter**: Database Adapter
- **Connection**: ConnectionProxyAbanksPA
- **Interaction Spec**: DBStoredProcedureInteractionSpec

### Transformaciones Específicas
- **Input**: `consultaFinancierasACHPAIn.xq`
- **Output**: `consultaFinancierasACHPAOut.xq`
- **Header Output**: `consultaFinancierasACHPAHeaderOut.xq`

### Características Únicas de Panamá
- **Lógica de agrupación**: Por cambio de código de destino
- **Búsqueda retrospectiva**: Limitada a 4 posiciones hacia atrás
- **Sin TRANSFER_TYPE**: Campo no incluido en la respuesta
- **Arrays más pequeños**: Tipos de datos con menor longitud que Guatemala