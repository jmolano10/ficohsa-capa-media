# Historia de Usuario: FPCWithdrawalConsultation

> **Como** Equipo de Integración  
> **Quiero** Implementar el servicio FPCWithdrawalConsultation para consultar información de retiros del fondo de pensión de un cliente  
> **Para** Permitir a los clientes obtener información detallada de retiros efectuados a partir de su identificación y número de solicitud

## Criterios de Aceptación

### 1. Campos de Entrada del Servicio

| Campo | Descripción | Requerido | Tipo/Formato |
|-------|-------------|-----------|--------------|
| **GeneralInfo** | Información general de la transacción | **Sí** | GeneralInfoType |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **SourceBank** | Banco origen | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **DestinationBank** | Banco destino | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **GlobalId** | Identificador global de transacción | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **ApplicationId** | Identificador de aplicación | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **ApplicationUser** | Usuario de aplicación | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **BranchId** | Identificador de sucursal | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **TransactionDate** | Fecha de transacción | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;└─ **Language** | Idioma de respuesta | No | string |
| **RequestNumber** | Número de solicitud de retiro | **Sí** | string |
| **ClientId** | Identificador del cliente | **Sí** | string |

> **Validaciones:**
> - GeneralInfo es obligatorio y debe contener al menos GlobalId
> - RequestNumber no puede estar vacío
> - ClientId no puede estar vacío
> - Se valida la estructura del mensaje contra el esquema XSD FPCWithdrawalConsultationTypes.xsd
> - Se valida la autenticación mediante Basic Authentication
> - Se valida la disponibilidad del servicio por región (solo Honduras HN01)

### 2. Campos de Salida del Servicio

| Campo | Descripción | Requerido | Tipo |
|-------|-------------|-----------|------|
| **FPCWithdrawalConsultationResponse** | Respuesta del servicio de consulta de retiro FPC | **Sí** | Complex Type |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **StatusInfo** | Información de estado de la transacción | No | StatusInfoType |
| &nbsp;&nbsp;&nbsp;&nbsp;│&nbsp;&nbsp;&nbsp;&nbsp;├─ **Status** | Estado de la operación (SUCCESS/ERROR) | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;│&nbsp;&nbsp;&nbsp;&nbsp;├─ **TransactionId** | Identificador de la transacción | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;│&nbsp;&nbsp;&nbsp;&nbsp;├─ **ValueDate** | Fecha valor | No | date |
| &nbsp;&nbsp;&nbsp;&nbsp;│&nbsp;&nbsp;&nbsp;&nbsp;├─ **DateTime** | Fecha y hora de la operación | No | dateTime |
| &nbsp;&nbsp;&nbsp;&nbsp;│&nbsp;&nbsp;&nbsp;&nbsp;└─ **GlobalId** | Identificador global de transacción | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **ErrorInfo** | Información de error (si aplica) | No | ErrorInfoType |
| &nbsp;&nbsp;&nbsp;&nbsp;│&nbsp;&nbsp;&nbsp;&nbsp;├─ **Code** | Código de error | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;│&nbsp;&nbsp;&nbsp;&nbsp;├─ **Error** | Tipo de error | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;│&nbsp;&nbsp;&nbsp;&nbsp;├─ **Description** | Descripción detallada del error | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;│&nbsp;&nbsp;&nbsp;&nbsp;├─ **ShortDescription** | Descripción corta del error | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;│&nbsp;&nbsp;&nbsp;&nbsp;├─ **DateTime** | Fecha y hora del error | No | dateTime |
| &nbsp;&nbsp;&nbsp;&nbsp;│&nbsp;&nbsp;&nbsp;&nbsp;├─ **GlobalId** | Identificador global de transacción | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;│&nbsp;&nbsp;&nbsp;&nbsp;└─ **Details** | Detalles adicionales del error (0..n) | No | Complex Type |
| &nbsp;&nbsp;&nbsp;&nbsp;│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **SystemId** | Identificador del sistema origen | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **SystemStatus** | Estado del sistema | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **MessageId** | Identificador del mensaje | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└─ **Messages** | Mensajes descriptivos | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **Account** | Número de cuenta del cliente | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **ClientName** | Nombre completo del cliente | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **IdNumber** | Número de identificación | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **PaymentMethod** | Método de pago del retiro | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **Currency** | Tipo de moneda | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **Amount** | Monto del retiro | No | decimal |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **WithdrawalType** | Tipo de retiro | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;└─ **BankingAccount** | Cuenta bancaria destino | No | string |

> **Nota:** Todos los campos de salida están validados contra el esquema XSD FPCWithdrawalConsultationTypes.xsd

## Tareas Técnicas

### 1. Códigos de Error

#### 1.1. Códigos de error del Proveedor

| Código Error | Descripción | Tipo Error |
|--------------|-------------|------------|
| VALIDATION_ERROR | Error en validación XSD o de negocio | Técnico |
| AUTHENTICATION_ERROR | Falla en autenticación CloudCode | Técnico |
| BUSINESS_ERROR | Error de lógica de negocio (solicitud no encontrada) | Negocio |
| SYSTEM_ERROR | Error interno del sistema | Técnico |
| SERVICE_UNAVAILABLE | Servicio CloudCode no disponible | Técnico |
| CONFIGURATION_ERROR | Error en parámetros de configuración | Técnico |
| TIMEOUT_ERROR | Timeout en servicios externos | Técnico |
| SUCCESS | Operación exitosa | Negocio |

> **Nota:** El servicio utiliza GetCustomErrorByStackTraceRegionalRestBS para estandarizar los mensajes de error y homologar códigos HTTP.

### 2. Configuración de Timeout

- **Timeout operación del OSB:** Configurado según estándares del middleware
- **Timeout CloudCode API:** Configurable por ambiente y servicio
- **Timeout servicios regionales:** Según configuración de base de datos

### 3. Datos de Prueba

> **Nota:** Los siguientes son datos de ejemplo no reales, utilizados únicamente para propósitos de testing y documentación.

- **RequestNumber:** "REQ-2024-001"
- **ClientId:** "0801199012345"
- **GlobalId:** "TXN-12345-67890"

### 4. Datos de Contacto

**Contacto responsable OSB:**
- **David Ruiz** - david.ruiz@ficohsa.com
- **Wilmer Fernandez** - wilmer.fernandez@ficohsa.com  
- **Francia Avila** - francia.avila@ficohsa.com
- **Diego Gomez** - diego.gomez@ficohsa.com

### 5. Lógica Importante

**Flujo Principal del Servicio:**

1. **Validación XSD:**
   - Se valida la estructura del mensaje contra el esquema FPCWithdrawalConsultationTypes.xsd
   - Valida que GeneralInfo esté presente
   - Valida que RequestNumber y ClientId no estén vacíos
   - Si falla la validación, se genera error automático y se detiene el flujo

2. **Obtención de Parámetros (StageCloudCodeLogin):**
   - Se invoca GetParametersRestBS con parameterName = "PG13516.SERVICE.ACCOUNT.APIFPC"
   - Se obtiene el nombre de la cuenta de servicio para autenticación
   - Si errorCode != "SUCCESS", se detiene el flujo y se retorna error

3. **Extracción de Credenciales:**
   - Se ejecuta ExtractCredentialsAPIFPC.xqy para obtener credenciales desencriptadas
   - Se utiliza el serviceAccount obtenido del paso anterior

4. **Autenticación CloudCode:**
   - Se invoca CloudCodeLoginPS con forceLogin = "false" y las credenciales extraídas
   - Se obtiene un token de sesión válido para la API de CloudCode
   - Si falla la autenticación, se retorna error

5. **Transformación de Request (TransformRegionalToTargetSystem):**
   - Se transforma el request regional al formato CloudCode API
   - XQuery utilizado: FPCWithdrawalConsultationToCloudCodeRestBS.xqy
   - Mapeo de campos:
     - `RequestNumber` → `numeroSolicitud` (decimal)
     - `ClientId` → `numeroIdentificacion` (string)

6. **Logging de Entrada (StageLogginInput):**
   - Se registra el request en LoggingRegionalRestBS para auditoría
   - Invocación desatendida, no afecta el flujo principal

7. **Invocación al Servicio CloudCode (InvokeCountry):**
   - Se invoca CloudCodeRestBS con operación GetFPCWithdrawal
   - Método: GET con query parameters (numeroSolicitud, numeroIdentificacion)
   - Header Authorization con Bearer Token obtenido del login
   - Endpoint: https://apidev.afpficohsa.com/api/v2/retiros

8. **Manejo de Error 401 (Re-autenticación):**
   - Si CloudCode responde con HTTP 401:
     - Se invoca CloudCodeLoginPS con forceLogin = "true"
     - Se obtiene nuevo token de sesión
     - Se reintenta la invocación a CloudCodeRestBS
   - Si el retry también falla, se retorna error

9. **Logging de Salida (StageLogginOutput):**
   - Se registra la respuesta en LoggingRegionalRestBS para auditoría

10. **Transformación de Response (TransformTargetSystemToRegional):**
    - Se transforma la respuesta de CloudCode al formato regional
    - XQuery utilizado: CloudCodeRestToFPCWithdrawalConsultation.xqy
    - Mapeo de campos:
      - `datos/retiros/cuenta` → `Account`
      - `datos/retiros/nombreCliente` → `ClientName`
      - `datos/retiros/numeroIdentificacion` → `IdNumber`
      - `datos/retiros/formaPago` → `PaymentMethod`
      - `datos/retiros/moneda` → `Currency`
      - `datos/retiros/monto` → `Amount`
      - `datos/retiros/tipoRetiro` → `WithdrawalType`
      - `datos/retiros/cuentaBancaria` → `BankingAccount`

11. **Mapeo de Errores:**
    - Si hay errores en la transformación de respuesta:
      - Se invoca GetCustomErrorByStackTraceRegionalRestBS
      - Se utiliza ErrorMapeoRegionalToFPCWithdrawalConsultation.xqy
      - Se homologa el código HTTP de respuesta
      - Se retorna error estandarizado al cliente

**Servicios Dependientes Analizados:**
- **GetParametersRestBS:** Obtiene parámetros de configuración (cuenta de servicio para autenticación)
- **CloudCodeLoginPS:** Servicio SOAP de autenticación que genera tokens de acceso para CloudCode
- **LoggingRegionalRestBS:** Servicio de logging para registrar entrada y salida de operaciones
- **CloudCodeRestBS:** Servicio principal que ejecuta la consulta de retiros en la API de CloudCode
- **GetCustomErrorByStackTraceRegionalRestBS:** Genera trazabilidad de errores y homologa códigos HTTP

**Arquitectura del Servicio:**
Este servicio es parte de la capa de Pensiones (SBHN_Pension) que proporciona servicios de consulta de fondos de pensión. Características principales:
- Patrón Proxy Rest/Soap Local expuesto desde regionalización
- Autenticación mediante Bearer Token contra CloudCode API
- Re-autenticación automática en caso de token expirado (HTTP 401)
- Logging de entrada y salida para auditoría
- Transformaciones XQuery específicas para Honduras
- Manejo de errores con homologación de códigos HTTP

**Seguridad:**
El servicio implementa múltiples capas de seguridad:
1. **Basic Authentication:** Autenticación del proxy de entrada
2. **Obtención de Parámetros:** Recupera configuración de cuenta de servicio de forma segura
3. **Credenciales Encriptadas:** Las credenciales se extraen y desencriptan mediante ExtractCredentialsAPIFPC
4. **Bearer Token:** Autenticación contra CloudCode API con token de sesión
5. **Re-autenticación Automática:** Renovación de token en caso de expiración (401)
6. **Trazabilidad:** GlobalId se mantiene en todas las operaciones para auditoría

### 6. Datos Relevantes

- El servicio no requiere reintentos automáticos (excepto para error 401 de autenticación)
- El servicio no requiere reversos (es una consulta de solo lectura)
- Es un servicio de consulta que no modifica datos
- Solo Honduras (HN01) está soportado como país
- Utiliza CloudCode como backend para la consulta de retiros de pensión
- Soporta exposición REST y SOAP desde el proxy de regionalización

### 7. Detalles Técnicos de Conexión

- **Conexión a GetParametersRestBS:** HTTP/REST - https://mwservices.gfficohsa.hn:8020/regional/utility/constants/rest/GetCustomParameter/v2
- **Conexión a CloudCodeLoginPS:** SOAP - SBHN_Pension_CloudCodeLogin/PS/CloudCodeLoginPS
- **Conexión a LoggingRegionalRestBS:** HTTP/REST - https://mwservices.gfficohsa.hn:8020/regional/utility/logging/rest/writeToFileSystem/v2
- **Conexión a CloudCodeRestBS:** HTTP/REST - https://apidev.afpficohsa.com/api/v2/retiros
- **Conexión a GetCustomErrorByStackTraceRegionalRestBS:** HTTP/REST - https://mwservices.gfficohsa.hn:8020/regional/utility/constants/rest/GetCustomErrorByStackTrace/v2

### 8. Dependencias del Servicio

**Servicios Internos:**
- SBHN_Pension_CloudCodeLogin/PS/CloudCodeLoginPS - Servicio de autenticación CloudCode
- SBHN_Pension_Commons/Transformations - Transformaciones comunes (ExtractCredentialsAPIFPC, ServiceToCloudCodeLogin, ServiceToParameters, ServicesToError)

**Servicios Externos (Business Services):**
- GetParametersRestBS - Obtención de parámetros de configuración
- LoggingRegionalRestBS - Logging regional de operaciones
- CloudCodeRestBS - Consulta de retiros FPC en CloudCode API
- GetCustomErrorByStackTraceRegionalRestBS - Mapeo y homologación de errores

## 9. Datos del Servicio

| Campo | Valor |
|-------|-------|
| **RUTA** | SBHN_Pension_FPCWithdrawalConsultation |
| **URI** | /regional/pension/FPCWithdrawalConsultation |
| **NUMERO_OPERACIONES** | 1 |
| **OPERACIONES** | FPCWithdrawalConsultation |
| **CODIGO** | Pension/FPCWithdrawalConsultation |
| **GRUPO_ASIGNADO** | FPCWithdrawalConsultation |

## 10. Información del Inventario de Servicios

Servicios relacionados con FPCWithdrawalConsultation encontrados en el inventario (GRUPO_ASIGNADO = "FPCWithdrawalConsultation"):

| Nombre Servicio | URI | NUMERO_OPERACIONES | OPERACIONES | CODIGO | RUTA |
|-----------------|-----|-------------------|-------------|--------|------|
| FPCWithdrawalConsultation | /regional/pension/FPCWithdrawalConsultation | 1 | FPCWithdrawalConsultation | Pension/FPCWithdrawalConsultation | SBHN_Pension_FPCWithdrawalConsultation |

## 11. Servicios Dependientes (Árbol Proxy-Biz)

Servicios que tienen como PROXY_PADRE "SBHN_Pension_FPCWithdrawalConsultation":

| PROXY_REFERENCIA | BIZ | URI |
|------------------|-----|-----|
| SBHN_Pension_FPCWithdrawalConsultation | GetParametersRestBS | [https://mwservices.gfficohsa.hn:8020/regional/utility/constants/rest/GetCustomParameter/v2] |
| SBHN_Pension_FPCWithdrawalConsultation | CloudCodeLoginPS | [SBHN_Pension_CloudCodeLogin/PS/CloudCodeLoginPS] |
| SBHN_Pension_FPCWithdrawalConsultation | LoggingRegionalRestBS | [https://mwservices.gfficohsa.hn:8020/regional/utility/logging/rest/writeToFileSystem/v2] |
| SBHN_Pension_FPCWithdrawalConsultation | CloudCodeRestBS | [https://apidev.afpficohsa.com/api/v2/retiros] |
| SBHN_Pension_FPCWithdrawalConsultation | GetCustomErrorByStackTraceRegionalRestBS | [https://mwservices.gfficohsa.hn:8020/regional/utility/constants/rest/GetCustomErrorByStackTrace/v2] |

## 12. Canales que utilizan la capacidad

**Canales:** Regionalización (Proxy Rest/Soap Local)

**URIs:** /regional/pension/FPCWithdrawalConsultation

**Número de canales:** 1

---

## Historial de Cambios

| Fecha | Versión | Autor | Descripción |
|-------|---------|-------|-------------|
| 2026-05-18 | 1.0 | ARQ FICOHSA | Creación inicial |
