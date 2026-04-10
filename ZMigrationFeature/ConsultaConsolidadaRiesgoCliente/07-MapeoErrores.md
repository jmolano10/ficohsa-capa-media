# Mapeo de Errores - ConsultaConsolidadaRiesgoCliente

## Códigos de Error del Core y Homologación HTTP

| Código Error (ConsultaConsolidadaRiesgoCliente) | Descripción Error (ConsultaConsolidadaRiesgoCliente) | Código HTTP | Descripción Error HTTP |
|--------------------------------------------------|------------------------------------------------------|-------------|------------------------|
| SUCCESS | Consulta exitosa | 200 | OK |
| NO RECORS | No se encontraron registros para el cliente | 404 | Not Found |
| ERROR | Error general en el procesamiento | 500 | Internal Server Error |
| VALIDATION_ERROR | Error de validación de esquema XSD | 400 | Bad Request |
| AUTHENTICATION_ERROR | Error de autenticación en headers | 401 | Unauthorized |
| REGIONAL_ROUTING_ERROR | Error en enrutamiento regional | 502 | Bad Gateway |
| DATABASE_CONNECTION_ERROR | Error de conexión a base de datos | 503 | Service Unavailable |
| STORED_PROCEDURE_ERROR | Error en ejecución del stored procedure | 500 | Internal Server Error |
| XML_PARSING_ERROR | Error al parsear XML incrustado | 500 | Internal Server Error |
| TRANSFORMATION_ERROR | Error en transformaciones XQuery | 500 | Internal Server Error |
| TIMEOUT_ERROR | Timeout en consulta a base de datos | 504 | Gateway Timeout |

## Detalles de Manejo de Errores

### 1. Errores de Validación XSD
- **Origen**: Stage ValidacionXSD en ConsultaConsolidadaRiesgoCliente.proxy
- **Trigger**: Cuando CUSTOMER_LEGAL_ID no cumple con minLength=1 o estructura XML inválida
- **Procesamiento**: Error Handler captura la excepción y la procesa mediante MapeoErrores
- **Código Interno**: VALIDATION_ERROR
- **Formato de Mensaje**: "FICBCO0398$#$" + detalle del error de validación

### 2. Errores de Enrutamiento Regional
- **Origen**: Stage ConsultaRutaRegional en ConsultaConsolidadaRiesgoCliente.proxy
- **Trigger**: Cuando consultaRutaRegional_db retorna PV_CODIGO_ERROR != 'SUCCESS'
- **Procesamiento**: Mapeo directo del mensaje de error del servicio regional
- **Código Interno**: REGIONAL_ROUTING_ERROR
- **Formato de Mensaje**: "FICBCO0398$#$" + PV_MENSAJE_ERROR

### 3. Errores de Base de Datos
- **Origen**: Business Service consultaConsolidadaRiesgoCliente_db
- **Trigger**: Problemas de conectividad, timeout, o errores en stored procedure
- **Procesamiento**: Error Handler en ConsultaConsolidadaRiesgoClienteHN.proxy
- **Código Interno**: DATABASE_CONNECTION_ERROR o STORED_PROCEDURE_ERROR
- **Formato de Mensaje**: "FICBCO0398$#$" + mensaje de error de la base de datos

### 4. Errores de Datos No Encontrados
- **Origen**: consultaConsolidadaRiesgoClienteHeaderOut.xq
- **Trigger**: Cuando el RowSet está vacío (count($rowOne/*) = 0)
- **Procesamiento**: Generación automática de header con error
- **Código Interno**: NO RECORS
- **Formato de Mensaje**: "NO RECORDS FOUND"

### 5. Errores de Transformación
- **Origen**: Archivos XQuery (.xq)
- **Trigger**: Errores en parsing XML, conversiones de tipo, o funciones XQuery
- **Procesamiento**: Error Handler captura y procesa mediante MapeoErrores
- **Código Interno**: TRANSFORMATION_ERROR o XML_PARSING_ERROR
- **Formato de Mensaje**: "FICBCO0398$#$" + detalle del error de transformación

## Configuración de MapeoErrores

### Parámetros de Entrada
- **CODIGO_ERROR**: Código de error original o successIndicator
- **MENSAJE_ERROR**: Mensaje con formato "FICBCO0398$#$" + descripción del error

### Transformaciones Aplicadas
- **mapeoErroresUsageIn.xq**: Prepara los parámetros para el servicio de mapeo
- **mapeoErroresUsageOut.xq**: Procesa la respuesta y actualiza el ResponseHeader

### Códigos de Servicio
- **Identificador de Servicio**: FICBCO0398
- **Prefijo de Error**: FICBCO0398$#$
- **Separador**: $#$ (utilizado para separar código de servicio del mensaje)

## Estructura de Response de Error

### Header de Error Estándar
```xml
<aut:ResponseHeader xmlns:aut="http://www.ficohsa.com.hn/middleware.services/autType">
    <messageId>-1</messageId>
    <successIndicator>ERROR</successIndicator>
    <messages>Descripción del error procesado</messages>
</aut:ResponseHeader>
```

### Body de Error Estándar
```xml
<con:consultaConsolidadaRiesgoClienteResponse xmlns:con="http://www.ficohsa.com.hn/middleware.services/consultaConsolidadaRiesgoClienteTypes"/>
```

## Escenarios de Error Específicos

### Escenario 1: Cliente No Existe
- **Condición**: CUSTOMER_LEGAL_ID válido pero no existe en base de datos
- **Resultado SP**: RowSet vacío
- **Response**: successIndicator="NO RECORS", messages="NO RECORDS FOUND"
- **HTTP Equivalente**: 404 Not Found

### Escenario 2: Error de Conexión a Base de Datos
- **Condición**: eis/DB/ConnectionCustomerCreditRisk no disponible
- **Resultado**: Excepción en Business Service
- **Response**: successIndicator="ERROR", messages="FICBCO0398$#$Database connection error"
- **HTTP Equivalente**: 503 Service Unavailable

### Escenario 3: Stored Procedure Falla
- **Condición**: p_consulta_ONBASE_V2 retorna error SQL
- **Resultado**: Excepción en ejecución del SP
- **Response**: successIndicator="ERROR", messages="FICBCO0398$#$SP execution error"
- **HTTP Equivalente**: 500 Internal Server Error

### Escenario 4: XML Incrustado Malformado
- **Condición**: fn-bea:inlinedXML() no puede parsear el XML del RowSet
- **Resultado**: Excepción en transformación
- **Response**: successIndicator="ERROR", messages="FICBCO0398$#$XML parsing error"
- **HTTP Equivalente**: 500 Internal Server Error

### Escenario 5: Timeout de Base de Datos
- **Condición**: Consulta excede tiempo límite configurado
- **Resultado**: Timeout exception
- **Response**: successIndicator="ERROR", messages="FICBCO0398$#$Database timeout"
- **HTTP Equivalente**: 504 Gateway Timeout

## Logging y Monitoreo de Errores

### Configuración de Logging
- **Nivel**: Debug (habilitado en ambos proxies)
- **SLA Alerting**: Normal level
- **Pipeline Alerting**: Normal level

### Información Capturada
- **Error Code**: ctx:errorCode del fault context
- **Error Reason**: ctx:reason del fault context
- **Service ID**: FICBCO0398 (siempre incluido)
- **Request Headers**: Authentication y otros headers del request original

## Recomendaciones para Manejo de Errores

1. **Monitoreo Proactivo**: Implementar alertas para códigos de error frecuentes
2. **Logging Detallado**: Mantener el nivel debug para troubleshooting
3. **Timeout Configuración**: Considerar configurar timeouts explícitos en conexiones DB
4. **Retry Logic**: Evaluar implementar retry logic para errores transitorios
5. **Error Categorization**: Separar errores técnicos de errores de negocio para mejor handling