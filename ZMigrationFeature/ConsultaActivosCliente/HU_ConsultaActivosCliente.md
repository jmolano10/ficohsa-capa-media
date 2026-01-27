# Historia de Usuario: ConsultaActivosCliente

> **Como** Equipo de Integración  
> **Quiero** Implementar un servicio que permita consultar los activos financieros de un cliente específico por tipo de producto  
> **Para** Proporcionar información consolidada de cuentas de ahorro, corriente, depósitos a plazo y fondos de pensiones según el país y tipo de activo solicitado

## Criterios de Aceptación

### 1. Campos de Entrada del Servicio

| Campo | Descripción | Requerido | Tipo/Formato |
|-------|-------------|-----------|--------------| 
| **CUSTOMER_ID** | Identificador único del cliente | **Sí** | string (minLength=1) |
| **ASSET_TYPE** | Tipo de activo a consultar | **Sí** | string (minLength=1) |

> **Validaciones:**
> - CUSTOMER_ID debe tener al menos 1 caracter
> - ASSET_TYPE debe ser uno de: AHO (Ahorros), CHQ (Corriente), DEP (Depósitos), FPC (Fondo Pensiones), CTA (Cuentas), ALL (Todos)
> - Se valida la estructura del mensaje contra el esquema XSD consultaClientesTypes.xsd
> - Se aplica validación de servicio regional con serviceId "FICBCO0043"

### 2. Campos de Salida del Servicio

| Campo | Descripción | Requerido | Tipo |
|-------|-------------|-----------|------|
| **consultaActivosClienteResponse** | Respuesta del servicio de consulta de activos | **Sí** | Complex Type |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **consultaActivosClienteAhorrosResponseType** | Información de cuentas de ahorro | No | Complex Type |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **consultaActivosClienteCorrienteResponseType** | Información de cuentas corrientes | No | Complex Type |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **consultaActivosClienteDepositosResponseType** | Información de depósitos a plazo | No | Complex Type |
| &nbsp;&nbsp;&nbsp;&nbsp;└─ **consultaActivosClientePensionesResponseType** | Información de fondos de pensiones | No | Complex Type |

**Estructura de cada tipo de respuesta:**
| Campo | Descripción | Requerido | Tipo |
|-------|-------------|-----------|------|
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **SUCCESS_INDICATOR** | Indicador de éxito de la operación | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;└─ **consultaActivosClienteResponseRecordType** | Array de registros de activos | No | Array |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **ASSET_TYPE** | Tipo de activo | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **ASSET_NUMBER** | Número del activo/cuenta | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **ASSET_NAME** | Nombre del activo/cuenta | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **ASSET_CURRENCY** | Moneda del activo | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **ASSET_TOTAL_BALANCE** | Saldo total | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **ASSET_RESERVE_BALANCE** | Saldo de reserva | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **ASSET_LOCKED_BALANCE** | Saldo bloqueado | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **ASSET_VISA_FLOATING_BALANCE** | Saldo flotante Visa | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **ASSET_AVAILABLE_BALANCE** | Saldo disponible | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **ASSET_SOURCE_BANK** | Banco origen | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **ASSET_PRODUCT_TYPE** | Tipo de producto | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **INTERNATIONAL_ACCOUNT_NUMBER** | Número de cuenta internacional | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **OPENING_DATE** | Fecha de apertura | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└─ **ACCOUNT_STATUS** | Estado de la cuenta | No | string |

> **Nota:** Todos los campos de salida están validados contra el esquema XSD consultaClientesTypes.xsd

## Tareas Técnicas

### 1. Códigos de Error

#### 1.1. Códigos de error del Proveedor

| Código Error | Descripción | Tipo Error |
|--------------|-------------|------------|
| MW-0008 | SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY | Técnico |
| BEA-382505 | Error de validación XSD | Técnico |
| PRODUCT NOT SUPPORTED | Tipo de producto no soportado | Negocio |

> **Nota:** Los errores se mapean a través del servicio MapeoErrores con código de servicio FICBCO0043

### 2. Configuración de Timeout

- **Timeout proveedor T24:** 30 segundos
- **Timeout proveedor ABKGT/ABKPA:** 30 segundos  
- **Timeout proveedor SJS:** 30 segundos
- **Timeout proveedor CTS:** 30 segundos
- **Timeout operación del OSB:** 60 segundos

### 3. Datos de Prueba

> **Nota:** Los siguientes son datos de ejemplo no reales, utilizados únicamente para propósitos de testing y documentación.

- **CUSTOMER_ID:** "12345678"
- **ASSET_TYPE:** "ALL"
- **CUSTOMER_ID:** "87654321"
- **ASSET_TYPE:** "AHO"

### 4. Datos de Contacto

**Contacto responsable OSB:**
- **David Ruiz** - david.ruiz@ficohsa.com
- **Wilmer Fernandez** - wilmer.fernandez@ficohsa.com  
- **Francia Avila** - francia.avila@ficohsa.com
- **Diego Gomez** - diego.gomez@ficohsa.com

### 5. Lógica Importante

**Flujo Principal del Servicio:**
1. **Validación XSD:** Se valida la estructura del mensaje contra el esquema consultaClientesTypes.xsd
2. **Validación Regional:** Se ejecuta ValidaServicioRegional con serviceId "FICBCO0043" para verificar disponibilidad por región
3. **Regionalización por País:** El servicio se enruta según el país de origen con flujos específicos:
   
   **HN01 (Honduras) - Sistema T24/SJS:**
   - **Flujo AHO/CHQ:** Consulta directa a T24 → ConsultaCuentaAhorro/ConsultaCuentaCorriente
   - **Flujo DEP:** Consulta a SJS → sjConsultaCuentasCliente para depósitos a plazo
   - **Flujo FPC:** Consulta a ConsultaFondoPensiones → Base de datos Ficopen
   - **Flujo ALL/CTA:** SplitJoin a SJS → sjConsultaActivosCliente (consolida todos los tipos)
   - **Validaciones:** ValidaFuncionalidadUsuario para "SALDOS_ACTIVOS"
   
   **GT01 (Guatemala) - Sistema ABKGT:**
   - **Flujo AHO/CHQ:** Consulta JCA/DB → consultaListaCuentas_db (ConnectionProxyAbanksGT)
   - **Flujo DEP:** Consulta JCA/DB → consultaListaDepositosCliente_db (ConnectionProxyAbanksGT)
   - **Flujo FPC:** No soportado - retorna respuesta vacía
   - **Flujo ALL/CTA:** SplitJoin → sjConsultaActivosCliente (consolida cuentas y depósitos)
   - **Base de Datos:** Conexión directa a Abanks Guatemala
   
   **PA01 (Panamá) - Sistema ABKPA:**
   - **Flujo AHO/CHQ:** Consulta JCA/DB → consultaListaCuentas_db (ConnectionProxyAbanksPA)
   - **Flujo DEP:** Consulta JCA/DB → consultaListaDepositosCliente_db (ConnectionProxyAbanksPA)
   - **Flujo FPC:** No soportado - retorna respuesta vacía
   - **Flujo ALL/CTA:** SplitJoin → sjConsultaActivosCliente (consolida cuentas y depósitos)
   - **Base de Datos:** Conexión directa a Abanks Panamá
   
   **NI01 (Nicaragua) - Sistema CTS/COBIS:**
   - **Flujo Único:** Consulta HTTP/SOAP → activos (GerenciaProductoActivos)
   - **Endpoint:** http://10.235.53.145:9080/GerenciaProductoActivos/SrvAplCobisActivosService
   - **Tipos Soportados:** Todos los tipos de activos mediante servicio unificado
   - **Sistema Core:** COBIS Nicaragua
   
   **Países No Implementados:**
   - **Error:** MW-0008 "SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY"
   - **Mapeo:** A través de MapeoErrores con código FICBCO0043
   - **Respuesta:** Error técnico sin datos de activos
4. **Consulta por Tipo de Activo:** Según ASSET_TYPE se ejecutan diferentes flujos:
   - AHO: Consulta cuentas de ahorro
   - CHQ: Consulta cuentas corrientes
   - DEP: Consulta depósitos a plazo
   - FPC: Consulta fondos de pensiones
   - CTA/ALL: Consulta todos los tipos mediante SplitJoin
5. **Validación de Funcionalidad:** Se valida funcionalidad "SALDOS_ACTIVOS" para el usuario
6. **Transformación de Respuesta:** Se construye respuesta según el país y tipo de activo consultado
7. **Manejo de Errores:** Se aplica mapeo de errores con código FICBCO0043

**Servicios Dependientes Analizados:**
- **ValidaServicioRegional:** Validación de disponibilidad del servicio por región
- **ValidaFuncionalidadUsuario:** Validación de permisos del usuario para consultar saldos
- **MapeoErrores:** Mapeo y transformación de códigos de error
- **ConsultaCliente:** Obtención de datos básicos del cliente (solo HN01)

**Arquitectura Multi-Core:** Soporta múltiples sistemas core según el país (T24, ABKGT, ABKPA, SJS, CTS)

**Seguridad por Usuario:** Implementa Custom Token Authentication con validación de funcionalidad por usuario

### 6. Datos Relevantes

- El servicio requiere autenticación mediante Custom Token Authentication
- El servicio no requiere reintentos automáticos
- El servicio no requiere reversos
- Soporta consulta por tipo específico de activo o todos los activos (ALL)
- Implementa lógica diferenciada por país y sistema core
- Los saldos se muestran según la funcionalidad asignada al usuario
- Maneja múltiples monedas y tipos de cuenta
- Incluye información de estado y fechas de las cuentas

### 7. Detalles Técnicos de Conexión

- **Conexión a T24 (HN01):** Por HTTP/SOAP - Servicios de consulta de cuentas de ahorro y corriente
- **Conexión a ABKGT (GT01):** Por JCA/DB - Conexión directa a base de datos Abanks Guatemala
- **Conexión a ABKPA (PA01):** Por JCA/DB - Conexión directa a base de datos Abanks Panamá
- **Conexión a SJS (HN01):** Por Flow - Servicios de consulta consolidada de cuentas
- **Conexión a CTS (NI01):** Por HTTP/SOAP - Sistema COBIS Nicaragua
- **Conexión a ConsultaFondoPensiones (HN01):** Por HTTP/SOAP - Servicios de fondos de pensiones

### 8. Dependencias del Servicio

**Servicios Internos:**
- ValidaServicioRegional - Validación regional del servicio
- ValidaFuncionalidadUsuario - Validación de permisos de usuario
- MapeoErrores - Mapeo de códigos de error

**Servicios Externos:**
- T24/ConsultaCuentaAhorro - Consulta de cuentas de ahorro (HN01)
- T24/ConsultaCuentaCorriente - Consulta de cuentas corrientes (HN01)
- SJS/consultaActivosCliente - Consulta consolidada de activos (HN01)
- SJS/consultaCuentasCliente - Consulta de cuentas del cliente (HN01)
- ABKGT/consultaListaCuentas - Consulta de cuentas Guatemala
- ABKGT/consultaListaDepositos - Consulta de depósitos Guatemala
- ABKGT/consultaActivosCliente - Consulta consolidada Guatemala
- ABKPA/consultaListaCuentas - Consulta de cuentas Panamá
- ABKPA/consultaListaDepositos - Consulta de depósitos Panamá
- ABKPA/consultaActivosCliente - Consulta consolidada Panamá
- CTS/activos - Consulta de activos Nicaragua
- ConsultaFondoPensiones12c - Consulta de fondos de pensiones
- consultasClienteBS - Consulta de datos del cliente

## 9. Datos del Servicio

| Campo | Valor |
|-------|-------|
| **RUTA** | Middleware\v2\ProxyServices\ConsultaActivosCliente |
| **URI** | /SMiddleware/OperationsAndExecution/PositionManagement/ConsultaActivosCliente_v2 |
| **NUMERO_OPERACIONES** | 1 |
| **OPERACIONES** | consultaActivosCliente |
| **CODIGO** | FICBCO0043 |
| **GRUPO_ASIGNADO** | ConsultaActivosCliente |

## 10. Información del Inventario de Servicios

Servicios relacionados con ConsultaActivosCliente encontrados en el inventario (GRUPO_ASIGNADO = "ConsultaActivosCliente"):

| URI | NUMERO_OPERACIONES | OPERACIONES | CODIGO | GRUPO_ASIGNADO | RUTA |
|-----|-------------------|-------------|--------|-----------------|------|
| /SMiddleware/OperationsAndExecution/PositionManagement/ConsultaActivosCliente_v2 | 1 | consultaActivosCliente | FICBCO0043 | ConsultaActivosCliente | Middleware\v2\ProxyServices\ConsultaActivosCliente |
| /Middleware/OperationsAndExecution/PositionManagement/ConsultaActivosCliente | 1 | consultaActivosCliente | - | ConsultaActivosCliente | Middleware\OperationsAndExecution\PositionManagement\ConsultaActivosCliente |

## 11. Servicios Dependientes (Árbol Proxy-Biz)

Servicios que tienen como PROXY_PADRE "Middleware\v2\ProxyServices\ConsultaActivosCliente":

| PROXY_REFERENCIA | BIZ | URI |
|------------------|-----|-----|
| Middleware\v2\ProxyServices\ConsultaActivosCliente | Middleware\v2\BusinessServices\ABKPA\consultaListaDepositos\biz\consultaListaDepositosCliente_db | [jca://eis/DB/ConnectionProxyAbanksPA] |
| Middleware\v2\ProxyServices\ConsultaActivosCliente | Middleware\v2\BusinessServices\ABKGT\consultaListaCuentas\biz\consultaListaCuentas_db | [jca://eis/DB/ConnectionProxyAbanksGT] |
| Middleware\v2\ProxyServices\ConsultaActivosCliente | Middleware\v2\BusinessServices\ABKPA\consultaActivosCliente\biz\sjConsultaActivosCliente | [flow:Middleware/v2/BusinessServices/ABKPA/consultaActivosCliente/flow/sjConsultaActivosCliente] |
| Middleware\v2\ProxyServices\ConsultaActivosCliente | Middleware\v2\BusinessServices\ABKGT\consultaListaDepositos\biz\consultaListaDepositosCliente_db | [jca://eis/DB/ConnectionProxyAbanksGT] |
| Middleware\v2\ProxyServices\ConsultaActivosCliente | Middleware\v2\BusinessServices\ABKPA\consultaListaCuentas\biz\consultaListaCuentas_db | [jca://eis/DB/ConnectionProxyAbanksPA] |
| Middleware\v2\ProxyServices\ConsultaActivosCliente | Middleware\v2\BusinessServices\CTS\activos\biz\activos | [http://10.235.53.145:9080/GerenciaProductoActivos/SrvAplCobisActivosService] |
| Middleware\v2\ProxyServices\ConsultaActivosCliente | Middleware\v2\BusinessServices\T24\ConsultaCuentaAhorro\biz\ConsultaCuentaAhorro | [http://172.23.13.19:7003/svcConsultaCuentaAhorro/services] |
| Middleware\v2\ProxyServices\ConsultaActivosCliente | Middleware\v2\BusinessServices\T24\ConsultaCuentaCorriente\biz\ConsultaCuentaCorriente | [http://172.23.13.19:7003/svcConsultaCuentaCorriente/services] |
| Middleware\v2\ProxyServices\ConsultaActivosCliente | Middleware\v2\BusinessServices\SJS\consultaCuentasCliente\biz\sjConsultaCuentasCliente | [flow:Middleware/v2/BusinessServices/SJS/consultaCuentasCliente/flow/sjConsultaCuentasCliente] |
| Middleware\v2\ProxyServices\ConsultaActivosCliente | Middleware\v2\BusinessServices\ValidaFuncionalidadUsuario\biz\ValidaFuncionalidadUsuario_db | [jca://eis/DB/ConnectionMiddleware] |
| Middleware\v2\ProxyServices\ConsultaActivosCliente | Middleware\v2\BusinessServices\ValidaServicioRegional\biz\ValidaServicioRegional_db | [jca://eis/DB/ConnectionMiddleware] |
| Middleware\v2\ProxyServices\ConsultaActivosCliente | Middleware\v2\BusinessServices\SJS\consultaActivosCliente\biz\sjConsultaActivosCliente | [flow:Middleware/v2/BusinessServices/SJS/consultaActivosCliente/flow/sjConsultaActivosCliente] |
| Middleware\v2\ProxyServices\ConsultaActivosCliente | Middleware\v2\BusinessServices\ConsultaFondoPensiones\biz\consultaFondoPensiones_db | [jca://eis/DB/ConnectionFicopen] |
| Middleware\v2\ProxyServices\ConsultaActivosCliente | Middleware\Business_Resources\consultasCliente\Resources\consultasClienteBS | [http://10.9.104.55:7004/svcConsultasCliente/services, http://10.9.104.55:7005/svcConsultasCliente/services, http://10.9.104.55:7006/svcConsultasCliente/services] |
| Middleware\v2\ProxyServices\ConsultaActivosCliente | Middleware\v2\BusinessServices\ABKGT\consultaActivosCliente\biz\sjConsultaActivosCliente | [flow:Middleware/v2/BusinessServices/ABKGT/consultaActivosCliente/flow/sjConsultaActivosCliente] |

## 12. Canales que utilizan la capacidad

**Canales:** ACET, INTERBANCA, INTERBANCABD, INTERFAZBD, INXU, ONBASE, PAGOSWS, SALESFORCE, SARA

**URIs:** /Middleware/OperationsAndExecution/PositionManagement/ConsultaActivosCliente, /SMiddleware/OperationsAndExecution/PositionManagement/ConsultaActivosCliente_v2

**Número de canales:** 9

---

## Historial de Cambios

| Fecha | Versión | Autor | Descripción |
|-------|---------|-------|-------------|
| 2024-12-19 | 1.0 | ARQ FICOHSA | Creación inicial |