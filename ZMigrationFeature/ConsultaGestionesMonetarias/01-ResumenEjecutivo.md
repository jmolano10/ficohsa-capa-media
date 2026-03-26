# Resumen Ejecutivo - ConsultaGestionesMonetarias

## Índice de Documentos
- [01-ResumenEjecutivo.md](01-ResumenEjecutivo.md)
- [02-ComparativaRegiones.md](02-ComparativaRegiones.md)
- [03-EjemplosYMapeos-HN01.md](03-EjemplosYMapeos-HN01.md)
- [03-EjemplosYMapeos-GT01.md](03-EjemplosYMapeos-GT01.md)
- [03-EjemplosYMapeos-PA01.md](03-EjemplosYMapeos-PA01.md)
- [04-Secuencia-HN01.mmd](04-Secuencia-HN01.mmd)
- [04-Secuencia-GT01.mmd](04-Secuencia-GT01.mmd)
- [04-Secuencia-PA01.mmd](04-Secuencia-PA01.mmd)
- [05-FlujoMultiregión.mmd](05-FlujoMultiregión.mmd)
- [06-ListadoFicheros.md](06-ListadoFicheros.md)
- [07-MapeoErrores.md](07-MapeoErrores.md)

## Propósito de la Funcionalidad

La funcionalidad **ConsultaGestionesMonetarias** es un servicio OSB que permite consultar información detallada sobre gestiones monetarias de clientes en el sistema bancario. Este servicio proporciona datos financieros específicos incluyendo importes, fechas, categorías y estados de diferentes operaciones monetarias asociadas a un usuario específico.

## Entradas y Salidas Principales

### Entradas
- **NUMUSU** (decimal): Número de usuario/cliente
- **DETALLE_GESTION** (string): Detalle específico de la gestión a consultar
- **PAIS** (string): Código del país para regionalización

### Salidas
- **NUMUSU** (decimal): Número de usuario
- **DETALLE** (string): Detalle de la gestión
- **IMP_M_LOCAL** (decimal): Importe en moneda local
- **IMP_M_USD** (decimal): Importe en dólares USD
- **FECHA_ORIGEN** (string): Fecha de origen de la operación
- **FECHA_LIQ** (string): Fecha de liquidación
- **FECHA_VENCIMIENTO** (string): Fecha de vencimiento
- **FECHA_LIQ_PROX** (string): Fecha de próxima liquidación
- **FECHA_PAGO** (string): Fecha de pago
- **PORCENTAJE** (int): Porcentaje aplicado
- **CATEGORIA** (string): Categoría de la gestión
- **SUB_CATEGORIA** (string): Subcategoría de la gestión
- **OPERACION** (string): Tipo de operación
- **PAGO_MLOCAL** (decimal): Pago en moneda local
- **PAGO_USD** (decimal): Pago en USD
- **SALDO_ACT_MLOCAL** (decimal): Saldo actual en moneda local
- **SALDO_ACT_USD** (decimal): Saldo actual en USD

## Sistemas/Servicios OSB Involucrados

### Proxy Services
- **ConsultaGestionesMonetarias.proxy**: Servicio principal que maneja la lógica de enrutamiento regional
- **ConsultaGestionesMonetarias.proxy** (External): Servicio externo que actúa como punto de entrada

### Business Services
- **consultaGestionesMonetarias_db.biz**: Adaptador de base de datos que ejecuta el stored procedure
- **ValidaServicioRegional_db.biz**: Servicio de validación regional

### Stored Procedure
- **SFC_P_CON_GESTIONES_MONETARIAS**: Procedimiento almacenado en esquema SALESFORCE que ejecuta la consulta

### Conexiones
- **ConnectionInterfazSFC**: Conexión JCA a base de datos Oracle para interfaz Salesforce

## Regiones Detectadas

Basado en el análisis del código fuente, se identificaron las siguientes regiones:

1. **HN01** - Honduras
2. **GT01** - Guatemala  
3. **PA01** - Panamá

Cada región tiene sus propias transformaciones XQuery específicas para entrada y salida de datos.

## Riesgos/Limitaciones Conocidas

### Riesgos Técnicos
- **Dependencia de Base de Datos**: El servicio depende completamente de la disponibilidad de la base de datos Oracle con esquema SALESFORCE
- **Validación Regional**: Falla en validación regional resulta en error inmediato del servicio
- **Transformaciones Específicas**: Cada región requiere transformaciones XQuery específicas

### Limitaciones Funcionales
- **Regiones Soportadas**: Solo soporta HN01, GT01 y PA01. Otras regiones retornan error "SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY"
- **Autenticación Requerida**: Requiere credenciales válidas en el header de la petición
- **Validación XSD**: Validación estricta de esquema en entrada

### Limitaciones de Datos
- **Dependencia de Stored Procedure**: La lógica de negocio está encapsulada en el SP SFC_P_CON_GESTIONES_MONETARIAS
- **Formato de Fechas**: Las fechas se manejan como strings con formato específico
- **Precisión Decimal**: Los importes monetarios dependen de la precisión configurada en base de datos

## Métricas o SLAs

### Configuración de Monitoreo
- **Logging**: Habilitado en nivel debug
- **SLA Alerting**: Habilitado con nivel normal
- **Pipeline Alerting**: Habilitado con nivel normal
- **Reporting**: Habilitado

### Configuración de Reintentos
- **Retry Count**: 0 (sin reintentos automáticos)
- **Retry Interval**: 30 segundos
- **Retry Application Errors**: true

### Timeouts
- No se encontraron configuraciones específicas de timeout en los artefactos analizados

## Arquitectura de Seguridad

### Autenticación
- **Custom Token Authentication**: Utiliza username/password extraídos del header
- **HTTPS**: Configurado para usar conexiones seguras
- **WSDL Policy Attachments**: Políticas de seguridad definidas en WSDL

### Validaciones
- **Validación XSD**: Validación estricta del esquema de entrada
- **Validación Regional**: Verificación de región válida antes del procesamiento
- **Mapeo de Errores**: Sistema centralizado de mapeo de errores con código de servicio FICBCO0287

## Flujo de Procesamiento

1. **Validación de Entrada**: Validación XSD del request
2. **Validación Regional**: Verificación de región y servicio válido
3. **Enrutamiento Regional**: Direccionamiento a pipeline específico según región
4. **Transformación de Entrada**: Mapeo de datos según región
5. **Ejecución de SP**: Llamada al stored procedure SFC_P_CON_GESTIONES_MONETARIAS
6. **Transformación de Salida**: Mapeo de respuesta según región
7. **Construcción de Response**: Generación de respuesta final con header y body