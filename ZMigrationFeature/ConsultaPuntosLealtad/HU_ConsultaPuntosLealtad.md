# Historia de Usuario: ConsultaPuntosLealtad

> **Como** Equipo de Integración  
> **Quiero** Consultar los puntos de lealtad disponibles de un cliente mediante diferentes tipos de identificación (ID Cliente, ID Legal o Número de Tarjeta)  
> **Para** Permitir a los canales digitales y físicos conocer el saldo de puntos acumulados y su equivalente en efectivo según el programa de lealtad asociado

## Criterios de Aceptación

### 1. Campos de Entrada del Servicio

| Campo | Descripción | Requerido | Tipo/Formato |
|-------|-------------|-----------|-----------------|
| **CUSTOMER_ID_TYPE** | Tipo de identificador del cliente. Valores permitidos: CUSTOMER_ID, LEGAL_ID, CARD_NUMBER | **Sí** | string (enum) |
| **CUSTOMER_ID_VALUE** | Valor del identificador del cliente | **Sí** | string (minLength=1) |
| **RETURN_CASH_EQUIVALENT** | Indica si se debe retornar el equivalente en efectivo | **Sí** | string (enum: YES, NO) |
| **CASH_REDEMPTION** | Información para cálculo de equivalencia en efectivo | **Sí** | Complex Type |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ CARD_NUMBER | Número de tarjeta para redención | **Sí** | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ MERCHANT_ID | Identificador del comercio | **Sí** | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ MERCHANT_TYPE | Tipo de comercio | **Sí** | string |
| &nbsp;&nbsp;&nbsp;&nbsp;└─ TERMINAL_ID | Identificador del terminal | **Sí** | string |
| **PROGRAM_ID** | Identificador del programa de lealtad (1=Mastercard, 2=VISA) | No | string (enum: 1, 2, "") |

> **Validaciones:**
> - CUSTOMER_ID_TYPE debe ser uno de los valores permitidos: CUSTOMER_ID, LEGAL_ID, CARD_NUMBER
> - CUSTOMER_ID_VALUE debe tener al menos 1 carácter
> - RETURN_CASH_EQUIVALENT debe ser YES o NO
> - Se valida la estructura del mensaje contra el esquema XSD programaLealtadTypes.xsd
> - Se aplica validación de servicio regional con código FICBCO0229

### 2. Campos de Salida del Servicio

| Campo | Descripción | Requerido | Tipo |
|-------|-------------|-----------|------|
| **consultaPuntosLealtadResponse** | Respuesta del servicio de consulta de puntos | **Sí** | Complex Type |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ LEGAL_ID | Identificación legal del cliente | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ CUSTOMER_NAME | Nombre del cliente | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ BALANCE | Saldo de puntos disponibles | No | decimal |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ CASH_EQUIVALENT | Equivalente en efectivo de los puntos | No | decimal |
| &nbsp;&nbsp;&nbsp;&nbsp;└─ CASH_CURRENCY | Moneda del equivalente en efectivo | No | string |

> **Nota:** Todos los campos de salida están validados contra el esquema XSD programaLealtadTypes.xsd

## Tareas Técnicas

### 1. Códigos de Error

#### 1.1. Códigos de error del Proveedor

| Código Error | Descripción | Tipo Error |
|--------------|-------------|------------|
| SUCCESS | Operación exitosa | Negocio |
| ERROR | Error general en la operación | Técnico |
| MW-0008 | Servicio no implementado para el país/empresa | Negocio |
| Cliente no encontrado | El cliente no existe en el sistema | Negocio |
| No se encontró información de tarjeta débito | Tarjeta débito no encontrada | Negocio |
| Programa de lealtad no soportado | El programa de lealtad no está configurado | Negocio |

> **Nota:** Los errores son mapeados a través del servicio MapeoErrores con código de servicio FICBCO0229

### 2. Configuración de Timeout

- **Timeout proveedor Mastercard CustomerService:** Configurado en Business Service
- **Timeout proveedor VISA WSCRS:** Configurado en Business Service
- **Timeout operación del OSB:** Configurado a nivel de Proxy Service

### 3. Datos de Prueba

> **Nota:** Los siguientes son datos de ejemplo no reales, utilizados únicamente para propósitos de testing y documentación.

- **CUSTOMER_ID_TYPE:** CUSTOMER_ID
- **CUSTOMER_ID_VALUE:** 12345
- **RETURN_CASH_EQUIVALENT:** YES
- **CASH_REDEMPTION.CARD_NUMBER:** 1234567890123456
- **CASH_REDEMPTION.MERCHANT_ID:** MERCH001
- **CASH_REDEMPTION.MERCHANT_TYPE:** RETAIL
- **CASH_REDEMPTION.TERMINAL_ID:** TERM001
- **PROGRAM_ID:** 1

### 4. Datos de Contacto

**Contacto responsable OSB:**
- **David Ruiz** - david.ruiz@ficohsa.com
- **Wilmer Fernandez** - wilmer.fernandez@ficohsa.com  
- **Francia Avila** - francia.avila@ficohsa.com
- **Diego Gomez** - diego.gomez@ficohsa.com

### 5. Lógica Importante

**Flujo Principal del Servicio:**
1. **Validación XSD:** Se valida la estructura del mensaje contra el esquema programaLealtadTypes.xsd
2. **Validación Regional:** Se ejecuta ValidaServicioRegional con serviceId "FICBCO0229" para verificar disponibilidad por región
3. **Regionalización por País:** El servicio se enruta según el país de origen:
   - **HN01 (Honduras):** Implementación completa con lógica de consulta de información del cliente, programa de lealtad y puntos. Soporta consulta por CUSTOMER_ID, LEGAL_ID y CARD_NUMBER. Integra con T24, Cobis, Alcance, Mastercard y VISA. Incluye cálculo de equivalencia en efectivo.
   - **GT01 (Guatemala):** Enrutamiento a ConsultaPuntosLealtadGT. Implementación específica para el mercado guatemalteco con validaciones locales y conexión a proveedores regionales.
   - **PA01 (Panamá):** Enrutamiento a ConsultaPuntosLealtadPA. Maneja particularidades del mercado panameño incluyendo regulaciones locales y proveedores específicos del país.
   - **NI01 (Nicaragua):** Enrutamiento a ConsultaPuntosLealtadNI. Implementación adaptada para Nicaragua con lógica de negocio específica y conexiones a sistemas locales.
   - **Default:** Retorna error MW-0008 "SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY"
4. **Consulta de Información del Cliente (HN01):**
   - Si CUSTOMER_ID_TYPE = "CUSTOMER_ID": Consulta cliente por ID en T24
   - Si CUSTOMER_ID_TYPE = "CARD_NUMBER": Determina tipo de tarjeta (débito/crédito) y consulta información correspondiente
   - Si CUSTOMER_ID_TYPE = "LEGAL_ID": Consulta cliente por identificación legal
5. **Obtención de Parametrización:** Consulta parámetro FICBCO0229.MRS.INSTITUTION.NAME para Mastercard
6. **Consulta de Programa de Lealtad:** Determina el programa de lealtad asociado al cliente (1=Mastercard, 2=VISA)
7. **Consulta de Puntos:**
   - Si programa = 1 (Mastercard): Invoca CustomerService.getPointDetails
   - Si programa = 2 (VISA): Invoca WSCRS.validarDatosOpcion
   - Otro: Retorna error "Programa de lealtad no soportado"
8. **Cálculo de Equivalencia en Efectivo:** Si RETURN_CASH_EQUIVALENT = "YES" y hay puntos disponibles, invoca canjearPuntosEfectivo
9. **Transformación de Respuesta:** Construye respuesta con LEGAL_ID, CUSTOMER_NAME, BALANCE, CASH_EQUIVALENT y CASH_CURRENCY
10. **Manejo de Errores:** Aplica mapeo de errores a través del servicio MapeoErrores

**Servicios Dependientes Analizados:**
- **ValidaServicioRegional:** Valida disponibilidad del servicio por región
- **consultasClienteBS:** Consulta información de clientes en T24
- **sjConsultaTipoTarjeta:** Determina si una tarjeta es débito o crédito
- **tarjetasDebitoBS:** Consulta información de tarjetas débito
- **transaccionesAlcance:** Consulta información de tarjetas crédito
- **ObtenerParametrizacion:** Obtiene parámetros de configuración
- **consultaProgramaLealtad:** Determina el programa de lealtad del cliente
- **Mastercard CustomerService:** Consulta puntos en programa Mastercard
- **VISA WSCRS:** Consulta puntos en programa VISA
- **canjearPuntosEfectivo:** Calcula equivalencia de puntos a efectivo
- **MapeoErrores:** Mapea códigos de error

**Arquitectura Multi-Core:** El servicio soporta consulta de información desde múltiples sistemas core (T24, Alcance, Cobis) según el tipo de identificador y tipo de tarjeta

**Seguridad por Usuario:** El servicio utiliza las credenciales del RequestHeader (UserName/Password) para autenticación en servicios backend

### 6. Datos Relevantes

- El servicio no requiere reintentos automáticos
- El servicio no requiere reversos
- Soporta dos programas de lealtad: Mastercard (1) y VISA (2)
- Para tarjetas crédito en Honduras, se obtiene el grupo de afinidad para determinar el programa de lealtad
- El cálculo de equivalencia en efectivo es opcional y se realiza solo si se solicita explícitamente
- El servicio implementa un patrón de Router Dinámico Regional
- Logging habilitado en nivel debug
- SLA alerting y pipeline alerting habilitados en nivel normal

### 7. Detalles Técnicos de Conexión

- **Conexión a T24 (consultasClienteBS):** Por SOAP/HTTP - Consulta de información de clientes
- **Conexión a Alcance (transaccionesAlcance):** Por SOAP/HTTP - Consulta de información de tarjetas crédito
- **Conexión a Cobis (tarjetasDebitoBS):** Por SOAP/HTTP - Consulta de información de tarjetas débito
- **Conexión a Mastercard (CustomerService):** Por SOAP/HTTPS - Consulta de puntos Mastercard Rewards
- **Conexión a VISA (WSCRS):** Por SOAP/HTTP - Consulta de puntos VISA
- **Conexión a BD Middleware (ValidaServicioRegional, canjearPuntosEfectivo, ObtenerParametrizacion):** Por JCA/DB
- **Conexión a BD Interfaz (consultaProgramaLealtad):** Por JCA/DB

### 8. Dependencias del Servicio

**Servicios Internos:**
- ValidaServicioRegional_db - Validación de disponibilidad regional
- canjearPuntosEfectivo_db - Cálculo de equivalencia en efectivo
- ObtenerParametrizacion - Obtención de parámetros de configuración
- consultaProgramaLealtad_db - Consulta de programa de lealtad
- sjConsultaTipoTarjeta - Determinación de tipo de tarjeta
- MapeoErrores - Mapeo de códigos de error

**Servicios Externos:**
- consultasClienteBS - Consulta de clientes en T24
- tarjetasDebitoBS - Consulta de tarjetas débito en Cobis
- transaccionesAlcance - Consulta de tarjetas crédito en Alcance
- CustomerService (Mastercard) - Consulta de puntos Mastercard
- WSCRS (VISA) - Consulta de puntos VISA

## 9. Datos del Servicio

| Campo | Valor |
|-------|-------|
| **RUTA** | Middleware\v2\ProxyServices\ConsultaPuntosLealtad |
| **URI** | /Middleware/v2/ProxyServices/ConsultaPuntosLealtad |
| **NUMERO_OPERACIONES** | 1 |
| **OPERACIONES** | consultaPuntosLealtad |
| **CODIGO** | FICBCO0229 |
| **GRUPO_ASIGNADO** | ConsultaPuntosLealtad |

## 10. Información del Inventario de Servicios

Servicios relacionados con ConsultaPuntosLealtad encontrados en el inventario (CODIGO = "FICBCO0229"):

| Servicio | RUTA | NUMERO_OPERACIONES | OPERACIONES | CODIGO | GRUPO_ASIGNADO |
|----------|------|-------------------|-------------|--------|-----------------|
| ConsultaPuntosLealtad | Middleware\v2\ProxyServices\ConsultaPuntosLealtad | 1 | consultaPuntosLealtad | FICBCO0229 | ConsultaPuntosLealtad |
| ConsultaPuntosLealtadPA | Middleware\v2\ProxyServices\ConsultaPuntosLealtadPA | 1 | consultaPuntosLealtad | FICBCO0229 | ConsultaPuntosLealtad |
| ConsultaPuntosLealtadGT | Middleware\v2\ProxyServices\ConsultaPuntosLealtadGT | 1 | consultaPuntosLealtad | FICBCO0229 | ConsultaPuntosLealtad |
| ConsultaPuntosLealtadHN | Middleware\v2\ProxyServices\ConsultaPuntosLealtadHN | 1 | consultaPuntosLealtad | FICBCO0229 | ConsultaPuntosLealtad |
| ConsultaPuntosLealtadNI | Middleware\v2\ProxyServices\ConsultaPuntosLealtadNI | 1 | consultaPuntosLealtad | FICBCO0229 | ConsultaPuntosLealtad |

## 11. Servicios Dependientes (Árbol Proxy-Biz)

Servicios que tienen como PROXY_PADRE "Middleware\v2\ProxyServices\ConsultaPuntosLealtad":

| PROXY_REFERENCIA | BIZ | URI |
|------------------|-----|-----|
| Middleware\v2\ProxyServices\ConsultaPuntosLealtad | \Middleware\v2\BusinessServices\MDW\canjearPuntosEfectivo\biz\canjearPuntosEfectivo_db | [jca://eis/DB/ConnectionMiddleware] |
| Middleware\v2\ProxyServices\ConsultaPuntosLealtad | \Middleware\Business_Resources\tarjetasDebito\Resources\tarjetasDebitoBS | [http://172.23.13.19:7003/svcTarjetaDebito/services] |
| Middleware\v2\ProxyServices\ConsultaPuntosLealtad | \Middleware\v2\BusinessServices\INTFC\consultaProgramaLealtad\biz\consultaProgramaLealtad_db | [jca://eis/DB/ConnectionInterfazdb] |
| Middleware\v2\ProxyServices\ConsultaPuntosLealtad | \Middleware\v2\BusinessServices\ValidaServicioRegional\biz\ValidaServicioRegional_db | [jca://eis/DB/ConnectionMiddleware] |
| Middleware\v2\ProxyServices\ConsultaPuntosLealtad | \Middleware\v2\BusinessServices\Mastercard\CustomerService\biz\CustomerService | [https://192.168.50.35:7011/mastercard-webservices/CustomerService] |
| Middleware\v2\ProxyServices\ConsultaPuntosLealtad | \Middleware\v2\BusinessServices\SJS\consultaTipoTarjeta\biz\sjConsultaTipoTarjeta | [flow:Middleware/v2/BusinessServices/SJS/consultaTipoTarjeta/flow/sjConsultaTipoTarjeta] |
| Middleware\v2\ProxyServices\ConsultaPuntosLealtad | \Middleware\v2\BusinessServices\transaccionesAlcance\biz\transaccionesAlcance | [http://172.16.100.15/WSInfoTarjetasProduccion/wsinfotarjetas.asmx] |
| Middleware\v2\ProxyServices\ConsultaPuntosLealtad | \Middleware\Business_Resources\consultasCliente\Resources\consultasClienteBS | [http://10.9.104.55:7004/svcConsultasCliente/services, http://10.9.104.55:7005/svcConsultasCliente/services, http://10.9.104.55:7006/svcConsultasCliente/services] |
| Middleware\v2\ProxyServices\ConsultaPuntosLealtad | \Middleware\Business_Resources\general\Resources\ObtenerParametrizacion\ObtenerParametrizacion | [jca://eis/DB/ConnectionMiddleware] |
| Middleware\v2\ProxyServices\MapeoErrores | \Middleware\v2\BusinessServices\MDW\guardarBitacoraMapeoErrores\biz\guardarBitacoraMapeoErrores_db | [jca://eis/DB/ConnectionMiddleware] |
| Middleware\v2\ProxyServices\ConsultaPuntosLealtad | \Middleware\v2\BusinessServices\VISA\WSCRS\biz\WSCRS | [http://172.23.19.9:8095/WSCRS.asmx] |
| Middleware\v2\ProxyServices\MapeoErrores | \Middleware\v2\BusinessServices\MapeoErrores\biz\mapeodeErrores_db | [jca://eis/DB/ConnectionMiddleware] |

## 12. Canales que utilizan la capacidad

**Canales:** SALESFORCE

**URIs:** /Middleware/v2/ProxyServices/ConsultaPuntosLealtad, /Middleware/SalesAndServices/BrandManagement/ProgramaLealtad

**Número de canales:** 1

---

## Historial de Cambios

| Fecha | Versión | Autor | Descripción |
|-------|---------|-------|-------------|
| 2024-01-15 | 1.0 | ARQ FICOHSA | Creación inicial |
