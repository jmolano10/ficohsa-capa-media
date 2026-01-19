# Resumen Ejecutivo - cargaLoteProductos

## Índice de Documentación

1. [Resumen Ejecutivo](01-ResumenEjecutivo.md)
2. [Comparativa entre Regiones](02-ComparativaRegiones.md)
3. [Ejemplos y Mapeos - HN01](03-EjemplosYMapeos-HN01.md)
4. [Diagrama de Secuencia - HN01](04-Secuencia-HN01.mmd)
5. [Diagrama de Flujo Multiregión](05-FlujoMultiregión.mmd)
6. [Listado de Ficheros](06-ListadoFicheros.md)

---

## 1. Propósito de la Funcionalidad

La funcionalidad **cargaLoteProductos** es un servicio OSB (Oracle Service Bus) diseñado para realizar la apertura masiva de productos bancarios (cuentas) para múltiples clientes asociados a un grupo de planilla (payroll). Este servicio permite a empresas corporativas realizar la carga de lotes de empleados para la apertura de cuentas de manera automatizada.

### Objetivos Principales:
- Validar el acceso del usuario y cliente al sistema Host-to-Host (H2H)
- Validar que el servicio esté habilitado para la región específica
- Consultar información del cliente corporativo en el core bancario (T24)
- Registrar un lote de clientes (empleados) con su información personal, laboral y financiera
- Ejecutar un stored procedure en base de datos Oracle para procesar la apertura masiva
- Retornar un código de lote (BANK_BATCH_ID) para seguimiento posterior

---

## 2. Entradas y Salidas Principales

### 2.1 Entrada Principal (Request)

**Endpoint OSB:** `cargaLoteProductosPS`

**Estructura del Request:**

```xml
<cargaLoteProductosRequest>
    <CUSTOMER_ID>string</CUSTOMER_ID>
    <PAYROLL_GROUP_ID>string</PAYROLL_GROUP_ID>
    <CUSTOMERS>
        <CUSTOMER> (múltiples)
            <CUSTOMER_ID_TYPE>string(20)</CUSTOMER_ID_TYPE>
            <LEGAL_ID>string(13)</LEGAL_ID>
            <LEGAL_ID_EMISSION_DATE>date</LEGAL_ID_EMISSION_DATE>
            <GIVEN_NAMES>string(40)</GIVEN_NAMES>
            <FAMILY_NAME>string(40)</FAMILY_NAME>
            <DATE_OF_BIRTH>date</DATE_OF_BIRTH>
            <GENDER>1|2</GENDER>
            <MARITAL_STATUS>S|L|M|D|W</MARITAL_STATUS>
            <HOME_ADDRESS>string(60)</HOME_ADDRESS>
            <CELLULAR>string(11)</CELLULAR>
            <PHONE_NUMBER>string(11)</PHONE_NUMBER>
            <PHONE_REFERENCE>string(20)</PHONE_REFERENCE>
            <EDUCATION_LEVEL>A|P|S|H|G</EDUCATION_LEVEL>
            <PROFESSION>number(3)</PROFESSION>
            <START_DAY_JOB>date</START_DAY_JOB>
            <JOB_TITTLE>number(3)</JOB_TITTLE>
            <INCOME_CURRENCY>HNL|USD</INCOME_CURRENCY>
            <INCOME_AMOUNT>string(10)</INCOME_AMOUNT>
            <MARRIED_NAME>string(40)</MARRIED_NAME>
            <MARRIED_LASTNAME>string(40)</MARRIED_LASTNAME>
            <REFERENCE_NAME>string(40)</REFERENCE_NAME>
            <REFERENCE_LASTNAME>string(40)</REFERENCE_LASTNAME>
            <REFERENCE_PHONE>string(11)</REFERENCE_PHONE>
            <REFERENCE_RELATIONSHIP>number(3)</REFERENCE_RELATIONSHIP>
            <BENEFICIARY_NAME>string(50)</BENEFICIARY_NAME>
            <BENEFICIARY_RELATIONSHIP>number(3)</BENEFICIARY_RELATIONSHIP>
        </CUSTOMER>
    </CUSTOMERS>
    <KV_PAIRS> (opcional)
        <PAIR>
            <KEY>string</KEY>
            <VALUE>string</VALUE>
        </PAIR>
    </KV_PAIRS>
</cargaLoteProductosRequest>
```

**Header del Request:**
```xml
<RequestHeader>
    <Authentication>
        <UserName>string</UserName>
        <Password>string</Password>
    </Authentication>
    <Region>
        <SourceBank>HN01</SourceBank>
        <DestinationBank>string</DestinationBank>
    </Region>
</RequestHeader>
```

### 2.2 Salida Principal (Response)

**Estructura del Response Exitoso:**

```xml
<cargaLoteProductosResponse>
    <BANK_BATCH_ID>string</BANK_BATCH_ID>
</cargaLoteProductosResponse>
```

**Header del Response:**
```xml
<ResponseHeader>
    <successIndicator>SUCCESS</successIndicator>
    <messages>string</messages>
</ResponseHeader>
```

**Estructura del Response con Error:**

```xml
<cargaLoteProductosResponse/>
```

**Header del Response con Error:**
```xml
<ResponseHeader>
    <successIndicator>ERROR</successIndicator>
    <messages>Descripción del error</messages>
</ResponseHeader>
```

---

## 3. Sistemas/Servicios OSB Involucrados

### 3.1 Proxy Service Principal
- **CargaLoteProductos.proxy** - Servicio principal que expone la funcionalidad

### 3.2 Business Services Dependientes

#### 3.2.1 Validación de Servicio Regional
- **Servicio:** `MWHostToHost/v1/BusinessServices/MDW/validaServicioRegional/biz/validaServicioRegional_db`
- **Operación:** `ValidaServicioRegional`
- **Tipo:** DB Adapter (Stored Procedure)
- **Propósito:** Validar que el servicio FICBCO0380 esté habilitado para la región

#### 3.2.2 Validación de Acceso H2H
- **Servicio:** `MWHostToHost/v1/BusinessServices/INTFC/validaAccesoH2H/biz/validaAccesoH2H_db`
- **Operación:** `validaAccesoH2H`
- **Tipo:** DB Adapter (Stored Procedure)
- **Propósito:** Validar que el usuario y cliente tengan acceso a operaciones Host-to-Host

#### 3.2.3 Consulta de Cliente (T24)
- **Servicio:** `Middleware/v3/BusinessServices/ConsultasCliente/biz/sjConsultaClienteResiliencia`
- **Operación:** `Consultadecliente`
- **Tipo:** SOAP Web Service (T24)
- **Propósito:** Consultar información del cliente corporativo en el core bancario

#### 3.2.4 Carga de Lote en Base de Datos
- **Servicio:** `MWHostToHost/v1/BusinessServices/PWS/cargaLoteProductos/biz/cargaLoteProductos_db`
- **Operación:** `cargaLoteProductos`
- **Tipo:** DB Adapter (Stored Procedure)
- **Conexión:** `eis/DB/ConnectionWebServices`
- **Package:** `HTH_K_APERTURA_MASIVA`
- **Stored Procedure:** `HTH_P_CARGA_LOTE_PRODUCTOS`

#### 3.2.5 Mapeo de Errores
- **Servicio:** `MWHostToHost/v1/BusinessServices/OSB/mapeoErrores/biz/mapeoErrores`
- **Operación:** `mapeoErrores`
- **Propósito:** Mapear códigos de error técnicos a mensajes de negocio

---

## 4. Riesgos/Limitaciones Conocidas

### 4.1 Limitaciones de Región
- **Región Soportada:** Únicamente HN01 (Honduras)
- **Otras Regiones:** GT01, PA01, NI01 no están implementadas
- **Comportamiento:** Si se invoca con una región diferente a HN01, el servicio retorna error "SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY" (código MW-0008)

### 4.2 Validaciones Obligatorias
- **CUSTOMER_ID:** No puede estar vacío (error: "NO CUSTOMER ID")
- **PAYROLL_GROUP_ID:** Es obligatorio (error: "NO PAYROLL GROUP")
- **Acceso H2H:** El usuario y cliente deben estar registrados en el sistema H2H
- **Servicio Regional:** El servicio FICBCO0380 debe estar habilitado para la región

### 4.3 Dependencias Críticas
- **T24 Core Banking:** Disponibilidad del servicio de consulta de clientes
- **Base de Datos Oracle:** Disponibilidad de la conexión `ConnectionWebServices`
- **Stored Procedure:** Correcta ejecución de `HTH_P_CARGA_LOTE_PRODUCTOS`

### 4.4 Riesgos Identificados
- **Timeout:** No se observan configuraciones explícitas de timeout en el proxy
- **Retry:** Configurado en 0 intentos para el DB Adapter
- **Transaccionalidad:** No se requiere transacción (`isRequired="false"`)
- **Volumen:** El servicio procesa arrays de clientes, sin límite explícito documentado
- **Resiliencia:** Dependencia del servicio T24 con resiliencia implementada

---

## 5. Métricas o SLAs

### 5.1 Configuración de Monitoreo
- **Monitoring:** Deshabilitado (`isEnabled="false"`)
- **Aggregation Interval:** 10 segundos
- **Pipeline Monitoring Level:** Pipeline
- **Reporting:** Habilitado (`true`)
- **Logging Level:** Debug
- **SLA Alerting:** Habilitado (nivel normal)
- **Pipeline Alerting:** Habilitado (nivel normal)

### 5.2 Configuración de Retry
- **Retry Count:** 0 (sin reintentos automáticos)
- **Retry Interval:** 30 segundos
- **Retry Application Errors:** true

### 5.3 Identificadores de Servicio
- **Service ID Principal:** FICBCO0380 (cargaLoteProductos)
- **Service ID Validación:** FICBCO0379 (validaAccesoH2H)

### 5.4 Métricas Esperadas
No se encontraron SLAs específicos documentados en el código fuente. Se recomienda establecer:
- Tiempo de respuesta objetivo
- Tasa de éxito esperada
- Volumen máximo de clientes por lote
- Disponibilidad del servicio

---

## 6. Flujo General de Ejecución

1. **Recepción del Request** → Validación de esquema XML
2. **Validación de Campos Obligatorios** → CUSTOMER_ID y PAYROLL_GROUP_ID
3. **Validación de Servicio Regional** → Verificar que FICBCO0380 esté habilitado para la región
4. **Validación de Acceso H2H** → Verificar permisos del usuario y cliente
5. **Enrutamiento Regional** → Branch por SourceBank (solo HN01 implementado)
6. **Consulta de Cliente en T24** → Obtener datos del cliente corporativo
7. **Transformación de Request** → Mapeo a formato del stored procedure
8. **Ejecución del Stored Procedure** → Procesar carga de lote en BD
9. **Transformación de Response** → Mapeo de resultado
10. **Manejo de Errores** → Mapeo de errores técnicos a mensajes de negocio
11. **Retorno de Response** → BANK_BATCH_ID o mensaje de error

---

## 7. Observaciones Técnicas

- El servicio utiliza **SOAP 1.1** (no SOAP 1.2)
- El binding es de tipo **document/literal**
- El transporte es **HTTP**
- La validación de esquema está habilitada
- El servicio no requiere transacciones distribuidas
- El error handler está implementado a nivel de router
- Se utiliza XQuery para todas las transformaciones
- El servicio implementa el patrón de regionalización mediante branch-node
