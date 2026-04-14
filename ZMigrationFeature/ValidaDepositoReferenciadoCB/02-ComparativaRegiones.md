# Comparación entre Regiones - ValidaDepositoReferenciadoCB

## Tabla de Comparación

| Aspecto | HN01 (Honduras) | Otras Regiones |
|---------|-----------------|----------------|
| **Endpoint OSB** | `/Middleware/OperationsAndExecution/CalculationServices/ValidaDepositoReferenciadoCB` | No implementado |
| **Nombre de Base de Datos** | ConnectionProxyAbanksHN | No aplica |
| **Esquemas** | ABK | No aplica |
| **Store Procedure** | `CBR_K_DEP_REFERENCIADOS.CRB_P_VALIDAR_DEPOSITO_REF` | No aplica |
| **Nombre de Conexión a Base de datos** | `eis/DB/ConnectionProxyAbanksHN` | No aplica |
| **Transformaciones clave** | validaDepositoReferenciadoIN.xq, validaDepositoReferenciadoOUT.xq, validaDepositoReferenciadoCBOUT.xq | No aplica |
| **Campos diferenciadores** | Mapeo de tipos de documento (DEBTOR_CODE=1, DOCUMENT_NUMBER=2) | No aplica |
| **Errores/Excepciones** | FICBCO0311, NO RECORDS, NO ACCOUNT, NO DOCUMENT TYPE, NO DOCUMENT VALUE | MW-0008 (SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY) |
| **Timeouts/Retrys** | 0 reintentos, 30s intervalo | No aplica |
| **Dependencias internas** | ValidaServicioRegional_db, consultarCorresponsalB_db, MapeoErrores | No aplica |

## Sección por Región

### HN01 (Honduras) - Implementación Completa

#### Endpoints
- **Proxy Principal**: `ValidaDepositoReferenciadoCB.proxy`
- **URI**: `/Middleware/OperationsAndExecution/CalculationServices/ValidaDepositoReferenciadoCB`
- **Protocolo**: SOAP 1.1
- **Binding**: ValidaDepositoReferenciadoCBSOAP

#### Mapeos y Transformaciones
- **Entrada**: Mapeo de `validaDepositoReferenciadoCBRequest` a `validaDepositoReferenciado`
- **Salida**: Transformación con `validaDepositoReferenciadoCBOUT.xq`
- **Tipos de Documento**:
  - `DEBTOR_CODE` → `PV_TIPO_DOCUMENTO = 1`
  - `DOCUMENT_NUMBER` → `PV_TIPO_DOCUMENTO = 2`

#### Validaciones
1. **Validación de Esquema**: Contra `validaDepositoReferenciadoCBTypes.xsd`
2. **Validación de Campos Obligatorios**:
   - ACCOUNT no vacío
   - DOCUMENT_INFO.TYPE no vacío
   - DOCUMENT_INFO.VALUE no vacío
3. **Validación de Corresponsal**: Transacción tipo 7 con `consultarCorresponsalB_db`
4. **Validación de Servicio Regional**: Código de servicio `FICBCO0311`

#### Políticas OSB
- **Seguridad**: Custom token authentication (username/password desde header)
- **Logging**: Habilitado en nivel debug
- **Monitoring**: Deshabilitado
- **SLA Alerting**: Habilitado nivel normal
- **Pipeline Alerting**: Habilitado nivel normal

#### Handlers de Error
- **BEA-382505**: Mapeo con `mapeoErrorValidate`
- **Otros errores**: Mapeo con servicio `MapeoErrores`
- **Código de servicio**: `FICBCO0312` para errores del wrapper CB

#### Base de Datos
- **Conexión**: `eis/DB/ConnectionProxyAbanksHN`
- **Package**: `CBR_K_DEP_REFERENCIADOS`
- **Procedure**: `CRB_P_VALIDAR_DEPOSITO_REF`
- **Parámetros de Entrada**:
  - `PV_NUMERO_CUENTA`: Número de cuenta
  - `PV_TIPO_DOCUMENTO`: Tipo de documento (1 o 2)
  - `PV_DOCUMENTO`: Valor del documento
- **Parámetros de Salida**:
  - `PV_NUMERO_DOCUMENTO`: Número de documento
  - `PV_CUENTA`: Cuenta validada
  - `PT_CODIGO_DEUDOR`: Array de códigos de deudor
  - `PT_NOMBRE_DEUDOR`: Array de nombres de deudor
  - `PV_CODIGO_ERROR`: Código de error
  - `PV_CODIGO_RETORNO`: Código de retorno
  - `PV_MENSAJE_ERROR`: Mensaje de error

### Otras Regiones (GT01, PA01, NI01, etc.) - No Implementadas

#### Comportamiento
- **Flujo**: Se ejecuta el pipeline `DefaultBranchPP`
- **Error Retornado**: `MW-0008`
- **Mensaje**: "SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY"
- **Respuesta**: Body vacío con header de error

#### Endpoints
- **Mismo endpoint**: Comparten el mismo proxy service
- **Diferenciación**: Por header `Region/SourceBank`

#### Limitaciones
- No hay implementación específica para otras regiones
- No hay conexiones de base de datos configuradas
- No hay stored procedures definidos
- No hay transformaciones específicas

## Diferencias Clave Identificadas

1. **Implementación Regional**: Solo HN01 tiene implementación completa
2. **Base de Datos**: Conexión específica solo para Honduras
3. **Stored Procedures**: Solo definidos para el esquema ABK de Honduras
4. **Validaciones**: Validación de corresponsal y servicio regional solo para HN01
5. **Transformaciones**: XQuery específicos solo para HN01
6. **Manejo de Errores**: Códigos de error específicos vs error genérico de no implementación

## Recomendaciones para Migración

1. **Identificar Regiones Objetivo**: Determinar qué regiones requieren implementación
2. **Configurar Conexiones**: Establecer conexiones de base de datos por región
3. **Crear Stored Procedures**: Implementar procedimientos equivalentes en cada región
4. **Adaptar Transformaciones**: Crear XQuery específicos si hay diferencias regionales
5. **Configurar Validaciones**: Implementar validaciones de corresponsal por región
6. **Testing Regional**: Probar cada región independientemente