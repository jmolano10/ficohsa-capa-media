# Ejemplos de Request/Response y Mapeo de Datos - NI01 (Nicaragua DGI)

## Request OSB (ejemplo SOAP/XML)

```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Header>
    <aut:RequestHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
      <Authentication>
        <UserName>USUARIO_DGI</UserName>
        <Password>PASSWORD_DGI</Password>
      </Authentication>
      <Region>
        <SourceBank>NI01</SourceBank>
        <DestinationBank>NI01</DestinationBank>
      </Region>
    </aut:RequestHeader>
  </soap:Header>
  <soap:Body>
    <con:consultaDGI xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaDGITypes">
      <RUC>J0310000000001</RUC>
      <BILL_NUMBER>12345678901234567890</BILL_NUMBER>
    </con:consultaDGI>
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
    <con:consultaDGIResponse xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaDGITypes">
      <TOTAL_AMOUNT>15000.00</TOTAL_AMOUNT>
      <DUE_DATE>2024-03-15</DUE_DATE>
      <TAX_VALUE>12000.00</TAX_VALUE>
      <EXCH_RATE_FEE>100.00</EXCH_RATE_FEE>
      <LATE_FEE>500.00</LATE_FEE>
      <PENALTY_FEE>2400.00</PENALTY_FEE>
      <BILL_AMOUNT>15000.00</BILL_AMOUNT>
      <ACCOUNT_CODE>1234567890</ACCOUNT_CODE>
      <TAX_DESCRIPTION>Impuesto sobre la Renta</TAX_DESCRIPTION>
    </con:consultaDGIResponse>
  </soap:Body>
</soap:Envelope>
```

## Request/Response a Servicio de Parametrización

### Request a ObtenerParametrizacion

```xml
<osb:obtenerParametrizacion xmlns:osb="http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_GET_CONFIG/">
  <osb:NOMBRE_PARAMETROS>FICBCO0256.TIPOCONSULTADGI||FICBCO0256.CODIGOBANCODGI</osb:NOMBRE_PARAMETROS>
</osb:obtenerParametrizacion>
```

### Response de ObtenerParametrizacion

```xml
<osb:obtenerParametrizacionResponse xmlns:osb="http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_GET_CONFIG/">
  <osb:ERROR_CODE>SUCCESS</osb:ERROR_CODE>
  <osb:ERROR_MESSAGE></osb:ERROR_MESSAGE>
  <osb:CONFIGURACIONES>
    <osb:CONFIGURACIONES_ITEM>
      <osb:NAME>FICBCO0256.TIPOCONSULTADGI</osb:NAME>
      <osb:VALUE>1</osb:VALUE>
    </osb:CONFIGURACIONES_ITEM>
    <osb:CONFIGURACIONES_ITEM>
      <osb:NAME>FICBCO0256.CODIGOBANCODGI</osb:NAME>
      <osb:VALUE>105</osb:VALUE>
    </osb:CONFIGURACIONES_ITEM>
  </osb:CONFIGURACIONES>
</osb:obtenerParametrizacionResponse>
```

## Request/Response Interno a CTS COBIS

### Request a CTS COBIS Service

```xml
<ns2:opConsultaDGISolicitud xmlns:ns2="http://service.srvaplcobisimpuestos.ecobis.cobiscorp" xmlns:ns0="http://dto.srvaplcobisentidades.ecobis.cobiscorp">
  <ns0:contextoTransaccional>
    <ns0:codCanalOriginador>1</ns0:codCanalOriginador>
  </ns0:contextoTransaccional>
  <ns0:consultaBIT>
    <ns0:valRUC>J0310000000001</ns0:valRUC>
    <ns0:tipoConsulta>1</ns0:tipoConsulta>
    <ns0:valCodigoBanco>105</ns0:valCodigoBanco>
    <ns0:bit>12345678901234567890</ns0:bit>
  </ns0:consultaBIT>
</ns2:opConsultaDGISolicitud>
```

### Response de CTS COBIS Service

```xml
<ns3:opConsultaDGIRespuesta xmlns:ns3="http://service.srvaplcobisimpuestos.ecobis.cobiscorp" xmlns:ns0="http://dto.srvaplcobisentidades.ecobis.cobiscorp">
  <ns0:contextoRespuesta>
    <ns0:codTipoRespuesta>0</ns0:codTipoRespuesta>
    <ns0:valDescripcionRespuesta>Consulta exitosa</ns0:valDescripcionRespuesta>
  </ns0:contextoRespuesta>
  <ns0:datosBITN900>
    <ns0:valMontoBit>15000.00</ns0:valMontoBit>
    <ns0:fechaVencimiento>2024-03-15T00:00:00</ns0:fechaVencimiento>
    <ns0:valImpuesto>12000.00</ns0:valImpuesto>
    <ns0:valMontoMantenimiento>100.00</ns0:valMontoMantenimiento>
    <ns0:valMora>500.00</ns0:valMora>
    <ns0:valMulta>2400.00</ns0:valMulta>
    <ns0:codigoCuenta>1234567890</ns0:codigoCuenta>
    <ns0:descripcionImpuesto>Impuesto sobre la Renta</ns0:descripcionImpuesto>
  </ns0:datosBITN900>
</ns3:opConsultaDGIRespuesta>
```

## Cadenas de Conexión y Credenciales

### Servicio CTS COBIS Impuestos
- **Endpoint**: `http://10.235.53.149:9080/GerenciaCobisImpuestos/SrvAplCobisImpuestosService`
- **Business Service**: `Middleware/v2/BusinessServices/CTS/impuesto/biz/impuesto`
- **Operación**: `OpConsultaDGI`
- **Protocolo**: SOAP 1.2
- **Timeout**: 0 (sin límite)
- **Retry**: 0 (sin reintentos)

### Servicio de Parametrización OSB
- **Business Service**: `Middleware/Business_Resources/general/Resources/ObtenerParametrizacion/ObtenerParametrizacion`
- **Operación**: `obtenerParametrizacion`

## Mapeo de Entrada (OSB → CTS COBIS)

| Campo Origen (OSB) | Transformación/Script | Campo Destino (CTS) |
|-------------------|----------------------|-------------------|
| Constante `1` | Valor fijo | `ns0:contextoTransaccional/ns0:codCanalOriginador` |
| `$consultaDGI/RUC` | `data()` directo | `ns0:consultaBIT/ns0:valRUC` |
| `$tipoConsultaDGIParam` | Parámetro de configuración | `ns0:consultaBIT/ns0:tipoConsulta` |
| `$codigoBancoDGIParam` | Parámetro de configuración | `ns0:consultaBIT/ns0:valCodigoBanco` |
| `$consultaDGI/BILL_NUMBER` | `data()` directo | `ns0:consultaBIT/ns0:bit` |

### Script de Transformación de Entrada
**Archivo**: `Middleware/v2/Resources/ConsultaDGI/xq/consultaDGIIn.xq`

```xquery
declare function xf:consultaDGIIn($consultaDGI as element(ns1:consultaDGI),
    $tipoConsultaDGI as xs:string,
    $codigoBancoDGI as xs:string)
    as element(ns2:opConsultaDGISolicitud) {
        <ns2:opConsultaDGISolicitud>
            <ns0:contextoTransaccional>
                <ns0:codCanalOriginador>1</ns0:codCanalOriginador>
            </ns0:contextoTransaccional>
            <ns0:consultaBIT>
                <ns0:valRUC>{ data($consultaDGI/RUC) }</ns0:valRUC>
                <ns0:tipoConsulta>{ $tipoConsultaDGI }</ns0:tipoConsulta>
                <ns0:valCodigoBanco>{ $codigoBancoDGI }</ns0:valCodigoBanco>
                <ns0:bit>{ data($consultaDGI/BILL_NUMBER) }</ns0:bit>
            </ns0:consultaBIT>
        </ns2:opConsultaDGISolicitud>
};
```

## Mapeo de Salida (CTS COBIS → OSB)

| Campo Origen (CTS) | Transformación/Script | Campo Destino (OSB) |
|-------------------|----------------------|-------------------|
| `$opConsultaDGIRespuesta/ns0:datosBITN900/ns0:valMontoBit` | `data()` directo | `TOTAL_AMOUNT` |
| `$opConsultaDGIRespuesta/ns0:datosBITN900/ns0:fechaVencimiento` | Ajuste de timezone | `DUE_DATE` |
| `$opConsultaDGIRespuesta/ns0:datosBITN900/ns0:valImpuesto` | `data()` directo | `TAX_VALUE` |
| `$opConsultaDGIRespuesta/ns0:datosBITN900/ns0:valMontoMantenimiento` | `data()` directo | `EXCH_RATE_FEE` |
| `$opConsultaDGIRespuesta/ns0:datosBITN900/ns0:valMora` | `data()` directo | `LATE_FEE` |
| `$opConsultaDGIRespuesta/ns0:datosBITN900/ns0:valMulta` | `data()` directo | `PENALTY_FEE` |
| `$opConsultaDGIRespuesta/ns0:datosBITN900/ns0:valMontoBit` | `data()` directo | `BILL_AMOUNT` |
| `$opConsultaDGIRespuesta/ns0:datosBITN900/ns0:codigoCuenta` | `data()` directo | `ACCOUNT_CODE` |
| `$opConsultaDGIRespuesta/ns0:datosBITN900/ns0:descripcionImpuesto` | `data()` directo | `TAX_DESCRIPTION` |

### Script de Transformación de Salida
**Archivo**: `Middleware/v2/Resources/ConsultaDGI/xq/consultaDGIOut.xq`

**Transformación especial de fecha**:
```xquery
<DUE_DATE>{ fn:adjust-date-to-timezone(fn-bea:date-from-dateTime(data($fechaVencimiento)),()) }</DUE_DATE>
```

### Script de Transformación de Header
**Archivo**: `Middleware/v2/Resources/ConsultaDGI/xq/consultaDGIHeaderOut.xq`

**Lógica de mapeo de códigos de respuesta**:
```xquery
let $successIndicator := fn:string($opConsultaDGIRespuesta/ns1:contextoRespuesta/ns1:codTipoRespuesta/text())
return
    if ($successIndicator = "0") then (
        <successIndicator>Success</successIndicator>
    ) else (
        <successIndicator>{ $successIndicator }</successIndicator>,
        <messages>{ data($opConsultaDGIRespuesta/ns1:contextoRespuesta/ns1:valDescripcionRespuesta) }</messages>
    )
```

## Reglas de Negocio Detectadas

### 1. Parametrización Obligatoria
**Ubicación**: Pipeline `NI01_ConsultaDGI_request`, etapa `ObtenerParametrizacion`
**Regla**: Debe obtener parámetros de configuración antes de procesar
**Parámetros requeridos**:
- `FICBCO0256.TIPOCONSULTADGI`
- `FICBCO0256.CODIGOBANCODGI`

### 2. Validación de Parametrización
**Ubicación**: Pipeline `NI01_ConsultaDGI_request`
**Regla**: Si no hay parámetros válidos, omitir procesamiento
**Implementación**:
```xquery
if ($validationMessage = '') then (
    // Procesar consulta CTS
) else (
    // Omitir procesamiento
)
```

### 3. Contexto Transaccional COBIS Obligatorio
**Ubicación**: `consultaDGIIn.xq`
**Regla**: Todas las solicitudes CTS deben incluir contexto con canal originador fijo
**Implementación**:
```xquery
<ns0:contextoTransaccional>
    <ns0:codCanalOriginador>1</ns0:codCanalOriginador>
</ns0:contextoTransaccional>
```

### 4. Validación de Esquema CTS
**Ubicación**: Pipeline `NI01_ConsultaDGI_request`, etapa `ConsultaDGI`
**Regla**: Validar request contra esquema CTS antes del envío
**Esquema**: `Middleware/v2/BusinessServices/CTS/impuesto/xsd/services.xsd`

### 5. Mapeo de Códigos de Respuesta CTS
**Ubicación**: `consultaDGIHeaderOut.xq`
**Regla**: Código "0" = Success, otros códigos = Error con mensaje
**Implementación**:
```xquery
if ($successIndicator = "0") then (
    <successIndicator>Success</successIndicator>
) else (
    <successIndicator>{ $successIndicator }</successIndicator>
)
```

### 6. Transformación de Fechas con Timezone
**Ubicación**: `consultaDGIOut.xq`
**Regla**: Convertir fechas CTS a formato date sin timezone
**Implementación**:
```xquery
fn:adjust-date-to-timezone(fn-bea:date-from-dateTime(data($fechaVencimiento)),())
```

### 7. Duplicación de Monto Total
**Ubicación**: `consultaDGIOut.xq`
**Regla**: valMontoBit se mapea tanto a TOTAL_AMOUNT como a BILL_AMOUNT
**Razón**: Compatibilidad con diferentes interpretaciones del monto

### 8. Manejo de Errores de Parametrización
**Ubicación**: Pipeline `NI01_ConsultaDGI_response`
**Regla**: Si hay error de parametrización, retornar error con mensaje específico
**Implementación**:
```xml
<aut:ResponseHeader>
    <successIndicator>ERROR</successIndicator>
    <messages>{ $validationMessage }</messages>
</aut:ResponseHeader>
```

## Dependencias Específicas de NI01

### Servicio CTS COBIS Impuestos
- **Endpoint**: `http://10.235.53.149:9080/GerenciaCobisImpuestos/SrvAplCobisImpuestosService`
- **Protocolo**: SOAP 1.2
- **Operación**: `OpConsultaDGI`

### Servicio de Parametrización OSB
- **Business Service**: `ObtenerParametrizacion`
- **Parámetros**: TIPOCONSULTADGI, CODIGOBANCODGI

### Transformaciones Específicas
- **Input**: `consultaDGIIn.xq`
- **Output**: `consultaDGIOut.xq`
- **Header Output**: `consultaDGIHeaderOut.xq`

### Validaciones Específicas
- **XSD OSB**: `consultaDGITypes.xsd`
- **XSD CTS**: `services.xsd`
- **Parametrización**: Validación de configuración