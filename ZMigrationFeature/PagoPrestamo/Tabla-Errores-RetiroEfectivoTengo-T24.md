# Tabla de Errores - Operación RetiroEfectivoTengo de T24

## Análisis de la Operación RetiroEfectivoTengo

### Información General
- **Operación:** RetiroEfectivoTengo
- **Sistema:** T24 (Temenos)
- **Protocolo:** SOAP Web Services
- **Tipo de Transacción:** FUNDSTRANSFERRETAILINTSALEWS
- **Endpoint:** svcRegistraTransaccionTengo

### Estructura de Response
La operación RetiroEfectivoTengo retorna un objeto `Status` con los siguientes campos:
- `successIndicator`: Enum con valores (Success, TWSError, T24Error, T24Override, T24Offline)
- `messages`: Array de mensajes descriptivos
- `transactionId`: ID de la transacción
- `application`: Aplicación que procesa

## Tabla de Mapeo de Errores a Códigos HTTP

### Errores del Indicador de Éxito (successIndicator)

| Código T24 | Descripción Error | Código HTTP | Mensaje HTTP | Categoría | Acción Recomendada |
|------------|-------------------|-------------|--------------|-----------|-------------------|
| **Success** | Transacción exitosa | **200** | OK | Éxito | Continuar |
| **TWSError** | Error en T24 Web Services | **502** | Bad Gateway | Sistema | Verificar conectividad T24 |
| **T24Error** | Error de aplicación T24 | **422** | Unprocessable Entity | Aplicación | Revisar datos transacción |
| **T24Override** | Requiere autorización adicional | **409** | Conflict | Autorización | Obtener override |
| **T24Offline** | Sistema T24 no disponible | **503** | Service Unavailable | Disponibilidad | Reintentar más tarde |

### Errores Específicos de Retiro en Efectivo T24

| Código Error T24 | Descripción Error | Código HTTP | Mensaje HTTP | Categoría | Acción Recomendada |
|-------------------|-------------------|-------------|--------------|-----------|-------------------|
| **FT-INVALID.ACCOUNT** | Cuenta de débito inválida | **400** | Bad Request | Validación | Verificar número cuenta |
| **FT-ACCOUNT.CLOSED** | Cuenta cerrada | **422** | Unprocessable Entity | Negocio | Usar cuenta activa |
| **FT-INSUFFICIENT.FUNDS** | Fondos insuficientes | **422** | Unprocessable Entity | Negocio | Verificar saldo |
| **FT-AMOUNT.INVALID** | Monto inválido | **400** | Bad Request | Validación | Verificar monto |
| **FT-CURRENCY.MISMATCH** | Monedas no coinciden | **422** | Unprocessable Entity | Negocio | Verificar moneda |
| **FT-DAILY.LIMIT.EXCEEDED** | Límite diario excedido | **422** | Unprocessable Entity | Límite | Reducir monto o esperar |
| **FT-TRANSACTION.LIMIT** | Límite por transacción excedido | **422** | Unprocessable Entity | Límite | Reducir monto |
| **FT-ACCOUNT.BLOCKED** | Cuenta bloqueada | **403** | Forbidden | Autorización | Contactar banco |
| **FT-INVALID.CURRENCY** | Moneda no válida | **400** | Bad Request | Validación | Usar moneda válida |
| **FT-CUTOFF.TIME** | Hora de corte pasada | **422** | Unprocessable Entity | Negocio | Procesar día siguiente |
| **FT-HOLIDAY.PROCESSING** | Procesamiento en feriado | **422** | Unprocessable Entity | Negocio | Procesar día hábil |
| **FT-DUPLICATE.REFERENCE** | Referencia duplicada | **409** | Conflict | Conflicto | Usar referencia única |
| **FT-INVALID.REFERENCE** | Referencia inválida | **400** | Bad Request | Validación | Verificar referencia |
| **FT-ACCOUNT.RESTRICTED** | Cuenta con restricciones | **403** | Forbidden | Autorización | Verificar restricciones |
| **FT-CUSTOMER.BLOCKED** | Cliente bloqueado | **403** | Forbidden | Autorización | Contactar banco |
| **FT-INVALID.BRANCH** | Sucursal inválida | **400** | Bad Request | Validación | Verificar sucursal |
| **FT-BRANCH.CLOSED** | Sucursal cerrada | **422** | Unprocessable Entity | Negocio | Usar sucursal activa |
| **FT-SYSTEM.MAINTENANCE** | Sistema en mantenimiento | **503** | Service Unavailable | Sistema | Reintentar más tarde |
| **FT-CONNECTION.ERROR** | Error de conexión | **502** | Bad Gateway | Sistema | Verificar conectividad |
| **FT-TIMEOUT** | Timeout de transacción | **408** | Request Timeout | Tiempo | Reintentar |
| **FT-VALIDATION.ERROR** | Error de validación | **400** | Bad Request | Validación | Corregir datos |
| **FT-AUTHORIZATION.REQUIRED** | Requiere autorización | **409** | Conflict | Autorización | Obtener autorización |
| **FT-INVALID.USER** | Usuario inválido | **401** | Unauthorized | Autorización | Verificar credenciales |
| **FT-USER.NOT.AUTHORIZED** | Usuario no autorizado | **403** | Forbidden | Autorización | Verificar permisos |
| **FT-INVALID.TRANSACTION.TYPE** | Tipo transacción inválido | **400** | Bad Request | Validación | Verificar tipo |
| **FT-TRANSACTION.NOT.ALLOWED** | Transacción no permitida | **403** | Forbidden | Autorización | Verificar permisos |

### Errores de Validación de Campos TENGO

| Campo | Código Error | Descripción | Código HTTP | Mensaje HTTP | Acción Recomendada |
|-------|--------------|-------------|-------------|--------------|-------------------|
| **DebitAccount** | INVALID.DEBIT.ACCOUNT | Cuenta débito inválida | **400** | Bad Request | Verificar formato cuenta |
| **DebitAmount** | INVALID.AMOUNT | Monto inválido | **400** | Bad Request | Verificar formato monto |
| **DebitCurrency** | INVALID.CURRENCY | Moneda inválida | **400** | Bad Request | Usar moneda válida |
| **CreditAccount** | INVALID.CREDIT.ACCOUNT | Cuenta crédito inválida | **400** | Bad Request | Verificar cuenta TENGO |
| **TransactionType** | INVALID.TXN.TYPE | Tipo transacción inválido | **400** | Bad Request | Verificar tipo |
| **LRREFTENGO** | INVALID.TENGO.REF | Referencia TENGO inválida | **400** | Bad Request | Verificar referencia |

### Errores de Negocio Específicos TENGO

| Código Error | Descripción | Código HTTP | Mensaje HTTP | Categoría | Acción Recomendada |
|--------------|-------------|-------------|--------------|-----------|-------------------|
| **TENGO-001** | Agente TENGO no encontrado | **404** | Not Found | Recurso | Verificar agente |
| **TENGO-002** | Agente TENGO inactivo | **422** | Unprocessable Entity | Negocio | Usar agente activo |
| **TENGO-003** | Límite agente excedido | **422** | Unprocessable Entity | Límite | Contactar agente |
| **TENGO-004** | Saldo agente insuficiente | **422** | Unprocessable Entity | Negocio | Verificar saldo agente |
| **TENGO-005** | Horario agente no válido | **422** | Unprocessable Entity | Negocio | Verificar horarios |
| **TENGO-006** | Ubicación no autorizada | **403** | Forbidden | Autorización | Verificar ubicación |
| **TENGO-007** | Documento cliente requerido | **400** | Bad Request | Validación | Proporcionar documento |
| **TENGO-008** | Cliente no autorizado | **403** | Forbidden | Autorización | Verificar cliente |
| **TENGO-009** | Monto mínimo no alcanzado | **422** | Unprocessable Entity | Negocio | Aumentar monto |
| **TENGO-010** | Monto máximo excedido | **422** | Unprocessable Entity | Negocio | Reducir monto |
| **TENGO-011** | Transacción ya procesada | **409** | Conflict | Conflicto | Verificar estado |
| **TENGO-012** | Red TENGO no disponible | **503** | Service Unavailable | Sistema | Reintentar más tarde |
| **TENGO-013** | Error comunicación agente | **502** | Bad Gateway | Sistema | Verificar conectividad |
| **TENGO-014** | Código autorización inválido | **400** | Bad Request | Validación | Verificar código |
| **TENGO-015** | Transacción expirada | **410** | Gone | Tiempo | Generar nueva transacción |

### Configuración de Retry por Tipo de Error

#### Errores que Permiten Retry (Temporales)

| Código HTTP | Descripción | Retry Count | Retry Interval | Razón |
|-------------|-------------|-------------|----------------|-------|
| **408** | Request Timeout | 3 | 30s | Error temporal |
| **502** | Bad Gateway | 3 | 45s | Error temporal |
| **503** | Service Unavailable | 5 | 60s | Error temporal |

#### Errores que NO Permiten Retry (Permanentes)

| Código HTTP | Descripción | Acción |
|-------------|-------------|--------|
| **400** | Bad Request | Corregir request |
| **401** | Unauthorized | Verificar credenciales |
| **403** | Forbidden | Verificar permisos |
| **404** | Not Found | Verificar recurso |
| **409** | Conflict | Resolver conflicto |
| **410** | Gone | Recurso expirado |
| **422** | Unprocessable Entity | Corregir datos negocio |

### Mensajes de Error Personalizados

#### Español

| Código Error | Mensaje Español |
|--------------|-----------------|
| **TWSError** | ERROR EN SERVICIOS WEB T24. INTENTE MAS TARDE |
| **T24Error** | ERROR EN SISTEMA T24. VERIFIQUE LOS DATOS |
| **T24Override** | TRANSACCION REQUIERE AUTORIZACION ADICIONAL |
| **T24Offline** | SISTEMA T24 NO DISPONIBLE. INTENTE MAS TARDE |
| **TENGO-001** | AGENTE TENGO NO ENCONTRADO |
| **TENGO-002** | AGENTE TENGO NO ACTIVO |
| **TENGO-012** | RED TENGO NO DISPONIBLE. INTENTE MAS TARDE |

#### Inglés

| Código Error | Mensaje Inglés |
|--------------|----------------|
| **TWSError** | T24 WEB SERVICES ERROR. TRY LATER |
| **T24Error** | T24 SYSTEM ERROR. CHECK DATA |
| **T24Override** | TRANSACTION REQUIRES ADDITIONAL AUTHORIZATION |
| **T24Offline** | T24 SYSTEM UNAVAILABLE. TRY LATER |
| **TENGO-001** | TENGO AGENT NOT FOUND |
| **TENGO-002** | TENGO AGENT NOT ACTIVE |
| **TENGO-012** | TENGO NETWORK UNAVAILABLE. TRY LATER |

### Implementación de Monitoreo

#### Alertas Críticas

| Error | Umbral | Acción |
|-------|--------|--------|
| T24Offline > 5% | Crítico | Verificar T24 |
| TWSError > 10% | Advertencia | Revisar conectividad |
| TENGO-012 > 3% | Crítico | Verificar red TENGO |

#### Métricas de Calidad

| Métrica | Objetivo |
|---------|----------|
| Tasa de éxito | > 95% |
| Tiempo respuesta | < 8s |
| Disponibilidad T24 | > 99% |
| Disponibilidad TENGO | > 98% |

## Resumen de Implementación

1. **Total de Códigos de Error Identificados:** 40+ específicos
2. **Categorías de Error:** 8 (Validación, Autorización, Negocio, Sistema, Red, Recurso, Tiempo, Conflicto, Límite)
3. **Sistema:** T24 (Temenos)
4. **Operación:** RetiroEfectivoTengo
5. **Códigos HTTP Utilizados:** 11 diferentes
6. **Errores con Retry:** 3 tipos
7. **Errores sin Retry:** 7 tipos

Esta tabla proporciona una homologación completa de todos los posibles errores que puede generar la operación RetiroEfectivoTengo de T24 a códigos HTTP estándar, incluyendo errores específicos de la red TENGO y validaciones de negocio particulares de retiros en efectivo.