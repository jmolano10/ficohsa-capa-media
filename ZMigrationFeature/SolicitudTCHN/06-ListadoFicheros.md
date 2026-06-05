# Listado de Ficheros que Intervienen — SolicitudTCHN

## Proxy Services

| Ruta Relativa | Descripción |
|---------------|-------------|
| `Middleware/v2/ProxyServices/SolicitudTCHN.proxy` | Proxy Service principal (entrada SOAP) |

## Pipelines

| Ruta Relativa | Descripción |
|---------------|-------------|
| `Middleware/v2/ProxyServices/SolicitudTCHN.pipeline` | Pipeline con lógica de orquestación (request/response/error) |

## Business Services

| Ruta Relativa | Descripción |
|---------------|-------------|
| `Middleware/v2/BusinessServices/MasterDataHN/conDatoCuenta/biz/conDatoCuenta_db.bix` | BS JCA - SP resolución de ORG por cuenta (HN) |
| `Middleware/v2/BusinessServices/VisionPlus/visionPlus/biz/visionPlus.bix` | BS HTTP/SOAP - Servicio VisionPlus Procesa |

## XQuery/XSLT

| Ruta Relativa | Descripción |
|---------------|-------------|
| `Middleware/v2/Resources/Generales/xq/convertirCodigoPais.xqy` | Conversión código país OSB↔ISO |
| `Middleware/v2/Resources/MasterDataHN/xq/conDatoCuentaHNIn.xqy` | Transformación entrada SP conDatoCuenta |
| `Middleware/v2/Resources/SolicitudTC/xq/embosserAddL8VBNIIn.xqy` | Transformación entrada VisionPlus (versión HN/NI) |
| `Middleware/v2/Resources/SolicitudTC/xq/embosserAddL8VBIn.xqy` | Transformación entrada VisionPlus (versión genérica, referencia) |
| `Middleware/v2/Resources/SolicitudTC/xq/solicitudTCOut.xqy` | Transformación salida VisionPlus → Response OSB |

## WSDL

| Ruta Relativa | Descripción |
|---------------|-------------|
| `Middleware/v2/Resources/SolicitudTC/wsdl/solicitudTCPS.wsdl` | WSDL del Proxy Service (contrato público) |
| `Middleware/v2/BusinessServices/VisionPlus/visionPlus/wsdl/VisionPlus.wsdl` | WSDL del servicio VisionPlus |
| `Middleware/v2/BusinessServices/MasterDataHN/conDatoCuenta/wsdl/conDatoCuenta_db.wsdl` | WSDL del DB Adapter conDatoCuenta |

## XSD (Schemas)

| Ruta Relativa | Descripción |
|---------------|-------------|
| `Middleware/v2/Resources/GestionesTarjetas/xsd/gestionesTarjetasTypes.xsd` | Tipos del dominio GestionesTarjetas (solicitudTC, solicitudTCResponse) |
| `Middleware/v2/Resources/esquemas_generales/HeaderElements.xsd` | Esquema de headers (RequestHeader, ResponseHeader) |
| `Middleware/v2/BusinessServices/VisionPlus/visionPlus/xsd/XMLSchema_769155616.xsd` | Esquema VisionPlus (EmbosserAddL8VBRequest/Response) |
| `Middleware/v2/BusinessServices/MasterDataHN/conDatoCuenta/xsd/conDatoCuenta_sp.xsd` | Esquema SP conDatoCuenta (InputParameters/OutputParameters) |

## JCA (Adaptadores)

| Ruta Relativa | Descripción |
|---------------|-------------|
| `Middleware/v2/BusinessServices/MasterDataHN/conDatoCuenta/jca/conDatoCuenta_db.jca` | Configuración JCA del DB Adapter |

## Java Callouts / POJOs

No se detectaron Java Callouts ni POJOs en este flujo.

## Policies / Security

No se detectaron políticas de seguridad customizadas. El proxy usa `wsdl-policy-attachments` y el BS usa `no-policies`.

## Properties / Config

No se detectaron archivos `.properties` específicos para este flujo.
