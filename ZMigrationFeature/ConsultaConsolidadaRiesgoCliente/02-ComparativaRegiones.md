# Comparativa entre Regiones - ConsultaConsolidadaRiesgoCliente

## Tabla de Comparación

| Aspecto | GT01 (Guatemala) | HN01 (Honduras) |
|---------|------------------|-----------------|
| **Endpoint OSB** | `/Middleware/RiskAndCompliance/RegulationsAndCompliance/ConsultaConsolidadaRiesgoCliente` | `/Middleware/RiskAndCompliance/RegulationsAndCompliance/ConsultaConsolidadaRiesgoCliente` |
| **Proxy Principal** | ConsultaConsolidadaRiesgoClienteGT.proxy | ConsultaConsolidadaRiesgoClienteHN.proxy |
| **Pipeline** | ConsultaConsolidadaRiesgoClienteGT.pipeline | ConsultaConsolidadaRiesgoClienteHN.pipeline |
| **Base de Datos** | ConnectionCustomerCreditRisk | ConnectionCustomerCreditRisk |
| **Esquema** | CREDITOS_RIESGOS | CREDITOS_RIESGOS |
| **Store Procedure** | p_consulta_ONBASE | p_consulta_ONBASE |
| **Conexión DB** | jca://eis/DB/ConnectionCustomerCreditRisk | jca://eis/DB/ConnectionCustomerCreditRisk |
| **Servicios Adicionales** | sjConsultaConsolidadaRiesgoClienteGT, consultaBurosPrecreditoGT | Ninguno |
| **Burós de Crédito** | TransUnion, SIRC | No aplica |
| **Transformaciones IN** | sjConsultaConsolidadaRiesgoClienteGTIn.xqy, consultaBurosGT.xqy | consultaConsolidadaRiesgoClienteIn.xqy |
| **Transformaciones OUT** | consultaConsolidadaRiesgoClienteGTOut.xqy | consultaConsolidadaRiesgoClienteOut.xqy, consultaConsolidadaRiesgoClienteHeaderOut.xqy |
| **Validación Regional** | Obtención de parámetros KEY para burós | No aplica |
| **Timeouts/Retrys** | 0 reintentos | 0 reintentos |
| **Monitoreo** | Habilitado (360s) | Habilitado (360s) |
| **Logging** | Debug habilitado | Debug habilitado |
| **Manejo de Errores** | Error handler personalizado | Error handler personalizado |

## Sección Guatemala (GT01)

### Características Específicas

#### Endpoints y Servicios
- **Proxy**: `ConsultaConsolidadaRiesgoClienteGT.proxy`
- **Pipeline**: `ConsultaConsolidadaRiesgoClienteGT.pipeline`
- **Binding**: SOAP 1.1 con selector SOAP body
- **Transport**: Local (interno)

#### Flujo de Procesamiento
1. **Consulta SJS**: Llamada a `sjConsultaConsolidadaRiesgoClienteGT`
2. **Obtención de Parámetros**: Consulta de parámetros de configuración para KEY de burós
3. **Consulta de Burós**: Llamada a `consultaBurosPrecreditoGT` con datos del cliente
4. **Validación de Respuesta**: Verificación del código de estado de la consulta de burós
5. **Transformación de Salida**: Consolidación de datos de SJS y burós de crédito

#### Transformaciones Clave
- **consultaBurosGT.xqy**: Mapea datos del cliente para consulta de burós
  - Mapea CUSTOMER_LEGAL_ID → DPI
  - Mapea FISCAL_ID → NIT
  - Incluye parámetros de autenticación (KEY, IP, PC)
- **sjConsultaConsolidadaRiesgoClienteGTIn.xqy**: Transformación para servicio SJS
- **consultaConsolidadaRiesgoClienteGTOut.xqy**: Consolidación de respuestas múltiples

#### Campos Diferenciadores
- **Información de Burós**: Datos de TransUnion y SIRC
- **Referencias Externas**: REFERENCE_BUREAU_TUCA, REFERENCE_BUREAU_SIRC
- **Score Externo**: EXTERNAL_SCORE de burós de crédito
- **Referencia SIB**: Campo específico de Guatemala

#### Validaciones y Políticas OSB
- **Validación de Parámetros**: Verificación de KEY para burós de crédito
- **Validación de Estado**: Verificación de código de respuesta de burós (código '1' = éxito)
- **Manejo de Errores**: Error handler específico con logging detallado

#### Dependencias Internas
- **ObtenerParametrizacion**: Para obtener KEY de burós por región
- **sjConsultaConsolidadaRiesgoClienteGT**: Servicio SJS para datos internos
- **consultaBurosPrecreditoGT**: Servicio de burós de crédito

## Sección Honduras (HN01)

### Características Específicas

#### Endpoints y Servicios
- **Proxy**: `ConsultaConsolidadaRiesgoClienteHN.proxy`
- **Pipeline**: `ConsultaConsolidadaRiesgoClienteHN.pipeline`
- **Binding**: SOAP 1.1 con selector SOAP action
- **Transport**: Local (interno)

#### Flujo de Procesamiento
1. **Consulta Directa**: Llamada directa a `consultaConsolidadaRiesgoCliente_db`
2. **Procesamiento de XML**: Extracción de datos XML de la respuesta de base de datos
3. **Transformación de Salida**: Mapeo directo de datos de base de datos

#### Transformaciones Clave
- **consultaConsolidadaRiesgoClienteIn.xqy**: Mapeo simple de CUSTOMER_LEGAL_ID → IDENTIDAD
- **consultaConsolidadaRiesgoClienteOut.xqy**: Transformación compleja de XML de base de datos
- **consultaConsolidadaRiesgoClienteHeaderOut.xqy**: Construcción de header de respuesta

#### Campos Diferenciadores
- **Datos Internos Únicamente**: Sin información de burós externos
- **Estructura Completa**: Información detallada de activos, pasivos y transacciones
- **Ofertas Preaprobadas**: Múltiples tipos de ofertas (FICOCREDITO, FICOYA, OPI, RETANQUEO)
- **Historial Transaccional**: Datos históricos detallados de 12 meses

#### Validaciones y Políticas OSB
- **Validación XSD**: Validación de esquema en entrada
- **Procesamiento XML**: Uso de fn-bea:inlinedXML para procesar respuesta
- **Manejo de Fechas**: Conversiones de formato de fecha específicas

#### Dependencias Internas
- **consultaConsolidadaRiesgoCliente_db**: Business service de base de datos
- **MapeoErrores**: Servicio de mapeo de errores (heredado del proxy principal)

## Diferencias Principales

### Arquitectura
- **GT01**: Arquitectura multi-servicio con integración de burós externos
- **HN01**: Arquitectura simple con consulta directa a base de datos

### Fuentes de Datos
- **GT01**: Datos internos (SJS) + Burós de crédito (TransUnion, SIRC)
- **HN01**: Únicamente datos internos de DataWarehouse

### Complejidad de Respuesta
- **GT01**: Respuesta consolidada con datos externos limitados
- **HN01**: Respuesta completa con datos históricos detallados

### Manejo de Errores
- **GT01**: Validación de códigos de estado de burós de crédito
- **HN01**: Manejo estándar de errores de base de datos

### Configuración Regional
- **GT01**: Requiere configuración de parámetros KEY por región
- **HN01**: Sin configuración regional específica

## Consideraciones de Migración

### Aspectos Críticos por Región

#### Guatemala (GT01)
1. **Configuración de Burós**: Migrar parámetros KEY de configuración
2. **Servicios Externos**: Asegurar conectividad con burós de crédito
3. **Transformaciones Complejas**: Validar mapeos de múltiples fuentes

#### Honduras (HN01)
1. **Procesamiento XML**: Validar función fn-bea:inlinedXML
2. **Transformaciones Extensas**: Verificar mapeos de datos históricos
3. **Ofertas Múltiples**: Asegurar correcta construcción de ofertas preaprobadas

### Recomendaciones Específicas
1. **Pruebas por Región**: Ejecutar casos de prueba específicos para cada región
2. **Configuración Diferenciada**: Mantener configuraciones separadas por región
3. **Monitoreo Granular**: Implementar métricas específicas por región
4. **Documentación Regional**: Mantener documentación actualizada de diferencias