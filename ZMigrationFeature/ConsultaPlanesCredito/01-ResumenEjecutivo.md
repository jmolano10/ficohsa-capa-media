# Resumen Ejecutivo - ConsultaPlanesCredito

## Índice de Documentos
- [01-ResumenEjecutivo.md](./01-ResumenEjecutivo.md)
- [02-ComparativaRegiones.md](./02-ComparativaRegiones.md)
- [03-EjemplosYMapeos-GT01.md](./03-EjemplosYMapeos-GT01.md)
- [03-EjemplosYMapeos-HN01.md](./03-EjemplosYMapeos-HN01.md)
- [03-EjemplosYMapeos-NI01.md](./03-EjemplosYMapeos-NI01.md)
- [03-EjemplosYMapeos-PA01.md](./03-EjemplosYMapeos-PA01.md)
- [04-Secuencia-GT01.mmd](./04-Secuencia-GT01.mmd)
- [04-Secuencia-HN01.mmd](./04-Secuencia-HN01.mmd)
- [04-Secuencia-NI01.mmd](./04-Secuencia-NI01.mmd)
- [04-Secuencia-PA01.mmd](./04-Secuencia-PA01.mmd)
- [05-FlujoMultiregión.mmd](./05-FlujoMultiregión.mmd)
- [06-ListadoFicheros.md](./06-ListadoFicheros.md)
- [07-MapeoErrores.md](./07-MapeoErrores.md)

## Propósito de la Funcionalidad

La funcionalidad **ConsultaPlanesCredito** permite consultar los planes de crédito asociados a una cuenta de tarjeta de crédito específica. Esta funcionalidad proporciona información detallada sobre los diferentes planes de financiamiento disponibles para una cuenta, incluyendo tasas de interés, balances actuales, fechas de plan y otros datos relevantes para la gestión de créditos.

## Entradas y Salidas Principales

### Entrada (Request)
- **ACCOUNT_NUMBER** (string, obligatorio): Número de cuenta de la tarjeta de crédito
- **ORG** (string, opcional): Código de organización

### Salida (Response)
- **CREDIT_PLANS**: Colección de planes de crédito que contiene:
  - **ORG**: Código de organización
  - **ACCOUNT**: Número de cuenta
  - **SEQ_NUMBER**: Número de secuencia del plan
  - **LOGO**: Logo asociado al plan
  - **PLAN_NUMBER**: Número del plan de crédito
  - **PAY_MINIMUM**: Pago mínimo requerido
  - **TYPE_PLAN**: Tipo de plan de crédito
  - **INT_RATE**: Tasa de interés
  - **INT_RATE_BASE**: Tasa de interés base
  - **CURRENT_BALANCE**: Balance actual del plan
  - **DATE_PLAN**: Fecha del plan (formato YYYYMMDD)
  - **ACRD_INT**: Interés acumulado
  - **DELAYS_ACRD_INT**: Interés acumulado por mora
  - **ACCUMULATED_DELAYS_INT**: Interés acumulado por mora diaria

## Sistemas/Servicios OSB Involucrados

### Proxy Services Principales
- **ConsultaPlanesCredito.proxy**: Proxy principal con enrutamiento dinámico regional
- **ConsultaPlanesCreditoGT.proxy**: Proxy específico para Guatemala (GT01)
- **ConsultaPlanesCreditoHN.proxy**: Proxy específico para Honduras (HN01)
- **ConsultaPlanesCreditoNI.proxy**: Proxy específico para Nicaragua (NI01)
- **ConsultaPlanesCreditoPA.proxy**: Proxy específico para Panamá (PA01)

### Business Services por Región
- **MasterDataGT/conDatosPlanes**: Servicio de base de datos para Guatemala
- **MasterDataHN/conDatosPlanes**: Servicio de base de datos para Honduras
- **MasterData/conDatosPlanes**: Servicio de base de datos para Nicaragua
- **MasterDataPA/conDatosPlanes**: Servicio de base de datos para Panamá

### Servicios de Apoyo
- **consultaRutaRegional**: Servicio para determinar el enrutamiento regional
- **MapeoErrores**: Servicio para mapeo y homologación de errores

## Regiones Detectadas

Las siguientes regiones han sido identificadas en el código:

1. **GT01** (Guatemala): Utiliza MasterDataGT y transformación consultaPlanesCreditoGTOut.xq
2. **HN01** (Honduras): Utiliza MasterDataHN y transformación consultaPlanesCreditoHNOut.xq
3. **NI01** (Nicaragua): Utiliza MasterData y transformación consultaPlanesCreditoOut.xq
4. **PA01** (Panamá): Utiliza MasterDataPA y transformación consultaPlanesCreditoPAOut.xq

## Riesgos/Limitaciones Conocidas

### Riesgos Técnicos
1. **Dependencia de Base de Datos Regional**: Cada región tiene su propia base de datos y stored procedure, lo que puede generar inconsistencias en caso de fallos de conectividad
2. **Enrutamiento Dinámico**: El proxy principal depende del servicio consultaRutaRegional para determinar la región correcta
3. **Transformaciones Específicas**: Cada región tiene su propia transformación XQuery, aumentando la complejidad de mantenimiento

### Limitaciones Funcionales
1. **Validación de Entrada**: Solo se valida el esquema XML, no hay validaciones de negocio específicas
2. **Manejo de Errores**: Los errores se mapean a través del servicio MapeoErrores, pero pueden perderse detalles específicos
3. **Formato de Fecha**: Las fechas se formatean a YYYYMMDD, lo que puede causar problemas de interpretación

### Limitaciones de Rendimiento
1. **Timeout**: No se especifican timeouts específicos en las configuraciones
2. **Retry**: Configurado con 0 reintentos en los business services HTTP
3. **Conexiones de BD**: Dependiente de la configuración del pool de conexiones "ConnectionTarjetas"

## Métricas o SLAs

### Configuraciones de Monitoreo
- **Monitoring**: Deshabilitado en todos los proxies (`isEnabled="false"`)
- **Reporting**: Habilitado (`true`)
- **Logging**: Habilitado con nivel `debug`
- **SLA Alerting**: Habilitado con nivel `normal`
- **Pipeline Alerting**: Habilitado con nivel `normal`

### Configuraciones de Rendimiento
- **Aggregation Interval**: 10 segundos
- **Pipeline Monitoring Level**: Pipeline
- **Connection Timeout**: 0 (sin timeout específico)
- **Request Timeout**: 0 (sin timeout específico)
- **Retry Count**: 0 (sin reintentos)

## Identificador de Servicio

- **Service ID**: FICBCO0321
- **Operación**: consultaPlanesCredito
- **Versión**: V2

## Endpoint Principal

```
URI: /Middleware/OperationsAndExecution/Cards/ConsultaPlanesCredito
Protocol: HTTPS
Port: 8004
```

## Stored Procedure Utilizado

- **Nombre**: OSBConDatoPlanes
- **Esquema**: dbo (GT, HN, PA) / OSB.dbo (NI)
- **Conexión**: eis/DB/ConnectionTarjetas

## Consideraciones de Migración

1. **Consolidación Regional**: Evaluar la posibilidad de unificar las transformaciones regionales
2. **Optimización de Conexiones**: Revisar la configuración de pools de conexión por región
3. **Monitoreo**: Habilitar el monitoreo para obtener métricas de rendimiento
4. **Timeouts**: Configurar timeouts apropiados para evitar bloqueos
5. **Validaciones**: Implementar validaciones de negocio adicionales
6. **Manejo de Errores**: Mejorar el manejo de errores específicos por región