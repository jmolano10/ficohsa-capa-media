# Listado de Ficheros - ConsultaTransaccionSwitch

## Proxy Services

### Principal
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/ProxyServices/ConsultaTransaccionSwitch.proxy`
  - **Descripción:** Proxy service principal que expone el servicio ConsultaTransaccionSwitch
  - **URI:** `/Middleware/OperationsAndExecution/CustomerDeposits/ConsultaTransaccionSwitch_v2`
  - **Protocolo:** SOAP/HTTPS
  - **Región:** HN01 implementada, otras no implementadas

### Versión Anterior (Referencia)
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/OperationsAndExecution/CustomerDeposits/ConsultaTransaccionSwitch.proxy`
  - **Descripción:** Versión anterior del proxy (posiblemente v1)

### Proxy Externo (Referencia)
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/External/Incoming/v2/ProxyServices/ConsultaTransaccionSwitch.proxy`
  - **Descripción:** Proxy en módulo External/Incoming

## Business Services

### Validación Regional
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/ValidaServicioRegional/biz/ValidaServicioRegional_db.biz`
  - **Descripción:** Business service para validar habilitación regional del servicio
  - **Tipo:** Database Adapter (JCA)
  - **Stored Procedure:** MW_P_VALIDA_SERVICIO_REGIONAL

- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/ValidaServicioRegional/jca/ValidaServicioRegional_db.jca`
  - **Descripción:** Configuración JCA del adapter de base de datos

- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/ValidaServicioRegional/wsdl/ValidaServicioRegional_db.wsdl`
  - **Descripción:** WSDL del servicio de validación regional

- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/ValidaServicioRegional/wsdl/ValidaServicioRegional.wsdl`
  - **Descripción:** WSDL base del servicio

- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/ValidaServicioRegional/xsd/ValidaServicioRegional_sp.xsd`
  - **Descripción:** XSD con definición de parámetros del stored procedure

### Consulta T24
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/Business_Resources/consultaTransacciones/Resources/consultasTransacciones.biz`
  - **Descripción:** Business service para consultar transacciones en T24
  - **Tipo:** SOAP Web Service
  - **Operación:** Consultadetransaccionswitch
  - **Endpoints:** 4 endpoints load-balanced

- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/Business_Resources/consultaTransacciones/Resources/consultasTransacciones.wsdl`
  - **Descripción:** WSDL del servicio T24 de consultas de transacciones

- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/Business_Resources/consultaTransacciones/Resources/XMLSchema_-1217682313.xsd`
  - **Descripción:** XSD con definición de tipos de datos T24 (WSSWITCHTRANSACTIONType)

- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/Business_Resources/consultaTransacciones/Resources/XMLSchema_-928942080.xsd`
  - **Descripción:** XSD adicional para tipos T24

- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/Business_Resources/consultaTransacciones/Resources/XMLSchema_-924279306.xsd`
  - **Descripción:** XSD adicional para tipos T24

### Business Service Externo (Referencia)
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/External/Incoming/v2/BusinessServices/ConsultaTransaccionSwitch/biz/ConsultaTransaccionSwitch.biz`
  - **Descripción:** Business service en módulo External

- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/External/Incoming/v2/BusinessServices/ConsultaTransaccionSwitch/wsdl/consultaTransaccionSwitchPS.wsdl`
  - **Descripción:** WSDL en módulo External

- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/External/Incoming/v2/BusinessServices/ConsultaTransaccionSwitch/xsd/consultaTransaccionSwitchTypes.xsd`
  - **Descripción:** XSD en módulo External

## Pipelines

Los pipelines están definidos dentro del archivo proxy principal:
- **ValidacionesGenerales_request:** Validación XSD y regional
- **ValidacionesGenerales_response:** Mapeo de errores
- **ConsultaTxnHND_request:** Consulta para HN01
- **ConsultaTxnHND_response:** Procesamiento de respuesta HN01
- **Default_ConsultatxnSwitch_request:** Pipeline por defecto (vacío)
- **Default_ConsultatxnSwitch_response:** Retorna error MW-0008
- **_onErrorHandler:** Manejo de errores generales

## XQuery Transformations

### Específicos de HN01
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/ConsultaTransaccionSwitch/xq/consultaTransaccionSwitchHNIn.xq`
  - **Descripción:** Transformación de request OSB a formato T24 para HN01
  - **Funciones:** getUsername(), getPassword() para LDAP lookup

- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/ConsultaTransaccionSwitch/xq/consultaTransaccionSwitchHNOut.xq`
  - **Descripción:** Transformación de response T24 a formato OSB para HN01
  - **Mapeo:** 12 campos de WSSWITCHTRANSACTIONType a consultaTransaccionSwitchResponse

- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/ConsultaTransaccionSwitch/xq/consultaTransaccionSwitchHOut.xq`
  - **Descripción:** Construcción del ResponseHeader
  - **Parámetros:** Message, Error

### Generales (Compartidos)
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/Generales/xq/validaServicioRegionalIn.xq`
  - **Descripción:** Construcción de request para validación regional
  - **Uso:** Todos los servicios que requieren validación regional

- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/Generales/xq/aplicarValoresPorDefectoRegion.xq`
  - **Descripción:** Aplicar valores por defecto a región (HN01 si vacío)
  - **Uso:** Normalización de headers de región

- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageIn.xq`
  - **Descripción:** Preparar request para servicio de mapeo de errores
  - **Uso:** Homologación de códigos de error

- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageOut.xq`
  - **Descripción:** Procesar response de mapeo de errores
  - **Uso:** Actualizar ResponseHeader con error homologado

### Versión Anterior (Referencia)
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/Business_Resources/consultaTransacciones/ConsultaTransaccionSwitch/consultaTransaccionSwitchIn.xq`
  - **Descripción:** Transformación de entrada versión anterior

- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/Business_Resources/consultaTransacciones/ConsultaTransaccionSwitch/consultaTransaccionSwitchOut.xq`
  - **Descripción:** Transformación de salida versión anterior

- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/Business_Resources/consultaTransacciones/ConsultaTransaccionSwitch/consultaTransaccionSwitchHeaderOut.xq`
  - **Descripción:** Construcción de header versión anterior

## WSDL

### Principal
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/ConsultaTransaccionSwitch/wsdl/consultaTransaccionSwitchPS.wsdl`
  - **Descripción:** WSDL del proxy service ConsultaTransaccionSwitch
  - **Namespace:** http://www.ficohsa.com.hn/middleware.services/consultaTransaccionSwitchPS/
  - **Port:** consultaTransaccionSwitchPSSOAP
  - **Operación:** consultaTransaccionSwitch

### Versión Anterior (Referencia)
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/Business_Resources/consultaTransacciones/ConsultaTransaccionSwitch/consultaTransaccionSwitchPS.wsdl`
  - **Descripción:** WSDL versión anterior

## XSD (Esquemas)

### Principal
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/ConsultaTransaccionSwitch/xsd/consultaTransaccionSwitchTypes.xsd`
  - **Descripción:** Definición de tipos de datos del servicio OSB
  - **Namespace:** http://www.ficohsa.com.hn/middleware.services/consultaTransaccionSwitchTypes
  - **Elementos:** consultaTransaccionSwitch (request), consultaTransaccionSwitchResponse (response)

### Versión Anterior (Referencia)
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/Business_Resources/consultaTransacciones/ConsultaTransaccionSwitch/consultaTransaccionSwitchTypes.xsd`
  - **Descripción:** XSD versión anterior

### Esquemas Generales
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/esquemas_generales/HeaderElements.xsd`
  - **Descripción:** Definición de RequestHeader y ResponseHeader
  - **Namespace:** http://www.ficohsa.com.hn/middleware.services/autType
  - **Uso:** Todos los servicios OSB

## Configuración

### Políticas OSB
No hay archivos de políticas específicos. Las políticas se configuran en el proxy:
- Binding mode: wsdl-policy-attachments
- Sin políticas WS-Security configuradas

### Properties
No se encontraron archivos .properties específicos para este servicio.
La configuración se realiza mediante:
- Endpoints en archivos .biz
- Credenciales LDAP en servidor OSB
- Connection pools en servidor WebLogic

## Tests

No se encontraron archivos de test específicos en el repositorio para este servicio.

## JAR (Hotfixes/Releases)

No se encontraron JARs específicos para ConsultaTransaccionSwitch en el repositorio.

## Documentación

No se encontró documentación preexistente para este servicio en el repositorio.

## Resumen de Archivos por Categoría

### Archivos Críticos (Producción Activa)
1. `Middleware/v2/ProxyServices/ConsultaTransaccionSwitch.proxy` - Proxy principal
2. `Middleware/v2/Resources/ConsultaTransaccionSwitch/xq/consultaTransaccionSwitchHNIn.xq` - Transform IN
3. `Middleware/v2/Resources/ConsultaTransaccionSwitch/xq/consultaTransaccionSwitchHNOut.xq` - Transform OUT
4. `Middleware/v2/Resources/ConsultaTransaccionSwitch/xq/consultaTransaccionSwitchHOut.xq` - Header OUT
5. `Middleware/v2/Resources/ConsultaTransaccionSwitch/wsdl/consultaTransaccionSwitchPS.wsdl` - Contrato WSDL
6. `Middleware/v2/Resources/ConsultaTransaccionSwitch/xsd/consultaTransaccionSwitchTypes.xsd` - Tipos de datos
7. `Middleware/v2/BusinessServices/ValidaServicioRegional/biz/ValidaServicioRegional_db.biz` - Validación regional
8. `Middleware/Business_Resources/consultaTransacciones/Resources/consultasTransacciones.biz` - Conexión T24

### Archivos de Soporte
9. `Middleware/v2/Resources/Generales/xq/validaServicioRegionalIn.xq` - Validación regional
10. `Middleware/v2/Resources/Generales/xq/aplicarValoresPorDefectoRegion.xq` - Defaults región
11. `Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageIn.xq` - Mapeo errores IN
12. `Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageOut.xq` - Mapeo errores OUT

### Archivos de Referencia (Versiones Anteriores)
13. `Middleware/OperationsAndExecution/CustomerDeposits/ConsultaTransaccionSwitch.proxy` - Proxy v1
14. `Middleware/Business_Resources/consultaTransacciones/ConsultaTransaccionSwitch/*.xq` - Transforms v1
15. `Middleware/Business_Resources/consultaTransacciones/ConsultaTransaccionSwitch/*.wsdl` - WSDL v1
16. `Middleware/Business_Resources/consultaTransacciones/ConsultaTransaccionSwitch/*.xsd` - XSD v1

### Archivos Externos (Posible Integración)
17. `Middleware/External/Incoming/v2/ProxyServices/ConsultaTransaccionSwitch.proxy` - Proxy externo
18. `Middleware/External/Incoming/v2/BusinessServices/ConsultaTransaccionSwitch/biz/ConsultaTransaccionSwitch.biz` - BS externo

**Total de archivos identificados:** 18+ archivos principales más dependencias compartidas

## Dependencias Externas al Repositorio

### Configuración en Servidor OSB
- Credenciales LDAP: `Middleware/Security/{USERNAME}`
- Connection Pool: `eis/DB/ConnectionMiddleware`

### Servicios Externos
- T24 Web Services (4 endpoints)
- Oracle Database (Middleware)
- Proxy MapeoErrores (interno OSB)

### Librerías OSB
- fn-bea:lookupBasicCredentials (función OSB)
- fn-bea:fail-over (función OSB)
- JCA Database Adapter
- SOAP Transport
