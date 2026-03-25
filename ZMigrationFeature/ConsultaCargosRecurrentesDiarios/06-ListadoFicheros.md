# Listado de Ficheros - ConsultaCargosRecurrentesDiarios

## Proxy Services

### Proxy Principal
- `Middleware/v2/ProxyServices/ConsultaCargosRecurrentesDiarios.proxy`
  - **Función**: Proxy principal con enrutamiento dinámico
  - **Endpoint**: `/Middleware/v2/ProxyServices/ConsultaCargosRecurrentesDiarios`
  - **Características**: Autenticación custom-token, validación XSD, enrutamiento regional

### Proxies Regionales
- `Middleware/v2/ProxyServices/ConsultaCargosRecurrentesDiariosHN.proxy`
  - **Función**: Implementación específica para Honduras (HN01)
  - **Protocolo**: SOAP 1.1
  - **Características**: Obtención de parámetros, transformaciones, validación

- `Middleware/v2/ProxyServices/ConsultaCargosRecurrentesDiariosNI.proxy`
  - **Función**: Implementación específica para Nicaragua (NI01)
  - **Protocolo**: SOAP 1.2
  - **Características**: Configuraciones de throttling, result caching, delay interval

### External Services
- `Middleware/v2/ExternalServices/ConsultaCargosRecurrentesDiarios.proxy`
  - **Función**: Definición de servicio externo (si aplica)

## Business Services

### Servicios VisaNet
- `Middleware/v2/BusinessServices/VisaNet/biz/wsVisaTransactionHN.biz`
  - **Función**: Conexión a VisaNet Honduras
  - **URL**: `https://192.168.125.188/WSVisaTransaction.asmx`
  - **Protocolo**: SOAP 1.1

- `Middleware/v2/BusinessServices/VisaNet/biz/wsVisaTransaction.biz`
  - **Función**: Conexión a VisaNet Nicaragua
  - **URL**: `https://192.168.125.16:9443/WSVisaTransaction.asmx`
  - **Protocolo**: SOAP 1.2

### Servicios de Configuración
- `Middleware/v2/BusinessServices/MDW/consultaRutaRegional/biz/consultaRutaRegional_db`
  - **Función**: Consulta de ruta regional para enrutamiento dinámico

- `Middleware/Business_Resources/general/Resources/ObtenerParametrizacion/ObtenerParametrizacion`
  - **Función**: Obtención de parámetros de configuración por región

## WSDL Files

### Servicio Principal
- `Middleware/v2/Resources/ConsultaCargosRecurrentesDiarios/wsdl/consultaCargosRecurrentesDiariosPS.wsdl`
  - **Función**: Definición del contrato SOAP del servicio
  - **Namespace**: `http://www.ficohsa.com.hn/middleware.services/consultaCargosRecurrentesDiariosPS/`
  - **Operación**: `consultaCargosRecurrentesDiarios`

### Servicios Externos
- `Middleware/v2/BusinessServices/VisaNet/wsdl/WSVisaTransaction.wsdl`
  - **Función**: Contrato del servicio VisaNet
  - **Namespace**: `http://tempuri.org/`
  - **Operación**: `QueryCardTransaction`

- `Middleware/v2/BusinessServices/OSB/ConsultaCargosRecurrentesDiarios_v2/wsdl/ConsultaCargosRecurrentesDiarios_v2.wsdl`
  - **Función**: WSDL del business service v2

## XSD Schemas

### Esquemas Principales
- `Middleware/v2/Resources/ConsultaCargosRecurrentesDiarios/xsd/consultaCargosRecurrentesDiariosTypes.xsd`
  - **Función**: Definición de tipos de datos del servicio
  - **Elementos**: `consultaCargosRecurrentesDiarios`, `consultaCargosRecurrentesDiariosResponse`

### Esquemas Generales
- `Middleware/v2/Resources/esquemas_generales/HeaderElements.xsd`
  - **Función**: Definición de elementos de header (RequestHeader, ResponseHeader)
  - **Namespace**: `http://www.ficohsa.com.hn/middleware.services/autType`

### Esquemas de Business Services
- `Middleware/v2/BusinessServices/OSB/ConsultaCargosRecurrentesDiarios_v2/xsd/XMLSchema_-1153371529.xsd`
- `Middleware/v2/BusinessServices/OSB/ConsultaCargosRecurrentesDiarios_v2/xsd/XMLSchema_-1780208483.xsd`

## XQuery Transformations

### Transformaciones de Entrada
- `Middleware/v2/Resources/ConsultaCargosRecurrentesDiarios/xq/queryCardTransactionIn.xq`
  - **Función**: Transformar request OSB a formato VisaNet
  - **Input**: `consultaCargosRecurrentesDiarios` + parámetros de configuración
  - **Output**: `QueryCardTransaction` para VisaNet

### Transformaciones de Salida
- `Middleware/v2/Resources/ConsultaCargosRecurrentesDiarios/xq/consultaCargosRecurrentesDiariosOut.xq`
  - **Función**: Transformar response VisaNet a formato OSB
  - **Input**: `QueryCardTransactionResponse` de VisaNet
  - **Output**: `consultaCargosRecurrentesDiariosResponse`

- `Middleware/v2/Resources/ConsultaCargosRecurrentesDiarios/xq/consultaCargosRecurrentesDiariosHeaderOut.xq`
  - **Función**: Transformar header de respuesta VisaNet a OSB
  - **Input**: `QueryCardTransactionResponse` de VisaNet
  - **Output**: `ResponseHeader`

### Transformaciones Generales
- `Middleware/v2/Resources/Generales/xq/consultaRutaRegionalIn`
  - **Función**: Preparar request para consulta de ruta regional

- `Middleware/v2/Resources/Generales/xq/aplicarValoresPorDefectoRegion`
  - **Función**: Aplicar valores por defecto según región

- `Middleware/Business_Resources/general/Parametrizacion/obtenerParametrizacionIn`
  - **Función**: Preparar request para obtención de parámetros

### Transformaciones de Mapeo de Errores
- `Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageIn`
  - **Función**: Preparar request para mapeo de errores

- `Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageOut`
  - **Función**: Procesar response de mapeo de errores

## JAR Files

### Archivos de Despliegue
- `JAR/V.HN.MIGRACION.PROCESADOR/PG-5293/PRD/mwomnicanal_ConsultaCargosRecurrentesDiarios.jar`
  - **Función**: JAR de producción para Honduras

- `JAR/V.HN.MIGRACION.PROCESADOR/PG-5293/QA/mwomniqa_ConsultaCargosRecurrentesDiarios.jar`
  - **Función**: JAR de QA para Honduras

- `JAR/2018.9.29/PRD/ConsultaCargosRecurrentes_Diarios_Historicos.jar`
  - **Función**: JAR histórico relacionado

## Business Service Definitions

### Definiciones v2
- `Middleware/v2/BusinessServices/OSB/ConsultaCargosRecurrentesDiarios_v2/biz/ConsultaCargosRecurrentesDiarios_v2.biz`
  - **Función**: Definición del business service versión 2

## Archivos de Configuración

### Properties Files
- No se encontraron archivos .properties específicos en la estructura analizada

### Config Files
- No se encontraron archivos .config específicos en la estructura analizada

## Archivos de Políticas

### WS-Policy
- Las políticas se configuran a nivel de binding con modo `wsdl-policy-attachments`
- No se encontraron archivos de política específicos

## Tests Relevantes

### Archivos de Test
- No se encontraron archivos de test específicos en la estructura analizada

## Archivos Relacionados (Funcionalidad Similar)

### ConsultaCargosRecurrentesHistoricos
- `Middleware/v2/ProxyServices/ConsultaCargosRecurrentesHistoricos.proxy`
- `Middleware/v2/ProxyServices/ConsultaCargosRecurrentesHistoricosHN.proxy`
- `Middleware/v2/ProxyServices/ConsultaCargosRecurrentesHistoricosNI.proxy`
- `Middleware/v2/Resources/ConsultaCargosRecurrentesHistoricos/xq/conHistorialTxVnetHNIn.xq`
- `Middleware/v2/Resources/ConsultaCargosRecurrentesHistoricos/xq/conHistorialTxVnetIn.xq`
- `Middleware/v2/Resources/ConsultaCargosRecurrentesHistoricos/xq/consultaCargosRecurrentesHistoricosHNOut.xq`
- `Middleware/v2/Resources/ConsultaCargosRecurrentesHistoricos/xq/consultaCargosRecurrentesHistoricosOut.xq`

## Resumen de Archivos por Tipo

| Tipo de Archivo | Cantidad | Descripción |
|-----------------|----------|-------------|
| **Proxy Services** | 4 | 1 principal + 2 regionales + 1 external |
| **Business Services** | 4 | 2 VisaNet + 2 configuración |
| **WSDL Files** | 3 | 1 principal + 1 VisaNet + 1 business service |
| **XSD Schemas** | 5 | 1 principal + 1 general + 3 business service |
| **XQuery Files** | 8 | 3 específicos + 5 generales/mapeo errores |
| **JAR Files** | 3 | 2 migración + 1 histórico |
| **BIZ Files** | 3 | 2 VisaNet + 1 business service v2 |

## Dependencias Externas

### Servicios de Base de Datos
- **consultaRutaRegional_db**: Para enrutamiento regional
- **ObtenerParametrizacion**: Para configuración de parámetros VisaNet

### Servicios Web Externos
- **VisaNet Honduras**: `https://192.168.125.188/WSVisaTransaction.asmx`
- **VisaNet Nicaragua**: `https://192.168.125.16:9443/WSVisaTransaction.asmx`

### Servicios OSB Internos
- **MapeoErrores**: Para mapeo de códigos de error

## Notas de Verificación

Todos los archivos listados han sido verificados contra la estructura del repositorio. Las rutas son relativas desde el directorio base:
`ficohsa-capa-media/Fuentes/ficohsacore-osb-7e5cceccb837/`