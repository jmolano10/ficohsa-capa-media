# Listado de Ficheros que Intervienen - ConsultaOfertaCreditoConsumo

## Proxies

| # | Ruta Relativa | Propósito |
|---|---------------|-----------|
| 1 | `Middleware/v2/ProxyServices/ConsultaOfertaCreditoConsumo.proxy` | Proxy principal (router regional) |
| 2 | `Middleware/v2/ProxyServices/ConsultaOfertaCreditoConsumoHN.proxy` | Proxy Honduras |
| 3 | `Middleware/v2/ProxyServices/ConsultaOfertaCreditoConsumoGT.proxy` | Proxy Guatemala |

## Pipelines

| # | Ruta Relativa | Propósito |
|---|---------------|-----------|
| 1 | `Middleware/v2/ProxyServices/ConsultaOfertaCreditoConsumo.pipeline` | Pipeline router: validación XSD, consulta ruta regional, enrutamiento dinámico |
| 2 | `Middleware/v2/ProxyServices/ConsultaOfertaCreditoConsumoHN.pipeline` | Pipeline HN: riesgo, token, Blaze Cloud, almacenamiento |
| 3 | `Middleware/v2/ProxyServices/ConsultaOfertaCreditoConsumoGT.pipeline` | Pipeline GT: token, OIC originaciones |

## Business Services

| # | Ruta Relativa | Tipo | Propósito |
|---|---------------|------|-----------|
| 1 | `Middleware/v2/BusinessServices/BLAZE/biz/blazeCloudApiRestBS.bix` | REST/SOAP | Motor de decisión FICO Blaze Cloud (HN) |
| 2 | `Middleware/v2/BusinessServices/OIC/originacionesGT/biz/originacionesGT.bix` | SOAP/OIC | Motor de decisión OIC (GT) |
| 3 | `Middleware/v2/BusinessServices/decisionModeler/ConsultaOfertaCreditoConsumo/biz/AlmacenaInformacionOfertaHonduras_db.bix` | JCA/DB | Almacenamiento de oferta en BD (HN) |

## WSDLs

| # | Ruta Relativa | Propósito |
|---|---------------|-----------|
| 1 | `Middleware/v2/Resources/ConsultaOfertaCreditoConsumo/wsdl/consultaOfertaCreditoConsumoPS.wsdl` | Contrato del proxy service |
| 2 | `Middleware/v2/BusinessServices/BLAZE/wsdl/blazeCloudApi.wsdl` | Contrato Blaze Cloud API (HN) |
| 3 | `Middleware/v2/BusinessServices/OIC/originacionesGT/wsdl/originacionesGT.wsdl` | Contrato OIC originaciones (GT) |
| 4 | `Middleware/v2/BusinessServices/decisionModeler/ConsultaOfertaCreditoConsumo/wsdl/AlmacenaInformacionOfertaHonduras.wsdl` | Contrato SP almacenamiento |
| 5 | `Middleware/v2/BusinessServices/decisionModeler/ConsultaOfertaCreditoConsumo/wsdl/AlmacenaInformacionOfertaHonduras_db.wsdl` | Contrato DB adapter almacenamiento |

## XSDs

| # | Ruta Relativa | Propósito |
|---|---------------|-----------|
| 1 | `Middleware/v2/Resources/ConsultaOfertaCreditoConsumo/xsd/consultaOfertaCreditoConsumoTypes.xsd` | Tipos del servicio (request/response) |
| 2 | `Middleware/v2/BusinessServices/BLAZE/xsd/blazeCloudApi.xsd` | Tipos Blaze Cloud API |
| 3 | `Middleware/v2/BusinessServices/decisionModeler/ConsultaOfertaCreditoConsumo/xsd/AlmacenaInformacionOfertaHonduras_sp.xsd` | Tipos SP almacenamiento |

## XQuery/XSL

| # | Ruta Relativa | Propósito |
|---|---------------|-----------|
| 1 | `Middleware/v2/Resources/ConsultaOfertaCreditoConsumo/xq/consultaConsolidadoRiesgoClienteIn.xqy` | Mapeo entrada a ConsultaConsolidadaRiesgoCliente (HN) |
| 2 | `Middleware/v2/Resources/ConsultaOfertaCreditoConsumo/xq/consultaOfertaCreditoConsumoCloudIn.xqy` | Mapeo entrada a Blaze Cloud API (HN – Cloud) |
| 3 | `Middleware/v2/Resources/ConsultaOfertaCreditoConsumo/xq/consultaOfertaCreditoConsumoCloudOut.xqy` | Mapeo salida de Blaze Cloud API (HN – Cloud) |
| 4 | `Middleware/v2/Resources/ConsultaOfertaCreditoConsumo/xq/consultaOfertaCreditoConsumoIn.xqy` | Mapeo entrada a Blaze (HN – legacy/on-premise) |
| 5 | `Middleware/v2/Resources/ConsultaOfertaCreditoConsumo/xq/consultaOfertaCreditoConsumoOut.xqy` | Mapeo salida de Blaze (HN – legacy/on-premise) |
| 6 | `Middleware/v2/Resources/ConsultaOfertaCreditoConsumo/xq/almacenaInformacionHondurasIN.xqy` | Mapeo entrada SP AlmacenaInformacionOfertaHonduras (HN) |
| 7 | `Middleware/v2/Resources/ConsultaOfertaCreditoConsumoGT/xq/processWithDecisionFlow2In.xqy` | Mapeo entrada a OIC originacionesGT (GT) |
| 8 | `Middleware/v2/Resources/ConsultaOfertaCreditoConsumoGT/xq/consultaOfertaCreditoConsumoGTOut.xqy` | Mapeo salida de OIC originacionesGT (GT) |

## JCA Adapters

| # | Ruta Relativa | Propósito |
|---|---------------|-----------|
| 1 | `Middleware/v2/BusinessServices/decisionModeler/ConsultaOfertaCreditoConsumo/jca/AlmacenaInformacionOfertaHonduras_db.jca` | Adaptador JCA para SP de almacenamiento |

## Proxies Dependientes (externos al servicio)

| # | Ruta Relativa | Propósito |
|---|---------------|-----------|
| 1 | `Middleware/v2/ProxyServices/ConsultaConsolidadaRiesgoClienteHN` | Consulta riesgo consolidado (HN) |
| 2 | `Middleware/v2/ProxyServices/TokenizacionProcesamientoBlazeProxyService` | Tokenización Blaze (HN) |
| 3 | `Middleware/v2/ProxyServices/TokenizacionProcesamientoBlaze` | Tokenización Blaze (GT) |
| 4 | `Middleware/v2/ProxyServices/MapeoErrores` | Normalización de errores |
| 5 | `Middleware/v2/BusinessServices/MDW/consultaRutaRegional/biz/consultaRutaRegional_db` | Consulta ruta regional dinàmica |

## Recursos Generales Referenciados

| # | Ruta Relativa | Propósito |
|---|---------------|-----------|
| 1 | `Middleware/v2/Resources/Generales/xq/consultaRutaRegionalIn` | XQ de entrada para consulta ruta regional |
| 2 | `Middleware/v2/Resources/Generales/xq/aplicarValoresPorDefectoRegion` | XQ para aplicar valores por defecto de región al header |
| 3 | `Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageIn` | XQ entrada mapeo errores |
| 4 | `Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageOut` | XQ salida mapeo errores |

## Seguridad

| # | Ruta Relativa | Propósito |
|---|---------------|-----------|
| 1 | `Middleware/Security/DEVCLOUD` | Service Account para autenticación HTTP Basic ante OIC (GT) |
