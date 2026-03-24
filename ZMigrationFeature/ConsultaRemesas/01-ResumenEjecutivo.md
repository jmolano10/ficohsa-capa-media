# Análisis AS-IS: ConsultaRemesas

## Índice de Archivos

1. [Resumen Ejecutivo](01-ResumenEjecutivo.md)
2. [Comparativa entre Regiones](02-ComparativaRegiones.md)
3. [Ejemplos y Mapeos - HN01](03-EjemplosYMapeos-HN01.md)
4. [Diagrama de Secuencia - HN01](04-Secuencia-HN01.mmd)
5. [Flujo Multi-región](05-FlujoMultiregión.mmd)
6. [Listado de Ficheros](06-ListadoFicheros.md)
7. [Mapeo de Errores](07-MapeoErrores.md)

---

## 1. Propósito de la Funcionalidad

La funcionalidad **ConsultaRemesas** permite consultar información detallada de remesas familiares a través de diferentes criterios de búsqueda. El servicio actúa como un enrutador inteligente que determina el tipo de remesadora y dirige la consulta al sistema correspondiente.

### Funcionalidades Principales:
- **Consulta por ID de Remesa**: Búsqueda directa usando el código único de la remesa
- **Consulta por Nombres**: Búsqueda usando nombres del remitente y/o beneficiario
- **Enrutamiento Inteligente**: Determina automáticamente el tipo de remesadora (Local, Ficohsa Remesas, Online)
- **Validación de Permisos**: Verifica que el usuario tenga acceso a consultar el tipo de remesa específico

## 2. Entradas y Salidas Principales

### Entrada (Request):
```xml
<consultaRemesas>
    <REMITTANCE_ID>string</REMITTANCE_ID>
    <REMITTER_FIRSTNAME>string</REMITTER_FIRSTNAME>
    <REMITTER_MIDDLENAME>string</REMITTER_MIDDLENAME>
    <REMITTER_FIRSTSURNAME>string</REMITTER_FIRSTSURNAME>
    <REMITTER_SECONDSURNAME>string</REMITTER_SECONDSURNAME>
    <BENEFICIARY_FIRSTNAME>string</BENEFICIARY_FIRSTNAME>
    <BENEFICIARY_MIDDLENAME>string</BENEFICIARY_MIDDLENAME>
    <BENEFICIARY_FIRSTSURNAME>string</BENEFICIARY_FIRSTSURNAME>
    <BENEFICIARY_SECONDSURNAME>string</BENEFICIARY_SECONDSURNAME>
    <CORRESPONSAL_BRANCHCODE>string</CORRESPONSAL_BRANCHCODE>
    <ADDITIONAL_INFO>
        <INFO>
            <NAME>string</NAME>
            <VALUE>string</VALUE>
        </INFO>
    </ADDITIONAL_INFO>
</consultaRemesas>
```

### Salida (Response):
```xml
<consultaRemesasResponse>
    <consultaRemesasResponseType>
        <consultaRemesasResponseRecordType>
            <REMITTANCE_ID>string</REMITTANCE_ID>
            <REMITTER_ID>string</REMITTER_ID>
            <REMITTER_NAME>string</REMITTER_NAME>
            <BENEFICIARY_NAME>string</BENEFICIARY_NAME>
            <BRANCH_NAME>string</BRANCH_NAME>
            <PAYMENT_DATE>string</PAYMENT_DATE>
            <CURRENCY>string</CURRENCY>
            <EXCHANGE_RATE>string</EXCHANGE_RATE>
            <REMITTANCE_STATUS>string</REMITTANCE_STATUS>
            <REMITTANCE_AMOUNT>string</REMITTANCE_AMOUNT>
            <REMITTANCE_SOURCE_AMOUNT>string</REMITTANCE_SOURCE_AMOUNT>
            <ORIGIN_COUNTRY>string</ORIGIN_COUNTRY>
        </consultaRemesasResponseRecordType>
    </consultaRemesasResponseType>
</consultaRemesasResponse>
```

## 3. Sistemas/Servicios OSB Involucrados

### Proxy Services:
- **ConsultaRemesas.proxy**: Servicio principal que expone la funcionalidad
- **MapeoErrores.proxy**: Manejo centralizado de errores
- **EvaluaListasCliente.proxy**: Validación de listas restrictivas

### Business Services:
- **ObtenerTipoRemesadora_db**: Determina el tipo de remesadora por código
- **sjConsultaRemesaResiliencia**: Consulta remesas en T24 (sistema core)
- **consultarRemLocalId_db**: Consulta remesas locales en tablas FLink
- **consultarRemFRemXPagador_db**: Consulta Ficohsa Remesas
- **sjConsultaMultipleRemesadoras**: Consulta remesadoras online (Moneygram, Western Union, etc.)
- **obtenerCamposRemesasRel_db**: Obtiene campos relacionados de remesas
- **ingresoRelConsPagoRem_db**: Registra relación consulta-pago
- **ValidaServicioRegional_db**: Validación regional del servicio

### Recursos de Transformación:
- **validarTipoConsulta.xq**: Determina si es consulta por ID o por nombre
- **obtenerTipoRemesadoraIn.xq**: Transforma entrada para obtener tipo de remesadora
- **consultaRemesaT24In.xq**: Transforma entrada para T24
- **consultaRemLocalIdIn.xq**: Transforma entrada para remesas locales
- **sjconsultaMultipleRemesadorasIn.xq**: Transforma entrada para remesadoras online
- **EnrutadorConveniosOut.xq**: Transforma salida del enrutador de convenios

## 4. Riesgos/Limitaciones Conocidas

### Riesgos Técnicos:
1. **Dependencia de Múltiples Sistemas**: El servicio depende de T24, FLink y sistemas externos
2. **Timeout en Consultas Online**: Las consultas a remesadoras externas pueden fallar por timeout
3. **Inconsistencia de Datos**: Diferentes fuentes pueden tener información desactualizada
4. **Validación de Permisos**: Falla en validación puede exponer información no autorizada

### Limitaciones Funcionales:
1. **Solo Región HN01**: Actualmente solo funciona para Honduras
2. **Consulta Secuencial**: No hay paralelización de consultas a múltiples remesadoras
3. **Cache Limitado**: No hay mecanismo de cache para consultas frecuentes
4. **Auditoría Básica**: Registro limitado de transacciones para auditoría

### Limitaciones de Rendimiento:
1. **Consultas Síncronas**: Todas las consultas son síncronas, impactando tiempo de respuesta
2. **Sin Balanceador**: No hay distribución de carga entre instancias
3. **Transformaciones Complejas**: Múltiples transformaciones XQuery impactan rendimiento

## 5. Métricas o SLAs

### SLAs Identificados:
- **Tiempo de Respuesta**: No especificado en código, pero timeout configurado en 500ms (MaxTime500.alert)
- **Disponibilidad**: Dependiente de sistemas backend (T24, FLink, SJS)
- **Throughput**: No especificado

### Configuraciones de Monitoreo:
- **Logging**: Habilitado en nivel DEBUG
- **Alertas**: Configuradas para SLA y Pipeline
- **Reporting**: Habilitado para métricas básicas
- **Aggregation Interval**: 10 segundos

### Endpoint de Producción:
```
URL: https://172.23.177.15:8004/Middleware/OperationsAndExecution/Payments/ConsultaRemesas_v2
Protocolo: HTTPS
Método: SOAP 1.1
```

## 6. Arquitectura de Integración

### Patrón de Integración:
- **Router Pattern**: Enrutamiento basado en tipo de remesadora
- **Adapter Pattern**: Adaptación a diferentes sistemas backend
- **Facade Pattern**: Interfaz unificada para múltiples sistemas de remesas

### Flujo de Datos:
1. **Validación**: XSD y validación regional
2. **Determinación**: Tipo de consulta (ID vs Nombre)
3. **Enrutamiento**: Según tipo de remesadora
4. **Transformación**: Adaptación a sistema específico
5. **Consulta**: Ejecución en sistema correspondiente
6. **Respuesta**: Transformación y retorno unificado

### Manejo de Errores:
- **Centralizado**: A través de MapeoErrores.proxy
- **Códigos Estándar**: Mapeo a códigos HTTP estándar
- **Logging**: Registro detallado para troubleshooting