## 1. Control de Cambios del Documento

> Version Plantilla: v1.0

| Fecha        | Motivo                   | Realizado por                     | 
| ------------ | ------------------------ | --------------------------------- |
| *2026/01/06* | *Creación del Documento* | *David Julián Molano Peralta* |
|              |                          |                                   |

[[_TOC_]]

## 2. Resumen Ejecutivo

> El **Analista SOA** describe brevemente el propósito y alcance de la API

API permite consultar la información de las entidades financieras disponibles para transferencias ACH

## 3. Contactos y gobernanza
| Nombre | Rol | Correo Electrónico |
| ------ | --- | ------------------ |
| **David Julián Molano Peralta** | Arquitecto de Software | julian.molano@pragma.com.co; david.j.molano@ficohsa.com
| **Harold René Barón Franco** | *Analista SOA* | ... |
| **...** | *Líder Técnico* | ... |
| **...** | *Desarrollador* | ... |
| **...** | *DevOps* | ... |
| **...** | *QA* | ... |
| **...** | *Encargado de Negocio* | ... |


## 4. Documentos de Referencia

| Nombre | Descripción | 
| ------ | ----------- |  
| **Adjuntar Colección Postman** | Artefacto que pemritirá hacer pruebas rápidas de la API con endpoints y ejemplos de consumos | ... 
| [**Lineamientos de Diseño y Gobernanza de la Arquitectura de Integración - Proyecto Modernización Ficohsa**](https://dev.azure.com/DevopsFicohsa/NOVA%20-%20Modernizaci%C3%B3n%20Capa%20Integraci%C3%B3n/_wiki/wikis/Wiki%20Foundation/223/Lineamientos-de-Dise%C3%B1o-y-Gobernanza-de-la-Arquitectura-de-Integraci%C3%B3n) | Documento que establece las diferentes estrategías incluyendo el versionamiento path, políticas de depreciasión, estandar de URL, clasificación de APIs ... | 
| [Diagram-PaymentRailOperationsRetrieve-Product](http://dev.azure.com/DevopsFicohsa/NOVA%20-%20Modernizaci%C3%B3n%20Capa%20Integraci%C3%B3n/_git/wiki-operations_execution-xrs-doc?path=/BD-Payments/SD-Payment-Execution/APIs/PaymentExecutionAdmin-Product/T%C3%A9cnica/Diagram-PaymentExecutionAdmin-Product.drawio) | Diagrama en draw.io 
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
| GET: /payments/payment-rail-operations-retrieves/v1/retrieve           | *N/A* | *N/A* | *N/A* | *N/A* | *24/7 (asumido)* |

## 7. Requisitos Técnicos de la API

> El **Arquitecto de Software** propone y/o perfila las indicaciones técnicas de la solución

- **Lenguaje/Framework**: Ej: Java 21 + Spring Boot 3
- **Tipo de despliegue**: Ej: Contenedor (EKS)
- **Dependencias externas**: Ej: PostgreSQL, Redis, Kafka
- **Consumo de recursos**: Ej: 512Mi RAM / 0.5 CPU
<!-- - **Variables de entorno**: `DB_URL`, `REDIS_HOST`, `TOPIC_EVENTS` -->

## 8. Diagrama de Contexto (Opcional)

> El **Arquitecto de Software** (o en su defecto el Analista) podría llegar a incluir, de modo opcional, aspecto funcional con un diagrama contextual o de sistema C4 (enlace de diagrama)

<!--
| Componente | Descripción |
| ---------- | ----------- |
| | |
| | |
| | |
-->
## 9. Diagrama de Contenedores (Opcional)

> El **Arquitecto de Software** podría llegar a incluir, de modo opcional, un diagrama de contenedores C4 o similar, el cual puede agrupar componentes (enlace de diagrama)

<!--
| Componente | Descripción |
| ---------- | ----------- |
| | |
| | |
| | |
-->
## 10. Diagrama de Componentes *

> El **Arquitecto de Software** propone solución con diagrama de componentes estilo **AWS** y/o estilo C4, ilustrando así el tipo de servicio (enlace de diagrama, este diagrama sí es requerido*)

<!--
| Componente | Tipo | Función |
| ---------- | ---- | ------- |
| Ej: `savingsaccount-service` | Microservicio | Expone lógica de negocio para cuentas de ahorro |
| Ej: `legacy-wrapper-cobis` | Wrapper | Adaptador a sistema COBIS |
| Ej: `audit-proxy` | BFF | Envía logs y trazas al sistema de auditoría |
-->
## 11. Diagrama de Secuencia *

> El **Arquitecto de Software** ilustra interacción con diagrama de secuencia **UML** (enlace de diagrama o mermaid incrustado, este diagrama sí es requerido*).  
> *Puede usarse un diagrama global o uno por método, según complejidad.*

###  Metodo 1 - GET /payments/payment-rail-operations-retrieves/v1/retrieve

:::mermaid

sequenceDiagram
    autonumber
    participant Consumidor as Consumidore/Aplicación
    participant API as ConsultaFinancierasACH - Product <br> Epica 2218: ConsultaFinancierasACH <br> HU 5600:  GET - /payments/payment-rail-operations-retrieves/v1/retrieve
    participant LibraryPipeline as Library Pipeline <br> Currency Exchange Retrieves-Product
    participant WT24 as Wrapper T24 <br> Op: ConsultadedestinosACH
    participant FPC as Wrapper FICOPEN <br> /api/v2/entes/bancos
    participant WPABGT as Wrapper Proxy Abanks GT <br> PKG: OSB_K_CONFINANCIERAS <br> SP: TOPLEVEL$OSB_P_CON_FINANCIERA
    participant WPABPA as Wrapper Proxy Abanks PA <br> PKG: OSB_K_CONFINANCIERAS <br> SP: TOPLEVEL$OSB_P_CON_FINANCIERA
    participant WCTS as Wrapper CTS NI <br> OpConsultaFinacierasACH
    participant Lambda as Lambda Parámetros <br>
    participant Errors as Control de Errores <br/> <<Librería de mapeo de errores>>

    Note over Consumidor, Errors: Flujo Honduras Core (HN01) - ConsultaFinancierasACH | HN02 - Ficopen <br> | GT01 - Proxy Abanks GT | PA01 - Proxy Abanks PA | NI01 - CTS Nicaragua

    Consumidor->>API: REST Request
    Note right of Consumidor: Header: SourceBank=HN01 <br/> queryParam: destinationInstitutionReference (opcional)

    API->>API: Validar Request
    Note over  API: Validar obligatoriedad campos según contrato OpenAPI

    API->>API: Validación exitosa

    API->>API: Validar Servicio Regional
    Note over API: key de config: PAYMENT_RAIL_OPERATIONS_RETRIEVES
    
    API->>API: Validación Regional Exitosa
    Note over API: Servicio habilitado para HN01 | HN02 | GT01 | PA01 | NI01

    API->>API: Patron Strategy Enrutamiento Regional
    Note over API: Branch: SourceBank = (HN01 | HN02 | GT01 | PA01 | NI01)

    alt Flujo para HN01

        API->>API: Estrategia Regional Seleccionada: HN01

        API->>LibraryPipeline: Consulta Constantes de Pipeline

        LibraryPipeline->>API: Retorna Constantes de Pipeline
        Note over LibraryPipeline: Constantes que retorna <br> columnName = @ID <br/> operand = EQ
        
        API->>API: Construir Request Wrapper T24
        Note over API: Request: <br> columnName = @ID <br> criteriaValue = DESTINATION_CODE (Opcional) <br> operand = EQ

        API->>WT24: Invocar Operación ConsultadedestinosACH

        WT24->>API: Response con Datos
        Note left of WT24: ResponseHeader <br> consultaFinancierasACHResponse

        API->>API: Transformar Response
        Note over API: Transforma datos de productos separados por "||" <br> según ejemplo transformación de response HN T24 

        API->>Consumidor: REST Response Exitosa
        Note right of Consumidor: body.data

    end 

    alt Flujo para HN02 - Pensiones

        API->>API: Estrategia Regional Seleccionada: HN02
        
        API->>FPC: Consume Wrapper FICOPEN - GET

        FPC->>API: Response Wrapper FICOPEN
        Note left of FPC: Rest Response JSON

        API->>API: Transformar Response
        Note over API: destinationInstitutionReference = datos.entes.codigo <br> destinationInstitutionName = datos.entes.descripcion

        API->>Consumidor: REST Response Exitosa
        Note right of Consumidor: destinationInstitutionReference <br> destinationInstitutionName

    end

    alt Flujo para GT01 - Proxy Abanks Guatemala

        API->>API: Estrategia Regional Seleccionada: GT01

        API->>API: Construye Request ProxyAbanks GT
        Note over API: DESTINATION_CODE = destinationInstitutionReference (opcional)
        
        API->>WPABGT: Consume Wrapper Proxy Abanks GT

        WPABGT->>API: Response Wrapper Proxy Abanks GT
        Note left of WPABGT: Response con datos planos

        API->>API: Transformar Response
        Note over API: Realiza agrupación de datos planos <br> según ejemplo transformación response GT

        API->>Consumidor: REST Response Exitosa
        Note right of Consumidor: body.data

    end

    alt Flujo para PA01 - Proxy Abanks Panamá

        API->>API: Estrategia Regional Seleccionada: PA01

        API->>API: Construye Request ProxyAbanks PA
        Note over API: DESTINATION_CODE = destinationInstitutionReference (opcional)
        
        API->>WPABPA: Consume Wrapper Proxy Abanks PA

        WPABPA->>API: Response Wrapper Proxy Abanks PA
        Note left of WPABPA: Response con datos planos

        API->>API: Transformar Response
        Note over API: Realiza agrupación de datos planos <br> según ejemplo transformación response PA

        API->>Consumidor: REST Response Exitosa
        Note right of Consumidor: body.data

    end

    alt Flujo para NI01 - Wrapper CTS Nicaragua

        API->>API: Estrategia Regional Seleccionada: NI01

        API->>API: Construye Request Wrapper CTS Nicaragua
        Note over API: DESTINATION_CODE = destinationInstitutionReference (opcional)
        
        API->>WCTS: Consume Wrapper CTS Nicaragua

        WCTS->>API: Response Wrapper CTS Nicaragua
        Note left of WCTS: Response con datos planos

        API->>API: Evalúa Response Wrapper CTS Nicaragua

        alt Si successIndicator = SUCCESS

            API->>Lambda: Consulta Lamda de parámetros
            Note right of API: Parámetros <br> name: ProducTypesParamNI

            Lambda->>API: Obtiene parámetros
            Note left of Lambda: Parámetros <br> MIN_PRODUCT_ID_LENGTH = 1 <br> MAX_PRODUCT_ID_LENGTH = 100 <br> LEADING_ZEROS_YES_NO = YES <br> PRODUCT_ID_SAMPLE = ""

            API->>API: Transformar Response
            Note over API: Delimita productos por cada "|" <br> Asigna valores parametrizados

            API->>Consumidor: REST Response Exitosa
            Note right of Consumidor: body.data

        end

    end

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

    Note over Consumidor, Errors: Reglas de Negocio Aplicadas:<br/>1. Filtro condicional por DESTINATION_CODE opcional
:::

### Descripción del diagrama


## 12. Diagrama Adicional (Opcional)

> El **Arquitecto de Software** (o en su defecto el desarrollador), podría(n) llegar a incluir, de modo opcional, un diagrama adicional (enlace de diagrama).   
> *Por ejemplo, de despliegue con fines de soporte a futuro u otro como Clases*

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
| Dev      | `ms-ap-pro-payment-rail-operations-retrieves` | [Repositorio Azure](https://dev.azure.com/DevopsFicohsa/NOVA%20-%20Modernizaci%C3%B3n%20Capa%20Integraci%C3%B3n/_git/ms-ap-pro-payment-rail-operations-retrieves)  | `develop`          | Desarrollo activo    |


## 14. Consideraciones relevantes en la Arquitectura

> Aquí se pueden incluir aspectos adicionales relevantes para la arquitectura de la API, como patrones de diseño, consideraciones de escalabilidad, manejo de errores, etc.


Se definen las validaciones de entrada mínimas que el servicio debe aplicar antes de procesar la solicitud:

- Cabeceras obligatorias:
  - Authorization: Bearer <token> (token válido y con scope/claims requeridos).
  - Content-Type: application/json (para payloads si aplica).


- Reintentos y timeouts:
  - Timeout por llamada a producto: 35s (configurable).

- Auditoría y trazabilidad:
  - Correlation-Id (si no viene, generar uno) y propagar a llamadas a proveedores.
  - Registrar eventos de validación fallida (nivel WARN/ERROR) en el sistema de logging/observabilidad.

- Tests y contract checks:
  - Validaciones deben estar cubiertas por pruebas unitarias y de contrato (OpenAPI/JSON Schema).
  - Cobertura de código al 85%

<!--
### Planes de consumo de APIs (Opcional, en caso de que aplique)

| Aplicativo Consumidor | Planes | API Keys |
| --------------------- | ------ | -------- |
| Consumidor 1 | Ej: `STANDARD` | `abc123xyz` |
| Consumidor 2 | Ej: `PREMIUM` | `12345abcd` |
-->

## 15. Información complementaria del Desarrollo

### 15.1. Ejemplos de transformación para los response de cada país en el AS-IS

#### Ejemplo Transformación Response para Hondura Core T24 AS-IS

##### ¿Qué hace este código?

Transforma datos de bancos donde **cada banco tiene sus productos concatenados en un solo string separado por "||"** y los convierte en una estructura jerárquica XML con productos individuales.

---

##### Código oirignal

```xquery
<ns1:consultaFinancierasACHResponse>
    <ns1:consultaFinancierasACHResponseType>
        {
            let $ids := $consultadedestinosACHResponse1/WSACHBANKLISTType[1]/gWSACHBANKLISTDetailType/mWSACHBANKLISTDetailType/ID
            let $descriptions := $consultadedestinosACHResponse1/WSACHBANKLISTType[1]/gWSACHBANKLISTDetailType/mWSACHBANKLISTDetailType/DESCRIPTION
            let $productTypes := $consultadedestinosACHResponse1/WSACHBANKLISTType[1]/gWSACHBANKLISTDetailType/mWSACHBANKLISTDetailType/PRODUCTTYPE
            let $productMinLengths := $consultadedestinosACHResponse1/WSACHBANKLISTType[1]/gWSACHBANKLISTDetailType/mWSACHBANKLISTDetailType/PRODIDMINLENGTH
            let $productMaxLengths := $consultadedestinosACHResponse1/WSACHBANKLISTType[1]/gWSACHBANKLISTDetailType/mWSACHBANKLISTDetailType/PRODIDMAXLENGTH
            let $productLeadZeros := $consultadedestinosACHResponse1/WSACHBANKLISTType[1]/gWSACHBANKLISTDetailType/mWSACHBANKLISTDetailType/PRODIDLEADZEROS
            let $productIdSampless := $consultadedestinosACHResponse1/WSACHBANKLISTType[1]/gWSACHBANKLISTDetailType/mWSACHBANKLISTDetailType/PRODIDSAMPLE
            
            for $i in (1 to count($ids))
                return 
                <ns1:consultaFinancierasACHResponseRecordType>
                    <DESTINATION_CODE>{ data($ids[$i]) }</DESTINATION_CODE>
                    <DESTINATION_NAME>{ data($descriptions[$i]) }</DESTINATION_NAME>
                    <ns1:consultaFinancierasACHDetailResponseType>
                    {
                        let $productType := fn:tokenize($productTypes[$i], '\|\|')
                        let $productMinLength := fn:tokenize($productMinLengths[$i], '\|\|')
                        let $productMaxLength := fn:tokenize($productMaxLengths[$i], '\|\|')
                        let $productLeadZero := fn:tokenize($productLeadZeros[$i], '\|\|')
                        let $productIdSample := fn:tokenize($productIdSampless[$i], '\|\|')
                        
                        for $j in 1 to (max ( (count($productType), count($productMinLength), count($productMaxLength),
                                              count($productLeadZero), count($productIdSample))))
                        return
                            if (data($productType[$j]) != "" or data($productMinLength[$j]) != "" or data($productMaxLength[$j]) != ""
                                or data($productLeadZero[$j]) != "" or data($productIdSample[$j]) != "") then (
                            <ns1:consultaFinancierasACHDetailResponseRecordType>
                                <TYPE_OF_PRODUCT>{ data($productType[$j]) }</TYPE_OF_PRODUCT>
                                <MIN_PRODUCT_ID_LENGTH>{ data($productMinLength[$j]) }</MIN_PRODUCT_ID_LENGTH>
                                <MAX_PRODUCT_ID_LENGTH>{ data($productMaxLength[$j]) }</MAX_PRODUCT_ID_LENGTH>
                                <LEADING_ZEROS_YES_NO>{ data($productLeadZero[$j]) }</LEADING_ZEROS_YES_NO>
                                <PRODUCT_ID_SAMPLE>{ data($productIdSample[$j]) }</PRODUCT_ID_SAMPLE>
                            </ns1:consultaFinancierasACHDetailResponseRecordType>
                            ) else ()
                    }
                    </ns1:consultaFinancierasACHDetailResponseType>
                </ns1:consultaFinancierasACHResponseRecordType>
        }
    </ns1:consultaFinancierasACHResponseType>
</ns1:consultaFinancierasACHResponse>
```
##### Estructura del proceso

###### PASO 1: Extracción de listas principales (variables `let`)

Extrae todas las listas de datos de bancos del response original:

```xquery
let $ids := ... /ID
let $descriptions := ... /DESCRIPTION
let $productTypes := ... /PRODUCTTYPE
let $productMinLengths := ... /PRODIDMINLENGTH
let $productMaxLengths := ... /PRODIDMAXLENGTH
let $productLeadZeros := ... /PRODIDLEADZEROS
let $productIdSampless := ... /PRODIDSAMPLE
```

###### PASO 2: Iteración por cada banco

```xquery
for $i in (1 to count($ids))
```

Recorre CADA banco (uno por uno).

---

##### Ejemplo con datos reales

###### INPUT (Response original)

```xml
<consultadedestinosACHResponse1>
    <WSACHBANKLISTType>
        <gWSACHBANKLISTDetailType>
            <mWSACHBANKLISTDetailType>
                <ID>001</ID>
                <DESCRIPTION>BANCO DE BOGOTA</DESCRIPTION>
                <PRODUCTTYPE>AHORROS||CORRIENTE||CREDITO</PRODUCTTYPE>
                <PRODIDMINLENGTH>10||10||15</PRODIDMINLENGTH>
                <PRODIDMAXLENGTH>12||12||18</PRODIDMAXLENGTH>
                <PRODIDLEADZEROS>YES||YES||NO</PRODIDLEADZEROS>
                <PRODIDSAMPLE>0012345678||0098765432||123456789012345</PRODIDSAMPLE>
            </mWSACHBANKLISTDetailType>
            
            <mWSACHBANKLISTDetailType>
                <ID>002</ID>
                <DESCRIPTION>BANCOLOMBIA</DESCRIPTION>
                <PRODUCTTYPE>AHORROS||CORRIENTE</PRODUCTTYPE>
                <PRODIDMINLENGTH>11||11</PRODIDMINLENGTH>
                <PRODIDMAXLENGTH>13||13</PRODIDMAXLENGTH>
                <PRODIDLEADZEROS>NO||NO</PRODIDLEADZEROS>
                <PRODIDSAMPLE>12345678901||98765432101</PRODIDSAMPLE>
            </mWSACHBANKLISTDetailType>
        </gWSACHBANKLISTDetailType>
    </WSACHBANKLISTType>
</consultadedestinosACHResponse1>
```

---

##### Procesamiento detallado

###### Para el BANCO 1 (i=1):

**1. Se extraen los datos básicos:**
```xquery
$ids[1] = "001"
$descriptions[1] = "BANCO DE BOGOTA"
$productTypes[1] = "AHORROS||CORRIENTE||CREDITO"
$productMinLengths[1] = "10||10||15"
$productMaxLengths[1] = "12||12||18"
$productLeadZeros[1] = "YES||YES||NO"
$productIdSampless[1] = "0012345678||0098765432||123456789012345"
```

**2. Se dividen (tokenize) por el separador "||":**
```xquery
$productType = ["AHORROS", "CORRIENTE", "CREDITO"]
$productMinLength = ["10", "10", "15"]
$productMaxLength = ["12", "12", "18"]
$productLeadZero = ["YES", "YES", "NO"]
$productIdSample = ["0012345678", "0098765432", "123456789012345"]
```

**3. Se calcula el máximo de elementos:**
```xquery
max(count($productType), count($productMinLength), ...) = 3
```
Esto asegura que recorra todos los productos aunque alguna lista sea más corta.

**4. Loop interno (j=1 to 3) - genera cada producto:**

**Iteración j=1:**
```xml
<ns1:consultaFinancierasACHDetailResponseRecordType>
    <TYPE_OF_PRODUCT>AHORROS</TYPE_OF_PRODUCT>
    <MIN_PRODUCT_ID_LENGTH>10</MIN_PRODUCT_ID_LENGTH>
    <MAX_PRODUCT_ID_LENGTH>12</MAX_PRODUCT_ID_LENGTH>
    <LEADING_ZEROS_YES_NO>YES</LEADING_ZEROS_YES_NO>
    <PRODUCT_ID_SAMPLE>0012345678</PRODUCT_ID_SAMPLE>
</ns1:consultaFinancierasACHDetailResponseRecordType>
```

**Iteración j=2:**
```xml
<ns1:consultaFinancierasACHDetailResponseRecordType>
    <TYPE_OF_PRODUCT>CORRIENTE</TYPE_OF_PRODUCT>
    <MIN_PRODUCT_ID_LENGTH>10</MIN_PRODUCT_ID_LENGTH>
    <MAX_PRODUCT_ID_LENGTH>12</MAX_PRODUCT_ID_LENGTH>
    <LEADING_ZEROS_YES_NO>YES</LEADING_ZEROS_YES_NO>
    <PRODUCT_ID_SAMPLE>0098765432</PRODUCT_ID_SAMPLE>
</ns1:consultaFinancierasACHDetailResponseRecordType>
```

**Iteración j=3:**
```xml
<ns1:consultaFinancierasACHDetailResponseRecordType>
    <TYPE_OF_PRODUCT>CREDITO</TYPE_OF_PRODUCT>
    <MIN_PRODUCT_ID_LENGTH>15</MIN_PRODUCT_ID_LENGTH>
    <MAX_PRODUCT_ID_LENGTH>18</MAX_PRODUCT_ID_LENGTH>
    <LEADING_ZEROS_YES_NO>NO</LEADING_ZEROS_YES_NO>
    <PRODUCT_ID_SAMPLE>123456789012345</PRODUCT_ID_SAMPLE>
</ns1:consultaFinancierasACHDetailResponseRecordType>
```

---

##### OUTPUT COMPLETO (Body Out)

```xml
<ns1:consultaFinancierasACHResponse>
    <ns1:consultaFinancierasACHResponseType>
        
        <!-- BANCO 1 -->
        <ns1:consultaFinancierasACHResponseRecordType>
            <DESTINATION_CODE>001</DESTINATION_CODE>
            <DESTINATION_NAME>BANCO DE BOGOTA</DESTINATION_NAME>
            
            <ns1:consultaFinancierasACHDetailResponseType>
                <ns1:consultaFinancierasACHDetailResponseRecordType>
                    <TYPE_OF_PRODUCT>AHORROS</TYPE_OF_PRODUCT>
                    <MIN_PRODUCT_ID_LENGTH>10</MIN_PRODUCT_ID_LENGTH>
                    <MAX_PRODUCT_ID_LENGTH>12</MAX_PRODUCT_ID_LENGTH>
                    <LEADING_ZEROS_YES_NO>YES</LEADING_ZEROS_YES_NO>
                    <PRODUCT_ID_SAMPLE>0012345678</PRODUCT_ID_SAMPLE>
                </ns1:consultaFinancierasACHDetailResponseRecordType>
                
                <ns1:consultaFinancierasACHDetailResponseRecordType>
                    <TYPE_OF_PRODUCT>CORRIENTE</TYPE_OF_PRODUCT>
                    <MIN_PRODUCT_ID_LENGTH>10</MIN_PRODUCT_ID_LENGTH>
                    <MAX_PRODUCT_ID_LENGTH>12</MAX_PRODUCT_ID_LENGTH>
                    <LEADING_ZEROS_YES_NO>YES</LEADING_ZEROS_YES_NO>
                    <PRODUCT_ID_SAMPLE>0098765432</PRODUCT_ID_SAMPLE>
                </ns1:consultaFinancierasACHDetailResponseRecordType>
                
                <ns1:consultaFinancierasACHDetailResponseRecordType>
                    <TYPE_OF_PRODUCT>CREDITO</TYPE_OF_PRODUCT>
                    <MIN_PRODUCT_ID_LENGTH>15</MIN_PRODUCT_ID_LENGTH>
                    <MAX_PRODUCT_ID_LENGTH>18</MAX_PRODUCT_ID_LENGTH>
                    <LEADING_ZEROS_YES_NO>NO</LEADING_ZEROS_YES_NO>
                    <PRODUCT_ID_SAMPLE>123456789012345</PRODUCT_ID_SAMPLE>
                </ns1:consultaFinancierasACHDetailResponseRecordType>
            </ns1:consultaFinancierasACHDetailResponseType>
        </ns1:consultaFinancierasACHResponseRecordType>
        
        <!-- BANCO 2 -->
        <ns1:consultaFinancierasACHResponseRecordType>
            <DESTINATION_CODE>002</DESTINATION_CODE>
            <DESTINATION_NAME>BANCOLOMBIA</DESTINATION_NAME>
            
            <ns1:consultaFinancierasACHDetailResponseType>
                <ns1:consultaFinancierasACHDetailResponseRecordType>
                    <TYPE_OF_PRODUCT>AHORROS</TYPE_OF_PRODUCT>
                    <MIN_PRODUCT_ID_LENGTH>11</MIN_PRODUCT_ID_LENGTH>
                    <MAX_PRODUCT_ID_LENGTH>13</MAX_PRODUCT_ID_LENGTH>
                    <LEADING_ZEROS_YES_NO>NO</LEADING_ZEROS_YES_NO>
                    <PRODUCT_ID_SAMPLE>12345678901</PRODUCT_ID_SAMPLE>
                </ns1:consultaFinancierasACHDetailResponseRecordType>
                
                <ns1:consultaFinancierasACHDetailResponseRecordType>
                    <TYPE_OF_PRODUCT>CORRIENTE</TYPE_OF_PRODUCT>
                    <MIN_PRODUCT_ID_LENGTH>11</MIN_PRODUCT_ID_LENGTH>
                    <MAX_PRODUCT_ID_LENGTH>13</MAX_PRODUCT_ID_LENGTH>
                    <LEADING_ZEROS_YES_NO>NO</LEADING_ZEROS_YES_NO>
                    <PRODUCT_ID_SAMPLE>98765432101</PRODUCT_ID_SAMPLE>
                </ns1:consultaFinancierasACHDetailResponseRecordType>
            </ns1:consultaFinancierasACHDetailResponseType>
        </ns1:consultaFinancierasACHResponseRecordType>
        
    </ns1:consultaFinancierasACHResponseType>
</ns1:consultaFinancierasACHResponse>
```

---

##### Detalle importante: El filtro condicional

```xquery
if (data($productType[$j]) != "" or data($productMinLength[$j]) != "" or ...)
```

###### ¿Por qué existe?

Previene crear elementos vacíos si algún array es más corto. Por ejemplo, si un banco tiene:
- `PRODUCTTYPE = "AHORROS||CORRIENTE"`
- `PRODIDMINLENGTH = "10||10||15"` (3 elementos por error)

El loop irá hasta j=3, pero en j=3 el `$productType[3]` estará vacío, entonces **NO crea ese producto** gracias al filtro.

---

##### Resumen Visual

**ANTES (datos concatenados):**
```
Banco 001: productos = "AHORROS||CORRIENTE||CREDITO"
           mínimos  = "10||10||15"
```

**DESPUÉS (datos expandidos):**
```
Banco 001
  ├─ Producto AHORROS (min: 10)
  ├─ Producto CORRIENTE (min: 10)
  └─ Producto CREDITO (min: 15)
```

---

##### Conclusión

Este patrón es muy común cuando un sistema legacy retorna datos delimitados y necesitas convertirlos a XML estructurado para consumo moderno. La transformación permite:

1. **Normalizar datos**: De formato concatenado a estructura relacional
2. **Facilitar el consumo**: Clientes pueden iterar productos sin parsear strings
3. **Validar integridad**: El filtro condicional previene datos corruptos
4. **Mantener jerarquía**: Relación clara banco → productos

---

**Tecnologías utilizadas:**
- XQuery (lenguaje de consulta y transformación XML)
- Oracle Service Bus / Middleware SOA
- Web Services SOAP

#### Ejemplo Transformación Response Abanks GT AS-IS

##### ¿Qué hace este código?

Este código transforma **listas paralelas** de datos bancarios en una estructura XML jerárquica, asumiendo que **cada banco tiene exactamente 4 productos**. Utiliza un patrón de agrupación fija basado en múltiplos de 4.

---

##### Código completo original

```xquery
<ns1:consultaFinancierasACHResponse>
    <ns1:consultaFinancierasACHResponseType>
        {
            let $destinationCodes := $outputParameters1/ns0:DESTINATION_CODES/ns0:DESTINATION_CODES_ITEM
            let $destinationNames := $outputParameters1/ns0:DESTINATION_NAMES/ns0:DESTINATION_NAMES_ITEM
            let $typeOfProducts := $outputParameters1/ns0:TYPE_OF_PRODUCTS/ns0:TYPE_OF_PRODUCTS_ITEM
            let $minProductIdLength := $outputParameters1/ns0:MIN_PRODUCT_ID_LENGTH/ns0:DESTINATION_CODES_ITEM
            let $maxProductIdLength := $outputParameters1/ns0:MAX_PRODUCT_ID_LENGTH/ns0:DESTINATION_CODES_ITEM
            let $leadingZerosYesNO := $outputParameters1/ns0:LEADING_ZEROS_YES_NO/ns0:DESTINATION_CODES_ITEM
            let $productIdSampleItem := $outputParameters1/ns0:PRODUCT_ID_SAMPLE/ns0:PRODUCT_ID_SAMPLE_ITEM
            let $transferType := $outputParameters1/ns0:TRANSFER_TYPE/ns0:TRANSFER_TYPE_ITEM
            
            for $i in (1 to count($destinationCodes))
            where (($i mod 4) = 0)  <!-- Solo ejecuta en múltiplos de 4 -->
            return
                <ns1:consultaFinancierasACHResponseRecordType>
                    <DESTINATION_CODE>{ data($destinationCodes[$i]) }</DESTINATION_CODE>
                    <DESTINATION_NAME>{ data($destinationNames[$i]) }</DESTINATION_NAME>
                    
                    <ns1:consultaFinancierasACHDetailResponseType>
                    {
                        for $j in (($i - 3) to $i)  <!-- Ventana fija de 4 elementos -->
                        return  
                            <ns1:consultaFinancierasACHDetailResponseRecordType>
                                <TYPE_OF_PRODUCT>{ data($typeOfProducts[$j]) }</TYPE_OF_PRODUCT>
                                <MIN_PRODUCT_ID_LENGTH>{ data($minProductIdLength[$j]) }</MIN_PRODUCT_ID_LENGTH>
                                <MAX_PRODUCT_ID_LENGTH>{ data($maxProductIdLength[$j]) }</MAX_PRODUCT_ID_LENGTH>
                                <LEADING_ZEROS_YES_NO>{ data($leadingZerosYesNO[$j]) }</LEADING_ZEROS_YES_NO>
                                <PRODUCT_ID_SAMPLE>{ data($productIdSampleItem[$j]) }</PRODUCT_ID_SAMPLE>
                                <TRANSFER_TYPE>{ data($transferType[$j]) }</TRANSFER_TYPE>
                            </ns1:consultaFinancierasACHDetailResponseRecordType>
                    }
                    </ns1:consultaFinancierasACHDetailResponseType>
                </ns1:consultaFinancierasACHResponseRecordType>
        }
    </ns1:consultaFinancierasACHResponseType>
</ns1:consultaFinancierasACHResponse>
```

##### Características clave

1. **Relación fija 1:4**: Cada banco tiene exactamente 4 productos
2. **Agrupación por módulo**: Procesa solo en posiciones múltiplo de 4 (4, 8, 12, 16...)
3. **Ventana fija hacia atrás**: Siempre recoge los 4 elementos anteriores
4. **Simpleza**: Código más simple que algoritmos de detección dinámica

---

##### Estructura del proceso

###### PASO 1: Extracción de listas paralelas

```xquery
let $destinationCodes := .../DESTINATION_CODES_ITEM
let $destinationNames := .../DESTINATION_NAMES_ITEM
let $typeOfProducts := .../TYPE_OF_PRODUCTS_ITEM
let $minProductIdLength := .../MIN_PRODUCT_ID_LENGTH
let $maxProductIdLength := .../MAX_PRODUCT_ID_LENGTH
let $leadingZerosYesNO := .../LEADING_ZEROS_YES_NO
let $productIdSampleItem := .../PRODUCT_ID_SAMPLE_ITEM
let $transferType := .../TRANSFER_TYPE_ITEM
```

###### PASO 2: Loop con condición de módulo 4

```xquery
for $i in (1 to count($destinationCodes))
where (($i mod 4) = 0)
```

**La clave:** Solo ejecuta cuando `$i mod 4 = 0` (múltiplos de 4)

###### PASO 3: Ventana fija de 4 elementos

```xquery
for $j in (($i - 3) to $i)
```

Siempre recoge 4 elementos: desde `(posición_actual - 3)` hasta `posición_actual`

---

##### Ejemplo con datos reales

###### INPUT (Listas paralelas - 12 elementos)

```xml
<outputParameters1>
    <!-- CÓDIGOS DE DESTINO -->
    <ns0:DESTINATION_CODES>
        <ns0:DESTINATION_CODES_ITEM>001</ns0:DESTINATION_CODES_ITEM>  <!-- Pos 1 -->
        <ns0:DESTINATION_CODES_ITEM>001</ns0:DESTINATION_CODES_ITEM>  <!-- Pos 2 -->
        <ns0:DESTINATION_CODES_ITEM>001</ns0:DESTINATION_CODES_ITEM>  <!-- Pos 3 -->
        <ns0:DESTINATION_CODES_ITEM>001</ns0:DESTINATION_CODES_ITEM>  <!-- Pos 4 ✅ -->
        <ns0:DESTINATION_CODES_ITEM>002</ns0:DESTINATION_CODES_ITEM>  <!-- Pos 5 -->
        <ns0:DESTINATION_CODES_ITEM>002</ns0:DESTINATION_CODES_ITEM>  <!-- Pos 6 -->
        <ns0:DESTINATION_CODES_ITEM>002</ns0:DESTINATION_CODES_ITEM>  <!-- Pos 7 -->
        <ns0:DESTINATION_CODES_ITEM>002</ns0:DESTINATION_CODES_ITEM>  <!-- Pos 8 ✅ -->
        <ns0:DESTINATION_CODES_ITEM>007</ns0:DESTINATION_CODES_ITEM>  <!-- Pos 9 -->
        <ns0:DESTINATION_CODES_ITEM>007</ns0:DESTINATION_CODES_ITEM>  <!-- Pos 10 -->
        <ns0:DESTINATION_CODES_ITEM>007</ns0:DESTINATION_CODES_ITEM>  <!-- Pos 11 -->
        <ns0:DESTINATION_CODES_ITEM>007</ns0:DESTINATION_CODES_ITEM>  <!-- Pos 12 ✅ -->
    </ns0:DESTINATION_CODES>
    
    <!-- NOMBRES DE DESTINO -->
    <ns0:DESTINATION_NAMES>
        <ns0:DESTINATION_NAMES_ITEM>BANCO DE BOGOTA</ns0:DESTINATION_NAMES_ITEM>
        <ns0:DESTINATION_NAMES_ITEM>BANCO DE BOGOTA</ns0:DESTINATION_NAMES_ITEM>
        <ns0:DESTINATION_NAMES_ITEM>BANCO DE BOGOTA</ns0:DESTINATION_NAMES_ITEM>
        <ns0:DESTINATION_NAMES_ITEM>BANCO DE BOGOTA</ns0:DESTINATION_NAMES_ITEM>
        <ns0:DESTINATION_NAMES_ITEM>BANCOLOMBIA</ns0:DESTINATION_NAMES_ITEM>
        <ns0:DESTINATION_NAMES_ITEM>BANCOLOMBIA</ns0:DESTINATION_NAMES_ITEM>
        <ns0:DESTINATION_NAMES_ITEM>BANCOLOMBIA</ns0:DESTINATION_NAMES_ITEM>
        <ns0:DESTINATION_NAMES_ITEM>BANCOLOMBIA</ns0:DESTINATION_NAMES_ITEM>
        <ns0:DESTINATION_NAMES_ITEM>DAVIVIENDA</ns0:DESTINATION_NAMES_ITEM>
        <ns0:DESTINATION_NAMES_ITEM>DAVIVIENDA</ns0:DESTINATION_NAMES_ITEM>
        <ns0:DESTINATION_NAMES_ITEM>DAVIVIENDA</ns0:DESTINATION_NAMES_ITEM>
        <ns0:DESTINATION_NAMES_ITEM>DAVIVIENDA</ns0:DESTINATION_NAMES_ITEM>
    </ns0:DESTINATION_NAMES>
    
    <!-- TIPOS DE PRODUCTOS -->
    <ns0:TYPE_OF_PRODUCTS>
        <ns0:TYPE_OF_PRODUCTS_ITEM>AHORROS</ns0:TYPE_OF_PRODUCTS_ITEM>
        <ns0:TYPE_OF_PRODUCTS_ITEM>CORRIENTE</ns0:TYPE_OF_PRODUCTS_ITEM>
        <ns0:TYPE_OF_PRODUCTS_ITEM>TARJETA_CREDITO</ns0:TYPE_OF_PRODUCTS_ITEM>
        <ns0:TYPE_OF_PRODUCTS_ITEM>CREDITO_HIPOTECARIO</ns0:TYPE_OF_PRODUCTS_ITEM>
        <ns0:TYPE_OF_PRODUCTS_ITEM>AHORROS</ns0:TYPE_OF_PRODUCTS_ITEM>
        <ns0:TYPE_OF_PRODUCTS_ITEM>CORRIENTE</ns0:TYPE_OF_PRODUCTS_ITEM>
        <ns0:TYPE_OF_PRODUCTS_ITEM>TARJETA_CREDITO</ns0:TYPE_OF_PRODUCTS_ITEM>
        <ns0:TYPE_OF_PRODUCTS_ITEM>CREDITO_VEHICULAR</ns0:TYPE_OF_PRODUCTS_ITEM>
        <ns0:TYPE_OF_PRODUCTS_ITEM>AHORROS</ns0:TYPE_OF_PRODUCTS_ITEM>
        <ns0:TYPE_OF_PRODUCTS_ITEM>CORRIENTE</ns0:TYPE_OF_PRODUCTS_ITEM>
        <ns0:TYPE_OF_PRODUCTS_ITEM>CDT</ns0:TYPE_OF_PRODUCTS_ITEM>
        <ns0:TYPE_OF_PRODUCTS_ITEM>CREDITO_LIBRE_INVERSION</ns0:TYPE_OF_PRODUCTS_ITEM>
    </ns0:TYPE_OF_PRODUCTS>
    
    <!-- LONGITUDES MÍNIMAS -->
    <ns0:MIN_PRODUCT_ID_LENGTH>
        <ns0:DESTINATION_CODES_ITEM>10</ns0:DESTINATION_CODES_ITEM>
        <ns0:DESTINATION_CODES_ITEM>10</ns0:DESTINATION_CODES_ITEM>
        <ns0:DESTINATION_CODES_ITEM>16</ns0:DESTINATION_CODES_ITEM>
        <ns0:DESTINATION_CODES_ITEM>12</ns0:DESTINATION_CODES_ITEM>
        <ns0:DESTINATION_CODES_ITEM>11</ns0:DESTINATION_CODES_ITEM>
        <ns0:DESTINATION_CODES_ITEM>11</ns0:DESTINATION_CODES_ITEM>
        <ns0:DESTINATION_CODES_ITEM>16</ns0:DESTINATION_CODES_ITEM>
        <ns0:DESTINATION_CODES_ITEM>15</ns0:DESTINATION_CODES_ITEM>
        <ns0:DESTINATION_CODES_ITEM>9</ns0:DESTINATION_CODES_ITEM>
        <ns0:DESTINATION_CODES_ITEM>9</ns0:DESTINATION_CODES_ITEM>
        <ns0:DESTINATION_CODES_ITEM>10</ns0:DESTINATION_CODES_ITEM>
        <ns0:DESTINATION_CODES_ITEM>12</ns0:DESTINATION_CODES_ITEM>
    </ns0:MIN_PRODUCT_ID_LENGTH>
    
    <!-- LONGITUDES MÁXIMAS -->
    <ns0:MAX_PRODUCT_ID_LENGTH>
        <ns0:DESTINATION_CODES_ITEM>12</ns0:DESTINATION_CODES_ITEM>
        <ns0:DESTINATION_CODES_ITEM>12</ns0:DESTINATION_CODES_ITEM>
        <ns0:DESTINATION_CODES_ITEM>16</ns0:DESTINATION_CODES_ITEM>
        <ns0:DESTINATION_CODES_ITEM>15</ns0:DESTINATION_CODES_ITEM>
        <ns0:DESTINATION_CODES_ITEM>13</ns0:DESTINATION_CODES_ITEM>
        <ns0:DESTINATION_CODES_ITEM>13</ns0:DESTINATION_CODES_ITEM>
        <ns0:DESTINATION_CODES_ITEM>16</ns0:DESTINATION_CODES_ITEM>
        <ns0:DESTINATION_CODES_ITEM>18</ns0:DESTINATION_CODES_ITEM>
        <ns0:DESTINATION_CODES_ITEM>11</ns0:DESTINATION_CODES_ITEM>
        <ns0:DESTINATION_CODES_ITEM>11</ns0:DESTINATION_CODES_ITEM>
        <ns0:DESTINATION_CODES_ITEM>12</ns0:DESTINATION_CODES_ITEM>
        <ns0:DESTINATION_CODES_ITEM>15</ns0:DESTINATION_CODES_ITEM>
    </ns0:MAX_PRODUCT_ID_LENGTH>
    
    <!-- CEROS A LA IZQUIERDA -->
    <ns0:LEADING_ZEROS_YES_NO>
        <ns0:DESTINATION_CODES_ITEM>YES</ns0:DESTINATION_CODES_ITEM>
        <ns0:DESTINATION_CODES_ITEM>YES</ns0:DESTINATION_CODES_ITEM>
        <ns0:DESTINATION_CODES_ITEM>NO</ns0:DESTINATION_CODES_ITEM>
        <ns0:DESTINATION_CODES_ITEM>YES</ns0:DESTINATION_CODES_ITEM>
        <ns0:DESTINATION_CODES_ITEM>NO</ns0:DESTINATION_CODES_ITEM>
        <ns0:DESTINATION_CODES_ITEM>NO</ns0:DESTINATION_CODES_ITEM>
        <ns0:DESTINATION_CODES_ITEM>NO</ns0:DESTINATION_CODES_ITEM>
        <ns0:DESTINATION_CODES_ITEM>YES</ns0:DESTINATION_CODES_ITEM>
        <ns0:DESTINATION_CODES_ITEM>YES</ns0:DESTINATION_CODES_ITEM>
        <ns0:DESTINATION_CODES_ITEM>YES</ns0:DESTINATION_CODES_ITEM>
        <ns0:DESTINATION_CODES_ITEM>NO</ns0:DESTINATION_CODES_ITEM>
        <ns0:DESTINATION_CODES_ITEM>YES</ns0:DESTINATION_CODES_ITEM>
    </ns0:LEADING_ZEROS_YES_NO>
    
    <!-- MUESTRAS DE ID DE PRODUCTO -->
    <ns0:PRODUCT_ID_SAMPLE>
        <ns0:PRODUCT_ID_SAMPLE_ITEM>0012345678</ns0:PRODUCT_ID_SAMPLE_ITEM>
        <ns0:PRODUCT_ID_SAMPLE_ITEM>0098765432</ns0:PRODUCT_ID_SAMPLE_ITEM>
        <ns0:PRODUCT_ID_SAMPLE_ITEM>4532111122223333</ns0:PRODUCT_ID_SAMPLE_ITEM>
        <ns0:PRODUCT_ID_SAMPLE_ITEM>001234567890</ns0:PRODUCT_ID_SAMPLE_ITEM>
        <ns0:PRODUCT_ID_SAMPLE_ITEM>12345678901</ns0:PRODUCT_ID_SAMPLE_ITEM>
        <ns0:PRODUCT_ID_SAMPLE_ITEM>98765432101</ns0:PRODUCT_ID_SAMPLE_ITEM>
        <ns0:PRODUCT_ID_SAMPLE_ITEM>5412751234567890</ns0:PRODUCT_ID_SAMPLE_ITEM>
        <ns0:PRODUCT_ID_SAMPLE_ITEM>001122334455667</ns0:PRODUCT_ID_SAMPLE_ITEM>
        <ns0:PRODUCT_ID_SAMPLE_ITEM>001234567</ns0:PRODUCT_ID_SAMPLE_ITEM>
        <ns0:PRODUCT_ID_SAMPLE_ITEM>009876543</ns0:PRODUCT_ID_SAMPLE_ITEM>
        <ns0:PRODUCT_ID_SAMPLE_ITEM>1234567890</ns0:PRODUCT_ID_SAMPLE_ITEM>
        <ns0:PRODUCT_ID_SAMPLE_ITEM>001987654321</ns0:PRODUCT_ID_SAMPLE_ITEM>
    </ns0:PRODUCT_ID_SAMPLE>
    
    <!-- TIPOS DE TRANSFERENCIA -->
    <ns0:TRANSFER_TYPE>
        <ns0:TRANSFER_TYPE_ITEM>ACH</ns0:TRANSFER_TYPE_ITEM>
        <ns0:TRANSFER_TYPE_ITEM>ACH</ns0:TRANSFER_TYPE_ITEM>
        <ns0:TRANSFER_TYPE_ITEM>INSTANT</ns0:TRANSFER_TYPE_ITEM>
        <ns0:TRANSFER_TYPE_ITEM>ACH</ns0:TRANSFER_TYPE_ITEM>
        <ns0:TRANSFER_TYPE_ITEM>ACH</ns0:TRANSFER_TYPE_ITEM>
        <ns0:TRANSFER_TYPE_ITEM>ACH</ns0:TRANSFER_TYPE_ITEM>
        <ns0:TRANSFER_TYPE_ITEM>INSTANT</ns0:TRANSFER_TYPE_ITEM>
        <ns0:TRANSFER_TYPE_ITEM>ACH</ns0:TRANSFER_TYPE_ITEM>
        <ns0:TRANSFER_TYPE_ITEM>ACH</ns0:TRANSFER_TYPE_ITEM>
        <ns0:TRANSFER_TYPE_ITEM>ACH</ns0:TRANSFER_TYPE_ITEM>
        <ns0:TRANSFER_TYPE_ITEM>ACH</ns0:TRANSFER_TYPE_ITEM>
        <ns0:TRANSFER_TYPE_ITEM>ACH</ns0:TRANSFER_TYPE_ITEM>
    </ns0:TRANSFER_TYPE>
</outputParameters1>
```

---

##### Procesamiento paso a paso

###### Tabla de ejecución del loop principal

| Posición ($i) | i mod 4 | ¿Ejecuta? | Rango ($j) | Productos incluidos | Banco |
|---------------|---------|-----------|------------|---------------------|-------|
| 1 | 1 | ❌ No | - | - | - |
| 2 | 2 | ❌ No | - | - | - |
| 3 | 3 | ❌ No | - | - | - |
| 4 | **0** | ✅ **SÍ** | 1 to 4 | 4 productos | 001 |
| 5 | 1 | ❌ No | - | - | - |
| 6 | 2 | ❌ No | - | - | - |
| 7 | 3 | ❌ No | - | - | - |
| 8 | **0** | ✅ **SÍ** | 5 to 8 | 4 productos | 002 |
| 9 | 1 | ❌ No | - | - | - |
| 10 | 2 | ❌ No | - | - | - |
| 11 | 3 | ❌ No | - | - | - |
| 12 | **0** | ✅ **SÍ** | 9 to 12 | 4 productos | 007 |

**Solo ejecuta en posiciones 4, 8 y 12** (múltiplos de 4).

---

##### Detalle de ejecución: Posición 4 (Banco 001)

###### Condición del loop principal
```xquery
$i = 4
4 mod 4 = 0  ✅ TRUE → EJECUTA
```

###### Datos extraídos de la posición 4
```xquery
$destinationCodes[4] = "001"
$destinationNames[4] = "BANCO DE BOGOTA"
```

###### Loop interno: Ventana de 4 elementos
```xquery
for $j in ((4 - 3) to 4)
for $j in (1 to 4)
```

###### Productos procesados (j = 1 to 4)

| j | Tipo producto | Min | Max | Zeros | Sample | Transfer |
|---|--------------|-----|-----|-------|---------|----------|
| 1 | AHORROS | 10 | 12 | YES | 0012345678 | ACH |
| 2 | CORRIENTE | 10 | 12 | YES | 0098765432 | ACH |
| 3 | TARJETA_CREDITO | 16 | 16 | NO | 4532111122223333 | INSTANT |
| 4 | CREDITO_HIPOTECARIO | 12 | 15 | YES | 001234567890 | ACH |

###### XML generado para banco 001

```xml
<ns1:consultaFinancierasACHResponseRecordType>
    <DESTINATION_CODE>001</DESTINATION_CODE>
    <DESTINATION_NAME>BANCO DE BOGOTA</DESTINATION_NAME>
    
    <ns1:consultaFinancierasACHDetailResponseType>
        <!-- Producto 1: Posición 1 -->
        <ns1:consultaFinancierasACHDetailResponseRecordType>
            <TYPE_OF_PRODUCT>AHORROS</TYPE_OF_PRODUCT>
            <MIN_PRODUCT_ID_LENGTH>10</MIN_PRODUCT_ID_LENGTH>
            <MAX_PRODUCT_ID_LENGTH>12</MAX_PRODUCT_ID_LENGTH>
            <LEADING_ZEROS_YES_NO>YES</LEADING_ZEROS_YES_NO>
            <PRODUCT_ID_SAMPLE>0012345678</PRODUCT_ID_SAMPLE>
            <TRANSFER_TYPE>ACH</TRANSFER_TYPE>
        </ns1:consultaFinancierasACHDetailResponseRecordType>
        
        <!-- Producto 2: Posición 2 -->
        <ns1:consultaFinancierasACHDetailResponseRecordType>
            <TYPE_OF_PRODUCT>CORRIENTE</TYPE_OF_PRODUCT>
            <MIN_PRODUCT_ID_LENGTH>10</MIN_PRODUCT_ID_LENGTH>
            <MAX_PRODUCT_ID_LENGTH>12</MAX_PRODUCT_ID_LENGTH>
            <LEADING_ZEROS_YES_NO>YES</LEADING_ZEROS_YES_NO>
            <PRODUCT_ID_SAMPLE>0098765432</PRODUCT_ID_SAMPLE>
            <TRANSFER_TYPE>ACH</TRANSFER_TYPE>
        </ns1:consultaFinancierasACHDetailResponseRecordType>
        
        <!-- Producto 3: Posición 3 -->
        <ns1:consultaFinancierasACHDetailResponseRecordType>
            <TYPE_OF_PRODUCT>TARJETA_CREDITO</TYPE_OF_PRODUCT>
            <MIN_PRODUCT_ID_LENGTH>16</MIN_PRODUCT_ID_LENGTH>
            <MAX_PRODUCT_ID_LENGTH>16</MAX_PRODUCT_ID_LENGTH>
            <LEADING_ZEROS_YES_NO>NO</LEADING_ZEROS_YES_NO>
            <PRODUCT_ID_SAMPLE>4532111122223333</PRODUCT_ID_SAMPLE>
            <TRANSFER_TYPE>INSTANT</TRANSFER_TYPE>
        </ns1:consultaFinancierasACHDetailResponseRecordType>
        
        <!-- Producto 4: Posición 4 -->
        <ns1:consultaFinancierasACHDetailResponseRecordType>
            <TYPE_OF_PRODUCT>CREDITO_HIPOTECARIO</TYPE_OF_PRODUCT>
            <MIN_PRODUCT_ID_LENGTH>12</MIN_PRODUCT_ID_LENGTH>
            <MAX_PRODUCT_ID_LENGTH>15</MAX_PRODUCT_ID_LENGTH>
            <LEADING_ZEROS_YES_NO>YES</LEADING_ZEROS_YES_NO>
            <PRODUCT_ID_SAMPLE>001234567890</PRODUCT_ID_SAMPLE>
            <TRANSFER_TYPE>ACH</TRANSFER_TYPE>
        </ns1:consultaFinancierasACHDetailResponseRecordType>
    </ns1:consultaFinancierasACHDetailResponseType>
</ns1:consultaFinancierasACHResponseRecordType>
```

---

##### Detalle de ejecución: Posición 8 (Banco 002)

###### Condición del loop principal
```xquery
$i = 8
8 mod 4 = 0  ✅ TRUE → EJECUTA
```

###### Datos extraídos de la posición 8
```xquery
$destinationCodes[8] = "002"
$destinationNames[8] = "BANCOLOMBIA"
```

###### Loop interno: Ventana de 4 elementos
```xquery
for $j in ((8 - 3) to 8)
for $j in (5 to 8)
```

###### Productos procesados (j = 5 to 8)

| j | Tipo producto | Min | Max | Zeros | Sample | Transfer |
|---|--------------|-----|-----|-------|---------|----------|
| 5 | AHORROS | 11 | 13 | NO | 12345678901 | ACH |
| 6 | CORRIENTE | 11 | 13 | NO | 98765432101 | ACH |
| 7 | TARJETA_CREDITO | 16 | 16 | NO | 5412751234567890 | INSTANT |
| 8 | CREDITO_VEHICULAR | 15 | 18 | YES | 001122334455667 | ACH |

###### XML generado para banco 002

```xml
<ns1:consultaFinancierasACHResponseRecordType>
    <DESTINATION_CODE>002</DESTINATION_CODE>
    <DESTINATION_NAME>BANCOLOMBIA</DESTINATION_NAME>
    
    <ns1:consultaFinancierasACHDetailResponseType>
        <!-- Producto 1: Posición 5 -->
        <ns1:consultaFinancierasACHDetailResponseRecordType>
            <TYPE_OF_PRODUCT>AHORROS</TYPE_OF_PRODUCT>
            <MIN_PRODUCT_ID_LENGTH>11</MIN_PRODUCT_ID_LENGTH>
            <MAX_PRODUCT_ID_LENGTH>13</MAX_PRODUCT_ID_LENGTH>
            <LEADING_ZEROS_YES_NO>NO</LEADING_ZEROS_YES_NO>
            <PRODUCT_ID_SAMPLE>12345678901</PRODUCT_ID_SAMPLE>
            <TRANSFER_TYPE>ACH</TRANSFER_TYPE>
        </ns1:consultaFinancierasACHDetailResponseRecordType>
        
        <!-- Producto 2: Posición 6 -->
        <ns1:consultaFinancierasACHDetailResponseRecordType>
            <TYPE_OF_PRODUCT>CORRIENTE</TYPE_OF_PRODUCT>
            <MIN_PRODUCT_ID_LENGTH>11</MIN_PRODUCT_ID_LENGTH>
            <MAX_PRODUCT_ID_LENGTH>13</MAX_PRODUCT_ID_LENGTH>
            <LEADING_ZEROS_YES_NO>NO</LEADING_ZEROS_YES_NO>
            <PRODUCT_ID_SAMPLE>98765432101</PRODUCT_ID_SAMPLE>
            <TRANSFER_TYPE>ACH</TRANSFER_TYPE>
        </ns1:consultaFinancierasACHDetailResponseRecordType>
        
        <!-- Producto 3: Posición 7 -->
        <ns1:consultaFinancierasACHDetailResponseRecordType>
            <TYPE_OF_PRODUCT>TARJETA_CREDITO</TYPE_OF_PRODUCT>
            <MIN_PRODUCT_ID_LENGTH>16</MIN_PRODUCT_ID_LENGTH>
            <MAX_PRODUCT_ID_LENGTH>16</MAX_PRODUCT_ID_LENGTH>
            <LEADING_ZEROS_YES_NO>NO</LEADING_ZEROS_YES_NO>
            <PRODUCT_ID_SAMPLE>5412751234567890</PRODUCT_ID_SAMPLE>
            <TRANSFER_TYPE>INSTANT</TRANSFER_TYPE>
        </ns1:consultaFinancierasACHDetailResponseRecordType>
        
        <!-- Producto 4: Posición 8 -->
        <ns1:consultaFinancierasACHDetailResponseRecordType>
            <TYPE_OF_PRODUCT>CREDITO_VEHICULAR</TYPE_OF_PRODUCT>
            <MIN_PRODUCT_ID_LENGTH>15</MIN_PRODUCT_ID_LENGTH>
            <MAX_PRODUCT_ID_LENGTH>18</MAX_PRODUCT_ID_LENGTH>
            <LEADING_ZEROS_YES_NO>YES</LEADING_ZEROS_YES_NO>
            <PRODUCT_ID_SAMPLE>001122334455667</PRODUCT_ID_SAMPLE>
            <TRANSFER_TYPE>ACH</TRANSFER_TYPE>
        </ns1:consultaFinancierasACHDetailResponseRecordType>
    </ns1:consultaFinancierasACHDetailResponseType>
</ns1:consultaFinancierasACHResponseRecordType>
```

---

##### Detalle de ejecución: Posición 12 (Banco 007)

###### Condición del loop principal
```xquery
$i = 12
12 mod 4 = 0  ✅ TRUE → EJECUTA
```

###### Datos extraídos de la posición 12
```xquery
$destinationCodes[12] = "007"
$destinationNames[12] = "DAVIVIENDA"
```

###### Loop interno: Ventana de 4 elementos
```xquery
for $j in ((12 - 3) to 12)
for $j in (9 to 12)
```

###### Productos procesados (j = 9 to 12)

| j | Tipo producto | Min | Max | Zeros | Sample | Transfer |
|---|--------------|-----|-----|-------|---------|----------|
| 9 | AHORROS | 9 | 11 | YES | 001234567 | ACH |
| 10 | CORRIENTE | 9 | 11 | YES | 009876543 | ACH |
| 11 | CDT | 10 | 12 | NO | 1234567890 | ACH |
| 12 | CREDITO_LIBRE_INVERSION | 12 | 15 | YES | 001987654321 | ACH |

###### XML generado para banco 007

```xml
<ns1:consultaFinancierasACHResponseRecordType>
    <DESTINATION_CODE>007</DESTINATION_CODE>
    <DESTINATION_NAME>DAVIVIENDA</DESTINATION_NAME>
    
    <ns1:consultaFinancierasACHDetailResponseType>
        <!-- Producto 1: Posición 9 -->
        <ns1:consultaFinancierasACHDetailResponseRecordType>
            <TYPE_OF_PRODUCT>AHORROS</TYPE_OF_PRODUCT>
            <MIN_PRODUCT_ID_LENGTH>9</MIN_PRODUCT_ID_LENGTH>
            <MAX_PRODUCT_ID_LENGTH>11</MAX_PRODUCT_ID_LENGTH>
            <LEADING_ZEROS_YES_NO>YES</LEADING_ZEROS_YES_NO>
            <PRODUCT_ID_SAMPLE>001234567</PRODUCT_ID_SAMPLE>
            <TRANSFER_TYPE>ACH</TRANSFER_TYPE>
        </ns1:consultaFinancierasACHDetailResponseRecordType>
        
        <!-- Producto 2: Posición 10 -->
        <ns1:consultaFinancierasACHDetailResponseRecordType>
            <TYPE_OF_PRODUCT>CORRIENTE</TYPE_OF_PRODUCT>
            <MIN_PRODUCT_ID_LENGTH>9</MIN_PRODUCT_ID_LENGTH>
            <MAX_PRODUCT_ID_LENGTH>11</MAX_PRODUCT_ID_LENGTH>
            <LEADING_ZEROS_YES_NO>YES</LEADING_ZEROS_YES_NO>
            <PRODUCT_ID_SAMPLE>009876543</PRODUCT_ID_SAMPLE>
            <TRANSFER_TYPE>ACH</TRANSFER_TYPE>
        </ns1:consultaFinancierasACHDetailResponseRecordType>
        
        <!-- Producto 3: Posición 11 -->
        <ns1:consultaFinancierasACHDetailResponseRecordType>
            <TYPE_OF_PRODUCT>CDT</TYPE_OF_PRODUCT>
            <MIN_PRODUCT_ID_LENGTH>10</MIN_PRODUCT_ID_LENGTH>
            <MAX_PRODUCT_ID_LENGTH>12</MAX_PRODUCT_ID_LENGTH>
            <LEADING_ZEROS_YES_NO>NO</LEADING_ZEROS_YES_NO>
            <PRODUCT_ID_SAMPLE>1234567890</PRODUCT_ID_SAMPLE>
            <TRANSFER_TYPE>ACH</TRANSFER_TYPE>
        </ns1:consultaFinancierasACHDetailResponseRecordType>
        
        <!-- Producto 4: Posición 12 -->
        <ns1:consultaFinancierasACHDetailResponseRecordType>
            <TYPE_OF_PRODUCT>CREDITO_LIBRE_INVERSION</TYPE_OF_PRODUCT>
            <MIN_PRODUCT_ID_LENGTH>12</MIN_PRODUCT_ID_LENGTH>
            <MAX_PRODUCT_ID_LENGTH>15</MAX_PRODUCT_ID_LENGTH>
            <LEADING_ZEROS_YES_NO>YES</LEADING_ZEROS_YES_NO>
            <PRODUCT_ID_SAMPLE>001987654321</PRODUCT_ID_SAMPLE>
            <TRANSFER_TYPE>ACH</TRANSFER_TYPE>
        </ns1:consultaFinancierasACHDetailResponseRecordType>
    </ns1:consultaFinancierasACHDetailResponseType>
</ns1:consultaFinancierasACHResponseRecordType>
```

---

##### OUTPUT COMPLETO (Response transformado)

```xml
<ns1:consultaFinancierasACHResponse>
    <ns1:consultaFinancierasACHResponseType>
        
        <!-- ========== BANCO 001: BANCO DE BOGOTA ========== -->
        <ns1:consultaFinancierasACHResponseRecordType>
            <DESTINATION_CODE>001</DESTINATION_CODE>
            <DESTINATION_NAME>BANCO DE BOGOTA</DESTINATION_NAME>
            <ns1:consultaFinancierasACHDetailResponseType>
                <ns1:consultaFinancierasACHDetailResponseRecordType>
                    <TYPE_OF_PRODUCT>AHORROS</TYPE_OF_PRODUCT>
                    <MIN_PRODUCT_ID_LENGTH>10</MIN_PRODUCT_ID_LENGTH>
                    <MAX_PRODUCT_ID_LENGTH>12</MAX_PRODUCT_ID_LENGTH>
                    <LEADING_ZEROS_YES_NO>YES</LEADING_ZEROS_YES_NO>
                    <PRODUCT_ID_SAMPLE>0012345678</PRODUCT_ID_SAMPLE>
                    <TRANSFER_TYPE>ACH</TRANSFER_TYPE>
                </ns1:consultaFinancierasACHDetailResponseRecordType>
                <ns1:consultaFinancierasACHDetailResponseRecordType>
                    <TYPE_OF_PRODUCT>CORRIENTE</TYPE_OF_PRODUCT>
                    <MIN_PRODUCT_ID_LENGTH>10</MIN_PRODUCT_ID_LENGTH>
                    <MAX_PRODUCT_ID_LENGTH>12</MAX_PRODUCT_ID_LENGTH>
                    <LEADING_ZEROS_YES_NO>YES</LEADING_ZEROS_YES_NO>
                    <PRODUCT_ID_SAMPLE>0098765432</PRODUCT_ID_SAMPLE>
                    <TRANSFER_TYPE>ACH</TRANSFER_TYPE>
                </ns1:consultaFinancierasACHDetailResponseRecordType>
                <ns1:consultaFinancierasACHDetailResponseRecordType>
                    <TYPE_OF_PRODUCT>TARJETA_CREDITO</TYPE_OF_PRODUCT>
                    <MIN_PRODUCT_ID_LENGTH>16</MIN_PRODUCT_ID_LENGTH>
                    <MAX_PRODUCT_ID_LENGTH>16</MAX_PRODUCT_ID_LENGTH>
                    <LEADING_ZEROS_YES_NO>NO</LEADING_ZEROS_YES_NO>
                    <PRODUCT_ID_SAMPLE>4532111122223333</PRODUCT_ID_SAMPLE>
                    <TRANSFER_TYPE>INSTANT</TRANSFER_TYPE>
                </ns1:consultaFinancierasACHDetailResponseRecordType>
                <ns1:consultaFinancierasACHDetailResponseRecordType>
                    <TYPE_OF_PRODUCT>CREDITO_HIPOTECARIO</TYPE_OF_PRODUCT>
                    <MIN_PRODUCT_ID_LENGTH>12</MIN_PRODUCT_ID_LENGTH>
                    <MAX_PRODUCT_ID_LENGTH>15</MAX_PRODUCT_ID_LENGTH>
                    <LEADING_ZEROS_YES_NO>YES</LEADING_ZEROS_YES_NO>
                    <PRODUCT_ID_SAMPLE>001234567890</PRODUCT_ID_SAMPLE>
                    <TRANSFER_TYPE>ACH</TRANSFER_TYPE>
                </ns1:consultaFinancierasACHDetailResponseRecordType>
            </ns1:consultaFinancierasACHDetailResponseType>
        </ns1:consultaFinancierasACHResponseRecordType>
        
        <!-- ========== BANCO 002: BANCOLOMBIA ========== -->
        <ns1:consultaFinancierasACHResponseRecordType>
            <DESTINATION_CODE>002</DESTINATION_CODE>
            <DESTINATION_NAME>BANCOLOMBIA</DESTINATION_NAME>
            <ns1:consultaFinancierasACHDetailResponseType>
                <ns1:consultaFinancierasACHDetailResponseRecordType>
                    <TYPE_OF_PRODUCT>AHORROS</TYPE_OF_PRODUCT>
                    <MIN_PRODUCT_ID_LENGTH>11</MIN_PRODUCT_ID_LENGTH>
                    <MAX_PRODUCT_ID_LENGTH>13</MAX_PRODUCT_ID_LENGTH>
                    <LEADING_ZEROS_YES_NO>NO</LEADING_ZEROS_YES_NO>
                    <PRODUCT_ID_SAMPLE>12345678901</PRODUCT_ID_SAMPLE>
                    <TRANSFER_TYPE>ACH</TRANSFER_TYPE>
                </ns1:consultaFinancierasACHDetailResponseRecordType>
                <ns1:consultaFinancierasACHDetailResponseRecordType>
                    <TYPE_OF_PRODUCT>CORRIENTE</TYPE_OF_PRODUCT>
                    <MIN_PRODUCT_ID_LENGTH>11</MIN_PRODUCT_ID_LENGTH>
                    <MAX_PRODUCT_ID_LENGTH>13</MAX_PRODUCT_ID_LENGTH>
                    <LEADING_ZEROS_YES_NO>NO</LEADING_ZEROS_YES_NO>
                    <PRODUCT_ID_SAMPLE>98765432101</PRODUCT_ID_SAMPLE>
                    <TRANSFER_TYPE>ACH</TRANSFER_TYPE>
                </ns1:consultaFinancierasACHDetailResponseRecordType>
                <ns1:consultaFinancierasACHDetailResponseRecordType>
                    <TYPE_OF_PRODUCT>TARJETA_CREDITO</TYPE_OF_PRODUCT>
                    <MIN_PRODUCT_ID_LENGTH>16</MIN_PRODUCT_ID_LENGTH>
                    <MAX_PRODUCT_ID_LENGTH>16</MAX_PRODUCT_ID_LENGTH>
                    <LEADING_ZEROS_YES_NO>NO</LEADING_ZEROS_YES_NO>
                    <PRODUCT_ID_SAMPLE>5412751234567890</PRODUCT_ID_SAMPLE>
                    <TRANSFER_TYPE>INSTANT</TRANSFER_TYPE>
                </ns1:consultaFinancierasACHDetailResponseRecordType>
                <ns1:consultaFinancierasACHDetailResponseRecordType>
                    <TYPE_OF_PRODUCT>CREDITO_VEHICULAR</TYPE_OF_PRODUCT>
                    <MIN_PRODUCT_ID_LENGTH>15</MIN_PRODUCT_ID_LENGTH>
                    <MAX_PRODUCT_ID_LENGTH>18</MAX_PRODUCT_ID_LENGTH>
                    <LEADING_ZEROS_YES_NO>YES</LEADING_ZEROS_YES_NO>
                    <PRODUCT_ID_SAMPLE>001122334455667</PRODUCT_ID_SAMPLE>
                    <TRANSFER_TYPE>ACH</TRANSFER_TYPE>
                </ns1:consultaFinancierasACHDetailResponseRecordType>
            </ns1:consultaFinancierasACHDetailResponseType>
        </ns1:consultaFinancierasACHResponseRecordType>
        
        <!-- ========== BANCO 007: DAVIVIENDA ========== -->
        <ns1:consultaFinancierasACHResponseRecordType>
            <DESTINATION_CODE>007</DESTINATION_CODE>
            <DESTINATION_NAME>DAVIVIENDA</DESTINATION_NAME>
            <ns1:consultaFinancierasACHDetailResponseType>
                <ns1:consultaFinancierasACHDetailResponseRecordType>
                    <TYPE_OF_PRODUCT>AHORROS</TYPE_OF_PRODUCT>
                    <MIN_PRODUCT_ID_LENGTH>9</MIN_PRODUCT_ID_LENGTH>
                    <MAX_PRODUCT_ID_LENGTH>11</MAX_PRODUCT_ID_LENGTH>
                    <LEADING_ZEROS_YES_NO>YES</LEADING_ZEROS_YES_NO>
                    <PRODUCT_ID_SAMPLE>001234567</PRODUCT_ID_SAMPLE>
                    <TRANSFER_TYPE>ACH</TRANSFER_TYPE>
                </ns1:consultaFinancierasACHDetailResponseRecordType>
                <ns1:consultaFinancierasACHDetailResponseRecordType>
                    <TYPE_OF_PRODUCT>CORRIENTE</TYPE_OF_PRODUCT>
                    <MIN_PRODUCT_ID_LENGTH>9</MIN_PRODUCT_ID_LENGTH>
                    <MAX_PRODUCT_ID_LENGTH>11</MAX_PRODUCT_ID_LENGTH>
                    <LEADING_ZEROS_YES_NO>YES</LEADING_ZEROS_YES_NO>
                    <PRODUCT_ID_SAMPLE>009876543</PRODUCT_ID_SAMPLE>
                    <TRANSFER_TYPE>ACH</TRANSFER_TYPE>
                </ns1:consultaFinancierasACHDetailResponseRecordType>
                <ns1:consultaFinancierasACHDetailResponseRecordType>
                    <TYPE_OF_PRODUCT>CDT</TYPE_OF_PRODUCT>
                    <MIN_PRODUCT_ID_LENGTH>10</MIN_PRODUCT_ID_LENGTH>
                    <MAX_PRODUCT_ID_LENGTH>12</MAX_PRODUCT_ID_LENGTH>
                    <LEADING_ZEROS_YES_NO>NO</LEADING_ZEROS_YES_NO>
                    <PRODUCT_ID_SAMPLE>1234567890</PRODUCT_ID_SAMPLE>
                    <TRANSFER_TYPE>ACH</TRANSFER_TYPE>
                </ns1:consultaFinancierasACHDetailResponseRecordType>
                <ns1:consultaFinancierasACHDetailResponseRecordType>
                    <TYPE_OF_PRODUCT>CREDITO_LIBRE_INVERSION</TYPE_OF_PRODUCT>
                    <MIN_PRODUCT_ID_LENGTH>12</MIN_PRODUCT_ID_LENGTH>
                    <MAX_PRODUCT_ID_LENGTH>15</MAX_PRODUCT_ID_LENGTH>
                    <LEADING_ZEROS_YES_NO>YES</LEADING_ZEROS_YES_NO>
                    <PRODUCT_ID_SAMPLE>001987654321</PRODUCT_ID_SAMPLE>
                    <TRANSFER_TYPE>ACH</TRANSFER_TYPE>
                </ns1:consultaFinancierasACHDetailResponseRecordType>
            </ns1:consultaFinancierasACHDetailResponseType>
        </ns1:consultaFinancierasACHResponseRecordType>
        
    </ns1:consultaFinancierasACHResponseType>
</ns1:consultaFinancierasACHResponse>
```

---

##### Diagrama visual del algoritmo

```
Posiciones:  [1]  [2]  [3]  [4]  [5]  [6]  [7]  [8]  [9] [10] [11] [12]
Códigos:     001  001  001  001  002  002  002  002  007  007  007  007
                              ↑                       ↑                  ↑
                           mod 4=0                mod 4=0            mod 4=0
                           PROCESA                PROCESA            PROCESA
                              
Ventanas:    [←  1-4  →]      [←  5-8  →]           [← 9-12 →]
             Banco 001         Banco 002              Banco 007
             4 productos       4 productos            4 productos
```

---

##### Funcionamiento del operador módulo (mod)

El operador `mod` devuelve el **resto** de una división:

```
1 mod 4 = 1  (1 ÷ 4 = 0 resto 1)
2 mod 4 = 2  (2 ÷ 4 = 0 resto 2)
3 mod 4 = 3  (3 ÷ 4 = 0 resto 3)
4 mod 4 = 0  (4 ÷ 4 = 1 resto 0) ✅ EJECUTA
5 mod 4 = 1  (5 ÷ 4 = 1 resto 1)
6 mod 4 = 2  (6 ÷ 4 = 1 resto 2)
7 mod 4 = 3  (7 ÷ 4 = 1 resto 3)
8 mod 4 = 0  (8 ÷ 4 = 2 resto 0) ✅ EJECUTA
```

Solo cuando el resto es **0**, la condición es verdadera.

---

##### Ventajas del enfoque

###### ✅ Pros
1. **Simplicidad**: Código muy simple y fácil de entender
2. **Predecibilidad**: Comportamiento 100% predecible
3. **Performance**: Muy eficiente, solo 3 iteraciones para 12 elementos
4. **Sin dependencias**: No necesita validaciones de cambio de banco

###### ❌ Contras
1. **Inflexibilidad total**: Solo funciona si TODOS los bancos tienen exactamente 4 productos
2. **Pérdida de datos**: Si un banco tiene 3 o 5 productos, habrá errores
3. **Sin validación**: No detecta ni reporta inconsistencias
4. **Alineación crítica**: Los datos deben venir perfectamente alineados

---

##### Casos de error

###### ⚠️ Caso 1: Banco con 3 productos

```
Entrada: [001, 001, 001, 002, 002, 002, 002]
                         ↑ Posición 4 (mod 4 = 0)
                         
Procesaría: Posiciones 1-4
- Productos 1-3: Banco 001 ✅
- Producto 4: Banco 002 ❌ ERROR (mezcla bancos)
```

###### ⚠️ Caso 2: Banco con 5 productos

```
Entrada: [001, 001, 001, 001, 001, 002, 002, 002]
                                   ↑ Posición 4 (mod 4 = 0)
                                                  ↑ Posición 8 (mod 4 = 0)
                                   
Procesaría: 
- Posición 4: Productos 1-4 del banco 001 ✅
- Posición 8: Productos 5-8 (mezcla 001 y 002) ❌ ERROR

Banco 001 pierde el producto 5
```

###### ⚠️ Caso 3: Total de elementos no múltiplo de 4

```
Entrada: [001, 001, 001, 001, 002, 002, 002] (7 elementos)
                                   
Solo procesa posición 4
Banco 002 NO se procesa (nunca llega a posición 8)
```

---

###### Comparación con otros enfoques

| Característica | Mod 4 (este código) | Detección de cambio | Tokenize "||" |
|---------------|---------------------|---------------------|---------------|
| Complejidad | ⭐ Baja | ⭐⭐ Media | ⭐⭐⭐ Alta |
| Flexibilidad | ❌ Cero | ✅ Alta | ✅ Alta |
| Performance | ✅ Excelente | ✅ Buena | ⭐⭐ Regular |
| Mantenibilidad | ✅ Fácil | ⭐⭐ Media | ⭐⭐ Media |
| Robustez | ❌ Muy frágil | ✅ Robusta | ✅ Robusta |
| Validación | ❌ Ninguna | ⭐⭐ Limitada | ✅ Buena |

---

###### ¿Cuándo usar este patrón?

###### ✅ Úsalo cuando:
1. Tienes **garantía contractual** de que siempre habrá exactamente 4 productos por banco
2. El sistema origen es **100% confiable** y validado
3. Necesitas **máximo performance** (procesamiento masivo)
4. El esquema de datos está **estrictamente controlado**

###### ❌ NO lo uses cuando:
1. La cantidad de productos puede variar
2. Los datos vienen de fuentes externas no controladas
3. Necesitas flexibilidad para cambios futuros
4. Requieres validación y reporte de errores

---

###### Recomendación de mejora

Si existe la posibilidad de que algunos bancos tengan diferente cantidad de productos, considera cambiar a un enfoque de **detección de cambio**:

```xquery
for $i in (1 to count($destinationCodes))
where (data($destinationCodes[$i]) != data($destinationCodes[$i+1])) 
   or ($i = count($destinationCodes))
```

Esto detecta automáticamente cuándo termina un banco, sin asumir cantidad fija de productos.

---

#### Ejemplo Transformación Response Abanks PA AS-IS

##### ¿Qué hace este código?

Este código transforma **listas paralelas** de datos bancarios en una estructura XML jerárquica. A diferencia de otros enfoques, este **detecta automáticamente** cuándo cambia el banco y agrupa dinámicamente todos los productos que pertenecen a cada entidad financiera.

##### Características clave

1. **Detección de cambio de banco**: Identifica cuándo termina un banco y comienza otro
2. **Agrupación dinámica**: No asume un número fijo de productos por banco
3. **Búsqueda hacia atrás**: Recupera todos los productos del banco actual buscando en las últimas 5 posiciones
4. **Optimización**: Solo procesa cuando detecta el último producto de cada banco

---

##### Estructura del proceso

###### PASO 1: Extracción de listas paralelas

```xquery
let $destinationCodes := .../DESTINATION_CODES_ITEM
let $destinationNames := .../DESTINATION_NAMES_ITEM
let $typeOfProducts := .../TYPE_OF_PRODUCTS_ITEM
let $minProductIdLength := .../MIN_PRODUCT_ID_LENGTH
let $maxProductIdLength := .../MAX_PRODUCT_ID_LENGTH
let $leadingZerosYesNO := .../LEADING_ZEROS_YES_NO
let $productIdSampleItem := .../PRODUCT_ID_SAMPLE_ITEM
```

###### PASO 2: Loop principal con condición de agrupación

```xquery
for $i in (1 to count($destinationCodes))
where (data($destinationCodes[$i]) != data($destinationCodes[$i+1])) or ($i = count($destinationCodes))
```

**La clave está en el `where`:**
- `$destinationCodes[$i] != $destinationCodes[$i+1]`: Detecta cambio de banco
- `$i = count($destinationCodes)`: Procesa el último elemento

Solo ejecuta el `return` cuando encuentra el **último producto de un banco**.

---

##### Ejemplo con datos reales

###### INPUT (Listas paralelas)

```xml
<outputParameters1>
    <ns0:DESTINATION_CODES>
        <ns0:DESTINATION_CODES_ITEM>001</ns0:DESTINATION_CODES_ITEM>  <!-- Posición 1 -->
        <ns0:DESTINATION_CODES_ITEM>001</ns0:DESTINATION_CODES_ITEM>  <!-- Posición 2 -->
        <ns0:DESTINATION_CODES_ITEM>001</ns0:DESTINATION_CODES_ITEM>  <!-- Posición 3 -->
        <ns0:DESTINATION_CODES_ITEM>002</ns0:DESTINATION_CODES_ITEM>  <!-- Posición 4 CAMBIO! -->
        <ns0:DESTINATION_CODES_ITEM>002</ns0:DESTINATION_CODES_ITEM>  <!-- Posición 5 -->
        <ns0:DESTINATION_CODES_ITEM>002</ns0:DESTINATION_CODES_ITEM>  <!-- Posición 6 -->
        <ns0:DESTINATION_CODES_ITEM>002</ns0:DESTINATION_CODES_ITEM>  <!-- Posición 7 -->
        <ns0:DESTINATION_CODES_ITEM>002</ns0:DESTINATION_CODES_ITEM>  <!-- Posición 8 -->
        <ns0:DESTINATION_CODES_ITEM>007</ns0:DESTINATION_CODES_ITEM>  <!-- Posición 9 CAMBIO! -->
        <ns0:DESTINATION_CODES_ITEM>007</ns0:DESTINATION_CODES_ITEM>  <!-- Posición 10 (último) -->
    </ns0:DESTINATION_CODES>
    
    <ns0:DESTINATION_NAMES>
        <ns0:DESTINATION_NAMES_ITEM>BANCO DE BOGOTA</ns0:DESTINATION_NAMES_ITEM>
        <ns0:DESTINATION_NAMES_ITEM>BANCO DE BOGOTA</ns0:DESTINATION_NAMES_ITEM>
        <ns0:DESTINATION_NAMES_ITEM>BANCO DE BOGOTA</ns0:DESTINATION_NAMES_ITEM>
        <ns0:DESTINATION_NAMES_ITEM>BANCOLOMBIA</ns0:DESTINATION_NAMES_ITEM>
        <ns0:DESTINATION_NAMES_ITEM>BANCOLOMBIA</ns0:DESTINATION_NAMES_ITEM>
        <ns0:DESTINATION_NAMES_ITEM>BANCOLOMBIA</ns0:DESTINATION_NAMES_ITEM>
        <ns0:DESTINATION_NAMES_ITEM>BANCOLOMBIA</ns0:DESTINATION_NAMES_ITEM>
        <ns0:DESTINATION_NAMES_ITEM>BANCOLOMBIA</ns0:DESTINATION_NAMES_ITEM>
        <ns0:DESTINATION_NAMES_ITEM>DAVIVIENDA</ns0:DESTINATION_NAMES_ITEM>
        <ns0:DESTINATION_NAMES_ITEM>DAVIVIENDA</ns0:DESTINATION_NAMES_ITEM>
    </ns0:DESTINATION_NAMES>
    
    <ns0:TYPE_OF_PRODUCTS>
        <ns0:TYPE_OF_PRODUCTS_ITEM>AHORROS</ns0:TYPE_OF_PRODUCTS_ITEM>
        <ns0:TYPE_OF_PRODUCTS_ITEM>CORRIENTE</ns0:TYPE_OF_PRODUCTS_ITEM>
        <ns0:TYPE_OF_PRODUCTS_ITEM>CREDITO</ns0:TYPE_OF_PRODUCTS_ITEM>
        <ns0:TYPE_OF_PRODUCTS_ITEM>AHORROS</ns0:TYPE_OF_PRODUCTS_ITEM>
        <ns0:TYPE_OF_PRODUCTS_ITEM>CORRIENTE</ns0:TYPE_OF_PRODUCTS_ITEM>
        <ns0:TYPE_OF_PRODUCTS_ITEM>TARJETA</ns0:TYPE_OF_PRODUCTS_ITEM>
        <ns0:TYPE_OF_PRODUCTS_ITEM>CREDITO</ns0:TYPE_OF_PRODUCTS_ITEM>
        <ns0:TYPE_OF_PRODUCTS_ITEM>NOMINA</ns0:TYPE_OF_PRODUCTS_ITEM>
        <ns0:TYPE_OF_PRODUCTS_ITEM>AHORROS</ns0:TYPE_OF_PRODUCTS_ITEM>
        <ns0:TYPE_OF_PRODUCTS_ITEM>CORRIENTE</ns0:TYPE_OF_PRODUCTS_ITEM>
    </ns0:TYPE_OF_PRODUCTS>
    
    <ns0:MIN_PRODUCT_ID_LENGTH>
        <ns0:DESTINATION_CODES_ITEM>10</ns0:DESTINATION_CODES_ITEM>
        <ns0:DESTINATION_CODES_ITEM>10</ns0:DESTINATION_CODES_ITEM>
        <ns0:DESTINATION_CODES_ITEM>15</ns0:DESTINATION_CODES_ITEM>
        <ns0:DESTINATION_CODES_ITEM>11</ns0:DESTINATION_CODES_ITEM>
        <ns0:DESTINATION_CODES_ITEM>11</ns0:DESTINATION_CODES_ITEM>
        <ns0:DESTINATION_CODES_ITEM>16</ns0:DESTINATION_CODES_ITEM>
        <ns0:DESTINATION_CODES_ITEM>12</ns0:DESTINATION_CODES_ITEM>
        <ns0:DESTINATION_CODES_ITEM>11</ns0:DESTINATION_CODES_ITEM>
        <ns0:DESTINATION_CODES_ITEM>9</ns0:DESTINATION_CODES_ITEM>
        <ns0:DESTINATION_CODES_ITEM>9</ns0:DESTINATION_CODES_ITEM>
    </ns0:MIN_PRODUCT_ID_LENGTH>
    
    <ns0:MAX_PRODUCT_ID_LENGTH>
        <ns0:DESTINATION_CODES_ITEM>12</ns0:DESTINATION_CODES_ITEM>
        <ns0:DESTINATION_CODES_ITEM>12</ns0:DESTINATION_CODES_ITEM>
        <ns0:DESTINATION_CODES_ITEM>18</ns0:DESTINATION_CODES_ITEM>
        <ns0:DESTINATION_CODES_ITEM>13</ns0:DESTINATION_CODES_ITEM>
        <ns0:DESTINATION_CODES_ITEM>13</ns0:DESTINATION_CODES_ITEM>
        <ns0:DESTINATION_CODES_ITEM>16</ns0:DESTINATION_CODES_ITEM>
        <ns0:DESTINATION_CODES_ITEM>15</ns0:DESTINATION_CODES_ITEM>
        <ns0:DESTINATION_CODES_ITEM>13</ns0:DESTINATION_CODES_ITEM>
        <ns0:DESTINATION_CODES_ITEM>11</ns0:DESTINATION_CODES_ITEM>
        <ns0:DESTINATION_CODES_ITEM>11</ns0:DESTINATION_CODES_ITEM>
    </ns0:MAX_PRODUCT_ID_LENGTH>
    
    <ns0:LEADING_ZEROS_YES_NO>
        <ns0:DESTINATION_CODES_ITEM>YES</ns0:DESTINATION_CODES_ITEM>
        <ns0:DESTINATION_CODES_ITEM>YES</ns0:DESTINATION_CODES_ITEM>
        <ns0:DESTINATION_CODES_ITEM>NO</ns0:DESTINATION_CODES_ITEM>
        <ns0:DESTINATION_CODES_ITEM>NO</ns0:DESTINATION_CODES_ITEM>
        <ns0:DESTINATION_CODES_ITEM>NO</ns0:DESTINATION_CODES_ITEM>
        <ns0:DESTINATION_CODES_ITEM>NO</ns0:DESTINATION_CODES_ITEM>
        <ns0:DESTINATION_CODES_ITEM>YES</ns0:DESTINATION_CODES_ITEM>
        <ns0:DESTINATION_CODES_ITEM>NO</ns0:DESTINATION_CODES_ITEM>
        <ns0:DESTINATION_CODES_ITEM>YES</ns0:DESTINATION_CODES_ITEM>
        <ns0:DESTINATION_CODES_ITEM>YES</ns0:DESTINATION_CODES_ITEM>
    </ns0:LEADING_ZEROS_YES_NO>
    
    <ns0:PRODUCT_ID_SAMPLE>
        <ns0:PRODUCT_ID_SAMPLE_ITEM>0012345678</ns0:PRODUCT_ID_SAMPLE_ITEM>
        <ns0:PRODUCT_ID_SAMPLE_ITEM>0098765432</ns0:PRODUCT_ID_SAMPLE_ITEM>
        <ns0:PRODUCT_ID_SAMPLE_ITEM>123456789012345</ns0:PRODUCT_ID_SAMPLE_ITEM>
        <ns0:PRODUCT_ID_SAMPLE_ITEM>12345678901</ns0:PRODUCT_ID_SAMPLE_ITEM>
        <ns0:PRODUCT_ID_SAMPLE_ITEM>98765432101</ns0:PRODUCT_ID_SAMPLE_ITEM>
        <ns0:PRODUCT_ID_SAMPLE_ITEM>5412751234567890</ns0:PRODUCT_ID_SAMPLE_ITEM>
        <ns0:PRODUCT_ID_SAMPLE_ITEM>001234567890</ns0:PRODUCT_ID_SAMPLE_ITEM>
        <ns0:PRODUCT_ID_SAMPLE_ITEM>88776655443</ns0:PRODUCT_ID_SAMPLE_ITEM>
        <ns0:PRODUCT_ID_SAMPLE_ITEM>001234567</ns0:PRODUCT_ID_SAMPLE_ITEM>
        <ns0:PRODUCT_ID_SAMPLE_ITEM>009876543</ns0:PRODUCT_ID_SAMPLE_ITEM>
    </ns0:PRODUCT_ID_SAMPLE>
</outputParameters1>
```

---

##### Procesamiento paso a paso

###### Iteración del loop principal

El loop recorre posiciones 1 a 10, pero solo ejecuta el `return` cuando se cumple la condición `where`:

| Posición | Código actual | Código siguiente | ¿Ejecuta? | Razón |
|----------|--------------|------------------|-----------|-------|
| 1 | 001 | 001 | ❌ No | Mismo código |
| 2 | 001 | 001 | ❌ No | Mismo código |
| 3 | 001 | 002 | ✅ **SÍ** | **Cambio detectado (001→002)** |
| 4 | 002 | 002 | ❌ No | Mismo código |
| 5 | 002 | 002 | ❌ No | Mismo código |
| 6 | 002 | 002 | ❌ No | Mismo código |
| 7 | 002 | 002 | ❌ No | Mismo código |
| 8 | 002 | 007 | ✅ **SÍ** | **Cambio detectado (002→007)** |
| 9 | 007 | 007 | ❌ No | Mismo código |
| 10 | 007 | null | ✅ **SÍ** | **Último elemento** |

---

##### Detalle de ejecución: Posición 3 (Primer banco - 001)

**Condición cumplida:** `$destinationCodes[3] (001) != $destinationCodes[4] (002)`

###### Loop interno - evaluación de rango

**Pregunta:** `($i - 4) <= 0`?  
**Respuesta:** `(3 - 4) = -1 <= 0` → **SÍ (TRUE)**

Por lo tanto, ejecuta el **primer bloque** (`if`):

```xquery
for $j in (1 to 3)
where data($destinationCodes[$j]) = data($destinationCodes[3])  // Busca todos los "001"
```

###### Productos encontrados:

| j | Código[$j] | ¿Es "001"? | ¿Incluir? |
|---|-----------|------------|-----------|
| 1 | 001 | ✅ Sí | ✅ Incluye producto AHORROS |
| 2 | 001 | ✅ Sí | ✅ Incluye producto CORRIENTE |
| 3 | 001 | ✅ Sí | ✅ Incluye producto CREDITO |

###### XML generado para banco 001:

```xml
<ns1:consultaFinancierasACHResponseRecordType>
    <DESTINATION_CODE>001</DESTINATION_CODE>
    <DESTINATION_NAME>BANCO DE BOGOTA</DESTINATION_NAME>
    
    <ns1:consultaFinancierasACHDetailResponseType>
        <ns1:consultaFinancierasACHDetailResponseRecordType>
            <TYPE_OF_PRODUCT>AHORROS</TYPE_OF_PRODUCT>
            <MIN_PRODUCT_ID_LENGTH>10</MIN_PRODUCT_ID_LENGTH>
            <MAX_PRODUCT_ID_LENGTH>12</MAX_PRODUCT_ID_LENGTH>
            <LEADING_ZEROS_YES_NO>YES</LEADING_ZEROS_YES_NO>
            <PRODUCT_ID_SAMPLE>0012345678</PRODUCT_ID_SAMPLE>
        </ns1:consultaFinancierasACHDetailResponseRecordType>
        
        <ns1:consultaFinancierasACHDetailResponseRecordType>
            <TYPE_OF_PRODUCT>CORRIENTE</TYPE_OF_PRODUCT>
            <MIN_PRODUCT_ID_LENGTH>10</MIN_PRODUCT_ID_LENGTH>
            <MAX_PRODUCT_ID_LENGTH>12</MAX_PRODUCT_ID_LENGTH>
            <LEADING_ZEROS_YES_NO>YES</LEADING_ZEROS_YES_NO>
            <PRODUCT_ID_SAMPLE>0098765432</PRODUCT_ID_SAMPLE>
        </ns1:consultaFinancierasACHDetailResponseRecordType>
        
        <ns1:consultaFinancierasACHDetailResponseRecordType>
            <TYPE_OF_PRODUCT>CREDITO</TYPE_OF_PRODUCT>
            <MIN_PRODUCT_ID_LENGTH>15</MIN_PRODUCT_ID_LENGTH>
            <MAX_PRODUCT_ID_LENGTH>18</MAX_PRODUCT_ID_LENGTH>
            <LEADING_ZEROS_YES_NO>NO</LEADING_ZEROS_YES_NO>
            <PRODUCT_ID_SAMPLE>123456789012345</PRODUCT_ID_SAMPLE>
        </ns1:consultaFinancierasACHDetailResponseRecordType>
    </ns1:consultaFinancierasACHDetailResponseType>
</ns1:consultaFinancierasACHResponseRecordType>
```

---

##### Detalle de ejecución: Posición 8 (Segundo banco - 002)

**Condición cumplida:** `$destinationCodes[8] (002) != $destinationCodes[9] (007)`

###### Loop interno - evaluación de rango

**Pregunta:** `($i - 4) <= 0`?  
**Respuesta:** `(8 - 4) = 4 <= 0` → **NO (FALSE)**

Por lo tanto, ejecuta el **segundo bloque** (`else`):

```xquery
for $j in ((8 - 4) to 8)  // Rango: 4 a 8
where data($destinationCodes[$j]) = data($destinationCodes[8])  // Busca todos los "002"
```

###### Productos encontrados:

| j | Código[$j] | ¿Es "002"? | ¿Incluir? |
|---|-----------|------------|-----------|
| 4 | 002 | ✅ Sí | ✅ Incluye producto AHORROS |
| 5 | 002 | ✅ Sí | ✅ Incluye producto CORRIENTE |
| 6 | 002 | ✅ Sí | ✅ Incluye producto TARJETA |
| 7 | 002 | ✅ Sí | ✅ Incluye producto CREDITO |
| 8 | 002 | ✅ Sí | ✅ Incluye producto NOMINA |

###### XML generado para banco 002:

```xml
<ns1:consultaFinancierasACHResponseRecordType>
    <DESTINATION_CODE>002</DESTINATION_CODE>
    <DESTINATION_NAME>BANCOLOMBIA</DESTINATION_NAME>
    
    <ns1:consultaFinancierasACHDetailResponseType>
        <ns1:consultaFinancierasACHDetailResponseRecordType>
            <TYPE_OF_PRODUCT>AHORROS</TYPE_OF_PRODUCT>
            <MIN_PRODUCT_ID_LENGTH>11</MIN_PRODUCT_ID_LENGTH>
            <MAX_PRODUCT_ID_LENGTH>13</MAX_PRODUCT_ID_LENGTH>
            <LEADING_ZEROS_YES_NO>NO</LEADING_ZEROS_YES_NO>
            <PRODUCT_ID_SAMPLE>12345678901</PRODUCT_ID_SAMPLE>
        </ns1:consultaFinancierasACHDetailResponseRecordType>
        
        <ns1:consultaFinancierasACHDetailResponseRecordType>
            <TYPE_OF_PRODUCT>CORRIENTE</TYPE_OF_PRODUCT>
            <MIN_PRODUCT_ID_LENGTH>11</MIN_PRODUCT_ID_LENGTH>
            <MAX_PRODUCT_ID_LENGTH>13</MAX_PRODUCT_ID_LENGTH>
            <LEADING_ZEROS_YES_NO>NO</LEADING_ZEROS_YES_NO>
            <PRODUCT_ID_SAMPLE>98765432101</PRODUCT_ID_SAMPLE>
        </ns1:consultaFinancierasACHDetailResponseRecordType>
        
        <ns1:consultaFinancierasACHDetailResponseRecordType>
            <TYPE_OF_PRODUCT>TARJETA</TYPE_OF_PRODUCT>
            <MIN_PRODUCT_ID_LENGTH>16</MIN_PRODUCT_ID_LENGTH>
            <MAX_PRODUCT_ID_LENGTH>16</MAX_PRODUCT_ID_LENGTH>
            <LEADING_ZEROS_YES_NO>NO</LEADING_ZEROS_YES_NO>
            <PRODUCT_ID_SAMPLE>5412751234567890</PRODUCT_ID_SAMPLE>
        </ns1:consultaFinancierasACHDetailResponseRecordType>
        
        <ns1:consultaFinancierasACHDetailResponseRecordType>
            <TYPE_OF_PRODUCT>CREDITO</TYPE_OF_PRODUCT>
            <MIN_PRODUCT_ID_LENGTH>12</MIN_PRODUCT_ID_LENGTH>
            <MAX_PRODUCT_ID_LENGTH>15</MAX_PRODUCT_ID_LENGTH>
            <LEADING_ZEROS_YES_NO>YES</LEADING_ZEROS_YES_NO>
            <PRODUCT_ID_SAMPLE>001234567890</PRODUCT_ID_SAMPLE>
        </ns1:consultaFinancierasACHDetailResponseRecordType>
        
        <ns1:consultaFinancierasACHDetailResponseRecordType>
            <TYPE_OF_PRODUCT>NOMINA</TYPE_OF_PRODUCT>
            <MIN_PRODUCT_ID_LENGTH>11</MIN_PRODUCT_ID_LENGTH>
            <MAX_PRODUCT_ID_LENGTH>13</MAX_PRODUCT_ID_LENGTH>
            <LEADING_ZEROS_YES_NO>NO</LEADING_ZEROS_YES_NO>
            <PRODUCT_ID_SAMPLE>88776655443</PRODUCT_ID_SAMPLE>
        </ns1:consultaFinancierasACHDetailResponseRecordType>
    </ns1:consultaFinancierasACHDetailResponseType>
</ns1:consultaFinancierasACHResponseRecordType>
```

---

##### Detalle de ejecución: Posición 10 (Tercer banco - 007)

**Condición cumplida:** `$i = count($destinationCodes)` (es el último elemento)

###### Loop interno - evaluación de rango

**Pregunta:** `($i - 4) <= 0`?  
**Respuesta:** `(10 - 4) = 6 <= 0` → **NO (FALSE)**

Ejecuta el bloque `else`:

```xquery
for $j in ((10 - 4) to 10)  // Rango: 6 a 10
where data($destinationCodes[$j]) = data($destinationCodes[10])  // Busca todos los "007"
```

###### Productos encontrados:

| j | Código[$j] | ¿Es "007"? | ¿Incluir? |
|---|-----------|------------|-----------|
| 6 | 002 | ❌ No | Descarta |
| 7 | 002 | ❌ No | Descarta |
| 8 | 002 | ❌ No | Descarta |
| 9 | 007 | ✅ Sí | ✅ Incluye producto AHORROS |
| 10 | 007 | ✅ Sí | ✅ Incluye producto CORRIENTE |

###### XML generado para banco 007:

```xml
<ns1:consultaFinancierasACHResponseRecordType>
    <DESTINATION_CODE>007</DESTINATION_CODE>
    <DESTINATION_NAME>DAVIVIENDA</DESTINATION_NAME>
    
    <ns1:consultaFinancierasACHDetailResponseType>
        <ns1:consultaFinancierasACHDetailResponseRecordType>
            <TYPE_OF_PRODUCT>AHORROS</TYPE_OF_PRODUCT>
            <MIN_PRODUCT_ID_LENGTH>9</MIN_PRODUCT_ID_LENGTH>
            <MAX_PRODUCT_ID_LENGTH>11</MAX_PRODUCT_ID_LENGTH>
            <LEADING_ZEROS_YES_NO>YES</LEADING_ZEROS_YES_NO>
            <PRODUCT_ID_SAMPLE>001234567</PRODUCT_ID_SAMPLE>
        </ns1:consultaFinancierasACHDetailResponseRecordType>
        
        <ns1:consultaFinancierasACHDetailResponseRecordType>
            <TYPE_OF_PRODUCT>CORRIENTE</TYPE_OF_PRODUCT>
            <MIN_PRODUCT_ID_LENGTH>9</MIN_PRODUCT_ID_LENGTH>
            <MAX_PRODUCT_ID_LENGTH>11</MAX_PRODUCT_ID_LENGTH>
            <LEADING_ZEROS_YES_NO>YES</LEADING_ZEROS_YES_NO>
            <PRODUCT_ID_SAMPLE>009876543</PRODUCT_ID_SAMPLE>
        </ns1:consultaFinancierasACHDetailResponseRecordType>
    </ns1:consultaFinancierasACHDetailResponseType>
</ns1:consultaFinancierasACHResponseRecordType>
```

---

##### OUTPUT COMPLETO

```xml
<ns1:consultaFinancierasACHResponse>
    <ns1:consultaFinancierasACHResponseType>
        
        <!-- BANCO 001: BANCO DE BOGOTA (3 productos) -->
        <ns1:consultaFinancierasACHResponseRecordType>
            <DESTINATION_CODE>001</DESTINATION_CODE>
            <DESTINATION_NAME>BANCO DE BOGOTA</DESTINATION_NAME>
            <ns1:consultaFinancierasACHDetailResponseType>
                <ns1:consultaFinancierasACHDetailResponseRecordType>
                    <TYPE_OF_PRODUCT>AHORROS</TYPE_OF_PRODUCT>
                    <MIN_PRODUCT_ID_LENGTH>10</MIN_PRODUCT_ID_LENGTH>
                    <MAX_PRODUCT_ID_LENGTH>12</MAX_PRODUCT_ID_LENGTH>
                    <LEADING_ZEROS_YES_NO>YES</LEADING_ZEROS_YES_NO>
                    <PRODUCT_ID_SAMPLE>0012345678</PRODUCT_ID_SAMPLE>
                </ns1:consultaFinancierasACHDetailResponseRecordType>
                <ns1:consultaFinancierasACHDetailResponseRecordType>
                    <TYPE_OF_PRODUCT>CORRIENTE</TYPE_OF_PRODUCT>
                    <MIN_PRODUCT_ID_LENGTH>10</MIN_PRODUCT_ID_LENGTH>
                    <MAX_PRODUCT_ID_LENGTH>12</MAX_PRODUCT_ID_LENGTH>
                    <LEADING_ZEROS_YES_NO>YES</LEADING_ZEROS_YES_NO>
                    <PRODUCT_ID_SAMPLE>0098765432</PRODUCT_ID_SAMPLE>
                </ns1:consultaFinancierasACHDetailResponseRecordType>
                <ns1:consultaFinancierasACHDetailResponseRecordType>
                    <TYPE_OF_PRODUCT>CREDITO</TYPE_OF_PRODUCT>
                    <MIN_PRODUCT_ID_LENGTH>15</MIN_PRODUCT_ID_LENGTH>
                    <MAX_PRODUCT_ID_LENGTH>18</MAX_PRODUCT_ID_LENGTH>
                    <LEADING_ZEROS_YES_NO>NO</LEADING_ZEROS_YES_NO>
                    <PRODUCT_ID_SAMPLE>123456789012345</PRODUCT_ID_SAMPLE>
                </ns1:consultaFinancierasACHDetailResponseRecordType>
            </ns1:consultaFinancierasACHDetailResponseType>
        </ns1:consultaFinancierasACHResponseRecordType>
        
        <!-- BANCO 002: BANCOLOMBIA (5 productos) -->
        <ns1:consultaFinancierasACHResponseRecordType>
            <DESTINATION_CODE>002</DESTINATION_CODE>
            <DESTINATION_NAME>BANCOLOMBIA</DESTINATION_NAME>
            <ns1:consultaFinancierasACHDetailResponseType>
                <ns1:consultaFinancierasACHDetailResponseRecordType>
                    <TYPE_OF_PRODUCT>AHORROS</TYPE_OF_PRODUCT>
                    <MIN_PRODUCT_ID_LENGTH>11</MIN_PRODUCT_ID_LENGTH>
                    <MAX_PRODUCT_ID_LENGTH>13</MAX_PRODUCT_ID_LENGTH>
                    <LEADING_ZEROS_YES_NO>NO</LEADING_ZEROS_YES_NO>
                    <PRODUCT_ID_SAMPLE>12345678901</PRODUCT_ID_SAMPLE>
                </ns1:consultaFinancierasACHDetailResponseRecordType>
                <ns1:consultaFinancierasACHDetailResponseRecordType>
                    <TYPE_OF_PRODUCT>CORRIENTE</TYPE_OF_PRODUCT>
                    <MIN_PRODUCT_ID_LENGTH>11</MIN_PRODUCT_ID_LENGTH>
                    <MAX_PRODUCT_ID_LENGTH>13</MAX_PRODUCT_ID_LENGTH>
                    <LEADING_ZEROS_YES_NO>NO</LEADING_ZEROS_YES_NO>
                    <PRODUCT_ID_SAMPLE>98765432101</PRODUCT_ID_SAMPLE>
                </ns1:consultaFinancierasACHDetailResponseRecordType>
                <ns1:consultaFinancierasACHDetailResponseRecordType>
                    <TYPE_OF_PRODUCT>TARJETA</TYPE_OF_PRODUCT>
                    <MIN_PRODUCT_ID_LENGTH>16</MIN_PRODUCT_ID_LENGTH>
                    <MAX_PRODUCT_ID_LENGTH>16</MAX_PRODUCT_ID_LENGTH>
                    <LEADING_ZEROS_YES_NO>NO</LEADING_ZEROS_YES_NO>
                    <PRODUCT_ID_SAMPLE>5412751234567890</PRODUCT_ID_SAMPLE>
                </ns1:consultaFinancierasACHDetailResponseRecordType>
                <ns1:consultaFinancierasACHDetailResponseRecordType>
                    <TYPE_OF_PRODUCT>CREDITO</TYPE_OF_PRODUCT>
                    <MIN_PRODUCT_ID_LENGTH>12</MIN_PRODUCT_ID_LENGTH>
                    <MAX_PRODUCT_ID_LENGTH>15</MAX_PRODUCT_ID_LENGTH>
                    <LEADING_ZEROS_YES_NO>YES</LEADING_ZEROS_YES_NO>
                    <PRODUCT_ID_SAMPLE>001234567890</PRODUCT_ID_SAMPLE>
                </ns1:consultaFinancierasACHDetailResponseRecordType>
                <ns1:consultaFinancierasACHDetailResponseRecordType>
                    <TYPE_OF_PRODUCT>NOMINA</TYPE_OF_PRODUCT>
                    <MIN_PRODUCT_ID_LENGTH>11</MIN_PRODUCT_ID_LENGTH>
                    <MAX_PRODUCT_ID_LENGTH>13</MAX_PRODUCT_ID_LENGTH>
                    <LEADING_ZEROS_YES_NO>NO</LEADING_ZEROS_YES_NO>
                    <PRODUCT_ID_SAMPLE>88776655443</PRODUCT_ID_SAMPLE>
                </ns1:consultaFinancierasACHDetailResponseRecordType>
            </ns1:consultaFinancierasACHDetailResponseType>
        </ns1:consultaFinancierasACHResponseRecordType>
        
        <!-- BANCO 007: DAVIVIENDA (2 productos) -->
        <ns1:consultaFinancierasACHResponseRecordType>
            <DESTINATION_CODE>007</DESTINATION_CODE>
            <DESTINATION_NAME>DAVIVIENDA</DESTINATION_NAME>
            <ns1:consultaFinancierasACHDetailResponseType>
                <ns1:consultaFinancierasACHDetailResponseRecordType>
                    <TYPE_OF_PRODUCT>AHORROS</TYPE_OF_PRODUCT>
                    <MIN_PRODUCT_ID_LENGTH>9</MIN_PRODUCT_ID_LENGTH>
                    <MAX_PRODUCT_ID_LENGTH>11</MAX_PRODUCT_ID_LENGTH>
                    <LEADING_ZEROS_YES_NO>YES</LEADING_ZEROS_YES_NO>
                    <PRODUCT_ID_SAMPLE>001234567</PRODUCT_ID_SAMPLE>
                </ns1:consultaFinancierasACHDetailResponseRecordType>
                <ns1:consultaFinancierasACHDetailResponseRecordType>
                    <TYPE_OF_PRODUCT>CORRIENTE</TYPE_OF_PRODUCT>
                    <MIN_PRODUCT_ID_LENGTH>9</MIN_PRODUCT_ID_LENGTH>
                    <MAX_PRODUCT_ID_LENGTH>11</MAX_PRODUCT_ID_LENGTH>
                    <LEADING_ZEROS_YES_NO>YES</LEADING_ZEROS_YES_NO>
                    <PRODUCT_ID_SAMPLE>009876543</PRODUCT_ID_SAMPLE>
                </ns1:consultaFinancierasACHDetailResponseRecordType>
            </ns1:consultaFinancierasACHDetailResponseType>
        </ns1:consultaFinancierasACHResponseRecordType>
        
    </ns1:consultaFinancierasACHResponseType>
</ns1:consultaFinancierasACHResponse>
```

---

##### ¿Por qué el límite de búsqueda de 4 posiciones hacia atrás?

La lógica `if (($i - 4) <= 0)` establece un límite de búsqueda:

###### Caso 1: Primeros elementos (i ≤ 4)
```xquery
if (($i - 4) <= 0) then
    for $j in (1 to $i)  // Busca desde el inicio
```
**Razón:** No hay suficientes elementos anteriores, busca desde el principio.

###### Caso 2: Elementos posteriores (i > 4)
```xquery
else
    for $j in (($i - 4) to $i)  // Busca solo en las últimas 5 posiciones
```
**Razón:** Optimización - asume que un banco no tiene más de 5 productos.

###### ⚠️ Limitación crítica

Si un banco tiene **más de 5 productos**, este código **perderá datos**. Por ejemplo:

```
Banco 002 con 6 productos (posiciones 4-9):
- Al procesar posición 9 (último producto del banco)
- Busca solo de (9-4=5) a 9 → posiciones 5 a 9
- PIERDE el producto en posición 4
```

---

##### Resumen visual del algoritmo

```
Entrada: [001, 001, 001, 002, 002, 002, 002, 002, 007, 007]
          ↓    ↓    ↓    ↓    ↓    ↓    ↓    ↓    ↓    ↓
          1    2    3    4    5    6    7    8    9   10

Detección:      ✅                           ✅          ✅
               (cambio)                    (cambio)   (final)

Agrupación: [1,2,3]              [4,5,6,7,8]      [9,10]
               ↓                       ↓              ↓
          Banco 001              Banco 002      Banco 007
          3 productos            5 productos     2 productos
```

---

##### Ventajas del enfoque

1. ✅ **Flexibilidad**: Soporta diferente cantidad de productos por banco
2. ✅ **Detección automática**: No necesita configuración externa
3. ✅ **Eficiente**: Solo procesa en puntos de cambio

##### Desventajas y riesgos

1. ❌ **Límite de 5 productos**: Pierde datos si un banco tiene > 5 productos
2. ❌ **Dependencia de orden**: Los datos DEBEN venir ordenados por banco
3. ❌ **Sin validación**: No verifica integridad de datos paralelos
4. ❌ **Complejidad**: Difícil de mantener y debuggear

---

##### Mejora sugerida

Para eliminar el límite de 5 productos, cambiar:

```xquery
<!-- CÓDIGO ACTUAL (limitado) -->
if (($i - 4) <= 0) then
    for $j in (1 to $i)
else
    for $j in (($i - 4) to $i)

<!-- CÓDIGO MEJORADO (sin límite) -->
for $j in (1 to $i)
where data($destinationCodes[$j]) = data($destinationCodes[$i])
```

Esto elimina la restricción de búsqueda y siempre encuentra todos los productos del banco actual.

---

##### Conclusión

Este código implementa un patrón de **agrupación dinámica con detección de cambio**. Es útil cuando:
- Los datos vienen en listas paralelas ordenadas
- Cada grupo tiene cantidad variable de elementos
- No se puede predecir cuántos elementos tiene cada grupo

Sin embargo, la limitación de búsqueda hacia atrás (máximo 5 elementos) es un **defecto de diseño** que puede causar pérdida de datos en producción.

---

**Tecnologías y conceptos:**
- XQuery (consultas y transformaciones XML)
- Lógica de ventana deslizante (sliding window)
- Agrupación contigua (contiguous grouping)
- Oracle Service Bus / SOA Suite
- Web Services SOAP

#### Ejemplo Transformación CTS Nicaragua AS-IS

##### ¿Qué hace este código?

Este código procesa una **estructura XML jerárquica** donde cada banco ya viene agrupado como un objeto, y genera productos a partir de una cadena de texto delimitada por pipes (`|`). A diferencia de los enfoques anteriores que trabajan con listas paralelas, este código maneja **datos ya estructurados** y utiliza **valores por defecto** para los atributos de productos.


---

##### Código completo con anotaciones

```xquery
<ns1:consultaFinancierasACHResponse>
    <ns1:consultaFinancierasACHResponseType>
        {
            <!-- Loop principal: itera sobre cada banco en la estructura jerárquica -->
            for $banco in $opConsultaFinacierasACHRespuesta1/ns0:banco
            return
                <ns1:consultaFinancierasACHResponseRecordType>
                    {
                        <!-- Extrae código ACH del banco actual -->
                        <!-- Nota: FOR innecesario ya que solo hay un codigoAch por banco -->
                        for $codigoAch in $banco/ns0:codigoAch
                        return
                            <DESTINATION_CODE>{ data($codigoAch) }</DESTINATION_CODE>
                    }
                    {
                        <!-- Extrae nombre del banco actual -->
                        <!-- Nota: FOR innecesario ya que solo hay un nombreBanco por banco -->
                        for $nombreBanco in $banco/ns0:nombreBanco
                        return
                            <DESTINATION_NAME>{ data($nombreBanco) }</DESTINATION_NAME>
                    }
                    <ns1:consultaFinancierasACHDetailResponseType>
                        {
                            <!-- Tokeniza la variable $tiposProducto usando | como delimitador -->
                            <!-- Esta variable debe estar definida en el contexto externo -->
                            for $tipo in tokenize($tiposProducto, '\|')
                            return                                 	
                            <ns1:consultaFinancierasACHDetailResponseRecordType>
                                <!-- Tipo de producto extraído del token -->
                                <TYPE_OF_PRODUCT>{ $tipo }</TYPE_OF_PRODUCT>
                                
                                <!-- Valores por defecto hardcodeados -->
                                <!-- Mismo para TODOS los productos de TODOS los bancos -->
                                <MIN_PRODUCT_ID_LENGTH>1</MIN_PRODUCT_ID_LENGTH>
                                <MAX_PRODUCT_ID_LENGTH>100</MAX_PRODUCT_ID_LENGTH>
                                <LEADING_ZEROS_YES_NO>YES</LEADING_ZEROS_YES_NO>
                                <PRODUCT_ID_SAMPLE></PRODUCT_ID_SAMPLE>                                		                                	                               
                            </ns1:consultaFinancierasACHDetailResponseRecordType>
                        }   
                    </ns1:consultaFinancierasACHDetailResponseType>
                </ns1:consultaFinancierasACHResponseRecordType>
        }
    </ns1:consultaFinancierasACHResponseType>
</ns1:consultaFinancierasACHResponse>
```


##### Características clave

1. **Entrada jerárquica**: Los bancos ya vienen como objetos estructurados (no listas planas)
2. **Tokenización de productos**: Los tipos de producto vienen en un string delimitado por `|`
3. **Valores por defecto**: Todos los productos usan valores fijos para longitudes y configuraciones
4. **Iteración natural**: No requiere cálculos de índices o módulos

---

##### Estructura del proceso

###### PASO 1: Iteración sobre bancos estructurados

```xquery
for $banco in $opConsultaFinacierasACHRespuesta1/ns0:banco
```

Recorre cada elemento `<banco>` en la estructura XML de entrada.

###### PASO 2: Extracción de atributos del banco

```xquery
for $codigoAch in $banco/ns0:codigoAch
for $nombreBanco in $banco/ns0:nombreBanco
```

Extrae código y nombre de cada banco individual.

###### PASO 3: Tokenización y generación de productos

```xquery
for $tipo in tokenize($tiposProducto, '\|')
```

Divide el string de tipos de producto usando `|` como delimitador.

---

##### Ejemplo con datos reales

###### INPUT (Estructura XML jerárquica)

```xml
<opConsultaFinacierasACHRespuesta1>
    <!-- BANCO 1 -->
    <ns0:banco>
        <ns0:codigoAch>001</ns0:codigoAch>
        <ns0:nombreBanco>BANCO DE BOGOTA</ns0:nombreBanco>
    </ns0:banco>
    
    <!-- BANCO 2 -->
    <ns0:banco>
        <ns0:codigoAch>002</ns0:codigoAch>
        <ns0:nombreBanco>BANCOLOMBIA</ns0:nombreBanco>
    </ns0:banco>
    
    <!-- BANCO 3 -->
    <ns0:banco>
        <ns0:codigoAch>007</ns0:codigoAch>
        <ns0:nombreBanco>DAVIVIENDA</ns0:nombreBanco>
    </ns0:banco>
    
    <!-- BANCO 4 -->
    <ns0:banco>
        <ns0:codigoAch>013</ns0:codigoAch>
        <ns0:nombreBanco>BBVA COLOMBIA</ns0:nombreBanco>
    </ns0:banco>
</opConsultaFinacierasACHRespuesta1>
```

###### Variable externa: $tiposProducto

```
$tiposProducto = "AHORROS|CORRIENTE|TARJETA_CREDITO|CREDITO_HIPOTECARIO|CDT"
```

Esta variable (probablemente definida en el contexto del código o pasada como parámetro) contiene los tipos de productos delimitados por `|`.

---

##### Procesamiento paso a paso

###### Iteración 1: Banco 001 (BANCO DE BOGOTA)

##### Paso 1: Seleccionar banco
```xquery
$banco = <ns0:banco>
    <ns0:codigoAch>001</ns0:codigoAch>
    <ns0:nombreBanco>BANCO DE BOGOTA</ns0:nombreBanco>
</ns0:banco>
```

##### Paso 2: Extraer código y nombre
```xquery
$codigoAch = "001"
$nombreBanco = "BANCO DE BOGOTA"
```

##### Paso 3: Tokenizar tipos de productos
```xquery
tokenize("AHORROS|CORRIENTE|TARJETA_CREDITO|CREDITO_HIPOTECARIO|CDT", '\|')

Resultado: ["AHORROS", "CORRIENTE", "TARJETA_CREDITO", "CREDITO_HIPOTECARIO", "CDT"]
```

##### Paso 4: Generar productos

| Iteración | $tipo | XML generado |
|-----------|-------|--------------|
| 1 | AHORROS | `<TYPE_OF_PRODUCT>AHORROS</TYPE_OF_PRODUCT>` |
| 2 | CORRIENTE | `<TYPE_OF_PRODUCT>CORRIENTE</TYPE_OF_PRODUCT>` |
| 3 | TARJETA_CREDITO | `<TYPE_OF_PRODUCT>TARJETA_CREDITO</TYPE_OF_PRODUCT>` |
| 4 | CREDITO_HIPOTECARIO | `<TYPE_OF_PRODUCT>CREDITO_HIPOTECARIO</TYPE_OF_PRODUCT>` |
| 5 | CDT | `<TYPE_OF_PRODUCT>CDT</TYPE_OF_PRODUCT>` |

##### XML generado para banco 001

```xml
<ns1:consultaFinancierasACHResponseRecordType>
    <DESTINATION_CODE>001</DESTINATION_CODE>
    <DESTINATION_NAME>BANCO DE BOGOTA</DESTINATION_NAME>
    
    <ns1:consultaFinancierasACHDetailResponseType>
        <ns1:consultaFinancierasACHDetailResponseRecordType>
            <TYPE_OF_PRODUCT>AHORROS</TYPE_OF_PRODUCT>
            <MIN_PRODUCT_ID_LENGTH>1</MIN_PRODUCT_ID_LENGTH>
            <MAX_PRODUCT_ID_LENGTH>100</MAX_PRODUCT_ID_LENGTH>
            <LEADING_ZEROS_YES_NO>YES</LEADING_ZEROS_YES_NO>
            <PRODUCT_ID_SAMPLE></PRODUCT_ID_SAMPLE>
        </ns1:consultaFinancierasACHDetailResponseRecordType>
        
        <ns1:consultaFinancierasACHDetailResponseRecordType>
            <TYPE_OF_PRODUCT>CORRIENTE</TYPE_OF_PRODUCT>
            <MIN_PRODUCT_ID_LENGTH>1</MIN_PRODUCT_ID_LENGTH>
            <MAX_PRODUCT_ID_LENGTH>100</MAX_PRODUCT_ID_LENGTH>
            <LEADING_ZEROS_YES_NO>YES</LEADING_ZEROS_YES_NO>
            <PRODUCT_ID_SAMPLE></PRODUCT_ID_SAMPLE>
        </ns1:consultaFinancierasACHDetailResponseRecordType>
        
        <ns1:consultaFinancierasACHDetailResponseRecordType>
            <TYPE_OF_PRODUCT>TARJETA_CREDITO</TYPE_OF_PRODUCT>
            <MIN_PRODUCT_ID_LENGTH>1</MIN_PRODUCT_ID_LENGTH>
            <MAX_PRODUCT_ID_LENGTH>100</MAX_PRODUCT_ID_LENGTH>
            <LEADING_ZEROS_YES_NO>YES</LEADING_ZEROS_YES_NO>
            <PRODUCT_ID_SAMPLE></PRODUCT_ID_SAMPLE>
        </ns1:consultaFinancierasACHDetailResponseRecordType>
        
        <ns1:consultaFinancierasACHDetailResponseRecordType>
            <TYPE_OF_PRODUCT>CREDITO_HIPOTECARIO</TYPE_OF_PRODUCT>
            <MIN_PRODUCT_ID_LENGTH>1</MIN_PRODUCT_ID_LENGTH>
            <MAX_PRODUCT_ID_LENGTH>100</MAX_PRODUCT_ID_LENGTH>
            <LEADING_ZEROS_YES_NO>YES</LEADING_ZEROS_YES_NO>
            <PRODUCT_ID_SAMPLE></PRODUCT_ID_SAMPLE>
        </ns1:consultaFinancierasACHDetailResponseRecordType>
        
        <ns1:consultaFinancierasACHDetailResponseRecordType>
            <TYPE_OF_PRODUCT>CDT</TYPE_OF_PRODUCT>
            <MIN_PRODUCT_ID_LENGTH>1</MIN_PRODUCT_ID_LENGTH>
            <MAX_PRODUCT_ID_LENGTH>100</MAX_PRODUCT_ID_LENGTH>
            <LEADING_ZEROS_YES_NO>YES</LEADING_ZEROS_YES_NO>
            <PRODUCT_ID_SAMPLE></PRODUCT_ID_SAMPLE>
        </ns1:consultaFinancierasACHDetailResponseRecordType>
    </ns1:consultaFinancierasACHDetailResponseType>
</ns1:consultaFinancierasACHResponseRecordType>
```

---

###### Iteraciones 2, 3 y 4: Otros bancos

El proceso se repite **exactamente igual** para cada banco:
- Bancolombia (002)
- Davivienda (007)
- BBVA Colombia (013)

Cada uno genera los **mismos 5 productos** con los **mismos valores por defecto**.

---

##### OUTPUT COMPLETO

```xml
<ns1:consultaFinancierasACHResponse>
    <ns1:consultaFinancierasACHResponseType>
        
        <!-- ========== BANCO 001: BANCO DE BOGOTA ========== -->
        <ns1:consultaFinancierasACHResponseRecordType>
            <DESTINATION_CODE>001</DESTINATION_CODE>
            <DESTINATION_NAME>BANCO DE BOGOTA</DESTINATION_NAME>
            <ns1:consultaFinancierasACHDetailResponseType>
                <ns1:consultaFinancierasACHDetailResponseRecordType>
                    <TYPE_OF_PRODUCT>AHORROS</TYPE_OF_PRODUCT>
                    <MIN_PRODUCT_ID_LENGTH>1</MIN_PRODUCT_ID_LENGTH>
                    <MAX_PRODUCT_ID_LENGTH>100</MAX_PRODUCT_ID_LENGTH>
                    <LEADING_ZEROS_YES_NO>YES</LEADING_ZEROS_YES_NO>
                    <PRODUCT_ID_SAMPLE></PRODUCT_ID_SAMPLE>
                </ns1:consultaFinancierasACHDetailResponseRecordType>
                <ns1:consultaFinancierasACHDetailResponseRecordType>
                    <TYPE_OF_PRODUCT>CORRIENTE</TYPE_OF_PRODUCT>
                    <MIN_PRODUCT_ID_LENGTH>1</MIN_PRODUCT_ID_LENGTH>
                    <MAX_PRODUCT_ID_LENGTH>100</MAX_PRODUCT_ID_LENGTH>
                    <LEADING_ZEROS_YES_NO>YES</LEADING_ZEROS_YES_NO>
                    <PRODUCT_ID_SAMPLE></PRODUCT_ID_SAMPLE>
                </ns1:consultaFinancierasACHDetailResponseRecordType>
                <ns1:consultaFinancierasACHDetailResponseRecordType>
                    <TYPE_OF_PRODUCT>TARJETA_CREDITO</TYPE_OF_PRODUCT>
                    <MIN_PRODUCT_ID_LENGTH>1</MIN_PRODUCT_ID_LENGTH>
                    <MAX_PRODUCT_ID_LENGTH>100</MAX_PRODUCT_ID_LENGTH>
                    <LEADING_ZEROS_YES_NO>YES</LEADING_ZEROS_YES_NO>
                    <PRODUCT_ID_SAMPLE></PRODUCT_ID_SAMPLE>
                </ns1:consultaFinancierasACHDetailResponseRecordType>
                <ns1:consultaFinancierasACHDetailResponseRecordType>
                    <TYPE_OF_PRODUCT>CREDITO_HIPOTECARIO</TYPE_OF_PRODUCT>
                    <MIN_PRODUCT_ID_LENGTH>1</MIN_PRODUCT_ID_LENGTH>
                    <MAX_PRODUCT_ID_LENGTH>100</MAX_PRODUCT_ID_LENGTH>
                    <LEADING_ZEROS_YES_NO>YES</LEADING_ZEROS_YES_NO>
                    <PRODUCT_ID_SAMPLE></PRODUCT_ID_SAMPLE>
                </ns1:consultaFinancierasACHDetailResponseRecordType>
                <ns1:consultaFinancierasACHDetailResponseRecordType>
                    <TYPE_OF_PRODUCT>CDT</TYPE_OF_PRODUCT>
                    <MIN_PRODUCT_ID_LENGTH>1</MIN_PRODUCT_ID_LENGTH>
                    <MAX_PRODUCT_ID_LENGTH>100</MAX_PRODUCT_ID_LENGTH>
                    <LEADING_ZEROS_YES_NO>YES</LEADING_ZEROS_YES_NO>
                    <PRODUCT_ID_SAMPLE></PRODUCT_ID_SAMPLE>
                </ns1:consultaFinancierasACHDetailResponseRecordType>
            </ns1:consultaFinancierasACHDetailResponseType>
        </ns1:consultaFinancierasACHResponseRecordType>
        
        <!-- ========== BANCO 002: BANCOLOMBIA ========== -->
        <ns1:consultaFinancierasACHResponseRecordType>
            <DESTINATION_CODE>002</DESTINATION_CODE>
            <DESTINATION_NAME>BANCOLOMBIA</DESTINATION_NAME>
            <ns1:consultaFinancierasACHDetailResponseType>
                <ns1:consultaFinancierasACHDetailResponseRecordType>
                    <TYPE_OF_PRODUCT>AHORROS</TYPE_OF_PRODUCT>
                    <MIN_PRODUCT_ID_LENGTH>1</MIN_PRODUCT_ID_LENGTH>
                    <MAX_PRODUCT_ID_LENGTH>100</MAX_PRODUCT_ID_LENGTH>
                    <LEADING_ZEROS_YES_NO>YES</LEADING_ZEROS_YES_NO>
                    <PRODUCT_ID_SAMPLE></PRODUCT_ID_SAMPLE>
                </ns1:consultaFinancierasACHDetailResponseRecordType>
                <ns1:consultaFinancierasACHDetailResponseRecordType>
                    <TYPE_OF_PRODUCT>CORRIENTE</TYPE_OF_PRODUCT>
                    <MIN_PRODUCT_ID_LENGTH>1</MIN_PRODUCT_ID_LENGTH>
                    <MAX_PRODUCT_ID_LENGTH>100</MAX_PRODUCT_ID_LENGTH>
                    <LEADING_ZEROS_YES_NO>YES</LEADING_ZEROS_YES_NO>
                    <PRODUCT_ID_SAMPLE></PRODUCT_ID_SAMPLE>
                </ns1:consultaFinancierasACHDetailResponseRecordType>
                <ns1:consultaFinancierasACHDetailResponseRecordType>
                    <TYPE_OF_PRODUCT>TARJETA_CREDITO</TYPE_OF_PRODUCT>
                    <MIN_PRODUCT_ID_LENGTH>1</MIN_PRODUCT_ID_LENGTH>
                    <MAX_PRODUCT_ID_LENGTH>100</MAX_PRODUCT_ID_LENGTH>
                    <LEADING_ZEROS_YES_NO>YES</LEADING_ZEROS_YES_NO>
                    <PRODUCT_ID_SAMPLE></PRODUCT_ID_SAMPLE>
                </ns1:consultaFinancierasACHDetailResponseRecordType>
                <ns1:consultaFinancierasACHDetailResponseRecordType>
                    <TYPE_OF_PRODUCT>CREDITO_HIPOTECARIO</TYPE_OF_PRODUCT>
                    <MIN_PRODUCT_ID_LENGTH>1</MIN_PRODUCT_ID_LENGTH>
                    <MAX_PRODUCT_ID_LENGTH>100</MAX_PRODUCT_ID_LENGTH>
                    <LEADING_ZEROS_YES_NO>YES</LEADING_ZEROS_YES_NO>
                    <PRODUCT_ID_SAMPLE></PRODUCT_ID_SAMPLE>
                </ns1:consultaFinancierasACHDetailResponseRecordType>
                <ns1:consultaFinancierasACHDetailResponseRecordType>
                    <TYPE_OF_PRODUCT>CDT</TYPE_OF_PRODUCT>
                    <MIN_PRODUCT_ID_LENGTH>1</MIN_PRODUCT_ID_LENGTH>
                    <MAX_PRODUCT_ID_LENGTH>100</MAX_PRODUCT_ID_LENGTH>
                    <LEADING_ZEROS_YES_NO>YES</LEADING_ZEROS_YES_NO>
                    <PRODUCT_ID_SAMPLE></PRODUCT_ID_SAMPLE>
                </ns1:consultaFinancierasACHDetailResponseRecordType>
            </ns1:consultaFinancierasACHDetailResponseType>
        </ns1:consultaFinancierasACHResponseRecordType>
        
        <!-- ========== BANCO 007: DAVIVIENDA ========== -->
        <ns1:consultaFinancierasACHResponseRecordType>
            <DESTINATION_CODE>007</DESTINATION_CODE>
            <DESTINATION_NAME>DAVIVIENDA</DESTINATION_NAME>
            <ns1:consultaFinancierasACHDetailResponseType>
                <ns1:consultaFinancierasACHDetailResponseRecordType>
                    <TYPE_OF_PRODUCT>AHORROS</TYPE_OF_PRODUCT>
                    <MIN_PRODUCT_ID_LENGTH>1</MIN_PRODUCT_ID_LENGTH>
                    <MAX_PRODUCT_ID_LENGTH>100</MAX_PRODUCT_ID_LENGTH>
                    <LEADING_ZEROS_YES_NO>YES</LEADING_ZEROS_YES_NO>
                    <PRODUCT_ID_SAMPLE></PRODUCT_ID_SAMPLE>
                </ns1:consultaFinancierasACHDetailResponseRecordType>
                <ns1:consultaFinancierasACHDetailResponseRecordType>
                    <TYPE_OF_PRODUCT>CORRIENTE</TYPE_OF_PRODUCT>
                    <MIN_PRODUCT_ID_LENGTH>1</MIN_PRODUCT_ID_LENGTH>
                    <MAX_PRODUCT_ID_LENGTH>100</MAX_PRODUCT_ID_LENGTH>
                    <LEADING_ZEROS_YES_NO>YES</LEADING_ZEROS_YES_NO>
                    <PRODUCT_ID_SAMPLE></PRODUCT_ID_SAMPLE>
                </ns1:consultaFinancierasACHDetailResponseRecordType>
                <ns1:consultaFinancierasACHDetailResponseRecordType>
                    <TYPE_OF_PRODUCT>TARJETA_CREDITO</TYPE_OF_PRODUCT>
                    <MIN_PRODUCT_ID_LENGTH>1</MIN_PRODUCT_ID_LENGTH>
                    <MAX_PRODUCT_ID_LENGTH>100</MAX_PRODUCT_ID_LENGTH>
                    <LEADING_ZEROS_YES_NO>YES</LEADING_ZEROS_YES_NO>
                    <PRODUCT_ID_SAMPLE></PRODUCT_ID_SAMPLE>
                </ns1:consultaFinancierasACHDetailResponseRecordType>
                <ns1:consultaFinancierasACHDetailResponseRecordType>
                    <TYPE_OF_PRODUCT>CREDITO_HIPOTECARIO</TYPE_OF_PRODUCT>
                    <MIN_PRODUCT_ID_LENGTH>1</MIN_PRODUCT_ID_LENGTH>
                    <MAX_PRODUCT_ID_LENGTH>100</MAX_PRODUCT_ID_LENGTH>
                    <LEADING_ZEROS_YES_NO>YES</LEADING_ZEROS_YES_NO>
                    <PRODUCT_ID_SAMPLE></PRODUCT_ID_SAMPLE>
                </ns1:consultaFinancierasACHDetailResponseRecordType>
                <ns1:consultaFinancierasACHDetailResponseRecordType>
                    <TYPE_OF_PRODUCT>CDT</TYPE_OF_PRODUCT>
                    <MIN_PRODUCT_ID_LENGTH>1</MIN_PRODUCT_ID_LENGTH>
                    <MAX_PRODUCT_ID_LENGTH>100</MAX_PRODUCT_ID_LENGTH>
                    <LEADING_ZEROS_YES_NO>YES</LEADING_ZEROS_YES_NO>
                    <PRODUCT_ID_SAMPLE></PRODUCT_ID_SAMPLE>
                </ns1:consultaFinancierasACHDetailResponseRecordType>
            </ns1:consultaFinancierasACHDetailResponseType>
        </ns1:consultaFinancierasACHResponseRecordType>
        
        <!-- ========== BANCO 013: BBVA COLOMBIA ========== -->
        <ns1:consultaFinancierasACHResponseRecordType>
            <DESTINATION_CODE>013</DESTINATION_CODE>
            <DESTINATION_NAME>BBVA COLOMBIA</DESTINATION_NAME>
            <ns1:consultaFinancierasACHDetailResponseType>
                <ns1:consultaFinancierasACHDetailResponseRecordType>
                    <TYPE_OF_PRODUCT>AHORROS</TYPE_OF_PRODUCT>
                    <MIN_PRODUCT_ID_LENGTH>1</MIN_PRODUCT_ID_LENGTH>
                    <MAX_PRODUCT_ID_LENGTH>100</MAX_PRODUCT_ID_LENGTH>
                    <LEADING_ZEROS_YES_NO>YES</LEADING_ZEROS_YES_NO>
                    <PRODUCT_ID_SAMPLE></PRODUCT_ID_SAMPLE>
                </ns1:consultaFinancierasACHDetailResponseRecordType>
                <ns1:consultaFinancierasACHDetailResponseRecordType>
                    <TYPE_OF_PRODUCT>CORRIENTE</TYPE_OF_PRODUCT>
                    <MIN_PRODUCT_ID_LENGTH>1</MIN_PRODUCT_ID_LENGTH>
                    <MAX_PRODUCT_ID_LENGTH>100</MAX_PRODUCT_ID_LENGTH>
                    <LEADING_ZEROS_YES_NO>YES</LEADING_ZEROS_YES_NO>
                    <PRODUCT_ID_SAMPLE></PRODUCT_ID_SAMPLE>
                </ns1:consultaFinancierasACHDetailResponseRecordType>
                <ns1:consultaFinancierasACHDetailResponseRecordType>
                    <TYPE_OF_PRODUCT>TARJETA_CREDITO</TYPE_OF_PRODUCT>
                    <MIN_PRODUCT_ID_LENGTH>1</MIN_PRODUCT_ID_LENGTH>
                    <MAX_PRODUCT_ID_LENGTH>100</MAX_PRODUCT_ID_LENGTH>
                    <LEADING_ZEROS_YES_NO>YES</LEADING_ZEROS_YES_NO>
                    <PRODUCT_ID_SAMPLE></PRODUCT_ID_SAMPLE>
                </ns1:consultaFinancierasACHDetailResponseRecordType>
                <ns1:consultaFinancierasACHDetailResponseRecordType>
                    <TYPE_OF_PRODUCT>CREDITO_HIPOTECARIO</TYPE_OF_PRODUCT>
                    <MIN_PRODUCT_ID_LENGTH>1</MIN_PRODUCT_ID_LENGTH>
                    <MAX_PRODUCT_ID_LENGTH>100</MAX_PRODUCT_ID_LENGTH>
                    <LEADING_ZEROS_YES_NO>YES</LEADING_ZEROS_YES_NO>
                    <PRODUCT_ID_SAMPLE></PRODUCT_ID_SAMPLE>
                </ns1:consultaFinancierasACHDetailResponseRecordType>
                <ns1:consultaFinancierasACHDetailResponseRecordType>
                    <TYPE_OF_PRODUCT>CDT</TYPE_OF_PRODUCT>
                    <MIN_PRODUCT_ID_LENGTH>1</MIN_PRODUCT_ID_LENGTH>
                    <MAX_PRODUCT_ID_LENGTH>100</MAX_PRODUCT_ID_LENGTH>
                    <LEADING_ZEROS_YES_NO>YES</LEADING_ZEROS_YES_NO>
                    <PRODUCT_ID_SAMPLE></PRODUCT_ID_SAMPLE>
                </ns1:consultaFinancierasACHDetailResponseRecordType>
            </ns1:consultaFinancierasACHDetailResponseType>
        </ns1:consultaFinancierasACHResponseRecordType>
        
    </ns1:consultaFinancierasACHResponseType>
</ns1:consultaFinancierasACHResponse>
```

---

##### Diagrama visual del algoritmo

```
INPUT JERÁRQUICO:
┌─────────────────────────────────────┐
│ <banco>                             │
│   <codigoAch>001</codigoAch>        │
│   <nombreBanco>BANCO DE BOGOTA...   │
│ </banco>                            │
│ <banco>                             │
│   <codigoAch>002</codigoAch>        │
│   <nombreBanco>BANCOLOMBIA</...     │
│ </banco>                            │
│ ...                                 │
└─────────────────────────────────────┘
                 ↓
         FOR EACH BANCO
                 ↓
┌─────────────────────────────────────┐
│ Variable: $tiposProducto            │
│ "AHORROS|CORRIENTE|TARJETA|..."     │
└─────────────────────────────────────┘
                 ↓
          TOKENIZE POR |
                 ↓
┌─────────────────────────────────────┐
│ Array: [AHORROS, CORRIENTE, ...]    │
└─────────────────────────────────────┘
                 ↓
        FOR EACH PRODUCTO
                 ↓
┌─────────────────────────────────────┐
│ Generar XML con valores por defecto:│
│ - MIN: 1                            │
│ - MAX: 100                          │
│ - LEADING_ZEROS: YES                │
│ - SAMPLE: (vacío)                   │
└─────────────────────────────────────┘
                 ↓
       OUTPUT JERÁRQUICO
```

---

##### Análisis detallado del código

###### 1. Loop principal sobre bancos

```xquery
for $banco in $opConsultaFinacierasACHRespuesta1/ns0:banco
```

**Tipo de iteración:** Natural, sobre elementos XML estructurados

**Ventajas:**
- ✅ Muy legible y natural
- ✅ No requiere índices numéricos
- ✅ Funciona con cualquier cantidad de bancos
- ✅ Orden garantizado por la estructura XML

###### 2. Extracción de atributos del banco

```xquery
for $codigoAch in $banco/ns0:codigoAch
return <DESTINATION_CODE>{ data($codigoAch) }</DESTINATION_CODE>

for $nombreBanco in $banco/ns0:nombreBanco
return <DESTINATION_NAME>{ data($nombreBanco) }</DESTINATION_NAME>
```

**Patrón utilizado:** FOR-RETURN individual para cada campo

**Observación importante:** 
- Usa `for` aunque solo haya un elemento
- Más verboso de lo necesario
- Podría simplificarse a: `<DESTINATION_CODE>{ data($banco/ns0:codigoAch) }</DESTINATION_CODE>`

###### 3. Tokenización de productos

```xquery
for $tipo in tokenize($tiposProducto, '\|')
```

**Función:** `tokenize(string, pattern)`
- **Parámetro 1:** String a dividir (`$tiposProducto`)
- **Parámetro 2:** Patrón delimitador (`'\|'` - pipe escapado)

**Resultado:** Secuencia de strings, uno por cada token

**Ejemplo:**
```xquery
tokenize("A|B|C", '\|') → ("A", "B", "C")
```

###### 4. Valores por defecto hardcodeados

```xquery
<MIN_PRODUCT_ID_LENGTH>1</MIN_PRODUCT_ID_LENGTH>
<MAX_PRODUCT_ID_LENGTH>100</MAX_PRODUCT_ID_LENGTH>
<LEADING_ZEROS_YES_NO>YES</LEADING_ZEROS_YES_NO>
<PRODUCT_ID_SAMPLE></PRODUCT_ID_SAMPLE>
```

**Implicación:** 
- ⚠️ TODOS los productos de TODOS los bancos tienen los mismos valores
- No hay diferenciación por tipo de producto o banco
- Valores genéricos y permisivos (1-100 caracteres)

---

##### Comportamiento con diferentes escenarios

###### Escenario 1: Variable $tiposProducto con 3 productos

```
$tiposProducto = "AHORROS|CORRIENTE|CDT"
```

**Resultado:** Cada banco tendrá exactamente 3 productos

---

###### Escenario 2: Variable $tiposProducto vacía

```
$tiposProducto = ""
```

**Resultado:** 
```xquery
tokenize("", '\|') → ("")
```

Generará **1 producto vacío** para cada banco:
```xml
<ns1:consultaFinancierasACHDetailResponseRecordType>
    <TYPE_OF_PRODUCT></TYPE_OF_PRODUCT>
    <MIN_PRODUCT_ID_LENGTH>1</MIN_PRODUCT_ID_LENGTH>
    ...
</ns1:consultaFinancierasACHDetailResponseRecordType>
```

---

###### Escenario 3: Banco sin código o nombre

```xml
<ns0:banco>
    <ns0:codigoAch></ns0:codigoAch>
    <ns0:nombreBanco></ns0:nombreBanco>
</ns0:banco>
```

**Resultado:** Generará elementos vacíos
```xml
<DESTINATION_CODE></DESTINATION_CODE>
<DESTINATION_NAME></DESTINATION_NAME>
```

---

###### Escenario 4: Variable $tiposProducto con productos duplicados

```
$tiposProducto = "AHORROS|AHORROS|CORRIENTE"
```

**Resultado:** Generará productos duplicados (tipo "AHORROS" aparecerá dos veces)

---

##### Ventajas del enfoque

###### ✅ Pros

1. **Simplicidad extrema:** Código muy fácil de leer y entender
2. **Flexibilidad de entrada:** Acepta cualquier cantidad de bancos
3. **No requiere sincronización:** No hay listas paralelas que alinear
4. **Fácil configuración:** Cambiar productos es solo modificar el string delimitado
5. **Escalabilidad:** Funciona igual con 1 banco o 1000 bancos
6. **Mantenibilidad:** Muy fácil de modificar y mantener

###### ❌ Contras

1. **Valores genéricos:** No personaliza atributos por banco o producto
2. **Falta de validación:** No valida si $tiposProducto está definido o es válido
3. **Datos incompletos:** PRODUCT_ID_SAMPLE siempre vacío
4. **Repetición innecesaria:** Usa loops FOR donde no son necesarios
5. **Dependencia externa:** Requiere que $tiposProducto esté definido fuera del código
6. **Sin diferenciación:** Todos los bancos tienen exactamente los mismos productos

---

##### Comparación con otros enfoques

| Característica | Este código | Mod 4 | Detección cambio | Tokenize "||" |
|---------------|-------------|-------|------------------|---------------|
| Estructura entrada | Jerárquica | Listas planas | Listas planas | Listas planas |
| Flexibilidad bancos | ✅ Total | ❌ Fija (mod 4) | ✅ Alta | ✅ Alta |
| Flexibilidad productos | ✅ Configurable | ❌ Fija | ✅ Variable | ✅ Variable |
| Valores personalizados | ❌ No | ✅ Sí | ✅ Sí | ✅ Sí |
| Complejidad | ⭐ Muy baja | ⭐ Baja | ⭐⭐ Media | ⭐⭐⭐ Alta |
| Robustez | ⭐⭐ Media | ❌ Frágil | ✅ Robusta | ✅ Robusta |
| Uso típico | Mock/Demo | Legacy fijo | Producción | Sistema complejo |

---

##### Casos de uso ideales

###### ✅ Cuándo usar este enfoque:

1. **Ambientes de desarrollo/pruebas:** Generar respuestas mock rápidamente
2. **Prototipado:** Validar estructura sin datos reales
3. **Catálogo genérico:** Cuando todos los bancos ofrecen los mismos productos
4. **Simplificación intencional:** Cuando la personalización no es requerida
5. **Migración inicial:** Como paso intermedio antes de implementar lógica compleja

###### ❌ Cuándo NO usar este enfoque:

1. **Producción con datos reales:** Requiere valores específicos por producto/banco
2. **Validación estricta:** Necesita longitudes y reglas específicas
3. **Diferentes productos por banco:** Cada banco tiene su propio catálogo
4. **Trazabilidad:** Requiere samples y metadatos específicos
5. **Cumplimiento regulatorio:** Necesita validaciones precisas

---

##### Mejoras sugeridas

###### Mejora 1: Eliminar loops innecesarios

**Código actual:**
```xquery
for $codigoAch in $banco/ns0:codigoAch
return <DESTINATION_CODE>{ data($codigoAch) }</DESTINATION_CODE>
```

**Código mejorado:**
```xquery
<DESTINATION_CODE>{ data($banco/ns0:codigoAch) }</DESTINATION_CODE>
```

---

###### Mejora 2: Validación de $tiposProducto

**Código actual:** Sin validación

**Código mejorado:**
```xquery
{
    if (string-length($tiposProducto) > 0) then
        for $tipo in tokenize($tiposProducto, '\|')
        where string-length($tipo) > 0
        return ...
    else
        ()
}
```

---

###### Mejora 3: Valores configurables por tipo de producto

**Código actual:** Valores fijos

**Código mejorado:**
```xquery
let $configuraciones := map {
    "AHORROS": map{"min": 10, "max": 12, "zeros": "YES"},
    "CORRIENTE": map{"min": 10, "max": 12, "zeros": "YES"},
    "TARJETA_CREDITO": map{"min": 16, "max": 16, "zeros": "NO"}
}

for $tipo in tokenize($tiposProducto, '\|')
let $config := $configuraciones($tipo)
return
    <ns1:consultaFinancierasACHDetailResponseRecordType>
        <TYPE_OF_PRODUCT>{ $tipo }</TYPE_OF_PRODUCT>
        <MIN_PRODUCT_ID_LENGTH>{ $config("min") }</MIN_PRODUCT_ID_LENGTH>
        <MAX_PRODUCT_ID_LENGTH>{ $config("max") }</MAX_PRODUCT_ID_LENGTH>
        <LEADING_ZEROS_YES_NO>{ $config("zeros") }</LEADING_ZEROS_YES_NO>
    </ns1:consultaFinancierasACHDetailResponseRecordType>
```

### 15.2. Resilencia y Reliability

#### 15.2.1. Circuitbraker
  - **Failure Rate Threshold: 50%** - Si el 50% o más de las llamadas fallan, el circuito se abre
  - **Slow Call Rate Threshold: 50%** - Si el 50% o más de las llamadas son lentas, el circuito se abre
  - **Slow Call Duration Threshold: 20000ms** - Una llamada se considera "lenta" si tarda más de 20 segundos
  - **Minimum Number of Calls: 10** - Necesita al menos 10 llamadas antes de evaluar si abrir el circuito
  - **Sliding Window Size: 100** - Analiza las últimas 100 llamadas para calcular estadísticas
  - **Wait Duration in Open State: 60s** - Cuando está abierto, espera 60 segundos antes de pasar a semi-abierto
  - **Permitted Number of Calls in Half Open: 5** - En estado semi-abierto, permite máximo 5 llamadas de prueba
  - **Timeout Configuration**: Per-service timeout settings (30s)

Nombre de parámetro para almacenar la configuración: `ban-xrs-lc-parm-circuit_braker-{env}-default`

```
{
  "resilience4j": {
    "circuitbreaker": {
      "instances": {
        "defaultConfig": {
          "failureRateThreshold": 50,
          "slowCallRateThreshold": 50,
          "slowCallDurationThreshold": "20s",
          "minimumNumberOfCalls": 10,
          "slidingWindowSize": 100,
          "slidingWindowType": "COUNT_BASED",
          "waitDurationInOpenState": "60s",
          "permittedNumberOfCallsInHalfOpenState": 5,
          "automaticTransitionFromOpenToHalfOpenEnabled": true,
          "recordExceptions": [
            "java.io.IOException",
            "java.util.concurrent.TimeoutException"
          ]
        }
      }
    },
    "timelimiter": {
      "instances": {
        "defaultConfig": {
          "timeoutDuration": "30s"
        }
      }
    }
  }
}
```
### 15.3. Parámetros para validación de región

> Teniendo en cuenta el soruceBank y el destinatioBank que venga en los header de la petición con la que se consume la api de producto verificar si en el método está habilitado o no. En caso de no estar en el arreglo de región se toma como false.

```json
//REQUEST
{
  "op": "GetParameter",
   "correlationId": "e1b3b0a7-8a8c-4e4b-9b2e-5c4cd7a1f3b1", 
   "country": "XRS",
   "domain": "PAYMENT_RAIL_OPERATIONS_RETRIEVE",
   "name": "CONFIG",
   "version": "0001"
}
```

```json
//RESPONSE
{
  "status": "Success",
  "correlationId": "e1b3b0a7-8a8c-4e4b-9b2e-5c4cd7a1f3b1",
  "data": {
    "name": "CONFIG",
    "value": {
    "methods": {
      "retrieve": {
        "regions": [
          {
            "region": "GT01-GT01",
            "enabled": true
          },
          {
            "region": "HN01-HN01",
            "enabled": true
          },
          {
            "region": "HN02-HN02",
            "enabled": true
          },
          {
            "region": "NI01-NI01",
            "enabled": true
          },
          {
            "region": "PA01-PA01",
            "enabled": true
          }
        ]
      }
    }
  },
  "type": "JSON",
  "description": "CONFIG OF PAYMENT_RAIL_OPERATIONS_RETRIEVE BY METHOD",
  "country": "XRS",
  "domain": "PAYMENT_RAIL_OPERATIONS_RETRIEVE",
  "tags": [],
  "precedence": 10,
  "effective_from": "",
  "effective_to": "",
  "status": "active",
  "updated_at": "2025-01-14T18:10:00Z",
  "updated_by": "david.j.molano@ficohsa.com"
  }
}
```
#### REGISTRO EN DYNAMODB PARAMTER

>dominio de la api  PAYMENT_RAIL_OPERATIONS_RETRIEVE

```json
//REGISTRO EN DYNAMODB PARAMETER - CONFIGURACIÓN POR MÉTODO
{  
  "pk": "COUNTRY#XRS#DOMAIN#PAYMENT_RAIL_OPERATIONS_RETRIEVE#PARAM#CONFIG",
  "sk": "V#0001",
  "name": "CONFIG",
  "version": "0001",
  "value": {
    "methods": {
      "retrieve": {
        "regions": [
          {
            "region": "GT01-GT01",
            "enabled": true
          },
          {
            "region": "HN01-HN01",
            "enabled": true
          },
          {
            "region": "HN02-HN02",
            "enabled": true
          },
          {
            "region": "NI01-NI01",
            "enabled": true
          },
          {
            "region": "PA01-PA01",
            "enabled": true
          }
        ]
      }
    }
  },
  "type": "JSON",
  "description": "CONFIG OF PAYMENT_RAIL_OPERATIONS_RETRIEVE BY METHOD",
  "country": "XRS",
  "domain": "PAYMENT_RAIL_OPERATIONS_RETRIEVE",
  "tags": [],
  "precedence": 10,
  "effective_from": "",
  "effective_to": "",
  "status": "active",
  "updated_at": "2025-01-14T18:10:00Z",
  "updated_by": "david.j.molano@ficohsa.com"
}
```

### 15.4. REGISTRO EN DYNAMODB PARAMTER - Configuración Wrapper T24 - Metodo 1 - GET /payments/payment-rail-operations-retrieves/v1/retrieve

```json
{
  "pk": "COUNTRY#HND#DOMAIN#WRAPPER_T24#PARAM#Application-ID|payment_rail_operations_retrieves-product_retrieve",
  "sk": "V#0001",
  "name": "Application-ID|payment_rail_operations_retrieves-product_retrieve",
  "value": "{
          secret-name: ban-hnd-ap-t24-consulta-de-destinos-ach-secm-wsdl-<env>, 
          param-name: ban-hnd-ap-t24-consulta-de-destinos-ach-param-wsdl-<env>
   }",   //nombre del secreto y nombre del parámetro
  "type": "json",
  "description": "credenciales de la operación ReversiondePagodeCheques del método payment_rail_operations_retrieves-product_retrieve",
  "country": "HND",
  "domain": "WRAPPER_T24",
  "tags": ["consulta-de-destinos-ach", "secret-manager-key"],
  "precedence": 1,
  "effective_from": "",
  "effective_to": "",
  "status": "active",
  "updated_at": "2025-10-25T18:10:00Z",
  "updated_by": "david.j.molano@ficohsa.com"
}
```

```
ban-hnd-ap-t24-consulta-de-destinos-ach-secm-wsdl-<env>
{
  "username": "...",
  "password": "..." 
}

ban-hnd-ap-t24-consulta-de-destinos-ach-param-wsdl-<env>
{
  "ip": "http://10.9.104.97",
  "port": "7003",
  "basePath": "/svcCore/services" 
}
```

### 15.5. Request para consumir el Wrapper FICOPEN - Metodo 1 - GET /payments/payment-rail-operations-retrieves/v1/retrieve

Request

```JSON
{
  "operation": "query",
  "data": {},
  "paramName": "ban-hnd-ap-ficopen-consulta-entes-bancos-param-wsdl-<env>"
}
```
### 15.5.1. Configuración en parameter stor para consumir el Wrapper FICOPEN - Metodo 1 - GET /payments/payment-rail-operations-retrieves/v1/retrieve

```
ban-hnd-ap-ficopen-consulta-entes-bancos-param-wsdl-<env>
{
  "valor": "/api/v2/entes/bancos"
}
```

### 15.6. Request para consumir el Wrapper Proxy Abanks GT - Metodo 1 - GET /payments/payment-rail-operations-retrieves/v1/retrieve

Request

```JSON
{
  "connectionType": "jca",
  "operationType": "query",
  "catalogueName": "proxyabanksgt",
  "procedureName": "TOPLEVEL$OSB_P_CON_FINANCIERA",
  "params": {
    "DESTINATION_CODE": "queryParam.destinationInstitutionReference" //Opcional
  }
}
```

### 15.7. Request para consumir el Wrapper Proxy Abanks PA - Metodo 1 - GET /payments/payment-rail-operations-retrieves/v1/retrieve

Request

```JSON
{
  "connectionType": "jca",
  "operationType": "query",
  "catalogueName": "proxyabankspa",
  "procedureName": "TOPLEVEL$OSB_P_CON_FINANCIERA",
  "params": {
    "DESTINATION_CODE": "queryParam.destinationInstitutionReference" //Opcional
  }
}
```

### 15.8. Configuración para consumir el Wrapper Cobis CTS Nicaragua - Metodo 1 - GET /payments/payment-rail-operations-retrieves/v1/retrieve

```JSON
{
    "data": {
        "connectionName": "cob_atm", // esto es la bd
        "catalogueName": "dbo", // esto es el squema
        "procedureName": "sp_OSB_consulta_TD", // nombre del sp a ejectar
        "params": { // aqui va los valores que se le envian al sp
            "i_CUSTOMER_ID": "82208976",
            "i_CARD_STATUS": "ACTIVE"
        }
    }
}
```

### 15.8.1. Parámetros para construir la respuesta de la consulta en Nicaragua - Metodo 1 - GET /payments/payment-rail-operations-retrieves/v1/retrieve

> Teniendo en cuenta el soruceBank y el destinatioBank que venga en los header de la petición con la que se consume la api de producto, se obtienen los parámetros necesarios para consturuir la respuesa del servicio 

```json
//REQUEST
{
  "op": "GetParameter",
   "correlationId": "e1b3b0a7-8a8c-4e4b-9b2e-5c4cd7a1f3b1", 
   "country": "NIC",
   "domain": "PAYMENT_RAIL_OPERATIONS_RETRIEVE",
   "name": "ProducTypesParamNI",
   "version": "0001"
}
```

```json
//RESPONSE
{
  "status": "Success",
  "correlationId": "e1b3b0a7-8a8c-4e4b-9b2e-5c4cd7a1f3b1",
  "data": {
    "name": "ProducTypesParamNI",
    "value": {
      "methods": {
        "retrieve": {
        "params": [
            {
              "name": "MIN_PRODUCT_ID_LENGTH",
              "value": "1"
            },
            {
              "name": "MAX_PRODUCT_ID_LENGTH",
              "value": "100"
            },
            {
              "name": "LEADING_ZEROS_YES_NO",
              "value": "YES"
            },
            {
              "name": "PRODUCT_ID_SAMPLE",
              "value": ""
            }
          ]
        }
      }
    },
    "type": "JSON",
    "description": "CONFIG OF PAYMENT_RAIL_OPERATIONS_RETRIEVE BY METHOD",
    "country": "NIC",
    "domain": "PAYMENT_RAIL_OPERATIONS_RETRIEVE",
    "tags": [],
    "precedence": 10,
    "effective_from": "",
    "effective_to": "",
    "status": "active",
    "updated_at": "2025-01-14T18:10:00Z",
    "updated_by": "david.j.molano@ficohsa.com"
  }
}
```
#### REGISTRO EN DYNAMODB PARAMTER

>dominio de la api  PAYMENT_RAIL_OPERATIONS_RETRIEVE

```json
//REGISTRO EN DYNAMODB PARAMETER - CONFIGURACIÓN POR MÉTODO
{  
  "pk": "COUNTRY#XRS#DOMAIN#PAYMENT_RAIL_OPERATIONS_RETRIEVE#PARAM#CONFIG",
  "sk": "V#0001",
  "name": "ProducTypesParamNI",
  "version": "0001",
  "value": {
    "methods": {
      "retrieve": {
        "params": [
          {
            "name": "MIN_PRODUCT_ID_LENGTH",
            "value": "1"
          },
          {
            "name": "MAX_PRODUCT_ID_LENGTH",
            "value": "100"
          },
          {
            "name": "LEADING_ZEROS_YES_NO",
            "value": "YES"
          },
          {
            "name": "PRODUCT_ID_SAMPLE",
            "value": ""
          }
        ]
      }
    }
  },
  "type": "JSON",
  "description": "CONFIG OF PAYMENT_RAIL_OPERATIONS_RETRIEVE BY METHOD",
  "country": "NIC",
  "domain": "PAYMENT_RAIL_OPERATIONS_RETRIEVE",
  "tags": [],
  "precedence": 10,
  "effective_from": "",
  "effective_to": "",
  "status": "active",
  "updated_at": "2025-01-14T18:10:00Z",
  "updated_by": "david.j.molano@ficohsa.com"
}
```