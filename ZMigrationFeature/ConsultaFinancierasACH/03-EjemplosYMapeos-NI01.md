# Ejemplos de Request/Response y Mapeo de Datos - NI01 (Nicaragua)

## Request OSB (ejemplo SOAP/XML)

```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Header>
    <aut:RequestHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
      <Authentication>
        <UserName>USUARIO_NI</UserName>
        <Password>PASSWORD_NI</Password>
      </Authentication>
      <Region>
        <SourceBank>NI01</SourceBank>
        <DestinationBank>NI01</DestinationBank>
      </Region>
    </aut:RequestHeader>
  </soap:Header>
  <soap:Body>
    <con:consultaFinancierasACH xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaFinancierasACHTypes">
      <DESTINATION_CODE>301</DESTINATION_CODE>
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
          <DESTINATION_CODE>301</DESTINATION_CODE>
          <DESTINATION_NAME>BANCO DE LA PRODUCCION NICARAGUA</DESTINATION_NAME>
          <con:consultaFinancierasACHDetailResponseType>
            <con:consultaFinancierasACHDetailResponseRecordType>
              <TYPE_OF_PRODUCT>CUENTA_CORRIENTE</TYPE_OF_PRODUCT>
              <MIN_PRODUCT_ID_LENGTH>1</MIN_PRODUCT_ID_LENGTH>
              <MAX_PRODUCT_ID_LENGTH>100</MAX_PRODUCT_ID_LENGTH>
              <LEADING_ZEROS_YES_NO>YES</LEADING_ZEROS_YES_NO>
              <PRODUCT_ID_SAMPLE></PRODUCT_ID_SAMPLE>
            </con:consultaFinancierasACHDetailResponseRecordType>
            <con:consultaFinancierasACHDetailResponseRecordType>
              <TYPE_OF_PRODUCT>CUENTA_AHORRO</TYPE_OF_PRODUCT>
              <MIN_PRODUCT_ID_LENGTH>1</MIN_PRODUCT_ID_LENGTH>
              <MAX_PRODUCT_ID_LENGTH>100</MAX_PRODUCT_ID_LENGTH>
              <LEADING_ZEROS_YES_NO>YES</LEADING_ZEROS_YES_NO>
              <PRODUCT_ID_SAMPLE></PRODUCT_ID_SAMPLE>
            </con:consultaFinancierasACHDetailResponseRecordType>
          </con:consultaFinancierasACHDetailResponseType>
        </con:consultaFinancierasACHResponseRecordType>
      </con:consultaFinancierasACHResponseType>
    </con:consultaFinancierasACHResponse>
  </soap:Body>
</soap:Envelope>
```

## Request/Response Interno a CTS COBIS

### Request a CTS COBIS Service

```xml
<ns2:opConsultaFinacierasACHSolicitud xmlns:ns2="http://service.srvaplcobistransferencia.ecobis.cobiscorp" xmlns:ns1="http://dto.srvaplcobisentidades.ecobis.cobiscorp">
  <ns1:banco>
    <ns1:codigoAch>301</ns1:codigoAch>
  </ns1:banco>
  <ns1:contextoTransaccional>
    <ns1:codCanalOriginador>1</ns1:codCanalOriginador>
  </ns1:contextoTransaccional>
</ns2:opConsultaFinacierasACHSolicitud>
```

### Response de CTS COBIS Service

```xml
<ns3:opConsultaFinacierasACHRespuesta xmlns:ns3="http://service.srvaplcobistransferencia.ecobis.cobiscorp" xmlns:ns0="http://dto.srvaplcobisentidades.ecobis.cobiscorp">
  <ns0:banco>
    <ns0:codigoAch>301</ns0:codigoAch>
    <ns0:nombreBanco>BANCO DE LA PRODUCCION NICARAGUA</ns0:nombreBanco>
  </ns0:banco>
  <ns0:banco>
    <ns0:codigoAch>302</ns0:codigoAch>
    <ns0:nombreBanco>BANCO CENTROAMERICANO NICARAGUA</ns0:nombreBanco>
  </ns0:banco>
</ns3:opConsultaFinacierasACHRespuesta>
```

## Request/Response a Servicio de Parametrización

### Request a ObtenerParametrizacion

```xml
<osb:obtenerParametrizacion xmlns:osb="http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_GET_CONFIG/">
  <osb:NOMBRE_PARAMETROS>FICBCO0118.NI.PRODUCTS_TYPES</osb:NOMBRE_PARAMETROS>
</osb:obtenerParametrizacion>
```

### Response de ObtenerParametrizacion

```xml
<osb:obtenerParametrizacionResponse xmlns:osb="http://xmlns.oracle.com/pcbpel/adapter/db/ORA_BANK/OSB_GET_CONFIG/">
  <osb:ERROR_CODE>SUCCESS</osb:ERROR_CODE>
  <osb:CONFIGURACIONES>
    <osb:CONFIGURACIONES_ITEM>
      <osb:NAME>FICBCO0118.NI.PRODUCTS_TYPES</osb:NAME>
      <osb:VALUE>CUENTA_CORRIENTE|CUENTA_AHORRO|CUENTA_PLAZO|PRESTAMO</osb:VALUE>
    </osb:CONFIGURACIONES_ITEM>
  </osb:CONFIGURACIONES>
</osb:obtenerParametrizacionResponse>
```

## Cadenas de Conexión y Credenciales

### Servicio CTS COBIS
- **Endpoint**: `http://10.235.53.149:9080/GerenciaTransferencia/SrvAplCobisTransferenciaService`
- **Operación**: `OpConsultaFinacierasACH`
- **Protocolo**: SOAP 1.2
- **Tipo de Conexión**: HTTP Web Service
- **Timeout**: 0 (sin límite)
- **Retry Count**: 0 (sin reintentos)

### Servicio de Parametrización
- **Business Service**: `Middleware/Business_Resources/general/Resources/ObtenerParametrizacion/ObtenerParametrizacion`
- **Operación**: `obtenerParametrizacion`
- **Parámetro**: `FICBCO0118.NI.PRODUCTS_TYPES`

## Mapeo de Entrada (OSB → CTS COBIS)

| Campo Origen (OSB) | Transformación/Script | Campo Destino (CTS) |
|-------------------|----------------------|-------------------|
| `$body/con:consultaFinancierasACH/DESTINATION_CODE` | `data()` directo | `ns1:banco/ns1:codigoAch` |
| Constante `1` | Valor fijo | `ns1:contextoTransaccional/ns1:codCanalOriginador` |

### Script de Transformación de Entrada
**Archivo**: `Middleware/v2/Resources/ConsultaFinancierasACH/xq/consultaFinanacierasACHNIIn.xq`

```xquery
declare function xf:consultaFinanacierasACHNIin($consultaFinancierasACH1 as element(ns0:consultaFinancierasACH))
    as element(ns2:opConsultaFinacierasACHSolicitud) {
        <ns2:opConsultaFinacierasACHSolicitud>
            <ns1:banco>
                {
                    for $DESTINATION_CODE in $consultaFinancierasACH1/DESTINATION_CODE
                    return
                        <ns1:codigoAch>{ data($DESTINATION_CODE) }</ns1:codigoAch>
                }
            </ns1:banco>
            <ns1:contextoTransaccional>
                <ns1:codCanalOriginador>1</ns1:codCanalOriginador>
            </ns1:contextoTransaccional>
        </ns2:opConsultaFinacierasACHSolicitud>
};
```

## Mapeo de Salida (CTS COBIS → OSB)

| Campo Origen (CTS) | Transformación/Script | Campo Destino (OSB) |
|-------------------|----------------------|-------------------|
| `$opConsultaFinacierasACHRespuesta1/ns0:banco/ns0:codigoAch` | `data()` directo | `DESTINATION_CODE` |
| `$opConsultaFinacierasACHRespuesta1/ns0:banco/ns0:nombreBanco` | `data()` directo | `DESTINATION_NAME` |
| `$tiposProducto` | Tokenización por `\|` | `TYPE_OF_PRODUCT` (múltiples) |
| Constante `1` | Valor fijo | `MIN_PRODUCT_ID_LENGTH` |
| Constante `100` | Valor fijo | `MAX_PRODUCT_ID_LENGTH` |
| Constante `YES` | Valor fijo | `LEADING_ZEROS_YES_NO` |
| Constante vacía | Valor fijo | `PRODUCT_ID_SAMPLE` |

### Script de Transformación de Salida
**Archivo**: `Middleware/v2/Resources/ConsultaFinancierasACH/xq/consultaFinanacierasACHNIOut.xq`

```xquery
declare function xf:consultaFinanacierasACHNIOut($opConsultaFinacierasACHRespuesta1 as element(ns3:opConsultaFinacierasACHRespuesta),
    $tiposProducto as xs:string)
    as element(ns1:consultaFinancierasACHResponse) {
        <ns1:consultaFinancierasACHResponse>
            <ns1:consultaFinancierasACHResponseType>
                {
                    for $banco in $opConsultaFinacierasACHRespuesta1/ns0:banco
                    return
                        <ns1:consultaFinancierasACHResponseRecordType>
                            {
                                for $codigoAch in $banco/ns0:codigoAch
                                return
                                    <DESTINATION_CODE>{ data($codigoAch) }</DESTINATION_CODE>
                            }
                            {
                                for $nombreBanco in $banco/ns0:nombreBanco
                                return
                                    <DESTINATION_NAME>{ data($nombreBanco) }</DESTINATION_NAME>
                            }
                            <ns1:consultaFinancierasACHDetailResponseType>
                                {
                                    for $tipo in tokenize($tiposProducto, '\|')
                                    return                                 	
                                    <ns1:consultaFinancierasACHDetailResponseRecordType>
                                        <TYPE_OF_PRODUCT>{ $tipo }</TYPE_OF_PRODUCT>
                                        <MIN_PRODUCT_ID_LENGTH>1</MIN_PRODUCT_ID_LENGTH>
                                        <MAX_PRODUCT_ID_LENGTH>100</MAX_PRODUCT_ID_LENGTH>
                                        <LEADING_ZEROS_YES_NO>YES</LEADING_ZEROS_YES_NO>
                                        <PRODUCT_ID_SAMPLE></PRODUCT_ID_SAMPLE>                                	                               
                                    </ns1:consultaFinancierasACHDetailResponseRecordType>
                                }   
                            </ns1:consultaFinancierasACHDetailResponseType>
                        </ns1:consultaFinancierasACHResponseRecordType>
                }
            </ns1:consultaFinancierasACHResponseType>
        </ns1:consultaFinancierasACHResponse>
};
```

### Script de Transformación de Header
**Archivo**: `Middleware/v2/Resources/ConsultaFinancierasACH/xq/consultaFinanacierasACHNIHeaderOut.xq`

## Reglas de Negocio Detectadas

### 1. Contexto Transaccional COBIS Obligatorio
**Ubicación**: `consultaFinanacierasACHNIIn.xq` líneas 18-20
**Regla**: Todas las solicitudes a CTS COBIS deben incluir contexto transaccional con canal originador
**Implementación**:
```xquery
<ns1:contextoTransaccional>
    <ns1:codCanalOriginador>1</ns1:codCanalOriginador>
</ns1:contextoTransaccional>
```

### 2. Parametrización Externa de Tipos de Producto
**Ubicación**: Pipeline `NI01_ConsultaFinancierasACH_response`
**Regla**: Los tipos de producto se obtienen de parametrización externa, no de la respuesta CTS
**Parámetro**: `FICBCO0118.NI.PRODUCTS_TYPES`
**Implementación**:
```xquery
<con2:assign varName="productTypesParamNI">
    <con1:xqueryText>"FICBCO0118.NI.PRODUCTS_TYPES"</con1:xqueryText>
</con2:assign>
```

### 3. Tokenización de Tipos de Producto
**Ubicación**: `consultaFinanacierasACHNIOut.xq` líneas 25-35
**Regla**: Los tipos de producto se separan por pipe (|) y se crean registros individuales
**Implementación**:
```xquery
for $tipo in tokenize($tiposProducto, '\|')
return                                 	
<ns1:consultaFinancierasACHDetailResponseRecordType>
    <TYPE_OF_PRODUCT>{ $tipo }</TYPE_OF_PRODUCT>
```

### 4. Valores Fijos para Longitudes y Configuraciones
**Ubicación**: `consultaFinanacierasACHNIOut.xq` líneas 28-31
**Regla**: Nicaragua usa valores fijos para longitudes y configuraciones de producto
**Implementación**:
```xquery
<MIN_PRODUCT_ID_LENGTH>1</MIN_PRODUCT_ID_LENGTH>
<MAX_PRODUCT_ID_LENGTH>100</MAX_PRODUCT_ID_LENGTH>
<LEADING_ZEROS_YES_NO>YES</LEADING_ZEROS_YES_NO>
<PRODUCT_ID_SAMPLE></PRODUCT_ID_SAMPLE>
```

### 5. Validación de Parametrización Exitosa
**Ubicación**: Pipeline `NI01_ConsultaFinancierasACH_response`
**Regla**: Verificar que la parametrización se obtuvo correctamente antes de procesar
**Implementación**:
```xquery
<con2:case>
    <con2:condition>
        <con1:xqueryText>$statusParametrizacion = "SUCCESS"</con1:xqueryText>
    </con2:condition>
```

### 6. Manejo de Error de Parametrización
**Ubicación**: Pipeline `NI01_ConsultaFinancierasACH_response`
**Regla**: Si falla la parametrización, generar error MW-0011
**Implementación**:
```xquery
<con2:default>
    <con2:Error>
        <con1:id>_ActionId-871453850187464558--28e35a46.15ec47e7f2a.-7f55</con1:id>
        <con2:errCode>MW-0011</con2:errCode>
    </con2:Error>
</con2:default>
```

### 7. Agrupación por Banco Individual
**Ubicación**: `consultaFinanacierasACHNIOut.xq` líneas 10-15
**Regla**: Cada banco en la respuesta CTS genera un registro separado en la respuesta OSB
**Implementación**:
```xquery
for $banco in $opConsultaFinacierasACHRespuesta1/ns0:banco
return
    <ns1:consultaFinancierasACHResponseRecordType>
```

### 8. Validación de Esquema CTS
**Ubicación**: Pipeline `NI01_ConsultaFinancierasACH_request`
**Regla**: Validar el request contra el esquema CTS antes del envío
**Esquema**: `Middleware/v2/BusinessServices/CTS/transferencia/xsd/services.xsd`
**Implementación**:
```xml
<con2:validate>
    <con2:schema ref="Middleware/v2/BusinessServices/CTS/transferencia/xsd/services"/>
    <con2:schemaElement xmlns:ser1="http://service.srvaplcobistransferencia.ecobis.cobiscorp">ser1:opConsultaFinacierasACHSolicitud</con2:schemaElement>
    <con2:varName>REQOpConsultaFinacierasACH</con2:varName>
</con2:validate>
```

## Dependencias Específicas de NI01

### Servicio CTS COBIS
- **Endpoint**: `http://10.235.53.149:9080/GerenciaTransferencia/SrvAplCobisTransferenciaService`
- **Business Service**: `Middleware/v2/BusinessServices/CTS/transferencia/biz/transferencia`
- **Protocolo**: SOAP 1.2
- **Operación**: `OpConsultaFinacierasACH`

### Servicio de Parametrización OSB
- **Business Service**: `Middleware/Business_Resources/general/Resources/ObtenerParametrizacion/ObtenerParametrizacion`
- **Operación**: `obtenerParametrizacion`
- **Parámetro clave**: `FICBCO0118.NI.PRODUCTS_TYPES`

### Transformaciones Específicas
- **Input**: `consultaFinanacierasACHNIIn.xq`
- **Output**: `consultaFinanacierasACHNIOut.xq`
- **Header Output**: `consultaFinanacierasACHNIHeaderOut.xq`

### Características Únicas de Nicaragua
- **Parametrización externa**: Tipos de producto desde configuración OSB
- **Valores fijos**: Longitudes y configuraciones estándar
- **Contexto COBIS**: Requerido para todas las transacciones
- **Sin TRANSFER_TYPE**: Campo no incluido en la respuesta
- **Agrupación por banco**: Cada banco es un registro independiente
- **Tokenización**: Separación de tipos de producto por pipe (|)