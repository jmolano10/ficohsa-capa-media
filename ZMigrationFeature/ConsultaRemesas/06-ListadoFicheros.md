# Listado de Ficheros - ConsultaRemesas

## Proxy Services

### Servicio Principal
- `Middleware/v2/ProxyServices/ConsultaRemesas.proxy`

### Servicios de Apoyo
- `Middleware/v2/ProxyServices/MapeoErrores.proxy`
- `Middleware/v2/ProxyServices/EvaluaListasCliente.proxy`

## Business Services

### Servicios de Base de Datos (MDW)
- `Middleware/v2/BusinessServices/MDW/obtenerTipoRemesadora/biz/ObtenerTipoRemesadora_db.biz`
- `Middleware/v2/BusinessServices/MDW/obtenerTipoRemesadora/jca/ObtenerTipoRemesadora_db.jca`
- `Middleware/v2/BusinessServices/MDW/obtenerTipoRemesadora/wsdl/ObtenerTipoRemesadora.wsdl`
- `Middleware/v2/BusinessServices/MDW/obtenerTipoRemesadora/wsdl/ObtenerTipoRemesadora_db.wsdl`
- `Middleware/v2/BusinessServices/MDW/obtenerTipoRemesadora/xsd/ObtenerTipoRemesadora_sp.xsd`

- `Middleware/v2/BusinessServices/MDW/obtenerCamposRemesasRel/biz/obtenerCamposRemesasRel_db.biz`
- `Middleware/v2/BusinessServices/MDW/obtenerCamposRemesasRel/jca/obtenerCamposRemesasRel_db.jca`
- `Middleware/v2/BusinessServices/MDW/obtenerCamposRemesasRel/wsdl/obtenerCamposRemesasRel.wsdl`
- `Middleware/v2/BusinessServices/MDW/obtenerCamposRemesasRel/wsdl/obtenerCamposRemesasRel_db.wsdl`
- `Middleware/v2/BusinessServices/MDW/obtenerCamposRemesasRel/xsd/obtenerCamposRemesasRel_sp.xsd`

### Servicios de Consulta de Remesas
- `Middleware/v2/BusinessServices/consultarRemLocalId/biz/consultarRemLocalId_db.biz`
- `Middleware/v2/BusinessServices/consultarRemFRemXPagador/biz/consultarRemFRemXPagador_db.biz`
- `Middleware/v2/BusinessServices/registraRelConsPagoRem/biz/ingresoRelConsPagoRem_db.biz`

### Servicios T24 y Resiliencia
- `Middleware/v2/BusinessServices/Remesas/biz/sjConsultaRemesaResiliencia.biz`
- `Middleware/v2/BusinessServices/Remesas/flow/sjConsultaRemesaResiliencia.flow`
- `Middleware/v2/BusinessServices/Remesas/wsdl/sjConsultaRemesaResiliencia.wsdl`

### Servicios SJS (Split-Join)
- `Middleware/v2/BusinessServices/SJS/consultaMultipleRemesadoras/biz/sjConsultaMultipleRemesadoras.biz`
- `Middleware/v2/BusinessServices/SJS/consultaMultipleRemesadoras/flow/sjConsultaMultipleRemesadoras.flow`
- `Middleware/v2/BusinessServices/SJS/consultaMultipleRemesadoras/wsdl/sjConsultaMultipleRemesadoras.wsdl`
- `Middleware/v2/BusinessServices/SJS/consultaMultipleRemesadoras/xsd/sjConsultaMultipleRemesadoras.xsd`

### Servicios de Validación
- `Middleware/v2/BusinessServices/ValidaServicioRegional/biz/ValidaServicioRegional_db.biz`

### Servicios de Parametrización
- `Middleware/Business_Resources/general/Resources/ObtenerParametrizacion/ObtenerParametrizacion.biz`

## Resources y Transformaciones

### WSDL Principal
- `Middleware/v2/Resources/ConsultaRemesas/wsdl/consultaRemesasPS.wsdl`

### XSD (Esquemas)
- `Middleware/v2/Resources/ConsultaRemesas/xsd/consultaRemesasTypes.xsd`

### XQuery - Validaciones y Entrada
- `Middleware/v2/Resources/ConsultaRemesas/xq/validarTipoConsulta.xq`
- `Middleware/v2/Resources/ConsultaRemesas/xq/obtenerTipoRemesadoraIn.xq`
- `Middleware/v2/Resources/ConsultaRemesas/xq/obtenerCamposRemesasRelIn.xq`

### XQuery - Transformaciones de Entrada por Tipo
- `Middleware/v2/Resources/ConsultaRemesas/xq/consultaRemesaT24In.xq`
- `Middleware/v2/Resources/ConsultaRemesas/xq/consultaRemLocalIdIn.xq`
- `Middleware/v2/Resources/ConsultaRemesas/xq/consultaFRemPagIdIn.xq`
- `Middleware/v2/Resources/ConsultaRemesas/xq/sjconsultaMultipleRemesadorasIn.xq`

### XQuery - Transformaciones de Salida por Tipo
- `Middleware/v2/Resources/ConsultaRemesas/xq/consultaRemesasOut.xq`
- `Middleware/v2/Resources/ConsultaRemesas/xq/consultaRemLocalIdOut.xq`
- `Middleware/v2/Resources/ConsultaRemesas/xq/consultaRemFRemIdOut.xq`
- `Middleware/v2/Resources/ConsultaRemesas/xq/EnrutadorConveniosOut.xq`

### XQuery - Headers de Respuesta
- `Middleware/v2/Resources/ConsultaRemesas/xq/consultaRemLocalIdHeaderOut.xq`
- `Middleware/v2/Resources/ConsultaRemesas/xq/consultaFRemHeadersOut.xq`

### XQuery - Auditoría y Registro
- `Middleware/v2/Resources/ConsultaRemesas/xq/ingresoRelConsPagoRem.xq`
- `Middleware/v2/Resources/ConsultaRemesas/xq/ingresoRelConsPagFRem.xq`
- `Middleware/v2/Resources/ConsultaRemesas/xq/ingRelConsPagoConv.xq`
- `Middleware/v2/Resources/ConsultaRemesas/xq/generaEntradaRelConsPagoConv.xq`

### XQuery - SJS Específicos
- `Middleware/v2/BusinessServices/SJS/consultaMultipleRemesadoras/xq/armarInfoParametrosRemesas.xq`
- `Middleware/v2/BusinessServices/SJS/consultaMultipleRemesadoras/xq/enrutadorConveniosIn.xq`
- `Middleware/v2/BusinessServices/SJS/consultaMultipleRemesadoras/xq/sjConsultaMultipleRemesadoraOut.xq`

## Business Resources

### Validaciones de Remesas
- `Middleware/Business_Resources/remesas/ConsultaRemesas/validarTipoRemesaLocal.xq`
- `Middleware/Business_Resources/remesas/ConsultaRemesas/validarOrigenRemesaLocal.xq`
- `Middleware/Business_Resources/remesas/ConsultaRemesas/consultaRemesasHeaderOut.xq`
- `Middleware/Business_Resources/remesas/ConsultaRemesas/EnrutadorConveniosHeaderOut.xq`

### Parametrización General
- `Middleware/Business_Resources/general/Parametrizacion/obtenerParametrizacionIn.xq`

### Validación Regional
- `Middleware/v2/Resources/Generales/xq/validaServicioRegionalIn.xq`
- `Middleware/v2/Resources/Generales/xq/aplicarValoresPorDefectoRegion.xq`

### Mapeo de Errores
- `Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageIn.xq`
- `Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageOut.xq`

### Evaluación de Listas
- `Middleware/v2/Resources/EvaluaListasCliente/xq/evaluaListasClienteConsultaRemesaIn.xq`

## Configuraciones y Políticas

### Alertas
- `Middleware/Alerts/MaxTime500.alert`

### Esquemas Generales
- `Middleware/v2/Resources/esquemas_generales/HeaderElements.xsd`

### Security Aliases (Referenciados)
- `Middleware/Security/SRV-ITRMSS.sa` (Remesas)
- `Middleware/Security/HNKEYSTOREWEBSERVICES.sa` (Certificados)

## Archivos de Configuración JCA

### Conexiones de Base de Datos
- `Middleware/v2/BusinessServices/MDW/obtenerTipoRemesadora/jca/ObtenerTipoRemesadora_db.jca`
- `Middleware/v2/BusinessServices/MDW/obtenerCamposRemesasRel/jca/obtenerCamposRemesasRel_db.jca`
- `Middleware/v2/BusinessServices/consultarRemLocalId/jca/consultarRemLocalId_db.jca`
- `Middleware/v2/BusinessServices/consultarRemFRemXPagador/jca/consultarRemFRemXPagador_db.jca`
- `Middleware/v2/BusinessServices/registraRelConsPagoRem/jca/ingresoRelConsPagoRem_db.jca`

## Archivos de Pruebas (Si existen)

### Tests Unitarios
- No encontrados archivos de test específicos para ConsultaRemesas

### Datos de Prueba
- No encontrados archivos de datos de prueba específicos

## Archivos de Documentación

### Documentación Técnica
- No encontrados archivos de documentación específicos en el repositorio

## Dependencias Externas Referenciadas

### Sistemas Core
- **T24**: Sistema core banking (conexión externa)
- **FLink**: Base de datos auxiliar (conexión JCA)
- **SJS**: Servicio Split-Join para remesadoras online

### Servicios Web Externos
- **Moneygram**: Remesadora online
- **Western Union**: Remesadora online  
- **Uniteller**: Remesadora online
- **Otros**: Según configuración en BD

## Archivos de Configuración de Entorno

### Conexiones
- `ConnectionMiddleware` (Pool de conexiones JCA)

### Endpoints
- Configurados en WSDL y archivos .biz
- URLs específicas por ambiente (DEV, QA, PROD)

## Resumen de Conteo de Archivos

| Tipo de Archivo | Cantidad | Ubicación Principal |
|------------------|----------|-------------------|
| **Proxy Services** | 3 | `v2/ProxyServices/` |
| **Business Services** | 15+ | `v2/BusinessServices/` |
| **WSDL** | 10+ | Múltiples ubicaciones |
| **XSD** | 8+ | Múltiples ubicaciones |
| **XQuery** | 25+ | `v2/Resources/` y `Business_Resources/` |
| **JCA** | 5+ | Dentro de Business Services |
| **Flows** | 2 | `v2/BusinessServices/` |
| **Alerts** | 1 | `Alerts/` |
| **Security** | 2+ | `Security/` |

**Total Estimado**: 70+ archivos directamente relacionados con la funcionalidad ConsultaRemesas

## Notas Importantes

1. **Rutas Relativas**: Todas las rutas son relativas desde el directorio raíz del proyecto OSB
2. **Archivos Generados**: Algunos archivos .biz y .jca pueden ser generados automáticamente por OSB
3. **Dependencias Implícitas**: Existen dependencias con archivos de configuración de servidor y pools de conexión
4. **Archivos de Ambiente**: Las configuraciones específicas de ambiente no están incluidas en este listado
5. **Versioning**: Algunos archivos pueden tener versiones múltiples (ej: obtenerTipoRemesadora vs obtenerTipoRemesadora_1)