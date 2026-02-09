# Comparativa entre Regiones - ConsultaEstadoLoteSoapPS

## Regiones Detectadas

A partir del análisis del código fuente, se han identificado las siguientes regiones:

1. **HN01** - Honduras
2. **GT01** - Guatemala  
3. **NI01** - Nicaragua
4. **PA01** - Panamá

Las regiones se detectan mediante el campo `SourceBank` en el header `RequestHeader/Region/SourceBank` del request SOAP.

---

## Tabla de Comparación entre Regiones

| Aspecto | HN (Honduras) | GT (Guatemala) | NI (Nicaragua) | PA (Panamá) |
|---------|---------------|----------------|----------------|-------------|
| **Endpoint OSB Virtual 11g** | `/regional/massivePayment/soap/getBatchStatus/v11g` | `/regional/massivePayment/soap/getBatchStatus/v11g` | `/regional/massivePayment/soap/getBatchStatus/v11g` | `/regional/massivePayment/soap/getBatchStatus/v11g` |
| **Endpoint OSB Regional v2** | `/regional/massivePayment/soap/getBatchStatus/v2` | `/regional/massivePayment/soap/getBatchStatus/v2` | `/regional/massivePayment/soap/getBatchStatus/v2` | `/regional/massivePayment/soap/getBatchStatus/v2` |
| **Endpoint Country v2** | `https://mwservices.gfficohsa.hn:8020/country/massivePayment/rest/getBatchStatus/v2` (dinámico) | `https://mwservices.gfficohsa.hn:8020/country/massivePayment/rest/getBatchStatus/v2` (dinámico) | `https://mwservices.gfficohsa.hn:8020/country/massivePayment/rest/getBatchStatus/v2` (dinámico) | `https://mwservices.gfficohsa.hn:8020/country/massivePayment/rest/getBatchStatus/v2` (dinámico) |
| **Nombre de Base de Datos** | No encontrado en código fuente | No encontrado en código fuente | No encontrado en código fuente | No encontrado en código fuente |
| **Esquemas** | No aplica (servicio REST/SOAP, no DB directa) | No aplica (servicio REST/SOAP, no DB directa) | No aplica (servicio REST/SOAP, no DB directa) | No aplica (servicio REST/SOAP, no DB directa) |
| **Store Procedure** | No aplica (servicio REST/SOAP, no DB directa) | No aplica (servicio REST/SOAP, no DB directa) | No aplica (servicio REST/SOAP, no DB directa) | No aplica (servicio REST/SOAP, no DB directa) |
| **Nombre de Conexión** | `GetBatchStatusCountryGenericRestBS` (REST) | `GetBatchStatusCountryGenericRestBS` (REST) | `GetBatchStatusCountryGenericRestBS` (REST) | `GetBatchStatusCountryGenericRestBS` (REST) |
| **Transformaciones Clave (Input)** | `Virtual11gToGetBatchStatus.xqy` | `Virtual11gToGetBatchStatus.xqy` | `Virtual11gToGetBatchStatus.xqy` | `Virtual11gToGetBatchStatus.xqy` |
| **Transformaciones Clave (Output Header)** | `GetBatchStatusToVirtual11gHeaderHN.xqy` | Sin diferencias detectadas (usa misma transformación HN) | Sin diferencias detectadas (usa misma transformación HN) | Sin diferencias detectadas (usa misma transformación HN) |
| **Transformaciones Clave (Output Body)** | `GetBatchStatusToVirtual11gBodyHN.xqy` | Sin diferencias detectadas (usa misma transformación HN) | Sin diferencias detectadas (usa misma transformación HN) | Sin diferencias detectadas (usa misma transformación HN) |
| **Campos Diferenciadores** | `SourceBank=HN01` | `SourceBank=GT01` | `SourceBank=NI01` | `SourceBank=PA01` |
| **Errores/Excepciones** | "INVALID REGION REQUEST" si región no válida | "INVALID REGION REQUEST" si región no válida | "INVALID REGION REQUEST" si región no válida | "INVALID REGION REQUEST" si región no válida |
| **Timeouts Request** | 40s (Virtual→Regional), 70s (Regional→Country) | 40s (Virtual→Regional), 70s (Regional→Country) | 40s (Virtual→Regional), 70s (Regional→Country) | 40s (Virtual→Regional), 70s (Regional→Country) |
| **Timeouts Connection** | 35s (Virtual→Regional), 65s (Regional→Country) | 35s (Virtual→Regional), 65s (Regional→Country) | 35s (Virtual→Regional), 65s (Regional→Country) | 35s (Virtual→Regional), 65s (Regional→Country) |
| **Retry Count** | 0 (sin reintentos) | 0 (sin reintentos) | 0 (sin reintentos) | 0 (sin reintentos) |
| **Dependencias Internas** | `GetCountryURLByNameRegionalRestBS`, `LoggingRegionalRestBS`, `GetCustomErrorByStackTraceRegionalRestBS` | `GetCountryURLByNameRegionalRestBS`, `LoggingRegionalRestBS`, `GetCustomErrorByStackTraceRegionalRestBS` | `GetCountryURLByNameRegionalRestBS`, `LoggingRegionalRestBS`, `GetCustomErrorByStackTraceRegionalRestBS` | `GetCountryURLByNameRegionalRestBS`, `LoggingRegionalRestBS`, `GetCustomErrorByStackTraceRegionalRestBS` |
| **Protocolo Virtual 11g** | SOAP 1.1 con WSS | SOAP 1.1 con WSS | SOAP 1.1 con WSS | SOAP 1.1 con WSS |
| **Protocolo Regional v2** | SOAP 1.1 con Basic Auth over SSL | SOAP 1.1 con Basic Auth over SSL | SOAP 1.1 con Basic Auth over SSL | SOAP 1.1 con Basic Auth over SSL |
| **Protocolo Country v2** | REST con Basic Auth over SSL | REST con Basic Auth over SSL | REST con Basic Auth over SSL | REST con Basic Auth over SSL |
| **Dispatch Policy** | `SBMassivePaymentManager` | `SBMassivePaymentManager` | `SBMassivePaymentManager` | `SBMassivePaymentManager` |
| **Result Caching** | Habilitado | Habilitado | Habilitado | Habilitado |
| **Validación de Esquema** | Solo en Regional v2 | Solo en Regional v2 | Solo en Regional v2 | Solo en Regional v2 |
| **Logging** | Request/Response/Error en filesystem | Request/Response/Error en filesystem | Request/Response/Error en filesystem | Request/Response/Error en filesystem |

---

## Detalles por Región

### 1. Honduras (HN01)

**Características Específicas:**
- Es la región por defecto si no se especifica `SourceBank` en el header
- Tiene transformaciones específicas para header y body de salida
- Código de región: `HN01` o cualquier valor que contenga `HN`

**Enrutamiento:**
```xquery
if (fn:contains($sourceBank, "HN")) then
    // Aplicar transformaciones específicas de HN
    GetBatchStatusToVirtual11gHeaderHN.xqy
    GetBatchStatusToVirtual11gBodyHN.xqy
```

**Transformaciones Específicas:**
- Header: Mapea `StatusInfo/Status` a `successIndicator`, `ErrorInfo` a `messageId` y `messages`
- Body: Mapea estructura completa de `getBatchStatusResponse` a `consultaEstadoLoteResponse`
- Conversión de booleano `Optimistic` (true/false) a string (YES/NO)

**Validaciones Específicas:**
- Ninguna validación adicional específica de región detectada
- Usa validaciones comunes del template

**Manejo de Errores:**
- Error estándar: "INVALID REGION REQUEST" si no es región válida
- Transformación de errores vía `GetCustomErrorByStackTraceRegionalRestBS`

---

### 2. Guatemala (GT01)

**Características Específicas:**
- Código de región: `GT01` o cualquier valor que contenga `GT`
- Comparte las mismas transformaciones que Honduras
- No se detectaron diferencias en la lógica de negocio

**Enrutamiento:**
```xquery
if (fn:contains($sourceBank, "GT")) then
    // Aplicar transformaciones (mismas que HN)
```

**Transformaciones Específicas:**
- Usa las mismas transformaciones que HN
- No se encontraron archivos específicos para GT en el código fuente analizado

**Validaciones Específicas:**
- Ninguna validación adicional específica de región detectada
- Usa validaciones comunes del template

**Manejo de Errores:**
- Idéntico a Honduras
- Error estándar: "INVALID REGION REQUEST" si no es región válida

**Diferencias con HN:**
- **Sin diferencias detectadas** en el código fuente analizado
- La única diferencia es el valor del campo `SourceBank` en el request
- El enrutamiento a nivel de Country puede tener diferencias (no visible en este código)

---

### 3. Nicaragua (NI01)

**Características Específicas:**
- Código de región: `NI01` o cualquier valor que contenga `NI`
- Comparte las mismas transformaciones que Honduras
- No se detectaron diferencias en la lógica de negocio

**Enrutamiento:**
```xquery
if (fn:contains($sourceBank, "NI")) then
    // Aplicar transformaciones (mismas que HN)
```

**Transformaciones Específicas:**
- Usa las mismas transformaciones que HN
- No se encontraron archivos específicos para NI en el código fuente analizado

**Validaciones Específicas:**
- Ninguna validación adicional específica de región detectada
- Usa validaciones comunes del template

**Manejo de Errores:**
- Idéntico a Honduras
- Error estándar: "INVALID REGION REQUEST" si no es región válida

**Diferencias con HN:**
- **Sin diferencias detectadas** en el código fuente analizado
- La única diferencia es el valor del campo `SourceBank` en el request
- El enrutamiento a nivel de Country puede tener diferencias (no visible en este código)

---

### 4. Panamá (PA01)

**Características Específicas:**
- Código de región: `PA01` o cualquier valor que contenga `PA`
- Comparte las mismas transformaciones que Honduras
- No se detectaron diferencias en la lógica de negocio

**Enrutamiento:**
```xquery
if (fn:contains($sourceBank, "PA")) then
    // Aplicar transformaciones (mismas que HN)
```

**Transformaciones Específicas:**
- Usa las mismas transformaciones que HN
- No se encontraron archivos específicos para PA en el código fuente analizado

**Validaciones Específicas:**
- Ninguna validación adicional específica de región detectada
- Usa validaciones comunes del template

**Manejo de Errores:**
- Idéntico a Honduras
- Error estándar: "INVALID REGION REQUEST" si no es región válida

**Diferencias con HN:**
- **Sin diferencias detectadas** en el código fuente analizado
- La única diferencia es el valor del campo `SourceBank` en el request
- El enrutamiento a nivel de Country puede tener diferencias (no visible en este código)

---

## Conclusiones de la Comparativa

### Similitudes entre Regiones

1. **Arquitectura Común:**
   - Todas las regiones usan la misma arquitectura de 3 capas (Virtual 11g → Regional v2 → Country v2)
   - Mismo flujo de procesamiento y templates

2. **Transformaciones Compartidas:**
   - Todas las regiones usan las mismas transformaciones XQuery
   - No se detectaron transformaciones específicas por región (excepto HN que es la base)

3. **Configuración Técnica:**
   - Timeouts idénticos
   - Políticas de seguridad idénticas
   - Dispatch policies idénticos
   - Sin reintentos en ninguna región

4. **Manejo de Errores:**
   - Mismo flujo de manejo de errores
   - Mismos servicios de mapeo de errores
   - Mismos mensajes de error estándar

### Diferencias entre Regiones

1. **Única Diferencia Detectada:**
   - El valor del campo `SourceBank` en el header del request
   - Este valor determina el enrutamiento a nivel de servicio Country

2. **Diferencias No Visibles en Este Código:**
   - Las diferencias reales entre regiones están en la capa Country (v2)
   - Cada país puede tener:
     - Diferentes bases de datos
     - Diferentes stored procedures
     - Diferentes reglas de negocio
     - Diferentes validaciones
   - Estas diferencias NO son visibles en el código analizado (Virtual 11g y Regional v2)

### Recomendaciones

1. **Para Migración:**
   - La lógica de Virtual 11g y Regional v2 es común para todas las regiones
   - Las diferencias reales están en la capa Country
   - Se debe analizar el código de cada servicio Country por separado

2. **Para Mantenimiento:**
   - Cualquier cambio en Virtual 11g o Regional v2 afecta a todas las regiones
   - Los cambios específicos por región deben hacerse en la capa Country

3. **Para Testing:**
   - Los casos de prueba de Virtual 11g y Regional v2 pueden ser comunes
   - Los casos de prueba específicos por región deben enfocarse en la capa Country

4. **Para Documentación:**
   - La documentación de Virtual 11g y Regional v2 puede ser común
   - Se debe documentar por separado cada implementación de Country

---

## Notas Técnicas

**Método de Detección de Regiones:**
```xquery
let $sourceBank := data($header//Region/SourceBank)
return
    if (fn:contains($sourceBank, "HN")) then "Honduras"
    else if (fn:contains($sourceBank, "GT")) then "Guatemala"
    else if (fn:contains($sourceBank, "NI")) then "Nicaragua"
    else if (fn:contains($sourceBank, "PA")) then "Panamá"
    else "INVALID REGION"
```

**Valor por Defecto:**
```xquery
if (($header//Region/SourceBank/text()) != "") then
    $header//Region/SourceBank/text()
else 
    "HN01"  // Honduras es el default
```

**Servicio de Regionalización:**
- Servicio: `GetCountryURLByNameRegionalRestBS`
- Operación: `GetCountryURLByName`
- Propósito: Obtener la URL dinámica del servicio Country según el banco destino
- Si retorna "N/A", se genera error: "SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY"
