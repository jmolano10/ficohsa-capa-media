# Resumen Ejecutivo - ConsultaCargosRecurrentesDiarios

## Índice de Documentación

1. [Resumen Ejecutivo](01-ResumenEjecutivo.md)
2. [Comparativa entre Regiones](02-ComparativaRegiones.md)
3. [Ejemplos y Mapeos - HN01](03-EjemplosYMapeos-HN01.md)
4. [Ejemplos y Mapeos - NI01](03-EjemplosYMapeos-NI01.md)
5. [Diagrama de Secuencia - HN01](04-Secuencia-HN01.mmd)
6. [Diagrama de Secuencia - NI01](04-Secuencia-NI01.mmd)
7. [Flujo Multi-región](05-FlujoMultiregión.mmd)
8. [Listado de Ficheros](06-ListadoFicheros.md)
9. [Mapeo de Errores](07-MapeoErrores.md)

## Propósito de la Funcionalidad

La funcionalidad **ConsultaCargosRecurrentesDiarios** permite consultar los cargos recurrentes diarios asociados a una tarjeta de débito específica. Esta funcionalidad está diseñada para proporcionar información detallada sobre las transacciones diarias de una tarjeta, incluyendo el estado de los movimientos, fechas, montos y monedas de las transacciones.

## Entradas y Salidas Principales

### Entrada Principal
- **CARD_NUMBER**: Número de tarjeta de débito (1-19 caracteres)

### Salida Principal
- **MOVEMENT_INFORMATION**: Lista de movimientos con la siguiente información:
  - **COMMERCE_NAME**: Nombre del comercio
  - **MOVEMENT_STATUS**: Estado del movimiento (Aplicado/Rechazado)
  - **TRANSACTION_DATE**: Fecha y hora de la transacción
  - **TRANSACTION_AMOUNT**: Monto de la transacción
  - **TRANSACTION_CURRENCY**: Moneda de la transacción

## Sistemas/Servicios OSB Involucrados

### Proxy Services
- **ConsultaCargosRecurrentesDiarios.proxy**: Proxy principal con enrutamiento dinámico
- **ConsultaCargosRecurrentesDiariosHN.proxy**: Implementación específica para Honduras (HN01)
- **ConsultaCargosRecurrentesDiariosNI.proxy**: Implementación específica para Nicaragua (NI01)

### Business Services
- **wsVisaTransactionHN.biz**: Servicio VisaNet para Honduras
- **wsVisaTransaction.biz**: Servicio VisaNet para Nicaragua
- **consultaRutaRegional_db**: Servicio de consulta de ruta regional
- **ObtenerParametrizacion**: Servicio de obtención de parámetros de configuración

### Servicios Externos
- **VisaNet WSVisaTransaction**: Servicio web externo para consulta de transacciones de tarjetas
  - Honduras: `https://192.168.125.188/WSVisaTransaction.asmx`
  - Nicaragua: `https://192.168.125.16:9443/WSVisaTransaction.asmx`

## Regiones Detectadas

Basado en el análisis del código fuente, se han identificado las siguientes regiones:

1. **HN01 (Honduras)**: Implementación completa con proxy específico
2. **NI01 (Nicaragua)**: Implementación completa con proxy específico

## Riesgos/Limitaciones Conocidas

### Riesgos Técnicos
1. **Dependencia de VisaNet**: La funcionalidad depende completamente de la disponibilidad del servicio externo VisaNet
2. **Configuración Regional**: Requiere parámetros específicos por región (STRUSER, STRPASSWORD, STRCARDACQMATRIZID, STRTERMINALMATRIZID)
3. **Validación de Entrada**: Solo valida longitud del número de tarjeta (1-19 caracteres)

### Limitaciones Funcionales
1. **Consulta Diaria**: Solo consulta transacciones del día actual (strDateIn = strDateOut = fecha actual)
2. **Sin Paginación**: No implementa paginación para grandes volúmenes de transacciones
3. **Mapeo de Estados**: Solo mapea códigos "00" como "Aplicado" y cualquier otro como "Rechazado"

### Limitaciones de Seguridad
1. **Autenticación Básica**: Utiliza autenticación username/password en el header
2. **Credenciales en Configuración**: Las credenciales de VisaNet se almacenan en la base de datos de configuración

## Métricas o SLAs

### Configuraciones de Timeout
- **HTTP Timeout**: 0 (sin timeout configurado)
- **Connection Timeout**: 0 (sin timeout configurado)
- **Retry Count**: 0 (sin reintentos configurados)

### Configuraciones de Monitoreo
- **Monitoring**: Deshabilitado
- **SLA Alerting**: Habilitado con nivel normal
- **Pipeline Alerting**: Habilitado con nivel normal
- **Logging**: Habilitado con nivel debug

### Identificador de Servicio
- **Service ID**: FICBCO0276

## Arquitectura de Enrutamiento

La funcionalidad utiliza un patrón de **enrutamiento dinámico** donde:

1. El proxy principal (`ConsultaCargosRecurrentesDiarios.proxy`) recibe la petición
2. Consulta la ruta regional mediante el servicio `consultaRutaRegional_db`
3. Enruta dinámicamente a la implementación específica de la región
4. Cada región tiene su propia implementación con parámetros específicos

## Transformaciones Clave

### Entrada (queryCardTransactionIn.xq)
- Mapea el número de tarjeta del request OSB al formato VisaNet
- Establece fechas de consulta (fecha actual)
- Incluye parámetros de autenticación específicos por región

### Salida (consultaCargosRecurrentesDiariosOut.xq)
- Transforma la respuesta de VisaNet al formato OSB
- Mapea códigos de estado: "00" → "Aplicado", otros → "Rechazado"
- Convierte fechas del formato "M/dd/yyyy hh:mm:ss a" a dateTime XML

### Header (consultaCargosRecurrentesDiariosHeaderOut.xq)
- Mapea código "000" de VisaNet a "Success"
- Otros códigos se prefijan con "VisaNet-"
- Incluye mensajes de respuesta de VisaNet