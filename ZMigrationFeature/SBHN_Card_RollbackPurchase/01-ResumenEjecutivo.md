# Resumen Ejecutivo - SBHN_Card_RollbackPurchase

## Índice de Documentación

1. [Resumen Ejecutivo](01-ResumenEjecutivo.md)
2. [Comparativa entre Regiones](02-ComparativaRegiones.md)
3. [Ejemplos y Mapeos - HN01](03-EjemplosYMapeos-HN01.md)
4. [Ejemplos y Mapeos - GT01](03-EjemplosYMapeos-GT01.md)
5. [Diagrama de Secuencia - HN01](04-Secuencia-HN01.mmd)
6. [Diagrama de Secuencia - GT01](04-Secuencia-GT01.mmd)
7. [Diagrama de Flujo Multiregión](05-FlujoMultiregión.mmd)
8. [Listado de Ficheros](06-ListadoFicheros.md)
9. [Mapeo de Errores](07-MapeoErrores.md)

---

## 1. Propósito de la Funcionalidad

**SBHN_Card_RollbackPurchase** es un servicio OSB que permite realizar la **reversión de compras con tarjeta de crédito** previamente procesadas. El servicio consulta el estado de un ticket de transacción y, si cumple las condiciones necesarias, ejecuta la reversión en el sistema Vision+ (procesador de tarjetas) y actualiza el estado del ticket en la base de datos.

### Funcionalidad Principal
- Consultar el estado de un ticket de transacción de compra con tarjeta de crédito
- Validar que la transacción puede ser reversada
- Ejecutar la reversión en Vision+ mediante el servicio OnlineTransactions
- Actualizar el estado del ticket a "Reversado" (R) en la base de datos

---

## 2. Entradas y Salidas Principales

### Entrada (Request)

**Elemento raíz:** `getStatusTicket`

| Campo | Tipo | Descripción | Obligatorio |
|-------|------|-------------|-------------|
| GeneralInfo | ComplexType | Información general de la transacción (GlobalId, SourceBank, DestinationBank, ApplicationId, Language) | Sí |
| Ticket | string | Identificador único del ticket de la transacción a reversar | Sí |
| TransactionType | string | Tipo de transacción | Sí |

### Salida (Response)

**Elemento raíz:** `getStatusTicketResponse`

| Campo | Tipo | Descripción |
|-------|------|-------------|
| StatusInfo | ComplexType | Estado de la operación (Status, ValueDate, DateTime, GlobalId) |
| ErrorInfo | ComplexType | Información de errores si aplica (Code, Error, Description, Details) |
| Status | string | Estado del ticket |
| OriginalAgency | decimal | Agencia origen |
| MerchantNumber | string | Número de comercio |
| CreditCard | string | Número de tarjeta de crédito |
| OperationType | string | Tipo de operación |
| BalanceCurrency | decimal | Moneda del saldo |
| Organizations | decimal | Organización |
| TransactionCurrency | string | Moneda de la transacción |
| ExchangeRate | decimal | Tasa de cambio |
| TransactionType | decimal | Tipo de transacción |
| User | string | Usuario |
| MovementSequence | string | Secuencia del movimiento |
| OriginalSequence | string | Secuencia original |
| PaymentAmount | decimal | Monto del pago |
| CheckValue | decimal | Valor del cheque |
| DocumentNumber | decimal | Número de documento |
| CardExpirationDate | string | Fecha de expiración de la tarjeta |
| CheckType | decimal | Tipo de cheque |
| OriginalBank | string | Banco origen |
| DestinationBank | string | Banco destino |
| Description | string | Descripción |
| Channel | string | Canal |
| AutorizationNumber | string | Número de autorización |
| Applied | string | Aplicado |
| AppliedOnLine | string | Aplicado en línea |

---

## 3. Sistemas/Servicios OSB Involucrados

### Proxy Services (Puntos de Entrada)
1. **RollbackPurchaseRestPS** - Endpoint REST
   - URI: `/honduras/card/rest/rollbackPurchase/v1`
   - Protocolo: HTTPS
   - Política de seguridad: `oracle/http_basic_auth_over_ssl_service_policy`

2. **RollbackPurchaseSoapPS** - Endpoint SOAP
   - URI: `/honduras/card/soap/rollbackPurchase/v1`
   - Protocolo: HTTPS
   - Política de seguridad: `oracle/http_basic_auth_over_ssl_service_policy`

### Pipeline
- **RollbackPurchasePP** - Pipeline principal que orquesta la lógica de negocio

### Business Services (Servicios Backend)

#### 1. DBGetStatusTicketAdapter
- **Tipo:** Database Adapter (JCA)
- **Conexión:** `jca://eis/DB/ConnectionPagosWSTC`
- **Base de Datos:** PAGOSWSTC
- **Esquema:** PAGOSWSTC
- **Package:** OSB_K_RECAUDO_BROKER_HN
- **Stored Procedure:** OSB_CONS_BROKER_RECAUDO_TICKET
- **Función:** Consultar el estado y detalles de un ticket de transacción
- **Retry:** 4 intentos con backoff de 2 segundos, intervalo máximo 120 segundos

#### 2. onlineTransactions_v4
- **Tipo:** SOAP Web Service
- **Endpoint:** `http://172.28.1.145:7802/OTWS/v4`
- **Sistema:** Vision+ (Procesador de Tarjetas)
- **Operación:** OnlineUpdateCard
- **Función:** Ejecutar la reversión de la transacción en Vision+
- **Timeout:** 70 segundos
- **Connection Timeout:** 65 segundos

#### 3. DBActTicketAdapter
- **Tipo:** Database Adapter (JCA)
- **Conexión:** `jca://eis/DB/ConnectionPagosWSTC`
- **Base de Datos:** PAGOSWSTC
- **Esquema:** PAGOSWSTC
- **Package:** OSB_K_RECAUDO_BROKER_HN
- **Stored Procedure:** OSB_ACT_BROKER_RECAUDO_TICKET
- **Función:** Actualizar el estado del ticket a "Reversado" (R)
- **Retry:** 4 intentos con backoff de 2 segundos, intervalo máximo 120 segundos

### Servicios Comunes (SBHN_Card_Commons)

#### 4. GetCustomErrorByStackTraceRegionalRestBS
- **Función:** Mapeo de errores técnicos a errores de negocio
- **Operación:** process

#### 5. LoggingRegionalRestBS
- **Función:** Registro de logs de entrada/salida
- **Operación:** SaveLogInFileSystem

---

## 4. Riesgos/Limitaciones Conocidas

### Riesgos Identificados

1. **Dependencia de Vision+**
   - El servicio depende completamente de la disponibilidad de Vision+ (172.28.1.145:7802)
   - Si Vision+ no está disponible, no se puede completar la reversión
   - Timeout configurado en 70 segundos

2. **Transacciones No Reversables**
   - Si el ticket no existe o ya fue reversado, el servicio retorna error
   - No hay validación de tiempo límite para reversiones (podría intentar reversar transacciones muy antiguas)

3. **Consistencia de Datos**
   - Si la reversión en Vision+ es exitosa pero falla la actualización del ticket en BD, puede haber inconsistencia
   - No se implementa patrón de compensación (saga)

4. **Seguridad**
   - El número de tarjeta se transmite en las transformaciones
   - Se requiere autenticación básica sobre SSL

### Limitaciones Técnicas

1. **Retry Limitado**
   - Solo 4 reintentos en adaptadores de BD
   - No hay retry en el servicio Vision+

2. **Logging**
   - Los logs pueden contener información sensible (números de tarjeta)
   - Variable `security` controla si se loguea el request completo

3. **Validaciones**
   - No valida el monto de la reversión
   - No valida la fecha de la transacción original
   - Depende completamente de la validación en Vision+

4. **Concurrencia**
   - No hay control de concurrencia explícito
   - Podría haber problemas si se intenta reversar el mismo ticket simultáneamente

---

## 5. Métricas o SLAs

### Timeouts Configurados

| Componente | Timeout | Descripción |
|------------|---------|-------------|
| Vision+ (onlineTransactions_v4) | 70 segundos | Timeout de respuesta |
| Vision+ Connection | 65 segundos | Timeout de conexión |
| DB Adapters Retry Interval | 1-120 segundos | Intervalo de reintentos con backoff |
| DB Adapters Max Retries | 4 intentos | Número máximo de reintentos |

### Políticas de Ejecución

| Política | Valor | Componente |
|----------|-------|------------|
| Dispatch Policy | SBCardManager | Todos los servicios |
| Load Balancing | round-robin | Business Services |
| Retry Application Errors | true | Business Services |

### SLAs Esperados (No Documentados en Código)

Basado en los timeouts configurados:
- **Tiempo de respuesta esperado:** < 5 segundos en condiciones normales
- **Tiempo máximo de respuesta:** ~70 segundos (timeout de Vision+)
- **Disponibilidad esperada:** Depende de Vision+ y Base de Datos

---

## 6. Regiones Detectadas

### HN01 - Honduras
- **Carpeta:** `ficohsacore-hncard-488b7ad93302/SBHN_Card/SBHN_Card_RollbackPurchase`
- **Prefijo:** SBHN_Card
- **Base de Datos:** PAGOSWSTC (Honduras)
- **Endpoint Vision+:** http://172.28.1.145:7802/OTWS/v4
- **Estado:** Implementado y desplegado (JAR en PG-17081)

### GT01 - Guatemala
- **Carpeta:** `ficohsacore-gtcard-16dd1ac59182/SBGT_Card/SBGT_Card_RollbackPurchase`
- **Prefijo:** SBGT_Card
- **Base de Datos:** PAGOSWSTC (Guatemala - asumido)
- **Endpoint Vision+:** Similar a HN (requiere verificación)
- **Estado:** Implementado

### Diferencias Principales entre Regiones
- Nombres de carpetas y prefijos (SBHN vs SBGT)
- Conexiones a bases de datos regionales
- Posibles diferencias en endpoints de Vision+
- Esquemas y packages de BD pueden variar

---

## 7. Flujo de Negocio Resumido

```
1. Cliente → OSB Proxy (REST/SOAP)
   ↓
2. OSB → Validación de entrada y logging
   ↓
3. OSB → DBGetStatusTicketAdapter (Consultar ticket)
   ↓
4. Validación: ¿Ticket existe y puede reversarse?
   ↓ (Sí)
5. OSB → onlineTransactions_v4 (Vision+) - Reversar en procesador
   ↓
6. Validación: ¿Reversión aprobada? (ActionDescription = 'APPROVED')
   ↓ (Sí)
7. OSB → DBActTicketAdapter (Actualizar estado a 'R')
   ↓
8. OSB → Response exitoso al cliente
```

### Manejo de Errores
- Si el ticket no existe o ya fue reversado → Error
- Si Vision+ rechaza la reversión → Error (no se actualiza BD)
- Si falla actualización de BD → Error (pero reversión en Vision+ ya ejecutada)
- Todos los errores se mapean mediante GetCustomErrorByStackTraceRegionalRestBS

---

## 8. Consideraciones para Migración

### Puntos Críticos
1. **Migrar conexión a Vision+** - Verificar endpoint y credenciales
2. **Migrar conexión a BD PAGOSWSTC** - Verificar esquema y stored procedures
3. **Políticas de seguridad** - Migrar `oracle/http_basic_auth_over_ssl_service_policy`
4. **Dispatch Policy SBCardManager** - Verificar configuración en nuevo entorno
5. **Servicio de logging** - Migrar LoggingRegionalRestBS
6. **Servicio de errores** - Migrar GetCustomErrorByStackTraceRegionalRestBS

### Dependencias Externas
- Vision+ (Procesador de Tarjetas)
- Base de Datos PAGOSWSTC
- Servicios comunes SBHN_Card_Commons

### Datos de Configuración
- Endpoints de servicios externos
- Cadenas de conexión a BD
- Políticas de seguridad
- Timeouts y retries
