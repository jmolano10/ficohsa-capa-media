# Listado de Ficheros - ConsultaActivosCliente

## Proxy Services

### Proxies Principales
| Ruta Relativa | Descripción | Región |
|--------------|-------------|--------|
| `Middleware/v2/ProxyServices/ConsultaActivosCliente.proxy` | Proxy principal con enrutamiento regional | Todas |
| `Middleware/v2/SProxyServices/ConsultaActivosCliente_v2.proxy` | Facade para invocación interna | Todas |
| `Middleware/v2/SProxyServices/ConsultaActivosCliente_v2S.proxy` | Proxy secundario | Todas |
| `Middleware/v2/SProxyServices/ConsultaActivosCliente_v2_Pensiones.proxy` | Especializado para pensiones | HN01 |
| `Middleware/v2/ExternalServices/ConsultaActivosCliente.proxy` | Servicio externo | Todas |
| `Middleware/OperationsAndExecution/PositionManagement/ConsultaActivosCliente.proxy` | Proxy de operaciones | Todas |

## Business Services

### Honduras (HN01)

#### T24 Web Services
| Ruta Relativa | Descripción |
|--------------|-------------|
| `Middleware/v2/BusinessServices/T24/ConsultaCuentaAhorro/biz/ConsultaCuentaAhorro.biz` | Consulta cuentas de ahorro |
| `Middleware/v2/BusinessServices/T24/ConsultaCuentaCorriente/biz/ConsultaCuentaCorriente.biz` | Consulta cuentas corrientes |
| `Middleware/Business_Resources/consultasCliente/Resources/consultasClienteBS.biz` | Consulta cliente y depósitos |

#### OSB 12c - Pensiones
| Ruta Relativa | Descripción |
|--------------|-------------|
| `Middleware/v2/BusinessServices/ConsultaFondoPensiones12c/biz/consultaFondoPensiones12c.biz` | Consulta fondos de pensiones |

#### Split-Join
| Ruta Relativa | Descripción |
|--------------|-------------|
| `Middleware/v2/BusinessServices/SJS/consultaCuentasCliente/biz/sjConsultaCuentasCliente.biz` | Split-Join para consulta consolidada |
| `Middleware/v2/BusinessServices/SJS/consultaActivosCliente/biz/sjConsultaActivosCliente.biz` | Split-Join activos |
| `Middleware/v2/BusinessServices/SJS/consultaActivosCliente/xsd/sjConsultaActivosCliente.xsd` | Esquema Split-Join |
| `Middleware/v2/BusinessServices/SJS/consultaActivosCliente/flow/sjConsultaActivosCliente.flow` | Flow Split-Join |

### Guatemala (GT01)

#### DB Adapters
| Ruta Relativa | Descripción |
|--------------|-------------|
| `Middleware/v2/BusinessServices/ABKGT/consultaListaCuentas/biz/consultaListaCuentas_db.biz` | Consulta cuentas (DB) |
| `Middleware/v2/BusinessServices/ABKGT/consultaListaCuentas/wsdl/consultaListaCuentas_db.wsdl` | WSDL DB Adapter |
| `Middleware/v2/BusinessServices/ABKGT/consultaListaCuentas/jca/consultaListaCuentas_db.jca` | JCA Adapter |
| `Middleware/v2/BusinessServices/ABKGT/consultaListaDepositos/biz/consultaListaDepositosCliente_db.biz` | Consulta depósitos (DB) |

#### Split-Join
| Ruta Relativa | Descripción |
|--------------|-------------|
| `Middleware/v2/BusinessServices/ABKGT/consultaActivosCliente/biz/sjConsultaActivosCliente.biz` | Split-Join GT |
| `Middleware/v2/BusinessServices/ABKGT/consultaActivosCliente/flow/sjConsultaActivosCliente.flow` | Flow Split-Join GT |
| `Middleware/v2/BusinessServices/ABKGT/consultaActivosCliente/wsdl/consultaActivosCliente_db.wsdl` | WSDL Split-Join |

### Panamá (PA01)

#### DB Adapters
| Ruta Relativa | Descripción |
|--------------|-------------|
| `Middleware/v2/BusinessServices/ABKPA/consultaListaCuentas/biz/consultaListaCuentas_db.biz` | Consulta cuentas (DB) |
| `Middleware/v2/BusinessServices/ABKPA/consultaListaCuentas/wsdl/consultaListaCuentas_db.wsdl` | WSDL DB Adapter |
| `Middleware/v2/BusinessServices/ABKPA/consultaListaCuentas/jca/consultaListaCuentas_db.jca` | JCA Adapter |
| `Middleware/v2/BusinessServices/ABKPA/consultaListaDepositos/biz/consultaListaDepositosCliente_db.biz` | Consulta depósitos (DB) |

#### Split-Join
| Ruta Relativa | Descripción |
|--------------|-------------|
| `Middleware/v2/BusinessServices/ABKPA/consultaActivosCliente/biz/sjConsultaActivosCliente.biz` | Split-Join PA |
| `Middleware/v2/BusinessServices/ABKPA/consultaActivosCliente/flow/sjConsultaActivosCliente.flow` | Flow Split-Join PA |
| `Middleware/v2/BusinessServices/ABKPA/consultaActivosCliente/wsdl/consultaActivosCliente_db.wsdl` | WSDL Split-Join |

### Nicaragua (NI01)

#### Web Service Cobis
| Ruta Relativa | Descripción |
|--------------|-------------|
| `Middleware/v2/BusinessServices/CTS/activos/biz/activos.biz` | Servicio Cobis CTS |
| `Middleware/v2/BusinessServices/CTS/activos/xsd/services.xsd` | Esquema Cobis |

### Servicios Compartidos

#### Validación
| Ruta Relativa | Descripción | Región |
|--------------|-------------|--------|
| `Middleware/v2/BusinessServices/ValidaServicioRegional/biz/ValidaServicioRegional_db.biz` | Valida servicio regional | Todas |
| `Middleware/v2/BusinessServices/ValidaFuncionalidadUsuario/biz/ValidaFuncionalidadUsuario_db.biz` | Valida funcionalidad usuario | HN01, GT01, PA01 |

#### Mapeo de Errores
| Ruta Relativa | Descripción | Región |
|--------------|-------------|--------|
| `Middleware/v2/ProxyServices/MapeoErrores.proxy` | Servicio de mapeo de errores | Todas |

#### OSB Internos
| Ruta Relativa | Descripción | Región |
|--------------|-------------|--------|
| `Middleware/v2/BusinessServices/OSB/consultaActivosCliente_v2/biz/consultaActivosCliente.biz` | Business service OSB interno | Todas |
| `Middleware/v2/BusinessServices/OSB/consultaActivosCliente_v2/wsdl/ConsultaActivosCliente_v2.wsdl` | WSDL OSB interno | Todas |
| `Middleware/v2/BusinessServices/OSB/consultaActivosCliente_v2/wsdl/ConsultaActivosCliente_v2_Pensiones.wsdl` | WSDL Pensiones | HN01 |

## XQuery Transformations

### Honduras (HN01)

#### Entrada
| Ruta Relativa | Descripción |
|--------------|-------------|
| `Middleware/v2/Resources/ConsultaCliente/xq/ConsultaClienteFPIn.xq` | Mapeo consulta cliente |
| `Middleware/v2/Resources/ConsultaActivosCliente/xq/consultaActivosAhorrosClienteV2In.xq` | Mapeo ahorros entrada |
| `Middleware/v2/Resources/ConsultaActivosCliente/xq/consultaActivosCorrientesClienteV2In.xq` | Mapeo corrientes entrada |
| `Middleware/v2/Resources/ConsultaActivosCliente/xq/consultaActivosDepositosClienteIn.xq` | Mapeo depósitos entrada |
| `Middleware/v2/Resources/ConsultaActivosCliente/xq/consultaActivosClienteSjIn.xq` | Mapeo Split-Join entrada |
| `Middleware/v2/Resources/ConsultaFondoPensiones/xq/getAssetsCustomerIn.xq` | Mapeo pensiones entrada |
| `Middleware/v2/Resources/ConsultaFondoPensiones/xq/getAssetsCustomerHeaderIn.xq` | Mapeo header pensiones |
| `Middleware/v2/Resources/ConsultaActivosCliente/xq/convertirTipoDocumento.xq` | Conversión tipo documento |
| `Middleware/v2/Resources/ConsultaActivosCliente/xq/consultaFuncionalidadUsuario.xq` | Validación funcionalidad |

#### Salida
| Ruta Relativa | Descripción |
|--------------|-------------|
| `Middleware/v2/Resources/ConsultaActivosCliente/xq/consultaActivosClienteHeaderV2Out.xq` | Mapeo header salida |
| `Middleware/v2/Resources/ConsultaActivosCliente/xq/consultaActivosClienteV2Out.xq` | Mapeo body salida |
| `Middleware/v2/Resources/ConsultaActivosCliente/xq/consultaActivosClienteSjHeaderOut.xq` | Mapeo header Split-Join |
| `Middleware/v2/Resources/ConsultaActivosCliente/xq/consultaActivosClienteSjOut.xq` | Mapeo body Split-Join |
| `Middleware/v2/Resources/ConsultaActivosCliente/xq/consultaActivosClienteHeaderFPCV2Out.xq` | Mapeo header pensiones |

### Guatemala (GT01)

#### Entrada
| Ruta Relativa | Descripción |
|--------------|-------------|
| `Middleware/v2/Resources/ConsultaActivosCliente/xq/sjConsultaActivosClientesGTIn.xq` | Mapeo Split-Join entrada |
| `Middleware/v2/Resources/ConsultaActivosCliente/xq/consultaListaCuentasGTIn.xq` | Mapeo cuentas entrada |
| `Middleware/v2/Resources/ConsultaActivosCliente/xq/consultaListaDepositosGTIn.xq` | Mapeo depósitos entrada |
| `Middleware/v2/BusinessServices/ABKGT/consultaActivosCliente/xq/consultaActivosClienteCtasGTIn.xq` | Mapeo cuentas Split-Join |
| `Middleware/v2/BusinessServices/ABKGT/consultaActivosCliente/xq/consultaActivosClienteDepsGTIn.xq` | Mapeo depósitos Split-Join |

#### Salida
| Ruta Relativa | Descripción |
|--------------|-------------|
| `Middleware/v2/Resources/ConsultaActivosCliente/xq/sjConsultaActivosClienteGTOut.xq` | Mapeo Split-Join salida |
| `Middleware/v2/Resources/ConsultaActivosCliente/xq/sjConsultaActivosClienteGTHdrOut.xq` | Mapeo header Split-Join |
| `Middleware/v2/Resources/ConsultaActivosCliente/xq/consultaListaCuentasGTOut.xq` | Mapeo cuentas salida |
| `Middleware/v2/Resources/ConsultaActivosCliente/xq/consultaListaCuentasGTHeaderOut.xq` | Mapeo header cuentas |
| `Middleware/v2/Resources/ConsultaActivosCliente/xq/consultaListaDepositosGTOut.xq` | Mapeo depósitos salida |
| `Middleware/v2/Resources/ConsultaActivosCliente/xq/consultaListaDepositosGTHeaderOut.xq` | Mapeo header depósitos |
| `Middleware/v2/Resources/ConsultaActivosCliente/xq/consultaActivosClienteGTOut.xq` | Mapeo agregado GT |

### Panamá (PA01)

#### Entrada
| Ruta Relativa | Descripción |
|--------------|-------------|
| `Middleware/v2/Resources/ConsultaActivosCliente/xq/sjConsultaActivosClientesPAIn.xq` | Mapeo Split-Join entrada |
| `Middleware/v2/Resources/ConsultaActivosCliente/xq/consultaListaCuentasPAIn.xq` | Mapeo cuentas entrada |
| `Middleware/v2/Resources/ConsultaActivosCliente/xq/consultaListaDepositosPAIn.xq` | Mapeo depósitos entrada |
| `Middleware/v2/BusinessServices/ABKPA/consultaActivosCliente/xq/consultaActivosClienteCtasPAIn.xq` | Mapeo cuentas Split-Join |
| `Middleware/v2/BusinessServices/ABKPA/consultaActivosCliente/xq/consultaActivosClienteDepsPAIn.xq` | Mapeo depósitos Split-Join |

#### Salida
| Ruta Relativa | Descripción |
|--------------|-------------|
| `Middleware/v2/Resources/ConsultaActivosCliente/xq/sjConsultaActivosClientePAOut.xq` | Mapeo Split-Join salida |
| `Middleware/v2/Resources/ConsultaActivosCliente/xq/sjConsultaActivosClientePAHeaderOut.xq` | Mapeo header Split-Join |
| `Middleware/v2/Resources/ConsultaActivosCliente/xq/consultaListaCuentasPAOut.xq` | Mapeo cuentas salida |
| `Middleware/v2/Resources/ConsultaActivosCliente/xq/consultaListaCuentasPAHeaderOut.xq` | Mapeo header cuentas |
| `Middleware/v2/Resources/ConsultaActivosCliente/xq/consultaListaDepositosPAOut.xq` | Mapeo depósitos salida |
| `Middleware/v2/Resources/ConsultaActivosCliente/xq/consultaListaDepositosPAHeaderOut.xq` | Mapeo header depósitos |
| `Middleware/v2/Resources/ConsultaActivosCliente/xq/consultaActivosClientePAOut.xq` | Mapeo agregado PA |

### Nicaragua (NI01)

#### Entrada
| Ruta Relativa | Descripción |
|--------------|-------------|
| `Middleware/v2/Resources/ConsultaActivosCliente/xq/consultaActivosClienteNIIn.xq` | Mapeo Cobis entrada |

#### Salida
| Ruta Relativa | Descripción |
|--------------|-------------|
| `Middleware/v2/Resources/ConsultaActivosCliente/xq/consultaActivosClienteNIOut.xq` | Mapeo Cobis salida |
| `Middleware/v2/Resources/ConsultaActivosCliente/xq/consultaActivosClienteNIHeaderOut.xq` | Mapeo header Cobis |

### Compartidos

#### Validación y Errores
| Ruta Relativa | Descripción |
|--------------|-------------|
| `Middleware/v2/Resources/Generales/xq/validaServicioRegionalIn.xq` | Mapeo validación regional |
| `Middleware/v2/Resources/Generales/xq/aplicarValoresPorDefectoRegion.xq` | Aplicar valores por defecto |
| `Middleware/v2/Resources/Genericos/mapeoErrorValidate.xq` | Mapeo error validación |
| `Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageIn.xq` | Mapeo errores entrada |
| `Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageOut.xq` | Mapeo errores salida |

#### Otros
| Ruta Relativa | Descripción |
|--------------|-------------|
| `Middleware/v2/BusinessServices/SJS/consultaActivosPasivosCliente/xq/ConsultaActivosClienteHeaderOUT.xq` | Header activos/pasivos |
| `Middleware/v2/BusinessServices/SJS/consultaActivosPasivosCliente/xq/ConsultaActivosClienteOUT.xq` | Body activos/pasivos |
| `Middleware/v2/BusinessServices/SJS/consultaActivosPasivosCliente/xq/ConsultaActivosClienteIN.xq` | Entrada activos/pasivos |

## XSD Schemas

### Principales
| Ruta Relativa | Descripción |
|--------------|-------------|
| `Middleware/Business_Resources/consultasCliente/consultaActivosCliente/sjConsultaActivosCliente.xsd` | Esquema Split-Join principal |
| `Middleware/Business_Resources/consultasCliente/Resources/consultaClientesTypes.xsd` | Tipos de consulta clientes |
| `Middleware/v2/Resources/ConsultaActivosCliente/xsd/consultaClientesTypes.xsd` | Tipos v2 |

### Por Región
| Ruta Relativa | Descripción | Región |
|--------------|-------------|--------|
| `Middleware/v2/BusinessServices/ABKGT/consultaActivosCliente/xsd/consultaActivosCliente_sp.xsd` | Esquema SP GT | GT01 |
| `Middleware/v2/BusinessServices/ABKPA/consultaActivosCliente/xsd/consultaActivosCliente_sp.xsd` | Esquema SP PA | PA01 |
| `Middleware/v2/BusinessServices/CTS/activos/xsd/services.xsd` | Esquema Cobis | NI01 |
| `Middleware/v2/BusinessServices/SJS/consultaActivosCliente/xsd/sjConsultaActivosCliente.xsd` | Esquema Split-Join HN | HN01 |

## WSDL

### Principales
| Ruta Relativa | Descripción |
|--------------|-------------|
| `Middleware/Business_Resources/consultasCliente/consultaActivosCliente/sjConsultaActivosCliente.wsdl` | WSDL Split-Join principal |
| `Middleware/v2/Resources/ConsultaActivosCliente/wsdl/consultaActivosClientePS.wsdl` | WSDL Proxy Service |

### Por Región
| Ruta Relativa | Descripción | Región |
|--------------|-------------|--------|
| `Middleware/v2/BusinessServices/ABKGT/consultaActivosCliente/wsdl/consultaActivosCliente_db.wsdl` | WSDL DB GT | GT01 |
| `Middleware/v2/BusinessServices/ABKPA/consultaActivosCliente/wsdl/consultaActivosCliente_db.wsdl` | WSDL DB PA | PA01 |

## BPEL Flows

| Ruta Relativa | Descripción | Región |
|--------------|-------------|--------|
| `Middleware/Business_Resources/consultasCliente/consultaActivosCliente/sjConsultaActivosCliente.flow` | Flow Split-Join principal | HN01 |
| `Middleware/v2/BusinessServices/ABKGT/consultaActivosCliente/flow/sjConsultaActivosCliente.flow` | Flow Split-Join GT | GT01 |
| `Middleware/v2/BusinessServices/ABKPA/consultaActivosCliente/flow/sjConsultaActivosCliente.flow` | Flow Split-Join PA | PA01 |

## Archivos JAR (Deployments)

### HotFix
| Ruta Relativa | Descripción |
|--------------|-------------|
| `JAR/PG-13516/HotFix/hotfix_mwomnicanal_ConsultaActivosCliente.jar` | HotFix Omnicanal |
| `JAR/PG-13516/HotFix/ConsultaActivosCliente_v2.jar` | HotFix v2 |
| `JAR/PG-13516/HotFix/mwomnicanal_ConsultaActivosCliente.jar` | HotFix MW Omnicanal |

### QA
| Ruta Relativa | Descripción |
|--------------|-------------|
| `JAR/PG-13516/QA/mwomniqa_ConsultaActivosCliente.jar` | QA Omnicanal |
| `JAR/2022.07.3.0/PM-2045/QA/soabus_ConsultaActivosCliente_v2Facade.jar` | QA Facade |
| `JAR/MAN-5332/QA/ConsultaActivosClienteV2.jar` | QA v2 |
| `JAR/TPCRM-2398/QA/ConsultaActivosCliente.jar` | QA CRM |
| `JAR/TPCRM-2398/QA/DMZ/DMZ_ConsultaActivosCliente.jar` | QA DMZ |
| `JAR/TPNCO-1471/QA/ConsultaActivosCliente.jar` | QA NCO |

### PRD
| Ruta Relativa | Descripción |
|--------------|-------------|
| `JAR/PG-13516/PRD/mwomnicanal_ConsultaActivosCliente.jar` | PRD Omnicanal |
| `JAR/2022.07.3.0/PM-2045/PRD/mwApp_ConsultaActivosCliente_v2Facade.jar` | PRD App Facade |
| `JAR/2022.07.3.0/PM-2045/PRD/mwInterbanca_ConsultaActivosCliente_v2Facade.jar` | PRD Interbanca Facade |
| `JAR/MAN-5332/PRD/ConsultaActivosClienteV2.jar` | PRD v2 |
| `JAR/TPCRM-2398/PRD/ConsultaActivosCliente.jar` | PRD CRM |
| `JAR/TPCRM-2398/PRD/DMZ/DMZ_ConsultaActivosCliente.jar` | PRD DMZ |
| `JAR/TPNCO-1471/PROD/ConsultaActivosCliente.jar` | PROD NCO |

## OSB 12c (Honduras)

| Ruta Relativa | Descripción |
|--------------|-------------|
| `CoreBankingHN/RequestorServices/ProxyServices/v1.0/GetCustomerAssets/SplitJoins/ConsultaActivosCliente_SJ.flow` | Split-Join OSB 12c |
| `CoreBankingHN/RequestorServices/ProxyServices/v1.0/GetCustomerAssets/XSD/sjConsultaActivosCliente.xsd` | Esquema OSB 12c |
| `CoreBankingHN/RequestorServices/ProxyServices/v1.0/GetCustomerAssets/WSDL/sjConsultaActivosCliente.wsdl` | WSDL OSB 12c |
| `CoreBankingHN/RequestorServices/ProxyServices/v1.0/GetCustomerAssets/XQ/ConsultaActivosClienteSJOut.xqy` | XQuery salida OSB 12c |
| `CoreBankingHN/RequestorServices/ProxyServices/v1.0/GetCustomerAssets/XQ/ConsultaActivosClienteSJIn.xqy` | XQuery entrada OSB 12c |

## Resumen por Tipo de Archivo

| Tipo | Cantidad Aproximada | Descripción |
|------|---------------------|-------------|
| `.proxy` | 6 | Proxy Services OSB |
| `.biz` | 15+ | Business Services |
| `.xq` / `.xqy` | 40+ | Transformaciones XQuery |
| `.xsd` | 10+ | Esquemas XML |
| `.wsdl` | 8+ | Definiciones WSDL |
| `.flow` | 4 | BPEL Flows (Split-Join) |
| `.jca` | 4+ | JCA Adapters |
| `.jar` | 20+ | Deployments (QA, PRD, HotFix) |

## Notas

1. **Rutas Relativas**: Todas las rutas son relativas a `Fuentes/ficohsacore-osb-7e5cceccb837/`
2. **Archivos JAR**: Representan diferentes versiones y ambientes de deployment
3. **XQuery**: La mayoría de la lógica de transformación está en archivos XQuery
4. **Split-Join**: GT01 y PA01 usan BPEL flows para ejecución paralela
5. **OSB 12c**: Honduras tiene componentes adicionales en OSB 12c para pensiones

---

**Total de Archivos Identificados**: ~100+ archivos relacionados con ConsultaActivosCliente

**Archivos Críticos para Migración**:
- Proxy principal: `ConsultaActivosCliente.proxy`
- XQuery de transformación por región (40+ archivos)
- Business Services por región (15+ archivos)
- Esquemas XSD (10+ archivos)
- BPEL Flows para Split-Join (4 archivos)
