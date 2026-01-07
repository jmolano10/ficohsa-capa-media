# Resumen Ejecutivo - ConsultaFinancierasACH

## Índice de Documentación

1. [Resumen Ejecutivo](01-ResumenEjecutivo.md)
2. [Comparación entre Regiones](02-ComparativaRegiones.md)
3. [Ejemplos y Mapeos - HN01](03-EjemplosYMapeos-HN01.md)
4. [Ejemplos y Mapeos - HN02](03-EjemplosYMapeos-HN02.md)
5. [Ejemplos y Mapeos - GT01](03-EjemplosYMapeos-GT01.md)
6. [Ejemplos y Mapeos - PA01](03-EjemplosYMapeos-PA01.md)
7. [Ejemplos y Mapeos - NI01](03-EjemplosYMapeos-NI01.md)
8. [Diagrama de Secuencia - HN01](04-Secuencia-HN01.mmd)
9. [Diagrama de Secuencia - HN02](04-Secuencia-HN02.mmd)
10. [Diagrama de Secuencia - GT01](04-Secuencia-GT01.mmd)
11. [Diagrama de Secuencia - PA01](04-Secuencia-PA01.mmd)
12. [Diagrama de Secuencia - NI01](04-Secuencia-NI01.mmd)
13. [Flujo Multiregión](05-FlujoMultiregión.mmd)
14. [Listado de Ficheros](06-ListadoFicheros.md)

## Propósito de la Funcionalidad

La funcionalidad **ConsultaFinancierasACH** es un servicio OSB que permite consultar información sobre entidades financieras participantes en el sistema ACH (Automated Clearing House) de cada región. Este servicio proporciona detalles sobre los códigos de destino, nombres de las instituciones financieras y los tipos de productos que manejan para transferencias ACH.

## Entradas y Salidas Principales

### Entrada Principal
- **DESTINATION_CODE** (opcional): Código de la entidad financiera a consultar
- **RequestHeader**: Header estándar con información de autenticación y región

### Salida Principal
- **consultaFinancierasACHResponse**: Lista de entidades financieras con:
  - DESTINATION_CODE: Código de la entidad financiera
  - DESTINATION_NAME: Nombre de la entidad financiera
  - Detalles de productos por entidad:
    - TYPE_OF_PRODUCT: Tipo de producto financiero
    - MIN_PRODUCT_ID_LENGTH: Longitud mínima del ID del producto
    - MAX_PRODUCT_ID_LENGTH: Longitud máxima del ID del producto
    - LEADING_ZEROS_YES_NO: Indicador si requiere ceros a la izquierda
    - PRODUCT_ID_SAMPLE: Ejemplo de ID de producto
    - TRANSFER_TYPE: Tipo de transferencia (solo GT01)

## Sistemas/Servicios OSB Involucrados

### Servicios Principales
- **ConsultaFinancierasACH.proxy**: Proxy service principal con enrutamiento regional
- **MapeoErrores**: Servicio para mapeo y manejo de errores
- **ValidaServicioRegional**: Validación de disponibilidad del servicio por región

### Servicios por Región

#### HN01 (Honduras - Core)
- **CoreBS**: Business service que conecta con T24 Core Banking
- Operación: `ConsultadedestinosACH`

#### HN02 (Honduras - FPC)
- **getFinancialACH12c**: Business service para consulta en FPC
- Operación: `consultaFinancierasACH`

#### GT01 (Guatemala)
- **consultaFinancierasACH_db**: Adaptador de base de datos Oracle
- Stored Procedure: `OSB_K_CONFINANCIERAS.TOPLEVEL$OSB_P_CON_FINANCIERA`
- Conexión: `ConnectionProxyAbanksGT`

#### PA01 (Panamá)
- **consultaFinancierasACH_db**: Adaptador de base de datos Oracle
- Stored Procedure: `OSB_K_CONFINANCIERAS.TOPLEVEL$OSB_P_CON_FINANCIERA`
- Conexión: `ConnectionProxyAbanksPA`

#### NI01 (Nicaragua)
- **transferencia**: Business service CTS (COBIS)
- Operación: `OpConsultaFinacierasACH`
- Endpoint: `http://10.235.53.149:9080/GerenciaTransferencia/SrvAplCobisTransferenciaService`

## Riesgos/Limitaciones Conocidas

### Riesgos Técnicos
1. **Dependencias Externas**: 
   - HN01 depende de T24 Core Banking
   - NI01 depende del servicio CTS de COBIS
   - GT01 y PA01 dependen de bases de datos Oracle específicas

2. **Manejo de Errores**:
   - Cada región tiene diferentes códigos de error
   - El mapeo de errores se centraliza en el servicio MapeoErrores

3. **Autenticación**:
   - Utiliza autenticación custom-token con usuario/contraseña
   - Credenciales almacenadas en LDAP para algunas regiones

### Limitaciones Funcionales
1. **Diferencias Regionales**:
   - GT01 incluye campo TRANSFER_TYPE que otras regiones no manejan
   - PA01 tiene lógica de agrupación diferente en la respuesta
   - NI01 utiliza parametrización externa para tipos de producto

2. **Validaciones**:
   - Validación XSD obligatoria para el request
   - Validación de servicio regional antes del procesamiento

## Métricas o SLAs

### Configuración de Monitoreo
- **Monitoring**: Habilitado con intervalo de agregación de 10 segundos
- **Pipeline Monitoring Level**: Action
- **Logging**: Habilitado en nivel debug
- **SLA Alerting**: Habilitado en nivel normal
- **Pipeline Alerting**: Habilitado en nivel normal

### Timeouts Configurados
- **NI01**: Sin timeout específico configurado (0 = sin límite)
- **Otras regiones**: Utilizan configuración por defecto del OSB

### Políticas de Retry
- **NI01**: Sin reintentos configurados
- **Load Balancing**: Round-robin para NI01

## Identificador de Servicio
- **Service ID**: FICBCO0118
- **Endpoint URI**: `/SMiddleware/ReferenceData/CommonBusinessInformation/ConsultaFinancierasACH_v2`
- **Protocolo**: HTTPS/SOAP 1.1