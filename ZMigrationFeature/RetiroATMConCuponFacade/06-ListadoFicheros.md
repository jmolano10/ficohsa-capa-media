# 06 - Listado de Ficheros: RetiroATMConCuponFacade

## Proxy Services

| Archivo | Ruta | Descripción |
|---------|------|-------------|
| RetiroATMConCuponFacade.proxy | Middleware/v2/ProxyServices/ | Facade - punto de entrada, enruta por MTI |
| RetiroATMConCupon.proxy | Middleware/v2/ProxyServices/ | Lógica principal del retiro con cupón |
| ReversaCuponATM.proxy | Middleware/v2/ProxyServices/ | Lógica de reversión |
| MapeoErrores.proxy | Middleware/v2/ProxyServices/ | Mapeo de errores estándar |

## Business Services

| Archivo | Ruta | Tipo | Destino |
|---------|------|------|---------|
| registraTrxCuponTengoATM_db.biz | Middleware/v2/BusinessServices/TENGO/RegistrarCuponATM/biz/ | JCA/DB | CONTROL_REVERSIONES_ATM_TENGO.MW_P_REGISTRAR_BILLETERA_CUPON |
| umarketsc.biz | Middleware/v2/BusinessServices/TENGO/biz/ | SOAP/HTTP | TENGO Web Service |
| AplicaRetiroATMT24.biz | Middleware/v2/BusinessServices/AplicaRetiroATMT24/biz/ | SOAP/HTTP | T24 Core Bancario |
| ValidaServicioRegional_db.biz | Middleware/v2/BusinessServices/ValidaServicioRegional/biz/ | JCA/DB | SP ValidaServicioRegional |
| ObtenerParametrizacion.biz | Middleware/Business_Resources/general/Resources/ObtenerParametrizacion/ | JCA/DB | SP OSB_GET_CONFIG |
| obtenerSecuencia_db.biz | Middleware/v2/BusinessServices/obtenerSecuencia/biz/ | JCA/DB | SP obtenerSecuencia |
| actualizarTrxCuponCB_db.biz | Middleware/v2/BusinessServices/TENGO/ActualizarDatosCuponATM/biz/ | JCA/DB | SP actualizarTrxCuponCB |

## WSDLs

| Archivo | Ruta |
|---------|------|
| retiroATMConCuponFacadePS.wsdl | Middleware/v2/Resources/RetiroATMConCuponFacade/wsdl/ |
| registraTrxCuponTengoATM_db.wsdl | Middleware/v2/BusinessServices/TENGO/RegistrarCuponATM/wsdl/ |
| registraTrxCuponTengoATM.wsdl | Middleware/v2/BusinessServices/TENGO/RegistrarCuponATM/wsdl/ |

## XSDs

| Archivo | Ruta | Descripción |
|---------|------|-------------|
| registraTrxCuponTengoATM_sp.xsd | Middleware/v2/BusinessServices/TENGO/RegistrarCuponATM/xsd/ | Schema del SP (Input/Output Parameters) |
| procesaMensajeGenericoSwitchFacadeTypes.xsd | Middleware/v2/Resources/ProcesaMensajeGenericoSwitch/xsd/ | Tipos ISO8583 |
| retiroATMConCuponTypes.xsd | Middleware/v2/Resources/RetiroATMConCupon/xsd/ | Tipos del servicio retiro |
| HeaderElements.xsd | Middleware/v2/Resources/esquemas_generales/ | Headers Request/Response |

## XQueries

| Archivo | Ruta |
|---------|------|
| registrarTransaccionCupon.xq | Middleware/v2/Resources/RetiroATMConCuponFacade/xq/ |
| retiroATMConCuponIn.xq | Middleware/v2/Resources/RetiroATMConCuponFacade/xq/ |
| retiroATMConCuponOut.xq | Middleware/v2/Resources/RetiroATMConCuponFacade/xq/ |

## JCA

| Archivo | Ruta |
|---------|------|
| registraTrxCuponTengoATM_db.jca | Middleware/v2/BusinessServices/TENGO/RegistrarCuponATM/jca/ |

## Java

| Archivo | Ruta | Descripción |
|---------|------|-------------|
| GenerarCredencialesTengo | Middleware/v2/Resources/Utilities/Java/ | Genera hash SHA1 para autenticación TENGO |

## Conexiones

| Recurso | Connection String/URI |
|---------|----------------------|
| registraTrxCuponTengoATM_db | jca://eis/DB/ConnectionMiddleware |
