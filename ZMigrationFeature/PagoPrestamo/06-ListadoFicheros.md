# Listado de Ficheros - PagoPrestamo

## 1. Proxy Services

### 1.1. Proxy Principal
- `Middleware/v2/ProxyServices/PagoPrestamo.proxy`

### 1.2. Proxies Dependientes
- `Middleware/v2/ProxyServices/MapeoErrores.proxy`
- `Middleware/v2/ProxyServices/ReversarTransaccion.proxy`

## 2. Business Services

### 2.1. HN01 (Honduras)

#### Base de Datos
- `Middleware/Business_Resources/pagoPrestamo/Resources/pagoPrestamoT24BS.biz`
- `Middleware/Business_Resources/pagoPrestamo/Resources/PagoPrestamoT24/pagoPrestamoT24_db.jca`
- `Middleware/Business_Resources/pagoPrestamo/Resources/PagoPrestamoT24/pagoPrestamoT24.wsdl`
- `Middleware/Business_Resources/pagoPrestamo/Resources/PagoPrestamoT24/xsd/ORA_BANK_OSB_PAG_PRESTAMO_T24.xsd`

#### Servicios SOAP
- `Middleware/v2/BusinessServices/SJS/consultaProductos/biz/sjConsultaProductos.biz`
- `Middleware/Business_Resources/consultaGeneralPrestamo/Resources/consultaGeneralPrestamoBS.biz`
- `Middleware/Business_Resources/general/Resources/ObtenerParametrizacion/ObtenerParametrizacion.biz`
- `Middleware/Business_Resources/Transferencias/Resources/transferenciasBS.biz`
- `Middleware/Business_Resources/Transferencias/Resources/transferencias.wsdl`
- `Middleware/Business_Resources/pagoPrestamo/Resources/DebitoPrestamo/debitoPrestamoBS.biz`
- `Middleware/Business_Resources/pagoPrestamo/Resources/DebitoPrestamo/debitoPrestamo.wsdl`
- `Middleware/Business_Resources/pagoPrestamo/Resources/DepositoCombinado/depositoCombinadoBS.biz`
- `Middleware/Business_Resources/pagoPrestamo/Resources/DepositoCombinado/depositoCombinado.wsdl`
- `Middleware/Business_Resources/ConsultasCuenta/Resources/consultaCuentasBS.biz`
- `Middleware/Business_Resources/consultaGeneralPrestamo/Resources/PrestamosT24BS.biz`

### 2.2. GT01 (Guatemala)
- `Middleware/v2/BusinessServices/ABKGT/pagoPrestamo/biz/PagoPrestamo_db.biz`
- `Middleware/v2/BusinessServices/ABKGT/pagoPrestamo/jca/PagoPrestamo_db.jca`
- `Middleware/v2/BusinessServices/ABKGT/pagoPrestamo/wsdl/PagoPrestamo_db.wsdl`
- `Middleware/v2/BusinessServices/ABKGT/pagoPrestamo/wsdl/PagoPrestamo.wsdl`
- `Middleware/v2/BusinessServices/ABKGT/pagoPrestamo/xsd/PagoPrestamo_sp.xsd`

### 2.3. PA01 (Panamá)
- `Middleware/v2/BusinessServices/ABKPA/pagoPrestamo/biz/pagoPrestamo_db.biz`
- `Middleware/v2/BusinessServices/ABKPA/pagoPrestamo/jca/pagoPrestamo_db.jca`
- `Middleware/v2/BusinessServices/ABKPA/pagoPrestamo/wsdl/pagoPrestamo_db.wsdl`
- `Middleware/v2/BusinessServices/ABKPA/pagoPrestamo/wsdl/pagoPrestamo.wsdl`
- `Middleware/v2/BusinessServices/ABKPA/pagoPrestamo/xsd/pagoPrestamo_sp.xsd`

### 2.4. NI01 (Nicaragua)
- `Middleware/v2/BusinessServices/CTS/prestamo/biz/prestamo.biz`
- `Middleware/v2/BusinessServices/CTS/prestamo/wsdl/COBISCorp.eCOBIS.SrvAplCobisPrestamo.Service.wsdl`
- `Middleware/v2/BusinessServices/CTS/prestamo/xsd/services.xsd`
- `Middleware/v2/BusinessServices/CTS/prestamo/xsd/cobiscorp.ecobis.srvaplcobisentidades.dto.xsd`
- `Middleware/v2/BusinessServices/CTS/prestamo/xsd/commonDTO1.xsd`
- `Middleware/v2/BusinessServices/CTS/prestamo/xsd/commonDTO2.xsd`

### 2.5. Servicios Comunes
- `Middleware/v2/BusinessServices/ValidaServicioRegional/biz/ValidaServicioRegional_db.biz`
- `Middleware/v2/BusinessServices/ValidaServicioRegional/jca/ValidaServicioRegional_db.jca`

## 3. Resources - WSDL y XSD

### 3.1. WSDL Principal
- `Middleware/v2/Resources/PagoPrestamo/wsdl/pagoPrestamoPS.wsdl`

### 3.2. XSD Principal
- `Middleware/v2/Resources/PagoPrestamo/xsd/pagoPrestamoTypes.xsd`

### 3.3. XSD Comunes
- `Middleware/v2/Resources/esquemas_generales/HeaderElements.xsd`

### 3.4. WSDL Business Resources
- `Middleware/Business_Resources/pagoPrestamo/pagoPrestamoPS.wsdl`
- `Middleware/Business_Resources/pagoPrestamo/pagoPrestamoTypes.xsd`

## 4. Transformaciones XQuery

### 4.1. Transformaciones Comunes
- `Middleware/v2/Resources/Generales/xq/validaServicioRegionalIn.xq`
- `Middleware/v2/Resources/Generales/xq/aplicarValoresPorDefectoRegion.xq`
- `Middleware/v2/Resources/Generales/xq/validarCrucePaisEmpresa.xq`
- `Middleware/v2/Resources/Genericos/mapeoErrorValidate.xq`
- `Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageIn.xq`
- `Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageOut.xq`

### 4.2. Transformaciones HN01

#### Validaciones y Utilidades
- `Middleware/Business_Resources/pagoPrestamo/consultaGeneralPrestamo/validarTipoPrestamo.xq`
- `Middleware/Business_Resources/general/UUID/obtenerUUID.xq`
- `Middleware/Business_Resources/general/Parametrizacion/obtenerParametrizacionIn.xq`

#### Consultas
- `Middleware/v2/Resources/PagoPrestamo/xq/pagoPtmoConsProductosIn.xq`
- `Middleware/v2/Resources/PagoPrestamo/xq/consultaDetalleCuentaIn.xq`
- `Middleware/Business_Resources/pagoPrestamo/consultaGeneralPrestamo/consultaGeneralPrestamoIn.xq`

#### Transferencias y Débitos
- `Middleware/v2/Resources/PagoPrestamo/xq/debitoPrestamoCuentaIn.xq`
- `Middleware/v2/Resources/PagoPrestamo/xq/debitoPrestamoCuentaAuthIn.xq`
- `Middleware/v2/Resources/PagoPrestamo/xq/pagoPrestamoAuthIn.xq`

#### Depósitos en Efectivo
- `Middleware/v2/Resources/PagoPrestamo/xq/depositoPrestamoEfectivoLocalIn.xq`
- `Middleware/v2/Resources/PagoPrestamo/xq/depositoPrestamoEfectivoExtranjeraIn.xq`

#### Depósitos con Cheque
- `Middleware/v2/Resources/PagoPrestamo/xq/debitoPrestamoChequeLocalIn.xq`
- `Middleware/v2/Resources/PagoPrestamo/xq/debitoPrestamoChequeExtranjeraIn.xq`

#### Registro de Pago
- `Middleware/v2/Resources/PagoPrestamo/xq/pagoPrestamoIn.xq`
- `Middleware/Business_Resources/pagoPrestamo/pagoPrestamo/pagoPrestamoIn.xq`

#### Pago T24
- `Middleware/v2/Resources/PagoPrestamo/xq/pagoPrestamoT24In.xq`
- `Middleware/v2/Resources/PagoPrestamo/xq/consultaPagoPtmoT24In.xq`
- `Middleware/Business_Resources/pagoPrestamo/pagoPrestamo/pagoPrestamoT24In.xq`

#### Reversión
- `Middleware/Business_Resources/pagoPrestamo/reversarTransaccion/reversarTransaccionIn.xq`

#### Respuestas
- `Middleware/v2/Resources/PagoPrestamo/xq/pagoPrestamoOut.xq`
- `Middleware/Business_Resources/pagoPrestamo/pagoPrestamo/pagoPrestamoOut.xq`
- `Middleware/Business_Resources/pagoPrestamo/pagoPrestamo/pagoPrestamoHeaderOut.xq`
- `Middleware/v2/Resources/PagoPrestamo/xq/pagoPrestamoT24Out.xq`
- `Middleware/v2/Resources/PagoPrestamo/xq/pagoPrestamoT24HeaderOut.xq`
- `Middleware/Business_Resources/pagoPrestamo/pagoPrestamo/pagoPrestamoT24Out.xq`
- `Middleware/Business_Resources/pagoPrestamo/pagoPrestamo/pagoPrestamoT24HeaderOut.xq`

### 4.3. Transformaciones GT01
- `Middleware/v2/Resources/PagoPrestamo/xq/pagoPtmoGTIn.xq`
- `Middleware/v2/Resources/PagoPrestamo/xq/pagoPtmoGTOut.xq`
- `Middleware/v2/Resources/PagoPrestamo/xq/pagoPtmoGTHeaderOut.xq`

### 4.4. Transformaciones PA01
- `Middleware/v2/Resources/PagoPrestamo/xq/pagoPtmoPAIn.xq`
- `Middleware/v2/Resources/PagoPrestamo/xq/pagoPtmoPAOut.xq`
- `Middleware/v2/Resources/PagoPrestamo/xq/pagoPtmoPAHeaderOut.xq`

### 4.5. Transformaciones NI01
- `Middleware/v2/Resources/PagoPrestamo/xq/pagoPrestamoNIIn.xq`
- `Middleware/v2/Resources/PagoPrestamo/xq/pagoPrestamoNIOut.xq`
- `Middleware/v2/Resources/PagoPrestamo/xq/pagoPrestamoNIHeaderOut.xq`

## 5. Configuración y Políticas

### 5.1. Archivos de Configuración
- No se encontraron archivos .properties específicos para PagoPrestamo
- La configuración se obtiene dinámicamente de la base de datos mediante ObtenerParametrizacion

### 5.2. Políticas OSB
- Autenticación: Custom Token Authentication (Username/Password en header)
- Seguridad: HTTPS habilitado
- Monitoreo: Habilitado (nivel Action, intervalo 720 minutos)
- Logging: Habilitado (nivel Debug)
- SLA Alerting: Habilitado (nivel normal)
- Pipeline Alerting: Habilitado (nivel normal)

## 6. Tests

### 6.1. Tests Relevantes
- No se encontraron tests unitarios específicos en el repositorio analizado
- Se recomienda crear tests para:
  - Validación de esquemas
  - Transformaciones XQuery
  - Flujos por región
  - Manejo de errores
  - Reversiones

## 7. Documentación Adicional

### 7.1. Archivos de Documentación Generados
- `ZMigrationFeature/PagoPrestamo/01-ResumenEjecutivo.md`
- `ZMigrationFeature/PagoPrestamo/02-ComparativaRegiones.md`
- `ZMigrationFeature/PagoPrestamo/03-EjemplosYMapeos-HN01.md`
- `ZMigrationFeature/PagoPrestamo/03-EjemplosYMapeos-GT01.md`
- `ZMigrationFeature/PagoPrestamo/03-EjemplosYMapeos-PA01.md`
- `ZMigrationFeature/PagoPrestamo/03-EjemplosYMapeos-NI01.md`
- `ZMigrationFeature/PagoPrestamo/04-Secuencia-HN01.mmd`
- `ZMigrationFeature/PagoPrestamo/04-Secuencia-GT01.mmd`
- `ZMigrationFeature/PagoPrestamo/04-Secuencia-PA01.mmd`
- `ZMigrationFeature/PagoPrestamo/04-Secuencia-NI01.mmd`
- `ZMigrationFeature/PagoPrestamo/05-FlujoMultiregión.mmd`
- `ZMigrationFeature/PagoPrestamo/06-ListadoFicheros.md`

## 8. Dependencias Externas

### 8.1. Bases de Datos

#### HN01
- **Conexión:** eis/DB/ConnectionInterbanca
- **Base de Datos:** ORA_BANK
- **Stored Procedures:**
  - OSB_PAG_PRESTAMO_T24
  - ValidaServicioRegional

#### GT01
- **Conexión:** eis/DB/ConnectionProxyAbanksGT
- **Stored Procedures:**
  - OSB_P_PAGO_PRESTAMO
  - ValidaServicioRegional

#### PA01
- **Conexión:** eis/DB/ConnectionProxyAbanksPA
- **Stored Procedures:**
  - OSB_P_PAGO_PRESTAMO
  - ValidaServicioRegional

### 8.2. Servicios SOAP Externos

#### NI01 - COBIS
- **Endpoint:** http://10.235.53.145:9080/GerenciaProductoPrestamo/SrvAplCobisPrestamoService
- **Protocolo:** SOAP 1.2
- **Operación:** OpPagarPrestamo
- **Namespace:** http://impl.service.srvaplcobisprestamo.ecobis.cobiscorp/

## 9. Archivos de Soporte

### 9.1. XSD de Transferencias
- `Middleware/Business_Resources/Transferencias/Resources/XMLSchema_1840876228.xsd`
- `Middleware/Business_Resources/Transferencias/Resources/XMLSchema_2134279235.xsd`

### 9.2. XSD de Débito Préstamo
- `Middleware/Business_Resources/pagoPrestamo/Resources/DebitoPrestamo/XMLSchema_1612001361.xsd`
- `Middleware/Business_Resources/pagoPrestamo/Resources/DebitoPrestamo/XMLSchema_1905404368.xsd`

### 9.3. XSD de Depósito Combinado
- `Middleware/Business_Resources/pagoPrestamo/Resources/DepositoCombinado/XMLSchema_-126873385.xsd`
- `Middleware/Business_Resources/pagoPrestamo/Resources/DepositoCombinado/XMLSchema_-420276392.xsd`

## 10. Resumen de Conteo

| Categoría | Cantidad |
|-----------|----------|
| Proxy Services | 3 |
| Business Services (HN01) | 11 |
| Business Services (GT01) | 1 |
| Business Services (PA01) | 1 |
| Business Services (NI01) | 1 |
| Business Services (Comunes) | 1 |
| WSDL | 15+ |
| XSD | 20+ |
| XQuery (HN01) | 25+ |
| XQuery (GT01) | 3 |
| XQuery (PA01) | 3 |
| XQuery (NI01) | 3 |
| XQuery (Comunes) | 6 |
| JCA Files | 5 |
| Stored Procedures | 4 |
| Servicios SOAP Externos | 1 |

## 11. Rutas Relativas Verificables

Todas las rutas listadas son relativas al directorio raíz del workspace:
- Base: `ficohsa-capa-media/Fuentes/ficohsacore-osb-7e5cceccb837/`

### Verificación de Existencia
- ✓ Proxy Principal existe
- ✓ Business Services por región existen
- ✓ Transformaciones XQuery existen
- ✓ WSDL y XSD existen
- ✓ Archivos JCA existen

### No Encontrado
- Tests unitarios específicos
- Archivos .properties específicos de PagoPrestamo
- Documentación técnica previa

## 12. Notas Adicionales

1. **Versionamiento:** El servicio está en la versión v2
2. **Service ID:** FICBCO0076
3. **Endpoint Base:** /SMiddleware/OperationsAndExecution/Payments/PagoPrestamo_v2
4. **Protocolo:** SOAP/HTTPS
5. **Autenticación:** Custom Token (Username/Password en header)
6. **Regiones Soportadas:** HN01, GT01, PA01, NI01
7. **Sistemas Core:** T24, ABANKS, COBIS
8. **Tipos de Pago:** ACCOUNT_DEBIT (todas), CASH (HN01), OTHER_BANK_CHEQUE (HN01)
9. **Monitoreo:** Habilitado con agregación de 12 horas
10. **Logging:** Debug level habilitado
