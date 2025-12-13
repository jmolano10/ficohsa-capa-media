# Historia de Usuario: ConsultaInformacionLaboral

> **Como** Equipo de Integración  
> **Quiero** consultar el historial de información laboral de los clientes  
> **Para** permitir a los sistemas de pensiones acceder al historial completo de empleadores, salarios y ocupaciones de los clientes

## Criterios de Aceptación

### 1. Campos de Entrada del Servicio

| Campo | Descripción | Requerido | Tipo/Formato |
|-------|-------------|-----------|--------------|
| **consultaInformacionLaboralRequest** | Elemento raíz de la solicitud | **Sí** | Complex Type |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **CUSTOMER_ACCOUNT** | Número de cuenta del cliente | **Sí** | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **FROM_DATE** | Fecha de inicio del período de consulta | No | string (formato: YYYYMMDD) |
| &nbsp;&nbsp;&nbsp;&nbsp;└─ **TO_DATE** | Fecha de fin del período de consulta | No | string (formato: YYYYMMDD) |

> **Validaciones:**
> - CUSTOMER_ACCOUNT es obligatorio
> - FROM_DATE y TO_DATE son opcionales
> - Las fechas se transforman al formato dd/MM/yyyy antes de enviar al proveedor
> - Se valida la estructura del mensaje contra el esquema XSD consultaInformacionLaboralTypes.xsd
> - Se aplica validación de servicio regional con serviceId "FICBCO0181"

### 2. Campos de Salida del Servicio

| Campo | Descripción | Requerido | Tipo |
|-------|-------------|-----------|------|
| **consultaInformacionLaboralResponse** | Respuesta del servicio de consulta de información laboral | **Sí** | Complex Type |
| &nbsp;&nbsp;&nbsp;&nbsp;└─ **JOB_INFO_HISTORY** | Historial de información laboral | No | Complex Type |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└─ **JOB_INFO_HISTORY_ITEM** | Item de historial laboral (0..unbounded) | No | Complex Type |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **CUSTOMER_ACCOUNT** | Número de cuenta del cliente | **Sí** | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **STATUS** | Estado del registro laboral | **Sí** | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **START_DATE** | Fecha de inicio del empleo | **Sí** | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **END_DATE** | Fecha de fin del empleo | **Sí** | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **PAYMENT_PERIOD** | Período de pago | **Sí** | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **EMPLOYER_CODE** | Código del empleador | **Sí** | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **EMPLOYER_NAME** | Nombre del empleador | **Sí** | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **EMPLOYER_RTN** | RTN del empleador | **Sí** | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **BALANCE_TYPE** | Tipo de balance | **Sí** | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **PAYMENT_CURRENCY** | Moneda de pago | **Sí** | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **PAYMENT_AMOUNT** | Monto de pago | **Sí** | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **SALARY_CURRENCY** | Moneda de salario | **Sí** | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **SALARY_AMOUNT** | Monto de salario | **Sí** | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **OCCUPATION_CODE** | Código de ocupación | **Sí** | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **OCCUPATION_DESC** | Descripción de ocupación | **Sí** | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **JOB_TITLE_CODE** | Código de título del puesto | **Sí** | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└─ **JOB_TITLE_DESC** | Descripción del título del puesto | **Sí** | string |

> **Nota:** Todos los campos de salida están validados contra el esquema XSD consultaInformacionLaboralTypes.xsd

## Tareas Técnicas

### 1. Códigos de Error

#### 1.1. Códigos de error del Proveedor

| Código Error | Descripción | Tipo Error |
|--------------|-------------|------------|
| BEA-382505 | Error de validación XSD | Técnico |
| SUCCESS | Operación exitosa | N/A |
| ERROR | Error general en la operación | Técnico/Negocio |

> **Nota:** El servicio utiliza MapeoErrores para estandarizar los códigos de error con el código de servicio FICBCO0181

### 2. Configuración de Timeout

- **Timeout proveedor getEmploymentInformation12c:** 70 segundos
- **Timeout de conexión:** 65 segundos
- **Retry count:** 0 (sin reintentos automáticos)

### 3. Datos de Prueba

> **Nota:** Los siguientes son datos de ejemplo no reales, utilizados únicamente para propósitos de testing y documentación.

- **CUSTOMER_ACCOUNT:** "1234567890"
- **FROM_DATE:** "20230101"
- **TO_DATE:** "20241231"

### 4. Datos de Contacto

**Contacto responsable OSB:**
- **David Ruiz** - david.ruiz@ficohsa.com
- **Wilmer Fernandez** - wilmer.fernandez@ficohsa.com  
- **Francia Avila** - francia.avila@ficohsa.com
- **Diego Gomez** - diego.gomez@ficohsa.com

### 5. Lógica Importante

**Flujo Principal del Servicio:**
1. **Validación XSD:** Se valida la estructura del mensaje contra el esquema consultaInformacionLaboralTypes.xsd
2. **Validación Regional:** Se ejecuta ValidaServicioRegional con serviceId "FICBCO0181" para verificar disponibilidad por región
3. **Regionalización por País:** El servicio se enruta según el país de origen:
   - **HN01 (Honduras):** Invoca el business service getEmploymentInformation12c que conecta al servicio regional de pensiones
   - **Default:** Retorna error "SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY"
4. **Transformación de Request:** Se aplica transformación getEmploymentInformationIn.xq que convierte las fechas de formato YYYYMMDD a dd/MM/yyyy
5. **Transformación de Header:** Se aplica getEmploymentInformationHeaderIn.xq para construir el header de autenticación con credenciales OSB12AUTH
6. **Invocación al Proveedor:** Se invoca el business service getEmploymentInformation12c vía HTTP/SOAP
7. **Evaluación de Respuesta:** Se evalúa el campo StatusInfo/Status de la respuesta
8. **Transformación de Response:** Si Status es SUCCESS, se aplica getEmploymentInformationHNOut.xq para adaptar la respuesta al formato estándar
9. **Manejo de Errores:** Se aplica mapeo de errores mediante el servicio MapeoErrores con código FICBCO0181

**Servicios Dependientes Analizados:**
- **getEmploymentInformation12c:** Business service que conecta al servicio regional de pensiones vía HTTP/SOAP
- **ValidaServicioRegional:** Valida disponibilidad del servicio por región
- **MapeoErrores:** Estandariza códigos de error del servicio
- **consultaInformacionLaboralFPC_db:** Business service legacy de base de datos (JCA)

**Arquitectura Multi-Core:** El servicio está preparado para soportar múltiples países mediante regionalización, actualmente implementado solo para Honduras (HN01)

**Seguridad por Usuario:** Utiliza autenticación básica con credenciales almacenadas en Middleware/Security/OSB12AUTH

### 6. Datos Relevantes

- El servicio no requiere reintentos automáticos (retry-count: 0)
- El servicio no requiere reversos
- Servicio especializado para consulta de historial laboral de clientes
- Soporta múltiples registros de historial laboral en la respuesta (maxOccurs="unbounded")
- Implementado únicamente para Honduras (HN01), otros países retornan error de no implementado
- Timeout configurado en 70 segundos debido a la complejidad de la consulta histórica
- Utiliza el patrón de regionalización estándar del middleware
- Transforma fechas de formato YYYYMMDD a dd/MM/yyyy para el proveedor
- Todos los campos dentro de JOB_INFO_HISTORY_ITEM son obligatorios

### 7. Detalles Técnicos de Conexión

- **Conexión a getEmploymentInformation12c (Servicio Regional de Pensiones):** Por HTTP/SOAP - Conecta al endpoint regional de pensiones para obtener historial de información laboral

### 8. Dependencias del Servicio

**Servicios Internos:**
- MapeoErrores - Mapeo y estandarización de códigos de error
- ValidaServicioRegional - Validación de disponibilidad del servicio por región

**Servicios Externos:**
- getEmploymentInformation12c - Business service que conecta al servicio regional de pensiones (/regional/pension/soap/getEmploymentInformation/v11g)

**Servicios Legacy:**
- consultaInformacionLaboralFPC_db - Business service de base de datos (JCA) no utilizado en el flujo principal

## 9. Datos del Servicio

| Campo | Valor |
|-------|-------|
| **RUTA** | Middleware\v2\ProxyServices\ConsultaInformacionLaboral |
| **URI** | /Middleware/ReferenceData/BusinessPartner/ConsultaInformacionLaboral |
| **NUMERO_OPERACIONES** | 1 |
| **OPERACIONES** | consultaInformacionLaboral |
| **CODIGO** | FICBCO0181 |
| **GRUPO_ASIGNADO** | ConsultaInformacionLaboral |

## 10. Información del Inventario de Servicios

Servicios relacionados con ConsultaInformacionLaboral encontrados en el inventario (GRUPO_ASIGNADO = "ConsultaInformacionLaboral"):

| Nombre del Servicio | Ruta | URI | Código FICBCO | WSDL | Grupo Asignado |
|---------------------|------|-----|---------------|------|----------------|
| ConsultaInformacionLaboral | Middleware\v2\ProxyServices\ConsultaInformacionLaboral | /Middleware/ReferenceData/BusinessPartner/ConsultaInformacionLaboral | FICBCO0181 | Middleware/v2/Resources/ConsultaInformacionLaboral/wsdl/consultaInformacionLaboralPS | ConsultaInformacionLaboral |

## 11. Servicios Dependientes (Árbol Proxy-Biz)

Servicios que tienen como PROXY_PADRE "Middleware\v2\ProxyServices\ConsultaInformacionLaboral":

| PROXY_REFERENCIA | BIZ | URI |
|------------------|-----|-----|
| Middleware\v2\ProxyServices\ConsultaInformacionLaboral | \Middleware\v2\BusinessServices\FPC\consultaInformacionLaboral\biz\consultaInformacionLaboralFPC_db | [jca://eis/DB/ConnectionFicopen] |
| Middleware\v2\ProxyServices\ConsultaInformacionLaboral | \Middleware\v2\BusinessServices\ValidaServicioRegional\biz\ValidaServicioRegional_db | [jca://eis/DB/ConnectionMiddleware] |

## 12. Canales que utilizan la capacidad

**Canales:** PENSIONES

**URIs:** /Middleware/ReferenceData/BusinessPartner/ConsultaInformacionLaboral

**Número de canales:** 1

---

## Artefactos Relacionados

- [Análisis Técnico](./ConsultaInformacionLaboral_AnalisisTecnico.md)
- [Entregables](./ConsultaInformacionLaboral_Entregables.md)

---

## Historial de Cambios

| Fecha | Versión | Autor | Descripción |
|-------|---------|-------|-------------|
| 2025-12-06 | 1.0 | ARQ FICOHSA | Creación inicial |
