# Listado de Ficheros - ReversarTransaccionID

## Proxies (Proxy Services)

| Archivo | Ruta Relativa | Descripción |
|---------|---------------|-------------|
| ReversarTransaccionID.proxy | Middleware/v2/ProxyServices/ReversarTransaccionID.proxy | Proxy service principal para reversión de transacciones |

## Business Services

### Servicios de Base de Datos
| Archivo | Ruta Relativa | Descripción |
|---------|---------------|-------------|
| consultaRutaRegional_db.biz | Middleware/v2/BusinessServices/MDW/consultaRutaRegional/biz/consultaRutaRegional_db.biz | Consulta configuración regional |
| consultaRutaRegional_db.jca | Middleware/v2/BusinessServices/MDW/consultaRutaRegional/jca/consultaRutaRegional_db.jca | Configuración JCA para consulta regional |
| consultaRutaRegional_db.wsdl | Middleware/v2/BusinessServices/MDW/consultaRutaRegional/wsdl/consultaRutaRegional_db.wsdl | WSDL para consulta regional |
| obtenerTipoTrxGen_db.biz | Middleware/v2/BusinessServices/TransaccionesGenericasCB/ObtenerTipoTrxGen/biz/obtenerTipoTrxGen_db.biz | Obtiene tipo de transacción genérica |
| validarEstadoTransaccion_db.biz | Middleware/v2/BusinessServices/TransaccionesAsincronas/DB/ValidarEstadoTransaccion/biz/validarEstadoTransaccion_db.biz | Valida estado de transacción |
| registrarReversionTCCB_db.biz | Middleware/v3/BusinessServices/PAGOSWSTC/registrarReversionTCCB/biz/registrarReversionTCCB_db.biz | Registra reversión de tarjeta de crédito |
| actualizarEstadoTransaccionUUID_db.biz | Middleware/v2/BusinessServices/TransaccionesAsincronas/DB/ActualizarEstadoTransaccionConsulta/biz/actualizarEstadoTransaccionUUID_db.biz | Actualiza estado de transacción |
| actualizarTransaccionGenCB_db.biz | Middleware/v2/BusinessServices/TransaccionesGenericasCB/ActualizarTransaccionGenericaCB/biz/actualizarTransaccionGenCB_db.biz | Actualiza transacciones genéricas |
| conReversarPagoTCRG_db.biz | Middleware/v3/BusinessServices/MasterData/conReversionPagoTCRG/biz/conReversarPagoTCRG_db.biz | Confirmación reversión pago TC |

### Servicios T24
| Archivo | Ruta Relativa | Descripción |
|---------|---------------|-------------|
| svcReversarTransaccionCB.biz | Middleware/v2/BusinessServices/TransaccionesAsincronas/T24/svcReversarTransaccionCB/biz/svcReversarTransaccionCB.biz | Servicio reversión en T24 |
| svcGestionesTrxSEEHTENGO.biz | Middleware/v2/BusinessServices/T24/svcGestionesTrxSEEHTENGO/biz/svcGestionesTrxSEEHTENGO.biz | Gestión transacciones EEH |

## Pipelines

No se identificaron pipelines específicos. El procesamiento se realiza directamente en el proxy service.

## XQuery Transformations

### Transformaciones de Entrada
| Archivo | Ruta Relativa | Descripción |
|---------|---------------|-------------|
| consultaRutaRegionalIn.xq | Middleware/v2/Resources/Generales/xq/consultaRutaRegionalIn.xq | Transformación para consulta regional |
| obtenerTipoGenIn.xq | Middleware/v2/Resources/ReversarTransaccionID/xq/obtenerTipoGenIn.xq | Transformación obtener tipo genérico |
| consultaEstadoTransaccionRevIn.xq | Middleware/v2/Resources/ReversarTransaccionID/xq/consultaEstadoTransaccionRevIn.xq | Transformación consulta estado |
| registrarReversionTCID.xq | Middleware/v2/Resources/ReversarTransaccionID/xq/registrarReversionTCID.xq | Transformación registro reversión TC |
| reversarTRXPagoTCCB.xq | Middleware/v2/Resources/ReversarTransaccionID/xq/reversarTRXPagoTCCB.xq | Transformación reversión pago TC |
| reversarTRXDepositoCB.xq | Middleware/v2/Resources/ReversarTransaccionID/xq/reversarTRXDepositoCB.xq | Transformación reversión depósito |
| reversarTrxGenericaT24.xq | Middleware/v2/Resources/ReversarTransaccionID/xq/reversarTrxGenericaT24.xq | Transformación reversión genérica T24 |
| registrarReversionTCMDIDIn.xq | Middleware/v2/Resources/ReversarTransaccionID/xq/registrarReversionTCMDIDIn.xq | Transformación registro reversión master data |
| actualizarTransaccionReversion.xq | Middleware/v2/Resources/ReversarTransaccionID/xq/actualizarTransaccionReversion.xq | Transformación actualizar estado |
| actualizarTrxGenReversaIn.xq | Middleware/v2/Resources/ReversarTransaccionID/xq/actualizarTrxGenReversaIn.xq | Transformación actualizar genérica |

### Transformaciones de Salida
| Archivo | Ruta Relativa | Descripción |
|---------|---------------|-------------|
| aplicarValoresPorDefectoRegion.xq | Middleware/v2/Resources/Generales/xq/aplicarValoresPorDefectoRegion.xq | Aplicar valores por defecto regional |

### Transformaciones de Error
| Archivo | Ruta Relativa | Descripción |
|---------|---------------|-------------|
| mapeoErroresUsageIn.xq | Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageIn.xq | Transformación entrada mapeo errores |
| mapeoErroresUsageOut.xq | Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageOut.xq | Transformación salida mapeo errores |

## XSLT Transformations

No se identificaron transformaciones XSLT específicas para esta funcionalidad.

## Java Callouts

No se identificaron Java Callouts específicos para esta funcionalidad.

## POJOs

No se identificaron POJOs específicos para esta funcionalidad.

## Configuración

### WSDL
| Archivo | Ruta Relativa | Descripción |
|---------|---------------|-------------|
| reversarTransaccionIDPS.wsdl | Middleware/v2/Resources/ReversarTransaccionID/wsdl/reversarTransaccionIDPS.wsdl | WSDL principal del servicio |

### XSD
| Archivo | Ruta Relativa | Descripción |
|---------|---------------|-------------|
| reversarTransaccionIDTypes.xsd | Middleware/v2/Resources/ReversarTransaccionID/xsd/reversarTransaccionIDTypes.xsd | Definición de tipos de datos |
| HeaderElements.xsd | Middleware/v2/Resources/esquemas_generales/HeaderElements.xsd | Elementos de header |

### Properties

No se identificaron archivos de propiedades específicos. La configuración se maneja a través de la base de datos regional.

## Policies

### Políticas de Seguridad
- **Autenticación**: Custom token authentication configurada en el proxy
- **WS-Policy**: WSDL policy attachments habilitadas

### Políticas de Transporte
- **HTTP**: Configuración de transporte HTTP estándar
- **JCA**: Configuración JCA para conexiones de base de datos

## Tests

### Tests Relevantes
| Archivo | Ruta Relativa | Descripción |
|---------|---------------|-------------|
| No encontrados | - | No se encontraron tests específicos en el repositorio |

## Archivos JAR

### Despliegues por Región
| Archivo | Ruta Relativa | Descripción |
|---------|---------------|-------------|
| soabus_ReversarTransaccionID.jar | JAR/MDA-58323/QA/soabus_ReversarTransaccionID.jar | Despliegue QA SOABUS |
| mwapp_ReversarTransaccionID.jar | JAR/MDA-58323/PRD/MWAPP/mwapp_ReversarTransaccionID.jar | Despliegue PRD MWAPP |
| mwinterbanca_ReversarTransaccionID.jar | JAR/MDA-58323/PRD/MWINTERBANCA/mwinterbanca_ReversarTransaccionID.jar | Despliegue PRD MWINTERBANCA |
| ReversarTransaccionID.jar | JAR/HotFix/MDA-54192/PRD2/MWAPP-MWINTERBANCA/ReversarTransaccionID.jar | HotFix despliegue |

### HotFixes
| Archivo | Ruta Relativa | Descripción |
|---------|---------------|-------------|
| ReversarTransaccionID.jar | JAR/MDA-54192/PRD/MWAPP-MWINTERBANCA/HN/ReversarTransaccionID.jar | HotFix Honduras |
| ReversarTransaccionID.jar | JAR/MDA-54192/QA/SOABUS/HN/ReversarTransaccionID.jar | HotFix QA Honduras |

## Archivos de Configuración JCA

### Conexiones de Base de Datos
| Archivo | Ruta Relativa | Descripción |
|---------|---------------|-------------|
| consultaRutaRegional_db.jca | Middleware/v2/BusinessServices/MDW/consultaRutaRegional/jca/consultaRutaRegional_db.jca | Configuración JCA consulta regional |
| obtenerTipoTrxGen_db.jca | Middleware/v2/BusinessServices/TransaccionesGenericasCB/ObtenerTipoTrxGen/jca/obtenerTipoTrxGen_db.jca | Configuración JCA tipo transacción |
| validarEstadoTransaccion_db.jca | Middleware/v2/BusinessServices/TransaccionesAsincronas/DB/ValidarEstadoTransaccion/jca/validarEstadoTransaccion_db.jca | Configuración JCA validación estado |

## Stored Procedures (Referencias)

### Procedimientos de Base de Datos
| Procedimiento | Descripción |
|---------------|-------------|
| MW_P_CONSULTA_RUTA_REGIONAL | Consulta configuración regional |
| MW_P_OBTENER_TIPO_TRX_GEN | Obtiene tipo de transacción genérica |
| MW_P_VALIDAR_ESTADO_TRANSACCION | Valida estado de transacción |
| MW_P_REGISTRAR_REVERSION_TCCB | Registra reversión tarjeta crédito |
| MW_P_ACTUALIZAR_ESTADO_TRANSACCION_UUID | Actualiza estado transacción |
| MW_P_ACTUALIZAR_TRANSACCION_GEN_CB | Actualiza transacciones genéricas |

## Resumen de Archivos por Categoría

- **Proxies**: 1 archivo
- **Business Services**: 9 archivos principales + archivos de configuración
- **XQuery**: 11 archivos de transformación
- **WSDL**: 1 archivo principal + archivos de business services
- **XSD**: 2 archivos principales
- **JAR**: 4 archivos de despliegue + hotfixes
- **JCA**: 3 archivos de configuración
- **Total aproximado**: 35+ archivos principales

## Dependencias Externas

### Sistemas Backend
- **T24**: Sistema core bancario
- **Core Banking (CB)**: Sistema banca central
- **Base de datos MDW**: Middleware database
- **Sistemas ATM**: Para transacciones de retiro
- **Sistemas EEH**: Para pagos de servicios públicos

### Conexiones
- **ConnectionMiddleware**: Pool de conexiones principal
- **Endpoints T24**: Por región (HN01, GT01, PA01, NI01)
- **Servicios regionales**: Configurados dinámicamente