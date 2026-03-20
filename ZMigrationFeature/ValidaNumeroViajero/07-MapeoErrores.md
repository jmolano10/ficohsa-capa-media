# Mapeo de Errores - ValidaNumeroViajero

## Códigos de Error del SP y Homologación HTTP

Códigos retornados por el parámetro `PV_ERROR_CODE` del SP `SALESFORCE.SFC_VALIDAR_NUMERO_VIAJERO`:

| PV_ERROR_CODE | PV_RESULT | PV_ERROR_MESAJE | Condición en el SP | Código HTTP | Descripción HTTP |
|---------------|-----------|-----------------|---------------------|-------------|------------------|
| `SUCCESS` | `True` | _(vacío)_ | Validación exitosa del número de viajero | 200 | OK |
| `SUCCESS` | `True` | `SUCCESS` | Dígito verificador correcto | 200 | OK |
| `ERROR - E01` | _(vacío)_ | `Valor de Pv_Type no valido.` | `PV_TYPE != 'AA'` | 400 | Bad Request |
| `ERROR - E02` | `False` | `Valores no permitidos en numero de viajero frecuente.` | El número contiene caracteres I, O, Q o Z | 422 | Unprocessable Entity |
| `ERROR - E03` | `False` | `Valor inicial esperado no encontrado.` | El número contiene G o S pero no inicia con ellos | 422 | Unprocessable Entity |
| `ERROR - E04` | `False` | `Ultimo valor no es un digito.` | El último carácter no es un dígito numérico | 422 | Unprocessable Entity |
| `ERROR - E05` | `False` | `Numero de viajero frecuente incorrecto.` | El dígito verificador calculado no coincide | 422 | Unprocessable Entity |
| `ERROR - E06` | `False` | `Numero de viajero frecuente incorrecto.` | `PV_NUMERO_VIAJERO = '0000000'` | 422 | Unprocessable Entity |
| `ERROR - E07` | `False` | `Numero de viajero frecuente incorrecto.` | `LENGTH(PV_NUMERO_VIAJERO) != 7` | 422 | Unprocessable Entity |
| `ERROR` | `False` | `Error al consultar la información. : {SQLERRM}` | Excepción no controlada (`WHEN OTHERS`) | 500 | Internal Server Error |

---

## Detalle de Cada Error

### SUCCESS
- **Origen**: SP `SFC_VALIDAR_NUMERO_VIAJERO`
- **PV_RESULT**: `True`
- **Condición**: Todas las validaciones pasan y el dígito verificador es correcto
- **HTTP**: `200 OK`

### ERROR - E01 — Tipo de programa no válido
- **Origen**: SP `SFC_VALIDAR_NUMERO_VIAJERO`
- **PV_RESULT**: _(string vacío)_
- **Condición**: `PV_TYPE != 'AA'`; el único valor aceptado es `'AA'`
- **HTTP**: `400 Bad Request`
- **Nota**: Es el único error donde `PV_RESULT` queda vacío en lugar de `'False'`

### ERROR - E02 — Caracteres no permitidos
- **Origen**: SP `SFC_VALIDAR_NUMERO_VIAJERO`
- **PV_RESULT**: `False`
- **Condición**: El número contiene al menos uno de los caracteres: `I`, `O`, `Q`, `Z`
- **HTTP**: `422 Unprocessable Entity`

### ERROR - E03 — Valor inicial incorrecto
- **Origen**: SP `SFC_VALIDAR_NUMERO_VIAJERO`
- **PV_RESULT**: `False`
- **Condición**: El número contiene `G` o `S` pero el primer carácter no es `G` ni `S`
- **HTTP**: `422 Unprocessable Entity`

### ERROR - E04 — Último carácter no numérico
- **Origen**: SP `SFC_VALIDAR_NUMERO_VIAJERO`
- **PV_RESULT**: `False`
- **Condición**: `TO_NUMBER(SUBSTR(PV_NUMERO_VIAJERO, -1))` lanza `VALUE_ERROR`; el último carácter no es dígito
- **HTTP**: `422 Unprocessable Entity`

### ERROR - E05 — Dígito verificador incorrecto
- **Origen**: SP `SFC_VALIDAR_NUMERO_VIAJERO`
- **PV_RESULT**: `False`
- **Condición**: El dígito verificador calculado a partir de los valores EBCDIC de los primeros 6 caracteres no coincide con el último carácter del número
- **HTTP**: `422 Unprocessable Entity`

### ERROR - E06 — Número de viajero cero
- **Origen**: SP `SFC_VALIDAR_NUMERO_VIAJERO`
- **PV_RESULT**: `False`
- **Condición**: `PV_NUMERO_VIAJERO = '0000000'`
- **HTTP**: `422 Unprocessable Entity`

### ERROR - E07 — Longitud incorrecta
- **Origen**: SP `SFC_VALIDAR_NUMERO_VIAJERO`
- **PV_RESULT**: `False`
- **Condición**: `LENGTH(PV_NUMERO_VIAJERO) != 7`; se esperan exactamente 7 caracteres
- **HTTP**: `422 Unprocessable Entity`

### ERROR — Error genérico (WHEN OTHERS)
- **Origen**: SP `SFC_VALIDAR_NUMERO_VIAJERO`
- **PV_RESULT**: `False`
- **Condición**: Cualquier excepción no controlada, incluyendo fallos al consultar `SALESFORCE.SFC_CODIGOS_EBCDIC` (p. ej. `NO_DATA_FOUND` si un carácter no existe en la tabla)
- **HTTP**: `500 Internal Server Error`

---

## Orden de Validaciones en el SP

Las validaciones se ejecutan en este orden exacto; la primera que falla retorna inmediatamente:

1. `PV_TYPE = 'AA'` → E01 si no cumple
2. `PV_NUMERO_VIAJERO != '0000000'` → E06 si es cero
3. `LENGTH(PV_NUMERO_VIAJERO) = 7` → E07 si longitud incorrecta
4. Sin caracteres `I`, `O`, `Q`, `Z` → E02 si hay alguno
5. Si contiene `G` o `S`, debe iniciar con ellos → E03 si no cumple
6. Último carácter debe ser dígito → E04 si no cumple
7. Dígito verificador correcto (cálculo EBCDIC) → E05 si no coincide

---

## Códigos de Error Técnicos de OSB

| Código OSB | Descripción | Mapeo HTTP |
|------------|-------------|------------|
| `OSB-382033` | Schema validation failed | 400 |
| `OSB-382034` | XPath evaluation failed | 400 |
| `OSB-382500` | Service callout failed | 502 |
| `OSB-395026` | Authentication failed | 401 |
| `JCA-11001` | Database connection error | 500 |
| `JCA-11002` | Database timeout | 504 |
| `JCA-11003` | SQL execution error | 500 |
