# Listado de Ficheros - ConsultaEstadoLote

## Proxy Services

### Principal
- `Middleware/v2/ProxyServices/ConsultaEstadoLote.proxy`
- `Middleware/v2/ProxyServices/ConsultaEstadoLote.pipeline`

### Alternativo (MWHostToHost)
- `MWHostToHost/v1/ProxyServices/ConsultaEstadoLote.proxy`
- `MWHostToHost/v1/ProxyServices/ConsultaEstadoLote.pipeline`

### Relacionados (Billetera)
- `Middleware/v2/ProxyServices/ConsultaEstadoLoteBilletera.proxy`
- `Middleware/v2/ProxyServices/ConsultaEstadoLoteBilletera.pipeline`

---

## Business Services

### HN01 - Base de Datos

#### consultarEstadoLote (PMSV)
- `Middleware/v2/BusinessServices/PMSV/consultaEstadoLote/biz/consultarEstadoLote_db.bix`
- `Middleware/v2/BusinessServices/PMSV/consultaEstadoLote/jca/consultarEstadoLote_db.jca`
- `Middleware/v2/BusinessServices/PMSV/consultaEstadoLote/wsdl/consultarEstadoLote.wsdl`
- `Middleware/v2/BusinessServices/PMSV/consultaEstadoLote/wsdl/consultarEstadoLote_db.wsdl`
- `Middleware/v2/BusinessServices/PMSV/consultaEstadoLote/xsd/consultarEstadoLote_sp.xsd`

#### validaAccesoPMS
- `Middleware/v2/BusinessServices/PMSV/validaAccesoPMS/biz/validaAccesoPMS_db.bix`
- `Middleware/v2/BusinessServices/PMSV/validaAccesoPMS/jca/validaAccesoPMS_db.jca`
- `Middleware/v2/BusinessServices/PMSV/validaAccesoPMS/wsdl/validaAccesoPMS.wsdl`
- `Middleware/v2/BusinessServices/PMSV/validaAccesoPMS/wsdl/validaAccesoPMS_db.wsdl`
- `Middleware/v2/BusinessServices/PMSV/validaAccesoPMS/xsd/validaAccesoPMS_sp.xsd`

#### Alternativo (PWS - MWHostToHost)
- `MWHostToHost/v1/BusinessServices/PWS/consultaEstadoLote/biz/consultaEstadoLote_db.bix`
- `MWHostToHost/v1/BusinessServices/PWS/consultaEstadoLote/jca/consultaEstadoLote_db.jca`
- `MWHostToHost/v1/BusinessServices/PWS/consultaEstadoLote/wsdl/consultaEstadoLote.wsdl`
- `MWHostToHost/v1/BusinessServices/PWS/consultaEstadoLote/wsdl/consultaEstadoLote_db.wsdl`
- `MWHostToHost/v1/BusinessServices/PWS/consultaEstadoLote/xsd/consultaEstadoLote_sp.xsd`

### GT01, NI01, PA01 - Servicio SOAP MTR

#### consultorLote
- `Middleware/v2/BusinessServices/MTR/consultorLote/biz/consultorLote.bix`
- `Middleware/v2/BusinessServices/MTR/consultorLote/wsdl/consultorLoteEndpoint.wsdl`

### Servicios de Soporte

#### ValidaServicioRegional
- `Middleware/v2/BusinessServices/ValidaServicioRegional/biz/ValidaServicioRegional_db.bix`
- `Middleware/v2/BusinessServices/ValidaServicioRegional/jca/ValidaServicioRegional_db.jca`
- `Middleware/v2/BusinessServices/ValidaServicioRegional/wsdl/ValidaServicioRegional.wsdl`
- `Middleware/v2/BusinessServices/ValidaServicioRegional/wsdl/ValidaServicioRegional_db.wsdl`
- `Middleware/v2/BusinessServices/ValidaServicioRegional/xsd/ValidaServicioRegional_sp.xsd`

#### MapeoErrores
- `Middleware/v2/ProxyServices/MapeoErrores.proxy`
- `Middleware/v2/ProxyServices/MapeoErrores.pipeline`

---

## Resources - WSDL

### Principal
- `Middleware/v2/Resources/ConsultaEstadoLote/wsdl/consultaEstadoLotePS.wsdl`

### Alternativo (MWHostToHost)
- `MWHostToHost/v1/Resources/ConsultaEstadoLote/wsdl/consultaEstadoLotePS.wsdl`

### Billetera
- `Middleware/v2/Resources/ConsultaEstadoLoteBilletera/wsdl/consultaEstadoLoteBilleteraPS.wsdl`

---

## Resources - XQuery

### HN01 (Honduras)

#### Transformaciones Entrada
- `Middleware/v2/Resources/ConsultaEstadoLote/xq/consultaEstadoLoteIn.xqy`

#### Transformaciones Salida
- `Middleware/v2/Resources/ConsultaEstadoLote/xq/consultaEstadoLoteOut.xqy`
- `Middleware/v2/Resources/ConsultaEstadoLote/xq/consultaEstadoLoteHeaderOut.xqy`

#### Alternativo (MWHostToHost)
- `MWHostToHost/v1/Resources/ConsultaEstadoLote/xq/consultaEstadoLoteIN.xqy`
- `MWHostToHost/v1/Resources/ConsultaEstadoLote/xq/consultaEstadoLoteOUT.xqy`

### GT01 (Guatemala)

#### Transformaciones Entrada
- `Middleware/v2/Resources/ConsultaEstadoLote/xq/consultaEstadoLoteGTIn.xqy`

#### Transformaciones Salida
- `Middleware/v2/Resources/ConsultaEstadoLote/xq/consultaEstadoLoteGTOut.xqy`
- `Middleware/v2/Resources/ConsultaEstadoLote/xq/consultaEstadoLoteGTHeaderOut.xqy`

### NI01 (Nicaragua)

#### Transformaciones Entrada
- `Middleware/v2/Resources/ConsultaEstadoLote/xq/consultaEstadoLoteNIIn.xqy`

#### Transformaciones Salida
- `Middleware/v2/Resources/ConsultaEstadoLote/xq/consultaEstadoLoteNIOut.xqy`
- `Middleware/v2/Resources/ConsultaEstadoLote/xq/consultaEstadoLoteNIHeaderOut.xqy`

### PA01 (Panamá)

#### Transformaciones Entrada
- `Middleware/v2/Resources/ConsultaEstadoLote/xq/consultaEstadoLotePAIn.xqy`

#### Transformaciones Salida
- `Middleware/v2/Resources/ConsultaEstadoLote/xq/consultaEstadoLotePAOut.xqy`
- `Middleware/v2/Resources/ConsultaEstadoLote/xq/consultaEstadoLotePAHeaderOut.xqy`

### Billetera

#### Transformaciones
- `Middleware/v2/Resources/ConsultaEstadoLoteBilletera/xq/consultaEstadoLoteBilleteraIn.xqy`
- `Middleware/v2/Resources/ConsultaEstadoLoteBilletera/xq/consultaEstadoLoteBilleteraOut.xqy`

#### Relacionados
- `Middleware/v2/Resources/PagosMasivosBilleteraPuente/xq/consultaEstadoLoteBilleteraPuenteIn.xqy`

---

## Resources - XSD (Schemas)

### Principal
- `Middleware/v2/Resources/PagosMasivos/xsd/pagosMasivosTypes.xsd`

### Alternativo (MWHostToHost)
- `MWHostToHost/v1/Resources/PagosMasivos/xsd/pagosMasivosTypes.xsd`

### Esquemas Generales
- `Middleware/Business_Resources/esquemas_generales/HeaderElements.xsd`
- `Middleware/Business_Resources/esquemas_generales/PagingTypes.xsd`

---

## Resources - Generales (Compartidos)

### Validación Regional
- `Middleware/v2/Resources/Generales/xq/validaServicioRegionalIn.xqy`
- `Middleware/v2/Resources/Generales/xq/aplicarValoresPorDefectoRegion.xqy`

### Validación Acceso PMS
- `Middleware/v2/Resources/PagosMasivos/xq/validarAccesoPMSIn.xqy`

### Mapeo de Errores
- `Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageIn.xqy`
- `Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageOut.xqy`

---

## Configuración y Políticas

### Alertas
- `Middleware/Alerts/MaxTime500.alert`

### Configuración de Proyecto
- `Middleware/Middleware.jpr`
- `Middleware/pom.xml`
- `Middleware/servicebus.sboverview`

### Configuración de MWHostToHost
- `MWHostToHost/MWHostToHost.jpr`
- `MWHostToHost/pom.xml`
- `MWHostToHost/servicebus.sboverview`

### Configuración de Sistema
- `System/pom.xml`
- `pom.xml` (raíz)
- `VortexMigrate.jws`

### Configuración de Seguridad
- `src/META-INF/jps-config.xml`
- `.adf/META-INF/adf-config.xml`

---

## Archivos JAR (Hotfixes y Releases)

### Relacionados con Pagos Masivos
- `jar/TPGCO-2065/PRD/` (contiene JARs de producción)
- `jar/TPGCO-2065/QA/` (contiene JARs de QA)
- `jar/TPGCO-2065_HF10/` (HotFix 10)
- `jar/TPGCO-1844/PRD/`
- `jar/TPGCO-1844/QA/`
- `jar/TPGCO-1844_HF11/OU02760_TPGCO-1844_HF11/`

### Otros Hotfixes Relevantes
- `jar/TIACH-2025/PRD/`
- `jar/TIACH-2025/QA/`
- `jar/TIACH-2025-HF01/`
- `jar/TIACH-2025-HF02/`
- `jar/TIACH-2025_BF01/`

---

## Tests (Si existen)

**Nota**: No se detectaron archivos de test específicos para ConsultaEstadoLote en la estructura analizada. Se recomienda verificar en:
- `Middleware/test/` (si existe)
- `MWHostToHost/test/` (si existe)
- Proyectos de test separados

---

## Archivos de Configuración de Entorno

### Propiedades
**Nota**: No se detectaron archivos `.properties` específicos en la estructura analizada. Posibles ubicaciones:
- `Middleware/config/` (si existe)
- `Middleware/Business_Resources/general/` (contiene recursos generales)
- Variables de entorno del servidor OSB

### Conexiones JNDI
- `eis/DB/ConnectionProxyAbanksHN` (referenciado en JCA files)

---

## Resumen por Tipo de Archivo

| Tipo | Cantidad | Ubicaciones Principales |
|------|----------|------------------------|
| **Proxy Services** | 3 | Middleware/v2/ProxyServices, MWHostToHost/v1/ProxyServices |
| **Pipeline Files** | 3 | Middleware/v2/ProxyServices, MWHostToHost/v1/ProxyServices |
| **Business Services** | 4+ | Middleware/v2/BusinessServices/PMSV, MTR, ValidaServicioRegional |
| **WSDL Files** | 10+ | Resources/*/wsdl, BusinessServices/*/wsdl |
| **XQuery Files** | 20+ | Resources/ConsultaEstadoLote/xq |
| **XSD Files** | 8+ | Resources/*/xsd, BusinessServices/*/xsd |
| **JCA Files** | 4+ | BusinessServices/*/jca |
| **BIX Files** | 4+ | BusinessServices/*/biz |
| **JAR Files** | 10+ | jar/* (hotfixes y releases) |
| **Config Files** | 5+ | pom.xml, .jpr, .jws, jps-config.xml |

---

## Archivos No Encontrados (Búsqueda Realizada)

Los siguientes archivos fueron buscados pero no encontrados:
- Tests unitarios específicos para ConsultaEstadoLote
- Archivos de configuración `.properties` específicos
- Documentación técnica en formato `.doc` o `.pdf`
- Scripts de despliegue específicos

**Técnica de Búsqueda Usada**: 
- `fileSearch` con query "ConsultaEstadoLote"
- `listDirectory` recursivo en estructura del proyecto
- Análisis de referencias en archivos `.proxy`, `.pipeline`, `.xqy`

---

## Dependencias Externas Detectadas

### Servicios
1. **Servicio MTR (Cidenet)**
   - Endpoint: `https://172.23.14.243:7004/ConsultaLotePmsWS/services/consultorLoteEndpoint`
   - Usado por: GT01, NI01, PA01

2. **Base de Datos Oracle**
   - Conexión: `eis/DB/ConnectionProxyAbanksHN`
   - Usado por: HN01, ValidaServicioRegional, validaAccesoPMS

### Librerías Oracle
- Oracle DB Adapter
- Oracle JCA Adapter
- Oracle BPEL (para XSD de stored procedures)

---

## Notas Adicionales

1. **Versionado**: El proyecto usa múltiples versiones (v1, v2, v3, v4) en diferentes módulos
2. **Estructura Modular**: Separación clara entre Middleware y MWHostToHost
3. **Hotfixes**: Múltiples hotfixes aplicados, documentados en carpeta `jar/`
4. **Encoding**: Archivos XQuery usan `Cp1252` (Windows Latin-1)
5. **Namespaces**: Consistentes en todo el proyecto (`http://www.ficohsa.com.hn/middleware.services/`)
