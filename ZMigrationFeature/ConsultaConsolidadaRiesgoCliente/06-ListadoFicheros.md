# Listado de Ficheros - ConsultaConsolidadaRiesgoCliente

## Proxies

### Proxy Principal
- `Middleware/v2/ProxyServices/ConsultaConsolidadaRiesgoCliente.proxy`

### Proxies Regionales
- `Middleware/v2/ProxyServices/ConsultaConsolidadaRiesgoClienteHN.proxy`

## Business Services

### Servicio Principal de Base de Datos
- `Middleware/v2/BusinessServices/DataWarehouse/consultaConsolidadaRiesgoCliente/biz/consultaConsolidadaRiesgoCliente_db.biz`
- `Middleware/v2/BusinessServices/DataWarehouse/consultaConsolidadaRiesgoCliente/jca/consultaConsolidadaRiesgoCliente_db.jca`
- `Middleware/v2/BusinessServices/DataWarehouse/consultaConsolidadaRiesgoCliente/wsdl/consultaConsolidadaRiesgoCliente.wsdl`
- `Middleware/v2/BusinessServices/DataWarehouse/consultaConsolidadaRiesgoCliente/wsdl/consultaConsolidadaRiesgoCliente_db.wsdl`
- `Middleware/v2/BusinessServices/DataWarehouse/consultaConsolidadaRiesgoCliente/xsd/consultaConsolidadaRiesgoCliente_sp.xsd`

## Pipelines

### Pipelines del Proxy Principal
- **ValidacionesGenerales_request** (pipeline interno en ConsultaConsolidadaRiesgoCliente.proxy)
  - Stage: ValidacionXSD
  - Stage: ConsultaRutaRegional
- **ValidacionesGenerales_response** (pipeline interno en ConsultaConsolidadaRiesgoCliente.proxy)
  - Stage: MapeoError
- **_onErrorHandler** (pipeline de error en ConsultaConsolidadaRiesgoCliente.proxy)
  - Stage: ManejoError

### Pipelines del Proxy Regional HN
- **HN_ConsultaConsolidadaRiesgoCliente_request** (pipeline interno en ConsultaConsolidadaRiesgoClienteHN.proxy)
  - Stage: ConsultaConsolidadRiesgoCliente
- **HN_ConsultaConsolidadaRiesgoCliente_response** (pipeline interno en ConsultaConsolidadaRiesgoClienteHN.proxy)
  - Stage: FujoSalida
- **_onErrorHandler** (pipeline de error en ConsultaConsolidadaRiesgoClienteHN.proxy)
  - Stage: ManejoError

## XQuery/XSLT

### Transformaciones Principales
- `Middleware/v2/Resources/ConsultaConsolidadaRiesgoCliente/xq/consultaConsolidadaRiesgoClienteIn.xq`
- `Middleware/v2/Resources/ConsultaConsolidadaRiesgoCliente/xq/consultaConsolidadaRiesgoClienteOut.xq`
- `Middleware/v2/Resources/ConsultaConsolidadaRiesgoCliente/xq/consultaConsolidadaRiesgoClienteHeaderOut.xq`

### Transformaciones de Apoyo (referenciadas)
- `Middleware/v2/Resources/Generales/xq/consultaRutaRegionalIn.xq`
- `Middleware/v2/Resources/Generales/xq/aplicarValoresPorDefectoRegion.xq`
- `Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageIn.xq`
- `Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageOut.xq`

### Transformaciones Duplicadas (en otros módulos)
- `Middleware/v2/Resources/ConsultaPrestamoATM/xq/consultaConsolidadaRiesgoClienteIn.xq`
- `Middleware/v2/Resources/ConsultaOfertaCreditoConsumo/xq/consultaConsolidadoRiesgoClienteIn.xq`

## Java Callouts

No se detectaron Java Callouts específicos para esta funcionalidad.

## POJOs

No se detectaron POJOs específicos para esta funcionalidad.

## Configuración

### Archivos WSDL
- `Middleware/v2/Resources/ConsultaConsolidadaRiesgoCliente/wsdl/consultaConsolidadaRiesgoClientePS.wsdl`

### Esquemas XSD
- `Middleware/v2/Resources/ConsultaConsolidadaRiesgoCliente/xsd/consultaConsolidadaRiesgoClienteTypes.xsd`
- `Middleware/v2/Resources/esquemas_generales/HeaderElements.xsd` (referenciado)

### Archivos JCA
- `Middleware/v2/BusinessServices/DataWarehouse/consultaConsolidadaRiesgoCliente/jca/consultaConsolidadaRiesgoCliente_db.jca`

## Properties

No se detectaron archivos .properties específicos para esta funcionalidad.

## Políticas

### Políticas de Seguridad
- Custom token authentication (configurada en ConsultaConsolidadaRiesgoCliente.proxy)
  - Username selector XPath
  - Password selector XPath

### Políticas de WS
- WS-Policy binding mode: wsdl-policy-attachments (ambos proxies)

## Tests Relevantes

### Archivos JAR de Testing/Deployment
- `JAR/2021.1.2.0/MAN-1501/PRD/MAN-1501_ConsultaConsolidadaRiesgoCliente.jar`
- `JAR/2021.1.2.0/MAN-1501/QA/MAN-1501_ConsultaConsolidadaRiesgoCliente.jar`
- `JAR/V.HN.MIGRACION.PROCESADOR/PG-5293/PRD/mwomnicanal_ConsultaConsolidadaRiesgoCliente.jar`
- `JAR/V.HN.MIGRACION.PROCESADOR/PG-5293/QA/mwomniqa_ConsultaConsolidadaRiesgoCliente.jar`

## Servicios de Dependencia

### Servicios de Enrutamiento
- `Middleware/v2/BusinessServices/MDW/consultaRutaRegional/biz/consultaRutaRegional_db.biz` (referenciado)

### Servicios de Mapeo de Errores
- `Middleware/v2/ProxyServices/MapeoErrores.proxy` (referenciado)

## Archivos de Configuración de Conexión

### Conexiones de Base de Datos
- Connection Factory: `eis/DB/ConnectionCustomerCreditRisk`
- Connection Name: `ConnectionCustomerCreditRisk`

## Estructura de Directorios Completa

```
Middleware/v2/
├── ProxyServices/
│   ├── ConsultaConsolidadaRiesgoCliente.proxy
│   └── ConsultaConsolidadaRiesgoClienteHN.proxy
├── BusinessServices/
│   └── DataWarehouse/
│       └── consultaConsolidadaRiesgoCliente/
│           ├── biz/
│           │   └── consultaConsolidadaRiesgoCliente_db.biz
│           ├── jca/
│           │   └── consultaConsolidadaRiesgoCliente_db.jca
│           ├── wsdl/
│           │   ├── consultaConsolidadaRiesgoCliente.wsdl
│           │   └── consultaConsolidadaRiesgoCliente_db.wsdl
│           └── xsd/
│               └── consultaConsolidadaRiesgoCliente_sp.xsd
└── Resources/
    └── ConsultaConsolidadaRiesgoCliente/
        ├── wsdl/
        │   └── consultaConsolidadaRiesgoClientePS.wsdl
        ├── xq/
        │   ├── consultaConsolidadaRiesgoClienteIn.xq
        │   ├── consultaConsolidadaRiesgoClienteOut.xq
        │   └── consultaConsolidadaRiesgoClienteHeaderOut.xq
        └── xsd/
            └── consultaConsolidadaRiesgoClienteTypes.xsd
```

## Archivos de Deployment/Versionado

### Archivos JAR por Ambiente
- **Producción (PRD)**:
  - `MAN-1501_ConsultaConsolidadaRiesgoCliente.jar`
  - `mwomnicanal_ConsultaConsolidadaRiesgoCliente.jar`
- **Quality Assurance (QA)**:
  - `MAN-1501_ConsultaConsolidadaRiesgoCliente.jar`
  - `mwomniqa_ConsultaConsolidadaRiesgoCliente.jar`

### Versiones Identificadas
- **MAN-1501**: Versión 2021.1.2.0
- **PG-5293**: Versión de migración Honduras

## Observaciones sobre Archivos

1. **Duplicación de Transformaciones**: Existen copias de `consultaConsolidadaRiesgoClienteIn.xq` en otros módulos, lo que sugiere reutilización o dependencias cruzadas.

2. **Versionado**: Los archivos JAR indican un proceso de versionado estructurado con separación por ambiente (PRD/QA).

3. **Migración Honduras**: Los archivos JAR con prefijo `mwomni*` sugieren una migración específica para Honduras.

4. **Estructura Estándar**: La organización de archivos sigue el patrón estándar de OSB con separación clara entre proxies, business services y resources.

5. **Dependencias Externas**: La funcionalidad depende de servicios generales como `consultaRutaRegional` y `MapeoErrores` que están fuera del módulo específico.