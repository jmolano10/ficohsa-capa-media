# Listado de Ficheros - PagoDGI

## Proxy Services

### Proxy Principal
- `Middleware/v2/ProxyServices/PagoDGI.proxy`

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
- `Middleware/v2/Resources/PagoDGI/xq/pagoDGIIn.xq`
- `Middleware/v2/Resources/PagoDGI/xq/pagoDGIOut.xq`
- `Middleware/v2/Resources/PagoDGI/xq/pagoDGIHeaderOut.xq`

### Transformaciones de Validación y Error
- `Middleware/v2/Resources/Generales/xq/validaServicioRegionalIn`
- `Middleware/v2/Resources/Generales/xq/aplicarValoresPorDefectoRegion`
- `Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageIn`
- `Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageOut`
- `Middleware/Business_Resources/general/Parametrizacion/obtenerParametrizacionIn`

## WSDL y XSD

### WSDL Principal
- `Middleware/v2/Resources/PagoDGI/wsdl/pagoDGIPS.wsdl`

### XSD de Tipos
- `Middleware/v2/Resources/PagoDGI/xsd/pagoDGITypes.xsd`
- `Middleware/v2/Resources/esquemas_generales/HeaderElements.xsd`

### XSD CTS COBIS (NI01)
- `Middleware/v2/BusinessServices/CTS/impuesto/xsd/services.xsd`
- `Middleware/v2/BusinessServices/CTS/impuesto/xsd/cobiscorp.ecobis.srvaplcobisentidades.dto.xsd`
- `Middleware/v2/BusinessServices/CTS/impuesto/xsd/commonDTO1.xsd`
- `Middleware/v2/BusinessServices/CTS/impuesto/xsd/commonDTO2.xsd`

## Archivos de Configuración

### Parametrización Nicaragua (4 Parámetros)
- Parámetro: `FICBCO0257.CAJADGI`
- Parámetro: `FICBCO0257.FORMAPAGODGI`
- Parámetro: `FICBCO0256.CODIGOBANCODGI` (compartido con ConsultaDGI)
- Parámetro: `FICBCO0257.TIPOIMPUESTODGI`

### Configuración CTS COBIS
- Endpoint: `http://10.235.53.149:9080/GerenciaCobisImpuestos/SrvAplCobisImpuestosService`
- Protocolo: SOAP 1.2
- Timeout: 0 (sin límite)
- Retry: 0 (sin reintentos)

## JAR de Despliegue

### Archivos de Despliegue
- `JAR/2018.7.2.0/PRD/PG-130_PagoDGI_mwomnicanal.jar`
- `JAR/2018.7.2.0/QA/PG-130_PagoDGI_mwomniqa.jar`
- `JAR/2018.7.2.0/QA/PG-130_PagoDGI_mwomniqa2.jar`
- `JAR/2018.7.2.0/QA/PG-130_PagoDGI_soabus2.jar`

## Directorios de Recursos

### Recursos Principales
- `Middleware/v2/Resources/PagoDGI/` (directorio principal)
- `Middleware/v2/Resources/PagoDGI/wsdl/` (definiciones WSDL)
- `Middleware/v2/Resources/PagoDGI/xq/` (transformaciones XQuery)
- `Middleware/v2/Resources/PagoDGI/xsd/` (esquemas XSD)

### Recursos CTS COBIS (Compartidos con ConsultaDGI)
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
   - Operación: `OpPagoDGI`

2. **Sistema DGI Nicaragua** (a través de CTS)
   - Procesamiento real de pagos
   - Generación de códigos SIF
   - Registro de transacciones fiscales

### Servicios OSB Auxiliares
1. **ValidaServicioRegional**
   - Validación de disponibilidad por región
   - Service ID: FICBCO0257

2. **MapeoErrores**
   - Mapeo centralizado de errores
   - Prefijo: FICBCO0257

3. **ObtenerParametrizacion**
   - Configuración de 4 parámetros DGI
   - Parámetros requeridos para NI01

## Archivos Específicos por Región

### NI01 (Nicaragua)
**Business Services:**
- `impuesto.biz` - Configuración CTS COBIS
- `COBISCorp.eCOBIS.SrvAplCobisImpuestos.Service.wsdl` - WSDL CTS

**Transformaciones:**
- `pagoDGIIn.xq` - Mapeo OSB → CTS + cálculos
- `pagoDGIOut.xq` - Mapeo CTS → OSB + redondeo
- `pagoDGIHeaderOut.xq` - Procesamiento headers + transactionId

**Esquemas:**
- `services.xsd` - Validación requests CTS
- `cobiscorp.ecobis.srvaplcobisentidades.dto.xsd` - DTOs COBIS
- `commonDTO1.xsd` - DTOs comunes COBIS
- `commonDTO2.xsd` - DTOs comunes COBIS

**Configuración:**
- 4 Parámetros: CAJADGI, FORMAPAGODGI, CODIGOBANCODGI, TIPOIMPUESTODGI
- Endpoint CTS: `10.235.53.149:9080`

### Otras Regiones (Default)
**Archivos utilizados:**
- Solo archivos de validación general
- Sin business services específicos
- Sin transformaciones específicas
- Error MW-0008 directo

## Archivos Comunes a Todas las Regiones

### Validaciones Generales
- `pagoDGITypes.xsd` - Validación entrada OSB (12 campos)
- `HeaderElements.xsd` - Validación headers
- `validaServicioRegionalIn` - Validación regional
- `aplicarValoresPorDefectoRegion` - Normalización headers

### Manejo de Errores
- `mapeoErroresUsageIn` - Preparación errores
- `mapeoErroresUsageOut` - Formateo errores

### Configuración Base
- `pagoDGIPS.wsdl` - Contrato SOAP principal
- `PagoDGI.proxy` - Configuración proxy

## Patrones de Archivos

### Patrón de Transformaciones (NI01)
```
pagoDGI{Sufijo}.xq
- pagoDGIIn.xq (entrada + cálculos)
- pagoDGIOut.xq (salida + redondeo)  
- pagoDGIHeaderOut.xq (headers + transactionId)
```

### Patrón de Esquemas CTS (Compartido con ConsultaDGI)
```
{namespace}.xsd
- services.xsd (operaciones)
- cobiscorp.ecobis.srvaplcobisentidades.dto.xsd (entidades)
- commonDTO1.xsd (comunes)
- commonDTO2.xsd (comunes)
```

### Patrón de Business Services
```
CTS/impuesto/
- biz/ (configuración)
- wsdl/ (contratos)
- xsd/ (esquemas)
```

## Funciones Específicas de PagoDGI

### Funciones XQuery Personalizadas
**Archivo**: `pagoDGIIn.xq`

```xquery
declare function obtenerIndicadorPago($valTotal as xs:decimal, $valPago as xs:decimal) as xs:string
```
- **Propósito**: Calcular si el pago es completo o parcial
- **Lógica**: Comparación matemática de montos
- **Retorno**: "1" (completo) o "2" (parcial)

### Funciones de Timestamp
- `fn:adjust-dateTime-to-timezone(current-dateTime(),())` - Fecha actual
- `fn-bea:dateTime-to-string-with-format("HH:mm:ss", current-dateTime())` - Hora actual

### Funciones de Redondeo
- `round-half-to-even(data($pagoDGIRequest/PAYMENT_AMOUNT), 2)` - Redondeo bancario

## Archivos No Encontrados (Otras Regiones)

Para implementar PagoDGI en otras regiones se necesitarían:

### Honduras (HN01)
- `pagoDGIHNIn.xq`
- `pagoDGIHNOut.xq`
- Business service SAR Honduras
- Esquemas fiscales Honduras
- 4+ parámetros de configuración

### Guatemala (GT01)
- `pagoDGIGTIn.xq`
- `pagoDGIGTOut.xq`
- Business service SAT Guatemala
- Esquemas fiscales Guatemala
- 4+ parámetros de configuración

### Panamá (PA01)
- `pagoDGIPAIn.xq`
- `pagoDGIPAOut.xq`
- Business service DGI Panamá
- Esquemas fiscales Panamá
- 4+ parámetros de configuración

## Comparación con ConsultaDGI

### Archivos Compartidos
- Business Service CTS: `impuesto.biz`
- Esquemas CTS: `services.xsd`, DTOs COBIS
- Servicios auxiliares: ValidaServicioRegional, MapeoErrores, ObtenerParametrizacion

### Archivos Específicos de PagoDGI
- `pagoDGITypes.xsd` (12 campos vs 2 en ConsultaDGI)
- `pagoDGIIn.xq` (con función de cálculo)
- `pagoDGIOut.xq` (con redondeo y combinación)
- `pagoDGIHeaderOut.xq` (con transactionId)

### Diferencias Clave
| Aspecto | ConsultaDGI | PagoDGI |
|---------|-------------|---------|
| **Archivos XQuery** | 3 archivos | 3 archivos |
| **Complejidad XQuery** | Mapeo directo | Cálculos + timestamps |
| **Parámetros config** | 2 parámetros | 4 parámetros |
| **Campos XSD** | 2 campos | 12 campos |
| **Operación CTS** | OpConsultaDGI | OpPagoDGI |
| **Transaccionalidad** | Solo lectura | Transaccional |
| **Campos únicos** | 9 campos fiscales | SIF_CODE + transactionId |
| **Riesgo** | Bajo | Alto (pagos reales) |

## Infraestructura Requerida

### Para NI01 (Implementado)
1. **Conexión CTS COBIS**: HTTP/SOAP 1.2
2. **Base de datos parametrización**: OSB Config DB
3. **Sistema DGI**: A través de CTS COBIS

### Para Otras Regiones (No Implementado)
1. **Sistemas fiscales locales**: SAR, SAT, DGI local
2. **Adaptadores específicos**: DB o Web Service
3. **Configuración regional**: Mínimo 4 parámetros
4. **Esquemas locales**: XSD específicos por país
5. **Transformaciones**: XQuery con lógica de negocio local

## Archivos de Auditoría y Monitoreo

### Configuración de Logging
- **Logging Level**: Debug (habilitado)
- **Pipeline Monitoring**: Pipeline level
- **SLA Alerting**: Normal level
- **Pipeline Alerting**: Normal level

### JAR de Auditoría
- Archivos JAR contienen configuración de despliegue
- Separación PRD/QA para control de cambios
- Versionado por fecha (2018.7.2.0)

## Consideraciones de Seguridad

### Autenticación
- **Custom Token Authentication**: Usuario/Password en header
- **HTTPS**: Protocolo seguro obligatorio
- **Credenciales**: Validación en cada request

### Transaccionalidad
- **Pagos reales**: Transacciones financieras irreversibles
- **Auditoría**: Logging completo de transacciones
- **Comprobantes**: Generación de SIF para auditoría fiscal

### Validaciones
- **XSD estricta**: 12 campos obligatorios
- **Esquema CTS**: Validación antes de envío
- **Parametrización**: Configuración segura de parámetros