# Listado de Ficheros - cargaLoteProductos

## 1. Proxy Services

| Ruta Relativa | Descripción |
|--------------|-------------|
| `ficohsacore-osb-7e5cceccb837/MWHostToHost/v1/ProxyServices/CargaLoteProductos.proxy` | Proxy service principal que expone la funcionalidad cargaLoteProductos |

---

## 2. Business Services

### 2.1 Validación de Servicio Regional

| Ruta Relativa | Descripción |
|--------------|-------------|
| `ficohsacore-osb-7e5cceccb837/MWHostToHost/v1/BusinessServices/MDW/validaServicioRegional/biz/validaServicioRegional_db.biz` | Business service para validación regional |
| `ficohsacore-osb-7e5cceccb837/MWHostToHost/v1/BusinessServices/MDW/validaServicioRegional/jca/validaServicioRegional_db.jca` | Configuración JCA del adapter |
| `ficohsacore-osb-7e5cceccb837/MWHostToHost/v1/BusinessServices/MDW/validaServicioRegional/wsdl/validaServicioRegional.wsdl` | WSDL abstracto |
| `ficohsacore-osb-7e5cceccb837/MWHostToHost/v1/BusinessServices/MDW/validaServicioRegional/wsdl/validaServicioRegional_db.wsdl` | WSDL concreto con binding |
| `ficohsacore-osb-7e5cceccb837/MWHostToHost/v1/BusinessServices/MDW/validaServicioRegional/xsd/validaServicioRegional_sp.xsd` | Esquema XSD del stored procedure |

### 2.2 Validación de Acceso H2H

| Ruta Relativa | Descripción |
|--------------|-------------|
| `ficohsacore-osb-7e5cceccb837/MWHostToHost/v1/BusinessServices/INTFC/validaAccesoH2H/biz/validaAccesoH2H_db.biz` | Business service para validación de acceso H2H |
| `ficohsacore-osb-7e5cceccb837/MWHostToHost/v1/BusinessServices/INTFC/validaAccesoH2H/jca/validaAccesoH2H_db.jca` | Configuración JCA del adapter |
| `ficohsacore-osb-7e5cceccb837/MWHostToHost/v1/BusinessServices/INTFC/validaAccesoH2H/wsdl/validaAccesoH2H.wsdl` | WSDL abstracto |
| `ficohsacore-osb-7e5cceccb837/MWHostToHost/v1/BusinessServices/INTFC/validaAccesoH2H/wsdl/validaAccesoH2H_db.wsdl` | WSDL concreto con binding |
| `ficohsacore-osb-7e5cceccb837/MWHostToHost/v1/BusinessServices/INTFC/validaAccesoH2H/xsd/validaAccesoH2H_sp.xsd` | Esquema XSD del stored procedure |

### 2.3 Consulta de Cliente (T24)

| Ruta Relativa | Descripción |
|--------------|-------------|
| `ficohsacore-osb-7e5cceccb837/Middleware/v3/BusinessServices/ConsultasCliente/biz/sjConsultaClienteResiliencia.biz` | Business service para consulta de cliente en T24 |
| `ficohsacore-osb-7e5cceccb837/Middleware/v3/BusinessServices/ConsultasCliente/flow/sjConsultaClienteResiliencia.flow` | Flujo de resiliencia |
| `ficohsacore-osb-7e5cceccb837/Middleware/v3/BusinessServices/ConsultasCliente/wsdl/sjConsultaClienteResiliencia.wsdl` | WSDL del servicio T24 |

### 2.4 Carga de Lote de Productos

| Ruta Relativa | Descripción |
|--------------|-------------|
| `ficohsacore-osb-7e5cceccb837/MWHostToHost/v1/BusinessServices/PWS/cargaLoteProductos/biz/cargaLoteProductos_db.biz` | Business service para carga de lote |
| `ficohsacore-osb-7e5cceccb837/MWHostToHost/v1/BusinessServices/PWS/cargaLoteProductos/jca/cargaLoteProductos_db.jca` | Configuración JCA del adapter |
| `ficohsacore-osb-7e5cceccb837/MWHostToHost/v1/BusinessServices/PWS/cargaLoteProductos/wsdl/cargaLoteProductos.wsdl` | WSDL abstracto |
| `ficohsacore-osb-7e5cceccb837/MWHostToHost/v1/BusinessServices/PWS/cargaLoteProductos/wsdl/cargaLoteProductos_db.wsdl` | WSDL concreto con binding |
| `ficohsacore-osb-7e5cceccb837/MWHostToHost/v1/BusinessServices/PWS/cargaLoteProductos/xsd/cargaLoteProductos_sp.xsd` | Esquema XSD del stored procedure |

### 2.5 Mapeo de Errores

| Ruta Relativa | Descripción |
|--------------|-------------|
| `ficohsacore-osb-7e5cceccb837/MWHostToHost/v1/BusinessServices/OSB/mapeoErrores/biz/mapeoErrores.biz` | Business service para mapeo de errores |
| `ficohsacore-osb-7e5cceccb837/MWHostToHost/v1/BusinessServices/OSB/mapeoErrores/wsdl/mapeoErrores.wsdl` | WSDL del servicio de mapeo |

---

## 3. Resources - WSDL

| Ruta Relativa | Descripción |
|--------------|-------------|
| `ficohsacore-osb-7e5cceccb837/MWHostToHost/v1/Resources/CargaLoteProductos/wsdl/cargaLoteProductosPS.wsdl` | WSDL del proxy service principal |

---

## 4. Resources - XQuery (Transformaciones)

### 4.1 Transformaciones Específicas de cargaLoteProductos

| Ruta Relativa | Descripción |
|--------------|-------------|
| `ficohsacore-osb-7e5cceccb837/MWHostToHost/v1/Resources/CargaLoteProductos/xq/cargaLoteProductosIN.xq` | Transformación de request OSB + datos T24 a stored procedure |
| `ficohsacore-osb-7e5cceccb837/MWHostToHost/v1/Resources/CargaLoteProductos/xq/cargaLoteProductosOUT.xq` | Transformación de respuesta del stored procedure a response OSB |
| `ficohsacore-osb-7e5cceccb837/MWHostToHost/v1/Resources/CargaLoteProductos/xq/ConsultaClienteIN.xq` | Transformación de request OSB a consulta T24 |

### 4.2 Transformaciones de Validación de Acceso H2H

| Ruta Relativa | Descripción |
|--------------|-------------|
| `ficohsacore-osb-7e5cceccb837/MWHostToHost/v1/Resources/CobranzasH2H/xq/validaAccesoH2HIn.xq` | Transformación para validación de acceso H2H |

### 4.3 Transformaciones Generales

| Ruta Relativa | Descripción |
|--------------|-------------|
| `ficohsacore-osb-7e5cceccb837/MWHostToHost/v1/Resources/Generales/xq/validaServicioRegionalIn.xq` | Transformación para validación de servicio regional |
| `ficohsacore-osb-7e5cceccb837/MWHostToHost/v1/Resources/Generales/xq/mapeoErroresUsageIn.xq` | Transformación de entrada para mapeo de errores |
| `ficohsacore-osb-7e5cceccb837/MWHostToHost/v1/Resources/Generales/xq/mapeoErroresUsageOut.xq` | Transformación de salida para mapeo de errores |

---

## 5. Resources - XSD (Esquemas)

### 5.1 Esquemas Específicos

| Ruta Relativa | Descripción |
|--------------|-------------|
| `ficohsacore-osb-7e5cceccb837/MWHostToHost/v1/Resources/AperturaMasiva/xsd/aperturaMasivaTypes.xsd` | Esquema de tipos para apertura masiva (request/response) |

### 5.2 Esquemas Generales

| Ruta Relativa | Descripción |
|--------------|-------------|
| `ficohsacore-osb-7e5cceccb837/MWHostToHost/v1/Resources/EsquemasGenerales/headerElements.xsd` | Esquema de elementos de header (RequestHeader/ResponseHeader) |
| `ficohsacore-osb-7e5cceccb837/MWHostToHost/v1/Resources/EsquemasGenerales/KeyValuePair.xsd` | Esquema de pares clave-valor |

---

## 6. Configuración y Políticas

### 6.1 Archivos de Configuración OSB

| Ruta Relativa | Descripción |
|--------------|-------------|
| `ficohsacore-osb-7e5cceccb837/MWHostToHost/.project` | Archivo de proyecto Eclipse/JDeveloper |
| `ficohsacore-osb-7e5cceccb837/MWHostToHost/.settings/org.eclipse.wst.common.component` | Configuración de componentes |
| `ficohsacore-osb-7e5cceccb837/MWHostToHost/.settings/org.eclipse.wst.common.project.facet.core.xml` | Configuración de facets |
| `ficohsacore-osb-7e5cceccb837/MWHostToHost/.settings/org.eclipse.wst.validation.prefs` | Preferencias de validación |

---

## 7. Archivos Relacionados (Contexto)

### 7.1 Otros Proxies en MWHostToHost

| Ruta Relativa | Descripción |
|--------------|-------------|
| `ficohsacore-osb-7e5cceccb837/MWHostToHost/v1/ProxyServices/ActualizaParametros.proxy` | Proxy relacionado - actualización de parámetros |
| `ficohsacore-osb-7e5cceccb837/MWHostToHost/v1/ProxyServices/ConsultaParametros.proxy` | Proxy relacionado - consulta de parámetros |
| `ficohsacore-osb-7e5cceccb837/MWHostToHost/v1/ProxyServices/ConsultaDetalleLote.proxy` | Proxy relacionado - consulta de detalle de lote |
| `ficohsacore-osb-7e5cceccb837/MWHostToHost/v1/ProxyServices/ConsultaEstadoLote.proxy` | Proxy relacionado - consulta de estado de lote |

### 7.2 Business Services Relacionados

| Ruta Relativa | Descripción |
|--------------|-------------|
| `ficohsacore-osb-7e5cceccb837/MWHostToHost/v1/BusinessServices/PWS/actualizaParametros/` | Business service relacionado |
| `ficohsacore-osb-7e5cceccb837/MWHostToHost/v1/BusinessServices/PWS/consultaParametros/` | Business service relacionado |
| `ficohsacore-osb-7e5cceccb837/MWHostToHost/v1/BusinessServices/PWS/consultaDetalleLote/` | Business service relacionado |
| `ficohsacore-osb-7e5cceccb837/MWHostToHost/v1/BusinessServices/PWS/consultaEstadoLote/` | Business service relacionado |

---

## 8. Resumen de Archivos por Tipo

### 8.1 Conteo de Archivos

| Tipo de Archivo | Cantidad | Descripción |
|----------------|----------|-------------|
| .proxy | 1 | Proxy services |
| .biz | 5 | Business services |
| .jca | 3 | Configuraciones JCA |
| .wsdl | 10 | Definiciones WSDL |
| .xsd | 5 | Esquemas XML |
| .xq | 8 | Transformaciones XQuery |
| .flow | 1 | Flujos de resiliencia |
| Configuración | 4 | Archivos de configuración |
| **TOTAL** | **37** | Archivos principales |

### 8.2 Archivos por Funcionalidad

| Funcionalidad | Archivos | Descripción |
|--------------|----------|-------------|
| Proxy Principal | 2 | .proxy + .wsdl |
| Validación Regional | 5 | .biz + .jca + 2 .wsdl + .xsd + .xq |
| Validación H2H | 5 | .biz + .jca + 2 .wsdl + .xsd + .xq |
| Consulta T24 | 3 | .biz + .flow + .wsdl + .xq |
| Carga Lote DB | 5 | .biz + .jca + 2 .wsdl + .xsd + .xq |
| Mapeo Errores | 4 | .biz + .wsdl + 2 .xq |
| Esquemas | 3 | 3 .xsd |
| Configuración | 4 | Archivos de proyecto |

---

## 9. Dependencias Externas

### 9.1 Conexiones a Base de Datos

| Nombre JNDI | Uso | Archivos que lo Referencian |
|------------|-----|----------------------------|
| `eis/DB/ConnectionWebServices` | Conexión Oracle para stored procedures | validaServicioRegional_db.biz<br/>validaAccesoH2H_db.biz<br/>cargaLoteProductos_db.biz |

### 9.2 Servicios Externos

| Servicio | Tipo | Uso |
|---------|------|-----|
| sjConsultaClienteResiliencia | SOAP/T24 | Consulta de clientes en core bancario |
| mapeoErrores | OSB Service | Mapeo de códigos de error |

### 9.3 Recursos LDAP

| Recurso | Uso |
|---------|-----|
| `Middleware/Security/{USERNAME}` | Lookup de credenciales para T24 |

---

## 10. Stored Procedures Referenciados

| Package | Procedure | Uso | Archivo Referencia |
|---------|-----------|-----|-------------------|
| HTH_K_APERTURA_MASIVA | HTH_P_CARGA_LOTE_PRODUCTOS | Carga de lote de productos | cargaLoteProductos_db.jca |
| (No especificado) | ValidaServicioRegional | Validación de servicio regional | validaServicioRegional_db.jca |
| (No especificado) | validaAccesoH2H | Validación de acceso H2H | validaAccesoH2H_db.jca |

---

## 11. Técnica de Búsqueda Utilizada

Para generar este listado se utilizaron las siguientes técnicas:

1. **Análisis del archivo proxy principal:** `CargaLoteProductos.proxy`
   - Identificación de business services referenciados
   - Identificación de recursos XQuery
   - Identificación de esquemas XSD

2. **Seguimiento de referencias:** A partir de cada business service identificado:
   - Archivos .biz (definición del servicio)
   - Archivos .jca (configuración del adapter)
   - Archivos .wsdl (contratos SOAP)
   - Archivos .xsd (esquemas de datos)

3. **Análisis de transformaciones XQuery:**
   - Identificación de recursos referenciados
   - Identificación de funciones y parámetros

4. **Búsqueda por patrón de nombres:**
   - Búsqueda de archivos con nombre "cargaLoteProductos"
   - Búsqueda de archivos en rutas relacionadas

5. **Análisis de dependencias:**
   - Servicios externos invocados
   - Conexiones a base de datos
   - Recursos LDAP

---

## 12. Archivos No Encontrados

Los siguientes archivos fueron referenciados pero no se encontraron en el análisis:

| Archivo | Tipo | Razón |
|---------|------|-------|
| Implementación de mapeoErrores | Business Service | Solo se encontró la referencia, no la implementación |
| Esquemas de T24 | XSD | Externos al proyecto OSB |
| Configuración de LDAP | Properties | Configuración externa |
| Scripts de base de datos | SQL/PLSQL | No incluidos en el proyecto OSB |

---

## 13. Notas Adicionales

1. **Versionamiento:** Todos los archivos están bajo la versión `v1` del módulo `MWHostToHost`

2. **Convención de Nombres:** 
   - Business Services: `{nombre}_db.biz` para DB Adapters
   - XQuery: `{nombre}IN.xq` para transformaciones de entrada, `{nombre}OUT.xq` para salida

3. **Organización:**
   - ProxyServices: Servicios expuestos
   - BusinessServices: Servicios consumidos (organizados por sistema: MDW, INTFC, PWS, OSB)
   - Resources: Recursos compartidos (WSDL, XQuery, XSD)

4. **Reutilización:**
   - Los XQuery de `Generales` son compartidos por múltiples servicios
   - Los esquemas de `EsquemasGenerales` son compartidos
   - Las validaciones (regional y H2H) son compartidas

5. **Mantenibilidad:**
   - Separación clara entre proxy, business services y recursos
   - Transformaciones XQuery independientes
   - Esquemas XSD versionados
