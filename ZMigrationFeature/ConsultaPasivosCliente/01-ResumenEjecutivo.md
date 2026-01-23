# Resumen Ejecutivo - ConsultaPasivosCliente

## Índice de Documentación

1. [Resumen Ejecutivo](01-ResumenEjecutivo.md)
2. [Comparativa entre Regiones](02-ComparativaRegiones.md)
3. Ejemplos y Mapeos por Región:
   - [Honduras (HN01)](03-EjemplosYMapeos-HN01.md)
   - [Guatemala (GT01)](03-EjemplosYMapeos-GT01.md)
   - [Panamá (PA01)](03-EjemplosYMapeos-PA01.md)
   - [Nicaragua (NI01)](03-EjemplosYMapeos-NI01.md)
4. Diagramas de Secuencia por Región:
   - [Honduras (HN01)](04-Secuencia-HN01.mmd)
   - [Guatemala (GT01)](04-Secuencia-GT01.mmd)
   - [Panamá (PA01)](04-Secuencia-PA01.mmd)
   - [Nicaragua (NI01)](04-Secuencia-NI01.mmd)
5. [Diagrama de Flujo Multiregión](05-FlujoMultiregion.mmd)
6. [Listado de Ficheros](06-ListadoFicheros.md)

---

## 1. Propósito de la Funcionalidad

**ConsultaPasivosCliente** es un servicio OSB (Oracle Service Bus) que permite consultar los productos pasivos (obligaciones financieras) de un cliente en el sistema bancario Ficohsa. El servicio está diseñado para operar en múltiples regiones geográficas (Honduras, Guatemala, Panamá y Nicaragua) y soporta diferentes tipos de productos pasivos.

### Tipos de Productos Soportados:
- **PTM** (Préstamos): Consulta de préstamos del cliente
- **TRC** (Tarjetas de Crédito): Consulta de tarjetas de crédito
- **LCR** (Líneas de Crédito Rotativas): Consulta de líneas de crédito (solo HN01)
- **PTC** (Préstamos con Tarjeta de Crédito): Tipo especial de tarjeta en Nicaragua
- **ALL**: Consulta todos los productos pasivos disponibles

---

## 2. Entradas y Salidas Principales

### 2.1. Request (Entrada)

**Endpoint OSB**: `/Middleware/OperationsAndExecution/PositionManagement/ConsultaPasivosCliente_v2`

**Protocolo**: SOAP 1.1 sobre HTTPS

**Estructura del Request**:
```xml
<consultaPasivosClienteRequest>
    <CUSTOMER_ID>string</CUSTOMER_ID>        <!-- ID del cliente (obligatorio) -->
    <LIABILITY_TYPE>string</LIABILITY_TYPE>   <!-- Tipo: PTM, TRC, LCR, PTC, ALL (obligatorio) -->
</consultaPasivosClienteRequest>
```

**Header de Autenticación**:
```xml
<RequestHeader>
    <Authentication>
        <UserName>string</UserName>
        <Password>string</Password>
    </Authentication>
    <Region>
        <SourceBank>string</SourceBank>  <!-- HN01, GT01, PA01, NI01 -->
    </Region>
</RequestHeader>
```

### 2.2. Response (Salida)

**Estructura del Response**:
```xml
<consultaPasivosClienteResponse>
    <consultaPasivosClientePrestamosResponseType>
        <consultaPasivosClienteResponseRecordType>
            <LIABILITY_TYPE>string</LIABILITY_TYPE>
            <LIABILITY_NUMBER>string</LIABILITY_NUMBER>
            <LIABILITY_CUST_NAME>string</LIABILITY_CUST_NAME>
            <LIABILITY_CURRENCY_1>string</LIABILITY_CURRENCY_1>
            <LIABILITY_PRINCIPAL_AMT_1>decimal</LIABILITY_PRINCIPAL_AMT_1>
            <LIABILITY_INT_COM_AMT_1>decimal</LIABILITY_INT_COM_AMT_1>
            <LIABILITY_TOTAL_AMT_1>decimal</LIABILITY_TOTAL_AMT_1>
            <LIABILITY_CURRENCY_2>string</LIABILITY_CURRENCY_2>
            <LIABILITY_PRINCIPAL_AMT_2>decimal</LIABILITY_PRINCIPAL_AMT_2>
            <LIABILITY_INT_COM_AMT_2>decimal</LIABILITY_INT_COM_AMT_2>
            <LIABILITY_TOTAL_AMT_2>decimal</LIABILITY_TOTAL_AMT_2>
            <LIABILITY_TOTAL_AMT>decimal</LIABILITY_TOTAL_AMT>
            <LIABILITY_PAYMENT_DATE>string</LIABILITY_PAYMENT_DATE>
            <LIABILITY_SOURCE_BANK>string</LIABILITY_SOURCE_BANK>
            <LIABILITY_TOTAL_CANCELATION_AMT>decimal</LIABILITY_TOTAL_CANCELATION_AMT>
        </consultaPasivosClienteResponseRecordType>
    </consultaPasivosClientePrestamosResponseType>
    <consultaPasivosClienteTCreditoResponseType>
        <!-- Misma estructura para tarjetas de crédito -->
    </consultaPasivosClienteTCreditoResponseType>
    <consultaPasivosClienteLCRResponseType>
        <!-- Misma estructura para líneas de crédito (solo HN01) -->
    </consultaPasivosClienteLCRResponseType>
    <consultaPasivosClientePrestamosTCResponseType>
        <!-- Estructura para PTC en Nicaragua -->
    </consultaPasivosClientePrestamosTCResponseType>
</consultaPasivosClienteResponse>
```

**Header de Respuesta**:
```xml
<ResponseHeader>
    <successIndicator>Success|ERROR|NO_RECORDS</successIndicator>
    <messages>string</messages>
</ResponseHeader>
```

---

## 3. Sistemas/Servicios OSB Involucrados

### 3.1. Servicios Comunes (Todas las Regiones)

| Servicio | Propósito | Ubicación |
|----------|-----------|-----------|
| **ValidaServicioRegional** | Valida que el servicio esté habilitado para la región | `Middleware/v2/BusinessServices/ValidaServicioRegional/biz/ValidaServicioRegional_db` |
| **MapeoErrores** | Mapea códigos de error internos a mensajes estándar | `Middleware/v2/ProxyServices/MapeoErrores` |
| **ValidaFuncionalidadUsuario** | Valida permisos del usuario (solo HN01) | `Middleware/v2/BusinessServices/ValidaFuncionalidadUsuario/biz/ValidaFuncionalidadUsuario_db` |

### 3.2. Servicios por Región

#### Honduras (HN01)
- **ConsultaPrestamosCliente**: Split-Join para consulta de préstamos en T24
- **conDatoTarjetaClienteHN_db**: Stored Procedure para consulta de tarjetas de crédito
- **consultaLineasCreditoCliente_db**: Stored Procedure para líneas de crédito
- **sjConsultaPasivosCliente**: Split-Join que orquesta consultas paralelas

#### Guatemala (GT01)
- **consultaPasivosCliente_db**: Stored Procedure para préstamos
  - Package: `OSB_K_CONLISTAPRESTAMOS`
  - Procedure: `TOPLEVEL$OSB_P_CON_LISTA_PRES`
  - Conexión: `eis/DB/ConnectionProxyAbanksGT`
- **conDatosTarjetaCliente_db**: Stored Procedure para tarjetas de crédito
  - Conexión: `eis/DB/ConnectionProxyMasterDataGT`

#### Panamá (PA01)
- **consultaPasivosCliente_db**: Stored Procedure para préstamos
  - Package: `OSB_K_CONLISTAPRESTAMOS`
  - Procedure: `TOPLEVEL$OSB_P_CON_LISTA_PRES`
  - Conexión: `eis/DB/ConnectionProxyAbanksPA`
- **conDatosTarjetaCliente_db**: Stored Procedure para tarjetas de crédito
  - Conexión: `eis/DB/ConnectionProxyMasterDataPA`

#### Nicaragua (NI01)
- **SrvAplCobisPasivosService**: Servicio SOAP externo (COBIS)
  - Endpoint: `http://10.235.53.149:9082/GerenciaProductoPasivos/SrvAplCobisPasivosService`
  - Operación: `OpConsultaPasivosCliente`
- **ObtenerParametrizacion**: Servicio para obtener configuración de códigos de bloqueo y BINes

---

## 4. Riesgos y Limitaciones Conocidas

### 4.1. Riesgos Identificados

| Riesgo | Severidad | Descripción | Mitigación |
|--------|-----------|-------------|------------|
| **Dependencia de Múltiples Sistemas** | Alta | El servicio depende de bases de datos Oracle (GT, PA, HN) y servicios SOAP externos (NI) | Implementar circuit breakers y timeouts adecuados |
| **Inconsistencia de Datos entre Regiones** | Media | Cada región tiene su propia estructura de datos y lógica de negocio | Documentación clara de diferencias regionales |
| **Autenticación Custom** | Media | Usa autenticación username/password en header SOAP en lugar de WS-Security estándar | Considerar migración a estándares de seguridad |
| **Transformaciones Complejas** | Media | Múltiples transformaciones XQuery con lógica de negocio embebida | Refactorizar a servicios de negocio separados |
| **Manejo de Errores Heterogéneo** | Media | Cada región maneja errores de forma diferente | Estandarizar códigos de error |

### 4.2. Limitaciones Técnicas

1. **Soporte de Productos por Región**:
   - LCR (Líneas de Crédito) solo disponible en HN01
   - PTC (Préstamos con Tarjeta) solo disponible en NI01
   - Diferentes estructuras de respuesta según región

2. **Formato de Fechas**:
   - HN01: Conversión de formato `yyyy-MM-dd` a `yyyyMMdd`
   - GT01/PA01: Formato `yyyy-MM-dd`
   - NI01: Formato `yyyyMMdd`

3. **Monedas Múltiples**:
   - Soporte para dos monedas por producto (CURRENCY_1, CURRENCY_2)
   - Lógica de conversión específica por región

4. **Validaciones Específicas**:
   - NI01 requiere validación de BINes de tarjetas y códigos de bloqueo
   - GT01/PA01 requieren padding del CUSTOMER_ID a 19 caracteres con ceros

### 4.3. Limitaciones de Negocio

1. **Filtrado de Tarjetas en Nicaragua**:
   - Se excluyen tarjetas con BINes específicos (configurables)
   - Se filtran tarjetas con códigos de bloqueo específicos

2. **Validación de Funcionalidad de Usuario**:
   - Solo implementada en HN01
   - Controla visibilidad de saldos pasivos por usuario

3. **Timeout y Retry**:
   - Retry configurado en 1 intento con intervalo de 30 segundos (GT01, PA01)
   - Sin retry configurado para NI01

---

## 5. Métricas y SLAs

### 5.1. Configuración de Monitoreo

| Parámetro | Valor | Descripción |
|-----------|-------|-------------|
| **Monitoring Enabled** | true | Monitoreo activo en todos los servicios |
| **Aggregation Interval** | 720 minutos (Proxy)<br>360 minutos (Business Services) | Intervalo de agregación de métricas |
| **Pipeline Monitoring Level** | Action | Nivel de detalle del monitoreo |
| **Logging Level** | debug | Nivel de logging del proxy |
| **SLA Alerting** | Enabled (normal) | Alertas de SLA activas |
| **Pipeline Alerting** | Enabled (normal) | Alertas de pipeline activas |

### 5.2. Configuración de Timeout y Retry

#### Guatemala y Panamá (Base de Datos)
- **Retry Count**: 1
- **Retry Interval**: 30 segundos
- **Retry Application Errors**: true

#### Nicaragua (Servicio SOAP)
- **Retry Count**: 0
- **Retry Interval**: 0 segundos
- **Request Timeout**: 0 (sin timeout configurado)
- **Connection Timeout**: 0 (sin timeout configurado)

### 5.3. SLAs Esperados (No Documentados en Código)

> **Nota**: No se encontraron SLAs específicos documentados en el código fuente. Se recomienda establecer:
> - Tiempo de respuesta objetivo: < 5 segundos (percentil 95)
> - Disponibilidad: > 99.5%
> - Tasa de error: < 1%

---

## 6. Arquitectura General

### 6.1. Patrón de Diseño

El servicio implementa un **patrón de enrutamiento regional** con las siguientes características:

1. **Validaciones Generales** (común a todas las regiones):
   - Validación de esquema XSD
   - Validación de servicio regional habilitado
   - Aplicación de valores por defecto según región

2. **Enrutamiento por Región** (branch-node):
   - Basado en el campo `SourceBank` del header
   - Pipelines específicos por región: HN01, GT01, PA01, NI01
   - Pipeline por defecto para regiones no soportadas

3. **Procesamiento Regional**:
   - Cada región tiene su propia lógica de negocio
   - Transformaciones XQuery específicas
   - Conexiones a sistemas backend diferentes

4. **Manejo de Errores Centralizado**:
   - Error handler común para todas las regiones
   - Mapeo de errores a códigos estándar
   - Respuesta consistente en caso de error

### 6.2. Flujo de Alto Nivel

```
Cliente → OSB Proxy → Validaciones Generales → Enrutamiento Regional
                                                      ↓
                        ┌─────────────────────────────┴─────────────────────────────┐
                        ↓                 ↓                 ↓                        ↓
                      HN01              GT01              PA01                     NI01
                        ↓                 ↓                 ↓                        ↓
                  Split-Join        DB Oracle         DB Oracle              SOAP COBIS
                  + DB Oracle       (Préstamos)       (Préstamos)            (Pasivos)
                  (PTM/TRC/LCR)     + DB Oracle       + DB Oracle
                                    (Tarjetas)        (Tarjetas)
                        ↓                 ↓                 ↓                        ↓
                        └─────────────────────────────────┬─────────────────────────┘
                                                          ↓
                                              Transformación de Salida
                                                          ↓
                                                  Mapeo de Errores
                                                          ↓
                                                      Cliente
```

---

## 7. Consideraciones para Migración

### 7.1. Dependencias Críticas

1. **Bases de Datos Oracle**:
   - ConnectionProxyAbanksGT (Guatemala)
   - ConnectionProxyAbanksPA (Panamá)
   - ConnectionProxyAbanksHN (Honduras - implícito)
   - ConnectionProxyMasterDataGT/PA/HN (Tarjetas de Crédito)

2. **Servicios Externos**:
   - COBIS Nicaragua: `http://10.235.53.149:9082/GerenciaProductoPasivos/SrvAplCobisPasivosService`

3. **Stored Procedures**:
   - Package: `OSB_K_CONLISTAPRESTAMOS`
   - Procedure: `TOPLEVEL$OSB_P_CON_LISTA_PRES`
   - Procedures de tarjetas de crédito (específicos por región)

### 7.2. Puntos de Atención

1. **Seguridad**:
   - Migrar de autenticación custom a WS-Security o OAuth 2.0
   - Implementar encriptación de credenciales en tránsito

2. **Estandarización**:
   - Unificar formatos de fecha entre regiones
   - Estandarizar códigos de error
   - Consolidar lógica de transformación

3. **Resiliencia**:
   - Implementar circuit breakers
   - Configurar timeouts apropiados (especialmente NI01)
   - Implementar retry con backoff exponencial

4. **Observabilidad**:
   - Implementar tracing distribuido
   - Mejorar logging estructurado
   - Definir y monitorear SLAs

---

## 8. Código de Servicio

**Service ID**: `FICBCO0044`

Este identificador se utiliza para:
- Validación de servicio regional
- Mapeo de errores
- Auditoría y trazabilidad

---

**Fecha de Análisis**: 2024
**Versión del Documento**: 1.0
**Analista**: Amazon Q Developer
