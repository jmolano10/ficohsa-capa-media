# Listado de XQuery — ConsultaCobranzasH2H

## Segmentación por País

### HN01 (Honduras) — XQuery Específicos

| XQuery | Usado en |
|--------|----------|
| `consultaConveniosH2HIn.xq` | Stage ConsultaConvenios |
| `sjConsultaRecaudoH2HIn.xq` | Stage ConsultaCobranzas |
| `sjConsultaRecaudoH2HOut.xq` | Stage FlujoSalida (respuesta) |
| `consPeticionesDispH2HIn.xq` | Stage ValidaCantidadPeticionesXdía |
| `actualizaPeticionesDisponiblesH2HIn.xq` | Stage ActualizaPeticionesDisponibles |

### Compartidos (todas las regiones)

| XQuery | Usado en |
|--------|----------|
| `validaServicioRegionalIn` | Stage ValidacionServicioRegional |
| `validaAccesoH2HIn.xq` | Stage ValidaAcceso |
| `obtenerParametrizacionIn` | Stage ObtenerParametrizacion |
| `mapeoErroresUsageIn` | Error handlers y MapeoError |
| `mapeoErroresUsageOut` | Error handlers y MapeoError |
| `aplicarValoresPorDefectoRegion` | Stage ValidacionServicioRegional (default branch) |
| `obtenerUUID` | Bitácora (proxy padre) |
| `registrarBitacoraH2HIn.xq` | Bitácora (proxy padre) |

---

## Análisis Detallado

### 1. consultaConveniosH2HIn.xq

**Ruta:** `v1/Resources/ConsultaCobranzasH2H/xq/consultaConveniosH2HIn.xq`

**Propósito:** Transforma el request OSB al formato de entrada del SP `consultaConveniosH2H`. Extrae los IDs de servicio únicos y el código de país.

**Entrada:**
| Parámetro | Tipo | Origen |
|-----------|------|--------|
| `$consultaCobranzas` | element(ns0:consultaCobranzas) | `$body/cob:consultaCobranzas` |
| `$sourceBank` | xs:string | `$header/aut:RequestHeader/Region/SourceBank` |

**Salida:**
| Campo | Transformación |
|-------|----------------|
| `PT_IDSERVICIO/PT_IDSERVICIO_ITEM` | `distinct-values($consultaCobranzas/SERVICES/SERVICE/ID)` — itera con `for` |
| `PV_CODIGOPAIS` | `$sourceBank` (directo) |

**Lógica:** Usa `distinct-values` para evitar duplicados de SERVICE/ID.

---

### 2. sjConsultaRecaudoH2HIn.xq

**Ruta:** `v1/Resources/ConsultaCobranzasH2H/xq/sjConsultaRecaudoH2HIn.xq`

**Propósito:** Construye el request para el Split-Join de consulta de cobranzas, enriqueciendo cada servicio con datos de convenios (CONTRACT_ID, NAME).

**Entrada:**
| Parámetro | Tipo | Origen |
|-----------|------|--------|
| `$requestHeader` | element(ns1:RequestHeader) | `$header/aut:RequestHeader` |
| `$consultaCobranzas` | element(ns2:consultaCobranzas) | `$body/cob:consultaCobranzas` |
| `$PT_INFOCONVENIOS` | element() | `$RSPConsultaConveniosH2H/conv:PT_INFOCONVENIOS` |

**Salida:**
| Campo | Transformación |
|-------|----------------|
| `USER_NAME` | `upper-case(string($requestHeader/Authentication/UserName))` |
| `PASSWORD` | `data($requestHeader/Authentication/Password)` |
| `SOURCE_BANK` | `data($requestHeader/Region/SourceBank)` |
| `CUSTOMER_ID` | `data($consultaCobranzas/CUSTOMER_ID)` |
| `SERVICES/SERVICE/ID` | `data($service/ID)` |
| `SERVICES/SERVICE/CONTRACT_ID` | Lookup: `$PT_INFOCONVENIOS_ITEM[ID_SERVICIO = ID]/ID_CONTRATO` (condicional: solo si no vacío) |
| `SERVICES/SERVICE/NAME` | Lookup: `$PT_INFOCONVENIOS_ITEM[ID_SERVICIO = ID]/DESCRIPCION` (condicional: solo si no vacío) |
| `SERVICES/SERVICE/DEBTORS` | Copia directa: `$service/DEBTORS/@* , $service/DEBTORS/node()` |

**Lógica:**
- Itera sobre cada SERVICE del request original
- Para cada SERVICE, busca en PT_INFOCONVENIOS el item cuyo ID_SERVICIO coincida
- Agrega CONTRACT_ID y NAME solo si tienen valor (no vacío)
- Copia los DEBTORS tal cual (atributos y nodos)

---

### 3. sjConsultaRecaudoH2HOut.xq

**Ruta:** `v1/Resources/ConsultaCobranzasH2H/xq/sjConsultaRecaudoH2HOut.xq`

**Propósito:** Transforma la respuesta del Split-Join al formato de respuesta OSB. Agrupa servicios por ID y aplica transformación HTML al DEALSLIP para serviceId=9.

**Entrada:**
| Parámetro | Tipo | Origen |
|-----------|------|--------|
| `$sjConsultaCobranzasResponse` | element(ns0:sjConsultaCobranzasResponse) | `$RSPsjConsulta` |

**Salida:**
| Campo | Transformación |
|-------|----------------|
| `SERVICES/SERVICE/SUCCESS_INDICATOR` | `data()` del primer elemento del grupo |
| `SERVICES/SERVICE/ERROR_MESSAGE` | `data()` del primer elemento del grupo |
| `SERVICES/SERVICE/ID` | Agrupado por `distinct-values()` |
| `SERVICES/SERVICE/NAME` | `data()` del primer elemento del grupo |
| `SERVICES/SERVICE/DEBTORS/DEBTOR/*` | Consolidación de todos los DEBTORS del grupo |
| `SERVICES/SERVICE/DEBTORS/DEBTOR/DEALSLIP` | `transformarReciboHTML(serviceId, dealSlip)` |

**Lógica:**
- Agrupa servicios por `distinct-values(SERVICE/ID)`
- Para cada grupo, toma el primer SERVICE como referencia para SUCCESS_INDICATOR, ERROR_MESSAGE, ID, NAME
- Consolida DEBTORS de todos los SERVICE del grupo (resultado del Split-Join paralelo)
- Solo genera elemento DEBTORS si `count(DEBTOR) > 0`
- Función `transformarReciboHTML`: si serviceId="9", reemplaza `[`→`<`, `]`→`>`, `@`→`"` en el DEALSLIP

---

### 4. validaAccesoH2HIn.xq

**Ruta:** `v1/Resources/CobranzasH2H/xq/validaAccesoH2HIn.xq`

**Propósito:** Mapea parámetros para el SP de validación de acceso H2H.

**Entrada:**
| Parámetro | Tipo | Origen |
|-----------|------|--------|
| `$usuario` | xs:string | `upper-case($header/aut:RequestHeader/Authentication/UserName)` |
| `$operacion` | xs:string | `upper-case($operation)` |
| `$idProxy` | xs:string | Literal `'FICBCO0258'` |
| `$codigoPais` | xs:string | `$header/aut:RequestHeader/Region/SourceBank` |
| `$codigoCliente` | xs:string | `$body/cob:consultaCobranzas/CUSTOMER_ID` |

**Salida:**
| Campo | Transformación |
|-------|----------------|
| `PV_NOMBREUSUARIO` | `$usuario` (directo) |
| `PV_OPERACION` | `$operacion` (directo) |
| `PV_IDPROXY` | `$idProxy` (directo) |
| `PV_CODIGOPAIS` | `$codigoPais` (directo) |
| `PV_CODIGOCLIENTE` | `$codigoCliente` (directo) |

---

### 5. consPeticionesDispH2HIn.xq

**Ruta:** `v1/Resources/CobranzasH2H/xq/consPeticionesDispH2HIn.xq`

**Propósito:** Mapea parámetros para el SP de consulta de peticiones disponibles por día.

**Entrada:**
| Parámetro | Tipo | Origen |
|-----------|------|--------|
| `$codigoUsuario` | xs:string | `upper-case($header/Authentication/UserName)` |
| `$IdProxy` | xs:string | Literal `"FICBCO0258"` |
| `$operacion` | xs:string | `upper-case($operation)` |
| `$numeroPeticiones` | xs:string | `count(DEBTORS/DEBTOR)` (como string) |

**Salida:**
| Campo | Transformación |
|-------|----------------|
| `PV_CODIGOUSUARIO` | `$codigoUsuario` (directo) |
| `PV_IDPROXY` | `$IdProxy` (directo) |
| `PV_OPERACION` | `$operacion` (directo) |
| `PN_CANTIDADPETICIONES` | `data($numeroPeticiones)` |

---

### 6. actualizaPeticionesDisponiblesH2HIn.xq

**Ruta:** `v1/Resources/CobranzasH2H/xq/actualizaPeticionesDisponiblesH2HIn.xq`

**Propósito:** Mapea parámetros para el SP de actualización de peticiones disponibles tras la consulta.

**Entrada:**
| Parámetro | Tipo | Origen |
|-----------|------|--------|
| `$codigoUsuario` | xs:string | `upper-case($header/Authentication/UserName)` |
| `$idProxy` | xs:string | Literal `"FICBCO0258"` |
| `$operacion` | xs:string | `upper-case($operation)` |
| `$cantidadExitosos` | xs:int | `$RSPsjConsulta/SUCCESS_AMOUNT` |
| `$cantidadErroneos` | xs:int | `$RSPsjConsulta/ERROR_AMOUNT` |

**Salida:**
| Campo | Transformación |
|-------|----------------|
| `PV_CODIGOUSUARIO` | `$codigoUsuario` (directo) |
| `PV_IDPROXY` | `$idProxy` (directo) |
| `PV_OPERACION` | `$operacion` (directo) |
| `PN_CANTIDADEXITOSOS` | `data($cantidadExitosos)` |
| `PN_CANTIDADERRONEOS` | `data($cantidadErroneos)` |
