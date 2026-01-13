# Ejemplos de Request/Response y Mapeo de Datos - NI01 (Nicaragua Pago DGI)

## Request OSB (ejemplo SOAP/XML)

```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Header>
    <aut:RequestHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
      <Authentication>
        <UserName>USUARIO_PAGO_DGI</UserName>
        <Password>PASSWORD_PAGO_DGI</Password>
      </Authentication>
      <Region>
        <SourceBank>NI01</SourceBank>
        <DestinationBank>NI01</DestinationBank>
      </Region>
    </aut:RequestHeader>
  </soap:Header>
  <soap:Body>
    <pag:pagoDGIRequest xmlns:pag="http://www.ficohsa.com.hn/middleware.services/pagoDGITypes">
      <RUC>J0310000000001</RUC>
      <BILL_NUMBER>12345678901234567890</BILL_NUMBER>
      <TOTAL_AMOUNT>15000.00</TOTAL_AMOUNT>
      <PAYMENT_AMOUNT>15000.00</PAYMENT_AMOUNT>
      <ACCOUNT_NUMBER>1234567890123456</ACCOUNT_NUMBER>
      <TAX_VALUE>12000.00</TAX_VALUE>
      <EXCH_RATE_FEE>100.00</EXCH_RATE_FEE>
      <LATE_FEE>500.00</LATE_FEE>
      <PENALTY_FEE>2400.00</PENALTY_FEE>
      <DUE_DATE>2024-03-15</DUE_DATE>
      <TAX_DESCRIPTION>Impuesto sobre la Renta</TAX_DESCRIPTION>
      <ACCOUNT_CODE>1234567890</ACCOUNT_CODE>
    </pag:pagoDGIRequest>
  </soap:Body>
</soap:Envelope>
```

## Response OSB (ejemplo SOAP/XML)

```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Header>
    <aut:ResponseHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
      <transactionId>PAG2024031500123456</transactionId>
      <successIndicator>Success</successIndicator>
      <messages></messages>
    </aut:ResponseHeader>
  </soap:Header>
  <soap:Body>
    <pag:pagoDGIResponse xmlns:pag="http://www.ficohsa.com.hn/middleware.services/pagoDGITypes">
      <TOTAL_AMOUNT>15000.00</TOTAL_AMOUNT>
      <DUE_DATE>2024-03-15</DUE_DATE>
      <TAX_VALUE>12000.00</TAX_VALUE>
      <EXCH_RATE_FEE>100.00</EXCH_RATE_FEE>
      <LATE_FEE>500.00</LATE_FEE>
      <PENALTY_FEE>2400.00</PENALTY_FEE>
      <BILL_AMOUNT>15000.00</BILL_AMOUNT>
      <SIF_CODE>SIF2024031500987654</SIF_CODE>
    </pag:pagoDGIResponse>
  </soap:Body>
</soap:Envelope>
```

## Request/Response a Servicio de Parametrización

### Request a ObtenerParametrizacion

```xml
<osb:obtenerParametrizacion xmlns:osb="http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_GET_CONFIG/">
  <osb:NOMBRE_PARAMETROS>FICBCO0257.CAJADGI||FICBCO0257.FORMAPAGODGI||FICBCO0256.CODIGOBANCODGI||FICBCO0257.TIPOIMPUESTODGI</osb:NOMBRE_PARAMETROS>
</osb:obtenerParametrizacion>
```

### Response de ObtenerParametrizacion

```xml
<osb:obtenerParametrizacionResponse xmlns:osb="http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_GET_CONFIG/">
  <osb:ERROR_CODE>SUCCESS</osb:ERROR_CODE>
  <osb:ERROR_MESSAGE></osb:ERROR_MESSAGE>
  <osb:CONFIGURACIONES>
    <osb:CONFIGURACIONES_ITEM>
      <osb:NAME>FICBCO0257.CAJADGI</osb:NAME>
      <osb:VALUE>001</osb:VALUE>
    </osb:CONFIGURACIONES_ITEM>
    <osb:CONFIGURACIONES_ITEM>
      <osb:NAME>FICBCO0257.FORMAPAGODGI</osb:NAME>
      <osb:VALUE>EFE</osb:VALUE>
    </osb:CONFIGURACIONES_ITEM>
    <osb:CONFIGURACIONES_ITEM>
      <osb:NAME>FICBCO0256.CODIGOBANCODGI</osb:NAME>
      <osb:VALUE>105</osb:VALUE>
    </osb:CONFIGURACIONES_ITEM>
    <osb:CONFIGURACIONES_ITEM>
      <osb:NAME>FICBCO0257.TIPOIMPUESTODGI</osb:NAME>
      <osb:VALUE>IR</osb:VALUE>
    </osb:CONFIGURACIONES_ITEM>
  </osb:CONFIGURACIONES>
</osb:obtenerParametrizacionResponse>
```

## Request/Response Interno a CTS COBIS

### Request a CTS COBIS Service

```xml
<ns2:opPagoDGISolicitud xmlns:ns2="http://service.srvaplcobisimpuestos.ecobis.cobiscorp" xmlns:ns1="http://dto.srvaplcobisentidades.ecobis.cobiscorp">
  <ns1:contextoTransaccional>
    <ns1:codCanalOriginador>1</ns1:codCanalOriginador>
  </ns1:contextoTransaccional>
  <ns1:datosPagN900>
    <ns1:bit>12345678901234567890</ns1:bit>
    <ns1:valMontoPago>15000.00</ns1:valMontoPago>
    <ns1:fechaPago>2024-03-15T14:30:25</ns1:fechaPago>
    <ns1:horaPago>14:30:25</ns1:horaPago>
    <ns1:indicadorPago>1</ns1:indicadorPago>
    <ns1:formaPago>EFE</ns1:formaPago>
    <ns1:codigoBanco>105</ns1:codigoBanco>
    <ns1:caja>001</ns1:caja>
    <ns1:valImpuesto>12000.00</ns1:valImpuesto>
    <ns1:valMontoMantenimiento>100.00</ns1:valMontoMantenimiento>
    <ns1:valMora>500.00</ns1:valMora>
    <ns1:valMulta>2400.00</ns1:valMulta>
    <ns1:tipoImpuesto>IR</ns1:tipoImpuesto>
    <ns1:tipoImpuestoTributario>Impuesto sobre la Renta</ns1:tipoImpuestoTributario>
    <ns1:codigoCuenta>1234567890</ns1:codigoCuenta>
    <ns1:valRUC>J0310000000001</ns1:valRUC>
    <ns1:fechaVencimiento>2024-03-15T00:00:00</ns1:fechaVencimiento>
    <ns1:valMontoBit>15000.00</ns1:valMontoBit>
    <ns1:cuenta>1234567890123456</ns1:cuenta>
  </ns1:datosPagN900>
</ns2:opPagoDGISolicitud>
```

### Response de CTS COBIS Service

```xml
<ns3:opPagoDGIRespuesta xmlns:ns3="http://service.srvaplcobisimpuestos.ecobis.cobiscorp" xmlns:ns1="http://dto.srvaplcobisentidades.ecobis.cobiscorp">
  <ns1:contextoRespuesta>
    <ns1:codTipoRespuesta>0</ns1:codTipoRespuesta>
    <ns1:valDescripcionRespuesta>Pago procesado exitosamente</ns1:valDescripcionRespuesta>
  </ns1:contextoRespuesta>
  <ns1:datosPagN900Respuesta>
    <ns1:valImpuesto>12000.00</ns1:valImpuesto>
    <ns1:valMontoMantenimiento>100.00</ns1:valMontoMantenimiento>
    <ns1:valMora>500.00</ns1:valMora>
    <ns1:valMulta>2400.00</ns1:valMulta>
  </ns1:datosPagN900Respuesta>
  <ns1:detallePagoDGI>
    <ns1:secuencial>PAG2024031500123456</ns1:secuencial>
    <ns1:sif>SIF2024031500987654</ns1:sif>
  </ns1:detallePagoDGI>
</ns3:opPagoDGIRespuesta>
```

## Cadenas de Conexión y Credenciales

### Servicio CTS COBIS Impuestos
- **Endpoint**: `http://10.235.53.149:9080/GerenciaCobisImpuestos/SrvAplCobisImpuestosService`
- **Business Service**: `Middleware/v2/BusinessServices/CTS/impuesto/biz/impuesto`
- **Operación**: `OpPagoDGI`
- **Protocolo**: SOAP 1.2
- **Timeout**: 0 (sin límite)
- **Retry**: 0 (sin reintentos)

### Servicio de Parametrización OSB
- **Business Service**: `Middleware/Business_Resources/general/Resources/ObtenerParametrizacion/ObtenerParametrizacion`
- **Operación**: `obtenerParametrizacion`

## Mapeo de Entrada (OSB → CTS COBIS)

| Campo Origen (OSB) | Transformación/Script | Campo Destino (CTS) |
|-------------------|----------------------|-------------------|
| Constante `1` | Valor fijo | `ns1:contextoTransaccional/ns1:codCanalOriginador` |
| `$pagoDGIRequest/BILL_NUMBER` | `data()` directo | `ns1:datosPagN900/ns1:bit` |
| `$pagoDGIRequest/PAYMENT_AMOUNT` | `data()` directo | `ns1:datosPagN900/ns1:valMontoPago` |
| `current-dateTime()` | Timestamp actual con timezone | `ns1:datosPagN900/ns1:fechaPago` |
| `current-dateTime()` | Formato HH:mm:ss | `ns1:datosPagN900/ns1:horaPago` |
| Función `obtenerIndicadorPago()` | Cálculo 1 o 2 | `ns1:datosPagN900/ns1:indicadorPago` |
| `$formaPagoDGIParam` | Parámetro de configuración | `ns1:datosPagN900/ns1:formaPago` |
| `$codigoBancoDGIParam` | Parámetro de configuración | `ns1:datosPagN900/ns1:codigoBanco` |
| `$cajaDGIParam` | Parámetro de configuración | `ns1:datosPagN900/ns1:caja` |
| `$pagoDGIRequest/TAX_VALUE` | `data()` directo | `ns1:datosPagN900/ns1:valImpuesto` |
| `$pagoDGIRequest/EXCH_RATE_FEE` | `data()` directo | `ns1:datosPagN900/ns1:valMontoMantenimiento` |
| `$pagoDGIRequest/LATE_FEE` | `data()` directo | `ns1:datosPagN900/ns1:valMora` |
| `$pagoDGIRequest/PENALTY_FEE` | `data()` directo | `ns1:datosPagN900/ns1:valMulta` |
| `$tipoImpuestoDGIParam` | Parámetro de configuración | `ns1:datosPagN900/ns1:tipoImpuesto` |
| `$pagoDGIRequest/TAX_DESCRIPTION` | `data()` directo | `ns1:datosPagN900/ns1:tipoImpuestoTributario` |
| `$pagoDGIRequest/ACCOUNT_CODE` | `data()` directo | `ns1:datosPagN900/ns1:codigoCuenta` |
| `$pagoDGIRequest/RUC` | `data()` directo | `ns1:datosPagN900/ns1:valRUC` |
| `$pagoDGIRequest/DUE_DATE` | Cast a dateTime | `ns1:datosPagN900/ns1:fechaVencimiento` |
| `$pagoDGIRequest/TOTAL_AMOUNT` | `data()` directo | `ns1:datosPagN900/ns1:valMontoBit` |
| `$pagoDGIRequest/ACCOUNT_NUMBER` | `data()` directo | `ns1:datosPagN900/ns1:cuenta` |

### Script de Transformación de Entrada
**Archivo**: `Middleware/v2/Resources/PagoDGI/xq/pagoDGIIn.xq`

**Función de cálculo de indicador de pago**:
```xquery
declare function obtenerIndicadorPago($valTotal as xs:decimal, $valPago as xs:decimal) as xs:string { 
    let $data :=  
        if(($valTotal - $valPago) = 0) then
            '1'
        else
            '2'
    return $data
};
```

**Generación de timestamps**:
```xquery
<ns1:fechaPago>{ fn:adjust-dateTime-to-timezone(current-dateTime(),()) }</ns1:fechaPago>
<ns1:horaPago>{ fn-bea:dateTime-to-string-with-format("HH:mm:ss", fn:adjust-dateTime-to-timezone(current-dateTime(),()) ) }</ns1:horaPago>
```

**Conversión de fecha de vencimiento**:
```xquery
<ns1:fechaVencimiento>{ xs:date($pagoDGIRequest/DUE_DATE) cast as xs:dateTime }</ns1:fechaVencimiento>
```

## Mapeo de Salida (CTS COBIS → OSB)

| Campo Origen (CTS/OSB) | Transformación/Script | Campo Destino (OSB) |
|----------------------|----------------------|-------------------|
| `$pagoDGIRequest/TOTAL_AMOUNT` | Del request original | `TOTAL_AMOUNT` |
| `$pagoDGIRequest/DUE_DATE` | Del request original | `DUE_DATE` |
| `$opPagoDGIRespuesta/ns1:datosPagN900Respuesta/ns1:valImpuesto` | `data()` directo | `TAX_VALUE` |
| `$opPagoDGIRespuesta/ns1:datosPagN900Respuesta/ns1:valMontoMantenimiento` | `data()` directo | `EXCH_RATE_FEE` |
| `$opPagoDGIRespuesta/ns1:datosPagN900Respuesta/ns1:valMora` | `data()` directo | `LATE_FEE` |
| `$opPagoDGIRespuesta/ns1:datosPagN900Respuesta/ns1:valMulta` | `data()` directo | `PENALTY_FEE` |
| `$pagoDGIRequest/PAYMENT_AMOUNT` | Redondeo half-to-even | `BILL_AMOUNT` |
| `$opPagoDGIRespuesta/ns1:detallePagoDGI/ns1:sif` | `data()` directo | `SIF_CODE` |

### Script de Transformación de Salida
**Archivo**: `Middleware/v2/Resources/PagoDGI/xq/pagoDGIOut.xq`

**Redondeo de monto pagado**:
```xquery
<BILL_AMOUNT>{ round-half-to-even(data($pagoDGIRequest/PAYMENT_AMOUNT), 2) }</BILL_AMOUNT>
```

**Mapeo de campos de respuesta CTS**:
```xquery
{
    for $valImpuesto in $opPagoDGIRespuesta/ns1:datosPagN900Respuesta/ns1:valImpuesto
    return
        <TAX_VALUE>{ data($valImpuesto) }</TAX_VALUE>
}
```

### Script de Transformación de Header
**Archivo**: `Middleware/v2/Resources/PagoDGI/xq/pagoDGIHeaderOut.xq`

**Lógica de mapeo de códigos de respuesta con transactionId**:
```xquery
let $successIndicator := fn:string($opPagoDGIRespuesta/ns1:contextoRespuesta/ns1:codTipoRespuesta/text())
return
    if ($successIndicator = "0") then (
        <transactionId>{ data($opPagoDGIRespuesta/ns1:detallePagoDGI/ns1:secuencial) }</transactionId>,
        <successIndicator>Success</successIndicator>
    ) else (
        <successIndicator>{ $successIndicator }</successIndicator>,
        <messages>{ data($opPagoDGIRespuesta/ns1:contextoRespuesta/ns1:valDescripcionRespuesta) }</messages>
    )
```

## Reglas de Negocio Detectadas

### 1. Parametrización Obligatoria (4 Parámetros)
**Ubicación**: Pipeline `NI01_PagoDGI_request`, etapa `ObtenerParametrizacion`
**Regla**: Debe obtener 4 parámetros de configuración antes de procesar
**Parámetros requeridos**:
- `FICBCO0257.CAJADGI`
- `FICBCO0257.FORMAPAGODGI`
- `FICBCO0256.CODIGOBANCODGI`
- `FICBCO0257.TIPOIMPUESTODGI`

### 2. Cálculo Automático de Indicador de Pago
**Ubicación**: `pagoDGIIn.xq`, función `obtenerIndicadorPago()`
**Regla**: Determinar si el pago es completo o parcial
**Implementación**:
```xquery
if(($valTotal - $valPago) = 0) then '1' else '2'
```
- **"1"**: Pago completo (TOTAL_AMOUNT = PAYMENT_AMOUNT)
- **"2"**: Pago parcial (TOTAL_AMOUNT > PAYMENT_AMOUNT)

### 3. Generación Automática de Timestamp
**Ubicación**: `pagoDGIIn.xq`
**Regla**: Generar fecha y hora actual del pago automáticamente
**Implementación**:
```xquery
<ns1:fechaPago>{ fn:adjust-dateTime-to-timezone(current-dateTime(),()) }</ns1:fechaPago>
<ns1:horaPago>{ fn-bea:dateTime-to-string-with-format("HH:mm:ss", current-dateTime()) }</ns1:horaPago>
```

### 4. Contexto Transaccional COBIS Obligatorio
**Ubicación**: `pagoDGIIn.xq`
**Regla**: Todas las solicitudes CTS deben incluir contexto con canal originador fijo
**Implementación**:
```xquery
<ns1:contextoTransaccional>
    <ns1:codCanalOriginador>1</ns1:codCanalOriginador>
</ns1:contextoTransaccional>
```

### 5. Validación de Esquema CTS
**Ubicación**: Pipeline `NI01_PagoDGI_request`, etapa `PagoDGI`
**Regla**: Validar request contra esquema CTS antes del envío
**Esquema**: `Middleware/v2/BusinessServices/CTS/impuesto/xsd/services.xsd`

### 6. Mapeo de Códigos de Respuesta CTS con TransactionId
**Ubicación**: `pagoDGIHeaderOut.xq`
**Regla**: Código "0" = Success + transactionId, otros códigos = Error con mensaje
**Implementación**:
```xquery
if ($successIndicator = "0") then (
    <transactionId>{ data($opPagoDGIRespuesta/ns1:detallePagoDGI/ns1:secuencial) }</transactionId>,
    <successIndicator>Success</successIndicator>
)
```

### 7. Redondeo de Montos de Pago
**Ubicación**: `pagoDGIOut.xq`
**Regla**: Redondear PAYMENT_AMOUNT a 2 decimales usando half-to-even
**Implementación**:
```xquery
<BILL_AMOUNT>{ round-half-to-even(data($pagoDGIRequest/PAYMENT_AMOUNT), 2) }</BILL_AMOUNT>
```

### 8. Conversión de Fecha de Vencimiento
**Ubicación**: `pagoDGIIn.xq`
**Regla**: Convertir fecha date a dateTime para CTS
**Implementación**:
```xquery
<ns1:fechaVencimiento>{ xs:date($pagoDGIRequest/DUE_DATE) cast as xs:dateTime }</ns1:fechaVencimiento>
```

### 9. Combinación de Datos Request + Response
**Ubicación**: `pagoDGIOut.xq`
**Regla**: La respuesta combina datos del request original con datos de la respuesta CTS
**Campos del request**: TOTAL_AMOUNT, DUE_DATE, PAYMENT_AMOUNT (como BILL_AMOUNT)
**Campos de CTS**: TAX_VALUE, EXCH_RATE_FEE, LATE_FEE, PENALTY_FEE, SIF_CODE

### 10. Manejo de Errores de Parametrización
**Ubicación**: Pipeline `NI01_PagoDGI_response`
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
- **Operación**: `OpPagoDGI`

### Servicio de Parametrización OSB
- **Business Service**: `ObtenerParametrizacion`
- **Parámetros**: CAJADGI, FORMAPAGODGI, CODIGOBANCODGI, TIPOIMPUESTODGI

### Transformaciones Específicas
- **Input**: `pagoDGIIn.xq` (con función de cálculo)
- **Output**: `pagoDGIOut.xq` (con redondeo)
- **Header Output**: `pagoDGIHeaderOut.xq` (con transactionId)

### Validaciones Específicas
- **XSD OSB**: `pagoDGITypes.xsd` (12 campos obligatorios)
- **XSD CTS**: `services.xsd`
- **Parametrización**: Validación de 4 configuraciones

### Campos Únicos de PagoDGI
- **Entrada**: PAYMENT_AMOUNT, ACCOUNT_NUMBER (no en ConsultaDGI)
- **Salida**: SIF_CODE, transactionId (no en ConsultaDGI)
- **Cálculos**: indicadorPago, timestamps automáticos