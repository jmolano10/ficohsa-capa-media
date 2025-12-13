# Listado de Ficheros - ConsultaFondoPensiones

## Proxies

### Proxy Services
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/ProxyServices/ConsultaFondoPensiones.proxy`

## Business Services

### Servicios Externos FPC
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/FPC/getPensionFund12c/biz/getPensionFund12c.biz`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/FPC/getPensionFund12c/wsdl/GetPensionFund12c.wsdl`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/FPC/getPensionFund12c/xsd/CommonTypes.xsd`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/FPC/getPensionFund12c/xsd/GetPensionFundTypes.xsd`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/FPC/getPensionFund12c/xsd/HeaderElements.xsd`

### Servicios de Base de Datos (Alternativos)
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/ConsultaFondoPensiones/biz/consultaFondoPensiones_db.biz`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/ConsultaFondoPensiones/jca/consultaFondoPensiones_db.jca`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/ConsultaFondoPensiones/wsdl/consultaFondoPensiones.wsdl`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/ConsultaFondoPensiones/wsdl/consultaFondoPensiones_db.wsdl`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/ConsultaFondoPensiones/xsd/consultaFondoPensiones_sp.xsd`

### Servicios 12c Adicionales
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/ConsultaFondoPensiones12c/biz/consultaFondoPensiones12c.biz`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/ConsultaFondoPensiones12c/wsdl/GetAssetsCustomerSoap11gPS.wsdl`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/ConsultaFondoPensiones12c/xsd/CommonTypes.xsd`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/ConsultaFondoPensiones12c/xsd/GetAssetsCustomerTypes.xsd`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/ConsultaFondoPensiones12c/xsd/HeaderElements.xsd`

## Pipelines

### Pipelines Principales (dentro del Proxy)
- FPCHN_ConsultaFondoPensiones_request
- FPCHN_ConsultaFondoPensiones_response
- BranchDefault_request
- BranchDefault_response

### Error Handlers (dentro del Proxy)
- _onErrorHandler-2272574518598779679--1ce8c208.14cf191d759.-7cd1

## XQuery/XSLT

### Transformaciones Específicas de ConsultaFondoPensiones
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/ConsultaFondoPensiones/xq/getPensionFundIn.xq`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/ConsultaFondoPensiones/xq/consultaFondoPensionesHNOut.xq`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/ConsultaFondoPensiones/xq/getPensionFundHeaderIn.xq`

### Transformaciones Adicionales (No Utilizadas en HN02)
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/ConsultaFondoPensiones/xq/consultaFondoPensionesIn.xq`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/ConsultaFondoPensiones/xq/consultaFondoPensiones_FPCHNIn.xq`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/ConsultaFondoPensiones/xq/consultaFondoPensiones_FPCHNOut.xq`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/ConsultaFondoPensiones/xq/getAssetsCustomerHeaderIn.xq`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/ConsultaFondoPensiones/xq/getAssetsCustomerIn.xq`

### Transformaciones de Otros Servicios Relacionados
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/Business_Resources/consultasCliente/consultaActivosCliente/sjConsultaFondoPensiones.xq`

## Java Callouts

No se encontraron Java Callouts específicos para esta funcionalidad.

## POJOs

No se encontraron POJOs específicos para esta funcionalidad.

## Config

### Archivos de Configuración JCA
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/ConsultaFondoPensiones/jca/consultaFondoPensiones_db.jca`

### Archivos de Proyecto
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/.project`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/.settings/`

## Properties

### Archivos de Seguridad
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/Security/OSB12AUTH.sa`

## Policies

### Políticas de Seguridad (dentro del Proxy)
- Custom token authentication con usuario/contraseña
- WS-Policy con binding-mode: wsdl-policy-attachments
- HTTPS habilitado para conexiones entrantes

### Políticas de Monitoreo (dentro del Proxy)
- Monitoring deshabilitado a nivel de servicio
- Reporting habilitado
- Logging en nivel debug
- SLA Alerting habilitado
- Pipeline Alerting habilitado

## Tests

No se encontraron tests específicos para esta funcionalidad en la estructura analizada.

## XSD

### Esquemas Principales
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/ConsultaFondoPensiones/xsd/consultaFondoPensionesTypes.xsd`

### Esquemas de Servicios Externos
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/FPC/getPensionFund12c/xsd/GetPensionFundTypes.xsd`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/FPC/getPensionFund12c/xsd/CommonTypes.xsd`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/FPC/getPensionFund12c/xsd/HeaderElements.xsd`

### Esquemas de Base de Datos
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/ConsultaFondoPensiones/xsd/consultaFondoPensiones_sp.xsd`

### Esquemas de Servicios 12c
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/ConsultaFondoPensiones12c/xsd/GetAssetsCustomerTypes.xsd`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/ConsultaFondoPensiones12c/xsd/CommonTypes.xsd`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/ConsultaFondoPensiones12c/xsd/HeaderElements.xsd`

### Esquemas Generales
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/esquemas_generales/HeaderElements.xsd`

## WSDL

### WSDL Principales
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/ConsultaFondoPensiones/wsdl/consultaFondoPensionesPS.wsdl`

### WSDL de Business Services
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/FPC/getPensionFund12c/wsdl/GetPensionFund12c.wsdl`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/ConsultaFondoPensiones/wsdl/consultaFondoPensiones.wsdl`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/ConsultaFondoPensiones/wsdl/consultaFondoPensiones_db.wsdl`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/ConsultaFondoPensiones12c/wsdl/GetAssetsCustomerSoap11gPS.wsdl`

## JAR

### Archivos JAR Relacionados
- `Fuentes/ficohsacore-osb-7e5cceccb837/JAR/PG-13516/PRD/mwapp_ConsultaFondoPensiones.jar`
- `Fuentes/ficohsacore-osb-7e5cceccb837/JAR/PG-13516/PRD/mwinterbanca_ConsultaFondoPensiones.jar`
- `Fuentes/ficohsacore-osb-7e5cceccb837/JAR/PG-13516/QA/soabus_ConsultaFondoPensiones.jar`

## Servicios Relacionados (No Utilizados Directamente)

### Otros Proxies de Fondos de Pensiones
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/ProxyServices/ConsultaFondosPensionesCliente.proxy`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/ProxyServices/ConsultaFondosPensionesClienteHN.proxy`

### Business Services Adicionales
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/FPC/consultaFondosPensionesCliente/`

### Recursos Adicionales
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/ConsultaFondosPensionesCliente/`

## Archivos OSB12 (Versión Anterior)

### Servicios en OSB12
- `Fuentes/ficohsacore-osb12-b78f21b126d5/CoreBankingHN/ProviderServices/JCA/GetCustomerProducts/consultaFondoPensiones_db.jca`
- `Fuentes/ficohsacore-osb12-b78f21b126d5/CoreBankingHN/ProviderServices/WSDL/GetCustomerProducts/consultaFondoPensiones.wsdl`
- `Fuentes/ficohsacore-osb12-b78f21b126d5/CoreBankingHN/ProviderServices/WSDL/GetCustomerProducts/consultaFondoPensiones_db.wsdl`
- `Fuentes/ficohsacore-osb12-b78f21b126d5/CoreBankingHN/ProviderServices/XSD/GetCustomerProducts/consultaFondoPensiones_sp.xsd`

### Transformaciones OSB12
- `Fuentes/ficohsacore-osb12-b78f21b126d5/CoreBankingHN/RequestorServices/ProxyServices/v1.0/GetCustomerAssets/XQ/ConsultaPensionesIn.xqy`
- `Fuentes/ficohsacore-osb12-b78f21b126d5/CoreBankingHN/RequestorServices/ProxyServices/v1.0/GetCustomerAssets/XQ/ConsultaPensionesOut.xqy`

## Resumen de Archivos por Categoría

| Categoría | Cantidad | Descripción |
|-----------|----------|-------------|
| **Proxies** | 1 | Servicio principal |
| **Business Services** | 10 | Servicios externos y BD |
| **XQuery** | 8 | Transformaciones de datos |
| **XSD** | 9 | Esquemas de validación |
| **WSDL** | 6 | Contratos de servicios |
| **JCA** | 2 | Configuración de adaptadores BD |
| **Security** | 1 | Archivos de credenciales |
| **JAR** | 3 | Artefactos compilados |
| **OSB12 Legacy** | 6 | Archivos de versión anterior |

**Total de archivos relevantes**: 46 archivos

## Dependencias Externas Identificadas

1. **Servicio Dynamo**: https://dynamoosbdev:8004 (Crítico)
2. **Almacén de Credenciales**: OSB12AUTH para autenticación
3. **Certificados HTTPS**: Para conexiones seguras
4. **Servicios de Base de Datos**: Como alternativa (no utilizados en HN02)

## Archivos Críticos para HN02

### Imprescindibles
1. `ConsultaFondoPensiones.proxy` - Servicio principal
2. `getPensionFund12c.biz` - Conexión al servicio externo
3. `getPensionFundIn.xq` - Transformación de entrada
4. `consultaFondoPensionesHNOut.xq` - Transformación de salida
5. `getPensionFundHeaderIn.xq` - Configuración de credenciales
6. `consultaFondoPensionesTypes.xsd` - Esquema principal
7. `GetPensionFund12c.wsdl` - Contrato del servicio externo

### Opcionales/Alternativos
- Servicios de base de datos (no utilizados actualmente)
- Transformaciones adicionales (para otros flujos)
- Archivos OSB12 (versión legacy)