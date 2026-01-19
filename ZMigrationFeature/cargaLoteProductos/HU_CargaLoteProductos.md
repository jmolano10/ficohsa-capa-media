# Historia de Usuario: CargaLoteProductos

> **Como** Equipo de Integración  
> **Quiero** implementar un servicio que permita cargar lotes de productos masivos para clientes empresariales  
> **Para** facilitar la apertura masiva de cuentas y productos bancarios de manera eficiente

## Criterios de Aceptación

### 1. Campos de Entrada del Servicio

| Campo | Descripción | Requerido | Tipo/Formato |
|-------|-------------|-----------|--------------|
| **cargaLoteProductosRequest** | Solicitud de carga de lote de productos | **Sí** | Complex Type |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **CUSTOMER_ID** | Identificador del cliente empresarial | **Sí** | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **PAYROLL_GROUP_ID** | Identificador del grupo de planilla | **Sí** | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **CUSTOMERS** | Lista de clientes a procesar | **Sí** | customersCargaType |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **CUSTOMER** | Información de cliente individual | **Sí** | customerCargaType (unbounded) |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **CUSTOMER_ID_TYPE** | Tipo de identificación del cliente | **Sí** | StringLength20 |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **LEGAL_ID** | Número de identificación legal | **Sí** | StringLength13 (pattern: [0-9]*) |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **LEGAL_ID_EMISSION_DATE** | Fecha de emisión de identificación | No | date |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **GIVEN_NAMES** | Nombres del cliente | **Sí** | StringLength40 |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **FAMILY_NAME** | Apellidos del cliente | **Sí** | StringLength40 |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **DATE_OF_BIRTH** | Fecha de nacimiento | **Sí** | date |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **GENDER** | Género (1=Masculino, 2=Femenino) | **Sí** | StringLength1 (enum: 1,2) |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **MARITAL_STATUS** | Estado civil | **Sí** | StringLength1 (enum: S,L,M,D,W) |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **HOME_ADDRESS** | Dirección de domicilio | **Sí** | StringLength60 |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **CELLULAR** | Número de celular | No | StringLength11 |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **PHONE_NUMBER** | Número de teléfono | No | StringLength11 |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **PHONE_REFERENCE** | Teléfono de referencia | No | StringLength20 |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **EDUCATION_LEVEL** | Nivel educativo | **Sí** | StringLength1 (enum: A,P,S,H,G) |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **PROFESSION** | Código de profesión | **Sí** | StringLength3 (pattern: [0-9]+) |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **START_DAY_JOB** | Fecha de inicio laboral | **Sí** | date |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **JOB_TITTLE** | Código de cargo laboral | **Sí** | StringLength3 (pattern: [0-9]+) |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **INCOME_CURRENCY** | Moneda de ingresos | **Sí** | StringLength3 (enum: HNL,USD) |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **INCOME_AMOUNT** | Monto de ingresos | **Sí** | StringLength10 |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **MARRIED_NAME** | Nombre de casada | No | StringLength40 |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **MARRIED_LASTNAME** | Apellido de casada | No | StringLength40 |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **REFERENCE_NAME** | Nombre de referencia | **Sí** | StringLength40 |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **REFERENCE_LASTNAME** | Apellido de referencia | **Sí** | StringLength40 |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **REFERENCE_PHONE** | Teléfono de referencia | **Sí** | StringLength11 |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **REFERENCE_RELATIONSHIP** | Relación con referencia | **Sí** | StringLength3 (pattern: [0-9]+) |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **BENEFICIARY_NAME** | Nombre del beneficiario | **Sí** | StringLength50 |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└─ **BENEFICIARY_RELATIONSHIP** | Relación con beneficiario | **Sí** | StringLength3 (pattern: [0-9]+) |
| &nbsp;&nbsp;&nbsp;&nbsp;└─ **KV_PAIRS** | Pares clave-valor adicionales | No | KVPairType |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└─ **PAIR** | Par clave-valor individual | **Sí** | PairType (unbounded) |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **KEY** | Clave del parámetro | **Sí** | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└─ **VALUE** | Valor del parámetro | **Sí** | string |

> **Validaciones:**
> - Se valida que CUSTOMER_ID no esté vacío
> - Se valida que PAYROLL_GROUP_ID no esté vacío
> - Se valida la estructura del mensaje contra el esquema XSD aperturaMasivaTypes.xsd
> - Se aplica validación de servicio regional con serviceId "FICBCO0380"
> - Se valida acceso H2H para el usuario y cliente

### 2. Campos de Salida del Servicio

| Campo | Descripción | Requerido | Tipo |
|-------|-------------|-----------|------|
| **cargaLoteProductosResponse** | Respuesta del servicio de carga de lote | **Sí** | Complex Type |
| &nbsp;&nbsp;&nbsp;&nbsp;└─ **BANK_BATCH_ID** | Identificador del lote generado por el banco | No | string |

> **Nota:** Todos los campos de salida están validados contra el esquema XSD aperturaMasivaTypes.xsd

## Tareas Técnicas

### 1. Códigos de Error

#### 1.1. Códigos de error del Proveedor

| Código Error | Descripción | Tipo Error |
|--------------|-------------|------------|
| MW-0008 | SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY | Técnico |
| NO CUSTOMER ID | El id de cliente no puede ir vacio | Negocio |
| NO PAYROLL GROUP | El código de grupo planilla es necesario | Negocio |
| ERROR | El usuario y/o cliente no tiene acceso a operaciones host to host | Negocio |
| NO RECORDS | No se encontro la información del cliente | Negocio |
| SUCCESS | Operación exitosa | Negocio |

> **Nota:** Se aplica mapeo de errores usando el servicio mapeoErrores con código FICBCO0380

### 2. Configuración de Timeout

- **Timeout proveedor validaServicioRegional:** 30 segundos
- **Timeout proveedor validaAccesoH2H:** 30 segundos
- **Timeout proveedor ConsultaDeCliente:** 60 segundos
- **Timeout proveedor cargaLoteProductos_db:** 120 segundos
- **Timeout operación del OSB:** 180 segundos

### 3. Datos de Prueba

> **Nota:** Los siguientes son datos de ejemplo no reales, utilizados únicamente para propósitos de testing y documentación.

- **CUSTOMER_ID:** "EMPRESA001"
- **PAYROLL_GROUP_ID:** "PLANILLA001"
- **LEGAL_ID:** "0801199012345"
- **GIVEN_NAMES:** "JUAN CARLOS"
- **FAMILY_NAME:** "LOPEZ MARTINEZ"

### 4. Datos de Contacto

**Contacto responsable OSB:**
- **David Ruiz** - david.ruiz@ficohsa.com
- **Wilmer Fernandez** - wilmer.fernandez@ficohsa.com  
- **Francia Avila** - francia.avila@ficohsa.com
- **Diego Gomez** - diego.gomez@ficohsa.com

### 5. Lógica Importante

**Flujo Principal del Servicio:**
1. **Validación XSD:** Se valida la estructura del mensaje contra el esquema aperturaMasivaTypes.xsd
2. **Validación de Campos Obligatorios:** Se verifica que CUSTOMER_ID y PAYROLL_GROUP_ID no estén vacíos
3. **Validación Regional:** Se ejecuta ValidaServicioRegional con serviceId "FICBCO0380" para verificar disponibilidad por región
4. **Validación de Acceso:** Se valida acceso H2H usando validaAccesoH2H con operación "CARGALOTEPRODUCTOS"
5. **Regionalización por País:** El servicio se enruta según el país de origen:
   - **HN01 (Honduras):** Consulta cliente en T24 y ejecuta carga en PWS
   - **Default:** Retorna error MW-0008 (servicio no implementado)
6. **Consulta de Cliente:** Se consulta información del cliente en T24 usando sjConsultaClienteResiliencia
7. **Carga de Lote:** Se ejecuta carga masiva en PWS usando cargaLoteProductos_db
8. **Transformación de Respuesta:** Se construye respuesta con BANK_BATCH_ID generado
9. **Manejo de Errores:** Se aplica mapeo de errores usando mapeoErrores

**Servicios Dependientes Analizados:**
- **validaServicioRegional:** Validación de disponibilidad regional del servicio
- **validaAccesoH2H:** Control de acceso para operaciones Host-to-Host
- **sjConsultaClienteResiliencia:** Consulta de información del cliente en T24
- **cargaLoteProductos_db:** Procesamiento de carga masiva en PWS
- **mapeoErrores:** Mapeo y normalización de códigos de error

**Arquitectura Multi-Core:** Soporte para múltiples sistemas core por región (T24, PWS)

**Seguridad por Usuario:** Control de acceso basado en usuario y cliente para operaciones H2H

### 6. Datos Relevantes

- El servicio requiere validación de acceso H2H específica
- El servicio no requiere reversos automáticos
- Procesamiento masivo de clientes en lotes
- Integración con T24 para consulta de clientes
- Integración con PWS para carga de productos
- Soporte únicamente para Honduras (HN01)
- Validación exhaustiva de datos personales y laborales
- Manejo de referencias personales y beneficiarios

### 7. Detalles Técnicos de Conexión

- **Conexión a validaServicioRegional:** Por JCA - [jca://eis/DB/ConnectionMiddleware]
- **Conexión a validaAccesoH2H:** Por JCA - [jca://eis/DB/ConnectionInterfaz]
- **Conexión a sjConsultaClienteResiliencia:** Por HTTP - Middleware/v3/BusinessServices/ConsultasCliente
- **Conexión a cargaLoteProductos_db:** Por JCA - [jca://eis/DB/ConnectionPWS]
- **Conexión a mapeoErrores:** Por HTTP - [http://172.23.13.19:8003/Middleware/v2/ProxyServices/MapeoErrores]

### 8. Dependencias del Servicio

**Servicios Internos:**
- validaServicioRegional_db - Validación de disponibilidad regional
- validaAccesoH2H_db - Control de acceso H2H
- mapeoErrores - Mapeo de códigos de error

**Servicios Externos:**
- sjConsultaClienteResiliencia - Consulta de clientes en T24
- cargaLoteProductos_db - Carga masiva en PWS

## 9. Datos del Servicio

| Campo | Valor |
|-------|-------|
| **RUTA** | MWHostToHost\v1\ProxyServices\CargaLoteProductos |
| **URI** | local |
| **NUMERO_OPERACIONES** | - |
| **OPERACIONES** | - |
| **CODIGO** | FICBCO0380$0379 |
| **GRUPO_ASIGNADO** | - |

## 10. Información del Inventario de Servicios

Servicios relacionados con CargaLoteProductos encontrados en el inventario:

| URI | NUMERO_OPERACIONES | OPERACIONES | CODIGO | GRUPO_ASIGNADO | RUTA |
|-----|-------------------|-------------|--------|-----------------|------|
| local | - | - | FICBCO0380$0379 | - | MWHostToHost\v1\ProxyServices\CargaLoteProductos |

## 11. Servicios Dependientes (Árbol Proxy-Biz)

Servicios que tienen como PROXY_PADRE "MWHostToHost\v1\ProxyServices\CargaLoteProductos":

| PROXY_REFERENCIA | BIZ | URI |
|------------------|-----|-----|
| MWHostToHost\v1\ProxyServices\CargaLoteProductos | \MWHostToHost\v1\BusinessServices\MDW\validaServicioRegional\biz\validaServicioRegional_db | [jca://eis/DB/ConnectionMiddleware] |
| MWHostToHost\v1\ProxyServices\CargaLoteProductos | \MWHostToHost\v1\BusinessServices\OSB\mapeoErrores\biz\mapeoErrores | [http://172.23.13.19:8003/Middleware/v2/ProxyServices/MapeoErrores] |

## 12. Canales que utilizan la capacidad

**Canales:** INTERBANCA

**URIs:** /MWHostToHost/SalesAndServices/CustomerManagement/AperturaMasiva

**Número de canales:** 1

---

## Historial de Cambios

| Fecha | Versión | Autor | Descripción |
|-------|---------|-------|-------------|
| 2024-12-12 | 1.0 | ARQ FICOHSA | Creación inicial |
