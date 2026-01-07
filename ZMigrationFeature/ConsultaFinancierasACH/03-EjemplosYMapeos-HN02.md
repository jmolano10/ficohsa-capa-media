# Ejemplos de Request/Response y Mapeo de Datos - HN02 (Honduras FPC)

## Request OSB (ejemplo SOAP/XML)

```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Header>
    <aut:RequestHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
      <Authentication>
        <UserName>USUARIO_FPC</UserName>
        <Password>PASSWORD_FPC</Password>
      </Authentication>
      <Region>
        <SourceBank>HN02</SourceBank>
        <DestinationBank>HN02</DestinationBank>
      </Region>
    </aut:RequestHeader>
  </soap:Header>
  <soap:Body>
    <con:consultaFinancierasACH xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaFinancierasACHTypes">
      <DESTINATION_CODE>002</DESTINATION_CODE>
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
          <DESTINATION_CODE>002</DESTINATION_CODE>
          <DESTINATION_NAME>BANCO FPC</DESTINATION_NAME>
          <con:consultaFinancierasACHDetailResponseType>
            <con:consultaFinancierasACHDetailResponseRecordType>
              <TYPE_OF_PRODUCT>FONDO_PENSIONES</TYPE_OF_PRODUCT>
              <MIN_PRODUCT_ID_LENGTH>8</MIN_PRODUCT_ID_LENGTH>
              <MAX_PRODUCT_ID_LENGTH>12</MAX_PRODUCT_ID_LENGTH>
              <LEADING_ZEROS_YES_NO>NO</LEADING_ZEROS_YES_NO>
              <PRODUCT_ID_SAMPLE>FPC12345</PRODUCT_ID_SAMPLE>
            </con:consultaFinancierasACHDetailResponseRecordType>
          </con:consultaFinancierasACHDetailResponseType>
        </con:consultaFinancierasACHResponseRecordType>
      </con:consultaFinancierasACHResponseType>
    </con:consultaFinancierasACHResponse>
  </soap:Body>
</soap:Envelope>
```

## Request/Response Interno a FPC Service

### Request a FPC Service

```xml
<soap:Header>
  <aut:RequestHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
    <Authentication>
      <UserName>OSB12AUTH</UserName>
      <Password>PASSWORD_FPC</Password>
    </Authentication>
    <Region>
      <SourceBank>HN01</SourceBank>
      <DestinationBank>HN01</DestinationBank>
    </Region>
  </aut:RequestHeader>
</soap:Header>
<soap:Body>
  <con:consultaFinancierasACH xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaFinancierasACHTypes">
    <DESTINATION_CODE>002</DESTINATION_CODE>
  </con:consultaFinancierasACH>
</soap:Body>
```

### Response de FPC Service

```xml
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
        <DESTINATION_CODE>002</DESTINATION_CODE>
        <DESTINATION_NAME>BANCO FPC</DESTINATION_NAME>
        <con:consultaFinancierasACHDetailResponseType>
          <con:consultaFinancierasACHDetailResponseRecordType>
            <TYPE_OF_PRODUCT>FONDO_PENSIONES</TYPE_OF_PRODUCT>
            <MIN_PRODUCT_ID_LENGTH>8</MIN_PRODUCT_ID_LENGTH>
            <MAX_PRODUCT_ID_LENGTH>12</MAX_PRODUCT_ID_LENGTH>
            <LEADING_ZEROS_YES_NO>NO</LEADING_ZEROS_YES_NO>
            <PRODUCT_ID_SAMPLE>FPC12345</PRODUCT_ID_SAMPLE>
          </con:consultaFinancierasACHDetailResponseRecordType>
        </con:consultaFinancierasACHDetailResponseType>
      </con:consultaFinancierasACHResponseRecordType>
    </con:consultaFinancierasACHResponseType>
  </con:consultaFinancierasACHResponse>
</soap:Body>
```

## Cadenas de Conexión y Credenciales

### Business Service FPC
- **Nombre del Business Service**: `Middleware/v2/BusinessServices/FPC/getFinancialACH12c/biz/getFinancialACH12c`
- **Operación**: `consultaFinancierasACH`
- **Tipo de Conexión**: SOAP Web Service
- **Service Account**: `OSB12AUTH` (fijo)
- **Autenticación**: Service account predefinido

## Mapeo de Entrada (OSB → FPC Service)

| Campo Origen (OSB) | Transformación/Script | Campo Destino (FPC) |
|-------------------|----------------------|-------------------|
| `$header` | Copia directa | `$REQHeaderConsultaFinancierasACH` |
| Constante `'OSB12AUTH'` | Valor fijo | `serviceAccountName` |
| `$header/aut:RequestHeader/Region/SourceBank` | Mapeo condicional HN02→HN01 | `sourceBank` |
| `$header/aut:RequestHeader/Region/DestinationBank` | Mapeo condicional HN02→HN01 | `destinationBank` |
| `$body/con:consultaFinancierasACH` | Copia directa | `$REQconsultaFinancierasACH` |

### Script de Transformación de Header
**Archivo**: `Middleware/v2/Resources/ConsultaFinancierasACH/xq/getFinancialACHHeaderIn.xq`

**Lógica de mapeo de región**:
```xquery
let $SourceBank := fn:data($header/aut:RequestHeader/Region/SourceBank)
return
if($SourceBank = 'HN02')then (
    'HN01')else (fn:data($header/aut:RequestHeader/Region/SourceBank))
```

```xquery
let $destinationBank := fn:data($header/aut:RequestHeader/Region/DestinationBank)
let $SourceBank := fn:data($header/aut:RequestHeader/Region/SourceBank)
return
if($destinationBank = '' and $SourceBank = 'HN02' or $destinationBank = 'HN02')then (
    'HN01')else (fn:data($header/aut:RequestHeader/Region/SourceBank))
```

## Mapeo de Salida (FPC Service → OSB)

| Campo Origen (FPC) | Transformación/Script | Campo Destino (OSB) |
|-------------------|----------------------|-------------------|
| `$RSPconsultaFinancierasACH` | Transformación XQuery | `body` |
| Constante `Success` | Valor fijo | `header/successIndicator` |
| Constante vacío | Valor fijo | `header/messages` |

### Script de Transformación de Salida
**Archivo**: `Middleware/v2/Resources/ConsultaFinancierasACH/xq/getFinancialACHOut.xq`

**Transformación de respuesta**:
```xquery
<con1:xqueryTransform>
  <con1:resource ref="Middleware/v2/Resources/ConsultaFinancierasACH/xq/getFinancialACHOut"/>
  <con1:param name="consultaFinancierasACHResponse">
    <con1:path>$RSPconsultaFinancierasACH</con1:path>
  </con1:param>
</con1:xqueryTransform>
```

## Reglas de Negocio Detectadas

### 1. Mapeo Automático de Región HN02 → HN01
**Ubicación**: Pipeline `HN02_ConsultaFinancierasACH_request`
**Regla**: Todas las solicitudes HN02 se mapean internamente a HN01 para el servicio FPC
**Implementación**:
```xquery
if($SourceBank = 'HN02')then ('HN01')
else (fn:data($header/aut:RequestHeader/Region/SourceBank))
```

### 2. Service Account Fijo para FPC
**Ubicación**: `getFinancialACHHeaderIn.xq`
**Regla**: Usar siempre 'OSB12AUTH' como service account para conexiones FPC
**Implementación**:
```xquery
<con1:param name="serviceAccountName">
  <con1:path>'OSB12AUTH'</con1:path>
</con1:param>
```

### 3. Manejo de DestinationBank Vacío
**Ubicación**: `getFinancialACHHeaderIn.xq`
**Regla**: Si DestinationBank está vacío y SourceBank es HN02, mapear a HN01
**Implementación**:
```xquery
if($destinationBank = '' and $SourceBank = 'HN02' or $destinationBank = 'HN02')then (
    'HN01')else (fn:data($header/aut:RequestHeader/Region/SourceBank))
```

### 4. Validación de Códigos de Error FPC
**Ubicación**: Pipeline `HN02_ConsultaFinancierasACH_request`
**Regla**: Extraer y validar códigos de error del header de respuesta FPC
**Implementación**:
```xquery
<con2:assign varName="errorCode">
  <con1:xqueryText>data($RSPHeaderConsultaFinancierasACH/aut:ResponseHeader/successIndicator/text())</con1:xqueryText>
</con2:assign>
<con2:assign varName="message">
  <con1:xqueryText>data($RSPHeaderConsultaFinancierasACH/aut:ResponseHeader/messages/text())</con1:xqueryText>
</con2:assign>
```

### 5. Response Header Estático para Éxito
**Ubicación**: Pipeline `HN02_ConsultaFinancierasACH_response`
**Regla**: Para respuestas exitosas, generar header estático con Success
**Implementación**:
```xml
<aut:ResponseHeader>
  <successIndicator>Success</successIndicator>
  <messages/>
</aut:ResponseHeader>
```

### 6. Preservación del Cuerpo de Request
**Ubicación**: Pipeline `HN02_ConsultaFinancierasACH_request`
**Regla**: El cuerpo del request se pasa sin modificaciones al servicio FPC
**Implementación**:
```xquery
<con2:assign varName="REQconsultaFinancierasACH">
  <con1:xqueryText>$body/con:consultaFinancierasACH</con1:xqueryText>
</con2:assign>
```

## Dependencias Específicas de HN02

### Servicio FPC
- **Business Service**: `Middleware/v2/BusinessServices/FPC/getFinancialACH12c/biz/getFinancialACH12c`
- **Tipo**: SOAP Web Service interno
- **Autenticación**: Service Account OSB12AUTH

### Transformaciones Específicas
- **Header Input**: `getFinancialACHHeaderIn.xq`
- **Response Output**: `getFinancialACHOut.xq`

### Validaciones Adicionales
- Validación de códigos de error específicos de FPC
- Mapeo automático de regiones HN02 a HN01
- Manejo de headers de autenticación específicos para FPC