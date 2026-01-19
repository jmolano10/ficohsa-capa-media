# Comparativa entre Regiones - cargaLoteProductos

## Regiones Detectadas

A partir del análisis del código fuente, se identificaron las siguientes regiones:

1. **HN01** - Honduras (IMPLEMENTADA)
2. **GT01** - Guatemala (NO IMPLEMENTADA)
3. **PA01** - Panamá (NO IMPLEMENTADA)
4. **NI01** - Nicaragua (NO IMPLEMENTADA)

**Nota:** La detección de regiones se realizó mediante el análisis del branch-node "Regionalizacion" en el archivo proxy, que evalúa el campo `SourceBank` del header.

---

## Tabla de Comparación entre Regiones

| Aspecto | HN01 (Honduras) | GT01 (Guatemala) | PA01 (Panamá) | NI01 (Nicaragua) |
|---------|-----------------|------------------|---------------|------------------|
| **Estado de Implementación** | ✅ IMPLEMENTADA | ❌ NO IMPLEMENTADA | ❌ NO IMPLEMENTADA | ❌ NO IMPLEMENTADA |
| **Endpoint OSB** | `/MWHostToHost/v1/ProxyServices/CargaLoteProductos` | `/MWHostToHost/v1/ProxyServices/CargaLoteProductos` | `/MWHostToHost/v1/ProxyServices/CargaLoteProductos` | `/MWHostToHost/v1/ProxyServices/CargaLoteProductos` |
| **Pipeline Request** | `ConsultaDetalleLoteHN_request` | `Default_request` (vacío) | `Default_request` (vacío) | `Default_request` (vacío) |
| **Pipeline Response** | `ConsultaDetalleLoteHN_response` | `Default_response` (error) | `Default_response` (error) | `Default_response` (error) |
| **Base de Datos** | Oracle DB | No aplica | No aplica | No aplica |
| **Esquema BD** | PAGOSWS | No aplica | No aplica | No aplica |
| **Package BD** | HTH_K_APERTURA_MASIVA | No aplica | No aplica | No aplica |
| **Stored Procedure** | HTH_P_CARGA_LOTE_PRODUCTOS | No aplica | No aplica | No aplica |
| **Conexión BD** | eis/DB/ConnectionWebServices | No aplica | No aplica | No aplica |
| **Servicio T24** | sjConsultaClienteResiliencia | No aplica | No aplica | No aplica |
| **Operación T24** | Consultadecliente | No aplica | No aplica | No aplica |
| **XQuery Transformación IN** | cargaLoteProductosIN.xq | No aplica | No aplica | No aplica |
| **XQuery Transformación OUT** | cargaLoteProductosOUT.xq | No aplica | No aplica | No aplica |
| **XQuery Consulta Cliente** | ConsultaClienteIN.xq | No aplica | No aplica | No aplica |
| **Validación Regional** | FICBCO0380 | FICBCO0380 | FICBCO0380 | FICBCO0380 |
| **Validación Acceso H2H** | FICBCO0379 | FICBCO0379 | FICBCO0379 | FICBCO0379 |
| **Código Error Default** | MW-0008 | MW-0008 | MW-0008 | MW-0008 |
| **Mensaje Error Default** | SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY | SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY | SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY | SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY |
| **Timeout Configurado** | No especificado | No especificado | No especificado | No especificado |
| **Retry Count** | 0 | 0 | 0 | 0 |
| **Monedas Soportadas** | HNL, USD | No aplica | No aplica | No aplica |

---

## Sección Detallada por Región

### 1. HN01 - Honduras (IMPLEMENTADA)

#### 1.1 Endpoints y Servicios

**Proxy Service:**
- Ruta: `MWHostToHost/v1/ProxyServices/CargaLoteProductos.proxy`
- WSDL: `MWHostToHost/v1/Resources/CargaLoteProductos/wsdl/cargaLoteProductosPS.wsdl`
- Namespace: `http://www.ficohsa.com.hn/middleware.services/cargaLoteProductosPS/`
- Port: `cargaLoteProductosPSSOAP`
- Binding: SOAP 1.1 Document/Literal

**Business Services:**

1. **Validación Servicio Regional**
   - Servicio: `MWHostToHost/v1/BusinessServices/MDW/validaServicioRegional/biz/validaServicioRegional_db`
   - Tipo: DB Adapter
   - Operación: `ValidaServicioRegional`
   - Service ID: `FICBCO0380`

2. **Validación Acceso H2H**
   - Servicio: `MWHostToHost/v1/BusinessServices/INTFC/validaAccesoH2H/biz/validaAccesoH2H_db`
   - Tipo: DB Adapter
   - Operación: `validaAccesoH2H`
   - Service ID: `FICBCO0379`

3. **Consulta Cliente T24**
   - Servicio: `Middleware/v3/BusinessServices/ConsultasCliente/biz/sjConsultaClienteResiliencia`
   - Tipo: SOAP Web Service
   - Operación: `Consultadecliente`
   - Sistema: T24 Core Banking

4. **Carga Lote Productos**
   - Servicio: `MWHostToHost/v1/BusinessServices/PWS/cargaLoteProductos/biz/cargaLoteProductos_db`
   - Tipo: DB Adapter
   - Operación: `cargaLoteProductos`
   - Conexión: `eis/DB/ConnectionWebServices`

5. **Mapeo de Errores**
   - Servicio: `MWHostToHost/v1/BusinessServices/OSB/mapeoErrores/biz/mapeoErrores`
   - Operación: `mapeoErrores`

#### 1.2 Base de Datos

**Conexión:**
- JNDI: `eis/DB/ConnectionWebServices`
- Tipo: Oracle Database Adapter

**Stored Procedure Principal:**
- Package: `HTH_K_APERTURA_MASIVA`
- Procedure: `HTH_P_CARGA_LOTE_PRODUCTOS`
- Esquema: `PAGOSWS` (inferido de los tipos de datos)

**Parámetros de Entrada (37 parámetros):**
1. PV_CODIGOCLIENTE (VARCHAR2)
2. PV_CODIGOGRUPOPLANILLA (NUMBER)
3. PV_USUARIO (VARCHAR2)
4. PN_NUMEROCLIENTES (NUMBER)
5. PV_NOMBREEMPRESA (VARCHAR2)
6. PV_DIRECCIONEMPRESA (VARCHAR2)
7. PV_CALLEEMPRESA (VARCHAR2)
8. PV_BLOQUEEMPRESA (VARCHAR2)
9. PV_CASAEMPRESA (VARCHAR2)
10. PV_TELEFONO_EMPRESA (VARCHAR2)
11. PV_REFERENCIAEMPRESA (VARCHAR2)
12. PT_TIPOIDENTIFICACION (Array TVARCHAR20)
13. PT_NUMEROIDENTIFICACION (Array TVARCHAR13)
14. PT_FECHAEMISION (Array TDATE)
15. PT_NOMBRECLIENTE (Array TVARCHAR40)
16. PT_APELLIDOSCLIENTE (Array TVARCHAR40)
17. PT_FECHANACIMIENTO (Array TDATE)
18. PT_GENERO (Array TNUMBER)
19. PT_ESTADOCIVIL (Array TVARCHAR20)
20. PT_DIRECCIONHOGAR (Array TVARCHAR60)
21. PT_CELULAR (Array TVARCHAR11)
22. PT_TELEFONO (Array TVARCHAR11)
23. PT_REFERENCIATELEFONO (Array TVARCHAR20)
24. PT_NIVELEDUCATIVO (Array TVARCHAR20)
25. PT_PROFESION (Array TNUMBER)
26. PT_FECHAINGRESOEMPRESA (Array TDATE)
27. PT_CARGO (Array TNUMBER)
28. PT_MONEDAINGRESO (Array TVARCHAR3)
29. PT_MONTOINGRESO (Array TVARCHAR20)
30. PT_NOMBRECONYUGUE (Array TVARCHAR40)
31. PT_APELLIDOSCONYUGUE (Array TVARCHAR40)
32. PT_NOMBREREFERENCIA (Array TVARCHAR40)
33. PT_APELLIDOSREFERENCIA (Array TVARCHAR40)
34. PT_TELEFONOREFERENCIA (Array TVARCHAR11)
35. PT_PARENTESCOREFERENCIA (Array TNUMBER)
36. PT_NOMBREBENEFICIARIO (Array TVARCHAR50)
37. PT_PARENTESCOBENEFICIARIO (Array TNUMBER)

**Parámetros de Salida (4 parámetros):**
1. PV_CODIGOCLIENTE (VARCHAR2)
2. PV_CODIGOLOTE (VARCHAR2)
3. PV_CODIGOERROR (VARCHAR2)
4. PV_DESCRIPCIONMENSAJE (VARCHAR2)

#### 1.3 Transformaciones XQuery

**1. ConsultaClienteIN.xq**
- Propósito: Mapear request OSB a formato T24
- Entrada: cargaLoteProductosRequest + RequestHeader
- Salida: Consultadecliente (T24)
- Funciones especiales:
  - `getUsername()`: Obtiene credenciales LDAP
  - `getPassword()`: Obtiene password LDAP
  - Lookup: `Middleware/Security/{USERNAME}`

**2. cargaLoteProductosIN.xq**
- Propósito: Mapear request OSB + datos T24 a stored procedure
- Entrada: cargaLoteProductosRequest + datos cliente T24
- Salida: InputParameters (SP)
- Mapeos especiales:
  - Datos empresa desde T24: NAMEOFBUSINESS, COLONYCODE, ADDSTREET, BLOCK, HOUSENUMBER, PHONE, REFERENCES
  - Arrays de clientes: itera sobre CUSTOMERS/CUSTOMER
  - Usuario desde header: Authentication/UserName

**3. cargaLoteProductosOUT.xq**
- Propósito: Mapear respuesta del stored procedure a response OSB
- Entrada: codLote (string)
- Salida: cargaLoteProductosResponse
- Mapeo simple: codLote → BANK_BATCH_ID

#### 1.4 Validaciones Específicas

**Validaciones de Negocio:**
1. CUSTOMER_ID no puede estar vacío
2. PAYROLL_GROUP_ID es obligatorio
3. Usuario debe tener acceso H2H
4. Cliente debe tener acceso H2H
5. Servicio debe estar habilitado regionalmente
6. Cliente debe existir en T24 con Status = "Success"

**Validaciones de Esquema:**
- LEGAL_ID: 13 dígitos numéricos
- GENDER: 1 o 2
- MARITAL_STATUS: S, L, M, D, W
- EDUCATION_LEVEL: A, P, S, H, G
- INCOME_CURRENCY: HNL o USD
- Campos numéricos: PROFESSION, JOB_TITTLE, REFERENCE_RELATIONSHIP, BENEFICIARY_RELATIONSHIP

#### 1.5 Manejo de Errores

**Errores Controlados:**
1. **NO CUSTOMER ID**: El id de cliente no puede ir vacío
2. **NO PAYROLL GROUP**: El código de grupo planilla es necesario
3. **ERROR**: El usuario y/o cliente no tiene acceso a operaciones host to host
4. **NO RECORDS**: No se encontró la información del cliente
5. **Errores del SP**: Mapeados mediante servicio mapeoErrores

**Error Handler:**
- Scope: Router level
- Pipeline: `_onErrorHandler-8352090216388798588--3d37eb35.16ecc769ffa.-7db4`
- Acción: Mapeo de errores + construcción de response vacío

#### 1.6 Políticas OSB

**Seguridad:**
- WS-Policy: `wsdl-policy-attachments`
- Autenticación: Mediante header (UserName/Password)
- Lookup de credenciales LDAP para T24

**Transacciones:**
- Required: false
- Same TX for Response: false

**Logging:**
- Enabled: true
- Level: debug

**Monitoring:**
- Enabled: false
- Aggregation Interval: 10 segundos

**Alerting:**
- SLA Alerting: enabled (normal)
- Pipeline Alerting: enabled (normal)

#### 1.7 Campos Diferenciadores

**Datos de Empresa (desde T24):**
- NAMEOFBUSINESS
- COLONYCODE (dirección)
- ADDSTREET (calle)
- BLOCK (bloque)
- HOUSENUMBER (número de casa)
- PHONE (teléfono)
- REFERENCES (referencias)

**Datos de Empleados (desde request):**
- Información personal: nombres, apellidos, fecha nacimiento, género, estado civil
- Información de contacto: dirección, celular, teléfono
- Información laboral: profesión, cargo, fecha ingreso, ingresos
- Información familiar: cónyuge, referencias, beneficiarios

**Monedas:**
- HNL (Lempira hondureño)
- USD (Dólar estadounidense)

---

### 2. GT01 - Guatemala (NO IMPLEMENTADA)

**Estado:** No implementada

**Comportamiento:**
- Al invocar con SourceBank = "GT01", el servicio ejecuta el pipeline `Default_response`
- Retorna error MW-0008: "SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY"
- No se ejecuta ninguna lógica de negocio

**Archivos Relacionados:**
- No se encontraron archivos específicos para Guatemala en la funcionalidad cargaLoteProductos

**Recomendaciones para Implementación:**
1. Crear pipeline `ConsultaDetalleLoteGT_request`
2. Crear pipeline `ConsultaDetalleLoteGT_response`
3. Configurar conexión a base de datos Guatemala
4. Adaptar stored procedure o crear uno específico
5. Configurar servicio T24 para Guatemala
6. Crear XQuery de transformación específicos si hay diferencias

---

### 3. PA01 - Panamá (NO IMPLEMENTADA)

**Estado:** No implementada

**Comportamiento:**
- Al invocar con SourceBank = "PA01", el servicio ejecuta el pipeline `Default_response`
- Retorna error MW-0008: "SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY"
- No se ejecuta ninguna lógica de negocio

**Archivos Relacionados:**
- No se encontraron archivos específicos para Panamá en la funcionalidad cargaLoteProductos

**Recomendaciones para Implementación:**
1. Crear pipeline `ConsultaDetalleLotePA_request`
2. Crear pipeline `ConsultaDetalleLotePA_response`
3. Configurar conexión a base de datos Panamá
4. Adaptar stored procedure o crear uno específico
5. Configurar servicio T24 para Panamá
6. Crear XQuery de transformación específicos si hay diferencias

---

### 4. NI01 - Nicaragua (NO IMPLEMENTADA)

**Estado:** No implementada

**Comportamiento:**
- Al invocar con SourceBank = "NI01", el servicio ejecuta el pipeline `Default_response`
- Retorna error MW-0008: "SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY"
- No se ejecuta ninguna lógica de negocio

**Archivos Relacionados:**
- No se encontraron archivos específicos para Nicaragua en la funcionalidad cargaLoteProductos

**Recomendaciones para Implementación:**
1. Crear pipeline `ConsultaDetalleLoteNI_request`
2. Crear pipeline `ConsultaDetalleLoteNI_response`
3. Configurar conexión a base de datos Nicaragua
4. Adaptar stored procedure o crear uno específico
5. Configurar servicio T24 para Nicaragua
6. Crear XQuery de transformación específicos si hay diferencias

---

## Diferencias Clave entre Regiones

### Diferencias Técnicas

| Aspecto | HN01 | Otras Regiones |
|---------|------|----------------|
| Implementación | Completa | Ninguna |
| Pipelines | 2 específicos | 1 default (error) |
| Base de Datos | Configurada | No configurada |
| Stored Procedures | Implementado | No implementado |
| Transformaciones XQuery | 3 archivos | Ninguno |
| Integración T24 | Configurada | No configurada |
| Validaciones | Completas | Solo validación regional |

### Diferencias de Negocio

**HN01:**
- Soporta apertura masiva de cuentas
- Integrado con T24 Honduras
- Validaciones de acceso H2H
- Procesamiento de lotes de empleados
- Monedas: HNL y USD

**Otras Regiones:**
- No soportan la funcionalidad
- Sin integración con sistemas locales
- Sin validaciones específicas
- Sin procesamiento de lotes

---

## Conclusiones

1. **Única Región Operativa:** Solo HN01 (Honduras) tiene implementación completa
2. **Arquitectura Preparada:** El proxy tiene la estructura de regionalización lista para expansión
3. **Patrón Consistente:** Se utiliza el patrón branch-node por SourceBank
4. **Esfuerzo de Expansión:** Para implementar otras regiones se requiere:
   - Configuración de base de datos regional
   - Desarrollo de stored procedures
   - Configuración de servicios T24 regionales
   - Creación de pipelines específicos
   - Adaptación de transformaciones XQuery si hay diferencias de negocio
5. **Sin Diferencias Detectadas en Contrato:** El WSDL es común para todas las regiones
6. **Diferencias Esperadas:** Probablemente existan diferencias en:
   - Validaciones de documentos de identidad
   - Catálogos de profesiones y cargos
   - Monedas locales
   - Regulaciones bancarias locales
