# Resumen Ejecutivo - ValidaDepositoReferenciadoCB

## Índice de Documentación

1. [Resumen Ejecutivo](01-ResumenEjecutivo.md)
2. [Comparación entre Regiones](02-ComparativaRegiones.md)
3. [Ejemplos y Mapeos - HN01](03-EjemplosYMapeos-HN01.md)
4. [Diagrama de Secuencia - HN01](04-Secuencia-HN01.mmd)
5. [Flujo Multi-región](05-FlujoMultiregión.mmd)
6. [Listado de Ficheros](06-ListadoFicheros.md)
7. [Mapeo de Errores](07-MapeoErrores.md)

## Propósito de la Funcionalidad

La funcionalidad **ValidaDepositoReferenciadoCB** es un servicio OSB que permite validar depósitos referenciados para Corresponsales Bancarios (CB). Su objetivo principal es verificar la existencia y validez de un depósito referenciado mediante el número de cuenta y la información del documento (tipo y valor).

## Entradas y Salidas Principales

### Entrada (Request)
- **ACCOUNT**: Número de cuenta del depósito referenciado
- **DOCUMENT_INFO**: Información del documento
  - **TYPE**: Tipo de documento (`DOCUMENT_NUMBER` o `DEBTOR_CODE`)
  - **VALUE**: Valor del documento

### Salida (Response)
- **DOCUMENT_NUMBER**: Número de documento encontrado
- **ACCOUNT**: Cuenta validada
- **DEBTOR_INFO**: Lista de información de deudores
  - **ID**: Código del deudor
  - **NAME**: Nombre del deudor

## Sistemas/Servicios OSB Involucrados

1. **ValidaDepositoReferenciadoCB.proxy** - Proxy service principal (wrapper CB)
2. **DepositosReferenciados.proxy** - Router de operaciones de depósitos referenciados
3. **ValidaDepositoReferenciado.proxy** - Servicio core de validación
4. **ValidaDepositoReferenciado_db.biz** - Business service de base de datos
5. **MapeoErrores.proxy** - Servicio de mapeo de errores
6. **consultarCorresponsalB_db.biz** - Validación de corresponsal bancario

## Base de Datos y Stored Procedures

- **Conexión**: `eis/DB/ConnectionProxyAbanksHN` (Honduras)
- **Package**: `CBR_K_DEP_REFERENCIADOS`
- **Stored Procedure**: `CRB_P_VALIDAR_DEPOSITO_REF`
- **Esquema**: ABK (Abanks Honduras)

## Regiones Detectadas

- **HN01**: Honduras - Única región implementada
- **Otras regiones**: No implementadas (devuelven error MW-0008)

## Riesgos/Limitaciones Conocidas

1. **Limitación Regional**: Solo implementado para Honduras (HN01)
2. **Dependencia de Base de Datos**: Requiere conexión específica a Abanks Honduras
3. **Validación de Corresponsal**: Requiere validación previa del corresponsal bancario
4. **Códigos de Error Específicos**: 
   - `FICBCO0312` para errores del wrapper CB
   - `FICBCO0311` para errores del servicio core
5. **Manejo de Errores**: Si no se encuentran registros, retorna código `-1`

## Métricas o SLAs

- **Logging**: Habilitado en nivel `debug`
- **Monitoring**: Deshabilitado
- **SLA Alerting**: Habilitado en nivel `normal`
- **Pipeline Alerting**: Habilitado en nivel `normal`
- **Retry**: 0 reintentos configurados
- **Timeout**: 30 segundos de intervalo de reintento

## Códigos de Servicio

- **FICBCO0312**: Código de servicio para ValidaDepositoReferenciadoCB
- **FICBCO0311**: Código de servicio para ValidaDepositoReferenciado
- **Transacción Tipo 7**: Para validación de corresponsal bancario

## Arquitectura

La funcionalidad sigue un patrón de arquitectura en capas:
1. **Capa de Wrapper CB**: ValidaDepositoReferenciadoCB (interfaz específica para CB)
2. **Capa de Router**: DepositosReferenciados (enrutamiento por operación)
3. **Capa de Servicio**: ValidaDepositoReferenciado (lógica de negocio)
4. **Capa de Datos**: Business service con stored procedure

## Estado de Implementación

- ✅ **HN01 (Honduras)**: Completamente implementado
- ❌ **Otras regiones**: No implementadas (GT01, PA01, NI01, etc.)