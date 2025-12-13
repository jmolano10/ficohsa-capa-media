# Resumen Ejecutivo - ConsultaInformacionLaboral

## Índice de Documentación

1. [Resumen Ejecutivo](01-ResumenEjecutivo.md)
2. [Comparativa entre Regiones](02-ComparativaRegiones.md)
3. [Ejemplos y Mapeos - HN01](03-EjemplosYMapeos-HN01.md)
4. [Diagrama de Secuencia - HN01](04-Secuencia-HN01.mmd)
5. [Flujo Multi-región](05-FlujoMultiregión.mmd)
6. [Listado de Ficheros](06-ListadoFicheros.md)

## Propósito de la Funcionalidad

La funcionalidad **ConsultaInformacionLaboral** permite consultar el historial laboral de un cliente específico en el sistema FPC (Fondo de Pensiones y Cesantías). Esta funcionalidad proporciona información detallada sobre el historial de empleos, salarios, patronos y períodos laborales de un cliente.

## Entradas y Salidas Principales

### Entrada (Request)
- **CUSTOMER_ACCOUNT**: Código de cuenta del cliente (obligatorio)
- **FROM_DATE**: Fecha de inicio del período a consultar (opcional)
- **TO_DATE**: Fecha fin del período a consultar (opcional)

### Salida (Response)
- **JOB_INFO_HISTORY**: Lista de registros del historial laboral que incluye:
  - Información del cliente (CUSTOMER_ACCOUNT, STATUS)
  - Fechas de empleo (START_DATE, END_DATE)
  - Información del patrono (EMPLOYER_CODE, EMPLOYER_NAME, EMPLOYER_RTN)
  - Información salarial (PAYMENT_AMOUNT, SALARY_AMOUNT, PAYMENT_CURRENCY, SALARY_CURRENCY)
  - Información ocupacional (OCCUPATION_CODE, OCCUPATION_DESC, JOB_TITLE_CODE, JOB_TITLE_DESC)
  - Detalles adicionales (PAYMENT_PERIOD, BALANCE_TYPE)

## Sistemas/Servicios OSB Involucrados

### Proxy Service
- **ConsultaInformacionLaboral.proxy**: Servicio principal que expone la funcionalidad
- **URI**: `/Middleware/ReferenceData/BusinessPartner/ConsultaInformacionLaboral`
- **Protocolo**: SOAP
- **Autenticación**: Custom token authentication con usuario/contraseña

### Business Services
1. **ValidaServicioRegional_db**: Validación de servicio por región
   - **Service ID**: FICBCO0181
   
2. **getEmploymentInformation12c**: Servicio externo para consulta de información laboral
   - **Endpoint**: `https://dynamoosbdev:8004/regional/pension/soap/getEmploymentInformation/v11g`
   - **Timeout**: 70 segundos
   - **Connection Timeout**: 65 segundos

3. **consultaInformacionLaboralFPC_db**: Conexión directa a base de datos FPC
   - **Conexión**: `eis/DB/ConnectionFicopen`
   - **Esquema**: FO
   - **Package**: WCONSULTAINFORMACIONLABORALFPC
   - **Stored Procedure**: FO_WEB_SERVICE$DEME_HIS_INFO_

## Regiones Detectadas

Basado en el análisis del código fuente, se identificaron las siguientes regiones:

- **HN01**: Honduras - Banco Principal
- **HN02**: Honduras - FPC (Fondo de Pensiones y Cesantías)

## Riesgos/Limitaciones Conocidas

1. **Limitación Regional**: El servicio solo está implementado para Honduras (HN02/FPC). Otras regiones devuelven error "SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY"

2. **Dependencia Externa**: El servicio depende de un endpoint externo (`dynamoosbdev:8004`) que puede no estar disponible

3. **Timeout Configurado**: Timeout de 70 segundos puede ser insuficiente para consultas de períodos extensos

4. **Validación Regional**: Requiere validación previa del servicio regional que puede fallar

5. **Formato de Fechas**: Manejo específico de formatos de fecha que puede causar errores si no se valida correctamente

## Métricas o SLAs

### Configuración de Monitoreo
- **Monitoring**: Habilitado a nivel Pipeline
- **Aggregation Interval**: 10 segundos
- **Logging**: Debug level habilitado
- **SLA Alerting**: Habilitado con nivel normal
- **Pipeline Alerting**: Habilitado con nivel normal

### Timeouts Configurados
- **HTTP Timeout**: 70 segundos
- **Connection Timeout**: 65 segundos
- **Retry Count**: 0 (sin reintentos automáticos)

### Políticas de Seguridad
- **Autenticación**: Custom token con usuario/contraseña extraídos del header
- **Credenciales**: Almacenadas en `Middleware/Security/OSB12AUTH`

## Flujo de Procesamiento

1. **Validación XSD**: Validación del esquema del request
2. **Validación Regional**: Verificación de que el servicio esté disponible para la región
3. **Enrutamiento Regional**: Direccionamiento basado en SourceBank
4. **Transformación**: Mapeo de datos según la región
5. **Invocación**: Llamada al servicio correspondiente (externo o base de datos)
6. **Respuesta**: Transformación y devolución de la respuesta

## Estado de Implementación

- **HN02 (FPC)**: ✅ Completamente implementado con conexión a base de datos
- **Otras Regiones**: ❌ No implementado - devuelve error estándar