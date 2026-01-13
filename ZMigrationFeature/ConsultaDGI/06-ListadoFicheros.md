# Listado de Ficheros - ConsultaDGI

## Proxy Services

### Proxy Principal
- `Middleware/v2/ProxyServices/ConsultaDGI.proxy`

## Business Services

### NI01 (Nicaragua - CTS COBIS)
- `Middleware/v2/BusinessServices/CTS/impuesto/biz/impuesto.biz`
- `Middleware/v2/BusinessServices/CTS/impuesto/wsdl/COBISCorp.eCOBIS.SrvAplCobisImpuestos.Service.wsdl`
- `Middleware/v2/BusinessServices/CTS/impuesto/xsd/cobiscorp.ecobis.srvaplcobisentidades.dto.xsd`
- `Middleware/v2/BusinessServices/CTS/impuesto/xsd/commonDTO1.xsd`
- `Middleware/v2/BusinessServices/CTS/impuesto/xsd/commonDTO2.xsd`
- `Middleware/v2/BusinessServices/CTS/impuesto/xsd/services.xsd`

### Servicios Auxiliares
- `Middleware/v2/BusinessServices/ValidaServicioRegional/biz/ValidaServicioRegional_db`
- `Middleware/v2/ProxyServices/MapeoErrores`
- `Middleware/Business_Resources/general/Resources/ObtenerParametrizacion/ObtenerParametrizacion`

## Transformaciones XQuery

### Transformaciones Principales (NI01)
- `Middleware/v2/Resources/ConsultaDGI/xq/consultaDGIIn.xq`
- `Middleware/v2/Resources/ConsultaDGI/xq/consultaDGIOut.xq`
- `Middleware/v2/Resources/ConsultaDGI/xq/consultaDGIHeaderOut.xq`

### Transformaciones de Validación y Error
- `Middleware/v2/Resources/Generales/xq/validaServicioRegionalIn`
- `Middleware/v2/Resources/Generales/xq/aplicarValoresPorDefectoRegion`
- `Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageIn`
- `Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageOut`
- `Middleware/Business_Resources/general/Parametrizacion/obtenerParametrizacionIn`

## WSDL y XSD

### WSDL Principal
- `Middleware/v2/Resources/ConsultaDGI/wsdl/consultaDGIPS.wsdl`

### XSD de Tipos
- `Middleware/v2/Resources/ConsultaDGI/xsd/consultaDGITypes.xsd`
- `Middleware/v2/Resources/esquemas_generales/HeaderElements.xsd`

### XSD CTS COBIS (NI01)
- `Middleware/v2/BusinessServices/CTS/impuesto/xsd/services.xsd`
- `Middleware/v2/BusinessServices/CTS/impuesto/xsd/cobiscorp.ecobis.srvaplcobisentidades.dto.xsd`
- `Middleware/v2/BusinessServices/CTS/impuesto/xsd/commonDTO1.xsd`
- `Middleware/v2/BusinessServices/CTS/impuesto/xsd/commonDTO2.xsd`

## Archivos de Configuración

### Parametrización Nicaragua
- Parámetro: `FICBCO0256.TIPOCONSULTADGI`
- Parámetro: `FICBCO0256.CODIGOBANCODGI`

### Configuración CTS COBIS
- Endpoint: `http://10.235.53.149:9080/GerenciaCobisImpuestos/SrvAplCobisImpuestosService`
- Protocolo: SOAP 1.2
- Timeout: 0 (sin límite)
- Retry: 0 (sin reintentos)

## JAR de Despliegue

### Archivos de Despliegue
- `JAR/2018.7.2.0/PRD/PG-130_ConsultaDGI_mwomnicanal.jar`
- `JAR/2018.7.2.0/QA/PG-130_ConsultaDGI_mwomniqa.jar`
- `JAR/2018.7.2.0/QA/PG-130_ConsultaDGI_mwomniqa2.jar`
- `JAR/2018.7.2.0/QA/PG-130_ConsultaDGI_soabus2.jar`

## Directorios de Recursos

### Recursos Principales
- `Middleware/v2/Resources/ConsultaDGI/` (directorio principal)
- `Middleware/v2/Resources/ConsultaDGI/wsdl/` (definiciones WSDL)
- `Middleware/v2/Resources/ConsultaDGI/xq/` (transformaciones XQuery)
- `Middleware/v2/Resources/ConsultaDGI/xsd/` (esquemas XSD)

### Recursos CTS COBIS
- `Middleware/v2/BusinessServices/CTS/impuesto/` (directorio principal)
- `Middleware/v2/BusinessServices/CTS/impuesto/biz/` (business services)
- `Middleware/v2/BusinessServices/CTS/impuesto/wsdl/` (WSDL CTS)
- `Middleware/v2/BusinessServices/CTS/impuesto/xsd/` (esquemas CTS)

## Resumen de Archivos por Tipo

| Tipo de Archivo | Cantidad | Descripción |
|-----------------|----------|-------------|
| Proxy Services | 1 | Servicio proxy principal |
| Business Services | 4 | CTS COBIS + servicios auxiliares |
| XQuery Files | 8 | Transformaciones de entrada, salida y auxiliares |
| WSDL Files | 2 | Definición principal + CTS COBIS |
| XSD Files | 7 | Esquemas OSB + esquemas CTS |
| JAR Files | 4 | Archivos de despliegue |
| Directorios | 6 | Estructura de recursos |

**Total de archivos identificados: 32 archivos**

## Dependencias Externas

### Sistemas Backend
1. **CTS COBIS Impuestos** (NI01)
   - Endpoint: `http://10.235.53.149:9080/GerenciaCobisImpuestos/SrvAplCobisImpuestosService`
   - Protocolo: SOAP 1.2
   - Operación: `OpConsultaDGI`

### Servicios OSB Auxiliares
1. **ValidaServicioRegional**
   - Validación de disponibilidad por región
   - Service ID: FICBCO0256

2. **MapeoErrores**
   - Mapeo centralizado de errores
   - Prefijo: FICBCO0256

3. **ObtenerParametrizacion**
   - Configuración de parámetros DGI
   - Parámetros requeridos para NI01

## Archivos Específicos por Región

### NI01 (Nicaragua)
**Business Services:**
- `impuesto.biz` - Configuración CTS COBIS
- `COBISCorp.eCOBIS.SrvAplCobisImpuestos.Service.wsdl` - WSDL CTS

**Transformaciones:**
- `consultaDGIIn.xq` - Mapeo OSB → CTS
- `consultaDGIOut.xq` - Mapeo CTS → OSB  
- `consultaDGIHeaderOut.xq` - Procesamiento headers CTS

**Esquemas:**
- `services.xsd` - Validación requests CTS
- `cobiscorp.ecobis.srvaplcobisentidades.dto.xsd` - DTOs COBIS
- `commonDTO1.xsd` - DTOs comunes COBIS
- `commonDTO2.xsd` - DTOs comunes COBIS

**Configuración:**
- Parámetros: `FICBCO0256.TIPOCONSULTADGI`, `FICBCO0256.CODIGOBANCODGI`
- Endpoint CTS: `10.235.53.149:9080`

### Otras Regiones (Default)
**Archivos utilizados:**
- Solo archivos de validación general
- Sin business services específicos
- Sin transformaciones específicas
- Error MW-0008 directo

## Archivos Comunes a Todas las Regiones

### Validaciones Generales
- `consultaDGITypes.xsd` - Validación entrada OSB
- `HeaderElements.xsd` - Validación headers
- `validaServicioRegionalIn` - Validación regional
- `aplicarValoresPorDefectoRegion` - Normalización headers

### Manejo de Errores
- `mapeoErroresUsageIn` - Preparación errores
- `mapeoErroresUsageOut` - Formateo errores

### Configuración Base
- `consultaDGIPS.wsdl` - Contrato SOAP principal
- `ConsultaDGI.proxy` - Configuración proxy

## Patrones de Archivos

### Patrón de Transformaciones (NI01)
```
consultaDGI{Sufijo}.xq
- consultaDGIIn.xq (entrada)
- consultaDGIOut.xq (salida)  
- consultaDGIHeaderOut.xq (headers)
```

### Patrón de Esquemas CTS
```
{namespace}.xsd
- services.xsd (operaciones)
- cobiscorp.ecobis.srvaplcobisentidades.dto.xsd (entidades)
- commonDTO1.xsd (comunes)
- commonDTO2.xsd (comunes)
```

### Patrón de Business Services
```
{region}/{servicio}/
- biz/ (configuración)
- wsdl/ (contratos)
- xsd/ (esquemas)
```

## Archivos No Encontrados (Otras Regiones)

Para implementar ConsultaDGI en otras regiones se necesitarían:

### Honduras (HN01)
- `consultaDGIHNIn.xq`
- `consultaDGIHNOut.xq`
- Business service SAR Honduras
- Esquemas fiscales Honduras

### Guatemala (GT01)
- `consultaDGIGTIn.xq`
- `consultaDGIGTOut.xq`
- Business service SAT Guatemala
- Esquemas fiscales Guatemala

### Panamá (PA01)
- `consultaDGIPAIn.xq`
- `consultaDGIPAOut.xq`
- Business service DGI Panamá
- Esquemas fiscales Panamá