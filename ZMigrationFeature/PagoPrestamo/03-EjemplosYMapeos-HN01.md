# Ejemplos de Request/Response y Mapeo de Datos - HN01 (Honduras)

## 1. Request OSB (Ejemplo - ACCOUNT_DEBIT)

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:pag="http://www.ficohsa.com.hn/middleware.services/pagoPrestamoTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:RequestHeader>
         <Authentication>
            <UserName>USUARIO_OSB</UserName>
            <Password>PASSWORD_OSB</Password>
         </Authentication>
         <Region>
            <SourceBank>HN01</SourceBank>
            <DestinationBank>HN01</DestinationBank>
         </Region>
      </aut:RequestHeader>
   </soapenv:Header>
   <soapenv:Body>
      <pag:pagoPrestamo>
         <LOAN_NUMBER>1234567890</LOAN_NUMBER>
         <PAYMENT_AMOUNT>5000.00</PAYMENT_AMOUNT>
         <PAYMENT_TYPE>ACCOUNT_DEBIT</PAYMENT_TYPE>
         <DEBIT_ACCOUNT>1001234567</DEBIT_ACCOUNT>
         <INTERFACE_REFERENCE_NO>REF20240101001</INTERFACE_REFERENCE_NO>
         <DEBIT_CREDIT>DEBIT</DEBIT_CREDIT>
      </pag:pagoPrestamo>
   </soapenv:Body>
</soapenv:Envelope>
```

## 2. Response OSB (Ejemplo - Exitoso)

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:pag="http://www.ficohsa.com.hn/middleware.services/pagoPrestamoTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:ResponseHeader>
         <successIndicator>SUCCESS</successIndicator>
         <messages>Pago procesado exitosamente</messages>
      </aut:ResponseHeader>
   </soapenv:Header>
   <soapenv:Body>
      <pag:pagoPrestamoResponse>
         <DATE_TIME>20240101120000</DATE_TIME>
         <LOAN_NUMBER>1234567890</LOAN_NUMBER>
         <DUE_ID>001</DUE_ID>
         <PAYMENT_AMOUNT>5000.00</PAYMENT_AMOUNT>
      </pag:pagoPrestamoResponse>
   </soapenv:Body>
</soapenv:Envelope>
```

## 3. Cadenas de Conexión y Credenciales

### 3.1. Base de Datos ABANKS

- **Nombre de Conexión:** eis/DB/ConnectionInterbanca
- **Base de Datos:** ORA_BANK
- **Stored Procedure:** OSB_PAG_PRESTAMO_T24
- **Esquema:** ORA_BANK
- **Package:** OSB_PAG_PRESTAMO_T24

### 3.2. Servicio T24 - Consulta Cuenta

- **Endpoint:** Middleware/Business_Resources/ConsultasCuenta/Resources/consultaCuentasBS
- **Operación:** Consultadedetallesdelacuenta
- **Protocolo:** SOAP

### 3.3. Servicio T24 - Pago Préstamo

- **Endpoint:** Middleware/Business_Resources/consultaGeneralPrestamo/Resources/PrestamosT24BS
- **Operación:** PagoaprestamoAA
- **Protocolo:** SOAP

### 3.4. Servicio ABANKS - Consulta Productos

- **Endpoint:** Middleware/v2/BusinessServices/SJS/consultaProductos/biz/sjConsultaProductos
- **Operación:** consultaProductos
- **Protocolo:** SOAP

### 3.5. Servicio ABANKS - Transferencias

- **Endpoint:** Middleware/Business_Resources/Transferencias/Resources/transferenciasBS
- **Operaciones:**
  - Transfmodelbankentrecuentas
  - Transfentrecuentasinstrcredito
  - Transferenciaentrecuentas
- **Protocolo:** SOAP

## 4. Mapeo de Entrada - Validación Servicio Regional

### Request a ValidaServicioRegional

| Campo Origen (OSB) | Transformación/Script | Campo Destino (DB) |
|--------------------|----------------------|-------------------|
| RequestHeader/Region/SourceBank | fn:string() | PV_REGION |
| "FICBCO0076" | Constante | PV_SERVICE_ID |

**Archivo XQuery:** `Middleware/v2/Resources/Generales/xq/validaServicioRegionalIn.xq`

**Regla de Negocio:** Valida que el servicio FICBCO0076 esté habilitado para la región HN01

### Response de ValidaServicioRegional

| Campo Origen (DB) | Transformación/Script | Campo Destino (OSB) |
|-------------------|----------------------|-------------------|
| PV_CODIGO_ERROR | fn:string() | Variable: successIndicator |
| PV_MENSAJE_ERROR | fn:string() | Variable: message |

**Condición:** Si PV_CODIGO_ERROR != 'SUCCESS', se detiene el flujo y se retorna error

## 5. Mapeo de Entrada - Consulta Productos (ABANKS)

### Request a sjConsultaProductos

| Campo Origen (OSB) | Transformación/Script | Campo Destino (Servicio) |
|--------------------|----------------------|-------------------------|
| RequestHeader/Authentication/UserName | fn:string() | ldapUsername |
| RequestHeader/Authentication/Password | fn:string() | ldapPassword |
| pagoPrestamo/DEBIT_ACCOUNT | fn:string() | accountNumber |
| pagoPrestamo/LOAN_NUMBER | fn:string() | loanNumber |

**Archivo XQuery:** `Middleware/v2/Resources/PagoPrestamo/xq/pagoPtmoConsProductosIn.xq`

**Regla de Negocio:** Valida que tanto el préstamo como la cuenta existan y estén activos

### Response de sjConsultaProductos

| Campo Origen (Servicio) | Transformación/Script | Campo Destino (OSB) |
|------------------------|----------------------|-------------------|
| PRODUCTS/PRODUCT[TYPE="PTM"][ID=$loanNumber]/SUCCESS_INDICATOR | fn:string() | Variable: successIndPtmo |
| PRODUCTS/PRODUCT[TYPE="CTA"][ID=$debitAccount]/SUCCESS_INDICATOR | fn:string() | Variable: successIndCuenta |
| PRODUCTS/PRODUCT[TYPE="PTM"]/CURRENCY | fn:string() | Variable: loanCurrency |
| PRODUCTS/PRODUCT[TYPE="CTA"]/CURRENCY | fn:string() | Variable: accountCurrency |

**Condición:** Ambos SUCCESS_INDICATOR deben ser "SUCCESS" para continuar

## 6. Mapeo de Entrada - Obtener Parametrización

### Request a ObtenerParametrizacion

| Campo Origen (OSB) | Transformación/Script | Campo Destino (Servicio) |
|--------------------|----------------------|-------------------------|
| Variable: loanCurrency | fn:concat("T24T134.", $loanCurrency, "CREDITACCTNO") | nombreParametros (1) |
| Constante | "T24T133.TXNTYPELOANPYMT" | nombreParametros (2) |
| Constante | "T24T057.INTACCOUNT.USERS" | nombreParametros (3) |

**Archivo XQuery:** `Middleware/Business_Resources/general/Parametrizacion/obtenerParametrizacionIn.xq`

**Regla de Negocio:** Obtiene parámetros de configuración necesarios para la transacción

### Response de ObtenerParametrizacion

| Campo Origen (Servicio) | Transformación/Script | Campo Destino (OSB) |
|------------------------|----------------------|-------------------|
| ERROR_CODE | fn:string() | Variable: statusParametrizacion |
| CONFIGURACIONES/CONFIGURACIONES_ITEM[NAME=$creditAcctParam]/VALUE | fn:string() | Variable: creditAccount |
| CONFIGURACIONES/CONFIGURACIONES_ITEM[NAME="T24T133.TXNTYPELOANPYMT"]/VALUE | fn:string() | Variable: trxType |
| CONFIGURACIONES/CONFIGURACIONES_ITEM[NAME="T24T057.INTACCOUNT.USERS"]/VALUE | fn:string() | Variable: intAccountUsers |

## 7. Mapeo de Entrada - Transferencia Entre Cuentas (Misma Moneda)

### Request a Transfmodelbankentrecuentas

| Campo Origen (OSB) | Transformación/Script | Campo Destino (Servicio) |
|--------------------|----------------------|-------------------------|
| Variable: trxType | fn:string() | transactionType |
| Variable: accountCurrency | fn:string() | accountCurrency |
| RequestHeader | Objeto completo | requestHeader |
| Variable: creditAccount | fn:string() | creditAccount |
| Variable: uuid | fn:string() | uuid |
| pagoPrestamo | Objeto completo | pagoPrestamo |

**Archivo XQuery:** `Middleware/v2/Resources/PagoPrestamo/xq/debitoPrestamoCuentaIn.xq`

**Regla de Negocio:** Realiza transferencia cuando la moneda del préstamo y la cuenta son iguales

### Response de Transfmodelbankentrecuentas

| Campo Origen (Servicio) | Transformación/Script | Campo Destino (OSB) |
|------------------------|----------------------|-------------------|
| Status/successIndicator | fn:string() | Variable: successIndicator |
| Status/transactionId | fn:string() | Variable: transactionId |
| FUNDSTRANSFERType/DEBITVALUEDATE | fn:string() | Variable: valueDate |
| Status/messages | fn:string-join(., '-') | Variable: message |

## 8. Mapeo de Entrada - Transferencia Entre Cuentas (Diferente Moneda - CREDIT)

### Request a Transfentrecuentasinstrcredito

| Campo Origen (OSB) | Transformación/Script | Campo Destino (Servicio) |
|--------------------|----------------------|-------------------------|
| Variable: trxType | fn:string() | transactionType |
| Variable: authParametro | '0' | auth |
| RequestHeader | Objeto completo | requestHeader |
| Variable: uuid | fn:string() | uuid |
| Variable: creditAccount | fn:string() | creditAccount |
| pagoPrestamo | Objeto completo | pagoPrestamo |

**Archivo XQuery:** `Middleware/v2/Resources/PagoPrestamo/xq/debitoPrestamoCuentaAuthIn.xq`

**Regla de Negocio:** Realiza transferencia con instrucción de crédito cuando DEBIT_CREDIT = 'CREDIT'

## 9. Mapeo de Entrada - Registro Pago en ABANKS

### Request a pagoPrestamoT24

| Campo Origen (OSB) | Transformación/Script | Campo Destino (DB) |
|--------------------|----------------------|-------------------|
| RequestHeader/Authentication/UserName | fn:string() | USERNAME |
| pagoPrestamo/LOAN_NUMBER | fn:string() | LOAN_NUMBER |
| pagoPrestamo/PAYMENT_AMOUNT | fn:string() | PAYMENT_AMOUNT |
| pagoPrestamo/DEBIT_ACCOUNT | fn:string() | DEBIT_ACCOUNT |
| pagoPrestamo/INTERFACE_REFERENCE_NO | fn:string() | INTERFACE_REFERENCE_NO |
| Variable: transactionId | fn:string() | TRANSACTIONID |

**Archivo XQuery:** `Middleware/v2/Resources/PagoPrestamo/xq/pagoPrestamoIn.xq`

**Stored Procedure:** OSB_PAG_PRESTAMO_T24

**Regla de Negocio:** Registra el pago en la base de datos ABANKS después de la transferencia exitosa

### Response de pagoPrestamoT24

| Campo Origen (DB) | Transformación/Script | Campo Destino (OSB) |
|-------------------|----------------------|-------------------|
| ERROR_CODE | fn:string() | Variable: successIndicatorAbanks |
| ERROR_MESSAGE | fn:string() | Variable: message |
| LOAN_NUMBER | fn:string() | pagoPrestamoResponse/LOAN_NUMBER |
| PAYMENT_AMOUNT | fn:string() | pagoPrestamoResponse/PAYMENT_AMOUNT |
| DATE_TIME | fn:string() | pagoPrestamoResponse/DATE_TIME |
| DUE_ID | fn:string() | pagoPrestamoResponse/DUE_ID |

**Condición:** Si ERROR_CODE != "SUCCESS", se reversa la transferencia

## 10. Mapeo de Entrada - Reversión de Transacción

### Request a ReversarTransaccion

| Campo Origen (OSB) | Transformación/Script | Campo Destino (Servicio) |
|--------------------|----------------------|-------------------------|
| Variable: transactionId | fn:string() | transactionId |

**Archivo XQuery:** `Middleware/Business_Resources/pagoPrestamo/reversarTransaccion/reversarTransaccionIn.xq`

**Regla de Negocio:** Reversa la transferencia si falla el registro en ABANKS

## 11. Flujo CASH (Efectivo)

### 11.1. Request a consultaGeneralPrestamo

| Campo Origen (OSB) | Transformación/Script | Campo Destino (Servicio) |
|--------------------|----------------------|-------------------------|
| pagoPrestamo | Objeto completo | pagoPrestamo |

**Archivo XQuery:** `Middleware/Business_Resources/pagoPrestamo/consultaGeneralPrestamo/consultaGeneralPrestamoIn.xq`

### 11.2. Request a Depositoenefectivofase11 (HNL)

| Campo Origen (OSB) | Transformación/Script | Campo Destino (Servicio) |
|--------------------|----------------------|-------------------------|
| Variable: uuid | fn:string() | uuid |
| RequestHeader | Objeto completo | requestHeader |
| pagoPrestamo | Objeto completo | pagoPrestamo |

**Archivo XQuery:** `Middleware/v2/Resources/PagoPrestamo/xq/depositoPrestamoEfectivoLocalIn.xq`

**Regla de Negocio:** Depósito en efectivo para moneda local (HNL)

### 11.3. Request a Depositoenefectivofase12 (USD)

| Campo Origen (OSB) | Transformación/Script | Campo Destino (Servicio) |
|--------------------|----------------------|-------------------------|
| Variable: uuid | fn:string() | uuid |
| RequestHeader | Objeto completo | requestHeader |
| pagoPrestamo | Objeto completo | pagoPrestamo |

**Archivo XQuery:** `Middleware/v2/Resources/PagoPrestamo/xq/depositoPrestamoEfectivoExtranjeraIn.xq`

**Regla de Negocio:** Depósito en efectivo para moneda extranjera (USD)

## 12. Flujo OTHER_BANK_CHEQUE (Cheque de Otro Banco)

### 12.1. Request a ObtenerParametrizacion (Cuentas de Cheque)

| Campo Origen (OSB) | Transformación/Script | Campo Destino (Servicio) |
|--------------------|----------------------|-------------------------|
| Constante | "T24T032.HNLOBCHQACCTNO\|\|T24T032.USDOBCHQACCTNO" | nombreParametros |

**Regla de Negocio:** Obtiene las cuentas de depósito para cheques según moneda

### 12.2. Request a Depositocombinado (HNL)

| Campo Origen (OSB) | Transformación/Script | Campo Destino (Servicio) |
|--------------------|----------------------|-------------------------|
| Variable: uuid | fn:string() | uuid |
| Variable: depositAccount | fn:string() (T24T032.HNLOBCHQACCTNO) | depositAccount |
| RequestHeader | Objeto completo | requestHeader |
| pagoPrestamo | Objeto completo | pagoPrestamo |

**Archivo XQuery:** `Middleware/v2/Resources/PagoPrestamo/xq/debitoPrestamoChequeLocalIn.xq`

**Regla de Negocio:** Depósito combinado para cheques en moneda local

### 12.3. Request a Depositocombinado (USD)

| Campo Origen (OSB) | Transformación/Script | Campo Destino (Servicio) |
|--------------------|----------------------|-------------------------|
| Variable: uuid | fn:string() | uuid |
| Variable: depositAccount | fn:string() (T24T032.USDOBCHQACCTNO) | depositAccount |
| RequestHeader | Objeto completo | requestHeader |
| pagoPrestamo | Objeto completo | pagoPrestamo |

**Archivo XQuery:** `Middleware/v2/Resources/PagoPrestamo/xq/debitoPrestamoChequeExtranjeraIn.xq`

**Regla de Negocio:** Depósito combinado para cheques en moneda extranjera

## 13. Flujo T24 (Préstamos en T24)

### 13.1. Request a Consultadedetallesdelacuenta

| Campo Origen (OSB) | Transformación/Script | Campo Destino (Servicio) |
|--------------------|----------------------|-------------------------|
| RequestHeader | Objeto completo | requestHeader |
| pagoPrestamo | Objeto completo | pagoPrestamo |

**Archivo XQuery:** `Middleware/v2/Resources/PagoPrestamo/xq/consultaDetalleCuentaIn.xq`

**Regla de Negocio:** Consulta detalles de la cuenta en T24

### 13.2. Request a PagoaprestamoAA

| Campo Origen (OSB) | Transformación/Script | Campo Destino (Servicio) |
|--------------------|----------------------|-------------------------|
| Variable: accountCurrency | fn:string() | accountCurrency |
| RequestHeader | Objeto completo | requestHeader |
| pagoPrestamo | Objeto completo | pagoPrestamo |

**Archivo XQuery:** `Middleware/v2/Resources/PagoPrestamo/xq/pagoPrestamoT24In.xq`

**Regla de Negocio:** Procesa el pago del préstamo en T24

### 13.3. Request a ConsultadepagodeprestamoAA

| Campo Origen (OSB) | Transformación/Script | Campo Destino (Servicio) |
|--------------------|----------------------|-------------------------|
| pagoPrestamo/LOAN_NUMBER | fn:string() | numeroPrestamo |
| RequestHeader | Objeto completo | requestHeader |
| RSPPagoPtmoT24/Status/transactionId | fn:string() | transactionId |

**Archivo XQuery:** `Middleware/v2/Resources/PagoPrestamo/xq/consultaPagoPtmoT24In.xq`

**Regla de Negocio:** Consulta los detalles del pago procesado en T24

## 14. Mapeo de Salida - Response Final

### Response Header

| Campo Origen (Interno) | Transformación/Script | Campo Destino (OSB) |
|------------------------|----------------------|-------------------|
| Variable: successIndicator | fn:upper-case() | ResponseHeader/successIndicator |
| Variable: message | fn:string() | ResponseHeader/messages |

### Response Body (ABANKS)

| Campo Origen (DB) | Transformación/Script | Campo Destino (OSB) |
|-------------------|----------------------|-------------------|
| Variable: valueDate | fn:string() | pagoPrestamoResponse/DATE_TIME |
| RESPONSEABANKS/LOAN_NUMBER | fn:string() | pagoPrestamoResponse/LOAN_NUMBER |
| RESPONSEABANKS/DUE_ID | fn:string() | pagoPrestamoResponse/DUE_ID |
| RESPONSEABANKS/PAYMENT_AMOUNT | fn:string() | pagoPrestamoResponse/PAYMENT_AMOUNT |

**Archivo XQuery:** `Middleware/Business_Resources/pagoPrestamo/pagoPrestamo/pagoPrestamoOut.xq`

### Response Body (T24)

| Campo Origen (Servicio) | Transformación/Script | Campo Destino (OSB) |
|------------------------|----------------------|-------------------|
| RSPConsPagoPtmo/WSFICOPAYMENTDETAILSAAType/.../TRANSINDICATOR | fn:string() | Variable: successIndicatorQry2 |
| RSPPagoPtmoT24 | Objeto completo | pagoPrestamoResponse |

**Archivo XQuery:** `Middleware/v2/Resources/PagoPrestamo/xq/pagoPrestamoT24Out.xq`

## 15. Reglas de Negocio Detectadas

### RN-001: Validación de Región
- **Ubicación:** Pipeline ValidacionesGenerales_request, Stage ValidacionServicioRegional
- **Descripción:** Valida que el servicio FICBCO0076 esté habilitado para la región HN01
- **Código:** `Middleware/v2/Resources/Generales/xq/validaServicioRegionalIn.xq`

### RN-002: Determinación de Tipo de Préstamo
- **Ubicación:** Pipeline ValidacionesGenerales_request, Stage ValidacionServicioRegional
- **Descripción:** Determina si el préstamo es de tipo ABANKS o T24
- **Código:** `Middleware/Business_Resources/pagoPrestamo/consultaGeneralPrestamo/validarTipoPrestamo.xq`

### RN-003: Validación de Cruce País-Empresa
- **Ubicación:** Pipeline ValidacionesGenerales_request, Stage ValidacionServicioRegional
- **Descripción:** Valida que el origen y destino sean el mismo país
- **Código:** `Middleware/v2/Resources/Generales/xq/validarCrucePaisEmpresa.xq`

### RN-004: Validación de Productos
- **Ubicación:** Pipeline ABANKS_request, Stage Abanks_proxyRequest
- **Descripción:** Valida que el préstamo y la cuenta existan y estén activos
- **Código:** `Middleware/v2/Resources/PagoPrestamo/xq/pagoPtmoConsProductosIn.xq`

### RN-005: Validación de Monedas
- **Ubicación:** Pipeline ABANKS_request, Stage Abanks_proxyRequest
- **Descripción:** Determina el flujo según si las monedas son iguales o diferentes
- **Código:** Lógica en PagoPrestamo.proxy, línea con condición `$accountCurrency = $loanCurrency`

### RN-006: Generación de UUID
- **Ubicación:** Pipeline ABANKS_request, Stage Abanks_proxyRequest
- **Descripción:** Genera un identificador único para la transacción
- **Código:** `Middleware/Business_Resources/general/UUID/obtenerUUID.xq`

### RN-007: Obtención de Parámetros
- **Ubicación:** Pipeline ABANKS_request, Stage Abanks_proxyRequest
- **Descripción:** Obtiene parámetros de configuración según la moneda del préstamo
- **Código:** `Middleware/Business_Resources/general/Parametrizacion/obtenerParametrizacionIn.xq`

### RN-008: Reversión Automática
- **Ubicación:** Pipeline ABANKS_request, Stage Abanks_proxyRequest
- **Descripción:** Reversa la transferencia si falla el registro en ABANKS
- **Código:** `Middleware/Business_Resources/pagoPrestamo/reversarTransaccion/reversarTransaccionIn.xq`

### RN-009: Mapeo de Errores
- **Ubicación:** Pipeline ValidacionesGenerales_response, Stage MapeoError
- **Descripción:** Mapea códigos de error internos a mensajes estándar
- **Código:** `Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageIn.xq`

### RN-010: Validación de Tipo de Pago
- **Ubicación:** Pipeline ABANKS_request, Stage Abanks_proxyRequest
- **Descripción:** Valida que el tipo de pago sea soportado (ACCOUNT_DEBIT, CASH, OTHER_BANK_CHEQUE)
- **Código:** Lógica en PagoPrestamo.proxy, múltiples condiciones ifThenElse

### RN-011: Selección de Cuenta de Depósito
- **Ubicación:** Pipeline ABANKS_request, Stage Abanks_proxyRequest (OTHER_BANK_CHEQUE)
- **Descripción:** Selecciona la cuenta de depósito según la moneda del préstamo
- **Código:** Lógica en PagoPrestamo.proxy, condiciones para HNL y USD

### RN-012: Validación de Campos Requeridos
- **Ubicación:** Pipeline ABANKS_request, Stage Abanks_proxyRequest
- **Descripción:** Valida que los campos requeridos estén presentes según el tipo de pago
- **Código:** Lógica en PagoPrestamo.proxy, múltiples validaciones de campos vacíos

## 16. Errores del Core T24 - Honduras

### 16.1. Códigos de Estado del Core T24

El core T24 retorna diferentes códigos de estado en el campo `successIndicator` del elemento `Status`:

| Código | Descripción | Acción OSB |
|--------|-------------|------------|
| Success | Transacción exitosa | Continúa flujo normal |
| TWSError | Error en T24 Web Services | Retorna error al cliente |
| T24Error | Error en aplicación T24 | Retorna error al cliente |
| T24Override | Requiere autorización adicional | Retorna error al cliente |
| T24Offline | T24 no disponible | Retorna error al cliente |
| TIMEOUT | Timeout en la transacción | Mensaje: "TRANSACCION EN ESPERA. REVISE SU CUENTA EN 5 MINUTOS" |
| ERROR | Error genérico | Mensaje: "ERROR APLICANDO PAGO A PRESTAMO" |

### 16.2. Errores Específicos de Validación T24

#### 16.2.1. Errores de Cuenta

| Código Error | Mensaje T24 | Descripción |
|--------------|-------------|-------------|
| AC-INVALID.ACCOUNT | Invalid account number | Número de cuenta inválido |
| AC-ACCOUNT.CLOSED | Account is closed | Cuenta cerrada |
| AC-INSUFFICIENT.FUNDS | Insufficient funds | Fondos insuficientes |
| AC-ACCOUNT.BLOCKED | Account is blocked | Cuenta bloqueada |
| AC-CURRENCY.MISMATCH | Currency mismatch | Monedas no coinciden |
| AC-INVALID.CURRENCY | Invalid currency | Moneda inválida |

#### 16.2.2. Errores de Préstamo

| Código Error | Mensaje T24 | Descripción |
|--------------|-------------|-------------|
| AA-INVALID.ARRANGEMENT | Invalid arrangement number | Número de préstamo inválido |
| AA-ARRANGEMENT.CLOSED | Arrangement is closed | Préstamo cerrado |
| AA-PAYMENT.EXCEEDS.BALANCE | Payment exceeds outstanding balance | Pago excede saldo pendiente |
| AA-INVALID.PAYMENT.AMOUNT | Invalid payment amount | Monto de pago inválido |
| AA-PAYMENT.BELOW.MINIMUM | Payment below minimum amount | Pago menor al mínimo permitido |
| AA-ARRANGEMENT.SUSPENDED | Arrangement is suspended | Préstamo suspendido |
| AA-MATURITY.DATE.PASSED | Arrangement maturity date has passed | Fecha de vencimiento pasada |

#### 16.2.3. Errores de Autorización

| Código Error | Mensaje T24 | Descripción |
|--------------|-------------|-------------|
| EB-INVALID.USER | Invalid user | Usuario inválido |
| EB-USER.NOT.AUTHORISED | User not authorised for this function | Usuario no autorizado |
| EB-SIGN.ON.NOT.ALLOWED | Sign on not allowed | Inicio de sesión no permitido |
| EB-PASSWORD.EXPIRED | Password has expired | Contraseña expirada |
| EB-USER.LOCKED | User is locked | Usuario bloqueado |

#### 16.2.4. Errores de Transacción

| Código Error | Mensaje T24 | Descripción |
|--------------|-------------|-------------|
| FT-INVALID.TRANSACTION.TYPE | Invalid transaction type | Tipo de transacción inválido |
| FT-TRANSACTION.NOT.ALLOWED | Transaction not allowed | Transacción no permitida |
| FT-DUPLICATE.TRANSACTION | Duplicate transaction | Transacción duplicada |
| FT-CUTOFF.TIME.PASSED | Cut off time has passed | Hora de corte pasada |
| FT-HOLIDAY.PROCESSING | Holiday processing not allowed | Procesamiento en feriado no permitido |

#### 16.2.5. Errores de Sistema

| Código Error | Mensaje T24 | Descripción |
|--------------|-------------|-------------|
| SYS-DATABASE.ERROR | Database error occurred | Error de base de datos |
| SYS-SYSTEM.UNAVAILABLE | System temporarily unavailable | Sistema temporalmente no disponible |
| SYS-TIMEOUT | System timeout | Timeout del sistema |
| SYS-COMMUNICATION.ERROR | Communication error | Error de comunicación |
| SYS-INVALID.REQUEST | Invalid request format | Formato de request inválido |

### 16.3. Mapeo de Errores en OSB

#### 16.3.1. Transformación de Errores T24 a OSB

**Archivo XQuery:** `Middleware/v2/Resources/PagoPrestamo/xq/pagoPrestamoT24HeaderOut.xq`

```xquery
if ($successIndicatorQry2 = "SUCCESS") then (
    <ns0:ResponseHeader>
        <successIndicator>SUCCESS</successIndicator>
        <messages>Pago procesado exitosamente</messages>
    </ns0:ResponseHeader>
) else (
    <ns0:ResponseHeader>
        <successIndicator>
        {
            if(fn:string($successIndicatorQry2) = "") then (
                "ERROR"
            ) else (
                fn:string($successIndicatorQry2)
            )
        }
        </successIndicator>
        <messages>
        {
            if ($successIndicatorQry2 = "TIMEOUT") then (
                "TRANSACCION EN ESPERA. REVISE SU CUENTA EN 5 MINUTOS"
            ) else if ($successIndicatorQry2 = "ERROR") then (
                "ERROR APLICANDO PAGO A PRESTAMO"
            ) else (
                fn:string-join($pagoaprestamoAAResponse/Status/messages,";")
            )
        }
        </messages>
    </ns0:ResponseHeader>
)
```

#### 16.3.2. Ejemplos de Response con Errores

**Error de Cuenta Inválida:**
```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:pag="http://www.ficohsa.com.hn/middleware.services/pagoPrestamoTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:ResponseHeader>
         <successIndicator>T24Error</successIndicator>
         <messages>AC-INVALID.ACCOUNT - Invalid account number</messages>
      </aut:ResponseHeader>
   </soapenv:Header>
   <soapenv:Body>
      <pag:pagoPrestamoResponse/>
   </soapenv:Body>
</soapenv:Envelope>
```

**Error de Fondos Insuficientes:**
```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:pag="http://www.ficohsa.com.hn/middleware.services/pagoPrestamoTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:ResponseHeader>
         <successIndicator>T24Error</successIndicator>
         <messages>AC-INSUFFICIENT.FUNDS - Insufficient funds</messages>
      </aut:ResponseHeader>
   </soapenv:Header>
   <soapenv:Body>
      <pag:pagoPrestamoResponse/>
   </soapenv:Body>
</soapenv:Envelope>
```

**Error de Préstamo Inválido:**
```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:pag="http://www.ficohsa.com.hn/middleware.services/pagoPrestamoTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:ResponseHeader>
         <successIndicator>T24Error</successIndicator>
         <messages>AA-INVALID.ARRANGEMENT - Invalid arrangement number</messages>
      </aut:ResponseHeader>
   </soapenv:Header>
   <soapenv:Body>
      <pag:pagoPrestamoResponse/>
   </soapenv:Body>
</soapenv:Envelope>
```

**Error de Timeout:**
```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:pag="http://www.ficohsa.com.hn/middleware.services/pagoPrestamoTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:ResponseHeader>
         <successIndicator>TIMEOUT</successIndicator>
         <messages>TRANSACCION EN ESPERA. REVISE SU CUENTA EN 5 MINUTOS</messages>
      </aut:ResponseHeader>
   </soapenv:Header>
   <soapenv:Body>
      <pag:pagoPrestamoResponse/>
   </soapenv:Body>
</soapenv:Envelope>
```

**Error de Sistema No Disponible:**
```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:pag="http://www.ficohsa.com.hn/middleware.services/pagoPrestamoTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:ResponseHeader>
         <successIndicator>T24Offline</successIndicator>
         <messages>SYS-SYSTEM.UNAVAILABLE - System temporarily unavailable</messages>
      </aut:ResponseHeader>
   </soapenv:Header>
   <soapenv:Body>
      <pag:pagoPrestamoResponse/>
   </soapenv:Body>
</soapenv:Envelope>
```

### 16.4. Manejo de Errores en el Flujo

#### 16.4.1. Validación de Response T24

**Ubicación:** Pipeline T24_response, Stage T24_proxyResponse

**Condición de Éxito:**
```xquery
$successIndicatorT24 = "Success"
```

**Condición de Error:**
```xquery
$successIndicatorT24 != "Success"
```

#### 16.4.2. Consulta de Detalles de Pago

Si el pago es exitoso, se consultan los detalles:

**Request a ConsultadepagodeprestamoAA:**

| Campo Origen (OSB) | Transformación/Script | Campo Destino (Servicio) |
|--------------------|----------------------|-------------------------|
| pagoPrestamo/LOAN_NUMBER | fn:string() | numeroPrestamo |
| RequestHeader | Objeto completo | requestHeader |
| RSPPagoPtmoT24/Status/transactionId | fn:string() | transactionId |

**Response de ConsultadepagodeprestamoAA:**

| Campo Origen (Servicio) | Transformación/Script | Campo Destino (OSB) |
|------------------------|----------------------|-------------------|
| WSFICOPAYMENTDETAILSAAType/.../TRANSINDICATOR | fn:string() | Variable: successIndicatorQry2 |
| WSFICOPAYMENTDETAILSAAType/.../TRANSID | fn:string() | pagoPrestamoResponse/TRANSACTION_ID |
| WSFICOPAYMENTDETAILSAAType/.../PAYMENTDATE | fn:string() | pagoPrestamoResponse/PAYMENT_DATE |
| WSFICOPAYMENTDETAILSAAType/.../LOANNUMBER | fn:string() | pagoPrestamoResponse/LOAN_NUMBER |
| WSFICOPAYMENTDETAILSAAType/.../TOTALPAYMENT | fn:string() | pagoPrestamoResponse/TOTAL_PAYMENT |

### 16.6. Códigos de Respuesta del Servicio depositoCombinadoBS

El servicio **depositoCombinadoBS** es utilizado en el flujo de pago con cheques de otros bancos (OTHER_BANK_CHEQUE) y puede retornar diversos códigos de respuesta del core T24.

#### 16.6.1. Operación: Depositocombinado

**Endpoint:** `http://mwomnidesa:7003/svcDepositos/services`
**Operación SOAP:** `Depositocombinado`
**Tipo de Transacción T24:** `TELLER.FINANCIAL.SERVICES`

#### 16.6.2. Tabla de Códigos de Respuesta T24 y Homologación HTTP

| Código T24 | Mensaje T24 | Descripción | Código HTTP Sugerido | Mensaje HTTP |
|------------|-------------|-------------|---------------------|---------------|
| **Success** | Transaction completed successfully | Depósito procesado exitosamente | **200** | OK |
| **TWSError** | T24 Web Services error | Error en servicios web de T24 | **502** | Bad Gateway |
| **T24Error** | T24 application error | Error en aplicación T24 | **422** | Unprocessable Entity |
| **T24Override** | Override required | Requiere autorización adicional | **409** | Conflict |
| **T24Offline** | T24 system offline | Sistema T24 no disponible | **503** | Service Unavailable |
| **TIMEOUT** | Request timeout | Timeout en la solicitud | **408** | Request Timeout |

#### 16.6.3. Errores Específicos de Depósito Combinado

| Código Error T24 | Mensaje T24 | Descripción | Código HTTP | Categoría |
|------------------|-------------|-------------|-------------|----------|
| **TT-INVALID.CHEQUE.NUMBER** | Invalid cheque number | Número de cheque inválido | **400** | Validación |
| **TT-CHEQUE.ALREADY.DEPOSITED** | Cheque already deposited | Cheque ya depositado | **409** | Conflicto |
| **TT-INVALID.BANK.CODE** | Invalid bank code | Código de banco inválido | **400** | Validación |
| **TT-CHEQUE.EXPIRED** | Cheque has expired | Cheque vencido | **422** | Negocio |
| **TT-INSUFFICIENT.CLEARING.BALANCE** | Insufficient clearing balance | Saldo insuficiente para compensación | **422** | Negocio |
| **TT-ACCOUNT.RESTRICTED** | Account has restrictions | Cuenta con restricciones | **403** | Autorización |
| **TT-INVALID.DEPOSIT.ACCOUNT** | Invalid deposit account | Cuenta de depósito inválida | **400** | Validación |
| **TT-CURRENCY.MISMATCH** | Currency mismatch between cheque and account | Monedas no coinciden | **422** | Negocio |
| **TT-AMOUNT.EXCEEDS.LIMIT** | Amount exceeds daily limit | Monto excede límite diario | **422** | Negocio |
| **TT-CLEARING.CUT.OFF.TIME** | Clearing cut off time passed | Hora de corte de compensación pasada | **422** | Negocio |
| **TT-HOLIDAY.PROCESSING** | Holiday processing not allowed | Procesamiento en feriado no permitido | **422** | Negocio |
| **TT-DUPLICATE.TRANSACTION** | Duplicate transaction detected | Transacción duplicada detectada | **409** | Conflicto |
| **TT-INVALID.CHEQUE.FORMAT** | Invalid cheque format | Formato de cheque inválido | **400** | Validación |
| **TT-BANK.NOT.PARTICIPATING** | Bank not participating in clearing | Banco no participa en compensación | **422** | Negocio |
| **TT-CHEQUE.STOP.PAYMENT** | Stop payment on cheque | Orden de no pago en cheque | **422** | Negocio |
| **TT-INVALID.ENDORSEMENT** | Invalid endorsement | Endoso inválido | **422** | Negocio |
| **TT-MICR.READ.ERROR** | MICR reading error | Error de lectura MICR | **422** | Técnico |
| **TT-CLEARING.HOUSE.CLOSED** | Clearing house closed | Cámara de compensación cerrada | **503** | Servicio |
| **TT-INVALID.TRANSACTION.CODE** | Invalid transaction code | Código de transacción inválido | **400** | Validación |
| **TT-CUSTOMER.SIGNATURE.REQUIRED** | Customer signature required | Firma del cliente requerida | **422** | Autorización |

#### 16.6.4. Errores de Sistema y Comunicación

| Código Error T24 | Mensaje T24 | Descripción | Código HTTP | Categoría |
|------------------|-------------|-------------|-------------|----------|
| **SYS-DATABASE.UNAVAILABLE** | Database temporarily unavailable | Base de datos temporalmente no disponible | **503** | Servicio |
| **SYS-NETWORK.ERROR** | Network communication error | Error de comunicación de red | **502** | Red |
| **SYS-MEMORY.INSUFFICIENT** | Insufficient system memory | Memoria del sistema insuficiente | **507** | Recurso |
| **SYS-DISK.FULL** | Disk space full | Espacio en disco lleno | **507** | Recurso |
| **SYS-INVALID.REQUEST.FORMAT** | Invalid request format | Formato de solicitud inválido | **400** | Formato |
| **SYS-AUTHENTICATION.FAILED** | Authentication failed | Autenticación fallida | **401** | Autenticación |
| **SYS-AUTHORIZATION.DENIED** | Authorization denied | Autorización denegada | **403** | Autorización |
| **SYS-RATE.LIMIT.EXCEEDED** | Rate limit exceeded | Límite de velocidad excedido | **429** | Límite |
| **SYS-MAINTENANCE.MODE** | System in maintenance mode | Sistema en modo mantenimiento | **503** | Mantenimiento |
| **SYS-VERSION.MISMATCH** | API version mismatch | Versión de API no coincide | **400** | Versión |

#### 16.6.5. Mapeo de Respuestas en OSB

**Archivo XQuery de Transformación:** `Middleware/v2/Resources/PagoPrestamo/xq/depositoCombinadoHeaderOut.xq`

```xquery
if ($depositoResponse/Status/successIndicator = "Success") then (
    <ns0:ResponseHeader>
        <successIndicator>SUCCESS</successIndicator>
        <messages>Depósito de cheque procesado exitosamente</messages>
        <transactionId>{$depositoResponse/Status/transactionId}</transactionId>
    </ns0:ResponseHeader>
) else (
    <ns0:ResponseHeader>
        <successIndicator>
        {
            if ($depositoResponse/Status/successIndicator = "TIMEOUT") then "TIMEOUT"
            else if ($depositoResponse/Status/successIndicator = "T24Offline") then "SERVICE_UNAVAILABLE"
            else if ($depositoResponse/Status/successIndicator = "T24Override") then "AUTHORIZATION_REQUIRED"
            else "ERROR"
        }
        </successIndicator>
        <messages>
        {
            if ($depositoResponse/Status/successIndicator = "TIMEOUT") then 
                "TRANSACCION EN ESPERA. REVISE SU CUENTA EN 5 MINUTOS"
            else if ($depositoResponse/Status/successIndicator = "T24Offline") then 
                "SERVICIO TEMPORALMENTE NO DISPONIBLE"
            else if ($depositoResponse/Status/successIndicator = "T24Override") then 
                "TRANSACCION REQUIERE AUTORIZACION ADICIONAL"
            else 
                fn:string-join($depositoResponse/Status/messages, "; ")
        }
        </messages>
    </ns0:ResponseHeader>
)
```

#### 16.6.6. Ejemplos de Response con Errores Específicos

**Error de Cheque Ya Depositado:**
```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:pag="http://www.ficohsa.com.hn/middleware.services/pagoPrestamoTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:ResponseHeader>
         <successIndicator>T24Error</successIndicator>
         <messages>TT-CHEQUE.ALREADY.DEPOSITED - Cheque already deposited</messages>
      </aut:ResponseHeader>
   </soapenv:Header>
   <soapenv:Body>
      <pag:pagoPrestamoResponse/>
   </soapenv:Body>
</soapenv:Envelope>
```

**Error de Código de Banco Inválido:**
```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:pag="http://www.ficohsa.com.hn/middleware.services/pagoPrestamoTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:ResponseHeader>
         <successIndicator>T24Error</successIndicator>
         <messages>TT-INVALID.BANK.CODE - Invalid bank code</messages>
      </aut:ResponseHeader>
   </soapenv:Header>
   <soapenv:Body>
      <pag:pagoPrestamoResponse/>
   </soapenv:Body>
</soapenv:Envelope>
```

**Error de Hora de Corte:**
```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:pag="http://www.ficohsa.com.hn/middleware.services/pagoPrestamoTypes"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
   <soapenv:Header>
      <aut:ResponseHeader>
         <successIndicator>T24Error</successIndicator>
         <messages>TT-CLEARING.CUT.OFF.TIME - Clearing cut off time passed</messages>
      </aut:ResponseHeader>
   </soapenv:Header>
   <soapenv:Body>
      <pag:pagoPrestamoResponse/>
   </soapenv:Body>
</soapenv:Envelope>
```

#### 16.6.7. Configuración de Retry para depositoCombinadoBS

**Errores que Permiten Retry:**
- `TIMEOUT` (408)
- `T24Offline` (503)
- `SYS-DATABASE.UNAVAILABLE` (503)
- `SYS-NETWORK.ERROR` (502)

**Errores que NO Permiten Retry:**
- `TT-CHEQUE.ALREADY.DEPOSITED` (409)
- `TT-INVALID.CHEQUE.NUMBER` (400)
- `TT-CHEQUE.EXPIRED` (422)
- `TT-DUPLICATE.TRANSACTION` (409)

**Configuración Sugerida:**
```xml
<retry-count>3</retry-count>
<retry-interval>30</retry-interval>
<retry-application-errors>true</retry-application-errors>
<retry-transport-errors>true</retry-transport-errors>
```

#### 16.6.8. Monitoreo y Alertas

**Métricas Críticas:**
- Tasa de errores `TT-CHEQUE.ALREADY.DEPOSITED`
- Frecuencia de `TIMEOUT`
- Disponibilidad del servicio (`T24Offline`)
- Errores de validación (`TT-INVALID.*`)

**Alertas Recomendadas:**
- Alerta crítica si tasa de `T24Offline` > 5%
- Alerta de advertencia si `TIMEOUT` > 10%
- Alerta informativa para errores de validación > 15%

## 16.7. Códigos de Error Específicos de Honduras

#### 16.7.1. Errores de Negocio Locales

| Código Error | Mensaje | Descripción |
|--------------|---------|-------------|
| HN-LOAN-001 | Préstamo no encontrado en sistema local | El préstamo no existe en la base local |
| HN-LOAN-002 | Préstamo migrado a T24 | El préstamo fue migrado y debe procesarse en T24 |
| HN-ACCT-001 | Cuenta no pertenece al cliente | La cuenta no está asociada al cliente del préstamo |
| HN-CURR-001 | Moneda no soportada para pagos | La moneda no está configurada para pagos |
| HN-PARAM-001 | Parámetros de configuración no encontrados | Faltan parámetros de configuración |

#### 16.7.2. Errores de Integración

| Código Error | Mensaje | Descripción |
|--------------|---------|-------------|
| HN-INT-001 | Error conectando con ABANKS | Falla en conexión con sistema ABANKS |
| HN-INT-002 | Error conectando con T24 | Falla en conexión con sistema T24 |
| HN-INT-003 | Timeout en consulta de productos | Timeout al consultar productos |
| HN-INT-004 | Error en transferencia entre cuentas | Falla en el proceso de transferencia |
| HN-INT-005 | Error en reversión de transacción | Falla al reversar la transacción |
| HN-INT-006 | Error en depósito combinado | Falla en el servicio depositoCombinadoBS |

## 17. Resumen de Dependencias

### Servicios de Base de Datos
1. ValidaServicioRegional (eis/DB/ConnectionInterbanca)
2. pagoPrestamoT24 (eis/DB/ConnectionInterbanca)

### Servicios SOAP Internos
1. sjConsultaProductos
2. consultaGeneralPrestamo
3. ObtenerParametrizacion
4. transferenciasBS (múltiples operaciones)
5. debitoPrestamoBS (múltiples operaciones)
6. depositoCombinadoBS
7. consultaCuentasBS
8. PrestamosT24BS (múltiples operaciones)

### Proxy Services
1. MapeoErrores
2. ReversarTransaccion

### Archivos XQuery
1. validaServicioRegionalIn.xq
2. aplicarValoresPorDefectoRegion.xq
3. validarTipoPrestamo.xq
4. validarCrucePaisEmpresa.xq
5. pagoPtmoConsProductosIn.xq
6. obtenerParametrizacionIn.xq
7. obtenerUUID.xq
8. debitoPrestamoCuentaIn.xq
9. debitoPrestamoCuentaAuthIn.xq
10. pagoPrestamoAuthIn.xq
11. pagoPrestamoIn.xq
12. consultaGeneralPrestamoIn.xq
13. depositoPrestamoEfectivoLocalIn.xq
14. depositoPrestamoEfectivoExtranjeraIn.xq
15. debitoPrestamoChequeLocalIn.xq
16. debitoPrestamoChequeExtranjeraIn.xq
17. consultaDetalleCuentaIn.xq
18. pagoPrestamoT24In.xq
19. consultaPagoPtmoT24In.xq
20. reversarTransaccionIn.xq
21. pagoPrestamoOut.xq
22. pagoPrestamoHeaderOut.xq
23. pagoPrestamoT24Out.xq
24. pagoPrestamoT24HeaderOut.xq
25. mapeoErroresUsageIn.xq
26. mapeoErroresUsageOut.xq
