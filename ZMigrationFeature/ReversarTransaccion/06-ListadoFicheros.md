# Listado de Ficheros - ReversarTransaccion

## Proxy Services

### Principales
- `MiddlewareCaja/ProxyServices/ReversarTransaccion.proxy`
- `Middleware/OperationsAndExecution/CustomerDeposits/ReversarTransaccion.proxy`
- `Middleware/v2/ProxyServices/ReversarTransaccion.proxy`
- `Middleware/v2/ProxyServices/ReversarTransaccionID.proxy`

### Regionales
- `MWCaja/v1/ProxyServices/TransactionReversal/TransactionReversalGT.proxy`

## Business Services

### Servicios de Reversión T24
- `Middleware/Business_Resources/ReversarTransaccion/Resources/ReverseTransaccionBS.biz`
- `MiddlewareCaja/BussinessServices/ReversaTransaccion.biz`
- `MiddlewareCaja/BussinessServices/ReversaTransaccion2.biz`
- `Middleware/Business_Resources/ReversaTransaccion/Resources/ReversaTransaccion.biz`

### Servicios Core Banking
- `Middleware/v2/BusinessServices/TransaccionesAsincronas/T24/svcReversarTransaccionCB/biz/svcReversarTransaccionCB.biz`
- `Middleware/v3/BusinessServices/PAGOSWSTC/registrarReversionTCCB/biz/registrarReversionTCCB_db.biz`
- `Middleware/v3/BusinessServices/MasterData/conReversionPagoTCRG/biz/conReversarPagoTCRG_db.biz`

### Servicios de Base de Datos
- `Middleware/v2/BusinessServices/TransaccionesAsincronas/DB/ValidarEstadoTransaccion/biz/validarEstadoTransaccion_db.biz`
- `Middleware/v2/BusinessServices/TransaccionesAsincronas/DB/ActualizarEstadoTransaccionConsulta/biz/actualizarEstadoTransaccionUUID_db.biz`
- `Middleware/v2/BusinessServices/TransaccionesGenericasCB/ActualizarTransaccionGenericaCB/biz/actualizarTransaccionGenCB_db.biz`
- `MiddlewareCaja/BussinessServices/reversionRecaudoAbanks_v2_db.biz`

### Servicios de Validación
- `Middleware/v2/BusinessServices/ValidaServicioRegional/biz/ValidaServicioRegional_db.biz`
- `Middleware/v2/BusinessServices/MDW/consultaRutaRegional/biz/consultaRutaRegional_db.biz`

## WSDL Files

### Proxy Services WSDL
- `MiddlewareCaja/Resources/wsdls/ReversarTransaccion.wsdl`
- `Middleware/v2/Resources/ReversarTransaccion/wsdl/ReversarTransaccionPS.wsdl`
- `Middleware/v2/Resources/ReversarTransaccionID/wsdl/reversarTransaccionIDPS.wsdl`
- `Middleware/Business_Resources/ReversarTransaccion/ReversarTransaccion/ReversarTransaccionPS.wsdl`

### Business Services WSDL
- `Middleware/Business_Resources/ReversarTransaccion/Resources/ReverseTransacccion.wsdl`
- `MiddlewareCaja/Resources/wsdls/ReversaTransaccion.wsdl`
- `MiddlewareCaja/Resources/wsdls/ReversaTransaccion2.wsdl`
- `Middleware/v2/Resources/ReversaTransaccion/wsdl/ReversaTransaccion.wsdl`

### T24 Services WSDL
- `Middleware/v2/BusinessServices/TransaccionesAsincronas/T24/svcReversarTransaccionCB/wsdl/services_1.wsdl`
- `Middleware/v2/BusinessServices/T24/svcRegistraTransaccionTengo/wsdl/svcRegistraTransaccionTengo.wsdl`

### Database Services WSDL
- `Middleware/v2/BusinessServices/TransaccionesAsincronas/DB/ValidarEstadoTransaccion/wsdl/validarEstadoTransaccion_db.wsdl`
- `Middleware/v2/BusinessServices/TransaccionesAsincronas/DB/ActualizarEstadoTransaccionConsulta/wsdl/actualizarEstadoTransaccionUUID_db.wsdl`

## XQuery Files

### Transformaciones de Entrada (Request)
- `Middleware/v2/Resources/ReversarTransaccion/xq/reversarTransaccionFTIn.xq`
- `Middleware/v2/Resources/ReversarTransaccion/xq/reversarTransaccionTTIn.xq`
- `Middleware/v2/Resources/ReversarTransaccion/xq/reversarTransaccionPagoChequeIn.xq`
- `Middleware/v2/Resources/ReversarTransaccion/xq/reversarTransaccionPagoRecaudoIn.xq`
- `Middleware/v2/Resources/ReversarTransaccion/xq/reversarTransaccionPagooRetiroTCIn.xq`

### Transformaciones de Autorización
- `Middleware/v2/Resources/ReversarTransaccion/xq/AutorizarReversionFTIn.xq`
- `Middleware/v2/Resources/ReversarTransaccion/xq/AutorizarReversionTTIn.xq`
- `Middleware/v2/Resources/ReversarTransaccion/xq/AutorizarReversionPagoRecaudoIn.xq`
- `Middleware/v2/Resources/ReversarTransaccion/xq/AutorizarReversionPagooRetiroTCIn.xq`

### Transformaciones MiddlewareCaja
- `MiddlewareCaja/Resources/xqueries/ReversarTransaccion/ReversarTransaccionFTIn.xq`
- `MiddlewareCaja/Resources/xqueries/ReversarTransaccion/ReversarTransaccionTTIn.xq`
- `MiddlewareCaja/Resources/xqueries/ReversarTransaccion/ReversarTransaccionPagoChequeIn.xq`
- `MiddlewareCaja/Resources/xqueries/ReversarTransaccion/ReversarTransaccionPagooRetiroTCIn.xq`
- `MiddlewareCaja/Resources/xqueries/ReversarTransaccion/AutorizarReversionFTIn.xq`
- `MiddlewareCaja/Resources/xqueries/ReversarTransaccion/AutorizarReversionTTIn.xq`
- `MiddlewareCaja/Resources/xqueries/ReversarTransaccion/AutorizarReversionPagooRetiroTCIn.xq`

### Transformaciones de Recaudos
- `MiddlewareCaja/Resources/xqueries/ReversarTransaccion/ReversarTransaccionPagoRecaudoRefEfectIn.xq`
- `MiddlewareCaja/Resources/xqueries/ReversarTransaccion/ReversarTransaccionPagoRecaudoRefDebCtaIn.xq`
- `MiddlewareCaja/Resources/xqueries/ReversarTransaccion/ReversarTransaccionPagoRecaudoRefFicoChqIn.xq`
- `MiddlewareCaja/Resources/xqueries/ReversarTransaccion/ReversarTransaccionPagoRecaudoRefOBChqIn.xq`
- `MiddlewareCaja/Resources/xqueries/ReversarTransaccion/ReversarTransaccionPagoRecaudoRefIntChqIn.xq`

### Transformaciones de Salida (Response)
- `MiddlewareCaja/Resources/xqueries/ReversarTransaccion/ReversarTransaccionFTHeaderOut.xq`
- `MiddlewareCaja/Resources/xqueries/ReversarTransaccion/ReversarTransaccionTTHeaderOut.xq`
- `MiddlewareCaja/Resources/xqueries/ReversarTransaccion/ReversarTransaccionPagoChequeHeaderOut.xq`
- `MiddlewareCaja/Resources/xqueries/ReversarTransaccion/ReversarTransaccionPagooRetiroTCHeaderOut.xq`

### Transformaciones ReversarTransaccionID
- `Middleware/v2/Resources/ReversarTransaccionID/xq/obtenerTipoGenIn.xq`
- `Middleware/v2/Resources/ReversarTransaccionID/xq/consultaEstadoTransaccionRevIn.xq`
- `Middleware/v2/Resources/ReversarTransaccionID/xq/registrarReversionTCID.xq`
- `Middleware/v2/Resources/ReversarTransaccionID/xq/registrarReversionTCMDIDIn.xq`
- `Middleware/v2/Resources/ReversarTransaccionID/xq/reversarTRXPagoTCCB.xq`
- `Middleware/v2/Resources/ReversarTransaccionID/xq/reversarTRXDepositoCB.xq`
- `Middleware/v2/Resources/ReversarTransaccionID/xq/reversarTrxGenericaT24.xq`
- `Middleware/v2/Resources/ReversarTransaccionID/xq/actualizarTransaccionReversion.xq`
- `Middleware/v2/Resources/ReversarTransaccionID/xq/actualizarTrxGenReversaIn.xq`

### Transformaciones Abanks
- `MiddlewareCaja/Resources/xqueries/ReversarTransaccion/v2/ReversarTransaccionAbanksIn.xq`
- `MiddlewareCaja/Resources/xqueries/ReversarTransaccion/v2/EliminacionRevRecRefFTIn.xq`
- `MiddlewareCaja/Resources/xqueries/ReversarTransaccion/v2/EliminacionRevRecRefTTIn.xq`

### Transformaciones ReversaTransaccion
- `Middleware/v2/Resources/ReversaTransaccion/xq/registrarReversionTCCB.xq`
- `Middleware/v2/Resources/ReversaTransaccion/xq/registrarReversionTCMDIDIn.xq`

## XSD Files

### Esquemas Principales
- `MiddlewareCaja/Resources/xsds/ReversarTransaccion/ReversarTransaccion.xsd`
- `Middleware/Business_Resources/ReversarTransaccion/ReversarTransaccion/reversarTransaccionTypes.xsd`
- `Middleware/v2/Resources/ReversarTransaccionID/xsd/reversarTransaccionIDTypes.xsd`

### Esquemas de Business Services
- `Middleware/Business_Resources/ReversarTransaccion/Resources/XMLSchema_-193201527.xsd`
- `Middleware/Business_Resources/ReversarTransaccion/Resources/XMLSchema_100201480.xsd`

### Esquemas de Base de Datos
- `Middleware/v2/BusinessServices/TransaccionesAsincronas/T24/svcReversarTransaccionCB/xsd/services.xsd`
- `Middleware/v2/BusinessServices/TransaccionesAsincronas/T24/svcReversarTransaccionCB/xsd/services_1.xsd`

### Esquemas Abanks
- `MiddlewareCaja/Resources/xsds/ReversaTransaccion/ReversionRecaudoAbanks/ORA_BANK_OSB_K_INTEGRACION_CONVENIOS_REVERSION_COBRANZA_ABANKS.xsd`
- `MiddlewareCaja/Resources/xsds/ReversaTransaccion/ReversionRecaudoAbanks/v2/reversionRecaudoAbanks_v2_sp.xsd`

## JCA Files (Database Adapters)

### Adaptadores de Base de Datos
- `Middleware/v2/BusinessServices/TransaccionesAsincronas/DB/ValidarEstadoTransaccion/jca/validarEstadoTransaccion_db.jca`
- `Middleware/v2/BusinessServices/TransaccionesAsincronas/DB/ActualizarEstadoTransaccionConsulta/jca/actualizarEstadoTransaccionUUID_db.jca`
- `Middleware/v2/BusinessServices/TransaccionesGenericasCB/RegistrarTransaccionGenericaCB/jca/registrarTransaccionGenCB_db.jca`
- `Middleware/v3/BusinessServices/PAGOSWSTC/registrarReversionTCCB/jca/registrarReversionTCCB_db.jca`

## JAR Files (Deployments)

### Producción
- `JAR/MDA-54192/PRD/MWOMNICANAL/HN/ReversarTransaccion.jar`
- `JAR/MDA-54192/PRD/MWAPP-MWINTERBANCA/HN/ReversarTransaccionID.jar`
- `JAR/MDA-58323/PRD/MWAPP/mwapp_ReversarTransaccionID.jar`
- `JAR/MDA-58323/PRD/MWINTERBANCA/mwinterbanca_ReversarTransaccionID.jar`

### QA
- `JAR/MDA-54192/QA/MWOMNIQA/HN/ReversarTransaccion.jar`
- `JAR/MDA-54192/QA/SOABUS/HN/ReversarTransaccionID.jar`
- `JAR/MDA-58323/QA/soabus_ReversarTransaccionID.jar`

### HotFix
- `JAR/HotFix/MDA-54192/PRD/OMNICANAL/ReversarTransaccion.jar`
- `JAR/HotFix/MDA-54192/PRD2/MWAPP-MWINTERBANCA/ReversarTransaccionID.jar`
- `JAR/HotFix/MDA-58323_HF02/HF_02_procesarTransaccionesGenericasT24IN.jar`
- `JAR/HotFix/MDA-58323_HF03/HF03_ProcesarTransaccionGenericaCB.jar`

## Archivos de Configuración

### Properties y Configuración
- No se encontraron archivos .properties específicos para ReversarTransaccion
- Configuración embebida en los archivos .proxy y .biz

### Políticas OSB
- Políticas de seguridad embebidas en los proxy services
- Custom token authentication configurado en v2 proxies
- WS-Policy attachments configurados

## Archivos de Pruebas

### Tests Relevantes
- No se encontraron archivos de test específicos en la estructura analizada
- Tests probablemente ubicados en repositorios separados o en carpetas no incluidas

## Archivos de Documentación

### Documentación Técnica
- `leeme.txt` (archivo general del proyecto)
- Documentación embebida en comentarios de XQuery y WSDL

## Resumen de Conteo

- **Proxy Services**: 4 archivos principales
- **Business Services**: 15+ archivos .biz
- **WSDL Files**: 20+ archivos
- **XQuery Files**: 50+ archivos de transformación
- **XSD Files**: 15+ esquemas
- **JCA Files**: 10+ adaptadores de BD
- **JAR Files**: 20+ deployments
- **Total aproximado**: 150+ archivos relacionados con ReversarTransaccion