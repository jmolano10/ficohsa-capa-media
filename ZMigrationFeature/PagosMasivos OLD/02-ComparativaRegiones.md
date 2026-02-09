# Comparativa entre Regiones - PagosMasivos

## Tabla de Comparación General

| Aspecto | HN01 (Honduras) | GT01 (Guatemala) | PA01 (Panamá) | NI01 (Nicaragua) |
|---------|-----------------|------------------|---------------|------------------|
| **Endpoint OSB** | `/Middleware/OperationsAndExecution/Payments/PagosMasivos` | `/Middleware/OperationsAndExecution/Payments/PagosMasivos` | `/Middleware/OperationsAndExecution/Payments/PagosMasivos` | `/Middleware/OperationsAndExecution/Payments/PagosMasivos` |
| **Pipeline Interno** | `PagosMasivosInterno.pipeline` | `PagosMasivosInternoGT.pipeline` | `PagosMasivosInternoPA.pipeline` | `PagosMasivosInterno.pipeline` |
| **Tipo de Procesamiento** | Interno (BPEL + Oracle DB) | Externo (Servicio MTR) | Externo (Servicio MTR) | Externo (Servicio MTR) |
| **Servicio Backend** | `sjPagosMasivosInterno.flow` | `cargadorArchivoLote` (SOAP) | `cargadorArchivoLote` (SOAP) | `cargadorArchivoLote` (SOAP) |
| **Base de Datos** | Oracle Database (Local) | Base de datos externa (MTR) | Base de datos externa (MTR) | Base de datos externa (MTR) |
| **Esquema BD** | No especificado | No especificado | No especificado | No especificado |
| **Store Procedures** | `validaEstructuraLote`, `procesaLotePagoMasivo` | Gestionado por servicio externo | Gestionado por servicio externo | Gestionado por servicio externo |
| **Conexión BD** | `validaEstructuraLote_db`, `procesaLotePagoMasivo_db` | N/A | N/A | N/A |
| **Servicio Bitácora** | `registraBitacoraPagosMasivos_db` | `registraBitacoraPagosMasivosRG_db` | `registraBitacoraPagosMasivosRG_db` | N/A (sin bitácora) |
| **Validación de Acceso** | `validaAccesoPMS_db` (BD Local) | `validaAccesoPMS` (Servicio MTR) | `validaAccesoPMS` (Servicio MTR) | N/A |
| **Validación de Saldos** | Sí (ConsultaDetallesCuentaMasivos) | No | No | No |
| **Validación de Estado Cuenta** | Sí (consultaCuentasBS - T24) | No | No | No |
| **Procesamiento Paralelo** | Sí (forEach parallel="yes") | No | No | No |
| **Agrupación por Cuenta** | Sí | No | No | No |
| **Transformaciones XQuery** | `sjPagosMasivosInternoIn.xqy`, `pagosMasivosInternoOut.xqy` | `pagosMasivosInternoGTIn.xqy`, `pagosMasivosInternoGTOut.xqy`, `pagosMasivosInternoGTHeaderOut.xqy` | `pagosMasivosInternoPAIn.xqy`, `pagosMasivosInternoPAOut.xqy`, `pagosMasivosInternoPAHeaderOut.xqy` | `pagosMasivosInternoNIIn.xqy`, `pagosMasivosInternoNIOut.xqy`, `pagosMasivosInternoNIHeaderOut.xqy` |
| **Manejo de Errores** | Faults personalizados (saldoInsuficiente, estadoInvalido) | Error handler estándar | Error handler estándar | Error handler estándar |
| **Timeouts/Retrys** | No especificado | No especificado | No especificado | No especificado |
| **Dependencias Internas** | ValidaServicioRegional, MapeoErrores, ConsultaDetallesCuentaMasivos, consultaCuentasBS | ValidaServicioRegional, MapeoErrores, cargadorArchivoLote, validaAccesoPMS | ValidaServicioRegional, MapeoErrores, cargadorArchivoLote, validaAccesoPMS | ValidaServicioRegional, MapeoErrores, cargadorArchivoLote |

## Detalles por Región

### HN01 - Honduras

#### Características Específicas

**Arquitectura**:
- Procesamiento completamente interno
- Utiliza BPEL para orquestación
- Base de datos Oracle local
- Procesamiento paralelo de batches

**Flujo de Procesamiento**:
1. Validación de servicio regional (FICBCO0231)
2. Validación XSD del request
3. Bitácora de request
4. Validación de acceso de usuario (BD local)
5. Invocación a BPEL flow (sjPagosMasivosInterno)
6. Procesamiento paralelo de cada batch:
   - Validación de estructura (SP: validaEstructuraLote)
   - Agrupación de transacciones por cuenta
   - Validación de saldos (si DEBIT_ACCT_BALANCE=YES)
   - Validación de estado de cuenta (si DEBIT_ACCT_STATUS=YES)
   - Procesamiento del lote (SP: procesaLotePagoMasivo)
7. Bitácora de response
8. Mapeo de errores

**Validaciones Específicas**:
- **Saldo Insuficiente**: Consulta saldo disponible y compara con monto total
- **Estado de Cuenta**: Verifica INACTIVEMARKER y POSTINGRESTRICT
- **Estructura de Lote**: Validación de campos y formato

**Stored Procedures**:
```sql
-- validaEstructuraLote
InputParameters:
  - PV_CUSTOMER_ID
  - PV_BATCH (XML)
  - PV_BATCH_NUMBER

OutputParameters:
  - ERROR_CODE
  - ERROR_MESSAGE

-- procesaLotePagoMasivo
InputParameters:
  - PV_CUSTOMER_ID
  - PV_USERNAME
  - PV_BATCH (XML)
  - PV_BATCH_NUMBER
  - PV_GLOBAL_ID

OutputParameters:
  - BANK_BATCH_ID
  - STATUS
  - ERROR_CODE
  - ERROR_MESSAGE
```

**Servicios de Consulta**:
- **ConsultaDetallesCuentaMasivos**: Obtiene saldo disponible (CURRENT_BALANCE)
- **consultaCuentasBS**: Consulta T24 para validar estado (INACTIVEMARKER, POSTINGRESTRICT)

**Manejo de Errores Personalizado**:
```xml
<bpel:catch faultName="tns:saldoInsuficiente">
  <!-- Retorna error específico de saldo insuficiente -->
</bpel:catch>

<bpel:catch faultName="tns:estadoInvalido">
  <!-- Retorna error específico de estado inválido -->
</bpel:catch>
```

#### Endpoints y Conexiones

**Base de Datos**:
- Conexión: `validaEstructuraLote_db`, `procesaLotePagoMasivo_db`, `registraBitacoraPagosMasivos_db`, `validaAccesoPMS_db`
- Tipo: Oracle Database Adapter (JCA)
- Operaciones: Invocación de Stored Procedures

**Servicios SOAP Internos**:
- `ConsultaDetallesCuentaMasivos`: Consulta de saldos
- `consultaCuentasBS`: Consulta de detalles de cuenta T24

#### Campos Diferenciadores

- `DEBIT_ACCT_BALANCE`: Controla validación de saldos
- `DEBIT_ACCT_STATUS`: Controla validación de estado de cuenta
- Procesamiento paralelo de batches
- Agrupación de transacciones por cuenta débito

---

### GT01 - Guatemala

#### Características Específicas

**Arquitectura**:
- Procesamiento externo mediante servicio MTR
- No utiliza base de datos local para procesamiento
- Validación de acceso mediante servicio externo

**Flujo de Procesamiento**:
1. Validación de servicio regional (FICBCO0231)
2. Validación XSD del request
3. Bitácora de request (registraBitacoraPagosMasivosRG_db)
4. Validación de acceso de usuario (servicio MTR)
5. Transformación de request a formato MTR
6. Invocación a servicio externo cargadorArchivoLote
7. Transformación de response
8. Bitácora de response
9. Mapeo de errores

**Servicio Externo**:
```xml
<!-- cargadorArchivoLote -->
Endpoint: Servicio SOAP externo (MTR)
Namespace: http://servicio.cargararchivolotews.mtrpmsv.cidenet.com.co/
Operation: cargarLotes

Request:
  - Transformado desde pagosMasivos mediante pagosMasivosInternoGTIn.xqy

Response:
  - respuestaHostToHost/cabeceraRespuesta/codigo
  - respuestaHostToHost/cabeceraRespuesta/mensaje
```

**Validación de Acceso**:
```xml
<!-- validaAccesoPMS (MTR) -->
Request:
  - customerId
  - userName

Response:
  - status (00000 = SUCCESS)
  - message
```

**Transformaciones Específicas**:
- `pagosMasivosInternoGTIn.xqy`: Transforma request OSB a formato MTR
- `pagosMasivosInternoGTOut.xqy`: Transforma response MTR a formato OSB
- `pagosMasivosInternoGTHeaderOut.xqy`: Construye header de respuesta

#### Endpoints y Conexiones

**Servicio SOAP Externo**:
- Servicio: `cargadorArchivoLote` (MTR)
- Operación: `cargarLotes`
- Validación: Schema validation habilitada

**Base de Datos**:
- Conexión: `registraBitacoraPagosMasivosRG_db` (solo bitácora)
- Incluye campo adicional: `countryCode` (GT01)

#### Campos Diferenciadores

- Uso de servicio externo MTR
- Bitácora con campo `countryCode`
- Sin validación de saldos en tiempo real
- Sin procesamiento paralelo

---

### PA01 - Panamá

#### Características Específicas

**Arquitectura**:
- Idéntica a GT01
- Procesamiento externo mediante servicio MTR
- Validación de acceso mediante servicio externo

**Flujo de Procesamiento**:
1. Validación de servicio regional (FICBCO0231)
2. Validación XSD del request
3. Bitácora de request (registraBitacoraPagosMasivosRG_db)
4. Validación de acceso de usuario (servicio MTR)
5. Transformación de request a formato MTR
6. Invocación a servicio externo cargadorArchivoLote
7. Transformación de response
8. Bitácora de response
9. Mapeo de errores

**Transformaciones Específicas**:
- `pagosMasivosInternoPAIn.xqy`: Transforma request OSB a formato MTR
- `pagosMasivosInternoPAOut.xqy`: Transforma response MTR a formato OSB
- `pagosMasivosInternoPAHeaderOut.xqy`: Construye header de respuesta

#### Endpoints y Conexiones

**Servicio SOAP Externo**:
- Servicio: `cargadorArchivoLote` (MTR)
- Operación: `cargarLotes`
- Validación: Schema validation habilitada

**Base de Datos**:
- Conexión: `registraBitacoraPagosMasivosRG_db` (solo bitácora)
- Incluye campo adicional: `countryCode` (PA01)

#### Campos Diferenciadores

- Uso de servicio externo MTR
- Bitácora con campo `countryCode`
- Sin validación de saldos en tiempo real
- Sin procesamiento paralelo

---

### NI01 - Nicaragua

#### Características Específicas

**Arquitectura**:
- Similar a GT01 y PA01 pero SIN validación de acceso
- Procesamiento externo mediante servicio MTR
- SIN bitácora de auditoría

**Flujo de Procesamiento**:
1. Validación de servicio regional (FICBCO0231)
2. Validación XSD del request
3. Transformación de request a formato MTR
4. Invocación a servicio externo cargadorArchivoLote
5. Transformación de response
6. Mapeo de errores

**Diferencias Clave**:
- **NO** tiene validación de acceso de usuario
- **NO** tiene bitácora de request/response
- Flujo más simple y directo

**Transformaciones Específicas**:
- `pagosMasivosInternoNIIn.xqy`: Transforma request OSB a formato MTR
- `pagosMasivosInternoNIOut.xqy`: Transforma response MTR a formato OSB
- `pagosMasivosInternoNIHeaderOut.xqy`: Construye header de respuesta

#### Endpoints y Conexiones

**Servicio SOAP Externo**:
- Servicio: `cargadorArchivoLote` (MTR)
- Operación: `cargarLotes`
- Validación: Schema validation habilitada

**Base de Datos**:
- Ninguna (no hay bitácora)

#### Campos Diferenciadores

- Sin validación de acceso
- Sin bitácora de auditoría
- Flujo simplificado
- Uso de servicio externo MTR

---

## Diferencias Clave entre Regiones

### Procesamiento

| Característica | HN01 | GT01 | PA01 | NI01 |
|----------------|------|------|------|------|
| Tipo | Interno (BPEL) | Externo (MTR) | Externo (MTR) | Externo (MTR) |
| Validación Saldos | Sí | No | No | No |
| Validación Estado | Sí | No | No | No |
| Procesamiento Paralelo | Sí | No | No | No |
| Agrupación por Cuenta | Sí | No | No | No |

### Seguridad y Auditoría

| Característica | HN01 | GT01 | PA01 | NI01 |
|----------------|------|------|------|------|
| Validación Acceso | BD Local | Servicio MTR | Servicio MTR | No |
| Bitácora Request | Sí | Sí | Sí | No |
| Bitácora Response | Sí | Sí | Sí | No |
| Campo countryCode | No | Sí | Sí | N/A |

### Dependencias

| Característica | HN01 | GT01 | PA01 | NI01 |
|----------------|------|------|------|------|
| Base de Datos Local | Sí | No | No | No |
| Servicio MTR | No | Sí | Sí | Sí |
| Consulta Saldos | Sí | No | No | No |
| Consulta T24 | Sí | No | No | No |

## Recomendaciones

1. **Estandarización**: Considerar unificar el procesamiento en todas las regiones
2. **Bitácora**: Implementar bitácora en NI01 para auditoría
3. **Validación de Acceso**: Implementar en NI01 para seguridad
4. **Validación de Saldos**: Evaluar implementar en GT01, PA01, NI01
5. **Monitoreo**: Implementar métricas específicas por región
6. **Documentación**: Documentar SPs y servicios externos
7. **Timeouts**: Configurar timeouts específicos por región
8. **Error Handling**: Estandarizar manejo de errores entre regiones
