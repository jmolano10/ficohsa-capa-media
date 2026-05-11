# 07 - Listado de XQueries: RetiroATMConCuponFacade

## XQueries del Facade (RetiroATMConCuponFacade)

### registrarTransaccionCupon.xq
- **Ruta**: `Middleware/v2/Resources/RetiroATMConCuponFacade/xq/`
- **Propósito**: Transforma ISO8583 a InputParameters del SP `MW_P_REGISTRAR_BILLETERA_CUPON`
- **Entrada**: `procesaMensajeGenericoSwitchFacadeRequest` (ISO8583)
- **Salida**: `InputParameters` (6 campos: PV_RETRIEVAL_REF, PV_TERMINAR_REFERENCE, PV_TERMINAL_ID, PV_CUPON_ID, PV_AMOUNT, PV_CURRENCY)
- **Lógica**: Mapeo directo de campos ISO8583 a parámetros del SP
- **Invocado en**: Facade → Publish al BS registraTrxCuponTengoATM_db (antes de enrutar al proxy hijo)

### retiroATMConCuponIn.xq
- **Ruta**: `Middleware/v2/Resources/RetiroATMConCuponFacade/xq/`
- **Propósito**: Transforma ISO8583 al formato de entrada del proxy RetiroATMConCupon
- **Entrada**: `procesaMensajeGenericoSwitchFacadeRequest` (ISO8583)
- **Salida**: `retiroATMConCupon` (AMOUNT, COUPON_ID, TERMINAL_ID, CHANNEL, CURRENCY, TERMINAL_REFERENCE, RETRIEVAL_REF_NUMBER)
- **Lógica**:
  - AMOUNT: divide entre 100 (centavos → unidades)
  - CURRENCY: 340→"HNL", 840→"USD"
  - CHANNEL: constante "ATM"
  - TERMINAL_ID: aplica `fn-bea:trim()`
- **Invocado en**: Facade → outboundTransform del route a RetiroATMConCupon

### retiroATMConCuponOut.xq
- **Ruta**: `Middleware/v2/Resources/RetiroATMConCuponFacade/xq/`
- **Propósito**: Construye la respuesta ISO8583 final combinando body original + respuesta del proxy hijo
- **Entrada**: `procesaMensajeGenericoSwitchFacadeRequest` (original), `retiroATMConCuponResponse`, `successIndicator`
- **Salida**: Estructura ISO8583 completa con MTI=0210
- **Lógica**:
  - MTI fijo "0210"
  - ResponseCode_039: SUCCESS→"00", ERROR→"80"
  - Montos divididos entre 100
  - Campo 121 (voucher): solo si SUCCESS, concatena datos de la transacción
  - TransmissionDateTime_007: fecha/hora actual formato MMddHHmmss
  - Demás campos: pass-through del body original
- **Invocado en**: Facade → responseTransform (éxito) y errorHandler (error)

## XQueries Auxiliares (usados por el proxy hijo RetiroATMConCupon)

### redimirCuponTengoIn.xq
- **Ruta**: `Middleware/v2/Resources/RetiroATMConCupon/xq/`
- **Propósito**: Prepara request para TENGO coupontransfer
- **Invocado en**: RetiroATMConCupon → stage RedimirCuponTENGO

### aplicaRetiroATMT24In.xq
- **Ruta**: `Middleware/v2/Resources/RetiroATMConCupon/xq/`
- **Propósito**: Prepara request para T24
- **Invocado en**: RetiroATMConCupon → stage RegistroTransaccionATMT24

### actualizarInfoCuponDBIn.xq
- **Ruta**: `Middleware/v2/Resources/RetiroATMConCupon/xq/`
- **Propósito**: Prepara request para actualizar datos del cupón en BD
- **Invocado en**: RetiroATMConCupon → stage RegistroTransaccionATMT24

### reversarATMConCuponIn.xq
- **Ruta**: `Middleware/v2/Resources/ReversaCuponATM/xq/`
- **Propósito**: Prepara request para reversión
- **Invocado en**: Facade → branch Reversión

### reversaCupoATMOut.xq
- **Ruta**: `Middleware/v2/Resources/ReversaCuponATM/xq/`
- **Propósito**: Construye respuesta de reversión
- **Invocado en**: Facade → responseTransform de reversión

## XQueries Generales

### mapeoErroresUsageIn.xq / mapeoErroresUsageOut.xq
- **Ruta**: `Middleware/v2/Resources/MapeoErrores/xq/`
- **Propósito**: Mapeo de errores estándar (entrada/salida)

### validaServicioRegionalIn.xq
- **Ruta**: `Middleware/v2/Resources/Generales/xq/`
- **Propósito**: Prepara request de validación regional

### aplicarValoresPorDefectoRegion.xq
- **Ruta**: `Middleware/v2/Resources/Generales/xq/`
- **Propósito**: Aplica valores por defecto al header según región

### obtenerCredencialesServiceAccount.xq
- **Ruta**: `Middleware/v2/Resources/Generales/xq/`
- **Propósito**: Obtiene credenciales del Service Account

### obtenerSecuenciaIn.xq
- **Ruta**: `Middleware/v2/Resources/Generales/xq/`
- **Propósito**: Prepara request para obtener secuencia

### loginTengo.xq
- **Ruta**: `Middleware/v2/Resources/ProcesaMensajeGenericoSwitch/xq/`
- **Propósito**: Prepara request de login a TENGO

### obtenerParametrizacionIn.xq
- **Ruta**: `Middleware/Business_Resources/general/Parametrizacion/`
- **Propósito**: Prepara request de parametrización
