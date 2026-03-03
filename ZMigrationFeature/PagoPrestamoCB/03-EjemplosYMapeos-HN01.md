# Ejemplos y Mapeos - HN01 (Honduras)

## Request OSB (Ejemplo JSON/XML)

### Request SOAP Completo

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType"
                  xmlns:pag="http://www.ficohsa.com.hn/middleware.services/pagoPrestamoTypes">
   <soapenv:Header>
      <aut:RequestHeader>
         <Authentication>
            <UserName>CORRESPONSAL_001</UserName>
            <Password>P@ssw0rd123</Password>
         </Authentication>
         <Region>
            <SourceBank>HN01</SourceBank>
         </Region>
         <BankingCorrespondent>
            <Id>CB001</Id>
            <PointOfSale>POS001</PointOfSale>
            <SubPointOfSale>SUBPOS001</SubPointOfSale>
         </BankingCorrespondent>
      </aut:RequestHeader>
   </soapenv:Header>
   <soapenv:Body>
      <pag:pagoPrestamo>
         <LOAN_NUMBER>1234567890</LOAN_NUMBER>
         <PAYMENT_AMOUNT>5000.00</PAYMENT_AMOUNT>
         <PAYMENT_CURRENCY>HNL</PAYMENT_CURRENCY>
         <PAYMENT_TYPE>CASH</PAYMENT_TYPE>
         <TRANSACTION_ID_BC>TXN-CB001-20240115-001</TRANSACTION_ID_BC>
      </pag:pagoPrestamo>
   </soapenv:Body>
</soapenv:Envelope>
```

---

## Response OSB (Ejemplo JSON/XML)

### Response SOAP Exitoso

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType"
                  xmlns:pag="http://www.ficohsa.com.hn/middleware.services/pagoPrestamoTypes">
   <soapenv:Header>
      <aut:ResponseHeader>
         <successIndicator>SUCCESS</successIndicator>
         <messages>Pago de préstamo procesado exitosamente</messages>
         <transactionId>FT24015001234</transactionId>
      </aut:ResponseHeader>
   </soapenv:Header>
   <soapenv:Body>
      <pag:pagoPrestamoResponse>
         <DATE_TIME>2024-01-15T10:30:45</DATE_TIME>
         <LOAN_NUMBER>1234567890</LOAN_NUMBER>
         <DUE_ID>001</DUE_ID>
         <PAYMENT_CURRENCY>HNL</PAYMENT_CURRENCY>
         <PAYMENT_AMOUNT>5000.00</PAYMENT_AMOUNT>
         <PAYMENT_SUBTOTAL_AMOUNT>4850.00</PAYMENT_SUBTOTAL_AMOUNT>
         <PAYMENT_ADVANCE>150.00</PAYMENT_ADVANCE>
         <LOAN_CUSTOMER_NAME>JUAN PEREZ LOPEZ</LOAN_CUSTOMER_NAME>
         <INTEREST_RATE>12.50</INTEREST_RATE>
         <EFFECTIVE_DATE>2023-01-15</EFFECTIVE_DATE>
         <MATURITY_DATE>2025-01-15</MATURITY_DATE>
         <INTEREST_BALANCE>1250.00</INTEREST_BALANCE>
         <CURRENT_PRINCIPAL_BALANCE>45000.00</CURRENT_PRINCIPAL_BALANCE>
         <PREVIOUS_PRINCIPAL_BALANCE>50000.00</PREVIOUS_PRINCIPAL_BALANCE>
         <BILL_NUMBER>BILL-2024-001</BILL_NUMBER>
         <RTEFORM>RTF-001</RTEFORM>
         <PAYMENT_DETAILS>
            <DETAIL_RECORD>
               <LABEL>Capital</LABEL>
               <VALUE>4500.00</VALUE>
            </DETAIL_RECORD>
            <DETAIL_RECORD>
               <LABEL>Intereses</LABEL>
               <VALUE>500.00</VALUE>
            </DETAIL_RECORD>
         </PAYMENT_DETAILS>
      </pag:pagoPrestamoResponse>
   </soapenv:Body>
</soapenv:Envelope>
```

### Response SOAP con Error

```xml
<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/"
                  xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType"
                  xmlns:pag="http://www.ficohsa.com.hn/middleware.services/pagoPrestamoTypes">
   <soapenv:Header>
      <aut:ResponseHeader>
         <successIndicator>ERROR</successIndicator>
         <messages>FICBCO0211: Moneda inválida para transacción</messages>
      </aut:ResponseHeader>
   </soapenv:Header>
   <soapenv:Body>
      <pag:pagoPrestamoResponse/>
   </soapenv:Body>
</soapenv:Envelope>
```

---

## Cadenas de Conexión y Credenciales

### 1. Base de Datos - Collections

**Nombre de Conexión:** `eis/DB/ConnectionCollections`

**Esquema:** `COLLECTIONS`

**Package:** `OSB_P_MANEJO_TRANSACCIONES`

**Stored Procedures:**

#### SP 1: REGISTRA_TRANSACCION_CANAL
```sql
COLLECTIONS.OSB_P_MANEJO_TRANSACCIONES.REGISTRA_TRANSACCION_CANAL(
    PV_CORRESPONSAL VARCHAR2,           -- UserName del corresponsal
    PN_TIPO_TRANSACCION NUMBER,         -- 4 (Pago de Préstamo)
    PV_CODIGO_CANAL VARCHAR2,           -- '1' (Canal)
    PV_ESTADO_TRANSACCION VARCHAR2,     -- 'REGISTRADO'
    PN_MONTO NUMBER,                    -- PAYMENT_AMOUNT
    PV_MONEDA VARCHAR2,                 -- PAYMENT_CURRENCY
    PV_CODIGO_PAIS VARCHAR2,            -- SourceBank (HN01)
    PV_CLAVE_CORRESPONSAL VARCHAR2,     -- TRANSACTION_ID_BC
    PV_REFERENCIA_T24 VARCHAR2,         -- '' (vacío)
    PV_CLAVE_TRANSACCION VARCHAR2,      -- LOAN_NUMBER
    PV_COD_CORRESPONSAL VARCHAR2,       -- BankingCorrespondent/Id
    PV_PUNTO_VENTA_CORR VARCHAR2,       -- BankingCorrespondent/PointOfSale
    PV_SUB_PUNTO_VENTA_CORR VARCHAR2,   -- BankingCorrespondent/SubPointOfSale
    PV_IDENTIDAD_SOLICITANTE VARCHAR2,  -- NULL
    PV_NOMBRE_SOLICITANTE VARCHAR2,     -- NULL
    PV_NUMERO_CUENTA VARCHAR2,          -- NULL
    PV_TOKEN_ID VARCHAR2,               -- NULL
    PV_ID_TRANSACCION_COMISION VARCHAR2,-- NULL
    PD_MONTO_COMISION NUMBER,           -- NULL
    PV_MONEDA_COMISION VARCHAR2,        -- NULL
    PV_REFERENCIA_T24_REV VARCHAR2,     -- NULL
    OUT PV_ERRORCODE VARCHAR2,
    OUT PV_ERRORMESSAGE VARCHAR2
)
```

#### SP 2: ACTUALIZA_ESTADO_TRANSACCION
```sql
COLLECTIONS.OSB_P_MANEJO_TRANSACCIONES.ACTUALIZA_ESTADO_TRANSACCION(
    PV_TIPO_TRANSACCION VARCHAR2,       -- 'PAGO_PRESTAMO'
    PN_TIPO_CONSULTA NUMBER,            -- 1
    PV_CODIGO VARCHAR2,                 -- TRANSACTION_ID_BC
    PV_ESTADO_TRANSACCION VARCHAR2,     -- 'TRANSACCION_EXITOSA' o estado actual
    PV_FT VARCHAR2,                     -- transactionId del response
    PV_REF_T24 VARCHAR2,                -- '' (vacío)
    PV_TIPO_ACTUALIZACION VARCHAR2,     -- 'TENGO'
    OUT PV_ERRORCODE VARCHAR2,
    OUT PV_ERRORMESSAGE VARCHAR2
)
```

### 2. Base de Datos - Middleware

**Nombre de Conexión:** `eis/DB/ConnectionMiddleware`

**Stored Procedures:**

#### SP 3: MW_P_VALIDA_SERVICIO_REGIONAL
```sql
MW_P_VALIDA_SERVICIO_REGIONAL(
    PV_CODIGO_SERVICIO VARCHAR2,        -- 'FICBCO0211'
    PV_CODIGO_PAIS VARCHAR2,            -- SourceBank (HN01)
    OUT PV_CODIGO_ERROR VARCHAR2,       -- 'SUCCESS' si válido
    OUT PV_MENSAJE_ERROR VARCHAR2
)
```

#### SP 4: MW_P_VALIDA_CORBAN
```sql
MW_P_VALIDA_CORBAN(
    PV_COD_CORRESPONSAL VARCHAR2,       -- BankingCorrespondent/Id
    PN_TIPO_TRANSACCION VARCHAR2,       -- '2' (Pago de Préstamo)
    PV_CODIGO_PAIS VARCHAR2,            -- SourceBank (HN01)
    OUT PV_CODIGO_MENSAJE VARCHAR2,     -- 'SUCCESS' si válido
    OUT PV_MENSAJE_ERROR VARCHAR2,
    OUT PV_CUENTA_DEBITO VARCHAR2,      -- Cuenta del corresponsal
    OUT PV_MONEDA_PERMITIDA VARCHAR2,   -- Moneda válida
    OUT PV_TIPO_TRANSACCION VARCHAR2    -- Tipo de transacción
)
```

#### SP 5: MW_P_REGISTRAR_USO_SERVICIO
```sql
MW_P_REGISTRAR_USO_SERVICIO(
    PV_ID_SERVICIO VARCHAR2,            -- 'FICBCO0211'
    PV_ID_USUARIO VARCHAR2,             -- UserName
    PV_BANCO_ORIGEN VARCHAR2,           -- SourceBank (HN01)
    PN_OPERACION NUMBER,                -- 1 (tomar cuota) o 2 (liberar cuota)
    OUT PN_CODIGO_ERROR NUMBER          -- 0 si exitoso
)
```

### 3. Servicio WSDL - PagoPrestamoCaja

**Endpoint:** `http://mwinterbanca:8003/MiddlewareCaja/PagoPrestamoCaja`

**Operación:** `pagoPrestamo`

**WSDL:** `Middleware/v2/BusinessServices/OSB/PagoPrestamoCB/wsdl/PagoPrestamoCaja.wsdl`

**Namespace:** `http://www.ficohsa.com.hn/middleware.services/pagoPrestamoPS/`

**Timeout:** 0 (sin límite)

**Retry:** 0 (sin reintentos)

---

## Tablas de Mapeo

### Mapeo de Entrada - Transformación de Header

**Servicio:** PagoPrestamoCB (OSB → Caja)

**XQuery:** `Middleware/v2/Resources/PagoPrestamoCB/xq/PagoPrestamoCBHdrIn.xq`

| Campo Origen (OSB) | Transformación/Script | Campo Destino (Caja) |
|--------------------|----------------------|----------------------|
| RequestHeader/Authentication/UserName | `fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($UserName)))/username` con fail-over a valor original | AutenticacionRequestHeader/UserName |
| RequestHeader/Authentication/Password | `fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($UserName)))/password` con fail-over a valor original | AutenticacionRequestHeader/Password |

**Regla de Negocio:**
- Busca credenciales en servicio LDAP usando el path `Middleware/Security/{USERNAME}`
- Si no encuentra credenciales en LDAP, usa las credenciales del request original
- Implementado con función `fn-bea:fail-over()`

**Fragmento de Código:**
```xquery
declare function getUsername ($LDAPUsername as xs:string) as xs:string { 
    let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
    return $data/con:username/text()
};

declare function getPassword ($LDAPUsername as xs:string) as xs:string {      
    let $data := fn-bea:lookupBasicCredentials(concat("Middleware/Security/", upper-case($LDAPUsername)))
    return $data/con:password/text()
};
```

### Mapeo de Entrada - Transformación de Body

**Servicio:** PagoPrestamoCB (OSB → Caja)

**XQuery:** `Middleware/v2/Resources/PagoPrestamoCB/xq/PagoPrestamoCBIn.xq`

| Campo Origen (OSB) | Transformación/Script | Campo Destino (Caja) |
|--------------------|----------------------|----------------------|
| pagoPrestamo/LOAN_NUMBER | `ficohsa.utilities.Utilities.FormatearPrestamo(LOAN_NUMBER)` (Java Callout) | pagoPrestamo/LOAN_NUMBER |
| pagoPrestamo/PAYMENT_AMOUNT | `data($pagoPrestamo1/PAYMENT_AMOUNT)` | pagoPrestamo/PAYMENT_AMOUNT |
| pagoPrestamo/PAYMENT_CURRENCY | `data($pagoPrestamo1/PAYMENT_CURRENCY)` | pagoPrestamo/PAYMENT_CURRENCY |
| pagoPrestamo/PAYMENT_TYPE | Si CASH: `'ACCOUNT_DEBIT'`, sino: valor original | pagoPrestamo/PAYMENT_TYPE |
| pagoPrestamo/DEBIT_ACCOUNT | Si CASH: `$cuentaDebito` (de consulta corresponsal), sino: valor original | pagoPrestamo/DEBIT_ACCOUNT |
| pagoPrestamo/CHEQUE_NUMBER | `data($pagoPrestamo1/CHEQUE_NUMBER)` (opcional) | pagoPrestamo/CHEQUE_NUMBER |
| pagoPrestamo/BANK_CODE | `data($pagoPrestamo1/BANK_CODE)` (opcional) | pagoPrestamo/BANK_CODE |
| pagoPrestamo/INTERFACE_REFERENCE_NO | `data($pagoPrestamo1/INTERFACE_REFERENCE_NO)` (opcional) | pagoPrestamo/INTERFACE_REFERENCE_NO |
| (Hardcoded) | `"CODIGO_CORRESPONSAL"` | pagoPrestamo/DESCRIPTION |
| pagoPrestamo/TRANSACTION_ID_BC | `data($pagoPrestamo1/TRANSACTION_ID_BC)` | pagoPrestamo/REPAY_TYPE |

**Reglas de Negocio:**

1. **Formateo de Número de Préstamo:**
   - Ubicación: Stage PagoPrestamo
   - Java Callout: `ficohsa.utilities.Utilities.FormatearPrestamo`
   - Archivo JAR: `Middleware/v2/Resources/Utilities/Java/Utilities`

2. **Conversión de Tipo de Pago CASH:**
   - Ubicación: Stage PagoPrestamo
   - Condición: `$tipoPago = 'CASH'`
   - Acción:
     ```xquery
     DEBIT_ACCOUNT = $cuentaDebito
     PAYMENT_TYPE = 'ACCOUNT_DEBIT'
     ```

3. **Sobrescritura de Campos:**
   - DESCRIPTION siempre se establece en "CODIGO_CORRESPONSAL"
   - REPAY_TYPE se establece con el TRANSACTION_ID_BC del request

**Fragmento de Código:**
```xquery
<ns0:pagoPrestamo>
    <LOAN_NUMBER>{ data($pagoPrestamo1/LOAN_NUMBER) }</LOAN_NUMBER>
    <PAYMENT_AMOUNT>{ data($pagoPrestamo1/PAYMENT_AMOUNT) }</PAYMENT_AMOUNT>
    <PAYMENT_CURRENCY>{ data($pagoPrestamo1/PAYMENT_CURRENCY) }</PAYMENT_CURRENCY>
    <PAYMENT_TYPE>{ data($pagoPrestamo1/PAYMENT_TYPE) }</PAYMENT_TYPE>
    <DEBIT_ACCOUNT>{ data($DEBIT_ACCOUNT) }</DEBIT_ACCOUNT>
    <DESCRIPTION>{ "CODIGO_CORRESPONSAL" }</DESCRIPTION>
    <REPAY_TYPE>{ data($pagoPrestamo1/TRANSACTION_ID_BC) }</REPAY_TYPE>
</ns0:pagoPrestamo>
```

### Mapeo de Salida - Response de Caja a OSB

**Servicio:** PagoPrestamoCB (Caja → OSB)

| Campo Origen (Caja) | Transformación/Script | Campo Destino (OSB) |
|---------------------|----------------------|---------------------|
| ResponseHeader/successIndicator | `fn:upper-case(fn:string($RSPHdrPagoPrestamo/aut:ResponseHeader/successIndicator/text()))` | ResponseHeader/successIndicator |
| ResponseHeader/messages | `fn:upper-case(fn:string($RSPHdrPagoPrestamo/aut:ResponseHeader/messages/text()))` | ResponseHeader/messages |
| ResponseHeader/transactionId | `fn:string($RSPHdrPagoPrestamo/aut:ResponseHeader/transactionId/text())` | ResponseHeader/transactionId |
| pagoPrestamoResponse/* | Sin transformación (paso directo) | pagoPrestamoResponse/* |

**Regla de Negocio:**
- El response del servicio de caja se pasa directamente al cliente
- Solo se transforman los indicadores de éxito a mayúsculas
- Si hay error, se mapea usando el servicio MapeoErrores

---

## Mapeo de Entrada - Registro de Transacción

**Servicio:** registraEstadoTransaccion_db

**XQuery:** `Middleware/v2/Resources/PagoPrestamoCB/xq/registraTransaccionPrestamo.xq`

| Campo Origen (OSB) | Transformación/Script | Campo Destino (BD) |
|--------------------|----------------------|-------------------|
| RequestHeader/Authentication/UserName | `data($requestHeader/Authentication/UserName)` | PV_CORRESPONSAL |
| (Hardcoded) | `'4'` | PN_TIPO_TRANSACCION |
| (Hardcoded) | `'1'` | PV_CODIGO_CANAL |
| (Hardcoded) | `'REGISTRADO'` | PV_ESTADO_TRANSACCION |
| pagoPrestamo/PAYMENT_AMOUNT | `data($pagoPrestamo/PAYMENT_AMOUNT)` | PN_MONTO |
| pagoPrestamo/PAYMENT_CURRENCY | `data($pagoPrestamo/PAYMENT_CURRENCY)` | PV_MONEDA |
| RequestHeader/Region/SourceBank | `data($requestHeader/Region/SourceBank)` | PV_CODIGO_PAIS |
| pagoPrestamo/TRANSACTION_ID_BC | `data($pagoPrestamo/TRANSACTION_ID_BC)` | PV_CLAVE_CORRESPONSAL |
| (Hardcoded) | `''` (vacío) | PV_REFERENCIA_T24 |
| pagoPrestamo/LOAN_NUMBER | `data($pagoPrestamo/LOAN_NUMBER)` | PV_CLAVE_TRANSACCION |
| RequestHeader/BankingCorrespondent/Id | `data($requestHeader/BankingCorrespondent/Id)` | PV_COD_CORRESPONSAL |
| RequestHeader/BankingCorrespondent/PointOfSale | `data($requestHeader/BankingCorrespondent/PointOfSale)` | PV_PUNTO_VENTA_CORR |
| RequestHeader/BankingCorrespondent/SubPointOfSale | `data($requestHeader/BankingCorrespondent/SubPointOfSale)` | PV_SUB_PUNTO_VENTA_CORR |

---

## Mapeo de Salida - Actualización de Estado

**Servicio:** actualizaEstadoTransaccion_db

**XQuery:** `Middleware/v2/Resources/PagoPrestamoCB/xq/actualizaEstadoTransaccionPrestamo.xq`

| Campo Origen (OSB) | Transformación/Script | Campo Destino (BD) |
|--------------------|----------------------|-------------------|
| (Hardcoded) | `'PAGO_PRESTAMO'` | PV_TIPO_TRANSACCION |
| (Hardcoded) | `1` | PN_TIPO_CONSULTA |
| $codigoCorresponsal | Variable del flujo | PV_CODIGO |
| $estadotrxTengo | `if(fn:string($transactionId) != '') then 'TRANSACCION_EXITOSA' else $estadotrxTengo` | PV_ESTADO_TRANSACCION |
| $transactionId | `fn:string($transactionId/text())` | PV_FT |
| (Hardcoded) | `''` (vacío) | PV_REF_T24 |
| (Hardcoded) | `'TENGO'` | PV_TIPO_ACTUALIZACION |

**Estados Posibles de $estadotrxTengo:**
- `'REGISTRADO'`
- `'VALIDACION_REGIONAL'`
- `'VALIDACION_REGIONAL_EXITOSA'`
- `'VALIDANDO_PARAMETRIA_CORRESPONSAL'`
- `'PARAMETRIA_OBTENIDA_CORRECTAMENTE'`
- `'REALIZANDO_LLAMADO_PAGO_PRESTAMO_CAJA'`
- `'TRANSACCION_EXITOSA'`
- `'ERROR_OBTENIENDO_SERVICIO_REGIONAL'`
- `'ERROR_OBTENIENDO_PARAMETRIZACION_CORRESPONSAL'`
- `'ERROR_MONEDA_INVALIDA'`
- `'TIPO_DE_PAGO_NO_ES_CASH'`

---

## Reglas de Negocio Detalladas

### Regla 1: Validación de Tipo de Pago

**Ubicación:** `PagoPrestamoCB.proxy` - Stage `PagoPrestamo`

**Condición:**
```xquery
$tipoPago = 'CASH'
```

**Acción si cumple:**
```xml
<con5:replace varName="REQPagoPrestamo" contents-only="true">
    <con5:location>./DEBIT_ACCOUNT</con5:location>
    <con5:expr>$cuentaDebito</con5:expr>
</con5:replace>
<con5:replace varName="REQPagoPrestamo" contents-only="true">
    <con5:location>./PAYMENT_TYPE</con5:location>
    <con5:expr>'ACCOUNT_DEBIT'</con5:expr>
</con5:replace>
```

**Acción si NO cumple:**
```xml
<con5:Error>
    <con5:errCode>MW-0002</con5:errCode>
    <con5:message>Los tipos de pago de prestamo permitidos deben ser Cash</con5:message>
</con5:Error>
```

**Justificación:**
Los pagos en efectivo a través de corresponsales bancarios se debitan de la cuenta del corresponsal, no del cliente. Por eso se cambia el tipo de pago a ACCOUNT_DEBIT y se usa la cuenta del corresponsal obtenida de la parametrización.

### Regla 2: Validación de Moneda

**Ubicación:** `PagoPrestamoCB.proxy` - Stage `ValidarCorresponsal`

**Condición:**
```xquery
$body/pag:pagoPrestamo/PAYMENT_CURRENCY/text() != $monedaValida
```

**Acción si NO cumple:**
```xml
<con3:replace varName="header" contents-only="true">
    <con3:expr>
        <aut:ResponseHeader>
            <successIndicator>ERROR</successIndicator>
            <messages>MONEDA INVALIDA PARA TRANSACCION</messages>
        </aut:ResponseHeader>
    </con3:expr>
</con3:replace>
<con5:reply/>
```

**Justificación:**
Cada corresponsal bancario tiene configuradas las monedas permitidas para operar. Esta validación asegura que solo se procesen transacciones en las monedas autorizadas para ese corresponsal específico.

### Regla 3: Control de Cuotas de Uso

**Ubicación:** `PagoPrestamoCB.proxy` - Stage `ValidacionUsoServicio`

**Operación 1 - Tomar Cuota:**
```
Parámetros:
- PV_ID_SERVICIO: "FICBCO0211"
- PV_ID_USUARIO: $username
- PV_BANCO_ORIGEN: $sourceBank
- PN_OPERACION: 1
```

**Operación 2 - Liberar Cuota:**
```
Parámetros:
- PV_ID_SERVICIO: "FICBCO0211"
- PV_ID_USUARIO: $username
- PV_BANCO_ORIGEN: $sourceBank
- PN_OPERACION: 2
```

**Excepción:**
No se libera cuota si el error es MW-0001 (cuota excedida), ya que nunca se tomó la cuota.

**Justificación:**
Controla el número de transacciones concurrentes que un usuario puede realizar, evitando sobrecarga del sistema y asegurando disponibilidad para todos los usuarios.

---

**Fecha de Análisis:** 2024
**Versión del Documento:** 1.0
