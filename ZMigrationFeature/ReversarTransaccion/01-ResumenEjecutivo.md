# Resumen Ejecutivo - ReversarTransaccion

## Índice de Documentos
- [01-ResumenEjecutivo.md](01-ResumenEjecutivo.md)
- [02-ComparativaRegiones.md](02-ComparativaRegiones.md)
- [03-EjemplosYMapeos-HN01.md](03-EjemplosYMapeos-HN01.md)
- [04-Secuencia-HN01.mmd](04-Secuencia-HN01.mmd)
- [05-FlujoMultiregión.mmd](05-FlujoMultiregión.mmd)
- [06-ListadoFicheros.md](06-ListadoFicheros.md)

## Propósito de la Funcionalidad

La funcionalidad **ReversarTransaccion** permite reversar diferentes tipos de transacciones bancarias que han sido procesadas previamente en el sistema. Esta funcionalidad es crítica para el manejo de errores operacionales y correcciones de transacciones.

## Entradas y Salidas Principales

### Entradas
- **TRANSACTION_ID**: Identificador único de la transacción a reversar (obligatorio)
- **TRANSACTION_TYPE**: Tipo de transacción a reversar (opcional en algunas versiones)
- **AUTHORIZER_USERNAME**: Usuario autorizador (opcional)
- **AUTHORIZER_PASSWORD**: Contraseña del autorizador (opcional)

### Salidas
- **ResponseHeader**: Indicador de éxito/error y mensajes
- **T24_REFERENCE**: Referencia de la transacción en T24 (para ReversarTransaccionID)
- **REFERENCE_CB**: Referencia del Core Banking

## Sistemas/Servicios OSB Involucrados

### Proxy Services Principales
1. **MiddlewareCaja/ProxyServices/ReversarTransaccion.proxy**
   - Endpoint: `/MiddlewareCaja/ReversarTransaccion`
   - Versión legacy para caja

2. **Middleware/v2/ProxyServices/ReversarTransaccion.proxy**
   - Endpoint: `/Middleware/OperationsAndExecution/CustomerDeposits/ReversarTransaccion_v2`
   - Versión v2 con regionalización

3. **Middleware/v2/ProxyServices/ReversarTransaccionID.proxy**
   - Endpoint: `/Middleware/SalesAndServices/BankingPartner/reversarTransaccionID`
   - Versión para reversión por ID

### Business Services
- **ReversaTransaccion**: Servicios de reversión T24
- **ReversaTransaccion2**: Servicios adicionales de reversión
- **svcReversarTransaccionCB**: Servicios Core Banking
- **reversionRecaudoAbanks_v2_db**: Reversión de recaudos Abanks

### Tipos de Transacciones Soportadas
- **CHEQUE_PAYMENT**: Pago de cheques
- **CREDIT_CARD_PAYMENT**: Pago de tarjetas de crédito
- **CREDIT_CARD_TFS**: Pago TC con TFS
- **REF_COLLECTION**: Cobranza de referencia
- **PROPTAX_COLLECTION**: Cobranza de impuestos
- **ONLINE_COLLECTION**: Cobranza en línea
- **LOCAL_COLLECTION**: Cobranza local
- **ABANKS_COLLECTION**: Cobranza Abanks
- **LOAN_PAYMENT**: Pago de préstamos
- **PAGO_TC**: Pago tarjeta de crédito (ID)
- **PAGO_EEH**: Pago EEH (ID)

## Riesgos/Limitaciones Conocidas

### Riesgos Operacionales
1. **Validación de Estado**: Las transacciones solo pueden revertirse si están en estado correcto
2. **Dependencia T24**: Requiere conectividad con T24 para completar la reversión
3. **Autorización Dual**: Algunas reversiones requieren autorización adicional
4. **Integridad Transaccional**: Falla en cualquier paso puede dejar la transacción en estado inconsistente

### Limitaciones Técnicas
1. **Regionalización**: Principalmente implementado para HN01 (Honduras)
2. **Tipos de Transacción**: No todos los tipos de transacción están soportados en todas las versiones
3. **Timeouts**: Dependiente de timeouts de servicios externos (T24, Core Banking)
4. **Rollback**: Limitaciones en rollback automático en caso de fallas parciales

### Limitaciones de Negocio
1. **Ventana de Tiempo**: Algunas transacciones tienen ventanas de tiempo limitadas para reversión
2. **Montos**: Pueden existir límites de monto para reversiones automáticas
3. **Frecuencia**: Restricciones en la frecuencia de reversiones por cliente/cuenta

## Métricas o SLAs

### Métricas de Rendimiento
- **Tiempo de Respuesta**: < 30 segundos para reversiones simples
- **Disponibilidad**: 99.5% durante horario bancario
- **Throughput**: Hasta 100 reversiones concurrentes

### SLAs de Negocio
- **Procesamiento**: Reversiones deben completarse dentro de 2 minutos
- **Notificación**: Confirmación inmediata al usuario
- **Auditoría**: Registro completo de todas las reversiones para auditoría

### Monitoreo
- **Logging**: Nivel debug habilitado en todos los proxies
- **Alertas**: SLA alerting configurado en nivel normal
- **Métricas**: Pipeline monitoring a nivel de acción
- **Agregación**: Intervalos de 10-360 minutos según el proxy

## Consideraciones de Migración

### Impacto en Sistemas
- **Alta Criticidad**: Funcionalidad crítica para operaciones bancarias
- **Dependencias Múltiples**: Integración con T24, Core Banking, y sistemas de recaudo
- **Datos Sensibles**: Manejo de información financiera crítica

### Recomendaciones
1. **Pruebas Exhaustivas**: Validar todos los tipos de transacción en ambiente de pruebas
2. **Rollback Plan**: Mantener versión legacy disponible durante migración
3. **Monitoreo Intensivo**: Supervisión 24/7 durante las primeras semanas post-migración
4. **Capacitación**: Entrenar al personal de operaciones en nuevos procedimientos