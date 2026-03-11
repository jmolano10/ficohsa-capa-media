# Análisis de Migración a AWS - Sistema de Corresponsales Bancarios

## 1. Análisis de Datos Actuales

### Tabla 1: MW_CORRESPONSALES_BANCARIOS
**Estructura:**
- CODIGO_CORRESPONSAL (PK)
- NOMBRE_CORRESPONSAL
- ESTADO
- CUENTA_CREDITO
- CUENTA_DEBITO
- MONEDA_PERMITIDA
- CODIGO_PAIS
- CUENTA_COMISION

**Datos actuales:** 3 corresponsales (101: TENGO PUNTOS, 102: TENGO BILLETERA ELECTRONICA, 103: TARJETAS RECARGABLES TENGO)

### Tabla 2: MW_TRANSACCIONES_CORBAN
**Estructura:**
- CODIGO_CORRESPONSAL (FK)
- CODIGO_TRANSACCION (PK)
- DESCRIPCION
- ESTADO
- MONTO_MAX_X_TRN
- TIPO_TRANSACCION
- CODIGO_PAIS
- MONTO_COMISION
- MONEDA_COMISION
- TIPO_TRANSACCION_COMISION

**Datos actuales:** 27 registros con 9 tipos de transacciones (Pago de préstamo, Depósito referenciado, Pago de tarjeta de crédito, etc.)

### Stored Procedure: MW_P_VALIDA_CORBAN
**Funcionalidad:**
- Valida la existencia y estado activo de un corresponsal bancario
- Recupera información de cuentas y moneda permitida
- Valida la transacción específica para ese corresponsal
- Retorna datos de comisiones y tipo de transacción
- Manejo de errores con códigos de respuesta

**Lógica:**
1. Validación de parámetros de entrada
2. Consulta a MW_CORRESPONSALES_BANCARIOS por código de corresponsal y país
3. Consulta a MW_TRANSACCIONES_CORBAN por código de transacción
4. Retorno de 11 parámetros OUT con información consolidada

---

## 2. Comparativa de Servicios AWS para Migración de Tablas

| Servicio | Tipo | Ventajas | Desventajas | Costo Estimado | Caso de Uso Ideal |
|----------|------|----------|-------------|----------------|-------------------|
| **Amazon RDS (Oracle)** | Relacional Managed | • Migración directa sin cambios<br>• Mantiene SPs nativos<br>• Compatibilidad 100%<br>• Backups automáticos<br>• Multi-AZ para HA | • Costo más alto<br>• Licenciamiento Oracle<br>• Menos escalabilidad<br>• Vendor lock-in Oracle | $$$$<br>(Alto) | Migración lift-and-shift sin cambios |
| **Amazon RDS (PostgreSQL)** | Relacional Managed | • Sin licencias costosas<br>• Stored procedures soportados<br>• Buen rendimiento<br>• Backups automáticos<br>• Comunidad activa | • Requiere conversión de SP<br>• Sintaxis diferente<br>• Testing extensivo necesario | $$<br>(Medio) | Modernización con BD relacional open source |
| **Amazon Aurora (PostgreSQL)** | Relacional Serverless | • Alto rendimiento (5x PostgreSQL)<br>• Escalabilidad automática<br>• Serverless v2 disponible<br>• Multi-AZ nativo<br>• Backups continuos | • Costo mayor que RDS estándar<br>• Requiere conversión de SP<br>• Complejidad inicial | $$$<br>(Medio-Alto) | Alta disponibilidad y rendimiento crítico |
| **Amazon DynamoDB** | NoSQL | • Escalabilidad masiva<br>• Latencia < 10ms<br>• Serverless nativo<br>• Pay-per-request<br>• Sin administración | • Requiere rediseño completo<br>• No soporta JOINs<br>• Cambio de paradigma<br>• Lógica en aplicación | $<br>(Bajo-Medio) | Aplicaciones con alta escala y baja latencia |
| **Amazon Aurora Serverless v2** | Relacional Serverless | • Escala automática (0.5-128 ACU)<br>• Pago por uso real<br>• Arranque instantáneo<br>• Compatible PostgreSQL/MySQL<br>• Ideal para cargas variables | • Requiere conversión de Oracle<br>• Costo puede variar<br>• Curva de aprendizaje | $$<br>(Variable) | Cargas de trabajo impredecibles o intermitentes |

---

## 3. Recomendación: Mejor Opción

### **🏆 Amazon Aurora PostgreSQL Serverless v2**

**Justificación:**

1. **Escalabilidad y Costo-Beneficio:** Aurora Serverless v2 escala automáticamente según la demanda, ideal para sistemas de corresponsales bancarios con patrones de tráfico variables. Solo pagas por lo que usas.

2. **Rendimiento:** Hasta 5x mejor rendimiento que PostgreSQL estándar, crítico para validaciones en tiempo real de transacciones bancarias.

3. **Alta Disponibilidad:** Multi-AZ nativo con replicación automática en 3 zonas de disponibilidad, garantizando 99.99% de disponibilidad.

4. **Sin Licenciamiento:** Elimina costos de licencias Oracle, reduciendo TCO significativamente.

5. **Modernización Gradual:** Permite mantener stored procedures mientras migras gradualmente a arquitecturas modernas.

6. **Seguridad:** Encriptación en reposo y tránsito, integración con AWS IAM, VPC isolation, y cumplimiento con estándares bancarios (PCI-DSS).

**Migración recomendada:**
- Usar AWS Schema Conversion Tool (SCT) para convertir el SP de Oracle a PostgreSQL
- Usar AWS Database Migration Service (DMS) para migrar los datos
- Tiempo estimado: 2-4 semanas

---

## 4. Arquitectura Recomendada para la Lógica del Stored Procedure

### **Opción Recomendada: API REST con AWS Lambda + API Gateway**

**Arquitectura Propuesta:**

```
Cliente → API Gateway → Lambda Function → Aurora PostgreSQL Serverless v2
                              ↓
                         CloudWatch Logs
```

### Comparativa de Arquitecturas

| Arquitectura | Ventajas | Desventajas | Recomendación |
|--------------|----------|-------------|---------------|
| **Mantener SP en BD** | • Sin cambios de código<br>• Lógica centralizada<br>• Transacciones ACID nativas | • Acoplamiento fuerte<br>• Difícil de testear<br>• Escalabilidad limitada<br>• Difícil versionamiento | ❌ No recomendado para modernización |
| **API REST + Lambda** | • Desacoplamiento<br>• Escalabilidad independiente<br>• Fácil testing y CI/CD<br>• Versionamiento de API<br>• Múltiples clientes<br>• Serverless (sin servidores) | • Requiere desarrollo<br>• Latencia de red adicional<br>• Gestión de API | ✅ **RECOMENDADO** |
| **Lambda Direct Invoke** | • Menor latencia<br>• Más simple<br>• Serverless | • Sin gestión de API<br>• Menos flexible<br>• Difícil para múltiples clientes | ⚠️ Solo para uso interno |
| **ECS/Fargate + API** | • Contenedores<br>• Control total<br>• Microservicios | • Mayor complejidad<br>• Gestión de contenedores<br>• Costo más alto | ⚠️ Solo si ya usan contenedores |

### **Arquitectura Detallada Recomendada:**

```
┌─────────────────────────────────────────────────────────────────┐
│                        CAPA DE PRESENTACIÓN                      │
│  Mobile App / Web App / Core Banking System / Third Party APIs   │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│                         API GATEWAY                              │
│  • REST API                                                      │
│  • Autenticación (API Keys / IAM / Cognito)                     │
│  • Rate Limiting & Throttling                                    │
│  • Request/Response Validation                                   │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│                      AWS LAMBDA FUNCTION                         │
│  • Runtime: Python 3.11 / Node.js 18 / Java 17                  │
│  • Función: validarCorresponsal()                                │
│  • Timeout: 30 segundos                                          │
│  • Memory: 512 MB                                                │
│  • VPC: Conectada a subnets privadas                            │
└────────────────────────────┬────────────────────────────────────┘
                             │
                             ▼
┌─────────────────────────────────────────────────────────────────┐
│              AMAZON AURORA POSTGRESQL SERVERLESS V2              │
│  • Tablas: corresponsales_bancarios, transacciones_corban       │
│  • Auto-scaling: 0.5 - 16 ACU                                   │
│  • Multi-AZ: 3 réplicas                                          │
│  • Encryption: AES-256                                           │
└─────────────────────────────────────────────────────────────────┘

                    SERVICIOS COMPLEMENTARIOS
┌──────────────────┐  ┌──────────────────┐  ┌──────────────────┐
│  CloudWatch      │  │  AWS Secrets     │  │   AWS WAF        │
│  Logs & Metrics  │  │  Manager         │  │   (Firewall)     │
└──────────────────┘  └──────────────────┘  └──────────────────┘
```

### **Beneficios de la Arquitectura Propuesta:**

1. **Desacoplamiento:** La lógica de negocio está separada de la base de datos
2. **Escalabilidad:** Lambda escala automáticamente de 0 a miles de invocaciones
3. **Mantenibilidad:** Código versionado en Git, CI/CD con AWS CodePipeline
4. **Testing:** Unit tests, integration tests, y mocks fáciles de implementar
5. **Observabilidad:** CloudWatch Logs, X-Ray tracing, métricas detalladas
6. **Seguridad:** WAF, API Gateway authentication, Secrets Manager para credenciales
7. **Costo:** Pay-per-use, sin servidores idle

---

## 5. Ejemplo de Implementación Lambda (Python)

```python
import json
import psycopg2
import os
from aws_lambda_powertools import Logger, Tracer
from aws_lambda_powertools.utilities.typing import LambdaContext

logger = Logger()
tracer = Tracer()

@tracer.capture_lambda_handler
@logger.inject_lambda_context
def lambda_handler(event, context: LambdaContext):
    """
    Valida corresponsal bancario y transacción
    """
    try:
        # Parsear request
        body = json.loads(event['body']) if isinstance(event.get('body'), str) else event
        
        codigo_corresponsal = body.get('codigoCorresponsal')
        codigo_pais = body.get('codigoPais')
        codigo_transaccion = body.get('codigoTransaccion')
        
        # Validaciones
        if not codigo_corresponsal:
            return response_error('ERROR', 'Parámetro codigoCorresponsal requerido')
        if not codigo_pais:
            return response_error('ERROR', 'Parámetro codigoPais requerido')
        
        # Conectar a Aurora
        conn = get_db_connection()
        cursor = conn.cursor()
        
        # Consulta 1: Validar corresponsal
        cursor.execute("""
            SELECT cuenta_credito, cuenta_debito, moneda_permitida, cuenta_comision
            FROM corresponsales_bancarios
            WHERE codigo_corresponsal = %s 
            AND codigo_pais = %s 
            AND estado = 'A'
        """, (codigo_corresponsal, codigo_pais))
        
        corresponsal = cursor.fetchone()
        if not corresponsal:
            return response_error('ERROR', 'Corresponsal no encontrado o inactivo')
        
        # Consulta 2: Validar transacción
        cursor.execute("""
            SELECT tipo_transaccion, monto_comision, moneda_comision, tipo_transaccion_comision
            FROM transacciones_corban
            WHERE codigo_corresponsal = %s 
            AND codigo_pais = %s 
            AND codigo_transaccion = %s 
            AND estado = 'A'
        """, (codigo_corresponsal, codigo_pais, codigo_transaccion))
        
        transaccion = cursor.fetchone()
        if not transaccion:
            return response_error('ERROR', 'Transacción no encontrada o inactiva')
        
        # Respuesta exitosa
        return {
            'statusCode': 200,
            'body': json.dumps({
                'codigoMensaje': 'SUCCESS',
                'mensajeError': 'Éxito en transacción',
                'data': {
                    'cuentaCredito': corresponsal[0],
                    'cuentaDebito': corresponsal[1],
                    'monedaPermitida': corresponsal[2],
                    'cuentaComision': corresponsal[3],
                    'tipoTransaccion': transaccion[0],
                    'montoComision': transaccion[1],
                    'monedaComision': transaccion[2],
                    'tipoTransaccionComision': transaccion[3]
                }
            })
        }
        
    except Exception as e:
        logger.exception("Error en validación")
        return response_error('ERROR', f'Error general: {str(e)}')
    finally:
        if 'cursor' in locals():
            cursor.close()
        if 'conn' in locals():
            conn.close()

def get_db_connection():
    return psycopg2.connect(
        host=os.environ['DB_HOST'],
        database=os.environ['DB_NAME'],
        user=os.environ['DB_USER'],
        password=os.environ['DB_PASSWORD']
    )

def response_error(codigo, mensaje):
    return {
        'statusCode': 400,
        'body': json.dumps({
            'codigoMensaje': codigo,
            'mensajeError': mensaje
        })
    }
```

---

## 6. Esquema de Base de Datos en Aurora PostgreSQL

### DDL - Tabla corresponsales_bancarios

```sql
CREATE TABLE corresponsales_bancarios (
    codigo_corresponsal VARCHAR(10) NOT NULL,
    nombre_corresponsal VARCHAR(100) NOT NULL,
    estado CHAR(1) NOT NULL DEFAULT 'A',
    cuenta_credito VARCHAR(20) NOT NULL,
    cuenta_debito VARCHAR(20) NOT NULL,
    moneda_permitida VARCHAR(3) NOT NULL,
    codigo_pais VARCHAR(4) NOT NULL,
    cuenta_comision VARCHAR(20),
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usuario_creacion VARCHAR(50),
    usuario_modificacion VARCHAR(50),
    PRIMARY KEY (codigo_corresponsal, codigo_pais),
    CONSTRAINT chk_estado CHECK (estado IN ('A', 'I'))
);

CREATE INDEX idx_corresponsal_estado ON corresponsales_bancarios(estado);
CREATE INDEX idx_corresponsal_pais ON corresponsales_bancarios(codigo_pais);
```

### DDL - Tabla transacciones_corban

```sql
CREATE TABLE transacciones_corban (
    codigo_corresponsal VARCHAR(10) NOT NULL,
    codigo_transaccion VARCHAR(10) NOT NULL,
    descripcion VARCHAR(100) NOT NULL,
    estado CHAR(1) NOT NULL DEFAULT 'A',
    monto_max_x_trn DECIMAL(15,2),
    tipo_transaccion VARCHAR(10),
    codigo_pais VARCHAR(4) NOT NULL,
    monto_comision DECIMAL(10,2),
    moneda_comision VARCHAR(3),
    tipo_transaccion_comision VARCHAR(10),
    fecha_creacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    fecha_modificacion TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    usuario_creacion VARCHAR(50),
    usuario_modificacion VARCHAR(50),
    PRIMARY KEY (codigo_corresponsal, codigo_transaccion, codigo_pais),
    CONSTRAINT fk_corresponsal FOREIGN KEY (codigo_corresponsal, codigo_pais) 
        REFERENCES corresponsales_bancarios(codigo_corresponsal, codigo_pais)
        ON DELETE RESTRICT ON UPDATE CASCADE,
    CONSTRAINT chk_trn_estado CHECK (estado IN ('A', 'I'))
);

CREATE INDEX idx_transaccion_estado ON transacciones_corban(estado);
CREATE INDEX idx_transaccion_tipo ON transacciones_corban(tipo_transaccion);
CREATE INDEX idx_transaccion_pais ON transacciones_corban(codigo_pais);
```

### Ejemplo de Registros Migrados

**Tabla: corresponsales_bancarios**
```sql
INSERT INTO corresponsales_bancarios VALUES
('101', 'TENGO PUNTOS CORRESPONSALES', 'A', 'HNL151450001', 'HNL151450001', 'HNL', 'HN01', 'PL52280', NOW(), NOW(), 'MIGRATION_USER', 'MIGRATION_USER'),
('102', 'TENGO BILLETERA ELECTRONICA', 'A', 'HNL152390001', 'HNL152390001', 'HNL', 'HN01', 'PL52280', NOW(), NOW(), 'MIGRATION_USER', 'MIGRATION_USER'),
('103', 'TARJETAS RECARGABLES TENGO', 'A', 'HNL152410001', 'HNL152410001', 'HNL', 'HN01', 'PL52280', NOW(), NOW(), 'MIGRATION_USER', 'MIGRATION_USER');
```

**Tabla: transacciones_corban (muestra)**
```sql
INSERT INTO transacciones_corban VALUES
('101', '2', 'PAGO DE PRESTAMO', 'A', 30000.00, NULL, 'HN01', NULL, NULL, NULL, NOW(), NOW(), 'MIGRATION_USER', 'MIGRATION_USER'),
('101', '7', 'DEPOSITO REFERENCIADO', 'A', NULL, NULL, 'HN01', NULL, NULL, NULL, NOW(), NOW(), 'MIGRATION_USER', 'MIGRATION_USER'),
('101', '5', 'PAGO DE TARJETA CREDITO', 'A', 30000.00, NULL, 'HN01', NULL, NULL, NULL, NOW(), NOW(), 'MIGRATION_USER', 'MIGRATION_USER'),
('102', '2', 'PAGO DE PRESTAMO', 'A', 30000.00, NULL, 'HN01', NULL, NULL, NULL, NOW(), NOW(), 'MIGRATION_USER', 'MIGRATION_USER'),
('102', '4', 'RETIRO EFECTIVO', 'A', 30000.00, 'ACTR', 'HN01', NULL, 'HNL', 'ACT3', NOW(), NOW(), 'MIGRATION_USER', 'MIGRATION_USER'),
('103', '4', 'RETIRO EFECTIVO', 'A', 30000.00, 'ACTR', 'HN01', 10.00, 'HNL', 'ACT3', NOW(), NOW(), 'MIGRATION_USER', 'MIGRATION_USER');
```

---

## 7. Arquitectura Completa de Migración

### Stack Tecnológico Recomendado

**Capa de Datos:**
- Amazon Aurora PostgreSQL Serverless v2
- AWS Secrets Manager (credenciales)
- Amazon S3 (backups adicionales)

**Capa de Aplicación:**
- AWS Lambda (Python 3.11 o Node.js 18)
- Amazon API Gateway (REST API)
- AWS Lambda Layers (librerías compartidas: psycopg2, boto3)

**Seguridad:**
- AWS WAF (protección API)
- Amazon VPC (aislamiento de red)
- AWS IAM (control de acceso)
- AWS KMS (encriptación)

**Observabilidad:**
- Amazon CloudWatch Logs
- AWS X-Ray (tracing distribuido)
- CloudWatch Alarms (alertas)
- CloudWatch Dashboards

**CI/CD:**
- AWS CodeCommit / GitHub
- AWS CodeBuild
- AWS CodePipeline
- AWS SAM / Serverless Framework

### Diagrama de Flujo de la API

```
POST /api/v1/corresponsales/validar
{
  "codigoCorresponsal": "101",
  "codigoPais": "HN01",
  "codigoTransaccion": "2"
}

↓

1. API Gateway valida request y autenticación
2. Lambda recibe evento
3. Lambda valida parámetros
4. Lambda consulta Aurora (corresponsal)
5. Lambda consulta Aurora (transacción)
6. Lambda construye respuesta
7. API Gateway retorna respuesta

↓

Response 200 OK:
{
  "codigoMensaje": "SUCCESS",
  "mensajeError": "Éxito en transacción",
  "data": {
    "cuentaCredito": "HNL151450001",
    "cuentaDebito": "HNL151450001",
    "monedaPermitida": "HNL",
    "cuentaComision": "PL52280",
    "tipoTransaccion": null,
    "montoComision": null,
    "monedaComision": null,
    "tipoTransaccionComision": null
  }
}
```

---

## 8. Plan de Migración (Fases)

### Fase 1: Preparación (1 semana)
- [ ] Análisis detallado de dependencias
- [ ] Configuración de entorno AWS
- [ ] Creación de VPC y subnets
- [ ] Configuración de Aurora Serverless v2

### Fase 2: Migración de Datos (1 semana)
- [ ] Conversión de esquema con AWS SCT
- [ ] Migración de datos con AWS DMS
- [ ] Validación de integridad de datos
- [ ] Testing de queries

### Fase 3: Desarrollo de API (2 semanas)
- [ ] Desarrollo de Lambda function
- [ ] Configuración de API Gateway
- [ ] Implementación de autenticación
- [ ] Unit testing y integration testing

### Fase 4: Testing y QA (1 semana)
- [ ] Testing funcional
- [ ] Testing de carga
- [ ] Testing de seguridad
- [ ] Validación con usuarios

### Fase 5: Despliegue (1 semana)
- [ ] Despliegue en ambiente de staging
- [ ] Migración gradual (canary deployment)
- [ ] Monitoreo intensivo
- [ ] Rollback plan preparado

---

## 9. Estimación de Costos Mensuales (Escenario Típico)

**Supuestos:**
- 100,000 transacciones/mes
- 2 ACU promedio en Aurora
- 1 GB de almacenamiento

| Servicio | Costo Mensual (USD) |
|----------|---------------------|
| Aurora Serverless v2 (2 ACU × 730h) | ~$105 |
| Aurora Storage (1 GB) | ~$0.10 |
| API Gateway (100K requests) | ~$0.35 |
| Lambda (100K invocations, 512MB, 1s avg) | ~$0.20 |
| CloudWatch Logs (1 GB) | ~$0.50 |
| Data Transfer | ~$5 |
| **TOTAL ESTIMADO** | **~$111/mes** |

**Comparación con Oracle RDS:**
- RDS Oracle (db.t3.medium): ~$500-800/mes + licencias
- **Ahorro estimado: 80-85%**

---

## 10. Consideraciones de Seguridad Bancaria

### Cumplimiento Normativo
- ✅ PCI-DSS: Aurora y Lambda son servicios PCI-DSS compliant
- ✅ Encriptación en reposo (AES-256)
- ✅ Encriptación en tránsito (TLS 1.2+)
- ✅ Auditoría con AWS CloudTrail
- ✅ Aislamiento de red con VPC

### Mejores Prácticas Implementadas
1. **Secrets Manager:** Credenciales rotadas automáticamente
2. **IAM Roles:** Principio de menor privilegio
3. **VPC Endpoints:** Tráfico privado sin internet
4. **WAF Rules:** Protección contra OWASP Top 10
5. **Rate Limiting:** Prevención de abuso
6. **Logging:** Auditoría completa de todas las operaciones

---

## 11. Ventajas de la Migración

### Técnicas
- ✅ Escalabilidad automática
- ✅ Alta disponibilidad (99.99%)
- ✅ Latencia reducida
- ✅ Backups automáticos
- ✅ Disaster recovery mejorado

### Operacionales
- ✅ Sin gestión de servidores
- ✅ Actualizaciones automáticas
- ✅ Monitoreo centralizado
- ✅ CI/CD simplificado
- ✅ Versionamiento de código

### Financieras
- ✅ Reducción de costos 80%+
- ✅ Pay-per-use
- ✅ Sin licencias Oracle
- ✅ Sin infraestructura on-premise
- ✅ Optimización continua

---

## 12. Próximos Pasos Recomendados

1. **Inmediato:**
   - Crear cuenta AWS o usar existente
   - Configurar AWS Organizations para governance
   - Establecer presupuestos y alertas de costos

2. **Corto Plazo (1-2 semanas):**
   - Provisionar Aurora Serverless v2 en ambiente de desarrollo
   - Migrar datos de prueba
   - Desarrollar Lambda function inicial

3. **Mediano Plazo (1 mes):**
   - Completar desarrollo de API
   - Testing exhaustivo
   - Documentación de API (OpenAPI/Swagger)

4. **Largo Plazo (2-3 meses):**
   - Despliegue en producción
   - Migración gradual del tráfico
   - Optimización basada en métricas reales

---

## Conclusión

La migración a **Amazon Aurora PostgreSQL Serverless v2 con API REST en Lambda** ofrece la mejor combinación de:
- **Rendimiento:** Latencia baja y alta disponibilidad
- **Costo:** Reducción significativa vs Oracle
- **Escalabilidad:** Automática según demanda
- **Modernización:** Arquitectura desacoplada y cloud-native
- **Seguridad:** Cumplimiento con estándares bancarios

Esta arquitectura posiciona el sistema para crecimiento futuro, facilita la integración con otros servicios, y reduce significativamente los costos operacionales mientras mejora la confiabilidad y mantenibilidad del sistema.
