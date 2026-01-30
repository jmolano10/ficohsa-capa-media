# Resumen Ejecutivo - Redención de Puntos de Lealtad

## Índice de Documentación

- [01 - Resumen Ejecutivo](./01-ResumenEjecutivo.md)
- [02 - Comparativa entre Regiones](./02-ComparativaRegiones.md)
- [03 - Ejemplos y Mapeos HN01](./03-EjemplosYMapeos-HN01.md)
- [03 - Ejemplos y Mapeos GT01](./03-EjemplosYMapeos-GT01.md)
- [03 - Ejemplos y Mapeos PA01](./03-EjemplosYMapeos-PA01.md)
- [03 - Ejemplos y Mapeos NI01](./03-EjemplosYMapeos-NI01.md)
- [04 - Diagrama de Secuencia HN01](./04-Secuencia-HN01.mmd)
- [04 - Diagrama de Secuencia GT01](./04-Secuencia-GT01.mmd)
- [04 - Diagrama de Secuencia PA01](./04-Secuencia-PA01.mmd)
- [04 - Diagrama de Secuencia NI01](./04-Secuencia-NI01.mmd)
- [05 - Flujo Multiregión](./05-FlujoMultiregión.mmd)
- [06 - Listado de Ficheros](./06-ListadoFicheros.md)

---

## 1. Propósito de la Funcionalidad

La funcionalidad **RedencionPuntosLealtad** permite a los clientes de Banco Ficohsa redimir puntos acumulados en sus programas de lealtad asociados a tarjetas de débito y crédito. El servicio soporta dos tipos principales de redención:

- **Redención por Efectivo (CASH)**: Conversión de puntos a dinero en efectivo
- **Redención por Puntos (POINTS)**: Canje directo de puntos por productos/servicios

El servicio está implementado como un Proxy Service en Oracle Service Bus (OSB) que actúa como orquestador entre los canales digitales y los sistemas backend de programas de lealtad (Mastercard Rewards Services y VisionPlus).

---

## 2. Entradas y Salidas Principales

### 2.1. Entrada Principal (Request)

**Endpoint SOAP**: `http://172.23.13.19:8003/Middleware/SalesAndServices/BrandManagement/RedencionPuntosLealtad`

**Operación**: `redencionPuntosLealtad`

**Estructura del Request**:

```xml
<redencionPuntosLealtad>
    <CUSTOMER_ID_TYPE>CARD_NUMBER|CUSTOMER_ID|LEGAL_ID</CUSTOMER_ID_TYPE>
    <CUSTOMER_ID_VALUE>string</CUSTOMER_ID_VALUE>
    <REDEMPTION_TYPE>CASH|POINTS</REDEMPTION_TYPE>
    <REDEMPTION_AMOUNT>decimal</REDEMPTION_AMOUNT>
    <CASH_REDEMPTION>
        <CARD_NUMBER>string</CARD_NUMBER>
        <MERCHANT_ID>string</MERCHANT_ID>
        <MERCHANT_TYPE>string</MERCHANT_TYPE>
        <TERMINAL_ID>string</TERMINAL_ID>
    </CASH_REDEMPTION>
    <REDEMPTION_DETAILS>
        <REDEMPTION_METHOD>CASH|ACCOUNT_CREDIT|CREDIT_CARD_PAYMENT</REDEMPTION_METHOD>
        <ACCOUNT_NUMBER>string</ACCOUNT_NUMBER>
        <CREDIT_CARD_NUMBER>string</CREDIT_CARD_NUMBER>
    </REDEMPTION_DETAILS>
    <PROGRAM_ID>1|2</PROGRAM_ID>
</redencionPuntosLealtad>
```

**Header de Autenticación**:
```xml
<RequestHeader>
    <Authentication>
        <UserName>string</UserName>
        <Password>string</Password>
    </Authentication>
    <Region>
        <SourceBank>HN01|GT01|PA01|NI01</SourceBank>
    </Region>
</RequestHeader>
```

### 2.2. Salida Principal (Response)

```xml
<redencionPuntosLealtadResponse>
    <LEGAL_ID>string</LEGAL_ID>
    <CUSTOMER_NAME>string</CUSTOMER_NAME>
    <POINTS_REDEEMED>decimal</POINTS_REDEEMED>
    <REMAINING_BALANCE>decimal</REMAINING_BALANCE>
    <REDEMPTION_ID>long</REDEMPTION_ID>
</redencionPuntosLealtadResponse>
```

**Header de Respuesta**:
```xml
<ResponseHeader>
    <successIndicator>Success|ERROR</successIndicator>
    <messages>string</messages>
</ResponseHeader>
```

---

## 3. Sistemas/Servicios OSB Involucrados

### 3.1. Proxy Services Principales

| Proxy Service | Región | Descripción |
|--------------|--------|-------------|
| `RedencionPuntosLealtad.proxy` | Multiregión | Proxy principal con enrutamiento regional |
| `RedencionPuntosLealtadHN.proxy` | HN01 | Implementación específica para Honduras |
| `RedencionPuntosLealtadGT.proxy` | GT01 | Implementación específica para Guatemala |
| `RedencionPuntosLealtadPA.proxy` | PA01 | Implementación específica para Panamá |
| `RedencionPuntosLealtadNI.proxy` | NI01 | Implementación específica para Nicaragua |

### 3.2. Business Services Backend

#### 3.2.1. Servicios de Programas de Lealtad

| Business Service | Proveedor | Operación | Descripción |
|-----------------|-----------|-----------|-------------|
| `RedemptionService` | Mastercard Rewards | `doItemRedemption` | Redención de puntos en programa Mastercard (Programa 1) |
| `visionPlus` | VisionPlus/FDCS | `PointsRedeem` | Redención de puntos en programa VisionPlus (Programa 2) |
| `visionPlus` | VisionPlus/FDCS | `PointsAdjustmentInquiry` | Consulta de saldo disponible post-redención |

#### 3.2.2. Servicios de Base de Datos

| Business Service | Base de Datos | Stored Procedure | Descripción |
|-----------------|---------------|------------------|-------------|
| `ValidaServicioRegional_db` | Middleware DB | `ValidaServicioRegional` | Valida disponibilidad del servicio por región |
| `canjearPuntosEfectivo_db` (HN) | ABK DB | `canjearPuntosEfectivo` | Conversión de monto a puntos (Honduras) |
| `canjearPuntosEfectivo_db` (GT) | ABKGT DB | `canjearPuntosEfectivo` | Conversión de monto a puntos (Guatemala) |
| `canjearPuntosEfectivo_db` (PA) | PXYNIC DB | `canjearPuntosEfectivo` | Conversión de monto a puntos (Panamá) |
| `canjearPuntosEfectivo_db` (NI) | PXYNIC DB | `canjearPuntosEfectivo` | Conversión de monto a puntos (Nicaragua) |
| `conInfoLealtad_db` | Procesos HN DB | `conInfoLealtad` | Consulta información de lealtad de tarjeta (Honduras) |
| `conDatoCuenta_db` (HN) | MasterData HN DB | `conDatoCuenta` | Consulta datos de cuenta (Honduras) |
| `conDatoCuenta_db` (GT) | MasterData GT DB | `conDatoCuenta` | Consulta datos de cuenta (Guatemala) |
| `conDatoCuenta_db` (PA) | MasterData PA DB | `conDatoCuenta` | Consulta datos de cuenta (Panamá) |
| `consultaProgramaLealtad_db` | INTFC DB | `consultaProgramaLealtad` | Consulta programa de lealtad por logo |
| `obtenerTipoProgramaLealtad_db` | INTFC DB | `obtenerTipoProgramaLealtad` | Obtiene tipo de programa por BIN (Nicaragua) |
| `INSTransaccionRedencion_db` | MasterData DB | `INSTransaccionRedencion` | Registra transacción de redención |
| `ObtenerParametrizacion` | Middleware DB | `OSB_GET_CONFIG` | Obtiene parámetros de configuración |
| `sjConsultaTipoTarjeta` | SJS DB | `ConsultaTipoTarjeta` | Consulta tipo de tarjeta (débito/crédito) |
| `sjConsultaTipoTarjetaNI` | SJS DB | `ConsultaTipoTarjeta` | Consulta tipo de tarjeta Nicaragua |

#### 3.2.3. Servicios Core Banking

| Business Service | Sistema | Operación | Descripción |
|-----------------|---------|-----------|-------------|
| `consultasClienteBS` | T24 WebServices | `Consultadecliente` | Consulta información del cliente por ID |
| `tarjetasDebitoBS` | T24 WebServices | `ConsultaMaestraTarjetaDebito` | Consulta información de tarjeta débito |
| `transaccionesAlcance` | Alcance | `InformacionTarjeta` | Consulta información de tarjeta crédito |

### 3.3. Servicios de Soporte

| Business Service | Operación | Descripción |
|-----------------|-----------|-------------|
| `MapeoErrores` | `mapeoErrores` | Mapeo y homologación de códigos de error |

---

## 4. Riesgos/Limitaciones Conocidas

### 4.1. Riesgos Técnicos

1. **Dependencia de Múltiples Sistemas Backend**
   - La funcionalidad depende de la disponibilidad de Mastercard Rewards Services y VisionPlus
   - Fallo en cualquiera de estos sistemas impacta la redención
   - **Mitigación**: Manejo de errores con mapeo centralizado

2. **Complejidad de Enrutamiento Regional**
   - Cada región tiene implementaciones diferentes con lógica específica
   - Mantenimiento complejo debido a la duplicación de código
   - **Mitigación**: Documentación detallada por región

3. **Validaciones de Tipo de Tarjeta**
   - HN01: Soporta CARD_NUMBER, CUSTOMER_ID, LEGAL_ID
   - GT01, PA01, NI01: Solo soportan CARD_NUMBER
   - **Riesgo**: Inconsistencia en la experiencia del usuario

4. **Conversión de Puntos a Efectivo**
   - Cada región tiene su propia lógica de conversión
   - Diferentes stored procedures por región
   - **Riesgo**: Inconsistencias en tasas de conversión

### 4.2. Limitaciones Funcionales

1. **Métodos de Redención Soportados**
   - Solo se permite REDEMPTION_METHOD = "CASH"
   - ACCOUNT_CREDIT y CREDIT_CARD_PAYMENT no están implementados
   - **Limitación**: Validación en XQuery rechaza otros métodos

2. **Programas de Lealtad Soportados**
   - Programa 1: Mastercard Rewards Services (Tarjetas Débito principalmente)
   - Programa 2: VisionPlus (Tarjetas Crédito)
   - **Limitación**: No hay soporte para otros programas

3. **Consulta de Saldo Restante**
   - HN01 (Programa 1): Retorna saldo restante desde Mastercard
   - HN01 (Programa 2): Consulta adicional a VisionPlus para obtener saldo
   - GT01, PA01, NI01 (Programa 2): No retornan saldo restante
   - **Limitación**: Inconsistencia entre regiones

4. **Validación de Estado de Tarjeta**
   - NI01: Valida que la tarjeta esté ACTIVE antes de redimir
   - Otras regiones: No validan estado de tarjeta
   - **Limitación**: Inconsistencia en validaciones

### 4.3. Limitaciones de Datos

1. **Información de Cliente**
   - HN01: Consulta completa desde T24 o Alcance según tipo de tarjeta
   - GT01, PA01: Solo consulta desde conDatoCuenta
   - NI01: Consulta desde sjConsultaTipoTarjeta
   - **Limitación**: Diferentes fuentes de datos por región

2. **ID de Redención**
   - Programa 1: ID generado por Mastercard Rewards
   - Programa 2 (GT01, HN01): ID registrado en INSTransaccionRedencion
   - Programa 2 (PA01, NI01): ID generado con timestamp
   - **Limitación**: Diferentes estrategias de generación de ID

---

## 5. Métricas o SLAs

### 5.1. Métricas de Rendimiento

| Métrica | Valor Esperado | Notas |
|---------|---------------|-------|
| Tiempo de Respuesta Promedio | < 5 segundos | Incluye llamadas a sistemas externos |
| Timeout de Servicios Backend | Configurado en Business Services | Variable por servicio |
| Disponibilidad del Servicio | 99.5% | Depende de disponibilidad de backends |

### 5.2. Configuración de Logging y Monitoreo

```xml
<ser:logging isEnabled="true">
    <ser:logLevel>debug</ser:logLevel>
</ser:logging>
<ser:sla-alerting isEnabled="true">
    <ser:alertLevel>normal</ser:alertLevel>
</ser:sla-alerting>
<ser:pipeline-alerting isEnabled="true">
    <ser:alertLevel>normal</ser:alertLevel>
</ser:pipeline-alerting>
```

### 5.3. Manejo de Errores

- **Error Handler Global**: `_onErrorHandler` configurado en cada proxy
- **Mapeo de Errores**: Servicio centralizado `MapeoErrores` para homologación
- **Códigos de Error**:
  - `SUCCESS`: Operación exitosa
  - `ERROR`: Error genérico
  - Códigos específicos de Mastercard y VisionPlus

---

## 6. Regiones Detectadas

Las siguientes regiones han sido identificadas en el código fuente:

| Código Región | País | Implementación |
|--------------|------|----------------|
| **HN01** | Honduras | `RedencionPuntosLealtadHN.proxy` |
| **GT01** | Guatemala | `RedencionPuntosLealtadGT.proxy` |
| **PA01** | Panamá | `RedencionPuntosLealtadPA.proxy` |
| **NI01** | Nicaragua | `RedencionPuntosLealtadNI.proxy` |

**Nota**: El proxy principal `RedencionPuntosLealtad.proxy` actúa como router que enruta las peticiones a los proxies regionales según el valor de `SourceBank` en el header.

---

## 7. Flujo General de Procesamiento

1. **Validación de Entrada**: Validación XSD del request
2. **Validación Regional**: Verifica que el servicio esté disponible para la región
3. **Consulta de Información del Cliente**: Obtiene datos del cliente según tipo de identificador
4. **Consulta de Programa de Lealtad**: Determina el programa (1 o 2) según logo/BIN de tarjeta
5. **Conversión de Puntos** (si REDEMPTION_TYPE = CASH): Convierte monto a puntos
6. **Obtención de Parámetros**: Obtiene matrixId, institutionName, rewardItem
7. **Redención de Puntos**: Invoca Mastercard o VisionPlus según programa
8. **Registro de Transacción** (Programa 2): Registra en base de datos
9. **Construcción de Respuesta**: Retorna información de redención
10. **Mapeo de Errores**: Homologa errores si ocurren

---

## 8. Consideraciones de Migración

### 8.1. Diferencias Críticas entre Regiones

- **HN01**: Implementación más completa con soporte para múltiples tipos de identificación
- **GT01, PA01**: Implementaciones similares, solo CARD_NUMBER
- **NI01**: Validación adicional de estado de tarjeta

### 8.2. Dependencias Externas

- Mastercard Rewards Services (SOAP)
- VisionPlus/FDCS (SOAP)
- Bases de datos Oracle (múltiples esquemas)
- T24 Core Banking
- Alcance (Procesador de Tarjetas Crédito)

### 8.3. Configuraciones Parametrizadas

- `FICBCO0229.MRS.MATRIXID.{REGION}`: ID de matriz de recompensas por región
- `FICBCO0229.MRS.INSTITUTION.NAME`: Nombre de institución para Mastercard
- `FICBCO0229.{USERNAME}.REWARDITEM`: Item de recompensa por usuario/canal

---

**Fecha de Análisis**: 2024
**Versión del Documento**: 1.0
**Service ID**: FICBCO0229
