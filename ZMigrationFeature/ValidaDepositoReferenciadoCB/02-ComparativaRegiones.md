# Comparación entre Regiones - ValidaDepositoReferenciadoCB

## Tabla de Comparación

| Aspecto | HN01 (Honduras) | Otras Regiones |
|---------|-----------------|----------------|
| **Endpoint OSB** | `/Middleware/OperationsAndExecution/CalculationServices/ValidaDepositoReferenciadoCB` | `/Middleware/OperationsAndExecution/CalculationServices/ValidaDepositoReferenciadoCB` |
| **Nombre de Base de Datos** | ConnectionProxyAbanksHN | No configurado |
| **Esquemas** | CBR_K_DEP_REFERENCIADOS | No disponible |
| **Store Procedure** | CRB_P_VALIDAR_DEPOSITO_REF | No disponible |
| **Nombre de Conexión a Base de datos u OSB** | jca://eis/DB/ConnectionProxyAbanksHN | No configurado |
| **Transformaciones clave** | validaDepositoReferenciadoIN.xq, validaDepositoReferenciadoOUT.xq, validaDepositoReferenciadoCBOUT.xq | No implementadas |
| **Campos diferenciadores** | Mapeo de DEBTOR_CODE a tipo 1, otros tipos a tipo 2 | No disponible |
| **Errores/Excepciones** | Códigos específicos: NO RECORDS (-1), FICBCO0311 | MW-0008: SERVICE NOT IMPLEMENTED |
| **Timeouts/Retrys** | Retry: 0, Interval: 30s, Application Errors: true | No configurado |
| **Dependencias internas** | ValidaServicioRegional, consultarCorresponsalB, MapeoErrores | MapeoErrores únicamente |

## Detalles por Región

### HN01 (Honduras) - Región Implementada

#### Endpoints y Configuración
- **Endpoint Principal**: `/Middleware/OperationsAndExecution/CalculationServices/ValidaDepositoReferenciadoCB`
- **Protocolo**: SOAP 1.1
- **Binding**: ValidaDepositoReferenciadoCBSOAP
- **Namespace**: `http://www.ficohsa.com.hn/middleware.services/ValidaDepositoReferenciadoCBTypes`

#### Mapeos y Transformaciones
1. **Transformación de Entrada**:
   - Mapeo directo de campos CB a formato interno
   - Validación de campos obligatorios (ACCOUNT, DOCUMENT_INFO.TYPE, DOCUMENT_INFO.VALUE)
   - Eliminación del campo BankingCorrespondent del header

2. **Transformación de Salida**:
   - Mapeo de arrays de deudores (PT_CODIGO_DEUDOR, PT_NOMBRE_DEUDOR)
   - Construcción de estructura DEBTOR_INFO con ID y NAME
   - Manejo condicional basado en successIndicator

#### Validaciones Específicas
1. **Validación de Corresponsal**:
   - Servicio: consultarCorresponsalB_db
   - Parámetros: transactionType="7", bankingCorrespId, sourceBank
   - Validación de código de retorno SUCCESS

2. **Validación de Servicio Regional**:
   - Servicio: ValidaServicioRegional_db
   - ServiceId: "FICBCO0311"
   - Validación por región y servicio

3. **Validación de Depósito**:
   - Stored Procedure: CRB_P_VALIDAR_DEPOSITO_REF
   - Package: CBR_K_DEP_REFERENCIADOS
   - Validación de código de retorno != "-1"

#### Políticas OSB
- **Autenticación**: Custom token con username/password desde header
- **Logging**: DEBUG level habilitado
- **Monitoring**: Pipeline level
- **SLA Alerting**: Normal level
- **Transacciones**: No requeridas

#### Handlers de Error
1. **Errores de Validación** (BEA-382505):
   - Uso de mapeoErrorValidate genérico
   
2. **Errores de Aplicación**:
   - Llamada a servicio MapeoErrores
   - Código de servicio: FICBCO0312 (CB) / FICBCO0311 (Core)
   - Formato de mensaje: "CODIGO$#$MENSAJE"

#### Dependencias Internas
1. **DepositosReferenciados** (Router):
   - Operación: validaDepositoReferenciado
   - Enrutamiento por operación SOAP

2. **ValidaDepositoReferenciado** (Core):
   - Pipeline específico HN01_request/HN01_response
   - Regionalización por SourceBank="HN01"

3. **Business Services**:
   - ValidaDepositoReferenciado_db (Oracle DB)
   - consultarCorresponsalB_db (Validación CB)
   - ValidaServicioRegional_db (Validación regional)

### Otras Regiones - No Implementadas

#### Comportamiento por Defecto
- **Pipeline**: DefaultBranchPP_request/DefaultBranchPP_response
- **Error Retornado**: MW-0008
- **Mensaje**: "SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY"

#### Configuración Mínima
- Mismo endpoint que HN01
- Misma configuración de seguridad y políticas
- Sin lógica de negocio específica
- Sin conexiones a base de datos regionales

## Diferencias Clave Identificadas

### 1. Implementación de Lógica de Negocio
- **HN01**: Implementación completa con validaciones y transformaciones
- **Otras**: Solo mensaje de error estándar

### 2. Conexiones a Base de Datos
- **HN01**: ConnectionProxyAbanksHN configurada y funcional
- **Otras**: Sin conexiones configuradas

### 3. Transformaciones de Datos
- **HN01**: XQuery específicas para mapeo de entrada y salida
- **Otras**: Sin transformaciones implementadas

### 4. Validaciones de Negocio
- **HN01**: Múltiples validaciones (corresponsal, servicio regional, depósito)
- **Otras**: Sin validaciones específicas

### 5. Manejo de Errores
- **HN01**: Mapeo detallado de errores con códigos específicos
- **Otras**: Error genérico de no implementación

## Recomendaciones para Implementación Regional

### Para Nuevas Regiones (GT01, PA01, NI01)
1. **Configurar conexiones de base de datos** específicas por región
2. **Implementar pipelines regionales** siguiendo el patrón HN01
3. **Adaptar stored procedures** según esquemas regionales
4. **Configurar validaciones** de corresponsal y servicio regional
5. **Implementar transformaciones** XQuery específicas si hay diferencias en formatos

### Consideraciones de Arquitectura
1. **Mantener consistencia** en interfaces CB
2. **Centralizar configuraciones** comunes
3. **Parametrizar diferencias** regionales
4. **Implementar logging** y monitoreo consistente