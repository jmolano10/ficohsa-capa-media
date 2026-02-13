# Listado de Ficheros - ConInfoLealtad

## Business Services

### conInfoLealtad (SQL Server - HN01)
- `Middleware/v2/BusinessServices/ProcesosHN/conInfoLealtad/biz/conInfoLealtad_db.bix`
- `Middleware/v2/BusinessServices/ProcesosHN/conInfoLealtad/jca/conInfoLealtad_db.jca`
- `Middleware/v2/BusinessServices/ProcesosHN/conInfoLealtad/wsdl/conInfoLealtad.wsdl`
- `Middleware/v2/BusinessServices/ProcesosHN/conInfoLealtad/wsdl/conInfoLealtad_db.wsdl`
- `Middleware/v2/BusinessServices/ProcesosHN/conInfoLealtad/xsd/conInfoLealtad_sp.xsd`

---

## Proxy Services (Contenedores)

### Honduras (HN01)
- `Middleware/v2/ProxyServices/ConsultaPuntosLealtadHN.proxy`
- `Middleware/v2/ProxyServices/ConsultaPuntosLealtadHN.pipeline`

### Otras Regiones (sin conInfoLealtad)
- `Middleware/v2/ProxyServices/ConsultaPuntosLealtadGT.proxy`
- `Middleware/v2/ProxyServices/ConsultaPuntosLealtadGT.pipeline`
- `Middleware/v2/ProxyServices/ConsultaPuntosLealtadNI.proxy`
- `Middleware/v2/ProxyServices/ConsultaPuntosLealtadNI.pipeline`
- `Middleware/v2/ProxyServices/ConsultaPuntosLealtadPA.proxy`
- `Middleware/v2/ProxyServices/ConsultaPuntosLealtadPA.pipeline`

### Facade (Multiregión)
- `Middleware/v2/ProxyServices/ConsultaPuntosLealtad.proxy`
- `Middleware/v2/ProxyServices/ConsultaPuntosLealtad.pipeline`
- `Middleware/v2/ProxyServices/ConsultaPuntosLealtadFacade.proxy`
- `Middleware/v2/ProxyServices/ConsultaPuntosLealtadFacade.pipeline`

---

## Resources - XQuery

### Transformaciones de conInfoLealtad
- `Middleware/v2/Resources/ProgramaLealtad/xq/conInfoLealtadHNIn.xqy`

### Transformaciones de ConsultaPuntosLealtad (HN01)
- `Middleware/v2/Resources/ConsultaPuntosLealtad/xq/consultaPuntosLealtadIn.xqy`
- `Middleware/v2/Resources/ConsultaPuntosLealtad/xq/consultaPuntosLealtadHNOut.xqy`
- `Middleware/v2/Resources/ConsultaPuntosLealtad/xq/consultaPuntosLealtadOut.xqy`

### Transformaciones de Otras Regiones
- `Middleware/v2/Resources/ConsultaPuntosLealtad/xq/consultaPuntosLealtadGTOut.xqy`
- `Middleware/v2/Resources/ConsultaPuntosLealtad/xq/consultaPuntosLealtadNIOut.xqy`
- `Middleware/v2/Resources/ConsultaPuntosLealtad/xq/consultaPuntosLealtadPAOut.xqy`

### Transformaciones de Servicios Relacionados
- `Middleware/v2/Resources/ConsultaPuntosLealtad/xq/getPointDetailsIn.xqy`
- `Middleware/v2/Resources/ConsultaPuntosLealtad/xq/getPointDetailsInGT.xqy`
- `Middleware/v2/Resources/ConsultaPuntosLealtad/xq/getPointDetailsInPA.xqy`
- `Middleware/v2/Resources/ConsultaPuntosLealtad/xq/registraPuntosLealtadIn.xqy`
- `Middleware/v2/Resources/ConsultaPuntosLealtad/xq/validarDatosOpcion.xqy`
- `Middleware/v2/Resources/ConsultaPuntosLealtad/xq/consultaBloqueSFIn.xqy`

### Transformaciones de Facade
- `Middleware/v2/Resources/ConsultaPuntosLealtadFacade/xq/consultaPuntosLealtadIn.xqy`
- `Middleware/v2/Resources/ConsultaPuntosLealtadFacade/xq/consultaPuntosLealtadFacadeOut.xqy`

### Transformaciones Generales
- `Middleware/v2/Resources/Generales/xq/convertirCodigoPais.xqy`

### Transformaciones de Programa Lealtad
- `Middleware/v2/Resources/ProgramaLealtad/xq/consultaProgramaLealtadIn.xqy`
- `Middleware/v2/Resources/ProgramaLealtad/xq/canjearPuntosEfectivoHNIn.xqy`
- `Middleware/v2/Resources/ProgramaLealtad/xq/MRSIdentity.xqy`

### Transformaciones de MasterData
- `Middleware/v2/Resources/MasterDataHN/xq/conDatoCuentaHNIn.xqy`

### Transformaciones de VisionPlus
- `Middleware/v2/Resources/VisionPlus/xq/pointsAdjustmentInquiryIn.xqy`

---

## Resources - WSDL

### conInfoLealtad
- `Middleware/v2/BusinessServices/ProcesosHN/conInfoLealtad/wsdl/conInfoLealtad.wsdl`
- `Middleware/v2/BusinessServices/ProcesosHN/conInfoLealtad/wsdl/conInfoLealtad_db.wsdl`

### ConsultaPuntosLealtad
- `Middleware/v2/Resources/ConsultaPuntosLealtad/wsdl/consultaPuntosLealtadPS.wsdl`

---

## Resources - XSD (Schemas)

### conInfoLealtad
- `Middleware/v2/BusinessServices/ProcesosHN/conInfoLealtad/xsd/conInfoLealtad_sp.xsd`

### ConsultaPuntosLealtad
- `Middleware/v2/Resources/ProgramaLealtad/xsd/programaLealtadTypes.xsd`

### Esquemas Generales
- `Middleware/Business_Resources/esquemas_generales/HeaderElements.xsd`

---

## Business Services Relacionados

### Consulta de Puntos
- `Middleware/v2/BusinessServices/CLIENTDATA/consultaPuntosLealtad/biz/consultaPuntosLealtad_db.bix`
- `Middleware/v2/BusinessServices/CLIENTDATA/consultaPuntosLealtad/jca/consultaPuntosLealtad_db.jca`
- `Middleware/v2/BusinessServices/CLIENTDATA/consultaPuntosLealtad/wsdl/consultaPuntosLealtad.wsdl`
- `Middleware/v2/BusinessServices/CLIENTDATA/consultaPuntosLealtad/wsdl/consultaPuntosLealtad_db.wsdl`
- `Middleware/v2/BusinessServices/CLIENTDATA/consultaPuntosLealtad/xsd/consultaPuntosLealtad_sp.xsd`

### Programa de Lealtad
- `Middleware/v2/BusinessServices/INTFC/consultaProgramaLealtad/biz/consultaProgramaLealtad_db.bix`
- `Middleware/v2/BusinessServices/INTFC/consultaProgramaLealtad/jca/consultaProgramaLealtad_db.jca`
- `Middleware/v2/BusinessServices/INTFC/consultaProgramaLealtad/wsdl/consultaProgramaLealtad.wsdl`
- `Middleware/v2/BusinessServices/INTFC/consultaProgramaLealtad/wsdl/consultaProgramaLealtad_db.wsdl`
- `Middleware/v2/BusinessServices/INTFC/consultaProgramaLealtad/xsd/consultaProgramaLealtad_sp.xsd`

### Mastercard Rewards
- `Middleware/v2/BusinessServices/Mastercard/CustomerService/biz/CustomerService.bix`
- `Middleware/v2/BusinessServices/Mastercard/CustomerService/wsdl/CustomerService.wsdl`

### VisionPlus
- `Middleware/v2/BusinessServices/VisionPlus/visionPlus/biz/visionPlus.bix`
- `Middleware/v2/BusinessServices/VisionPlus/visionPlus/wsdl/visionPlus.wsdl`

### Datos de Cuenta
- `Middleware/v2/BusinessServices/MasterDataHN/conDatoCuenta/biz/conDatoCuenta_db.bix`
- `Middleware/v2/BusinessServices/MasterDataHN/conDatoCuenta/jca/conDatoCuenta_db.jca`
- `Middleware/v2/BusinessServices/MasterDataHN/conDatoCuenta/wsdl/conDatoCuenta.wsdl`
- `Middleware/v2/BusinessServices/MasterDataHN/conDatoCuenta/wsdl/conDatoCuenta_db.wsdl`
- `Middleware/v2/BusinessServices/MasterDataHN/conDatoCuenta/xsd/conDatoCuenta_sp.xsd`

### Canje de Puntos
- `Middleware/v2/BusinessServices/ABK/canjearPuntosEfectivo/biz/canjearPuntosEfectivo_db.bix`
- `Middleware/v2/BusinessServices/ABK/canjearPuntosEfectivo/jca/canjearPuntosEfectivo_db.jca`
- `Middleware/v2/BusinessServices/ABK/canjearPuntosEfectivo/wsdl/canjearPuntosEfectivo.wsdl`
- `Middleware/v2/BusinessServices/ABK/canjearPuntosEfectivo/wsdl/canjearPuntosEfectivo_db.wsdl`
- `Middleware/v2/BusinessServices/ABK/canjearPuntosEfectivo/xsd/canjearPuntosEfectivo_sp.xsd`

### Registro de Puntos
- `Middleware/v2/BusinessServices/CLIENTDATA/registraPuntosLealtad/biz/registraPuntosLealtad_db.bix`
- `Middleware/v2/BusinessServices/CLIENTDATA/registraPuntosLealtad/jca/registraPuntosLealtad_db.jca`
- `Middleware/v2/BusinessServices/CLIENTDATA/registraPuntosLealtad/wsdl/registraPuntosLealtad.wsdl`
- `Middleware/v2/BusinessServices/CLIENTDATA/registraPuntosLealtad/wsdl/registraPuntosLealtad_db.wsdl`
- `Middleware/v2/BusinessServices/CLIENTDATA/registraPuntosLealtad/xsd/registraPuntosLealtad_sp.xsd`

### Parametrización
- `Middleware/Business_Resources/general/Resources/ObtenerParametrizacion/ObtenerParametrizacion.bix`
- `Middleware/Business_Resources/general/Parametrizacion/obtenerParametrizacionIn.xqy`

---

## Configuración y Políticas

### Configuración de Proyecto
- `Middleware/Middleware.jpr`
- `Middleware/pom.xml`
- `Middleware/servicebus.sboverview`

### Configuración de Sistema
- `System/pom.xml`
- `pom.xml` (raíz)
- `VortexMigrate.jws`

### Configuración de Seguridad
- `src/META-INF/jps-config.xml`
- `.adf/META-INF/adf-config.xml`

---

## Java Callouts

**No detectados** para conInfoLealtad específicamente.

**Técnica de Búsqueda**: Análisis de archivos .pipeline y .bix

---

## POJOs

**No detectados** para conInfoLealtad específicamente.

**Técnica de Búsqueda**: Búsqueda de archivos .java en estructura del proyecto

---

## Archivos de Configuración

### Properties
**No encontrados** archivos .properties específicos para conInfoLealtad.

**Técnica de Búsqueda**: 
- Búsqueda recursiva en `Middleware/config/`
- Búsqueda en `Middleware/Business_Resources/general/`
- Análisis de referencias en archivos JCA

### Conexiones JNDI
- `eis/DB/ConnectionProcesosHN` (referenciado en conInfoLealtad_db.jca)
- `eis/DB/ConnectionCLIENTDATA` (usado por consultaPuntosLealtad_db)
- `eis/DB/ConnectionINTFC` (usado por consultaProgramaLealtad_db)
- `eis/DB/ConnectionABK` (usado por canjearPuntosEfectivo_db)

---

## Tests

**No encontrados** tests específicos para conInfoLealtad.

**Técnica de Búsqueda**:
- Búsqueda de archivos con patrón `*Test*.java`
- Búsqueda de archivos con patrón `*test*.xml`
- Búsqueda en carpetas `test/` o `tests/`

**Recomendación**: Crear tests unitarios y de integración para:
- Transformación XQuery (conInfoLealtadHNIn.xqy)
- Flujo completo con diferentes tipos de tarjeta
- Manejo de errores del Stored Procedure

---

## Políticas OSB

**No detectadas** políticas específicas para conInfoLealtad.

**Políticas Heredadas** del Proxy Service contenedor:
- SLA Alerting: Habilitado (nivel normal)
- Pipeline Alerting: Habilitado (nivel normal)
- Logging: Habilitado (nivel debug)

---

## Resumen por Tipo de Archivo

| Tipo | Cantidad | Ubicaciones Principales |
|------|----------|------------------------|
| **Business Services** | 1 | Middleware/v2/BusinessServices/ProcesosHN/conInfoLealtad |
| **Proxy Services (contenedores)** | 6 | Middleware/v2/ProxyServices/ConsultaPuntosLealtad* |
| **WSDL Files** | 2 | conInfoLealtad/wsdl |
| **XQuery Files** | 1 | ProgramaLealtad/xq/conInfoLealtadHNIn.xqy |
| **XSD Files** | 1 | conInfoLealtad/xsd/conInfoLealtad_sp.xsd |
| **JCA Files** | 1 | conInfoLealtad/jca/conInfoLealtad_db.jca |
| **BIX Files** | 1 | conInfoLealtad/biz/conInfoLealtad_db.bix |
| **Java Callouts** | 0 | N/A |
| **POJOs** | 0 | N/A |
| **Properties** | 0 | N/A |
| **Tests** | 0 | N/A |

---

## Servicios Relacionados (Dependencias)

### Upstream (Invocan conInfoLealtad)
1. `ConsultaPuntosLealtadHN.pipeline`
   - Stage: `ConsultaInformacionCliente`
   - Condición: `not(exists($RSPconsultaPuntosLealtad/PT_PUNTOS_LEALTAD/BALANCE)) and $customerIdType = "CARD_NUMBER"`

### Downstream (Invocados por conInfoLealtad)
- Ninguno (es un leaf service - consulta directa a DB)

### Servicios en el Mismo Flujo

#### Antes de conInfoLealtad:
1. **consultaPuntosLealtad_db**
   - `Middleware/v2/BusinessServices/CLIENTDATA/consultaPuntosLealtad/biz/consultaPuntosLealtad_db`
   - Consulta inicial de puntos (puede no retornar datos)

2. **convertirCodigoPais**
   - `Middleware/v2/Resources/Generales/xq/convertirCodigoPais.xqy`
   - Convierte HN01 → HND

#### Después de conInfoLealtad:
3. **consultaProgramaLealtad_db**
   - `Middleware/v2/BusinessServices/INTFC/consultaProgramaLealtad/biz/consultaProgramaLealtad_db`
   - Determina programa de lealtad según LOGO

4. **ObtenerParametrizacion**
   - `Middleware/Business_Resources/general/Resources/ObtenerParametrizacion/ObtenerParametrizacion`
   - Obtiene nombre de institución para Mastercard

5. **Mastercard CustomerService** (si programa = '1')
   - `Middleware/v2/BusinessServices/Mastercard/CustomerService/biz/CustomerService`
   - Operación: `getPointDetails`

6. **VisionPlus** (si programa = '2')
   - `Middleware/v2/BusinessServices/VisionPlus/visionPlus/biz/visionPlus`
   - Operación: `PointsAdjustmentInquiry`

7. **conDatoCuenta_db** (si programa = '2')
   - `Middleware/v2/BusinessServices/MasterDataHN/conDatoCuenta/biz/conDatoCuenta_db`
   - Obtiene datos de cuenta para VisionPlus

8. **canjearPuntosEfectivo_db** (si RETURN_CASH_EQUIVALENT = YES)
   - `Middleware/v2/BusinessServices/ABK/canjearPuntosEfectivo/biz/canjearPuntosEfectivo_db`
   - Calcula equivalencia en efectivo

9. **registraPuntosLealtad_db**
   - `Middleware/v2/BusinessServices/CLIENTDATA/registraPuntosLealtad/biz/registraPuntosLealtad_db`
   - Registra la consulta realizada

---

## Archivos No Encontrados (Búsqueda Realizada)

Los siguientes archivos fueron buscados pero no encontrados:
- Tests unitarios para conInfoLealtad
- Archivos de configuración `.properties` específicos
- Documentación técnica del Stored Procedure OSBConInfoLealtad
- Scripts SQL de creación del Stored Procedure
- Java Callouts relacionados
- POJOs de modelo de datos

**Técnica de Búsqueda Usada**: 
- `fileSearch` con query "conInfoLealtad"
- `listDirectory` recursivo en estructura del proyecto
- Análisis de referencias en archivos `.pipeline`, `.jca`, `.xqy`

---

## Dependencias Externas Detectadas

### Base de Datos SQL Server
- **Conexión**: `eis/DB/ConnectionProcesosHN`
- **Schema**: `dbo`
- **Stored Procedure**: `OSBConInfoLealtad`
- **Tabla(s)**: No especificadas (dentro del SP)

### Servicios Externos
1. **Mastercard Rewards Service**
   - Endpoint: Configurado en Business Service
   - Operación: `getPointDetails`

2. **VisionPlus Service**
   - Endpoint: Configurado en Business Service
   - Operación: `PointsAdjustmentInquiry`

---

## Notas Adicionales

1. **Región Específica**: Solo implementado para HN01 (Honduras)
2. **Tipo de Base de Datos**: SQL Server (diferente a otros servicios que usan Oracle)
3. **Formato de Salida**: RowSet con columnas dinámicas (no estructura fija)
4. **Case Insensitive**: Usa `upper-case(@name)` para comparar nombres de columnas
5. **Trim de Datos**: Usa `fn-bea:trim()` para limpiar espacios del Legal ID
6. **Encoding**: XQuery usa encoding por defecto (UTF-8)
7. **XQuery Version**: 2004-draft
8. **Namespace**: `http://xmlns.oracle.com/pcbpel/adapter/db/sp/conInfoLealtad`
