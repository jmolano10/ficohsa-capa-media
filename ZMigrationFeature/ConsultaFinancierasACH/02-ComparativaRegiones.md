# Comparación entre Regiones - ConsultaFinancierasACH

## Tabla de Comparación Regional

| Aspecto | HN01 (Honduras Core) | HN02 (Honduras FPC) | GT01 (Guatemala) | PA01 (Panamá) | NI01 (Nicaragua) |
|---------|---------------------|---------------------|------------------|---------------|------------------|
| **Endpoint OSB** | T24 Core Banking | FPC Service | Oracle DB Adapter | Oracle DB Adapter | CTS COBIS Service |
| **Nombre de Base de Datos** | T24 Core | FPC Database | AbanksGT | AbanksPA | COBIS CTS |
| **Esquemas** | T24WebServicesImpl | FPC Schema | OSB_K_CONFINANCIERAS | OSB_K_CONFINANCIERAS | COBIS Schema |
| **Store Procedure** | ConsultadedestinosACH | consultaFinancierasACH | TOPLEVEL$OSB_P_CON_FINANCIERA | TOPLEVEL$OSB_P_CON_FINANCIERA | OpConsultaFinacierasACH |
| **Nombre de Conexión** | CoreBS | getFinancialACH12c | ConnectionProxyAbanksGT | ConnectionProxyAbanksPA | CTS transferencia |
| **Transformaciones clave** | consultaFinancierasACHIn.xq | getFinancialACHHeaderIn.xq | consultaFinancierasACHGTIn.xq | consultaFinancierasACHPAIn.xq | consultaFinanacierasACHNIIn.xq |
| **Campos diferenciadores** | WebRequestCommon | serviceAccountName='OSB12AUTH' | InputParameters estándar | InputParameters estándar | contextoTransaccional |
| **Errores/Excepciones** | T24 Error Codes | FPC Error Handling | ERROR_CODE/ERROR_MESSAGE | ERROR_CODE/ERROR_MESSAGE | COBIS Error Structure |
| **Timeouts/Retrys** | Default OSB | Default OSB | Default OSB | Default OSB | timeout=0, retry=0 |
| **Dependencias internas** | LDAP Credentials | Header transformation | DB Connection Pool | DB Connection Pool | External CTS Service |
| **Campo TRANSFER_TYPE** | No | No | Sí | No | No |
| **Lógica de agrupación** | Estándar | Estándar | Cada 4 registros | Agrupación por código | Por banco |
| **Parametrización externa** | No | No | No | No | Sí (FICBCO0118.NI.PRODUCTS_TYPES) |

## Detalles por Región

### HN01 (Honduras - Core Banking)

**Características específicas:**
- Utiliza T24 Core Banking como backend
- Implementa lookup de credenciales LDAP con failover
- Maneja autenticación mediante WebRequestCommon
- Utiliza enquiryInputCollection para filtros
- Transformación de salida estándar sin agrupaciones especiales

**Endpoint de conexión:**
- Business Service: `Middleware/Business_Resources/Core/Resources/CoreBS`
- Operación: `ConsultadedestinosACH`

**Validaciones específicas:**
- Lookup de credenciales LDAP con función getUsername/getPassword
- Failover a credenciales del header si LDAP falla

### HN02 (Honduras - FPC)

**Características específicas:**
- Utiliza servicio FPC (Fondo de Pensiones y Cesantías)
- Mapeo especial de regiones HN02 → HN01
- Service account fijo: 'OSB12AUTH'
- Header transformation específica para FPC

**Endpoint de conexión:**
- Business Service: `Middleware/v2/BusinessServices/FPC/getFinancialACH12c/biz/getFinancialACH12c`
- Operación: `consultaFinancierasACH`

**Validaciones específicas:**
- Transformación de región HN02 a HN01 en headers
- Manejo de DestinationBank con lógica condicional

### GT01 (Guatemala)

**Características específicas:**
- Conexión directa a base de datos Oracle
- Incluye campo TRANSFER_TYPE único en la respuesta
- Lógica de agrupación cada 4 registros
- Stored procedure específico para Guatemala

**Endpoint de conexión:**
- JCA Adapter: `jca://eis/DB/ConnectionProxyAbanksGT`
- Package: `OSB_K_CONFINANCIERAS`
- Procedure: `TOPLEVEL$OSB_P_CON_FINANCIERA`

**Campos únicos:**
- TRANSFER_TYPE: Tipo de transferencia (no presente en otras regiones)

**Lógica de procesamiento:**
```xquery
for $i in (1 to count($destinationCodes))
where (($i mod 4) = 0)
```

### PA01 (Panamá)

**Características específicas:**
- Conexión directa a base de datos Oracle
- Lógica de agrupación por cambio de código de destino
- No incluye campo TRANSFER_TYPE
- Stored procedure idéntico a GT01 pero con diferente lógica de agrupación

**Endpoint de conexión:**
- JCA Adapter: `jca://eis/DB/ConnectionProxyAbanksPA`
- Package: `OSB_K_CONFINANCIERAS`
- Procedure: `TOPLEVEL$OSB_P_CON_FINANCIERA`

**Lógica de procesamiento:**
```xquery
for $i in (1 to count($destinationCodes))
where (data($destinationCodes[$i]) != data($destinationCodes[$i+1])) or ($i = count($destinationCodes))
```

### NI01 (Nicaragua)

**Características específicas:**
- Utiliza servicio externo CTS de COBIS
- Requiere parametrización externa para tipos de producto
- Contexto transaccional específico de COBIS
- Agrupación por banco en la respuesta

**Endpoint de conexión:**
- HTTP Service: `http://10.235.53.149:9080/GerenciaTransferencia/SrvAplCobisTransferenciaService`
- Operación: `OpConsultaFinacierasACH`

**Parametrización externa:**
- Parámetro: `FICBCO0118.NI.PRODUCTS_TYPES`
- Servicio: `ObtenerParametrizacion`

**Estructura de request específica:**
```xml
<contextoTransaccional>
    <codCanalOriginador>1</codCanalOriginador>
</contextoTransaccional>
```

## Diferencias Clave de Implementación

### Manejo de Autenticación
- **HN01**: LDAP lookup con failover
- **HN02**: Service account fijo
- **GT01/PA01**: Conexión de base de datos
- **NI01**: Sin autenticación específica

### Estructura de Respuesta
- **HN01/HN02**: Respuesta estándar
- **GT01**: Incluye TRANSFER_TYPE, agrupación cada 4
- **PA01**: Sin TRANSFER_TYPE, agrupación por código
- **NI01**: Agrupación por banco, tipos de producto parametrizados

### Manejo de Errores
- **HN01/HN02**: Códigos de error de aplicación
- **GT01/PA01**: ERROR_CODE/ERROR_MESSAGE de stored procedure
- **NI01**: Estructura de error de COBIS

### Dependencias Externas
- **HN01**: T24 Core Banking + LDAP
- **HN02**: FPC Service
- **GT01/PA01**: Oracle Database
- **NI01**: CTS COBIS + Parametrización OSB