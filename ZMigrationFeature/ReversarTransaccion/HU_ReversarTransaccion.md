# Historia de Usuario: ReversarTransaccion

> **Como** Equipo de Integración  
> **Quiero** revertir transacciones bancarias de diferentes tipos (pagos de cheques, tarjetas de crédito, recaudos, préstamos y transacciones FT/TT) en el sistema T24  
> **Para** permitir la corrección de operaciones erróneas y mantener la integridad de las transacciones bancarias

## Criterios de Aceptación

### 1. Campos de Entrada del Servicio

| Campo | Descripción | Requerido | Tipo/Formato |
|-------|-------------|-----------|--------------|
| **reversarTransaccion** | Elemento raíz del request | **Sí** | Complex Type |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **TRANSACTION_ID** | ID de la transacción a revertir | **Sí** | string (minLength=1) |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **TRANSACTION_TYPE** | Tipo de transacción a revertir | **Sí** | string (minLength=1) |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ AUTHORIZER_USERNAME | Usuario autorizador | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;└─ AUTHORIZER_PASSWORD | Contraseña del autorizador | No | string |
| **AutenticacionRequestHeader** | Header de autenticación SOAP | **Sí** | Complex Type |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **UserName** | Usuario para autenticación | **Sí** | string |
| &nbsp;&nbsp;&nbsp;&nbsp;└─ **Password** | Contraseña para autenticación | **Sí** | string |

> **Validaciones:**
> - TRANSACTION_ID debe tener al menos 1 carácter
> - TRANSACTION_TYPE debe tener al menos 1 carácter
> - TRANSACTION_TYPE debe ser uno de: CHEQUE_PAYMENT, CREDIT_CARD_PAYMENT, REF_COLLECTION, PROPTAX_COLLECTION, ONLINE_COLLECTION, LOCAL_COLLECTION, ABANKS_COLLECTION, LOAN_PAYMENT, o vacío para FT/TT genéricos
> - Para transacciones FT/TT genéricas: TRANSACTION_ID debe comenzar con "FT" o "TT"
> - Se valida la estructura del mensaje contra el esquema XSD ReversarTransaccion.xsd

### 2. Campos de Salida del Servicio

| Campo | Descripción | Requerido | Tipo |
|-------|-------------|-----------|------|
| **reversarTransaccionResponse** | Respuesta del servicio (elemento vacío) | **Sí** | Empty Element |
| **ResponseHeader** | Header de respuesta SOAP | **Sí** | Complex Type |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ transactionId | ID de la transacción procesada | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ messageId | ID del mensaje | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ successIndicator | Indicador de éxito (SUCCESS/ERROR) | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ application | Aplicación que procesó | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ messages | Mensajes de respuesta (puede repetirse) | No | string (maxOccurs=unbounded) |
| &nbsp;&nbsp;&nbsp;&nbsp;└─ valueDate | Fecha valor de la transacción | No | string |

> **Nota:** Todos los campos de salida están validados contra el esquema XSD Autenticacion.xsd. La información de resultado se retorna en el ResponseHeader, el body contiene un elemento vacío.

## Tareas Técnicas

### 1. Códigos de Error

#### 1.1. Códigos de error del Servicio

| Código Error | Descripción | Tipo Error |
|--------------|-------------|------------|
| ERROR | UNSUPPORTED TRANSACTION_TYPE | Negocio |
| ERROR | TRANSACTION_ID MUST TO BEGIN WITH "FT" OR "TT" | Negocio |
| ERROR | REQUIRED FIELDS NOT SUPPLIED | Negocio |
| ERROR | Mensaje de validación de consulta de transacción | Técnico |
| ERROR | Error de reversión en T24 | Técnico |
| ERROR | Error de actualización BD Abanks | Técnico |
| ERROR | Error de eliminación de transacción (compensación) | Técnico |
| ERROR | Concatenación de errorCode y reason del fault | Técnico |

> **Nota:** Los errores se retornan en el ResponseHeader con successIndicator="ERROR" y el mensaje descriptivo en el campo messages.

### 2. Configuración de Timeout

- **Timeout Business Services:** Valores por defecto configurados en cada BS
- **Timeout operación del OSB:** No especificado (usar default)
- **Recomendación:** Configurar 60-120 segundos en Business Services

### 3. Datos de Prueba

> **Nota:** Los siguientes son datos de ejemplo no reales, utilizados únicamente para propósitos de testing y documentación.

- **TRANSACTION_ID:** FT2401123456 (para FT), TT2401123456 (para TT), 12345678 (para otros tipos)
- **TRANSACTION_TYPE:** CHEQUE_PAYMENT, CREDIT_CARD_PAYMENT, REF_COLLECTION, ABANKS_COLLECTION, LOAN_PAYMENT
- **UserName:** testuser
- **Password:** testpass123
- **AUTHORIZER_USERNAME:** authuser
- **AUTHORIZER_PASSWORD:** authpass123

### 4. Datos de Contacto

**Contacto responsable OSB:**
- **David Ruiz** - david.ruiz@ficohsa.com
- **Wilmer Fernandez** - wilmer.fernandez@ficohsa.com  
- **Francia Avila** - francia.avila@ficohsa.com
- **Diego Gomez** - diego.gomez@ficohsa.com

### 5. Lógica Importante

**Flujo Principal del Servicio:**
1. **Validación XSD:** Se valida la estructura del mensaje contra el esquema ReversarTransaccion.xsd
2. **Extracción de Datos:** Se extrae TRANSACTION_ID, TRANSACTION_TYPE y se genera UUID para trazabilidad
3. **Enrutamiento Condicional por Tipo de Transacción:**
   - **CHEQUE_PAYMENT:** Llama a ReversiondePagodeCheques del BS ReversaTransaccion
   - **CREDIT_CARD_PAYMENT:** Ejecuta ReversionpagoTC y si es exitosa, autoriza con AutorizareversapagooretiroTC
   - **REF_COLLECTION / ABANKS_COLLECTION:** 
     - Consulta la transacción (FT o TT) para obtener método de pago, valueDate, inputter y branchCode
     - Ejecuta reversión según método de pago (CASH, DEB.TO.ACCT, FICO.CHEQUE, OB.CHEQUE, INTL.CHEQUE)
     - Para ABANKS_COLLECTION: si reversión exitosa, actualiza BD Abanks; si falla actualización, elimina transacción en T24 (compensación)
   - **PROPTAX_COLLECTION:** Similar a REF_COLLECTION pero usa servicios AMDC del BS ReversaTxnRecaudos
   - **ONLINE_COLLECTION / LOCAL_COLLECTION:** Similar a REF_COLLECTION pero usa servicios de recaudo local del BS ReversaTxnRecaudos
   - **LOAN_PAYMENT (TFS):** Ejecuta Reversiondepositocombinado y si es exitosa, autoriza con AuthReversionDepositosCombinados
   - **FT/TT Genéricos:** Ejecuta ReversiondetransaccionFT/TT y si es exitosa, autoriza con AutorizacionreversionFT/TT
4. **Transformación de Request:** Se aplica XQuery específico según tipo de transacción y método de pago (30+ archivos XQuery)
5. **Transformación de Response:** Se construye ResponseHeader usando XQuery específico (13 archivos XQuery)
6. **Manejo de Errores:** Error handler global captura excepciones y construye ResponseHeader con ERROR

**Servicios Dependientes Analizados:**
- **reversionRecaudoAbanks_v2_db:** Actualización de base de datos externa de Abanks (conexión JCA)
- **ReversaTransaccion:** Reversiones y autorizaciones principales (cheques, TC, FT, TT)
- **ReversaTxnRecaudos:** Reversiones de recaudos de impuestos y locales
- **ConsultasTransacciones:** Consultas previas de transacciones FT/TT
- **ReversaTransaccion2:** Reversiones de depósitos combinados/préstamos
- **PagoRecaudos:** Eliminaciones de transacciones (compensación)

**Mecanismo de Compensación:** Para ABANKS_COLLECTION, si la actualización de BD externa falla después de una reversión exitosa en T24, el servicio ejecuta una eliminación de la transacción en T24 para mantener consistencia.

**Seguridad:** Las credenciales se pasan en el header SOAP (AutenticacionRequestHeader). No se almacenan en logs.

### 6. Datos Relevantes

- El servicio **no requiere** reintentos automáticos (riesgo de reversiones duplicadas)
- El servicio **no requiere** reversos (es el servicio de reversión en sí)
- Soporta 9 tipos de transacción diferentes con lógica específica para cada uno
- Soporta 5 métodos de pago para recaudos (efectivo, débito cuenta, cheques Fico/OB/Internacional)
- Implementa mecanismo de compensación para ABANKS_COLLECTION
- La autorización es un paso separado que solo se ejecuta si la reversión es exitosa
- Utiliza 30+ archivos XQuery para transformaciones (28 request, 13 response)
- Logging habilitado en nivel debug para auditoría completa
- Crítico para operaciones de caja - requiere monitoreo exhaustivo

### 7. Detalles Técnicos de Conexión

- **Conexión a T24 (ReversaTransaccion):** Por HTTP/SOAP - Reversiones y autorizaciones principales
- **Conexión a T24 (ReversaTxnRecaudos):** Por HTTP/SOAP - Reversiones de recaudos AMDC y locales
- **Conexión a T24 (ConsultasTransacciones):** Por HTTP/SOAP - Consultas de transacciones FT/TT
- **Conexión a T24 (ReversaTransaccion2):** Por HTTP/SOAP - Reversiones de depósitos combinados
- **Conexión a T24 (PagoRecaudos):** Por HTTP/SOAP - Eliminaciones para compensación
- **Conexión a BD Abanks:** Por JCA (jca://eis/DB/ConnectionWebServices) - Actualización de recaudos Abanks

### 8. Dependencias del Servicio

**Servicios Internos:**
- reversionRecaudoAbanks_v2_db - Actualización BD externa Abanks
- ReversaTransaccion - Reversiones principales
- ReversaTxnRecaudos - Reversiones de recaudos
- ConsultasTransacciones - Consultas previas
- ReversaTransaccion2 - Depósitos combinados
- PagoRecaudos - Compensaciones

**Servicios Externos:**
- T24 Core Banking System - Sistema principal de reversiones
- Base de Datos Abanks - BD externa para recaudos Abanks

## 9. Datos del Servicio

| Campo | Valor |
|-------|-------|
| **RUTA** | MiddlewareCaja\ProxyServices\ReversarTransaccion |
| **URI** | /MiddlewareCaja/ReversarTransaccion |
| **NUMERO_OPERACIONES** | 1 |
| **OPERACIONES** | reversarTransaccion |
| **CODIGO** | N/A |
| **GRUPO_ASIGNADO** | ReversarTransaccion |

## 10. Información del Inventario de Servicios

Servicios relacionados con ReversarTransaccion encontrados en el inventario (GRUPO_ASIGNADO = "ReversarTransaccion"):

| URI | NUMERO_OPERACIONES | OPERACIONES | CODIGO | GRUPO_ASIGNADO | RUTA |
|-----|-------------------|-------------|--------|-----------------|------|
| /Middleware/OperationsAndExecution/CustomerDeposits/ReversarTransaccion | 1 | reversarTransaccion | N/A | ReversarTransaccion | Middleware\OperationsAndExecution\CustomerDeposits\ReversarTransaccion |
| /Middleware/OperationsAndExecution/CustomerDeposits/ReversarTransaccion_v2 | 1 | reversarTransaccion | FICBCO0084 | ReversarTransaccion | Middleware\v2\ProxyServices\ReversarTransaccion |
| /MiddlewareCaja/ReversarTransaccion | 1 | reversarTransaccion | N/A | ReversarTransaccion | MiddlewareCaja\ProxyServices\ReversarTransaccion |
| /Middleware/SalesAndServices/BankingPartner/reversarTransaccionID | 1 | reversarTransaccionID | FICBCO0516$0259 | ReversarTransaccion | Middleware\v2\ProxyServices\ReversarTransaccionID |

## 11. Servicios Dependientes (Árbol Proxy-Biz)

Servicios que tienen como PROXY_PADRE "MiddlewareCaja\ProxyServices\ReversarTransaccion":

| PROXY_REFERENCIA | BIZ | URI |
|------------------|-----|-----|
| MiddlewareCaja\ProxyServices\ReversarTransaccion | \MiddlewareCaja\BussinessServices\reversionRecaudoAbanks_v2_db | [jca://eis/DB/ConnectionWebServices] |
| MiddlewareCaja\ProxyServices\ReversarTransaccion | \MiddlewareCaja\BussinessServices\ReversaTransaccion | [ENDPOINT_REVERSA_TRANSACCION] |
| MiddlewareCaja\ProxyServices\ReversarTransaccion | \MiddlewareCaja\BussinessServices\ConsultasTransacciones | [ENDPOINT_CONSULTAS_TRANSACCIONES] |
| MiddlewareCaja\ProxyServices\ReversarTransaccion | \MiddlewareCaja\BussinessServices\ReversaTxnRecaudos | [ENDPOINT_REVERSA_TXN_RECAUDOS] |
| MiddlewareCaja\ProxyServices\ReversarTransaccion | \MiddlewareCaja\BussinessServices\ReversaTransaccion2 | [ENDPOINT_REVERSA_TRANSACCION2] |
| MiddlewareCaja\ProxyServices\ReversarTransaccion | \MiddlewareCaja\BussinessServices\PagoRecaudos | [ENDPOINT_PAGO_RECAUDOS] |

## 12. Canales que utilizan la capacidad

**Canales:** INTERBANCABD, INTERFAZBD, NST, PAGOSWS, TENGO

**URIs:** /Middleware/OperationsAndExecution/CustomerDeposits/ReversarTransaccion, /Middleware/OperationsAndExecution/CustomerDeposits/ReversarTransaccion_v2, /Middleware/SalesAndServices/BankingPartner/reversarTransaccionID, /MiddlewareCaja/ReversarTransaccion

**Número de canales:** 5

---

## Historial de Cambios

| Fecha | Versión | Autor | Descripción |
|-------|---------|-------|-------------|
| 2025-11-30 | 1.0 | ARQ FICOHSA | Creación inicial |
