# 06 - Listado de Ficheros

## Funcionalidad: SBHN_Card_RollbackPurchase

Este documento lista todos los archivos que intervienen en la funcionalidad **RollbackPurchase** para la región de Honduras (HN01).

---

## 1. Proxy Services (PS)

| Archivo | Ruta Relativa | Descripción |
|---------|---------------|-------------|
| RollbackPurchaseSoapPS.proxy | ficohsacore-hncard-488b7ad93302/SBHN_Card/SBHN_Card_RollbackPurchase/PS/RollbackPurchaseSoapPS.proxy | Proxy Service SOAP para reversar compras con tarjeta de crédito |
| RollbackPurchaseRestPS.proxy | ficohsacore-hncard-488b7ad93302/SBHN_Card/SBHN_Card_RollbackPurchase/PS/RollbackPurchaseRestPS.proxy | Proxy Service REST para reversar compras con tarjeta de crédito |

**Endpoints:**
- SOAP: `/honduras/card/soap/rollbackPurchase/v1`
- REST: `/honduras/card/rest/rollbackPurchase/v1`

---

## 2. Pipelines (PP)

| Archivo | Ruta Relativa | Descripción |
|---------|---------------|-------------|
| RollbackPurchasePP.pipeline | ficohsacore-hncard-488b7ad93302/SBHN_Card/SBHN_Card_RollbackPurchase/PP/RollbackPurchasePP.pipeline | Pipeline principal que orquesta la lógica de reversión de compras |

---

## 3. Business Services (BS)

| Archivo | Ruta Relativa | Descripción |
|---------|---------------|-------------|
| DBGetStatusTicketAdapter.bix | ficohsacore-hncard-488b7ad93302/SBHN_Card/SBHN_Card_RollbackPurchase/BS/DBGetStatusTicketAdapter.bix | Adaptador DB para consultar el estado del ticket de recaudo |
| DBActTicketAdapter.bix | ficohsacore-hncard-488b7ad93302/SBHN_Card/SBHN_Card_RollbackPurchase/BS/DBActTicketAdapter.bix | Adaptador DB para actualizar el estado del ticket de recaudo |
| onlineTransactions_v4.bix | ficohsacore-hncard-488b7ad93302/SBHN_Card/SBHN_Card_RollbackPurchase/BS/onlineTransactions_v4.bix | Business Service para invocar Vision+ (OnlineTransactions v4) |

---

## 4. Transformaciones XQuery (Transformations)

| Archivo | Ruta Relativa | Descripción |
|---------|---------------|-------------|
| RollbackPurchaseToPagosWS.xqy | ficohsacore-hncard-488b7ad93302/SBHN_Card/SBHN_Card_RollbackPurchase/Transformations/RollbackPurchaseToPagosWS.xqy | Transforma request OSB a consulta de ticket en BD |
| RollbackPurchaseToOnlinePayment.xqy | ficohsacore-hncard-488b7ad93302/SBHN_Card/SBHN_Card_RollbackPurchase/Transformations/RollbackPurchaseToOnlinePayment.xqy | Transforma datos del ticket a request de Vision+ para reversión |
| RollbackPurchaseToActTicket.xqy | ficohsacore-hncard-488b7ad93302/SBHN_Card/SBHN_Card_RollbackPurchase/Transformations/RollbackPurchaseToActTicket.xqy | Transforma request OSB a actualización de estado del ticket |
| PagosWSToRollbackPurchase.xqy | ficohsacore-hncard-488b7ad93302/SBHN_Card/SBHN_Card_RollbackPurchase/Transformations/PagosWSToRollbackPurchase.xqy | Transforma response de BD a response OSB exitoso |
| ErrorToRollbackPurchase.xqy | ficohsacore-hncard-488b7ad93302/SBHN_Card/SBHN_Card_RollbackPurchase/Transformations/ErrorToRollbackPurchase.xqy | Transforma errores a response OSB con estructura de error |

---

## 5. Esquemas XSD (Schemas)

| Archivo | Ruta Relativa | Descripción |
|---------|---------------|-------------|
| RollbackPurchaseTypes.xsd | ficohsacore-hncard-488b7ad93302/SBHN_Card/SBHN_Card_RollbackPurchase/Schemas/RollbackPurchaseTypes.xsd | Esquema del contrato OSB (request/response) |
| DBGetStatusTicketAdapter_sp.xsd | ficohsacore-hncard-488b7ad93302/SBHN_Card/SBHN_Card_RollbackPurchase/Schemas/DBGetStatusTicketAdapter_sp.xsd | Esquema del SP de consulta de ticket |
| DBActTicketAdapter_sp.xsd | ficohsacore-hncard-488b7ad93302/SBHN_Card/SBHN_Card_RollbackPurchase/Schemas/DBActTicketAdapter_sp.xsd | Esquema del SP de actualización de ticket |

---

## 6. Recursos WSDL/WADL (Resources)

| Archivo | Ruta Relativa | Descripción |
|---------|---------------|-------------|
| RollbackPurchase.wsdl | ficohsacore-hncard-488b7ad93302/SBHN_Card/SBHN_Card_RollbackPurchase/Resources/RollbackPurchase.wsdl | Contrato WSDL del servicio |
| RollbackPurchaseRestPS.wadl | ficohsacore-hncard-488b7ad93302/SBHN_Card/SBHN_Card_RollbackPurchase/Resources/RollbackPurchaseRestPS.wadl | Contrato WADL del servicio REST |
| OnlineTransactions_v4.wsdl | ficohsacore-hncard-488b7ad93302/SBHN_Card/SBHN_Card_RollbackPurchase/Resources/OnlineTransactions_v4.wsdl | Contrato WSDL de Vision+ v4 |
| DBGetStatusTicketAdapter_db.jca | ficohsacore-hncard-488b7ad93302/SBHN_Card/SBHN_Card_RollbackPurchase/Resources/DBGetStatusTicketAdapter_db.jca | Configuración JCA del adaptador de consulta |
| DBGetStatusTicketAdapter-concrete.wsdl | ficohsacore-hncard-488b7ad93302/SBHN_Card/SBHN_Card_RollbackPurchase/Resources/DBGetStatusTicketAdapter-concrete.wsdl | WSDL concreto del adaptador de consulta |
| DBGetStatusTicketAdapter.wsdl | ficohsacore-hncard-488b7ad93302/SBHN_Card/SBHN_Card_RollbackPurchase/Resources/DBGetStatusTicketAdapter.wsdl | WSDL abstracto del adaptador de consulta |
| DBActTicketAdapter_db.jca | ficohsacore-hncard-488b7ad93302/SBHN_Card/SBHN_Card_RollbackPurchase/Resources/DBActTicketAdapter_db.jca | Configuración JCA del adaptador de actualización |
| DBActTicketAdapter-concrete.wsdl | ficohsacore-hncard-488b7ad93302/SBHN_Card/SBHN_Card_RollbackPurchase/Resources/DBActTicketAdapter-concrete.wsdl | WSDL concreto del adaptador de actualización |
| DBActTicketAdapter.wsdl | ficohsacore-hncard-488b7ad93302/SBHN_Card/SBHN_Card_RollbackPurchase/Resources/DBActTicketAdapter.wsdl | WSDL abstracto del adaptador de actualización |

---

## 7. Componentes Comunes (Commons)

### 7.1 Templates

| Archivo | Ruta Relativa | Descripción |
|---------|---------------|-------------|
| HondurasCardTemplate.ptx | ficohsacore-hncard-488b7ad93302/SBHN_Card/SBHN_Card_Commons/PP/HondurasCardTemplate.ptx | Template común para servicios de tarjetas Honduras (logging, error handling) |

### 7.2 Business Services Comunes

| Archivo | Ruta Relativa | Descripción |
|---------|---------------|-------------|
| GetCustomErrorByStackTraceRegionalRestBS.bix | ficohsacore-hncard-488b7ad93302/SBHN_Card/SBHN_Card_Commons/BS/GetCustomErrorByStackTraceRegionalRestBS.bix | Servicio de mapeo de errores regional |
| LoggingRegionalRestBS.bix | ficohsacore-hncard-488b7ad93302/SBHN_Card/SBHN_Card_Commons/BS/LoggingRegionalRestBS.bix | Servicio de logging regional |
| GetParametersRestBS.bix | ficohsacore-hncard-488b7ad93302/SBHN_Card/SBHN_Card_Commons/BS/GetParametersRestBS.bix | Servicio de consulta de parámetros |

### 7.3 Transformaciones Comunes

| Archivo | Ruta Relativa | Descripción |
|---------|---------------|-------------|
| ServicesToError.xqy | ficohsacore-hncard-488b7ad93302/SBHN_Card/SBHN_Card_Commons/Transformations/ServicesToError.xqy | Transforma errores de servicios a formato de consulta de mapeo |
| ServiceToLog.xqy | ficohsacore-hncard-488b7ad93302/SBHN_Card/SBHN_Card_Commons/Transformations/ServiceToLog.xqy | Transforma datos de servicio a formato de log |

### 7.4 Esquemas Comunes

| Archivo | Ruta Relativa | Descripción |
|---------|---------------|-------------|
| CommonTypes.xsd | ficohsacore-hncard-488b7ad93302/SBHN_Card/SBHN_Card_Commons/Schemas/CommonTypes.xsd | Tipos comunes (GeneralInfo, StatusInfo, ErrorInfo) |
| CustomParameter.xsd | ficohsacore-hncard-488b7ad93302/SBHN_Card/SBHN_Card_Commons/Resources/SBRG_Constants_Commons/Schemas/CustomParameter.xsd | Esquema de parámetros personalizados |
| ErrorMappingRegional.xsd | ficohsacore-hncard-488b7ad93302/SBHN_Card/SBHN_Card_Commons/Resources/SBRG_Constants_Commons/Schemas/ErrorMappingRegional.xsd | Esquema de mapeo de errores regional |
| LoggingRegional.xsd | ficohsacore-hncard-488b7ad93302/SBHN_Card/SBHN_Card_Commons/Resources/SBRG_Logging_Commons/Schemas/LoggingRegional.xsd | Esquema de logging regional |

---

## 8. Configuración y Políticas

### 8.1 Políticas de Seguridad

- **Política OWSM**: `oracle/http_basic_auth_over_ssl_service_policy`
  - Aplicada en: RollbackPurchaseSoapPS, RollbackPurchaseRestPS
  - Tipo: HTTP Basic Authentication sobre SSL

### 8.2 Dispatch Policy

- **SBCardManager**: Política de despacho para gestión de threads en servicios de tarjetas

### 8.3 Conexiones a Base de Datos

- **ConnectionPagosWSTC**: `jca://eis/DB/ConnectionPagosWSTC`
  - Esquema: `PAGOSWSTC`
  - Package: `OSB_K_RECAUDO_BROKER_HN`

---

## 9. Stored Procedures

| Stored Procedure | Esquema | Package | Descripción |
|------------------|---------|---------|-------------|
| OSB_CONS_BROKER_RECAUDO_TICKET | PAGOSWSTC | OSB_K_RECAUDO_BROKER_HN | Consulta el estado y datos de un ticket de recaudo |
| OSB_ACT_BROKER_RECAUDO_TICKET | PAGOSWSTC | OSB_K_RECAUDO_BROKER_HN | Actualiza el estado de un ticket de recaudo |

---

## 10. Servicios Externos

### 10.1 Vision+ (OnlineTransactions v4)

- **Endpoint**: `http://172.28.1.145:7802/OTWS/v4`
- **Operación utilizada**: `OnlineUpdateCard`
- **Timeout**: 70 segundos
- **Connection Timeout**: 65 segundos
- **Protocolo**: SOAP/HTTP

---

## 11. Configuración de Retry

### 11.1 DB Adapters

- **Retry Count**: 4
- **Retry Interval**: 1 segundo
- **Retry Backoff**: 2
- **Max Interval**: 120 segundos

### 11.2 Vision+ Service

- **Retry Count**: 0 (sin retry automático)
- **Retry Interval**: 0

---

## 12. Archivos de Proyecto

| Archivo | Ruta Relativa | Descripción |
|---------|---------------|-------------|
| SBHN_Card_RollbackPurchase.jpr | ficohsacore-hncard-488b7ad93302/SBHN_Card/SBHN_Card_RollbackPurchase/SBHN_Card_RollbackPurchase.jpr | Proyecto JDeveloper del módulo |
| servicebus.sboverview | ficohsacore-hncard-488b7ad93302/SBHN_Card/SBHN_Card_RollbackPurchase/servicebus.sboverview | Vista general del Service Bus |
| pom.xml | ficohsacore-hncard-488b7ad93302/SBHN_Card/SBHN_Card_RollbackPurchase/pom.xml | Configuración Maven del proyecto |

---

## 13. Resumen de Dependencias

### Dependencias Internas (OSB)
- SBHN_Card_Commons (templates, transformaciones, esquemas comunes)

### Dependencias Externas
- Base de Datos Oracle (PAGOSWSTC)
- Vision+ v4 (Procesador de tarjetas)

### Frameworks y Librerías
- Oracle Service Bus 12c
- Oracle Database Adapter
- XQuery 1.0
- SOAP 1.1
- REST

---

## 14. Convenciones de Nomenclatura

- **PS (Proxy Services)**: `*PS.proxy`
- **PP (Pipelines)**: `*PP.pipeline`
- **BS (Business Services)**: `*.bix`
- **Transformaciones**: `*.xqy`
- **Esquemas**: `*.xsd`
- **WSDL**: `*.wsdl`
- **WADL**: `*.wadl`
- **JCA**: `*_db.jca`

---

**Nota**: Todos los archivos están ubicados bajo el directorio base:
`ficohsa-capa-media/Fuentes/ficohsacore-hncard-488b7ad93302/`
