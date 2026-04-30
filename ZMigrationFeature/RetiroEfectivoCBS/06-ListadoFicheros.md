# Listado de Ficheros - RetiroEfectivoCBS

## Proxies (Proxy Services)

### Proxy Principal
- `Middleware/v2/SProxyServices/RetiroEfectivoCBS.proxy`

### Proxies Relacionados
- `Middleware/v2/SProxyServices/ConsultaCuentaRetiroEfectivoCBS.proxy`
- `Middleware/v2/ProxyServices/MapeoErrores.proxy`
- `Middleware/v2/ProxyServices/ReversarTransaccion.proxy`

## Business Services

### Servicios de Base de Datos
- `Middleware/v2/BusinessServices/MDW/consultaComisionesCB/biz/consultaComisionesCB_db.biz`
- `Middleware/v2/BusinessServices/MDW/consultaComisionesCB/jca/consultaComisionesCB_db.jca`
- `Middleware/v2/BusinessServices/MDW/consultaComisionesCB/wsdl/consultaComisionesCB_db.wsdl`
- `Middleware/v2/BusinessServices/MDW/consultaComisionesCB/xsd/consultaComisionesCB_sp.xsd`

- `Middleware/v2/BusinessServices/ValidaServicioRegional/biz/ValidaServicioRegional_db.biz`
- `Middleware/v2/BusinessServices/MDW/consultarCorresponsalB/biz/consultarCorresponsalB_db.biz`
- `Middleware/v2/BusinessServices/MDW/registraEstadoTransaccion/biz/registraEstadoTransaccion_db.biz`
- `Middleware/v2/BusinessServices/MDW/ActualizaEstadoTransaccion/biz/actualizaEstadoTransaccion_db.biz`

### Servicios de Aplicación
- `Middleware/v2/BusinessServices/T24/svcRegistraTransaccionTengo/biz/svcRegistraTransaccionTengo.biz`
- `Middleware/v2/BusinessServices/T24/svcRegistraTransaccionTengo/wsdl/svcRegistraTransaccionTengo.wsdl`
- `Middleware/v2/BusinessServices/T24/svcRegistraTransaccionTengo/xsd/scvRegistraTransaccionTengoTypes.xsd`
- `Middleware/v2/BusinessServices/T24/svcRegistraTransaccionTengo/xsd/svcRegistraTransaccionTengoAnyTypes.xsd`

- `Middleware/Business_Resources/ConsultasCuenta/Resources/consultaCuentasBS.biz`
- `Middleware/Business_Resources/Transferencias/Resources/transferenciasBS.biz`

### Servicios de Registro y Control
- `Middleware/Business_Resources/general/Resources/RegistrarUsoServicio/registrarUsoServicio_db.biz`

## Pipelines

### Pipeline Principal
- Definido dentro de `Middleware/v2/SProxyServices/RetiroEfectivoCBS.proxy`:
  - `Validaciones_request`
  - `Validaciones_response`
  - `HN01_request`
  - `HN01_response`
  - `PipelinePairNode1_request`
  - `PipelinePairNode1_response`

## XQuery/XSLT (Transformaciones)

### Transformaciones de Entrada
- `Middleware/v2/Resources/RetiroEfectivoCBS/xq/consultaComisionesCBIn.xq`
- `Middleware/v2/Resources/RetiroEfectivoCBS/xq/retiroEfectivoConsultaSaldoCuentaIn.xq`
- `Middleware/v2/Resources/RetiroEfectivoCBS/xq/retiroEfectivoTengoT24In.xq`
- `Middleware/v2/Resources/RetiroEfectivoCBS/xq/retiroEfectivoTransferenciaCuentasIn.xq`
- `Middleware/v2/Resources/RetiroEfectivoCBS/xq/retiroEfectivoTransferenciaCuentasComisionIn.xq`

### Transformaciones de Salida
- `Middleware/v2/Resources/RetiroEfectivoCBS/xq/retiroEfectivoOut.xq`
- `Middleware/v2/Resources/RetiroEfectivoCBS/xq/retiroEfectivoHeaderOut.xq`

### Transformaciones de Control
- `Middleware/v2/Resources/RetiroEfectivoCBS/xq/registraEstadoTransaccion.xq`
- `Middleware/v2/Resources/RetiroEfectivoCBS/xq/actualizaEstadoTransaccion.xq`
- `Middleware/v2/Resources/RetiroEfectivoCBS/xq/obtenerParametrosTengo.xq`

### Transformaciones Generales (Dependencias)
- `Middleware/v2/Resources/Generales/xq/validaServicioRegionalIn.xq`
- `Middleware/v2/Resources/Generales/xq/aplicarValoresPorDefectoRegionCB.xq`
- `Middleware/v2/Resources/Genericos/consultarCorresponsalBIn.xq`
- `Middleware/Business_Resources/general/UsoServicio/registroUsoServicioIn.xq`
- `Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageIn.xq`
- `Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageOut.xq`
- `Middleware/Business_Resources/pagoPrestamo/reversarTransaccion/reversarTransaccionIn.xq`

## Java Callouts

### JARs de Despliegue
- `JAR/MDA-49958/PRD/MWAPP/MWAPP_RetiroEfectivoCBS.jar`
- `JAR/MDA-49958/PRD/MWINTERBANCA/MWINTERBANCA_RetiroEfectivoCBS.jar`
- `JAR/MDA-49958/QA/SOABUS/SOABUS_CA_RetiroEfectivoCBS.jar`

### JARs Relacionados
- `JAR/MDA-49958/QA/MWOMNIQA/MWOMNIQA_svcRegistraTransaccionTengo.jar`
- `JAR/MDA-49958/QA/SOABUS/SOABUS_svcRegistraTransaccionTengo.jar`

## Configuración

### WSDL Principal
- `Middleware/v2/Resources/RetiroEfectivoCBS/wsdl/retiroEfectivoCB_PS.wsdl`

### Esquemas XSD
- `Middleware/v2/Resources/RetiroEfectivoCBS/xsd/retiroEfectivoCBTypes.xsd`
- `Middleware/v2/Resources/esquemas_generales/HeaderElementsCB.xsd`

### Configuración de Conexiones JCA
- `Middleware/v2/BusinessServices/MDW/consultaComisionesCB/jca/consultaComisionesCB_db.jca`

## Properties

### Archivos de Propiedades (Inferidos)
- Configuración de conexiones de base de datos (ConnectionMiddleware)
- Configuración de credenciales LDAP para T24
- Configuración de endpoints por ambiente

## Políticas (Policies)

### Políticas de Seguridad
- Custom token authentication configurada en el proxy principal
- Políticas WSDL attachments habilitadas

### Políticas de Monitoreo
- SLA alerting configurado
- Pipeline alerting configurado
- Logging en nivel debug

## Tests Relevantes

### Tests Unitarios (No encontrados explícitamente)
- No se encontraron archivos de test específicos en la estructura analizada

### Tests de Integración (Inferidos)
- Tests incluidos en los JARs de despliegue
- Validaciones de esquema automáticas

## Archivos de Configuración Adicionales

### Configuración de Ambientes
- Configuración de endpoints T24 por ambiente
- Configuración de conexiones de base de datos por ambiente
- Configuración de credenciales por ambiente

### Configuración de Mapeo de Errores
- Configuración específica para código de servicio FICBCO0218
- Mapeo de errores de T24 a códigos OSB
- Mapeo de errores de base de datos a códigos de negocio

## Dependencias Externas

### Servicios Web Externos
- **T24 Web Services**: `http://10.242.104.55:7005/svcRegistraTransaccionTengo/services`

### Bases de Datos
- **Oracle Database**: Conexión `eis/DB/ConnectionMiddleware`
- **Stored Procedures**: `MW_P_CON_COMISION_CORBAN`

### Servicios OSB Internos
- Servicios de consulta de cuentas
- Servicios de transferencias
- Servicios de validación regional
- Servicios de mapeo de errores

## Archivos de Documentación

### Documentación Técnica (Generada)
- `01-ResumenEjecutivo.md`
- `02-ComparativaRegiones.md`
- `03-EjemplosYMapeos-HN01.md`
- `04-Secuencia-HN01.mmd`
- `05-FlujoMultiregión.mmd`
- `06-ListadoFicheros.md` (este archivo)
- `07-MapeoErrores.md`

## Observaciones

### Archivos Críticos para Migración
1. **Proxy Principal**: `RetiroEfectivoCBS.proxy` - Contiene toda la lógica de orquestación
2. **Transformaciones XQuery**: Todos los archivos .xq en la carpeta Resources/RetiroEfectivoCBS/xq/
3. **Esquemas**: `retiroEfectivoCBTypes.xsd` - Define el contrato de servicio
4. **Business Services**: Especialmente los de base de datos y T24

### Archivos de Configuración Sensibles
1. **Conexiones JCA**: Contienen configuración de base de datos
2. **Business Services T24**: Contienen endpoints y configuración de conectividad
3. **Configuración de Seguridad**: Credenciales y políticas de autenticación

### Archivos de Despliegue
1. **JARs**: Contienen la configuración compilada para cada ambiente
2. **WSDL**: Define el contrato público del servicio
3. **XSD**: Define la estructura de datos del servicio