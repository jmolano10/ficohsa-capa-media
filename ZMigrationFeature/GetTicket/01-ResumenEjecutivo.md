# Resumen Ejecutivo - GetTicket

## Índice de Documentación

1. [Resumen Ejecutivo](01-ResumenEjecutivo.md)
2. [Comparación entre Regiones](02-ComparativaRegiones.md)
3. [Ejemplos y Mapeos - HN01](03-EjemplosYMapeos-HN01.md)
4. [Diagrama de Secuencia - HN01](04-Secuencia-HN01.mmd)
5. [Diagrama de Flujo Multiregión](05-FlujoMultiregión.mmd)
6. [Listado de Ficheros](06-ListadoFicheros.md)

## Propósito de la Funcionalidad

La funcionalidad **GetTicket** es un servicio OSB que permite obtener un ticket de autenticación para realizar operaciones ACH (Automated Clearing House) en el sistema bancario. Este servicio actúa como un proxy que recibe solicitudes SOAP y las transforma para invocar un servicio REST interno de ACH.

## Entradas y Salidas Principales

### Entrada (Request)
- **Protocolo**: SOAP/HTTP
- **Namespace**: `http://www.ficohsa.com.hn/middleware.services/achServicesPS`
- **Elemento**: `GetTicketRequest`
- **Campos**:
  - `originatorId` (opcional): Identificador del originador
  - `messageType` (opcional): Tipo de mensaje

### Salida (Response)
- **Protocolo**: SOAP/HTTP
- **Namespace**: `http://www.ficohsa.com.hn/middleware.services/achServicesPS`
- **Elemento**: `GetTicketResponse`
- **Campos**:
  - `ticket`: Token de autenticación generado

## Sistemas/Servicios OSB Involucrados

### Proxy Service
- **Nombre**: `GetTicket_PS`
- **Ubicación**: `/Applications/RequestorServices/v1.0/HN/GetTicket/ProxyServices/GetTicket_PS`
- **Tipo**: SOAP Proxy Service
- **WSDL**: `Applications/RequestorServices/v1.0/HN/GetTicket/WSDL/GetTicket_PS`

### Pipeline
- **Nombre**: `GetTicket_PP`
- **Ubicación**: `/Applications/RequestorServices/v1.0/HN/GetTicket/Pipelines/GetTicket_PP.pipeline`
- **Función**: Orquestación del flujo de procesamiento

### Business Service
- **Nombre**: `ACHRest_BS`
- **Ubicación**: `/Applications/ProviderServices/BusinessServices/ACHRest_BS`
- **Tipo**: REST Business Service
- **Endpoint**: `https://saliente-ach-dev2.gfficohsa.hn/api/Ach`
- **Operación**: `GetAchTicket`

### Transformaciones XQuery
- **GetTicketHeaderOut.xqy**: Transformación del header de respuesta
- **GetTicketOUT.xqy**: Transformación del body de respuesta

### Servicios de Logging
- **SetLogInfoService_BS**: Servicio para registro de logs de transacciones
- **GetErrorMessages_BS**: Servicio para obtención de mensajes de error

## Riesgos/Limitaciones Conocidas

### Riesgos Identificados
1. **Dependencia de Servicio Externo**: El servicio depende completamente del endpoint REST ACH externo
2. **Autenticación HTTP Basic**: Utiliza autenticación básica HTTP que puede ser vulnerable
3. **Timeout Configurado**: Timeout de 65 segundos que puede ser insuficiente para operaciones complejas
4. **Región Única**: Solo implementado para la región HN01 (Honduras)

### Limitaciones Técnicas
1. **Sin Retry Automático**: No tiene configuración de reintentos automáticos (retry-count: 0)
2. **Sin Balanceador de Carga**: Configurado con round-robin pero un solo endpoint
3. **Logging Asíncrono**: Los logs se envían con quality-of-service "best-effort"
4. **Validación Limitada**: Validaciones mínimas en el request de entrada

## Métricas o SLAs

### Configuración de Monitoreo
- **Monitoring**: Habilitado con intervalo de agregación de 60 segundos
- **Message Tracing**: Habilitado con nivel "full" y tamaño máximo de 8192 bytes
- **Result Caching**: Habilitado para optimizar rendimiento

### Timeouts Configurados
- **Connection Timeout**: 60 segundos
- **Read Timeout**: 65 segundos
- **Retry Interval**: 30 segundos (aunque retry-count es 0)

### Códigos de Servicio
- **Código de Aplicación**: 1
- **Código de Servicio**: 5
- **Código de Sistema**: 1
- **Versión**: 1
- **Operación**: GetTicket

## Arquitectura Regional

La funcionalidad está implementada únicamente para la región **HN01** (Honduras), identificada por:
- Estructura de carpetas: `/v1.0/HN/GetTicket/`
- Endpoint específico: `saliente-ach-dev2.gfficohsa.hn`
- Configuración regional en headers: `SourceBank` y `DestinationBank`

## Estado de Implementación

- **Región HN01**: ✅ Completamente implementada
- **Otras Regiones**: ❌ No implementadas (GT01, PA01, NI01)

## Recomendaciones

1. **Implementar en Otras Regiones**: Extender la funcionalidad a GT01, PA01, NI01
2. **Mejorar Seguridad**: Considerar autenticación más robusta que HTTP Basic
3. **Configurar Reintentos**: Habilitar retry automático para mayor resiliencia
4. **Monitoreo Avanzado**: Implementar alertas proactivas basadas en métricas
5. **Documentar SLAs**: Establecer acuerdos de nivel de servicio formales