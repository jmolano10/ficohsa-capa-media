# Listado de Ficheros - GetTicket

## Archivos Principales de la Funcionalidad

### Proxy Services
- `Applications/RequestorServices/v1.0/HN/GetTicket/ProxyServices/GetTicket_PS.proxy`
  - **Tipo**: OSB Proxy Service
  - **Función**: Punto de entrada SOAP para la funcionalidad GetTicket
  - **Binding**: SOAP 1.1 con WSDL
  - **URI**: `/Applications/RequestorServices/v1.0/HN/GetTicket/ProxyServices/GetTicket_PS`

### Pipelines
- `Applications/RequestorServices/v1.0/HN/GetTicket/Pipelines/GetTicket_PP.pipeline`
  - **Tipo**: OSB Pipeline
  - **Función**: Orquestación del flujo de procesamiento
  - **Stages**: CommonParams, LogInitialRequest, GetTicketACHREQ, GetTicketACH, AssignResponse, LogFinalResponse, FinalResponse
  - **Error Handler**: Pipeline de manejo de errores personalizado

### WSDL y Contratos
- `Applications/RequestorServices/v1.0/HN/GetTicket/WSDL/GetTicket_PS.wsdl`
  - **Tipo**: WSDL Contract
  - **Función**: Definición del contrato SOAP
  - **Namespace**: `urn:AchSoapRouter_PS`
  - **Operations**: GetTicket
  - **Binding**: AchSoapRouter_PS_ptt-binding

### Transformaciones XQuery
- `Applications/RequestorServices/v1.0/HN/GetTicket/XQ/GetTicketHeaderOut.xqy`
  - **Tipo**: XQuery Transformation
  - **Función**: Transformación del header de respuesta
  - **Input**: GetTicketResponse del servicio ACH
  - **Output**: ResponseHeader estándar OSB

- `Applications/RequestorServices/v1.0/HN/GetTicket/XQ/GetTicketOUT.xqy`
  - **Tipo**: XQuery Transformation
  - **Función**: Transformación del body de respuesta
  - **Input**: GetTicketResponse del servicio ACH
  - **Output**: GetTicketResponse OSB

### Archivos de Configuración XQuery Mapper
- `Applications/.settings/oracle.xquery.mapper.jdev.model/RequestorServices/v1.0/HN/GetTicket/XQ/GetTicketHeaderOut.xqy.xml`
  - **Tipo**: XQuery Mapper Configuration
  - **Función**: Configuración del mapper para GetTicketHeaderOut

- `Applications/.settings/oracle.xquery.mapper.jdev.model/RequestorServices/v1.0/HN/GetTicket/XQ/GetTicketOUT.xqy.xml`
  - **Tipo**: XQuery Mapper Configuration
  - **Función**: Configuración del mapper para GetTicketOUT

## Business Services Dependientes

### Servicio ACH REST
- `Applications/ProviderServices/BusinessServices/ACHRest_BS.bix`
  - **Tipo**: OSB Business Service (REST)
  - **Función**: Conexión al servicio REST de ACH
  - **Endpoint**: `https://saliente-ach-dev2.gfficohsa.hn/api/Ach`
  - **Operations**: GetAchTicket, GetStatus, SenCredit, GetTransaction, Echo

- `Applications/ProviderServices/WSDL/ACHRest_BS.wsdl`
  - **Tipo**: WSDL para Business Service REST
  - **Función**: Definición de operaciones REST como SOAP
  - **Namespace**: `http://xmlns.oracle.com/DynamoMigrate/Applications/ACHRest_BS`

- `Applications/ProviderServices/WADL/ACHRest_BS.wadl`
  - **Tipo**: WADL (Web Application Description Language)
  - **Función**: Descripción del servicio REST

- `Applications/ProviderServices/SA/ACHRest_SA.sa`
  - **Tipo**: Service Account
  - **Función**: Credenciales para autenticación HTTP Basic

### Servicios de Logging y Error
- `CommonResources/MiddlewareDB/ProviderServices/BusinessServices/SetLogInfoService/v1.0/SetLogInfoService_BS`
  - **Tipo**: OSB Business Service
  - **Función**: Registro de logs de transacciones
  - **Operations**: SetLogInfoService_BS

- `CommonResources/MiddlewareDB/ProviderServices/BusinessServices/GetErrorMessages/v1.0/GetErrorMessages_BS`
  - **Tipo**: OSB Business Service
  - **Función**: Obtención de mensajes de error localizados
  - **Operations**: GetErrorMessages_BS

## Esquemas XSD

### Esquemas de Tipos ACH
- `MWBanking/Ach/RequestorServices/v1.0/AchSoapRouter/XSD/achTypes.xsd`
  - **Tipo**: XML Schema Definition
  - **Función**: Definición de tipos para servicios ACH SOAP
  - **Namespace**: `http://www.ficohsa.com.hn/middleware.services/achServicesPS`
  - **Elements**: GetTicketRequest, GetTicketResponse, DoEchoRequest, etc.

- `Applications/ProviderServices/XSD/achCDM.xsd`
  - **Tipo**: XML Schema Definition
  - **Función**: Definición de tipos para servicios ACH REST (CDM)
  - **Namespace**: `http://www.ficohsa.com/ach`
  - **Elements**: GetTicketResponse, SendCredit, GetTransactionStatusResponse, etc.

### Esquemas Comunes
- `CommonResources/XSD/CommonTypes.xsd`
  - **Tipo**: XML Schema Definition
  - **Función**: Tipos comunes para headers y estructuras estándar
  - **Namespace**: `http://www.ficohsa.com.hn/middleware.services/commonTypes`
  - **Elements**: RequestHeader, ResponseHeader, StatusInfo, ErrorInfo

## Transformaciones XQuery Comunes

### Transformaciones de Logging
- `CommonResources/MiddlewareDB/ProviderServices/XQ/Tx_Msg_To_SetLogInfo`
  - **Tipo**: XQuery Transformation
  - **Función**: Transformación de mensajes para logging
  - **Input**: Parámetros de transacción
  - **Output**: Request para SetLogInfoService

- `CommonResources/MiddlewareDB/ProviderServices/XQ/Tx_Msg_To_GetErrorBS`
  - **Tipo**: XQuery Transformation
  - **Función**: Transformación para obtener mensajes de error
  - **Input**: Código de error y parámetros
  - **Output**: Request para GetErrorMessages

### Transformaciones de Error
- `CommonResources/XQ/Tx_ErrorMap_To_ErrorHeaderRSP`
  - **Tipo**: XQuery Transformation
  - **Función**: Transformación de errores a ResponseHeader
  - **Input**: Error mapping response
  - **Output**: ResponseHeader con información de error

## Archivos de Configuración y Políticas

### Configuraciones OSB
- Configuraciones de timeout y retry en ACHRest_BS.bix
- Configuraciones de monitoring y tracing en GetTicket_PS.proxy
- Configuraciones de security (WSS processing) en GetTicket_PS.proxy

### Service Accounts
- `Applications/ProviderServices/SA/ACHRest_SA.sa`
  - **Función**: Credenciales para autenticación HTTP Basic con el servicio ACH

## Tests y Validación

### Tests Relevantes
- **No se encontraron archivos de test específicos** para la funcionalidad GetTicket
- **Recomendación**: Crear tests unitarios y de integración para validar la funcionalidad

## Archivos de Configuración del Entorno

### Propiedades y Configuración
- **No se encontraron archivos .properties específicos** para GetTicket
- **Configuración embebida** en los archivos .bix y .proxy

## Resumen de Rutas por Tipo

### Estructura de Directorios
```
Applications/RequestorServices/v1.0/HN/GetTicket/
├── Pipelines/
│   └── GetTicket_PP.pipeline
├── ProxyServices/
│   └── GetTicket_PS.proxy
├── WSDL/
│   └── GetTicket_PS.wsdl
└── XQ/
    ├── GetTicketHeaderOut.xqy
    └── GetTicketOUT.xqy

Applications/ProviderServices/
├── BusinessServices/
│   └── ACHRest_BS.bix
├── WSDL/
│   └── ACHRest_BS.wsdl
├── WADL/
│   └── ACHRest_BS.wadl
├── XSD/
│   └── achCDM.xsd
└── SA/
    └── ACHRest_SA.sa

CommonResources/
├── XSD/
│   └── CommonTypes.xsd
├── XQ/
│   └── Tx_ErrorMap_To_ErrorHeaderRSP
└── MiddlewareDB/ProviderServices/
    ├── BusinessServices/
    │   ├── SetLogInfoService/v1.0/SetLogInfoService_BS
    │   └── GetErrorMessages/v1.0/GetErrorMessages_BS
    └── XQ/
        ├── Tx_Msg_To_SetLogInfo
        └── Tx_Msg_To_GetErrorBS

MWBanking/Ach/RequestorServices/v1.0/AchSoapRouter/XSD/
└── achTypes.xsd
```

## Total de Archivos Identificados

- **Archivos principales**: 6
- **Business Services**: 3
- **Esquemas XSD**: 3
- **Transformaciones XQuery**: 5
- **Service Accounts**: 1
- **Archivos de configuración**: 2

**Total**: 20 archivos directamente relacionados con la funcionalidad GetTicket