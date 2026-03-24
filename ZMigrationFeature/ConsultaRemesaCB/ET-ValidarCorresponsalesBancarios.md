# Migración AWS Aurora — Lambda Validación Corresponsales Bancarios

## Control de Cambios

| Fecha | Versión | Cambio | Autor |
|-------|---------|--------|-------|
| 2026-03-12 | v1.0 | **Creación del Documento** | **David Julian Molano Peralta** |

[[_TOC_]]

---
## 1. Resumen Ejecutivo

Este documento describe la migración de dos tablas Oracle (`MW_CORRESPONSALES_BANCARIOS` y `MW_TRANSACCIONES_CORBAN`) y su stored procedure asociado (`MW_P_VALIDA_CORBAN`) desde una base de datos Oracle hacia **AWS Aurora Serverless PostgreSQL**.

El proceso de migración incluye:
- Rediseño del esquema con nomenclatura **BIAN (Banking Industry Architecture Network)**
- Reescritura del stored procedure en **PL/pgSQL** (compatible con Aurora PostgreSQL)
- Construcción de una **AWS Lambda** en Node.js que expone el SP como endpoint REST
- Definición de estrategia de manejo de errores y logging

| Componente Original | Componente AWS | Identificador |
|---|---|---|
| Oracle Schema `MIDDLEWARE` | Aurora PostgreSQL Schema `correspondentBank` | `ban-xrs-ic-rds-aurora-postgresql-{env}` |
| `MW_CORRESPONSALES_BANCARIOS` | `correspondent_bank` | — |
| `MW_TRANSACCIONES_CORBAN` | `correspondent_bank_transaction` | — |
| `MW_P_VALIDA_CORBAN` | `sp_validate_correspondent_bank` | `ban-xrs-ic-sp-validate-bank-correspondent-{env}` |
| _(no existía)_ | Lambda Validación | `ban-xrs-ic-lam-validate-bank-correspondent-{env}` |

---

## 2. Mapeo de Nomenclatura BIAN

### 2.1 Tablas

| Nombre Original (Oracle) | Nombre BIAN (Aurora PostgreSQL) | Descripción |
|---|---|---|
| `MW_CORRESPONSALES_BANCARIOS` | `correspondent_bank` | Registro maestro de corresponsales bancarios autorizados |
| `MW_TRANSACCIONES_CORBAN` | `correspondent_bank_transaction` | Catálogo de transacciones habilitadas por corresponsal |

### 2.2 Campos — `MW_CORRESPONSALES_BANCARIOS` → `correspondent_bank`

| Campo Original | Campo BIAN | Tipo Original | Tipo Aurora | Descripción |
|---|---|---|---|---|
| `CODIGO_CORRESPONSAL` | `correspondent_party_reference` | `VARCHAR2` | `VARCHAR(20)` | Identificador único del corresponsal |
| `NOMBRE_CORRESPONSAL` | `correspondent_party_name` | `VARCHAR2` | `VARCHAR(200)` | Nombre comercial del corresponsal |
| `ESTADO` | `status` | `VARCHAR2(1)` | `CHAR(1)` | Estado: `A`=Activo, `I`=Inactivo |
| `CUENTA_CREDITO` | `credit_account_reference` | `VARCHAR2` | `VARCHAR(50)` | Número de cuenta para crédito |
| `CUENTA_DEBITO` | `debit_account_reference` | `VARCHAR2` | `VARCHAR(50)` | Número de cuenta para débito |
| `MONEDA_PERMITIDA` | `permitted_currency_code` | `VARCHAR2` | `VARCHAR(3)` | Código ISO 4217 de moneda permitida |
| `CODIGO_PAIS` | `country_code` | `VARCHAR2` | `VARCHAR(10)` | Código del país (ej. `HN01`) |
| `CUENTA_COMISION` | `commission_account_reference` | `VARCHAR2` | `VARCHAR(50)` | Cuenta para cobro de comisiones |

### 2.3 Campos — `MW_TRANSACCIONES_CORBAN` → `correspondent_bank_transaction`

| Campo Original | Campo BIAN | Tipo Original | Tipo Aurora | Descripción |
|---|---|---|---|---|
| `CODIGO_CORRESPONSAL` | `correspondent_party_reference` | `VARCHAR2` | `VARCHAR(20)` | FK al corresponsal bancario |
| `CODIGO_TRANSACCION` | `transaction_type_code` | `VARCHAR2` | `VARCHAR(10)` | Código numérico de la transacción |
| `DESCRIPCION` | `transaction_description` | `VARCHAR2` | `VARCHAR(200)` | Descripción legible de la transacción |
| `ESTADO` | `status` | `VARCHAR2(1)` | `CHAR(1)` | Estado: `A`=Activo, `I`=Inactivo |
| `MONTO_MAX_X_TRN` | `maximum_transaction_amount` | `NUMBER` | `NUMERIC(18,2)` | Monto máximo permitido por transacción |
| `TIPO_TRANSACCION` | `transaction_type` | `VARCHAR2` | `VARCHAR(10)` | Tipo de transacción BIAN (ej. `ACTG`, `ACTR`) |
| `CODIGO_PAIS` | `country_code` | `VARCHAR2` | `VARCHAR(10)` | Código del país |
| `MONTO_COMISION` | `commission_amount` | `NUMBER` | `NUMERIC(18,2)` | Monto de la comisión aplicable |
| `MONEDA_COMISION` | `commission_currency_code` | `VARCHAR2` | `VARCHAR(3)` | Código ISO 4217 de moneda de comisión |
| `TIPO_TRANSACCION_COMISION` | `commission_transaction_type` | `VARCHAR2` | `VARCHAR(10)` | Tipo de transacción para la comisión |

### 2.4 Parámetros del Stored Procedure

| Parámetro Original | Parámetro BIAN | Dirección | Descripción |
|---|---|---|---|
| `Pv_CODIGO_CORRESPONSAL` | `p_correspondent_party_reference` | IN | Código del corresponsal |
| `Pv_CODIGO_PAIS` | `p_country_code` | IN | Código de país |
| `Pv_CODIGO_TRANSACCION` | `p_transaction_type_code` | IN | Código de transacción |
| `Pv_CUENTA_CREDITO` | `p_credit_account_reference` | OUT | Cuenta de crédito |
| `Pv_CUENTA_DEBITO` | `p_debit_account_reference` | OUT | Cuenta de débito |
| `Pv_MONEDA_PERMITIDA` | `p_permitted_currency_code` | OUT | Moneda permitida |
| `Pv_TIPO_TRANSACCION` | `p_transaction_type` | OUT | Tipo de transacción |
| `Pv_MONTO_COMISION` | `p_commission_amount` | OUT | Monto de comisión |
| `Pv_MONEDA_COMISION` | `p_commission_currency_code` | OUT | Moneda de comisión |
| `Pv_TIPO_TRANSACCION_COMISION` | `p_commission_transaction_type` | OUT | Tipo de transacción comisión |
| `Pv_CUENTA_COMISION` | `p_commission_account_reference` | OUT | Cuenta de comisión |
| `Pv_CODIGO_MENSAJE` | `p_response_code` | OUT | Código de respuesta: `SUCCESS` / `ERROR` |
| `Pv_MENSAJE_ERROR` | `p_response_message` | OUT | Mensaje descriptivo del resultado |

---

## 3. Modelo de Datos — AWS Aurora PostgreSQL

### 3.1 Tabla: `correspondent_bank`

```sql
Schema  : correspondentBank
Tabla   : correspondent_bank
PK      : correspondent_party_reference + country_code
Índices : idx_cb_status
```

| Columna | Tipo | Nulo | PK | FK | Descripción |
|---|---|---|---|---|---|
| `correspondent_party_reference` | `VARCHAR(20)` | NO | PK | — | Identificador único del corresponsal |
| `country_code` | `VARCHAR(10)` | NO | PK | — | Código de país (ej. `HN01`) |
| `correspondent_party_name` | `VARCHAR(200)` | NO | — | — | Nombre del corresponsal |
| `status` | `CHAR(1)` | NO | — | — | `A`=Activo / `I`=Inactivo |
| `credit_account_reference` | `VARCHAR(50)` | NO | — | — | Cuenta de crédito |
| `debit_account_reference` | `VARCHAR(50)` | NO | — | — | Cuenta de débito |
| `permitted_currency_code` | `VARCHAR(3)` | YES | — | — | Código ISO 4217 |
| `commission_account_reference` | `VARCHAR(50)` | YES | — | — | Cuenta de comisión |
| `created_at` | `TIMESTAMP` | NO | — | — | Fecha de creación del registro |
| `updated_at` | `TIMESTAMP` | YES | — | — | Fecha de última modificación |

### 3.2 Tabla: `correspondent_bank_transaction`

```sql
Schema  : correspondentBank
Tabla   : correspondent_bank_transaction
PK      : correspondent_party_reference + transaction_type_code + country_code
FK      : correspondent_party_reference + country_code → correspondent_bank
Índices : idx_cbt_status, idx_cbt_transaction_code
```

| Columna | Tipo | Nulo | PK | FK | Descripción |
|---|---|---|---|---|---|
| `correspondent_party_reference` | `VARCHAR(20)` | NO | PK | PK de `correspondent_bank` | Código del corresponsal |
| `transaction_type_code` | `VARCHAR(10)` | NO | PK | — | Código de la transacción |
| `country_code` | `VARCHAR(10)` | NO | PK | PK de `correspondent_bank` | Código de país |
| `transaction_description` | `VARCHAR(200)` | NO | — | — | Descripción de la transacción |
| `status` | `CHAR(1)` | NO | — | — | `A`=Activo / `I`=Inactivo |
| `maximum_transaction_amount` | `NUMERIC(18,2)` | YES | — | — | Monto máximo por transacción |
| `transaction_type` | `VARCHAR(10)` | YES | — | — | Tipo BIAN (`ACTG`, `ACTR`, etc.) |
| `commission_amount` | `NUMERIC(18,2)` | YES | — | — | Monto de comisión |
| `commission_currency_code` | `VARCHAR(3)` | YES | — | — | Moneda de comisión ISO 4217 |
| `commission_transaction_type` | `VARCHAR(10)` | YES | — | — | Tipo de transacción para comisión |
| `created_at` | `TIMESTAMP` | NO | — | — | Fecha de creación |
| `updated_at` | `TIMESTAMP` | YES | — | — | Fecha de modificación |

---

## 4. Modelo Entidad-Relación

```
┌─────────────────────────────────────────────────────────────────────┐
│                         correspondentBank schema                           │
│                                                                     │
│  ┌──────────────────────────────────┐                               │
│  │        correspondent_bank        │                               │
│  ├──────────────────────────────────┤                               │
│  │ PK correspondent_party_reference │◄─────────────────┐           │
│  │ PK country_code                  │◄──────────────┐  │           │
│  │    correspondent_party_name      │               │  │           │
│  │    status  (A/I)                 │               │  │           │
│  │    credit_account_reference      │               │  │           │
│  │    debit_account_reference       │               │  │           │
│  │    permitted_currency_code       │               │  │           │
│  │    commission_account_reference  │               │  │           │
│  │    created_at                    │               │  │           │
│  │    updated_at                    │               │  │           │
│  └──────────────────────────────────┘               │  │           │
│                                                     │  │           │
│  ┌──────────────────────────────────────────────┐   │  │           │
│  │      correspondent_bank_transaction          │   │  │           │
│  ├──────────────────────────────────────────────┤   │  │           │
│  │ PK correspondent_party_reference  ───────────┼───┘  │           │
│  │ PK transaction_type_code                     │      │           │
│  │ PK country_code  ────────────────────────────┼──────┘           │
│  │    transaction_description                   │                  │
│  │    status  (A/I)                             │                  │
│  │    maximum_transaction_amount                │                  │
│  │    transaction_type                          │                  │
│  │    commission_amount                         │                  │
│  │    commission_currency_code                  │                  │
│  │    commission_transaction_type               │                  │
│  │    created_at                                │                  │
│  │    updated_at                                │                  │
│  └──────────────────────────────────────────────┘                  │
│                                                                     │
│  Relación: correspondent_bank  1──────N  correspondent_bank_trans. │
│  (correspondent_party_reference + country_code)                     │
└─────────────────────────────────────────────────────────────────────┘
```

**Cardinalidad:**
- Un `correspondent_bank` puede tener **una o muchas** `correspondent_bank_transaction` (1:N)
- Una `correspondent_bank_transaction` pertenece a **exactamente un** `correspondent_bank` (N:1)
- La llave compuesta `(correspondent_party_reference, country_code)` garantiza unicidad del corresponsal por país

---

## 5. Scripts DDL — Creación de Tablas

```sql
-- ============================================================
-- Schema
-- ============================================================
CREATE SCHEMA IF NOT EXISTS correspondentBank;

-- ============================================================
-- Tabla: correspondent_bank
-- Equivalente a: MW_CORRESPONSALES_BANCARIOS
-- ============================================================
CREATE TABLE correspondentBank.correspondent_bank (
    correspondent_party_reference   VARCHAR(20)     NOT NULL,
    country_code                    VARCHAR(10)     NOT NULL,
    correspondent_party_name        VARCHAR(200)    NOT NULL,
    status                          CHAR(1)         NOT NULL DEFAULT 'A',
    credit_account_reference        VARCHAR(50)     NOT NULL,
    debit_account_reference         VARCHAR(50)     NOT NULL,
    permitted_currency_code         VARCHAR(3),
    commission_account_reference    VARCHAR(50),
    created_at                      TIMESTAMP       NOT NULL DEFAULT NOW(),
    updated_at                      TIMESTAMP,

    CONSTRAINT pk_correspondent_bank
        PRIMARY KEY (correspondent_party_reference, country_code),

    CONSTRAINT chk_cb_status
        CHECK (status IN ('A', 'I'))
);

CREATE INDEX idx_cb_status
    ON correspondentBank.correspondent_bank (status);

COMMENT ON TABLE correspondentBank.correspondent_bank
    IS 'Registro maestro de corresponsales bancarios autorizados. Migrado desde Oracle MW_CORRESPONSALES_BANCARIOS.';

COMMENT ON COLUMN correspondentBank.correspondent_bank.correspondent_party_reference
    IS 'Identificador único del corresponsal bancario.';
COMMENT ON COLUMN correspondentBank.correspondent_bank.country_code
    IS 'Código de país según catálogo interno (ej. HN01 = Honduras).';
COMMENT ON COLUMN correspondentBank.correspondent_bank.status
    IS 'Estado del corresponsal: A=Activo, I=Inactivo.';
COMMENT ON COLUMN correspondentBank.correspondent_bank.credit_account_reference
    IS 'Número de cuenta contable para movimientos de crédito.';
COMMENT ON COLUMN correspondentBank.correspondent_bank.debit_account_reference
    IS 'Número de cuenta contable para movimientos de débito.';
COMMENT ON COLUMN correspondentBank.correspondent_bank.permitted_currency_code
    IS 'Código ISO 4217 de la moneda habilitada para el corresponsal.';
COMMENT ON COLUMN correspondentBank.correspondent_bank.commission_account_reference
    IS 'Número de cuenta para el cobro de comisiones.';


-- ============================================================
-- Tabla: correspondent_bank_transaction
-- Equivalente a: MW_TRANSACCIONES_CORBAN
-- ============================================================
CREATE TABLE correspondentBank.correspondent_bank_transaction (
    correspondent_party_reference   VARCHAR(20)     NOT NULL,
    transaction_type_code           VARCHAR(10)     NOT NULL,
    country_code                    VARCHAR(10)     NOT NULL,
    transaction_description         VARCHAR(200)    NOT NULL,
    status                          CHAR(1)         NOT NULL DEFAULT 'A',
    maximum_transaction_amount      NUMERIC(18,2),
    transaction_type                VARCHAR(10),
    commission_amount               NUMERIC(18,2),
    commission_currency_code        VARCHAR(3),
    commission_transaction_type     VARCHAR(10),
    created_at                      TIMESTAMP       NOT NULL DEFAULT NOW(),
    updated_at                      TIMESTAMP,

    CONSTRAINT pk_correspondent_bank_transaction
        PRIMARY KEY (correspondent_party_reference, transaction_type_code, country_code),

    CONSTRAINT fk_cbt_correspondent_bank
        FOREIGN KEY (correspondent_party_reference, country_code)
        REFERENCES correspondentBank.correspondent_bank (correspondent_party_reference, country_code)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,

    CONSTRAINT chk_cbt_status
        CHECK (status IN ('A', 'I'))
);

CREATE INDEX idx_cbt_status
    ON correspondentBank.correspondent_bank_transaction (status);

CREATE INDEX idx_cbt_transaction_code
    ON correspondentBank.correspondent_bank_transaction (transaction_type_code);

COMMENT ON TABLE correspondentBank.correspondent_bank_transaction
    IS 'Catálogo de transacciones habilitadas por corresponsal bancario. Migrado desde Oracle MW_TRANSACCIONES_CORBAN.';

COMMENT ON COLUMN correspondentBank.correspondent_bank_transaction.transaction_type_code
    IS 'Código numérico de la transacción (1=Depósito, 2=Pago Préstamo, 3=Recaudo, 4=Retiro, 5=Tarjeta Crédito, etc.).';
COMMENT ON COLUMN correspondentBank.correspondent_bank_transaction.maximum_transaction_amount
    IS 'Monto máximo permitido por transacción en la moneda del corresponsal.';
COMMENT ON COLUMN correspondentBank.correspondent_bank_transaction.transaction_type
    IS 'Tipo de transacción BIAN (ACTG=Accounting, ACTR=Account Transfer, etc.).';
COMMENT ON COLUMN correspondentBank.correspondent_bank_transaction.commission_amount
    IS 'Valor fijo de comisión aplicable a la transacción. NULL si no aplica comisión.';
```

---

## 6. Scripts DML — Carga Inicial de Datos

```sql
-- ============================================================
-- Carga inicial: correspondent_bank
-- Fuente: MW_CORRESPONSALES_BANCARIOS.csv
-- ============================================================
INSERT INTO correspondentBank.correspondent_bank
    (correspondent_party_reference, country_code, correspondent_party_name,
     status, credit_account_reference, debit_account_reference,
     permitted_currency_code, commission_account_reference, created_at)
VALUES
    ('101', 'HN01', 'TENGO PUNTOS CORRESPONSALES',    'A', 'HNL151450001', 'HNL151450001', 'HNL', 'PL52280', NOW()),
    ('102', 'HN01', 'TENGO BILLETERA ELECTRONICA',    'A', 'HNL152390001', 'HNL152390001', 'HNL', 'PL52280', NOW()),
    ('103', 'HN01', 'TARJETAS RECARGABLES TENGO',     'A', 'HNL152410001', 'HNL152410001', 'HNL', 'PL52280', NOW());


-- ============================================================
-- Carga inicial: correspondent_bank_transaction
-- Fuente: MW_TRANSACCIONES_CORBAN.csv
-- ============================================================
INSERT INTO correspondentBank.correspondent_bank_transaction
    (correspondent_party_reference, transaction_type_code, country_code,
     transaction_description, status, maximum_transaction_amount,
     transaction_type, commission_amount, commission_currency_code,
     commission_transaction_type, created_at)
VALUES
-- Corresponsal 101
    ('101', '2',  'HN01', 'PAGO DE PRESTAMO',            'A', 30000,  NULL,   NULL, NULL,  NULL,   NOW()),
    ('101', '7',  'HN01', 'DEPOSITO REFERENCIADO',        'A', NULL,   NULL,   NULL, NULL,  NULL,   NOW()),
    ('101', '5',  'HN01', 'PAGO DE TARJETA CREDITO',      'A', 30000,  NULL,   NULL, NULL,  NULL,   NOW()),
    ('101', '1',  'HN01', 'DEPOSITO A CUENTA',            'A', 30000,  'ACTG', NULL, NULL,  NULL,   NOW()),
    ('101', '4',  'HN01', 'RETIRO EFECTIVO',              'A', 30000,  'ACTR', NULL, 'HNL', 'ACT3', NOW()),
    ('101', '3',  'HN01', 'PAGO DE RECAUDO',              'A', 30000,  NULL,   NULL, NULL,  NULL,   NOW()),
    ('101', '6',  'HN01', 'ANTICIPO DE SALARIO',          'A', NULL,   NULL,   NULL, NULL,  NULL,   NOW()),
    ('101', '8',  'HN01', 'RETIRO EFECTIVO DESDE TC',     'A', 30000,  NULL,   NULL, 'HNL', 'ACT3', NOW()),
    ('101', '9',  'HN01', 'PAGO DE REMESA',               'A', NULL,   NULL,   NULL, NULL,  NULL,   NOW()),
-- Corresponsal 102
    ('102', '2',  'HN01', 'PAGO DE PRESTAMO',             'A', 30000,  NULL,   NULL, NULL,  NULL,   NOW()),
    ('102', '7',  'HN01', 'DEPOSITO REFERENCIADO',         'A', NULL,   NULL,   NULL, NULL,  NULL,   NOW()),
    ('102', '5',  'HN01', 'PAGO DE TARJETA DE CREDITO',   'A', 30000,  NULL,   NULL, NULL,  NULL,   NOW()),
    ('102', '1',  'HN01', 'DEPOSITO A CUENTA',             'A', 30000,  'ACTG', NULL, NULL,  NULL,   NOW()),
    ('102', '4',  'HN01', 'RETIRO EFECTIVO',               'A', 30000,  'ACTR', NULL, 'HNL', 'ACT3', NOW()),
    ('102', '3',  'HN01', 'PAGO DE RECAUDO',               'A', 30000,  NULL,   NULL, NULL,  NULL,   NOW()),
    ('102', '6',  'HN01', 'ANTICIPO DE SALARIO',           'A', NULL,   NULL,   NULL, NULL,  NULL,   NOW()),
    ('102', '8',  'HN01', 'RETIRO EFECTIVO DESDE TC',      'A', 30000,  NULL,   NULL, 'HNL', 'ACT3', NOW()),
    ('102', '9',  'HN01', 'PAGO DE REMESA',                'A', NULL,   NULL,   NULL, NULL,  NULL,   NOW()),
-- Corresponsal 103
    ('103', '2',  'HN01', 'PAGO DE PRESTAMO',             'A', 30000,  NULL,   NULL, NULL,  NULL,   NOW()),
    ('103', '7',  'HN01', 'DEPOSITO REFERENCIADO',         'A', NULL,   NULL,   NULL, NULL,  NULL,   NOW()),
    ('103', '5',  'HN01', 'PAGO DE TARJETA CREDITO',      'A', 30000,  NULL,   NULL, NULL,  NULL,   NOW()),
    ('103', '1',  'HN01', 'DEPOSITO A CUENTA',             'A', 30000,  'ACTG', NULL, NULL,  NULL,   NOW()),
    ('103', '4',  'HN01', 'RETIRO EFECTIVO',               'A', 30000,  'ACTR', 10,   'HNL', 'ACT3', NOW()),
    ('103', '3',  'HN01', 'PAGO DE RECAUDO',               'A', 30000,  NULL,   NULL, NULL,  NULL,   NOW()),
    ('103', '6',  'HN01', 'ANTICIPO DE SALARIO',           'A', NULL,   NULL,   NULL, NULL,  NULL,   NOW()),
    ('103', '8',  'HN01', 'RETIRO EFECTIVO DESDE TC',      'A', 30000,  NULL,   NULL, 'HNL', 'ACT3', NOW()),
    ('103', '9',  'HN01', 'PAGO DE REMESA',                'A', NULL,   NULL,   NULL, NULL,  NULL,   NOW());
```

---

## 7. Stored Procedure — AWS Aurora PostgreSQL

> **Nombre:** `sp_validate_correspondent_bank`
> **Identificador AWS:** `ban-xrs-ic-sp-validate-bank-correspondent-{env}`
> **Motor:** Aurora PostgreSQL — PL/pgSQL
> **Equivalente Oracle:** `MIDDLEWARE.MW_P_VALIDA_CORBAN`

```sql
-- ============================================================
-- SP: sp_validate_correspondent_bank
-- Descripción: Valida un corresponsal bancario activo y retorna
--              los datos de cuentas y comisiones para una
--              transacción específica.
-- Autor migración: ficohsa-capa-media team
-- Fecha migración: 2026-03-12
-- Versión original Oracle: 1.0 (05/08/2016 - cjmenjivar)
-- ============================================================
CREATE OR REPLACE PROCEDURE correspondentBank.sp_validate_correspondent_bank(
    -- Parámetros de entrada
    IN  p_correspondent_party_reference     VARCHAR(20),
    IN  p_country_code                      VARCHAR(10),
    IN  p_transaction_type_code             VARCHAR(10),
    -- Parámetros de salida
    OUT p_credit_account_reference          VARCHAR(50),
    OUT p_debit_account_reference           VARCHAR(50),
    OUT p_permitted_currency_code           VARCHAR(3),
    OUT p_transaction_type                  VARCHAR(10),
    OUT p_commission_amount                 VARCHAR(20),
    OUT p_commission_currency_code          VARCHAR(3),
    OUT p_commission_transaction_type       VARCHAR(10),
    OUT p_commission_account_reference      VARCHAR(50),
    OUT p_response_code                     VARCHAR(10),
    OUT p_response_message                  VARCHAR(500)
)
LANGUAGE plpgsql
AS $$
BEGIN

    -- --------------------------------------------------------
    -- Validación parámetros de entrada
    -- --------------------------------------------------------
    IF p_correspondent_party_reference IS NULL OR TRIM(p_correspondent_party_reference) = '' THEN
        p_response_code    := 'ERROR';
        p_response_message := 'ERROR: PARAMETRO DE ENTRADA correspondent_party_reference ES REQUERIDO.';
        RETURN;
    END IF;

    IF p_country_code IS NULL OR TRIM(p_country_code) = '' THEN
        p_response_code    := 'ERROR';
        p_response_message := 'ERROR: PARAMETRO DE ENTRADA country_code ES REQUERIDO.';
        RETURN;
    END IF;

    IF p_transaction_type_code IS NULL OR TRIM(p_transaction_type_code) = '' THEN
        p_response_code    := 'ERROR';
        p_response_message := 'ERROR: PARAMETRO DE ENTRADA transaction_type_code ES REQUERIDO.';
        RETURN;
    END IF;

    -- --------------------------------------------------------
    -- Consulta 1: Datos del corresponsal bancario
    -- Equivale al primer BEGIN..SELECT en Oracle
    -- --------------------------------------------------------
    BEGIN
        SELECT
            cb.credit_account_reference,
            cb.debit_account_reference,
            cb.permitted_currency_code,
            cb.commission_account_reference
        INTO
            p_credit_account_reference,
            p_debit_account_reference,
            p_permitted_currency_code,
            p_commission_account_reference
        FROM correspondentBank.correspondent_bank cb
        WHERE cb.correspondent_party_reference = p_correspondent_party_reference
          AND cb.country_code                  = p_country_code
          AND cb.status                        = 'A';

        IF NOT FOUND THEN
            p_response_code    := 'ERROR';
            p_response_message := 'ERROR: NO SE ENCONTRO EL CORRESPONSAL O ESTA INACTIVO.';
            RETURN;
        END IF;

    EXCEPTION
        WHEN OTHERS THEN
            p_response_code    := 'ERROR';
            p_response_message := 'ERROR EN CONSULTA CORRESPONSAL: ' || SQLERRM;
            RETURN;
    END;

    -- --------------------------------------------------------
    -- Consulta 2: Datos de la transacción del corresponsal
    -- Equivale al segundo BEGIN..SELECT en Oracle
    -- --------------------------------------------------------
    BEGIN
        SELECT
            cbt.transaction_type,
            cbt.commission_amount::VARCHAR,
            cbt.commission_currency_code,
            cbt.commission_transaction_type
        INTO
            p_transaction_type,
            p_commission_amount,
            p_commission_currency_code,
            p_commission_transaction_type
        FROM correspondentBank.correspondent_bank_transaction cbt
        WHERE cbt.correspondent_party_reference = p_correspondent_party_reference
          AND cbt.country_code                  = p_country_code
          AND cbt.transaction_type_code         = p_transaction_type_code
          AND cbt.status                        = 'A';

        IF NOT FOUND THEN
            p_response_code    := 'ERROR';
            p_response_message := 'ERROR: NO SE ENCONTRO LA TRANSACCION O ESTA INACTIVA.';
            RETURN;
        END IF;

    EXCEPTION
        WHEN OTHERS THEN
            p_response_code    := 'ERROR';
            p_response_message := 'ERROR EN CONSULTA TRANSACCION: ' || SQLERRM;
            RETURN;
    END;

    -- --------------------------------------------------------
    -- Respuesta exitosa
    -- --------------------------------------------------------
    p_response_code    := 'SUCCESS';
    p_response_message := 'EXITO EN TRANSACCION.';

EXCEPTION
    WHEN OTHERS THEN
        p_response_code    := 'ERROR';
        p_response_message := 'ERROR GENERAL SP sp_validate_correspondent_bank: ' || SQLERRM;
END;
$$;

-- Permisos de ejecución
GRANT EXECUTE ON PROCEDURE correspondentBank.sp_validate_correspondent_bank(
    VARCHAR, VARCHAR, VARCHAR,
    OUT VARCHAR, OUT VARCHAR, OUT VARCHAR, OUT VARCHAR,
    OUT VARCHAR, OUT VARCHAR, OUT VARCHAR, OUT VARCHAR,
    OUT VARCHAR, OUT VARCHAR
) TO correspondentBank_lambda_role;
```

---

## 8. Lambda — Consumidor del SP

> **Nombre:** `ban-xrs-ic-lam-validate-bank-correspondent-{env}`
> **Trigger:** API Gateway (REST)
> **Método HTTP:** POST
> **Path:** `/v1/correspondent-bank/validate`

### 8.2 Contrato de la API

**Request Body:**
```json
{
  "correspondentPartyReference": "101",
  "country": "HN01",
  "transactionType": "2"
}
```

**Response — Éxito (HTTP 200):**
```json
{
  "success": true,
  "correlationId": "uuid-v4-generado-por-lambda",
  "data": {
    "creditAccountReference": "HNL151450001",
    "debitAccountReference": "HNL151450001",
    "permittedCurrencyCode": "HNL",
    "transactionType": null,
    "commissionAmount": null,
    "commissionCurrencyCode": null,
    "commissionTransactionType": null,
    "commissionAccountReference": "PL52280"
  }
}
```

**Response — Error de negocio (HTTP 422):**
```json
{
  "success": false,
  "correlationId": "uuid-v4-generado-por-lambda",
  "error": {
    "code": "CORRESPONDENT_NOT_FOUND",
    "message": "ERROR: NO SE ENCONTRO EL CORRESPONSAL O ESTA INACTIVO."
  }
}
```

**Response — Error técnico (HTTP 500):**
```json
{
  "success": false,
  "correlationId": "uuid-v4-generado-por-lambda",
  "error": {
    "code": "INTERNAL_SERVER_ERROR",
    "message": "An unexpected error occurred. Please contact support."
  }
}
```

## 9. Manejo de Errores de la Lambda

### 9.1 Tabla de Códigos de Error

| HTTP | Código Error | Origen | Causa | Acción Recomendada |
|---|---|---|---|---|
| `400` | `BAD_REQUEST` | Lambda | Body no es JSON válido | Verificar formato del request |
| `400` | `VALIDATION_ERROR` | Lambda | Campo obligatorio faltante | Revisar campos `correspondentPartyReference`, `country`, `transactionType` |
| `422` | `MISSING_CORRESPONDENT_REFERENCE` | SP | `correspondent_party_reference` nulo o vacío en SP | Error de mapeo en Lambda (no debería ocurrir si la validación funciona) |
| `422` | `MISSING_COUNTRY_CODE` | SP | `country_code` nulo o vacío en SP | Error de mapeo en Lambda |
| `422` | `MISSING_TRANSACTION_TYPE_CODE` | SP | `transaction_type_code` nulo o vacío en SP | Error de mapeo en Lambda |
| `422` | `CORRESPONDENT_NOT_FOUND` | SP | Corresponsal no existe o está inactivo | Verificar que el corresponsal está registrado y activo en Aurora |
| `422` | `TRANSACTION_NOT_FOUND` | SP | Transacción no habilitada para ese corresponsal | Verificar catálogo en `correspondent_bank_transaction` |
| `422` | `BUSINESS_ERROR` | SP | Error de negocio no categorizado del SP | Revisar mensaje detallado en logs CloudWatch |
| `500` | `INTERNAL_SERVER_ERROR` | Lambda | Error de conexión a Aurora, timeout, error inesperado | Revisar logs CloudWatch, verificar VPC/Secrets Manager |

### 9.2 Errores de Infraestructura (no expuestos al cliente)

| Error Interno | Causa Probable | Solución |
|---|---|---|
| `connection timeout` | Lambda fuera de VPC o Security Group mal configurado | Verificar VPC config y SG de Aurora |
| `ECONNREFUSED` | Aurora en estado stopped o fallo del endpoint | Revisar estado del clúster Aurora Serverless (puede estar en pausa) |
| `password authentication failed` | Credenciales incorrectas en Secrets Manager | Rotar secreto y actualizar ARN en variable de entorno |
| `SSL SYSCALL error` | Incompatibilidad de SSL entre Lambda y Aurora | Verificar certificado RDS CA y configuración SSL del pool pg |
| `too many connections` | Pool excedido, Lambda concurrencia alta | Aumentar `DB_MAX_CONNECTIONS` o usar RDS Proxy |
| `ResourceNotFoundException` (Secrets Manager) | ARN de secreto incorrecto | Verificar variable `DB_PASSWORD_SECRET` y permisos IAM |
| `AccessDeniedException` (Secrets Manager) | Rol Lambda sin permisos sobre el secreto | Agregar política `secretsmanager:GetSecretValue` al rol Lambda |
| `Function timeout` | Consulta lenta o Aurora waking up (Serverless v1) | Aumentar timeout Lambda a 30s; considerar Aurora Serverless v2 |

### 9.3 Estrategia de Logging (CloudWatch)

Todos los logs se emiten en formato JSON estructurado con los campos:

```json
{
  "correlationId": "uuid",
  "level": "INFO|WARN|ERROR",
  "message": "descripción",
  "env": "dev|qa|prod",
  "requestId": "api-gateway-request-id"
}
```

**Métricas recomendadas en CloudWatch:**
- `Errors` — count de errores 5xx
- `4XXError` — count de errores 4xx
- `Duration` — tiempo de ejecución de la Lambda
- `Throttles` — throttling de invocaciones

---

## 10. Diagrama de Secuencia

:::mermaid
sequenceDiagram
    autonumber
    participant API as API Consumidora
    participant Lambda as Lambda Validación Corresponsales<br/>ban-xrs-ic-lam-validate-bank-correspondent-{env}
    participant SP as SP sp_validate_correspondent_bank<br/>ban-xrs-ic-sp-validate-bank-correspondent-{env}
    participant Aurora as AWS Aurora Serverless<br/>ban-xrs-ic-rds-aurora-postgresql-{env}

    Note over API, Aurora: Flujo Honduras (HN01) — Validación Corresponsales Bancarios

    API->>Lambda: POST /v1/correspondent-bank/validate
    Note right of API: { correspondentPartyReference,<br/> country, transactionType }

    Lambda->>Lambda: Validar campos de entrada

    Lambda->>Lambda: Construir parámetros SP
    Note over Lambda:Mapeo: p_correspondentPartyReference = request.correspondentPartyReference, <br> p_countryCode = request.country, <br> p_transactionTypeCode = request.transactionType

    Lambda->>SP: CALL sp_validate_correspondent_bank(...)
    Note right of Lambda: p_correspondentPartyReference,<br/> p_countryCode, p_transactionTypeCode

    SP->>Aurora: SELECT FROM correspondent_bank WHERE status='A'

    Aurora->>SP: credit_account_reference, debit_account_reference,<br/> permitted_currency_code, commission_account_reference

    SP->>Aurora: SELECT FROM correspondent_bank_transaction WHERE status='A'

    Aurora->>SP: transaction_type, commission_amount,<br/> commission_currency_code, commission_transaction_type

    SP->>Lambda: p_response_code = 'SUCCESS' + datos
    Note left of SP: creditAccountReference,<br/> debitAccountReference,<br/> permittedCurrencyCode,<br/> transactionType, commissionAmount,<br/> commissionCurrencyCode,<br/> commissionTransactionType,<br/> commissionAccountReference

    Lambda->>Lambda: Construir respuesta Lambda
    Note over Lambda:  If p_response_code = 'SUCCESS' then success = true <br> else success = false

    Lambda->>API: HTTP 200 + { success, correlationId, data }
:::

---

## 11. Repositorio y Despliegue

| Ambiente | Repositorio | Rama | Observación |
|----------|-------------|------|-------------|
| Dev | `fn-ic-val_bank_corr-sys` | [Repositorio Azure](https://dev.azure.com/DevopsFicohsa/NOVA%20-%20Modernizaci%C3%B3n%20Capa%20Integraci%C3%B3n/_git/fn-ic-val_bank_corr-sys) | `develop` | Desarrollo activo |

---

## 12. Consideraciones de Migración

### 12.1 Diferencias Oracle → Aurora PostgreSQL

| Aspecto | Oracle PL/SQL | Aurora PostgreSQL PL/pgSQL |
|---|---|---|
| Verificación de fila no encontrada | `WHEN NO_DATA_FOUND` (excepción automática) | `IF NOT FOUND THEN` (verificación explícita tras SELECT) |
| Variable de tipo basada en tabla | `tabla.columna%TYPE` | Tipo explícito en declaración |
| Concatenación de strings | `\|\|` | `\|\|` (igual) |
| `SQLERRM` | Sí | `SQLERRM` sí existe en PL/pgSQL |
| `RETURN` dentro de bloque | `RETURN;` | `RETURN;` (igual) |
| Parámetros OUT en CALL | Referenciados por posición | Referenciados por posición con `NULL` como placeholder |
| Schema | `MIDDLEWARE.` (mayúsculas) | `correspondentBank.` (minúsculas, case-insensitive) |
| Tipo de dato `VARCHAR2` | `VARCHAR2(n)` | `VARCHAR(n)` |
| Tipo de dato `NUMBER` | `NUMBER(p,s)` | `NUMERIC(p,s)` |


### 12.2 Aurora PostgreSQL vs DynamoDB — Decisión de Arquitectura

Para esta migración se evaluaron dos servicios AWS como destino del modelo de datos. A continuación se justifica la elección de **Aurora PostgreSQL** sobre **DynamoDB**.

#### Naturaleza del dato

| Criterio | Aurora PostgreSQL | DynamoDB |
|---|---|---|
| Modelo de datos | Relacional — tablas con FK entre `correspondent_bank` y `correspondent_bank_transaction` | Documental / clave-valor — no soporta FK nativas |
| Integridad referencial | `FOREIGN KEY` garantizado por el motor | Debe implementarse en código de aplicación |
| Transacciones ACID | Soportadas nativamente | Transacciones disponibles pero limitadas a 100 ítems |
| Consultas complejas | `JOIN`, `WHERE` multicampo, agregaciones | Requiere diseño previo de índices GSI/LSI o escaneo completo |
| Stored Procedures | PL/pgSQL nativo — migración directa desde Oracle | No soporta procedimientos almacenados |

#### Compatibilidad con el SP Oracle original

El stored procedure `MW_P_VALIDA_CORBAN` realiza dos `SELECT` secuenciales con condiciones compuestas (`AND`) sobre dos tablas relacionadas. Este patrón es **nativo en SQL relacional** y requeriría ser completamente reimplementado como lógica de aplicación en DynamoDB, eliminando la ventaja de reusar el SP.

```
Oracle SP                         Aurora PostgreSQL          DynamoDB
─────────────────────────────     ───────────────────────    ─────────────────────────
SELECT FROM tabla1 WHERE          SELECT FROM tabla1 WHERE   GetItem (PK exacta) o
  col1 = x AND col2 = y   ──►      col1 = x AND col2 = y ✔   Scan con FilterExpression ✘
SELECT FROM tabla2 WHERE          SELECT FROM tabla2 WHERE
  col1 = x AND col3 = z   ──►      col1 = x AND col3 = z ✔   Query con GSI (diseño previo) ✘
```

#### Costos y operación

| Criterio | Aurora PostgreSQL Serverless v2 | DynamoDB |
|---|---|---|
| Modelo de costo | ACU por segundo (escala a 0 en inactividad) | RCU/WCU por operación o capacidad provisionada |
| Costo para carga baja | Muy bajo (Serverless v2 escala a 0.5 ACU) | Bajo (on-demand) |
| Costo para carga alta | Predecible — escala linealmente | Puede crecer significativamente por RCU |
| Operación | Schema migrations con Flyway/Liquibase | Sin migraciones, pero cambios de modelo son costosos |
| Herramientas de migración | AWS SCT / pg_dump / DMS — compatibles con Oracle | Requiere ETL personalizado desde Oracle |

#### Conclusión de la decisión

> **Aurora PostgreSQL Serverless v2** es la opción correcta porque:
> 1. El modelo de datos es **inherentemente relacional** con integridad referencial entre corresponsal y transacciones.
> 2. Permite la **migración directa del SP Oracle** sin reescribir la lógica de negocio en la aplicación.
> 3. El esquema es **compatible con herramientas estándar** de migración Oracle → PostgreSQL (AWS DMS, SCT).
> 4. El volumen de datos es **acotado y estático** (catálogo de corresponsales), por lo que no se requiere la escala masiva de escritura donde DynamoDB sobresale.

---

### 12.3 Catálogo de Transacciones Migradas

| `transaction_type_code` | Descripción | Corresponsales que la tienen |
|---|---|---|
| `1` | Depósito a Cuenta | 101, 102, 103 |
| `2` | Pago de Préstamo | 101, 102, 103 |
| `3` | Pago de Recaudo | 101, 102, 103 |
| `4` | Retiro Efectivo | 101, 102, 103 |
| `5` | Pago de Tarjeta Crédito | 101, 102, 103 |
| `6` | Anticipo de Salario | 101, 102, 103 |
| `7` | Depósito Referenciado | 101, 102, 103 |
| `8` | Retiro Efectivo desde TC | 101, 102, 103 |
| `9` | Pago de Remesa | 101, 102, 103 |

> **Nota:** El corresponsal `103` es el único con `commission_amount = 10` en la transacción `4` (Retiro Efectivo). Los demás tienen `commission_amount = NULL`.

### 12.5 Lambda como Capa de Abstracción — vs Consumo Directo del SP

#### Arquitectura sin Lambda (consumo directo desde la API)

```
┌─────────────┐    conexión JDBC/ODBC    ┌──────────────────────────┐
│ API Externa │ ────────────────────────► │  Aurora PostgreSQL        │
│ (consumidor)│    CALL sp_validate...   │  sp_validate_correspond.. │
└─────────────┘                          └──────────────────────────┘
```

#### Arquitectura con Lambda (modelo implementado)

```
┌─────────────┐    REST/HTTPS    ┌──────────────┐    pool TCP    ┌──────────────────────────┐
│ API Externa │ ───────────────► │ Lambda       │ ─────────────► │  Aurora PostgreSQL        │
│ (consumidor)│    JSON BIAN     │ (orquestador)│    CALL sp..   │  sp_validate_correspond.. │
└─────────────┘                  └──────────────┘                └──────────────────────────┘
```

#### Ventajas de la abstracción Lambda

| Dimensión | Sin Lambda (directo) | Con Lambda |
|---|---|---|
| **Protocolo** | El consumidor necesita driver PostgreSQL (JDBC, psycopg2, pg) | El consumidor usa REST/HTTPS estándar — cualquier lenguaje o plataforma |
| **Seguridad de red** | Aurora debe exponerse fuera de la VPC o el consumidor debe estar en la misma VPC | Aurora permanece completamente privada; solo Lambda (dentro de la VPC) la alcanza |
| **Credenciales** | El consumidor debe conocer host, puerto, usuario y contraseña de Aurora | El consumidor solo usa el endpoint de API Gateway; las credenciales DB quedan encapsuladas |
| **Evolución del SP** | Cambios en la firma del SP requieren cambios en todos los consumidores | Lambda absorbe los cambios del SP y expone el mismo contrato REST; los consumidores no se ven afectados |
| **Transformación de datos** | El consumidor recibe tipos nativos PostgreSQL (arrays, bytea, etc.) | Lambda serializa y transforma la respuesta al modelo BIAN canónico en JSON |
| **Observabilidad** | Logs dispersos entre consumidores y base de datos | `correlationId` centralizado en CloudWatch — trazabilidad end-to-end de cada invocación |
| **Control de acceso** | Requiere usuarios DB por consumidor o roles compartidos | IAM + API Gateway gestiona la autenticación; la DB tiene un único rol `lambda_role` |
| **Escalabilidad** | Cada consumidor abre su propio pool de conexiones — riesgo de saturar Aurora | Lambda centraliza el pool y puede usar RDS Proxy para multiplexar conexiones |
| **Timeouts y reintentos** | Cada consumidor implementa su propia política | Lambda implementa la política una sola vez con manejo de errores consistente |
| **Versionado de API** | No hay mecanismo nativo de versiones en un SP | API Gateway permite versionar (`/v1/`, `/v2/`) sin romper consumidores existentes |

#### Diagrama de responsabilidades

```
                    ┌──────────────────────────────────────────────┐
                    │               AWS Lambda                     │
  Responsabilidad   │                                              │
  del CONSUMIDOR:   │  ┌──────────────┐   ┌────────────────────┐  │
  ─ Autenticación   │  │  Validación  │   │  Mapeo BIAN        │  │
    API Gateway     │  │  de entrada  │   │  (SP → JSON)       │  │
  ─ Formato JSON    │  └──────┬───────┘   └────────┬───────────┘  │
  ─ Manejo HTTP     │         │                    │               │
                    │  ┌──────▼───────────────────▼───────────┐   │
  Responsabilidad   │  │  Conexión Pool + CALL SP              │   │
  de la LAMBDA:     │  │  (Secrets Manager, VPC, retry)        │   │
  ─ Conexión DB     │  └──────────────────────────────────────┘   │
  ─ Ejecución SP    │                                              │
  ─ Transformación  │  ┌──────────────────────────────────────┐   │
  ─ Logging         │  │  Manejo de errores + correlationId   │   │
  ─ Seguridad DB    │  └──────────────────────────────────────┘   │
                    └──────────────────────────────────────────────┘
```

> **Principio clave:** La Lambda actúa como **Anti-Corruption Layer (ACL)** entre el modelo de la base de datos (Oracle-heredado, orientado a SP) y el modelo de dominio BIAN que expone la API. Cualquier cambio interno en la DB queda transparente para los consumidores externos.

---

### 12.4 Riesgos Identificados

| Riesgo | Probabilidad | Impacto | Mitigación |
|---|---|---|---|
| Aurora Serverless en pausa causa timeout en primera invocación | Media | Alto | Usar Aurora Serverless v2 (sin cold start) o implementar keep-alive |
| Cambio de contraseña en Secrets Manager invalida pool activo | Baja | Alto | Implementar retry con refresco de secreto ante `password authentication failed` |
| Concurrencia alta agota conexiones Aurora | Media | Alto | Configurar RDS Proxy entre Lambda y Aurora |
| Diferencias en tipos de datos Oracle ↔ PostgreSQL | Baja | Medio | Validar con suite de tests de regresión completa |
| Campos `commission_amount` que llegan como `NULL` en SP | Alta | Bajo | Lambda ya maneja nulos con operador `?? null` |
