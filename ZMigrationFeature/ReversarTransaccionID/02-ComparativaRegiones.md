# Comparativa entre Regiones - ReversarTransaccionID

## Tabla de Comparación

| Aspecto | HN01 (Honduras) | GT01 (Guatemala) | PA01 (Panamá) | NI01 (Nicaragua) |
|---------|-----------------|------------------|---------------|------------------|
| **Endpoint OSB** | `/Middleware/SalesAndServices/BankingPartner/reversarTransaccionID` | `/Middleware/SalesAndServices/BankingPartner/reversarTransaccionID` | `/Middleware/SalesAndServices/BankingPartner/reversarTransaccionID` | `/Middleware/SalesAndServices/BankingPartner/reversarTransaccionID` |
| **Nombre de Base de Datos** | ConnectionMiddleware | ConnectionMiddleware | ConnectionMiddleware | ConnectionMiddleware |
| **Esquemas** | MW_P_CONSULTA_RUTA_REGIONAL | MW_P_CONSULTA_RUTA_REGIONAL | MW_P_CONSULTA_RUTA_REGIONAL | MW_P_CONSULTA_RUTA_REGIONAL |
| **Store Procedures** | MW_P_CONSULTA_RUTA_REGIONAL<br/>obtenerTipoTrxGen<br/>validarEstadoTransaccion<br/>registrarReversionTCCB<br/>actualizarEstadoTransaccionUUID<br/>actualizarTransaccionGenCB | MW_P_CONSULTA_RUTA_REGIONAL<br/>obtenerTipoTrxGen<br/>validarEstadoTransaccion<br/>registrarReversionTCCB<br/>actualizarEstadoTransaccionUUID<br/>actualizarTransaccionGenCB | MW_P_CONSULTA_RUTA_REGIONAL<br/>obtenerTipoTrxGen<br/>validarEstadoTransaccion<br/>registrarReversionTCCB<br/>actualizarEstadoTransaccionUUID<br/>actualizarTransaccionGenCB | MW_P_CONSULTA_RUTA_REGIONAL<br/>obtenerTipoTrxGen<br/>validarEstadoTransaccion<br/>registrarReversionTCCB<br/>actualizarEstadoTransaccionUUID<br/>actualizarTransaccionGenCB |
| **Nombre de Conexión** | jca://eis/DB/ConnectionMiddleware | jca://eis/DB/ConnectionMiddleware | jca://eis/DB/ConnectionMiddleware | jca://eis/DB/ConnectionMiddleware |
| **Transformaciones clave** | obtenerTipoGenIn.xq<br/>consultaEstadoTransaccionRevIn.xq<br/>registrarReversionTCID.xq<br/>reversarTRXPagoTCCB.xq<br/>reversarTRXDepositoCB.xq<br/>reversarTrxGenericaT24.xq<br/>actualizarTransaccionReversion.xq | obtenerTipoGenIn.xq<br/>consultaEstadoTransaccionRevIn.xq<br/>registrarReversionTCID.xq<br/>reversarTRXPagoTCCB.xq<br/>reversarTRXDepositoCB.xq<br/>reversarTrxGenericaT24.xq<br/>actualizarTransaccionReversion.xq | obtenerTipoGenIn.xq<br/>consultaEstadoTransaccionRevIn.xq<br/>registrarReversionTCID.xq<br/>reversarTRXPagoTCCB.xq<br/>reversarTRXDepositoCB.xq<br/>reversarTrxGenericaT24.xq<br/>actualizarTransaccionReversion.xq | obtenerTipoGenIn.xq<br/>consultaEstadoTransaccionRevIn.xq<br/>registrarReversionTCID.xq<br/>reversarTRXPagoTCCB.xq<br/>reversarTRXDepositoCB.xq<br/>reversarTrxGenericaT24.xq<br/>actualizarTransaccionReversion.xq |
| **Campos diferenciadores** | Configuración regional específica | Configuración regional específica | Configuración regional específica | Configuración regional específica |
| **Errores/Excepciones** | MapeoErrores con código FICBCO0259 | MapeoErrores con código FICBCO0259 | MapeoErrores con código FICBCO0259 | MapeoErrores con código FICBCO0259 |
| **Timeouts/Retrys** | retry-count: 0<br/>retry-interval: 30<br/>retry-application-errors: true | retry-count: 0<br/>retry-interval: 30<br/>retry-application-errors: true | retry-count: 0<br/>retry-interval: 30<br/>retry-application-errors: true | retry-count: 0<br/>retry-interval: 30<br/>retry-application-errors: true |
| **Dependencias internas** | T24 Core Banking<br/>MDW Database<br/>Core Banking CB | T24 Core Banking<br/>MDW Database<br/>Core Banking CB | T24 Core Banking<br/>MDW Database<br/>Core Banking CB | T24 Core Banking<br/>MDW Database<br/>Core Banking CB |

## Sección por Región

### HN01 - Honduras

#### Endpoints y Configuración
- **Proxy Service**: `ReversarTransaccionID.proxy`
- **URI**: `/Middleware/SalesAndServices/BankingPartner/reversarTransaccionID`
- **Servicio ID**: `FICBCO0516`
- **Versión**: V2

#### Mapeos y Validaciones
- **Consulta Regional**: Utiliza `consultaRutaRegionalIn.xq` con parámetros específicos de Honduras
- **Validación de Autenticación**: Username/Password en RequestHeader
- **Políticas OSB**: WSDL policy attachments habilitadas

#### Handlers y Procesamiento
- **Error Handler**: `_onErrorHandler` con mapeo de errores específico
- **Logging**: Nivel debug habilitado
- **Monitoring**: Pipeline level monitoring
- **Alerting**: SLA y Pipeline alerting en nivel normal

### GT01 - Guatemala

#### Endpoints y Configuración
- **Proxy Service**: `ReversarTransaccionID.proxy`
- **URI**: `/Middleware/SalesAndServices/BankingPartner/reversarTransaccionID`
- **Servicio ID**: `FICBCO0516`
- **Versión**: V2

#### Mapeos y Validaciones
- **Consulta Regional**: Utiliza `consultaRutaRegionalIn.xq` con parámetros específicos de Guatemala
- **Validación de Autenticación**: Username/Password en RequestHeader
- **Políticas OSB**: WSDL policy attachments habilitadas

#### Handlers y Procesamiento
- **Error Handler**: `_onErrorHandler` con mapeo de errores específico
- **Logging**: Nivel debug habilitado
- **Monitoring**: Pipeline level monitoring
- **Alerting**: SLA y Pipeline alerting en nivel normal

### PA01 - Panamá

#### Endpoints y Configuración
- **Proxy Service**: `ReversarTransaccionID.proxy`
- **URI**: `/Middleware/SalesAndServices/BankingPartner/reversarTransaccionID`
- **Servicio ID**: `FICBCO0516`
- **Versión**: V2

#### Mapeos y Validaciones
- **Consulta Regional**: Utiliza `consultaRutaRegionalIn.xq` con parámetros específicos de Panamá
- **Validación de Autenticación**: Username/Password en RequestHeader
- **Políticas OSB**: WSDL policy attachments habilitadas

#### Handlers y Procesamiento
- **Error Handler**: `_onErrorHandler` con mapeo de errores específico
- **Logging**: Nivel debug habilitado
- **Monitoring**: Pipeline level monitoring
- **Alerting**: SLA y Pipeline alerting en nivel normal

### NI01 - Nicaragua

#### Endpoints y Configuración
- **Proxy Service**: `ReversarTransaccionID.proxy`
- **URI**: `/Middleware/SalesAndServices/BankingPartner/reversarTransaccionID`
- **Servicio ID**: `FICBCO0516`
- **Versión**: V2

#### Mapeos y Validaciones
- **Consulta Regional**: Utiliza `consultaRutaRegionalIn.xq` con parámetros específicos de Nicaragua
- **Validación de Autenticación**: Username/Password en RequestHeader
- **Políticas OSB**: WSDL policy attachments habilitadas

#### Handlers y Procesamiento
- **Error Handler**: `_onErrorHandler` con mapeo de errores específico
- **Logging**: Nivel debug habilitado
- **Monitoring**: Pipeline level monitoring
- **Alerting**: SLA y Pipeline alerting en nivel normal

## Diferencias Identificadas

### Configuración Regional
La principal diferencia entre regiones se encuentra en la configuración regional obtenida a través del stored procedure `MW_P_CONSULTA_RUTA_REGIONAL`, que retorna parámetros específicos para cada región basados en el código de región.

### Procesamiento de Transacciones
- **Tipos de Transacción**: Todas las regiones soportan los mismos tipos de transacción
- **Flujo de Validación**: El flujo de validación es idéntico en todas las regiones
- **Manejo de Errores**: El manejo de errores es consistente entre regiones

### Business Services
- **Servicios Comunes**: Todos los business services son compartidos entre regiones
- **Configuración de Conexión**: Las conexiones a base de datos son las mismas
- **Transformaciones**: Las transformaciones XQuery son idénticas

## Conclusión

La funcionalidad **ReversarTransaccionID** presenta una **arquitectura unificada** entre todas las regiones, donde las diferencias se manejan a través de:

1. **Configuración Regional**: Parámetros específicos obtenidos de la base de datos
2. **Enrutamiento Dinámico**: Basado en la configuración regional
3. **Servicios Compartidos**: Mismos business services para todas las regiones

Esta arquitectura permite mantener un código base único mientras se adapta a las necesidades específicas de cada región a través de configuración dinámica.