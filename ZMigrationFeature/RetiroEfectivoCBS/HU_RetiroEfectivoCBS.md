# Historia de Usuario: RetiroEfectivoCBS

> **Como** Equipo de Integración  
> **Quiero** Implementar el servicio de retiro de efectivo para corresponsales bancarios  
> **Para** Permitir a los clientes realizar retiros de efectivo a través de corresponsales bancarios (TENGO) con validación de saldo, cálculo de comisiones y registro de transacciones

## Criterios de Aceptación

### 1. Campos de Entrada del Servicio

| Campo | Descripción | Requerido | Tipo/Formato |
|-------|-------------|-----------|-----------------|
| **retiroEfectivo** | Elemento raíz del request | **Sí** | Complex Type |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ ACCOUNT_NUMBER | Número de cuenta del cliente | **Sí** | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ CURRENCY | Moneda de la transacción | **Sí** | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ AMOUNT | Monto del retiro | **Sí** | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ TOKEN_ID | Identificador del token de seguridad | **Sí** | string |
| &nbsp;&nbsp;&nbsp;&nbsp;└─ TRANSACTION_ID_CB | ID de transacción del corresponsal bancario | **Sí** | string |

> **Validaciones:**
> - Se valida la estructura del mensaje contra el esquema XSD retiroEfectivoCBTypes.xsd
> - Se aplica validación de servicio regional con serviceId "FICBCO0218"
> - Se valida que la moneda sea permitida para el corresponsal
> - Se valida saldo disponible en la cuenta (monto + comisión)
> - Se valida que la cuenta exista y esté activa

### 2. Campos de Salida del Servicio

| Campo | Descripción | Requerido | Tipo |
|-------|-------------|-----------|------|
| **retiroEfectivoResponse** | Respuesta del servicio de retiro efectivo | **Sí** | Complex Type |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ ACCOUNT_NUMBER | Número de cuenta procesada | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ AMOUNT | Monto del retiro procesado | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ CURRENCY | Moneda de la transacción | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ ACCOUNT_NAME | Nombre del titular de la cuenta | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ TOKEN_ID | Token de seguridad utilizado | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;└─ COMMISION_AMOUNT | Monto de la comisión cobrada | No | string |

> **Nota:** Todos los campos de salida están validados contra el esquema XSD retiroEfectivoCBTypes.xsd

## Tareas Técnicas

### 1. Códigos de Error

#### 1.1. Códigos de error del Proveedor

| Código Error | Descripción | Tipo Error |
|--------------|-------------|------------|
| MW-0001 | SERVICE QUOTA EXCEEDED - Cuota de servicio excedida | Técnico |
| R01 | Fondos Insuficientes | Negocio |
| R03 | Número de Cuenta Inexistente | Negocio |
| ERROR | Moneda inválida para transacción | Negocio |
| ERROR | Error obteniendo comisión | Técnico |
| ERROR | Error consultando cuenta | Técnico |
| ERROR | Error realizando transferencia | Técnico |
| ERROR | Error cobrando comisión | Técnico |
| ERROR | Error al reversar la transacción | Técnico |
| SUCCESS | Transacción exitosa | Negocio |

> **Nota:** El servicio implementa mapeo de errores a través del servicio MapeoErrores para estandarizar los códigos de respuesta

### 2. Configuración de Timeout

- **Timeout consultaCuentasBS:** 30 segundos
- **Timeout svcRegistraTransaccionTengo:** 60 segundos
- **Timeout transferenciasBS:** 45 segundos
- **Timeout operación del OSB:** 120 segundos

### 3. Datos de Prueba

> **Nota:** Los siguientes son datos de ejemplo no reales, utilizados únicamente para propósitos de testing y documentación.

- **ACCOUNT_NUMBER:** 1234567890
- **CURRENCY:** HNL
- **AMOUNT:** 500.00
- **TOKEN_ID:** TKN123456789
- **TRANSACTION_ID_CB:** CB20240101001

### 4. Datos de Contacto

**Contacto responsable OSB:**
- **David Ruiz** - david.ruiz@ficohsa.com
- **Wilmer Fernandez** - wilmer.fernandez@ficohsa.com  
- **Francia Avila** - francia.avila@ficohsa.com
- **Diego Gomez** - diego.gomez@ficohsa.com

### 5. Lógica Importante

**Pipeline: Validaciones (Request)**
1. **Validación XSD:** Valida estructura del mensaje contra retiroEfectivoCBTypes.xsd, elemento retiroEfectivo
2. **Registro Inicial:** Llama a registraEstadoTransaccion_db con:
   - Estado: "REGISTRADO"
   - Tipo transacción: '1'
   - Código canal: '1'
   - Extrae codigoCorresponsal de TRANSACTION_ID_CB
3. **Validación Regional:** Ejecuta ValidaServicioRegional_db con serviceId "FICBCO0218"
   - Estado previo: 'VALIDANDO_RUTA_REGIONAL'
   - Si falla: Estado 'VALIDACION_REGIONAL_FALLIDA', retorna error y termina
   - Si éxito: Estado 'VALIDACION_REGIONAL_EXITOSA', aplica valores por defecto de región
4. **Validación Corresponsal:** Consulta consultarCorresponsalB_db con:
   - Estado previo: 'OBTENIENDO_PARAMETRIA_CORRESPONSAL'
   - Tipo transacción: '4'
   - Extrae: sourceBank, codCorresponsal del header
   - Obtiene: cuentaDebito, monedaValida, tipoTransaccion, cuentaCredito
   - Si falla: Estado 'ERROR_OBTENIENDO_PARAMETRIZACION', retorna error y termina
5. **Validación Moneda:** Compara CURRENCY del request con monedaValida del corresponsal
   - Estado previo: 'VALIDANDO_MONEDA_TRANSACCION'
   - Si no coincide: Estado 'PARAMETRIA_OBTENIDA_CORRECTAMENTE', retorna "MONEDA INVALIDA PARA TRANSACCION" y termina
   - Si coincide: Estado 'ERROR_DE_MONEDA_INVALIDA' (continúa flujo)
6. **Registro Uso Servicio:** Llama a registrarUsoServicio_db con operación "1" (apertura)
   - Si statusUsoServicio != "0": Lanza error MW-0001 "SERVICE QUOTA EXCEEDED"

**Pipeline: Validaciones (Response)**
7. **Cierre Uso Servicio:** Llama a registrarUsoServicio_db con operación "2" (cierre)
8. **Mapeo Errores:** Si successIndicator != "SUCCESS", llama a MapeoErrores para estandarizar respuesta

**Branch: Regionalización**
- **HN01:** Ejecuta pipeline HN01_request/HN01_response (procesamiento completo)
- **Default:** Ejecuta PipelinePairNode1 (VACÍO - no hace procesamiento, solo pasa request/response sin modificar)

**Pipeline: HN01 (Request) - Solo para Honduras**
9. **Consulta Comisión:** Llama a consultaComisionesCB_db
   - Estado previo: 'OBTENIENDO_COMISION'
   - Parámetros: codigoTransaccion='4', usuarioTransaccion del header
   - Si falla: Estado 'ERROR_OBTENIENDO_COMISION', asigna successIndicator="ERROR", validateMessage con error
   - Si éxito: Estado 'COMISION_OBTENIDA_EXITOSAMENTE', guarda montocomision
10. **Consulta Saldo:** Llama a consultaCuentasBS operación Consultadesaldodecuenta
    - Estado previo: 'CONSULTANDO_CUENTA'
    - Si count=0: Estado 'ERROR_CONSULTANDO_CUENTA', successIndicator=error, validateMessage='R03-Número de Cuenta Inexistente'
    - Si count>0: Extrae disponible (AVAILBALANCE)
11. **Validación Fondos:** Calcula total = AMOUNT + montocomision, resta = disponible - total
    - Si resta < 0: Estado 'ERROR_SALDO_INSUFICIENTE', successIndicator="ERROR", validateMessage="R01-Fondos Insuficientes"
    - Si resta >= 0: Estado 'CUENTA_VALIDADA', continúa
12. **Transferencia Principal:** Llama a svcRegistraTransaccionTengo operación RetiroEfectivoTengo
    - Estado previo: 'REALIZANDO_TRANSFERENCIA'
    - Parámetros: tipoTrxT24, cuentaCreditoT24, HeaderCB
    - Guarda transactionId y estadoTransaccionT24
    - Asigna successIndicator y validateMessage del response
13. **Evaluación Transferencia:**
    - Si estadoTransaccionT24 != "SUCCESS": Estado 'ERROR_AL_REALIZAR_TRANSFERENCIA', termina
    - Si estadoTransaccionT24 = "SUCCESS": Estado 'TRANSACCION_EXITOSA', continúa
14. **Cobro Comisión (Condicional):** Si montocomision > 0:
    - Estado previo: 'REALIZANDO_COBRO_COMISION'
    - Asigna transactionIdrev (no usado posteriormente)
    - Llama a transferenciasBS operación Transfmodelbankentrecuentas
    - Parámetros: originalTransaction=transactionId, tipoTransaccionComision, cuentacomision
    - **Si falla cobro comisión:**
      - Estado: 'ERROR_COBRANDO_COMISION'
      - Asigna successIndicator y validateMessage del error
      - **Reversión:** Llama a ReversarTransaccion con transactionId original
        - Estado previo: 'REVERSANDO_TRANSACCION'
        - Si reversión falla: Estado 'ERROR_AL_REVERSAR_LA_TRANSACCION'
        - Si reversión éxito: Estado 'REVERSADA'
    - **Si éxito cobro comisión:** Estado 'TRANSACCION_EXITOSA'
15. **Actualización Estado Final:** Stage ActualizaEstadoTransaccionFin
    - Llama a actualizaEstadoTransaccion_db
    - Parámetros: FT=transactionId, tipoTransaccion='RETIRO', codigoOperacion=TRANSACTION_ID_CB, estadoTransaccion=estadotrxTengo, tipoActualizacion='TENGO', tipoConsulta=1

**Pipeline: HN01 (Response)**
16. **Construcción Respuesta:**
    - Construye header con retiroEfectivoHeaderOut: messages, transactionId, successIndicator
    - Si estadotrxTengo="TRANSACCION_EXITOSA":
      - Asigna tipoactualizacion='T24'
      - Construye body con retiroEfectivoOut: comision, consultadesaldodecuentaResponse, retiroEfectivo
    - Si estadotrxTengo != "TRANSACCION_EXITOSA":
      - Body vacío: <ret:retiroEfectivoResponse/>

**Error Handler Principal (_onErrorHandler)**
17. **Manejo de Errores Globales:**
    - Extrae errorCode y errorMessage del fault
    - Llama a actualizaEstadoTransaccion_db con estado actual (estadotrxTengo)
    - Llama a MapeoErrores con errorCode y errorMessage
    - Construye header con respuesta mapeada
    - Body vacío: <ret:retiroEfectivoResponse/>
    - Ejecuta reply

**Error Handler Secundario (ActualizaEstadoTransaccionFin)**
18. **Manejo Error en Actualización:** Log de error y resume (continúa flujo)

**Estados de Transacción Rastreados:**
- REGISTRADO → VALIDANDO_RUTA_REGIONAL → VALIDACION_REGIONAL_EXITOSA/VALIDACION_REGIONAL_FALLIDA
- OBTENIENDO_PARAMETRIA_CORRESPONSAL → ERROR_OBTENIENDO_PARAMETRIZACION/VALIDANDO_MONEDA_TRANSACCION
- PARAMETRIA_OBTENIDA_CORRECTAMENTE (error moneda) / ERROR_DE_MONEDA_INVALIDA (continúa)
- OBTENIENDO_COMISION → ERROR_OBTENIENDO_COMISION/COMISION_OBTENIDA_EXITOSAMENTE
- CONSULTANDO_CUENTA → ERROR_CONSULTANDO_CUENTA/CUENTA_VALIDADA
- ERROR_SALDO_INSUFICIENTE / REALIZANDO_TRANSFERENCIA
- ERROR_AL_REALIZAR_TRANSFERENCIA / TRANSACCION_EXITOSA
- REALIZANDO_COBRO_COMISION → ERROR_COBRANDO_COMISION → REVERSANDO_TRANSACCION → ERROR_AL_REVERSAR_LA_TRANSACCION/REVERSADA
- TRANSACCION_EXITOSA (final exitoso)

**Servicios Dependientes:**
- **registraEstadoTransaccion_db:** Registro inicial (Validaciones pipeline)
- **ValidaServicioRegional_db:** Validación regional (Validaciones pipeline)
- **consultarCorresponsalB_db:** Parametrización corresponsal (Validaciones pipeline)
- **registrarUsoServicio_db:** Control cuota apertura/cierre (Validaciones request/response)
- **consultaComisionesCB_db:** Cálculo comisión (HN01 pipeline)
- **consultaCuentasBS:** Consulta saldo (HN01 pipeline)
- **svcRegistraTransaccionTengo:** Transferencia principal T24 (HN01 pipeline)
- **transferenciasBS:** Transferencia comisión (HN01 pipeline, condicional)
- **ReversarTransaccion:** Reversión en caso de error comisión (HN01 pipeline, condicional)
- **actualizaEstadoTransaccion_db:** Actualización estado final (HN01 pipeline + error handler)
- **MapeoErrores:** Mapeo errores (Validaciones response + error handler)

**Arquitectura Multi-Core:** Solo Honduras (HN01) tiene implementación completa. Otros países ejecutan pipeline vacío.

**Seguridad:** Custom token authentication con username/password del header RequestHeader/Authentication

**Variables Clave No Documentadas en Parametrización:**
- cuentaComision: Obtenida de consultarCorresponsalB (no explícita en código mostrado)
- tipoTransaccioncomision: Usada en cobro comisión (origen no explícito)

### 6. Datos Relevantes

- El servicio requiere reversión automática si falla el cobro de comisión
- El servicio registra múltiples estados de la transacción para trazabilidad
- Implementa validación de cuota de uso de servicio
- Soporta únicamente transacciones en la moneda permitida por el corresponsal
- Valida saldo disponible antes de ejecutar la transacción
- Cobra comisión en una transacción separada después de la transferencia principal
- Estados de transacción rastreados: REGISTRADO, VALIDANDO_RUTA_REGIONAL, VALIDACION_REGIONAL_EXITOSA, OBTENIENDO_PARAMETRIA_CORRESPONSAL, PARAMETRIA_OBTENIDA_CORRECTAMENTE, VALIDANDO_MONEDA_TRANSACCION, OBTENIENDO_COMISION, COMISION_OBTENIDA_EXITOSAMENTE, CONSULTANDO_CUENTA, CUENTA_VALIDADA, REALIZANDO_TRANSFERENCIA, TRANSACCION_EXITOSA, REALIZANDO_COBRO_COMISION, REVERSANDO_TRANSACCION, REVERSADA
- Limitación: Solo soporta Honduras (HN01), otros países no tienen implementación

### 7. Detalles Técnicos de Conexión

- **Conexión a T24 (svcRegistraTransaccionTengo):** Por HTTP - Ejecuta la transferencia principal del retiro
- **Conexión a consultaCuentasBS:** Por HTTP - Consulta saldo y detalles de cuenta
- **Conexión a transferenciasBS:** Por HTTP - Ejecuta transferencia de comisión
- **Conexión a Base de Datos Middleware:** Por JCA - Registra estados, valida uso, consulta comisiones y corresponsales
- **Conexión a ReversarTransaccion:** Por Proxy interno - Reversa transacciones fallidas

### 8. Dependencias del Servicio

**Servicios Internos:**
- registraEstadoTransaccion_db - Registra estado inicial de transacción
- ValidaServicioRegional_db - Valida disponibilidad regional
- consultarCorresponsalB_db - Obtiene parametrización de corresponsal
- registrarUsoServicio_db - Controla cuota de uso
- consultaComisionesCB_db - Calcula comisión
- actualizaEstadoTransaccion_db - Actualiza estado final
- MapeoErrores - Mapea códigos de error

**Servicios Externos:**
- consultaCuentasBS - Consulta saldo de cuenta (T24)
- svcRegistraTransaccionTengo - Ejecuta transferencia principal (T24)
- transferenciasBS - Ejecuta transferencia de comisión (T24)
- ReversarTransaccion - Reversa transacciones

## 9. Datos del Servicio

| Campo | Valor |
|-------|-------|
| **RUTA** | Middleware\v2\SProxyServices\RetiroEfectivoCBS |
| **URI** | /SMiddleware/OperationsAndExecution/Payments/RetiroEfectivoCBS |
| **NUMERO_OPERACIONES** | 1 |
| **OPERACIONES** | retiroEfectivo |
| **CODIGO** | FICBCO0218$0265 |
| **GRUPO_ASIGNADO** | RetiroEfectivo |

## 10. Información del Inventario de Servicios

Servicios relacionados con RetiroEfectivoCBS encontrados en el inventario (GRUPO_ASIGNADO = "RetiroEfectivo"):

| URI | NUMERO_OPERACIONES | OPERACIONES | CODIGO | GRUPO_ASIGNADO | RUTA |
|-----|-------------------|-------------|--------|-----------------|------|
| /SMiddleware/OperationsAndExecution/Payments/RetiroEfectivoCBS | 1 | retiroEfectivo | FICBCO0218$0265 | RetiroEfectivo | Middleware\v2\SProxyServices\RetiroEfectivoCBS |

**Archivos del Inventario:**
- **WSDL:** Middleware/v2/Resources/RetiroEfectivoCBS/wsdl/retiroEfectivoCB_PS
- **XSD:** Middleware/v2/Resources/RetiroEfectivoCBS/xsd/retiroEfectivoCBTypes.xsd

## 11. Servicios Dependientes (Árbol Proxy-Biz)

Servicios que tienen como PROXY_PADRE "Middleware\v2\SProxyServices\RetiroEfectivoCBS":

### Dependencias Directas de RetiroEfectivoCBS

| PROXY_REFERENCIA | BIZ | Tipo Conexión |
|------------------|-----|---------------|
| Middleware\v2\SProxyServices\RetiroEfectivoCBS | \Middleware\v2\BusinessServices\MDW\registraEstadoTransaccion\biz\registraEstadoTransaccion_db | JCA (ConnectionMiddleware) |
| Middleware\v2\SProxyServices\RetiroEfectivoCBS | \Middleware\v2\BusinessServices\ValidaServicioRegional\biz\ValidaServicioRegional_db | JCA (ConnectionMiddleware) |
| Middleware\v2\SProxyServices\RetiroEfectivoCBS | \Middleware\v2\BusinessServices\MDW\consultarCorresponsalB\biz\consultarCorresponsalB_db | JCA (ConnectionMiddleware) |
| Middleware\v2\SProxyServices\RetiroEfectivoCBS | \Middleware\Business_Resources\general\Resources\RegistrarUsoServicio\registrarUsoServicio_db | JCA (ConnectionMiddleware) |
| Middleware\v2\SProxyServices\RetiroEfectivoCBS | \Middleware\v2\BusinessServices\MDW\consultaComisionesCB\biz\consultaComisionesCB_db | JCA (ConnectionMiddleware) |
| Middleware\v2\SProxyServices\RetiroEfectivoCBS | \Middleware\Business_Resources\ConsultasCuenta\Resources\consultaCuentasBS | HTTP |
| Middleware\v2\SProxyServices\RetiroEfectivoCBS | \Middleware\v2\BusinessServices\T24\svcRegistraTransaccionTengo\biz\svcRegistraTransaccionTengo | HTTP |
| Middleware\v2\SProxyServices\RetiroEfectivoCBS | \Middleware\Business_Resources\Transferencias\Resources\transferenciasBS | HTTP |
| Middleware\v2\SProxyServices\RetiroEfectivoCBS | \Middleware\v2\BusinessServices\MDW\ActualizaEstadoTransaccion\biz\actualizaEstadoTransaccion_db | JCA (ConnectionMiddleware) |
| Middleware\v2\ProxyServices\ReversarTransaccion | \Middleware\Business_Resources\ReversarTransaccion\Resources\ReverseTransaccionBS | HTTP |
| Middleware\v2\ProxyServices\ReversarTransaccion | \Middleware\v3\BusinessServices\PAGOSWSTC\registrarReversionTCCB\biz\registrarReversionTCCB_db | JCA (ConnectionPagosWSTC) |
| Middleware\v2\ProxyServices\ReversarTransaccion | \Middleware\v2\BusinessServices\ValidaServicioRegional\biz\ValidaServicioRegional_db | JCA (ConnectionMiddleware) |
| Middleware\v2\ProxyServices\MapeoErrores | \Middleware\v2\BusinessServices\MDW\guardarBitacoraMapeoErrores\biz\guardarBitacoraMapeoErrores_db | JCA (ConnectionMiddleware) |
| Middleware\v2\ProxyServices\MapeoErrores | \Middleware\v2\BusinessServices\MapeoErrores\biz\mapeodeErrores_db | JCA (ConnectionMiddleware) |

## 12. Canales que utilizan la capacidad

**Canales:** TENGO

**URIs:** /SMiddleware/OperationsAndExecution/Payments/RetiroEfectivoCBS

**Número de canales:** 1

---

## Historial de Cambios

| Fecha | Versión | Autor | Descripción |
|-------|---------|-------|-------------|
| 2024-01-15 | 1.0 | ARQ FICOHSA | Creación inicial |
