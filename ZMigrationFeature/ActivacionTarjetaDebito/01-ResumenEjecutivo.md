# Análisis AS-IS: ActivacionTarjetaDebito

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

La funcionalidad **ActivacionTarjetaDebito** permite activar tarjetas de débito en el sistema bancario. Es un servicio crítico para la gestión del ciclo de vida de tarjetas de débito, permitiendo a los clientes activar sus tarjetas para uso en transacciones.

### Objetivo Principal
- Activar tarjetas de débito mediante número de tarjeta
- Validar existencia y tipo de producto de la tarjeta
- Registrar bitácora completa de transacciones
- Soportar operaciones regionales con validación específica

## 2. Entradas y Salidas Principales

### Entrada (Request)
```xml
<activacionTarjetaDebito>
    <DEBIT_CARD_NUMBER>1234567890123456</DEBIT_CARD_NUMBER>
</activacionTarjetaDebito>
```

### Salida (Response)
```xml
<activacionTarjetaDebitoResponse/>
```

### Headers de Autenticación
- **RequestHeader**: Contiene información de autenticación, región y usuario
- **ResponseHeader**: Indica el estado de la operación (Success/Error) y mensajes

## 3. Sistemas/Servicios OSB Involucrados

### Proxy Services Principales
- **ActivacionTarjetaDebito.proxy**: Servicio principal con validación regional

### Business Services
- **ValidaServicioRegional_db**: Validación de servicios por región
- **tarjetasDebitoBS**: Servicio T24 para consulta y activación de tarjetas
- **RegistrarBitacoraOSB_v2**: Registro de bitácora de transacciones

### Servicios de Soporte
- **MapeoErrores**: Manejo y mapeo de errores del sistema

## 4. Arquitectura Regional Detectada

### Regiones Identificadas
1. **HN01** (Honduras): Implementación completa identificada
2. **Otras regiones**: Implementación por defecto con mensaje de error

### Patrón de Enrutamiento
- **Validación Regional**: Utiliza `ValidaServicioRegional` para verificar disponibilidad
- **Branch Condicional**: Basado en el campo `SourceBank` del header
- **Implementación Específica**: Solo Honduras tiene implementación funcional

## 5. Flujo de Procesamiento

### Flujo General
1. **Validación XSD**: Validación del esquema de entrada
2. **Validación Regional**: Verifica si el servicio está disponible para la región
3. **Branch Regional**: Enruta según la región de origen
4. **Mapeo de Errores**: Procesamiento de errores con códigos estándar

### Flujo Honduras (HN01)
1. **Bitácora Request**: Registro de entrada de la transacción
2. **Validación Campo**: Verifica que el número de tarjeta no esté vacío
3. **Consulta Maestra**: Consulta información de la tarjeta en T24
4. **Validación Producto**: Verifica que el tipo de producto exista
5. **Activación**: Ejecuta la activación de la tarjeta
6. **Bitácora Response**: Registro de salida de la transacción

## 6. Riesgos/Limitaciones Conocidas

### Riesgos Técnicos
- **Dependencia T24**: Solo Honduras tiene conexión funcional a T24
- **Validación Regional**: Otras regiones no tienen implementación
- **Bitácora**: Dependencia crítica del servicio de bitácora

### Limitaciones Funcionales
- **Campo Único**: Solo requiere número de tarjeta
- **Regiones Limitadas**: Solo Honduras implementado
- **Sin Rollback**: No implementa mecanismo de rollback
- **Validación Básica**: Validaciones mínimas de entrada

### Riesgos de Migración
- **Implementación Parcial**: Solo una región funcional
- **Dependencias T24**: Validar conectividad en ambiente destino
- **Bitácora**: Migrar servicio de bitácora como dependencia crítica

## 7. Métricas y SLAs

### Configuración de Monitoreo
- **Logging**: Habilitado en nivel DEBUG
- **SLA Alerting**: Habilitado con nivel NORMAL
- **Pipeline Alerting**: Habilitado con nivel NORMAL
- **Reporting**: Habilitado para métricas de uso

### Configuración de Rendimiento
- **Throttling**: No configurado
- **Message Tracing**: Deshabilitado por defecto
- **Retry Policy**: No configurado
- **Load Balancing**: No aplicable (single region)

## 8. Dependencias Críticas

### Sistemas Backend
- **T24 (Honduras)**: Sistema core banking para activación de tarjetas
- **Base de Datos Middleware**: Para validación regional
- **LDAP**: Para autenticación y credenciales

### Servicios OSB
- **ValidaServicioRegional**: Crítico para validación regional
- **MapeoErrores**: Esencial para manejo consistente de errores
- **RegistrarBitacoraOSB_v2**: Crítico para auditoría

### Infraestructura
- **Conectividad HTTP**: Para servicios T24
- **Conectividad JCA**: Para base de datos
- **Certificados SSL**: Para comunicación segura

## 9. Reglas de Negocio Identificadas

### Validaciones
- **Campo Obligatorio**: DEBIT_CARD_NUMBER no puede estar vacío
- **Validación XSD**: Esquema obligatorio antes del procesamiento
- **Validación Regional**: Servicio debe estar habilitado para la región
- **Tipo de Producto**: Debe existir tipo de producto para la tarjeta

### Flujo de Activación
1. **Consulta Maestra**: Busca tarjeta con patrón "...{número}"
2. **Validación Producto**: Verifica que PRODUCTTYPE no esté vacío
3. **Activación**: Construye ID como "{PRODUCTTYPE}.{CARD_NUMBER}"
4. **Bitácora**: Registra request y response completos

### Manejo de Errores
- **Campo Vacío**: "REQUIRED FIELDS NOT SUPPLIED"
- **Producto Inexistente**: Mensaje del sistema T24 o ZERORECORDS
- **Error Regional**: Mensaje de validación regional
- **Error Sistema**: Mapeo estándar con código FICBCO0324

## 10. Consideraciones de Migración

### Preparación Requerida
1. **Validación T24**: Confirmar servicios en ambiente destino
2. **Bitácora**: Migrar servicio de bitácora como prioridad
3. **Validación Regional**: Configurar tabla de servicios por región
4. **Credenciales**: Migrar configuración LDAP

### Puntos de Atención
- **Implementación Parcial**: Solo Honduras funcional
- **Dependencia Bitácora**: Crítica para auditoría
- **Validaciones**: Confirmar reglas de negocio en destino
- **Otras Regiones**: Decidir si implementar o mantener error

### Diferencias con Otras Funcionalidades
- **Simplicidad**: Solo un campo de entrada
- **Bitácora Completa**: Request y response registrados
- **Validación Previa**: Consulta maestra antes de activación
- **ID Compuesto**: Usa PRODUCTTYPE + CARD_NUMBER

## 11. Recomendaciones

### Técnicas
- Implementar validaciones adicionales de tarjeta
- Agregar timeout específico para operaciones T24
- Implementar cache para consultas de producto frecuentes
- Considerar implementación para otras regiones

### Operacionales
- Establecer monitoreo específico para activaciones
- Implementar alertas para fallos de activación
- Crear dashboards de métricas de activación por región
- Establecer procedimientos de rollback manual

### Seguridad
- Validar permisos por región y tipo de tarjeta
- Implementar auditoría completa de activaciones
- Establecer límites de activaciones por usuario
- Configurar alertas de seguridad para patrones sospechosos