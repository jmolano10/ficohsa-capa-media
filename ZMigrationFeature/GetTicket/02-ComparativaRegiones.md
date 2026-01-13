# Comparación entre Regiones - GetTicket

## Tabla de Comparación Regional

| Aspecto | HN01 (Honduras) | GT01 (Guatemala) | PA01 (Panamá) | NI01 (Nicaragua) |
|---------|-----------------|------------------|---------------|------------------|
| **Endpoint OSB** | `/Applications/RequestorServices/v1.0/HN/GetTicket/ProxyServices/GetTicket_PS` | No encontrado | No encontrado | No encontrado |
| **Nombre de Base de Datos** | No aplica (servicio REST) | No aplica | No aplica | No aplica |
| **Esquemas** | No aplica (servicio REST) | No aplica | No aplica | No aplica |
| **Store Procedure** | No aplica (servicio REST) | No aplica | No aplica | No aplica |
| **Nombre de Conexión a Base de datos u OSB** | ACHRest_BS | No encontrado | No encontrado | No encontrado |
| **Transformaciones clave** | GetTicketHeaderOut.xqy, GetTicketOUT.xqy | No encontrado | No encontrado | No encontrado |
| **Campos diferenciadores** | userName (ApplicationId) | No aplica | No aplica | No aplica |
| **Errores/Excepciones** | Manejo estándar con GetErrorMessages_BS | No aplica | No aplica | No aplica |
| **Timeouts/Retrys** | 65s timeout, 0 retry | No aplica | No aplica | No aplica |
| **Dependencias internas** | SetLogInfoService_BS, GetErrorMessages_BS, ACHRest_BS | No aplica | No aplica | No aplica |
| **Endpoint REST** | https://saliente-ach-dev2.gfficohsa.hn/api/Ach | No aplica | No aplica | No aplica |
| **Autenticación** | HTTP Basic con ACHRest_SA | No aplica | No aplica | No aplica |
| **Operación REST** | GetAchTicket | No aplica | No aplica | No aplica |
| **Namespace WSDL** | urn:AchSoapRouter_PS | No aplica | No aplica | No aplica |
| **Binding SOAP** | AchSoapRouter_PS_ptt-binding | No aplica | No aplica | No aplica |

## Sección por Región

### HN01 (Honduras) - Implementación Completa

#### Endpoints y Configuración
- **Proxy Service**: `GetTicket_PS.proxy`
- **Pipeline**: `GetTicket_PP.pipeline`
- **WSDL**: `GetTicket_PS.wsdl`
- **URI Endpoint**: `/Applications/RequestorServices/v1.0/HN/GetTicket/ProxyServices/GetTicket_PS`

#### Mapeos y Transformaciones
- **Request Mapping**: El ApplicationId del header se mapea al campo userName del request REST
- **Response Header Mapping**: Utiliza GetTicketHeaderOut.xqy para transformar la respuesta
- **Response Body Mapping**: Utiliza GetTicketOUT.xqy para extraer el ticket

#### Validaciones y Políticas OSB
- **Validación de Esquema**: Habilitada para SOAP body
- **WSS Processing**: Habilitado para procesar headers WSS
- **Monitoring**: Habilitado con agregación cada 60 segundos
- **Message Tracing**: Nivel completo con máximo 8192 bytes

#### Handlers y Configuración
- **Error Handler**: Pipeline de error personalizado con manejo de faults
- **Security**: Configuración sin políticas WS-Policy
- **Transport**: HTTP con compresión deshabilitada
- **Session Stickiness**: Deshabilitado

#### Business Service Interno
- **Nombre**: ACHRest_BS
- **Tipo**: REST Service
- **Endpoint**: https://saliente-ach-dev2.gfficohsa.hn/api/Ach
- **Operación**: GetAchTicket
- **Autenticación**: HTTP Basic Authentication
- **Service Account**: ACHRest_SA
- **Timeout**: 65 segundos
- **Connection Timeout**: 60 segundos

#### Logging y Auditoría
- **Request Logging**: SetLogInfoService_BS con todos los detalles de la transacción
- **Response Logging**: SetLogInfoService_BS con respuesta final
- **Error Logging**: SetLogInfoService_BS con detalles del error
- **Error Messages**: GetErrorMessages_BS para obtener mensajes localizados

### GT01 (Guatemala) - No Implementado

**Estado**: No se encontraron archivos o configuraciones para esta región.

**Búsqueda realizada**: 
- Directorio: `/Applications/RequestorServices/v1.0/GT/GetTicket/` - No encontrado
- Archivos relacionados con GT01 y GetTicket - No encontrado

### PA01 (Panamá) - No Implementado

**Estado**: No se encontraron archivos o configuraciones para esta región.

**Búsqueda realizada**:
- Directorio: `/Applications/RequestorServices/v1.0/PA/GetTicket/` - No encontrado
- Archivos relacionados con PA01 y GetTicket - No encontrado

### NI01 (Nicaragua) - No Implementado

**Estado**: No se encontraron archivos o configuraciones para esta región.

**Búsqueda realizada**:
- Directorio: `/Applications/RequestorServices/v1.0/NI/GetTicket/` - No encontrado
- Archivos relacionados con NI01 y GetTicket - No encontrado

## Diferencias Identificadas

### Diferencias Principales
1. **Cobertura Regional**: Solo HN01 tiene implementación completa
2. **Arquitectura Única**: No hay variaciones regionales para comparar
3. **Endpoint Específico**: El endpoint REST es específico para Honduras (.hn)

### Diferencias Técnicas por Región
- **HN01**: Implementación completa con todos los componentes OSB
- **GT01, PA01, NI01**: Sin implementación

### Diferencias en Configuración
- **HN01**: Configuración completa de timeouts, autenticación y logging
- **Otras regiones**: No aplica

## Análisis de Impacto

### Impacto de Migración
1. **HN01**: Requiere migración completa de todos los componentes
2. **Otras Regiones**: Requieren implementación desde cero si se necesita la funcionalidad

### Consideraciones de Diseño
1. **Reutilización**: Los componentes de HN01 pueden servir como plantilla
2. **Endpoints Regionales**: Cada región necesitará su propio endpoint ACH
3. **Configuración Regional**: Adaptar timeouts y configuraciones por región

## Recomendaciones

### Para HN01
1. Migrar todos los componentes manteniendo la funcionalidad actual
2. Revisar y actualizar endpoints si es necesario
3. Validar configuraciones de timeout y retry

### Para Otras Regiones
1. Evaluar si la funcionalidad GetTicket es requerida
2. Si es necesaria, usar HN01 como plantilla
3. Configurar endpoints ACH específicos por región
4. Adaptar configuraciones de seguridad y timeouts según requisitos regionales