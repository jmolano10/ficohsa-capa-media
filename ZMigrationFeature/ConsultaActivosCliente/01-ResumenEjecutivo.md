# Resumen Ejecutivo - ConsultaActivosCliente

## Índice de Documentación

1. [Resumen Ejecutivo](01-ResumenEjecutivo.md)
2. [Comparativa entre Regiones](02-ComparativaRegiones.md)
3. Ejemplos y Mapeos por Región:
   - [HN01 - Honduras](03-EjemplosYMapeos-HN01.md)
   - [GT01 - Guatemala](03-EjemplosYMapeos-GT01.md)
   - [PA01 - Panamá](03-EjemplosYMapeos-PA01.md)
   - [NI01 - Nicaragua](03-EjemplosYMapeos-NI01.md)
4. Diagramas de Secuencia por Región:
   - [HN01 - Honduras](04-Secuencia-HN01.mmd)
   - [GT01 - Guatemala](04-Secuencia-GT01.mmd)
   - [PA01 - Panamá](04-Secuencia-PA01.mmd)
   - [NI01 - Nicaragua](04-Secuencia-NI01.mmd)
5. [Diagrama de Flujo Multiregión](05-FlujoMultiregion.mmd)
6. [Listado de Ficheros](06-ListadoFicheros.md)

---

## 1. Propósito de la Funcionalidad

**ConsultaActivosCliente** es un servicio OSB que permite consultar los activos financieros de un cliente en el sistema bancario. Los activos incluyen:

- **Cuentas de Ahorro (AHO)**: Cuentas de ahorro del cliente
- **Cuentas Corrientes (CHQ)**: Cuentas corrientes/cheques del cliente
- **Depósitos a Plazo (DEP)**: Certificados de depósito a plazo fijo
- **Fondos de Pensiones (FPC)**: Fondos de pensiones (solo Honduras)
- **Todas las Cuentas (CTA/ALL)**: Consulta consolidada de todos los tipos de activos

El servicio está regionalizado para operar en cuatro países: Honduras (HN01), Guatemala (GT01), Panamá (PA01) y Nicaragua (NI01), cada uno con su propia implementación y sistemas backend.

---

## 2. Entradas y Salidas Principales

### 2.1. Entrada Principal (Request OSB)

**Endpoint**: `/SMiddleware/OperationsAndExecution/PositionManagement/ConsultaActivosCliente_v2`

**Protocolo**: SOAP/HTTPS

**Estructura del Request**:

```xml
<consultaActivosClienteRequest>
    <CUSTOMER_ID>string</CUSTOMER_ID>           <!-- ID del cliente -->
    <ASSET_TYPE>string</ASSET_TYPE>             <!-- Tipo: AHO, CHQ, DEP, FPC, CTA, ALL -->
</consultaActivosClienteRequest>
```

**Header de Autenticación**:

```xml
<RequestHeader>
    <Authentication>
        <UserName>string</UserName>
        <Password>string</Password>
    </Authentication>
    <Region>
        <SourceBank>string</SourceBank>         <!-- HN01, GT01, PA01, NI01 -->
        <DestinationBank>string</DestinationBank>
    </Region>
</RequestHeader>
```

### 2.2. Salida Principal (Response OSB)

```xml
<consultaActivosClienteResponse>
    <consultaActivosClienteAhorrosResponseType>
        <SUCCESS_INDICATOR>string</SUCCESS_INDICATOR>
        <consultaActivosClienteResponseRecordType>
            <ASSET_TYPE>string</ASSET_TYPE>
            <ASSET_NUMBER>string</ASSET_NUMBER>
            <ASSET_NAME>string</ASSET_NAME>
            <ASSET_CURRENCY>string</ASSET_CURRENCY>
            <ASSET_TOTAL_BALANCE>decimal</ASSET_TOTAL_BALANCE>
            <ASSET_RESERVE_BALANCE>decimal</ASSET_RESERVE_BALANCE>
            <ASSET_LOCKED_BALANCE>decimal</ASSET_LOCKED_BALANCE>
            <ASSET_VISA_FLOATING_BALANCE>decimal</ASSET_VISA_FLOATING_BALANCE>
            <ASSET_AVAILABLE_BALANCE>decimal</ASSET_AVAILABLE_BALANCE>
            <ASSET_SOURCE_BANK>string</ASSET_SOURCE_BANK>
            <ASSET_PRODUCT_TYPE>string</ASSET_PRODUCT_TYPE>
            <INTERNATIONAL_ACCOUNT_NUMBER>string</INTERNATIONAL_ACCOUNT_NUMBER> <!-- Solo NI01 -->
        </consultaActivosClienteResponseRecordType>
    </consultaActivosClienteAhorrosResponseType>
    <consultaActivosClienteCorrienteResponseType>...</consultaActivosClienteCorrienteResponseType>
    <consultaActivosClienteDepositosResponseType>...</consultaActivosClienteDepositosResponseType>
    <consultaActivosClientePensionesResponseType>...</consultaActivosClientePensionesResponseType>
</consultaActivosClienteResponse>
```

**Header de Respuesta**:

```xml
<ResponseHeader>
    <messageId>string</messageId>
    <successIndicator>SUCCESS|ERROR</successIndicator>
    <messages>string</messages>
</ResponseHeader>
```

---

## 3. Sistemas/Servicios OSB Involucrados

### 3.1. Proxy Services Principales

| Proxy Service | Ruta | Función |
|--------------|------|---------|
| `ConsultaActivosCliente.proxy` | `Middleware/v2/ProxyServices/` | Proxy principal con enrutamiento regional |
| `ConsultaActivosCliente_v2.proxy` | `Middleware/v2/SProxyServices/` | Facade para invocación interna |
| `ConsultaActivosCliente_v2_Pensiones.proxy` | `Middleware/v2/SProxyServices/` | Especializado para fondos de pensiones |

### 3.2. Business Services por Región

#### Honduras (HN01)
- **T24 Web Services**: Consulta de cuentas de ahorro y corrientes
- **Stored Procedures Oracle**: Consulta de depósitos a plazo
- **Servicio Pensiones 12c**: Consulta de fondos de pensiones
- **Split-Join Service**: Consulta consolidada de todos los activos

#### Guatemala (GT01)
- **DB Adapter - ConnectionProxyAbanksGT**: Conexión a base de datos Oracle
- **Stored Procedure**: `OSB_K_CONLISTACUENTAS.TOPLEVEL$OSB_P_CON_LISTA_CUEN`
- **Split-Join Flow**: Ejecución paralela de consultas de cuentas y depósitos

#### Panamá (PA01)
- **DB Adapter - ConnectionProxyAbanksPA**: Conexión a base de datos Oracle
- **Stored Procedure**: `OSB_K_CONLISTACUENTAS.TOPLEVEL$OSB_P_CON_LISTA_CUEN`
- **Split-Join Flow**: Ejecución paralela de consultas de cuentas y depósitos

#### Nicaragua (NI01)
- **Web Service CTS (Cobis)**: Servicio SOAP externo
- **Operación**: `OpConsultaActivosCliente`
- **Endpoint**: Servicio de activos Cobis

### 3.3. Servicios Auxiliares Comunes

| Servicio | Función | Región |
|----------|---------|--------|
| `ValidaServicioRegional` | Valida que el servicio esté habilitado para la región | Todas |
| `MapeoErrores` | Mapea códigos de error a mensajes estándar | Todas |
| `ValidaFuncionalidadUsuario` | Valida permisos del usuario para ver saldos | HN01, GT01, PA01 |
| `ConsultaCliente` | Obtiene información del cliente (Legal ID) | HN01 |

---

## 4. Riesgos y Limitaciones Conocidas

### 4.1. Riesgos Identificados

1. **Heterogeneidad de Backends**:
   - Cada región utiliza sistemas diferentes (T24, Oracle DB, Cobis)
   - Dificultad para mantener consistencia en respuestas
   - Complejidad en pruebas multiregionales

2. **Manejo de Errores**:
   - Códigos de error no estandarizados entre regiones
   - Dependencia del servicio `MapeoErrores` para normalización
   - Posibles inconsistencias en mensajes de error

3. **Timeouts y Rendimiento**:
   - GT01 y PA01: Timeout configurado en 0 (sin límite explícito)
   - HN01: Múltiples llamadas secuenciales pueden afectar rendimiento
   - Split-Join en GT01/PA01: Ejecución paralela pero sin timeout definido

4. **Validación Regional**:
   - Fallo en `ValidaServicioRegional` interrumpe el flujo
   - No hay fallback si una región no está disponible

5. **Autenticación**:
   - HN01: Autenticación custom-token en el proxy
   - Otras regiones: Sin autenticación explícita en proxy
   - Credenciales en headers pueden ser vulnerables

### 4.2. Limitaciones Técnicas

1. **Fondos de Pensiones**:
   - Solo disponible en Honduras (HN01)
   - Otras regiones devuelven respuesta vacía

2. **IBAN**:
   - Solo Nicaragua (NI01) devuelve `INTERNATIONAL_ACCOUNT_NUMBER`
   - Otras regiones no incluyen este campo

3. **Retry**:
   - GT01: Sin retry configurado (retry-count=0)
   - PA01: 1 retry configurado
   - HN01 y NI01: No especificado

4. **Validación de Esquema**:
   - Solo HN01 valida el request contra XSD
   - Otras regiones no tienen validación explícita

5. **Logging**:
   - Nivel de log configurado en "debug" en todos los proxies
   - Puede generar volumen excesivo de logs en producción

### 4.3. Dependencias Críticas

1. **Base de Datos Oracle** (GT01, PA01):
   - Disponibilidad de ConnectionProxy
   - Existencia y correcto funcionamiento de stored procedures

2. **T24 Core Banking** (HN01):
   - Disponibilidad de servicios web T24
   - Consistencia de datos entre T24 y otros sistemas

3. **Cobis CTS** (NI01):
   - Disponibilidad del servicio externo
   - Compatibilidad de versiones de esquema

4. **Servicios Compartidos**:
   - `ValidaServicioRegional`: Fallo bloquea todas las operaciones
   - `MapeoErrores`: Necesario para respuestas consistentes

---

## 5. Métricas y SLAs

### 5.1. Configuración de Monitoreo

| Región | Monitoring Enabled | Aggregation Interval | Pipeline Monitoring Level |
|--------|-------------------|---------------------|---------------------------|
| HN01 (Proxy) | Sí | 720 min (12 horas) | Action |
| GT01 (BS) | Sí | 10 min | Pipeline |
| PA01 (BS) | Sí | 10 min | Pipeline |
| NI01 | No especificado | - | - |

### 5.2. Alertas Configuradas

- **SLA Alerting**: Habilitado en todos los servicios (nivel: normal)
- **Pipeline Alerting**: Habilitado en todos los servicios (nivel: normal)

### 5.3. SLAs Esperados (No Encontrados en Código)

No se encontraron SLAs explícitos en el código fuente. Se recomienda definir:

- **Tiempo de respuesta objetivo**: < 3 segundos (estimado)
- **Disponibilidad**: 99.5% (estimado)
- **Tasa de error aceptable**: < 1% (estimado)

### 5.4. Métricas Recomendadas para Monitoreo

1. **Tiempo de respuesta por región**
2. **Tasa de éxito/error por región**
3. **Volumen de transacciones por tipo de activo**
4. **Disponibilidad de servicios backend**
5. **Tiempo de ejecución de stored procedures (GT01, PA01)**
6. **Latencia de servicios externos (NI01)**

---

## 6. Consideraciones de Migración

### 6.1. Complejidad de Migración

- **Alta**: Debido a la heterogeneidad de backends y lógica regional específica
- **Regiones más complejas**: HN01 (múltiples integraciones), NI01 (servicio externo)
- **Regiones más simples**: GT01, PA01 (similar implementación con DB)

### 6.2. Puntos de Atención

1. Mantener compatibilidad de contratos SOAP
2. Preservar lógica de enrutamiento regional
3. Migrar stored procedures de Oracle (GT01, PA01)
4. Integración con servicios externos (T24, Cobis)
5. Validación exhaustiva de transformaciones XQuery

---

**Fecha de Análisis**: 2024  
**Versión del Documento**: 1.0  
**Analista**: Amazon Q Developer
