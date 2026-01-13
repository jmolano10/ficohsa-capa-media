# Ejemplos de Request/Response y Mapeo de Datos - Otras Regiones (Default)

## Request OSB (ejemplo SOAP/XML)

```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Header>
    <aut:RequestHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
      <Authentication>
        <UserName>USUARIO_REGION</UserName>
        <Password>PASSWORD_REGION</Password>
      </Authentication>
      <Region>
        <SourceBank>HN01</SourceBank>
        <DestinationBank>HN01</DestinationBank>
      </Region>
    </aut:RequestHeader>
  </soap:Header>
  <soap:Body>
    <con:consultaDGI xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaDGITypes">
      <RUC>0801198000001</RUC>
      <BILL_NUMBER>FAC-2024-001234</BILL_NUMBER>
    </con:consultaDGI>
  </soap:Body>
</soap:Envelope>
```

## Response OSB (ejemplo SOAP/XML)

```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Header>
    <aut:ResponseHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
      <successIndicator>ERROR</successIndicator>
      <messages>SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY</messages>
    </aut:ResponseHeader>
  </soap:Header>
  <soap:Body>
    <soap:Fault>
      <faultcode>MW-0008</faultcode>
      <faultstring>SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY</faultstring>
    </soap:Fault>
  </soap:Body>
</soap:Envelope>
```

## Flujo de Procesamiento para Otras Regiones

### Validaciones Ejecutadas

#### 1. Validación XSD
```xml
<!-- Validación exitosa contra consultaDGITypes.xsd -->
<con:validate>
  <con:schema ref="Middleware/v2/Resources/ConsultaDGI/xsd/consultaDGITypes"/>
  <con:schemaElement>con:consultaDGI</con:schemaElement>
  <con:varName>body</con:varName>
</con:validate>
```

#### 2. Validación de Servicio Regional
```xml
<!-- Validación exitosa para FICBCO0256 -->
<con:wsCallout>
  <con:service ref="Middleware/v2/BusinessServices/ValidaServicioRegional/biz/ValidaServicioRegional_db"/>
  <con:operation>ValidaServicioRegional</con:operation>
</con:wsCallout>
```

### Request a ValidaServicioRegional

```xml
<val:ValidaServicioRegional xmlns:val="http://xmlns.oracle.com/pcbpel/adapter/db/sp/ValidaServicioRegional">
  <val:PV_SERVICE_ID>FICBCO0256</val:PV_SERVICE_ID>
  <val:PV_SOURCE_BANK>HN01</val:PV_SOURCE_BANK>
  <val:PV_DESTINATION_BANK>HN01</val:PV_DESTINATION_BANK>
</val:ValidaServicioRegional>
```

### Response de ValidaServicioRegional

```xml
<val:ValidaServicioRegionalResponse xmlns:val="http://xmlns.oracle.com/pcbpel/adapter/db/sp/ValidaServicioRegional">
  <val:PV_CODIGO_ERROR>SUCCESS</val:PV_CODIGO_ERROR>
  <val:PV_MENSAJE_ERROR></val:PV_MENSAJE_ERROR>
</val:ValidaServicioRegionalResponse>
```

## Enrutamiento Regional

### Lógica de Enrutamiento
```xml
<con:branch-table variable="header">
  <con:xpath>./aut:RequestHeader/Region/SourceBank</con:xpath>
  <con:branch name="NI01">
    <con:operator>equals</con:operator>
    <con:value>'NI01'</con:value>
    <!-- Flujo implementado -->
  </con:branch>
  <con:default-branch>
    <!-- Flujo Default - Error MW-0008 -->
  </con:default-branch>
</con:branch-table>
```

### Regiones que Ejecutan Default
- **HN01**: Honduras
- **HN02**: Honduras FPC
- **GT01**: Guatemala
- **PA01**: Panamá
- **Cualquier otra región no especificada**

## Pipeline Default - Request

### Etapa: FlujoEntrada
```xml
<con:stage name="FlujoEntrada">
  <con:context/>
  <!-- Sin acciones - Pipeline vacío -->
</con:stage>
```

**Características:**
- No hay procesamiento de datos
- No hay transformaciones
- No hay llamadas a servicios externos
- Pipeline completamente vacío

## Pipeline Default - Response

### Etapa: FlujoSalida
```xml
<con:stage name="FlujoSalida">
  <con:context>
    <con:varNsDecl namespace="http://www.ficohsa.com.hn/middleware.services/autType" prefix="aut"/>
  </con:context>
  <con:actions>
    <con:Error>
      <con:errCode>MW-0008</con:errCode>
      <con:message>SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY</con:message>
    </con:Error>
  </con:actions>
</con:stage>
```

**Características:**
- Genera error inmediato MW-0008
- Mensaje estándar de servicio no implementado
- No hay procesamiento de datos
- Termina ejecución con fault

## Manejo de Errores para Otras Regiones

### Error MW-0008
- **Código**: MW-0008
- **Mensaje**: "SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY"
- **Tipo**: Error de implementación
- **Comportamiento**: Termina procesamiento inmediatamente

### Flujo de Error
1. **Validaciones**: Pasan correctamente
2. **Enrutamiento**: Dirige a Default
3. **Pipeline Request**: Vacío (sin procesamiento)
4. **Pipeline Response**: Genera error MW-0008
5. **Cliente**: Recibe SOAP Fault

## Mapeo de Errores

### Error Handler General
Si ocurre cualquier error técnico durante las validaciones:

```xml
<con:pipeline type="error" name="_onErrorHandler">
  <con:stage name="ManejoError">
    <con:actions>
      <con:assign varName="errorCode">
        <con:expr>fn:string($fault/ctx:errorCode/text())</con:expr>
      </con:assign>
      <con:assign varName="errorMessage">
        <con:expr>fn:string($fault/ctx:reason/text())</con:expr>
      </con:assign>
      <con:wsCallout>
        <con:service ref="Middleware/v2/ProxyServices/MapeoErrores"/>
        <con:operation>mapeoErrores</con:operation>
      </con:wsCallout>
    </con:actions>
  </con:stage>
</con:pipeline>
```

### Request a MapeoErrores

```xml
<mapeoErrores>
  <CODIGO_ERROR>{errorCode}</CODIGO_ERROR>
  <MENSAJE_ERROR>FICBCO0256$#${errorMessage}</MENSAJE_ERROR>
</mapeoErrores>
```

## Validaciones Aplicadas a Todas las Regiones

### 1. Validación XSD de Entrada
**Esquema**: `Middleware/v2/Resources/ConsultaDGI/xsd/consultaDGITypes.xsd`
**Elemento**: `consultaDGI`
**Campos validados**:
- RUC: String con longitud mínima 1
- BILL_NUMBER: String con longitud mínima 1

### 2. Validación de Servicio Regional
**Service ID**: FICBCO0256
**Business Service**: `ValidaServicioRegional_db`
**Validación**: Disponibilidad del servicio por región

### 3. Aplicación de Valores por Defecto
**Transformación**: `aplicarValoresPorDefectoRegion.xq`
**Propósito**: Normalizar headers de región

## Diferencias con NI01

| Aspecto | NI01 | Otras Regiones |
|---------|------|----------------|
| **Procesamiento** | Completo | Solo validaciones |
| **Servicios externos** | CTS COBIS + Parametrización | Ninguno |
| **Transformaciones** | 3 archivos XQuery | Ninguna |
| **Response** | Datos fiscales completos | Error MW-0008 |
| **Complejidad** | Alta | Mínima |
| **Dependencias** | Múltiples | Solo validaciones |

## Consideraciones para Implementación Futura

### Para implementar ConsultaDGI en otras regiones se requeriría:

1. **Identificar sistema fiscal local**:
   - Honduras: SAR (Servicio de Administración de Rentas)
   - Guatemala: SAT (Superintendencia de Administración Tributaria)
   - Panamá: DGI (Dirección General de Ingresos)

2. **Crear business services específicos**:
   - Conexiones a APIs fiscales locales
   - Adaptadores de base de datos si aplica
   - Configuraciones de timeout y retry

3. **Desarrollar transformaciones**:
   - XQuery de entrada específico por región
   - XQuery de salida específico por región
   - Mapeo de campos fiscales locales

4. **Configurar parámetros regionales**:
   - Códigos de banco por región
   - Tipos de consulta por región
   - Configuraciones específicas

5. **Adaptar manejo de errores**:
   - Códigos de error locales
   - Mensajes en idioma local
   - Mapeo a códigos estándar OSB

### Patrón de implementación sugerido:
```xml
<con:branch name="HN01">
  <con:operator>equals</con:operator>
  <con:value>'HN01'</con:value>
  <con:flow>
    <con:pipeline-node name="HN01_ConsultaDGI">
      <con:request>HN01_ConsultaDGI_request</con:request>
      <con:response>HN01_ConsultaDGI_response</con:response>
    </con:pipeline-node>
  </con:flow>
</con:branch>
```