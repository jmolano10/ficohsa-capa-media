# ms-lc-ccard-credit_card_retrieves-product

## Información General

| Campo                    | Valor                                                    |
|--------------------------|----------------------------------------------------------|
| Nombre del Servicio      | Credit Card Retrieves                                    |
| Código del Servicio      | ms-lc-ccard-credit_card_retrieves-product                |
| Dominio Funcional        | Lending & Cards - Credit Card                            |
| Versión a Desplegar      | 1.0.0                                                    |
| Criticidad del Servicio  | [x] Tier 2                                               |
| Entorno Destino          | [x] DEV [x] STG [ ] UAT [ ] PROD                        |

## Stack Tecnológico

| Componente         | Versión           |
|--------------------|-------------------|
| Java               | 21                |
| Spring Boot        | 3.5.14            |
| Spring WebFlux     | 6.2.18            |
| Ficohsa Core       | 2.4.2-SNAPSHOT    |
| Ficohsa Router     | 2.4.2-SNAPSHOT    |
| Ficohsa Logging    | 2.4.2-SNAPSHOT    |
| Gradle             | 8.14.3            |

## Enlaces de Referencia

| Recurso           | URL/Referencia                                                                              |
|-------------------|---------------------------------------------------------------------------------------------|
| Repositorio Git   | https://dev.azure.com/DevopsFicohsa/NOVA/_git/ms-lc-ccard-credit_card_retrieves-product    |
| Swagger/OpenAPI   | {base-url}/swagger-ui.html                                                                  |

## Configuración de Variables por Ambiente

| Variable                       | Valor Local       | Valor Desarrollo                              |
|--------------------------------|-------------------|-----------------------------------------------|
| SPRING_APPLICATION_NAME        | ms-lc-ccard-credit_card_retrieves-product | ms-lc-ccard-credit_card_retrieves-product |
| SPRING_PROFILES_ACTIVE         | local             | dev                                           |
| LOG_LEVEL                      | INFO              | INFO                                          |
| AWS_REGION                     | us-east-1         | us-east-1                                     |
| DWH_BASE_URL                   | http://localhost   | {ic-wrapper-url}                             |
| ABANKS_BASE_URL                | http://localhost   | {ic-wrapper-url}                             |
| EXCEPTION_TYPE                 | https://live.integration.ficohsa.com/errors | https://live.integration.ficohsa.com/errors |

## Contrato de API

### Endpoint 1: Retrieve Debit Card Details

- **Método:** GET
- **Path:** `/cards/credit-card-retrieves/v1/{customerIdentification}/debit-card-details`

#### Request

| Parámetro               | Ubicación | Tipo   | Requerido | Descripción                    |
|-------------------------|-----------|--------|-----------|--------------------------------|
| customerIdentification  | Path      | String | Sí        | Identificación del cliente     |
| accountstatustypevalues | Query     | String | Sí        | Estado de cuenta               |
| accountNumber           | Query     | String | No        | Número de cuenta               |

**Headers:** Authorization, Source-Bank, Application-Id

---

### Endpoint 2: Retrieve Settlement Quote Details

- **Método:** POST
- **Path:** `/cards/credit-card-retrieves/v1/settlement-quote-details`

#### Request Body

```json
{
  "data": {
    "accountNumber": "4545000012345678",
    "organizationReference": "340",
    "financingPlanReference": "001",
    "paymentSequenceNumber": "1",
    "cancellationDate": "2026-06-15",
    "repaymentAmount": "38000.00",
    "paymentType": "TOTAL"
  }
}
```

---

### Endpoint 3: Retrieve Credit Card

- **Método:** GET
- **Path:** `/cards/credit-card-retrieves/v1/{customerIdentification}/retrieve`

#### Request

| Parámetro              | Ubicación | Tipo   | Requerido |
|------------------------|-----------|--------|-----------|
| customerIdentification | Path      | String | Sí        |

---

### Errores Comunes

| Código | Escenario                           |
|--------|-------------------------------------|
| 400    | Parámetros obligatorios faltantes   |
| 404    | Tarjeta no encontrada               |
| 422    | Región no habilitada                |
| 502    | Error de servicio externo           |
| 500    | Error interno                       |

## Arquitectura y Flujo

### Estructura del Proyecto

```
ms-lc-ccard-credit_card_retrieves-product/
├── applications/app-service/
├── domain/
│   ├── model/
│   ├── ports/
│   └── use-case/
├── infrastructure/
│   ├── entry-points/reactive-web/
│   ├── driven-adapters/
│   │   ├── visionplus-client-api/
│   │   ├── t24-client-api/
│   │   ├── cobis-client-api/
│   │   ├── abanks-client-api/
│   │   ├── creditcard-client-api/
│   │   ├── secrets-manager/
│   │   ├── parameter-store/
│   │   └── lambda-regionalization/
│   └── helpers/
├── gradle/libs.versions.toml
├── build.gradle
├── main.gradle
└── settings.gradle
```

### Capas de la Arquitectura

- **Domain (model):** Modelos de negocio, excepciones
- **Domain (ports):** Interfaces de entrada y salida (Gateway)
- **Domain (use-case):** Orquestación de lógica de negocio
- **Infrastructure (entry-points):** Handlers REST, Router, DTOs de API
- **Infrastructure (driven-adapters):** Adapters HTTP (VisionPlus, T24, Cobis, Abanks), R2DBC, SecretsManager, ParameterStore, Regionalización

### Flujo Principal

1. Request llega al Router → delega al Handler correspondiente
2. Handler extrae parámetros y valida con AppTool.context()
3. Use case valida regionalización por método
4. Use case resuelve estrategia por país (HN, GT, PA, NI)
5. Adapter correspondiente consulta el core bancario (VisionPlus/T24/Cobis/Abanks)
6. Response se mapea y retorna al cliente

## Ejecución y Pruebas

### Compilar y Ejecutar
```bash
./gradlew build
./gradlew :app-service:bootRun
```

### Probar los Endpoints
```bash
# Debit Card Details
curl -X GET 'http://localhost:8080/cards/credit-card-retrieves/v1/0801199012345/debit-card-details?accountstatustypevalues=ACTIVE' \
  -H 'Authorization: Bearer {token}' \
  -H 'Source-Bank: HN01' \
  -H 'Application-Id: 423847'

# Settlement Quote Details
curl -X POST 'http://localhost:8080/cards/credit-card-retrieves/v1/settlement-quote-details' \
  -H 'Authorization: Bearer {token}' \
  -H 'Source-Bank: HN01' \
  -H 'Application-Id: 423847' \
  -H 'Content-Type: application/json' \
  -d '{"data":{"accountNumber":"4545000012345678","organizationReference":"340","financingPlanReference":"001","paymentSequenceNumber":"1","cancellationDate":"2026-06-15","repaymentAmount":"38000.00","paymentType":"TOTAL"}}'

# Credit Card Retrieve
curl -X GET 'http://localhost:8080/cards/credit-card-retrieves/v1/0801199012345/retrieve' \
  -H 'Authorization: Bearer {token}' \
  -H 'Source-Bank: HN01' \
  -H 'Application-Id: 423847'
```
