# Análisis AS-IS: ActualizaDisponibleVentaMonedaExtranjera

## Índice de Documentos

1. [Resumen Ejecutivo](01-ResumenEjecutivo.md)
2. [Comparativa entre Regiones](02-ComparativaRegiones.md)
3. [Ejemplos y Mapeos - HN01](03-EjemplosYMapeos-HN01.md)
4. [Ejemplos y Mapeos - Otras Regiones](03-EjemplosYMapeos-OtrasRegiones.md)
5. [Diagrama de Secuencia - HN01](04-Secuencia-HN01.mmd)
6. [Diagrama de Secuencia - Otras Regiones](04-Secuencia-OtrasRegiones.mmd)
7. [Flujo Multi-región](05-FlujoMultiregión.mmd)
8. [Listado de Ficheros](06-ListadoFicheros.md)

## 1. Propósito de la Funcionalidad

La funcionalidad **ActualizaDisponibleVentaMonedaExtranjera** permite actualizar y gestionar los montos disponibles para la venta de moneda extranjera en el sistema bancario. Esta funcionalidad es crítica para el control de inventarios de divisas y la gestión de operaciones de cambio.

### Objetivo Principal
- Actualizar montos disponibles para venta de moneda extranjera
- Gestionar deals/transacciones de divisas con diferentes estados
- Controlar fechas de vencimiento y tipos de operación
- Soportar operaciones multi-regionales con enrutamiento dinámico

## 2. Entradas y Salidas Principales

### Entrada (Request)
```xml
<actualizaDisponibleVentaMonedaExtranjera>
    <PROFILE>CLIENTE001</PROFILE>           <!-- Perfil/Cliente -->
    <CURRENCY>USD</CURRENCY>                <!-- Tipo de moneda -->
    <AMOUNT>50000.00</AMOUNT>               <!-- Monto a actualizar -->
    <DEAL>DEAL001</DEAL>                    <!-- ID del deal/transacción -->
    <STATUS>ACTIVE</STATUS>                 <!-- Estado del deal -->
    <OPERATION_TYPE>SELL</OPERATION_TYPE>   <!-- Tipo de operación -->
    <END_DATE>20241231</END_DATE>           <!-- Fecha de vencimiento -->
    <ACTION_TYPE>UPDATE</ACTION_TYPE>       <!-- Tipo de acción -->
</actualizaDisponibleVentaMonedaExtranjera>
```

### Salida (Response)
```xml
<actualizaDisponibleVentaMonedaExtranjeraResponse>
    <SUCCESS_FLAG>Success</SUCCESS_FLAG>    <!-- Indicador de éxito -->
</actualizaDisponibleVentaMonedaExtranjeraResponse>
```

### Headers de Autenticación
- **RequestHeader**: Contiene información de autenticación, región y usuario
- **ResponseHeader**: Indica el estado de la operación (Success/Error) y mensajes

## 3. Sistemas/Servicios OSB Involucrados

### Proxy Services Principales
- **ActualizaDisponibleVentaMonedaExtranjera.proxy**: Servicio principal con enrutamiento dinámico
- **ActualizaDisponibleVentaMonedaExtranjeraHN.proxy**: Implementación específica para Honduras (HN01)

### Business Services
- **consultaRutaRegional_db**: Servicio de base de datos para determinar enrutamiento regional
- **mercadoLibre**: Servicio T24 para actualización de montos disponibles en Honduras

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
1. **Validación XSD**: Validación del esquema de entrada con 8 campos obligatorios
2. **Consulta Ruta Regional**: Determina el proxy destino según la región
3. **Enrutamiento Dinámico**: Redirección al proxy regional específico
4. **Mapeo de Errores**: Procesamiento de errores con códigos estándar

### Flujo Honduras (HN01)
1. **Actualización Directa T24**: Invocación directa al servicio `ActualizaDisponibleMonedaFCY`
2. **Transformación de Datos**: Mapeo completo de 8 campos de entrada
3. **Manejo de Respuesta**: Procesamiento directo sin enrutamiento adicional
4. **Gestión de Fechas**: Conversión automática de fechas a formato T24

## 6. Riesgos/Limitaciones Conocidas

### Riesgos Técnicos
- **Dependencia T24**: La región HN01 depende directamente del sistema T24
- **Enrutamiento Dinámico**: Fallas en `consultaRutaRegional` afectan todas las regiones
- **Gestión de Fechas**: Conversión automática de fechas puede causar inconsistencias
- **Validación de Deals**: No se valida existencia previa de deals

### Limitaciones Funcionales
- **Campos Obligatorios**: Los 8 campos son obligatorios sin validaciones de negocio
- **Estados Limitados**: No se validan los estados permitidos para deals
- **Sin Rollback**: No implementa mecanismo de rollback para operaciones fallidas
- **Monedas**: Principalmente diseñado para USD pero acepta otras monedas

### Riesgos de Migración
- **Configuración Regional**: Cada región requiere configuración específica de endpoints
- **Credenciales**: Manejo de credenciales por región en LDAP
- **Base de Datos**: Dependencia de stored procedures específicos
- **Sincronización**: Riesgo de inconsistencias entre regiones

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
- **Consistencia**: No garantiza consistencia transaccional entre regiones

## 8. Dependencias Críticas

### Sistemas Backend
- **T24 (Honduras)**: Sistema core banking para actualización de divisas
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

## 9. Reglas de Negocio Identificadas

### Transformaciones de Datos
- **Conversión de Fechas**: Fecha actual automática en formato YYYYMMDD
- **Mapeo de Campos**: Transformación directa de 8 campos OSB → T24
- **Credenciales**: Lookup LDAP con failover a credenciales del header
- **ID de Deal**: Usado como identificador único en T24

### Validaciones
- **XSD Obligatorio**: Validación de esquema antes del procesamiento
- **Campos Requeridos**: Los 8 campos son obligatorios
- **Formato de Fechas**: END_DATE debe ser string en formato válido
- **Montos**: AMOUNT debe ser numérico válido

### Estados y Operaciones
- **STATUS**: Estados del deal (ACTIVE, INACTIVE, etc.)
- **OPERATION_TYPE**: Tipos de operación (SELL, BUY, etc.)
- **ACTION_TYPE**: Tipos de acción (UPDATE, CREATE, DELETE, etc.)

## 10. Consideraciones de Migración

### Preparación Requerida
1. **Mapeo de Regiones**: Confirmar todas las regiones activas
2. **Configuración de Endpoints**: Validar URLs de servicios backend por región
3. **Credenciales**: Migrar configuración LDAP por región
4. **Base de Datos**: Verificar stored procedures en ambiente destino
5. **Validación de Deals**: Confirmar estructura de deals en T24 destino

### Puntos de Atención
- **Orden de Despliegue**: Servicios de soporte antes que proxies principales
- **Configuración Regional**: Validar configuración específica por país
- **Pruebas de Conectividad**: Verificar conectividad con todos los backends
- **Rollback Plan**: Preparar plan de rollback por región
- **Sincronización de Datos**: Validar consistencia de deals entre ambientes

### Diferencias con ConsultaDisponibleVentaMonedaExtranjera
- **Complejidad**: Más campos de entrada (8 vs 1)
- **Operación**: Actualización vs Consulta
- **Validaciones**: Más estrictas debido a la naturaleza de actualización
- **Impacto**: Mayor riesgo por ser operación de escritura
- **ID de Servicio**: FICBCO0439 vs FICBCO0434

## 11. Recomendaciones

### Técnicas
- Implementar validaciones de negocio adicionales
- Agregar mecanismo de rollback para operaciones fallidas
- Configurar timeouts específicos para operaciones críticas
- Implementar cache para consultas de enrutamiento frecuentes

### Operacionales
- Establecer monitoreo específico para deals críticos
- Implementar alertas para fallos de actualización
- Crear dashboards de métricas de disponibilidad de divisas
- Establecer procedimientos de reconciliación entre regiones

### Seguridad
- Validar permisos por tipo de operación y monto
- Implementar auditoría completa de transacciones
- Establecer límites por usuario y región
- Configurar alertas de seguridad para operaciones sospechosas