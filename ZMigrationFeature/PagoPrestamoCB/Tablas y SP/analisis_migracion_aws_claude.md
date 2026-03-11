# Análisis de Migración a AWS — Corresponsales Bancarios

---

## 1. Análisis de las Tablas Actuales

### 1.1 Tabla: `MW_CORRESPONSALES_BANCARIOS`

Esta tabla almacena la información maestra de los corresponsales bancarios. Según el stored procedure, sus columnas son:

| Columna | Tipo inferido | Descripción |
|---|---|---|
| `CODIGO_CORRESPONSAL` | VARCHAR2 | Identificador único del corresponsal |
| `CODIGO_PAIS` | VARCHAR2 | Código del país donde opera |
| `NOMBRE_CORRESPONSAL` | VARCHAR2 | Nombre del corresponsal (inferido) |
| `CUENTA_CREDITO` | VARCHAR2 | Cuenta para acreditar transacciones |
| `CUENTA_DEBITO` | VARCHAR2 | Cuenta para debitar transacciones |
| `MONEDA_PERMITIDA` | VARCHAR2 | Moneda en la que opera el corresponsal |
| `CUENTA_COMISION` | VARCHAR2 | Cuenta donde se depositan comisiones |
| `ESTADO` | VARCHAR2(1) | Estado del registro (`A` = Activo) |

**Clave de búsqueda:** `CODIGO_CORRESPONSAL` + `CODIGO_PAIS` + `ESTADO = 'A'`

### 1.2 Tabla: `MW_TRANSACCIONES_CORBAN`

Esta tabla almacena el catálogo de transacciones permitidas por corresponsal. Sus columnas son:

| Columna | Tipo inferido | Descripción |
|---|---|---|
| `CODIGO_CORRESPONSAL` | VARCHAR2 | FK al corresponsal |
| `CODIGO_PAIS` | VARCHAR2 | FK al país |
| `CODIGO_TRANSACCION` | VARCHAR2 | Identificador de la transacción |
| `TIPO_TRANSACCION` | VARCHAR2 | Tipo/categoría de la transacción |
| `MONTO_COMISION` | VARCHAR2/NUMBER | Monto de la comisión aplicable |
| `MONEDA_COMISION` | VARCHAR2 | Moneda de la comisión |
| `TIPO_TRANSACCION_COMISION` | VARCHAR2 | Tipo de transacción para la comisión |
| `ESTADO` | VARCHAR2(1) | Estado del registro (`A` = Activo) |

**Clave de búsqueda:** `CODIGO_CORRESPONSAL` + `CODIGO_PAIS` + `CODIGO_TRANSACCION` + `ESTADO = 'A'`

### 1.3 Relación entre tablas

```
MW_CORRESPONSALES_BANCARIOS (1) ──── (N) MW_TRANSACCIONES_CORBAN
        PK: CODIGO_CORRESPONSAL              FK: CODIGO_CORRESPONSAL
            + CODIGO_PAIS                        + CODIGO_PAIS
```

Un corresponsal puede tener múltiples transacciones configuradas. La relación es 1:N a través de la clave compuesta `(CODIGO_CORRESPONSAL, CODIGO_PAIS)`.

---

## 2. Análisis del Stored Procedure `MW_P_VALIDA_CORBAN`

### 2.1 Flujo lógico

1. **Validación de entrada:** Verifica que `CODIGO_CORRESPONSAL` y `CODIGO_PAIS` no sean nulos.
2. **Consulta del corresponsal:** Busca en `MW_CORRESPONSALES_BANCARIOS` por corresponsal, país y estado activo. Retorna cuentas de crédito, débito, moneda permitida y cuenta de comisión.
3. **Consulta de la transacción:** Busca en `MW_TRANSACCIONES_CORBAN` por corresponsal, país, transacción y estado activo. Retorna tipo de transacción, monto de comisión, moneda de comisión y tipo de transacción de comisión.
4. **Manejo de errores:** Cada bloque tiene su propio manejo con mensajes descriptivos.

### 2.2 Observaciones del SP actual

- La lógica es **exclusivamente de lectura** (solo `SELECT`), no modifica datos.
- Los parámetros de salida son todos `VARCHAR2`, lo que sugiere que se usa como validación/consulta antes de procesar una transacción.
- El manejo de excepciones usa `WHEN OTHERS` de forma amplia, lo cual captura todo sin discriminar el tipo de error.
- El bloque externo de excepciones (`NO_DATA_FOUND` y `OTHERS`) nunca se alcanzaría en la práctica, ya que los bloques internos capturan todas las excepciones primero.
- Los mensajes de error del bloque externo referencian `MW_REGISTRAR_TRANS_CORBAN`, lo que sugiere que el código fue copiado/adaptado de otro procedimiento.

---

## 3. Opciones de Base de Datos en AWS — Tabla Comparativa

| Criterio | Amazon RDS (Oracle / PostgreSQL) | Amazon Aurora (PostgreSQL) | Amazon DynamoDB | Amazon Aurora Serverless v2 |
|---|---|---|---|---|
| **Tipo** | Relacional administrado | Relacional nativo de AWS | NoSQL (clave-valor/documento) | Relacional serverless |
| **Compatibilidad con modelo actual** | Alta (Oracle nativo o PostgreSQL con migración mínima) | Alta (PostgreSQL compatible) | Media (requiere rediseño del modelo) | Alta (PostgreSQL compatible) |
| **Escalabilidad** | Vertical (cambiar tipo de instancia) | Horizontal en lectura (hasta 15 réplicas) | Automática e ilimitada | Automática (escala por ACUs) |
| **Costo mensual estimado (carga baja)** | ~$50-200/mes (db.t3.medium) | ~$80-250/mes (db.t3.medium) | ~$5-25/mes (modo on-demand con poco tráfico) | ~$30-100/mes (escala a 0 ACUs posible) |
| **Costo a escala** | Alto (Oracle con licenciamiento) | Moderado | Bajo-Moderado (pago por consulta) | Moderado (auto-escala) |
| **Alta disponibilidad** | Multi-AZ disponible | Multi-AZ nativo, replicación automática | Nativa, replicación global | Multi-AZ nativo |
| **Stored Procedures** | Sí (PL/SQL en Oracle, PL/pgSQL en PostgreSQL) | Sí (PL/pgSQL) | No | Sí (PL/pgSQL) |
| **Latencia** | Baja (~1-5 ms) | Muy baja (~1-3 ms) | Ultra baja (<10 ms a escala) | Baja (~1-5 ms) |
| **Mantenimiento** | Medio (parches, backups automáticos) | Bajo (AWS gestiona más) | Mínimo (totalmente administrado) | Mínimo (serverless) |
| **Migración desde Oracle** | Fácil si se mantiene Oracle; moderada a PostgreSQL | Moderada (usar AWS SCT + DMS) | Compleja (rediseño completo) | Moderada (usar AWS SCT + DMS) |
| **Soporte transaccional (ACID)** | Completo | Completo | Limitado (por ítem o transacciones de hasta 100 ítems) | Completo |
| **Backup y recovery** | Automático | Automático + backtrack | Automático (PITR 35 días) | Automático |

### Ventajas y desventajas resumidas

**Amazon RDS (Oracle)**
- ✅ Migración 1:1, sin cambios en el código SQL/PL/SQL
- ✅ Familiar para equipos que ya usan Oracle
- ❌ Licenciamiento costoso de Oracle
- ❌ Escalabilidad limitada

**Amazon RDS / Aurora (PostgreSQL)**
- ✅ Sin costo de licencia, comunidad activa
- ✅ Compatible con la mayoría de funcionalidades Oracle
- ✅ Aurora ofrece mejor rendimiento y alta disponibilidad
- ❌ Requiere migración de PL/SQL a PL/pgSQL (esfuerzo bajo en este caso)

**Amazon DynamoDB**
- ✅ Escalabilidad masiva sin administración
- ✅ Costos muy bajos en baja carga
- ✅ Latencia ultra baja
- ❌ Requiere rediseño completo del modelo de datos
- ❌ No soporta JOINs ni stored procedures
- ❌ Consultas limitadas a patrones de acceso predefinidos

**Amazon Aurora Serverless v2**
- ✅ Pago por uso real, escala automáticamente
- ✅ Ideal para cargas variables o intermitentes
- ✅ Compatibilidad completa con PostgreSQL
- ❌ Latencia adicional en "cold start" (mitigada en v2)

---

## 4. Recomendación: Mejor Opción de Base de Datos

### 🏆 Amazon Aurora Serverless v2 (PostgreSQL)

**Razones:**

1. **Costo-eficiencia:** Para tablas de configuración/catálogo con consultas puntuales (como las de este SP), Aurora Serverless cobra solo por los ACUs consumidos. Si el tráfico es intermitente, el costo es significativamente menor que una instancia RDS fija.

2. **Sin licenciamiento:** Al usar PostgreSQL compatible, se elimina el costo de licencia de Oracle, que es uno de los mayores gastos recurrentes.

3. **Migración sencilla:** El stored procedure actual es simple (dos SELECTs y validaciones). La conversión de PL/SQL a PL/pgSQL es trivial para esta complejidad. AWS Schema Conversion Tool (SCT) puede automatizar gran parte del proceso.

4. **Escalabilidad automática:** Si el volumen de validaciones crece (más corresponsales, más transacciones), Aurora escala automáticamente sin intervención manual.

5. **Alta disponibilidad nativa:** Multi-AZ, replicación automática, backups continuos y recuperación puntual incluidos.

6. **Compatibilidad futura:** PostgreSQL permite agregar funcionalidades avanzadas como JSONB, particionamiento, extensiones, y es el motor relacional con mayor crecimiento en la industria.

---

## 5. Mejor Arquitectura para la Lógica del Stored Procedure

### Comparativa de opciones para implementar la lógica

| Criterio | Mantener como SP (PL/pgSQL) | API REST (ECS/Fargate) | AWS Lambda + API Gateway |
|---|---|---|---|
| **Complejidad de implementación** | Baja (migración directa) | Media-Alta | Media |
| **Latencia** | Muy baja (ejecuta en la BD) | Baja (~20-50 ms adicionales) | Baja-Media (cold start ~100-500 ms) |
| **Escalabilidad** | Limitada a la BD | Alta (contenedores auto-escalables) | Muy alta (auto-escala por invocación) |
| **Costo** | Incluido en la BD | ~$30-100/mes mínimo | Prácticamente gratis en baja carga |
| **Mantenibilidad** | Baja (lógica acoplada a BD) | Alta (código versionable, testeable) | Alta (código versionable, testeable) |
| **Observabilidad** | Limitada (logs de BD) | Alta (CloudWatch, X-Ray) | Alta (CloudWatch, X-Ray) |
| **Testing** | Difícil (requiere BD activa) | Fácil (unit tests, mocks) | Fácil (unit tests, mocks) |
| **Despliegue independiente** | No (acoplado a BD) | Sí (CI/CD independiente) | Sí (CI/CD independiente) |
| **Reutilización** | Solo desde la BD | Desde cualquier cliente HTTP | Desde cualquier cliente HTTP |

### 🏆 Recomendación: AWS Lambda + API Gateway

**Esta es la mejor arquitectura para este caso de uso. Razones:**

1. **La lógica es simple y stateless:** El SP solo ejecuta dos consultas de lectura y validaciones. Es un candidato perfecto para Lambda.

2. **Patrón request-response:** La validación de corresponsal se invoca bajo demanda y responde inmediatamente. Lambda está optimizada para este patrón.

3. **Costo mínimo:** Con el free tier de Lambda (1M invocaciones/mes gratis) y API Gateway, el costo para volúmenes bajos-medios es cercano a cero.

4. **Desacoplamiento:** Separar la lógica de la base de datos permite evolucionar ambos componentes independientemente. Se puede cambiar la BD sin tocar la API y viceversa.

5. **Observabilidad:** CloudWatch Logs, métricas automáticas, y AWS X-Ray para trazabilidad completa de cada invocación.

6. **Seguridad:** API Gateway permite autenticación con API Keys, IAM, Cognito o JWT. Se puede controlar acceso granular por endpoint.

### Arquitectura propuesta

```
┌─────────────┐     ┌─────────────────┐     ┌──────────────────┐     ┌─────────────────────────┐
│   Cliente    │────▶│  API Gateway    │────▶│  AWS Lambda      │────▶│  Aurora Serverless v2    │
│  (App/Web)  │◀────│  (REST API)     │◀────│  (Python/Node)   │◀────│  (PostgreSQL)            │
└─────────────┘     └─────────────────┘     └──────────────────┘     └─────────────────────────┘
                           │                        │                          │
                    ┌──────┴──────┐          ┌──────┴──────┐           ┌───────┴───────┐
                    │ - Auth JWT  │          │ - Validación│           │ - correspon-  │
                    │ - Throttle  │          │ - Query DB  │           │   sales_      │
                    │ - WAF       │          │ - Response  │           │   bancarios   │
                    │ - Cache     │          │   mapping   │           │ - transac-    │
                    └─────────────┘          └─────────────┘           │   ciones_     │
                                                                      │   corban      │
                                                                      └───────────────┘
```

---

## 6. Ejemplo de Base de Datos Migrada (Aurora PostgreSQL)

### 6.1 DDL — Creación de tablas

```sql
-- Esquema
CREATE SCHEMA IF NOT EXISTS middleware;

-- Tabla de corresponsales bancarios
CREATE TABLE middleware.corresponsales_bancarios (
    codigo_corresponsal  VARCHAR(20)  NOT NULL,
    codigo_pais          VARCHAR(5)   NOT NULL,
    nombre_corresponsal  VARCHAR(100),
    cuenta_credito       VARCHAR(30)  NOT NULL,
    cuenta_debito        VARCHAR(30)  NOT NULL,
    moneda_permitida     VARCHAR(5)   NOT NULL,
    cuenta_comision      VARCHAR(30)  NOT NULL,
    estado               CHAR(1)      NOT NULL DEFAULT 'A',
    fecha_creacion       TIMESTAMP    NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion   TIMESTAMP,
    
    CONSTRAINT pk_corresponsales 
        PRIMARY KEY (codigo_corresponsal, codigo_pais),
    CONSTRAINT chk_estado_corr 
        CHECK (estado IN ('A', 'I'))
);

-- Tabla de transacciones por corresponsal
CREATE TABLE middleware.transacciones_corban (
    codigo_corresponsal       VARCHAR(20)    NOT NULL,
    codigo_pais               VARCHAR(5)     NOT NULL,
    codigo_transaccion        VARCHAR(20)    NOT NULL,
    tipo_transaccion          VARCHAR(30)    NOT NULL,
    monto_comision            NUMERIC(15,2)  NOT NULL DEFAULT 0,
    moneda_comision           VARCHAR(5)     NOT NULL,
    tipo_transaccion_comision VARCHAR(30),
    estado                    CHAR(1)        NOT NULL DEFAULT 'A',
    fecha_creacion            TIMESTAMP      NOT NULL DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion        TIMESTAMP,

    CONSTRAINT pk_transacciones 
        PRIMARY KEY (codigo_corresponsal, codigo_pais, codigo_transaccion),
    CONSTRAINT fk_transacciones_corresponsal 
        FOREIGN KEY (codigo_corresponsal, codigo_pais) 
        REFERENCES middleware.corresponsales_bancarios(codigo_corresponsal, codigo_pais),
    CONSTRAINT chk_estado_trans 
        CHECK (estado IN ('A', 'I'))
);

-- Índices para optimizar consultas del patrón de acceso actual
CREATE INDEX idx_corr_estado 
    ON middleware.corresponsales_bancarios(codigo_corresponsal, codigo_pais, estado);

CREATE INDEX idx_trans_estado 
    ON middleware.transacciones_corban(codigo_corresponsal, codigo_pais, codigo_transaccion, estado);
```

### 6.2 Datos de ejemplo

```sql
-- Corresponsales bancarios
INSERT INTO middleware.corresponsales_bancarios VALUES
('CORBAN001', 'SV', 'Farmacia San Nicolás',     '0011234567890', '0019876543210', 'USD', '0015551234567', 'A', '2024-01-15 08:00:00', NULL),
('CORBAN002', 'SV', 'Super Selectos Escalón',    '0011234567891', '0019876543211', 'USD', '0015551234568', 'A', '2024-02-20 10:30:00', NULL),
('CORBAN003', 'GT', 'Tienda La Bendición',       '0021234567890', '0029876543210', 'GTQ', '0025551234567', 'A', '2024-03-10 09:00:00', NULL),
('CORBAN004', 'HN', 'Pulpería El Progreso',      '0031234567890', '0039876543210', 'HNL', '0035551234567', 'A', '2024-04-05 11:00:00', NULL),
('CORBAN005', 'SV', 'Librería Cultural',         '0011234567892', '0019876543212', 'USD', '0015551234569', 'I', '2024-01-20 08:00:00', '2024-09-15 14:00:00');

-- Transacciones por corresponsal
INSERT INTO middleware.transacciones_corban VALUES
('CORBAN001', 'SV', 'TRX001', 'DEPOSITO',     1.50, 'USD', 'COMISION_FIJA',     'A', '2024-01-15 08:00:00', NULL),
('CORBAN001', 'SV', 'TRX002', 'RETIRO',       2.00, 'USD', 'COMISION_FIJA',     'A', '2024-01-15 08:00:00', NULL),
('CORBAN001', 'SV', 'TRX003', 'PAGO_SERVICIO',0.75, 'USD', 'COMISION_PORCENTAJE','A', '2024-01-15 08:00:00', NULL),
('CORBAN002', 'SV', 'TRX001', 'DEPOSITO',     1.50, 'USD', 'COMISION_FIJA',     'A', '2024-02-20 10:30:00', NULL),
('CORBAN002', 'SV', 'TRX004', 'TRANSFERENCIA',3.00, 'USD', 'COMISION_FIJA',     'A', '2024-02-20 10:30:00', NULL),
('CORBAN003', 'GT', 'TRX001', 'DEPOSITO',     5.00, 'GTQ', 'COMISION_FIJA',     'A', '2024-03-10 09:00:00', NULL),
('CORBAN003', 'GT', 'TRX002', 'RETIRO',       7.50, 'GTQ', 'COMISION_FIJA',     'A', '2024-03-10 09:00:00', NULL),
('CORBAN004', 'HN', 'TRX001', 'DEPOSITO',    10.00, 'HNL', 'COMISION_FIJA',     'A', '2024-04-05 11:00:00', NULL),
('CORBAN004', 'HN', 'TRX005', 'PAGO_PRESTAMO',5.00, 'HNL', 'COMISION_PORCENTAJE','A', '2024-04-05 11:00:00', NULL),
('CORBAN001', 'SV', 'TRX006', 'CONSULTA',     0.00, 'USD', 'SIN_COMISION',      'I', '2024-01-15 08:00:00', '2024-08-01 12:00:00');
```

### 6.3 Ejemplo de consulta equivalente al SP

```sql
-- Consulta 1: Validar corresponsal activo
SELECT cuenta_credito, cuenta_debito, moneda_permitida, cuenta_comision
FROM middleware.corresponsales_bancarios
WHERE codigo_corresponsal = 'CORBAN001'
  AND codigo_pais = 'SV'
  AND estado = 'A';

-- Resultado:
-- cuenta_credito  | cuenta_debito   | moneda_permitida | cuenta_comision
-- 0011234567890   | 0019876543210   | USD              | 0015551234567

-- Consulta 2: Validar transacción activa
SELECT tipo_transaccion, monto_comision, moneda_comision, tipo_transaccion_comision
FROM middleware.transacciones_corban
WHERE codigo_corresponsal = 'CORBAN001'
  AND codigo_pais = 'SV'
  AND codigo_transaccion = 'TRX001'
  AND estado = 'A';

-- Resultado:
-- tipo_transaccion | monto_comision | moneda_comision | tipo_transaccion_comision
-- DEPOSITO         | 1.50           | USD             | COMISION_FIJA
```

---

## 7. Ejemplo de Lambda (Python) que reemplaza el SP

```python
import json
import os
import psycopg2
from psycopg2.extras import RealDictCursor

# Conexión a Aurora PostgreSQL (usar Secrets Manager en producción)
DB_CONFIG = {
    "host": os.environ.get("DB_HOST"),
    "port": int(os.environ.get("DB_PORT", 5432)),
    "dbname": os.environ.get("DB_NAME"),
    "user": os.environ.get("DB_USER"),
    "password": os.environ.get("DB_PASSWORD"),
}

def lambda_handler(event, context):
    # Extraer parámetros del request
    body = json.loads(event.get("body", "{}"))
    codigo_corresponsal = body.get("codigo_corresponsal")
    codigo_pais = body.get("codigo_pais")
    codigo_transaccion = body.get("codigo_transaccion")

    # Validación de entrada
    if not codigo_corresponsal:
        return response(400, "ERROR", "Parámetro codigo_corresponsal es requerido.")
    if not codigo_pais:
        return response(400, "ERROR", "Parámetro codigo_pais es requerido.")
    if not codigo_transaccion:
        return response(400, "ERROR", "Parámetro codigo_transaccion es requerido.")

    conn = None
    try:
        conn = psycopg2.connect(**DB_CONFIG)
        cur = conn.cursor(cursor_factory=RealDictCursor)

        # Consulta 1: Validar corresponsal
        cur.execute("""
            SELECT cuenta_credito, cuenta_debito, moneda_permitida, cuenta_comision
            FROM middleware.corresponsales_bancarios
            WHERE codigo_corresponsal = %s
              AND codigo_pais = %s
              AND estado = 'A'
        """, (codigo_corresponsal, codigo_pais))

        corresponsal = cur.fetchone()
        if not corresponsal:
            return response(404, "ERROR",
                "No se encontró el corresponsal o está inactivo.")

        # Consulta 2: Validar transacción
        cur.execute("""
            SELECT tipo_transaccion, monto_comision, moneda_comision,
                   tipo_transaccion_comision
            FROM middleware.transacciones_corban
            WHERE codigo_corresponsal = %s
              AND codigo_pais = %s
              AND codigo_transaccion = %s
              AND estado = 'A'
        """, (codigo_corresponsal, codigo_pais, codigo_transaccion))

        transaccion = cur.fetchone()
        if not transaccion:
            return response(404, "ERROR",
                "No se encontró la transacción o está inactiva.")

        # Respuesta exitosa combinando ambas consultas
        resultado = {
            **corresponsal,
            **transaccion,
            "monto_comision": float(transaccion["monto_comision"]),
        }
        return response(200, "SUCCESS", "Validación exitosa.", resultado)

    except Exception as e:
        return response(500, "ERROR", f"Error interno: {str(e)}")
    finally:
        if conn:
            conn.close()


def response(status_code, codigo_mensaje, mensaje, data=None):
    body = {
        "codigo_mensaje": codigo_mensaje,
        "mensaje": mensaje,
    }
    if data:
        body["data"] = data
    return {
        "statusCode": status_code,
        "headers": {"Content-Type": "application/json"},
        "body": json.dumps(body, default=str),
    }
```

### Ejemplo de invocación (request/response)

**Request:**
```json
POST /validar-corresponsal
Content-Type: application/json

{
    "codigo_corresponsal": "CORBAN001",
    "codigo_pais": "SV",
    "codigo_transaccion": "TRX001"
}
```

**Response (200 OK):**
```json
{
    "codigo_mensaje": "SUCCESS",
    "mensaje": "Validación exitosa.",
    "data": {
        "cuenta_credito": "0011234567890",
        "cuenta_debito": "0019876543210",
        "moneda_permitida": "USD",
        "cuenta_comision": "0015551234567",
        "tipo_transaccion": "DEPOSITO",
        "monto_comision": 1.50,
        "moneda_comision": "USD",
        "tipo_transaccion_comision": "COMISION_FIJA"
    }
}
```

---

## 8. Resumen Ejecutivo

| Aspecto | Recomendación |
|---|---|
| **Base de datos** | Amazon Aurora Serverless v2 (PostgreSQL) |
| **Lógica del SP** | AWS Lambda (Python) + API Gateway |
| **Migración de datos** | AWS DMS + Schema Conversion Tool |
| **Autenticación** | API Gateway con JWT / Amazon Cognito |
| **Monitoreo** | CloudWatch + X-Ray |
| **Infraestructura como código** | AWS CDK o Terraform |
| **Costo estimado mensual (baja carga)** | ~$30-50 USD (Aurora Serverless + Lambda free tier) |

Esta arquitectura moderniza la solución actual, elimina costos de licenciamiento Oracle, desacopla la lógica de negocio de la base de datos, y permite escalar cada componente de forma independiente.
