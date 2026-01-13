# Análisis Técnico: GetTicket_PS

## Resumen Ejecutivo

El servicio **GetTicket_PS** (GetTicket_PS) es un servicio Simple que permite obtener tickets de autenticación del sistema ACH. Implementa un patrón de Servicio Simple con comunicación directa para autenticación.

## Arquitectura del Servicio

### Patrón de Diseño
- **Tipo**: Servicio Simple
- **Versión**: v1.0
- **Protocolo**: SOAP/HTTP
- **Seguridad**: Custom WSS Authentication

### Flujo de Ejecución

```mermaid
graph TD
    A[Cliente] --> B[GetTicket_PS Proxy Service]
    B --> C[Validación XSD]
    C --> D[CommonParams Stage]
    D --> E[LogInitialRequest]
    E --> F[GetTicketACHREQ Stage]
    F --> G[GetTicketACH Stage]
    G --> H[ACHRest_BS]
    H --> I[AssignResponse]
    I --> J[LogFinalResponse]
    J --> K[FinalResponse]
    K --> L[Respuesta Final]
    
    B --> M[Error Handler]
    M --> N[GetErrors Stage]
    N --> O[GetErrorMessages_BS]
    O --> P[TxErrorMessage]
    P --> Q[LogErrorRequest]
    Q --> R[Response Error]
```

## Servicios Dependientes

### 1. ACHRest_BS
- **Propósito**: Servicio REST principal para comunicación con sistema ACH
- **Parámetros**: GetAchTicket_params (userName extraído de ApplicationId)
- **Respuesta**: GetAchTicketRSP (ticket de autenticación)
- **Validación**: Operación GetAchTicket para obtención de tokens

### 2. SetLogInfoService_BS
- **Propósito**: Servicio de logging y auditoría de transacciones
- **Parámetros**: Información completa de la transacción (request/response)
- **Respuesta**: Confirmación de registro
- **Validación**: Logging tanto de request como response y errores

### 3. GetErrorMessages_BS
- **Propósito**: Servicio de mapeo y traducción de códigos de error
- **Parámetros**: Código de error del sistema, código de servicio, idioma
- **Respuesta**: Mensaje de error traducido y formateado
- **Validación**: Mapeo de errores técnicos y de negocio

## Transformaciones de Datos

### Procesamiento por País

| País | Código | Descripción Lógica | XQuery Request | XQuery Response |
|-------|--------|-------------------|----------------|----------------|
| Honduras | HN01 | Procesamiento directo al sistema ACH nacional para obtención de tickets | N/A (construcción inline) | ficohsacore-osb12/Applications/RequestorServices/v1.0/HN/GetTicket/XQ/GetTicketOUT.xqy, ficohsacore-osb12/Applications/RequestorServices/v1.0/HN/GetTicket/XQ/GetTicketHeaderOut.xqy |

## Conexiones por País

### Honduras (HN01)
```xml
<!-- REST/HTTP -->
<service>ACHRest_BS</service>
<endpoint>[ENDPOINT_ACH_HN]</endpoint>
<operation>GetAchTicket</operation>
<!-- Autenticación: Configurada a nivel de Business Service -->
```

## Validación XSD

### Información General
- **Esquema XSD**: achTypes.xsd
- **Namespace**: http://www.ficohsa.com.hn/middleware.services/achServicesPS
- **Versión**: 1.0

### Archivos de Esquema

#### Ubicación
- **XSD Principal**: `ficohsacore-osb12/MWBanking/Ach/RequestorServices/v1.0/AchSoapRouter/XSD/achTypes.xsd`
- **WSDL**: `ficohsacore-osb12/Applications/RequestorServices/v1.0/HN/GetTicket/WSDL/GetTicket_PS.wsdl`
- **Headers**: `ficohsacore-osb12/CommonResources/XSD/CommonTypes.xsd`

#### Dependencias
- **Namespace http://www.ficohsa.com.hn/middleware.services/achServicesPS**: Para tipos específicos de ACH
- **Namespace http://www.ficohsa.com.hn/middleware.services/commonTypes**: Para headers comunes

### Estructura del Request

#### Definición XSD Request
```xml
<xs:element name="GetTicketRequest" type="ach:GetTicketRequestType"/>

<xs:complexType name="GetTicketRequestType">
    <xs:sequence>
        <xs:element name="originatorId" type="xs:string" minOccurs="0"/>
        <xs:element name="messageType" type="xs:string" minOccurs="0"/>
    </xs:sequence>
</xs:complexType>
```

#### Ejemplo de Request Válido
> **Nota:** Los siguientes son datos de ejemplo no reales, utilizados únicamente para propósitos de testing y documentación.

```xml
<GetTicketRequest xmlns="http://www.ficohsa.com.hn/middleware.services/achServicesPS">
    <originatorId>FICOHSA_HN</originatorId>
    <messageType>AUTH_REQUEST</messageType>
</GetTicketRequest>
```

### Estructura del Response

### Definiciones XSD Completas

#### Response Principal
```xml
<xs:element name="GetTicketResponse" type="ach:GetTicketResponseType"/>

<xs:complexType name="GetTicketResponseType">
    <xs:sequence>
        <xs:element name="ticket" minOccurs="0" type="xs:string"/>
    </xs:sequence>
</xs:complexType>
```

#### Headers de Request
```xml
<xs:complexType name="RequestHeaderType">
    <xs:sequence>
        <xs:element name="SourceBank" type="xs:string"/>
        <xs:element name="DestinationBank" minOccurs="0" type="xs:string"/>
        <xs:element name="ApplicationId" minOccurs="0" type="xs:string"/>
        <xs:element name="Language" type="xs:string" minOccurs="0"/>
    </xs:sequence>
</xs:complexType>
```

#### Headers de Response
```xml
<xs:complexType name="ResponseHeaderType">
    <xs:sequence>
        <xs:element name="TransactionId" minOccurs="0" type="xs:string"/>
        <xs:element name="MessageId" minOccurs="0" type="xs:string"/>
        <xs:element name="SuccessIndicator" type="xs:string"/>
        <xs:element name="Messages" type="xs:string" minOccurs="0"/>
        <xs:element name="ValueDate" type="xs:string"/>
    </xs:sequence>
</xs:complexType>
```

### Ejemplo de Response Válido

> **Nota:** Los siguientes son datos de ejemplo no reales, utilizados únicamente para propósitos de testing y documentación.

```xml
<GetTicketResponse xmlns="http://www.ficohsa.com.hn/middleware.services/achServicesPS">
    <ticket>eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiIxMjM0NTY3ODkwIiwibmFtZSI6IkZJQ09IU0EiLCJpYXQiOjE1MTYyMzkwMjJ9.SflKxwRJSMeKKF2QT4fwpMeJf36POk6yJV_adQssw5c</ticket>
</GetTicketResponse>
```

### Casos de Error XSD

#### Request Inválido - Namespace Incorrecto
> **Nota:** Los siguientes son datos de ejemplo no reales, utilizados únicamente para propósitos de testing y documentación.

```xml
<!-- ERROR: Namespace incorrecto -->
<GetTicketRequest xmlns="http://wrong.namespace/">
    <originatorId>FICOHSA_HN</originatorId>
    <messageType>AUTH_REQUEST</messageType>
</GetTicketRequest>
```

#### Response Inválido - SuccessIndicator Faltante
> **Nota:** Los siguientes son datos de ejemplo no reales, utilizados únicamente para propósitos de testing y documentación.

```xml
<!-- ERROR: Falta SuccessIndicator (requerido en ResponseHeader) -->
<ResponseHeader xmlns="http://www.ficohsa.com.hn/middleware.services/commonTypes">
    <ValueDate>2026-01-02T18:24:21</ValueDate>
    <!-- SuccessIndicator faltante -->
</ResponseHeader>
```

#### Request Header Inválido - SourceBank Faltante
> **Nota:** Los siguientes son datos de ejemplo no reales, utilizados únicamente para propósitos de testing y documentación.

```xml
<!-- ERROR: Falta SourceBank (requerido) -->
<RequestHeader xmlns="http://www.ficohsa.com.hn/middleware.services/commonTypes">
    <ApplicationId>ACH_CLIENT</ApplicationId>
    <!-- SourceBank faltante -->
</RequestHeader>
```

---

## Historial de Cambios

| Fecha | Versión | Autor | Descripción |
|-------|---------|-------|-------------|
| 2026-01-02 | 1.0 | ARQ FICOHSA | Creación inicial |
