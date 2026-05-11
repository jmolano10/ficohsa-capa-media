# 01 - Resumen Ejecutivo: RetiroATMConCuponFacade

## Propósito del Servicio
Servicio Facade que orquesta el flujo de **retiro de efectivo en ATM mediante cupón digital (TENGO)**. Actúa como punto de entrada desde el Switch (mensajería ISO8583) y enruta según el tipo de mensaje (MTI):
- **0200** → Retiro con cupón (flujo principal)
- **0420/0220** → Reversión de retiro con cupón

## Identificador del Servicio
- **Código**: FICBCO0259
- **Endpoint SOAP**: `http://172.23.13.19:8003/Middleware/OperationsAndExecution/Messaging/retiroATMConCuponFacade`
- **Operación**: `retiroATMConCuponFacade`

## Entrada
- Mensaje ISO8583 encapsulado en `procesaMensajeGenericoSwitchFacadeRequest`
- Campos clave: MTI, AmountTransaction_004, AdditionalDataPrivate_048 (cupón ID), CardAcceptorTerminalIdentification_041, SystemTraceAuditNumber_011, CurrencyCodeTransaction_049, RetrievalReferenceNumber_037

## Salida
- Mensaje ISO8583 de respuesta con MTI 0210
- ResponseCode_039: '00' (éxito) o '80' (error)
- Campo 121 (ReservedForPrivateUse_121): Voucher con datos de la transacción en caso exitoso

## Sistemas Involucrados

| Sistema | Tipo | Descripción |
|---------|------|-------------|
| Switch (ISO8583) | Consumidor | Envía mensajes de retiro/reversión |
| TENGO (umarketsc) | Proveedor WS | Billetera digital - createsession, login, coupontransfer |
| T24 (AplicaRetiroATMT24) | Proveedor BS | Core bancario - aplica el retiro contable |
| BD Oracle (registraTrxCuponTengoATM) | Proveedor DB | Registra la transacción del cupón (paquete CONTROL_REVERSIONES_ATM_TENGO.MW_P_REGISTRAR_BILLETERA_CUPON) |
| BD Oracle (actualizarTrxCuponCB) | Proveedor DB | Actualiza datos del cupón post-retiro |
| BD Oracle (obtenerSecuencia) | Proveedor DB | Genera consecutivo CC_SWITCH_COUPON |
| BD Oracle (ValidaServicioRegional) | Proveedor DB | Valida disponibilidad regional del servicio |
| BD Oracle (ObtenerParametrizacion) | Proveedor DB | Obtiene parámetros de configuración |
| MapeoErrores | Proxy interno | Mapea códigos de error a mensajes estándar |
| ReversaCuponATM | Proxy interno | Maneja la reversión del cupón |

## Flujo Principal (MTI 0200 - Retiro)

1. **Facade** recibe ISO8583, guarda body original, extrae MTI
2. Enruta a **RetiroATMConCupon** proxy
3. Valida XSD del request
4. Valida servicio regional (solo HN01 implementado)
5. Obtiene parametrización (usuario TENGO, cuenta billetera, código transacción)
6. Crea sesión en TENGO (`createsession`)
7. Obtiene credenciales del Service Account
8. Genera PIN cifrado (Java callout SHA1)
9. Login en TENGO (`login`)
10. Redime cupón en TENGO (`coupontransfer`)
11. Obtiene consecutivo (secuencia CC_SWITCH_COUPON)
12. **Registra transacción en BD** (`registraTrxCuponTengoATM` → MW_P_REGISTRAR_BILLETERA_CUPON) ← **Relevante para HU 65057**
13. Aplica retiro en T24
14. Actualiza datos del cupón en BD
15. Retorna respuesta ISO8583 con voucher

## Relevancia para HU 65057 (CreateCouponWalletRegister-Sys/Register)

La funcionalidad que se moderniza corresponde al **paso 12**: el registro de la transacción del cupón en la base de datos mediante el stored procedure `CONTROL_REVERSIONES_ATM_TENGO.MW_P_REGISTRAR_BILLETERA_CUPON`.

### Datos de entrada al SP:
| Parámetro | Origen ISO8583 |
|-----------|---------------|
| PV_RETRIEVAL_REF | RetrievalReferenceNumber_037 |
| PV_TERMINAR_REFERENCE | SystemTraceAuditNumber_011 |
| PV_TERMINAL_ID | CardAcceptorTerminalIdentification_041 |
| PV_CUPON_ID | AdditionalDataPrivate_048 |
| PV_AMOUNT | AmountTransaction_004 |
| PV_CURRENCY | CurrencyCodeTransaction_049 |

### Datos de salida del SP:
| Parámetro | Descripción |
|-----------|-------------|
| PV_CODIGO_ERROR | Código de error (vacío si éxito) |
| PV_MENSAJE_ERROR | Mensaje descriptivo del error |

## Proxies Dependientes
| Proxy | Ruta | Descripción |
|-------|------|-------------|
| RetiroATMConCupon | Middleware/v2/ProxyServices/RetiroATMConCupon.proxy | Lógica principal del retiro |
| ReversaCuponATM | Middleware/v2/ProxyServices/ReversaCuponATM.proxy | Lógica de reversión |
| MapeoErrores | Middleware/v2/ProxyServices/MapeoErrores.proxy | Mapeo de errores estándar |
