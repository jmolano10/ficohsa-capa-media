# Listado de Ficheros - PagosMasivos

## Proxy Services (Orquestadores)

### Proxy Principal
- `Middleware/v2/ProxyServices/PagosMasivos.proxy`

### Proxies Internos Regionales
- `Middleware/v2/ProxyServices/PagosMasivosInterno.proxy` (HN01, NI01)
- `Middleware/v2/ProxyServices/PagosMasivosInternoGT.proxy` (GT01)
- `Middleware/v2/ProxyServices/PagosMasivosInternoPA.proxy` (PA01)

### Proxies Delegados por Operación
- `Middleware/v2/ProxyServices/CargaProveedores.proxy`
- `Middleware/v2/ProxyServices/AutorizarProveedores.proxy`
- `Middleware/v2/ProxyServices/EliminarProveedores.proxy`
- `Middleware/v2/ProxyServices/ConsultaProveedores.proxy`
- `Middleware/v2/ProxyServices/ConsultaDetalleLote.proxy`
- `Middleware/v2/ProxyServices/ConsultaTransaccionLote.proxy`
- `Middleware/v2/ProxyServices/ConsultaEstadoLote.proxy`
- `Middleware/v2/ProxyServices/CancelarLote.proxy`
- `Middleware/v2/ProxyServices/EditarEstadoRegistroLote.proxy`
- `Middleware/v2/ProxyServices/AutorizarLotePagosMasivos.proxy`
- `Middleware/v2/ProxyServices/CargarArchivoLote.proxy`
- `Middleware/v2/ProxyServices/ConsultaLotesCliente.proxy`

### Proxy de Utilidades
- `Middleware/v2/ProxyServices/MapeoErrores.proxy`

---

## Business Services

### Base de Datos - Validación
- `Middleware/v2/BusinessServices/ValidaServicioRegional/biz/ValidaServicioRegional_db.biz`

### Base de Datos - Bitácora (HN01)
- `Middleware/v2/BusinessServices/PMSV/registraBitacoraPagosMasivos/biz/registraBitacoraPagosMasivos_db.biz`
- `Middleware/v2/BusinessServices/PMSV/registraBitacoraPagosMasivos/jca/registraBitacoraPagosMasivos_db.jca`
- `Middleware/v2/BusinessServices/PMSV/registraBitacoraPagosMasivos/wsdl/registraBitacoraPagosMasivos.wsdl`
- `Middleware/v2/BusinessServices/PMSV/registraBitacoraPagosMasivos/wsdl/registraBitacoraPagosMasivos_db.wsdl`
- `Middleware/v2/BusinessServices/PMSV/registraBitacoraPagosMasivos/xsd/registraBitacoraPagosMasivos_sp.xsd`

### Base de Datos - Bitácora Regional (GT01, PA01)
- `Middleware/v2/BusinessServices/PMSV/registraBitacoraPagosMasivosRG/biz/registraBitacoraPagosMasivosRG_db.biz`
- `Middleware/v2/BusinessServices/PMSV/registraBitacoraPagosMasivosRG/jca/registraBitacoraPagosMasivosRG_db.jca`
- `Middleware/v2/BusinessServices/PMSV/registraBitacoraPagosMasivosRG/wsdl/registraBitacoraPagosMasivosRG.wsdl`
- `Middleware/v2/BusinessServices/PMSV/registraBitacoraPagosMasivosRG/wsdl/registraBitacoraPagosMasivosRG_db.wsdl`
- `Middleware/v2/BusinessServices/PMSV/registraBitacoraPagosMasivosRG/xsd/registraBitacoraPagosMasivosRG_sp.xsd`

### Base de Datos - Validación de Acceso (HN01)
- `Middleware/v2/BusinessServices/PMSV/validaAccesoPMS/biz/validaAccesoPMS_db.biz`

### Base de Datos - Procesamiento de Lotes
- `Middleware/v2/BusinessServices/PMSV/procesaLotePagoMasivo/biz/procesaLotePagoMasivo_db.biz`
- `Middleware/v2/BusinessServices/PMSV/procesaLotePagoMasivo/jca/procesaLotePagoMasivo_db.jca`
- `Middleware/v2/BusinessServices/PMSV/procesaLotePagoMasivo/wsdl/procesaLotePagoMasivo.wsdl`
- `Middleware/v2/BusinessServices/PMSV/procesaLotePagoMasivo/wsdl/procesaLotePagoMasivo_db.wsdl`
- `Middleware/v2/BusinessServices/PMSV/procesaLotePagoMasivo/xsd/procesaLotePagoMasivo_sp.xsd`

### Servicios Java (SJS) - HN01
- `Middleware/v2/BusinessServices/SJS/pagosMasivosInterno/biz/sjPagosMasivosInterno.biz`
- `Middleware/v2/BusinessServices/SJS/pagosMasivosInterno/flow/sjPagosMasivosInterno.flow`
- `Middleware/v2/BusinessServices/SJS/pagosMasivosInterno/wsdl/sjPagosMasivosInterno.wsdl`
- `Middleware/v2/BusinessServices/SJS/pagosMasivosInterno/xsd/sjPagosMasivosInterno.xsd`

#### XQuery del Servicio Java
- `Middleware/v2/BusinessServices/SJS/pagosMasivosInterno/xq/consultaDeSaldoDeCuentaIn.xq`
- `Middleware/v2/BusinessServices/SJS/pagosMasivosInterno/xq/consultaDetalleDeCuentaIn.xq`
- `Middleware/v2/BusinessServices/SJS/pagosMasivosInterno/xq/consultaDetallesCuentaMasivosIn.Xquery`
- `Middleware/v2/BusinessServices/SJS/pagosMasivosInterno/xq/procesaLotePagoMasivoIn.xq`
- `Middleware/v2/BusinessServices/SJS/pagosMasivosInterno/xq/validaEstructuraLoteIn.xq`
- `Middleware/v2/BusinessServices/SJS/pagosMasivosInterno/xq/sjPagosMasivosInternoBacthOut.xq`

### Servicios Web MTR - GT01, PA01, NI01

#### Cargador de Archivos de Lote
- `Middleware/v2/BusinessServices/MTR/cargadorArchivoLote/biz/cargadorArchivoLote.biz`
- `Middleware/v2/BusinessServices/MTR/cargadorArchivoLote/wsdl/cargadorArchivoLoteEndpoint.wsdl`

#### Validación de Acceso MTR
- `Middleware/v2/BusinessServices/MTR/validaAccesoPMS/biz/validaAccesoPMS.biz`

### Servicios OSB
- `Middleware/v2/BusinessServices/OSB/RegistraPagosMasivos/biz/achTransfer.biz`
- `Middleware/v2/BusinessServices/OSB/RegistraPagosMasivos/wsdl/AchTransfer_1.wsdl`
- `Middleware/v2/BusinessServices/OSB/RegistraPagosMasivos/xsd/AchTransfer.xsd`
- `Middleware/v2/BusinessServices/OSB/RegistraPagosMasivos/xsd/AchTransfer_1.xsd`

### Servicios TENGO (Billetera)
- `Middleware/v2/BusinessServices/TENGO/PagoMasivoBilletera/biz/PagoMasivoBilletera.biz`
- `Middleware/v2/BusinessServices/TENGO/PagoMasivoBilletera/wsdl/Services.wsdl`
- `Middleware/v2/BusinessServices/TENGO/PagoMasivoBilletera/xsd/Services.xsd`
- `Middleware/v2/BusinessServices/TENGO/PagoMasivoBilleteraPuente/biz/PagoMasivoBilleteraPuente.biz`
- `Middleware/v2/BusinessServices/TENGO/PagoMasivoBilleteraPuente/wsdl/PagosMasivosBilletera_1.wsdl`
- `Middleware/v2/BusinessServices/TENGO/PagoMasivoBilleteraPuente/xsd/PagosMasivosBilletera.xsd`
- `Middleware/v2/BusinessServices/TENGO/PagoMasivoBilleteraPuente/xsd/PagosMasivosBilletera_1.xsd`

---

## Resources - WSDL y XSD

### WSDL Principal
- `Middleware/v2/Resources/PagosMasivos/wsdl/pagosMasivosPS.wsdl`

### XSD Principal
- `Middleware/v2/Resources/PagosMasivos/xsd/pagosMasivosTypes.xsd`

### WSDL Interno
- `Middleware/v2/Resources/PagosMasivosInterno/wsdl/pagosMasivosInternoPS.wsdl`

### WSDL Autorizar Lote
- `Middleware/v2/Resources/AutorizarLotePagosMasivos/wsdl/autorizarLotePS.wsdl`

### WSDL Billetera
- `Middleware/v2/Resources/PagosMasivosBilletera/wsdl/pagosMasivosBilleteraPS.wsdl`
- `Middleware/v2/Resources/PagosMasivosBilletera/xsd/pagosMasivosBilleteraTypes.xsd`

### WSDL Billetera Puente
- `Middleware/v2/Resources/PagosMasivosBilleteraPuente/wsdl/pagosMasivosBilleteraPuentePS.wsdl`
- `Middleware/v2/Resources/PagosMasivosBilleteraPuente/xsd/pagosMasivosBilleteraPuenteTypes.xsd`

---

## Transformaciones XQuery

### Transformaciones Generales
- `Middleware/v2/Resources/Generales/xq/validaServicioRegionalIn.xq`
- `Middleware/v2/Resources/Generales/xq/aplicarValoresPorDefectoRegion.xq`

### Transformaciones Mapeo de Errores
- `Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageIn.xq`
- `Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageOut.xq`

### Transformaciones PagosMasivos (Validación)
- `Middleware/v2/Resources/PagosMasivos/xq/validarAccesoPMSIn.xq`
- `Middleware/v2/Resources/PagosMasivos/xq/validarAccesoPMSRGIn.xq`

### Transformaciones PagosMasivosInterno - HN01
- `Middleware/v2/Resources/PagosMasivosInterno/xq/sjPagosMasivosInternoIn.xq`
- `Middleware/v2/Resources/PagosMasivosInterno/xq/pagosMasivosInternoOut.xq`
- `Middleware/v2/Resources/PagosMasivosInterno/xq/registrarBitacoraPagosMasivosIn.xq`
- `Middleware/v2/Resources/PagosMasivosInterno/xq/validarAccesoPMSIn.xq`

### Transformaciones PagosMasivosInterno - GT01
- `Middleware/v2/Resources/PagosMasivosInterno/xq/pagosMasivosInternoGTIn.xq`
- `Middleware/v2/Resources/PagosMasivosInterno/xq/pagosMasivosInternoGTOut.xq`
- `Middleware/v2/Resources/PagosMasivosInterno/xq/pagosMasivosInternoGTHeaderOut.xq`
- `Middleware/v2/Resources/PagosMasivosInterno/xq/registrarBitacoraPagosMasivosRGIn.xq`

### Transformaciones PagosMasivosInterno - PA01
- `Middleware/v2/Resources/PagosMasivosInterno/xq/pagosMasivosInternoPAIn.xq`
- `Middleware/v2/Resources/PagosMasivosInterno/xq/pagosMasivosInternoPAOut.xq`
- `Middleware/v2/Resources/PagosMasivosInterno/xq/pagosMasivosInternoPAHeaderOut.xq`

### Transformaciones PagosMasivosInterno - NI01
- `Middleware/v2/Resources/PagosMasivosInterno/xq/pagosMasivosInternoNIIn.xq`
- `Middleware/v2/Resources/PagosMasivosInterno/xq/pagosMasivosInternoNIOut.xq`
- `Middleware/v2/Resources/PagosMasivosInterno/xq/pagosMasivosInternoNIHeaderOut.xq`

### Transformaciones Utilidades
- `Middleware/v2/Resources/PagosMasivosInterno/xq/agrupaTxnLoteXCuenta.xq`

### Transformaciones AutorizarLote
- `Middleware/v2/Resources/AutorizarLotePagosMasivos/xq/autorizarLoteHNIn.xq`
- `Middleware/v2/Resources/AutorizarLotePagosMasivos/xq/autorizarLoteHNOut.xq`
- `Middleware/v2/Resources/AutorizarLotePagosMasivos/xq/autorizarLoteHNHeaderOut.xq`
- `Middleware/v2/Resources/AutorizarLotePagosMasivos/xq/autorizarLoteGTIn.xq`
- `Middleware/v2/Resources/AutorizarLotePagosMasivos/xq/autorizarLoteGTOut.xq`
- `Middleware/v2/Resources/AutorizarLotePagosMasivos/xq/autorizarLoteGTHeaderOut.xq`
- `Middleware/v2/Resources/AutorizarLotePagosMasivos/xq/autorizarLotePAIn.xq`
- `Middleware/v2/Resources/AutorizarLotePagosMasivos/xq/autorizarLotePAOut.xq`
- `Middleware/v2/Resources/AutorizarLotePagosMasivos/xq/autorizarLotePAHeaderOut.xq`
- `Middleware/v2/Resources/AutorizarLotePagosMasivos/xq/autorizarLoteNIIn.xq`
- `Middleware/v2/Resources/AutorizarLotePagosMasivos/xq/autorizarLoteNIOut.xq`
- `Middleware/v2/Resources/AutorizarLotePagosMasivos/xq/autorizarLoteNIHeaderOut.xq`

### Transformaciones Billetera Puente
- `Middleware/v2/Resources/PagosMasivosBilleteraPuente/xq/PagosMasivosBilleteraPuenteHeaderIn.xq`
- `Middleware/v2/Resources/PagosMasivosBilleteraPuente/xq/cargaLoteBilleteraPuenteIn.xq`
- `Middleware/v2/Resources/PagosMasivosBilleteraPuente/xq/cargaLoteBilleteraPuenteOut.xq`
- `Middleware/v2/Resources/PagosMasivosBilleteraPuente/xq/consultaDetalleLoteBilleteraPuenteIn.xq`
- `Middleware/v2/Resources/PagosMasivosBilleteraPuente/xq/consultaDetalleLoteBilleteraPuenteOut.xq`
- `Middleware/v2/Resources/PagosMasivosBilleteraPuente/xq/consultaEstadoLoteBilleteraPuenteIn.xq`
- `Middleware/v2/Resources/PagosMasivosBilleteraPuente/xq/consultaEstadoLoteBilleteraPuenteOut.xq`
- `Middleware/v2/Resources/PagosMasivosBilleteraPuente/xq/generaTokenBilleteraPuenteIn.xq`
- `Middleware/v2/Resources/PagosMasivosBilleteraPuente/xq/generaTokenBilleteraPuenteOut.xq`
- `Middleware/v2/Resources/PagosMasivosBilleteraPuente/xq/validaLoteBilleteraPuenteIn.xq`
- `Middleware/v2/Resources/PagosMasivosBilleteraPuente/xq/validaLoteBilleteraPuenteOut.xq`

---

## Recursos Generales

### UUID Generator
- `Middleware/Business_Resources/general/UUID/obtenerUUID.xq`

### Esquemas Generales
- `Middleware/v2/esquemas_generales/HeaderElements.xsd`
- `Middleware/v2/esquemas_generales/PagingTypes.xsd`

---

## Archivos JAR (Deployments)

### Producción (PRD)
- `JAR/2018.12.1.0/PRD/PG-130_PagosMasivosHN_MWHostToHost_PG-130.jar`
- `JAR/2018.12.1.0/PRD/PG-130_PagosMasivosHN_mwapp.jar`
- `JAR/2018.12.1.0/PRD/PG-130_PagosMasivosHN_mwinterbanca.jar`
- `JAR/2018.12.1.0/PRD/PG-130_PagosMasivosHN_mwomnicanal.jar`
- `JAR/2018.12.1.0/PRD/PG-130_PagosMasivosHN_mwpmsv.jar`
- `JAR/2018.5.2.0/PRD/MAN-2_PagosMasivos_mwapp.jar`
- `JAR/2018.5.2.0/PRD/MAN-2_PagosMasivos_mwinterbanca.jar`
- `JAR/2018.5.2.0/PRD/MAN-2_PagosMasivos_mwomnicanal.jar`
- `JAR/2018.5.2.0/PRD/MAN-2_PagosMasivos_mwpmsv.jar`
- `JAR/2018.5.2.0/PRD/MDA-991_PagosMasivos.jar`
- `JAR/2019.4.1.0/PRD/PG-313_PagosMasivos_GT_PA.jar`
- `JAR/2021.1.1.0/PP-1003/PagosMasivosBilletera.jar`
- `JAR/2021.1.1.0/PP-1003/PagosMasivosBilleteraPuente.jar`
- `JAR/2021.1.1.0/PG-3633/PRD/mwapp_PagosMasivos.jar`
- `JAR/2021.1.1.0/PG-3633/PRD/mwinterbanca_PagosMasivos.jar`
- `JAR/2021.1.1.0/PG-3633/PRD/mwomnicanal_PagosMasivos.jar`
- `JAR/2022.09.2.0/PM-7104/PRD/PagosMasivosInterno.jar`
- `JAR/MAN-5545/PRD/mwapp_PagosMasivosInterno.jar`
- `JAR/MAN-5545/PRD/mwinterbanca_PagosMasivosInterno.jar`
- `JAR/MAN-5545/PRD/mwmasivos_PagosMasivosInterno.jar`
- `JAR/MAN-5545/PRD/mwomnicanal_PagosMasivosInterno.jar`
- `JAR/PG-13979/PRD/mwOmnicanal_RegistraPagosMasivos.jar`

### QA
- `JAR/2018.12.1.0/QA/PG-130_PagosMasivosHN_MWHostToHost_PG-130.jar`
- `JAR/2018.12.1.0/QA/PG-130_PagosMasivosHN_mwomniqa.jar`
- `JAR/2018.12.1.0/QA/PG-130_PagosMasivosHN_mwomniqa2.jar`
- `JAR/2018.12.1.0/QA/PG-130_PagosMasivosHN_soabus.jar`
- `JAR/2018.12.1.0/QA/PG-130_PagosMasivosHN_soabus2.jar`
- `JAR/2018.5.2.0/QA/MAN-2_PagosMasivos_mwomniqa.jar`
- `JAR/2018.5.2.0/QA/MAN-2_PagosMasivos_soabus.jar`
- `JAR/2018.5.2.0/QA/MDA-991_PagosMasivos.jar`
- `JAR/2019.4.1.0/QA/PG-313_PagosMasivos_GT_PA.jar`
- `JAR/2021.1.1.0/PG-3633/QA/mwomniqa_PagosMasivos.jar`
- `JAR/2021.1.1.0/PG-3633/QA/mwsoabus_PagosMasivos.jar`
- `JAR/2022.09.2.0/PM-7104/QA/PagosMasivosInterno.jar`
- `JAR/MAN-5545/QA/mwomniqa_PagosMasivosInterno.jar`
- `JAR/MAN-5545/QA/mwsoabus_PagosMasivosInterno.jar`
- `JAR/PG-13979/QA/mwOmniqa_RegistraPagosMasivos.jar`

### Archivos XML de Configuración
- `JAR/2021.1.1.0/PP-1003/PRD/PagosMasivosBilleteraPuente.xml`
- `JAR/2021.1.1.0/PP-1003/PRD/PagosMasivoBilleteraBiz.xml`
- `JAR/2021.1.1.0/PP-1003/QA/PagosMasivosBilleteraPuente.xml`
- `JAR/2021.1.1.0/PP-1003/QA/PagosMasivoBilleteraBiz.xml`

---

## Archivos de Versión Anterior (MWHostToHost v1)

### Proxy v1
- `MWHostToHost/v1/ProxyServices/PagosMasivos.proxy`

### Resources v1
- `MWHostToHost/v1/Resources/PagosMasivos/wsdl/pagosMasivosPS.wsdl`
- `MWHostToHost/v1/Resources/PagosMasivos/xsd/pagosMasivosTypes.xsd`

### XQuery v1
- `MWHostToHost/v1/Resources/PagosMasivos/xq/consultaDetalleLoteIn.xq`
- `MWHostToHost/v1/Resources/PagosMasivos/xq/consultaDetalleLoteOut.xq`
- `MWHostToHost/v1/Resources/PagosMasivos/xq/consultaLotesClienteIn.xq`
- `MWHostToHost/v1/Resources/PagosMasivos/xq/consultaLotesClienteOut.xq`
- `MWHostToHost/v1/Resources/PagosMasivos/xq/consultaTransaccionLoteIn.xq`
- `MWHostToHost/v1/Resources/PagosMasivos/xq/consultaTransaccionLoteOut.xq`
- `MWHostToHost/v1/Resources/PagosMasivos/xq/pagosMasivosInternoIn.xq`
- `MWHostToHost/v1/Resources/PagosMasivos/xq/pagosMasivosInternoOut.xq`

---

## Archivos de Configuración y Propiedades

No se encontraron archivos .properties explícitos en el análisis del código fuente. Las configuraciones están embebidas en los archivos .proxy y .biz.

---

## Tests Relevantes

No se detectaron archivos de test en la estructura analizada. Se recomienda:
- Crear tests unitarios para transformaciones XQuery
- Crear tests de integración para flujos completos
- Crear tests de contrato para WSDL

---

## Resumen de Conteo

| Tipo de Archivo | Cantidad |
|-----------------|----------|
| Proxy Services | 16 |
| Business Services | ~40 |
| WSDL | 15 |
| XSD | 12 |
| XQuery | 60+ |
| JAR (PRD) | 20 |
| JAR (QA) | 15 |
| **TOTAL** | **~178 archivos** |

---

## Archivos Críticos para Migración

### Prioridad 1 (Críticos)
1. `Middleware/v2/ProxyServices/PagosMasivos.proxy`
2. `Middleware/v2/ProxyServices/PagosMasivosInterno.proxy`
3. `Middleware/v2/ProxyServices/PagosMasivosInternoGT.proxy`
4. `Middleware/v2/ProxyServices/PagosMasivosInternoPA.proxy`
5. `Middleware/v2/Resources/PagosMasivos/wsdl/pagosMasivosPS.wsdl`
6. `Middleware/v2/Resources/PagosMasivos/xsd/pagosMasivosTypes.xsd`

### Prioridad 2 (Importantes)
7. Todas las transformaciones XQuery de PagosMasivosInterno
8. Business Services de base de datos (bitácora y validación)
9. Servicio Java sjPagosMasivosInterno
10. Servicios MTR (cargadorArchivoLote, validaAccesoPMS)

### Prioridad 3 (Secundarios)
11. Proxies delegados por operación
12. Transformaciones de AutorizarLote
13. Servicios de Billetera
14. Archivos JAR de deployment

---

## Notas Adicionales

- **Versiones:** Existen 2 versiones (v1 en MWHostToHost, v2 en Middleware)
- **Ambientes:** Archivos separados para PRD y QA
- **Regiones:** Archivos específicos por región (HN, GT, PA, NI)
- **Dependencias:** Alto acoplamiento entre componentes
- **Documentación:** No se encontró documentación técnica adicional
