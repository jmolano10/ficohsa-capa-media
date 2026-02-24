# Resumen Ejecutivo - PagoPrestamo (Análisis Completo)

## 1. IDENTIFICACIÓN DEL SERVICIO

### Información General
- **Nombre del Servicio**: PagoPrestamo
- **ID del Servicio**: FICBCO0076
- **Versión**: v2
- **Tipo**: Proxy Service (Oracle Service Bus)
- **Ubicación**: `Middleware/v2/ProxyServices/PagoPrestamo.proxy`
- **Endpoint**: `/SMiddleware/OperationsAndExecution/Payments/PagoPrestamo_v2`
- **Protocolo**: SOAP 1.1 sobre HTTPS
- **Puerto WSDL**: pagoPrestamoPSSOAP
- **Namespace WSDL**: http://www.ficohsa.com.hn/middleware.services/pagoPrestamoPS/

### Autenticación y Seguridad
- **Tipo de Autenticación**: Custom Token Authentication (Username/Password)
- **Extracción de Usuario**: XPath desde `./aut:RequestHeader/Authentication/UserName/text()`
- **Extracción de Contraseña**: XPath desde `./aut:RequestHeader/Authentication/Password/text()`
- **Variable de Contexto**: header
- **Transporte**: HTTPS obligatorio
- **WSI-Compliant**: false

### Configuración de Monitoreo y Logging
- **Monitoring**: Habilitado
  - Intervalo de Agregación: 720 minutos (12 horas)
  - Nivel de Pipeline: Action
- **Reporting**: Habilitado
- **Logging**: Habilitado
  - Nivel: debug
- **SLA Alerting**: Habilitado
  - Nivel: normal
- **Pipeline Alerting**: Habilitado
  - Nivel: normal
- **Tracing**: Deshabilitado
- **Auto-Publish**: Deshabilitado

## 2. PROPÓSITO Y FUNCIONALIDAD

### Descripción General
Servicio multiregional para procesar pagos de préstamos en 4 países de Centroamérica (Honduras, Guatemala, Panamá, Nicaragua). Implementa lógica de negocio compleja con múltiples tipos de pago, validaciones regionales, integración con sistemas core bancarios heterogéneos (T24 y ABANKS), y mecanismos de reversión automática de transacciones.

### Capacidades Principales
1. **Procesamiento de Pagos Multiregional**: Soporte para 4 regiones con lógicas diferenciadas
2. **Múltiples Tipos de Pago**: ACCOUNT_DEBIT, CASH, OTHER_BANK_CHEQUE (según región)
3. **Integración Dual de Sistemas Core**: T24 y ABANKS en Honduras
4. **Validación Regional**: Verificación de servicios habilitados por región
5. **Reversión Automática**: Rollback de transacciones en caso de fallo
6. **Mapeo de Errores**: Estandarización de códigos de error
7. **Soporte Multi-Moneda**: HNL y USD

## 3. REGIONES SOPORTADAS

### HN01 - Honduras (Banco Ficohsa Honduras)
- **Sistemas Core**: T24 + ABANKS (Dual)
- **Tipos de Pago Soportados**: 
  - ACCOUNT_DEBIT (Débito a cuenta)
  - CASH (Efectivo)
  - OTHER_BANK_CHEQUE (Cheque de otro banco)
- **Monedas**: HNL, USD
- **Complejidad**: ALTA
- **Características Especiales**:
  - Determinación automática de tipo de préstamo (T24 vs ABANKS)
  - Proceso de dos fases: Transferencia + Registro en ABANKS
  - Reversión automática si falla registro en ABANKS
  - Consulta de productos vía SJS
  - Validación de moneda de cuenta vs préstamo
  - Soporte para transferencias internacionales
  - Manejo de cuentas intermediarias

### GT01 - Guatemala (Banco Ficohsa Guatemala)
- **Sistema Core**: ABANKS únicamente
- **Tipos de Pago Soportados**: 
  - ACCOUNT_DEBIT (Débito a cuenta)
- **Stored Procedure**: OSB_P_PAGO_PRESTAMO
- **Conexión DB**: eis/DB/ConnectionProxyAbanksGT
- **Complejidad**: BAJA
- **Características Especiales**:
  - Implementación simplificada
  - Un solo tipo de pago
  - Llamada directa a stored procedure

### PA01 - Panamá (Banco Ficohsa Panamá)
- **Sistema Core**: ABANKS únicamente
- **Tipos de Pago Soportados**: 
  - ACCOUNT_DEBIT (Débito a cuenta)
- **Stored Procedure**: OSB_P_PAGO_PRESTAMO
- **Conexión DB**: eis/DB/ConnectionProxyAbanksPA
- **Complejidad**: BAJA
- **Características Especiales**:
  - Implementación idéntica a GT01
  - Diferencia solo en conexión de base de datos

### NI01 - Nicaragua (Banco Ficohsa Nicaragua)
- **Sistema Core**: COBIS (Sistema externo)
- **Tipos de Pago Soportados**: 
  - ACCOUNT_DEBIT (Débito a cuenta)
- **Protocolo**: SOAP 1.2
- **Endpoint**: http://10.235.53.145:9080/GerenciaProductoPrestamo/SrvAplCobisPrestamoService
- **Operación**: OpPagarPrestamo
- **Complejidad**: MEDIA
- **Características Especiales**:
  - Única región con integración SOAP externa
  - Conversión de formato de fecha (yyyy-MM-dd a yyyyMMdd)
  - Contexto transaccional con valores fijos
  - Validación de esquema XSD en request

## 4. ESTRUCTURA DE DATOS

### Request (pagoPrestamo)
```xml
<pagoPrestamo>
  <LOAN_NUMBER>string</LOAN_NUMBER>              <!-- Obligatorio -->
  <PAYMENT_AMOUNT>decimal</PAYMENT_AMOUNT>       <!-- Obligatorio -->
  <PAYMENT_TYPE>string</PAYMENT_TYPE>            <!-- Obligatorio: ACCOUNT_DEBIT|CASH|OTHER_BANK_CHEQUE -->
  <DEBIT_ACCOUNT>string</DEBIT_ACCOUNT>          <!-- Opcional: Requerido para ACCOUNT_DEBIT -->
  <CHEQUE_NUMBER>string</CHEQUE_NUMBER>          <!-- Opcional: Requerido para OTHER_BANK_CHEQUE -->
  <BANK_CODE>string</BANK_CODE>                  <!-- Opcional: Requerido para OTHER_BANK_CHEQUE -->
  <INTERFACE_REFERENCE_NO>string</INTERFACE_REFERENCE_NO>  <!-- Opcional -->
  <DEBIT_CREDIT>string</DEBIT_CREDIT>            <!-- Opcional: CREDIT|DEBIT (HN01) -->
</pagoPrestamo>
```

### Response (pagoPrestamoResponse)
```xml
<pagoPrestamoResponse>
  <DATE_TIME>string</DATE_TIME>                  <!-- Formato: yyyyMMdd -->
  <LOAN_NUMBER>string</LOAN_NUMBER>
  <DUE_ID>string</DUE_ID>                        <!-- Puede estar vacío -->
  <PAYMENT_AMOUNT>decimal</PAYMENT_AMOUNT>
</pagoPrestamoResponse>
```

### Request Header
```xml
<RequestHeader>
  <Authentication>
    <UserName>string</UserName>
    <Password>string</Password>
  </Authentication>
  <Region>
    <SourceBank>string</SourceBank>              <!-- HN01|GT01|PA01|NI01 -->
    <DestinationBank>string</DestinationBank>    <!-- HN01|GT01|PA01|NI01 -->
  </Region>
</RequestHeader>
```

### Response Header
```xml
<ResponseHeader>
  <transactionId>string</transactionId>          <!-- ID de transacción -->
  <successIndicator>string</successIndicator>    <!-- SUCCESS|ERROR|TIMEOUT -->
  <messages>string</messages>                    <!-- Mensaje descriptivo -->
  <valueDate>string</valueDate>                  <!-- Fecha valor (opcional) -->
</ResponseHeader>
```

## 5. FLUJO DE PROCESAMIENTO GENERAL

### Fase 1: Validaciones Generales (Todas las Regiones)
1. **Validación XSD**: Verificación de estructura del request contra schema
2. **Validación de Servicio Regional**: 
   - Llamada a stored procedure `MW_P_VALIDA_SERVICIO_REGIONAL`
   - Parámetros: PV_SERVICIO='FICBCO0076', PV_ORIGEN, PV_DESTINO
   - Conexión: eis/DB/ConnectionMiddleware
3. **Aplicación de Valores por Defecto**:
   - SourceBank por defecto: HN01
   - DestinationBank por defecto: igual a SourceBank
4. **Validación de Cruce País/Empresa**:
   - SourceBank debe ser igual a DestinationBank
   - Si son diferentes: Error MW-0008
5. **Determinación de Tipo de Préstamo** (Solo HN01):
   - Si LOAN_NUMBER inicia con "AA": T24
   - Si LOAN_NUMBER es numérico: ABANKS
   - Caso contrario: ERROR

### Fase 2: Procesamiento Regional
Enrutamiento basado en SourceBank hacia pipeline específico.

### Fase 3: Mapeo de Errores
- Si successIndicator != "SUCCESS": Llamada a MapeoErrores proxy
- Formato de mensaje: "FICBCO0076$#$[mensaje_error]"

## 6. DEPENDENCIAS Y SERVICIOS EXTERNOS

### Business Services Utilizados

#### HN01 - Honduras
1. **sjConsultaProductos** (SJS)
   - Consulta información de préstamos y cuentas
   - Retorna: SUCCESS_INDICATOR, CURRENCY, etc.

2. **ObtenerParametrizacion**
   - Obtiene configuraciones del sistema
   - Parámetros consultados:
     - T24T134.[CURRENCY]CREDITACCTNO
     - T24T133.TXNTYPELOANPYMT
     - T24T057.INTACCOUNT.USERS
     - T24T032.HNLOBCHQACCTNO
     - T24T032.USDOBCHQACCTNO

3. **transferenciasBS**
   - Operaciones:
     - Transfmodelbankentrecuentas
     - Transfentrecuentasinstrcredito
     - Transferenciaentrecuentas

4. **pagoPrestamoT24BS**
   - Stored Procedure: OSB_PAG_PRESTAMO_T24
   - Conexión: eis/DB/ConnectionInterbanca

5. **consultaGeneralPrestamoBS**
   - Consulta general de préstamos

6. **consultaCuentasBS**
   - Operación: Consultadedetallesdelacuenta
   - Servicio T24 Web Services

7. **PrestamosT24BS**
   - Operaciones:
     - PagoaprestamoAA
     - ConsultadepagodeprestamoAA

8. **debitoPrestamoBS**
   - Operaciones:
     - Depositoenefectivofase11 (HNL)
     - Depositoenefectivofase12 (USD)

9. **depositoCombinadoBS**
   - Operación: Depositocombinado

10. **ReversarTransaccion** (Proxy)
    - Reversión de transacciones fallidas

#### GT01 - Guatemala
1. **PagoPrestamo_db**
   - Stored Procedure: OSB_P_PAGO_PRESTAMO
   - Conexión: eis/DB/ConnectionProxyAbanksGT

#### PA01 - Panamá
1. **pagoPrestamo_db**
   - Stored Procedure: OSB_P_PAGO_PRESTAMO
   - Conexión: eis/DB/ConnectionProxyAbanksPA

#### NI01 - Nicaragua
1. **prestamo** (COBIS)
   - Operación SOAP: OpPagarPrestamo
   - Endpoint: http://10.235.53.145:9080/GerenciaProductoPrestamo/SrvAplCobisPrestamoService
   - SOAP Version: 1.2

### Proxy Services Utilizados
1. **MapeoErrores**: Estandarización de códigos de error
2. **ReversarTransaccion**: Reversión de transacciones (HN01)

## 7. TRANSFORMACIONES XQUERY

### Transformaciones Comunes
- `validaServicioRegionalIn.xq`: Mapeo para validación regional
- `aplicarValoresPorDefectoRegion.xq`: Aplicación de valores por defecto
- `validarCrucePaisEmpresa.xq`: Validación de cruce regional
- `validarTipoPrestamo.xq`: Determinación de tipo de préstamo (T24/ABANKS)
- `mapeoErroresUsageIn.xq`: Mapeo de entrada para errores
- `mapeoErroresUsageOut.xq`: Mapeo de salida para errores
- `obtenerUUID.xq`: Generación de identificadores únicos

### Transformaciones HN01
- `pagoPrestamoIn.xq`: Request a stored procedure T24
- `pagoPrestamoT24In.xq`: Request a servicio T24 SOAP
- `pagoPrestamoT24Out.xq`: Response de servicio T24
- `pagoPrestamoT24HeaderOut.xq`: Header de response T24
- `consultaDetalleCuentaIn.xq`: Consulta de detalles de cuenta
- `consultaPagoPtmoT24In.xq`: Consulta de pago en T24
- `pagoPtmoConsProductosIn.xq`: Consulta de productos SJS
- `debitoPrestamoCuentaIn.xq`: Débito internacional
- `debitoPrestamoCuentaAuthIn.xq`: Débito con autorización
- `pagoPrestamoAuthIn.xq`: Pago con autorización
- `depositoPrestamoEfectivoLocalIn.xq`: Depósito efectivo HNL
- `depositoPrestamoEfectivoExtranjeraIn.xq`: Depósito efectivo USD
- `debitoPrestamoChequeLocalIn.xq`: Cheque local HNL
- `debitoPrestamoChequeExtranjeraIn.xq`: Cheque extranjero USD
- `pagoPrestamoHeaderOut.xq`: Header de response ABANKS
- `pagoPrestamoOut.xq`: Response ABANKS
- `reversarTransaccionIn.xq`: Request de reversión
- `consultaGeneralPrestamoIn.xq`: Consulta general de préstamo

### Transformaciones GT01
- `pagoPtmoGTIn.xq`: Request a stored procedure
- `pagoPtmoGTOut.xq`: Response de stored procedure
- `pagoPtmoGTHeaderOut.xq`: Header de response

### Transformaciones PA01
- `pagoPtmoPAIn.xq`: Request a stored procedure
- `pagoPtmoPAOut.xq`: Response de stored procedure
- `pagoPtmoPAHeaderOut.xq`: Header de response

### Transformaciones NI01
- `pagoPrestamoNIIn.xq`: Request a COBIS SOAP
- `pagoPrestamoNIOut.xq`: Response de COBIS
- `pagoPrestamoNIHeaderOut.xq`: Header de response COBIS

## 8. MANEJO DE ERRORES

### Códigos de Error del Sistema
- **BEA-382505**: Error de validación XSD
- **MW-0002**: Request inválido
- **MW-0008**: Servicio no implementado para país/empresa
- **ERROR**: Error genérico
- **TIMEOUT**: Timeout en transacción T24
- **SUCCESS**: Operación exitosa

### Estrategia de Manejo de Errores
1. **Error Handler Global**: Pipeline `_onErrorHandler` captura todos los errores
2. **Validación XSD**: Errores mapeados con `mapeoErrorValidate.xq`
3. **Errores de Negocio**: Mapeados vía proxy MapeoErrores
4. **Reversión Automática**: En HN01, si falla registro en ABANKS después de transferencia exitosa

### Mensajes de Error Comunes
- "REQUIRED FIELDS NOT SUPPLIED"
- "PAYMENT TYPE NOT SUPPORTED"
- "PAYMENT TYPE NOT AVAILABLE"
- "SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY"
- "INVALID REQUEST"
- "TRANSACCION EN ESPERA. REVISE SU CUENTA EN 5 MINUTOS" (TIMEOUT T24)
- "ERROR APLICANDO PAGO A PRESTAMO" (ERROR T24)

## 9. CONFIGURACIÓN DE RETRY

### HN01
- **Retry Habilitado**: Sí (implícito en llamadas a T24)
- **Intentos**: 1 retry
- **Intervalo**: 30 segundos
- **Servicios con Retry**: Servicios T24 Web Services

### GT01, PA01, NI01
- **Retry Habilitado**: No
- **Estrategia**: Fallo inmediato

## 10. MÉTRICAS Y CONSIDERACIONES DE RENDIMIENTO

### Tiempos de Procesamiento Estimados
- **HN01 ACCOUNT_DEBIT**: 3-5 segundos (múltiples llamadas)
- **HN01 CASH**: 2-4 segundos
- **HN01 OTHER_BANK_CHEQUE**: 3-5 segundos
- **GT01/PA01**: 1-2 segundos (llamada directa a SP)
- **NI01**: 2-3 segundos (llamada SOAP externa)

### Puntos de Contención
1. **Consulta SJS** (HN01): Puede ser lenta
2. **Servicios T24 Web Services** (HN01): Latencia variable
3. **Stored Procedures**: Dependiente de carga de BD
4. **Servicio COBIS** (NI01): Dependiente de disponibilidad externa

### Recomendaciones de Optimización
1. Implementar caché para consultas de parametrización
2. Paralelizar consultas independientes
3. Implementar circuit breaker para servicios externos
4. Monitorear tiempos de respuesta por región
5. Implementar timeout configurables por servicio

## 11. CONSIDERACIONES DE SEGURIDAD

### Autenticación
- Custom token con usuario/contraseña en header
- Mapeo de credenciales LDAP a credenciales T24
- Función `getUsername()` y `getPassword()` para lookup de credenciales

### Transporte
- HTTPS obligatorio
- No se especifica versión TLS mínima

### Datos Sensibles
- Contraseñas en tránsito (header)
- Números de cuenta
- Montos de transacciones
- Números de cheque

### Recomendaciones
1. Implementar encriptación de credenciales en header
2. Auditoría completa de transacciones
3. Enmascaramiento de datos sensibles en logs
4. Implementar rate limiting por usuario
5. Validación de autorización por monto

## 12. TESTING Y CALIDAD

### Estado Actual
- **Unit Tests**: No encontrados en repositorio
- **Integration Tests**: No encontrados
- **Test Data**: No documentado

### Cobertura de Pruebas Recomendada
1. **Pruebas Unitarias**:
   - Validaciones XSD
   - Transformaciones XQuery
   - Lógica de enrutamiento regional

2. **Pruebas de Integración**:
   - Flujo completo por región
   - Manejo de errores
   - Reversión de transacciones

3. **Pruebas de Carga**:
   - Concurrencia por región
   - Stress testing de stored procedures
   - Timeout scenarios

4. **Pruebas de Seguridad**:
   - Inyección SQL
   - Validación de autenticación
   - Autorización por región

## 13. MIGRACIÓN Y MODERNIZACIÓN

### Complejidad de Migración
- **HN01**: ALTA (lógica compleja, múltiples integraciones)
- **GT01**: BAJA (stored procedure simple)
- **PA01**: BAJA (idéntico a GT01)
- **NI01**: MEDIA (integración SOAP externa)

### Estrategia de Migración Recomendada
1. **Fase 1**: Migrar GT01 y PA01 (bajo riesgo)
2. **Fase 2**: Migrar NI01 (riesgo medio)
3. **Fase 3**: Migrar HN01 (alto riesgo, requiere más tiempo)

### Tecnologías Target Sugeridas
- **API Gateway**: AWS API Gateway / Kong / Apigee
- **Orquestación**: AWS Step Functions / Camunda
- **Microservicios**: Spring Boot / Node.js
- **Base de Datos**: Mantener conexiones existentes
- **Mensajería**: AWS SQS/SNS para asincronía

### Refactorización Recomendada
1. Separar lógica de negocio de orquestación
2. Implementar patrón Saga para transacciones distribuidas
3. Externalizar configuraciones
4. Implementar API REST además de SOAP
5. Separar servicios por región (microservicios independientes)

## 14. DOCUMENTACIÓN ADICIONAL GENERADA

1. **02-ComparativaRegiones.md**: Análisis comparativo detallado
2. **03-EjemplosYMapeos-[REGION].md**: Ejemplos y mapeos por región
3. **04-Secuencia-[REGION].mmd**: Diagramas de secuencia Mermaid
4. **05-FlujoMultiregión.mmd**: Diagrama de flujo completo
5. **06-ListadoFicheros.md**: Inventario exhaustivo de archivos

## 15. CONTACTOS Y REFERENCIAS

### Artefactos Clave
- **Proxy**: `Middleware/v2/ProxyServices/PagoPrestamo.proxy`
- **WSDL**: `Middleware/v2/Resources/PagoPrestamo/wsdl/pagoPrestamoPS.wsdl`
- **XSD**: `Middleware/v2/Resources/PagoPrestamo/xsd/pagoPrestamoTypes.xsd`
- **XQueries**: `Middleware/v2/Resources/PagoPrestamo/xq/`

### Sistemas Integrados
- **T24**: Sistema core bancario (HN01)
- **ABANKS**: Sistema core bancario (HN01, GT01, PA01)
- **COBIS**: Sistema core bancario (NI01)
- **SJS**: Sistema de consulta de productos (HN01)

---

**Fecha de Análisis**: 2024
**Versión del Documento**: 1.0 COMPLETO
**Estado**: Análisis Exhaustivo Completado
