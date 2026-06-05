# Listado de XQueries que Intervienen — SolicitudTCHN

## Región HN01

### 1. `Middleware/v2/Resources/Generales/xq/convertirCodigoPais.xqy`

**Propósito**: Convierte códigos de país entre formatos OSB, ISO2 e ISO3.

**Conversiones soportadas**:
- `OSB-ISO3`: HN01→HND, GT01→GTM, NI01→NIC, PA01→PAN
- `OSB-ISO2`: HN01→HN, GT01→GT, NI01→NI, PA01→PA
- `ISO2-OSB`: HN→HN01, GT→GT01, NI→NI01, PA→PA01
- `ISO3-OSB`: HND→HN01, GTM→GT01, NIC→NI01, PAN→PA01

**Parámetros de entrada**:
| Parámetro | Tipo | Descripción |
|-----------|------|-------------|
| `$codigoPais` | xs:string | Código a convertir (ej: "HN01") |
| `$sentidoConversion` | xs:string | Dirección de conversión (ej: "OSB-ISO3") |

**Retorno**: xs:string — Código convertido (ej: "HND")

**Uso en este flujo**: Se invoca con `$codigoPais = SourceBank (HN01)` y `$sentidoConversion = 'OSB-ISO3'` para obtener "HND" que se pasa como parámetro al SP `conDatoCuenta`.

---

### 2. `Middleware/v2/Resources/MasterDataHN/xq/conDatoCuentaHNIn.xqy`

**Propósito**: Construye el mensaje `InputParameters` para el SP `dbo.OSBConDatoCuenta`.

**Parámetros de entrada**:
| Parámetro | Tipo | Descripción |
|-----------|------|-------------|
| `$countryCode` | xs:string | Código país ISO3 (ej: "HND") |
| `$org` | xs:string | Organización (puede ser vacío) |
| `$accountNumber` | xs:string | Número de cuenta |

**Retorno**: `ns0:InputParameters`

**Transformación de campos**:
| Campo Entrada | Transformación | Campo Salida |
|---------------|---------------|--------------|
| `$countryCode` | Directo | `ns0:Pais` |
| `$org` | Si no vacío → incluye elemento; si vacío → omite | `ns0:Org` (condicional) |
| `$accountNumber` | `fn-bea:pad-left($accountNumber, 19, '0')` | `ns0:NumCuenta` |

---

### 3. `Middleware/v2/Resources/SolicitudTC/xq/embosserAddL8VBNIIn.xqy`

**Propósito**: Transforma el request OSB `solicitudTC` al formato `EmbosserAddL8VBRequest` de VisionPlus. Versión extendida usada para HN/NI con lógica condicional para TYPE_CARD y TYPE_CARD_MAILER.

**Parámetros de entrada**:
| Parámetro | Tipo | Descripción |
|-----------|------|-------------|
| `$org` | xs:integer | Organización resuelta |
| `$solicitudTCRequest` | element(ns0:solicitudTC) | Request completo del cliente |

**Retorno**: `ns1:EmbosserAddL8VBRequest`

**Función auxiliar**: `transformarCardAction($cardAction)`:
| Entrada | Salida |
|---------|--------|
| NEW_CARD | 1 |
| NORMAL_REPLACEMENT | 3 |
| EMERGENCY_REPLACEMENT | 6 |
| RENOVATION | 7 |

**Transformación de campos principales** (solo campos con lógica, no constantes):
| Campo Entrada | Lógica | Campo Salida |
|---------------|--------|--------------|
| `ACCOUNT_NUMBER` | Directo | `AZXAPI-POST-TO-ACCT` |
| `CARD_NUMBER` | Directo | `AZXAPI-CARD-NBR` |
| `CARD_ACTION` | `transformarCardAction()` | `AZXAPI-CARD-ACTION` |
| `TYPE_CARD` | Si vacío → PRINCIPAL='01', ADDITIONAL='00' | `AZXAPI-RQTD-CARD-TYPE` |
| `TYPE_CARD_MAILER` | Si vacío → PRINCIPAL='01', ADDITIONAL='00' | `AZXAPI-TYPE-CARD-MAILER` |
| `EMBOSSED_NAME` | Directo | `AZXAPI-EMBOSSED-NAME-1` |
| `EMBOSSED_NAME_2` | Directo | `AZXAPI-EMBOSSED-NAME-2` |
| `EXPIRATION_DATE` | Directo | `AZXAPI-DATE-EXPIRE` |
| `CUSTOMER_ID` | Directo | `AZXAPI-CUSTOMER-NBR` |
| `NAME_2` | Directo | `AZXAPI-EMBR-NAME-2` |
| `CARD_HOLDER_TYPE` | PRINCIPAL→1, ADDITIONAL→0 | `AZXAPI-CARDHOLDER-FLAG` |
| `GENERATE_PIN` | YES→0, NO→1 | `AZXAPI-PIN-SUPPRESSION` |
| `BLOCK_CODE` | Directo | `AZXAPI-BLOCK-CODE` |
| `PRIORYTI_PASS` | Directo | `AZXAPI-USER-1` |
| `PROCESS_TYPE` | EMERGENCY→1, NORMAL→0 | `AZXAPI-SDP-PROCESS-TYPE` |
| `EMBLEM_ID` | Si vacío → 0 | `AZXAPI-EMBLM-ID` |
| `CARD_ACTION_REASON_CODE` | Si vacío → 1 | `AZXAPI-CARD-ACTION-REASON` |
| `SPENDING_LIMIT_INDICATOR` | Si vacío → 0 | `AZXAPI-SPEND-LIMITS-STATUS` |
| `PERCENTAGE_LIMIT_OF_DAILY_PURCHASE` | Si vacío → 0 | `AZXAPI-RETAIL-PERCENT-DAILY` |
| `PERCENTAGE_MONTHLY_PURCHASE_LIMIT` | Si vacío → 0 | `AZXAPI-RETAIL-PERCENT-MTD` |
| `ANNUAL_PURCHASE_LIMIT_PERCENTAGE` | Si vacío → 0 | `AZXAPI-RETAIL-PERCENT-YTD` |
| `DAILY_PURCHASE_LIMIT` | Si vacío → 0 | `AZXAPI-RETAIL-AMOUNT-DAILY` |
| `MONTHLY_PURCHASE_LIMIT` | Si vacío → 0 | `AZXAPI-RETAIL-AMOUNT-MTD` |
| `ANNUAL_PURCHASE_LIMIT` | Si vacío → 0 | `AZXAPI-RETAIL-AMOUNT-YTD` |
| `DAILY_WITHDRAWAL_LIMIT_PERCENTAGE` | Si vacío → 0 | `AZXAPI-CASH-PERCENT-DAILY` |
| `MONTHLY_WITHDRAWAL_LIMIT_PERCENTAGE` | Si vacío → 0 | `AZXAPI-CASH-PERCENT-MTD` |
| `ANNUAL_RETIREMENT_LIMIT_PERCENTAGE` | Si vacío → 0 | `AZXAPI-CASH-PERCENT-YTD` |
| `DAILY_WITHDRAWAL_LIMIT` | Si vacío → 0 | `AZXAPI-CASH-AMOUNT-DAILY` |
| `MONTHLY_WITHDRAWAL_LIMIT` | Si vacío → 0 | `AZXAPI-CASH-AMOUNT-MTD` |
| `ANNUAL_WITHDRAWAL_LIMIT` | Si vacío → 0 | `AZXAPI-CASH-AMOUNT-YTD` |

---

### 4. `Middleware/v2/Resources/SolicitudTC/xq/solicitudTCOut.xqy`

**Propósito**: Transforma la respuesta `EmbosserAddL8VBResponse` de VisionPlus al formato de respuesta OSB `solicitudTCResponse`.

**Parámetros de entrada**:
| Parámetro | Tipo | Descripción |
|-----------|------|-------------|
| `$embosserAddL8VBResponse` | element(ns1:EmbosserAddL8VBResponse) | Respuesta de VisionPlus |

**Retorno**: `ns0:solicitudTCResponse`

**Transformación de campos**:
| Campo Entrada (VP) | Transformación | Campo Salida (OSB) |
|---------------------|---------------|-------------------|
| `AZXAPO-ORG` | `data()` | `LCY_ORG` |
| `AZXAPO-FOREIGN-ORG` | `data()` | `FCY_ORG` |
| `AZXAPO-LOGO` | `data()` | `LOGO` |
| `AZXAPO-ACCT` | `data()` | `ACCOUNT_NUMBER` |
| `AZXAPO-CARD-NBR` | `data()` | `CARD_NUMBER` |
| `AZXAPO-CARD-SEQ` | `data()` | `CARD_SEQUENCE` |
| `AZXAPO-CURR-CHIP-SEQ` | `data()` | `CHIP_SEQUENCE` |

---

## Referencia adicional (versión genérica)

### `Middleware/v2/Resources/SolicitudTC/xq/embosserAddL8VBIn.xqy`

**Propósito**: Versión genérica de la transformación a VisionPlus, sin lógica condicional en TYPE_CARD y TYPE_CARD_MAILER (mapeo directo).

**Diferencia con versión NI/HN**: Los campos `AZXAPI-RQTD-CARD-TYPE` y `AZXAPI-TYPE-CARD-MAILER` se mapean directamente del request sin fallback por CARD_HOLDER_TYPE.

**Nota**: No se usa en el proxy SolicitudTCHN pero se documenta como referencia para comparación regional.
