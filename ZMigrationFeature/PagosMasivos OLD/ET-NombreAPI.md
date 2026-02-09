---
template: v1.0
---

## 1. Control de Cambios del Documento

> Version Plantilla: v1.0

| Fecha        | Motivo                   | Realizado por                     | 
| ------------ | ------------------------ | --------------------------------- |
| *2026/02/06* | *Creación del Documento* | *David Julian Molano Peralta* |
|              |                          |                                   |
|              |                          |                                   |

[[_TOC_]]

## 2. Resumen Ejecutivo

> El **Analista SOA** describe brevemente el propósito y alcance de la API

API que permite consultar información sobre pagos masivos

## 3. Contactos y gobernanza
| Nombre | Rol | Correo Electrónico |
| ------ | --- | ------------------ |
| **David Julian Molano Peralta*** | Arquitecto de Software | julian.molano@pragma.com.co; david.j.molano@ficohsa.com
| **...** | *Analista SOA* | ... |
| **...** | *Líder Técnico* | ... |
| **...** | *Desarrollador* | ... |
| **...** | *DevOps* | ... |
| **...** | *QA* | ... |
| **...** | *Encargado de Negocio* | ... |


## 4. Documentos de Referencia

|  Nombre                      | Descripción                                                                                           |
| --------------------------- | ----------------------------------------------------------------------------------------------------- |
|[**Lineamientos de Diseño y Gobernanza de la Arquitectura de Integración - Proyecto Modernización Ficohsa**](https://dev.azure.com/DevopsFicohsa/NOVA%20-%20Modernizaci%C3%B3n%20Capa%20Integraci%C3%B3n/_wiki/wikis/Wiki%20Foundation/223/Lineamientos-de-Dise%C3%B1o-y-Gobernanza-de-la-Arquitectura-de-Integraci%C3%B3n)|Documento que establece las diferentes estrategías incluyendo el versionamiento path, políticas de depreciasión, estandar de URL, clasificación de APIs ...|
| [Diagram-Payment-Execution-Batch-Retrieve-Product..drawio](https://dev.azure.com/DevopsFicohsa/NOVA%20-%20Modernizaci%C3%B3n%20Capa%20Integraci%C3%B3n/_git/wiki-operations_execution-xrs-doc?path=/BD-Payments/SD-Payment-Execution/APIs/Payment-Execution-Batch-Retrieve-Product/T%C3%A9cnica/Diagram-Payment-Execution-Batch-Retrieve-Product..drawio&version=GBmain) | Diagrama en draw.io 
|[**Lineamiento de Manejo de Errores**](https://dev.azure.com/DevopsFicohsa/NOVA%20-%20Modernizaci%C3%B3n%20Capa%20Integraci%C3%B3n/_wiki/wikis/Wiki%20Foundation/2251/Lineamiento-de-Manejo-de-Errores?anchor=diagrama-con-manejos-comunes) | Documentación de estrategia de manejo de errores con libreria| 

## 5. Estándares soportados por la API

- **OpenAPI (versión 3.0.1):** Especificación estandarizada para describir APIs RESTful. Permite definir de forma estructurada los endpoints, parámetros, esquemas de datos, respuestas y errores, facilitando tanto el desarrollo como el consumo de la API. Comúnmente representada en formato YAML o JSON, y conocida también como Swagger.

- **JSON Schema** (draft-04): Vocabulario utilizado para validar la estructura y el contenido de objetos JSON. Se emplea para definir contratos de datos en las solicitudes y respuestas de la API.

- **Otros**: {Agregar si aplica, por ejemplo, gRPC, Protobuf, GraphQL, AsyncAPI, etc.}

## 6. Mecanismos de Acceso, Seguridad y Requisitos No Funcionales de la API

### Seguridad a nivel de la API

| Protocolo de Exposición | Identificación y Autenticación | Autorización         | Confidencialidad (Transporte / Aplicación) | Integridad | Auditabilidad |
| ----------------------- | ------------------------------ | -------------------- | ------------------------------------------ | ---------- | ------------- |
| *REST*                  | *Client Credentials*           | *Bearer Token - JWT* | *HTTPS - PGP*                              | *PGP*      | *CloudWatch*  |

*Tanto los controles de seguridad del servicio son a nivel de transporte como a nivel de aplicación.*

### Desempeño y Disponibilidad a nivel de los métodos

| Operación/Método                       | TPS  | Tiempo Respuesta Máx. (ms) | Tiempo Prom. (ms) | Coldstart (ms) | Horario Disponibilidad |
|--------------------------------------|------|----------------------------|-------------------|----------------|------------------------|
| GET: /payments/payment-execution-batch-retrieve/v1/retrieve-status            | *N/A* | *N/A* | *N/A* | *N/A* | *24/7 (asumido)* |

## 7. Requisitos Técnicos de la API

> El **Arquitecto de Software** propone y/o perfila las indicaciones técnicas de la solución

- **Lenguaje/Framework**: Ej: Java 21 + Spring Boot 3
- **Tipo de despliegue**: Ej: Contenedor (EKS)
- **Dependencias externas**: Ej: PostgreSQL, Redis, Kafka
- **Consumo de recursos**: Ej: 512Mi RAM / 0.5 CPU
<!-- - **Variables de entorno**: `DB_URL`, `REDIS_HOST`, `TOPIC_EVENTS` -->

## 8. Diagrama de Contexto (Opcional)

> El **Arquitecto de Software** (o en su defecto el Analista) podría llegar a incluir, de modo opcional, aspecto funcional con un diagrama contextual o de sistema C4 (enlace de diagrama)

[Diagrama de Contexto](https://app.diagrams.net/?splash=0#G1UCB2KiWOF51mrLzlQ51_52-ZvPxFwQn-#%7B%22pageId%22%3A%22w4PzxHJIKuQM1vVVX5xB%22%7D)

<!--
| Componente | Descripción |
| ---------- | ----------- |
| | |
| | |
| | |
-->
## 9. Diagrama de Contenedores (Opcional)

> El **Arquitecto de Software** podría llegar a incluir, de modo opcional, un diagrama de contenedores C4 o similar, el cual puede agrupar componentes (enlace de diagrama)

## 10. Diagrama de Componentes *

> El **Arquitecto de Software** propone solución con diagrama de componentes estilo **AWS** y/o estilo C4, ilustrando así el tipo de servicio (enlace de diagrama, este diagrama sí es requerido*)

-->
## 11. Diagrama de Secuencia *

###  Metodo 1 - GET - /payments/payment-execution-batch-retrieve/v1/retrieve-status

:::mermaid


sequenceDiagram
    autonumber
    participant Consumidor as Consumidore/Aplicación
    participant API as API Consulta Estado Lote Pagos Masivos v1 <br> Epica 54856: ConsultaEstadoLotePagosMasivos <br> HU 55039:  GET - /payments/payment-execution-batch-retrieve/v1/retrieve-status
    participant CL as Caché Local
    participant Lambda as Lambda de parámetros
    participant Parameter as Parameter Store
    participant Lib as Librería Pipeline (ConfigMap)
    participant Abanks as Wrapper ProxyAbanks <br/> SP: SP: OSB_P_VALIDA_ACCESO_PMS o <br/> SP: PMS_P_CON_ESTADO_LOTE
    participant pagosOLD as Wrapper Pagos Masivos <br/> Operación: consultarLote 
    participant Homologador as Liberería de <br> Homologación
    participant Errors as Control de Errores <br> <<Librería de mapeo de errores>>
    
    Note over Consumidor, Errors: Flujo Regional (HN01 | GT01 | NI01 | PA01) - Consulta Estado Lote Pagos Masivos v1

    Consumidor->>API: REST Request
    Note right of Consumidor: Header, queryParam: customerReference, bankBatchId, batchUploadDate

    API->>API: Validar Request
    Note over API: Valida campos obligatorios según contrato OpenAPI <br> customerReference (obligatorio), bankBatchId (obligatorio)

    API->>API: Validación exitosa

    alt Consulta parametros en caché local

        API->>CL: Consultar parámetros Lambda Parámetros caché local
        Note right of API: Domain: "PAYMENT_EXCECUTION_BATCH_RETRIEVE" <br> name: "v1-retrieve-status" <br> country: XRS 

        CL->>API: Obtiene parámetros Lambda Parámetros Cahé Local
        Note left of CL: Obtiene parámetros de regionalización y negocio
 
        API->>CL: Consultar parámetros Parameter Store caché local
        Note right of API: Param Name: <br> lambda.param-name-wrapper-proxy-abanks-hn o <br> lambda.param-name-cons-est-lote

        CL->>API: Obtiene parámetros Parameter Store Caché Local
        Note left of CL: Obtiene parámetros de consumo a Wrapper ProxyAbanks

    else Consulta  parametros en Lambda Parámetros / Parameter Store

        API->>Lambda: Consultar parámetros lambda parámetros
        Note right of API: Domain: "PAYMENT_EXCECUTION_BATCH_RETRIEVE" <br> name: "v1-retrieve-status" <br> country: XRS 

        Lambda->>API: Obtiene parámetros Lambda Parámetros
        Note left of Lambda: Obtiene parámetros de regionalización y negocio

        API->>CL: Guarda parámetros lambda Parámetros en caché local
        Note right of API: value.param-name 

        API->>Parameter: Consultar parámetros Parameter Store
        Note right of API: Param Name: <br> lambda.param-name-wrapper-proxy-abanks-hn o <br> lambda.param-name-cons-est-lote

        Parameter->>API: Obtiene parámetros Parameter Store
        Note left of Parameter: Obtiene parámetros de consumo a Wrapper ProxyAbanks

        API->>CL: Guarda parámetros Parameter Store en caché local
        Note right of API: Parámetros de consumo a Wrapper ProxyAbanks

    end

    API->>API: Validar Servicio Regional
    Note over API: Usando parámetros de regionalización obtenidos

    API->>API: Validación Regional Exitosa
    Note over API: Servicio habilitado para HN01 | GT01 | NI01 | PA01

    alt Flujo Honduras (HN01)

        API->>Lib: Consulta Constantes
    
        Lib->>API: Retorna constantes necesarias
        Note left of Lib: Constantes: "procedureNameValidaAcceso", "procedureNameConsultaLote"

        API->>API: Construye Request Wrapper ProxyAbanks - OSB_P_VALIDA_ACCESO_PMS
        Note over API: Mapeo: <br> CUSTOMER_ID = request.customerReference <br> USER_NAME = header.Application-User <br> procedureName = const.procedureNameValidaAcceso <br> + Campos adicionales obtenidos lambda.param-name-wrapper-proxy-abanks-hn 

        API->>Abanks: Consume Wrapper ProxyAbanks - OSB_P_VALIDA_ACCESO_PMS
        Note over API, Lambda: connectionType, operationType, catalogueName, procedureName, params(CUSTOMER_ID, USER_NAME)

        Abanks->>API: Response Wrapper ProxyAbanks - OSB_P_VALIDA_ACCESO_PMS
        Note over Abanks: Response: <br> ERROR_CODE, ERROR_MESSAGE

        API->>API: Evalúa response Valida Acceso

        alt Si response.ERROR_CODE = "SUCCESS" (Acceso válido)

            API->>API: Construye Request Wrapper ProxyAbanks - PMS_P_CON_ESTADO_LOTE
            Note over API: Mapeo: <br> PV_CODIGOCLIENTE = request.customerReference <br> PN_NUMEROLOTE = request.bankBatchId <br> PD_FECINGRESO = request.batchUploadDate <br> procedureName = const.procedureNameConsultaLote <br> + Campos adicionales obtenidos lambda.param-name-wrapper-proxy-abanks-hn

            API->>Abanks: Consume Wrapper ProxyAbanks - PMS_P_CON_ESTADO_LOTE
            Note over API, Lambda: connectionType, operationType, catalogueName, procedureName, params(PV_CODIGOCLIENTE, PN_NUMEROLOTE, PD_FECINGRESO)

            Abanks->>API: Response Wrapper ProxyAbanks - PMS_P_CON_ESTADO_LOTE
            Note over Abanks: Response: <br> Optimista + 17 campos

            API->>Homologador: Consulta Homologación result
            Note right of API: domain: "PAYMENT_EXCECUTION_BATCH_RETRIEVE"_OPTIMISTA <br> name: CATALOGATE <br> value.name: request.result

            Homologador->>API: Retorna Valor Homologado 
            Note left of Homologador: "S" → YES <br> "N" → NO 

            API->>API: Construye response API
            Note over API: Mapeo: <br> optimistic = optimista (Homologado) + 17 campos directo

            API->>Consumidor: Response Exitoso
            Note left of API: HTTP 200: Response Body 
        
        else Si response.ERROR_CODE = "ERROR" (Acceso denegado)

            API->> Errors: Mapear código de error
            
            Errors ->> API: Retorna código mapeado
            
            API->>Consumidor: Response Acceso Denegado
            Note left of API:  HTTP 403: Body: Access Denied

        end

    end

    alt FLujo Guatemala, Nicaragua y Panamá (GT01 | NI01 | PA01)

        API->>Lib: Consulta Constantes
    
        Lib->>API: Retorna constantes necesarias
        Note left of Lib: operation = "consultarLote"

        API->>API: Construye Request Wrapper Pagos Msaivos OLD
        Note over API: data(fechaRegistroLote = request.batchUploadDate, <br> idLote = lambda.queryValue, <br> idCliente = request.customerReference, <br> idBancoOrigen = header.sourceBanks) <br> + Campos adicionales"key": "param-name-cons-xrs"

        API->>pagosOLD: Consume Wrapper Pagos Masivos OLD - informacionTarjetas
        Note right of API: operation, data, paramName

        pagosOLD->>API: Response Wrapper Pagos Masivos OLD - InformacionTarjeta
        Note over pagosOLD: Response: <br> Optimista + 17 campos

        API->>Homologador: Consulta Homologación result
        Note right of API: domain: "PAYMENT_EXCECUTION_BATCH_RETRIEVE"_OPTIMISTA <br> name: CATALOGATE <br> value.name: request.result

        Homologador->>API: Retorna Valor Homologado 
        Note left of Homologador: "S" → YES <br> "N" → NO 

        API->>API: Construye response API
        Note over API: Mapeo: <br> optimistic = optimista (Homologado) + 17 campos directo

        API->>Consumidor: Response Exitoso
        Note left of API: HTTP 200: Response Body 

    end

    Note over Consumidor, Errors: Flujo Alternativo - Error
    activate API
    alt Exception occurs
        note over Errors: Error Library Handler
        activate Errors
            API->> Errors: Mapear código de error
            Errors -->> API: Retorna código mapeado
        deactivate Errors
        activate Consumidor
            API-->> Consumidor: Retorna error
        deactivate Consumidor
        Note over Consumidor,Errors: Diagrama guía de manejo de errores <br> http://bit.ly/4rpKVIU
    end
    deactivate API
:::

#### Descripción del diagrama de secuencia Metodo 1 - GET - /payments/payment-execution-batch-retrieve/v1/retrieve-status

Este diagrama de secuencia describe el flujo de la operación de consulta de estado de lote de pagos masivos (GET `/payments/payment-execution-batch-retrieve/v1/retrieve-status`) para las regionales **HN01 (Honduras)**, **GT01 (Guatemala)**, **NI01 (Nicaragua)** y **PA01 (Panamá)**. A continuación se detalla paso a paso:

**Participantes del diagrama:**

| Participante | Descripción |
|---|---|
| Consumidor/Aplicación | Sistema o aplicación cliente que invoca la API |
| API Consulta Estado Lote Pagos Masivos v1 | Microservicio principal que orquesta la consulta (Épica 54856: ConsultaEstadoLotePagosMasivos, HU 55039) |
| Caché Local | Almacenamiento en caché local para parámetros de configuración y consumo |
| Lambda de Parámetros | Función Lambda que provee parámetros de regionalización y negocio |
| Parameter Store | AWS Systems Manager Parameter Store con parámetros de consumo hacia los backends (Wrappers) |
| Librería Pipeline (ConfigMap) | Librería que provee constantes de configuración almacenadas en ConfigMap |
| Wrapper ProxyAbanks | Backend para Honduras que ejecuta los Stored Procedures: `OSB_P_VALIDA_ACCESO_PMS` (validación de acceso) y `PMS_P_CON_ESTADO_LOTE` (consulta estado del lote) |
| Wrapper Pagos Masivos OLD | Backend para Guatemala, Nicaragua y Panamá que expone la operación `consultarLote` |
| Librería de Homologación | Librería que homologa valores entre los sistemas backend y el contrato estándar de la API |
| Control de Errores | Librería de mapeo de errores estándar (Error Library Handler) |

---

**Flujo principal:**

1. **Recepción del Request (paso 1):** El Consumidor/Aplicación envía una solicitud REST a la API. La petición incluye headers requeridos y los query parameters: `customerReference`, `bankBatchId` y `batchUploadDate`.

2. **Validación del Request (pasos 2-3):** La API valida los campos obligatorios según el contrato OpenAPI: `customerReference` (obligatorio) y `bankBatchId` (obligatorio). Si la validación es exitosa, el flujo continúa.

3. **Obtención de Parámetros — Caché Local vs Lambda/Parameter Store (pasos 4-11):**

   - **Escenario A — Parámetros disponibles en caché local:**
     - Se consultan los parámetros de la Lambda de Parámetros desde el caché local utilizando: domain: `PAYMENT_EXCECUTION_BATCH_RETRIEVE`, name: `v1-retrieve-status`, country: `XRS`.
     - Se obtienen los parámetros de regionalización y negocio.
     - Se consultan los parámetros de Parameter Store desde el caché local utilizando el Param Name obtenido: `lambda.param-name-wrapper-proxy-abanks-hn` (para Honduras) o `lambda.param-name-cons-est-lote` (para GT/NI/PA).
     - Se obtienen los parámetros de consumo hacia el Wrapper ProxyAbanks o Wrapper Pagos Masivos OLD.

   - **Escenario B — Parámetros NO disponibles en caché local:**
     - Se consultan los parámetros directamente desde la Lambda de Parámetros con: domain: `PAYMENT_EXCECUTION_BATCH_RETRIEVE`, name: `v1-retrieve-status`, country: `XRS`.
     - Se obtienen los parámetros de regionalización y negocio.
     - Se guardan los parámetros obtenidos en caché local (`value.param-name`).
     - Se consultan los parámetros de Parameter Store con el Param Name correspondiente: `lambda.param-name-wrapper-proxy-abanks-hn` o `lambda.param-name-cons-est-lote`.
     - Se obtienen los parámetros de consumo hacia el Wrapper ProxyAbanks.
     - Se guardan los parámetros de Parameter Store en caché local.

4. **Validación Regional (pasos 12-13):** La API valida que el servicio esté habilitado para la regional del consumidor utilizando los parámetros de regionalización obtenidos previamente. La validación regional es exitosa si la regional pertenece a: HN01, GT01, NI01 o PA01.

5. **Flujo Honduras (HN01) (pasos 14-27):**

   - **Consulta de Constantes (pasos 14-15):** La API consulta la Librería Pipeline (ConfigMap) para obtener las constantes necesarias: `procedureNameValidaAcceso` y `procedureNameConsultaLote`.

   - **Validación de Acceso — SP `OSB_P_VALIDA_ACCESO_PMS` (pasos 16-19):**
     - Se construye el request hacia el Wrapper ProxyAbanks con el mapeo: `CUSTOMER_ID` = `request.customerReference`, `USER_NAME` = `header.Application-User`, `procedureName` = `const.procedureNameValidaAcceso`, más campos adicionales obtenidos de `lambda.param-name-wrapper-proxy-abanks-hn`.
     - Se consume el Wrapper ProxyAbanks enviando: `connectionType`, `operationType`, `catalogueName`, `procedureName`, `params(CUSTOMER_ID, USER_NAME)`.
     - Se obtiene un response con los campos: `ERROR_CODE` y `ERROR_MESSAGE`.

   - **Evaluación del response de Validación de Acceso (paso 20):**

     - **Si `ERROR_CODE` = "SUCCESS" (Acceso válido) (pasos 21-27):**
       - Se construye el request hacia el Wrapper ProxyAbanks para ejecutar el SP `PMS_P_CON_ESTADO_LOTE` con el mapeo: `PV_CODIGOCLIENTE` = `request.customerReference`, `PN_NUMEROLOTE` = `request.bankBatchId`, `PD_FECINGRESO` = `request.batchUploadDate`, `procedureName` = `const.procedureNameConsultaLote`, más campos adicionales obtenidos de `lambda.param-name-wrapper-proxy-abanks-hn`.
       - Se consume el Wrapper ProxyAbanks enviando: `connectionType`, `operationType`, `catalogueName`, `procedureName`, `params(PV_CODIGOCLIENTE, PN_NUMEROLOTE, PD_FECINGRESO)`.
       - Se obtiene un response con el campo `optimista` + 17 campos adicionales.
       - Se consulta la **Librería de Homologación** para el campo `result` (domain: `PAYMENT_EXCECUTION_BATCH_RETRIEVE_OPTIMISTA`, name: `CATALOGATE`, value.name: `request.result`), donde `"S"` se homologa a `YES` y `"N"` se homologa a `NO`.
       - Se construye el response de la API mapeando: `optimistic` = optimista (homologado) + 17 campos directos.
       - Se retorna al consumidor un **HTTP 200** con el Response Body.

     - **Si `ERROR_CODE` = "ERROR" (Acceso denegado) (pasos 28-30):**
       - Se envía el código de error a la librería de Control de Errores para su mapeo.
       - La librería retorna el código de error mapeado.
       - Se retorna al consumidor un **HTTP 403** con body: Access Denied.

6. **Flujo Guatemala, Nicaragua y Panamá (GT01 | NI01 | PA01) (pasos 31-40):**

   - **Consulta de Constantes (pasos 31-32):** La API consulta la Librería Pipeline (ConfigMap) para obtener las constantes necesarias, obteniendo `operation` = `"consultarLote"`.

   - **Consumo del Wrapper Pagos Masivos OLD (pasos 33-35):**
     - Se construye el request hacia el Wrapper Pagos Masivos OLD con el mapeo: `fechaRegistroLote` = `request.batchUploadDate`, `idLote` = `lambda.queryValue`, `idCliente` = `request.customerReference`, `idBancoOrigen` = `header.sourceBanks`, más campos adicionales del parámetro `param-name-cons-xrs`.
     - Se consume el Wrapper Pagos Masivos OLD (operación `consultarLote`) enviando: `operation`, `data`, `paramName`.
     - Se obtiene un response con el campo `optimista` + 17 campos adicionales.

   - **Homologación y Response (pasos 36-40):**
     - Se consulta la **Librería de Homologación** para el campo `result` (domain: `PAYMENT_EXCECUTION_BATCH_RETRIEVE_OPTIMISTA`, name: `CATALOGATE`, value.name: `request.result`), donde `"S"` se homologa a `YES` y `"N"` se homologa a `NO`.
     - Se construye el response de la API mapeando: `optimistic` = optimista (homologado) + 17 campos directos.
     - Se retorna al consumidor un **HTTP 200** con el Response Body.

7. **Flujo Alternativo — Error:**
   - Ante cualquier excepción no controlada durante el procesamiento, se activa el flujo alternativo de error:
     - La librería de Control de Errores (Error Library Handler) recibe el error y mapea el código de error correspondiente.
     - Se retorna el código mapeado a la API.
     - La API retorna el error al consumidor con el código HTTP y body apropiado.
     - El manejo de errores sigue el lineamiento establecido en el diagrama guía de manejo de errores (referencia: http://bit.ly/4rpKVIU).


## 12. Diagrama Adicional (Opcional)

> El **Arquitecto de Software** (o en su defecto el desarrollador), podría(n) llegar a incluir, de modo opcional, un diagrama adicional (enlace de diagrama).   
> *Por ejemplo, de despliegue con fines de soporte a futuro u otro como Clases*

[Diagrama ...](https://app.diagrams.net/?splash=0#G1UCB2KiWOF51mrLzlQ51_52-ZvPxFwQn-#%7B%22pageId%22%3A%220l_eFboT6uhBL78n1GCV%22%7D)

<!--
| Ambiente | DESARROLLO | CERTIFICACIÓN | PRODUCCIÓN |
| -------- | ---------- | ------------- | ---------- |
| Proveedor Cloud | AWS | AWS | AWS |
| Proyecto / Cluster | Ej: dev-banking | Ej: qa-banking | Ej: prod-banking |
| DNS Gateway | Ej: dev.api.banco.com | Ej: qa.api.banco.com | Ej: api.banco.com |
| Namespace API | Ej: /v1/savingsaccount | Ej: /v1/savingsaccount | Ej: /v1/savingsaccount |
| Canales MQ | | | |

### Despliegue On-Premises (En caso de aplicar):

| Ambiente | DESARROLLO | CERTIFICACIÓN | PRODUCCIÓN |
| -------- | ---------- | ------------- | ---------- |
| Servidor | | | |
| IP | | | |
| DNS/puerto | | | |
| Canal Conexión | | | |
| Usuario MQ | | | |
| Colas MQ | | | |
-->

## 13. Repositorio de Despliegue

> Información que puede gestionarse y/o escalarse desde el equipo de desarrollo

| Ambiente | Nombre del Repositorio   | Ruta           | Rama/Tag           | Observación          |
| -------- | ------------------------ | -------------- | ------------------ | -------------------- |
| Dev | `ms-ap-pex-payment_execution_batch_retrieve_product` | [Repositorio Azure](https://dev.azure.com/DevopsFicohsa/NOVA%20-%20Modernizaci%C3%B3n%20Capa%20Integraci%C3%B3n/_git/ms-ap-pex-payment_execution_batch_retrieve_product) | `develop` | Desarrollo activo |
## 14. Consideraciones relevantes en la Arquitectura

> Aquí se pueden incluir aspectos adicionales relevantes para la arquitectura de la API, como patrones de diseño, consideraciones de escalabilidad, manejo de errores, etc.

### Tags

...

<!--
### Planes de consumo de APIs (Opcional, en caso de que aplique)

| Aplicativo Consumidor | Planes | API Keys |
| --------------------- | ------ | -------- |
| Consumidor 1 | Ej: `STANDARD` | `abc123xyz` |
| Consumidor 2 | Ej: `PREMIUM` | `12345abcd` |
-->

## 15. Información complementaria del Desarrollo

### 15.1. Información complementaría Metodo 1 - GET - /payments/payment-execution-batch-retrieve/v1/retrieve-status

#### 15.1.1. DynamoDB Parameter - Parámetros método 
```json
//REGISTRO EN DYNAMODB PARAMETER - CONFIGURACIÓN POR MÉTODO
{
  "pk": "COUNTRY#XRS#DOMAIN#MANTAIN_PARTY_DIGITAL_REFRENCE#PARAM#v1-retrieve-status",
  "sk": "V#0001",
  "name": "v1-retrieve-status",
  "value": [
    {
      "region": "HN01-HN01",
      "enabled": true,
      "param-name-val-access": "ban-xrs-xx-valida-acceso-pms-param-wsdl",
      "param-name-wrapper-proxy-abanks-hn": "ban-xrs-ic-consumo-wrapper-abanks-hn-wsdl"
    },
    {
      "region": "GT01-GT01",
      "enabled": true,
      "param-name-cons-est-lote": "ban-xrs-xx-consulta-estado-lote-v1-param-wsdl-<env>",
      "queryValue": "bankBatchId"
    },
    {
      "region": "NI01-NI01",
      "enabled": true,
      "param-name-cons-est-lote": "ban-xrs-xx-consulta-estado-lote-v1-param-wsdl-<env>",
      "queryValue": "bankBatchId"
    },
    {
      "region": "PA01-PA01",
      "enabled": true,
      "param-name-cons-est-lote": "ban-xrs-xx-consulta-estado-lote-v1-param-wsdl-<env>",
      "queryValue": "bankBatchId"
    }
  ],
  "type": "JSON",
  "description": "CONFIG OF MANTAIN_PARTY_DIGITAL_REFRENCE BY METHOD",
  "country": "XRS",
  "domain": "MANTAIN_PARTY_DIGITAL_REFRENCE",
  "tags": [],
  "precedence": 10,
  "effective_from": "",
  "effective_to": "",
  "status": "active",
  "updated_at": "2025-12-19T18:10:00Z",
  "updated_by": "eudis.perdomo@ficohsa.com"
}
```
#### 15.1.2. AWS Systems Manager Parameter Store

```json
"ban-hn-ic-consumo-wrapper-abanks-hn-wsdl"
{
  "connectionType": "jca",
  "operationType": "query",
  "catalogueName": "proxyabankshn"
}
```
```json
"ban-xrs-ap-consulta-estado-lote-v1-param-wsdl-<dev>"
{
  "ip": "https://172.23.14.243",
  "port": "7004",
  "basePath": "ConsultaLotePmsWS/services/consultorLoteEndpoint"
}
```
```json
"ban-xrs-ap-consulta-estado-lote-v1-param-wsdl-<qa>"
{
  "ip": "https://172.23.179.99",
  "port": "7008",
  "basePath": "ConsultaLotePmsWS/services/consultorLoteEndpoint"
}
```
#### 15.1.3. Constantes para almacenar en ConfigMap

```json
{
  "procedureNameConsultaLote": "PMS_P_CON_ESTADO_LOTE",
  "procedureNameValidaAcceso": "OSB_P_VALIDA_ACCESO_PMS"
}
```

#### 15.1.4. Parámetros Homologación campo OPTIMISTA

```json
{
  "procedureNameConsultaLote": "PMS_P_CON_ESTADO_LOTE",
  "procedureNameValidaAcceso": "OSB_P_VALIDA_ACCESO_PMS"
}
```