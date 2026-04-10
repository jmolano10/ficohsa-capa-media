# Resumen Ejecutivo - ConsultaConsolidadaRiesgoCliente

## Índice de Documentos
- [01-ResumenEjecutivo.md](01-ResumenEjecutivo.md)
- [02-ComparativaRegiones.md](02-ComparativaRegiones.md)
- [03-EjemplosYMapeos-GT01.md](03-EjemplosYMapeos-GT01.md)
- [03-EjemplosYMapeos-HN01.md](03-EjemplosYMapeos-HN01.md)
- [04-Secuencia-GT01.mmd](04-Secuencia-GT01.mmd)
- [04-Secuencia-HN01.mmd](04-Secuencia-HN01.mmd)
- [05-FlujoMultiregión.mmd](05-FlujoMultiregión.mmd)
- [06-ListadoFicheros.md](06-ListadoFicheros.md)
- [07-MapeoErrores.md](07-MapeoErrores.md)

## Propósito de la Funcionalidad

La funcionalidad **ConsultaConsolidadaRiesgoCliente** es un servicio OSB que proporciona información consolidada de riesgo crediticio de clientes del banco Ficohsa. Este servicio integra datos de múltiples fuentes para ofrecer una visión completa del perfil de riesgo de un cliente, incluyendo información de activos, pasivos, historial crediticio, referencias de burós de crédito y ofertas preaprobadas.

## Entradas y Salidas Principales

### Entrada Principal
- **CUSTOMER_LEGAL_ID** (obligatorio): Identificación legal del cliente
- **FISCAL_ID** (opcional): Número de identificación fiscal
- **FIRST_NAME** (opcional): Primer nombre del cliente
- **LAST_NAME** (opcional): Apellido del cliente
- **BIRTH_DATE** (opcional): Fecha de nacimiento
- **USER_NAME** (opcional): Usuario que realiza la consulta
- **PERSON_TYPE** (opcional): Tipo de persona (física/jurídica)
- **PRODUCT_CODE** (opcional): Código del producto

### Salida Principal
La respuesta incluye dos secciones principales:

1. **LOAN_MAINTENANCE**: Información de mantenimiento de préstamos
   - Información del cliente (datos personales, scores, evaluaciones)
   - Activos (cuentas de depósito, transacciones)
   - Pasivos (tarjetas de crédito, préstamos)
   - Información de direcciones y teléfonos
   - Cargos administrativos y resúmenes de mora

2. **LOAN_ORIGINATIONS**: Información para originación de préstamos
   - Ofertas preaprobadas
   - Extras internos
   - Detalles de referencias de burós de crédito (TUCA, SIRC)
   - Consultas históricas

## Sistemas/Servicios OSB Involucrados

### Servicios Principales
- **ConsultaConsolidadaRiesgoCliente.proxy**: Proxy principal con enrutamiento dinámico
- **ConsultaConsolidadaRiesgoClienteGT.proxy**: Proxy específico para Guatemala
- **ConsultaConsolidadaRiesgoClienteHN.proxy**: Proxy específico para Honduras

### Business Services
- **consultaConsolidadaRiesgoCliente_db**: Conexión a base de datos DataWarehouse
- **sjConsultaConsolidadaRiesgoClienteGT**: Servicio SJS para Guatemala
- **consultaBurosPrecreditoGT**: Consulta de burós de crédito para Guatemala
- **consultaRutaRegional_db**: Servicio de enrutamiento regional
- **MapeoErrores**: Servicio de mapeo de errores

### Bases de Datos
- **ConnectionCustomerCreditRisk**: Conexión a base de datos de riesgo crediticio
- **Esquema**: CREDITOS_RIESGOS
- **Stored Procedure**: p_consulta_ONBASE

## Regiones Detectadas

Basado en el análisis del código fuente, se identificaron las siguientes regiones:

1. **GT01 (Guatemala)**: Implementación completa con consulta de burós de crédito
2. **HN01 (Honduras)**: Implementación con consulta directa a base de datos

## Riesgos/Limitaciones Conocidas

### Riesgos Técnicos
1. **Dependencia de Servicios Externos**: La funcionalidad depende de servicios de burós de crédito externos que pueden fallar
2. **Complejidad de Transformaciones**: Las transformaciones XQuery son complejas y pueden ser propensas a errores
3. **Enrutamiento Dinámico**: El enrutamiento basado en región puede fallar si el servicio de consulta regional no está disponible

### Limitaciones Funcionales
1. **Diferencias Regionales**: Las implementaciones por región tienen diferentes niveles de funcionalidad
2. **Validación de Datos**: La validación se basa principalmente en esquemas XSD
3. **Manejo de Errores**: El manejo de errores es básico y puede no cubrir todos los escenarios

### Limitaciones de Rendimiento
1. **Múltiples Llamadas**: Para Guatemala se realizan múltiples llamadas a servicios externos
2. **Transformaciones Complejas**: Las transformaciones XQuery pueden impactar el rendimiento
3. **Volumen de Datos**: La respuesta puede contener grandes volúmenes de datos históricos

## Métricas y SLAs

### Configuración de Monitoreo
- **Monitoring**: Habilitado con intervalo de agregación de 360 segundos
- **SLA Alerting**: Habilitado en nivel normal
- **Pipeline Alerting**: Habilitado en nivel normal
- **Message Tracing**: Deshabilitado por defecto
- **Logging**: Habilitado en nivel debug

### Configuración de Rendimiento
- **Result Caching**: Habilitado para business services
- **Retry Count**: 0 (sin reintentos automáticos)
- **Load Balancing**: Round-robin

### Identificador de Servicio
- **Service ID**: FICBCO0398

## Consideraciones de Migración

### Aspectos Críticos
1. **Preservar Enrutamiento Regional**: Mantener la lógica de enrutamiento dinámico
2. **Compatibilidad de Contratos**: Asegurar que los contratos WSDL/XSD se mantengan
3. **Configuración de Conexiones**: Migrar correctamente las configuraciones de base de datos
4. **Transformaciones**: Validar que todas las transformaciones XQuery funcionen correctamente

### Dependencias Externas
1. **Burós de Crédito**: Servicios de TransUnion y SIRC para Guatemala
2. **Base de Datos**: DataWarehouse con esquema CREDITOS_RIESGOS
3. **Servicios Compartidos**: MapeoErrores, consultaRutaRegional

## Recomendaciones

1. **Pruebas Exhaustivas**: Realizar pruebas completas por región
2. **Monitoreo Mejorado**: Implementar monitoreo más granular por región
3. **Documentación**: Mantener documentación actualizada de las diferencias regionales
4. **Manejo de Errores**: Mejorar el manejo de errores y logging
5. **Optimización**: Considerar optimizaciones de rendimiento para las transformaciones complejas