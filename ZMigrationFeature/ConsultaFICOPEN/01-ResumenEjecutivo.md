# Resumen Ejecutivo - ConsultaFICOPEN

## Índice de Documentación

1. [Resumen Ejecutivo](01-ResumenEjecutivo.md)
2. [Comparativa entre Regiones](02-ComparativaRegiones.md)
3. [Ejemplos y Mapeos - HN01](03-EjemplosYMapeos-HN01.md)
4. [Diagrama de Secuencia - HN01](04-Secuencia-HN01.mmd)
5. [Diagrama de Flujo Multiregión](05-FlujoMultiregión.mmd)
6. [Listado de Ficheros](06-ListadoFicheros.md)

---

## 1. Propósito de la Funcionalidad

**ConsultaFICOPEN** es un servicio OSB que permite consultar información de cuentas de fondos de pensiones (FICOPEN - Fondo de Inversión Complementaria Obligatoria de Pensiones). El servicio recupera datos detallados de inversiones, incluyendo balances, contribuciones, intereses, retiros, comisiones y seguros para un período específico.

### Objetivo del Negocio
- Proporcionar información consolidada de cuentas de fondos de pensiones
- Consultar movimientos y balances históricos por período
- Facilitar la integración con sistemas de banca digital y canales alternativos

---

## 2. Entradas y Salidas Principales

### 2.1 Entrada (Request)

**Estructura del Request:**
```xml
<consultaFICOPEN>
    <INVESTMENT_CODE>string (mínimo 1 carácter)</INVESTMENT_CODE>
    <START_DATE>string (8 caracteres - formato YYYYMMDD)</START_DATE>
    <END_DATE>string (8 caracteres - formato YYYYMMDD)</END_DATE>
</consultaFICOPEN>
```

**Campos de Entrada:**
- **INVESTMENT_CODE**: Código de inversión/cuenta del fondo de pensiones (obligatorio, mínimo 1 carácter)
- **START_DATE**: Fecha de inicio del período de consulta (obligatorio, formato YYYYMMDD, longitud exacta 8)
- **END_DATE**: Fecha de fin del período de consulta (obligatorio, formato YYYYMMDD, longitud exacta 8)

**Header de Autenticación:**
```xml
<RequestHeader>
    <Authentication>
        <UserName>string</UserName>
        <Password>string</Password>
    </Authentication>
    <Region>
        <SourceBank>string (ej: HN01)</SourceBank>
        <DestinationBank>string (opcional)</DestinationBank>
    </Region>
</RequestHeader>
```

### 2.2 Salida (Response)

**Estructura del Response:**
```xml
<consultaFICOPENResponse>
    <CUSTOMER_LEGAL_ID>string</CUSTOMER_LEGAL_ID>
    <CUSTOMER_NAME>string</CUSTOMER_NAME>
    <ACCOUNT_NUMBER>string</ACCOUNT_NUMBER>
    <ACCOUNT_CURRENCY>string</ACCOUNT_CURRENCY>
    <CONTRACT_NUMBER>string</CONTRACT_NUMBER>
    <CONTRACT_TYPE>string</CONTRACT_TYPE>
    <COMPANY>string</COMPANY>
    <START_DATE>string</START_DATE>
    <consultaFICOPENResponseType>
        <consultaFICOPENResponseRecordType> (0..n)
            <BALANCE_TYPE>string</BALANCE_TYPE>
            <PREVIOUS_BALANCE>string</PREVIOUS_BALANCE>
            <GROSS_CONTRIBUTIONS_AMOUNT>string</GROSS_CONTRIBUTIONS_AMOUNT>
            <INTEREST_AMOUNT>string</INTEREST_AMOUNT>
            <WITHDRAWALS_AMOUNT>string</WITHDRAWALS_AMOUNT>
            <FEE_AMOUNT>string</FEE_AMOUNT>
            <INSURANCE_AMOUNT>string</INSURANCE_AMOUNT>
            <CURRENT_BALANCE>string</CURRENT_BALANCE>
        </consultaFICOPENResponseRecordType>
    </consultaFICOPENResponseType>
</consultaFICOPENResponse>
```

**Campos de Salida:**

**Información del Cliente y Contrato:**
- **CUSTOMER_LEGAL_ID**: Identificación legal del cliente
- **CUSTOMER_NAME**: Nombre del cliente
- **ACCOUNT_NUMBER**: Número de cuenta
- **ACCOUNT_CURRENCY**: Moneda de la cuenta
- **CONTRACT_NUMBER**: Número de contrato
- **CONTRACT_TYPE**: Tipo de contrato
- **COMPANY**: Compañía/Entidad
- **START_DATE**: Fecha de inicio del contrato

**Detalle de Balances (Array):**
- **BALANCE_TYPE**: Tipo de balance (ej: Obligatorio, Voluntario)
- **PREVIOUS_BALANCE**: Balance anterior
- **GROSS_CONTRIBUTIONS_AMOUNT**: Monto de contribuciones brutas
- **INTEREST_AMOUNT**: Monto de intereses
- **WITHDRAWALS_AMOUNT**: Monto de retiros
- **FEE_AMOUNT**: Monto de comisiones
- **INSURANCE_AMOUNT**: Monto de seguros
- **CURRENT_BALANCE**: Balance actual

**Header de Respuesta:**
```xml
<ResponseHeader>
    <successIndicator>SUCCESS|ERROR</successIndicator>
    <messages>string</messages>
</ResponseHeader>
```

---

## 3. Sistemas/Servicios OSB Involucrados

### 3.1 Proxy Service Principal
- **Nombre**: ConsultaFICOPEN
- **Ubicación**: `Middleware/v2/ProxyServices/ConsultaFICOPEN.proxy`
- **Endpoint**: `/SMiddleware/OperationsAndExecution/BundledProducts/ConsultaFICOPEN_v2`
- **Protocolo**: SOAP 1.1
- **Tipo de Binding**: SOAP Document/Literal
- **Autenticación**: Custom Token Authentication (Username/Password en header)

### 3.2 Business Services

#### 3.2.1 getFicopen12c (Servicio Principal - HN01)
- **Ubicación**: `Middleware/v2/BusinessServices/FPC/getFicopen12c/biz/getFicopen12c.biz`
- **Endpoint**: `https://dynamoosbdev:8004/regional/pension/soap/getFICOPEN/v11g`
- **Protocolo**: SOAP/HTTPS
- **Timeout**: 70 segundos
- **Connection Timeout**: 65 segundos
- **Retry Count**: 0
- **Descripción**: Servicio externo que consulta el sistema de fondos de pensiones (FPC - Fondo de Pensiones Complementarias)

#### 3.2.2 ValidaServicioRegional_db
- **Ubicación**: `Middleware/v2/BusinessServices/ValidaServicioRegional/biz/ValidaServicioRegional_db.biz`
- **Tipo**: Database Adapter (JCA)
- **Conexión**: `eis/DB/ConnectionMiddleware`
- **Stored Procedure**: `MW_P_VALIDA_SERVICIO_REGIONAL`
- **Descripción**: Valida que el servicio esté habilitado para la región solicitada

### 3.3 Servicios de Soporte

#### MapeoErrores
- **Ubicación**: `Middleware/v2/ProxyServices/MapeoErrores.proxy`
- **Función**: Mapea códigos de error internos a mensajes estandarizados
- **Service ID**: FICBCO0110

### 3.4 Recursos de Transformación (XQuery)

**Transformaciones de Entrada:**
- `Middleware/v2/Resources/ConsultaFICOPEN/xq/getFICOPENIn.xq`: Mapea request OSB a formato del servicio FPC
- `Middleware/v2/Resources/ConsultaFICOPEN/xq/getFICOPENHeaderIn.xq`: Construye header de autenticación para servicio FPC
- `Middleware/v2/Resources/Generales/xq/validaServicioRegionalIn.xq`: Prepara request de validación regional

**Transformaciones de Salida:**
- `Middleware/v2/Resources/ConsultaFICOPEN/xq/getFICOPENOut.xq`: Mapea response del servicio FPC a formato OSB
- `Middleware/v2/Resources/Generales/xq/aplicarValoresPorDefectoRegion.xq`: Aplica valores por defecto según región
- `Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageIn.xq`: Prepara request de mapeo de errores
- `Middleware/v2/Resources/MapeoErrores/xq/mapeoErroresUsageOut.xq`: Procesa response de mapeo de errores
- `Middleware/v2/Resources/Genericos/mapeoErrorValidate.xq`: Mapea errores de validación XSD

### 3.5 Esquemas (XSD)
- `Middleware/v2/Resources/ConsultaFICOPEN/xsd/consultaFICOPENTypes.xsd`: Define tipos de datos del servicio OSB
- `Middleware/v2/BusinessServices/FPC/getFicopen12c/xsd/GetFicopenTypes.xsd`: Define tipos de datos del servicio FPC
- `Middleware/v2/BusinessServices/FPC/getFicopen12c/xsd/HeaderElements.xsd`: Define estructura de headers
- `Middleware/v2/BusinessServices/ValidaServicioRegional/xsd/ValidaServicioRegional_sp.xsd`: Define parámetros del SP de validación

---

## 4. Riesgos/Limitaciones Conocidas

### 4.1 Riesgos Identificados

**Disponibilidad Regional:**
- ✅ **HN01 (Honduras)**: Implementado y funcional
- ❌ **Otras regiones (GT01, PA01, NI01)**: No implementadas - retorna error "SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY" (MW-0008)

**Dependencias Externas:**
- El servicio depende completamente del sistema FPC (Fondo de Pensiones Complementarias) externo
- Endpoint: `https://dynamoosbdev:8004/regional/pension/soap/getFICOPEN/v11g`
- Sin retry configurado (retry-count: 0)
- Timeout de 70 segundos puede ser insuficiente para consultas de períodos extensos

**Validación Regional:**
- Requiere que el servicio FICBCO0110 esté registrado en la base de datos de middleware para la región
- Si la validación falla, el servicio se detiene antes de invocar el backend

**Seguridad:**
- Autenticación mediante credenciales en header (UserName/Password)
- Las credenciales se obtienen del servicio de seguridad OSB: `Middleware/Security/OSB12AUTH`
- Comunicación HTTPS con el servicio FPC

### 4.2 Limitaciones Técnicas

**Formato de Fechas:**
- Las fechas deben tener exactamente 8 caracteres (YYYYMMDD)
- No hay validación de rangos de fechas válidos
- No hay validación de que START_DATE sea menor que END_DATE

**Validación de Datos:**
- INVESTMENT_CODE solo requiere mínimo 1 carácter, sin validación de formato específico
- No hay validación de existencia del código de inversión antes de invocar el backend

**Manejo de Errores:**
- Los errores de validación XSD (BEA-382505) se manejan de forma especial
- Otros errores se mapean genéricamente
- No hay distinción clara entre errores de negocio y errores técnicos en algunos casos

**Escalabilidad:**
- No hay configuración de throttling (capacidad: 0)
- No hay balanceo de carga configurado (round-robin sin múltiples endpoints)
- Monitoring habilitado con intervalo de agregación de 360 segundos

### 4.3 Puntos de Falla

1. **Servicio FPC no disponible**: Sin retry, falla inmediatamente
2. **Base de datos de validación regional no disponible**: El servicio no puede proceder
3. **Timeout del servicio FPC**: 70 segundos pueden ser insuficientes para grandes volúmenes de datos
4. **Credenciales inválidas**: Si el servicio de seguridad no retorna credenciales válidas

---

## 5. Métricas o SLAs

### 5.1 Configuración de Monitoreo

**Monitoring:**
- Estado: Habilitado
- Intervalo de Agregación: 360 segundos (6 minutos)
- Nivel de Monitoreo: Action (nivel de detalle de pipeline)

**Logging:**
- Estado: Habilitado
- Nivel: Debug

**Alerting:**
- SLA Alerting: Habilitado (nivel normal)
- Pipeline Alerting: Habilitado (nivel normal)

**Message Tracing:**
- Estado: Deshabilitado
- Nivel de Detalle: Terse (cuando se habilita)
- Tamaño Máximo: 8192 bytes

### 5.2 Timeouts Configurados

**Business Service getFicopen12c:**
- **Request Timeout**: 70 segundos
- **Connection Timeout**: 65 segundos
- **Retry Count**: 0 (sin reintentos)
- **Retry Interval**: 0 segundos

### 5.3 SLAs Esperados (No Documentados Explícitamente)

Basado en la configuración técnica, se pueden inferir los siguientes SLAs:

**Tiempo de Respuesta:**
- Tiempo máximo esperado: < 70 segundos (timeout del backend)
- Tiempo típico esperado: No documentado (requiere medición en producción)

**Disponibilidad:**
- No hay configuración de alta disponibilidad
- Depende de la disponibilidad del servicio FPC externo
- Sin failover configurado

**Throughput:**
- No hay límites de throttling configurados
- Capacidad limitada por el backend FPC

### 5.4 Códigos de Servicio

**Service ID**: FICBCO0110
- Utilizado para validación regional
- Utilizado para mapeo de errores

---

## 6. Flujo General de Ejecución

### 6.1 Flujo Exitoso (HN01)

1. **Cliente** → Invoca servicio OSB con request SOAP
2. **ValidacionXSD** → Valida estructura del request contra XSD
3. **ValidacionServicioRegional** → Valida que el servicio esté habilitado para HN01
4. **RegionalizacionPaisEmpresa** → Enruta a pipeline HN01
5. **Transformación Request** → Mapea datos OSB a formato FPC
6. **Invocación getFicopen12c** → Llama al servicio externo FPC
7. **Transformación Response** → Mapea datos FPC a formato OSB
8. **MapeoErrores** → (Solo si hay error) Mapea código de error
9. **Cliente** ← Retorna response SOAP

### 6.2 Flujo de Error

**Error de Validación XSD:**
- Se captura en error handler
- Se mapea con `mapeoErrorValidate.xq`
- Se invoca MapeoErrores
- Se retorna response vacío con error en header

**Error de Validación Regional:**
- Se detiene el flujo
- Se retorna error inmediatamente
- No se invoca el backend

**Error en Backend FPC:**
- Se captura el error en variables `errorCode` y `message`
- Se invoca MapeoErrores para estandarizar el mensaje
- Se retorna response vacío con error en header

**Región No Implementada:**
- Se enruta a pipeline Default
- Se genera error MW-0008: "SERVICE NOT IMPLEMENTED YET FOR THIS COUNTRY/COMPANY"

---

## 7. Consideraciones para Migración

### 7.1 Dependencias Críticas

- **Base de Datos Middleware**: Tabla de validación de servicios regionales
- **Servicio FPC Externo**: Sistema de fondos de pensiones
- **Servicio de Seguridad OSB**: Para obtener credenciales OSB12AUTH
- **Servicio MapeoErrores**: Para estandarización de errores

### 7.2 Configuraciones Específicas

- Credenciales almacenadas en: `Middleware/Security/OSB12AUTH`
- Conexión a BD: `eis/DB/ConnectionMiddleware`
- Stored Procedure: `MW_P_VALIDA_SERVICIO_REGIONAL`

### 7.3 Puntos de Atención

- Solo región HN01 está implementada
- No hay manejo de transacciones distribuidas
- No hay compensación en caso de falla parcial
- El servicio es de solo lectura (consulta)

---

## 8. Información de Contacto y Soporte

**Service ID**: FICBCO0110  
**Versión del Servicio**: v2  
**Ambiente de Desarrollo**: dynamoosbdev:8004  
**Protocolo**: SOAP 1.1 / HTTPS  

---

**Fecha de Análisis**: 2024  
**Versión del Documento**: 1.0  
**Estado**: Análisis AS-IS Completo
