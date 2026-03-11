# Listado de Ficheros - RollbackTaxesBulletin

## Estructura de Directorios

```
ficohsacore-hntransfer-b64b1a407777/
└── SBHN_Transfer/
    ├── SBHN_Transfer_RollbackTaxesBullletin/
    └── SBHN_Transfer_Commons/
```

---

## 1. Proxy Services (Puntos de Entrada)

### 1.1 Proxy SOAP
**Ruta**: `ficohsacore-hntransfer-b64b1a407777/SBHN_Transfer/SBHN_Transfer_RollbackTaxesBullletin/PS/RollbackTaxesBulletinSoapPS.proxy`

**Descripción**: Servicio proxy SOAP que expone el endpoint HTTPS para reversión de boletines fiscales

**Características**:
- Binding: SOAP 1.1
- Endpoint: `/honduras/transfer/soap/rollbackTaxesBulletin/v1`
- Política de seguridad: oracle/http_basic_auth_over_ssl_service_policy
- Invoca: RollbackTaxesBulletinPP pipeline

### 1.2 Proxy REST
**Ruta**: `ficohsacore-hntransfer-b64b1a407777/SBHN_Transfer/SBHN_Transfer_RollbackTaxesBullletin/PS/RollbackTaxesBulletinRestPS.proxy`

**Descripción**: Servicio proxy REST que expone el endpoint HTTPS para reversión de boletines fiscales

**Características**:
- Binding: REST
- Endpoint: `/honduras/transfer/rest/rollbackTaxesBulletin/v1`
- Política de seguridad: oracle/http_basic_auth_over_ssl_service_policy
- Invoca: RollbackTaxesBulletinPP pipeline

---

## 2. Pipelines

### 2.1 Pipeline Principal
**Ruta**: `ficohsacore-hntransfer-b64b1a407777/SBHN_Transfer/SBHN_Transfer_RollbackTaxesBullletin/PP/RollbackTaxesBulletinPP.pipeline`

**Descripción**: Pipeline principal que orquesta el flujo de reversión

**Stages**:
- StageSecurity: Extracción de credenciales
- StageTransformRequest: Transformación de request regional a T24
- StageInvokeCoreBanking: Invocación a T24
- StageTargetSystemToRegional: Transformación de response T24 a regional
- ErrorToRespuesta: Manejo de errores

**Template base**: TransferHondurasFicohsaTemplate

**Variables asignadas**:
- service: 'Transfer/RollbackTaxesBulletin'
- version: 'v1'
- key: 'TransactionId'
- value: TransactionId del body
- method: 'SOAP'
- operationTargetSystem: 'Reversionpagorecaudorefdbcta'
- targetSystem: 'T24'
- security: 'Y'

### 2.2 Template Común
**Ruta**: `ficohsacore-hntransfer-b64b1a407777/SBHN_Transfer/SBHN_Transfer_Commons/PP/TransferHondurasFicohsaTemplate.ptx`

**Descripción**: Template base para servicios de transferencias de Honduras

**Pipelines**:
- request-N53e8b9dc.N41373bfe.0.189f609faa7.N7f9f (request)
- response-N53e8b9dc.N41373bfe.0.189f609faa7.N7f9e (response)
- error-N53e8b9dc.N41373bfe.0.189f609faa7.N7f9b (error handler)

**Stages**:
- StageAssigment: Asignación de variables de contexto
- StageLoggingInput: Logging de request
- StageLoggingOutput: Logging de response
- StageIT: Reporte de errores
- StageMappingErrors: Mapeo de errores
- StageLoggingOutputError: Logging de errores
- StageRespuesta: Respuesta final

**Placeholders**:
- GetSecurity
- TransformRegionalToTargetSystem
- InvokeCountry
- TransformTargetSystemToRegional
- TransformResponse

---

## 3. Business Services

### 3.1 Business Service T24
**Ruta**: `ficohsacore-hntransfer-b64b1a407777/SBHN_Transfer/SBHN_Transfer_RollbackTaxesBullletin/BS/ReversarTransaccionSoapT24BS.bix`

**Descripción**: Business service SOAP para conectar con T24

**Configuración**:
- URL: http://172.23.13.19:7003/RollbackTaxesBulletin/services
- Port: T24WebServicesImplPort
- Namespace: T24WebServicesImpl
- Timeout: 0 (sin límite)
- Connection timeout: 0
- Retry count: 0
- Retry interval: 30 segundos
- Load balancing: round-robin
- Chunked streaming: true
- Result caching: enabled

### 3.2 Business Service de Logging
**Ruta**: `ficohsacore-hntransfer-b64b1a407777/SBHN_Transfer/SBHN_Transfer_Commons/BS/LoggingRegionalRestBS.*`

**Descripción**: Servicio REST para registro de logs en filesystem

**Operación**: SaveLogInFileSystem

### 3.3 Business Service de Mapeo de Errores
**Ruta**: `ficohsacore-hntransfer-b64b1a407777/SBHN_Transfer/SBHN_Transfer_Commons/BS/GetCustomErrorByStackTraceRegionalRestBS.*`

**Descripción**: Servicio REST para mapeo de errores a códigos regionales

**Operación**: process

---

## 4. Transformaciones (XQuery)

### 4.1 Transformación Request Regional → T24
**Ruta**: `ficohsacore-hntransfer-b64b1a407777/SBHN_Transfer/SBHN_Transfer_RollbackTaxesBullletin/Transformations/RollbackTaxesBulletinToT24.xqy`

**Descripción**: Transforma el request regional al formato esperado por T24

**Parámetros de entrada**:
- $input: rollbackTaxesBullletin (regional)
- $userConnInfo: connInfoElement con credenciales

**Salida**: rollbackTaxesBulletin (T24)

**Mapeos**:
- TransactionId → transactionId
- username → userName
- password → password
- company → "" (vacío)

### 4.2 Transformación Response T24 → Regional (Exitoso)
**Ruta**: `ficohsacore-hntransfer-b64b1a407777/SBHN_Transfer/SBHN_Transfer_RollbackTaxesBullletin/Transformations/T24ToRollbackTaxesBulletin.xqy`

**Descripción**: Transforma la respuesta exitosa de T24 al formato regional

**Parámetros de entrada**:
- $coreResponse: rollbackTaxesBulletinResponse (T24)
- $globalId: GlobalId del request original

**Salida**: rollbackTaxesBullletinResponse (regional)

**Mapeos**:
- successIndicator → Status
- current-dateTime → ValueDate (substring 0,11)
- current-dateTime → DateTime (substring 0,20)
- globalId → GlobalId

### 4.3 Transformación Error → Regional
**Ruta**: `ficohsacore-hntransfer-b64b1a407777/SBHN_Transfer/SBHN_Transfer_RollbackTaxesBullletin/Transformations/ErrorToRollbackTaxesBulletin.xqy`

**Descripción**: Transforma errores al formato regional

**Parámetros de entrada**:
- $responseError: errorMappingRegionalOutput
- $codeError: Código de error
- $messageError: Mensaje de error
- $targetSystem: Sistema origen del error
- $status: Estado
- $globalId: GlobalId del request original

**Salida**: rollbackTaxesBullletinResponse con ErrorInfo

### 4.4 Extracción de Credenciales
**Ruta**: `ficohsacore-hntransfer-b64b1a407777/SBHN_Transfer/SBHN_Transfer_Commons/Transformations/ExtractCredentials.xqy`

**Descripción**: Extrae credenciales de LDAP basándose en ApplicationId

**Parámetro de entrada**:
- $account: userLoginElement con userLogin

**Salida**: connInfoElement con username y password

**Funciones**:
- fic:getUsername($LDAPId): Obtiene username de LDAP
- fic:getPassword($LDAPId): Obtiene password de LDAP
- fic:extractCredentialsFromSecurity($account): Función principal con failover

**LDAP Path**: `SB_Security/Common/{ApplicationId en mayúsculas}`

### 4.5 Transformación Servicios a Error
**Ruta**: `ficohsacore-hntransfer-b64b1a407777/SBHN_Transfer/SBHN_Transfer_Commons/Transformations/ServicesToError.xqy`

**Descripción**: Construye request para servicio de mapeo de errores

**Parámetros**:
- systemApplication: Sistema origen
- service: Nombre del servicio
- errorMessage: Mensaje de error
- errorCode: Código de error
- language: Idioma (ES/EN)

### 4.6 Transformación Servicios a Log
**Ruta**: `ficohsacore-hntransfer-b64b1a407777/SBHN_Transfer/SBHN_Transfer_Commons/Transformations/ServiceToLog.xqy`

**Descripción**: Construye request para servicio de logging

**Parámetros múltiples**: destinationBank, method, channel, body, version, targetSystem, GlobalId, sourceBank, endpoint, messageType, service, codeError, state, operation, value, user, key, errorDetails, etc.

---

## 5. Esquemas (XSD)

### 5.1 Esquema Regional
**Ruta**: `ficohsacore-hntransfer-b64b1a407777/SBHN_Transfer/SBHN_Transfer_RollbackTaxesBullletin/Schemas/RollbackTaxesBulletinTypes.xsd`

**Descripción**: Define los tipos de datos para request y response regionales

**Namespace**: https://www.ficohsa.com/regional/transfer/transferTypes

**Elementos**:
- rollbackTaxesBullletin (request)
  - GeneralInfo: GeneralInfoType
  - TransactionId: string
- rollbackTaxesBullletinResponse (response)
  - StatusInfo: StatusInfoType
  - ErrorInfo: ErrorInfoType

**Importa**: CommonTypes.xsd

### 5.2 Esquema T24
**Ruta**: `ficohsacore-hntransfer-b64b1a407777/SBHN_Transfer/SBHN_Transfer_RollbackTaxesBullletin/Schemas/ReversarTransacciones.xsd`

**Descripción**: Define los tipos de datos para T24 Web Services

**Namespace**: T24WebServicesImpl

**Elementos principales**:
- rollbackTaxesBulletin (request)
  - WebRequestCommon: webRequestCommon
  - FUNDSTRANSFERREFCOLLACTRFREVCOPYType: transactionId
- rollbackTaxesBulletinResponse (response)
  - Status: Status
  - FUNDSTRANSFERType: FUNDSTRANSFERType (complejo)

**Tipos complejos**:
- webRequestCommon: userName, password, company
- transactionId: transactionId
- Status: transactionId, messageId, successIndicator, application, messages
- FUNDSTRANSFERType: Múltiples campos (REVERSALMKR, RECORDSTATUS, etc.)
- successIndicator (enum): Success, TWSError, T24Error, T24Override, T24Offline

### 5.3 Esquema de Tipos Comunes
**Ruta**: `ficohsacore-hntransfer-b64b1a407777/SBHN_Transfer/SBHN_Transfer_Commons/Schemas/CommonTypes.xsd`

**Descripción**: Define tipos comunes para servicios regionales

**Namespace**: https://www.ficohsa.com/regional/common/commonTypes

**Tipos complejos**:
- StatusInfoType: Status, TransactionId, ValueDate, DateTime, GlobalId
- ErrorInfoType: Code, Error, Description, ShortDescription, DateTime, GlobalId, Details
- GeneralInfoType: SourceBank, DestinationBank, GlobalId, ApplicationId, ApplicationUser, BranchId, TransactionDate, Language

### 5.4 Esquema de Array de Reversión (Referencia)
**Ruta**: `ficohsacore-hntransfer-b64b1a407777/SBHN_Transfer/SBHN_Transfer_RollbackTaxesBullletin/Schemas/ReversarTransaccionesArray.xsd`

**Descripción**: Esquema adicional para operaciones en array (no usado en esta funcionalidad)

---

## 6. WSDL

### 6.1 WSDL Regional
**Ruta**: `ficohsacore-hntransfer-b64b1a407777/SBHN_Transfer/SBHN_Transfer_RollbackTaxesBullletin/Resources/RollbackTaxesBulletin.wsdl`

**Descripción**: Contrato WSDL del servicio regional

**Namespace**: https://www.ficohsa.com/regional/transfer/transferTypes

**Port Type**: rollbackTaxesBulletinPtt

**Operación**: rollbackTaxesBulletin
- Input: requestMessage (rollbackTaxesBullletin)
- Output: replyMessage (rollbackTaxesBullletinResponse)

**Binding**: rollbackTaxesBulletinBind (SOAP/HTTP)

### 6.2 WSDL T24
**Ruta**: `ficohsacore-hntransfer-b64b1a407777/SBHN_Transfer/SBHN_Transfer_RollbackTaxesBullletin/Resources/ReversarTransaccion.wsdl`

**Descripción**: Contrato WSDL del servicio T24

**Namespace**: T24WebServicesImpl

**Operaciones**:
- rollbackTaxesBulletin
- callOfs (operación genérica OFS)

---

## 7. WADL (REST)

### 7.1 WADL REST
**Ruta**: `ficohsacore-hntransfer-b64b1a407777/SBHN_Transfer/SBHN_Transfer_RollbackTaxesBullletin/Resources/RollbackTaxesBulletinRestPS.wadl`

**Descripción**: Contrato WADL para el servicio REST

---

## 8. Archivos de Configuración

### 8.1 Proyecto JDeveloper
**Ruta**: `ficohsacore-hntransfer-b64b1a407777/SBHN_Transfer/SBHN_Transfer_RollbackTaxesBullletin/SBHN_Transfer_RollbackTaxesBullletin.jpr`

**Descripción**: Archivo de proyecto de Oracle JDeveloper

### 8.2 POM Maven
**Ruta**: `ficohsacore-hntransfer-b64b1a407777/SBHN_Transfer/SBHN_Transfer_RollbackTaxesBullletin/pom.xml`

**Descripción**: Configuración Maven para build y despliegue

### 8.3 Service Bus Overview
**Ruta**: `ficohsacore-hntransfer-b64b1a407777/SBHN_Transfer/SBHN_Transfer_RollbackTaxesBullletin/servicebus.sboverview`

**Descripción**: Vista general del proyecto OSB

---

## 9. Archivos de Metadatos (XQuery Mapper)

### 9.1 Metadata RollbackTaxesBulletinToT24
**Ruta**: `ficohsacore-hntransfer-b64b1a407777/SBHN_Transfer/SBHN_Transfer_RollbackTaxesBullletin/.settings/oracle.xquery.mapper.jdev.model/Transformations/RollbackTaxesBulletinToT24.xqy.xml`

**Descripción**: Metadatos del mapper visual de JDeveloper

### 9.2 Metadata T24ToRollbackTaxesBulletin
**Ruta**: `ficohsacore-hntransfer-b64b1a407777/SBHN_Transfer/SBHN_Transfer_RollbackTaxesBullletin/.settings/oracle.xquery.mapper.jdev.model/Transformations/T24ToRollbackTaxesBulletin.xqy.xml`

**Descripción**: Metadatos del mapper visual de JDeveloper

### 9.3 Metadata ErrorToRollbackTaxesBulletin
**Ruta**: `ficohsacore-hntransfer-b64b1a407777/SBHN_Transfer/SBHN_Transfer_RollbackTaxesBullletin/.settings/oracle.xquery.mapper.jdev.model/Transformations/ErrorToRollbackTaxesBulletin.xqy.xml`

**Descripción**: Metadatos del mapper visual de JDeveloper

---

## 10. Dependencias Externas (Módulo Commons)

### 10.1 Esquemas Comunes
- `SBHN_Transfer_Commons/Schemas/CommonTypes.xsd`
- `SBHN_Transfer_Commons/Schemas/UserLoginT24.xsd`
- `SBHN_Transfer_Commons/Resources/SBRG_Constants_Commons/Schemas/ErrorMappingRegional.xsd`

### 10.2 Transformaciones Comunes
- `SBHN_Transfer_Commons/Transformations/ExtractCredentials.xqy`
- `SBHN_Transfer_Commons/Transformations/ServicesToError.xqy`
- `SBHN_Transfer_Commons/Transformations/ServiceToLog.xqy`

### 10.3 Business Services Comunes
- `SBHN_Transfer_Commons/BS/LoggingRegionalRestBS`
- `SBHN_Transfer_Commons/BS/GetCustomErrorByStackTraceRegionalRestBS`

### 10.4 Template Común
- `SBHN_Transfer_Commons/PP/TransferHondurasFicohsaTemplate.ptx`

---

## 11. Resumen de Conteo

| Tipo de Archivo | Cantidad | Ubicación Principal |
|-----------------|----------|---------------------|
| Proxy Services | 2 | PS/ |
| Pipelines | 1 | PP/ |
| Templates | 1 | Commons/PP/ |
| Business Services | 3 | BS/ y Commons/BS/ |
| Transformaciones XQuery | 6 | Transformations/ y Commons/Transformations/ |
| Esquemas XSD | 5 | Schemas/ y Commons/Schemas/ |
| WSDL | 2 | Resources/ |
| WADL | 1 | Resources/ |
| Archivos de Configuración | 3 | Raíz del proyecto |
| Metadatos Mapper | 3 | .settings/ |
| **TOTAL** | **27** | |

---

## 12. Archivos No Encontrados (Búsqueda Realizada)

Los siguientes archivos fueron buscados pero no se encontraron en el repositorio:

- Archivos de properties específicos de región
- Archivos de configuración de políticas OWSM (gestionados por servidor)
- Archivos de configuración LDAP (gestionados por servidor)
- Tests unitarios o de integración
- Documentación técnica adicional
- Scripts de despliegue

---

## 13. Técnicas de Búsqueda Utilizadas

1. **Búsqueda por nombre**: rollbackTaxesBulletin, RollbackTaxesBulletin
2. **Búsqueda por patrón**: SBHN_Transfer_RollbackTaxesBullletin
3. **Búsqueda por extensión**: .proxy, .pipeline, .ptx, .bix, .xqy, .xsd, .wsdl, .wadl
4. **Búsqueda por referencia**: Análisis de imports y referencias en archivos
5. **Búsqueda en Commons**: Identificación de dependencias compartidas

---

## 14. Notas de Migración

### Archivos Críticos para Migración
1. Todos los archivos en `SBHN_Transfer_RollbackTaxesBullletin/`
2. Template y transformaciones comunes en `SBHN_Transfer_Commons/`
3. Configuración de seguridad LDAP (externa al repositorio)
4. Políticas OWSM (configuración de servidor)

### Archivos de Configuración Específicos de Ambiente
- URL de T24 en ReversarTransaccionSoapT24BS.bix
- Credenciales LDAP (SB_Security/Common/)
- Endpoints de servicios auxiliares (Logging, ErrorMapper)

### Orden de Despliegue Sugerido
1. Esquemas XSD comunes
2. Transformaciones comunes
3. Business Services comunes
4. Template común
5. Esquemas específicos de RollbackTaxesBulletin
6. Transformaciones específicas
7. Business Service T24
8. Pipeline
9. Proxy Services
