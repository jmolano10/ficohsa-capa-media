# Historia de Usuario: ConsultaFICOPEN

> **Como** Equipo de Integración  
> **Quiero** consultar información detallada de cuentas FICOPEN (Fondo Individual de Capitalización de Prestaciones Laborales)  
> **Para** permitir a los canales digitales y sistemas internos acceder a los datos de pensiones y prestaciones de los clientes

## Criterios de Aceptación

### 1. Campos de Entrada del Servicio

| Campo | Descripción | Requerido | Tipo/Formato |
|-------|-------------|-----------|--------------|
| **consultaFICOPEN** | Elemento raíz de la solicitud | **Sí** | Complex Type |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **INVESTMENT_CODE** | Código de inversión del cliente | **Sí** | string (minLength=1) |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **START_DATE** | Fecha de inicio del período de consulta | **Sí** | string (length=8, formato: YYYYMMDD) |
| &nbsp;&nbsp;&nbsp;&nbsp;└─ **END_DATE** | Fecha de fin del período de consulta | **Sí** | string (length=8, formato: YYYYMMDD) |

> **Validaciones:**
> - INVESTMENT_CODE debe tener al menos 1 carácter
> - START_DATE y END_DATE deben tener exactamente 8 caracteres en formato YYYYMMDD
> - Se valida la estructura del mensaje contra el esquema XSD consultaFICOPENTypes.xsd
> - Se aplica validación de servicio regional con serviceId "FICBCO0110"

### 2. Campos de Salida del Servicio

| Campo | Descripción | Requerido | Tipo |
|-------|-------------|-----------|------|
| **consultaFICOPENResponse** | Respuesta del servicio de consulta FICOPEN | **Sí** | Complex Type |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **CUSTOMER_LEGAL_ID** | Identificación legal del cliente | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **CUSTOMER_NAME** | Nombre completo del cliente | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **ACCOUNT_NUMBER** | Número de cuenta FICOPEN | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **ACCOUNT_CURRENCY** | Moneda de la cuenta | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **CONTRACT_NUMBER** | Número de contrato | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **CONTRACT_TYPE** | Tipo de contrato | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **COMPANY** | Empresa asociada | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **START_DATE** | Fecha de inicio del contrato | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;└─ **consultaFICOPENResponseType** | Detalle de balances y movimientos | No | Complex Type |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└─ **consultaFICOPENResponseRecordType** | Registro de balance (0..unbounded) | No | Complex Type |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **BALANCE_TYPE** | Tipo de balance | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **PREVIOUS_BALANCE** | Balance anterior | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **GROSS_CONTRIBUTIONS_AMOUNT** | Monto de contribuciones brutas | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **INTEREST_AMOUNT** | Monto de intereses | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **WITHDRAWALS_AMOUNT** | Monto de retiros | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **FEE_AMOUNT** | Monto de comisiones | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **INSURANCE_AMOUNT** | Monto de seguros | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└─ **CURRENT_BALANCE** | Balance actual | No | string |

> **Nota:** Todos los campos de salida están validados contra el esquema XSD consultaFICOPENTypes.xsd

## Tareas Técnicas

### 1. Códigos de Error

#### 1.1. Códigos de error del Proveedor

| Código Error | Descripción | Tipo Error |
|--------------|-------------|------------|
| BEA-382505 | Error de validación XSD | Técnico |
| MW-0008 | Servicio no implementado para el país/empresa | Negocio |
| SUCCESS | Operación exitosa | N/A |
| ERROR | Error general en la operación | Técnico/Negocio |

> **Nota:** El servicio utiliza MapeoErrores para estandarizar los códigos de error con el código de servicio FICBCO0110

### 2. Configuración de Timeout

- **Timeout proveedor getFicopen12c:** 70 segundos
- **Timeout de conexión:** 65 segundos
- **Retry count:** 0 (sin reintentos automáticos)

### 3. Datos de Prueba

> **Nota:** Los siguientes son datos de ejemplo no reales, utilizados únicamente para propósitos de testing y documentación.

- **INVESTMENT_CODE:** "INV123456"
- **START_DATE:** "20240101"
- **END_DATE:** "20241231"

### 4. Datos de Contacto

**Contacto responsable OSB:**
- **David Ruiz** - david.ruiz@ficohsa.com
- **Wilmer Fernandez** - wilmer.fernandez@ficohsa.com  
- **Francia Avila** - francia.avila@ficohsa.com
- **Diego Gomez** - diego.gomez@ficohsa.com

### 5. Lógica Importante

**Flujo Principal del Servicio:**
1. **Validación XSD:** Se valida la estructura del mensaje contra el esquema consultaFICOPENTypes.xsd
2. **Validación Regional:** Se ejecuta ValidaServicioRegional con serviceId "FICBCO0110" para verificar disponibilidad por región
3. **Regionalización por País:** El servicio se enruta según el país de origen:
   - **HN01 (Honduras):** Invoca el business service getFicopen12c que conecta al servicio regional de pensiones
   - **Default:** Retorna error MW-0008 "SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY"
4. **Transformación de Request:** Se aplica transformación getFICOPENIn.xq para adaptar el mensaje al formato del proveedor
5. **Transformación de Header:** Se aplica getFICOPENHeaderIn.xq para construir el header de autenticación con credenciales OSB12AUTH
6. **Invocación al Proveedor:** Se invoca el business service getFicopen12c vía HTTP/SOAP
7. **Transformación de Response:** Se aplica getFICOPENOut.xq para adaptar la respuesta al formato estándar
8. **Manejo de Errores:** Se aplica mapeo de errores mediante el servicio MapeoErrores con código FICBCO0110

**Servicios Dependientes Analizados:**
- **getFicopen12c:** Business service que conecta al servicio regional de pensiones vía HTTP/SOAP
- **ValidaServicioRegional:** Valida disponibilidad del servicio por región
- **MapeoErrores:** Estandariza códigos de error del servicio

**Arquitectura Multi-Core:** El servicio está preparado para soportar múltiples países mediante regionalización, actualmente implementado solo para Honduras (HN01)

**Seguridad por Usuario:** Utiliza autenticación básica con credenciales almacenadas en Middleware/Security/OSB12AUTH

### 6. Datos Relevantes

- El servicio no requiere reintentos automáticos (retry-count: 0)
- El servicio no requiere reversos
- Servicio especializado para consulta de fondos de pensiones FICOPEN
- Soporta consulta de múltiples registros de balance en la respuesta (maxOccurs="unbounded")
- Implementado únicamente para Honduras (HN01), otros países retornan error de no implementado
- Timeout configurado en 70 segundos debido a la complejidad de la consulta de datos históricos
- Utiliza el patrón de regionalización estándar del middleware

### 7. Detalles Técnicos de Conexión

- **Conexión a getFicopen12c (Servicio Regional de Pensiones):** Por HTTP/SOAP - Conecta al endpoint regional de pensiones para obtener información de cuentas FICOPEN

### 8. Dependencias del Servicio

**Servicios Internos:**
- MapeoErrores - Mapeo y estandarización de códigos de error
- ValidaServicioRegional - Validación de disponibilidad del servicio por región

**Servicios Externos:**
- getFicopen12c - Business service que conecta al servicio regional de pensiones (/regional/pension/soap/getFICOPEN/v11g)

## 9. Datos del Servicio

| Campo | Valor |
|-------|-------|
| **RUTA** | Middleware\v2\ProxyServices\ConsultaFICOPEN |
| **URI** | /SMiddleware/OperationsAndExecution/BundledProducts/ConsultaFICOPEN_v2 |
| **NUMERO_OPERACIONES** | 1 |
| **OPERACIONES** | consultaFICOPEN |
| **CODIGO** | FICBCO0110 |
| **GRUPO_ASIGNADO** | ConsultaFICOPEN |

## 10. Información del Inventario de Servicios

Servicios relacionados con ConsultaFICOPEN encontrados en el inventario (GRUPO_ASIGNADO = "ConsultaFICOPEN"):

| Nombre del Servicio | Ruta | URI | Código FICBCO | WSDL | Grupo Asignado |
|---------------------|------|-----|---------------|------|----------------|
| ConsultaFICOPEN | Middleware\v2\ProxyServices\ConsultaFICOPEN | /SMiddleware/OperationsAndExecution/BundledProducts/ConsultaFICOPEN_v2 | FICBCO0110 | Middleware/v2/Resources/ConsultaFICOPEN/wsdl/consultaFICOPENPS | ConsultaFICOPEN |

## 11. Servicios Dependientes (Árbol Proxy-Biz)

Servicios que tienen como PROXY_PADRE "Middleware\v2\ProxyServices\ConsultaFICOPEN":

| PROXY_REFERENCIA | BIZ | URI |
|------------------|-----|-----|
| Middleware\v2\ProxyServices\MapeoErrores | \Middleware\v2\BusinessServices\MapeoErrores\biz\mapeodeErrores_db | [jca://eis/DB/ConnectionMiddleware] |
| Middleware\v2\ProxyServices\ConsultaFICOPEN | \Middleware\Business_Resources\Ficopen\Resource\consultaFICOPENBS | [jca://eis/DB/ConnectionFicopen] |
| Middleware\v2\ProxyServices\MapeoErrores | \Middleware\v2\BusinessServices\MDW\guardarBitacoraMapeoErrores\biz\guardarBitacoraMapeoErrores_db | [jca://eis/DB/ConnectionMiddleware] |
| Middleware\v2\ProxyServices\ConsultaFICOPEN | \Middleware\v2\BusinessServices\ValidaServicioRegional\biz\ValidaServicioRegional_db | [jca://eis/DB/ConnectionMiddleware] |

## 12. Canales que utilizan la capacidad

**Canales:** INTERBANCA, INTERBANCABD, INTERFAZBD, PENSIONES, SARA

**URIs:** /Middleware/OperationsAndExecution/BundledProducts/ConsultaFICOPEN, /SMiddleware/OperationsAndExecution/BundledProducts/ConsultaFICOPEN_v2

**Número de canales:** 5

---

## Artefactos Relacionados

- [Análisis Técnico](./ConsultaFICOPEN_AnalisisTecnico.md)
- [Entregables](./ConsultaFICOPEN_Entregables.md)

---

## Historial de Cambios

| Fecha | Versión | Autor | Descripción |
|-------|---------|-------|-------------|
| 2025-12-06 | 1.0 | ARQ FICOHSA | Creación inicial |
