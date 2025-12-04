# Análisis Técnico - ConsultaDisponibleVentaMonedaExtranjera

## 1. Resumen Ejecutivo

**Nombre del Servicio:** ConsultaDisponibleVentaMonedaExtranjera  
**Código de Servicio:** FICBCO0434  
**Tipo de Servicio:** Router Dinámico Regional  
**Patrón de Diseño:** Enrutamiento Dinámico con Consulta de Ruta Regional

### Descripción Funcional
El servicio ConsultaDisponibleVentaMonedaExtranjera proporciona capacidades de consulta del monto disponible para venta de moneda extranjera. Implementa un patrón de router dinámico que consulta la ruta del servicio regional en tiempo de ejecución mediante el servicio consultaRutaRegional. El servicio valida el esquema XSD del request, obtiene la ubicación del servicio regional según el país y versión (V2), y enruta dinámicamente la solicitud al servicio correspondiente. Incluye mapeo de errores tanto en el pipeline de respuesta como en el error handler para estandarización de mensajes.

---

## 2. Arquitectura del Servicio

### Patrón Arquitectónico
El servicio implementa un patrón de **Router Dinámico Regional con Consulta de Ruta en Tiempo de Ejecución**:

1. Recepción de solicitud con autenticación custom token
2. Validación XSD del request
3. Consulta de ruta regional con código FICBCO0434 y versión V2
4. Evaluación de resultado de consulta de ruta
5. Aplicación de configuraciones regionales
6. Enrutamiento dinámico al servicio regional determinado
7. Mapeo de errores en response pipeline
8. Manejo centralizado de errores con mapeo

### Diagrama de Flujo

```mermaid
graph TD
    A[Cliente] -->|SOAP Request| B[ConsultaDisponibleVentaMonedaExtranjera Proxy]
    B -->|Validar Autenticación| C{Custom Token Valid?}
    C -->|No| D[Error: Authentication Failed]
    C -->|Sí| E[Validación XSD]
    E -->|Invalid| F[Error: XSD Validation]
    E -->|Valid| G[consultaRutaRegional]
    G -->|FICBCO0434, V2| H{PV_CODIGO_ERROR = SUCCESS?}
    H -->|No| I[Error: Ruta No Disponible]
    H -->|Sí| J[Aplicar Valores Región]
    J --> K[Router Dinámico]
    K -->|PV_UBICACION| L[Servicio Regional]
    L --> M[Response]
    M --> N{successIndicator = SUCCESS?}
    N -->|No| O[MapeoErrores Response]
    N -->|Sí| P[Response Final]
    O --> P
    P --> A
    D --> Q[Error Handler]
    F --> Q
    Q --> R[MapeoErrores Error]
    R --> S[Return Error]
    I --> S
    S --> A
```

---

## 3. Servicios Dependientes

### Servicios de Enrutamiento

| Servicio | Tipo | Propósito | Operación |
|----------|------|-----------|-----------|
| consultaRutaRegional | Business Service (DB) | Obtener ruta del servicio regional según país y versión | consultaRutaRegional |
| MapeoErrores | Proxy Service | Estandarizar códigos y mensajes de error | mapeoErrores |

### Servicios de Procesamiento

| Servicio | Tipo | Propósito | Operación |
|----------|------|-----------|-----------|
| Servicio Regional Dinámico | Proxy Service | Consultar disponible de venta según región | [Determinado en runtime] |

### Cadena de Dependencias
```
ConsultaDisponibleVentaMonedaExtranjera
├── consultaRutaRegional (DB)
├── MapeoErrores
└── [Servicio Regional Dinámico]
    └── [Servicios Backend Regionales]
```

---

## 4. Transformaciones de Datos

### Transformaciones por Etapa

| Etapa | Descripción | Archivos XQuery Request | Archivos XQuery Response |
|-------|-------------|------------------------|--------------------------|
| Consulta Ruta Regional | Construcción de request para obtener ruta | `Middleware/v2/Resources/Generales/xq/consultaRutaRegionalIn.xq` | N/A |
| Aplicación Regional | Aplicar configuraciones por defecto de región | N/A | `Middleware/v2/Resources/Generales/xq/aplicarValoresPorDefectoRegion.xq` |
| Mapeo Errores Request (Response) | Construcción de request para mapeo en response pipeline | `Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageIn.xq` | N/A |
| Mapeo Errores Response (Response) | Transformación de respuesta de mapeo en response pipeline | N/A | `Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageOut.xq` |
| Mapeo Errores Request (Error) | Construcción de request para mapeo en error handler | `Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageIn.xq` | N/A |
| Mapeo Errores Response (Error) | Transformación de respuesta de mapeo en error handler | N/A | `Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageOut.xq` |

**Nota:** Los archivos XQuery específicos del servicio regional (consultaMontoDisponibleVentaDolarIn.xq, consultaDisponibleVentaMonedaExtranjeraOut.xq) son utilizados por el servicio regional dinámico, no por el router principal.

### Lógica de Transformación

**consultaRutaRegionalIn.xq:**
- Entrada: idServicio (string), requestHeader (aut:RequestHeader), operacion (string), version (string)
- Salida: Request para consultaRutaRegional
- Parámetros: idServicio = "FICBCO0434", version = "V2"

**aplicarValoresPorDefectoRegion.xq:**
- Entrada: RequestHeader original
- Salida: RequestHeader con valores regionales aplicados
- Propósito: Enriquecer header con configuraciones específicas de la región

**mapeoErroresUsageIn.xq (Response Pipeline):**
- Entrada: CODIGO_ERROR (successIndicator), MENSAJE_ERROR (concatenado con "FICBCO0434$#$")
- Salida: Request para MapeoErrores
- Contexto: Invocado cuando successIndicator != "SUCCESS"

**mapeoErroresUsageOut.xq (Response Pipeline):**
- Entrada: mapeoErroresResponse, successIndicator
- Salida: ResponseHeader con error mapeado
- Propósito: Transformar respuesta de MapeoErrores a formato estándar

**mapeoErroresUsageIn.xq (Error Handler):**
- Entrada: CODIGO_ERROR (errorCode del fault), MENSAJE_ERROR (concatenado con "FICBCO0434$#$")
- Salida: Request para MapeoErrores
- Contexto: Invocado en error handler

**mapeoErroresUsageOut.xq (Error Handler):**
- Entrada: mapeoErroresResponse, successIndicator (errorCode)
- Salida: ResponseHeader con error mapeado
- Propósito: Transformar respuesta de MapeoErrores en error handler

---

## 5. Conexiones por País

### Consulta de Ruta (Común para todos los países)

| País | Tipo Conexión | Servicio | Endpoint | Operación |
|------|---------------|----------|----------|-----------|
| Todos | JCA (Database) | consultaRutaRegional | [CONNECTION_CONSULTA_RUTA_REGIONAL] | consultaRutaRegional |

**Nota:** La conexión JCA maneja la autenticación a nivel de conexión configurada en el servidor.

### Enrutamiento Dinámico

| Determinación | Tipo Conexión | Servicio | Endpoint | Operación |
|---------------|---------------|----------|----------|-----------|
| Runtime (PV_UBICACION) | SOAP | [Servicio Regional Dinámico] | [ENDPOINT_DETERMINADO_RUNTIME] | [Operación del servicio regional] |

**Nota:** El servicio destino se determina en tiempo de ejecución mediante el valor PV_UBICACION retornado por consultaRutaRegional. El enrutamiento es completamente dinámico.

---

## 6. Validación XSD

### Esquema Principal
- **Archivo XSD:** consultaDisponibleVentaMonedaExtranjeraTypes.xsd
- **Ruta:** Middleware/v2/Resources/ConsultaDisponibleVentaMonedaExtranjera/xsd/consultaDisponibleVentaMonedaExtranjeraTypes.xsd
- **Namespace:** http://www.ficohsa.com.hn/middleware.services/consultaDisponibleVentaMonedaExtranjeraTypes
- **Prefijo:** tns

### Estructura del Request: consultaDisponibleVentaMonedaExtranjera

| Campo | Tipo | Obligatorio | Cardinalidad | Restricciones | Descripción |
|-------|------|-------------|--------------|---------------|-------------|
| consultaDisponibleVentaMonedaExtranjera | complexType | Sí | 1..1 | - | Elemento raíz del request |
| CURRENCY | stringMinLength1 | Sí | 1..1 | Mínimo 1 carácter | Código de moneda extranjera |

### Estructura del Response: consultaDisponibleVentaMonedaExtranjeraResponse

| Campo | Tipo | Obligatorio | Cardinalidad | Restricciones | Descripción |
|-------|------|-------------|--------------|---------------|-------------|
| consultaDisponibleVentaMonedaExtranjeraResponse | complexType | Sí | 1..1 | - | Elemento raíz del response |
| AMOUNT_AVAILABLE | string | No | 0..1 | - | Monto disponible para venta |

### Tipos Complejos y Simples

**stringMinLength1 (simpleType - Restricción):**
- Base: xs:string
- Longitud mínima: 1 carácter

### Ejemplo de Request Válido

**Nota:** Los siguientes son datos de ejemplo no reales, utilizados únicamente para propósitos de testing y documentación.

```xml
<con:consultaDisponibleVentaMonedaExtranjera xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaDisponibleVentaMonedaExtranjeraTypes">
  <CURRENCY>USD</CURRENCY>
</con:consultaDisponibleVentaMonedaExtranjera>
```

### Ejemplo de Response Válido

**Nota:** Los siguientes son datos de ejemplo no reales, utilizados únicamente para propósitos de testing y documentación.

```xml
<con:consultaDisponibleVentaMonedaExtranjeraResponse xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaDisponibleVentaMonedaExtranjeraTypes">
  <AMOUNT_AVAILABLE>50000.00</AMOUNT_AVAILABLE>
</con:consultaDisponibleVentaMonedaExtranjeraResponse>
```

### Casos de Error de Validación XSD

**Error 1: CURRENCY vacío**
```xml
<CURRENCY></CURRENCY>  <!-- Viola minLength=1 -->
```
Error esperado: `cvc-minLength-valid: Value '' with length = '0' is not facet-valid`

**Error 2: CURRENCY faltante**
```xml
<con:consultaDisponibleVentaMonedaExtranjera>
  <!-- CURRENCY faltante -->
</con:consultaDisponibleVentaMonedaExtranjera>
```
Error esperado: `cvc-complex-type.2.4.b: The content of element 'consultaDisponibleVentaMonedaExtranjera' is not complete`

### Estadísticas de Validación
- **Total de elementos en Request:** 2
- **Elementos obligatorios:** 2 (100%)
- **Elementos opcionales:** 0 (0%)
- **Total de elementos en Response:** 2
- **Elementos obligatorios en Response:** 1 (50%)
- **Elementos opcionales en Response:** 1 (50%)
- **Tipos complejos definidos:** 2
- **Tipos simples definidos:** 1
- **Cobertura de documentación:** 100%

---

## 7. Manejo de Errores

### Error Handler Dedicado
- **Nombre:** _onErrorHandler-5874529093145720941-2d27ae7c.174691f95ce.-4089
- **Tipo:** Pipeline de error con mapeo

### Flujo de Manejo de Errores

```mermaid
graph TD
    A[Error Ocurre] --> B[Etapa: ManejoError]
    B --> C[Extraer errorCode]
    B --> D[Extraer errorMessage]
    C --> E[Invocar MapeoErrores]
    D --> E
    E --> F[Transformar con mapeoErroresUsageIn]
    F --> G[Recibir RSPMapeoErrores]
    G --> H[Transformar con mapeoErroresUsageOut]
    H --> I[Reemplazar Header]
    I --> J[Reemplazar Body Vacío]
    J --> K[Reply]
```

### Extracción de Información de Error
```xpath
errorCode: fn:string($fault/ctx:errorCode/text())
errorMessage: fn:string($fault/ctx:reason/text())
```

### Integración con MapeoErrores
- **Servicio:** Middleware/v2/ProxyServices/MapeoErrores
- **Operación:** mapeoErrores
- **Transformación Request:** mapeoErroresUsageIn.xq
- **Transformación Response:** mapeoErroresUsageOut.xq
- **Parámetros:** CODIGO_ERROR, MENSAJE_ERROR (formato: "FICBCO0434$#$[mensaje]")

### Mapeo de Errores en Response Pipeline
- **Condición:** successIndicator != "SUCCESS"
- **Ubicación:** ValidacionesGenerales_response, etapa MapeoError
- **Proceso:** Similar al error handler pero usando successIndicator del header

---

## 8. Configuración de Seguridad

### Autenticación Custom Token
- **Tipo:** Username/Password en header
- **Namespace:** http://www.ficohsa.com.hn/middleware.services/autType
- **Prefijo:** aut

**Extracción de Username:**
```xpath
./aut:RequestHeader/Authentication/UserName/text()
```

**Extracción de Password:**
```xpath
./aut:RequestHeader/Authentication/Password/text()
```

**Variable de contexto:** header

### Transporte
- **Protocolo:** HTTPS (obligatorio)
- **Provider:** http
- **Dirección:** Inbound

---

## 9. Configuración de Monitoreo y Logging

### Logging
- **Estado:** Habilitado
- **Nivel:** debug
- **Propósito:** Trazabilidad completa de requests y responses

### Reporting
- **Estado:** Habilitado
- **Propósito:** Métricas de uso y rendimiento

### SLA Alerting
- **Estado:** Habilitado
- **Nivel:** normal
- **Propósito:** Alertas de cumplimiento de SLA

### Pipeline Alerting
- **Estado:** Habilitado
- **Nivel:** normal
- **Propósito:** Alertas de errores en pipeline

### Monitoring
- **Estado:** Deshabilitado
- **Intervalo de agregación:** 10 segundos
- **Nivel:** Pipeline

### Configuraciones Adicionales
- **Throttling:** Deshabilitado
- **Message Tracing:** Deshabilitado
- **WSI-compliant:** false

---

## 10. Consideraciones de Implementación

### Variables de Configuración Requeridas
- `[CONNECTION_CONSULTA_RUTA_REGIONAL]`: Conexión JCA a base de datos de rutas regionales
- `[ENDPOINT_DETERMINADO_RUNTIME]`: Endpoint del servicio regional (determinado dinámicamente)

### Dependencias de Despliegue
1. Base de datos de consultaRutaRegional debe estar disponible
2. Servicio MapeoErrores debe estar desplegado
3. Servicios regionales deben estar configurados y accesibles
4. Configuración de rutas en base de datos debe estar actualizada
5. Esquemas XSD deben estar registrados en el servidor OSB

### Puntos de Configuración por Ambiente
- Conexión JCA a base de datos de rutas
- Endpoints de servicios regionales
- Credenciales de autenticación
- Timeouts de servicios
- Niveles de logging

### Consideraciones Especiales
- El servicio implementa router dinámico (`<con3:dynamic-route>`)
- La ruta del servicio regional se determina en tiempo de ejecución
- El servicio usa versión "V2" para consulta de ruta regional
- El mapeo de errores se aplica en dos puntos: response pipeline y error handler
- El servicio NO tiene información de canales en Servicios-Priorizados.csv
- El enrutamiento es completamente dinámico basado en PV_UBICACION

---

**Versión del Documento:** 1.0  
**Fecha de Análisis:** 2025-01-15  
**Analista:** Equipo de Arquitectura OSB
