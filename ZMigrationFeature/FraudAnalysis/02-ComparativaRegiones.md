# Comparación entre Regiones - FraudAnalysis

## Introducción

La funcionalidad **FraudAnalysis** opera en un entorno multiregional que soporta cuatro regiones principales: Honduras (HN01), Guatemala (GT01), Panamá (PA01) y Nicaragua (NI01). Este documento detalla las diferencias y similitudes entre las implementaciones regionales.

---

## Tabla Comparativa de Regiones

| Aspecto | HN01 (Honduras) | GT01 (Guatemala) | PA01 (Panamá) | NI01 (Nicaragua) |
|---------|-----------------|------------------|---------------|------------------|
| **Endpoint OSB** | `/Middleware/OperationsAndExecution/PartyAuthentication/FraudAnalysis` | `/Middleware/OperationsAndExecution/PartyAuthentication/FraudAnalysis` | `/Middleware/OperationsAndExecution/PartyAuthentication/FraudAnalysis` | `/Middleware/OperationsAndExecution/PartyAuthentication/FraudAnalysis` |
| **Nombre de Base de Datos** | ConnectionMiddleware | ConnectionMiddleware | ConnectionMiddleware | ConnectionMiddleware |
| **Esquemas** | MIDDLEWARE2 | MIDDLEWARE2 | MIDDLEWARE2 | MIDDLEWARE2 |
| **Store Procedure - Validación Regional** | MW_P_VALIDA_SERVICIO_REGIONAL | MW_P_VALIDA_SERVICIO_REGIONAL | MW_P_VALIDA_SERVICIO_REGIONAL | MW_P_VALIDA_SERVICIO_REGIONAL |
| **Store Procedure - API Auth** | MW_P_OBTENER_APIREST_AUT | MW_P_OBTENER_APIREST_AUT | MW_P_OBTENER_APIREST_AUT | MW_P_OBTENER_APIREST_AUT |
| **Nombre de Conexión a Base de datos** | eis/DB/ConnectionMiddleware | eis/DB/ConnectionMiddleware | eis/DB/ConnectionMiddleware | eis/DB/ConnectionMiddleware |
| **Endpoint VU Security** | https://10.242.25.20:8080/FraudAnalysis/service | https://10.242.25.20:8080/FraudAnalysis/service | https://10.242.25.20:8080/FraudAnalysis/service | https://10.242.25.20:8080/FraudAnalysis/service |
| **Transformaciones clave** | FraudAnalysis_To_VU.xqy<br/>Vu_To_FraudAnalysis_Response.xqy | FraudAnalysis_To_VU.xqy<br/>Vu_To_FraudAnalysis_Response.xqy | FraudAnalysis_To_VU.xqy<br/>Vu_To_FraudAnalysis_Response.xqy | FraudAnalysis_To_VU.xqy<br/>Vu_To_FraudAnalysis_Response.xqy |
| **Campos diferenciadores** | SourceBank: "HN01"<br/>DestinationBank: "HN01" (default) | SourceBank: "GT01"<br/>DestinationBank: "GT01" | SourceBank: "PA01"<br/>DestinationBank: "PA01" | SourceBank: "NI01"<br/>DestinationBank: "NI01" |
| **Errores/Excepciones** | Manejo estándar via MapeoErrores | Manejo estándar via MapeoErrores | Manejo estándar via MapeoErrores | Manejo estándar via MapeoErrores |
| **Timeouts** | Connection: 0<br/>Read: 0 | Connection: 0<br/>Read: 0 | Connection: 0<br/>Read: 0 | Connection: 0<br/>Read: 0 |
| **Retrys** | 0 (sin reintentos) | 0 (sin reintentos) | 0 (sin reintentos) | 0 (sin reintentos) |
| **Dependencias internas** | - ValidaServicioRegional_db<br/>- GetAPIAuth_BS<br/>- FraudAnalysis_BS<br/>- RegistrarBitacoraOSB_v2<br/>- MapeoErrores | - ValidaServicioRegional_db<br/>- GetAPIAuth_BS<br/>- FraudAnalysis_BS<br/>- RegistrarBitacoraOSB_v2<br/>- MapeoErrores | - ValidaServicioRegional_db<br/>- GetAPIAuth_BS<br/>- FraudAnalysis_BS<br/>- RegistrarBitacoraOSB_v2<br/>- MapeoErrores | - ValidaServicioRegional_db<br/>- GetAPIAuth_BS<br/>- FraudAnalysis_BS<br/>- RegistrarBitacoraOSB_v2<br/>- MapeoErrores |
| **IdServicio Request** | FICBCO0498 | FICBCO0498 | FICBCO0498 | FICBCO0498 |
| **IdServicio Response** | FICBCO0500 | FICBCO0500 | FICBCO0500 | FICBCO0500 |
| **IdServicio Error** | FICBCO0491 | FICBCO0491 | FICBCO0491 | FICBCO0491 |
| **Autenticación** | Username/Password en SOAP Header | Username/Password en SOAP Header | Username/Password en SOAP Header | Username/Password en SOAP Header |
| **Validación XSD** | FraudAnalysisTypes.xsd | FraudAnalysisTypes.xsd | FraudAnalysisTypes.xsd | FraudAnalysisTypes.xsd |
| **Canales Soportados** | INTERBANCA_WEB, IVR, ATM, INTERBANCA_APP | INTERBANCA_WEB, IVR, ATM, INTERBANCA_APP | INTERBANCA_WEB, IVR, ATM, INTERBANCA_APP | INTERBANCA_WEB, IVR, ATM, INTERBANCA_APP |
| **Región por Defecto** | Sí (HN01 es el default) | No | No | No |
| **API Key App Name** | REGFRAUD | REGFRAUD | REGFRAUD | REGFRAUD |

---

## Análisis Detallado por Región

### 1. HN01 - Honduras (Región por Defecto)

#### Características Específicas

**Configuración Regional**:
- Honduras es la región por defecto del sistema
- Si el campo `SourceBank` viene vacío o nulo, el sistema automáticamente asigna "HN01"
- Si el campo `DestinationBank` viene vacío, se asigna el mismo valor que `SourceBank`

**Lógica de Valores por Defecto** (aplicarValoresPorDefectoRegion.xqy):
```xquery
if ( $data = "" ) then "HN01" else $data
```

**Validación Regional**:
- Parámetros enviados a `MW_P_VALIDA_SERVICIO_REGIONAL`:
  - `PV_SERVICIO`: "FICBCO0498"
  - `PV_ORIGEN`: "HN01"
  - `PV_DESTINO`: "HN01" (o el valor especificado)

**Bitácora**:
- Todos los registros de bitácora incluyen:
  - `BancoOrigen`: "HN01"
  - `BancoDestino`: "HN01" (o el especificado)

**Particularidades**:
- Es la única región que se aplica automáticamente si no se especifica ninguna
- Actúa como fallback para configuraciones sin región explícita

---

### 2. GT01 - Guatemala

#### Características Específicas

**Configuración Regional**:
- Debe especificarse explícitamente en el header del request
- No tiene valores por defecto automáticos

**Validación Regional**:
- Parámetros enviados a `MW_P_VALIDA_SERVICIO_REGIONAL`:
  - `PV_SERVICIO`: "FICBCO0498"
  - `PV_ORIGEN`: "GT01"
  - `PV_DESTINO`: "GT01" (o el valor especificado)

**Bitácora**:
- Todos los registros de bitácora incluyen:
  - `BancoOrigen`: "GT01"
  - `BancoDestino`: "GT01" (o el especificado)

**Particularidades**:
- Misma implementación técnica que otras regiones
- Diferenciación únicamente a nivel de datos (SourceBank/DestinationBank)

---

### 3. PA01 - Panamá

#### Características Específicas

**Configuración Regional**:
- Debe especificarse explícitamente en el header del request
- No tiene valores por defecto automáticos

**Validación Regional**:
- Parámetros enviados a `MW_P_VALIDA_SERVICIO_REGIONAL`:
  - `PV_SERVICIO`: "FICBCO0498"
  - `PV_ORIGEN`: "PA01"
  - `PV_DESTINO`: "PA01" (o el valor especificado)

**Bitácora**:
- Todos los registros de bitácora incluyen:
  - `BancoOrigen`: "PA01"
  - `BancoDestino`: "PA01" (o el especificado)

**Particularidades**:
- Misma implementación técnica que otras regiones
- Diferenciación únicamente a nivel de datos (SourceBank/DestinationBank)

---

### 4. NI01 - Nicaragua

#### Características Específicas

**Configuración Regional**:
- Debe especificarse explícitamente en el header del request
- No tiene valores por defecto automáticos

**Validación Regional**:
- Parámetros enviados a `MW_P_VALIDA_SERVICIO_REGIONAL`:
  - `PV_SERVICIO`: "FICBCO0498"
  - `PV_ORIGEN`: "NI01"
  - `PV_DESTINO`: "NI01" (o el valor especificado)

**Bitácora**:
- Todos los registros de bitácora incluyen:
  - `BancoOrigen`: "NI01"
  - `BancoDestino`: "NI01" (o el especificado)

**Particularidades**:
- Misma implementación técnica que otras regiones
- Diferenciación únicamente a nivel de datos (SourceBank/DestinationBank)

---

## Diferencias Identificadas

### Diferencias a Nivel de Código

**Sin diferencias detectadas en el código fuente**. La implementación es completamente agnóstica a la región. Todas las regiones:
- Usan el mismo proxy service
- Usan el mismo pipeline
- Usan las mismas transformaciones XQuery
- Invocan los mismos business services
- Usan el mismo endpoint de VU Security
- Usan la misma conexión a base de datos

### Diferencias a Nivel de Datos

Las únicas diferencias entre regiones son:

1. **Valor del campo SourceBank** en el header del request
2. **Valor del campo DestinationBank** en el header del request
3. **Región por defecto**: Solo HN01 se aplica automáticamente si no se especifica región
4. **Configuración en Base de Datos**: La validación regional (`MW_P_VALIDA_SERVICIO_REGIONAL`) puede tener configuraciones diferentes por región en la base de datos

### Diferencias Potenciales a Nivel de Base de Datos

Aunque el código es idéntico, pueden existir diferencias en:

1. **Tabla de Validación Regional**:
   - Cada región puede tener diferentes servicios habilitados/deshabilitados
   - La tabla consultada por `MW_P_VALIDA_SERVICIO_REGIONAL` puede tener configuraciones específicas por región

2. **Tabla de API Keys**:
   - Aunque todas las regiones usan el mismo app name ("REGFRAUD"), podrían tener diferentes API Keys almacenados
   - La tabla consultada por `MW_P_OBTENER_APIREST_AUT` puede retornar diferentes keys por región

3. **Tablas de Bitácora**:
   - Los registros se diferencian por los campos BancoOrigen y BancoDestino
   - Permite auditoría y análisis por región

4. **Tablas de Mapeo de Errores**:
   - Potencialmente podrían tener mensajes de error personalizados por región
   - No se encontró evidencia de esto en el código

---

## Similitudes entre Regiones

### Arquitectura Común

Todas las regiones comparten:

1. **Mismo Proxy Service**: `FraudAnalysis_PS`
2. **Mismo Pipeline**: `FraudAnalysis_PP`
3. **Mismos Business Services**:
   - ValidaServicioRegional_db
   - GetAPIAuth_BS
   - FraudAnalysis_BS
   - RegistrarBitacoraOSB_v2
   - MapeoErrores

### Flujo de Procesamiento Común

El flujo es idéntico para todas las regiones:

1. Validación XSD
2. Asignación de variables comunes
3. Registro de bitácora de request
4. Validación de servicio regional
5. Aplicación de valores por defecto
6. Obtención de API Key
7. Transformación de request
8. Invocación a VU Security
9. Evaluación de respuesta
10. Transformación de response
11. Registro de bitácora de response
12. Retorno de respuesta

### Transformaciones Comunes

Todas las regiones usan las mismas transformaciones:

1. **FraudAnalysis_To_VU.xqy**: Mapeo de canales y estructura
2. **Vu_To_FraudAnalysis_Response.xqy**: Mapeo de códigos de resultado a acciones
3. **validaServicioRegionalIn.xqy**: Construcción de request de validación
4. **aplicarValoresPorDefectoRegion.xqy**: Aplicación de defaults
5. **registrarBitacoraOSBIn.xqy**: Construcción de bitácora
6. **mapeoErroresUsageIn.xqy**: Construcción de mapeo de errores

### Políticas de Seguridad Comunes

Todas las regiones:
- Requieren autenticación Username/Password en SOAP Header
- Procesan WSS Header (processWssHeader="true")
- Validan contra el mismo XSD (FraudAnalysisTypes.xsd)
- Usan el mismo mecanismo de custom token authentication

### Configuración de Timeouts y Reintentos

Todas las regiones tienen la misma configuración (o falta de ella):
- Connection Timeout: 0 (sin límite)
- Read Timeout: 0 (sin límite)
- Retry Count: 0 (sin reintentos)
- Retry Interval: 30 segundos (no aplicable con retry count en 0)

---

## Consideraciones para Migración

### Aspectos Comunes a Todas las Regiones

1. **Configuración de Conexión a BD**: Todas las regiones requieren que `eis/DB/ConnectionMiddleware` esté configurado
2. **Endpoint de VU Security**: Todas las regiones apuntan al mismo endpoint (10.242.25.20:8080)
3. **Stored Procedures**: Todas las regiones requieren los mismos SPs en la base de datos
4. **Tablas de Configuración**: Validar que las tablas de validación regional, API keys, bitácora y mapeo de errores estén pobladas para todas las regiones

### Aspectos Específicos por Región

1. **Validación Regional**: Verificar que cada región (HN01, GT01, PA01, NI01) esté habilitada en la tabla de validación regional para el servicio FICBCO0498
2. **API Keys**: Verificar que existan API Keys para "REGFRAUD" (pueden ser iguales o diferentes por región)
3. **Datos de Prueba**: Preparar datos de prueba específicos para cada región

### Recomendaciones

1. **Externalizar Configuración Regional**: Considerar externalizar la configuración regional a archivos de properties o variables de ambiente
2. **Endpoint por Región**: Evaluar si cada región debería tener su propio endpoint de VU Security
3. **Monitoreo por Región**: Implementar dashboards que permitan ver métricas segregadas por región
4. **Alertas por Región**: Configurar alertas específicas por región para detectar problemas localizados

---

## Conclusión

La funcionalidad **FraudAnalysis** implementa un diseño **completamente multiregional agnóstico**, donde la diferenciación entre regiones se maneja exclusivamente a través de:

1. **Datos en el Header**: Los campos SourceBank y DestinationBank
2. **Configuración en Base de Datos**: Tablas de validación regional y configuración

**No existen diferencias en el código, transformaciones, endpoints o lógica de negocio entre regiones**. Esto representa una arquitectura limpia y mantenible, donde agregar una nueva región solo requiere:

1. Agregar la configuración en la tabla de validación regional
2. Configurar el API Key si es necesario
3. Actualizar la documentación

La única excepción es **HN01 (Honduras)**, que actúa como región por defecto cuando no se especifica ninguna región en el request.

---

**Fecha de Análisis**: 2024  
**Versión del Documento**: 1.0  
**Analista**: Amazon Q Developer
