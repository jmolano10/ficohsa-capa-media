# Análisis AS-IS: ConsultaDisponibleVentaMonedaExtranjera

## Índice de Documentos

1. [Resumen Ejecutivo](01-ResumenEjecutivo.md)
2. [Comparativa entre Regiones](02-ComparativaRegiones.md)
3. [Ejemplos y Mapeos - HN01](03-EjemplosYMapeos-HN01.md)
4. [Ejemplos y Mapeos - Otras Regiones](03-EjemplosYMapeos-OtrasRegiones.md)
7. [Flujo Multi-región](05-FlujoMultiregión.mmd)
8. [Listado de Ficheros](06-ListadoFicheros.md)

## 1. Propósito de la Funcionalidad

La funcionalidad **ConsultaDisponibleVentaMonedaExtranjera** permite consultar el monto disponible para la venta de moneda extranjera (principalmente dólares) en el sistema bancario. Esta funcionalidad es crítica para operaciones de cambio de divisas y control de límites de venta de moneda extranjera.

### Objetivo Principal
- Consultar el monto disponible para venta de moneda extranjera por tipo de divisa
- Proporcionar información en tiempo real sobre disponibilidad de divisas
- Soportar operaciones multi-regionales con enrutamiento dinámico

## 2. Entradas y Salidas Principales

### Entrada (Request)
```xml
<consultaDisponibleVentaMonedaExtranjera>
    <CURRENCY>USD</CURRENCY>  <!-- Tipo de moneda (obligatorio) -->
</consultaDisponibleVentaMonedaExtranjera>
```

### Salida (Response)
```xml
<consultaDisponibleVentaMonedaExtranjeraResponse>
    <AMOUNT_AVAILABLE>1000000.00</AMOUNT_AVAILABLE>  <!-- Monto disponible -->
</consultaDisponibleVentaMonedaExtranjeraResponse>
```

### Headers de Autenticación
- **RequestHeader**: Contiene información de autenticación, región y usuario
- **ResponseHeader**: Indica el estado de la operación (Success/Error) y mensajes

## 3. Sistemas/Servicios OSB Involucrados

### Proxy Services Principales
- **ConsultaDisponibleVentaMonedaExtranjera.proxy**: Servicio principal con enrutamiento dinámico
- **ConsultaDisponibleVentaMonedaExtranjeraHN.proxy**: Implementación específica para Honduras (HN01)

### Business Services
- **consultaRutaRegional_db**: Servicio de base de datos para determinar enrutamiento regional
- **mercadoLibre**: Servicio T24 para consulta de montos disponibles en Honduras

### Servicios de Soporte
- **MapeoErrores**: Manejo y mapeo de errores del sistema
- **ValidaServicioRegional**: Validación de servicios por región

## 4. Arquitectura Regional Detectada

### Regiones Identificadas
Basado en el análisis del código fuente, se identifican las siguientes regiones:

1. **HN01** (Honduras): Implementación completa identificada
2. **GT01** (Guatemala): Inferida por patrones de naming en otros servicios
3. **PA01** (Panamá): Inferida por patrones de naming en otros servicios  
4. **NI01** (Nicaragua): Inferida por patrones de naming en otros servicios

### Patrón de Enrutamiento
- **Servicio Principal**: Utiliza `consultaRutaRegional` para determinar el proxy destino
- **Enrutamiento Dinámico**: Basado en el campo `SourceBank` del header de región
- **Implementación Regional**: Cada región puede tener su propia lógica de negocio

## 5. Flujo de Procesamiento

### Flujo General (Regiones No-HN)
1. **Validación XSD**: Validación del esquema de entrada
2. **Consulta Ruta Regional**: Determina el proxy destino según la región
3. **Enrutamiento Dinámico**: Redirección al proxy regional específico
4. **Mapeo de Errores**: Procesamiento de errores con códigos estándar

### Flujo Honduras (HN01)
1. **Consulta Directa T24**: Invocación directa al servicio `mercadoLibre`
2. **Transformación de Datos**: Mapeo de request/response específico
3. **Manejo de Respuesta**: Procesamiento directo sin enrutamiento adicional

## 6. Riesgos/Limitaciones Conocidas

### Riesgos Técnicos
- **Dependencia T24**: La región HN01 depende directamente del sistema T24
- **Enrutamiento Dinámico**: Fallas en `consultaRutaRegional` afectan todas las regiones
- **Timeout**: No se configuran timeouts específicos en algunos servicios

### Limitaciones Funcionales
- **Moneda Única**: Principalmente diseñado para USD
- **Validación Mínima**: Validaciones básicas de entrada
- **Sin Cache**: No implementa cache para consultas frecuentes

### Riesgos de Migración
- **Configuración Regional**: Cada región requiere configuración específica de endpoints
- **Credenciales**: Manejo de credenciales por región en LDAP
- **Base de Datos**: Dependencia de stored procedures específicos

## 7. Métricas y SLAs

### Configuración de Monitoreo
- **Logging**: Habilitado en nivel DEBUG
- **SLA Alerting**: Habilitado con nivel NORMAL
- **Pipeline Alerting**: Habilitado con nivel NORMAL
- **Reporting**: Habilitado para métricas de uso

### Configuración de Rendimiento
- **Throttling**: Deshabilitado (capacidad ilimitada)
- **Message Tracing**: Deshabilitado por defecto
- **Retry Policy**: 0 reintentos configurados
- **Load Balancing**: Round-robin para servicios backend

### SLAs Implícitos
- **Timeout**: Sin timeout específico configurado (usa defaults del sistema)
- **Disponibilidad**: Dependiente de la disponibilidad de T24 y base de datos regional
- **Throughput**: Sin límites específicos configurados

## 8. Dependencias Críticas

### Sistemas Backend
- **T24 (Honduras)**: Sistema core banking para consultas de divisas
- **Base de Datos Middleware**: Para enrutamiento regional y configuración
- **LDAP**: Para autenticación y credenciales por región

### Servicios OSB
- **consultaRutaRegional**: Crítico para enrutamiento multi-regional
- **MapeoErrores**: Esencial para manejo consistente de errores
- **Validación XSD**: Para integridad de datos de entrada

### Infraestructura
- **Conectividad HTTP**: Para servicios T24
- **Conectividad JCA**: Para base de datos
- **Certificados SSL**: Para comunicación segura

## 9. Consideraciones de Migración

### Preparación Requerida
1. **Mapeo de Regiones**: Confirmar todas las regiones activas
2. **Configuración de Endpoints**: Validar URLs de servicios backend por región
3. **Credenciales**: Migrar configuración LDAP por región
4. **Base de Datos**: Verificar stored procedures en ambiente destino

### Puntos de Atención
- **Orden de Despliegue**: Servicios de soporte antes que proxies principales
- **Configuración Regional**: Validar configuración específica por país
- **Pruebas de Conectividad**: Verificar conectividad con todos los backends
- **Rollback Plan**: Preparar plan de rollback por región
