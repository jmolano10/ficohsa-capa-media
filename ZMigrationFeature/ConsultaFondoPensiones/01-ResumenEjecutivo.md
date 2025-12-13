# Resumen Ejecutivo - ConsultaFondoPensiones

## Índice de Documentación

1. [Resumen Ejecutivo](01-ResumenEjecutivo.md)
2. [Comparativa entre Regiones](02-ComparativaRegiones.md)
3. [Ejemplos y Mapeos - HN02](03-EjemplosYMapeos-HN02.md)
4. [Diagrama de Secuencia - HN02](04-Secuencia-HN02.mmd)
5. [Flujo Multi-región](05-FlujoMultiregión.mmd)
6. [Listado de Ficheros](06-ListadoFicheros.md)

## Propósito de la Funcionalidad

La funcionalidad **ConsultaFondoPensiones** permite consultar la información detallada de una cuenta de fondo de pensiones de un cliente específico. Esta funcionalidad proporciona datos completos sobre la cuenta, incluyendo información del cliente, producto, contribuciones, beneficiarios y balances de inversión.

## Entradas y Salidas Principales

### Entrada (Request)
- **ACCOUNT_NUMBER**: Número de cuenta del fondo de pensiones (obligatorio)

### Salida (Response)
- **Información de la Cuenta**: ACCOUNT_NUMBER, ACCOUNT_TYPE, ACCOUNT_CURRENCY, ACCOUNT_STATUS
- **Información del Cliente**: CUSTOMER_ID, CUSTOMER_NAME
- **Información del Producto**: PRODUCT_CODE, PRODUCT_NAME, SUB_PRODUCT_CODE, SUB_PRODUCT_NAME
- **Fechas Importantes**: OPENING_DATE, EXPIRATION_DATE, CLOSING_DATE
- **Información de Contribuciones**: 
  - CONTRIBUTION_AMOUNT, FIRST_CONTRIBUTION_AMOUNT/DATE
  - LAST_CONTRIBUTION_AMOUNT/DATE, NEXT_CONTRIBUTION_AMOUNT/DATE
  - LAST_EXTRA_CONTRIBUTION_AMOUNT/DATE
- **Información de Pago**: FREQUENCY, FREQUENCY_DATE, PAYMENT_METHOD
- **Montos de Seguro**: SALARY_AMOUNT, PREMIUM_AMOUNT, INSURED_AMOUNT
- **Información de Beneficiarios**: Lista con FULL_NAME, RELATIONSHIP, DISTRIBUTION_PERCENTAGE
- **Información de Balances**: Lista con tipos de balance e inversión

## Sistemas/Servicios OSB Involucrados

### Proxy Service
- **ConsultaFondoPensiones.proxy**: Servicio principal que expone la funcionalidad
- **URI**: `/Middleware/ReferenceData/BusinessPartner/ConsultaFondoPensiones`
- **Protocolo**: SOAP con HTTPS habilitado
- **Autenticación**: Custom token authentication con usuario/contraseña

### Business Services
1. **getPensionFund12c**: Servicio externo para consulta de fondos de pensiones
   - **Endpoint**: `https://dynamoosbdev:8004/regional/pension/soap/getPensionFund11g/v1`
   - **Timeout**: 70 segundos
   - **Connection Timeout**: 65 segundos
   - **Operación**: getPensionFund

## Regiones Detectadas

Basado en el análisis del código fuente, se identificaron las siguientes regiones:

- **HN02**: Honduras - FPC (Fondo de Pensiones y Cesantías) - ✅ Implementado
- **Otras Regiones**: No implementadas - devuelven error estándar

## Riesgos/Limitaciones Conocidas

1. **Limitación Regional**: El servicio solo está implementado para Honduras FPC (HN02). Otras regiones devuelven error "SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY"

2. **Dependencia Externa Crítica**: El servicio depende completamente de un endpoint externo (`dynamoosbdev:8004`) sin alternativa de base de datos local

3. **Timeout Configurado**: Timeout de 70 segundos puede ser insuficiente para consultas complejas

4. **Sin Validación Regional Previa**: A diferencia de otros servicios, no implementa validación regional antes del procesamiento

5. **HTTPS Requerido**: El servicio requiere HTTPS, lo que puede causar problemas de certificados

6. **Manejo de Errores Limitado**: Solo verifica el campo Status de la respuesta externa

## Métricas o SLAs

### Configuración de Monitoreo
- **Monitoring**: Deshabilitado a nivel de servicio
- **Reporting**: Habilitado
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
- **HTTPS**: Habilitado para conexiones entrantes

## Flujo de Procesamiento

1. **Enrutamiento Regional**: Verificación de SourceBank para determinar el pipeline
2. **Preparación de Header**: Configuración de credenciales OSB12AUTH
3. **Transformación de Request**: Mapeo del número de cuenta y región
4. **Invocación Externa**: Llamada al servicio getPensionFund12c
5. **Evaluación de Respuesta**: Verificación del campo Status
6. **Transformación de Response**: Mapeo completo de datos de la cuenta
7. **Construcción de Respuesta**: Generación del response final

## Estado de Implementación

- **HN02 (FPC)**: ✅ Completamente implementado con servicio externo
- **Otras Regiones**: ❌ No implementado - devuelve error estándar

## Arquitectura Técnica

### Patrón de Integración
- **Tipo**: Proxy-to-External Service
- **Protocolo**: SOAP/HTTPS
- **Transformaciones**: XQuery para mapeo de datos
- **Autenticación**: Credenciales almacenadas en OSB

### Dependencias Críticas
1. **Servicio Dynamo**: Endpoint externo principal
2. **Almacén de Credenciales**: OSB12AUTH para autenticación
3. **Certificados HTTPS**: Para conexiones seguras

### Características Especiales
- **Uso de HTTPS**: Conexiones seguras habilitadas
- **Mapeo Complejo**: Transformación de estructuras de datos complejas
- **Manejo de Listas**: Procesamiento de beneficiarios y balances
- **Campos Opcionales**: Manejo de elementos que pueden estar ausentes