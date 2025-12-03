# Listado de Ficheros - ActualizaDisponibleVentaMonedaExtranjera

## Proxy Services

### Servicios Principales
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/ProxyServices/ActualizaDisponibleVentaMonedaExtranjera.proxy`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/ProxyServices/ActualizaDisponibleVentaMonedaExtranjeraHN.proxy`

### Servicios de Soporte
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/ProxyServices/MapeoErrores.proxy`

## Business Services

### Servicios de Base de Datos
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/MDW/consultaRutaRegional/biz/consultaRutaRegional_db.biz`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/MDW/consultaRutaRegional/jca/consultaRutaRegional_db.jca`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/MDW/consultaRutaRegional/wsdl/consultaRutaRegional.wsdl`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/MDW/consultaRutaRegional/wsdl/consultaRutaRegional_db.wsdl`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/MDW/consultaRutaRegional/xsd/consultaRutaRegional_sp.xsd`

### Servicios T24
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/T24/MercadoLibre/biz/mercadoLibre.biz`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/T24/MercadoLibre/wsdl/services.wsdl`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/T24/MercadoLibre/xsd/XMLSchema_161558775.xsd`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/T24/MercadoLibre/xsd/XMLSchema_454961782.xsd`

## Recursos de Transformación

### XQuery - Funcionalidad Principal
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/ActualizaDisponibleVentaMonedaExtranjera/xq/actualizaDisponibleMonedaFCYIn.xq`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/ActualizaDisponibleVentaMonedaExtranjera/xq/actualizaDisponibleVentaMonedaExtranjeraOut.xq`

### XQuery - Servicios Generales
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/Generales/xq/consultaRutaRegionalIn.xq`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/Generales/xq/aplicarValoresPorDefectoRegion.xq`

### XQuery - Mapeo de Errores
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageIn.xq`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageOut.xq`

## Esquemas XSD

### Esquemas Principales
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/ActualizaDisponibleVentaMonedaExtranjera/xsd/actualizaDisponibleVentaMonedaExtranjeraTypes.xsd`

### Esquemas de Soporte
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/esquemas_generales/HeaderElements.xsd`

## WSDL

### WSDL Principales
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/Resources/ActualizaDisponibleVentaMonedaExtranjera/wsdl/actualizaDisponibleVentaMonedaExtranjeraPS.wsdl`

## Archivos de Configuración

### Properties y Configuración
- No se encontraron archivos .properties específicos para esta funcionalidad
- Configuración de endpoints embebida en archivos .biz
- Configuración de seguridad en LDAP (referenciada en XQuery)

## Políticas de Seguridad

### Configuración de Autenticación
- Configuración de autenticación personalizada embebida en proxy principal
- Referencias a LDAP para lookup de credenciales en XQuery
- Configuración SSL/HTTPS en endpoints

## Tests Relevantes

### Tests Unitarios
- No se encontraron tests específicos en el repositorio analizado

### Tests de Integración
- No se encontraron tests de integración específicos

## Archivos JAR de Despliegue

### Versiones de Producción
- `Fuentes/ficohsacore-osb-7e5cceccb837/JAR/2022.02.2.0/PG-3815/PRD/mwapp _ActualizaDisponibleVentaMonedaExtranjera.jar`
- `Fuentes/ficohsacore-osb-7e5cceccb837/JAR/2022.02.2.0/PG-3815/PRD/mwinterbanca _ActualizaDisponibleVentaMonedaExtranjera.jar`

### Versiones de QA
- `Fuentes/ficohsacore-osb-7e5cceccb837/JAR/2022.02.2.0/PG-3815/QA/mwsoabus_ActualizaDisponibleVentaMonedaExtranjera.jar`

## Archivos de Configuración JCA

### Adaptadores de Base de Datos
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/v2/BusinessServices/MDW/consultaRutaRegional/jca/consultaRutaRegional_db.jca`

## Dependencias Externas Identificadas

### Servicios OSB Dependientes
- MapeoErrores.proxy (para manejo de errores)
- Servicios de validación regional (referenciados pero no encontrados)

### Sistemas Backend
- T24 MercadoLibre (endpoint: http://172.23.13.19:7003/svcMercadoLibre/services)
- Base de datos Middleware (conexión: jca://eis/DB/ConnectionMiddleware)
- LDAP Security (path: Middleware/Security/)

### Stored Procedures
- MW_P_CONSULTA_RUTA_REGIONAL (referenciado en configuración JCA)

## Archivos de Proyecto OSB

### Archivos de Configuración de Proyecto
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/.project`
- `Fuentes/ficohsacore-osb-7e5cceccb837/Middleware/.settings/` (directorio)

## Funciones Personalizadas Identificadas

### Funciones XQuery Específicas
- `getUsername()` - Lookup de credenciales en LDAP
- `getPassword()` - Lookup de password en LDAP
- `date-to-string()` - Conversión de fecha a formato YYYYMMDD

## Resumen de Conteo de Archivos

| Tipo de Archivo | Cantidad | Observaciones |
|-----------------|----------|---------------|
| Proxy Services | 2 | Principal + HN específico |
| Business Services | 2 | consultaRutaRegional + mercadoLibre |
| XQuery Files | 6 | Transformaciones principales y de soporte |
| XSD Schemas | 4 | Tipos principales + esquemas T24 |
| WSDL Files | 3 | Principal + servicios backend |
| JCA Files | 1 | Configuración DB adapter |
| JAR Files | 3 | Despliegues PRD y QA |
| **Total** | **21** | Archivos principales identificados |

## Archivos No Encontrados (Esperados)

### Proxies Regionales Específicos
- ActualizaDisponibleVentaMonedaExtranjeraGT.proxy (referenciado en enrutamiento)
- ActualizaDisponibleVentaMonedaExtranjeraPA.proxy (inferido)
- ActualizaDisponibleVentaMonedaExtranjeraNI.proxy (inferido)

### Configuración Regional
- Archivos de configuración específicos por región
- Properties files para endpoints regionales
- Configuración de timeouts y políticas por región

### Tests
- Tests unitarios para XQuery transformations
- Tests de integración para flujos completos
- Tests de carga y rendimiento
- Tests específicos para validación de deals

## Diferencias con ConsultaDisponibleVentaMonedaExtranjera

### Archivos Únicos de ActualizaDisponibleVentaMonedaExtranjera
- `actualizaDisponibleMonedaFCYIn.xq` (vs `consultaMontoDisponibleVentaDolarIn.xq`)
- `actualizaDisponibleVentaMonedaExtranjeraOut.xq` (vs `consultaDisponibleVentaMonedaExtranjeraOut.xq`)
- `actualizaDisponibleVentaMonedaExtranjeraTypes.xsd` (vs `consultaDisponibleVentaMonedaExtranjeraTypes.xsd`)
- `actualizaDisponibleVentaMonedaExtranjeraPS.wsdl` (vs `consultaDisponibleVentaMonedaExtranjeraPS.wsdl`)

### Complejidad Adicional
- **Campos de Entrada**: 8 campos vs 1 campo
- **Validaciones**: Más estrictas por ser operación de escritura
- **Transformaciones**: Más complejas con conversión de fechas
- **Funciones**: Función adicional `date-to-string()`

### ID de Servicio
- **ActualizaDisponibleVentaMonedaExtranjera**: FICBCO0439
- **ConsultaDisponibleVentaMonedaExtranjera**: FICBCO0434

## Notas de Migración

### Archivos Críticos para Migración
1. **Proxies principales**: Ambos proxy services son esenciales
2. **Business services**: consultaRutaRegional_db es crítico para enrutamiento
3. **XQuery transformations**: Todas las transformaciones deben migrarse, especialmente las funciones personalizadas
4. **Esquemas XSD**: Validación de contratos con 8 campos
5. **Configuración JCA**: Conectividad con base de datos

### Archivos de Configuración Específica
- Endpoints de T24 (embebidos en .biz files)
- Conexiones de base de datos (en archivos JCA)
- Configuración LDAP (referenciada en XQuery)
- Certificados SSL (no encontrados en código fuente)

### Validaciones Adicionales Requeridas
- Validar operación `ActualizaDisponibleMonedaFCY` en T24 destino
- Confirmar estructura `FICOFXDEALSTXNINPUTType` en T24
- Validar función `date-to-string()` en ambiente destino
- Confirmar configuración de deals y estados válidos

### Orden Sugerido de Migración
1. Esquemas XSD y WSDL (con 8 campos)
2. Business services (consultaRutaRegional primero)
3. XQuery transformations (incluyendo funciones personalizadas)
4. Proxy services (HN específico primero para testing)
5. Configuración de seguridad y endpoints
6. Tests de conectividad y funcionalidad
7. Validación de deals y operaciones T24

### Consideraciones Especiales
- **Operación de Escritura**: Mayor cuidado en testing por impacto en datos
- **Gestión de Fechas**: Validar conversión de fechas en ambiente destino
- **Deals**: Confirmar estructura y estados de deals en T24 destino
- **Rollback**: Preparar mecanismo de rollback para operaciones fallidas
- **Auditoría**: Implementar logging detallado para operaciones de actualización