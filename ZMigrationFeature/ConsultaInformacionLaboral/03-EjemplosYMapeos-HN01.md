# Ejemplos de Request/Response y Mapeo de Datos - HN01

## Request OSB (ejemplo XML)

```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Header>
    <aut:RequestHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
      <Authentication>
        <UserName>testuser</UserName>
        <Password>testpass</Password>
      </Authentication>
      <Region>
        <SourceBank>HN01</SourceBank>
        <DestinationBank>HN01</DestinationBank>
      </Region>
    </aut:RequestHeader>
  </soap:Header>
  <soap:Body>
    <con:consultaInformacionLaboralRequest xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaInformacionLaboralTypes">
      <con:CUSTOMER_ACCOUNT>1234567890</con:CUSTOMER_ACCOUNT>
      <con:FROM_DATE>20230101</con:FROM_DATE>
      <con:TO_DATE>20231231</con:TO_DATE>
    </con:consultaInformacionLaboralRequest>
  </soap:Body>
</soap:Envelope>
```

## Response OSB (ejemplo XML)

```xml
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Header>
    <aut:ResponseHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
      <successIndicator>ERROR</successIndicator>
      <messages>MW-0008: SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY</messages>
    </aut:ResponseHeader>
  </soap:Header>
  <soap:Body>
    <con:consultaInformacionLaboralResponse xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaInformacionLaboralTypes"/>
  </soap:Body>
</soap:Envelope>
```

## Requests/Responses internos a servicios dependientes

### Validación de Servicio Regional

**Request a ValidaServicioRegional_db**:
```xml
<val:InputParameters xmlns:val="http://xmlns.oracle.com/pcbpel/adapter/db/sp/ValidaServicioRegional">
  <val:PV_SERVICE_ID>FICBCO0181</val:PV_SERVICE_ID>
  <val:PV_SOURCE_BANK>HN01</val:PV_SOURCE_BANK>
  <val:PV_DESTINATION_BANK>HN01</val:PV_DESTINATION_BANK>
</val:InputParameters>
```

**Response de ValidaServicioRegional_db**:
```xml
<val:OutputParameters xmlns:val="http://xmlns.oracle.com/pcbpel/adapter/db/sp/ValidaServicioRegional">
  <val:PV_CODIGO_ERROR>ERROR</val:PV_CODIGO_ERROR>
  <val:PV_MENSAJE_ERROR>Servicio no implementado para esta región</val:PV_MENSAJE_ERROR>
</val:OutputParameters>
```

## Cadenas de conexión detectadas y credenciales

### Base de Datos
- **Nombre de Conexión**: No encontrado - servicio no implementado
- **Esquema**: No encontrado
- **Stored Procedure**: No encontrado
- **Package**: No encontrado

### Servicios WSDL
- **Endpoint WSDL**: No encontrado - servicio no implementado
- **Operación**: No encontrado

### Credenciales
- **Referencia de Credenciales**: No encontrado - servicio no implementado

## Tablas de mapeo de entrada por cada llamada a servicio dependiente

### Validación Regional

| Campo Origen (OSB) | Transformación/Script | Campo Destino (ValidaServicioRegional) |
|-------------------|----------------------|---------------------------------------|
| Constante "FICBCO0181" | Valor fijo | PV_SERVICE_ID |
| header/aut:RequestHeader/Region/SourceBank | Mapeo directo | PV_SOURCE_BANK |
| header/aut:RequestHeader/Region/DestinationBank | Mapeo directo | PV_DESTINATION_BANK |

**Archivo de transformación**: `Middleware/v2/Resources/Generales/xq/validaServicioRegionalIn`

### Servicio Principal
❌ **No implementado** - No hay mapeos de entrada para HN01

## Tablas de mapeo de salida por cada respuesta de servicio dependiente

### Validación Regional

| Campo Origen (ValidaServicioRegional) | Transformación/Script | Campo Destino (OSB) |
|--------------------------------------|----------------------|-------------------|
| PV_CODIGO_ERROR | Evaluación: si != 'SUCCESS' | successIndicator = 'ERROR' |
| PV_MENSAJE_ERROR | Mapeo directo | messages |

### Servicio Principal
❌ **No implementado** - No hay mapeos de salida para HN01

## Reglas de negocio detectadas

### 1. Validación Regional
- **Ubicación**: Pipeline ValidacionesGenerales_request, Stage ValidacionServicioRegional
- **Archivo**: ConsultaInformacionLaboral.proxy
- **Línea**: Aproximadamente línea 45-80
- **Lógica**: 
  ```xquery
  fn:string($RSP_ValidaServicioRegional/val:PV_CODIGO_ERROR/text()) != 'SUCCESS'
  ```
- **Descripción**: Si la validación regional falla, se devuelve error inmediatamente

### 2. Enrutamiento Regional
- **Ubicación**: Branch node RegionalizacionPaisEmpresa
- **Archivo**: ConsultaInformacionLaboral.proxy
- **Línea**: Aproximadamente línea 200-220
- **Lógica**: 
  ```xpath
  ./aut:RequestHeader/Region/SourceBank
  ```
- **Descripción**: Enruta a pipeline específico basado en SourceBank. Para HN01 va al pipeline Default

### 3. Error por Servicio No Implementado
- **Ubicación**: Pipeline Default_ConsultaInformacionLaboral_response, Stage ProxySvcResponse
- **Archivo**: ConsultaInformacionLaboral.proxy
- **Línea**: Aproximadamente línea 180-190
- **Código de Error**: MW-0008
- **Mensaje**: "SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY"
- **Descripción**: Devuelve error estándar para regiones no implementadas

### 4. Manejo de Errores Generales
- **Ubicación**: Error Handler _onErrorHandler-1771452867105238821-332ff2a4.14e547ec944.-7cac
- **Archivo**: ConsultaInformacionLaboral.proxy
- **Transformación**: `Middleware/Business_Resources/general/ServiceErrorId/obtenerServiceErrorId`
- **Parámetros**:
  - string1: "0181" (Service ID)
  - string2: Concatenación de errorCode y reason
- **Descripción**: Mapea códigos de error internos a mensajes de usuario

### 5. Validación XSD
- **Ubicación**: Pipeline ValidacionesGenerales_request, Stage ValidacionXSD
- **Esquema**: `Middleware/v2/Resources/ConsultaInformacionLaboral/xsd/consultaInformacionLaboralTypes`
- **Elemento**: `con:consultaInformacionLaboralRequest`
- **Variable de Resultado**: esquemaValido
- **Descripción**: Valida que el request cumpla con el esquema XSD definido

## Estado de Implementación para HN01

❌ **SERVICIO NO IMPLEMENTADO**

La región HN01 (Honduras Principal) no tiene implementación específica para la consulta de información laboral. El servicio:

1. Pasa las validaciones generales (XSD y regional)
2. Se enruta al pipeline Default
3. Devuelve inmediatamente el error MW-0008
4. No realiza ninguna consulta a servicios externos o bases de datos

## Recomendaciones para Implementación

Para implementar el servicio en HN01 sería necesario:

1. **Crear Business Service específico** para HN01
2. **Definir transformaciones** de entrada y salida
3. **Configurar conexiones** a la fuente de datos correspondiente
4. **Implementar pipeline específico** para HN01
5. **Actualizar enrutamiento** en el branch node
6. **Definir reglas de negocio** específicas para la región