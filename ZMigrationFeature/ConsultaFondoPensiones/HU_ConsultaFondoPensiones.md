# Historia de Usuario: ConsultaFondoPensiones

> **Como** Equipo de Integración  
> **Quiero** consultar información detallada de fondos de pensiones de los clientes  
> **Para** permitir a los sistemas de pensiones acceder a datos completos de cuentas, beneficiarios y contribuciones

## Criterios de Aceptación

### 1. Campos de Entrada del Servicio

| Campo | Descripción | Requerido | Tipo/Formato |
|-------|-------------|-----------|--------------|
| **consultaFondoPensionesRequest** | Elemento raíz de la solicitud | **Sí** | Complex Type |
| &nbsp;&nbsp;&nbsp;&nbsp;└─ **ACCOUNT_NUMBER** | Número de cuenta del fondo de pensiones | **Sí** | string |

> **Validaciones:**
> - ACCOUNT_NUMBER es obligatorio
> - Se valida la estructura del mensaje contra el esquema XSD consultaFondoPensionesTypes.xsd

### 2. Campos de Salida del Servicio

| Campo | Descripción | Requerido | Tipo |
|-------|-------------|-----------|------|
| **consultaFondoPensionesResponse** | Respuesta del servicio de consulta de fondo de pensiones | **Sí** | Complex Type |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **ACCOUNT_NUMBER** | Número de cuenta | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **ACCOUNT_TYPE** | Tipo de cuenta | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **ACCOUNT_CURRENCY** | Moneda de la cuenta | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **ACCOUNT_STATUS** | Estado de la cuenta | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **REQUEST_ID** | ID de solicitud | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **GROUP_CODE** | Código de grupo | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **CONTRACT_ID** | ID de contrato | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **CUSTOMER_ID** | ID del cliente | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **CUSTOMER_NAME** | Nombre del cliente | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **PRODUCT_CODE** | Código de producto | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **PRODUCT_NAME** | Nombre del producto | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **SUB_PRODUCT_CODE** | Código de subproducto | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **SUB_PRODUCT_NAME** | Nombre del subproducto | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **OPENING_DATE** | Fecha de apertura | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **EXPIRATION_DATE** | Fecha de expiración | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **CLOSING_DATE** | Fecha de cierre | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **OFFICER_CODE** | Código de oficial | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **BRANCH_CODE** | Código de sucursal | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **NOTIFICATION_TYPE** | Tipo de notificación | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **APPLY_INSURANCE** | Aplica seguro | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **FREQUENCY** | Frecuencia de contribución | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **FREQUENCY_DATE** | Fecha de frecuencia | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **PAYMENT_METHOD** | Método de pago | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **SALARY_AMOUNT** | Monto de salario | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **PREMIUM_AMOUNT** | Monto de prima | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **INSURED_AMOUNT** | Monto asegurado | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **CONTRIBUTION_TYPE** | Tipo de contribución | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **CONTRIBUTION_AMOUNT** | Monto de contribución | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **FIRST_CONTRIBUTION_AMOUNT** | Monto de primera contribución | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **FIRST_CONTRIBUTION_DATE** | Fecha de primera contribución | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **LAST_CONTRIBUTION_AMOUNT** | Monto de última contribución | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **LAST_CONTRIBUTION_DATE** | Fecha de última contribución | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **NEXT_CONTRIBUTION_AMOUNT** | Monto de próxima contribución | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **NEXT_CONTRIBUTION_DATE** | Fecha de próxima contribución | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **LAST_EXTRA_CONTRIBUTION_AMOUNT** | Monto de última contribución extra | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **LAST_EXTRA_CONTRIBUTION_DATE** | Fecha de última contribución extra | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **BALANCE_TYPE_INFO** | Información de tipos de balance | No | Complex Type |
| &nbsp;&nbsp;&nbsp;&nbsp;│&nbsp;&nbsp;&nbsp;└─ **BALANCE_TYPE_ITEM** | Item de tipo de balance (0..unbounded) | No | Complex Type |
| &nbsp;&nbsp;&nbsp;&nbsp;│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **BALANCE_TYPE_CODE** | Código de tipo de balance | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **BALANCE_TYPE_DESCRIPTION** | Descripción de tipo de balance | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **INVESTMENT_TYPE_CODE** | Código de tipo de inversión | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **INVESTMENT_TYPE_DESCRIPTION** | Descripción de tipo de inversión | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;│&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└─ **DISTRIBUTION_PERCENTANGE** | Porcentaje de distribución | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;└─ **BENEFICIARY_INFO** | Información de beneficiarios | No | Complex Type |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└─ **BENEFICIARY_ITEM** | Item de beneficiario (1..unbounded) | **Sí** | Complex Type |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **FULL_NAME** | Nombre completo del beneficiario | **Sí** | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **FIRST_NAME** | Primer nombre | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **SECOND_NAME** | Segundo nombre | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **FIRST_LASTNAME** | Primer apellido | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **SECOND_LASTNAME** | Segundo apellido | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **BIRTH_DATE** | Fecha de nacimiento | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **GENDER** | Género (MALE/FEMALE) | **Sí** | enum |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;├─ **RELATIONSHIP** | Relación con el titular | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;└─ **DISTRIBUTION_PERCENTAGE** | Porcentaje de distribución | No | string |

> **Nota:** Todos los campos de salida están validados contra el esquema XSD consultaFondoPensionesTypes.xsd

## Tareas Técnicas

### 1. Códigos de Error

#### 1.1. Códigos de error del Proveedor

| Código Error | Descripción | Tipo Error |
|--------------|-------------|------------|
| SUCCESS | Operación exitosa | N/A |
| ERROR | Error general en la operación | Técnico/Negocio |
| SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY | Servicio no implementado para el país/empresa | Negocio |

> **Nota:** El servicio evalúa el campo Status de la respuesta del proveedor para determinar el éxito de la operación

### 2. Configuración de Timeout

- **Timeout proveedor getPensionFund12c:** 70 segundos
- **Timeout de conexión:** 65 segundos
- **Retry count:** 0 (sin reintentos automáticos)

### 3. Datos de Prueba

> **Nota:** Los siguientes son datos de ejemplo no reales, utilizados únicamente para propósitos de testing y documentación.

- **ACCOUNT_NUMBER:** "1234567890"

### 4. Datos de Contacto

**Contacto responsable OSB:**
- **David Ruiz** - david.ruiz@ficohsa.com
- **Wilmer Fernandez** - wilmer.fernandez@ficohsa.com  
- **Francia Avila** - francia.avila@ficohsa.com
- **Diego Gomez** - diego.gomez@ficohsa.com

### 5. Lógica Importante

**Flujo Principal del Servicio:**
1. **Regionalización por País:** El servicio se enruta según el país de origen:
   - **HN02 (Honduras - FPC):** Invoca el business service getPensionFund12c que conecta al servicio regional de pensiones
   - **Default:** Retorna error "SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY"
2. **Transformación de Request:** Se aplica transformación getPensionFundIn.xq para adaptar el mensaje al formato del proveedor regional
3. **Transformación de Header:** Se aplica getPensionFundHeaderIn.xq para construir el header de autenticación con credenciales OSB12AUTH
4. **Invocación al Proveedor:** Se invoca el business service getPensionFund12c vía HTTP/SOAP
5. **Evaluación de Respuesta:** Se evalúa el campo StatusInfo/Status de la respuesta
6. **Transformación de Response:** Si Status es SUCCESS, se aplica consultaFondoPensionesHNOut.xq para adaptar la respuesta al formato estándar
7. **Manejo de Errores:** Si Status no es SUCCESS, se retorna el mensaje de error del campo ErrorInfo/Description

**Servicios Dependientes Analizados:**
- **getPensionFund12c:** Business service que conecta al servicio regional de pensiones vía HTTP/SOAP

**Arquitectura Multi-Core:** El servicio está preparado para soportar múltiples países mediante regionalización, actualmente implementado solo para Honduras FPC (HN02)

**Seguridad por Usuario:** Utiliza autenticación básica con credenciales almacenadas en Middleware/Security/OSB12AUTH

### 6. Datos Relevantes

- El servicio no requiere reintentos automáticos (retry-count: 0)
- El servicio no requiere reversos
- Servicio especializado para consulta de fondos de pensiones
- Soporta múltiples beneficiarios en la respuesta (maxOccurs="unbounded")
- Soporta múltiples tipos de balance en la respuesta (maxOccurs="unbounded")
- Implementado únicamente para Honduras FPC (HN02), otros países retornan error de no implementado
- Timeout configurado en 70 segundos debido a la complejidad de la consulta
- No utiliza validación regional estándar (ValidaServicioRegional)
- No utiliza servicio de MapeoErrores

### 7. Detalles Técnicos de Conexión

- **Conexión a getPensionFund12c (Servicio Regional de Pensiones):** Por HTTP/SOAP - Conecta al endpoint regional de pensiones para obtener información completa de fondos de pensiones

### 8. Dependencias del Servicio

**Servicios Internos:**
- Ninguno (no utiliza MapeoErrores ni ValidaServicioRegional)

**Servicios Externos:**
- getPensionFund12c - Business service que conecta al servicio regional de pensiones (/regional/pension/soap/getPensionFund11g/v1)

## 9. Datos del Servicio

| Campo | Valor |
|-------|-------|
| **RUTA** | Middleware\v2\ProxyServices\ConsultaFondoPensiones |
| **URI** | /Middleware/ReferenceData/BusinessPartner/ConsultaFondoPensiones |
| **NUMERO_OPERACIONES** | 1 |
| **OPERACIONES** | afiliaClienteFondoPensiones |
| **CODIGO** | No especificado |
| **GRUPO_ASIGNADO** | ConsultaFondoPensiones |

## 10. Información del Inventario de Servicios

Servicios relacionados con ConsultaFondoPensiones encontrados en el inventario (GRUPO_ASIGNADO = "ConsultaFondoPensiones"):

| Nombre del Servicio | Ruta | URI | Código FICBCO | WSDL | Grupo Asignado |
|---------------------|------|-----|---------------|------|----------------|
| ConsultaFondoPensiones | Middleware\v2\ProxyServices\ConsultaFondoPensiones | /Middleware/ReferenceData/BusinessPartner/ConsultaFondoPensiones | No especificado | Middleware/v2/Resources/AfiliaClienteFondoPensiones/wsdl/afiliaClienteFondoPensionesPS | ConsultaFondoPensiones |
| ConsultaFondosPensionesCliente | Middleware\v2\ProxyServices\ConsultaFondosPensionesCliente | /Middleware/ReferenceData/BusinessPartner/ConsultaFondosPensionesCliente | FICBCO195 | Middleware/v2/Resources/ConsultaFondosPensionesCliente/wsdl/consultaFondosPensionesClientePS | ConsultaFondoPensiones |

## 11. Servicios Dependientes (Árbol Proxy-Biz)

No se encontraron dependencias registradas en Arbol_Proxy_Biz.csv para este servicio.

**Dependencias identificadas en el código:**
- getPensionFund12c (Business Service HTTP/SOAP)

## 12. Canales que utilizan la capacidad

**Canales:** PENSIONES

**URIs:** /Middleware/ReferenceData/BusinessPartner/ConsultaFondoPensiones, /Middleware/ReferenceData/BusinessPartner/ConsultaFondosPensionesCliente

**Número de canales:** 1

---

## Artefactos Relacionados

- [Análisis Técnico](./ConsultaFondoPensiones_AnalisisTecnico.md)
- [Entregables](./ConsultaFondoPensiones_Entregables.md)

---

## Historial de Cambios

| Fecha | Versión | Autor | Descripción |
|-------|---------|-------|-------------|
| 2025-12-06 | 1.0 | ARQ FICOHSA | Creación inicial |
