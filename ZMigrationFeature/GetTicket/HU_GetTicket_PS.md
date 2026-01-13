# Historia de Usuario: GetTicket_PS

> **Como** Equipo de Integración  
> **Quiero** Implementar un servicio para obtener tickets de autenticación del sistema ACH  
> **Para** Permitir la autenticación segura en operaciones posteriores del sistema ACH

## Criterios de Aceptación

### 1. Campos de Entrada del Servicio

| Campo | Descripción | Requerido | Tipo/Formato |
|-------|-------------|-----------|--------------|
| **GetTicketRequest** | Solicitud de ticket de autenticación | **Sí** | Complex Type |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **originatorId** | Identificador del originador | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;└─ **messageType** | Tipo de mensaje para el ticket | No | string |
| **RequestHeader** | Encabezado de la solicitud | **Sí** | Complex Type |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **SourceBank** | Banco origen de la solicitud | **Sí** | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **DestinationBank** | Banco destino de la solicitud | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **ApplicationId** | Identificador de la aplicación (usado como userName) | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;└─ **Language** | Idioma de la respuesta | No | string |

> **Validaciones:**
> - Se valida la estructura del mensaje contra el esquema XSD achTypes.xsd
> - El campo SourceBank es obligatorio en el RequestHeader
> - El ApplicationId se utiliza como userName en la llamada al sistema ACH
> - Se aplica validación de servicio regional

### 2. Campos de Salida del Servicio

| Campo | Descripción | Requerido | Tipo |
|-------|-------------|-----------|------|
| **GetTicketResponse** | Respuesta del servicio de obtención de ticket | **Sí** | Complex Type |
| &nbsp;&nbsp;&nbsp;&nbsp;└─ **ticket** | Token de autenticación generado por el sistema ACH | No | string |
| **ResponseHeader** | Encabezado de la respuesta | **Sí** | Complex Type |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **TransactionId** | Identificador único de la transacción | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **MessageId** | Identificador del mensaje | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **SuccessIndicator** | Indicador de éxito de la operación | **Sí** | string |
| &nbsp;&nbsp;&nbsp;&nbsp;├─ **Messages** | Mensajes informativos o de error | No | string |
| &nbsp;&nbsp;&nbsp;&nbsp;└─ **ValueDate** | Fecha y hora de procesamiento | **Sí** | string |

> **Nota:** Todos los campos de salida están validados contra el esquema XSD achTypes.xsd

## Tareas Técnicas

### 1. Códigos de Error

#### 1.1. Códigos de error del Proveedor

| Código Error | Descripción | Tipo Error |
|--------------|-------------|------------|
| T001 | Connection timeout al servicio ACH | Técnico |
| T002 | Read timeout en la respuesta | Técnico |
| T004 | Service unavailable - ACH no disponible | Técnico |
| B001 | Invalid originatorId | Negocio |
| B002 | Invalid messageType | Negocio |
| S001 | Database connection error | Sistema |
| S005 | Internal server error | Sistema |

> **Nota:** Los errores se mapean desde el sistema ACH y se transforman usando el servicio GetErrorMessages_BS

### 2. Configuración de Timeout

- **Timeout proveedor ACH:** No especificado en configuración
- **Timeout operación del OSB:** 120 segundos (configuración estándar)

### 3. Datos de Prueba

> **Nota:** Los siguientes son datos de ejemplo no reales, utilizados únicamente para propósitos de testing y documentación.

- **originatorId:** "FICOHSA_HN"
- **messageType:** "AUTH_REQUEST"
- **SourceBank:** "HN01"
- **DestinationBank:** "HN01"
- **ApplicationId:** "ACH_CLIENT"
- **Language:** "es"

### 4. Datos de Contacto

**Contacto responsable OSB:**
- **David Ruiz** - david.ruiz@ficohsa.com
- **Wilmer Fernandez** - wilmer.fernandez@ficohsa.com  
- **Francia Avila** - francia.avila@ficohsa.com
- **Diego Gomez** - diego.gomez@ficohsa.com

### 5. Lógica Importante

**Flujo Principal del Servicio:**
1. **Validación XSD:** Se valida la estructura del mensaje contra el esquema achTypes.xsd
2. **Asignación de Variables:** Se asignan variables comunes (codigoServicio='5', uuid, sourceBank, destinationBank)
3. **Log Inicial:** Se registra la solicitud inicial usando SetLogInfoService_BS
4. **Preparación Request ACH:** Se construye GetAchTicket_params usando ApplicationId como userName
5. **Llamada ACH:** Se ejecuta wsCallout al servicio ACHRest_BS operación GetAchTicket
6. **Transformación de Respuesta:** Se construye la respuesta usando GetTicketOUT.xqy y GetTicketHeaderOut.xqy
7. **Log Final:** Se registra la respuesta exitosa
8. **Manejo de Errores:** En caso de error, se consulta GetErrorMessages_BS y se construye respuesta de error

**Servicios Dependientes Analizados:**
- **ACHRest_BS:** Servicio principal para comunicación con sistema ACH
- **SetLogInfoService_BS:** Servicio de logging para auditoría
- **GetErrorMessages_BS:** Servicio de mapeo de códigos de error

**Arquitectura:** Servicio Simple con comunicación directa al sistema ACH

**Seguridad:** Utiliza inboundWss con processWssHeader="true"

### 6. Datos Relevantes

- El servicio no requiere reintentos automáticos
- El servicio no requiere reversos (genera tokens de autenticación)
- Servicio de autenticación para obtener tickets válidos para operaciones ACH
- Utiliza transformaciones XQuery para construcción de request y response
- Implementa logging completo para auditoría de operaciones
- Manejo centralizado de errores con mapeo personalizado
- El ApplicationId del header se mapea como userName en la llamada ACH

### 7. Detalles Técnicos de Conexión

- **Conexión a ACH:** Por REST/HTTP - Servicio de autenticación y obtención de tickets
- **Conexión a SetLogInfoService:** Por SOAP - Registro de auditoría
- **Conexión a GetErrorMessages:** Por SOAP - Mapeo de errores

### 8. Dependencias del Servicio

**Servicios Internos:**
- SetLogInfoService_BS - Servicio de logging y auditoría
- GetErrorMessages_BS - Servicio de mapeo de códigos de error

**Servicios Externos:**
- ACHRest_BS - Servicio REST del sistema ACH para autenticación

## 9. Datos del Servicio

| Campo | Valor |
|-------|-------|
| **RUTA** | Applications\RequestorServices\v1.0\HN\GetTicket\ProxyServices\GetTicket_PS |
| **URI** | /Applications/RequestorServices/v1.0/HN/GetTicket/ProxyServices/GetTicket_PS |
| **NUMERO_OPERACIONES** | 1 |
| **OPERACIONES** | GetTicket_PS |
| **CODIGO** | GetTicket_PS |
| **GRUPO_ASIGNADO** | No especificado |

## 10. Información del Inventario de Servicios

Servicio GetTicket_PS encontrado en el inventario:

| URI | NUMERO_OPERACIONES | OPERACIONES | CODIGO | GRUPO_ASIGNADO | RUTA |
|-----|-------------------|-------------|--------|-----------------|------|
| /Applications/RequestorServices/v1.0/HN/GetTicket/ProxyServices/GetTicket_PS | 1 | GetTicket_PS | GetTicket_PS | No especificado | Applications\RequestorServices\v1.0\HN\GetTicket\ProxyServices\GetTicket_PS |

## 11. Servicios Dependientes (Árbol Proxy-Biz)

No se encontraron servicios que tengan como PROXY_PADRE "Applications\RequestorServices\v1.0\HN\GetTicket\ProxyServices\GetTicket_PS" en el archivo Arbol_Proxy_Biz.csv.

## 12. Canales que utilizan la capacidad

**Canales:** No se encontró información de canales para esta capacidad (GRUPO_ASIGNADO: No especificado)

**URIs:** N/A

**Número de canales:** 0

---

## Historial de Cambios

| Fecha | Versión | Autor | Descripción |
|-------|---------|-------|-------------|
| 2026-01-02 | 1.0 | ARQ FICOHSA | Creación inicial |
