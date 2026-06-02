# Listado de Ficheros OSB – ConsultaConsolidadaRiesgoClienteHN

## Proxy Service

| Archivo | Ruta Completa |
|---------|---------------|
| ConsultaConsolidadaRiesgoClienteHN.proxy | `Middleware/v2/ProxyServices/ConsultaConsolidadaRiesgoClienteHN.proxy` |

## Business Service

| Archivo | Ruta Completa |
|---------|---------------|
| consultaConsolidadaRiesgoCliente_db.biz | `Middleware/v2/BusinessServices/DataWarehouse/consultaConsolidadaRiesgoCliente/biz/consultaConsolidadaRiesgoCliente_db.biz` |

## JCA Configuration

| Archivo | Ruta Completa |
|---------|---------------|
| consultaConsolidadaRiesgoCliente_db.jca | `Middleware/v2/BusinessServices/DataWarehouse/consultaConsolidadaRiesgoCliente/jca/consultaConsolidadaRiesgoCliente_db.jca` |

## WSDLs

| Archivo | Ruta Completa | Tipo |
|---------|---------------|------|
| consultaConsolidadaRiesgoClientePS.wsdl | `Middleware/v2/Resources/ConsultaConsolidadaRiesgoCliente/wsdl/consultaConsolidadaRiesgoClientePS.wsdl` | Proxy Service (público) |
| consultaConsolidadaRiesgoCliente.wsdl | `Middleware/v2/BusinessServices/DataWarehouse/consultaConsolidadaRiesgoCliente/wsdl/consultaConsolidadaRiesgoCliente.wsdl` | BIZ (abstract) |
| consultaConsolidadaRiesgoCliente_db.wsdl | `Middleware/v2/BusinessServices/DataWarehouse/consultaConsolidadaRiesgoCliente/wsdl/consultaConsolidadaRiesgoCliente_db.wsdl` | BIZ (concrete binding) |

## XSDs

| Archivo | Ruta Completa | Descripción |
|---------|---------------|-------------|
| consultaConsolidadaRiesgoClienteTypes.xsd | `Middleware/v2/Resources/ConsultaConsolidadaRiesgoCliente/xsd/consultaConsolidadaRiesgoClienteTypes.xsd` | Tipos request/response del proxy |
| consultaConsolidadaRiesgoCliente_sp.xsd | `Middleware/v2/BusinessServices/DataWarehouse/consultaConsolidadaRiesgoCliente/xsd/consultaConsolidadaRiesgoCliente_sp.xsd` | Schema InputParameters/OutputParameters del SP |

## XQueries

| Archivo | Ruta Completa | Función |
|---------|---------------|---------|
| consultaConsolidadaRiesgoClienteIn.xq | `Middleware/v2/Resources/ConsultaConsolidadaRiesgoCliente/xq/consultaConsolidadaRiesgoClienteIn.xq` | Transformación de entrada (CUSTOMER_LEGAL_ID → IDENTIDAD) |
| consultaConsolidadaRiesgoClienteOut.xq | `Middleware/v2/Resources/ConsultaConsolidadaRiesgoCliente/xq/consultaConsolidadaRiesgoClienteOut.xq` | Transformación de salida (XML plano → estructura tipada) |
| consultaConsolidadaRiesgoClienteHeaderOut.xq | `Middleware/v2/Resources/ConsultaConsolidadaRiesgoCliente/xq/consultaConsolidadaRiesgoClienteHeaderOut.xq` | Header de respuesta (Success / NO RECORS / ERROR) |

## Stored Procedure

| Archivo | Ubicación |
|---------|-----------|
| Consulta riesgos HN v2.txt | `ZMigrationFeature/ConsultaConsolidadaRiesgoCliente/V2/` |
| SP en BD | `CREDITOS_RIESGOS.dbo.p_consulta_ONBASE_V2` |
