# Comparación entre Regiones - PagoPrestamo

## Tabla de Comparación General

| Aspecto | HN01 (Honduras) | GT01 (Guatemala) | PA01 (Panamá) | NI01 (Nicaragua) |
|---------|-----------------|------------------|---------------|------------------|
| **Endpoint OSB** | `/SMiddleware/OperationsAndExecution/Payments/PagoPrestamo_v2` | `/SMiddleware/OperationsAndExecution/Payments/PagoPrestamo_v2` | `/SMiddleware/OperationsAndExecution/Payments/PagoPrestamo_v2` | `/SMiddleware/OperationsAndExecution/Payments/PagoPrestamo_v2` |
| **Sistema Core** | T24 + ABANKS | ABANKS | ABANKS | COBIS |
| **Base de Datos** | ORA_BANK (Interbanca) | ConnectionProxyAbanksGT | ConnectionProxyAbanksPA | N/A (Servicio SOAP) |
| **Esquema** | OSB_PAG_PRESTAMO_T24 | OSB_P_PAGO_PRESTAMO | OSB_P_PAGO_PRESTAMO | N/A |
| **Store Procedure** | OSB_PAG_PRESTAMO_T24 | OSB_P_PAGO_PRESTAMO | OSB_P_PAGO_PRESTAMO | N/A |
| **Nombre de Conexión** | eis/DB/ConnectionInterbanca | eis/DB/ConnectionProxyAbanksGT | eis/DB/ConnectionProxyAbanksPA | http://10.235.53.145:9080 |
| **Tipos de Pago Soportados** | ACCOUNT_DEBIT, CASH, OTHER_BANK_CHEQUE | ACCOUNT_DEBIT | ACCOUNT_DEBIT | ACCOUNT_DEBIT |
| **Validación de Tipo Préstamo** | Sí (ABANKS/T24) | No | No | No |
| **Manejo de Monedas** | HNL, USD | Múltiples | Múltiples | Múltiples |
| **Reversión Automática** | Sí | No especificada | No especificada | No especificada |
| **Timeout** | 0 (sin límite) | 0 (sin límite) | 0 (sin límite) | 0 (sin límite) |
| **Retry Count** | 1 | 0 | 0 | 0 |
| **Retry Interval** | 30 segundos | 0 | 0 | 0 |

---

## Detalle por Región

### 1. HN01 (Honduras)

#### 1.1. Características Principales

- **Complejidad:** Alta - Maneja dos sistemas core (T24 y ABANKS)
- **Flujo Dual:** Determina el tipo de préstamo antes de procesar
- **Tipos de Pago:** Soporta los 3 tipos principales (ACCOUNT_DEBIT, CASH, OTHER_BANK_CHEQUE)

#### 1.2. Endpoints y Conexiones

**Base de Datos ABANKS:**
- **Conexión:** eis/DB/ConnectionInterbanca
- **Stored Procedure:** OSB_PAG_PRESTAMO_T24
- **Esquema:** ORA_BANK.OSB_PAG_PRESTAMO_T24

**Servicios T24:**
- **Consulta Cuenta:** Consultadedetallesdelacuenta
- **Pago Préstamo:** PagoaprestamoAA
- **Consulta Pago:** ConsultadepagodeprestamoAA

**Servicios ABANKS:**
- **Consulta Productos:** sjConsultaProductos
- **Consulta General Préstamo:** consultaGeneralPrestamo
- **Transferencias:** Transfmodelbankentrecuentas, Transfentrecuentasinstrcredito, Transferenciaentrecuentas
- **Débito Préstamo:** Depositoenefectivofase11, Depositoenefectivofase12
- **Depósito Combinado:** Depositocombinado

#### 1.3. Transformaciones Clave

**Request a ABANKS (pagoPrestamoIn.xq):**
```xquery
<InputParameters>
    <LOAN_NUMBER>{$pagoPrestamo/LOAN_NUMBER}</LOAN_NUMBER>
    <PAYMENT_AMOUNT>{$pagoPrestamo/PAYMENT_AMOUNT}</PAYMENT_AMOUNT>
    <DEBIT_ACCOUNT>{$pagoPrestamo/DEBIT_ACCOUNT}</DEBIT_ACCOUNT>
    <INTERFACE_REFERENCE_NO>{$pagoPrestamo/INTERFACE_REFERENCE_NO}</INTERFACE_REFERENCE_NO>
    <USERNAME>{$requestHeader/Authentication/UserName}</USERNAME>
    <TRANSACTIONID>{$transactionID}</TRANSACTIONID>
</InputParameters>
```

**Request a T24 (pagoPrestamoT24In.xq):**
```xquery
<InputParameters>
    <LOAN_NUMBER>{$pagoPrestamo/LOAN_NUMBER}</LOAN_NUMBER>
    <PAYMENT_AMOUNT>{$pagoPrestamo/PAYMENT_AMOUNT}</PAYMENT_AMOUNT>
    <DEBIT_ACCOUNT>{$pagoPrestamo/DEBIT_ACCOUNT}</DEBIT_ACCOUNT>
    <INTERFACE_REFERENCE_NO>{$pagoPrestamo/INTERFACE_REFERENCE_NO}</INTERFACE_REFERENCE_NO>
    <USERNAME>{$requestHeader/Authentication/UserName}</USERNAME>
</InputParameters>
```

#### 1.4. Campos Diferenciadores

- **loanType:** Variable que determina si es ABANKS o T24
- **accountCurrency:** Moneda de la cuenta
- **loanCurrency:** Moneda del préstamo
- **creditAccount:** Cuenta de crédito parametrizada
- **trxType:** Tipo de transacción parametrizado
- **uuid:** Identificador único de transacción

#### 1.5. Errores/Excepciones

| Código | Mensaje | Origen |
|--------|---------|--------|
| BEA-382505 | Error de validación XSD | OSB |
| MW-0002 | INVALID REQUEST | OSB |
| MW-0008 | SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY | OSB |
| SUCCESS | Transacción exitosa | Core |
| ERROR | Error genérico | Core |

#### 1.6. Parámetros de Configuración

- **T24T134.{CURRENCY}CREDITACCTNO:** Cuenta de crédito por moneda
- **T24T133.TXNTYPELOANPYMT:** Tipo de transacción para pago de préstamo
- **T24T057.INTACCOUNT.USERS:** Cuenta interna de usuarios
- **T24T032.HNLOBCHQACCTNO:** Cuenta para cheques en HNL
- **T24T032.USDOBCHQACCTNO:** Cuenta para cheques en USD

#### 1.7. Dependencias Internas

1. ValidaServicioRegional (DB)
2. MapeoErrores (Proxy)
3. sjConsultaProductos (Business Service)
4. consultaGeneralPrestamo (Business Service)
5. ObtenerParametrizacion (Business Service)
6. transferenciasBS (Business Service)
7. debitoPrestamoBS (Business Service)
8. depositoCombinadoBS (Business Service)
9. pagoPrestamoT24BS (Business Service)
10. consultaCuentasBS (Business Service)
11. PrestamosT24BS (Business Service)
12. ReversarTransaccion (Proxy)

---

### 2. GT01 (Guatemala)

#### 2.1. Características Principales

- **Complejidad:** Baja - Implementación simplificada
- **Flujo Único:** Solo ABANKS
- **Tipos de Pago:** Solo ACCOUNT_DEBIT

#### 2.2. Endpoints y Conexiones

**Base de Datos:**
- **Conexión:** eis/DB/ConnectionProxyAbanksGT
- **Stored Procedure:** OSB_P_PAGO_PRESTAMO
- **Esquema:** No especificado explícitamente

#### 2.3. Transformaciones Clave

**Request (pagoPtmoGTIn.xq):**
```xquery
<InputParameters>
    <LOAN_NUMBER>{$pagoPrestamo1/LOAN_NUMBER}</LOAN_NUMBER>
    <PAYMENT_AMOUNT>{$pagoPrestamo1/PAYMENT_AMOUNT}</PAYMENT_AMOUNT>
    <DEBIT_ACCOUNT>{$pagoPrestamo1/DEBIT_ACCOUNT}</DEBIT_ACCOUNT>
    <INTERFACE_REFERENCE_NO>{$pagoPrestamo1/INTERFACE_REFERENCE_NO}</INTERFACE_REFERENCE_NO>
    <USERNAME>{$requestHeader1/Authentication/UserName}</USERNAME>
</InputParameters>
```

**Response (pagoPtmoGTOut.xq):**
```xquery
<pagoPrestamoResponse>
    <DATE_TIME>{$outputParameters1/DATE_TIME}</DATE_TIME>
    <LOAN_NUMBER>{$outputParameters1/LOAN_NUMBER}</LOAN_NUMBER>
    <DUE_ID>{$outputParameters1/DUE_ID}</DUE_ID>
    <PAYMENT_AMOUNT>{$outputParameters1/PAYMENT_AMOUNT}</PAYMENT_AMOUNT>
</pagoPrestamoResponse>
```

#### 2.4. Campos Diferenciadores

- **Simplificación:** No requiere validación de tipo de préstamo
- **Sin UUID:** No genera identificador único de transacción
- **Sin Reversión:** No implementa reversión automática

#### 2.5. Errores/Excepciones

| Código | Mensaje | Origen |
|--------|---------|--------|
| SUCCESS | Transacción exitosa | SP |
| ERROR | Error en stored procedure | SP |
| PAYMENT TYPE NOT SUPPORTED | Tipo de pago no soportado | OSB |
| REQUIRED FIELDS NOT SUPPLIED | Campos requeridos faltantes | OSB |

#### 2.6. Dependencias Internas

1. ValidaServicioRegional (DB)
2. MapeoErrores (Proxy)
3. PagoPrestamo_db (Business Service)

---

### 3. PA01 (Panamá)

#### 3.1. Características Principales

- **Complejidad:** Baja - Similar a GT01
- **Flujo Único:** Solo ABANKS
- **Tipos de Pago:** Solo ACCOUNT_DEBIT

#### 3.2. Endpoints y Conexiones

**Base de Datos:**
- **Conexión:** eis/DB/ConnectionProxyAbanksPA
- **Stored Procedure:** OSB_P_PAGO_PRESTAMO
- **Esquema:** No especificado explícitamente

#### 3.3. Transformaciones Clave

**Request (pagoPtmoPAIn.xq):**
```xquery
<InputParameters>
    <LOAN_NUMBER>{$pagoPrestamo1/LOAN_NUMBER}</LOAN_NUMBER>
    <PAYMENT_AMOUNT>{$pagoPrestamo1/PAYMENT_AMOUNT}</PAYMENT_AMOUNT>
    <DEBIT_ACCOUNT>{$pagoPrestamo1/DEBIT_ACCOUNT}</DEBIT_ACCOUNT>
    <INTERFACE_REFERENCE_NO>{$pagoPrestamo1/INTERFACE_REFERENCE_NO}</INTERFACE_REFERENCE_NO>
    <USERNAME>{$requestHeader1/Authentication/UserName}</USERNAME>
</InputParameters>
```

**Response (pagoPtmoPAOut.xq):**
```xquery
<pagoPrestamoResponse>
    <DATE_TIME>{$outputParameters1/DATE_TIME}</DATE_TIME>
    <LOAN_NUMBER>{$outputParameters1/LOAN_NUMBER}</LOAN_NUMBER>
    <DUE_ID>{$outputParameters1/DUE_ID}</DUE_ID>
    <PAYMENT_AMOUNT>{$outputParameters1/PAYMENT_AMOUNT}</PAYMENT_AMOUNT>
</pagoPrestamoResponse>
```

#### 3.4. Campos Diferenciadores

- **Idéntico a GT01:** Misma estructura y lógica
- **Conexión Diferente:** Apunta a base de datos de Panamá

#### 3.5. Errores/Excepciones

| Código | Mensaje | Origen |
|--------|---------|--------|
| SUCCESS | Transacción exitosa | SP |
| ERROR | Error en stored procedure | SP |
| PAYMENT TYPE NOT SUPPORTED | Tipo de pago no soportado | OSB |
| REQUIRED FIELDS NOT SUPPLIED | Campos requeridos faltantes | OSB |

#### 3.6. Dependencias Internas

1. ValidaServicioRegional (DB)
2. MapeoErrores (Proxy)
3. pagoPrestamo_db (Business Service)

---

### 4. NI01 (Nicaragua)

#### 4.1. Características Principales

- **Complejidad:** Media - Integración con COBIS
- **Flujo Único:** COBIS (Servicio SOAP)
- **Tipos de Pago:** Solo ACCOUNT_DEBIT
- **Protocolo:** SOAP 1.2

#### 4.2. Endpoints y Conexiones

**Servicio COBIS:**
- **URL:** http://10.235.53.145:9080/GerenciaProductoPrestamo/SrvAplCobisPrestamoService
- **Operación:** OpPagarPrestamo
- **Protocolo:** SOAP 1.2

#### 4.3. Transformaciones Clave

**Request (pagoPrestamoNIIn.xq):**
```xquery
<opPagarPrestamoSolicitud>
    <contextoTransaccional>
        <identificadorTransaccional>{$pagoPrestamo/INTERFACE_REFERENCE_NO}</identificadorTransaccional>
        <codCanalOriginador>1</codCanalOriginador>
        <ipConsumidor>OMNICANAL</ipConsumidor>
    </contextoTransaccional>
    <transaccion>
        <valMonto>{$pagoPrestamo/PAYMENT_AMOUNT}</valMonto>
    </transaccion>
    <prestamo>
        <producto>
            <valNumeroProducto>{$pagoPrestamo/LOAN_NUMBER}</valNumeroProducto>
        </producto>
    </prestamo>
    <cuenta>
        <codCuentaHabiente>{$pagoPrestamo/DEBIT_ACCOUNT}</codCuentaHabiente>
    </cuenta>
    <oficina>
        <codOficina>1</codOficina>
    </oficina>
    <moneda>
        <multimoneda>N</multimoneda>
    </moneda>
    <canal>
        <servicio>10</servicio>
    </canal>
</opPagarPrestamoSolicitud>
```

**Response (pagoPrestamoNIOut.xq):**
```xquery
<pagoPrestamoResponse>
    <DATE_TIME>{convertirFecha($opPagarPrestamoRespuesta/pagoPrestamo/transaccion/fecAplicacion)}</DATE_TIME>
    <LOAN_NUMBER>{$opPagarPrestamoRespuesta/pagoPrestamo/prestamo/producto/valNumeroProducto}</LOAN_NUMBER>
    <DUE_ID></DUE_ID>
    <PAYMENT_AMOUNT>{$opPagarPrestamoRespuesta/pagoPrestamo/transaccion/valMonto}</PAYMENT_AMOUNT>
</pagoPrestamoResponse>
```

#### 4.4. Campos Diferenciadores

- **contextoTransaccional:** Información de contexto COBIS
- **codCanalOriginador:** Código de canal (1)
- **ipConsumidor:** IP del consumidor (OMNICANAL)
- **codOficina:** Código de oficina (1)
- **multimoneda:** Indicador de multimoneda (N)
- **servicio:** Código de servicio (10)
- **Conversión de Fecha:** Formato yyyy-MM-dd a yyyyMMdd

#### 4.5. Errores/Excepciones

| Código | Mensaje | Origen |
|--------|---------|--------|
| SUCCESS | Transacción exitosa | COBIS |
| Error | Error en COBIS | COBIS |
| PAYMENT TYPE NOT SUPPORTED | Tipo de pago no soportado | OSB |

#### 4.6. Dependencias Internas

1. ValidaServicioRegional (DB)
2. MapeoErrores (Proxy)
3. prestamo (Business Service - COBIS)

---

## Diferencias Clave entre Regiones

### 1. Arquitectura

| Región | Arquitectura | Complejidad |
|--------|--------------|-------------|
| HN01 | Dual (T24 + ABANKS) | Alta |
| GT01 | Simple (ABANKS) | Baja |
| PA01 | Simple (ABANKS) | Baja |
| NI01 | SOAP (COBIS) | Media |

### 2. Tipos de Pago

| Tipo de Pago | HN01 | GT01 | PA01 | NI01 |
|--------------|------|------|------|------|
| ACCOUNT_DEBIT | ✓ | ✓ | ✓ | ✓ |
| CASH | ✓ | ✗ | ✗ | ✗ |
| OTHER_BANK_CHEQUE | ✓ | ✗ | ✗ | ✗ |
| OWN_CHEQUE | ✗ | ✗ | ✗ | ✗ |

### 3. Manejo de Transacciones

| Aspecto | HN01 | GT01 | PA01 | NI01 |
|---------|------|------|------|------|
| UUID | ✓ | ✗ | ✗ | ✗ |
| Reversión Automática | ✓ | ✗ | ✗ | ✗ |
| Validación de Moneda | ✓ | ✗ | ✗ | ✗ |
| Parametrización | ✓ | ✗ | ✗ | ✗ |

### 4. Integración

| Aspecto | HN01 | GT01 | PA01 | NI01 |
|---------|------|------|------|------|
| Protocolo | DB Adapter | DB Adapter | DB Adapter | SOAP 1.2 |
| Retry | ✓ (1x30s) | ✗ | ✗ | ✗ |
| Timeout | 0 | 0 | 0 | 0 |
| Connection Pooling | ✓ | ✓ | ✓ | ✗ |

---

## Conclusiones

1. **HN01 es la región más compleja** con soporte para múltiples tipos de pago y sistemas core
2. **GT01 y PA01 son idénticas** en implementación, solo difieren en la conexión de base de datos
3. **NI01 es única** por usar COBIS con protocolo SOAP en lugar de stored procedures
4. **Todas las regiones** comparten el mismo contrato de servicio OSB
5. **La validación regional** es común a todas las regiones
6. **El manejo de errores** es consistente pero con diferentes niveles de detalle

---

## Recomendaciones de Migración

1. **Priorizar HN01** por su complejidad y criticidad
2. **Agrupar GT01 y PA01** en la misma fase de migración
3. **Tratar NI01 separadamente** por su arquitectura diferente
4. **Estandarizar el manejo de errores** entre regiones
5. **Implementar retry y timeout** en todas las regiones
6. **Centralizar la parametrización** para facilitar mantenimiento
