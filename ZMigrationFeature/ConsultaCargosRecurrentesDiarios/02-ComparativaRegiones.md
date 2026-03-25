# Comparativa entre Regiones - ConsultaCargosRecurrentesDiarios

## Tabla de Comparación

| Aspecto | HN01 (Honduras) | NI01 (Nicaragua) |
|---------|-----------------|------------------|
| **Endpoint OSB** | `/Middleware/v2/ProxyServices/ConsultaCargosRecurrentesDiariosHN` | `/Middleware/v2/ProxyServices/ConsultaCargosRecurrentesDiariosNI` |
| **Servicio VisaNet** | `wsVisaTransactionHN.biz` | `wsVisaTransaction.biz` |
| **URL VisaNet** | `https://192.168.125.188/WSVisaTransaction.asmx` | `https://192.168.125.16:9443/WSVisaTransaction.asmx` |
| **Protocolo SOAP** | SOAP 1.1 | SOAP 1.2 |
| **Operación VisaNet** | `QueryCardTransaction` | `QueryCardTransaction` |
| **Parámetros de Configuración** | `VISANET.STRUSER.HN01`<br/>`VISANET.STRPASSWORD.HN01`<br/>`VISANET.STRCARDACQMATRIZID.HN01`<br/>`VISANET.STRTERMINALMATRIZID.HN01` | `VISANET.STRUSER.NI01`<br/>`VISANET.STRPASSWORD.NI01`<br/>`VISANET.STRCARDACQMATRIZID.NI01`<br/>`VISANET.STRTERMINALMATRIZID.NI01` |
| **Transformaciones de Entrada** | `queryCardTransactionIn.xq` | `queryCardTransactionIn.xq` |
| **Transformaciones de Salida** | `consultaCargosRecurrentesDiariosOut.xq` | `consultaCargosRecurrentesDiariosOut.xq` |
| **Transformaciones de Header** | `consultaCargosRecurrentesDiariosHeaderOut.xq` | `consultaCargosRecurrentesDiariosHeaderOut.xq` |
| **Validación de Request** | Validación XSD habilitada | Validación XSD habilitada |
| **Manejo de Errores** | Pipeline de error personalizado | Pipeline de error personalizado |
| **Timeout HTTP** | 0 (sin timeout) | 0 (sin timeout) |
| **Retry Count** | 0 (sin reintentos) | 0 (sin reintentos) |
| **Monitoring** | Deshabilitado | Deshabilitado |
| **Logging Level** | Debug | Debug |

## Sección por Región

### HN01 (Honduras)

#### Endpoints y Configuración
- **Proxy Service**: `ConsultaCargosRecurrentesDiariosHN.proxy`
- **Business Service**: `wsVisaTransactionHN.biz`
- **URL Externa**: `https://192.168.125.188/WSVisaTransaction.asmx`
- **Protocolo**: SOAP 1.1
- **Transport**: HTTP

#### Parámetros Específicos
```
VISANET.STRUSER.HN01
VISANET.STRPASSWORD.HN01
VISANET.STRCARDACQMATRIZID.HN01
VISANET.STRTERMINALMATRIZID.HN01
```

#### Mapeos y Validaciones
- **Request Mapping**: Utiliza `queryCardTransactionIn.xq` para transformar el request OSB al formato VisaNet
- **Response Mapping**: Utiliza `consultaCargosRecurrentesDiariosOut.xq` para transformar la respuesta VisaNet al formato OSB
- **Header Mapping**: Utiliza `consultaCargosRecurrentesDiariosHeaderOut.xq` para mapear códigos de respuesta
- **Validación**: Validación XSD contra el esquema `WSVisaTransaction.wsdl`

#### Políticas OSB
- **Security**: No configurada a nivel de proxy regional
- **Throttling**: No configurado
- **Result Caching**: No configurado
- **WS-Policy**: Modo `wsdl-policy-attachments`

#### Handlers y Configuraciones
- **Error Handler**: `_onErrorHandler-5076734320840762327-488177e2.17e276fd582.-78ef`
- **Load Balancing**: Round-robin
- **Connection Properties**: 
  - Chunked streaming mode habilitado
  - Follow redirects deshabilitado

### NI01 (Nicaragua)

#### Endpoints y Configuración
- **Proxy Service**: `ConsultaCargosRecurrentesDiariosNI.proxy`
- **Business Service**: `wsVisaTransaction.biz`
- **URL Externa**: `https://192.168.125.16:9443/WSVisaTransaction.asmx`
- **Protocolo**: SOAP 1.2
- **Transport**: HTTP

#### Parámetros Específicos
```
VISANET.STRUSER.NI01
VISANET.STRPASSWORD.NI01
VISANET.STRCARDACQMATRIZID.NI01
VISANET.STRTERMINALMATRIZID.NI01
```

#### Mapeos y Validaciones
- **Request Mapping**: Utiliza `queryCardTransactionIn.xq` para transformar el request OSB al formato VisaNet
- **Response Mapping**: Utiliza `consultaCargosRecurrentesDiariosOut.xq` para transformar la respuesta VisaNet al formato OSB
- **Header Mapping**: Utiliza `consultaCargosRecurrentesDiariosHeaderOut.xq` para mapear códigos de respuesta
- **Validación**: Validación XSD contra el esquema `WSVisaTransaction.wsdl`

#### Políticas OSB
- **Security**: No configurada a nivel de proxy regional
- **Throttling**: Deshabilitado (capacity: 0, maxQueueLength: 0, timeToLive: 0)
- **Result Caching**: Soportado pero habilitado (isSupported: false, isEnabled: true)
- **WS-Policy**: Modo `wsdl-policy-attachments`

#### Handlers y Configuraciones
- **Error Handler**: `_onErrorHandler-5076734320840762327-488177e2.17e276fd582.-7b56`
- **Load Balancing**: Round-robin
- **Connection Properties**: 
  - Chunked streaming mode habilitado
  - Follow redirects deshabilitado
  - Delay interval configuration deshabilitado

## Diferencias Principales entre Regiones

### 1. Protocolo SOAP
- **HN01**: Utiliza SOAP 1.1
- **NI01**: Utiliza SOAP 1.2

### 2. URLs de VisaNet
- **HN01**: `https://192.168.125.188/WSVisaTransaction.asmx`
- **NI01**: `https://192.168.125.16:9443/WSVisaTransaction.asmx` (puerto 9443)

### 3. Configuraciones Específicas
- **HN01**: No tiene configuración de throttling ni result caching
- **NI01**: Tiene configuración explícita de throttling (deshabilitado) y result caching

### 4. Error Handlers
- Cada región tiene su propio error handler con identificadores únicos
- La lógica de manejo de errores es idéntica pero con diferentes IDs

### 5. Parámetros de Configuración
- Ambas regiones utilizan el mismo patrón de parámetros pero con sufijos regionales diferentes
- Los valores específicos se obtienen de la base de datos de configuración OSB

## Similitudes entre Regiones

### 1. Lógica de Negocio
- Ambas regiones utilizan las mismas transformaciones XQuery
- El mapeo de códigos de estado es idéntico
- La validación de entrada es la misma

### 2. Estructura de Request/Response
- Ambas utilizan el mismo esquema XSD
- La estructura de datos es idéntica
- Los campos de entrada y salida son los mismos

### 3. Configuraciones de Red
- Timeout y connection timeout en 0 (sin límite)
- Retry count en 0 (sin reintentos)
- Load balancing algorithm: round-robin

### 4. Monitoreo y Logging
- Monitoring deshabilitado en ambas
- Logging level: debug
- SLA alerting habilitado con nivel normal

## Consideraciones para Migración

### 1. Unificación de Configuraciones
- Evaluar la posibilidad de unificar las configuraciones de throttling y caching
- Considerar estandarizar el protocolo SOAP (1.1 vs 1.2)

### 2. Manejo de Errores
- Los error handlers pueden ser unificados ya que la lógica es idéntica
- Considerar un manejo centralizado de errores

### 3. Parámetros de Configuración
- Mantener la separación de parámetros por región
- Asegurar que todos los parámetros estén correctamente configurados en el ambiente destino

### 4. URLs y Conectividad
- Verificar la conectividad a las URLs de VisaNet desde el ambiente destino
- Considerar configuraciones de firewall y certificados SSL