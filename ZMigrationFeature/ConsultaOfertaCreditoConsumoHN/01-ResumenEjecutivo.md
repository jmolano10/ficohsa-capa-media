# Resumen Ejecutivo - ConsultaOfertaCreditoConsumoHN

## Índice de Entregables

- [02-ComparativaRegiones.md](./02-ComparativaRegiones.md)
- [03-EjemplosYMapeos-HN01.md](./03-EjemplosYMapeos-HN01.md)
- [03-EjemplosYMapeos-GT01.md](./03-EjemplosYMapeos-GT01.md)
- [06-ListadoFicheros.md](./06-ListadoFicheros.md)
- [07-ListadoXQ.md](./07-ListadoXQ.md)

---

## Propósito de la Funcionalidad

La funcionalidad **ConsultaOfertaCreditoConsumo** es un servicio OSB que permite consultar ofertas de crédito de consumo para clientes de Ficohsa. El servicio recibe información del cliente (datos personales, referencias crediticias, tarjetas, activos, pasivos, scores) y retorna una evaluación de riesgo con ofertas de crédito pre-aprobadas incluyendo montos, plazos y tasas.

El flujo opera con **enrutamiento regional dinámico**: un pipeline principal (`ConsultaOfertaCreditoConsumo.pipeline`) valida el request, consulta la ruta regional mediante un SP, y redirige al pipeline específico de la región (HN o GT).

---

## Entradas y Salidas Principales

### Request (SOAP)
- **Header**: `RequestHeader` con `SourceBank` (región)
- **Body**: `consultaOfertaCreditoConsumoRequest` con:
  - `CASE_ID` (ID de solicitud)
  - `PRODUCT_NATURE` (naturaleza del producto)
  - `CUSTOMER_INFO` (ID, tipo, salarios, género, segmento, tipo trabajo)
  - `EXTERNAL_SCORE` (score buró externo)
  - `SCORE_INFO` (calificación, nivel riesgo, cálculo score)
  - `OFFERS` (ofertas pre-existentes)
  - `ASSETS` (activos)
  - `LIABILITIES` (pasivos, tarjetas de crédito)
  - `PRE_APPROVED_OFFERS` (ofertas pre-aprobadas)
  - `INTERNAL_EXTRAS` (extras internos)
  - `REFERENCES_DETAILS` (consultas buró, referencias activas/históricas, TUCA, SIRC, consolidados)
  - `AGREEMENT` (convenio: tasa, empresa, monto, plazo)

### Response (SOAP)
- **Header**: `ResponseHeader` con `successIndicator` (Success/ERROR) y `messages`
- **Body**: `consultaOfertaCreditoConsumoResponse` con:
  - Métricas de riesgo: RCI, NDE actual/final, scores internos/externos
  - Segmentación: segmento/subsegmento cliente
  - Exposición crediticia: actual, global (local/USD)
  - Ofertas resueltas: `RESOLUTION_OFFERS` con montos por plazo (12-120 meses), tasas, cuotas
  - Tarjetas de crédito evaluadas
  - Información de consolidación

---

## Sistemas/Servicios OSB Involucrados

| # | Componente | Tipo | Propósito |
|---|-----------|------|-----------|
| 1 | `ConsultaOfertaCreditoConsumo.proxy` | Proxy (Router) | Punto de entrada, validación XSD, enrutamiento regional dinámico |
| 2 | `ConsultaOfertaCreditoConsumoHN.proxy/.pipeline` | Proxy + Pipeline | Flujo específico Honduras |
| 3 | `ConsultaOfertaCreditoConsumoGT.proxy/.pipeline` | Proxy + Pipeline | Flujo específico Guatemala |
| 4 | `ConsultaConsolidadaRiesgoClienteHN` | Proxy (wsCallout) | Consulta riesgo consolidado del cliente (solo HN) |
| 5 | `TokenizacionProcesamientoBlazeProxyService` | Proxy (wsCallout) | Obtención de token Bearer para APIs cloud |
| 6 | `blazeCloudApiRestBS` | Business Service REST | API FICO Blaze Cloud - motor de decisión HN (epOriginacionesHonduras) |
| 7 | `originacionesGT` | Business Service SOAP/OIC | API OIC - motor de decisión GT (processWithDecisionFlow2) |
| 8 | `AlmacenaInformacionOfertaHonduras_db` | Business Service JCA/DB | Almacena resultado de oferta en BD (solo HN, publish/fire-and-forget) |
| 9 | `consultaRutaRegional_db` | Business Service JCA/DB | Determina ruta regional dinámica por ServiceId FICBCO0399 |
| 10 | `MapeoErrores` | Proxy (wsCallout) | Mapeo y normalización de errores |

---

## Regiones Detectadas

- **HN01** – Honduras (pipeline dedicado `ConsultaOfertaCreditoConsumoHN.pipeline`)
- **GT01** – Guatemala (pipeline dedicado `ConsultaOfertaCreditoConsumoGT.pipeline`)

> **Nota**: El XSD y WSDL son compartidos entre regiones. No se detectaron pipelines ni proxies para PA01 o NI01 en este servicio.

---

## Riesgos / Limitaciones Conocidas

1. **Dependencia de token externo**: El flujo depende de `TokenizacionProcesamientoBlaze` para obtener un Bearer token. Si falla, HN retorna error genérico "No se obtuvo token de entrada" y GT verifica con `validationMessage`.
2. **Fire-and-forget en almacenamiento (HN)**: El almacenamiento de la oferta (`AlmacenaInformacionOfertaHonduras_db`) se realiza como `publish` (route sin esperar respuesta). Si falla, no se notifica al cliente.
3. **Error handler específico para HTTP en HN**: El pipeline HN captura códigos HTTP (401, 503) del servicio Blaze Cloud y genera mensajes específicos, pero usa `resume` para continuar el flujo con `ErrorCode` (no aborta inmediatamente).
4. **Sin retry en servicios cloud**: Tanto `blazeCloudApiRestBS` como `originacionesGT` tienen `retry-count=0`.
5. **Timeout de 60-70s en APIs externas**: `blazeCloudApiRestBS` tiene timeout 60s y connection-timeout 65s; `originacionesGT` tiene timeout 70s y connection-timeout 65s.

---

## Métricas / SLAs

| Servicio | Timeout | Connection Timeout | Retry |
|----------|---------|-------------------|-------|
| blazeCloudApiRestBS (HN) | 60s | 65s | 0 |
| originacionesGT (GT) | 70s | 65s | 0 |
| AlmacenaInformacionOfertaHonduras_db | N/A (JCA) | N/A | 0 |

---

## Proxies Dependientes

Los siguientes proxies son referenciados internamente y podrían requerir análisis complementario:

| Proxy | Ruta | Uso |
|-------|------|-----|
| ConsultaConsolidadaRiesgoClienteHN | `Middleware/v2/ProxyServices/ConsultaConsolidadaRiesgoClienteHN` | Consulta consolidada de riesgo (solo HN) |
| TokenizacionProcesamientoBlazeProxyService | `Middleware/v2/ProxyServices/TokenizacionProcesamientoBlazeProxyService` | Obtención token Blaze (HN) |
| TokenizacionProcesamientoBlaze | `Middleware/v2/ProxyServices/TokenizacionProcesamientoBlaze` | Obtención token Blaze (GT) |
| MapeoErrores | `Middleware/v2/ProxyServices/MapeoErrores` | Normalización de errores |
