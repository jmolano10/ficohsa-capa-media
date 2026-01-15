# Resumen Ejecutivo - FraudAnalysis

## Índice de Documentación

1. [Resumen Ejecutivo](01-ResumenEjecutivo.md) (este documento)
2. [Comparación entre Regiones](02-ComparativaRegiones.md)
3. Ejemplos de Request/Response y Mapeo de Datos por Región:
   - [Región HN01 (Honduras)](03-EjemplosYMapeos-HN01.md)
   - [Región GT01 (Guatemala)](03-EjemplosYMapeos-GT01.md)
   - [Región PA01 (Panamá)](03-EjemplosYMapeos-PA01.md)
   - [Región NI01 (Nicaragua)](03-EjemplosYMapeos-NI01.md)
4. Diagramas de Secuencia por Región:
   - [Secuencia HN01](04-Secuencia-HN01.mmd)
   - [Secuencia GT01](04-Secuencia-GT01.mmd)
   - [Secuencia PA01](04-Secuencia-PA01.mmd)
   - [Secuencia NI01](04-Secuencia-NI01.mmd)
5. [Diagrama de Flujo Multiregión](05-FlujoMultiregion.mmd)
6. [Listado de Ficheros](06-ListadoFicheros.md)

---

## 1. Propósito de la Funcionalidad

La funcionalidad **FraudAnalysis** es un servicio de middleware OSB que permite realizar análisis de fraude en tiempo real para operaciones bancarias. El servicio actúa como intermediario entre los sistemas bancarios de Ficohsa y el sistema externo de análisis de fraude VU Security.

### Objetivo Principal
Evaluar el riesgo de fraude de transacciones bancarias en tiempo real, proporcionando una recomendación de acción (permitir, denegar, autenticar, bloquear, revisar operación o revisar por agente) basada en reglas de negocio, patrones de comportamiento y scoring de riesgo.

### Alcance Regional
El servicio opera en un entorno multiregional, soportando las siguientes regiones:
- **HN01**: Honduras (región por defecto)
- **GT01**: Guatemala
- **PA01**: Panamá
- **NI01**: Nicaragua

---

## 2. Entradas y Salidas Principales

### 2.1. Entrada Principal (Request OSB)

**Protocolo**: SOAP 1.1  
**Endpoint**: `/Middleware/OperationsAndExecution/PartyAuthentication/FraudAnalysis`  
**Operación**: `fraudAnalysis`

#### Estructura del Request

**Header (RequestHeader)**:
- `Authentication/UserName`: Usuario que realiza la operación
- `Authentication/Password`: Contraseña del usuario
- `Region/SourceBank`: Banco origen (HN01, GT01, PA01, NI01)
- `Region/DestinationBank`: Banco destino (opcional, por defecto igual al origen)

**Body (FraudAnalysisRequest)**:
- `user`: Identificador del usuario
- `channel`: Canal de operación (INTERBANCA_WEB, IVR, ATM, INTERBANCA_APP)
- `idOperationType`: Identificador del tipo de operación
- `OperationDesc`: Descripción de la operación
- `dateTime`: Fecha y hora de la transacción
- `debitAccount`: Cuenta de débito
- `creditAccount`: Cuenta de crédito (opcional)
- `amount`: Monto de la transacción
- `optionalParams`: Parámetros opcionales (lista de key-value)

### 2.2. Salida Principal (Response OSB)

**Header (ResponseHeader)**:
- `transactionId`: Identificador de transacción
- `messageId`: Código de mensaje (0 para éxito)
- `successIndicator`: Indicador de éxito (Success/ERROR)
- `messages`: Mensajes de error o información

**Body (FraudAnalysisResponse)**:
- `FraudAnalysisRecordType/ACTION`: Acción recomendada
  - `ALLOW`: Permitir la transacción
  - `DENY`: Denegar la transacción
  - `AUTHENTICATE`: Requiere autenticación adicional
  - `BLOCK`: Bloquear usuario/cuenta
  - `CHECK_OPERATION`: Revisar operación
  - `CHECK_BY_AGENT`: Revisar por agente
- `FraudAnalysisRecordType/SCORERISK`: Puntuación de riesgo (0-100)
- `FraudAnalysisRecordType/TRIGGEREDRULENAME`: Nombres de reglas activadas
- `FraudAnalysisRecordType/EVENTID`: Identificador del evento en VU Security

---

## 3. Sistemas/Servicios OSB Involucrados

### 3.1. Proxy Service Principal
- **FraudAnalysis_PS**: Proxy service SOAP que expone el servicio al exterior
- **FraudAnalysis_PP**: Pipeline que contiene la lógica de orquestación

### 3.2. Business Services Dependientes

#### 3.2.1. ValidaServicioRegional_db
- **Tipo**: DB Adapter (Stored Procedure)
- **Propósito**: Validar que el servicio esté habilitado para la región especificada
- **Conexión**: `eis/DB/ConnectionMiddleware`
- **Stored Procedure**: `MW_P_VALIDA_SERVICIO_REGIONAL`
- **Parámetros**:
  - `PV_SERVICIO`: "FICBCO0498"
  - `PV_ORIGEN`: Banco origen del header
  - `PV_DESTINO`: Banco destino del header
- **Respuesta**:
  - `PV_CODIGO_ERROR`: "SUCCESS" si es válido
  - `PV_MENSAJE_ERROR`: Mensaje de error si no es válido

#### 3.2.2. GetAPIAuth_BS
- **Tipo**: DB Adapter (Stored Procedure)
- **Propósito**: Obtener el API Key para autenticación con VU Security
- **Conexión**: `eis/DB/ConnectionMiddleware`
- **Schema**: `MIDDLEWARE2`
- **Stored Procedure**: `MW_P_OBTENER_APIREST_AUT`
- **Parámetros**:
  - `PV_NOMBRE_APP`: "REGFRAUD"
- **Respuesta**:
  - `PV_CLAVE`: API Key para VU Security

#### 3.2.3. FraudAnalysis_BS
- **Tipo**: REST Business Service
- **Propósito**: Invocar el servicio externo de análisis de fraude VU Security
- **Endpoint**: `https://10.242.25.20:8080/FraudAnalysis/service`
- **Operación**: `analyze`
- **Protocolo**: REST/HTTP
- **Timeout**: 0 (sin timeout configurado)
- **Connection Timeout**: 0 (sin timeout de conexión)
- **Retry Count**: 0 (sin reintentos)

#### 3.2.4. RegistrarBitacoraOSB_v2
- **Tipo**: Business Service
- **Propósito**: Registrar bitácora de request y response
- **Operación**: `registrarBitacoraOSB`
- **Invocaciones**:
  - Request: Al inicio del flujo (IdServicio: FICBCO0498)
  - Response: Al final del flujo exitoso (IdServicio: FICBCO0500)
  - Response Error: Al final del flujo con error (IdServicio: FICBCO0491)

#### 3.2.5. MapeoErrores
- **Tipo**: Proxy Service
- **Propósito**: Mapear códigos de error técnicos a mensajes de negocio
- **Operación**: `mapeoErrores`
- **Invocación**: Cuando ocurre un error o cuando VU Security retorna status != 1

### 3.3. Recursos de Transformación (XQuery)

#### 3.3.1. FraudAnalysis_To_VU.xqy
- **Propósito**: Transformar el request OSB al formato esperado por VU Security
- **Transformaciones clave**:
  - Mapeo de canales a IDs numéricos:
    - INTERBANCA_WEB → 1
    - IVR → 2
    - ATM → 3
    - INTERBANCA_APP → 4
  - Reestructuración de optionalParams (entry/key-value → name-value)
  - Inclusión del API Key

#### 3.3.2. Vu_To_FraudAnalysis_Response.xqy
- **Propósito**: Transformar la respuesta de VU Security al formato OSB
- **Transformaciones clave**:
  - Mapeo de códigos de resultado a acciones:
    - 1 → ALLOW
    - 2 → AUTHENTICATE
    - 3 → DENY
    - 4 → CHECK_OPERATION
    - 5 → BLOCK
    - 6 → CHECK_BY_AGENT

#### 3.3.3. validaServicioRegionalIn.xqy
- **Propósito**: Construir el request para validación regional

#### 3.3.4. aplicarValoresPorDefectoRegion.xqy
- **Propósito**: Aplicar valores por defecto a las regiones
- **Lógica**: Si SourceBank está vacío, usa "HN01" por defecto

#### 3.3.5. registrarBitacoraOSBIn.xqy
- **Propósito**: Construir requests para registro de bitácora

#### 3.3.6. mapeoErroresUsageIn.xqy
- **Propósito**: Construir request para mapeo de errores

---

## 4. Riesgos y Limitaciones Conocidas

### 4.1. Riesgos Identificados

#### 4.1.1. Disponibilidad del Servicio Externo
- **Riesgo**: El servicio VU Security es un punto único de falla
- **Impacto**: Si VU Security no está disponible, todas las transacciones fallarán
- **Mitigación actual**: Ninguna (no hay retry configurado, timeout en 0)
- **Recomendación**: Implementar circuit breaker y fallback strategy

#### 4.1.2. Timeouts No Configurados
- **Riesgo**: Timeout configurado en 0 (sin límite)
- **Impacto**: Posibles bloqueos indefinidos si VU Security no responde
- **Recomendación**: Configurar timeouts apropiados (ej: 30 segundos)

#### 4.1.3. Sin Reintentos
- **Riesgo**: Retry count en 0
- **Impacto**: Fallos transitorios de red causan errores inmediatos
- **Recomendación**: Configurar al menos 2-3 reintentos con backoff

#### 4.1.4. Seguridad del API Key
- **Riesgo**: API Key almacenado en base de datos
- **Impacto**: Posible exposición de credenciales
- **Recomendación**: Usar vault o servicio de gestión de secretos

#### 4.1.5. Endpoint Hardcodeado
- **Riesgo**: URL de VU Security hardcodeada en el Business Service
- **Impacto**: Cambios de ambiente requieren redespliegue
- **Recomendación**: Externalizar a archivo de configuración por ambiente

### 4.2. Limitaciones Técnicas

#### 4.2.1. Sin Caché de Resultados
- **Limitación**: No hay caché de análisis de fraude
- **Impacto**: Cada transacción requiere llamada a VU Security
- **Nota**: Result caching está habilitado en el BS pero puede no ser efectivo para este caso de uso

#### 4.2.2. Validación Regional Síncrona
- **Limitación**: Validación regional se hace en cada request
- **Impacto**: Latencia adicional en cada transacción
- **Alternativa**: Caché de configuración regional

#### 4.2.3. Bitácora Síncrona
- **Limitación**: Registro de bitácora es síncrono
- **Impacto**: Aumenta latencia de respuesta
- **Alternativa**: Bitácora asíncrona con JMS

#### 4.2.4. Sin Versionado de API
- **Limitación**: No hay versionado explícito en el contrato
- **Impacto**: Cambios en VU Security pueden romper integración
- **Recomendación**: Implementar versionado en el path o headers

### 4.3. Limitaciones de Negocio

#### 4.3.1. Canales Soportados
- **Limitación**: Solo 4 canales soportados (INTERBANCA_WEB, IVR, ATM, INTERBANCA_APP)
- **Impacto**: Nuevos canales requieren cambios en XQuery

#### 4.3.2. Acciones de Fraude
- **Limitación**: 6 acciones predefinidas
- **Impacto**: Nuevas acciones requieren cambios en transformación

#### 4.3.3. Sin Soporte para Transacciones Batch
- **Limitación**: Análisis uno por uno
- **Impacto**: No optimizado para análisis masivo

---

## 5. Métricas y SLAs

### 5.1. Identificadores de Servicio

- **IdServicio Request**: FICBCO0498
- **IdServicio Response**: FICBCO0500
- **IdServicio Error**: FICBCO0491

### 5.2. Métricas Registradas en Bitácora

Para cada transacción se registra:
- Usuario
- Banco Origen
- Banco Destino
- UUID de Request
- ID de Servicio
- ID de OSB (Host)
- ID de Operación
- Tipo de Mensaje (REQ/RSP)
- Resultado
- UUID único
- Fecha de Transacción
- Contenido completo (request/response)
- ID de Transacción
- Mensaje de Error (si aplica)

### 5.3. SLAs

**No se encontraron SLAs explícitos en el código fuente.**

Recomendaciones de SLAs:
- **Disponibilidad**: 99.9% (8.76 horas de downtime al año)
- **Tiempo de Respuesta**: P95 < 2 segundos, P99 < 5 segundos
- **Tasa de Error**: < 0.1%
- **Throughput**: Mínimo 100 TPS (transacciones por segundo)

### 5.4. Políticas de Seguridad

#### 5.4.1. Autenticación
- **Método**: Custom Token Authentication (Username/Password)
- **Ubicación**: SOAP Header (RequestHeader/Authentication)
- **Validación**: Procesada por OSB (processWssHeader="true")

#### 5.4.2. Autorización
- **Validación Regional**: Cada request valida que el servicio esté habilitado para la región

#### 5.4.3. Transporte
- **Protocolo**: HTTP (no HTTPS en el endpoint interno)
- **Nota**: El endpoint de VU Security usa HTTPS (https://10.242.25.20:8080)

---

## 6. Flujo de Alto Nivel

```
1. Cliente → FraudAnalysis_PS (SOAP Request)
2. FraudAnalysis_PP → Validación XSD
3. FraudAnalysis_PP → Asignar variables comunes
4. FraudAnalysis_PP → RegistrarBitacoraOSB (Request)
5. FraudAnalysis_PP → ValidaServicioRegional_db
   - Si error → Retornar error y terminar
   - Si éxito → Aplicar valores por defecto de región
6. FraudAnalysis_PP → GetAPIAuth_BS (obtener API Key)
7. FraudAnalysis_PP → Transformar request (FraudAnalysis_To_VU)
8. FraudAnalysis_PP → FraudAnalysis_BS (VU Security)
9. FraudAnalysis_PP → Evaluar respuesta:
   - Si status=1 → Transformar respuesta exitosa
   - Si status!=1 → MapeoErrores + Transformar respuesta con error
10. FraudAnalysis_PP → RegistrarBitacoraOSB (Response)
11. FraudAnalysis_PS → Cliente (SOAP Response)

En caso de error (pipeline error):
- ManejoError → MapeoErrores
- BitacoraResponseError → RegistrarBitacoraOSB
- Retornar SOAP Fault
```

---

## 7. Dependencias Externas

### 7.1. Base de Datos
- **Conexión**: `eis/DB/ConnectionMiddleware`
- **Schema**: `MIDDLEWARE2`
- **Stored Procedures**:
  - `MW_P_VALIDA_SERVICIO_REGIONAL`
  - `MW_P_OBTENER_APIREST_AUT`
  - Stored procedures de bitácora (referenciados por RegistrarBitacoraOSB_v2)
  - Stored procedures de mapeo de errores (referenciados por MapeoErrores)

### 7.2. Servicio Externo VU Security
- **URL**: https://10.242.25.20:8080/FraudAnalysis/service
- **Protocolo**: REST/HTTPS
- **Operación**: analyze
- **Autenticación**: API Key en el body del request

---

## 8. Consideraciones para Migración

### 8.1. Puntos de Atención
1. **Configuración de Conexión a BD**: Verificar que `eis/DB/ConnectionMiddleware` esté configurado en el nuevo ambiente
2. **Endpoint de VU Security**: Validar que la IP 10.242.25.20:8080 sea accesible desde el nuevo ambiente
3. **API Keys**: Migrar las credenciales de la tabla de autenticación
4. **Configuración Regional**: Verificar que los stored procedures de validación regional estén actualizados
5. **Bitácora**: Asegurar que las tablas de bitácora existan en el nuevo ambiente
6. **Mapeo de Errores**: Verificar que las tablas de mapeo de errores estén pobladas

### 8.2. Oportunidades de Mejora
1. Implementar timeouts y reintentos
2. Externalizar configuración de endpoints
3. Implementar circuit breaker para VU Security
4. Hacer bitácora asíncrona
5. Implementar caché de validación regional
6. Agregar métricas de monitoreo (Prometheus/Grafana)
7. Implementar health checks
8. Agregar logging estructurado
9. Implementar rate limiting
10. Considerar migración a arquitectura de microservicios

---

**Fecha de Análisis**: 2024  
**Versión del Documento**: 1.0  
**Analista**: Amazon Q Developer
