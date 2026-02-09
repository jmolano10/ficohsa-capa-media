# Listado de Ficheros - PagosMasivos

## Proxy Services

### Proxy Principal
- `Middleware/v2/ProxyServices/PagosMasivos.proxy`
- `Middleware/v2/ProxyServices/PagosMasivos.pipeline`

### Proxies Internos por Región
- `Middleware/v2/ProxyServices/PagosMasivosInterno.pipeline`
- `Middleware/v2/ProxyServices/PagosMasivosInternoGT.pipeline`
- `Middleware/v2/ProxyServices/PagosMasivosInternoPA.pipeline`

### Proxies de Operaciones Relacionadas
- `Middleware/v2/ProxyServices/CargaProveedores.pipeline`
- `Middleware/v2/ProxyServices/AutorizarProveedores.pipeline`
- `Middleware/v2/ProxyServices/EliminarProveedores.pipeline`
- `Middleware/v2/ProxyServices/ConsultaProveedores.pipeline`
- `Middleware/v2/ProxyServices/ConsultaDetalleLote.pipeline`
- `Middleware/v2/ProxyServices/ConsultaTransaccionLote.pipeline`
- `Middleware/v2/ProxyServices/ConsultaEstadoLote.pipeline`
- `Middleware/v2/ProxyServices/CancelarLote.pipeline`
- `Middleware/v2/ProxyServices/EditarEstadoRegistroLote.pipeline`
- `Middleware/v2/ProxyServices/AutorizarLotePagosMasivos.pipeline`
- `Middleware/v2/ProxyServices/CargarArchivoLote.pipeline`
- `Middleware/v2/ProxyServices/ConsultaLotesCliente.pipeline`
- `Middleware/v2/ProxyServices/MapeoErrores.pipeline`
- `Middleware/v2/ProxyServices/ConsultaDetallesCuentaMasivos.pipeline`

## Business Services

### BPEL Flow (HN01)
- `Middleware/v2/BusinessServices/SJS/pagosMasivosInterno/flow/sjPagosMasivosInterno.flow`
- `Middleware/v2/BusinessServices/SJS/pagosMasivosInterno/wsdl/sjPagosMasivosInterno.wsdl`
- `Middleware/v2/BusinessServices/SJS/pagosMasivosInterno/xsd/sjPagosMasivosInterno.xsd`

### Database Adapters - PMSV (HN01)
- `Middleware/v2/BusinessServices/PMSV/validaEstructuraLote/biz/validaEstructuraLote_db.bix`
- `Middleware/v2/BusinessServices/PMSV/validaEstructuraLote/jca/validaEstructuraLote_db.jca`
- `Middleware/v2/BusinessServices/PMSV/validaEstructuraLote/wsdl/validaEstructuraLote_db.wsdl`
- `Middleware/v2/BusinessServices/PMSV/validaEstructuraLote/xsd/validaEstructuraLote_sp.xsd`

- `Middleware/v2/BusinessServices/PMSV/procesaLotePagoMasivo/biz/procesaLotePagoMasivo_db.bix`
- `Middleware/v2/BusinessServices/PMSV/procesaLotePagoMasivo/jca/procesaLotePagoMasivo_db.jca`
- `Middleware/v2/BusinessServices/PMSV/procesaLotePagoMasivo/wsdl/procesaLotePagoMasivo_db.wsdl`
- `Middleware/v2/BusinessServices/PMSV/procesaLotePagoMasivo/xsd/procesaLotePagoMasivo_sp.xsd`

- `Middleware/v2/BusinessServices/PMSV/registraBitacoraPagosMasivos/biz/registraBitacoraPagosMasivos_db.bix`
- `Middleware/v2/BusinessServices/PMSV/registraBitacoraPagosMasivos/jca/registraBitacoraPagosMasivos_db.jca`
- `Middleware/v2/BusinessServices/PMSV/registraBitacoraPagosMasivos/wsdl/registraBitacoraPagosMasivos_db.wsdl`
- `Middleware/v2/BusinessServices/PMSV/registraBitacoraPagosMasivos/xsd/registraBitacoraPagosMasivos_sp.xsd`

- `Middleware/v2/BusinessServices/PMSV/registraBitacoraPagosMasivosRG/biz/registraBitacoraPagosMasivosRG_db.bix`
- `Middleware/v2/BusinessServices/PMSV/registraBitacoraPagosMasivosRG/jca/registraBitacoraPagosMasivosRG_db.jca`
- `Middleware/v2/BusinessServices/PMSV/registraBitacoraPagosMasivosRG/wsdl/registraBitacoraPagosMasivosRG_db.wsdl`
- `Middleware/v2/BusinessServices/PMSV/registraBitacoraPagosMasivosRG/xsd/registraBitacoraPagosMasivosRG_sp.xsd`

- `Middleware/v2/BusinessServices/PMSV/validaAccesoPMS/biz/validaAccesoPMS_db.bix`
- `Middleware/v2/BusinessServices/PMSV/validaAccesoPMS/jca/validaAccesoPMS_db.jca`
- `Middleware/v2/BusinessServices/PMSV/validaAccesoPMS/wsdl/validaAccesoPMS_db.wsdl`
- `Middleware/v2/BusinessServices/PMSV/validaAccesoPMS/xsd/validaAccesoPMS_sp.xsd`

### SOAP Services - MTR (GT01, PA01, NI01)
- `Middleware/v2/BusinessServices/MTR/cargadorArchivoLote/biz/cargadorArchivoLote.bix`
- `Middleware/v2/BusinessServices/MTR/cargadorArchivoLote/wsdl/cargadorArchivoLoteEndpoint.wsdl`

- `Middleware/v2/BusinessServices/MTR/validaAccesoPMS/biz/validaAccesoPMS.bix`
- `Middleware/v2/BusinessServices/MTR/validaAccesoPMS/wsdl/validaAccesoPMS.wsdl`

### T24 Services
- `Middleware/Business_Resources/ConsultasCuenta/Resources/consultaCuentasBS.bix`
- `Middleware/Business_Resources/ConsultasCuenta/Resources/consultaCuentasBS.wsdl`

### Validación Regional
- `Middleware/v2/BusinessServices/ValidaServicioRegional/biz/ValidaServicioRegional_db.bix`
- `Middleware/v2/BusinessServices/ValidaServicioRegional/jca/ValidaServicioRegional_db.jca`
- `Middleware/v2/BusinessServices/ValidaServicioRegional/wsdl/ValidaServicioRegional_db.wsdl`

## Resources

### WSDL
- `Middleware/v2/Resources/PagosMasivos/wsdl/pagosMasivosPS.wsdl`
- `Middleware/v2/Resources/PagosMasivosInterno/wsdl/pagosMasivosInternoPS.wsdl`

### XSD (Schemas)
- `Middleware/v2/Resources/PagosMasivos/xsd/pagosMasivosTypes.xsd`
- `Middleware/v2/esquemas_generales/HeaderElements.xsd`
- `Middleware/v2/esquemas_generales/PagingTypes.xsd`

### XQuery - PagosMasivos
- `Middleware/v2/Resources/PagosMasivos/xq/validarAccesoPMSIn.xqy`
- `Middleware/v2/Resources/PagosMasivos/xq/validarAccesoPMSRGIn.xqy`

### XQuery - PagosMasivosInterno (HN01)
- `Middleware/v2/Resources/PagosMasivosInterno/xq/sjPagosMasivosInternoIn.xqy`
- `Middleware/v2/Resources/PagosMasivosInterno/xq/pagosMasivosInternoOut.xqy`
- `Middleware/v2/Resources/PagosMasivosInterno/xq/agrupaTxnLoteXCuenta.xqy`
- `Middleware/v2/Resources/PagosMasivosInterno/xq/registrarBitacoraPagosMasivosIn.xqy`
- `Middleware/v2/Resources/PagosMasivosInterno/xq/validarAccesoPMSIn.xqy`

### XQuery - PagosMasivosInterno (GT01)
- `Middleware/v2/Resources/PagosMasivosInterno/xq/pagosMasivosInternoGTIn.xqy`
- `Middleware/v2/Resources/PagosMasivosInterno/xq/pagosMasivosInternoGTOut.xqy`
- `Middleware/v2/Resources/PagosMasivosInterno/xq/pagosMasivosInternoGTHeaderOut.xqy`
- `Middleware/v2/Resources/PagosMasivosInterno/xq/registrarBitacoraPagosMasivosRGIn.xqy`

### XQuery - PagosMasivosInterno (PA01)
- `Middleware/v2/Resources/PagosMasivosInterno/xq/pagosMasivosInternoPAIn.xqy`
- `Middleware/v2/Resources/PagosMasivosInterno/xq/pagosMasivosInternoPAOut.xqy`
- `Middleware/v2/Resources/PagosMasivosInterno/xq/pagosMasivosInternoPAHeaderOut.xqy`

### XQuery - PagosMasivosInterno (NI01)
- `Middleware/v2/Resources/PagosMasivosInterno/xq/pagosMasivosInternoNIIn.xqy`
- `Middleware/v2/Resources/PagosMasivosInterno/xq/pagosMasivosInternoNIOut.xqy`
- `Middleware/v2/Resources/PagosMasivosInterno/xq/pagosMasivosInternoNIHeaderOut.xqy`
- `Middleware/v2/Resources/PagosMasivosInterno/xq/pagosMasivosInternoNIHeaderOur.xqy` (typo en nombre)

### XQuery - sjPagosMasivosInterno (BPEL)
- `Middleware/v2/BusinessServices/SJS/pagosMasivosInterno/xq/validaEstructuraLoteIn.xqy`
- `Middleware/v2/BusinessServices/SJS/pagosMasivosInterno/xq/consultaDetallesCuentaMasivosIn.xqy`
- `Middleware/v2/BusinessServices/SJS/pagosMasivosInterno/xq/consultaDetalleDeCuentaIn.xqy`
- `Middleware/v2/BusinessServices/SJS/pagosMasivosInterno/xq/consultaDeSaldoDeCuentaIn.xqy`
- `Middleware/v2/BusinessServices/SJS/pagosMasivosInterno/xq/procesaLotePagoMasivoIn.xqy`
- `Middleware/v2/BusinessServices/SJS/pagosMasivosInterno/xq/sjPagosMasivosInternoBacthOut.xqy`

### XQuery - Generales
- `Middleware/v2/Resources/Generales/xq/validaServicioRegionalIn.xqy`
- `Middleware/v2/Resources/Generales/xq/aplicarValoresPorDefectoRegion.xqy`
- `Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageIn.xqy`
- `Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageOut.xqy`
- `Middleware/Business_Resources/general/UUID/obtenerUUID.xqy`

## Políticas y Configuraciones

### Seguridad
- Custom Token Authentication configurado en `PagosMasivos.proxy`
- XPath para UserName: `./aut:RequestHeader/Authentication/UserName/text()`
- XPath para Password: `./aut:RequestHeader/Authentication/Password/text()`

### Monitoring y Alerting
- Configuración de monitoring en todos los proxies
- Intervalo de agregación: 360 segundos
- SLA alerting habilitado
- Pipeline alerting habilitado

## Java Callouts

No se identificaron Java Callouts en el análisis del código.

## POJOs

No se identificaron POJOs personalizados en el análisis del código.

## Properties Files

No se identificaron archivos .properties específicos en el análisis del código.
Los valores de configuración están embebidos en los archivos .bix y .jca.

## Tests

No se identificaron tests unitarios o de integración en el análisis del código.

## Archivos de Configuración

### JCA Files (Database Adapters)
- `Middleware/v2/BusinessServices/PMSV/validaEstructuraLote/jca/validaEstructuraLote_db.jca`
- `Middleware/v2/BusinessServices/PMSV/procesaLotePagoMasivo/jca/procesaLotePagoMasivo_db.jca`
- `Middleware/v2/BusinessServices/PMSV/registraBitacoraPagosMasivos/jca/registraBitacoraPagosMasivos_db.jca`
- `Middleware/v2/BusinessServices/PMSV/registraBitacoraPagosMasivosRG/jca/registraBitacoraPagosMasivosRG_db.jca`
- `Middleware/v2/BusinessServices/PMSV/validaAccesoPMS/jca/validaAccesoPMS_db.jca`
- `Middleware/v2/BusinessServices/ValidaServicioRegional/jca/ValidaServicioRegional_db.jca`

### BIX Files (Business Service Definitions)
- `Middleware/v2/BusinessServices/PMSV/validaEstructuraLote/biz/validaEstructuraLote_db.bix`
- `Middleware/v2/BusinessServices/PMSV/procesaLotePagoMasivo/biz/procesaLotePagoMasivo_db.bix`
- `Middleware/v2/BusinessServices/PMSV/registraBitacoraPagosMasivos/biz/registraBitacoraPagosMasivos_db.bix`
- `Middleware/v2/BusinessServices/PMSV/registraBitacoraPagosMasivosRG/biz/registraBitacoraPagosMasivosRG_db.bix`
- `Middleware/v2/BusinessServices/PMSV/validaAccesoPMS/biz/validaAccesoPMS_db.bix`
- `Middleware/v2/BusinessServices/MTR/cargadorArchivoLote/biz/cargadorArchivoLote.bix`
- `Middleware/v2/BusinessServices/MTR/validaAccesoPMS/biz/validaAccesoPMS.bix`
- `Middleware/v2/BusinessServices/ValidaServicioRegional/biz/ValidaServicioRegional_db.bix`
- `Middleware/Business_Resources/ConsultasCuenta/Resources/consultaCuentasBS.bix`

## Resumen por Tipo de Archivo

| Tipo | Cantidad | Ubicación Principal |
|------|----------|---------------------|
| .proxy | 14 | `Middleware/v2/ProxyServices/` |
| .pipeline | 14 | `Middleware/v2/ProxyServices/` |
| .flow | 1 | `Middleware/v2/BusinessServices/SJS/pagosMasivosInterno/flow/` |
| .bix | 9 | `Middleware/v2/BusinessServices/*/biz/` |
| .jca | 6 | `Middleware/v2/BusinessServices/*/jca/` |
| .wsdl | 12+ | `Middleware/v2/Resources/*/wsdl/`, `Middleware/v2/BusinessServices/*/wsdl/` |
| .xsd | 10+ | `Middleware/v2/Resources/*/xsd/`, `Middleware/v2/BusinessServices/*/xsd/` |
| .xqy | 30+ | `Middleware/v2/Resources/*/xq/`, `Middleware/v2/BusinessServices/*/xq/` |

## Archivos Críticos por Región

### HN01
1. `PagosMasivosInterno.pipeline` (lógica principal)
2. `sjPagosMasivosInterno.flow` (orquestación BPEL)
3. `validaEstructuraLote_db.bix` (validación)
4. `procesaLotePagoMasivo_db.bix` (procesamiento)
5. `registraBitacoraPagosMasivos_db.bix` (auditoría)
6. `agrupaTxnLoteXCuenta.xqy` (agrupación)

### GT01
1. `PagosMasivosInternoGT.pipeline` (lógica principal)
2. `cargadorArchivoLote.bix` (servicio externo)
3. `pagosMasivosInternoGTIn.xqy` (transformación entrada)
4. `pagosMasivosInternoGTOut.xqy` (transformación salida)
5. `registraBitacoraPagosMasivosRG_db.bix` (auditoría)
6. `validaAccesoPMS.bix` (validación acceso)

### PA01
1. `PagosMasivosInternoPA.pipeline` (lógica principal)
2. `cargadorArchivoLote.bix` (servicio externo)
3. `pagosMasivosInternoPAIn.xqy` (transformación entrada)
4. `pagosMasivosInternoPAOut.xqy` (transformación salida)
5. `registraBitacoraPagosMasivosRG_db.bix` (auditoría)
6. `validaAccesoPMS.bix` (validación acceso)

### NI01
1. `PagosMasivosInterno.pipeline` (lógica principal - branch NI01)
2. `cargadorArchivoLote.bix` (servicio externo)
3. `pagosMasivosInternoNIIn.xqy` (transformación entrada)
4. `pagosMasivosInternoNIOut.xqy` (transformación salida)

## Notas

1. Todos los archivos están bajo el proyecto `ficohsacore-vortex-7ebad6e8baaa`
2. La estructura sigue convenciones de OSB 12c
3. Los archivos .bix son definiciones de Business Services en formato XML
4. Los archivos .jca son configuraciones de JCA Adapters para base de datos
5. Los archivos .flow son procesos BPEL
6. Existen múltiples versiones de algunos servicios (v1 en MWHostToHost, v2 en Middleware)
7. La versión activa es v2 (Middleware/v2/)
