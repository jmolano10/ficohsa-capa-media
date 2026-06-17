# Listado de XQuery que Intervienen - ConsultaOfertaCreditoConsumo

---

## Honduras (HN01)

### 1. consultaConsolidadoRiesgoClienteIn.xqy

**Ruta**: `Middleware/v2/Resources/ConsultaOfertaCreditoConsumo/xq/consultaConsolidadoRiesgoClienteIn.xqy`

**Propósito**: Construye el request para el servicio ConsultaConsolidadaRiesgoCliente a partir del ID del cliente.

**Parámetros de entrada**:
- `$customerLegalID` (xs:string) — ID/identidad del cliente

**Salida**: Elemento `ns0:consultaConsolidadaRiesgoCliente`

**Transformación de campos**:

| Campo Entrada | Campo Salida |
|---------------|--------------|
| `$customerLegalID` | `CUSTOMER_LEGAL_ID` |

**Análisis**: XQuery simple que toma el ID legal del cliente y lo envuelve en el request del servicio de riesgo consolidado. Sin lógica condicional ni reglas de negocio.

---

### 2. consultaOfertaCreditoConsumoCloudIn.xqy

**Ruta**: `Middleware/v2/Resources/ConsultaOfertaCreditoConsumo/xq/consultaOfertaCreditoConsumoCloudIn.xqy`

**Propósito**: Transforma el request OSB + respuesta de riesgo consolidado al formato esperado por la API FICO Blaze Cloud (operación epOriginacionesHonduras).

**Parámetros de entrada**:
- `$consultaOfertaCreditoConsumoRequest` — Request OSB completo
- `$consultaConsolidadaRiesgoClienteResponse` — Respuesta del servicio de riesgo consolidado

**Salida**: Elemento `ns3:epOriginacionesHonduras/arg0`

**Transformación de campos principales**:

| Campo Entrada (OSB) | Lógica | Campo Salida (Blaze) |
|---------------------|--------|---------------------|
| `CUSTOMER_INFO/ID` | directo | `identidad` |
| `CUSTOMER_INFO/TYPE` | directo | `tipoCliente` |
| `CUSTOMER_INFO/TOTAL_SALARY` | `xs:float()`, condicional exists | `salarioBruto` |
| `CUSTOMER_INFO/NET_SALARY` | `xs:float()`, condicional exists | `salarioNeto` |
| `CUSTOMER_INFO/PAYROLL_SALARY` | `xs:float()`, condicional exists | `salarioPlanilla` |
| `CUSTOMER_INFO/GENDER` | directo | `sexo` |
| `CUSTOMER_INFO/TARGET` | directo | `segmentoCliente` |
| `CUSTOMER_INFO/JOB_TYPE` | for-each | `tipoTrabajo` |
| `EXTERNAL_SCORE` | `xs:float()`, condicional exists | `scoreBuro` |
| `SCORE_INFO/QUALIFICATION` | for-each | `score/calificacionScore` |
| `SCORE_INFO/RISK_LEVEL` | for-each | `score/nivelRiesgo` |
| `SCORE_INFO/SCORE_CALCULATION` | `xs:float()`, condicional exists | `score/score` |
| `AGREEMENT/RATE` | `xs:float()`, condicional exists | `tasaConvenio` |
| `LIABILITIES/CREDIT_CARDS_INFO/CREDIT_CARD` | for-each con mapeos internos | `tarjetas[]` |
| `REFERENCES_DETAILS/ACTIVE_REFERENCES/REFERENCE` | for-each con mapeos internos | `referencias[]` |
| `REFERENCES_DETAILS/HISTORICAL_REFERENCES/REFERENCE` | for-each (mismo mapeo que activas) | `referencias[]` |
| Préstamos de `consultaConsolidadaRiesgoClienteResponse` | for-each con transacciones | `prestamos[]` |

**Análisis**: XQuery complejo que combina dos fuentes de datos (request original + riesgo consolidado). Mapea:
- Información del cliente (datos personales, salarios, scores)
- Tarjetas de crédito con transacciones (extra/intra)
- Referencias crediticias activas e históricas con todos sus campos
- Préstamos del servicio de riesgo consolidado con transacciones
- Campos condicionales: usa `if (exists($X)) then... else ()` para campos opcionales con casting a `xs:float()`, `xs:date()`, `xs:int()`

---

### 3. consultaOfertaCreditoConsumoCloudOut.xqy

**Ruta**: `Middleware/v2/Resources/ConsultaOfertaCreditoConsumo/xq/consultaOfertaCreditoConsumoCloudOut.xqy`

**Propósito**: Transforma la respuesta de la API FICO Blaze Cloud al formato de response OSB.

**Parámetros de entrada**:
- `$epOriginacionesHondurasResponse` — Respuesta de Blaze Cloud

**Salida**: Elemento `ns2:consultaOfertaCreditoConsumoResponse`

**Transformación de campos principales**:

| Campo Entrada (Blaze) | Lógica | Campo Salida (OSB) |
|----------------------|--------|-------------------|
| `return/numeroSolicitud` | directo | `CASE_ID` |
| `return/RCI` | `xs:float()` | `GENERAL_RCI` |
| `return/RCIMax` | `xs:float()` | `GENERAL_RCI_MAX` |
| `return/NDEActual` | `xs:float()` | `GENERAL_CURRENT_NDE` |
| `return/NDEFinal` | `xs:float()` | `GENERAL_FINAL_NDE` |
| `return/behaviorScoreTC` | `xs:int()` | `CREDIT_CARD_SCORE` |
| `return/score/score` | `xs:float()` | `INTERNAL_SCORE` |
| `return/nivelRiesgoTC` | `xs:string()` | `CREDIT_CARD_RISK_LEVEL` |
| `return/score/nivelRiesgo` | `xs:string()` | `INTERNAL_RISK_LEVEL` |
| `return/calificacionBuro` | `xs:string()` | `EXTERNAL_RISK_LEVEL` |
| `return/segmentoCliente` | `xs:string()` | `CUSTOMER_SEGMENT` |
| `return/subSegmentoCliente` | `xs:string()` | `CUSTOMER_SUBSEGMENT` |
| `return/exposicionActual` | `xs:float()` | `CURRENT_EXPOSURE` |
| `return/exposicionGlobal` | `xs:float()` | `GLOBAL_EXPOSURE_LOCAL_CCY` |
| `return/exposicionGlobalUSD` | `xs:float()` | `GLOBAL_EXPOSURE_FOREIGN_CCY` |
| `return/noSobregiroTC` | `xs:float()` | `CREDIT_CARD_OVERDRAFT` |
| `return/noReferenciasCrediticias` | `xs:int()` | `CREDIT_REFERENCES` |
| `return/noReferenciasPtmo` | `xs:int()` | `INTERNAL_LOAN_REFERENCES` |
| `return/noReferenciasSR` | `xs:int()` | `REWRITE_REFERENCES` |
| `return/totalExtrafinanciamientos` | `xs:int()` | `TOTAL_EXTRA` |
| `return/riesgoTotal` | `xs:float()` | `TOTAL_RISK` |
| `return/moraActualInterna` | `xs:int()` | `CURRENT_ARREAR` |
| `return/saldoMoraActualInterna` | `xs:float()` | `CURRENT_ARREAR_BALANCE` |
| `return/expCrediticia` | `xs:int()` | `CREDIT_EXPERIENCE` |
| `return/vecesMora60_6m` | `xs:int()` | `ARREAR_ON_60DAYS_FOR_6MONTHS` |
| `return/vecesMora60_12m` | `xs:int()` | `ARREAR_ON_60DAYS_FOR_12MONTHS` |
| `return/vecesMora90_12m` | `xs:int()` | `ARREAR_ON_90DAYS_FOR_12MONTHS` |
| `return/oferta/arrayResolucion[]` | for-each | `RESOLUTIONS/RESOLUTION[]` |
| `return/oferta[]` | for-each | `RESOLUTION_OFFERS/OFFER[]` |
| `return/oferta/monto12..monto120` | `xs:float()` | `FOR_12_MONTHS..FOR_120_MONTHS` |
| `return/tarjetas[]` | for-each | `CREDIT_CARD[]` |

**Análisis**: Mapeo directo 1:1 con casteo de tipos. Itera sobre ofertas y tarjetas. Los campos de tarjeta incluyen transacciones (EXTRA_FEE, INTRA_FEE, EXTRA_BALANCE, INTRA_BALANCE).

---

### 4. consultaOfertaCreditoConsumoIn.xqy

**Ruta**: `Middleware/v2/Resources/ConsultaOfertaCreditoConsumo/xq/consultaOfertaCreditoConsumoIn.xqy`

**Propósito**: Versión legacy/on-premise del mapeo de entrada a Blaze (mismo propósito que CloudIn pero para el servicio on-premise).

**Parámetros de entrada**:
- `$consultaOfertaCreditoConsumoRequest` — Request OSB
- `$consultaConsolidadaRiesgoClienteResponse` — Respuesta riesgo consolidado

**Salida**: Elemento `ns1:epOriginacionesHonduras`

**Análisis**: Estructura prácticamente idéntica a `consultaOfertaCreditoConsumoCloudIn.xqy`, con la diferencia de que usa `fn:string-length(data($X)) > 0` para validaciones condicionales en lugar de `exists($X)`. Ambas versiones coexisten para soportar la migración de on-premise a cloud.

---

### 5. consultaOfertaCreditoConsumoOut.xqy

**Ruta**: `Middleware/v2/Resources/ConsultaOfertaCreditoConsumo/xq/consultaOfertaCreditoConsumoOut.xqy`

**Propósito**: Versión legacy/on-premise del mapeo de salida de Blaze.

**Parámetros de entrada**:
- `$epOriginacionesHondurasResponse` — Respuesta de Blaze on-premise

**Salida**: Elemento `ns0:consultaOfertaCreditoConsumoResponse`

**Análisis**: Estructura idéntica a `consultaOfertaCreditoConsumoCloudOut.xqy`. Referencia el WSDL legacy (`RuleServiceDefinitionORPTMOHNService.wsdl`) y namespace `http://package.name.in.reverse.order`.

---

### 6. almacenaInformacionHondurasIN.xqy

**Ruta**: `Middleware/v2/Resources/ConsultaOfertaCreditoConsumo/xq/almacenaInformacionHondurasIN.xqy`

**Propósito**: Construye los parámetros de entrada para el SP de almacenamiento de la oferta.

**Parámetros de entrada**:
- `$identidad` (xs:string) — ID del cliente
- `$xml` (xs:string) — XML serializado de la respuesta de Blaze

**Salida**: Elemento `ns1:InputParameters`

**Transformación de campos**:

| Campo Entrada | Campo Salida |
|---------------|--------------|
| `$identidad` | `ns1:IDENTIDAD` |
| `$xml` | `ns1:XML` |

**Análisis**: XQuery simple que empaqueta la identidad del cliente y el XML serializado completo de la respuesta Blaze como parámetros del Stored Procedure. El SP almacena el XML "as-is" en la base de datos.

---

## Guatemala (GT01)

### 7. processWithDecisionFlow2In.xqy

**Ruta**: `Middleware/v2/Resources/ConsultaOfertaCreditoConsumoGT/xq/processWithDecisionFlow2In.xqy`

**Propósito**: Transforma el request OSB al formato esperado por OIC (operación processWithDecisionFlow2).

**Parámetros de entrada**:
- `$token` (xs:string) — Token de autenticación
- `$consultaOfertaCreditoConsumoRequest` — Request OSB

**Salida**: Elemento `ns1:processWithDecisionFlow2/arg0`

**Transformación de campos principales**:

| Campo Entrada (OSB) | Lógica | Campo Salida (OIC) |
|---------------------|--------|-------------------|
| `$token` | directo | `arg0/token` |
| `CUSTOMER_INFO/SIB_REFERENCE` | for-each | `arg0/accion/referenciaSIB` |
| (constante 0) | hardcoded | `arg0/antiguedadExtrafinanciamiento..antiguedadTarjetaCancelada` |
| `CUSTOMER_INFO/SALES_ORIGIN` | for-each | `arg0/canalDeVenta` |
| (constante 0) | hardcoded | `arg0/clienteCastigado..clienteUniversitario` |
| `CUSTOMER_INFO/VIP_CLIENT` | for-each | `arg0/clienteVIP` |
| (constante 0) | hardcoded | `arg0/codigoTipoCliente` |
| `REFERENCES_DETAILS/QUERIES/QUERY_ITEM` | for-each con conversión fechas | `arg0/consultaTuca[]` |
| `QUERY_ITEM/DATE` | `fn-bea:date-from-string-with-format` (dd/MM/yyyy → yyyy-MM-ddTHH:mm:ss) | `consultaTuca/fechaConsulta` |
| Referencias activas/históricas | for-each (mismo mapeo que HN) | `arg0/referencias[]` |
| Salarios, scores, tarjetas | mismo mapeo que HN | campos correspondientes |
| `CUSTOMER_INFO/TYPE` | directo | `arg0/tipoCliente` |
| `CUSTOMER_INFO/JOB_TYPE` | for-each | `arg0/tipoTrabajo` |

**Análisis**: XQuery complejo con diferencias clave respecto a HN:
- Envía el token dentro del payload (no como header HTTP)
- Incluye campos de `consultaTuca` (consultas de buró TUCA) con conversión de formato de fecha
- Inicializa múltiples campos de antigüedad y estado con valor constante `0`
- Incluye `referenciaSIB`, `canalDeVenta`, `clienteVIP` que no se envían en HN
- NO recibe la respuesta de ConsultaConsolidadaRiesgoCliente como input

---

### 8. consultaOfertaCreditoConsumoGTOut.xqy

**Ruta**: `Middleware/v2/Resources/ConsultaOfertaCreditoConsumoGT/xq/consultaOfertaCreditoConsumoGTOut.xqy`

**Propósito**: Transforma la respuesta de OIC (processWithDecisionFlow2Response) al formato de response OSB.

**Parámetros de entrada**:
- `$processWithDecisionFlow2Response` — Respuesta de OIC

**Salida**: Elemento `ns0:consultaOfertaCreditoConsumoResponse`

**Transformación de campos principales**:

| Campo Entrada (OIC) | Lógica | Campo Salida (OSB) |
|--------------------|--------|-------------------|
| `return/noSolicitud` | for-each | `CASE_ID` |
| `return/accion/rciFinal` | for-each | `GENERAL_RCI` |
| `return/accion/rciMax` | for-each | `GENERAL_RCI_MAX` |
| `return/accion/nivelEndeudamientoActual` | for-each | `GENERAL_CURRENT_NDE` |
| `return/accion/nivelEndeudamientoFinal` | for-each | `GENERAL_FINAL_NDE` |
| `return/accion/scoreTarjetaCredito` | for-each | `CREDIT_CARD_SCORE` |
| `return/accion/nivelRiesgoTarjetaCredito` | for-each | `CREDIT_CARD_RISK_LEVEL` |
| `return/accion/nivelRiesgoExterno` | for-each | `EXTERNAL_RISK_LEVEL` |
| `return/accion/segmentoCliente` | for-each | `CUSTOMER_SEGMENT` |
| `return/accion/subSegmentoCliente` | for-each | `CUSTOMER_SUBSEGMENT` |
| `return/accion/exposicionGlobal` | for-each | `CURRENT_EXPOSURE` |
| `return/accion/exposicionActualLOC` | for-each | `GLOBAL_EXPOSURE_LOCAL_CCY` |
| `return/accion/exposicionActualUSD` | for-each | `GLOBAL_EXPOSURE_FOREIGN_CCY` |
| `return/accion/sobreGiroTarjetaCredito` | for-each | `CREDIT_CARD_OVERDRAFT` |
| `return/oferta[]` | for-each | `RESOLUTION_OFFERS/OFFER[]` |
| `return/oferta/monto12..monto120` | for-each | `FOR_12_MONTHS..FOR_120_MONTHS` |

**Análisis**: Mapeo directo usando `for-each` (en lugar de acceso directo con `data()` como HN). Los campos están bajo `return/accion/` (a diferencia de HN donde están bajo `return/` directamente). No hay casteo explícito de tipos (usa datos tal cual vienen de OIC).

**Diferencias con el XQuery de salida HN**:
- Estructura: campos bajo `return/accion/` en GT vs `return/` directo en HN
- Nombres de campos diferentes: `exposicionActualLOC` (GT) vs `exposicionGlobal` (HN), `exposicionActualUSD` (GT) vs `exposicionGlobalUSD` (HN)
- Sin casteo explícito de tipos en GT
- Uso de `for-each` en GT vs acceso directo `data()` en HN
