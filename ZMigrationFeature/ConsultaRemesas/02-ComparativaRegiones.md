# Comparativa entre Regiones - ConsultaRemesas

## Regiones Detectadas

Basado en el análisis del código fuente, se han identificado las siguientes regiones:

### Regiones Configuradas:
- **HN01**: Honduras (Única región actualmente implementada)
- **GT01**: Guatemala (Referenciada en configuraciones pero no implementada)
- **PA01**: Panamá (Referenciada en configuraciones pero no implementada)
- **NI01**: Nicaragua (Referenciada en configuraciones pero no implementada)

## Tabla de Comparación por Región

| Aspecto | HN01 (Honduras) | GT01 (Guatemala) | PA01 (Panamá) | NI01 (Nicaragua) |
|---------|-----------------|------------------|---------------|------------------|
| **Endpoint OSB** | `/Middleware/OperationsAndExecution/Payments/ConsultaRemesas_v2` | No implementado | No implementado | No implementado |
| **Base de Datos Principal** | T24 Honduras | No configurado | No configurado | No configurado |
| **Esquemas DB** | T24, FLink | No configurado | No configurado | No configurado |
| **Store Procedures** | `ObtenerTipoRemesadora`, `consultarRemLocalId`, `consultarRemFRemXPagador`, `obtenerCamposRemesasRel`, `ingresoRelConsPagoRem` | No configurado | No configurado | No configurado |
| **Conexión DB** | `ConnectionMiddleware` (JCA) | No configurado | No configurado | No configurado |
| **Transformaciones Clave** | `validarTipoConsulta.xq`, `obtenerTipoRemesadoraIn.xq`, `consultaRemesaT24In.xq`, `sjconsultaMultipleRemesadorasIn.xq` | No implementado | No implementado | No implementado |
| **Campos Diferenciadores** | `REMITTANCE_ID`, `REMITTER_NAME`, `BENEFICIARY_NAME` | No implementado | No implementado | No implementado |
| **Errores/Excepciones** | Mapeo centralizado via `MapeoErrores.proxy` | No implementado | No implementado | No implementado |
| **Timeouts/Retrys** | MaxTime500.alert (500ms) | No configurado | No configurado | No configurado |
| **Dependencias Internas** | T24, FLink, SJS, Validación Regional | No configurado | No configurado | No configurado |
| **Tipos de Remesadora** | REMESALOCAL, FICOREMESA, ONLINE | No configurado | No configurado | No configurado |
| **Sistemas de Consulta** | T24 (Core), FLink (Tablas), SJS (Online) | No configurado | No configurado | No configurado |
| **Validación de Listas** | EvaluaListasCliente habilitado | No configurado | No configurado | No configurado |

## Detalles por Región

### HN01 (Honduras) - IMPLEMENTADA

#### Configuración Completa:
- **Región Activa**: Única región con implementación completa
- **Branch Condition**: `./aut:RequestHeader/Region/SourceBank = 'HN01'`
- **Flujo Completo**: Validación → Determinación → Enrutamiento → Consulta → Respuesta

#### Endpoints y Conexiones:
- **Proxy Service**: `ConsultaRemesas.proxy`
- **URL Endpoint**: `https://172.23.177.15:8004/Middleware/OperationsAndExecution/Payments/ConsultaRemesas_v2`
- **Conexión DB**: `jca://eis/DB/ConnectionMiddleware`
- **SJS Endpoint**: `http://172.23.13.19:8003/Middleware/SJS/ConsultaMultipleRemesadoras`

#### Tipos de Remesadora Soportados:
1. **REMESALOCAL**:
   - Fuente: T24 o Tablas FLink
   - SP: `consultarRemLocalId`
   - Validación: Estado DISPONIBLE

2. **FICOREMESA**:
   - Fuente: Tablas FLink
   - SP: `consultarRemFRemXPagador`
   - Validación: Estado DISPONIBLE

3. **ONLINE**:
   - Fuente: SJS (Split-Join Service)
   - Remesadoras: Moneygram, Western Union, etc.
   - Priorización: Por campo PRIORITY

#### Validaciones Específicas:
- **Validación Regional**: `ValidaServicioRegional` con ServiceId: `FICBCO0148`
- **Validación XSD**: `consultaRemesasTypes.xsd`
- **Validación de Permisos**: Parámetros `REMITALLOW`, `CHECKLISTS`, `CHECKREMITTERID`
- **Evaluación de Listas**: Integración con `EvaluaListasCliente`

#### Transformaciones Específicas:
- **Entrada**: `validarTipoConsulta.xq` → Determina ID_BASED vs NAME_BASED
- **T24**: `consultaRemesaT24In.xq` → Transformación para core banking
- **Local**: `consultaRemLocalIdIn.xq` → Transformación para tablas locales
- **Ficohsa**: `consultaFRemPagIdIn.xq` → Transformación para Ficohsa Remesas
- **Online**: `sjconsultaMultipleRemesadorasIn.xq` → Transformación para SJS
- **Salida**: `EnrutadorConveniosOut.xq` → Respuesta unificada

#### Manejo de Errores:
- **Código de Servicio**: `FICBCO0148`
- **Mapeo Centralizado**: `MapeoErrores.proxy`
- **Códigos de Error**: Específicos por tipo de remesadora
- **Logging**: Nivel DEBUG habilitado

### GT01, PA01, NI01 - NO IMPLEMENTADAS

#### Estado Actual:
- **Implementación**: No existe flujo específico
- **Branch Condition**: Default branch (flujo vacío)
- **Configuración**: Referencias en parámetros pero sin implementación

#### Configuraciones Detectadas:
```
T24C070.{USUARIO}.REMITALLOW - Remesadoras permitidas por usuario
T24C070.{USUARIO}.IDPAYERGUSER - ID de pagador por usuario
T24C070.{USUARIO}.CHECKLISTS - Validación de listas habilitada
T24C070.{USUARIO}.CHECKREMITTERID - IDs de remesadora a validar
```

#### Limitaciones:
- **Sin Endpoint**: No hay URL específica configurada
- **Sin Validación**: No hay validación regional específica
- **Sin Transformaciones**: No existen XQuery específicos
- **Sin Conexiones**: No hay conexiones a sistemas locales configuradas

## Diferencias Clave Identificadas

### 1. Arquitectura de Datos
- **HN01**: Integración completa con T24 + FLink + SJS
- **Otras Regiones**: Sin integración configurada

### 2. Tipos de Remesadora
- **HN01**: Soporte completo para 3 tipos (Local, Ficohsa, Online)
- **Otras Regiones**: Sin configuración

### 3. Validaciones
- **HN01**: Validación regional + XSD + Permisos + Listas
- **Otras Regiones**: Sin validaciones específicas

### 4. Transformaciones
- **HN01**: 8+ transformaciones XQuery específicas
- **Otras Regiones**: Sin transformaciones

### 5. Manejo de Errores
- **HN01**: Mapeo centralizado con código FICBCO0148
- **Otras Regiones**: Sin manejo específico

## Recomendaciones para Implementación Multi-Regional

### 1. Estandarización de Configuración
- Crear parámetros específicos por región: `T24C070.{REGION}.{PARAMETRO}`
- Implementar branch conditions para cada región
- Configurar endpoints específicos por región

### 2. Adaptación de Transformaciones
- Crear XQuery específicos por región: `{transformacion}_{REGION}.xq`
- Adaptar mapeos de campos según sistemas locales
- Implementar validaciones regionales específicas

### 3. Integración de Sistemas
- Configurar conexiones a sistemas core por región
- Adaptar stored procedures según esquemas locales
- Implementar failover y resilience por región

### 4. Validaciones Regionales
- Implementar `ValidaServicioRegional` por región
- Configurar códigos de servicio específicos
- Adaptar validación de listas según regulaciones locales

## Impacto de Migración

### Complejidad Alta:
- **HN01**: Migración completa requerida (todos los componentes)
- **Otras Regiones**: Implementación desde cero necesaria

### Dependencias Críticas:
- Sistemas core banking por región
- Tablas de configuración regional
- Servicios de remesadoras locales por país

### Riesgos de Implementación:
- Diferencias en sistemas core por región
- Regulaciones específicas por país
- Integración con remesadoras locales diferentes