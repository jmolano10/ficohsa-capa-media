# Resumen Ejecutivo - ValidaDepositoReferenciadoCB

## Índice de Documentación

1. [Resumen Ejecutivo](01-ResumenEjecutivo.md)
2. [Comparación entre Regiones](02-ComparativaRegiones.md)
3. [Ejemplos y Mapeos - HN01](03-EjemplosYMapeos-HN01.md)
4. [Diagrama de Secuencia - HN01](04-Secuencia-HN01.mmd)
5. [Diagrama de Flujo Multiregión](05-FlujoMultiregión.mmd)
6. [Listado de Ficheros](06-ListadoFicheros.md)
7. [Mapeo de Errores](07-MapeoErrores.md)

## Propósito de la Funcionalidad

**ValidaDepositoReferenciadoCB** es un servicio OSB que actúa como wrapper/fachada para validar depósitos referenciados en el contexto de Correspondent Banking (CB). El servicio recibe solicitudes de validación de depósitos con información de cuenta y documento del deudor, y retorna los datos del depósito y la información de los deudores asociados.

### Funcionalidad Principal
- Validación de depósitos referenciados por cuenta y documento de deudor
- Consulta de información de deudores asociados a un depósito
- Transformación de datos entre el formato CB y el formato interno del sistema

## Entradas y Salidas Principales

### Entrada (Request)
```xml
<validaDepositoReferenciadoCBRequest>
    <ACCOUNT>string</ACCOUNT>
    <DOCUMENT_INFO>
        <TYPE>string</TYPE>  <!-- DEBTOR_CODE o otro tipo -->
        <VALUE>string</VALUE>
    </DOCUMENT_INFO>
</validaDepositoReferenciadoCBRequest>
```

### Salida (Response)
```xml
<validaDepositoReferenciadoCBResponse>
    <DOCUMENT_NUMBER>string</DOCUMENT_NUMBER>
    <ACCOUNT>string</ACCOUNT>
    <DEBTOR_INFO> <!-- 0 a N elementos -->
        <ID>string</ID>
        <NAME>string</NAME>
    </DEBTOR_INFO>
</validaDepositoReferenciadoCBResponse>
```

## Sistemas/Servicios OSB Involucrados

### Servicios Proxy
1. **ValidaDepositoReferenciadoCB** - Servicio principal CB wrapper
2. **DepositosReferenciados** - Router de operaciones de depósitos referenciados
3. **ValidaDepositoReferenciado** - Servicio core de validación

### Business Services
1. **ValidaDepositoReferenciado_db** - Conexión a base de datos Oracle
2. **consultarCorresponsalB_db** - Validación de corresponsal bancario
3. **ValidaServicioRegional_db** - Validación de servicio por región
4. **MapeoErrores** - Servicio de mapeo de errores

### Base de Datos
- **Conexión**: ConnectionProxyAbanksHN (Oracle Database)
- **Package**: CBR_K_DEP_REFERENCIADOS
- **Stored Procedure**: CRB_P_VALIDAR_DEPOSITO_REF

## Regiones Detectadas

Basado en el análisis del código fuente, se identificaron las siguientes regiones:

1. **HN01** - Honduras (Región implementada)
   - Tiene pipeline específico con lógica de negocio
   - Conexión a base de datos Oracle configurada
   - Transformaciones XQuery específicas

2. **Otras regiones** - No implementadas
   - El servicio tiene un branch por defecto que retorna error "SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY"

## Riesgos/Limitaciones Conocidas

### Limitaciones de Implementación
1. **Cobertura Regional Limitada**: Solo implementado para HN01
2. **Dependencia de Base de Datos**: Fuerte acoplamiento con Oracle Database
3. **Manejo de Errores**: Dependiente del servicio MapeoErrores para transformación

### Riesgos Técnicos
1. **Punto Único de Falla**: Dependencia crítica de la conexión a base de datos
2. **Validaciones Hardcodeadas**: Códigos de servicio y transacción fijos en el código
3. **Transformaciones Complejas**: Lógica de mapeo distribuida en múltiples XQuery

### Códigos de Error Identificados
- **NO ACCOUNT**: Cuenta requerida pero no proporcionada
- **NO DOCUMENT TYPE**: Tipo de documento requerido pero no proporcionado  
- **NO DOCUMENT VALUE**: Valor de documento requerido pero no proporcionado
- **NO RECORDS**: No se encontraron registros en la base de datos
- **MW-0008**: Servicio no implementado para el país/compañía
- **FICBCO0312**: Código de servicio para mapeo de errores CB
- **FICBCO0311**: Código de servicio para mapeo de errores core

## Métricas o SLAs

### Configuración de Monitoreo
- **Logging**: Habilitado en nivel DEBUG
- **SLA Alerting**: Habilitado en nivel NORMAL
- **Pipeline Alerting**: Habilitado en nivel NORMAL
- **Reporting**: Habilitado

### Configuración de Retry
- **Retry Count**: 0 (sin reintentos automáticos)
- **Retry Interval**: 30 segundos
- **Retry Application Errors**: true

### Timeouts
- No se encontraron configuraciones específicas de timeout en los archivos analizados

## Arquitectura del Servicio

El servicio sigue un patrón de arquitectura en capas:

1. **Capa de Presentación**: ValidaDepositoReferenciadoCB (CB Wrapper)
2. **Capa de Enrutamiento**: DepositosReferenciados (Router)
3. **Capa de Lógica de Negocio**: ValidaDepositoReferenciado (Core Service)
4. **Capa de Datos**: Business Services de base de datos

Esta arquitectura permite separar las responsabilidades y facilitar el mantenimiento, aunque introduce complejidad adicional en el flujo de datos.