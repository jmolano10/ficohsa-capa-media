# Análisis Funcional - SolicitaFinanciamientoTC

## Índice de Documentos

1. [Resumen Ejecutivo](01-ResumenEjecutivo.md)
2. [Comparativa entre Regiones](02-ComparativaRegiones.md)
3. [Ejemplos y Mapeos - HN01](03-EjemplosYMapeos-HN01.md)
4. [Ejemplos y Mapeos - GT01](03-EjemplosYMapeos-GT01.md)
5. [Diagrama de Secuencia - HN01](04-Secuencia-HN01.mmd)
6. [Diagrama de Secuencia - GT01](04-Secuencia-GT01.mmd)
7. [Flujo Multi-región](05-FlujoMultiregión.mmd)
8. [Listado de Ficheros](06-ListadoFicheros.md)
9. [Mapeo de Errores](07-MapeoErrores.md)

---

## 1. Resumen Ejecutivo

### Propósito de la Funcionalidad

**SolicitaFinanciamientoTC** es un servicio OSB que permite a los clientes solicitar financiamientos sobre tarjetas de crédito. El servicio procesa solicitudes de extrafinanciamiento, valida las condiciones crediticias del cliente, consulta ofertas disponibles y registra la gestión en Salesforce para su posterior procesamiento.

### Entradas y Salidas Principales

#### Entrada Principal (Request)
- **CUSTOMER_ID**: Identificación del cliente
- **CARD_NUMBER**: Número de tarjeta de crédito (opcional)
- **TOTAL_AMOUNT**: Monto total solicitado
- **CURRENCY**: Moneda de la transacción
- **NUMBER_OF_PAYMENTS**: Número de cuotas
- **DISBURSEMENT_INFO**: Información del desembolso (tipo, cuenta destino, dirección)
- **EMAIL_ADDRESS**: Correo electrónico del cliente
- **CREDIT_LINE**: Línea de crédito (INTERNAL/EXTERNAL)

#### Salida Principal (Response)
- **TRANSACTION_ID**: ID de transacción generado
- **AMOUNT_REQUESTED**: Monto solicitado
- **MONTHLY_PAYMENT**: Cuota mensual calculada
- **MONTHLY_INTEREST_RATE**: Tasa de interés mensual
- **AVAILABLE_AMOUNT**: Monto disponible después de cargos
- **CHARGES**: Cargos aplicados (desembolso, seguro)
- **STATUS**: Estado de la solicitud (APPROVED/PENDING/REJECTED)

### Sistemas/Servicios OSB Involucrados

#### Servicios Internos OSB
1. **ValidaServicioRegional**: Validación de disponibilidad del servicio por región
2. **MapeoErrores**: Mapeo de códigos de error a mensajes estándar
3. **LoginSalesforce**: Autenticación con Salesforce
4. **RegistrarBitacoraOSB_v2**: Registro de bitácora de transacciones

#### Servicios de Base de Datos
1. **consultaOferta_db** (HN01): Consulta ofertas disponibles en Honduras
   - Base de datos: VASA
   - Stored Procedure: consultaOferta
   - Parámetros: Pv_Identidad, Pv_Linea

2. **consultaOferta_db** (GT01): Consulta ofertas disponibles en Guatemala
   - Base de datos: BLAZEGT
   - Stored Procedure: consultaOferta
   - Parámetros: Pv_Identidad, Pv_Linea

#### Servicios Externos
1. **SalesforceHNIngresaGestionExtra** (HN01): Registro de gestión en Salesforce Honduras
2. **SalesforceRGNIngresaGestionExtra** (GT01): Registro de gestión en Salesforce Guatemala

#### Servicios de Parametrización
1. **ObtenerParametrizacion**: Obtención de parámetros de configuración
   - FICBCO0269.DISBURSERATE: Tasa de desembolso
   - FICBCO0269.PRODUCTQUANTIFY: Producto a cuotificar
   - FICBCO0269.DISBURSEMENTYPE: Tipo de desembolso

### Regiones Detectadas

Basado en el análisis del código fuente, se identificaron las siguientes regiones:

1. **HN01** (Honduras): Implementación completa con flujo específico
2. **GT01** (Guatemala): Implementación completa con flujo específico
3. **Otras regiones**: Flujo por defecto que retorna error "SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY"

### Riesgos/Limitaciones Conocidas

#### Riesgos Técnicos
1. **Dependencia de Salesforce**: El servicio depende críticalmente de la disponibilidad de Salesforce
2. **Manejo de sesiones**: Implementa retry automático en caso de sesión inválida (INVALID_SESSION_ID)
3. **Validación de ofertas**: Falla si no hay ofertas disponibles para el monto/plazo solicitado
4. **Conectividad de base de datos**: Dependencia de conexiones a bases de datos regionales

#### Limitaciones Funcionales
1. **Cobertura regional limitada**: Solo implementado para HN01 y GT01
2. **Validación estricta**: Rechaza solicitudes que no coincidan exactamente con ofertas preconfiguradas
3. **Tipos de desembolso limitados**: Solo soporta tipos parametrizados
4. **Dependencia de parametrización**: Requiere configuración previa de tasas y productos

### Métricas o SLAs

#### Identificadores de Servicio
- **Service ID**: FICBCO0269
- **Operación**: solicitaFinanciamientoTC

#### Configuraciones de Monitoreo
- **Logging**: Habilitado (nivel debug)
- **SLA Alerting**: Habilitado (nivel normal)
- **Pipeline Alerting**: Habilitado (nivel normal)
- **Reporting**: Habilitado

#### Bitácora de Transacciones
- Registro automático de request y response
- UUID único por transacción
- Información de usuario, banco origen/destino
- Registro de errores y resultados

### Flujo de Procesamiento General

1. **Validaciones Iniciales**
   - Validación XSD del request
   - Validación de servicio regional
   - Registro de bitácora de entrada

2. **Parametrización**
   - Obtención de parámetros de configuración
   - Configuración de tasas y productos por región

3. **Consulta de Ofertas**
   - Consulta a base de datos regional
   - Validación de condiciones crediticias

4. **Autenticación Salesforce**
   - Login a Salesforce regional
   - Manejo de sesiones y retry automático

5. **Registro de Gestión**
   - Creación de registro en Salesforce
   - Procesamiento de respuesta

6. **Respuesta Final**
   - Construcción de response con datos calculados
   - Mapeo de errores si es necesario
   - Registro de bitácora de salida

### Consideraciones para Migración

#### Puntos Críticos
1. **Configuración de parámetros**: Migrar configuraciones de base de datos
2. **Credenciales Salesforce**: Configurar accesos por región
3. **Conexiones de base de datos**: Configurar conexiones regionales
4. **Mapeo de errores**: Migrar tabla de mapeo de errores

#### Dependencias Externas
1. **Salesforce**: Configuración de servicios web por región
2. **Bases de datos**: VASA (HN), BLAZEGT (GT)
3. **Servicios de parametrización**: Configuración centralizada
4. **Servicios de bitácora**: Sistema de auditoría