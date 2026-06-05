# Comparativa de Regiones — SolicitudTCHN

## Regiones Detectadas

El proxy **SolicitudTCHN** es **exclusivo para la región HN01** (Honduras). El pipeline se denomina `HN01_SolicitudTC` y no contiene enrutamiento condicional por región dentro del flujo.

Sin embargo, en el repositorio existen dos versiones del XQuery de transformación de entrada a VisionPlus:

- `embosserAddL8VBIn.xqy` — versión genérica (usada por otros proxies regionales)
- `embosserAddL8VBNIIn.xqy` — versión extendida (usada en este proxy HN)

## Tabla de Comparación

| Aspecto | HN01 (este proxy) | Otras regiones (GT01, PA01, NI01) |
|---------|-------------------|-----------------------------------|
| **Endpoint OSB** | `http://172.23.13.19:8003/Middleware/OperationsAndExecution/Cards/SolicitudTC/` | No aplica (proxy dedicado HN) |
| **Base de Datos** | ConnectionTarjetasHN (JCA) | No aplica en este proxy |
| **Esquema/Package BD** | `dbo.OSBConDatoCuenta` | No aplica |
| **Store Procedure** | `OSBConDatoCuenta` | No aplica |
| **Nombre Conexión BD** | `jca://eis/DB/ConnectionTarjetasHN` | No aplica |
| **Endpoint VisionPlus** | `http://172.28.1.145:7802/VisionPlusService` | Mismo endpoint (compartido) |
| **Operación VisionPlus** | `EmbosserAddL8VB` | `EmbosserAddL8VB` |
| **XQuery Entrada VP** | `embosserAddL8VBNIIn.xqy` | `embosserAddL8VBIn.xqy` (genérica) |
| **XQuery Salida** | `solicitudTCOut.xqy` | `solicitudTCOut.xqy` (misma) |
| **Timeout VisionPlus** | 5 seg | 5 seg |
| **Retry** | 0 | 0 |

## Diferencias Clave entre XQueries

### `embosserAddL8VBNIIn.xqy` (usada en HN01)

La versión NI/HN tiene lógica condicional extendida para los campos `AZXAPI-RQTD-CARD-TYPE` y `AZXAPI-TYPE-CARD-MAILER`:

```xquery
(: AZXAPI-RQTD-CARD-TYPE :)
if (data($typeCard) != '') then (
    string($typeCard/text())
) elseif ($cardHolderType/text() = 'PRINCIPAL') then ('01')
  elseif ($cardHolderType/text() = 'ADDITIONAL') then ('00')
  else ()

(: AZXAPI-TYPE-CARD-MAILER :)
if (data($typeCardMailer) != '') then (
    string($typeCardMailer/text())
) elseif ($cardHolderType/text() = 'PRINCIPAL') then ('01')
  elseif ($cardHolderType/text() = 'ADDITIONAL') then ('00')
  else ()
```

### `embosserAddL8VBIn.xqy` (versión genérica)

La versión genérica mapea directamente sin lógica condicional:

```xquery
<AZXAPI-RQTD-CARD-TYPE>{ data($solicitudTCRequest/TYPE_CARD) }</AZXAPI-RQTD-CARD-TYPE>
<AZXAPI-TYPE-CARD-MAILER>{ data($solicitudTCRequest/TYPE_CARD_MAILER) }</AZXAPI-TYPE-CARD-MAILER>
```

### Resumen de Diferencias

| Campo | Versión HN (NI) | Versión Genérica |
|-------|-----------------|------------------|
| AZXAPI-RQTD-CARD-TYPE | Si TYPE_CARD vacío → usa CARD_HOLDER_TYPE (PRINCIPAL=01, ADDITIONAL=00) | Mapeo directo de TYPE_CARD |
| AZXAPI-TYPE-CARD-MAILER | Si TYPE_CARD_MAILER vacío → usa CARD_HOLDER_TYPE (PRINCIPAL=01, ADDITIONAL=00) | Mapeo directo de TYPE_CARD_MAILER |

Todos los demás campos son idénticos entre ambas versiones.
