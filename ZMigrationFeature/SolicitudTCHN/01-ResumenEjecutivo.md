# Resumen Ejecutivo — SolicitudTCHN

## Índice de Documentos

- [02-ComparativaRegiones.md](./02-ComparativaRegiones.md)
- [03-EjemplosYMapeos-HN01.md](./03-EjemplosYMapeos-HN01.md)
- [06-ListadoFicheros.md](./06-ListadoFicheros.md)
- [07-ListadoXQ.md](./07-ListadoXQ.md)

---

## Propósito de la Funcionalidad

El proxy **SolicitudTCHN** gestiona la solicitud de tarjeta de crédito (embossing) para la región Honduras (HN01). Permite crear, reemplazar o renovar tarjetas de crédito mediante la operación `EmbosserAddL8VB` del sistema **VisionPlus** de Procesa (FDCS).

El flujo incluye:
1. Resolución del ORG (organización) a partir del número de cuenta si no viene informado en el request.
2. Invocación al servicio VisionPlus con la operación EmbosserAddL8VB para alta/modificación de embosser de tarjeta.

## Entradas y Salidas Principales

### Entrada (SOAP Request)

| Campo | Tipo | Obligatorio | Descripción |
|-------|------|-------------|-------------|
| ACCOUNT_NUMBER | string (max 19) | Sí | Número de cuenta |
| CARD_NUMBER | string | No | Número de tarjeta |
| ORG | integer | No | Organización (si vacío se resuelve vía SP) |
| CUSTOMER_ID | string | Sí | ID del cliente |
| CARD_ACTION | enum | Sí | NEW_CARD, NORMAL_REPLACEMENT, EMERGENCY_REPLACEMENT, RENOVATION |
| EMBOSSED_NAME | string | Sí | Nombre a embozar línea 1 |
| EXPIRATION_DATE | string | Sí | Fecha de expiración |
| CARD_HOLDER_TYPE | enum | Sí | PRINCIPAL, ADDITIONAL |
| GENERATE_PIN | enum | Sí | YES, NO |
| PROCESS_TYPE | enum | Sí | EMERGENCY, NORMAL |
| TYPE_CARD | string | No | Tipo de tarjeta solicitada |
| TYPE_CARD_MAILER | string | No | Tipo de mailer |
| EMBOSSED_NAME_2 | string | No | Nombre a embozar línea 2 |
| NAME_2 | string | No | Segundo nombre |
| BLOCK_CODE | string | No | Código de bloqueo |
| PRIORYTI_PASS | string | No | Priority Pass |
| EMBLEM_ID | string | No | ID de emblema |
| CARD_ACTION_REASON_CODE | string | No | Código de razón de acción |
| SPENDING_LIMIT_INDICATOR | string | No | Indicador de límite de gasto |
| PERCENTAGE_LIMIT_OF_DAILY_PURCHASE | string | No | % límite compra diaria |
| PERCENTAGE_MONTHLY_PURCHASE_LIMIT | string | No | % límite compra mensual |
| ANNUAL_PURCHASE_LIMIT_PERCENTAGE | string | No | % límite compra anual |
| DAILY_PURCHASE_LIMIT | string | No | Límite compra diaria |
| MONTHLY_PURCHASE_LIMIT | string | No | Límite compra mensual |
| ANNUAL_PURCHASE_LIMIT | string | No | Límite compra anual |
| DAILY_WITHDRAWAL_LIMIT_PERCENTAGE | string | No | % límite retiro diario |
| MONTHLY_WITHDRAWAL_LIMIT_PERCENTAGE | string | No | % límite retiro mensual |
| ANNUAL_RETIREMENT_LIMIT_PERCENTAGE | string | No | % límite retiro anual |
| DAILY_WITHDRAWAL_LIMIT | string | No | Límite retiro diario |
| MONTHLY_WITHDRAWAL_LIMIT | string | No | Límite retiro mensual |
| ANNUAL_WITHDRAWAL_LIMIT | string | No | Límite retiro anual |

### Salida (SOAP Response)

| Campo | Tipo | Descripción |
|-------|------|-------------|
| LCY_ORG | decimal | Organización local |
| FCY_ORG | decimal | Organización extranjera |
| LOGO | decimal | Logo |
| ACCOUNT_NUMBER | string | Número de cuenta |
| CARD_NUMBER | string | Número de tarjeta generada |
| CARD_SEQUENCE | decimal | Secuencia de tarjeta |
| CHIP_SEQUENCE | decimal | Secuencia de chip |

### Header de Respuesta

| Campo | Descripción |
|-------|-------------|
| successIndicator | "Success" en caso exitoso, código de error en caso contrario |
| messages | Mensaje de error (vacío en caso exitoso) |

## Sistemas/Servicios OSB Involucrados

| Sistema | Tipo | Descripción |
|---------|------|-------------|
| **SolicitudTCHN** | Proxy Service | Punto de entrada SOAP |
| **conDatoCuenta_db (HN)** | Business Service (JCA/DB) | Stored Procedure para resolución de ORG por cuenta |
| **visionPlus** | Business Service (HTTP/SOAP) | Servicio externo VisionPlus de Procesa para embossing |

## Riesgos / Limitaciones Conocidas

1. **Sin retry en Business Services**: Ambos BS tienen `retry-count=0`, cualquier fallo de conexión resulta en error directo.
2. **Timeout ajustado en VisionPlus**: 5 segundos de timeout HTTP y 5 segundos de connection-timeout.
3. **Validación de ORG vacío**: Si `conDatoCuenta` retorna error (`CodigoError != -1`) pero no se valida explícitamente antes de llamar a VisionPlus; se valida que `$org != ""` para proceder.
4. **Sin manejo de región dinámica**: El proxy es exclusivo para HN01 (pipeline `HN01_SolicitudTC`). No hay enrutamiento multirregión dentro de este proxy.
5. **XQuery embosserAddL8VBNIIn**: Aunque el nombre sugiere NI (Nicaragua), es el XQuery usado en el pipeline HN. La lógica de CARD_HOLDER_TYPE tiene lógica condicional adicional para TYPE_CARD y TYPE_CARD_MAILER que no existe en la versión genérica.

## Métricas o SLAs

- **Timeout VisionPlus**: 5 seg (request + connection)
- **Retry**: 0 en ambos BS
- **Monitoreo**: Habilitado (aggregationInterval=360) en ambos Business Services
- **SLA Alerting**: Habilitado en nivel normal

## Proxies Dependientes

No se detectaron invocaciones a otros proxies OSB desde este flujo. Las únicas dependencias son los Business Services mencionados.
