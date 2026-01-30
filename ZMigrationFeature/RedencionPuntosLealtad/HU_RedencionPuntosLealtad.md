# Historia de Usuario: RedencionPuntosLealtad

> **Como** Equipo de Integración  
> **Quiero** Implementar el servicio de redención de puntos del programa de lealtad  
> **Para** Permitir a los clientes canjear sus puntos acumulados por efectivo, abono a cuenta o pago de tarjeta de crédito

## Criterios de Aceptación

### 1. Campos de Entrada del Servicio

| Campo | Descripción | Requerido | Tipo/Formato |
|-------|-------------|-----------|-----------------|
| **CUSTOMER_ID_TYPE** | Tipo de identificador del cliente. Valores permitidos: CUSTOMER_ID, LEGAL_ID, CARD_NUMBER | **Sí** | string (enum) |
| **CUSTOMER_ID_VALUE** | Valor del identificador del cliente | **Sí** | string (minLength=1) |
| **REDEMPTION_TYPE** | Tipo de redención. Valores permitidos: CASH, POINTS | **Sí** | string (enum) |
| **REDEMPTION_AMOUNT** | Monto a redimir (efectivo o puntos) | **Sí** | decimal |
| **CASH_REDEMPTION** | Información de redención en efectivo | **Sí** | Complex Type |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ CARD_NUMBER | Número de tarjeta | **Sí** | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ MERCHANT_ID | Identificador del comercio | **Sí** | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ MERCHANT_TYPE | Tipo de comercio | **Sí** | string |
| &nbsp;&nbsp;&nbsp;&nbsp;└─ TERMINAL_ID | Identificador del terminal | **Sí** | string |
| **REDEMPTION_DETAILS** | Detalles de la redención | **Sí** | Complex Type |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ REDEMPTION_METHOD | Método de redención. Valores permitidos: CASH, ACCOUNT_CREDIT, CREDIT_CARD_PAYMENT | **Sí** | string (enum) |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ ACCOUNT_NUMBER | Número de cuenta (si aplica) | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;└─ CREDIT_CARD_NUMBER | Número de tarjeta de crédito (si aplica) | No | string |
| **PROGRAM_ID** | Identificador del programa de lealtad. Valores permitidos: "1", "2", "" | No | string (enum) |

> **Validaciones:**
> - Se valida que CUSTOMER_ID_TYPE sea uno de los valores permitidos
> - Se valida que CUSTOMER_ID_VALUE tenga al menos 1 carácter
> - Se valida que REDEMPTION_TYPE sea CASH o POINTS
> - Se valida que REDEMPTION_AMOUNT sea un valor decimal válido
> - Se valida la estructura del mensaje contra el esquema XSD programaLealtadTypes.xsd
> - Se aplica validación de servicio regional con código FICBCO0229
> - Si REDEMPTION_TYPE es CASH, se convierte el monto a puntos usando el servicio canjearPuntosEfectivo

### 2. Campos de Salida del Servicio

| Campo | Descripción | Requerido | Tipo |
|-------|-------------|-----------|------|
| **redencionPuntosLealtadResponse** | Respuesta del servicio de redención | **Sí** | Complex Type |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ LEGAL_ID | Identificación legal del cliente | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ CUSTOMER_NAME | Nombre del cliente | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ POINTS_REDEEMED | Puntos redimidos | No | decimal |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ REMAINING_BALANCE | Saldo restante de puntos | No | decimal |
| &nbsp;&nbsp;&nbsp;&nbsp;└─ REDEMPTION_ID | ID de la transacción de redención | No | long |

> **Nota:** Todos los campos de salida están validados contra el esquema XSD programaLealtadTypes.xsd

## Tareas Técnicas

### 1. Códigos de Error

#### 1.1. Códigos de error del Proveedor

| Código Error | Descripción | Tipo Error |
|--------------|-------------|------------|
| MW-0008 | SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY | Técnico |
| SUCCESS | Operación exitosa | Negocio |
| ERROR | Error en validación o procesamiento | Negocio |
| Cliente no encontrado | Cliente no existe en el sistema | Negocio |
| No se encontró información de tarjeta débito | Tarjeta débito no encontrada | Negocio |
| Códigos MRS | Códigos de error de Mastercard Rewards Service | Técnico |

> **Nota:** Los errores se mapean a través del servicio MapeoErrores con código de servicio FICBCO0229

### 2. Configuración de Timeout

- **Timeout proveedor Mastercard RedemptionService:** Configurado en Business Service
- **Timeout operación del OSB:** Configurado en Proxy Service

### 3. Datos de Prueba

> **Nota:** Los siguientes son datos de ejemplo no reales, utilizados únicamente para propósitos de testing y documentación.

- **CUSTOMER_ID_TYPE:** LEGAL_ID
- **CUSTOMER_ID_VALUE:** 0801199012345
- **REDEMPTION_TYPE:** CASH
- **REDEMPTION_AMOUNT:** 100.00
- **CASH_REDEMPTION.CARD_NUMBER:** 1234567890123456
- **CASH_REDEMPTION.MERCHANT_ID:** MERCH001
- **CASH_REDEMPTION.MERCHANT_TYPE:** RETAIL
- **CASH_REDEMPTION.TERMINAL_ID:** TERM001
- **REDEMPTION_DETAILS.REDEMPTION_METHOD:** CASH

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
   - **HN01 (Honduras):** 
     - Validación XSD del mensaje de entrada
     - Consulta información del cliente mediante conInfoLealtad_db (obtiene legalId, customerName, cardType, logo)
     - Si cardType es CREDIT: Consulta datos de cuenta mediante conDatoCuenta_db para obtener customerId, org, scheme, accountNumber
     - Determina programa de lealtad: DEBIT usa programCode='1', CREDIT consulta consultaProgramaLealtad_db
     - Conversión de puntos si REDEMPTION_TYPE='CASH' mediante canjearPuntosEfectivo_db
     - Obtiene parametrización (matrixId, institutionName, rewardItem)
     - Redención según programCode:
       - programCode='1': Redención mediante Mastercard RedemptionService (doItemRedemption)
       - programCode='2': Inserta transacción mediante INSTransaccionRedencion_db, redime en VisionPlus (PointsRedeem) y consulta saldo mediante PointsAdjustmentInquiry
   - **GT01 (Guatemala):**
     - Validación XSD y validación de negocio (solo soporta CUSTOMER_ID_TYPE='CARD_NUMBER')
     - Consulta datos de cuenta mediante conDatoCuenta_db (obtiene logo, customerId, customerName, legalId)
     - Consulta programa de lealtad mediante consultaProgramaLealtad_db
     - Conversión de puntos si REDEMPTION_TYPE='CASH' mediante canjearPuntosEfectivo_db
     - Inserta transacción de redención mediante INSTransaccionRedencion_db
     - Obtiene parametrización (matrixId, institutionName, rewardItem)
     - Si programCode='2': Redención mediante VisionPlus (PointsRedeem)
   - **NI01 (Nicaragua):**
     - Validación XSD (solo soporta CUSTOMER_ID_TYPE='CARD_NUMBER')
     - Consulta tipo de tarjeta mediante sjConsultaTipoTarjetaNI (obtiene cardType, logo, customerId, customerName, legalId, cardStatus)
     - Determina programa de lealtad:
       - Si cardType='DEBIT' y cardStatus='ACTIVE': Consulta obtenerTipoProgramaLealtad_db usando BIN de tarjeta
       - Si cardType='CREDIT': Consulta consultaProgramaLealtad_db
     - Conversión de puntos si REDEMPTION_TYPE='CASH' mediante canjearPuntosEfectivo_db
     - Obtiene parametrización (matrixId, institutionName, rewardItem)
     - Redención según programCode:
       - programCode='1': Redención mediante Mastercard RedemptionService (doItemRedemption)
       - programCode='2': Redención mediante VisionPlus (PointsRedeem)
   - **PA01 (Panamá):**
     - Validación XSD (solo soporta CUSTOMER_ID_TYPE='CARD_NUMBER')
     - Consulta datos de cuenta mediante conDatoCuenta_db (obtiene logo, customerId, customerName, legalId)
     - Consulta programa de lealtad mediante consultaProgramaLealtad_db
     - Conversión de puntos si REDEMPTION_TYPE='CASH' mediante canjearPuntosEfectivo_db
     - Obtiene parametrización (matrixId, institutionName, rewardItem)
     - Si programCode='2': Redención mediante VisionPlus (PointsRedeem)
   - **Default:** Error MW-0008 - Servicio no implementado para el país
4. **Validaciones de Negocio (HN01):** Se validan los datos de entrada usando XQuery redencionPuntosLealtadValidate
5. **Consulta de Información del Cliente:**
   - Si CUSTOMER_ID_TYPE = "CUSTOMER_ID": Consulta cliente por ID en T24
   - Si CUSTOMER_ID_TYPE = "CARD_NUMBER": 
     - Consulta tipo de tarjeta (débito/crédito)
     - Si es débito: Consulta información en T24
     - Si es crédito: Consulta información en Alcance
   - Si CUSTOMER_ID_TYPE = "LEGAL_ID": Consulta cliente por identificación legal en T24
6. **Obtención de Puntos:**
   - Si REDEMPTION_TYPE = "CASH": Convierte monto a puntos usando canjearPuntosEfectivo
   - Si REDEMPTION_TYPE = "POINTS": Usa directamente REDEMPTION_AMOUNT
7. **Obtención de Parametrización:** Obtiene MATRIXID y INSTITUTION_NAME según el país
8. **Redención en Mastercard:** Llama a doItemRedemption del RedemptionService de Mastercard
9. **Transformación de Respuesta:** Construye respuesta con datos del cliente y resultado de redención
10. **Manejo de Errores:** Aplicación de mapeo de errores con código FICBCO0229

**Servicios Dependientes Analizados:**
- **ValidaServicioRegional:** Valida disponibilidad del servicio por región
- **MapeoErrores:** Mapea códigos de error a mensajes estándar
- **canjearPuntosEfectivo:** Convierte monto en efectivo a puntos
- **ObtenerParametrizacion:** Obtiene configuración de MATRIXID e INSTITUTION_NAME
- **consultasClienteBS:** Consulta información de cliente en T24
- **sjConsultaTipoTarjeta:** Determina si tarjeta es débito o crédito
- **tarjetasDebitoBS:** Consulta información de tarjeta débito
- **transaccionesAlcance:** Consulta información de tarjeta crédito
- **RedemptionService:** Servicio de Mastercard para redención de puntos

**Arquitectura Multi-Core:** El servicio soporta múltiples países (HN, GT, NI, PA) con implementaciones específicas por país

**Seguridad por Usuario:** Utiliza autenticación mediante RequestHeader con Username y Password

### 6. Datos Relevantes

- El servicio requiere integración con Mastercard Rewards Service
- El servicio soporta redención por efectivo o puntos
- El servicio soporta tres métodos de redención: efectivo, abono a cuenta, pago de tarjeta
- Conversión de efectivo a puntos se realiza mediante procedimiento almacenado
- El servicio valida existencia del cliente antes de procesar redención
- Diferencia entre tarjetas débito y crédito para consulta de información
- Parametrización dinámica de MATRIXID según país
- Manejo de errores centralizado mediante MapeoErrores

### 7. Detalles Técnicos de Conexión

- **Conexión a T24 (consultasClienteBS):** Por HTTP - Consulta de información de clientes
- **Conexión a Alcance (transaccionesAlcance):** Por HTTP/SOAP - Consulta de información de tarjetas crédito
- **Conexión a Mastercard (RedemptionService):** Por HTTPS - Redención de puntos en programa de lealtad
- **Conexión a Base de Datos (canjearPuntosEfectivo):** Por JCA - Conversión de efectivo a puntos
- **Conexión a Base de Datos (ValidaServicioRegional):** Por JCA - Validación regional
- **Conexión a Base de Datos (ObtenerParametrizacion):** Por JCA - Obtención de parámetros

### 8. Dependencias del Servicio

**Servicios Internos:**
- ValidaServicioRegional_db - Validación de disponibilidad regional
- MapeoErrores - Mapeo de códigos de error
- canjearPuntosEfectivo_db - Conversión efectivo a puntos
- ObtenerParametrizacion - Obtención de parámetros de configuración
- sjConsultaTipoTarjeta - Determinación de tipo de tarjeta
- RedencionPuntosLealtadGT - Implementación para Guatemala
- RedencionPuntosLealtadNI - Implementación para Nicaragua
- RedencionPuntosLealtadPA - Implementación para Panamá
- RedencionPuntosLealtadHN - Implementación para Honduras

**Servicios Externos:**
- consultasClienteBS - Consulta de clientes en T24
- tarjetasDebitoBS - Consulta de tarjetas débito
- transaccionesAlcance - Consulta de tarjetas crédito en Alcance
- RedemptionService - Servicio de redención de Mastercard

## 9. Datos del Servicio

| Campo | Valor |
|-------|-------|
| **RUTA** | Middleware\v2\ProxyServices\RedencionPuntosLealtad |
| **URI** | local |
| **NUMERO_OPERACIONES** | N/A |
| **OPERACIONES** | redencionPuntosLealtad |
| **CODIGO** | FICBCO0229 |
| **GRUPO_ASIGNADO** | RedencionPuntosLealtad |

## 10. Información del Inventario de Servicios

Servicios relacionados encontrados en el inventario con GRUPO_ASIGNADO = "RedencionPuntosLealtad":

| Servicio | Ruta | URI | Operaciones | Código |
|----------|------|-----|-------------|--------|
| RedencionPuntosLealtad | Middleware\v2\ProxyServices\RedencionPuntosLealtad | local | redencionPuntosLealtad | FICBCO0229 |
| RedencionPuntosLealtadFacade | Middleware\v2\ProxyServices\RedencionPuntosLealtadFacade | local | N/A | N/A |
| RedencionPuntosLealtadGT | Middleware\v2\ProxyServices\RedencionPuntosLealtadGT | local | redencionPuntosLealtad | FICBCO0229 |
| RedencionPuntosLealtadHN | Middleware\v2\ProxyServices\RedencionPuntosLealtadHN | local | redencionPuntosLealtad | FICBCO0229 |
| RedencionPuntosLealtadNI | Middleware\v2\ProxyServices\RedencionPuntosLealtadNI | local | redencionPuntosLealtad | FICBCO0229 |
| RedencionPuntosLealtadPA | Middleware\v2\ProxyServices\RedencionPuntosLealtadPA | local | redencionPuntosLealtad | FICBCO0229 |

## 11. Servicios Dependientes (Árbol Proxy-Biz)

Servicios que tienen como PROXY_PADRE "Middleware\v2\ProxyServices\RedencionPuntosLealtad":

| PROXY_REFERENCIA | BIZ | URI |
|------------------|-----|-----|
| RedencionPuntosLealtadGT | INSTransaccionRedencion_db | [jca://eis/DB/ConnectionTarjetas] |
| MapeoErrores | guardarBitacoraMapeoErrores_db | [jca://eis/DB/ConnectionMiddleware] |
| RedencionPuntosLealtad | canjearPuntosEfectivo_db | [jca://eis/DB/ConnectionMiddleware] |
| RedencionPuntosLealtad | ObtenerParametrizacion | [jca://eis/DB/ConnectionMiddleware] |
| RedencionPuntosLealtad | RedemptionService | [https://192.168.50.35:7011/mastercard-webservices/RedemptionService] |
| RedencionPuntosLealtadNI | obtenerTipoProgramaLealtad_db | [jca://eis/DB/ConnectionInterfazdb] |
| RedencionPuntosLealtad | ValidaServicioRegional_db | [jca://eis/DB/ConnectionMiddleware] |
| RedencionPuntosLealtadNI | sjConsultaTipoTarjetaNI | [flow:Middleware/v2/BusinessServices/SJS/consultaTipoTarjetaNI/flow/sjConsultaTipoTarjetaNI] |
| RedencionPuntosLealtadGT | visionPlus | [http://172.28.1.146:7802/VisionPlusService] |
| RedencionPuntosLealtadNI | visionPlus | [http://172.28.1.146:7802/VisionPlusService] |
| RedencionPuntosLealtad | consultasClienteBS | [http://10.9.104.55:7004/svcConsultasCliente/services] |
| RedencionPuntosLealtadPA | consultaProgramaLealtad_db | [jca://eis/DB/ConnectionInterfazdb] |
| RedencionPuntosLealtadPA | conDatoCuenta_db | [jca://eis/DB/ConnectionTarjetas] |
| RedencionPuntosLealtadGT | conDatoCuenta_db | [jca://eis/DB/ConnectionTarjetas] |
| RedencionPuntosLealtad | sjConsultaTipoTarjeta | [flow:Middleware/v2/BusinessServices/SJS/consultaTipoTarjeta/flow/sjConsultaTipoTarjeta] |
| RedencionPuntosLealtad | tarjetasDebitoBS | [http://172.23.13.19:7003/svcTarjetaDebito/services] |
| RedencionPuntosLealtadNI | canjearPuntosEfectivo_db | [jca://eis/DB/ConnectionProxyNI] |
| RedencionPuntosLealtadPA | canjearPuntosEfectivo_db | [jca://eis/DB/ConnectionProxyNI] |
| RedencionPuntosLealtad | transaccionesAlcance | [http://172.16.100.15/WSInfoTarjetasProduccion/wsinfotarjetas.asmx] |
| MapeoErrores | mapeodeErrores_db | [jca://eis/DB/ConnectionMiddleware] |

## 12. Canales que utilizan la capacidad

**Canales:** SALESFORCE

**URIs:** /Middleware/SalesAndServices/BrandManagement/ProgramaLealtad

**Número de canales:** 1

---

## Historial de Cambios

| Fecha | Versión | Autor | Descripción |
|-------|---------|-------|-------------|
| 2024-01-15 | 1.0 | ARQ FICOHSA | Creación inicial |
