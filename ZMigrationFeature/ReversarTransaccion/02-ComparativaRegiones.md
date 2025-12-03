# Comparativa entre Regiones - ReversarTransaccion

## Regiones Detectadas

Basado en el análisis del código fuente, se identificaron las siguientes regiones:

1. **HN01** - Honduras (Región principal implementada)
2. **GT01** - Guatemala (Referencias encontradas en archivos)
3. **PA01** - Panamá (Referencias encontradas en archivos)
4. **NI01** - Nicaragua (Referencias encontradas en archivos)

## Tabla de Comparación por Región

| Aspecto | HN01 (Honduras) | GT01 (Guatemala) | PA01 (Panamá) | NI01 (Nicaragua) |
|---------|-----------------|------------------|---------------|------------------|
| **Endpoint OSB** | `/Middleware/OperationsAndExecution/CustomerDeposits/ReversarTransaccion_v2` | No encontrado | No encontrado | No encontrado |
| **Nombre de Base de Datos** | T24 Core Banking | No encontrado | No encontrado | No encontrado |
| **Esquemas** | Múltiples esquemas por tipo de transacción | No encontrado | No encontrado | No encontrado |
| **Store Procedures** | `registrarReversionTCCB`, `validarEstadoTransaccion`, `actualizarEstadoTransaccionUUID` | No encontrado | No encontrado | No encontrado |
| **Nombre de Conexión BD/OSB** | `svcReversarTransaccionCB`, `registrarReversionTCCB_db` | No encontrado | No encontrado | No encontrado |
| **Transformaciones Clave** | XQuery para cada tipo de transacción | No encontrado | No encontrado | No encontrado |
| **Campos Diferenciadores** | `SourceBank=HN01`, validación regional | No implementado | No implementado | No implementado |
| **Errores/Excepciones** | Manejo completo de errores con mapeo | No implementado | No implementado | No implementado |
| **Timeouts/Retrys** | Configuración estándar OSB | No implementado | No implementado | No implementado |
| **Dependencias Internas** | T24, Core Banking, Abanks | No implementado | No implementado | No implementado |

## Detalles por Región

### HN01 (Honduras) - Región Completamente Implementada

#### Endpoints y Servicios
- **Proxy Service Principal**: `ReversarTransaccion.proxy` (v2)
- **Endpoint**: `/Middleware/OperationsAndExecution/CustomerDeposits/ReversarTransaccion_v2`
- **Validación Regional**: Servicio `ValidaServicioRegional` con ID `FICBCO0084`
- **Regionalización**: Branch condition `SourceBank = 'HN01'`

#### Mapeos y Transformaciones
- **Transformaciones XQuery**: Específicas por tipo de transacción
  - `reversarTransaccionFTIn.xq` - Fondos Transfer
  - `reversarTransaccionTTIn.xq` - Teller Transfer
  - `reversarTransaccionPagoChequeIn.xq` - Pago de cheques
  - `reversarTransaccionPagooRetiroTCIn.xq` - Pago/Retiro TC
  - `AutorizarReversionFTIn.xq` - Autorización FT
  - `AutorizarReversionTTIn.xq` - Autorización TT

#### Validaciones y Reglas de Negocio
- **Validación XSD**: `reversarTransaccionTypes.xsd`
- **Validación Regional**: Consulta a BD regional
- **Estados de Transacción**: Validación de estado antes de reversión
- **Autorización Dual**: Para ciertos tipos de transacción

#### Conexiones de Base de Datos
- **T24 Core Banking**: Conexión principal
- **Core Banking CB**: `registrarReversionTCCB_db`
- **Validaciones**: `ValidaServicioRegional_db`
- **Estados**: `validarEstadoTransaccion_db`

#### Manejo de Errores
- **Mapeo de Errores**: Servicio `MapeoErrores`
- **Códigos de Error**: Específicos por tipo de operación
- **Logging**: Nivel debug habilitado
- **Alertas**: SLA alerting configurado

### GT01, PA01, NI01 (Guatemala, Panamá, Nicaragua) - No Implementadas

#### Estado Actual
- **Implementación**: No encontrada implementación específica
- **Endpoint**: Redirige a pipeline por defecto
- **Respuesta**: "SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY"
- **Error Code**: MW-0008

#### Pipeline por Defecto
```xml
<con5:Error>
    <con5:errCode>MW-0008</con5:errCode>
    <con5:message>SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY</con5:message>
</con5:Error>
```

## Diferencias Clave Identificadas

### Arquitectura
1. **HN01**: Arquitectura completa con múltiples business services y validaciones
2. **Otras Regiones**: Solo pipeline de error por defecto

### Tipos de Transacción Soportados
1. **HN01**: Soporte completo para todos los tipos
   - CHEQUE_PAYMENT
   - CREDIT_CARD_PAYMENT
   - CREDIT_CARD_TFS
   - REF_COLLECTION
   - PROPTAX_COLLECTION
   - ONLINE_COLLECTION
   - LOCAL_COLLECTION
   - ABANKS_COLLECTION
   - LOAN_PAYMENT
2. **Otras Regiones**: Ningún tipo soportado

### Integración con Sistemas Backend
1. **HN01**: 
   - T24 Core Banking
   - Core Banking CB
   - Sistema Abanks
   - Base de datos regional
2. **Otras Regiones**: Sin integraciones

### Validaciones y Seguridad
1. **HN01**:
   - Autenticación custom token
   - Validación XSD
   - Validación regional
   - Validación de estados
2. **Otras Regiones**: Sin validaciones específicas

## Recomendaciones para Implementación Regional

### Para GT01, PA01, NI01
1. **Replicar Arquitectura HN01**: Usar como base la implementación de Honduras
2. **Adaptar Conexiones**: Configurar conexiones específicas por región
3. **Personalizar Validaciones**: Implementar reglas de negocio locales
4. **Configurar Endpoints**: Definir endpoints específicos por país
5. **Mapear Errores**: Implementar mapeo de errores en idioma local

### Consideraciones de Migración
1. **Fase 1**: Implementar funcionalidad básica por región
2. **Fase 2**: Agregar tipos de transacción específicos
3. **Fase 3**: Optimizar y personalizar por mercado local
4. **Fase 4**: Integrar con sistemas locales específicos